from imports import *

chat_bp = Blueprint('chat_bp', __name__, url_prefix='/chat')

@chat_bp.route("/users")
def chat_users():
    print("in this route of the page")
    q = request.args.get("q", "")
    user = require_login()
    current_user_id = user['user_id']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if q:
        cursor.execute("""
            SELECT 
                u.id, 
                u.username,
                COUNT(m.id) as unread_count
            FROM users u
            LEFT JOIN messages m ON m.sender_id = u.id 
                AND m.receiver_id = %s 
                AND m.status = 'sent'
            WHERE u.username LIKE %s AND u.id != %s
            GROUP BY u.id, u.username
            ORDER BY unread_count DESC, u.username
        """, (current_user_id, f"%{q}%", current_user_id))
    else:
        cursor.execute("""
            SELECT 
                u.id, 
                u.username,
                COUNT(m.id) as unread_count
            FROM users u
            LEFT JOIN messages m ON m.sender_id = u.id 
                AND m.receiver_id = %s 
                AND m.status = 'sent'
            WHERE u.id != %s
            GROUP BY u.id, u.username
            ORDER BY unread_count DESC, u.username
        """, (current_user_id, current_user_id))

    users = cursor.fetchall()
    cursor.close()
    conn.close()

    return jsonify(users)

@chat_bp.route("/me", methods=["GET"])
def get_current_user():
    user = require_login()
    user_id = user['user_id']
    if not user_id:
        return jsonify({"id": None}), 401

    return jsonify({"id": user_id})


@chat_bp.route("/messages/<int:receiver_id>")
def chat_messages(receiver_id):
    user = require_login()
    sender_id = user['user_id']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch all messages between sender and receiver
    cursor.execute("""
        SELECT id, sender_id, receiver_id, message, created_at, status
        FROM messages
        WHERE 
          (sender_id = %s AND receiver_id = %s)
          OR
          (sender_id = %s AND receiver_id = %s)
        ORDER BY created_at
    """, (sender_id, receiver_id, receiver_id, sender_id))
    
    messages = cursor.fetchall()

    # Mark messages as read (where current user is receiver and status is 'sent')
    cursor.execute("""
        UPDATE messages
        SET status = 'read'
        WHERE receiver_id = %s 
          AND sender_id = %s 
          AND status = 'sent'
    """, (sender_id, receiver_id))
    
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify(messages)


@chat_bp.route("/messages", methods=["POST"])
def send_message():
    user = require_login()
    sender_id = user['user_id']

    data = request.get_json()
    receiver_id = data.get("receiver_id")
    message = data.get("message", "").strip()

    if not receiver_id or not message:
        return jsonify({"error": "Missing receiver_id or message"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO messages (sender_id, receiver_id, message, created_at, status)
        VALUES (%s, %s, %s, NOW(), 'sent')
    """, (sender_id, receiver_id, message))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"success": True})




@chat_bp.route("/unread-count", methods=["GET"])
def get_unread_count():
    user = require_login()
    user_id = user['user_id']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Count unread messages where current user is the receiver
    cursor.execute("""
        SELECT COUNT(*) as unread_count
        FROM messages
        WHERE receiver_id = %s AND status = 'sent'
    """, (user_id,))
    
    result = cursor.fetchone()
    cursor.close()
    conn.close()

    return jsonify({"unread_count": result['unread_count']})