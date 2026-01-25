import React from 'react';
import {
  AbsoluteFill,
  useCurrentFrame,
  useVideoConfig,
  interpolate,
  spring,
  Sequence,
} from 'remotion';

interface QuickTipVideoProps {
  title: string;
  tip: string;
  reason: string;
  duration: number;
  cta: string;
  brandColor: string;
}

export const QuickTipVideo: React.FC<QuickTipVideoProps> = ({
  title,
  tip,
  reason,
  cta,
  brandColor,
}) => {
  const { fps } = useVideoConfig();

  const hookDuration = fps * 3;
  const tipDuration = fps * 6;
  const reasonDuration = fps * 4;
  const ctaDuration = fps * 2;

  return (
    <AbsoluteFill style={{ backgroundColor: '#000' }}>
      {/* Hook */}
      <Sequence durationInFrames={hookDuration}>
        <HookSection brandColor={brandColor} />
      </Sequence>

      {/* Tip */}
      <Sequence from={hookDuration} durationInFrames={tipDuration}>
        <TipSection tip={tip} brandColor={brandColor} />
      </Sequence>

      {/* Reason */}
      <Sequence
        from={hookDuration + tipDuration}
        durationInFrames={reasonDuration}
      >
        <ReasonSection reason={reason} brandColor={brandColor} />
      </Sequence>

      {/* CTA */}
      <Sequence from={hookDuration + tipDuration + reasonDuration}>
        <CTASection cta={cta} brandColor={brandColor} />
      </Sequence>
    </AbsoluteFill>
  );
};

const HookSection: React.FC<{ brandColor: string }> = ({ brandColor }) => {
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
        backgroundColor: brandColor,
      }}
    >
      <div
        style={{
          fontSize: '96px',
          fontWeight: 'bold',
          color: '#fff',
          transform: `scale(${scale})`,
        }}
      >
        QUICK TIP
      </div>
    </AbsoluteFill>
  );
};

const TipSection: React.FC<{ tip: string; brandColor: string }> = ({
  tip,
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
          fontSize: '72px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
          transform: `scale(${scale})`,
        }}
      >
        {tip}
      </div>
      <div
        style={{
          position: 'absolute',
          top: '80px',
          fontSize: '64px',
          color: brandColor,
        }}
      >
        💡
      </div>
    </AbsoluteFill>
  );
};

const ReasonSection: React.FC<{ reason: string; brandColor: string }> = ({
  reason,
  brandColor,
}) => {
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
        {reason}
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
    config: { damping: 100, stiffness: 300 },
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
          fontSize: '64px',
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
