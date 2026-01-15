# n8n Backup and Error Handling Plan

**Created:** 2026-01-14
**Status:** Planning Phase
**Priority:** HIGH - Prevent workflow loss

---

## Overview

Comprehensive plan to protect n8n workflows from data loss and implement robust error handling. This plan addresses the critical need for backups after experiencing workflow loss and establishes monitoring systems for production workflows.

## Current n8n Setup

**Location:** Docker Compose configuration
**Data Persistence:** `~/.n8n` volume mount
**Key Workflows:**
- BILAN Social Media Content Generator (in progress)
- 12-project automation roadmap (planned)

**Reference Files:**
- Setup: `02_AREAS/Workflow_Automation/n8n/ngrok&n8n.md`
- Primer: `02_AREAS/Workflow_Automation/n8n/n8n_primer.md`
- BILAN Workflow: `01_PROJECTS/BILAN/MARKETING/n8n/SM-Posts/n8n_workflow_implementation.md`
- Roadmap: `01_PROJECTS/BILAN/00_INBOX/n8n/ai_n8n_automation_projects_roadmap.md`

---

## Phase 1: Immediate Backup Protection

### Task 1: Document Current Workflows and Export as JSON Backups

**Priority:** CRITICAL
**Complexity:** Easy
**Time Estimate:** 30 minutes

**Steps:**

1. **Access n8n UI:**
   ```bash
   # Check if n8n is running
   docker ps | grep n8n

   # If not running, start it
   cd /path/to/docker-compose/directory
   docker-compose up -d

   # Access at: http://localhost:5678
   ```

2. **Export Each Workflow:**
   - Open n8n at `http://localhost:5678`
   - For each workflow:
     - Open the workflow
     - Click the three-dot menu (⋮) in top right
     - Select "Download"
     - Save as: `[workflow-name]_[date].json`

3. **Create Backup Directory:**
   ```bash
   mkdir -p ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS
   mkdir -p ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/manual
   mkdir -p ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/automated
   ```

4. **Move Exported Files:**
   ```bash
   mv ~/Downloads/*.json ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/manual/
   ```

5. **Create Backup Inventory:**
   Create file: `BACKUPS/backup_inventory.md`
   ```markdown
   # n8n Workflow Backup Inventory

   ## Manual Backups

   | Workflow Name | Backup Date | File Name | Status | Notes |
   |--------------|-------------|-----------|--------|-------|
   | BILAN Social Media Generator | YYYY-MM-DD | bilan_sm_generator_2026-01-14.json | Active | Current production |
   | [workflow 2] | YYYY-MM-DD | [filename] | [status] | [notes] |

   ## Automated Backups

   Automated backup system to be configured in Phase 2.
   ```

**Success Criteria:**
- [ ] All active workflows exported as JSON
- [ ] Files organized in BACKUPS directory
- [ ] Backup inventory created and documented
- [ ] Backup files tested by importing into n8n (dry run)

---

### Task 2: Set Up Automated Workflow Backup System

**Priority:** HIGH
**Complexity:** Intermediate
**Time Estimate:** 2-3 hours

**Option A: Using n8n Workflow to Back Up Itself (Meta-workflow)**

Create an n8n workflow that exports all workflows automatically.

**Workflow Design:**
```
Schedule Trigger (Daily 3 AM)
  → HTTP Request (n8n API - Get All Workflows)
  → Loop Over Workflows
  → HTTP Request (Get Workflow JSON)
  → Write to File (Local or Cloud Storage)
  → Notification (Success/Failure)
```

**Implementation:**

1. **Enable n8n API Access:**

   Update your `docker-compose.yml`:
   ```yaml
   services:
     n8n:
       environment:
         - N8N_API_KEY=your_secure_api_key_here
         # Add to existing environment variables
   ```

   Restart n8n:
   ```bash
   docker-compose restart n8n
   ```

2. **Create Backup Workflow in n8n:**

   **Node 1: Schedule Trigger**
   - Cron: `0 3 * * *` (3 AM daily)
   - Name: "Daily Backup Trigger"

   **Node 2: HTTP Request - List Workflows**
   - Method: GET
   - URL: `http://n8n:5678/api/v1/workflows`
   - Headers:
     ```
     X-N8N-API-KEY: {{ $env.N8N_API_KEY }}
     ```

   **Node 3: Split In Batches**
   - Batch Size: 1
   - Loop over workflow items

   **Node 4: HTTP Request - Get Workflow Details**
   - Method: GET
   - URL: `http://n8n:5678/api/v1/workflows/{{ $json.id }}`
   - Headers:
     ```
     X-N8N-API-KEY: {{ $env.N8N_API_KEY }}
     ```

   **Node 5: Function - Format Backup**
   ```javascript
   const workflow = $input.first().json;
   const timestamp = new Date().toISOString().split('T')[0];

   return [{
     json: {
       filename: `${workflow.name.replace(/\s+/g, '_')}_${timestamp}.json`,
       content: JSON.stringify(workflow, null, 2),
       workflow_id: workflow.id,
       workflow_name: workflow.name,
       backup_date: timestamp
     }
   }];
   ```

   **Node 6: Write Binary File**
   - File Path: `/home/node/.n8n/backups/automated/{{ $json.filename }}`
   - Convert to Binary: Yes

   **Node 7: Aggregate All Results**

   **Node 8: Send Notification** (Email or Slack)
   - Subject: "n8n Daily Backup Complete"
   - Message: "Backed up {{ $json.count }} workflows successfully"

**Option B: Using Shell Script (Simpler)**

Create backup script: `~/scripts/n8n_backup.sh`

