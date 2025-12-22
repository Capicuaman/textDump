# Guía de Inicio: Herramientas CLI de AI y Gestión del Conocimiento

## Introducción

Esta guía te ayudará a comenzar con herramientas de línea de comandos (CLI) de inteligencia artificial y a organizar tu conocimiento de manera efectiva. Aprenderás a usar:

- **Claude Code** - Asistente de codificación de Anthropic
- **Gemini CLI** - Herramienta de línea de comandos de Google Gemini
- **OpenCode** - Sistema de "segundo cerebro" para desarrolladores
- **Git/GitHub** - Control de versiones y colaboración
- **Visual Studio Code** - Editor de código con integración total de las herramientas anteriores
- **Método PARA** - Sistema de organización del conocimiento

---

## 1. Claude Code

### ¿Qué es Claude Code?

Claude Code es un asistente de AI que trabaja directamente en tu terminal para ayudarte con tareas de programación, automatización y gestión de proyectos.

### Instalación

```bash
# Instalar Node.js (si no lo tienes)
# En macOS con Homebrew:
brew install node

# Instalar Claude Code globalmente
npm install -g @anthropic-ai/claude-code

# Verificar instalación
claude --version
```

### Configuración Inicial

1. **Obtener API Key:**
   - Ve a [console.anthropic.com](https://console.anthropic.com)
   - Crea una cuenta o inicia sesión
   - Ve a "API Keys" y genera una nueva clave
   - Guarda tu clave de forma segura

2. **Configurar Claude Code:**
```bash
# Ejecutar configuración
claude configure

# Te pedirá tu API key
# Pégala cuando se solicite
```

### Comandos Básicos

#### Iniciar Claude Code en un Proyecto

```bash
# Navega a tu directorio de proyecto
cd ~/mis-proyectos/mi-proyecto

# Inicializar Claude Code
claude /init

# O simplemente
claude
```

#### Comandos Útiles en Sesión

Una vez dentro de Claude Code:

- `/help` - Muestra ayuda y comandos disponibles
- `/clear` - Limpia la conversación
- `/task` - Crea una tarea específica
- `/commit` - Crea un commit de git con mensaje generado por AI
- `/exit` - Salir de Claude Code
- `Ctrl+C` - Cancelar operación actual
- `Ctrl+D` - Salir

#### Ejemplos de Uso

```bash
# Ejemplo 1: Pedir ayuda con código
claude
> "Explícame qué hace este archivo: src/index.js"

# Ejemplo 2: Crear nuevo archivo
> "Crea un script de Python que organice archivos por extensión"

# Ejemplo 3: Refactorizar código
> "Refactoriza la función calculateTotal para que sea más legible"

# Ejemplo 4: Debugging
> "Hay un error en mi código, ayúdame a encontrarlo"
```

### Archivo CLAUDE.md

Claude Code lee archivos especiales llamados `CLAUDE.md` en tu proyecto para entender contexto:

```bash
# Crear archivo de instrucciones para Claude
touch CLAUDE.md
```

Ejemplo de contenido:

```markdown
# Mi Proyecto

## Descripción
Este es un proyecto de [descripción breve].

## Estructura
- `src/` - Código fuente
- `tests/` - Pruebas
- `docs/` - Documentación

## Convenciones
- Usar español para comentarios
- Seguir PEP 8 para Python
- Tests antes de commits

## Notas para Claude
- Este proyecto usa Python 3.11
- Base de datos: PostgreSQL
- Framework: FastAPI
```

---

## 2. Gemini CLI

### ¿Qué es Gemini CLI?

Gemini CLI te permite interactuar con los modelos de Google Gemini desde la terminal.

### Instalación

```bash
# Opción 1: Con npm
npm install -g @google/generative-ai-cli

# Opción 2: Con pip (Python)
pip install google-generativeai

# Opción 3: Usar directamente con curl/HTTP
# (no requiere instalación, solo API key)
```

### Configuración

1. **Obtener API Key:**
   - Ve a [makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)
   - Genera una API key
   - Guárdala de forma segura

2. **Configurar variable de entorno:**
```bash
# En ~/.zshrc o ~/.bashrc
export GEMINI_API_KEY="tu-api-key-aquí"

# Recargar configuración
source ~/.zshrc
```

### Uso Básico

```bash
# Ejemplo de consulta simple
gemini "Explícame qué es un API REST"

# Procesar archivos
gemini "Resume este documento" < documento.txt

# Modo interactivo
gemini --interactive
```

---

## 3. OpenCode

### ¿Qué es OpenCode?

OpenCode es un sistema de "segundo cerebro" (second brain) para desarrolladores que te ayuda a capturar, organizar y recuperar conocimiento técnico.

### Instalación

```bash
# Clonar repositorio (si es open source)
git clone https://github.com/usuario/opencode.git
cd opencode

# Instalar dependencias
npm install
# o
pip install -r requirements.txt

# Configurar
./setup.sh
```

### Conceptos Clave

1. **Captura Rápida** - Guardar snippets de código, comandos, notas
2. **Etiquetado** - Organizar con tags (#python, #docker, etc.)
3. **Búsqueda Semántica** - Encontrar información por contexto
4. **Integración con AI** - Usar LLMs para resumir y conectar ideas

### Uso Básico

```bash
# Capturar un snippet
opencode save "comando útil de git" --tag git
# Luego pegar el comando

# Buscar
opencode search "docker compose"

# Listar por etiqueta
opencode list --tag python

# Ver estadísticas
opencode stats
```

---

## 4. Git y GitHub

### ¿Por qué Git?

Git es el sistema de control de versiones más usado. Te permite:
- Rastrear cambios en tu código
- Colaborar con otros
- Volver a versiones anteriores
- Experimentar sin miedo

### Instalación de Git

```bash
# En macOS
brew install git

# En Ubuntu/Debian
sudo apt install git

# Configuración inicial
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Editor por defecto
git config --global core.editor "nano"
# o "vim" o "code" (VSCode)
```

### Conceptos Básicos de Git

#### Flujo de Trabajo Básico

```bash
# 1. Inicializar repositorio
git init

# 2. Ver estado de archivos
git status

# 3. Agregar archivos al staging area
git add archivo.txt
# o agregar todos
git add .

# 4. Crear commit (guardar cambios)
git commit -m "Descripción de los cambios"

# 5. Ver historial
git log
# o versión compacta
git log --oneline
```

#### Comandos Esenciales

```bash
# Ver diferencias antes de commit
git diff

# Ver ramas
git branch

# Crear y cambiar a nueva rama
git checkout -b nueva-funcionalidad

# Cambiar de rama
git checkout main

# Unir ramas
git merge nueva-funcionalidad

# Ver archivos ignorados
cat .gitignore
```

### GitHub

#### Configuración Inicial

1. **Crear cuenta en GitHub:**
   - Ve a [github.com](https://github.com)
   - Regístrate con tu email

2. **Configurar SSH (recomendado):**

```bash
# Generar llave SSH
ssh-keygen -t ed25519 -C "tu@email.com"

# Presiona Enter para aceptar ubicación por defecto
# Opcionalmente añade una contraseña

# Copiar llave pública
cat ~/.ssh/id_ed25519.pub
# Copia el contenido

# En GitHub:
# Settings → SSH and GPG keys → New SSH key
# Pega la llave pública
```

3. **Verificar conexión:**
```bash
ssh -T git@github.com
# Deberías ver: "Hi usuario! You've successfully authenticated"
```

#### Flujo de Trabajo con GitHub

```bash
# Clonar un repositorio existente
git clone git@github.com:usuario/repositorio.git
cd repositorio

# Crear nuevo repositorio local y subirlo a GitHub
mkdir mi-proyecto
cd mi-proyecto
git init
echo "# Mi Proyecto" > README.md
git add README.md
git commit -m "Primer commit"

# En GitHub, crea un nuevo repositorio (sin README)
# Luego conecta tu repo local:
git remote add origin git@github.com:tu-usuario/mi-proyecto.git
git branch -M main
git push -u origin main

# Flujo diario:
# 1. Hacer cambios
echo "contenido nuevo" >> archivo.txt

# 2. Ver estado
git status

# 3. Agregar cambios
git add archivo.txt

# 4. Commit
git commit -m "Agregar contenido nuevo"

# 5. Subir a GitHub
git push

# 6. Bajar cambios de otros
git pull
```

#### Archivo .gitignore

Archivo que indica qué NO subir a GitHub:

```bash
# Crear .gitignore
touch .gitignore
```

Ejemplo de contenido:

```
# Archivos del sistema
.DS_Store
Thumbs.db

# Dependencias
node_modules/
venv/
__pycache__/

# Configuración local
.env
config.local.json

# API Keys (MUY IMPORTANTE)
*.key
secrets/

# IDEs
.vscode/
.idea/
*.swp

# Build outputs
dist/
build/
*.log
```

---

## 5. Visual Studio Code (VSCode)

### ¿Qué es VSCode?

Visual Studio Code es un editor de código gratuito y de código abierto desarrollado por Microsoft. Es ligero, rápido y extremadamente popular entre desarrolladores. Lo mejor: integra perfectamente con Git, GitHub, y todas las herramientas CLI que estamos usando.

### ¿Por qué usar VSCode?

- **Terminal integrada** - Usa Claude Code, Git, y otros comandos sin salir del editor
- **Explorador de archivos** - Navega tu estructura PARA visualmente
- **Integración con Git/GitHub** - Ve cambios, haz commits, push sin usar terminal
- **Extensiones** - Miles de extensiones para cualquier lenguaje o herramienta
- **Markdown preview** - Ve tus notas formateadas en tiempo real
- **Multi-cursor** - Edita múltiples líneas simultáneamente
- **Gratis y multiplataforma** - Funciona en macOS, Windows, Linux

### Instalación

#### Opción 1: Descarga Directa

```bash
# Ve a https://code.visualstudio.com
# Descarga el instalador para tu sistema operativo
# Abre el instalador y sigue las instrucciones
```

#### Opción 2: Homebrew (macOS)

```bash
# Instalar con Homebrew
brew install --cask visual-studio-code

# Verificar instalación
code --version
```

#### Opción 3: apt (Ubuntu/Debian)

```bash
# Actualizar repositorios
sudo apt update

# Instalar VSCode
sudo apt install code

# Verificar
code --version
```

### Configuración Inicial

#### Abrir desde Terminal

```bash
# Configurar el comando 'code' (si no funciona)
# En macOS, abre VSCode y presiona Cmd+Shift+P
# Escribe: "Shell Command: Install 'code' command in PATH"
# Selecciona esa opción

# Ahora puedes abrir carpetas desde terminal
cd ~/segundo-cerebro
code .

# Abrir archivo específico
code README.md

# Abrir nuevo archivo
code nueva-nota.md
```

#### Interfaz Básica

Cuando abres VSCode, verás:

```
┌─────────────────────────────────────────┐
│  [≡] Menú    Archivo   Editar   Ver...  │ ← Barra de menú
├───┬─────────────────────────────────────┤
│ E │                                     │
│ x │   Área del Editor                  │ ← Aquí editas archivos
│ p │   (archivos abiertos)              │
│ l │                                     │
│ o │─────────────────────────────────────│
│ r │                                     │
│ a │   Terminal integrada                │ ← Aquí usas CLI tools
│ d │   (puedes ocultarla con Ctrl+`)     │
│ o │                                     │
│ r │                                     │
└───┴─────────────────────────────────────┘
  ↑
Barra lateral (explorador, búsqueda, Git, etc.)
```

### Atajos de Teclado Esenciales

#### Navegación General

```bash
Cmd+P (macOS) / Ctrl+P (Linux/Windows)  # Búsqueda rápida de archivos
Cmd+Shift+P                              # Paleta de comandos
Cmd+B                                    # Mostrar/ocultar barra lateral
Cmd+`                                    # Mostrar/ocultar terminal
Cmd+W                                    # Cerrar archivo actual
Cmd+Shift+T                              # Reabrir archivo cerrado
```

#### Edición

```bash
Cmd+/                   # Comentar/descomentar línea
Cmd+D                   # Seleccionar siguiente ocurrencia
Cmd+Shift+L             # Seleccionar todas las ocurrencias
Alt+Flecha arriba/abajo # Mover línea arriba/abajo
Cmd+Enter               # Insertar línea abajo
Cmd+F                   # Buscar en archivo
Cmd+Shift+F             # Buscar en todos los archivos
```

#### Terminal

```bash
Ctrl+`                  # Mostrar/ocultar terminal
Cmd+Shift+`             # Nueva terminal
Ctrl+Shift+5            # Dividir terminal
```

### Explorador de Archivos (File Explorer)

#### Usar el Explorador

El explorador te muestra tu estructura de carpetas visualmente:

```bash
# Abrir explorador
Click en el ícono de carpeta en la barra lateral (primera opción)
# O presiona: Cmd+Shift+E

# Funciones del explorador:
- Click derecho en carpeta → Nuevo archivo/carpeta
- Arrastrar archivos para mover
- Click derecho → Revelar en Finder/Explorer
- Click en archivo → Abre en editor
```

#### Ejemplo: Navegar tu Estructura PARA

```
EXPLORADOR
└── segundo-cerebro/
    ├── 00_INBOX/
    │   ├── idea-1.md
    │   └── idea-2.md
    ├── 01_PROYECTOS/
    │   ├── aprender-docker/
    │   └── crear-portfolio/
    ├── 02_AREAS/
    ├── 03_RECURSOS/
    │   └── AI/
    │       ├── claude/
    │       └── gemini/
    ├── 04_ARCHIVO/
    └── CLAUDE.md
```

**Acciones rápidas:**
- Click derecho en `00_INBOX/` → "New File" → crear nota
- Arrastrar `idea-1.md` de INBOX a `03_RECURSOS/AI/`
- Click en `CLAUDE.md` para editarlo

#### Filtros y Búsqueda en Explorador

```bash
# En la vista del explorador:
- Escribe para filtrar archivos visibles
- Click en ícono de lupa → Búsqueda avanzada
- Click en ícono de 3 puntos → Ordenar por nombre/fecha/tipo
```

### Integración con Git/GitHub

#### Vista de Control de Código Fuente

```bash
# Abrir vista de Git
Click en ícono de ramificación en barra lateral (tercera opción)
# O presiona: Ctrl+Shift+G
```

**Lo que verás:**

```
SOURCE CONTROL
  Changes (3)
    M  01_PROYECTOS/docker/notas.md
    A  03_RECURSOS/python/guia.md
    D  00_INBOX/viejo.md

  Message: [Escribir mensaje de commit aquí]

  [Commit] [Refresh] [...]
```

**Símbolos:**
- `M` (Modified) - Archivo modificado
- `A` (Added) - Archivo nuevo
- `D` (Deleted) - Archivo eliminado
- `U` (Untracked) - Sin seguimiento de Git

#### Hacer Commits desde VSCode

**Método Visual (sin terminal):**

```bash
1. Abre vista de Control de Código Fuente (Ctrl+Shift+G)

2. Ver cambios:
   - Click en archivo modificado
   - VSCode muestra diferencias lado a lado
   - Verde = agregado, Rojo = eliminado

3. Stage changes (agregar al commit):
   - Hover sobre archivo → Click en "+"
   - O click en "+" junto a "Changes" para agregar todos

4. Escribir mensaje de commit:
   - Click en el cuadro de texto arriba
   - Escribe tu mensaje descriptivo

5. Hacer commit:
   - Click en el botón "Commit" (✓)
   - O presiona Cmd+Enter

6. Push a GitHub:
   - Click en "..." (menú)
   - Selecciona "Push"
   - O click en el ícono de sincronización en la barra inferior
```

#### Ver Historial de Git

```bash
# En vista de Control de Código Fuente:
Click en archivo → "Open Timeline" en panel inferior
# Verás historial de cambios del archivo

# Para historial completo, instala extensión:
# Git History (por Don Jayamanne)
```

#### Resolver Conflictos de Merge

Cuando hay conflictos, VSCode los muestra claramente:

```markdown
<<<<<<< HEAD (Current Change)
Tu versión del texto
=======
Versión del servidor (de GitHub)
>>>>>>> main (Incoming Change)
```

VSCode muestra botones para:
- **Accept Current Change** - Mantener tu versión
- **Accept Incoming Change** - Usar versión del servidor
- **Accept Both Changes** - Mantener ambas
- **Compare Changes** - Ver diferencias lado a lado

### Integración con GitHub (Extensión)

#### Instalar GitHub Extension

```bash
# Método 1: Desde VSCode
1. Click en ícono de extensiones (cuadrados en barra lateral)
2. Buscar "GitHub Pull Requests and Issues"
3. Click "Install"

# Método 2: Terminal
code --install-extension GitHub.vscode-pull-request-github
```

#### Autenticar con GitHub

```bash
1. Presiona Cmd+Shift+P
2. Escribe: "GitHub: Sign in"
3. Selecciona "Sign in with browser"
4. Autoriza en el navegador
5. VSCode ahora tiene acceso a tu GitHub
```

**Funciones que obtienes:**

- Ver Pull Requests en VSCode
- Crear PRs desde el editor
- Revisar código de PRs
- Ver y crear Issues
- Clonar repositorios fácilmente
- Notificaciones de GitHub

#### Clonar Repositorio desde VSCode

```bash
1. Cmd+Shift+P → "Git: Clone"
2. Pega URL del repositorio
   Ejemplo: https://github.com/usuario/repo.git
3. Selecciona dónde guardarlo
4. VSCode abre el repositorio automáticamente
```

### Usar CLI Tools en Terminal Integrada

#### Abrir Terminal

```bash
# Abrir/cerrar terminal
Ctrl+` (tecla del acento grave)

# O desde menú:
Terminal → New Terminal
```

#### Usar Claude Code en VSCode

```bash
# En la terminal de VSCode:
cd ~/segundo-cerebro
claude

# Claude Code funciona igual que en terminal externa
> "Ayúdame a organizar mis notas"
> /commit
> /help
> /exit
```

**Ventajas en VSCode:**
- Ver archivos mientras hablas con Claude
- Claude crea/edita archivos → los ves actualizar en tiempo real
- Copiar código de Claude directo al editor
- Ver diffs de cambios sugeridos por Claude

#### Usar Git en Terminal de VSCode

```bash
# Todos los comandos de Git funcionan igual:
git status
git add .
git commit -m "Mensaje"
git push

# Ventaja: VSCode actualiza vista de Git automáticamente
```

#### Múltiples Terminales

```bash
# Crear nueva terminal
Click en "+" en panel de terminal
# O: Cmd+Shift+`

# Usar varias terminales simultáneamente:
Terminal 1: claude        # Claude Code corriendo
Terminal 2: git status    # Comandos de Git
Terminal 3: python script.py  # Ejecutar scripts
Terminal 4: npm run dev   # Si tienes proyectos Node.js

# Cambiar entre terminales:
Click en el dropdown de terminales
# O usa: Ctrl+Shift+5 para dividir pantalla
```

#### Terminal Dividida

```bash
# Dividir terminal (ver dos terminales lado a lado):
Click en ícono de "Split Terminal" en panel de terminal
# O: Ctrl+Shift+5

# Ejemplo de uso:
┌──────────────┬──────────────┐
│ claude       │ git status   │
│              │              │
│ Conversación │ Comandos Git │
│ con Claude   │              │
└──────────────┴──────────────┘
```

### Extensiones Recomendadas

#### Instalar Extensiones

```bash
# Desde VSCode:
Click en ícono de extensiones (Cmd+Shift+X)
Buscar el nombre
Click "Install"

# Desde terminal:
code --install-extension [extension-id]
```

#### Extensiones Esenciales

**1. Markdown All in One**
```bash
code --install-extension yzhang.markdown-all-in-one
```
- Preview de Markdown (Cmd+Shift+V)
- Auto-completado de listas
- Tabla de contenidos automática
- Atajos de teclado para Markdown

**2. Markdown Preview Enhanced**
```bash
code --install-extension shd101wyy.markdown-preview-enhanced
```
- Preview avanzado con temas
- Exportar a PDF/HTML
- Diagramas (mermaid, plantuml)
- Matemáticas (LaTeX)

**3. GitHub Pull Requests and Issues**
```bash
code --install-extension GitHub.vscode-pull-request-github
```
- Gestionar PRs desde VSCode
- Ver y crear Issues
- Code review integrado

**4. GitLens**
```bash
code --install-extension eamodio.gitlens
```
- Ver quién cambió cada línea (Git Blame)
- Historial de archivos avanzado
- Comparar commits visualmente
- Navegar historial de Git fácilmente

**5. Spanish Language Pack (Opcional)**
```bash
code --install-extension MS-CEINTL.vscode-language-pack-es
```
- Interfaz de VSCode en español
- Reiniciar VSCode después de instalar

**6. Code Spell Checker**
```bash
code --install-extension streetsidesoftware.code-spell-checker
```
- Corrección ortográfica en inglés

**7. Spanish - Code Spell Checker**
```bash
code --install-extension streetsidesoftware.code-spell-checker-spanish
```
- Corrección ortográfica en español

**8. Todo Tree**
```bash
code --install-extension Gruntfuggly.todo-tree
```
- Encuentra todos los TODOs en tu código
- Perfecto para trackear tareas en archivos Markdown

**9. Path Intellisense**
```bash
code --install-extension christian-kohler.path-intellisense
```
- Auto-completado de rutas de archivos

**10. Live Server (para HTML)**
```bash
code --install-extension ritwickdey.LiveServer
```
- Servidor local para ver HTML
- Recarga automática al guardar

#### Extensiones para Lenguajes Específicos

```bash
# Python
code --install-extension ms-python.python

# JavaScript/TypeScript
code --install-extension dbaeumer.vscode-eslint

# Docker
code --install-extension ms-azuretools.vscode-docker

# YAML (para configuración)
code --install-extension redhat.vscode-yaml
```

### Configuración y Settings

#### Abrir Settings

```bash
# Método 1: Atajo de teclado
Cmd+,

# Método 2: Paleta de comandos
Cmd+Shift+P → "Preferences: Open Settings"

# Método 3: JSON directo (para usuarios avanzados)
Cmd+Shift+P → "Preferences: Open Settings (JSON)"
```

#### Settings Recomendados

**Configuración Visual (desde UI):**

1. **Auto Save** (guardado automático):
   - Busca: "Auto Save"
   - Cambia a: "afterDelay"
   - Delay: 1000ms

2. **Formato al guardar**:
   - Busca: "Format On Save"
   - Activa: ✓ Editor: Format On Save

3. **Tamaño de fuente**:
   - Busca: "Font Size"
   - Editor: Font Size → 14 (o tu preferencia)

4. **Tema de color**:
   - Busca: "Color Theme"
   - Selecciona tu favorito (Dark+, Light+, etc.)

5. **Terminal default**:
   - Busca: "Terminal: Integrated: Default Profile"
   - Selecciona: zsh (o tu shell preferida)

**Configuración JSON (avanzado):**

```json
{
  // Auto-guardado
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,

  // Formateo
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,

  // Fuente
  "editor.fontSize": 14,
  "editor.fontFamily": "Menlo, Monaco, 'Courier New', monospace",

  // Markdown
  "markdown.preview.fontSize": 14,
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": false
  },

  // Terminal
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.shell.osx": "/bin/zsh",

  // Git
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,

  // Spell checker (si instalaste la extensión)
  "cSpell.language": "en,es",

  // Excluir carpetas del explorador
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/__pycache__": true
  }
}
```

Para aplicar esta configuración:
1. Cmd+Shift+P → "Preferences: Open Settings (JSON)"
2. Copia y pega la configuración arriba
3. Guarda (Cmd+S)

### Workspace vs User Settings

VSCode tiene dos niveles de configuración:

**User Settings (Global):**
- Aplican a todos los proyectos
- Se guardan en: `~/Library/Application Support/Code/User/settings.json`

**Workspace Settings (Por proyecto):**
- Solo para el proyecto actual
- Se guardan en: `[tu-proyecto]/.vscode/settings.json`

**Ejemplo de Workspace Settings para tu segundo-cerebro:**

```bash
# Crear carpeta de configuración
mkdir ~/segundo-cerebro/.vscode

