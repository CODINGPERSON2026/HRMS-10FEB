from imports import *
from db_config import get_db_connection


leave_bp = Blueprint('apply_leave', __name__, url_prefix='/apply_leave')
@leave_bp.route("/", methods=["GET"])
def apply_leave():
       return render_template("apply_leave/apply_leave.html")

@leave_bp.route("/get_leave_details", methods=["POST"])
def get_leave_details():
    data = request.get_json()
    army_no = data.get("person_id")

    if not army_no:
        return jsonify({"success": False, "message": "Army number missing"}), 400

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT name, army_number, trade, `rank`, company
            FROM personnel
            WHERE army_number = %s
        """, (army_no,))
        personnel = cursor.fetchone()

        if not personnel:
            return jsonify({"success": False, "message": "No such soldier found"}), 404

        cursor.execute("""
            SELECT sr_no, year, al_days, cl_days, aal_days, total_days, remarks
            FROM leave_details
            WHERE army_number = %s
            ORDER BY year DESC
            LIMIT 1
        """, (army_no,))
        leaveinfo = cursor.fetchone()
        print(leaveinfo)

        if not leaveinfo:
            # If no record in leave_details, we can still show standard entitlements
            # or return empty. Given the user's comment, I'll provide the standard ones.
            leaveinfo = {
                "al_days": 60,
                "cl_days": 30,
                "aal_days": 30
            }

        # Query actual leave taken from approved requests
        cursor.execute("""
            SELECT leave_type, SUM(leave_days) as taken
            FROM leave_status_info
            WHERE army_number = %s AND request_status = 'Approved'
            GROUP BY leave_type
        """, (army_no,))
        taken_info = cursor.fetchall()
        taken_dict = {row['leave_type']: row['taken'] for row in taken_info}

        # Get personnel rank to determine entitlements
        rank = personnel.get('rank', '').strip().upper()
        
        # Check if Agniveer rank
        is_agniveer = rank in ['AGNIVEER', 'AV']
        
        # Set entitlements based on rank
        if is_agniveer:
            # Agniveer: Only AL=30 days
            al_total = 30
            cl_total = 0
            aal_total = 0
        else:
            # Other ranks: AL=60, CL=30, AAL=30
            al_total = 60
            cl_total = 30
            aal_total = 30

        al_taken = taken_dict.get('AL', 0) or 0
        cl_taken = taken_dict.get('CL', 0) or 0
        aal_taken = taken_dict.get('AAL', 0) or 0

        # Build leave balance array based on rank
        leave_balance = [
            {
                "leave_type": "AL",
                "total_leave": al_total,
                "leave_taken": int(al_taken),
                "balance_leave": al_total - int(al_taken)
            }
        ]
        
        # Only add CL and AAL for non-Agniveer ranks
        if not is_agniveer:
            leave_balance.extend([
                {
                    "leave_type": "CL",
                    "total_leave": cl_total,
                    "leave_taken": int(cl_taken),
                    "balance_leave": cl_total - int(cl_taken)
                },
                {
                    "leave_type": "AAL",
                    "total_leave": aal_total,
                    "leave_taken": int(aal_taken),
                    "balance_leave": aal_total - int(aal_taken)
                }
            ])

        # Add Summary Total Row
        total_auth = sum(l['total_leave'] for l in leave_balance)
        total_taken = sum(l['leave_taken'] for l in leave_balance)
        total_balance = sum(l['balance_leave'] for l in leave_balance)

        leave_balance.append({
            "leave_type": "Total",
            "total_leave": total_auth,
            "leave_taken": total_taken,
            "balance_leave": total_balance
        })

        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "personnel": personnel,
            "leave_balance": leave_balance
        })

    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500







# ########################################################### UPDATED CERTIFICATE DOWNLOAD FUNCTIONLAITY


@leave_bp.route("/search_personnel")
def search_personnel():
    query = request.args.get("query", "").strip()

    if query == "":
        return jsonify([])

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT army_number, request_status, leave_type, from_date, to_date
            FROM leave_status_info
            WHERE army_number = %s
        """, (query,))
        
        existing = cursor.fetchone()

        if existing:
            status = existing["request_status"]

            # 🔹 Normalize status using LIKE-style logic
            if status.lower().startswith("pending"):
                existing["request_status"] = "Pending"
            elif status.lower().startswith("approved"):
                existing["request_status"] = "Approved"
            elif status.lower().startswith("rejected"):
                existing["request_status"] = "Rejected"

            return jsonify({
                "exists": True,
                "existing_leave": existing
            })

        # No existing leave → search personnel
        cursor.execute("""
            SELECT name, army_number, `rank`, trade, company,section
            FROM personnel
            WHERE army_number LIKE %s
            LIMIT 1
        """, (f"%{query}%",))
        results = cursor.fetchall()

        return jsonify(results)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()
        conn.close()



