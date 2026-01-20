# n8n + ngrok Docker Stack Setup

Complete guide for running n8n with ngrok in Docker for webhook development and testing.

## Overview

This setup provides:
- **n8n**: Self-hosted workflow automation platform
- **ngrok**: Secure tunnel for exposing local webhooks to the internet
- **Docker Compose**: Orchestrated multi-container setup
- **Persistent Data**: Volume mounts for data retention

## Prerequisites

```bash
# Install Docker and Docker Compose
docker --version
docker-compose --version

# Get ngrok authtoken from https://dashboard.ngrok.com/get-started/your-authtoken
```

## Docker Compose Configuration

### Basic Setup (docker-compose.yml)

```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=changeme
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - WEBHOOK_URL=http://localhost:5678/
      - GENERIC_TIMEZONE=America/Los_Angeles
      - TZ=America/Los_Angeles
    volumes:
      - n8n_data:/home/node/.n8n
      - ./n8n-local-files:/files
    networks:
      - n8n-network

  ngrok:
    image: ngrok/ngrok:latest
    container_name: ngrok
    restart: unless-stopped
    command:
      - "start"
      - "--all"
      - "--config"
      - "/etc/ngrok.yml"
    volumes:
      - ./ngrok.yml:/etc/ngrok.yml
    ports:
      - "4040:4040"  # ngrok web interface
    networks:
      - n8n-network
    depends_on:
      - n8n

volumes:
  n8n_data:
    driver: local

networks:
  n8n-network:
    driver: bridge
```

### ngrok Configuration (ngrok.yml)

Create `ngrok.yml` in the same directory:

```yaml
version: "2"
authtoken: YOUR_NGROK_AUTHTOKEN_HERE

tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    bind_tls: true
    inspect: true
```

## Advanced Setup with PostgreSQL

### docker-compose.production.yml

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: n8n_postgres
    restart: unless-stopped
    environment:
      - POSTGRES_USER=n8n
      - POSTGRES_PASSWORD=n8n_secure_password
      - POSTGRES_DB=n8n
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - n8n-network
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -h localhost -U n8n -d n8n']
      interval: 5s
      timeout: 5s
      retries: 10

  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=n8n_secure_password
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=secure_password_here
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://your-ngrok-url.ngrok-free.app/
      - GENERIC_TIMEZONE=America/Los_Angeles
      - TZ=America/Los_Angeles
      - N8N_LOG_LEVEL=info
      - N8N_ENCRYPTION_KEY=your_32_char_encryption_key_here
    volumes:
      - n8n_data:/home/node/.n8n
      - ./n8n-local-files:/files
    networks:
      - n8n-network
    depends_on:
      postgres:
        condition: service_healthy

  ngrok:
    image: ngrok/ngrok:latest
    container_name: ngrok
    restart: unless-stopped
    command:
      - "start"
      - "--all"
      - "--config"
      - "/etc/ngrok.yml"
    volumes:
      - ./ngrok.yml:/etc/ngrok.yml
    ports:
      - "4040:4040"
    networks:
      - n8n-network
    depends_on:
      - n8n

volumes:
  n8n_data:
    driver: local
  postgres_data:
    driver: local

networks:
  n8n-network:
    driver: bridge
```

## Setup Instructions

### 1. Create Project Directory

```bash
mkdir n8n-stack
cd n8n-stack
```

### 2. Create Configuration Files

```bash
# Create docker-compose.yml (copy from above)
nano docker-compose.yml

# Create ngrok.yml (copy from above)
nano ngrok.yml

# Create local files directory
mkdir n8n-local-files
```

### 3. Configure ngrok

```bash
# Get your authtoken from https://dashboard.ngrok.com/get-started/your-authtoken
# Replace YOUR_NGROK_AUTHTOKEN_HERE in ngrok.yml
nano ngrok.yml
```

### 4. Start the Stack

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Check status
docker-compose ps
```

### 5. Access Services

- **n8n Interface**: http://localhost:5678
- **ngrok Dashboard**: http://localhost:4040
- **Public Webhook URL**: Check ngrok dashboard for the public URL