# Crear settings
cat > ~/segundo-cerebro/.vscode/settings.json << 'EOF'
{
  "cSpell.language": "en,es",
  "files.exclude": {
    "**/.git": true
  },
  "markdown.preview.fontSize": 16,
  "[markdown]": {
    "editor.wordWrap": "on"
  }
}
EOF
```

### Integración con PARA y Segundo Cerebro

#### Abrir tu Segundo Cerebro

```bash
# Desde terminal
cd ~/segundo-cerebro
code .

# O agregar alias a ~/.zshrc
echo 'alias brain="cd ~/segundo-cerebro && code ."' >> ~/.zshrc
source ~/.zshrc

# Ahora simplemente:
brain
```

#### Navegación PARA en VSCode

**Estructura visible en explorador:**

```
EXPLORADOR
└── segundo-cerebro/
    ├── 📥 00_INBOX/           ← Click para ver items a procesar
    ├── 📋 01_PROYECTOS/       ← Click para ver proyectos activos
    │   ├── aprender-docker/
    │   │   ├── README.md
    │   │   ├── notas/
    │   │   └── ejercicios/
    │   └── crear-api/
    ├── 🔧 02_AREAS/
    │   └── Desarrollo-Web/
    ├── 📚 03_RECURSOS/
    │   └── AI/
    │       ├── claude/
    │       └── git/
    ├── 📦 04_ARCHIVO/
    └── CLAUDE.md
