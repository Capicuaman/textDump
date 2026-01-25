import React from 'react';
import { Composition } from 'remotion';
import { EducationalVideo } from './templates/EducationalVideo';
import { MythbustingVideo } from './templates/MythbustingVideo';
import { QuickTipVideo } from './templates/QuickTipVideo';
import { TrendingVideo } from './templates/TrendingVideo';

// Default props for each template
export const educationalDefaultProps = {
  title: "Benefits of Magnesium",
  hook: "Did you know magnesium affects 300+ body functions?",
  mainPoints: [
    "Improves muscle recovery",
    "Reduces cramps and fatigue",
    "Supports better sleep"
  ],
  conclusion: "That's why BILAN uses magnesium glycinate",
  cta: "Try BILAN today",
  brandColor: "#00a86b"
};

export const mythbustingDefaultProps = {
  title: "Hydration Myths Debunked",
  myth: "You need 8 glasses of water per day",
  truth: "Your hydration needs depend on activity level, climate, and sweat rate",
  explanation: "Athletes can lose 1-2L per hour. Plain water isn't enough - you need electrolytes.",
  cta: "Get proper hydration with BILAN",
  brandColor: "#00a86b"
};

export const quickTipDefaultProps = {
  title: "Pre-Workout Hydration",
  tip: "Drink electrolytes 30 min before training",
  reason: "This ensures optimal sodium levels during your workout",
  duration: 15,
  cta: "Shop BILAN",
  brandColor: "#00a86b"
};

export const trendingDefaultProps = {
  title: "POV: You discover real hydration",
  hook: "When you realize plain water isn't enough",
  scenes: [
    "Working out without electrolytes",
    "Feeling tired and cramping",
    "Trying BILAN for the first time",
    "Crushing your workout with proper hydration"
  ],
  cta: "Experience the difference",
  brandColor: "#00a86b",
  trendingFormat: "transformation"
};

export const RemotionRoot: React.FC = () => {
  return (
    <>
      <Composition
        id="Educational"
        component={EducationalVideo}
        durationInFrames={1800} // 60 seconds at 30fps
        fps={30}
        width={1080}
        height={1920}
        defaultProps={educationalDefaultProps}
      />
      <Composition
        id="Mythbusting"
        component={MythbustingVideo}
        durationInFrames={900} // 30 seconds at 30fps
        fps={30}
        width={1080}
        height={1920}
        defaultProps={mythbustingDefaultProps}
      />
      <Composition
        id="QuickTip"
        component={QuickTipVideo}
        durationInFrames={450} // 15 seconds at 30fps
        fps={30}
        width={1080}
        height={1920}
        defaultProps={quickTipDefaultProps}
      />
      <Composition
        id="Trending"
        component={TrendingVideo}
        durationInFrames={1200} // 40 seconds at 30fps
        fps={30}
        width={1080}
        height={1920}
        defaultProps={trendingDefaultProps}
      />
    </>
  );
};
