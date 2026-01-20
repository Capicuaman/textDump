# File Reorganization Log

This file documents the changes made to your directory structure. You can use the commands below to revert the changes if necessary.

---

## January 19, 2026 - PARA Method Cleanup

### Root Directory Files Organized
- Moved `claude-commands.html` and `claude.html` → `03_RESOURCES/AI/CLAUDE/`
- Moved `openwebui_docker_compose.md` → `02_AREAS/HOME-LAB/`
- Moved `scan_network.sh` → `03_RESOURCES/Home_Network/`
- Deleted temporary files: `pasted.txt`, `file.bak`

### BILAN Project Organization
- Created `01_PROJECTS/BILAN/n8n/` for BILAN-specific n8n workflows
- Moved n8n files from `01_PROJECTS/BILAN/00_INBOX/n8n/` → `01_PROJECTS/BILAN/n8n/`
  - ai_customer_support_faq_bot_implementation_guide.md
  - ai_customer_support_faq_bot_test_cases.md
  - ai_customer_support_faq_bot_workflow.json
  - ai_n8n_automation_projects_roadmap.md
  - claude_api_credentials_setup.md
  - colleague_testing_guide.md
- Moved website files from `01_PROJECTS/BILAN/00_INBOX/` → `01_PROJECTS/BILAN/WEB_DEVELOPMENT/`
  - bilan-bot-test.html
  - customer-support.html
  - harumi.html
  - index.html
  - ventas.html
- BILAN inbox now empty (except .DS_Store)

### NARANJOS Project Organization
- Moved `pisos.json` from `01_PROJECTS/NARANJOS/00_INBOX/` → `01_PROJECTS/NARANJOS/`
- NARANJOS inbox now empty

### Rollback Commands (January 19, 2026)

```shell
# Restore root directory files
mv 03_RESOURCES/AI/CLAUDE/claude-commands.html .
mv 03_RESOURCES/AI/CLAUDE/claude.html .
mv 02_AREAS/HOME-LAB/openwebui_docker_compose.md .
mv 03_RESOURCES/Home_Network/scan_network.sh .

# Restore BILAN inbox structure
mkdir -p 01_PROJECTS/BILAN/00_INBOX/n8n
mkdir -p 01_PROJECTS/BILAN/00_INBOX/created_websites
mv 01_PROJECTS/BILAN/n8n/* 01_PROJECTS/BILAN/00_INBOX/n8n/
mv 01_PROJECTS/BILAN/WEB_DEVELOPMENT/customer-support.html 01_PROJECTS/BILAN/00_INBOX/n8n/
mv 01_PROJECTS/BILAN/WEB_DEVELOPMENT/bilan-bot-test.html 01_PROJECTS/BILAN/00_INBOX/
mv 01_PROJECTS/BILAN/WEB_DEVELOPMENT/harumi.html 01_PROJECTS/BILAN/00_INBOX/created_websites/
mv 01_PROJECTS/BILAN/WEB_DEVELOPMENT/index.html 01_PROJECTS/BILAN/00_INBOX/created_websites/
mv 01_PROJECTS/BILAN/WEB_DEVELOPMENT/ventas.html 01_PROJECTS/BILAN/00_INBOX/created_websites/
rmdir 01_PROJECTS/BILAN/n8n

# Restore NARANJOS inbox
mkdir -p 01_PROJECTS/NARANJOS/00_INBOX
mv 01_PROJECTS/NARANJOS/pisos.json 01_PROJECTS/NARANJOS/00_INBOX/
```

---

## November 1, 2025 - Initial PARA Structure

## Rollback Commands

To undo the reorganization, run the following shell commands from the `/Users/ideaopedia/Documents/textDump` directory:

### Stage 2 Rollback