```

**Workflow diario en VSCode:**

```bash
1. Abrir segundo cerebro:
   brain  # (tu alias)

2. Revisar INBOX en explorador:
   Click en 00_INBOX/ → ver archivos sin procesar

3. Arrastrar y organizar:
   - Arrastrar de INBOX a carpeta correcta en PARA
   - VSCode actualiza Git automáticamente

4. Editar notas con Markdown preview:
   - Click en nota .md
   - Cmd+Shift+V para preview lado a lado

5. Usar Claude Code en terminal:
   Ctrl+` → claude
   > "Ayúdame a organizar estas notas"

6. Commit visual:
   Ctrl+Shift+G → ver cambios → commit → push

7. Todo sin salir de VSCode
```

#### Snippets Personalizados para PARA

Crear snippets para notas rápidas:

```bash
# Abrir configuración de snippets
Cmd+Shift+P → "Preferences: Configure User Snippets"
→ Seleccionar "markdown.json"
```

Agregar estos snippets:

```json
{
  "Nota PARA": {
    "prefix": "para",
    "body": [
      "# ${1:Título}",
      "",
      "**Fecha:** ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
      "**Categoría:** ${2|PROYECTO,AREA,RECURSO,ARCHIVO|}",
      "**Tags:** #${3:tag1} #${4:tag2}",
      "",
      "## Contenido",
      "",
      "$0"
    ],
    "description": "Template para nota en sistema PARA"
  },

  "Proyecto Nuevo": {
    "prefix": "proyecto",
    "body": [
      "# ${1:Nombre del Proyecto}",
      "",
      "**Inicio:** ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
      "**Deadline:** ${2:YYYY-MM-DD}",
      "**Estado:** 🔄 En progreso",
      "",
      "## Objetivo",
      "",
      "${3:Descripción del objetivo}",
      "",
      "## Tareas",
      "",
      "- [ ] ${4:Primera tarea}",
      "- [ ] ${5:Segunda tarea}",
      "",
      "## Recursos",
      "",
      "- ",
      "",
      "## Notas",
      "",
      "$0"
    ],
    "description": "Template para nuevo proyecto"
  }
}
```

