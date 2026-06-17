import boto3
import json
import oracledb

# Read Master Secret
client = boto3.client(
    "secretsmanager",
    region_name="us-east-1"
)

secret = client.get_secret_value(SecretId = "satwik/oracle-rds/master_credentials")

data = json.loads(secret["SecretString"])

params = oracledb.ConnectParams(
    host=data["endpoint"],
    port=int(data["port"]),
    service_name=data["database_name"]
)

conn = oracledb.connect(
    user=data["master_username"],
    password=data["password"],
    params=params
)

cursor = conn.cursor()

users = ["randam", "rwx", "read"]

for user in users:
    secret = f"satwik/oracle-rds/{user}"
    try:
        cursor.execute(
            f"DROP USER {user} CASCADE"
        )
        print(f"FROM DATABASE: {user} deleted")
        client.delete_secret(SecretId=secret,
                            ForceDeleteWithoutRecovery=True)
        print(f"FROM AWS SECRET: {secret} deleted")

    except Exception as e:
        print(f"{user} not found")
        print(e)

conn.commit()
cursor.close()
conn.close()

print("Cleanup completed")