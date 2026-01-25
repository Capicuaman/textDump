# BILAN Generación de Videos con Remotion

Sistema automatizado de generación de videos para crear contenido de TikTok, Instagram Reels y YouTube Shorts a escala para el mercado mexicano.

## Descripción General

Este sistema te permite generar múltiples videos desde un archivo CSV, con 4 plantillas predefinidas:

1. **Educativo** - Contenido educativo profundo (60s)
2. **Desmitificador** - Desmentir mitos comunes (30s)
3. **Consejo Rápido** - Tips rápidos y accionables (15s)
4. **Tendencia** - Aprovecha formatos virales (40s)

## Inicio Rápido

### 1. Instalar Dependencias

```bash
cd 01_PROJECTS/BILAN/video-generation
npm install
```

### 2. Vista Previa de Plantillas

```bash
npm run dev
```

Esto abre Remotion Studio donde puedes previsualizar y editar plantillas.

### 3. Prepara tu CSV

Edita `src/data/videos-es.csv` con tu contenido en español mexicano.

### 4. Renderiza Videos

```bash
# Renderizar todos los videos del CSV por defecto
npm run render

# Renderizar desde CSV específico (español)
CSV_FILE=src/data/videos-es.csv npm run render

# Especificar directorio de salida
OUTPUT_DIR=../MARKETING/VIDEO/rendered npm run render
```

## Formato CSV para Mercado Mexicano

### Ejemplo de Video Educativo

```csv
id,type,title,hook,mainPoints,conclusion,cta,brandColor
1,Educational,Beneficios del Magnesio,¿Sabías que el magnesio afecta más de 300 funciones corporales?,Mejora recuperación muscular|Reduce calambres y fatiga|Ayuda a dormir mejor,Por eso BILAN usa glicinato de magnesio,Prueba BILAN hoy,#00a86b
```

### Consideraciones Culturales para México

1. **Tono**: Cercano pero respetuoso (uso de "tú" informal)
2. **Referencias**: Actividades y deportes populares en México
3. **Idioma**: Español mexicano (no español de España)
4. **Emoji**: Usar con moderación, apropiados culturalmente
5. **Música**: Considerar tendencias musicales mexicanas

### Plantillas Específicas para México

**Educativo - Ejemplo:**
- Hook: "¿Sabías que en el calor mexicano pierdes el doble de electrolitos?"
- Puntos principales: Enfocados en clima, deportes locales
- Conclusión: "BILAN te mantiene hidratado en cualquier clima"

**Desmitificador - Ejemplo:**
- Mito: "Con 8 vasos de agua al día estás bien"
- Verdad: "En México necesitas más: clima, altitud y actividad importan"

**Consejo Rápido - Ejemplo:**
- Tip: "Antes de entrenar en el gym, toma BILAN 30 min antes"
- Razón: "El calor mexicano aumenta pérdida de sodio"

**Tendencia - Ejemplo:**
- Formato: POV mexicano
- Escenas: Adaptadas a contexto cultural mexicano

## Integración con Claude Code

### Generar Contenido en Español

```
TASK: Generar 10 guiones de video para TikTok en español mexicano

Crear contenido para:
- 3 videos educativos sobre beneficios de electrolitos
- 3 videos desmitificadores sobre hidratación
- 2 consejos rápidos sobre uso de BILAN
- 2 videos de tendencias/transformación

IMPORTANTE:
- Idioma: Español mexicano (no España)
- Tono: Informal pero respetuoso (tú)
- Contexto: Clima cálido, deportes populares en México
- Referencias: Culturalmente relevantes para México

Formato: CSV válido con todas las columnas requeridas
Investigar: PRODUCT/ y MARKETING/RAG/
Guardar: video-generation/src/data/videos-es-YYYY-MM-DD.csv

Ejecutar en segundo plano.
```

## Recursos

- `USAGE-ES.md` - Guía de uso en español
- `CSV_TEMPLATE-ES.md` - Documentación de formato CSV
- Documentación de Remotion en inglés: https://remotion.dev

## Soporte

Para problemas o preguntas, consulta la documentación en español o los archivos de tareas de Claude Code en `01_PROJECTS/BILAN/`.