```bash
#!/bin/bash

# n8n Workflow Backup Script
# Usage: ./n8n_backup.sh

BACKUP_DIR="$HOME/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/automated"
N8N_DATA="$HOME/.n8n"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="n8n_backup_${TIMESTAMP}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create timestamped backup of entire .n8n directory
echo "Creating backup of n8n data directory..."
tar -czf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" -C "$HOME" .n8n

# Copy workflows.db (SQLite database containing all workflows)
echo "Backing up workflows database..."
cp "$N8N_DATA/database.sqlite" "$BACKUP_DIR/database_${TIMESTAMP}.sqlite"

# Keep only last 30 days of backups
echo "Cleaning up old backups (keeping last 30 days)..."
find "$BACKUP_DIR" -name "n8n_backup_*.tar.gz" -mtime +30 -delete
find "$BACKUP_DIR" -name "database_*.sqlite" -mtime +30 -delete

echo "Backup completed: ${BACKUP_NAME}.tar.gz"
echo "Backup location: $BACKUP_DIR"

# Optional: Log backup to inventory
echo "$(date) - Backup created: ${BACKUP_NAME}.tar.gz" >> "$BACKUP_DIR/../backup_log.txt"
```

**Set up cron job:**
```bash
# Make script executable
chmod +x ~/scripts/n8n_backup.sh

# Add to crontab (3 AM daily)
crontab -e
# Add line:
0 3 * * * /Users/ideaopedia/scripts/n8n_backup.sh >> /Users/ideaopedia/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/backup_cron.log 2>&1
```

**Success Criteria:**
- [ ] Automated backup system configured and tested
- [ ] Backups running daily without manual intervention
- [ ] Backup rotation configured (keep 30 days)
- [ ] Backup success notifications working

---

### Task 3: Create Git Repository for n8n Workflow Version Control

**Priority:** HIGH
**Complexity:** Easy
**Time Estimate:** 1 hour

**Steps:**

1. **Initialize Git Repository:**
   ```bash
   cd ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS
   git init
   ```

2. **Create .gitignore:**
   ```bash
   cat > .gitignore << 'EOF'
   # Ignore automated backup archives
   automated/*.tar.gz
   automated/*.sqlite

   # Keep JSON workflow exports
   !manual/*.json
   !automated/*.json

   # Ignore logs
   *.log

   # Ignore credentials (if accidentally exported)
   *credentials*.json
   *secrets*.json
   EOF
   ```

3. **Create README:**
   ```bash
   cat > README.md << 'EOF'
   # n8n Workflow Backups

   This repository contains version-controlled backups of all n8n workflows.

   ## Directory Structure

   - `manual/` - Manual workflow exports (JSON)
   - `automated/` - Automated daily backups
   - `backup_inventory.md` - Catalog of all backups

   ## Restore Instructions

   See: `../n8n_backup_and_error_handling_plan.md` (Task 7)

   ## Backup Schedule

   - **Manual exports:** On significant workflow changes
   - **Automated backups:** Daily at 3:00 AM
   - **Retention:** 30 days
   EOF
   ```

4. **Initial Commit:**
   ```bash
   git add .
   git commit -m "Initial commit: n8n workflow backup repository"
   ```

5. **Optional: Push to Remote Repository:**
   ```bash
   # Create GitHub repo (or GitLab, etc.)
   # Then:
   git remote add origin git@github.com:yourusername/n8n-backups.git
   git branch -M main
   git push -u origin main
   ```

6. **Set Up Automatic Commits:**

   Update backup script to include git commits:
   ```bash
   # Add to ~/scripts/n8n_backup.sh after backup creation:

   # Commit to Git
   cd "$BACKUP_DIR"
   git add -A
   git commit -m "Automated backup: ${TIMESTAMP}" || echo "No changes to commit"

   # Optional: Push to remote
   # git push origin main
   ```

**Success Criteria:**
- [ ] Git repository initialized
- [ ] Initial backups committed
- [ ] .gitignore properly configured
- [ ] Optional: Remote repository configured
- [ ] Automatic commits integrated with backup script

---

## Phase 2: Error Handling Implementation

### Task 4: Implement Error Handling in BILAN Social Media Workflow

**Priority:** HIGH
**Complexity:** Intermediate
**Time Estimate:** 2 hours

**Reference:** Your workflow design at `01_PROJECTS/BILAN/MARKETING/n8n/SM-Posts/n8n_workflow_implementation.md` already includes error handling design. Now implement it.

**Implementation Steps:**

1. **Add Error Trigger Node:**
   - Add new node: "Error Trigger"
   - Name: "Workflow Error Handler"
   - Settings:
     - ✓ Execute once per workflow
     - ✓ Continue on fail

2. **Add Error Processing Function:**

   Create Function node connected to Error Trigger:

   ```javascript
   // Error Analysis and Reporting Function
   const error = $input.first().json;
   const execution = $execution;

   // Extract error context
   const errorContext = {
     error_id: `error_${Date.now()}`,
     timestamp: new Date().toISOString(),
     workflow_name: execution.workflow.name,
     workflow_id: execution.workflow.id,
     execution_id: execution.id,
     node_name: error.node?.name || 'unknown',
     error_message: error.message,
     error_stack: error.stack,
     workflow_data: $input.all()[1]?.json || {}
   };

   // Categorize error type
   let errorType = 'unknown';
   let severity = 'medium';
   let retryRecommended = false;

   if (error.message.includes('429') || error.message.includes('rate limit')) {
     errorType = 'rate_limit';
     severity = 'low';
     retryRecommended = true;
   } else if (error.message.includes('401') || error.message.includes('unauthorized')) {
     errorType = 'authentication';
     severity = 'high';
     retryRecommended = false;
   } else if (error.message.includes('500') || error.message.includes('502')) {
     errorType = 'server_error';
     severity = 'medium';
     retryRecommended = true;
   } else if (error.message.includes('timeout')) {
     errorType = 'timeout';
     severity = 'medium';
     retryRecommended = true;
   } else if (error.message.includes('network')) {
     errorType = 'network';
     severity = 'high';
     retryRecommended = true;
   }

   // Resolution steps by error type
   const resolutionSteps = {
     rate_limit: [
       'Wait 60 seconds before retry',
       'Check Claude API usage dashboard',
       'Consider reducing request frequency',
       'Review rate limit tier'
     ],
     authentication: [
       'Verify Claude API key is valid and not expired',
       'Check n8n credentials configuration',
       'Ensure API key has proper permissions',
       'Regenerate API key if necessary'
     ],
     server_error: [
       'Check Claude API status page: https://status.anthropic.com',
       'Retry after 30-60 seconds',
       'If persistent, contact Claude support',
       'Check n8n logs for additional context'
     ],
     timeout: [
       'Increase HTTP request timeout setting',
       'Check network connectivity',
       'Reduce prompt complexity or length',
       'Consider splitting large requests'
     ],
     network: [
       'Verify internet connectivity',
       'Check Docker network configuration',
       'Restart ngrok tunnel if using webhooks',
       'Test connection to Claude API directly'
     ]
   };

   return [{
     json: {
       ...errorContext,
       error_type: errorType,
       severity: severity,
       retry_recommended: retryRecommended,
       resolution_steps: resolutionSteps[errorType] || ['Review error logs', 'Contact support'],
       notification_required: severity === 'high',
       alert_channels: severity === 'high' ? ['email', 'slack'] : ['log']
     }
   }];
   ```

