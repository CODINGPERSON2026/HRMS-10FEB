from imports import *

accounts_bp = Blueprint('account', __name__, url_prefix='/account')


# ==========================================
# DASHBOARD PAGE
# ==========================================
@accounts_bp.route('/')
def accounts():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    query = """
        SELECT 
            g.id,
            g.name,
            g.code_head,
            IFNULL(a.total_allotment, 0) AS total_allotment,
            IFNULL(s.no_of_sos, 0) AS no_of_sos,
            IFNULL(e.total_expenditure, 0) AS total_expenditure
        FROM grants g
        LEFT JOIN (
            SELECT grant_id, SUM(amount) AS total_allotment
            FROM grant_allocations
            GROUP BY grant_id
        ) a ON g.id = a.grant_id
        LEFT JOIN (
            SELECT grant_id, COUNT(*) AS no_of_sos
            FROM sanction_orders
            GROUP BY grant_id
        ) s ON g.id = s.grant_id
        LEFT JOIN (
            SELECT grant_id, SUM(amount) AS total_expenditure
            FROM expenditures
            GROUP BY grant_id
        ) e ON g.id = e.grant_id
    """

    cursor.execute(query)
    grants = cursor.fetchall()

    for row in grants:

        total_allotment = float(row['total_allotment'] or 0)
        total_expenditure = float(row['total_expenditure'] or 0)

        row['balance'] = total_allotment - total_expenditure
        row['exp_percent'] = (
            round((total_expenditure / total_allotment) * 100, 2)
            if total_allotment > 0 else 0
        )

        print("DASHBOARD DEBUG:", row['name'], total_allotment)

    cursor.close()
    db.close()

    return render_template(
        "account_management/account.html",
        grants=grants
    )


# ==========================================
# SUMMARY API
# ==========================================
@accounts_bp.route('/grants/summary')
def grant_summary():

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT 
            g.id,
            g.name,
            g.code_head,
            IFNULL(a.total_allotment, 0) AS total_allotment,
            IFNULL(s.no_of_sos, 0) AS no_of_sos,
            IFNULL(e.total_expenditure, 0) AS total_expenditure
        FROM grants g
        LEFT JOIN (
            SELECT grant_id, SUM(amount) AS total_allotment
            FROM grant_allocations
            GROUP BY grant_id
        ) a ON g.id = a.grant_id
        LEFT JOIN (
            SELECT grant_id, COUNT(*) AS no_of_sos
            FROM sanction_orders
            GROUP BY grant_id
        ) s ON g.id = s.grant_id
        LEFT JOIN (
            SELECT grant_id, SUM(amount) AS total_expenditure
            FROM expenditures
            GROUP BY grant_id
        ) e ON g.id = e.grant_id
    """

    cursor.execute(query)
    results = cursor.fetchall()

    for row in results:

        total_allotment = float(row['total_allotment'] or 0)
        total_expenditure = float(row['total_expenditure'] or 0)

        row['balance'] = total_allotment - total_expenditure
        row['exp_percent'] = (
            round((total_expenditure / total_allotment) * 100, 2)
            if total_allotment > 0 else 0
        )

        print("SUMMARY DEBUG:", row['name'], total_allotment)

    cursor.close()
    conn.close()

    return jsonify(results)


# ==========================================
# CREATE GRANT + ORIGINAL ALLOCATION
# ==========================================
@accounts_bp.route('/grants/add', methods=['POST'])
def add_grant():

    data = request.get_json()

    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO grants (name, code_head, created_at)
        VALUES (%s, %s, NOW())
    """, (data['name'], data['code_head']))

    grant_id = cursor.lastrowid

    original_amount = float(data['allotment'] or 0)

    print("Creating Grant:", data['name'])
    print("Original Allotment:", original_amount)

    cursor.execute("""
        INSERT INTO grant_allocations
        (grant_id, amount, allocation_type, remarks)
        VALUES (%s, %s, 'Original', 'Initial Allotment')
    """, (grant_id, original_amount))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"success": True})


