from imports import *
import mysql.connector
import re
from langchain_ollama import OllamaLLM
from schema import COMPLETE_SCHEMA

ollama_bot_bp = Blueprint('ollama_bot', __name__, url_prefix='/bot')

print("🔵 HRMS AI Blueprint Loaded")

# -------------------------
# LOAD OLLAMA MODEL ONCE
# -------------------------
print("🔵 Loading Ollama model...")
llm = OllamaLLM(model="llama3.2:1b", temperature=0,
                base_url="http://127.0.0.1:11434")
print("✅ Ollama model ready.")

# -------------------------
# DATABASE CONNECTION FUNCTION
# -------------------------
def get_db_connection():
    print("🔵 Connecting to database...")
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="qaz123QAZ!@#",
        database="hrms"
    )

# -------------------------
# /ASK API
# -------------------------
@ollama_bot_bp.route("/ask", methods=["POST"])
def ask_hrms():

    print("\n==============================")
    print("🟢 /bot/ask endpoint called")
    print("==============================")

    data = request.get_json()
    print("📩 Incoming Request JSON:", data)

    if not data or "question" not in data:
        print("❌ Question missing in request")
        return jsonify({"error": "Question is required"}), 400

    question = data["question"].strip()
    print("🟢 User Question:", question)

    if not question:
        print("❌ Empty question received")
        return jsonify({"error": "Empty question"}), 400

    # -------------------------
    # GREETING CHECK
    # -------------------------
    greetings = [
        "hi", "hello", "hey",
        "good morning", "good afternoon", "good evening"
    ]

    if question.lower() in greetings:
        print("👋 Greeting detected. Sending greeting response.")
        return jsonify({
            "response": "Hello 👋 I am your HRMS AI Assistant. How can I help you today?"
        })

    # -------------------------
    # PROMPT GENERATION
    # -------------------------
    print("🔵 Generating SQL using LLM...")

    prompt = f"""
    You are an expert MySQL query generator for HRMS.

    STRICT RULES:
    1. ONLY generate SELECT queries.
    2. NEVER use DELETE, UPDATE, INSERT, DROP, ALTER, etc.
    3. NEVER select the password column from users table.
    4. Use exact column names as shown in the schema.
    5. If question requires JOIN, use army_number.
    6. If unrelated, respond: "NOT RELATED"
    7. If insufficient info, respond: "INSUFFICIENT DATA"
    8. Return ONLY SQL query.

    Database Information:
    {COMPLETE_SCHEMA}

    User Question:
    {question}

    Return ONLY the SQL query:
    """

    try:
        generated_sql = llm.invoke(prompt)
        print("🟡 Raw LLM Output:")
        print(generated_sql)
    except Exception as e:
        print("❌ LLM Error:", e)
        return jsonify({"error": f"LLM Error: {str(e)}"}), 500

    # -------------------------
    # CLEAN SQL
    # -------------------------
    generated_sql = re.sub(r"```sql|```", "", generated_sql).strip()
    generated_sql = re.sub(r"^SQL:\s*", "", generated_sql, flags=re.IGNORECASE)

    print("🟢 Cleaned SQL:")
    print(generated_sql)

    sql_lower = generated_sql.lower()

    # -------------------------
    # SAFETY CHECKS
    # -------------------------
    print("🔵 Running safety checks...")

    dangerous_keywords = ['delete', 'update', 'insert', 'drop', 'alter', 'create', 'truncate', 'replace']
    if any(keyword in sql_lower for keyword in dangerous_keywords):
        print("❌ Dangerous keyword detected!")
        return jsonify({"error": "Only SELECT queries allowed"}), 400

    if "password" in sql_lower and "users" in sql_lower:
        print("❌ Attempt to access password column!")
        return jsonify({"error": "Access to password column not allowed"}), 403

    if "NOT RELATED" in generated_sql:
        print("❌ Question not related to HRMS")
        return jsonify({"error": "Question not related to HRMS"}), 400

    if "INSUFFICIENT DATA" in generated_sql:
        print("❌ Insufficient schema data")
        return jsonify({"error": "Insufficient data in schema"}), 400

    if not sql_lower.startswith("select"):
        print("❌ Query does not start with SELECT")
        return jsonify({"error": "Query must start with SELECT"}), 400

    print("✅ Safety checks passed.")

    # -------------------------
    # EXECUTE QUERY
    # -------------------------
    try:
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        print("🔵 Executing SQL query...")
        cursor.execute(generated_sql)
        result = cursor.fetchall()

        print(f"✅ Query executed successfully. Records found: {len(result)}")

        # Mask accidental password fields
        for row in result:
            for key in row:
                if 'password' in key.lower():
                    row[key] = "*** MASKED ***"

        cursor.close()
        db.close()
        print("🔴 Database connection closed.")

        return jsonify({
            "sql": generated_sql,
            "count": len(result),
            "data": result
        })

    except mysql.connector.Error as e:
        print("❌ MySQL Error:", e)
        return jsonify({"error": f"MySQL Error: {str(e)}"}), 500

    except Exception as e:
        print("❌ Unexpected Error:", e)
        return jsonify({"error": f"Unexpected Error: {str(e)}"}), 500