3. **Add Error Notification Node:**

   Option A: Email notification (using n8n Email node)
   - To: your-email@example.com
   - Subject: `🚨 n8n Error: {{ $json.workflow_name }}`
   - Body:
   ```
   Error in n8n Workflow: {{ $json.workflow_name }}

   Error Type: {{ $json.error_type }}
   Severity: {{ $json.severity }}
   Timestamp: {{ $json.timestamp }}
   Node: {{ $json.node_name }}

   Error Message:
   {{ $json.error_message }}

   Resolution Steps:
   {{ $json.resolution_steps.join('\n') }}

   Retry Recommended: {{ $json.retry_recommended ? 'Yes' : 'No' }}

   Execution ID: {{ $json.execution_id }}
   Error ID: {{ $json.error_id }}
   ```

   Option B: Slack notification (if you use Slack)
   - Channel: #n8n-alerts
   - Message: Similar to email above

4. **Add Error Logging Node:**

   Write to File node:
   - File path: `/home/node/.n8n/logs/errors/{{ $json.error_id }}.json`
   - Content: `{{ JSON.stringify($json, null, 2) }}`

5. **Test Error Handling:**
   - Temporarily break the workflow (invalid API key)
   - Execute and verify error is caught
   - Check notification received
   - Restore valid configuration

**Success Criteria:**
- [ ] Error Trigger node added and configured
- [ ] Error processing function implemented
- [ ] Notifications configured and tested
- [ ] Error logs being written
- [ ] Error handling tested with multiple error scenarios

---

### Task 5: Configure n8n Error Workflow for Notifications

**Priority:** MEDIUM
**Complexity:** Intermediate
**Time Estimate:** 2 hours

Create a centralized error handling workflow that all other workflows can use.

**Workflow Design:**

```
Webhook Trigger (Error Receiver)
  → Error Analysis Function
  → If (Severity Check)
    ├─→ High Severity: Send Email + Slack + Log
    ├─→ Medium Severity: Send Slack + Log
    └─→ Low Severity: Log Only
  → Update Error Dashboard (Google Sheets/Airtable)
```

**Implementation:**

1. **Create New Workflow: "Central Error Handler"**

2. **Add Webhook Trigger:**
   - Name: "Error Webhook Receiver"
   - Method: POST
   - Path: `error-handler`
   - Response: JSON

3. **Add Error Analysis Function:**
   ```javascript
   const errorData = $input.first().json;

   // Enrich error data
   const enrichedError = {
     ...errorData,
     received_at: new Date().toISOString(),
     error_hash: require('crypto').createHash('md5').update(errorData.error_message).digest('hex').substring(0, 8),
     similar_errors_likely: false // Can check against recent errors
   };

   return [{ json: enrichedError }];
   ```

4. **Add IF Node for Severity Routing:**
   - Condition: `{{ $json.severity === 'high' }}`
   - True branch: High severity actions
   - False branch: Check medium severity

5. **High Severity Branch:**
   - Send Email
   - Send Slack (if configured)
   - Write to Error Log

6. **Medium Severity Branch:**
   - Send Slack notification
   - Write to Error Log

7. **Low Severity Branch:**
   - Write to Error Log only

8. **Add Error Dashboard Logging:**

   Google Sheets node (or Airtable):
   - Spreadsheet: "n8n Error Dashboard"
   - Sheet: "Errors"
   - Operation: Append
   - Columns:
     - Timestamp
     - Workflow Name
     - Error Type
     - Severity
     - Error Message
     - Resolution Status
     - Error ID

9. **Update Existing Workflows to Use Central Handler:**

   In BILAN workflow error handler, add HTTP Request node:
   - Method: POST
   - URL: `http://n8n:5678/webhook/error-handler`
   - Body: `{{ JSON.stringify($json) }}`

**Success Criteria:**
- [ ] Central error handler workflow created
- [ ] Multiple notification channels configured
- [ ] Error dashboard (Google Sheets) set up
- [ ] Existing workflows updated to use central handler
- [ ] Tested with various error severities

---

### Task 6: Set Up Persistent Volume Backups for n8n Docker Data

**Priority:** CRITICAL
**Complexity:** Easy
**Time Estimate:** 1 hour

Your `~/.n8n` directory contains everything. Back it up properly.

**Steps:**

1. **Verify Current Volume Mount:**
   ```bash
   # Check docker-compose.yml
   grep -A 5 "volumes:" ~/path/to/docker-compose.yml

   # Should show:
   # volumes:
   #   - ~/.n8n:/home/node/.n8n
   ```

