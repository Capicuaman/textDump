#!/usr/bin/env node
const { bundle } = require('@remotion/bundler');
const { renderMedia, selectComposition } = require('@remotion/renderer');
const path = require('path');
const fs = require('fs');

// Import CSV parser (we'll use csv-parse)
const { parse } = require('csv-parse/sync');

// Configuration
const CSV_FILE = process.env.CSV_FILE || path.join(__dirname, 'data', 'videos.csv');
const OUTPUT_DIR = process.env.OUTPUT_DIR || path.join(__dirname, '..', 'out');
const CONCURRENCY = parseInt(process.env.CONCURRENCY || '2', 10);

// Parse CSV
function parseCSV(filePath) {
  const fileContent = fs.readFileSync(filePath, 'utf-8');
  const records = parse(fileContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  });

  return records.map((row) => ({
    id: row.id,
    type: row.type,
    title: row.title,
    data: buildVideoProps(row),
  }));
}

function buildVideoProps(row) {
  const baseProps = {
    title: row.title,
    cta: row.cta,
    brandColor: row.brandColor || '#00a86b',
  };

  switch (row.type) {
    case 'Educational':
      return {
        ...baseProps,
        hook: row.hook || '',
        mainPoints: row.mainPoints
          ? row.mainPoints.split('|').map((p) => p.trim())
          : [],
        conclusion: row.conclusion || '',
      };

    case 'Mythbusting':
      return {
        ...baseProps,
        myth: row.myth || '',
        truth: row.truth || '',
        explanation: row.explanation || '',
      };

    case 'QuickTip':
      return {
        ...baseProps,
        tip: row.tip || '',
        reason: row.reason || '',
        duration: parseInt(row.duration || '15', 10),
      };

    case 'Trending':
      return {
        ...baseProps,
        hook: row.hook || '',
        scenes: row.scenes ? row.scenes.split('|').map((s) => s.trim()) : [],
        trendingFormat: row.trendingFormat || 'transformation',
      };

    default:
      throw new Error(`Unknown video type: ${row.type}`);
  }
}

// Render a single video
async function renderVideo(bundled, video, outputPath) {
  console.log(`\n🎬 Rendering: ${video.title} (${video.type})`);

  const composition = await selectComposition({
    serveUrl: bundled,
    id: video.type,
    inputProps: video.data,
  });

  await renderMedia({
    composition,
    serveUrl: bundled,
    codec: 'h264',
    outputLocation: outputPath,
    inputProps: video.data,
    verbose: true,
  });

  console.log(`✅ Completed: ${video.title}`);
}

// Main batch render function
async function batchRender() {
  console.log('🚀 BILAN Batch Video Renderer\n');

  // Check if CSV exists
  if (!fs.existsSync(CSV_FILE)) {
    console.error(`❌ CSV file not found: ${CSV_FILE}`);
    console.log('\nUsage:');
    console.log('  CSV_FILE=path/to/videos.csv npm run render');
    console.log('  CSV_FILE=path/to/videos.csv OUTPUT_DIR=path/to/output npm run render');
    process.exit(1);
  }

  // Parse videos from CSV
  console.log(`📄 Reading CSV: ${CSV_FILE}`);
  const videos = parseCSV(CSV_FILE);
  console.log(`✓ Found ${videos.length} videos to render\n`);

  // Create output directory
  if (!fs.existsSync(OUTPUT_DIR)) {
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  // Bundle the project
  console.log('📦 Bundling Remotion project...');
  const bundled = await bundle({
    entryPoint: path.join(__dirname, 'index.ts'),
    webpackOverride: (config) => config,
  });
  console.log('✓ Bundling complete\n');

  // Render videos (with concurrency control)
  const renderPromises = [];
  for (let i = 0; i < videos.length; i++) {
    const video = videos[i];
    const outputPath = path.join(OUTPUT_DIR, `${video.id}-${video.title.replace(/[^a-z0-9]/gi, '-').toLowerCase()}.mp4`);

    const renderPromise = renderVideo(bundled, video, outputPath);
    renderPromises.push(renderPromise);

    // Control concurrency
    if (renderPromises.length >= CONCURRENCY) {
      await Promise.race(renderPromises);
      renderPromises.splice(renderPromises.findIndex((p) => p === renderPromise), 1);
    }
  }

  // Wait for remaining renders
  await Promise.all(renderPromises);

  console.log('\n🎉 All videos rendered successfully!');
  console.log(`📁 Output directory: ${OUTPUT_DIR}`);
}

// Run
batchRender().catch((err) => {
  console.error('❌ Batch render failed:', err);
  process.exit(1);
});