# download route

@leave_bp.route("/leave/download_certificate/<army_number>")
def download_leave_certificate(army_number):
    try:
        # DB connection
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch approved leave + personnel details
        # We join leave_status_info with personnel to get all needed data
        # We take the latest APPROVED leave for this user or a specific one if ID was passed (but URL uses army_number)
        # Assuming we want the LATEST approved leave for this user.
        
        cursor.execute("""
            SELECT 
                l.id as leave_id,
                l.leave_type,
                l.leave_days,
                l.from_date,
                l.to_date,
                l.prefix_date,
                l.suffix_date,
                l.created_at as applied_on,
                l.updated_at as issue_date,
                p.name,
                p.army_number,
                p.rank,
                p.company,
                p.section,
                p.trade,
                p.home_house_no,
                p.home_village,
                p.home_po,
                p.home_teh,
                p.home_district,
                p.home_state
                
            FROM leave_status_info l
            JOIN personnel p 
                ON p.army_number = l.army_number
            WHERE l.army_number = %s
              AND l.request_status = 'Approved'
            ORDER BY l.created_at DESC
            LIMIT 1
        """, (army_number,))

        data = cursor.fetchone()

        if not data:
            return "No approved leave certificate found for this user.", 404

        # Prepare Applicant Object
        applicant = {
            "name": data['name'],
            "rank": data['rank'],
            "army_number": data['army_number'],
            "unit": "15 CORPS ENGG SIG REGT", # Hardcoded as per header
            "company_name": data['company'],
            "section_name": data['section'] if data['section'] else "HQ"
        }

        # Format Address from personnel table
        # Construct address from components: House No, Village, PO, Tehsil, District, State
        parts = []
        if data.get('home_house_no'): parts.append(f"House No: {data['home_house_no']}")
        if data.get('home_village'): parts.append(f"Vill: {data['home_village']}")
        if data.get('home_po'): parts.append(f"PO: {data['home_po']}")
        if data.get('home_teh'): parts.append(f"Teh: {data['home_teh']}")
        if data.get('home_district'): parts.append(f"Dist: {data['home_district']}")
        if data.get('home_state'): parts.append(data['home_state'])
        
        details_address = ", ".join(parts)

        if not details_address.strip():
             details_address = "Address not updated in records."

        # Prepare Leave Object
        # Certificate Number: LEAVE/YEAR/ID
        current_year = datetime.now().year
        cert_no = f"LEAVE/{current_year}/{data['leave_id']}"

        # Calculate Duration
        # We can use logic to calculate duration or just use leave_days
        # data['from_date'] and data['to_date'] are likely date objects
        
        leave_info = {
            "certificate_number": cert_no,
            "leave_type": data['leave_type'],
            "start_date": data['from_date'],
            "end_date": data['to_date'],
            "total_days": data['leave_days'],
            "applied_on": data['applied_on'],
            "issue_date": data['issue_date'] if data['issue_date'] else datetime.now(),
            "prefix_details": data['prefix_date'] if data['prefix_date'] else "NIL",
            "suffix_details": data['suffix_date'] if data['suffix_date'] else "NIL",
            "address_during_leave": details_address,
            
            "reporting_date": data['to_date'] 
        }

        # Render HTML template
        html = render_template(
            "leave_certificate.html",
            applicant=applicant,
            leave=leave_info
        )

        # Create PDF using xhtml2pdf (pisa) - Stable on Windows
        pdf_buffer = BytesIO()
        pisa_status = pisa.CreatePDF(html, dest=pdf_buffer)

        if pisa_status.err:
            return "Error generating PDF", 500

        # Prepare response
        response = make_response(pdf_buffer.getvalue())
        response.headers["Content-Type"] = "application/pdf"
        response.headers["Content-Disposition"] = (
            f"inline; filename=Leave_Certificate_{army_number}.pdf"
        )

        return response

    except Exception as e:
        print(f"Error: {e}")
        return str(e), 500

    finally:
        if 'cursor' in locals() and cursor:
            cursor.close()
        if 'conn' in locals() and conn:
            conn.close()


