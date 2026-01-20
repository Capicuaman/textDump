Transferring credentials between n8n instances requires exporting them from the source (often decrypted for compatibility), securely transferring the file, and importing into the target. This process works best with Docker setups common in n8n deployments, using CLI commands inside containers. Copying the encryption key from the source instance's `.n8n/config` file to the target ensures credentials decrypt properly, avoiding authentication failures.[1][2]

## Export Credentials (Source Instance)
Run these commands on the source server, replacing `n8n_container_name` with your actual container name (check via `docker ps`).[2][1]

- Export decrypted credentials: `docker exec -u node -it n8n_container_name n8n export:credentials --all --decrypted --output=/home/node/credentials.json`[2]
- Copy file out of container: `docker cp n8n_container_name:/home/node/credentials.json ./credentials.json`[1]
- Securely transfer: `scp credentials.json user@target-server:/path/to/destination` (use SSH/SCP; delete after use)[1][2]

## Copy Encryption Key
Locate the source `.n8n/config` file (often in `/home/node/.n8n/config` inside Docker or mounted volume).[2][1]

- Copy the `encryptionKey` value to the target's `.n8n/config` (create if missing).[1]
- Restart the target n8n container after updating: `docker restart n8n_container_name`.[2]

## Import Credentials (Target Instance)
On the target server, copy the file into the container and import.[1][2]

- Copy into container: `docker cp credentials.json n8n_container_name:/home/node/credentials.json`
- Import: `docker exec -u node -it n8n_container_name n8n import:credentials --input=/home/node/credentials.json`[1]
- Existing credentials with matching IDs get overwritten; edit JSON IDs to avoid conflicts if needed.[2]

## Alternatives
- **Full backup**: Archive and restore the entire `.n8n` folder (includes workflows/settings), but requires matching encryption key.[2]
- **n8n workflows**: Use pre-built ones like credential transfer templates from n8n.io for API-based moves.[1]

[1](https://n8n.io/workflows/2521-transfer-credentials-to-other-n8n-instances-using-a-multi-form/)
[2](https://www.youtube.com/watch?v=rLe2FKWoHSQ)
[3](https://n8n.io/workflows/8620-transfer-workflows-with-credentials-and-sub-workflow-management-between-n8n-instances/)
[4](https://www.youtube.com/watch?v=DsGZ54ZjBqo)
[5](https://devsnit.com/en/n8n-workflows-and-credentials-migration-tutorial/)
[6](https://community.n8n.io/t/credentials-export-import-bug/4399)
[7](https://community.n8n.io/t/export-credentials/22211)
[8](https://github.com/trezero/n8nMigration)
[9](https://help.ovhcloud.com/csm/en-vps-import-export-n8n?id=kb_article_view&sysparm_article=KB0072423)
[10](https://n8nworkflow.net/workflow/c53d7bd4-a7ee-5e57-59cf-c3f020d25f84)