2. **Create Backup Script for Docker Volume:**

   File: `~/scripts/n8n_docker_volume_backup.sh`

   ```bash
   #!/bin/bash

   # n8n Docker Volume Backup Script

   BACKUP_DIR="$HOME/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/docker_volumes"
   N8N_DATA="$HOME/.n8n"
   TIMESTAMP=$(date +%Y%m%d_%H%M%S)
   BACKUP_NAME="n8n_volume_${TIMESTAMP}"

   # Create backup directory
   mkdir -p "$BACKUP_DIR"

   echo "Starting n8n volume backup..."

   # Stop n8n (optional but safer)
   read -p "Stop n8n container for clean backup? (y/n): " -n 1 -r
   echo
   if [[ $REPLY =~ ^[Yy]$ ]]; then
       docker-compose -f /path/to/docker-compose.yml stop n8n
       STOPPED=true
   fi

   # Backup entire .n8n directory
   tar -czf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" \
       -C "$HOME" \
       --exclude='.n8n/logs' \
       --exclude='.n8n/cache' \
       .n8n

   # Restart n8n if it was stopped
   if [ "$STOPPED" = true ]; then
       docker-compose -f /path/to/docker-compose.yml start n8n
   fi

   # Calculate backup size
   BACKUP_SIZE=$(du -h "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" | cut -f1)

   echo "✓ Backup completed: ${BACKUP_NAME}.tar.gz"
   echo "✓ Size: $BACKUP_SIZE"
   echo "✓ Location: $BACKUP_DIR"

   # Keep only last 14 volume backups (they're larger)
   find "$BACKUP_DIR" -name "n8n_volume_*.tar.gz" -mtime +14 -delete

   # Log backup
   echo "$(date) - Volume backup: ${BACKUP_NAME}.tar.gz ($BACKUP_SIZE)" >> "$BACKUP_DIR/../backup_log.txt"
   ```

3. **Set Up Weekly Volume Backup:**
   ```bash
   chmod +x ~/scripts/n8n_docker_volume_backup.sh

   # Add to crontab (Sunday 2 AM weekly)
   crontab -e
   # Add:
   0 2 * * 0 /Users/ideaopedia/scripts/n8n_docker_volume_backup.sh >> /Users/ideaopedia/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/volume_backup.log 2>&1
   ```

4. **Test Backup:**
   ```bash
   ~/scripts/n8n_docker_volume_backup.sh
   ```

5. **Document Restoration Process:**

   Create: `BACKUPS/RESTORE_INSTRUCTIONS.md`
   ```markdown
   # n8n Volume Restore Instructions

   ## Full Volume Restore

   1. Stop n8n:
      ```bash
      docker-compose down
      ```

   2. Backup current data (if any):
      ```bash
      mv ~/.n8n ~/.n8n.old
      ```

   3. Extract backup:
      ```bash
      tar -xzf /path/to/n8n_volume_YYYYMMDD_HHMMSS.tar.gz -C ~/
      ```

   4. Verify permissions:
      ```bash
      ls -la ~/.n8n
      ```

   5. Restart n8n:
      ```bash
      docker-compose up -d
      ```

   6. Verify workflows in UI:
      - Open http://localhost:5678
      - Check all workflows present
      - Test execute a simple workflow
   ```

**Success Criteria:**
- [ ] Volume backup script created and tested
- [ ] Weekly automated backups scheduled
- [ ] Restoration instructions documented
- [ ] Test restore performed successfully
- [ ] Backup retention policy configured (14 days)

---

## Phase 3: Recovery & Monitoring

### Task 7: Create Recovery Documentation with Restore Procedures

**Priority:** HIGH
**Complexity:** Easy
**Time Estimate:** 1 hour

**Steps:**

Create comprehensive recovery guide: `DISASTER_RECOVERY_GUIDE.md`

```markdown
# n8n Disaster Recovery Guide

## Quick Recovery Checklist

- [ ] Docker and Docker Compose installed
- [ ] Backup files located and accessible
- [ ] Credentials documented and available
- [ ] ngrok auth token available
- [ ] Network connectivity verified

## Scenario 1: Lost Single Workflow

**Symptoms:** One workflow disappeared or corrupted

**Recovery:**

1. Navigate to backups:
   ```bash
   cd ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS
   ```

2. Find latest workflow backup:
   ```bash
   ls -lt manual/ | head -10
   # or
   ls -lt automated/ | head -10
   ```

3. Open n8n UI: http://localhost:5678

4. Import workflow:
   - Click "Add Workflow"
   - Click "Import from File"
   - Select workflow JSON file
   - Verify credentials are linked
   - Test execute
   - Activate workflow

## Scenario 2: Complete n8n Instance Loss

**Symptoms:** Docker container destroyed, .n8n directory lost

**Recovery:**

1. **Restore Docker Compose setup:**
   ```bash
   cd ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n

   # Verify docker-compose.yml exists
   cat ngrok&n8n.md  # Contains docker-compose configuration

   # Create docker-compose.yml from documentation
   # (Extract YAML from ngrok&n8n.md lines 121-156)
   ```

2. **Set environment variables:**
   ```bash
   export NGROK_AUTHTOKEN=your_token_here
   ```

3. **Restore .n8n directory from backup:**
   ```bash
   # Find latest volume backup
   ls -lt BACKUPS/docker_volumes/

   # Extract
   tar -xzf BACKUPS/docker_volumes/n8n_volume_YYYYMMDD_HHMMSS.tar.gz -C ~/
   ```

4. **Start n8n:**
   ```bash
   docker-compose up -d
   ```

5. **Verify recovery:**
   - Access http://localhost:5678
   - Check all workflows present
   - Verify credentials configured
   - Test workflow execution
   - Check ngrok tunnel: http://localhost:4040

6. **If volume backup not available, restore from workflow JSONs:**
   ```bash
   # Start fresh n8n
   docker-compose up -d

   # Import each workflow manually from JSON backups
   # Through UI: Add Workflow → Import from File
   ```

7. **Restore credentials:**
   - Re-enter API keys:
     - Claude API key
     - Google OAuth credentials
     - Any other service credentials
   - Test connections

## Scenario 3: Database Corruption

**Symptoms:** n8n starts but workflows don't load, errors in logs

**Recovery:**

1. **Stop n8n:**
   ```bash
   docker-compose stop n8n
   ```

2. **Backup corrupted database:**
   ```bash
   cp ~/.n8n/database.sqlite ~/.n8n/database.sqlite.corrupted
   ```

3. **Restore from backup:**
   ```bash
   # Find latest database backup
   ls -lt BACKUPS/automated/database_*.sqlite

   # Restore
   cp BACKUPS/automated/database_YYYYMMDD_HHMMSS.sqlite ~/.n8n/database.sqlite
   ```

4. **Restart n8n:**
   ```bash
   docker-compose start n8n
   ```

5. **Verify workflows loaded**

## Scenario 4: Workflow Execution Data Loss

**Symptoms:** Historical execution data missing

**Recovery:**

Execution history is stored in database. Restore from volume backup (Scenario 2, step 3).

Note: If only workflow definitions needed (not execution history), import from JSON backups.

## Credentials Recovery

**Critical Credentials Needed:**

1. **Claude API Key:**
   - Location: https://console.anthropic.com/settings/keys
   - Environment: Production
   - Name: n8n-integration

2. **Google OAuth:**
   - Client ID: [document in secure location]
   - Client Secret: [document in secure location]
   - Redirect URI: https://your-ngrok-url.ngrok-free.app/rest/oauth2-credential/callback

3. **ngrok Auth Token:**
   - Location: https://dashboard.ngrok.com/get-started/your-authtoken
   - Stored in: Environment variable or docker-compose.yml

4. **n8n Basic Auth:**
   - Username: admin (or as configured)
   - Password: [document in secure location]

**Best Practice:** Store all credentials in a password manager (1Password, Bitwarden, etc.)

## Testing Recovery

After any recovery, run this test checklist:

- [ ] n8n UI accessible at http://localhost:5678
- [ ] All workflows visible in workflow list
- [ ] Credentials configured and connection tests pass
- [ ] Manual workflow execution succeeds
- [ ] Scheduled workflows trigger correctly
- [ ] Webhook workflows respond to test requests
- [ ] Error handling workflows trigger on failure
- [ ] Backup automation workflow runs successfully
- [ ] ngrok tunnel active (if used): http://localhost:4040

## Prevention

- ✓ Run automated backups daily (Task 2)
- ✓ Version control workflows in Git (Task 3)
- ✓ Document credentials in password manager (Task 11)
- ✓ Test restoration quarterly
- ✓ Keep backup scripts updated
- ✓ Monitor backup success/failure

## Support Resources

- n8n Documentation: https://docs.n8n.io/
- n8n Community: https://community.n8n.io/
- Docker Documentation: https://docs.docker.com/
- This Repository: `02_AREAS/Workflow_Automation/n8n/`

---

**Last Updated:** 2026-01-14
**Next Review:** 2026-04-14 (quarterly)
```

