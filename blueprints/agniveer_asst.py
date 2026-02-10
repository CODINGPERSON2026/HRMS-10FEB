from imports import *
from dateutil.relativedelta import relativedelta
agniveer_bp = Blueprint("agniveer_bp", __name__, url_prefix="/agni")

@agniveer_bp.route('/get_batches', methods=['GET'])
def get_batches():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True ,buffered=True)
        cursor.execute("SELECT DISTINCT batch FROM personnel WHERE batch IS NOT NULL ORDER BY batch ASC")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify([row['batch'] for row in rows])
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500



@agniveer_bp.route('/api/assistant-test', methods=['POST'])
def save_assistant_test():
    try:
        data = request.json
        batchSelected = data.get('batch')

        if not batchSelected:
            return jsonify({'success': False, 'error': 'Batch is required'}), 400

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True,buffered=True)

        # 🔹 Check if batch already exists in assistant_test
        cursor.execute("SELECT id FROM assistant_test WHERE batch = %s", (batchSelected,))
        if cursor.fetchone():
            cursor.close()
            conn.close()
            return jsonify({'success': False, 'error': 'Assistant test already initialized for this batch'}), 400
        # 🔹 Get DOE and TOS
        # 🔹 Get DOE and TOS
        cursor.execute(
            "SELECT date_of_enrollment, date_of_tos FROM personnel WHERE batch = %s LIMIT 1",
            (batchSelected,)
        )
        result = cursor.fetchone()






        if not result:
            return jsonify({'success': False, 'error': 'Batch not found'}), 404

        DOE = result['date_of_enrollment']
        TOS = result['date_of_tos']

        # 🔹 Auto calculations
        asst_test1 = DOE + relativedelta(months=12)
        asst_test2 = DOE + relativedelta(months=18)
        asst_test3 = DOE + relativedelta(months=30)
        asst_test4 = DOE + relativedelta(months=42)

        TOE = DOE + relativedelta(years=4)
        END_OF_TENURE = TOS + relativedelta(months=20)
        from_date = DOE + relativedelta(months=42)
        to_date   = DOE + relativedelta(months=45)
        screening_board = f"{from_date.strftime('%m/%y')} to {to_date.strftime('%m/%y')}"




        # 🔹 Insert
        sql = """
        INSERT INTO assistant_test
        (batch, asst_test1, asst_test2, asst_test3, asst_test4,
         test1_status, test2_status, test3_status, test4_status,
         DOE, TOE, TOS, END_OF_TENURE)
        VALUES (%s,%s,%s,%s,%s,0,0,0,0,%s,%s,%s,%s)
        """

        cursor.execute(sql, (
            batchSelected,
            asst_test1,
            asst_test2,
            asst_test3,
            asst_test4,
            DOE,
            TOE,
            TOS,
            END_OF_TENURE
        ))

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            'success': True,
            'message': 'Assistant test dates auto-generated successfully'
        }), 200

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500









@agniveer_bp.route('/get_all_agniveers', methods=['GET'])
def get_all_agniveers():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True, buffered=True)

    query = """
    SELECT 
        a.*,
        
        a.remarks,

        IFNULL(p.strength, 0) AS strength
    FROM assistant_test a
    LEFT JOIN (
        SELECT batch, COUNT(*) AS strength
        FROM personnel
        GROUP BY batch
    ) p ON p.batch = a.batch
   
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    # Convert dates to string format and compute dynamic fields
    for row in rows:
        for key, value in row.items():
            if hasattr(value, "strftime"):
                row[key] = value.strftime('%Y-%m-%d')

        # 🔹 Compute "Assmt completed on / or such wef" dynamically
        # For 4 sub-columns (1st Yr, 2nd Yr, 3rd Yr, 4th Yr)
        row["assmt_wef_1st"] = row.get("emergency_test1")
        row["assmt_wef_2nd"] = row.get("emergency_test2")
        row["assmt_wef_3rd"] = row.get("emergency_test3")
        row["assmt_wef_4th"] = row.get("emergency_test4")

        # 🔹 Fill Screening Board if blank
        if not row.get("screening_board"):
            DOE = row.get("DOE")
            if DOE:
                # If DOE is already a string from the strftime loop above
                DOE_date = datetime.strptime(DOE, "%Y-%m-%d")
                from_date = DOE_date + relativedelta(months=42)
                to_date   = DOE_date + relativedelta(months=45)
                row["screening_board"] = f"{from_date.strftime('%m/%y')} to {to_date.strftime('%m/%y')}"

    cursor.close()
    conn.close()
    return jsonify(rows)





    




@agniveer_bp.route("/update-assistant", methods=["POST"])
def update_assistant():
    data = request.get_json()
    batch = data.get("batch")
    test_no = data.get("test_no")
    status = data.get("status")
    emergency_type = data.get("emergency_type")  # optional
    new_date = data.get("new_date")  # optional
    remarks = data.get("remarks")  # new field

    # Validate mandatory fields
    if not batch or not test_no or status not in (0, 1):
        return jsonify({"success": False, "error": "Invalid input"}), 400

    # Remove mandatory word count check
    if not remarks or remarks.strip() == "":
        remarks = "No Remarks"

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # 1️⃣ Update normal status and remarks
        column_name = f"test{test_no}_status"
        sql_status = f"UPDATE assistant_test SET {column_name} = %s, remarks = %s WHERE batch = %s"
        cursor.execute(sql_status, (status, remarks, batch))

        # 2️⃣ Update emergency date if provided
        if emergency_type in ("prepone", "postpone") and new_date:
            date_column = f"emergency_test{test_no}"
            type_column = f"emergency_test{test_no}_type"
            sql_emergency = f"""
                UPDATE assistant_test
                SET {date_column} = %s, {type_column} = %s
                WHERE batch = %s
            """
            cursor.execute(sql_emergency, (new_date, emergency_type, batch))

        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    
    except Exception as e:
        print("Error updating assistant:", e)
        return jsonify({"success": False, "error": "Server error"}), 500
