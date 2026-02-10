from imports import *
roll_call_bp = Blueprint("roll_call", __name__, url_prefix="/roll_call")

@roll_call_bp.route("/submit", methods=["POST"])
def submit_roll_call():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"success": False, "message": "No data provided"}), 400

        category = data.get("category")
        point_title = data.get("point_title")
        point_description = data.get("point_description")
        army_number = data.get("army_number")

        # Basic validation
        if not category or not point_title or not point_description:
            return jsonify({"success": False, "message": "All fields are required"}), 400

        status = None  # Default for SM_SUGGESTION

        if category == "OR_REQUEST":
            if not army_number or army_number.strip() == "":
                return jsonify({"success": False, "message": "Army Number is required for OR Request"}), 400

            # ------------------ Check if Army Number exists ------------------
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT army_number FROM personnel WHERE army_number = %s", (army_number,))
            result = cursor.fetchone()
            if not result:
                cursor.close()
                conn.close()
                return jsonify({"success": False, "message": "Please enter a valid Army Number"}), 400

            status = "PENDING"  # Set status for OR_REQUEST
        else:
            # SM_SUGGESTION → status stays NULL
            conn = get_db_connection()
            cursor = conn.cursor()

        # Insert into roll_call_points table
        cursor.execute("""
            INSERT INTO roll_call_points (category, point_title, point_description, army_number, status)
            VALUES (%s, %s, %s, %s, %s)
        """, (category, point_title, point_description, army_number, status))
        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({"success": True, "message": "Point submitted successfully"})

    except Exception as e:
        print("Error submitting roll call:", e)
        return jsonify({"success": False, "message": "Server error"}), 500




@roll_call_bp.route('/pending', methods=['GET'])
def get_pending_roll_call_points():
    user = require_login()
    company = user['company']
    role = user['role']

    category = request.args.get('category', 'OR_REQUEST')

    status_map = {
        'OR_REQUEST': 'PENDING',
        'SM_SUGGESTION': 'SUGGESTED'
    }

    status = status_map.get(category, 'PENDING')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        query = '''
            SELECT 
                rcp.id,
                rcp.status,
                rcp.category,
                rcp.point_title,
                rcp.point_description,
                rcp.created_at,
                p.army_number,
                p.name,
                p.rank,
                p.company
            FROM roll_call_points rcp
            LEFT JOIN personnel p ON rcp.army_number = p.army_number
            WHERE rcp.status = %s
        '''

        params = [status]
        print('compnay',company)

        # if company != "Admin" or company == 'Center':
        #     print('filtered')
        #     query += " AND p.company = %s"
        #     params.append(company)

        query += " ORDER BY rcp.created_at DESC"

        cursor.execute(query, tuple(params))
        rows = cursor.fetchall()

        return jsonify({"status": "success", "data": rows}), 200

    except Exception as e:
        print("Roll call fetch error:", e)
        return jsonify({"status": "error"}), 500

    finally:
        cursor.close()
        conn.close()


















@roll_call_bp.route("/update_status", methods=["POST"])
def update_roll_call_status():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"status": "error", "message": "No data provided"}), 400

        roll_call_id = data.get("id")
        new_status = data.get("status")

        # Validate inputs
        if not roll_call_id or not new_status:
            return jsonify({
                "status": "error",
                "message": "ID and status are required"
            }), 400

        if new_status not in ["APPROVED", "REJECTED"]:
            return jsonify({
                "status": "error",
                "message": "Invalid status value"
            }), 400

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Check if record exists and is pending
        cursor.execute("""
            SELECT id, status
            FROM roll_call_points
            WHERE id = %s
        """, (roll_call_id,))
        record = cursor.fetchone()

        if not record:
            cursor.close()
            conn.close()
            return jsonify({
                "status": "error",
                "message": "Roll call record not found"
            }), 404

        if record["status"] != "PENDING":
            cursor.close()
            conn.close()
            return jsonify({
                "status": "error",
                "message": "Only PENDING records can be updated"
            }), 400

        # Update status
        cursor.execute("""
            UPDATE roll_call_points
            SET status = %s
            WHERE id = %s
        """, (new_status, roll_call_id))

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            "status": "success",
            "message": f"Status updated to {new_status}"
        })

    except Exception as e:
        print("Update Roll Call Status Error:", e)
        return jsonify({
            "status": "error",
            "message": "Server error"
        }), 500
