# schema.py
"""
HRMS Database Schema Definition
Contains complete structure of users and personnel tables
"""

# Users table schema
USERS_SCHEMA = """
Table: users
Purpose: Stores system login and profile information for HRMS users.
Columns:
- id (int, primary key, auto increment)
- username (varchar(100), unique username for login)
- email (varchar(150), user email address)
- password (varchar(255), encrypted password - NEVER SELECT THIS)
- role (varchar(50), user role: admin, officer, clerk, etc.) 
- created_at (timestamp, account creation date)
- company (varchar(50), company assigned to user)
- army_number (varchar(50), may be NULL for officers without personnel records)
"""

# Personnel table schema - Simplified soldier information
PERSONNEL_SCHEMA = """
Table: personnel
Purpose: Stores essential personnel records for soldiers/unit members (JCOs, NCOs, Other `rank`s).
Note: Commissioned Officers (CO, 2IC, Adjutant, OC) exist ONLY in users table.

Primary Key: id (int, auto increment)
Unique Identifier: army_number (varchar(100))

Columns:
- army_number: varchar(100) - Unique army identifier (Primary identifier)
- `rank`: varchar(100) - Military `rank` (JCO, NCO, Sepoy, Havildar, etc.) - NO COMMISSIONED OFFICERS
- company: varchar(100) - Assigned company (1 company, 2 company, HQ company, Center)
- onleave_status: tinyint(1) - On leave status (1 = On Leave, 0 = Not on Leave)
- detachment_status: tinyint(1) - On detachment status (1 = On Detachment, 0 = Not on Detachment)

Important: This table contains ONLY JCOs, NCOs, and Other `rank`s. 
Commissioned Officers (CO, 2IC, Adjutant, OC) are stored ONLY in users table.
"""

# Complete database schema with relationships
COMPLETE_SCHEMA = f"""
DATABASE SCHEMA:

{USERS_SCHEMA}

{PERSONNEL_SCHEMA}

=== IMPORTANT DISTINCTION ===
- Commissioned Officers (CO, 2IC, ADJUTANT, OC) exist ONLY in the users table
- JCOs, NCOs, and Other `rank`s exist in the personnel table
- Some personnel may have corresponding user accounts for system access
- Users without personnel records are typically officers or admin staff

=== RELATIONSHIPS ===
- users.army_number may reference personnel.army_number (optional)
- If a user has an army_number, they have a corresponding personnel record (JCO/NCO/OR)
- If a user has NULL army_number, they are an officer or admin without personnel record

=== COMMON QUERY PATTERNS ===

1. Get all soldiers (JCOs, NCOs, ORs) in a company:
   SELECT * FROM personnel WHERE company = 'company_name'

2. Get all officers (CO, 2IC, Adjutant, OC) in a company:
   SELECT username, email, role, company 
   FROM users 
   WHERE role IN ('CO', '2IC', 'ADJUTANT', 'OC') AND company = 'company_name'

3. Get JCOs by `rank`:
   SELECT * FROM personnel WHERE `rank` = 'JCO'

4. Get soldiers on leave:
   SELECT army_number, `rank`, company FROM personnel WHERE onleave_status = 1

5. Get soldiers on detachment:
   SELECT army_number, `rank`, company FROM personnel WHERE detachment_status = 1

6. Get ALL unit personnel (officers + soldiers) in a company:
   -- Officers from users table
   SELECT username as name, role as `rank`, company, 'Officer' as type 
   FROM users WHERE role IN ('CO', '2IC', 'ADJUTANT', 'OC') AND company = 'company_name'
   UNION ALL
   -- Soldiers from personnel table
   SELECT name, `rank`, company, 'Soldier' as type 
   FROM personnel WHERE company = 'company_name'

7. Get soldiers with user accounts (JCOs/NCOs/ORs who can login):
   SELECT p.army_number, p.`rank`, p.company, u.username, u.email, u.role
   FROM personnel p
   JOIN users u ON p.army_number = u.army_number

8. Get officers without personnel records:
   SELECT username, email, role, company 
   FROM users 
   WHERE army_number IS NULL AND role IN ('CO', '2IC', 'ADJUTANT', 'OC')

9. Get company strength (officers + soldiers):
   SELECT 
     'Officers' as category,
     COUNT(*) as count 
   FROM users 
   WHERE role IN ('CO', '2IC', 'ADJUTANT', 'OC') AND company = 'company_name'
   UNION ALL
   SELECT 
     'Soldiers' as category,
     COUNT(*) as count 
   FROM personnel 
   WHERE company = 'company_name'

10. Find available personnel (not on leave, not on detachment):
    -- Available soldiers
    SELECT army_number, `rank`, company, 'Soldier' as type 
    FROM personnel 
    WHERE onleave_status = 0 AND detachment_status = 0 AND company = 'company_name'
    UNION ALL
    -- Officers (always considered available unless specified otherwise)
    SELECT username, role, company, 'Officer' as type 
    FROM users 
    WHERE role IN ('CO', '2IC', 'ADJUTANT', 'OC') AND company = 'company_name'

11. Get unit hierarchy:
    -- Commanding Officer
    SELECT username, role, company FROM users WHERE role = 'CO'
    -- Second in Command
    SELECT username, role, company FROM users WHERE role = '2IC'
    -- Adjutant
    SELECT username, role, company FROM users WHERE role = 'ADJUTANT'
    -- All JCOs
    SELECT name, `rank`, company FROM personnel WHERE `rank` = 'JCO'

12. Count total unit strength:
    SELECT 
        COUNT(CASE WHEN role IN ('CO', '2IC', 'ADJUTANT', 'OC') THEN 1 END) as total_officers,
        COUNT(CASE WHEN role NOT IN ('CO', '2IC', 'ADJUTANT', 'OC') THEN 1 END) as total_other_users,
        (SELECT COUNT(*) FROM personnel) as total_soldiers
    FROM users
"""

def get_schema_summary():
    """Return a brief summary of the database schema"""
    return """
HRMS Database Summary:
- Users table: All system users including Officers (CO, 2IC, ADJUTANT, OC) and other staff
- Personnel table: JCOs, NCOs, and Other `rank`s only (soldiers)
- Officers exist ONLY in users table with NULL army_number
- Soldiers may have corresponding user accounts if they need system access
"""

def get_table_columns(table_name):
    """Return list of columns for a specific table"""
    if table_name.lower() == 'users':
        return ['id', 'username', 'email', 'role', 'created_at', 'company', 'army_number']
    elif table_name.lower() == 'personnel':
        return ['army_number', 'rank', 'company', 'onleave_status', 'detachment_status']
    else:
        return []