### 6. Configure n8n Webhook URL

1. Go to ngrok dashboard: http://localhost:4040
2. Copy the public HTTPS URL (e.g., `https://abc123.ngrok-free.app`)
3. Update `WEBHOOK_URL` in docker-compose.yml
4. Restart n8n: `docker-compose restart n8n`

## Common Commands

```bash
# Start the stack
docker-compose up -d

# Stop the stack
docker-compose down

# Stop and remove volumes (CAUTION: deletes data)
docker-compose down -v

# View logs
docker-compose logs -f n8n
docker-compose logs -f ngrok

# Restart a service
docker-compose restart n8n

# Update to latest versions
docker-compose pull
docker-compose up -d

# Access n8n container shell
docker exec -it n8n sh

# Backup n8n data
docker run --rm -v n8n-stack_n8n_data:/data -v $(pwd):/backup alpine tar czf /backup/n8n-backup.tar.gz -C /data .

# Restore n8n data
docker run --rm -v n8n-stack_n8n_data:/data -v $(pwd):/backup alpine tar xzf /backup/n8n-backup.tar.gz -C /data
```

## Environment Variables Reference

### n8n Configuration

| Variable | Description | Example |
|----------|-------------|---------|
| `N8N_BASIC_AUTH_ACTIVE` | Enable basic authentication | `true` |
| `N8N_BASIC_AUTH_USER` | Username for basic auth | `admin` |
| `N8N_BASIC_AUTH_PASSWORD` | Password for basic auth | `secure_password` |
| `N8N_HOST` | Hostname for n8n | `localhost` or domain |
| `N8N_PORT` | Port for n8n | `5678` |
| `N8N_PROTOCOL` | Protocol (http/https) | `https` |
| `WEBHOOK_URL` | Public webhook URL | `https://abc.ngrok-free.app/` |
| `GENERIC_TIMEZONE` | Timezone for scheduling | `America/Los_Angeles` |
| `N8N_LOG_LEVEL` | Logging level | `info`, `debug`, `error` |
| `N8N_ENCRYPTION_KEY` | Encryption key for credentials | 32-character string |

### Database Configuration (PostgreSQL)

| Variable | Description | Example |
|----------|-------------|---------|
| `DB_TYPE` | Database type | `postgresdb` |
| `DB_POSTGRESDB_HOST` | PostgreSQL host | `postgres` |
| `DB_POSTGRESDB_PORT` | PostgreSQL port | `5432` |
| `DB_POSTGRESDB_DATABASE` | Database name | `n8n` |
| `DB_POSTGRESDB_USER` | Database user | `n8n` |
| `DB_POSTGRESDB_PASSWORD` | Database password | `secure_password` |

## ngrok Configuration Options

### Custom Subdomain (Paid Plan)

```yaml
tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    subdomain: my-n8n-instance
    bind_tls: true
```

### Custom Domain (Paid Plan)

```yaml
tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    hostname: n8n.yourdomain.com
    bind_tls: true
```

### Basic Authentication

```yaml
tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    auth: "username:password"
    bind_tls: true
```

### IP Restrictions (Paid Plan)

```yaml
tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    cidr_allow:
      - 192.168.1.0/24
      - 10.0.0.0/8
    bind_tls: true
```

## Webhook Testing Workflow

### 1. Create Webhook in n8n

1. Open n8n at http://localhost:5678
2. Create new workflow
3. Add "Webhook" trigger node
4. Set HTTP Method (GET/POST)
5. Copy the webhook URL
6. Replace `localhost:5678` with your ngrok URL from http://localhost:4040

### 2. Test Webhook

```bash
# Get ngrok public URL
curl http://localhost:4040/api/tunnels | jq '.tunnels[0].public_url'

# Test webhook (replace URL)
curl -X POST https://abc123.ngrok-free.app/webhook/your-webhook-path \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'
```

## Troubleshooting

### ngrok Not Connecting

