# content_module.py
from db_config import get_connection
from push_notification import push_to_user
import datetime

def create_notification(user_id, title, message):
    conn = get_connection()
    cur = conn.cursor()
    try:
        created_at = datetime.datetime.now()
        cur.execute("""
            INSERT INTO notifications (user_id, title, message, created_at, status)
            VALUES (%s, %s, %s, %s, 'NEW')
        """, (user_id, title, message, created_at))
        conn.commit()
        print("✅ Notification created successfully.")
    except Exception as e:
        conn.rollback()
        print("❌ Error creating notification:", e)
    finally:
        conn.close()

def send_notification(user_id):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("SELECT id, title, message FROM notifications WHERE user_id=%s AND status='NEW'", (user_id,))
        rows = cur.fetchall()
        if not rows:
            print("No new notifications.")
            return
        
        for (nid, title, message) in rows:
            push_to_user(user_id, title, message)
            cur.execute("UPDATE notifications SET status='SENT' WHERE id=%s", (nid,))
        
        conn.commit()
        print("✅ Notifications sent successfully.")
    except Exception as e:
        conn.rollback()
        print("❌ Error sending notifications:", e)
    finally:
        conn.close()
