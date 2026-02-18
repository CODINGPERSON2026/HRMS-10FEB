# schema.py
"""
HRMS Database Schema Definition
Contains complete structure of users and personnel tables
"""

# Users table schema
COMPLETE_SCHEMA = """
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