@leave_bp.route("/submit_leave", methods=["POST"])
def submit_leave_request():
    data = request.get_json()
    print("Received data:", data)

    army_number = data.get("person_id")
    leave_type = data.get("leave_type")
    actual_leave_days = data.get("actual_leave_days")  # Days that count against balance (without prefix/suffix)
    total_days = data.get("total_days")  # Total days including prefix/suffix
    prefix_days = data.get("prefix_days", 0)
    suffix_days = data.get("suffix_days", 0)
    prefix_date = data.get("prefix_date")
    suffix_date = data.get("suffix_date")
    from_date = data.get("from_date")
    to_date = data.get("to_date")
    reason = data.get("reason")
    name = data.get('name')
    print(name)
    
    

    # Validate required fields
    if not all([army_number, leave_type, actual_leave_days, total_days, from_date, to_date, reason]):
        return jsonify({"message": "Missing required fields"}), 400

    # Get company of personnel
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT company,`rank`,section FROM personnel WHERE army_number = %s", (army_number,))
        result = cursor.fetchone()
        if not result:
            return jsonify({"message": "Invalid Army Number. Personnel not found"}), 404
        company_name = result['company'].lower()
        rank = result['rank']
        section = result['section']
        print(company_name,section,rank)
        request_status = section
        print(company_name,'this is company')
        # Find SEC NCO of the same company
        cursor.execute('SELECT role FROM users WHERE company = %s AND role = %s', (company_name,''))
        sec_nco = cursor.fetchone()
        print('#########################################################################################')
        request_status = ''
        if rank =='Subedar' or rank == 'Naib Subedar' or rank  == 'Subedar Major':
            request_sent_to = 'OC'
            request_status = 'Pending at OC'
        else : 
            # Prefix section with 'NCO ' to match role format in users table
            request_sent_to = f'NCO {section}'
            request_status = f'Pending at NCO {section}'
    except Exception as e:
        return jsonify({"message": "Database error", "error": str(e),'status':'error'}), 500
    finally:
        cursor.close()
        conn.close()

    

    # Insert leave request - use actual_leave_days for leave_days field
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO leave_status_info
            (army_number, rank, name, company, leave_type, leave_days, from_date, to_date, prefix_date, suffix_date, prefix_days, suffix_days, request_sent_to, request_status, recommend_date, rejected_date, remarks, leave_reason, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, NULL, NULL, %s, %s, NOW(), NOW())
        """, (
            army_number,
            rank,
            name,
            company_name,
            leave_type,
            int(actual_leave_days),
            from_date,
            to_date,
            prefix_date,
            suffix_date,
            int(prefix_days),
            int(suffix_days),
            request_sent_to,
            request_status,
            f"{leave_type} for {total_days} day(s) (Actual: {actual_leave_days} days, Prefix: {prefix_days}, Suffix: {suffix_days})",
            reason
        ))
        conn.commit()
        return jsonify({'status':'success',"message": f"Leave request for {total_days} day(s) sent successfully!"})
    except Exception as e:
        conn.rollback()
        return jsonify({"message": "Failed to apply leave", "error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()


# FOR SENDING THE LEAVE REQUEST TO HIGHER LEVEL
@leave_bp.route("/update_leave_status", methods=["POST"])
def update_leave_status():
    data = request.get_json()
    leave_id = data.get("id")
    status = data.get("status")

    if status not in ['Approved', 'Rejected']:
        return jsonify({"status": "error", "message": "Invalid status"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        if status == 'Approved':
            cursor.execute("""
                UPDATE leave_status_info
                SET request_status = %s, updated_at = NOW()
                WHERE id = %s
            """, (status, leave_id))
        else:
            cursor.execute("""
                UPDATE leave_status_info
                SET request_status = %s, rejected_date = NOW()
                WHERE id = %s
            """, (status, leave_id))

        conn.commit()
        return jsonify({"status": "success"})
    except Exception as e:
        conn.rollback()
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cursor.close()
        conn.close()

@leave_bp.route("/get_leave_requests", methods=["GET"])
def get_leave_requests():
    print('in this route')
    conn = get_db_connection()
    print("hitting this from the dashboard of co")

    cursor = conn.cursor(dictionary=True)
    user = require_login()
    
    current_user_role = user['role']
    current_user_company = user['company']
    print(current_user_role)
    request_status = f'Pending at {current_user_role}'
    print(request_status)
    try:
        query = '''
  SELECT id,name, army_number, leave_type, leave_days,
                   request_status, remarks, created_at
            FROM leave_status_info
            WHERE request_sent_to = %s AND request_status = %s 
            
'''
        
        if current_user_role != '2IC' and current_user_role != 'CO':
            query = query + 'AND company = %s' + 'ORDER BY created_at DESC'
            print(current_user_role,request_status,current_user_company)
            cursor.execute(query, (current_user_role,request_status,current_user_company))
            print("in the route that sjould worldds  adsdsfdjfklfjdlf fljalfjdsklfjs ")
        elif current_user_role == 'CO':
            print('IN CO USER ROLE')
            query =  '''SELECT
    id,
    army_number,
    rank,
    name,
    company,
    leave_type,
    leave_days,
    request_status
FROM leave_status_info
WHERE request_status LIKE 'Pending%'
AND updated_at < NOW() - INTERVAL 5 MINUTE;'''
            cursor.execute(query)
            print('in CO TYPE')
        
        else:
            query = query + 'ORDER BY created_at DESC'
            cursor.execute(query, (current_user_role,request_status,))

        rows = cursor.fetchall()
        print(rows)
        return jsonify({"status": "success", "data": rows})

    except Exception as e:
        print("Error fetching leave requests:", e)
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cursor.close()
        conn.close()



@leave_bp.route("/get_leave_request/<int:leave_id>", methods=["GET"])
def get_leave_request(leave_id):
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch only necessary leave request data including from_date and to_date
        cursor.execute("""
            SELECT 
                id,
                army_number,
                rank,
                name,
                company,
                leave_type,
                leave_days,
                from_date,
                to_date,
                prefix_date,
                suffix_date,
                prefix_days,
                suffix_days,
                leave_reason,
                request_status,
                       reject_reason
                       
            FROM leave_status_info
            WHERE id = %s
        """, (leave_id,))
        leave = cursor.fetchone()
        cursor.execute("select name,`rank`from personnel where army_number = %s",(leave['army_number'],))
        name_result = cursor.fetchone()        
        leave['name'] = name_result['name']
        leave['rank'] = name_result['rank']
        
        print("this request is called before")
        user = require_login()
        if user['role'] == 'OC':
            leave['leave_request_type'] = 'OR'
        elif user['role'] == '2IC':
            leave['leave_request_type'] = 'OFFICER'

        if not leave:
            return jsonify({
                "success": False,
                "message": "Leave request not found"
            }), 404
        print("THIS IS LEAVE RETURNED",leave)

        return jsonify({
            "success": True,
            "data": leave
        })

    except Exception as e:
        print(str(e))
        return jsonify({
            "success": False,
            "message": "Server error",
            "error": str(e)
        }), 500

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()





@leave_bp.route("/recommend_leave", methods=["POST"])
def recommend_leave():
    data = request.get_json()
    print(data)
    leave_id = data.get("leave_id")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    send_request_to = ''
    current_user_role = ''
    request_status = ''

    if not leave_id:
        return jsonify({"message": "Leave ID missing"}), 400
    user =  require_login()
    current_user_role = user['role']
    current_user_company = user['company']
    print('current_user_role',current_user_role)
    if current_user_role.startswith("NCO "):
         send_request_to = current_user_role.replace("NCO ", "JCO ", 1)
         request_status = f"Pending at {send_request_to}"
    if current_user_role.startswith("JCO "):
         send_request_to = 'S/JCO'
         request_status = f"Pending at {send_request_to}"
         print(current_user_company)
    if current_user_role.startswith("S/JCO"):
         send_request_to = 'OC'
         request_status = f"Pending at {send_request_to}"
         print(current_user_company)
        

    

    print('current user role',current_user_role)
    print('send request to ',send_request_to)
    
    

    try:
        # 1️⃣ Fetch leave request details
        cursor.execute("""
            SELECT 
                id,
                army_number,
                       name,
                leave_type,
                leave_days,
                from_date,
                to_date,
                leave_reason
            FROM leave_status_info
            WHERE id = %s
        """, (leave_id,))
        leave = cursor.fetchone()
        
    # check what the rank of the personnel 
        cursor.execute('select `rank`,section from personnel where army_number = %s',(leave['army_number'],))
        result_rank = cursor.fetchone()
        rank =  result_rank['rank']



        if current_user_role == 'OC' and rank != 'Subedar' and rank !='Naib Subedar' and rank !='Subedar Major':
            sent_request_to = 'Approved'
            request_status  = 'Approved'
            cursor.execute('update personnel set onleave_status = 1 where army_number = %s',(leave['army_number'],))
        elif current_user_role == 'OC':
            sent_request_to = '2IC'
            request_status = 'Pending at 2IC' 
        elif current_user_role == '2IC':
            sent_request_to = 'Approved'
            request_status = 'Approved'
        elif  current_user_role == 'CO':
            sent_request_to = 'Approved'
            request_status  = 'Approved'
        
        
        
        print("##################################################################################")

        if not leave:
            return jsonify({"message": "Leave request not found"}), 404
        print(leave,"this is leave")
        # Logged-in user (SEC NCO)
        
        # 2️⃣ Insert into leave_history
        cursor.execute("""
            INSERT INTO hrms.leave_history (
                leave_request_id,
                army_number,
                name,
                leave_type,
                from_date,
                to_date,
                total_days,
                recommended_by,
                remarks,
                status
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s,%s)
        """, (
            leave["id"],
            leave["army_number"],
            leave['name'],  # replace with actual name if available
            leave["leave_type"],
            leave["from_date"],
            leave["to_date"],
            leave["leave_days"],
            current_user_role,
            leave["leave_reason"],
            request_status
        ))
        print(request_status,"before query")
        

        # 3️⃣ Update main leave table
        cursor.execute("""
            UPDATE leave_status_info
            SET
                request_sent_to = %s,
                request_status = %s,
                recommend_date = NOW(),
                rejected_date = NULL,
                updated_at = NOW()
            WHERE id = %s
        """, (send_request_to,request_status,leave_id))

        conn.commit()

        return jsonify({"message": "Leave recommended successfully"}), 200

    except Exception as e:
        conn.rollback()
        print("ERROR:", e)
        return jsonify({"message": "Server error"}), 500

    finally:
        cursor.close()
        conn.close()
@leave_bp.route("/get_recommended_requests")
def get_recommended_requests():
    print("in this recommended route")

    user = require_login()
    recommended_by = user['role']
    user_company = user['company']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = '''
    SELECT
        lh.id,
        lh.leave_request_id,
        lh.army_number,
        lsi.rank,
        lsi.name,
        lsi.company,
        lh.leave_type,
        lsi.leave_days,
        lsi.from_date,
        lsi.to_date,
        lh.status,
        lh.recommended_at
    FROM leave_history lh
    JOIN leave_status_info lsi
        ON lh.leave_request_id = lsi.id
    WHERE lh.recommended_by = %s
'''

    # UNIT 2IC → sees ALL companies
    if recommended_by == '2IC':
        query += ' ORDER BY lh.recommended_at DESC'
        cursor.execute(query, (recommended_by,))

    # Company-level users → restricted by company
    else:
        query += ' AND lsi.company = %s ORDER BY lh.recommended_at DESC'
        cursor.execute(query, (recommended_by, user_company))

    data = cursor.fetchall()
    print(data,"this is data")

    
    cursor.close()
    conn.close()

    return jsonify({"data": data})


@leave_bp.route("/get_leave_history/<int:id>")
def get_leave_history(id):
    user = require_login()
    recommended_by = user['role']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            lh.id,
            lh.leave_request_id,
                   lsi.name,
            lh.army_number,
            lh.name,
            lh.leave_type,
            lsi.leave_days,
            lsi.from_date,
            lsi.to_date,
            lsi.leave_reason,
            lsi.request_status,
            lh.remarks,
            lh.recommended_at
        FROM leave_history lh
        JOIN leave_status_info lsi
            ON lh.leave_request_id = lsi.id
        WHERE lh.id = %s
          AND lh.recommended_by = %s
    """, (id, recommended_by))

    data = cursor.fetchone()
    
