from imports import *

oncourses_bp = Blueprint('oncourses_bp', __name__, url_prefix='/oncourses')




@oncourses_bp.route('/add_on_course', methods=['POST'])
def add_on_course():
    data = request.get_json()

    army_number = data.get('army_number')
    course_name = data.get('course_name')
    institute_name = data.get('institute_name')
    course_starting_date = data.get('course_starting_date')
    course_end_date = data.get('course_end_date')

    # Validate required fields
    if not all([army_number, course_name, institute_name, course_starting_date, course_end_date]):
        return jsonify({"status": "error", "message": "Missing required fields"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        query = """
            INSERT INTO candidate_on_courses (
                army_number,
                course_starting_date,
                course_end_date,
                course_name,
                institute_name
            ) VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(query, (
            army_number,
            course_starting_date,
            course_end_date,
            course_name,
            institute_name
        ))
        conn.commit()
        return jsonify({"status": "success"}), 200
    except Exception as e:
        conn.rollback()
        print(f"Error adding on course: {e}")
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cursor.close()
        conn.close()





