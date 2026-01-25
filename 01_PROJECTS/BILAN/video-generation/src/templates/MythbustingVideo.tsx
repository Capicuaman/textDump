import React from 'react';
import {
  AbsoluteFill,
  useCurrentFrame,
  useVideoConfig,
  interpolate,
  spring,
  Sequence,
} from 'remotion';

interface MythbustingVideoProps {
  title: string;
  myth: string;
  truth: string;
  explanation: string;
  cta: string;
  brandColor: string;
}

export const MythbustingVideo: React.FC<MythbustingVideoProps> = ({
  title,
  myth,
  truth,
  explanation,
  cta,
  brandColor,
}) => {
  const { fps } = useVideoConfig();

  const titleDuration = fps * 3;
  const mythDuration = fps * 6;
  const truthDuration = fps * 8;
  const explanationDuration = fps * 8;
  const ctaDuration = fps * 5;

  return (
    <AbsoluteFill style={{ backgroundColor: '#000' }}>
      {/* Title */}
      <Sequence durationInFrames={titleDuration}>
        <TitleSection title={title} brandColor={brandColor} />
      </Sequence>

      {/* Myth */}
      <Sequence from={titleDuration} durationInFrames={mythDuration}>
        <MythSection myth={myth} />
      </Sequence>

      {/* Truth Reveal */}
      <Sequence
        from={titleDuration + mythDuration}
        durationInFrames={truthDuration}
      >
        <TruthSection truth={truth} brandColor={brandColor} />
      </Sequence>

      {/* Explanation */}
      <Sequence
        from={titleDuration + mythDuration + truthDuration}
        durationInFrames={explanationDuration}
      >
        <ExplanationSection explanation={explanation} brandColor={brandColor} />
      </Sequence>

      {/* CTA */}
      <Sequence from={titleDuration + mythDuration + truthDuration + explanationDuration}>
        <CTASection cta={cta} brandColor={brandColor} />
      </Sequence>
    </AbsoluteFill>
  );
};

const TitleSection: React.FC<{ title: string; brandColor: string }> = ({
  title,
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
      }}
    >
      <div
        style={{
          fontSize: '80px',
          fontWeight: 'bold',
          color: brandColor,
          textAlign: 'center',
          transform: `scale(${scale})`,
        }}
      >
        MYTH BUSTED
      </div>
    </AbsoluteFill>
  );
};

const MythSection: React.FC<{ myth: string }> = ({ myth }) => {
  const frame = useCurrentFrame();

  const opacity = interpolate(frame, [0, 15], [0, 1]);

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        padding: '80px',
        backgroundColor: '#1a0000',
        opacity,
      }}
    >
      <div
        style={{
          position: 'absolute',
          top: '100px',
          fontSize: '48px',
          color: '#ff4444',
          fontWeight: 'bold',
        }}
      >
        ❌ MYTH
      </div>
      <div
        style={{
          fontSize: '64px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
        }}
      >
        {myth}
      </div>
    </AbsoluteFill>
  );
};

const TruthSection: React.FC<{ truth: string; brandColor: string }> = ({
  truth,
  brandColor,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const scale = spring({
    frame,
    fps,
    config: { damping: 100, stiffness: 300 },
  });

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        padding: '80px',
        backgroundColor: '#001a00',
      }}
    >
      <div
        style={{
          position: 'absolute',
          top: '100px',
          fontSize: '48px',
          color: brandColor,
          fontWeight: 'bold',
          transform: `scale(${scale})`,
        }}
      >
        ✓ TRUTH
      </div>
      <div
        style={{
          fontSize: '64px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
        }}
      >
        {truth}
      </div>
    </AbsoluteFill>
  );
};

const ExplanationSection: React.FC<{
  explanation: string;
  brandColor: string;
}> = ({ explanation, brandColor }) => {
  const frame = useCurrentFrame();

  const opacity = interpolate(frame, [0, 15], [0, 1]);

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
          fontSize: '56px',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.4',
        }}
      >
        {explanation}
      </div>
      <div
        style={{
          position: 'absolute',
          bottom: '100px',
          fontSize: '36px',
          color: brandColor,
          fontWeight: 'bold',
        }}
      >
        BILAN
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
        backgroundColor: brandColor,
      }}
    >
      <div
        style={{
          fontSize: '72px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          transform: `scale(${scale})`,
        }}
      >
        {cta}
      </div>
    </AbsoluteFill>
  );
};
