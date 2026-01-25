import { parse } from 'csv-parse/sync';
import * as fs from 'fs';
import * as path from 'path';

export interface VideoData {
  id: string;
  type: 'Educational' | 'Mythbusting' | 'QuickTip' | 'Trending';
  title: string;
  data: any;
}

export interface CSVRow {
  id: string;
  type: string;
  title: string;
  // Educational fields
  hook?: string;
  mainPoints?: string;
  conclusion?: string;
  // Mythbusting fields
  myth?: string;
  truth?: string;
  explanation?: string;
  // QuickTip fields
  tip?: string;
  reason?: string;
  duration?: string;
  // Trending fields
  scenes?: string;
  trendingFormat?: string;
  // Common fields
  cta: string;
  brandColor?: string;
}

export function parseCSV(filePath: string): VideoData[] {
  const fileContent = fs.readFileSync(filePath, 'utf-8');
  const records: CSVRow[] = parse(fileContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  });

  return records.map((row) => {
    const videoData: VideoData = {
      id: row.id,
      type: row.type as any,
      title: row.title,
      data: buildVideoProps(row),
    };

    return videoData;
  });
}

function buildVideoProps(row: CSVRow): any {
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

export function validateVideoData(data: VideoData): boolean {
  if (!data.id || !data.type || !data.title) {
    console.error('Missing required fields:', data);
    return false;
  }

  const validTypes = ['Educational', 'Mythbusting', 'QuickTip', 'Trending'];
  if (!validTypes.includes(data.type)) {
    console.error('Invalid video type:', data.type);
    return false;
  }

  return true;
}
