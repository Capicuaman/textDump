# File Reorganization Log

This file documents the changes made to your directory structure on November 1, 2025. You can use the commands below to revert the changes if necessary.

---

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