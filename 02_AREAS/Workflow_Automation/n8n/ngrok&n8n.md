ngrok start n8n-ui n8n-webhooks

## What ngrok does

ngrok creates a secure tunnel from the public internet to a service running on your local machine. It gives you a temporary public URL (HTTP/HTTPS) that forwards traffic to a port on your host, handling TLS termination and NAT traversal automatically.

## Using ngrok inside Docker for n8n

Below is a step‑by‑step guide that works with the official **n8n** Docker image.

---

### 1. Create a Docker network (optional but recommended)

```bash
docker network create n8n-net
```

### 2. Run n8n

```bash
docker run -d \
  --name n8n \
  --network n8n-net \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=admin \
  -e N8N_BASIC_AUTH_PASSWORD=secret \
  -p 5678:5678 \
  n8nio/n8n:latest
```

* n8n listens on **port 5678** inside the container and is exposed on the same port on the host.

### 3. Run ngrok in a separate container

You can use the official ngrok image and attach it to the same network:

```bash
docker run -d \
  --name ngrok \
  --network n8n-net \
  -e NGROK_AUTHTOKEN=YOUR_NGROK_AUTH_TOKEN \
  -e NGROK_REGION=us \
  -p 4040:4040 \
  ngrok/ngrok:latest http n8n:5678
```

* `NGROK_AUTHTOKEN` is required for a stable tunnel and higher limits.  
* The `http n8n:5678` argument tells ngrok to forward traffic to the **n8n** container on port 5678.  
* Port 4040 exposes the ngrok web UI (optional) so you can view the tunnel URL at `http://localhost:4040`.

### 4. Retrieve the public URL

```bash
docker logs ngrok 2>&1 | grep -o 'https://[a-z0-9]*\.ngrok\.io'
```

Or open the UI at `http://localhost:4040` and copy the **Forwarding** URL shown there.  
That URL is now a public endpoint that forwards directly to your n8n instance.

### 5. Configure n8n webhook URLs (if needed)

If you use n8n webhooks, set the **Webhook URL** in n8n’s settings to the ngrok URL, e.g.:

```
https://abcd1234.ngrok.io/webhook/
```

You can also set it via environment variable when starting n8n:

```bash
-e WEBHOOK_URL=https://abcd1234.ngrok.io/
```

---

## Quick‑start Docker‑Compose example

If you prefer a single file, here’s a minimal `docker-compose.yml` that spins up both services:

```yaml
version: "3.8"

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=secret
    ports:
      - "5678:5678"

  ngrok:
    image: ngrok/ngrok:latest
    container_name: ngrok
    environment:
      - NGROK_AUTHTOKEN=${NGROK_AUTHTOKEN}
      - NGROK_REGION=us
    command: http n8n:5678
    ports:
      - "4040:4040"
    depends_on:
      - n8n
```

Run with:

```bash
NGROK_AUTHTOKEN=your_token docker-compose up -d
```

The public URL appears in the ngrok logs or at `http://localhost:4040`.

---  

With this setup, **ngrok** securely exposes your **n8n** workflow automation to the internet without opening any ports on your host firewall.

```yaml
version: "3.8"

services:
  n8n:
    image: n8nio/n8n:1.115.3
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    volumes:
      - ~/.n8n:/home/node/.n8n
    environment:
      - N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
      - WEBHOOK_URL=https://ideaopedia.ngrok-free.app
      - DB_SQLITE_POOL_SIZE=5
      - N8N_RUNNERS_ENABLED=true
      - N8N_BLOCK_ENV_ACCESS_IN_NODE=false
      - N8N_GIT_NODE_DISABLE_BARE_REPOS=true
      # (optional) basic auth – remove if you don’t need it
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=secret

  ngrok:
    image: ngrok/ngrok:latest
    container_name: ngrok
    restart: unless-stopped
    environment:
      - NGROK_AUTHTOKEN=${NGROK_AUTHTOKEN}   # set in .env or export beforehand
      - NGROK_REGION=us
    command: http n8n:5678
    ports:
      - "4040:4040"          # ngrok web UI (optional)
    depends_on:
      - n8n
```