```shell
# Move AI folders back to root
mv 03_RESOURCES/AI/CrewAI/ .
mv 03_RESOURCES/AI/GRADIO/ .
mv 03_RESOURCES/AI/JINA/ .
mv 03_RESOURCES/AI/LANG_CHAIN/ .
mv 03_RESOURCES/AI/GEMINI/ .
mv 03_RESOURCES/AI/FABRIC_PATTERNS/ .

# Move Software Engineering folders back to root
mv 03_RESOURCES/Software_Engineering/DEV/ .
mv 03_RESOURCES/Software_Engineering/DOCKER/ .
mv 03_RESOURCES/Software_Engineering/PYTHON/ .
mv 03_RESOURCES/Software_Engineering/node/ .
mv 03_RESOURCES/Software_Engineering/git/ .
mv 03_RESOURCES/Software_Engineering/web-ui/ .
mv 03_RESOURCES/Software_Engineering/BrowserUseWebUI/ .
mv 03_RESOURCES/Software_Engineering/pydantic/ .
mv 03_RESOURCES/Software_Engineering/SANKEY/ .
mv 03_RESOURCES/Software_Engineering/SECURITY/ .

# Move Terminal and Shell folders back to root
mv 03_RESOURCES/Terminal_And_Shell/Konsole/ .
mv 03_RESOURCES/Terminal_And_Shell/oh-my-zsh/ .
mv 03_RESOURCES/Terminal_And_Shell/zsh/ .
mv 03_RESOURCES/Terminal_And_Shell/fzf/ .
mv 03_RESOURCES/Terminal_And_Shell/tmux/ .
mv 03_RESOURCES/Terminal_And_Shell/dotfiles/ .

# Move Design, Knowledge Management, and Misc folders back to root
mv 03_RESOURCES/Design/FREECAD/ .
mv 03_RESOURCES/Design/inkscape/ .
mv 03_RESOURCES/Knowledge_Management/OPENCODE/ .
mv 03_RESOURCES/Knowledge_Management/onetab/ .
mv 03_RESOURCES/Misc/ANA/ .
mv 03_RESOURCES/Misc/COOKING/ .
mv 03_RESOURCES/Misc/MCP/ .
mv 03_RESOURCES/Misc/YouTube/ .
mv 03_RESOURCES/Misc/TRAVEL/ .

# Move Notes back to root
mv 03_RESOURCES/Notes/backendGod.md .
mv 03_RESOURCES/Notes/drinklmnt_raw.md .
mv 03_RESOURCES/Notes/frontendGod.md .
mv 03_RESOURCES/Notes/GEMINI.md .
mv 03_RESOURCES/Notes/googledocsShotrcuts.md .
mv 03_RESOURCES/Notes/raw_drinklmnt.md .
mv 03_RESOURCES/Notes/readme.md .
```

### Stage 1 Rollback

```shell
# Move projects back to the root directory
mv 01_PROJECTS/ALICIA .
mv 01_PROJECTS/BILAN .

# Move area files and folders back to the root directory
mv 02_AREAS/Software_Development/Back-End_Development_Learning_Roadmap.md .
mv 02_AREAS/Software_Development/frontendRoadmap.md .
mv 02_AREAS/Personal_Development/BOOKS .
mv 02_AREAS/Workflow_Automation/n8n .
mv 02_AREAS/Workflow_Automation/AUTOMATION .

# Move resource files and folders back to the root directory
mv 03_RESOURCES/AI/fabric .
mv 03_RESOURCES/AI/OLLAMA .
mv 03_RESOURCES/AI/promptEngineering_PRIMER.md .
mv 03_RESOURCES/AI/How_My_Projects_Fit_Together.md .
mv 03_RESOURCES/Knowledge_Management/secondBrain .
mv 03_RESOURCES/Knowledge_Management/LOQSEQ .

# Move journal files back to their original location
mv 05_JOURNAL/daily-2025-11-01.md 03_RESOURCES/Knowledge_Management/secondBrain/
mv 05_JOURNAL/daily-note-template.md 03_RESOURCES/Knowledge_Management/secondBrain/

# Remove the empty PARA directories
rm -rf 01_PROJECTS 02_AREAS 03_RESOURCES 04_ARCHIVES 05_JOURNAL
```