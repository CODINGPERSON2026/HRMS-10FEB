"""
HRMS Database Schema Definition
Contains complete structure of users and personnel tables
"""

# ==========================================================
# USERS TABLE SCHEMA
# ==========================================================


USERS_SCHEMA = """
Table: users
Purpose: Stores system login and profile information for HRMS users.



IMPORTANT:
This table contains:
1. Commissioned Officers (CO, OC, 2IC, ADJUTANT)
2. System roles (admin, clerk, NCO, JCO, CNCO etc.)
3. ONLY JCO ARE LINKED TO army_number in personnel table

Columns:
- id (int, primary key, auto increment)
- username (varchar(100), unique username for login)
- email (varchar(150), user email address)
- password (varchar(255), encrypted password - NEVER SELECT THIS)
- role (varchar(50), role examples below)
- created_at (timestamp, account creation date)
- company (varchar(100), assigned company)
- army_number (varchar(100), NULL for officers/admin,in this table its only for login)

ROLE VALUES MAY INCLUDE:
Commissioned Officers:
- 'CO'
- 'OC'
- '2IC'
- 'ADJUTANT'

System / Other Roles:
- 'admin'
- 'clerk'
- 'NCO'
- 'JCO'
- 'CNCO'
- etc.
"""

# ==========================================================
# PERSONNEL TABLE SCHEMA (ONLY SOLDIERS)
# ==========================================================
f'if question has (co,2ic,adjutant,JCO,S/JCO) query only {USERS_SCHEMA} '

PERSONNEL_SCHEMA = """
Table: personnel
Purpose: Stores ONLY soldier data (Subedar,Subedar Major,Naib Subedar NCOs, Other Ranks).

IMPORTANT:
Commissioned Officers (CO, OC, 2IC, ADJUTANT) DO NOT exist in this table .

Primary Key:
- id (int, auto increment)

Unique Identifier:
- army_number (varchar(100))

Columns:
- army_number: varchar(100) - Unique army identifier
- name: varchar(100) - Name of the soldier
- `rank`: varchar(100) - Military rank

VALID RANK VALUES INCLUDE:
- 'Subedar Major'
- 'Subedar'
- 'Naib Subedar'
- 'Havaldar'
- Other OR (Other Rank) categories

- company: varchar(100) - Assigned company
  Example values:
  '1 Company'
  '2 Company'
  'HQ Company'
  'Center'

- onleave_status: tinyint(1)
  1 = On Leave
  0 = Not on Leave

- detachment_status: tinyint(1)
  1 = On Detachment
  0 = Not on Detachment
"""

# ==========================================================
# COMPLETE DATABASE SCHEMA
# ==========================================================

COMPLETE_SCHEMA = f"""
DATABASE SCHEMA:

{USERS_SCHEMA}

{PERSONNEL_SCHEMA}

================ IMPORTANT DISTINCTION ================

1. Commissioned Officers (CO, OC, 2IC, ADJUTANT)
   → EXIST ONLY in users table
   → army_number is usually NULL

2. Soldiers (Subedar Major, Subedar, Naib Subedar, Havaldar, OR ranks)
   → EXIST ONLY in personnel table
   → Always have army_number

3. Some soldiers may ALSO have login accounts in users table
   → In that case users.army_number = personnel.army_number

4. If users.army_number IS NULL
   → That user is an officer or admin (not a soldier record)

=======================================================

================ COMMON QUERY PATTERNS ================

1. Get all soldiers in a company:
   SELECT * FROM personnel WHERE company = 'company_name'
2.WHO IS MAJ PRATEEK
 select * from users where username = 'Maj prateek' (if not found here then search personnel table as below)
   select name army_number `rank` from personnel where name = 'Major Prateek'
2. Get all officers in a company:
   SELECT username, email, role, company
   FROM users
   WHERE role IN ('CO', 'OC', '2IC', 'ADJUTANT')
   AND company = 'company_name'

3. Get soldiers by rank:
   SELECT `rank` FROM personnel 

4. Get soldiers on leave:
   SELECT army_number, name, `rank`, company
   FROM personnel
   WHERE onleave_status = 1

5. Get soldiers on detachment:
   SELECT army_number, name, `rank`, company
   FROM personnel
   WHERE detachment_status = 1

6. Get full company strength (Officers + Soldiers):
   -- Officers
   SELECT username as name, role as `rank`, company, 'Officer' as type
   FROM users
   WHERE role IN ('CO', 'OC', '2IC', 'ADJUTANT')
   AND company = 'company_name'

   UNION ALL

   -- Soldiers
   SELECT name, `rank`, company, 'Soldier' as type
   FROM personnel
   WHERE company = 'company_name'

7. Get soldiers who have login accounts:
   SELECT p.army_number, p.name, p.`rank`, p.company,
          u.username, u.email, u.role
   FROM personnel p
   JOIN users u ON p.army_number = u.army_number

8. Get officers only:
   SELECT username, role, company
   FROM users
   WHERE role IN ('CO', 'OC', '2IC', 'ADJUTANT')

9. Count total soldiers:
   SELECT COUNT(*) FROM personnel

10. Count officers:
   SELECT COUNT(*) FROM users
   WHERE role IN ('CO', 'OC', '2IC', 'ADJUTANT')

=======================================================
"""

# ==========================================================
# HELPER FUNCTIONS
# ==========================================================

def get_schema_summary():
    """Return a brief summary of the database schema"""
    return """
HRMS Database Summary:
- Users table: Officers (CO, OC, 2IC, ADJUTANT) + system users (admin, clerk, NCO, JCO, CNCO)
- Personnel table: ONLY soldiers (Subedar Major, Subedar, Naib Subedar, Havaldar, OR ranks)
- Officers exist ONLY in users table
- Soldiers exist ONLY in personnel table
- Soldiers may have login accounts linked via army_number
"""


def get_table_columns(table_name):
    """Return list of columns for a specific table"""
    if table_name.lower() == 'users':
        return [
            'id',
            'username',
            'email',
            'role',
            'created_at',
            'company',
            'army_number'
        ]
    elif table_name.lower() == 'personnel':
        return [
            'army_number',
            'name',
            'rank',
            'company',
            'onleave_status',
            'detachment_status'
        ]
    else:
        return []
