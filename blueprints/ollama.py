
from imports import *
import mysql.connector
from langchain_ollama import OllamaLLM
import re
from schema import COMPLETE_SCHEMA, get_schema_summary

ollama_bot_bp = Blueprint('bot', __name__, url_prefix='/bot')

print("🔵 Starting HRMS Offline SQL Flask Chat...")
print(get_schema_summary())



# -------------------------
# CONNECT TO DATABASE
# -------------------------
print("🔵 Connecting to database...")

try:
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="qaz123QAZ!@#",
        database="hrms"
    )
    cursor = db.cursor(dictionary=True)
    print("✅ Database connected successfully.")
except mysql.connector.Error as err:
    print(f"❌ Database connection failed: {err}")
    exit()

# -------------------------
# LOAD OLLAMA MODEL
# -------------------------
print("🔵 Loading Ollama model...")

try:
    llm = OllamaLLM(model="llama3.2:3b", temperature=0)
    print("✅ Ollama model ready.")
except Exception as e:
    print("❌ Failed to load Ollama model:", e)
    exit()

print("🚀 Flask HRMS Chat App Ready")


# =====================================================
# 🔥 NORMALIZATION FUNCTION (NEW)
# =====================================================
def normalize_question(question: str) -> str:
    """
    Normalize company names like:
    1 coy -> 1 Company
    1 co -> 1 Company
    hq coy -> HQ Company
    """

    original_question = question
    question = question.lower()

    # 1 coy / 1 co → 1 Company
    question = re.sub(r'\b(\d+)\s*(coy|co|company)\b',
                      lambda m: f"{m.group(1)} Company",
                      question)

    # hq coy / hq co → HQ Company
    question = re.sub(r'\bhq\s*(coy|co|company)\b',
                      "HQ Company",
                      question)

    print("🟢 Normalized Question:", question)
    return question


# -------------------------
# HOME PAGE
# -------------------------



# -------------------------
# CHAT API
# -------------------------
@ollama_bot_bp.route("/chat", methods=["POST"])
def chat():

    print("\n================ NEW REQUEST ================")

    question = request.json.get("message", "").strip()

    print("🔵 Original User Question:", question)

    if not question:
        print("❌ Empty question received.")
        return jsonify({"error": "Empty question"}), 400

    # ✅ APPLY NORMALIZATION HERE
    question = normalize_question(question)

    # -------------------------
    # PROMPT
    # -------------------------
    prompt = f"""
You are an expert MySQL query generator for HRMS.

STRICT RULES:
1. ONLY generate SELECT queries.
2. NEVER use DELETE, UPDATE, INSERT, DROP, ALTER.
3. NEVER select password column.
4. Use exact column names.
5. Return ONLY SQL query.
6. ALWAYS replace placeholders with actual values from the user's question.
7. Company names are case sensitive and stored like:
   - '1 Company'
   - '2 Company'
   - '3 Company'
   - 'HQ Company'
8. Return ONLY SQL query.

Database Information:
{COMPLETE_SCHEMA}

User Question:
{question}

Return ONLY SQL query:
"""

    print("🔵 Generating SQL from LLM...")

    try:
        generated_sql = llm.invoke(prompt)
    except Exception as e:
        print("❌ Error calling Ollama:", e)
        return jsonify({"error": str(e)}), 500

    print("\n🟡 Raw LLM Output:")
    print(generated_sql)

    # -------------------------
    # CLEAN SQL
    # -------------------------
    generated_sql = re.sub(r"```sql|```", "", generated_sql).strip()
    generated_sql = re.sub(r"^SQL:\s*", "", generated_sql, flags=re.IGNORECASE)

    print("\n🟢 Cleaned SQL:")
    print(generated_sql)

    # -------------------------
    # SAFETY CHECKS
    # -------------------------
    print("🔵 Running safety checks...")

    sql_lower = generated_sql.lower()
    dangerous = ['delete', 'update', 'insert', 'drop', 'alter', 'create', 'truncate']

    if any(word in sql_lower for word in dangerous):
        print("❌ Dangerous operation detected.")
        return jsonify({"error": "Only SELECT allowed"}), 400

    if not sql_lower.startswith("select"):
        print("❌ Query does not start with SELECT.")
        return jsonify({"error": "Invalid query"}), 400

    # -------------------------
    # EXECUTE QUERY
    # -------------------------
    try:
        print("🔵 Executing SQL query...")
        cursor.execute(generated_sql)
        result = cursor.fetchall()

        print("✅ Query executed successfully.")
        print(f"📊 Found {len(result)} record(s).")

        print("=============================================\n")

        return jsonify({
            "sql": generated_sql,
            "result": result
        })

    except mysql.connector.Error as e:
        print("❌ MySQL Error:", e)
        return jsonify({"error": str(e)}), 500

    except Exception as e:
        print("❌ Unexpected Error:", e)
        return jsonify({"error": str(e)}), 500




