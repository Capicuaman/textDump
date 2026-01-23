# Guía de Estrategia: Canva Bulk Create para TikTok Videos
## BILAN Electrolitos | Enero 2025

---

## Tabla de Contenidos

1. [Introducción](#introducción)
2. [Preparación del CSV](#preparación-del-csv)
3. [Diseño de Plantilla en Canva](#diseño-de-plantilla-en-canva)
4. [Workflow de Bulk Create](#workflow-de-bulk-create)
5. [Mejores Prácticas para TikTok](#mejores-prácticas-para-tiktok)
6. [Exportación y Distribución](#exportación-y-distribución)
7. [Control de Calidad](#control-de-calidad)
8. [Troubleshooting](#troubleshooting)

---

## Introducción

### ¿Qué es Canva Bulk Create?

Canva Bulk Create es una herramienta que te permite generar múltiples variaciones de un diseño usando datos de un archivo CSV. En lugar de crear 10 videos TikTok manualmente uno por uno, puedes:

1. Diseñar **una plantilla maestra**
2. Preparar un **CSV con todos los datos** (ya completado: `canva-bulk-create.csv`)
3. **Generar automáticamente** los 10 videos con un solo clic

### Diferencia: Static Posts vs. Video Creation

**Para Instagram/Posts estáticos:** Usas elementos de texto simples que se reemplazan directamente.

**Para TikTok Videos:** Necesitas considerar:
- Timing de animaciones de texto
- Overlays con timestamps
- Transiciones entre secciones
- Subtítulos y captions dinámicos
- Audio sincronizado (opcional)

### Beneficios para Este Proyecto

- **Ahorro de tiempo:** 10 videos en 30 minutos en lugar de 5 horas
- **Consistencia:** Mismo branding y estilo visual en todos los videos
- **Testing eficiente:** Permite enfocarte en analizar engagement en lugar de producción
- **Escalabilidad:** Fácil crear el próximo lote de 10 videos cuando tengas los resultados

---

## Preparación del CSV

### Archivo Existente

Ya tienes el archivo listo: **`canva-bulk-create.csv`**

**Ubicación:** `01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/TikTok/testing/canva-bulk-create.csv`

### Estructura de Columnas

| Columna | Propósito | Ejemplo |
|---------|-----------|---------|
| `Video Number` | Identificador único | 1 |
| `Title` | Título del video (para organización) | "LA VERDAD SOBRE LA SAL..." |
| `Duration` | Duración del video | "60 segundos" |
| `Hook A` | Primera variante de hook | "¿Por qué nos dijeron..." |
| `Hook B` | Segunda variante de hook | "¿Sabías que la sal..." |
| `Hook C` | Tercera variante de hook | "El 80% de los mexicanos..." |
| `Key Message` | Mensaje principal del video | "El sodio que pierdes al sudar..." |
| `Overlay 1-5` | Texto superpuesto con timestamps | "[0:00-0:03] ¿LA SAL ES MALA?" |
| `CTA Text` | Call-to-action final | "Dime en los comentarios..." |
| `Hashtags` | Lista completa de hashtags | "#Hidratacion #Electrolitos..." |

### Cómo Usar las Columnas en Canva

En tu plantilla de Canva, crearás elementos de texto con estos placeholders:

```
{{Video Number}}
{{Title}}
{{Duration}}
{{Hook A}}  ← Usarás este para tus primeras 10 videos
{{Key Message}}
{{Overlay 1}}
{{Overlay 2}}
{{Overlay 3}}
{{Overlay 4}}
{{Overlay 5}}
{{CTA Text}}
{{Hashtags}}
```

**Nota:** Por ahora usa **Hook A** para todos. Después de analizar resultados, puedes crear nuevos lotes con Hook B y Hook C para A/B testing.

---

## Diseño de Plantilla en Canva

### Paso 1: Crear Nuevo Diseño

1. Abrir Canva
2. Seleccionar **"Video"** → **"TikTok Video"**
3. Especificaciones:
   - **Dimensiones:** 1080 x 1920 px (9:16)
   - **Duración:** 60 segundos (para videos largos), 30s o 15s (para videos cortos)
   - **Frame rate:** 30 fps

### Paso 2: Estructura de la Plantilla

#### Sección 1: HOOK (0-3 segundos)

**Elementos:**
- Fondo llamativo (gradient o color sólido BILAN)
- Texto grande con placeholder `{{Hook A}}`
- Emoji o ícono relevante (opcional)

**Configuración de Texto:**
```
Font: Montserrat Bold o similar (sans-serif)
Size: 80-100 pt
Color: Blanco (#FFFFFF) o BILAN azul
Position: Centro de pantalla
Animation: "Pop" o "Rise" al entrar (0.5s duration)
```

#### Sección 2: OVERLAYS (3-50 segundos)

**5 páginas/slides con overlays:**

Cada overlay debe tener:
- **Fondo:** Video stock, B-roll, o imagen relevante
- **Text Box:** Con placeholder `{{Overlay 1}}`, `{{Overlay 2}}`, etc.
- **Timing:** Basado en los timestamps en el CSV

**Ejemplo de timing para Video #1:**
- Página 2 (3-12s): `{{Overlay 1}}` - "[0:00-0:03] ¿LA SAL ES MALA?"
- Página 3 (12-20s): `{{Overlay 2}}` - "[0:12] 500-1000mg de sodio por litro de sudor"
- Página 4 (20-28s): `{{Overlay 3}}` - "[0:20] 2000mg de sodio perdidos por hora"
- Página 5 (28-43s): `{{Overlay 4}}` - "[0:28] Bebidas deportivas: 20-50mg 🤔"
- Página 6 (43-52s): `{{Overlay 5}}` - "[0:43] BILAN: 1000mg de sodio"

**Configuración de Overlays:**
```
Font: Montserrat SemiBold
Size: 60-70 pt
Color: Blanco con stroke negro (para legibilidad)
Position: Tercio inferior de pantalla (zona segura para UI de TikTok)
Background: Semi-transparent black box (opacity 40-60%)
Animation: "Fade in" al entrar, "Fade out" al salir
```

#### Sección 3: CTA (últimos 8-10 segundos)

**Elementos:**
- Texto con placeholder `{{CTA Text}}`
- Logo BILAN
- "Link en bio" (si aplica)
- Botón "Sígueme" (sugerencia visual)

**Configuración:**
```
Font: Montserrat Regular
Size: 50-60 pt
Color: BILAN brand colors
Position: Centro con logo abajo
Animation: "Bounce" o "Wobble" para llamar atención
```

#### Sección 4: Hashtags (no visible en video, pero en caption)

**Nota:** Los hashtags no necesitan aparecer en el video, pero puedes incluirlos en la descripción del post cuando subas a TikTok. El placeholder `{{Hashtags}}` se usa para copiar/pegar fácilmente.

### Paso 3: Branding BILAN

**Colores de Marca:**
- Azul primario: `#0066CC` (o el color oficial de BILAN)
- Azul secundario: `#004499`
- Blanco: `#FFFFFF`
- Negro: `#000000`

**Logo:**
- Posición: Esquina superior derecha o inferior centro
- Tamaño: 150-200 px de ancho
- Opacity: 80-100% (visible pero no invasivo)

**Tipografía:**
- Primaria: Montserrat (Bold, SemiBold, Regular)
- Alternativa: Poppins, Inter, o Roboto

### Paso 4: Animaciones Recomendadas

**Para texto de hook:**
- "Pop" - Aparece con efecto de crecimiento rápido
- "Rise" - Sube desde abajo
- "Typewriter" - Aparece letra por letra (solo para texto corto)

**Para overlays:**
- "Fade" - Transición suave
- "Slide" - Entra desde un lado
- "Wipe" - Transición tipo cortina

**Para CTA:**
- "Bounce" - Rebote sutil para llamar atención
- "Pulse" - Pulsación continua
- "Wobble" - Movimiento de lado a lado

**Velocidad recomendada:** 0.3-0.5 segundos para entradas/salidas

### Paso 5: Elementos Visuales Adicionales

**B-Roll / Fondo:**
- Videos de stock relacionados con fitness/gym/deportes
- Imágenes de atletas hidratándose
- Gráficos animados de sodio/electrolitos
- Productos BILAN (si tienes fotos/videos)

**Fuentes de video stock gratuito:**
- Pexels.com
- Pixabay.com
- Canva's built-in library

**Elementos decorativos:**
- Líneas divisorias
- Íconos de gotas de agua, sal, electrolitos
- Emojis estratégicos (💧, 🔋, 💪, ⚡)
- Flechas o indicadores

---

## Workflow de Bulk Create

### Paso 1: Preparar Plantilla

1. Completar el diseño con todos los placeholders: `{{Hook A}}`, `{{Overlay 1}}`, etc.
2. Verificar que todos los elementos estén correctamente nombrados
3. Revisar timing y animaciones
4. Guardar plantilla con nombre claro: **"BILAN_TikTok_Template_2025-01"**

### Paso 2: Conectar CSV

1. En Canva, con tu plantilla abierta, ir a **"Apps"** (barra lateral izquierda)
2. Buscar **"Bulk Create"** (o "Crear en masa")
3. Click en la app Bulk Create
4. Seleccionar **"Upload CSV"** o **"Connect Data Source"**
5. Subir tu archivo: `canva-bulk-create.csv`

### Paso 3: Mapear Columnas

Canva te mostrará una interfaz para conectar las columnas del CSV con los elementos de tu plantilla:

```
CSV Column          →  Canva Element
─────────────────────────────────────
Video Number        →  {{Video Number}}
Title               →  {{Title}}
Duration            →  {{Duration}}
Hook A              →  {{Hook A}}
Key Message         →  {{Key Message}}
Overlay 1           →  {{Overlay 1}}
Overlay 2           →  {{Overlay 2}}
Overlay 3           →  {{Overlay 3}}
Overlay 4           →  {{Overlay 4}}
Overlay 5           →  {{Overlay 5}}
CTA Text            →  {{CTA Text}}
Hashtags            →  {{Hashtags}}
```

**Verificar:**
- Todas las columnas están mapeadas correctamente
- No hay errores de encoding (caracteres especiales españoles: á, é, í, ó, ú, ñ, ¿, ¡)
- Preview de al menos 2-3 videos se ve correcto

### Paso 4: Generar Videos

1. Click en **"Generate"** o **"Generar Diseños"**
2. Canva creará 10 instancias de tu plantilla, cada una con los datos de una fila del CSV
3. Tiempo estimado: 2-5 minutos dependiendo de la complejidad

### Paso 5: Revisión Individual

Canva te mostrará todos los 10 videos en una grid view:

**Checklist de revisión rápida:**
- [ ] Texto se ve completo (no cortado)
- [ ] Overlays están en el orden correcto
- [ ] Timing parece correcto
- [ ] Logo BILAN visible
- [ ] Colores de marca consistentes
- [ ] Animaciones funcionan

**Si algo está mal:**
- Ajustar la plantilla maestra
- Re-generar desde el CSV
- O editar videos individuales si es un cambio menor

### Paso 6: Exportación en Masa

1. Seleccionar los 10 videos (checkbox en cada uno)
2. Click en **"Download"** o **"Descargar"**
3. Configuración de exportación:
   - **Formato:** MP4
   - **Calidad:** 1080p (High quality)
   - **Frame rate:** 30 fps
   - **Nombre de archivo:** `BILAN_Video_{{Video Number}}_{{Title}}`

4. Click en **"Export All"**
5. Canva generará los archivos (puede tardar 5-10 minutos)

### Paso 7: Organización de Archivos

Una vez descargados:

```
01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/
├── BILAN_Video_1_LA_VERDAD_SOBRE_LA_SAL.mp4
├── BILAN_Video_2_3_SENALES_DESHIDRATACION.mp4
├── BILAN_Video_3_MITO_8_VASOS.mp4
├── BILAN_Video_4_TRAMPA_BEBIDAS_DEPORTIVAS.mp4
├── BILAN_Video_5_CURE_CALAMBRES.mp4
├── BILAN_Video_6_TRANSFORMACION_GYM.mp4
├── BILAN_Video_7_TIP_15_SEGUNDOS.mp4
├── BILAN_Video_8_SECRETO_ATLETAS.mp4
├── BILAN_Video_9_POV_OLVIDAS_ELECTROLITOS.mp4
└── BILAN_Video_10_TUTORIAL_HIDRATACION.mp4
```

---

## Mejores Prácticas para TikTok

### Diseño Visual

#### 1. Zona Segura para UI de TikTok

TikTok tiene elementos de interfaz que tapan partes de tu video:

**Evitar estas zonas:**
- **Top 100px:** Username, botón "Follow"
- **Bottom 200px:** Caption, hashtags, botones de compartir/like/comentar
- **Right 80px:** Columna de botones (like, comment, share, profile)

**Zona segura para texto:**
- Centro vertical: 300px - 1400px de altura
- Centro horizontal: 100px - 980px de ancho

#### 2. Tamaño de Texto para Móvil

| Tipo de Texto | Tamaño Mínimo | Recomendado | Máximo |
|---------------|---------------|-------------|--------|
| Hook principal | 70pt | 80-100pt | 120pt |
| Overlays | 50pt | 60-70pt | 90pt |
| CTA | 45pt | 50-60pt | 80pt |
| Subtítulos | 40pt | 45-50pt | 60pt |

**Nota:** Prueba siempre en tu teléfono antes de publicar.

#### 3. Contraste y Legibilidad

**Para texto sobre video/imagen:**
- Usar stroke (contorno) negro de 8-12px en texto blanco
- O usar caja semi-transparente negra detrás del texto (opacity 40-60%)
- Evitar texto amarillo claro, verde claro, o tonos pastel (difíciles de leer)

**Combinaciones recomendadas:**
```
✅ Blanco con stroke negro
✅ Blanco sobre fondo negro semi-transparente
✅ Negro sobre fondo blanco/amarillo brillante
✅ BILAN azul sobre fondo blanco
❌ Amarillo claro sobre blanco
❌ Gris sobre gris
❌ Rojo sobre verde
```

#### 4. Animaciones y Timing

**Hook (primeros 3 segundos):**
- Aparición rápida (0.3-0.5s)
- Movimiento dinámico
- Debe captar atención INMEDIATAMENTE

**Overlays (cuerpo del video):**
- Transiciones suaves (0.3s fade)
- Duración en pantalla: mínimo 3 segundos, máximo 10 segundos
- Sincronizar con el mensaje de audio/voiceover (si aplica)

**CTA (últimos 5-8 segundos):**
- Animación que llama atención (bounce, pulse)
- Duración en pantalla: 5-8 segundos
- Incluir llamado claro a la acción

### Contenido

#### 5. Hook Testing

Tu CSV tiene 3 hooks por video (A, B, C). Estrategia sugerida:

**Fase 1 (Enero):**
- Publicar los 10 videos con **Hook A**
- Medir engagement de cada uno

**Fase 2 (Febrero):**
- Para los 3 videos con mejor engagement, crear variantes con Hook B y Hook C
- A/B testing de hooks en videos ya validados

#### 6. Timing de Texto Overlays

Los timestamps en el CSV son guías. Ajustes recomendados:

**Para videos de 60 segundos:**
- Hook: 0-3s
- Overlay 1: 3-12s (9 segundos)
- Overlay 2: 12-22s (10 segundos)
- Overlay 3: 22-33s (11 segundos)
- Overlay 4: 33-45s (12 segundos)
- Overlay 5: 45-52s (7 segundos)
- CTA: 52-60s (8 segundos)

**Para videos de 30 segundos:**
- Hook: 0-3s
- Overlays: 3-4 segundos cada uno (máximo 3 overlays)
- CTA: últimos 5-6s

**Para videos de 15 segundos:**
- Hook: 0-3s
- 1-2 overlays: 3-4 segundos cada uno
- CTA: últimos 4-5s

#### 7. Subtítulos y Accesibilidad

**Agregar subtítulos:**
- TikTok tiene herramienta de auto-captions (usa después de subir)
- O puedes agregar manualmente en Canva
- Font pequeño (35-40pt) en la zona segura

**Beneficios:**
- 85% de videos se ven sin sonido inicialmente
- Mejor accesibilidad
- Mejor retención

### Estrategia de Publicación

#### 8. Calendario de Testing

**Semana 1 (23-29 Enero):**
- Día 1 (Lunes): Videos #1, #2 (8 AM, 6 PM)
- Día 3 (Miércoles): Videos #3, #4 (12 PM, 8 PM)
- Día 5 (Viernes): Videos #5, #6 (8 AM, 7 PM)

**Semana 2 (30 Enero - 5 Febrero):**
- Día 1 (Lunes): Videos #7, #8 (8 AM, 6 PM)
- Día 4 (Jueves): Videos #9, #10 (12 PM, 8 PM)

**Razón:** Distribuir publicación permite:
- Evitar saturar tu audiencia
- Probar diferentes horarios
- Medir engagement de forma aislada

#### 9. Mejores Horarios para México

Según estudios de TikTok México (2024-2025):

**Horarios primarios:**
- **6:00-9:00 AM:** Commute, desayuno
- **12:00-2:00 PM:** Lunch break
- **6:00-9:00 PM:** Después del trabajo/gym
- **9:00-11:00 PM:** Antes de dormir

**Días con mejor engagement:**
- **Lunes, Miércoles, Viernes:** Mejor para contenido educativo
- **Sábado, Domingo:** Mejor para contenido de fitness/gym (audiencia activa)

**Días a evitar:**
- Martes (bajo engagement general)
- Domingos en la mañana (gente ocupada con familia)

#### 10. Caption y Hashtags

**Estructura de caption:**
```
[Hook del video o pregunta]

[1-2 líneas de contexto adicional]

[CTA específico]

[Hashtags del CSV]
```

**Ejemplo para Video #1:**
```
¿Por qué los atletas profesionales consumen sal a montones? 🤔

La ciencia detrás del sodio te va a sorprender.

Dime en los comentarios si ya sabías esto o te vendieron el cuento de que toda la sal es mala 👇

#Hidratacion #Electrolitos #FitnessMexico #SodioSaludable #Nutricion #GymTok #DeportesMexico #HidratacionOptima #SaludYBienestar #BilanElectrolitos #ElectrolitosNaturales #HydrationTips #FitnessEspañol #GymMexico
```

**Límite de caracteres:** TikTok permite 2,200 caracteres, pero las mejores captions son de 150-300 caracteres.

**Número de hashtags:**
- Óptimo: 12-15 hashtags
- Mezclar: Hashtags grandes (#FitnessMexico), medianos (#ElectrolitosNaturales), pequeños (#BilanElectrolitos)

---

## Exportación y Distribución

### Configuración de Exportación en Canva

**Configuración recomendada:**
```
Formato: MP4 (H.264)
Resolución: 1080 x 1920 (Full HD)
Frame Rate: 30 fps
Bitrate: 8-12 Mbps (high quality)
Audio: AAC 320 kbps (si aplica)
```

**Tamaño estimado por video:**
- 15 segundos: 3-5 MB
- 30 segundos: 8-12 MB
- 60 segundos: 15-25 MB

### Naming Convention

**Formato de archivo:**
```
BILAN_Video_[Número]_[Título_Corto]_[Fecha].mp4
```

**Ejemplos:**
```
BILAN_Video_1_Verdad_Sal_2025-01-23.mp4
BILAN_Video_2_3_Senales_2025-01-23.mp4
BILAN_Video_3_Mito_8_Vasos_2025-01-23.mp4
```

**Beneficio:** Fácil identificar y organizar en tu carpeta de videos.

### Organización de Carpetas

**Estructura recomendada:**
```
01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/TikTok/testing/
├── videos/
│   ├── batch_2025-01-23/
│   │   ├── BILAN_Video_1_Verdad_Sal.mp4
│   │   ├── BILAN_Video_2_3_Senales.mp4
│   │   └── ... (10 videos)
│   └── batch_2025-02-15/  (próximo lote)
├── captions/
│   ├── video_1_caption.txt
│   ├── video_2_caption.txt
│   └── ... (10 captions)
├── thumbnails/ (opcional)
│   ├── video_1_thumb.jpg
│   └── ...
└── analytics/
    └── engagement-tracking-2025-01-es-MX.md
```

### Subida a TikTok

#### Opción 1: TikTok App (Móvil)

**Ventajas:**
- Acceso a todas las features (efectos, stickers, música)
- Mejor para agregar last-minute tweaks
- Auto-captions en tiempo real

**Proceso:**
1. Transferir videos a tu teléfono (AirDrop, Google Drive, iCloud)
2. Abrir TikTok app → `+` (crear)
3. Seleccionar **"Upload"**
4. Elegir video de la galería
5. Agregar caption (copiar de tu archivo .txt)
6. Agregar música de fondo (opcional pero recomendado)
7. Configurar cover (thumbnail)
8. Publicar

#### Opción 2: TikTok Creator Studio (Desktop)

**Ventajas:**
- Publicación en masa más rápida
- Programar publicaciones (scheduling)
- Mejor para workflow profesional

**Requisitos:**
- Cuenta TikTok Business o Creator

**Proceso:**
1. Ir a: https://www.tiktok.com/creator-tools/upload
2. Drag & drop video o seleccionar archivo
3. Agregar caption y hashtags
4. Configurar cover
5. **Programar publicación** (fecha y hora)
6. Publicar o agendar

**Recomendación:** Usa Creator Studio para programar los 10 videos de una vez con las fechas/horarios optimizados.

### Programación de Publicaciones

**Calendario sugerido:**

| Video | Título | Fecha | Hora | Hashtag Focus |
|-------|--------|-------|------|---------------|
| 1 | Verdad sobre la Sal | Lun 27 Ene | 8:00 AM | #Educativo #Sodio |
| 2 | 3 Señales Deshidratación | Lun 27 Ene | 6:00 PM | #Salud #TipsRápidos |
| 3 | Mito 8 Vasos | Mié 29 Ene | 12:00 PM | #RompeMitos #Hidratación |
| 4 | Trampa Bebidas Deportivas | Mié 29 Ene | 8:00 PM | #VerdadOculta #Fitness |
| 5 | Curé Calambres | Vie 31 Ene | 8:00 AM | #Transformación #Futbol |
| 6 | Transformación Gym | Vie 31 Ene | 7:00 PM | #GymLife #Rendimiento |
| 7 | Tip 15 Segundos | Lun 3 Feb | 8:00 AM | #QuickTip #LifeHack |
| 8 | Secreto Atletas | Lun 3 Feb | 6:00 PM | #Atletas #Nutrición |
| 9 | POV Olvidas Electrolitos | Jue 6 Feb | 12:00 PM | #POV #GymHumor |
| 10 | Tutorial Hidratación | Jue 6 Feb | 8:00 PM | #Tutorial #HowTo |

**Notas:**
- Lunes y Viernes: Mejor engagement
- 2 videos por día de publicación: Mañana (8 AM-12 PM) y Tarde/Noche (6-8 PM)
- Espaciar 4-6 horas entre publicaciones el mismo día

---

## Control de Calidad

### Checklist Pre-Publicación

Revisar cada video antes de subir:

#### Visual
- [ ] Texto legible en pantalla de teléfono (prueba en tu móvil)
- [ ] Colores de marca BILAN consistentes
- [ ] Logo visible y en buena calidad
- [ ] Overlays en zona segura (no tapados por UI de TikTok)
- [ ] Imágenes/videos de fondo relevantes al tema
- [ ] No hay cortes abruptos o errores de edición

#### Contenido
- [ ] Hook capta atención en primeros 3 segundos
- [ ] Mensaje principal claro y conciso
- [ ] Información científica correcta
- [ ] Tono apropiado para audiencia mexicana
- [ ] CTA específico y accionable
- [ ] Hashtags relevantes al contenido

#### Técnico
- [ ] Resolución: 1080 x 1920
- [ ] Formato: MP4
- [ ] Duración correcta (15s/30s/45s/60s según diseño)
- [ ] No hay lag o problemas de reproducción
- [ ] Audio (si aplica) sincronizado

#### Caption y Metadata
- [ ] Caption preparado y revisado (ortografía, puntuación)
- [ ] Hashtags copiados del CSV
- [ ] CTA incluido en caption
- [ ] Thumbnail/cover seleccionado (frame llamativo del video)

### Pruebas Recomendadas

**Antes de publicar los 10 videos:**

1. **Publicar 1 video de prueba** (puede ser el #7 de 15 segundos)
   - Revisar cómo se ve en la app
   - Verificar que texto es legible
   - Confirmar que el flow del video funciona
   - Medir engagement inicial (primeras 24h)

2. **Ajustar template si es necesario**
   - Basado en feedback del video de prueba
   - Re-generar los otros 9 con ajustes

3. **Publicar en fases**
   - No subir los 10 el mismo día
   - Seguir calendario sugerido (2-3 por semana)

### Métricas de Calidad

**Indicadores de que el video está bien producido:**

- **Retención a 3s:** >75% (la mayoría ve más allá del hook)
- **Retención promedio:** >40% para 60s, >60% para 30s, >80% para 15s
- **Completion rate:** >30% para 60s, >50% para 30s, >70% para 15s
- **Engagement rate:** >5% (likes + comentarios + compartidos / vistas)

**Si las métricas son bajas:**
- Revisar hook (primeros 3s)
- Acortar duración
- Simplificar mensaje
- Mejorar thumbnail

---

## Troubleshooting

### Problemas Comunes en Canva Bulk Create

#### 1. Texto Cortado o No Visible

**Problema:** Al generar los videos, parte del texto no se ve o está cortado.

**Causas:**
- Text box demasiado pequeño
- Texto muy largo para el espacio
- Font size demasiado grande

**Solución:**
- Aumentar tamaño del text box en la plantilla
- Reducir font size
- Usar auto-resize en Canva: Text box → ... → "Auto-resize text"
- Acortar texto en el CSV si es necesario

#### 2. Placeholders No Reemplazan

**Problema:** Los `{{placeholders}}` no se reemplazan con los datos del CSV.

**Causas:**
- Nombre del placeholder no coincide exactamente con columna del CSV
- Mayúsculas/minúsculas no coinciden
- Espacios extra en el nombre

**Solución:**
- Verificar que `{{Hook A}}` en Canva coincide exactamente con columna "Hook A" en CSV
- No usar espacios extra: `{{Hook A}}` ✅ vs `{{ Hook A }}` ❌
- Case-sensitive: `{{Hook A}}` ≠ `{{hook a}}`

#### 3. Caracteres Especiales No Se Ven Bien

**Problema:** Caracteres españoles (á, é, í, ñ, ¿, ¡) se ven como símbolos raros.

**Causas:**
- Encoding del CSV no es UTF-8
- Font no soporta caracteres latinos

**Solución:**
- Guardar CSV como UTF-8: Excel → Save As → CSV UTF-8
- Usar font que soporte español: Montserrat, Poppins, Inter, Roboto
- Evitar fonts decorativos que pueden no tener acentos

#### 4. Videos No Se Exportan

**Problema:** Canva falla al exportar los videos o tarda demasiado.

**Causas:**
- Videos muy largos o complejos
- Muchas animaciones simultáneas
- Conexión a internet lenta

**Solución:**
- Exportar de 2-3 en 2-3 en lugar de los 10 a la vez
- Simplificar animaciones en la plantilla
- Reducir calidad de exportación temporalmente (720p en lugar de 1080p)
- Intentar en diferentes horarios (menos carga en servidores de Canva)

#### 5. Timing de Animaciones Incorrecto

**Problema:** Animaciones no coinciden con los timestamps del CSV.

**Causas:**
- Duración de páginas/slides no configurada correctamente
- Animaciones automáticas tienen timing por defecto

**Solución:**
- En cada página de la plantilla, configurar duración manualmente:
  - Click en página → Clock icon → Set duration
- Para Overlay 1 (3-12s): Duración de página = 9 segundos
- Para Overlay 2 (12-22s): Duración de página = 10 segundos
- Etc.

#### 6. Logo BILAN Se Ve Pixelado

**Problema:** Logo se ve borroso o de baja calidad.

**Causas:**
- Logo en formato JPG de baja resolución
- Logo muy pequeño escalado al tamaño incorrecto

**Solución:**
- Usar logo en formato PNG o SVG (vector)
- Resolución mínima: 500 x 500 px
- Subir logo a Canva a su tamaño real, no escalar mucho
- Si no tienes logo en alta res, solicitar archivo vectorizado

---

## Recursos Adicionales

### Plantillas de Ejemplo

**Ubicación:** `01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/TikTok/templates/`

**Plantillas disponibles:**
- `tiktok_educational_template.canva` - Para videos educativos (60s)
- `tiktok_quick_tip_template.canva` - Para tips rápidos (15-30s)
- `tiktok_transformation_template.canva` - Para antes/después (60s)

### Assets de Marca BILAN

**Ubicación:** `01_PROJECTS/BILAN/PACKAGING/` y `MARKETING/`

- Logo BILAN (PNG, SVG)
- Colores de marca (hex codes)
- Tipografía oficial
- Imágenes del producto

### Música Recomendada (Royalty-Free)

**Para videos de fitness:**
- Epidemic Sound: "Energetic Workout" tracks
- Uppbeat: Fitness category
- TikTok Library: "Gym" y "Workout" tags

**Para videos educativos:**
- Música de fondo suave, no invasiva
- Evitar letras (distrae del mensaje)
- BPM: 80-110 (ritmo medio)

### Herramientas Complementarias

**Video Editing:**
- **CapCut** (gratis) - Para ediciones finales y efectos TikTok nativos
- **InShot** (gratis) - Para ajustes rápidos en móvil
- **DaVinci Resolve** (gratis) - Para edición profesional si es necesario

**Analytics:**
- **TikTok Analytics** (built-in) - Para tracking de métricas
- **engagement-tracking-2025-01-es-MX.md** - Template ya creado para análisis

**Scheduling:**
- **TikTok Creator Studio** (gratis)
- **Later** (plan gratuito disponible)
- **Buffer** (plan gratuito limitado)

---

## Próximos Pasos

### Después de Publicar los 10 Videos

1. **Tracking diario** (primeras 48 horas):
   - Llenar métricas en `engagement-tracking-2025-01-es-MX.md`
   - Responder a todos los comentarios en las primeras 2 horas

2. **Análisis semanal** (cada domingo):
   - Identificar top 3 videos
   - Identificar bottom 3 videos
   - Documentar patrones en el archivo de tracking

3. **Optimización para próximo lote** (finales de febrero):
   - Usar insights del análisis
   - Crear nuevos scripts basados en lo que funcionó
   - A/B test de hooks (usar Hook B y Hook C para videos exitosos)

### Escalamiento

Una vez que identifiques los formatos ganadores:

**Semana 5-8:**
- Crear 20 videos por mes (en lugar de 10)
- Usar solo formatos con mejor engagement
- Experimentar con nuevas tendencias de TikTok

**Mes 3-6:**
- Considerar colaboraciones con micro-influencers fitness México
- Crear serie de contenido (ej: "Lunes de Mitos", "Viernes de Tips")
- Repurposing: Adaptar videos a Instagram Reels y YouTube Shorts

---

## Contacto y Soporte

**Documentación relacionada:**
- `claude_code_task_workflows.md` - Workflow completo de TikTok testing
- `2025-01-23-batch-es-MX.md` - Scripts completos de los 10 videos
- `engagement-tracking-2025-01-es-MX.md` - Template de análisis

**Para preguntas:**
- Referirse a la documentación del proyecto BILAN en `01_PROJECTS/BILAN/`
- Consultar recursos de Canva: [canva.com/help](https://www.canva.com/help/)
- Guías de TikTok Creator: [TikTok Creator Portal](https://www.tiktok.com/creators/creator-portal/en-us/)

---

**Versión:** 1.0
**Fecha de creación:** 23 de enero de 2025
**Última actualización:** 23 de enero de 2025
**Autor:** BILAN Marketing Team (via Claude Code)

---

¡Buena suerte con la creación de tus videos TikTok! 🚀🎬