**Usar snippets:**
```bash
1. Crear nuevo archivo .md
2. Escribir: para
3. Presionar Tab
4. Template se auto-completa
5. Tab para navegar entre campos
```

### Workflow Completo: VSCode + Claude + Git + PARA

#### Ejemplo Real: Crear y Organizar Nuevo Recurso

```bash
# 1. Abrir segundo cerebro en VSCode
brain  # (tu alias: cd ~/segundo-cerebro && code .)

# 2. Crear archivo rápido (Cmd+N)
   - Escribir: para<Tab>  # usa snippet
   - Llenar título: "Docker Compose Guía"
   - Categoría: RECURSO
   - Tags: #docker #devops

# 3. Guardar en ubicación (Cmd+S)
   - Navegar a: 03_RECURSOS/DevOps/docker/
   - Nombre: docker-compose-guia.md

# 4. Editar con preview
   - Cmd+Shift+V → preview lado a lado
   - Escribir contenido en una ventana
   - Ver resultado en la otra

# 5. Pedir ayuda a Claude
   - Ctrl+` → terminal
   - claude
   > "Ayúdame a completar esta guía de Docker Compose.
      Agrega ejemplos prácticos y explicaciones claras"
   - Claude crea/edita el archivo
   - Ves cambios en tiempo real en VSCode

