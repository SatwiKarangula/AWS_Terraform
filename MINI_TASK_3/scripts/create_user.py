import boto3
import json
import secrets
import string
import oracledb

# Read Master Secret
client = boto3.client( "secretsmanager", region_name = "us-east-1")

secret = client.get_secret_value(SecretId = "satwik/oracle-rds/master_credentials")

data = json.loads(secret["SecretString"])

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

# Password Generator
def generate_password(length=16):
    chars = string.ascii_letters + string.digits + "!@#$%"
    return "".join(
        secrets.choice(chars)
        for _ in range(length)
    )

# Users
users = {
    "randam": "ADMIN",
    "rwx": "RWX",
    "read": "READ"
}

for user, access in users.items():

    password = generate_password()
    cursor.execute(
        f'CREATE USER {user} IDENTIFIED BY "{password}"'
    )

    # Grants
    if access == "ADMIN":
        cursor.execute(
            f"GRANT DBA TO {user}"
        )

    elif access == "RWX":
        cursor.execute(
            f"GRANT CONNECT, RESOURCE TO {user}"
        )

    else:
        cursor.execute(
            f"GRANT CONNECT TO {user}"
        )

    # Store Secret
    client.create_secret(
        Name=f"satwik/oracle-rds/{user}",
        SecretString=json.dumps({
            "username": user,
            "password": password,
            "access_level": access
        }),
        Tags=[
            {"Key": "Name", "Value": "Satwik"},
            {"Key": "Role", "Value": "Intern"},
            {"Key": "AccessLevel", "Value": access}
        ]
    )

    print(f"{user} created")

connection .commit()
connection.close()

print("All users and secrets created successfully") 