**Success Criteria:**
- [ ] Recovery guide created and comprehensive
- [ ] All scenarios documented with step-by-step instructions
- [ ] Credentials recovery process documented
- [ ] Testing checklist included

---

### Task 8: Test Workflow Import/Export and Restoration Process

**Priority:** CRITICAL
**Complexity:** Easy
**Time Estimate:** 1 hour

**Steps:**

1. **Test Individual Workflow Export/Import:**
   ```
   a. Export BILAN Social Media workflow
   b. Delete the workflow from n8n
   c. Import from backup JSON
   d. Verify all nodes present
   e. Check credentials linked correctly
   f. Test execute
   g. Activate workflow
   ```

2. **Test Volume Backup Restoration:**
   ```
   a. Create test n8n instance (different port)
   b. Extract volume backup to test location
   c. Start test instance with restored data
   d. Verify workflows present
   e. Test workflow execution
   f. Shut down test instance
   ```

3. **Test Database Backup:**
   ```
   a. Stop n8n
   b. Backup current database.sqlite
   c. Replace with older backup
   d. Start n8n
   e. Verify workflows loaded
   f. Restore original database
   g. Restart n8n
   ```

4. **Document Test Results:**

   Create: `BACKUPS/restoration_test_log.md`
   ```markdown
   # Restoration Test Log

   ## Test Date: YYYY-MM-DD

   ### Individual Workflow Import
   - [ ] Export successful
   - [ ] Import successful
   - [ ] Credentials linked
   - [ ] Execution works
   - Time to restore: X minutes
   - Issues encountered: None / [describe]

   ### Volume Restoration
   - [ ] Backup extracted successfully
   - [ ] n8n started with restored data
   - [ ] All workflows present
   - [ ] Executions work
   - Time to restore: X minutes
   - Issues encountered: None / [describe]

   ### Database Restoration
   - [ ] Database replaced successfully
   - [ ] n8n started correctly
   - [ ] Workflows loaded
   - Time to restore: X minutes
   - Issues encountered: None / [describe]

   ## Next Test Date: YYYY-MM-DD (3 months)
   ```

5. **Schedule Quarterly Tests:**
   ```bash
   # Add reminder to calendar
   # Test restoration every 3 months
   # Document in restoration_test_log.md
   ```

**Success Criteria:**
- [ ] Workflow import/export tested successfully
- [ ] Volume restoration tested and verified
- [ ] Database restoration tested and verified
- [ ] Test results documented
- [ ] Quarterly testing schedule established

---

### Task 9: Set Up Monitoring for Workflow Execution Failures

**Priority:** MEDIUM
**Complexity:** Intermediate
**Time Estimate:** 2 hours

**Implementation:**

1. **Create Monitoring Workflow:**

   New workflow: "n8n Health Monitor"

   **Node 1: Schedule Trigger**
   - Cron: `*/15 * * * *` (every 15 minutes)

   **Node 2: HTTP Request - Get Recent Executions**
   - Method: GET
   - URL: `http://n8n:5678/api/v1/executions?status=error&limit=50`
   - Headers: `X-N8N-API-KEY: {{ $env.N8N_API_KEY }}`

   **Node 3: Function - Analyze Execution Health**
   ```javascript
   const executions = $input.first().json.data || [];
   const now = new Date();
   const fifteenMinutesAgo = new Date(now - 15 * 60 * 1000);

   // Filter executions from last 15 minutes
   const recentErrors = executions.filter(exec => {
     const execTime = new Date(exec.startedAt);
     return execTime > fifteenMinutesAgo;
   });

   // Group by workflow
   const errorsByWorkflow = {};
   recentErrors.forEach(exec => {
     const workflowName = exec.workflowData.name;
     if (!errorsByWorkflow[workflowName]) {
       errorsByWorkflow[workflowName] = {
         workflow_name: workflowName,
         workflow_id: exec.workflowId,
         error_count: 0,
         errors: []
       };
     }
     errorsByWorkflow[workflowName].error_count++;
     errorsByWorkflow[workflowName].errors.push({
       execution_id: exec.id,
       started_at: exec.startedAt,
       error: exec.data?.resultData?.error?.message || 'Unknown error'
     });
   });

   // Check if action needed
   const criticalWorkflows = Object.values(errorsByWorkflow)
     .filter(w => w.error_count >= 3); // 3+ errors in 15 min = critical

   return [{
     json: {
       check_time: now.toISOString(),
       total_recent_errors: recentErrors.length,
       affected_workflows: Object.keys(errorsByWorkflow).length,
       workflows: Object.values(errorsByWorkflow),
       critical_workflows: criticalWorkflows,
       alert_required: criticalWorkflows.length > 0
     }
   }];
   ```

   **Node 4: IF - Alert Required?**
   - Condition: `{{ $json.alert_required === true }}`

   **Node 5a: Send Alert (True Branch)**
   - Email or Slack
   - Subject: `⚠️ n8n Workflow Failures Detected`
   - Body:
   ```
   Multiple workflow failures detected in the last 15 minutes.

   Critical Workflows:
   {{ $json.critical_workflows.map(w => `- ${w.workflow_name}: ${w.error_count} errors`).join('\n') }}

   Check n8n dashboard immediately: http://localhost:5678/executions
   ```

   **Node 5b: Log Only (False Branch)**
   - Write to log file

