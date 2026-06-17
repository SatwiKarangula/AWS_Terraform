# verify_users
import boto3
import json
import oracledb

# --------------------------------------------------
# Read Master Secret
# --------------------------------------------------

client = boto3.client( "secretsmanager", region_name = "us-east-1")

secret = client.get_secret_value(SecretId = "satwik/oracle-rds/master_credentials")
data = json.loads(secret["SecretString"])

# --------------------------------------------------
# Connect to Oracle
# --------------------------------------------------

params = oracledb.ConnectParams(
    host=data["endpoint"],
    port=int(data["port"]),
    service_name=data["database_name"]
)

connection = oracledb.connect(
    user=data["master_username"],
    password=data["password"],
    params=params
)

cursor = connection.cursor()

print("\n===================================")
print(" Oracle Connection Verification")
print("===================================")
print("Connected Successfully")

# --------------------------------------------------
# Verify Users Exist
# --------------------------------------------------

print("\n===================================")
print(" User Verification")
print("===================================")

cursor.execute("""
SELECT username, account_status
FROM dba_users
WHERE username IN ('RANDAM','RWX','READ')
ORDER BY username
""")

users = cursor.fetchall()

for user in users:
    print(
        f"Username: {user[0]} | Status: {user[1]}"
    )

# --------------------------------------------------
# Verify User Count
# --------------------------------------------------

print("\n===================================")
print(" User Count Verification")
print("===================================")

cursor.execute("""
SELECT COUNT(*)
FROM dba_users
WHERE username IN ('RANDAM','RWX','READ')
""")

count = cursor.fetchone()[0]

print(f"Total Users Found: {count}")

# --------------------------------------------------
# Verify Privileges
# --------------------------------------------------

print("\n===================================")
print(" Privilege Verification")
print("===================================")

cursor.execute("""
SELECT grantee, granted_role
FROM dba_role_privs
WHERE grantee IN ('RANDAM','RWX','READ')
ORDER BY grantee
""")

privileges = cursor.fetchall()

for privilege in privileges:
    print(
        f"User: {privilege[0]} | Role: {privilege[1]}"
    )

# --------------------------------------------------
# Verify Secrets Manager Secrets
# --------------------------------------------------

print("\n===================================")
print(" Secrets Verification")
print("===================================")

secret_names = [
    "satwik/oracle-rds/randam",
    "satwik/oracle-rds/rwx",
    "satwik/oracle-rds/read"
]

for secret_name in secret_names:

    try:

        client.describe_secret(
            SecretId=secret_name
        )

        print(
            f"Secret Found: {secret_name}"
        )

    except Exception:

        print(
            f"Secret Missing: {secret_name}"
        )

# --------------------------------------------------
# Close Connection
# --------------------------------------------------

cursor.close()
connection.close()

print("\n===================================")
print(" Verification Completed")
print("===================================")


'''

## Execute

```bash
python verify_users.py
```

## Expected Output

```text
===================================
 Oracle Connection Verification
===================================
Connected Successfully

===================================
 User Verification
===================================
Username: RANDAM | Status: OPEN
Username: READ  | Status: OPEN
Username: RWX   | Status: OPEN

===================================
 User Count Verification
===================================
Total Users Found: 3

===================================
 Privilege Verification
===================================
User: RANDAM | Role: DBA
User: READ  | Role: CONNECT
User: RWX   | Role: CONNECT
User: RWX   | Role: RESOURCE

===================================
 Secrets Verification
===================================
Secret Found: satwik/oracle-rds/RANDAM
Secret Found: satwik/oracle-rds/rwx
Secret Found: satwik/oracle-rds/read

===================================
 Verification Completed
===================================
'''