# get the rannk

    cursor.execute('select `rank` from personnel where army_number =%s',(data['army_number'],))
    result_rank = cursor.fetchone()
    rank = result_rank['rank']



    user_data = {}
    if recommended_by == 'OC' and rank !='Subedar' and rank != 'Naib Subedar' and rank !='Subedar Major':
        user_data['leave_request_type'] = 'OR'
    elif recommended_by == 'OC':
        user_data['leave_request_type'] = 'OFFICER'
    cursor.close()
    conn.close()

    if not data:
        return jsonify({"message": "Record not found"}), 404

    return jsonify({"data": data,'user_data':user_data})





@leave_bp.route("/reject_leave", methods=["POST"])
def reject_leave():
    data = request.get_json()

    leave_id = data.get("leave_id")
    reason = data.get("reason")

    if not leave_id or not reason:
        return jsonify({
            "message": "Leave ID and rejection reason required"
        }), 400

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    user = require_login()
    current_role = user["role"]
    rejected_by = user.get("username", "SYSTEM")

    status_text = f"Rejected at {current_role}"
    now = datetime.now()

    try:
        # 🔹 START TRANSACTION
        conn.start_transaction()

        # 1️⃣ Fetch leave request details (LOCK ROW)
        cursor.execute("""
            SELECT
                id,
                army_number,
                       name,
                leave_type,
                from_date,
                to_date,
                leave_days,
                company
            FROM leave_status_info
            WHERE id = %s
            FOR UPDATE
        """, (leave_id,))

        leave = cursor.fetchone()

        if not leave:
            conn.rollback()
            return jsonify({
                "message": "Leave request not found"
            }), 404

        # 2️⃣ UPDATE leave_status_info
        cursor.execute("""
            UPDATE leave_status_info
            SET
                request_status = %s,
                reject_reason = %s,
                rejected_date = %s,
                updated_at = %s
            WHERE id = %s
        """, (
            status_text,
            reason,
            now,
            now,
            leave_id
        ))

        # 3️⃣ INSERT INTO leave_history (ONLY INSERT)
        cursor.execute("""
            INSERT INTO leave_history (
                leave_request_id,
                army_number,
                name,
                leave_type,
                from_date,
                to_date,
                total_days,
                recommended_by,
                status,
                remarks,
                recommended_at,
                reject_reason,
                company
            )
            VALUES (%s,%s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s)
        """, (
            leave["id"],
            leave["army_number"],
            leave['name'],
            leave["leave_type"],
            leave["from_date"],
            leave["to_date"],
            leave["leave_days"],
            rejected_by,          # who rejected
            status_text,
            "Leave rejected",
            now,
            reason,
            leave['company']
        ))

        # 🔹 COMMIT TRANSACTION
        conn.commit()

        return jsonify({
            "message": "Leave rejected successfully"
        }), 200

    except Exception as e:
        conn.rollback()
        print("REJECT ERROR:", e)
        return jsonify({
            "message": "Internal server error"
        }), 500

    finally:
        cursor.close()
        conn.close()


