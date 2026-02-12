# Claude Code Skills - Deep Understanding Quiz

**Total Questions:** 15
**Estimated Time:** 18-20 minutes
**Passing Score:** 75% (11/15 correct)

---

## Question 1: Skill Directory Discovery

You create a skill at `~/.claude/skills/my-tool/skill.md` and invoke it with `/my-tool`. It works perfectly. Then you create a project-specific version at `~/.claude/projects/-home-user-myproject/skills/my-tool/skill.md`. What happens when you invoke `/my-tool` from inside that project?

**A)** Error: duplicate skill names are not allowed
**B)** The global skill runs (first found wins)
**C)** The project-specific skill runs (project scope takes precedence)
**D)** You must specify which one: `/my-tool@global` or `/my-tool@project`

---

## Question 2: Project Key Generation

Which of these paths would generate the SAME project key?

```
/home/user/My Projects/app
/home/user/my-projects/app
/home/user/MY-PROJECTS/APP
```

**A)** All three generate the same key (case-insensitive, spaces normalized)
**B)** None of them - each has a unique key (case and spaces matter)
**C)** First and second are the same (space→dash conversion) but third differs (case matters)
**D)** All three are invalid (spaces not allowed in project paths)

---

## Question 3: skill.md Requirements

You create this directory structure:

```
~/.claude/skills/video-tool/
├── skill.md
├── templates/
│   └── template.tsx
└── README.md
```

What's the MINIMUM requirement for Claude to recognize this as a valid skill?

**A)** Must have skill.md only
**B)** Must have skill.md with specific YAML frontmatter
**C)** Must have skill.md with at least one non-empty line
**D)** Must have skill.md and README.md

---

## Question 4: Skill Invocation Timing

You have a skill that reads project files and generates documentation. When you invoke `/document-project`, at what point does Claude Code load and read the skill.md file?

**A)** When Claude Code starts up (all skills preloaded)
**B)** When you type `/doc` (autocomplete triggers loading)
**C)** When you press Enter after typing `/document-project`
**D)** After you press Enter and Claude confirms the skill exists

---

## Question 5: Skill Sharing Strategy

You have three video rendering projects that all use similar Remotion workflows. You want to share a skill called `/render-workflow` across all three. What's the BEST approach?

**A)** Copy the skill to each project's `.claude/projects/[project]/skills/` directory
**B)** Create it as a global skill at `~/.claude/skills/render-workflow/`
**C)** Create it once and symlink from each project's skills directory
**D)** Create a plugin and install it in `~/.claude/plugins/`

---

## Question 6: Skill Arguments Edge Case

You create a skill that accepts arguments:

```bash
/my-skill arg1 arg2
```

In your skill.md, you reference:

```markdown
ARGUMENTS: {{args}}
```

What does the user see when they invoke `/my-skill hello world`?

**A)** `{{args}}` is replaced with `hello world`
**B)** `{{args}}` stays as literal text (no replacement happens)
**C)** `ARGUMENTS: hello world` appears in the prompt
**D)** Error: skill arguments require {{arg1}} {{arg2}} syntax

---

## Question 7: Skill Discovery After Creation

You create a new skill at `~/.claude/skills/new-tool/skill.md` while Claude Code is running. What must you do for it to be available?

**A)** Nothing - skills are watched and auto-reload
**B)** Restart Claude Code
**C)** Run `/reload-skills` command
**D)** Exit and re-enter the current project directory

---

## Question 8: Skill Naming Restrictions

Which of these skill directory names would be INVALID?

**A)** `my-skill` (lowercase with dash)
**B)** `MySkill` (camelCase)
**C)** `my_skill` (underscore)
**D)** All of the above are valid

---

## Question 9: Skill Scope Confusion

You're in `/home/user/projects/app-A` and create a skill at:
```
~/.claude/projects/-home-user-projects-app-A/skills/helper/skill.md
```

Then you `cd /home/user/projects/app-B` and try `/helper`. What happens?

**A)** The skill runs (project skills are accessible from sibling projects)
**B)** Error: skill not found (project skills are scoped to their project)
**C)** The skill runs only if app-B doesn't have its own /helper skill
**D)** Prompt to confirm running a skill from another project

---

## Question 10: Skill File Organization

Inside a skill directory, you have:

```
~/.claude/skills/video-helper/
├── skill.md
├── templates/
│   ├── intro.tsx
│   └── outro.tsx
├── scripts/
│   └── render.js
└── data/
    └── config.json
```

When you invoke `/video-helper`, which files does Claude Code read?

**A)** Only skill.md
**B)** skill.md and all .md files recursively
**C)** All files in the directory (skill.md + templates + scripts + data)
**D)** skill.md plus any files referenced in its content

---

## Question 11: Skill vs Built-in Commands

You create a skill called `clear` at `~/.claude/skills/clear/skill.md`. When you type `/clear`, what happens?

**A)** Your custom skill runs (user skills override built-ins)
**B)** The built-in /clear command runs (built-ins have priority)
**C)** Error: cannot override built-in commands
**D)** Prompt asking which /clear you want to use

---

## Question 12: Multi-line Skill Arguments

You invoke a skill like this:

```bash
/my-skill first argument
and more on next line
```

What arguments does the skill receive?

**A)** Only `first argument` (newline terminates arguments)
**B)** `first argument\nand more on next line` (full multi-line text)
**C)** Error: arguments must be on one line
**D)** Two separate invocations of the skill

---

## Question 13: Skill Discoverability Pattern

You want users to easily find your skill without knowing its exact name. What's the BEST approach?

**A)** Name it with common prefixes: `skill-video-render`
**B)** Add aliases in skill.md frontmatter
**C)** Include keywords in the skill directory name: `video-render-remotion-export`
**D)** Create multiple symlinks with different names

---

## Question 14: Skill Content Structure

Which of these skill.md structures is MOST effective?

**A)**
```markdown
Generate video content
```

**B)**
```markdown
# Video Generator Skill
Generate video content with these specs...
```

**C)**
```markdown
You are a video generation expert.
When the user invokes this skill:
1. Ask for content type
2. Generate appropriate template
3. Validate against platform specs
```

**D)**
```markdown
---
name: video-generator
version: 1.0
---
Generate video content
```

---

## Question 15: Skill Update Propagation

You update a global skill's `skill.md` file while Claude Code is running. You've already used this skill once in the current session. What happens when you invoke it again?

**A)** The NEW version runs (skill.md is read fresh each invocation)
**B)** The OLD version runs (cached in memory until restart)
**C)** Error: skill was modified, restart required
**D)** Claude asks if you want to reload the skill

---

## Answer Sheet

Fill in your answers:

1. ___
2. ___
3. ___
4. ___
5. ___
6. ___
7. ___
8. ___
9. ___
10. ___
11. ___
12. ___
13. ___
14. ___
15. ___

---

## Scoring Guide

**13-15 correct (87-100%):** 🏆 **MASTERY**
Deep understanding of Claude Code's skill system. Ready for sophisticated workflows.

**11-12 correct (73-80%):** ✅ **STRONG**
Solid foundation with minor gaps. Review missed questions.

**8-10 correct (53-67%):** ⚠️ **MODERATE**
Understand basics but need more practice. Focus on scoping, precedence, and discovery timing.

**Below 8 (< 53%):** 📚 **REVIEW NEEDED**
Revisit fundamentals. Practice creating skills in different scopes.

---

**Check your answers in:** `claude-skills-quiz-answers.md`

**Quiz Generated:** 2026-02-10
**Skill Used:** learning-quiz-generator
