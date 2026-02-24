from imports import *

accounts_bp = Blueprint('account',__name__,url_prefix='/account')

@accounts_bp.route('/')
def accounts():
    return render_template('account_management/account.html')






# -----------------------------
# Fetch Departments
# -----------------------------
@accounts_bp.route('/departments', methods=['GET'])
def get_departments():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, account_holder, current_balance FROM department_accounts ORDER BY account_holder")
    departments = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(departments)


# -----------------------------
# Add Department
# -----------------------------
@accounts_bp.route('/departments/add', methods=['POST'])
def add_department():
    data = request.json
    name = data.get('account_holder')
    initial_balance = float(data.get('initial_balance', 0))

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO department_accounts (account_holder, current_balance) VALUES (%s, %s)",
        (name, initial_balance)
    )
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'status': 'success', 'message': 'Department added successfully'})


# -----------------------------
# Update Balance
# -----------------------------
@accounts_bp.route('/departments/update_balance', methods=['POST'])
def update_balance():
    data = request.json
    dep_id = data.get('department_id')
    transaction_type = data.get('transaction_type')
    amount = Decimal(str(data.get('amount')))  # convert float/string to Decimal
    remarks = data.get('remarks', '')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch current balance
    cursor.execute("SELECT current_balance FROM department_accounts WHERE id = %s", (dep_id,))
    row = cursor.fetchone()
    if not row:
        return jsonify({'success': False, 'message': 'Department not found'}), 404

    old_balance = row['current_balance']  # decimal.Decimal

    # Calculate new balance
    if transaction_type == 'credit':
        new_balance = old_balance + amount
        credit_amount = amount
        debit_amount = Decimal('0')
    else:
        new_balance = old_balance - amount
        credit_amount = Decimal('0')
        debit_amount = amount

    # Update current_balance in department_accounts
    cursor.execute(
        "UPDATE department_accounts SET current_balance = %s, updated_at = NOW() WHERE id = %s",
        (new_balance, dep_id)
    )

    # Insert transaction into department_transactions
    cursor.execute("""
        INSERT INTO department_transactions
        (department_account_id, transaction_date, old_balance, credit_amount, debit_amount, new_balance, remarks)
        VALUES (%s, NOW(), %s, %s, %s, %s, %s)
    """, (dep_id, old_balance, credit_amount, debit_amount, new_balance, remarks))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'success': True, 'message': 'Balance updated successfully'})



# -----------------------------
# Fetch Department Statement
# -----------------------------


@accounts_bp.route('/departments/<int:department_id>/statement', methods=['GET'])
def get_statement(department_id):
    page = int(request.args.get('page', 1))  # current page, default 1
    per_page = 20  # number of transactions per page
    offset = (page - 1) * per_page

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch paginated transactions
    cursor.execute(
        """SELECT DATE_FORMAT(transaction_date, '%d %b %Y') AS date,
                  old_balance, credit_amount, debit_amount, new_balance, remarks
           FROM department_transactions
           WHERE department_account_id=%s
           ORDER BY transaction_date DESC
           LIMIT %s OFFSET %s""",
        (department_id, per_page, offset)
    )
    transactions = cursor.fetchall()

    # Fetch current balance to show in dropdown
    cursor.execute(
        "SELECT current_balance FROM department_accounts WHERE id=%s",
        (department_id,)
    )
    account = cursor.fetchone()
    current_balance = float(account['current_balance']) if account else 0

    cursor.close()
    conn.close()

    return jsonify({
        'transactions': transactions,
        'current_balance': current_balance,
        'page': page,
        'per_page': per_page,
        'has_more': len(transactions) == per_page  # flag to check if more pages exist
    })
# -----------------------------
# Fetch Last 10 Transactions for All Grants
# -----------------------------
@accounts_bp.route('/departments/all_transactions', methods=['GET'])
def get_all_transactions():
    limit = int(request.args.get('limit', 10))  # default 10

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        """SELECT t.id, t.department_account_id, d.account_holder,
                  DATE_FORMAT(t.transaction_date, '%d %b %Y') AS date,
                  t.old_balance, t.credit_amount, t.debit_amount, t.new_balance, t.remarks
           FROM department_transactions t
           JOIN department_accounts d ON t.department_account_id = d.id
           ORDER BY t.transaction_date DESC
           LIMIT %s""",
        (limit,)
    )
    transactions = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify({
        'transactions': transactions,
        'has_more': False  # no infinite scroll for all grants
    })