# 6. Ver cambios en Git
   - Ctrl+Shift+G → Source Control
   - Ver diff: click en "docker-compose-guia.md"
   - Verde = lo que Claude agregó

# 7. Commit visual
   - Hover sobre archivo → "+"
   - Mensaje: "Agregar guía de Docker Compose con ejemplos"
   - Cmd+Enter → commit

# 8. Push
   - Click en "..." → Push
   - O click en ícono de sync en barra inferior
```

### Atajos de Teclado Completos

#### Referencia Rápida

```bash
# === GENERALES ===
Cmd+Shift+P          Paleta de comandos
Cmd+P                Búsqueda rápida de archivos
Cmd+,                Abrir settings

# === EXPLORADOR ===
Cmd+Shift+E          Mostrar explorador de archivos
Cmd+B                Toggle barra lateral
Cmd+O                Abrir archivo
Cmd+N                Nuevo archivo

# === EDICIÓN ===
Cmd+S                Guardar
Cmd+Z                Deshacer
Cmd+Shift+Z          Rehacer
Cmd+F                Buscar
Cmd+H                Buscar y reemplazar
Cmd+D                Seleccionar siguiente ocurrencia
Cmd+/                Comentar/descomentar

# === NAVEGACIÓN ===
Cmd+Tab              Cambiar entre archivos abiertos
Ctrl+-               Volver a ubicación anterior
Ctrl+Shift+-         Ir a ubicación siguiente

