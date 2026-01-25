import React from 'react';
import {
  AbsoluteFill,
  useCurrentFrame,
  useVideoConfig,
  interpolate,
  spring,
  Sequence,
} from 'remotion';

interface TrendingVideoProps {
  title: string;
  hook: string;
  scenes: string[];
  cta: string;
  brandColor: string;
  trendingFormat: 'transformation' | 'pov' | 'challenge' | 'duet';
}

export const TrendingVideo: React.FC<TrendingVideoProps> = ({
  title,
  hook,
  scenes,
  cta,
  brandColor,
  trendingFormat,
}) => {
  const { fps } = useVideoConfig();

  const hookDuration = fps * 3;
  const sceneDuration = fps * 8;
  const ctaDuration = fps * 3;

  return (
    <AbsoluteFill style={{ backgroundColor: '#000' }}>
      {/* Hook */}
      <Sequence durationInFrames={hookDuration}>
        <HookSection hook={hook} brandColor={brandColor} />
      </Sequence>

      {/* Scenes */}
      {scenes.map((scene, index) => (
        <Sequence
          key={index}
          from={hookDuration + index * sceneDuration}
          durationInFrames={sceneDuration}
        >
          <SceneSection
            scene={scene}
            index={index}
            total={scenes.length}
            brandColor={brandColor}
            format={trendingFormat}
          />
        </Sequence>
      ))}

      {/* CTA */}
      <Sequence from={hookDuration + scenes.length * sceneDuration}>
        <CTASection cta={cta} brandColor={brandColor} />
      </Sequence>
    </AbsoluteFill>
  );
};

const HookSection: React.FC<{ hook: string; brandColor: string }> = ({
  hook,
  brandColor,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const scale = spring({
    frame,
    fps,
    config: { damping: 100, stiffness: 200 },
  });

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        padding: '80px',
        background: `linear-gradient(135deg, ${brandColor}, #000)`,
      }}
    >
      <div
        style={{
          fontSize: '68px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
          transform: `scale(${scale})`,
        }}
      >
        {hook}
      </div>
    </AbsoluteFill>
  );
};

const SceneSection: React.FC<{
  scene: string;
  index: number;
  total: number;
  brandColor: string;
  format: string;
}> = ({ scene, index, total, brandColor, format }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const slideIn = spring({
    frame,
    fps,
    config: { damping: 100, stiffness: 200 },
  });

  const opacity = interpolate(slideIn, [0, 1], [0, 1]);

  // Different animations based on format
  const getTransform = () => {
    switch (format) {
      case 'transformation':
        return `scale(${slideIn})`;
      case 'pov':
        return `translateY(${interpolate(slideIn, [0, 1], [100, 0])}px)`;
      case 'challenge':
        return `rotate(${interpolate(slideIn, [0, 1], [-5, 0])}deg)`;
      default:
        return `scale(${slideIn})`;
    }
  };

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        padding: '80px',
        opacity,
      }}
    >
      <div
        style={{
          position: 'absolute',
          top: '80px',
          right: '80px',
          fontSize: '48px',
          color: brandColor,
          fontWeight: 'bold',
        }}
      >
        {index + 1}/{total}
      </div>
      <div
        style={{
          fontSize: '64px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
          transform: getTransform(),
        }}
      >
        {scene}
      </div>
    </AbsoluteFill>
  );
};

const CTASection: React.FC<{ cta: string; brandColor: string }> = ({
  cta,
  brandColor,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const pulse = Math.sin((frame / fps) * Math.PI * 2) * 0.1 + 1;

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: brandColor,
      }}
    >
      <div
        style={{
          fontSize: '72px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          transform: `scale(${pulse})`,
        }}
      >
        {cta}
      </div>
    </AbsoluteFill>
  );
};