```bash
# Check ngrok logs
docker-compose logs ngrok

# Verify authtoken
docker exec ngrok ngrok config check

# Test ngrok connectivity
docker exec ngrok ngrok version
```

### n8n Not Accessible

```bash
# Check n8n logs
docker-compose logs n8n

# Verify n8n is running
docker-compose ps

# Check port availability
netstat -tuln | grep 5678

# Restart n8n
docker-compose restart n8n
```

### Webhook Not Triggering

1. Check ngrok dashboard at http://localhost:4040 for incoming requests
2. Verify `WEBHOOK_URL` is set to ngrok public URL
3. Ensure webhook path matches in your external service
4. Check n8n execution logs
5. Verify ngrok tunnel is active

### Database Connection Issues

```bash
# Check PostgreSQL logs
docker-compose logs postgres

# Test database connection
docker exec n8n sh -c 'psql -h postgres -U n8n -d n8n -c "SELECT version();"'

# Restart services in order
docker-compose restart postgres
sleep 5
docker-compose restart n8n
```

## Production Considerations

### Security

1. **Change default credentials** in docker-compose.yml
2. **Use strong passwords** for PostgreSQL and n8n auth
3. **Set N8N_ENCRYPTION_KEY** to a random 32-character string
4. **Use ngrok auth** to protect your tunnel
5. **Enable HTTPS** with proper certificates (Traefik/Caddy)
6. **Restrict ngrok access** with IP whitelisting (paid plan)

### Performance

1. **Use PostgreSQL** instead of SQLite for production
2. **Increase container resources** if handling heavy workflows
3. **Monitor disk usage** for volume mounts
4. **Set up log rotation** to prevent disk space issues

### Backups

```bash
# Automated backup script
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups"

mkdir -p $BACKUP_DIR

# Backup n8n data
docker run --rm \
  -v n8n-stack_n8n_data:/data \
  -v $(pwd)/$BACKUP_DIR:/backup \
  alpine tar czf /backup/n8n-data-$DATE.tar.gz -C /data .

# Backup PostgreSQL
docker exec n8n_postgres pg_dump -U n8n n8n | gzip > $BACKUP_DIR/postgres-$DATE.sql.gz

echo "Backup completed: $DATE"
```

### Monitoring

```bash
# Monitor container health
docker-compose ps

# Watch logs in real-time
docker-compose logs -f

# Check resource usage
docker stats
```

## ngrok Alternatives

If you need production-ready tunneling:

1. **Cloudflare Tunnel** (free, production-ready)
2. **Tailscale** (free for personal use)
3. **localtunnel** (open source)
4. **Expose** (self-hosted)
5. **Custom VPS with reverse proxy** (Traefik/Caddy/Nginx)

## Resources

- **n8n Documentation**: https://docs.n8n.io/
- **ngrok Documentation**: https://ngrok.com/docs
- **Docker Compose**: https://docs.docker.com/compose/
- **n8n Community**: https://community.n8n.io/
- **ngrok Dashboard**: https://dashboard.ngrok.com/

## Quick Start Script

Save as `setup.sh`:

```bash
#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}n8n + ngrok Docker Stack Setup${NC}"

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Prompt for ngrok authtoken
read -p "Enter your ngrok authtoken: " NGROK_TOKEN

# Create directory structure
mkdir -p n8n-local-files

# Create ngrok.yml
cat > ngrok.yml <<EOF
version: "2"
authtoken: ${NGROK_TOKEN}

tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    bind_tls: true
    inspect: true
EOF

echo -e "${GREEN}Configuration created successfully!${NC}"
echo -e "${YELLOW}Starting docker stack...${NC}"

# Start services
docker-compose up -d

echo -e "${GREEN}Stack started!${NC}"
echo ""
echo "Access points:"
echo "  n8n: http://localhost:5678"
echo "  ngrok dashboard: http://localhost:4040"
echo ""
echo "Get your public webhook URL from: http://localhost:4040"
```

Make executable and run:

```bash
chmod +x setup.sh
./setup.sh
```