# ==========================================
# GRANT DETAIL PAGE
# ==========================================
@accounts_bp.route('/grants/<int:grant_id>')
def grant_detail(grant_id):

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT id, name, code_head
        FROM grants
        WHERE id = %s
    """, (grant_id,))
    grant = cursor.fetchone()

    if not grant:
        return "Grant not found", 404

    # ✅ TOTAL ALLOTMENT
    cursor.execute("""
        SELECT IFNULL(SUM(amount),0) AS total_allotment
        FROM grant_allocations
        WHERE grant_id = %s
    """, (grant_id,))
    total_allotment = float(cursor.fetchone()['total_allotment'] or 0)

    # attach to grant object for template
    grant["allotment"] = total_allotment

    # ✅ TOTAL EXPENDITURE
    cursor.execute("""
        SELECT IFNULL(SUM(amount),0) AS total_exp
        FROM expenditures
        WHERE grant_id = %s
    """, (grant_id,))
    total_exp = float(cursor.fetchone()['total_exp'] or 0)

    # lists
    cursor.execute("""
        SELECT id, so_number, so_amount, created_at
        FROM sanction_orders
        WHERE grant_id = %s
        ORDER BY created_at DESC
    """, (grant_id,))
    sos = cursor.fetchall()

    cursor.execute("""
        SELECT id, amount, remarks, created_at
        FROM expenditures
        WHERE grant_id = %s
        ORDER BY created_at DESC
    """, (grant_id,))
    expenditures = cursor.fetchall()

    balance = total_allotment - total_exp
    exp_percent = (
        round((total_exp / total_allotment) * 100, 2)
        if total_allotment > 0 else 0
    )

    print("DETAIL DEBUG:", grant["name"], total_allotment)

    cursor.close()
    conn.close()

    return render_template(
        "account_management/grant_detail.html",
        grant=grant,
        total_exp=total_exp,
        sos=sos,
        expenditures=expenditures,
        balance=balance,
        exp_percent=exp_percent
    )


# ==========================================
# ADD ADDITIONAL ALLOCATION
# ==========================================
@accounts_bp.route('/grants/<int:grant_id>/add-allocation', methods=['POST'])
def add_allocation(grant_id):

    data = request.get_json()
    amount = float(data.get("amount") or 0)

    if amount <= 0:
        return jsonify({"success": False, "message": "Invalid amount"})

    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO grant_allocations
        (grant_id, amount, allocation_type, remarks)
        VALUES (%s, %s, 'Additional', %s)
    """, (grant_id, amount, data.get("remarks", "")))

    conn.commit()
    cursor.close()
    conn.close()

    print("Added Additional Allocation:", amount)

    return jsonify({"success": True})


# ==========================================
# ADD EXPENDITURE (FIXED QUERY)
# ==========================================
@accounts_bp.route("/grants/<int:grant_id>/add-exp", methods=["POST"])
def add_expenditure(grant_id):

    data = request.get_json()
    amount = float(data.get("amount") or 0)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # ✅ FIXED: Separate queries to avoid SUM multiplication bug

    cursor.execute("""
        SELECT IFNULL(SUM(amount),0) AS total_allotment
        FROM grant_allocations
        WHERE grant_id = %s
    """, (grant_id,))
    total_allotment = float(cursor.fetchone()["total_allotment"] or 0)

    cursor.execute("""
        SELECT IFNULL(SUM(amount),0) AS total_exp
        FROM expenditures
        WHERE grant_id = %s
    """, (grant_id,))
    total_exp = float(cursor.fetchone()["total_exp"] or 0)

    current_balance = total_allotment - total_exp

    print("EXP DEBUG - Balance:", current_balance)

    if amount > current_balance:
        cursor.close()
        conn.close()
        return jsonify({
            "success": False,
            "message": "Expenditure exceeds available balance"
        })

    cursor.execute("""
        INSERT INTO expenditures (grant_id, amount)
        VALUES (%s, %s)
    """, (grant_id, amount))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"success": True})