# === TERMINAL ===
Ctrl+`               Toggle terminal
Cmd+Shift+`          Nueva terminal
Ctrl+Shift+5         Split terminal

# === GIT ===
Ctrl+Shift+G         Abrir source control
Cmd+Enter            Commit (cuando estás en mensaje)

# === MARKDOWN ===
Cmd+Shift+V          Preview de Markdown
Cmd+K V              Preview lado a lado
```

Puedes imprimir esta referencia y mantenerla cerca mientras aprendes.

### Solución de Problemas

#### VSCode no abre desde terminal

```bash
# Reinstalar comando 'code'
# En VSCode:
Cmd+Shift+P → "Shell Command: Install 'code' command in PATH"

# Verificar
code --version
```

#### Git no funciona en VSCode

```bash
# Verificar que Git está instalado
git --version

# Verificar configuración en VSCode
Cmd+, → buscar "git.path"
# Debe estar vacío o apuntar a: /usr/bin/git

# Si no funciona, reiniciar VSCode
```

#### Terminal no muestra colores

```bash
# Agregar a settings.json:
"terminal.integrated.env.osx": {
  "TERM": "xterm-256color"
}
```

#### Extensiones no se instalan

```bash
# Desde terminal, forzar instalación:
code --install-extension [extension-id] --force

# Ver extensiones instaladas:
code --list-extensions
```

---

## 6. Método PARA

### ¿Qué es PARA?

PARA es un método de organización del conocimiento desarrollado por Tiago Forte. Es simple pero poderoso.

### Las 4 Categorías

```
tu-segundo-cerebro/
├── 01_PROYECTOS/      # Projects - con fecha de fin
├── 02_AREAS/          # Areas - responsabilidades continuas
├── 03_RECURSOS/       # Resources - temas de interés
└── 04_ARCHIVO/        # Archive - items inactivos
```

#### 1. PROYECTOS (Projects)

**Definición:** Tareas con un objetivo específico y fecha límite.

**Características:**
- Tienen una meta clara
- Tienen fecha de inicio y fin
- Se pueden completar

**Ejemplos:**
```
01_PROYECTOS/
├── landing-page-negocio/
│   ├── README.md
│   ├── diseños/
│   ├── contenido/
│   └── codigo/
├── aprender-docker/
│   ├── notas-curso.md
│   ├── ejercicios/
│   └── proyecto-final/
└── configurar-servidor-casa/
    ├── lista-compras.md
    ├── configuracion.md
    └── scripts/
```

#### 2. AREAS (Areas)

**Definición:** Áreas de responsabilidad continua sin fecha de fin.

**Características:**
- Responsabilidades constantes
- Requieren mantenimiento
- No tienen "completado"

**Ejemplos:**
```
02_AREAS/
├── Desarrollo-Software/
│   ├── Python/
│   ├── JavaScript/
│   └── mejores-practicas.md
├── Finanzas-Personales/
│   ├── presupuesto.md
│   └── inversiones.md
├── Salud/
│   ├── ejercicio.md
│   └── nutricion.md
└── Carrera-Profesional/
    ├── skills-desarrollar.md
    └── red-contactos.md
```

#### 3. RECURSOS (Resources)

**Definición:** Temas de interés, hobbies, conocimiento de referencia.

**Características:**
- Información útil para el futuro
- No requieren acción inmediata
- Base de conocimiento

**Ejemplos:**
```
03_RECURSOS/
├── AI/
│   ├── claude/
│   ├── chatgpt/
│   └── ollama/
├── DevOps/
│   ├── docker/
│   ├── kubernetes/
│   └── CI-CD/
├── Diseño/
│   ├── UI-UX/
│   └── herramientas.md
└── Idiomas/
    ├── ingles/
    └── frances/
```

#### 4. ARCHIVO (Archive)

**Definición:** Proyectos completados o items inactivos.

**Características:**
- Ya no están activos
- Se guardan por referencia
- Mantienen estructura original

**Ejemplos:**
```
04_ARCHIVO/
├── 2024/
│   ├── sitio-web-antiguo/
│   └── curso-react-2024/
└── 2023/
    └── proyecto-escuela/
```

### Flujo de Trabajo PARA

```bash
# 1. Captura (00_INBOX opcional)
mkdir -p 00_INBOX
echo "Idea rápida sobre Docker" > 00_INBOX/docker-idea.md

# 2. Procesar (decidir categoría)
# ¿Es un proyecto con fecha límite? → 01_PROYECTOS/
# ¿Es una responsabilidad continua? → 02_AREAS/
# ¿Es referencia para después? → 03_RECURSOS/
# ¿Ya no es activo? → 04_ARCHIVO/

# 3. Mover a lugar correcto
mv 00_INBOX/docker-idea.md 03_RECURSOS/DevOps/docker/

# 4. Cuando proyecto termina
mv 01_PROYECTOS/landing-page-negocio/ 04_ARCHIVO/2024/
```

### Ejemplo de Estructura Completa

```
mi-segundo-cerebro/
├── 00_INBOX/
│   └── para-procesar/
├── 01_PROYECTOS/
│   ├── crear-portfolio/
│   │   ├── README.md
│   │   ├── diseño.md
│   │   └── contenido/
│   └── aprender-python/
│       ├── ejercicios/
│       └── notas.md
├── 02_AREAS/
│   ├── Desarrollo-Web/
│   │   ├── frontend/
│   │   └── backend/
│   └── Home-Lab/
│       └── configuraciones/
├── 03_RECURSOS/
│   ├── AI/
│   │   ├── claude-code/
│   │   ├── gemini/
│   │   └── opencode/
│   ├── Git-GitHub/
│   │   ├── comandos-utiles.md
│   │   └── workflows.md
│   └── Terminal/
│       ├── zsh-config.md
│       └── aliases.md
├── 04_ARCHIVO/
│   └── 2024/
│       └── proyectos-terminados/
└── CLAUDE.md  # Instrucciones para Claude Code
```

---

## 7. Integración: Todo Junto

### Flujo de Trabajo Completo

#### Día 1: Configuración

```bash
# 1. Crear estructura PARA
mkdir -p ~/segundo-cerebro/{00_INBOX,01_PROYECTOS,02_AREAS,03_RECURSOS,04_ARCHIVO}
cd ~/segundo-cerebro

