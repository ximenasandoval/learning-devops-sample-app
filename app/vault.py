import hvac
import os


client = hvac.Client()

client.auth.userpass.login(
    username=os.environ.get("VAULT_USR"),
    password=os.environ.get("VAULT_PASSWORD"),
)

mount = client.secrets.kv.v2.read_secret_version(
    mount_point='kv', path=os.environ.get("VAULT_PATH"))

# Write file
f = open("env", "w")
for v in list(mount['data']['data'].keys()):
    f.write(f"{v}={mount['data']['data'][v]} \n")

f.close()
