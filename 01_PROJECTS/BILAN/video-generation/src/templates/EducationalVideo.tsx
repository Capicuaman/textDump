import React from 'react';
import {
  AbsoluteFill,
  useCurrentFrame,
  useVideoConfig,
  interpolate,
  spring,
  Sequence,
} from 'remotion';

interface EducationalVideoProps {
  title: string;
  hook: string;
  mainPoints: string[];
  conclusion: string;
  cta: string;
  brandColor: string;
}

export const EducationalVideo: React.FC<EducationalVideoProps> = ({
  title,
  hook,
  mainPoints,
  conclusion,
  cta,
  brandColor,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Timing (in frames)
  const hookDuration = fps * 5; // 5 seconds
  const pointDuration = fps * 4; // 4 seconds per point
  const conclusionStart = hookDuration + (mainPoints.length * pointDuration);
  const conclusionDuration = fps * 4;
  const ctaStart = conclusionStart + conclusionDuration;

  return (
    <AbsoluteFill style={{ backgroundColor: '#000' }}>
      {/* Hook Section */}
      <Sequence durationInFrames={hookDuration}>
        <HookSection hook={hook} brandColor={brandColor} />
      </Sequence>

      {/* Main Points */}
      {mainPoints.map((point, index) => (
        <Sequence
          key={index}
          from={hookDuration + (index * pointDuration)}
          durationInFrames={pointDuration}
        >
          <PointSection
            point={point}
            number={index + 1}
            brandColor={brandColor}
          />
        </Sequence>
      ))}

      {/* Conclusion */}
      <Sequence from={conclusionStart} durationInFrames={conclusionDuration}>
        <ConclusionSection conclusion={conclusion} brandColor={brandColor} />
      </Sequence>

      {/* CTA */}
      <Sequence from={ctaStart}>
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
    config: { damping: 100, stiffness: 200, mass: 0.5 },
  });

  const opacity = interpolate(frame, [0, 15], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

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
          fontSize: '72px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
          transform: `scale(${scale})`,
        }}
      >
        {hook}
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

const PointSection: React.FC<{
  point: string;
  number: number;
  brandColor: string;
}> = ({ point, number, brandColor }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const slideIn = spring({
    frame,
    fps,
    config: { damping: 100, stiffness: 200 },
  });

  const translateX = interpolate(slideIn, [0, 1], [1080, 0]);

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
          transform: `translateX(${translateX}px)`,
          width: '100%',
        }}
      >
        <div
          style={{
            fontSize: '120px',
            fontWeight: 'bold',
            color: brandColor,
            marginBottom: '40px',
          }}
        >
          {number}
        </div>
        <div
          style={{
            fontSize: '64px',
            fontWeight: 'bold',
            color: '#fff',
            lineHeight: '1.3',
          }}
        >
          {point}
        </div>
      </div>
    </AbsoluteFill>
  );
};

const ConclusionSection: React.FC<{
  conclusion: string;
  brandColor: string;
}> = ({ conclusion, brandColor }) => {
  const frame = useCurrentFrame();

  const opacity = interpolate(frame, [0, 15], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        padding: '80px',
        opacity,
        backgroundColor: brandColor,
      }}
    >
      <div
        style={{
          fontSize: '68px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          lineHeight: '1.3',
        }}
      >
        {conclusion}
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
        backgroundColor: '#000',
      }}
    >
      <div
        style={{
          fontSize: '72px',
          fontWeight: 'bold',
          color: '#fff',
          textAlign: 'center',
          padding: '60px',
          backgroundColor: brandColor,
          borderRadius: '40px',
          transform: `scale(${scale})`,
        }}
      >
        {cta}
      </div>
    </AbsoluteFill>
  );
};