2. **Create Execution Statistics Tracker:**

   New workflow: "Execution Statistics Logger"

   **Node 1: Schedule Trigger**
   - Cron: `0 0 * * *` (daily at midnight)

   **Node 2: HTTP Request - Get All Executions (Last 24h)**

   **Node 3: Function - Calculate Statistics**
   ```javascript
   const executions = $input.first().json.data || [];
   const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000);

   const stats = {
     date: new Date().toISOString().split('T')[0],
     total_executions: executions.length,
     successful: executions.filter(e => e.finished && !e.stoppedAt).length,
     failed: executions.filter(e => e.stoppedAt).length,
     success_rate: 0,
     by_workflow: {}
   };

   // Calculate success rate
   if (stats.total_executions > 0) {
     stats.success_rate = ((stats.successful / stats.total_executions) * 100).toFixed(2);
   }

   // Group by workflow
   executions.forEach(exec => {
     const name = exec.workflowData.name;
     if (!stats.by_workflow[name]) {
       stats.by_workflow[name] = { total: 0, successful: 0, failed: 0 };
     }
     stats.by_workflow[name].total++;
     if (exec.finished && !exec.stoppedAt) {
       stats.by_workflow[name].successful++;
     } else if (exec.stoppedAt) {
       stats.by_workflow[name].failed++;
     }
   });

   return [{ json: stats }];
   ```

   **Node 4: Google Sheets - Append Statistics**
   - Spreadsheet: "n8n Execution Statistics"
   - Sheet: "Daily Stats"

3. **Create Dashboard (Optional):**

   Google Sheets template with charts:
   - Daily execution trends
   - Success rate over time
   - Most failed workflows
   - Average execution time

**Success Criteria:**
- [ ] Health monitoring workflow created and active
- [ ] Alert thresholds configured appropriately
- [ ] Statistics logging workflow active
- [ ] Dashboard created (optional)
- [ ] Alerts tested and working

---

### Task 10: Configure Automatic Workflow Exports on Schedule

**Priority:** MEDIUM
**Complexity:** Easy (if using meta-workflow from Task 2)
**Time Estimate:** 30 minutes

**Steps:**

1. **Ensure Meta-Workflow is Active:**
   - Open "n8n Workflow Backup" workflow
   - Verify schedule: `0 3 * * *` (3 AM daily)
   - Activate workflow

2. **Add Git Commit to Backup Workflow:**

   Add new node after Write Binary File:

   **Execute Command Node:**
   ```bash
   cd /home/node/.n8n/backups && \
   git add -A && \
   git commit -m "Automated workflow backup: $(date +%Y-%m-%d)" && \
   git push origin main
   ```

3. **Configure Backup Success Notification:**

   Add at end of backup workflow:
   ```javascript
   // Success notification
   const backupCount = $input.all().length;
   const timestamp = new Date().toISOString();

   return [{
     json: {
       subject: "✓ n8n Daily Backup Complete",
       message: `Successfully backed up ${backupCount} workflows at ${timestamp}`,
       backup_location: "/home/node/.n8n/backups/automated",
       git_committed: true
     }
   }];
   ```

4. **Test Automated Backup:**
   ```bash
   # Wait for scheduled run or trigger manually
   # Verify backup files created
   ls -la ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/automated/

   # Check git commits
   cd ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS
   git log --oneline | head -5
   ```

**Success Criteria:**
- [ ] Automated backup workflow active
- [ ] Daily schedule configured
- [ ] Git commits automated
- [ ] Success notifications working
- [ ] Backup verified after scheduled run

---

## Phase 4: Documentation & Disaster Recovery

### Task 11: Document All Credentials and API Keys in Secure Password Manager

**Priority:** CRITICAL
**Complexity:** Easy
**Time Estimate:** 30 minutes

**Steps:**

1. **Inventory All Credentials:**

   Create checklist:
   - [ ] Claude API Key
   - [ ] n8n Basic Auth (username/password)
   - [ ] Google OAuth Client ID & Secret
   - [ ] ngrok Auth Token
   - [ ] n8n API Key (if enabled)
   - [ ] Email SMTP credentials (if used)
   - [ ] Slack API token (if used)
   - [ ] Any other service API keys

2. **Choose Password Manager:**
   - 1Password (recommended)
   - Bitwarden
   - LastPass
   - KeePass