# 2. Inicializar Git
git init
git add .
git commit -m "Estructura inicial PARA"

# 3. Crear repositorio en GitHub y conectar
git remote add origin git@github.com:tu-usuario/segundo-cerebro.git
git push -u origin main

# 4. Crear CLAUDE.md
cat > CLAUDE.md << 'EOF'
# Mi Segundo Cerebro

Sistema de gestión del conocimiento usando el método PARA.

## Estructura
- 00_INBOX/ - Captura rápida
- 01_PROYECTOS/ - Proyectos activos con deadline
- 02_AREAS/ - Responsabilidades continuas
- 03_RECURSOS/ - Base de conocimiento
- 04_ARCHIVO/ - Items completados

## Instrucciones para Claude
- Ayúdame a organizar información según PARA
- Sugiere dónde poner nuevas notas
- Mantén la estructura limpia
EOF

git add CLAUDE.md
git commit -m "Agregar instrucciones para Claude"
git push
```

#### Día a Día: Captura y Organización

```bash
# 1. Capturar idea rápida
cd ~/segundo-cerebro
echo "# Docker Compose para Dev\n\nAnotar comandos útiles..." > 00_INBOX/docker-notes.md

# 2. Usar Claude Code para organizar
claude
> "Ayúdame a organizar las notas de Docker. ¿Dónde deberían ir según el método PARA?"
> "Crea una estructura para un recurso de Docker en 03_RECURSOS/"

# 3. Commit con Claude
> /commit
# Claude generará un mensaje descriptivo

# 4. Push a GitHub
git push

# 5. Buscar información
claude
> "¿Qué notas tengo sobre APIs REST?"
> "Resume mis notas de Python"

# 6. Crear nuevo proyecto
mkdir -p 01_PROYECTOS/api-clima
cd 01_PROYECTOS/api-clima
claude
> "Ayúdame a crear un API del clima con FastAPI. Crea la estructura inicial."
```

#### Ejemplo: Nuevo Proyecto de Aprendizaje

```bash
# 1. Crear proyecto
mkdir -p ~/segundo-cerebro/01_PROYECTOS/aprender-kubernetes
cd ~/segundo-cerebro/01_PROYECTOS/aprender-kubernetes

# 2. Iniciar Claude Code
claude

# 3. Pedir estructura
> "Necesito aprender Kubernetes. Crea una estructura de proyecto de aprendizaje con:
- README con objetivos
- Directorio de notas por tema
- Directorio de ejercicios prácticos
- Lista de recursos
- Tracking de progreso"

# 4. Commit
> /commit

# 5. Trabajar con los recursos
> "Resume qué es Kubernetes en términos simples"
> "Guarda el resumen en notas/01-introduccion.md"

# 6. Cuando termines el aprendizaje
cd ~/segundo-cerebro
mv 01_PROYECTOS/aprender-kubernetes 04_ARCHIVO/2024/
git add .
git commit -m "Archivar proyecto Kubernetes completado"
git push
```

### Script de Ayuda Diario

Crea un script para facilitar el flujo:

```bash
# Crear script
cat > ~/segundo-cerebro/quick-capture.sh << 'EOF'
#!/bin/bash

# Script de captura rápida para segundo cerebro
BRAIN_DIR=~/segundo-cerebro
INBOX=$BRAIN_DIR/00_INBOX

# Captura rápida
if [ "$1" == "capture" ]; then
    echo "# $2" > "$INBOX/$(date +%Y%m%d_%H%M%S)-$2.md"
    echo "" >> "$INBOX/$(date +%Y%m%d_%H%M%S)-$2.md"
    code "$INBOX/$(date +%Y%m%d_%H%M%S)-$2.md"

# Procesar inbox con Claude
elif [ "$1" == "process" ]; then
    cd $BRAIN_DIR
    claude -c "Ayúdame a procesar y organizar los archivos en 00_INBOX/ según el método PARA"

# Status de proyectos
elif [ "$1" == "status" ]; then
    echo "📂 Proyectos activos:"
    ls -1 $BRAIN_DIR/01_PROYECTOS/
    echo ""
    echo "📥 Items en inbox:"
    ls -1 $INBOX/ | wc -l

# Commit y push rápido
elif [ "$1" == "save" ]; then
    cd $BRAIN_DIR
    git add .
    git commit -m "${2:-Actualización rápida}"
    git push

else
    echo "Uso: quick-capture.sh [capture|process|status|save] [args]"
fi
EOF

chmod +x ~/segundo-cerebro/quick-capture.sh

# Crear alias
echo "alias brain='~/segundo-cerebro/quick-capture.sh'" >> ~/.zshrc
source ~/.zshrc
```

Uso del script:

```bash
# Captura rápida
brain capture "idea-sobre-docker"

# Procesar inbox
brain process

# Ver status
brain status

# Guardar cambios
brain save "Notas de Kubernetes"
```

---

## 8. Mejores Prácticas

### Seguridad

```bash
# NUNCA subas API keys a GitHub
# Crear .env para secrets
echo "CLAUDE_API_KEY=tu-key-aqui" > .env

# Agregar a .gitignore
echo ".env" >> .gitignore
echo "*.key" >> .gitignore
echo "secrets/" >> .gitignore

# Commit .gitignore
git add .gitignore
git commit -m "Agregar .gitignore para seguridad"
```

### Organización de Archivos

```markdown
# Nombrar archivos con kebab-case
bueno: mi-nota-sobre-docker.md
malo: Mi Nota Sobre Docker.md

# Usar prefijos numéricos para orden
01-introduccion.md
02-conceptos-basicos.md
03-ejemplos-practicos.md

