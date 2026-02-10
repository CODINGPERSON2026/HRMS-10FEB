from imports import *

oncourses_bp = Blueprint('oncourses_bp', __name__, url_prefix='/oncourses')




@oncourses_bp.route('/add_on_course', methods=['POST'])
def add_on_course():
    data = request.get_json()

    army_number = data['army_number']
    rank = data['rank']
    name = data['name']
    course_name = data['course_name']
    institute_name = data['institute_name']
    course_starting_date = data['course_starting_date']
    course_end_date = data['course_end_date']

    conn = get_db_connection()
    cursor =conn.cursor()
    query = """
        INSERT INTO candidate_on_courses (
            army_number,
            rank,
            name,
            course_starting_date,
            course_end_date,
            course_name,
            institute_name
        ) VALUES (%s, %s, %s, %s, %s,%s,%s)
    """
    cursor.execute(query, (
        army_number,
        rank,
        name,
        course_starting_date,
        course_end_date,
        course_name,
        institute_name
    ))
    conn.commit()
    cursor.close()

    return jsonify({"status": "success"})