3. **Create Secure Entries:**

   For each credential, store:
   - **Title:** "n8n - Claude API Key"
   - **Username:** (if applicable)
   - **Password:** The API key or password
   - **URL:** Service URL (e.g., https://console.anthropic.com)
   - **Notes:**
     ```
     Purpose: n8n workflow automation
     Used in: BILAN Social Media Generator workflow
     Permissions: Read, Write
     Created: YYYY-MM-DD
     Backup location: n8n credentials store
     ```

4. **Create Recovery Document:**

   File: `BACKUPS/CREDENTIALS_RECOVERY.md` (encrypt or store in password manager)

   ```markdown
   # n8n Credentials Recovery Guide

   ## Credential Locations

   All credentials stored in: [Password Manager Name]
   Vault: "Development Credentials" or similar

   ## Required Credentials for Full Recovery

   ### 1. Claude API Key
   - **Service:** Anthropic Claude AI
   - **Password Manager Entry:** "n8n - Claude API Key"
   - **How to obtain new:** https://console.anthropic.com/settings/keys
   - **Used in workflows:** BILAN Social Media Generator

   ### 2. Google OAuth Credentials
   - **Service:** Google Cloud Platform
   - **Password Manager Entry:** "n8n - Google OAuth"
   - **How to obtain new:** Google Cloud Console → APIs & Services → Credentials
   - **Used in workflows:** BILAN Social Media Generator (Google Docs)

   ### 3. ngrok Auth Token
   - **Service:** ngrok
   - **Password Manager Entry:** "ngrok Auth Token"
   - **How to obtain new:** https://dashboard.ngrok.com/get-started/your-authtoken
   - **Used in:** Docker Compose setup

   ### 4. n8n Basic Auth
   - **Service:** n8n
   - **Password Manager Entry:** "n8n - Admin Credentials"
   - **Default:** admin / secret (CHANGE IN PRODUCTION)
   - **Set in:** docker-compose.yml environment variables

   ## Re-configuring Credentials in n8n

   1. Access n8n: http://localhost:5678
   2. Navigate to: Settings → Credentials
   3. For each credential:
      - Click "Add Credential"
      - Select credential type
      - Enter values from password manager
      - Test connection
      - Save

   ## Emergency Contact

   If locked out of password manager:
   - Recovery contact: [Name]
   - Recovery email: [Email]
   - Backup codes location: [Secure location]
   ```

5. **Enable Password Manager Backup:**
   - Export encrypted vault backup
   - Store in secure location (separate from n8n backups)
   - Set up automated vault backups if available

**Success Criteria:**
- [ ] All credentials documented in password manager
- [ ] Each entry includes comprehensive notes
- [ ] Recovery guide created
- [ ] Password manager backup configured
- [ ] Emergency recovery process documented

---

### Task 12: Create Disaster Recovery Plan for n8n Instance Rebuild

**Priority:** MEDIUM
**Complexity:** Easy
**Time Estimate:** 1 hour

**Steps:**

Create comprehensive plan: `n8n_disaster_recovery_plan.md`

```markdown
# n8n Disaster Recovery Plan

**Last Updated:** 2026-01-14
**Review Frequency:** Quarterly
**Owner:** [Your name]

---

## Recovery Time Objectives (RTO)

- **Individual workflow loss:** 15 minutes
- **Complete instance rebuild:** 2 hours
- **Full recovery with historical data:** 4 hours

## Recovery Point Objectives (RPO)

- **Workflow definitions:** 24 hours (daily backups)
- **Execution history:** 7 days (weekly volume backups)
- **Credentials:** Current (stored in password manager)

---

## Pre-Disaster Preparations

### ✓ Completed
- [ ] Daily automated backups configured
- [ ] Git version control set up
- [ ] Credentials documented in password manager
- [ ] Recovery procedures documented
- [ ] Disaster recovery plan reviewed (quarterly)
- [ ] Test recovery performed (quarterly)

### Backup Locations

| Backup Type | Location | Frequency | Retention |
|------------|----------|-----------|-----------|
| Workflow JSON | `~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/automated/` | Daily | 30 days |
| Volume backup | `~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/docker_volumes/` | Weekly | 14 days |
| Git repository | `~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/.git` | Daily | Unlimited |
| Remote Git | GitHub/GitLab (optional) | Daily | Unlimited |

---

## Disaster Scenarios

### Scenario A: Single Workflow Lost
**Recovery Time:** 15 minutes
**See:** DISASTER_RECOVERY_GUIDE.md → Scenario 1

### Scenario B: Multiple Workflows Lost
**Recovery Time:** 30-60 minutes
**Procedure:**
1. Locate latest backup: `BACKUPS/automated/`
2. Import each workflow via UI
3. Verify credentials linked
4. Test execute each workflow
5. Reactivate workflows

### Scenario C: Complete Instance Destruction
**Recovery Time:** 2-4 hours
**See:** DISASTER_RECOVERY_GUIDE.md → Scenario 2

### Scenario D: Data Corruption
**Recovery Time:** 1 hour
**See:** DISASTER_RECOVERY_GUIDE.md → Scenario 3

### Scenario E: Host Machine Failure
**Recovery Time:** 4-8 hours
**Procedure:**
1. Set up new machine with Docker
2. Clone backup repository
3. Restore docker-compose.yml
4. Restore .n8n directory from backup
5. Configure ngrok
6. Start services
7. Verify all workflows

---

## Recovery Procedures

### Phase 1: Assessment (15 minutes)

1. **Identify disaster scope:**
   - [ ] Single workflow affected
   - [ ] Multiple workflows affected
   - [ ] Complete instance lost
   - [ ] Host machine failure

2. **Locate latest backups:**
   ```bash
   cd ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS
   ls -lt automated/ | head -5
   ls -lt docker_volumes/ | head -3
   git log --oneline | head -5
   ```

3. **Verify backup integrity:**
   ```bash
   # Check file sizes reasonable
   du -sh automated/*.json
   du -sh docker_volumes/*.tar.gz

   # Verify JSON syntax
   jq empty automated/[latest-file].json && echo "Valid JSON"
   ```

### Phase 2: Recovery Execution

**Follow scenario-specific procedures in DISASTER_RECOVERY_GUIDE.md**

### Phase 3: Verification (30 minutes)

1. **Verify n8n accessible:**
   ```bash
   curl -I http://localhost:5678
   # Should return 200 OK
   ```

2. **Check workflows restored:**
   - Open n8n UI
   - Count workflows matches expected
   - Verify each workflow opens without errors

3. **Test credentials:**
   - Settings → Credentials
   - Test connection for each credential
   - Re-enter any that fail

4. **Test workflow execution:**
   - Manually execute each workflow
   - Verify outputs correct
   - Check error handling works

5. **Verify scheduled workflows:**
   - Check cron triggers configured
   - Verify next execution time reasonable

6. **Check error monitoring:**
   - Verify health monitor workflow active
   - Test error notifications working

### Phase 4: Post-Recovery Actions

1. **Document incident:**
   - What failed
   - Root cause
   - Recovery actions taken
   - Time to recover
   - Lessons learned

2. **Update recovery plan if needed**

3. **Perform full backup:**
   ```bash
   ~/scripts/n8n_docker_volume_backup.sh
   ```

4. **Notify stakeholders of recovery completion**

---

## Recovery Team

### Primary Contact
- **Name:** [Your name]
- **Role:** n8n Administrator
- **Contact:** [Email/Phone]

### Backup Contacts
- **Name:** [Backup person]
- **Role:** Technical support
- **Contact:** [Email/Phone]

---

## Testing Schedule

### Quarterly Recovery Tests

**Next Test Date:** 2026-04-14

**Test Checklist:**
- [ ] Export workflow from n8n
- [ ] Delete workflow
- [ ] Restore from backup
- [ ] Verify functionality
- [ ] Test volume restoration
- [ ] Document test results
- [ ] Update procedures if needed

**Test Log:** See `BACKUPS/restoration_test_log.md`

---

## Continuous Improvement

### Review Triggers
- After any disaster recovery event
- Quarterly scheduled review
- After major n8n version upgrade
- After workflow architecture changes

### Metrics to Track
- Time to detect disaster
- Time to initiate recovery
- Time to complete recovery
- Backup restore success rate
- Lessons learned per incident

---

## Appendices

### A. Quick Reference Commands

```bash
# Check n8n status
docker ps | grep n8n

# Start n8n
docker-compose up -d n8n

# Stop n8n
docker-compose stop n8n

# View logs
docker logs n8n

# Access n8n shell
docker exec -it n8n sh

# Backup now
~/scripts/n8n_docker_volume_backup.sh

# List backups
ls -lth ~/Documents/textDump/02_AREAS/Workflow_Automation/n8n/BACKUPS/automated/

# Restore volume
tar -xzf backup.tar.gz -C ~/
```

### B. External Dependencies

| Service | Status Page | Documentation |
|---------|-------------|---------------|
| Claude API | https://status.anthropic.com | https://docs.anthropic.com |
| Google APIs | https://status.cloud.google.com | https://cloud.google.com/docs |
| ngrok | https://status.ngrok.com | https://ngrok.com/docs |
| n8n | https://n8n.statuspage.io | https://docs.n8n.io |

### C. Related Documentation

- `n8n_backup_and_error_handling_plan.md` (this file)
- `DISASTER_RECOVERY_GUIDE.md`
- `BACKUPS/RESTORE_INSTRUCTIONS.md`
- `BACKUPS/CREDENTIALS_RECOVERY.md`
- `02_AREAS/Workflow_Automation/n8n/ngrok&n8n.md`

---

**Document Version:** 1.0
**Next Review:** 2026-04-14
```

**Success Criteria:**
- [ ] Disaster recovery plan created
- [ ] All scenarios documented with procedures
- [ ] Recovery team identified
- [ ] Testing schedule established
- [ ] Quick reference commands included

---

## Implementation Timeline

### Week 1: Critical Backups
- [ ] Task 1: Manual workflow exports (Day 1)
- [ ] Task 3: Git version control setup (Day 2)
- [ ] Task 6: Docker volume backups (Day 3)
- [ ] Task 7: Recovery documentation (Day 4)
- [ ] Task 11: Credential documentation (Day 5)

### Week 2: Automation
- [ ] Task 2: Automated backup system (Days 1-2)
- [ ] Task 10: Automated exports (Day 3)
- [ ] Task 8: Test restoration (Days 4-5)

### Week 3: Error Handling
- [ ] Task 4: BILAN workflow error handling (Days 1-2)
- [ ] Task 5: Central error workflow (Days 3-4)
- [ ] Task 9: Execution monitoring (Day 5)

### Week 4: Finalization
- [ ] Task 12: Disaster recovery plan (Days 1-2)
- [ ] Full system test (Day 3)
- [ ] Documentation review (Day 4)
- [ ] Project completion (Day 5)

---

## Success Metrics

### Backup Coverage
- ✓ 100% of workflows backed up daily
- ✓ Full volume backup weekly
- ✓ Git commits daily
- ✓ 30-day retention for workflow backups
- ✓ 14-day retention for volume backups

### Recovery Capability
- ✓ Single workflow recovery: <15 minutes
- ✓ Full instance recovery: <4 hours
- ✓ Tested quarterly
- ✓ Documentation complete
- ✓ Credentials secured

### Error Handling
- ✓ All production workflows have error handlers
- ✓ Central error workflow active
- ✓ Alerts configured
- ✓ Error logging enabled
- ✓ Health monitoring active

### Documentation
- ✓ Backup procedures documented
- ✓ Restoration procedures documented
- ✓ Disaster recovery plan created
- ✓ Credentials recovery documented
- ✓ Quick reference guides available

---

## Maintenance Schedule

### Daily
- Automated workflow backups (3 AM)
- Execution health checks (every 15 min)
- Error monitoring active

### Weekly
- Full volume backup (Sunday 2 AM)
- Review error logs
- Check backup success

### Monthly
- Review backup disk usage
- Update documentation if needed
- Check credential expiration

### Quarterly
- Test full recovery process
- Review disaster recovery plan
- Update procedures as needed
- Verify all backups restorable

---

## Next Steps

1. **Start with Task 1:** Export all current workflows immediately
2. **Set up Git:** Task 3 - Version control for peace of mind
3. **Automate:** Task 2 - Don't rely on manual backups
4. **Test:** Task 8 - Ensure backups actually work
5. **Monitor:** Task 9 - Catch failures before they cascade

---

**Project Status:** Planning Complete - Ready for Implementation
**Priority:** HIGH - Start immediately to prevent future workflow loss
**Estimated Total Time:** 15-20 hours over 4 weeks
