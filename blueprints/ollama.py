from imports import *
import requests
import re
import mysql.connector

ollama_bot_bp = Blueprint('ollama_bot', __name__, url_prefix='/bot')

# =========================
# DATABASE CONFIG
# =========================
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "qaz123QAZ!@#",
    "database": "hrms"
}

# =========================
# UNIT INFORMATION
# =========================
UNIT_INFO = {
    "name": "15 Corps Engg Sig Regt",
    "location": "Srinagar",
    "role": "Provides communication and IT support to Corps operations.",
    "motto": "Tejas – Swift and Sure",
    "raising_date": "01 Jan 19XX",
    "under_command": "15 Corps",
    "current_co": "Col M S Dilawri"
}

# =========================
# MASTER DATA
# =========================
COMPANIES = [
    "1 Company",
    "2 Company",
    "3 Company",
    "HQ company"
]

SECTIONS = [
    "MW","LINE","OP","IT","PWR","CHQ","MCCS",
    "DET","System","MT","RHQ","LRW","QM","RP/NA","TM"
]

RANK_GROUPS = {
    "subedar major": ["Subedar Major"],
    "naib subedar": ["Naib Subedar"],
    "lance naik": ["L NK", "LOC NK"],
    "subedar": ["Subedar"],
    "havildar": ["hav"],
    "signal man": ["Signal Man"],
    "agniveer": ["Agniveer"],
    "naik": ["NK"]
}

ALIASES = {
    "sub maj": "subedar major",
    "nb sub": "naib subedar",
    "hav": "havildar",
    "l nk": "lance naik",
    "nk": "naik",
    "1 coy": "1 company",
    "2 coy": "2 company",
    "3 coy": "3 company",
    "hq coy": "hq company"
}

# =========================
# NORMALIZE QUESTION
# =========================
def normalize_question(question):
    q = question.lower()
    for alias, standard in ALIASES.items():
        pattern = r"\b" + re.escape(alias) + r"\b"
        q = re.sub(pattern, standard, q)
    return q

# =========================
# DETECT RANK (Longest First)
# =========================
def detect_rank_group(question):
    sorted_ranks = sorted(RANK_GROUPS.keys(), key=len, reverse=True)
    for key in sorted_ranks:
        if re.search(r"\b" + re.escape(key) + r"\b", question):
            return RANK_GROUPS[key]
    return None

# =========================
# SAFE SQL CHECK
# =========================
def is_safe_sql(sql):
    sql_lower = sql.lower()
    if not sql_lower.startswith("select"):
        return False
    forbidden = ["delete", "update", "drop", "insert", "alter", "truncate"]
    return not any(word in sql_lower for word in forbidden)

# =========================
# RULE BASED SQL
# =========================
def generate_sql_rule_based(question):

    question = normalize_question(question)

    # UNIT INFO
    if any(word in question for word in [
        "about unit", "about regiment", "unit details",
        "unit information", "tell me about unit",
        "history", "role of unit", "motto",
        "where is unit located", "co name",
        "who is co", "current co"
    ]):
        return "UNIT_INFO", []

    conditions = []
    values = []

    detected_rank = detect_rank_group(question)
    detected_company = None
    detected_section = None

    if "how many companies" in question:
        return "SELECT COUNT(DISTINCT company) FROM personnel", []

    if "how many sections" in question:
        return "SELECT COUNT(DISTINCT section) FROM personnel", []

    for company in COMPANIES:
        if company.lower() in question:
            detected_company = company
            break

    for section in SECTIONS:
        if section.lower() in question:
            detected_section = section
            break

    if detected_rank:
        placeholders = ", ".join(["%s"] * len(detected_rank))
        conditions.append(f"`rank` IN ({placeholders})")
        values.extend(detected_rank)

    if detected_company:
        conditions.append("company = %s")
        values.append(detected_company)

    if detected_section:
        conditions.append("section = %s")
        values.append(detected_section)

    if not conditions:
        return None, []

    if "how many" in question:
        select_part = "SELECT COUNT(*)"
    else:
        select_part = "SELECT name, army_number, `rank`, company, section"

    sql = f"{select_part} FROM personnel"

    if conditions:
        sql += " WHERE " + " AND ".join(conditions)

    return sql, values

# =========================
# CHAT MODE
# =========================
def chat_with_ollama(question):

    system_prompt = """
You are a helpful HRMS assistant for an Army unit.
Be polite, short and professional.
"""

    response = requests.post(
        "http://localhost:11434/api/generate",
        json={
            "model": "gemma3:4b",
            "prompt": f"{system_prompt}\nUser: {question}\nAssistant:",
            "stream": False
        }
    )

    return response.json().get("response", "").strip()

# =========================================================
# SMART HYBRID ROUTE
# =========================================================
@ollama_bot_bp.route("/ask", methods=["POST"])
def smart_ask():

    print("\n==============================")
    print("🤖 SMART ROUTE HIT")
    print("==============================")

    question = request.json.get("question")
    print("📩 Incoming Question:", question)

    if not question:
        return jsonify({"error": "No question provided"})

    sql, values = generate_sql_rule_based(question)

    print("🧠 Generated SQL:", sql)
    print("📦 SQL Values:", values)

    # UNIT INFO
    if sql == "UNIT_INFO":
        formatted = f"""
Unit Name: {UNIT_INFO['name']}
Location: {UNIT_INFO['location']}
Role: {UNIT_INFO['role']}
Motto: {UNIT_INFO['motto']}
Raising Date: {UNIT_INFO['raising_date']}
Under Command: {UNIT_INFO['under_command']}
Commanding Officer: {UNIT_INFO['current_co']}
"""
        return jsonify({"answer": formatted.strip(), "mode": "unit_info"})

    # DATABASE QUERY
    if sql and is_safe_sql(sql):
        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            print("🔌 Database Connected")

            cursor.execute(sql, values)
            result = cursor.fetchall()
            columns = [desc[0] for desc in cursor.description]

            cursor.close()
            conn.close()
            print("🔒 Database Closed")

            if not result:
                return jsonify({"answer": "No data found.", "mode": "database"})

            if "count" in sql.lower():
                return jsonify({"answer": f"Total: {result[0][0]}", "mode": "database"})

            formatted_rows = [dict(zip(columns, row)) for row in result]

            return jsonify({"answer": formatted_rows, "mode": "database"})

        except Exception as e:
            print("💥 DB ERROR:", str(e))
            return jsonify({"error": str(e)})

    # FALLBACK TO AI
    print("🧠 Falling Back to AI")
    ai_reply = chat_with_ollama(question)

    return jsonify({"answer": ai_reply, "mode": "chat"})
