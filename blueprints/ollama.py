from flask import Blueprint, request, jsonify
import mysql.connector
from mysql.connector import Error
from langchain_ollama import OllamaLLM
import re

# Import schema
from schema import COMPLETE_SCHEMA

ollama_bot_bp = Blueprint('bot', __name__, url_prefix='/bot')

# ─────────────────────────────────────────────
# Global DB Configuration
# ─────────────────────────────────────────────
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "qaz123QAZ!@#",
    "database": "hrms"
}

llm = None


# ─────────────────────────────────────────────
# Load LLM (Cold start protection)
# ─────────────────────────────────────────────
def get_llm():
    global llm
    if llm is None:
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("Loading Ollama model (llama3.2:3b)...")
        llm = OllamaLLM(model="llama3.2:3b", temperature=0)
        print("Ollama model loaded successfully.")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    return llm


# ─────────────────────────────────────────────
# Database Connection
# ─────────────────────────────────────────────
def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        return conn
    except Error as e:
        print(f"DB connection FAILED: {e}")
        return None


# ─────────────────────────────────────────────
# Greeting Detection
# ─────────────────────────────────────────────
def is_greeting(text):
    greetings = [
        "hi", "hello", "hey",
        "good morning", "good afternoon", "good evening",
        "how are you", "who are you"
    ]
    text = text.lower()
    return any(greet in text for greet in greetings)


def is_help(text):
    return "help" in text.lower()


# ─────────────────────────────────────────────
# Main Route
# ─────────────────────────────────────────────
@ollama_bot_bp.route('/ask', methods=['POST'])
def ask():
    print("\n" + "═" * 60)
    print("NEW REQUEST RECEIVED → /bot/ask")

    data = request.get_json()

    if not data or 'question' not in data:
        return jsonify({"error": "Missing question"}), 400

    question = data['question'].strip()

    if not question:
        return jsonify({"error": "Empty question"}), 400

    print(f"User Question: {question}")

    # ─────────────────────────────────────────
    # Greeting Handling
    # ─────────────────────────────────────────
    if is_greeting(question):
        return jsonify({
            "answer": "Hello 👋 I am your HRMS assistant. I can help you with personnel and user account data.",
            "data": []
        })

    # ─────────────────────────────────────────
    # Help Handling
    # ─────────────────────────────────────────
    if is_help(question):
        return jsonify({
            "answer": (
                "You can ask things like:\n"
                "- Show all personnel\n"
                "- Find soldier by army number\n"
                "- List all users\n"
                "- Show personnel from a specific unit\n"
                "- Rank wise count"
            ),
            "data": []
        })

    # ─────────────────────────────────────────
    # Prompt Preparation
    # ─────────────────────────────────────────
    prompt = f"""
You are an expert MySQL query generator for HRMS.

STRICT RULES:
1. ONLY generate SELECT queries.
2. NEVER use DELETE, UPDATE, INSERT, DROP, ALTER, CREATE, etc.
3. NEVER select the password column from users table.
4. Use exact column names from schema.
5. If unrelated to HRMS → respond "NOT RELATED"
6. If info not available → respond "INSUFFICIENT DATA"
7. Return ONLY SQL query.

Database Schema:
{COMPLETE_SCHEMA}

User Question:
{question}

Return ONLY SQL query:
"""

    # ─────────────────────────────────────────
    # Generate SQL
    # ─────────────────────────────────────────
    try:
        model = get_llm()
        raw_output = model.invoke(prompt)
    except Exception as e:
        return jsonify({"error": f"LLM error: {str(e)}"}), 500

    # Clean Output
    sql = re.sub(r"```sql|```", "", raw_output).strip()
    sql = re.sub(r"^SQL:\s*", "", sql, flags=re.IGNORECASE).strip()

    print("Generated SQL:", sql)

    # ─────────────────────────────────────────
    # Safety Checks
    # ─────────────────────────────────────────
    sql_lower = sql.lower()

    if "NOT RELATED" in sql.upper() or "INSUFFICIENT DATA" in sql.upper():
        return jsonify({"answer": sql.strip(), "data": []})

    if not sql_lower.startswith("select"):
        return jsonify({"error": "Only SELECT statements allowed"}), 400

    dangerous_keywords = [
        "delete", "update", "insert", "drop",
        "alter", "create", "truncate", "replace"
    ]

    if any(keyword in sql_lower for keyword in dangerous_keywords):
        return jsonify({"error": "Dangerous SQL operation detected"}), 400

    # Extra Password Protection
    if re.search(r"select.*password.*from", sql_lower):
        return jsonify({"error": "Access to password column forbidden"}), 400

    # ─────────────────────────────────────────
    # Execute Query
    # ─────────────────────────────────────────
    conn = get_db_connection()
    if not conn:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute(sql)
        result = cursor.fetchall()

        # Mask password fields if somehow returned
        for row in result:
            for key in row:
                if "password" in key.lower():
                    row[key] = "*** MASKED ***"

        answer_text = (
            f"Found {len(result)} record(s)." if result else "No records found."
        )

        return jsonify({
            "answer": answer_text,
            "data": result
        })

    except Error as e:
        return jsonify({"error": f"MySQL error: {str(e)}"}), 500

    except Exception as e:
        return jsonify({"error": f"Unexpected error: {str(e)}"}), 500

    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()