# Agregar metadata al inicio
---
fecha: 2024-01-15
tags: #python #api #tutorial
estado: en-progreso
---

# Título del Documento
```

### Commits Descriptivos

```bash
# Buenos commits
git commit -m "Agregar guía de instalación de Docker"
git commit -m "Actualizar notas de Python con ejemplos de decoradores"
git commit -m "Archivar proyecto de portfolio - completado"

# Malos commits
git commit -m "update"
git commit -m "fixes"
git commit -m "cambios varios"

# Usar Claude Code para commits
claude
> /commit
# Claude analizará los cambios y creará un mensaje descriptivo
```

### Revisión Semanal

```bash
# Script de revisión semanal
cat > ~/segundo-cerebro/weekly-review.sh << 'EOF'
#!/bin/bash

echo "🔍 REVISIÓN SEMANAL"
echo "==================="
echo ""

cd ~/segundo-cerebro

echo "📋 Proyectos activos:"
ls -1 01_PROYECTOS/

echo ""
echo "📥 Items en inbox (procesar):"
ls -1 00_INBOX/ 2>/dev/null | wc -l

echo ""
echo "📊 Commits esta semana:"
git log --since="1 week ago" --oneline

echo ""
echo "💡 Usar Claude para revisar progreso:"
echo "   claude"
echo '   > "Resume mi progreso de proyectos esta semana"'
EOF

chmod +x ~/segundo-cerebro/weekly-review.sh
```

---

## 9. Recursos Adicionales

### Documentación Oficial

- **Claude Code:** [claude.ai/code](https://claude.ai/code)
- **VSCode:** [code.visualstudio.com/docs](https://code.visualstudio.com/docs)
- **Git:** [git-scm.com/doc](https://git-scm.com/doc)
- **GitHub:** [docs.github.com](https://docs.github.com)
- **Método PARA:** [fortelabs.com/blog/para](https://fortelabs.com/blog/para/)

### Comunidades

- **GitHub Discussions** - Para cada herramienta
- **Reddit:** r/SecondBrain, r/git, r/learnprogramming
- **Discord:** Comunidades de AI tools

### Libros Recomendados

- **"Building a Second Brain"** - Tiago Forte (método PARA)
- **"Pro Git"** - Scott Chacon (Git gratis online)
- **"The Pragmatic Programmer"** - Hunt & Thomas

### Cursos (Gratis)

- **Git/GitHub:** [learngitbranching.js.org](https://learngitbranching.js.org/)
- **Terminal/Shell:** [cmdchallenge.com](https://cmdchallenge.com/)
- **Markdown:** [markdowntutorial.com](https://markdowntutorial.com/)

---

## 10. Solución de Problemas Comunes

### Claude Code

```bash
# Error: "API key not found"
claude configure
# Vuelve a ingresar tu API key

# Error: "Command not found: claude"
npm list -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code

# Claude no ve mis archivos
# Asegúrate de estar en el directorio correcto
pwd
# Inicia Claude desde la raíz del proyecto
```

### Git/GitHub

```bash
# Error: "Permission denied (publickey)"
# Verificar SSH
ssh -T git@github.com
# Si falla, regenerar SSH keys (ver sección 4)

# Error: "Updates were rejected"
# Alguien más hizo cambios, bajar primero
git pull
# Resolver conflictos si hay
git push

# Ver qué cambió
git diff

# Deshacer último commit (mantener cambios)
git reset --soft HEAD~1

# Deshacer cambios en archivo (PELIGROSO)
git checkout -- archivo.txt
```

### Problemas de Organización

```bash
# ¿Dónde va esta nota?
# Pregúntate:
# - ¿Tiene fecha de fin? → PROYECTOS
# - ¿Es responsabilidad continua? → AREAS
# - ¿Es solo referencia? → RECURSOS
# - ¿Ya terminó/está inactivo? → ARCHIVO

# Si dudas, ponlo en INBOX y procesa después
mv nota.md 00_INBOX/

# Usa Claude para ayudar
claude
> "¿En qué categoría PARA debería poner estas notas sobre Docker?"
```

---

## 11. Próximos Pasos

### Primera Semana

- [ ] Instalar todas las herramientas (Claude Code, Git, VSCode)
- [ ] Configurar Git y GitHub (SSH keys)
- [ ] Configurar VSCode (extensiones básicas: Markdown, GitLens, GitHub)
- [ ] Crear estructura PARA
- [ ] Hacer primer commit desde VSCode
- [ ] Practicar con Claude Code en terminal de VSCode

### Primer Mes

- [ ] Crear 3 proyectos en PROYECTOS/
- [ ] Organizar recursos en RECURSOS/
- [ ] Hacer commits diarios
- [ ] Revisar progreso semanalmente
- [ ] Archivar primer proyecto completado

### Largo Plazo

- [ ] Automatizar workflows con scripts
- [ ] Integrar más herramientas AI
- [ ] Contribuir a proyectos open source en GitHub
- [ ] Desarrollar tu sistema personalizado
- [ ] Enseñar a otros lo que aprendiste

---

## Conclusión

Has aprendido los fundamentos de:

✅ **Claude Code** - Asistente AI en terminal
✅ **Git/GitHub** - Control de versiones y colaboración
✅ **Visual Studio Code** - Editor integrado con todas las herramientas
✅ **Método PARA** - Organización del conocimiento
✅ **Flujos de trabajo** - Integración de herramientas

### Recuerda

1. **Empieza simple** - No trates de hacer todo perfecto desde el inicio
2. **Consistencia > Perfección** - Mejor poco y frecuente que mucho y ocasional
3. **Itera y mejora** - Tu sistema evolucionará con el tiempo
4. **Usa las herramientas** - Claude Code puede ayudarte en cada paso

### Comando de Inicio Rápido

```bash
# Tu comando diario
cd ~/segundo-cerebro
claude
> "¿Qué debería trabajar hoy? Muéstrame mis proyectos activos"
```

---

**¡Buena suerte en tu viaje de gestión del conocimiento y desarrollo con AI! 🚀**

**Preguntas?** Usa Claude Code para ayudarte:
```bash
claude
> "Explícame [tu pregunta aquí]"
```