@leave_bp.route("/get_rejected_requests", methods=["GET"])
def get_rejected_requests():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    user = require_login()
    company = user['company']
    role = user['role']
    print(user,"this is user")
    query = """
    SELECT
        id,
        army_number,
        rank,
        name,
        company,
        leave_type,
        leave_days,
        reject_reason,
        request_status
    FROM leave_status_info
    WHERE request_status LIKE '%Rejected at%'
"""

    try:
        # Unit 2IC → sees all companies
        if role == '2IC':
            query += " ORDER BY updated_at DESC"
            cursor.execute(query)

        # Company-level users → restricted to own company
        else:
            query += " AND company = %s ORDER BY updated_at DESC"
            cursor.execute(query, (company,))

        data = cursor.fetchall()
        print(data)
        return jsonify({
            "data": data
        }), 200

    except Exception as e:
        print("FETCH REJECTED ERROR:", e)
        return jsonify({
            "data": []
        }), 500

    finally:
        cursor.close()
        conn.close()







@leave_bp.route("/undo_rejected_leave", methods=["POST"])
def undo_reject_leave():
    data = request.get_json()
    leave_id = data.get("leave_id")
    print("this is leave id",leave_id)
    if not leave_id:
        return jsonify({"message": "Leave ID missing"}), 400

    user = require_login()
    current_user_role = user['role']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    

    try:
        # 1️⃣ Ensure leave exists & is rejected
        cursor.execute("""
            SELECT id
            FROM leave_status_info
            WHERE id = %s AND request_status like '%Rejected at%'
        """, (leave_id,))
        leave = cursor.fetchone()

        if not leave:
            return jsonify({"message": "Rejected leave not found"}), 404

        # 2️⃣ Build role-based pending status
        sent_request_to = current_user_role
        request_status = f"Pending at {current_user_role}"

        # 3️⃣ Undo rejection
        cursor.execute("""
            UPDATE leave_status_info
            SET
                request_sent_to = %s,
                request_status = %s,
                rejected_date = NULL,
                reject_reason = NULL,
                updated_at = NOW()
            WHERE id = %s
        """, (sent_request_to, request_status, leave_id))

        conn.commit()

        return jsonify({"message": "Leave moved back to pending"}), 200

    except Exception as e:
        conn.rollback()
        print("UNDO ERROR:", e)
        return jsonify({"message": "Server error"}), 500

    finally:
        cursor.close()
        conn.close()







@leave_bp.route("/rejected_leaves", methods=["GET"])
def co_rejected_leaves():
    print("in this routed route")
    user = require_login()  # get current logged-in user
    if user['role'] != 'CO':
        return jsonify({"message": "Unauthorized"}), 403

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Fetch leaves that were rejected
        cursor.execute("""
            SELECT 
                id,
                army_number,
                name,
                leave_type,
                leave_days,
                reject_reason,
                request_status,
                updated_at
            FROM leave_status_info
            WHERE request_status = 'Rejected at OC' 
            ORDER BY updated_at DESC
        """)

        leaves = cursor.fetchall()
        return jsonify({"data": leaves}), 200

    except Exception as e:
        print("Error fetching CO rejected leaves:", e)
        return jsonify({"message": "Server error"}), 500

    finally:
        cursor.close()
        conn.close()







@leave_bp.route("/get_leave_for_co/<int:leave_id>", methods=["GET"])
def get_leave(leave_id):
    user = require_login()
    if user['role'] != 'CO':
        return jsonify({"message": "Unauthorized"}), 403

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT id, army_number, name, leave_type, leave_days, from_date, to_date,
                   prefix_date, suffix_date, prefix_days, suffix_days,
                   leave_reason, reject_reason, request_status
            FROM leave_status_info
            WHERE id = %s
        """, (leave_id,))
        leave = cursor.fetchone()
        if not leave:
            return jsonify({"message": "Leave not found"}), 404

        return jsonify({"data": leave}), 200

    except Exception as e:
        print("Error fetching leave details:", e)
        return jsonify({"message": "Server error"}), 500

    finally:
        cursor.close()
        conn.close()
