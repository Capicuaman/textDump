# Strudel Live Performance Guide

## Introduction to Live Coding Performance

Live coding is about **making music by writing and tweaking code in real time**. The code changes translate instantly to music output, and often the code is projected during a performance so the audience can see the logic behind the sound.

With Strudel, you can:
- Build patterns incrementally during performance
- Morph and evolve music in real-time
- Create complex layered compositions
- Improvise with algorithmic structures
- Engage audiences with visual code feedback

---

## Pre-Performance Setup

### 1. Technical Requirements

**Hardware:**
- Laptop with reliable performance (8GB+ RAM recommended)
- External audio interface (for better sound quality)
- Projector or large screen (for code visibility)
- Backup power supply

**Browser Setup:**
- Use Chrome or Firefox (best performance)
- Close unnecessary tabs and applications
- Disable browser notifications
- Set browser to fullscreen mode (F11)

**Network:**
- Strudel can work offline once loaded
- Test internet connection if loading custom samples
- Have local samples ready as backup

### 2. Performance Environment

```javascript
// Set your starting tempo
setcps(0.75)  // or setcpm(120) for BPM

// Load custom samples at start
samples('github:yourusername/samples')

// Prepare color scheme for visibility
// (Strudel has built-in themes)
```

### 3. Prepare Starting Patterns

Have a few simple patterns ready to start your set:

```javascript
// Minimal starter
const kick = s("bd*4")

// Build from here
const snare = s("~ sd ~ sd")
const hats = s("hh*8").gain(0.4)
```

---

## Performance Workflow

### The Typical Flow

1. **Start Minimal**: Begin with 1-2 simple elements
2. **Build Gradually**: Add layers one at a time
3. **Morph Patterns**: Modify existing code while running
4. **Create Tension**: Use effects and variations
5. **Drop/Break**: Remove elements strategically
6. **Rebuild**: Bring elements back with variations

### Starting Your Performance

```javascript
// Session 1: Start with just a kick
setcps(0.75)
s("bd*4")
```

Press `Ctrl+Enter` to start. The music begins immediately.

---

## Building Layers Live

### Step 1: Add Rhythm

```javascript
// Add kick (already playing)
const kick = s("bd*4")

// Add snare (evaluate this next)
const snare = s("~ sd ~ sd")

stack(kick, snare)
```

### Step 2: Add Percussion

```javascript
// Add hihats
const hats = s("hh*8").gain(0.4)

stack(kick, snare, hats)
```

### Step 3: Add Bass

```javascript
// Add bassline
const bass = note("c2 c2 eb2 g2")
  .s("sawtooth")
  .lpf(800)

stack(kick, snare, hats, bass)
```

### Step 4: Add Melody

```javascript
// Add melodic element
const melody = note("c4 eb4 g4 bb4 c5")
  .scale("C:minor")
  .s("piano")
  .room(0.5)
  .every(4, x => x.rev())

stack(kick, snare, hats, bass, melody)
```

---

## Live Transformation Techniques

### 1. Every N Cycles

Transform patterns periodically:

```javascript
// Add variation every 4 cycles
s("bd sd").every(4, x => x.fast(2))

// Combine multiple transformations
s("bd sd cp hh")
  .every(4, x => x.fast(2))
  .every(8, x => x.rev())
  .every(16, x => x.shuffle())
```

### 2. Sometimes

Add randomness:

```javascript
// Sometimes double speed
s("bd sd").sometimes(x => x.speed(2))

// Often apply effect
s("hh*8").often(x => x.lpf(2000))

// Rarely add distortion
s("bd").rarely(x => x.distort(0.5))
```

### 3. Gradual Changes

Use slow LFOs and automation:

```javascript
// Slowly modulate filter
s("hh*8").lpf(sine.range(500, 5000).slow(8))

// Oscillating pan
s("cp").pan(sine.slow(4))

// Breathing gain
s("bd").gain(sine.range(0.6, 1).slow(2))
```

---

## Control Functions for Performance

### Master Controls

```javascript
// STOP EVERYTHING (emergency!)
hush()

// Mute specific layers
mute(drums)
mute(bass)

// Solo specific layer
solo(melody)

// Unmute
unmute(drums)
```

### Pattern Management

Store patterns in variables for easy control:

```javascript
// Define patterns
const drums = stack(
  s("bd*4"),
  s("~ sd ~ sd"),
  s("hh*8").gain(0.4)
)

const bass = note("c2 c2 eb2 g2").s("sawtooth")
const lead = note("c4 eb4 g4 bb4").s("piano")

// Play combinations
stack(drums, bass)  // Just drums and bass
stack(drums, bass, lead)  // Full arrangement
```

---

## Performance Patterns and Tricks

### Pattern 1: Build and Drop

```javascript
// Build tension
const buildup = s("bd sd bd sd")
  .every(2, x => x.fast(2))
  .every(4, x => x.fast(2))
  .every(8, x => x.fast(2))
  .gain(1.2)

// Then drop to simple
const drop = s("bd ~ ~ ~").distort(0.3)
```

### Pattern 2: Call and Response

```javascript
// Create alternating patterns
const call = note("c4 eb4 g4").s("piano")
const response = note("bb3 g3 c4").s("piano").rev()

// Switch between them
call
// Later evaluate:
response
```

### Pattern 3: Polyrhythm

```javascript
// Different cycle lengths
stack(
  s("bd sd").fast(1),     // 1x speed
  s("hh*3").fast(1.5),    // 1.5x speed
  s("cp*5").fast(2.5)     // 2.5x speed
)
```

### Pattern 4: Breakbeat Manipulation

```javascript
// Load a break
s("breaks165:0").cut(1)

// Chop it up
s("breaks165:0").chop(16).rev()

// Scramble
s("breaks165:0").chop(32).shuffle()

// Stutter
s("breaks165:0").stut(4, 0.5, 0.125)
```

---

## Tempo and Time Manipulation

### Changing Tempo Live

```javascript
// Gradually increase tempo
setcps(0.75)  // Start
// Later:
setcps(0.85)
// Later:
setcps(1.0)   // Peak

// Or use BPM
setcpm(120)
// Build to:
setcpm(140)
```

### Time Warping

```javascript
// Compress time
s("bd sd cp hh").compress(0, 0.5)

// Stretch time
s("bd sd").stretch(2)

// Shift in time
s("bd sd").early(0.25)
s("cp hh").late(0.125)
```

---

## Effects for Live Performance

### Build Tension

```javascript
// Increasing filter sweep
s("hh*8").lpf(sine.range(500, 8000).slow(4))

// Rising distortion
s("bd sd").distort(saw.range(0, 0.8).slow(8))

// Delay feedback buildup
s("cp").delay(0.5).delayfeedback(0.7).delaytime(0.125)
```

### Create Space

```javascript
// Reverb for depth
s("bd sd").room(0.8).size(0.9)

// Delay for width
s("cp").delay(0.5).pan("0 1")

// Phaser for movement
s("hh*8").phaser(4).phaserrate(2)
```

### Add Energy

```javascript
// Distortion
s("bd").distort(0.5).gain(1.2)

// Bit crushing
s("sd").crush(4)

// High-pass punch
s("bd").hpf(100).hpq(20)
```

---

## Improvisation Strategies

### Strategy 1: Theme and Variations

Start with a motif and transform it:

```javascript
// Theme
const theme = note("c4 eb4 g4 bb4").s("piano")

// Variation 1: Speed
theme.fast(2)

// Variation 2: Reverse
theme.rev()

// Variation 3: Octave shift
theme.add(12)

// Variation 4: Different sound
theme.s("sawtooth").lpf(1000)
```

### Strategy 2: Layer Substitution

Replace elements while keeping structure:

```javascript
// Start with this
s("bd sd bd sd")

// Replace with this (same rhythm, different sound)
s("808bd 808sd 808bd 808sd")

// Or completely different
note("c3 eb3 g3 bb3").s("sawtooth")
```

### Strategy 3: Density Control

Vary pattern complexity:

```javascript
// Sparse
s("bd ~ ~ ~")

// Medium
s("bd ~ sd ~")

// Dense
s("bd [sd cp] bd [sd cp hh]")

// Very dense
s("bd*4 sd*2 [cp hh]*8")
```

---

## Performance Tips

### Before the Show

1. **Rehearse**: Practice your set multiple times
2. **Test Setup**: Verify audio, video, and browser
3. **Prepare Patterns**: Have starter code ready
4. **Plan Arc**: Know your performance structure
5. **Have Backups**: Save code snippets offline

### During Performance

1. **Start Strong**: Begin with something engaging
2. **Pace Yourself**: Don't add everything at once
3. **Create Dynamics**: Use builds, drops, and breaks
4. **Fix Mistakes**: If code breaks, quickly `hush()` and restart
5. **Engage Audience**: Look up, explain what you're doing
6. **Project Code**: Make sure audience can see your screen

### Emergency Procedures

```javascript
// Something sounds bad? Stop it fast:
hush()

// Then quickly start something new:
s("bd sd bd sd")

// Or go back to a safe pattern:
const safe = s("bd*4").gain(0.8)
safe
```

### Visual Performance

Make your code readable for the audience:

```javascript
// Use clear variable names
const kick = s("bd*4")
const snare = s("~ sd ~ sd")
const hihat = s("hh*8")

// Add comments during performance
// BUILDING TENSION
s("bd sd").fast(2).distort(0.5)

// THE DROP!
s("bd ~ ~ ~").gain(1.5)
```

---

## Advanced Performance Techniques

### Conditional Logic

```javascript
// Only play on certain cycles
s("bd sd").when(({cycle}) => cycle % 4 == 0)

// Complex conditions
s("cp").when(({cycle}) => cycle > 16 && cycle % 2 == 0)
```

### External Control

```javascript
// MIDI input (requires setup)
midi('your-controller').note().s("piano")

// OSC control (requires configuration)
osc('/freq').s("sawtooth")
```

### Live Coding with Code

```javascript
// Use JavaScript for generative patterns
const notes = [0,2,4,7,9,11,14]
const pattern = notes.map(n => `c${Math.floor(n/7) + 3}`).join(" ")
note(pattern).s("piano")

// Random every performance
note(choose(...["c3", "eb3", "g3", "bb3"])).s("piano")
```

---

## Example Performance Set

### Act 1: Introduction (0-5 min)

```javascript
setcps(0.75)

// Start minimal
s("bd*4")

// Add snare
stack(
  s("bd*4"),
  s("~ sd ~ sd")
)

// Add hats
stack(
  s("bd*4"),
  s("~ sd ~ sd"),
  s("hh*8").gain(0.4)
)
```

### Act 2: Build (5-10 min)

```javascript
// Add bass
const bass = note("c2 c2 eb2 g2")
  .s("sawtooth")
  .lpf(800)

stack(drums, bass)

// Add variation
s("bd sd").every(4, x => x.fast(2))

// Add melody
const melody = note("c4 eb4 g4 bb4 c5")
  .scale("C:minor")
  .s("piano")
  .room(0.5)

stack(drums, bass, melody)
```

### Act 3: Peak (10-15 min)

```javascript
// Increase tempo
setcps(0.9)

// Add complexity
s("bd sd cp hh")
  .every(2, x => x.fast(2))
  .every(4, x => x.rev())
  .distort(0.3)

// Dense percussion
s("[bd sd]*4 cp*2 [hh oh]*8")
```

### Act 4: Break/Transition (15-18 min)

```javascript
// Drop most elements
hush()

// Just ambient pad
note("c3 eb3 g3")
  .s("sawtooth")
  .lpf(500)
  .room(0.9)
  .slow(4)
```

### Act 5: Rebuild/Finale (18-25 min)

```javascript
// Bring back drums differently
s("808bd 808sd 808bd 808sd")

// New bassline
note("c2 f2 g2 bb2")
  .s("sawtooth")
  .distort(0.5)

// Build to climax
setcps(1.0)
stack(
  s("bd*4").gain(1.2),
  s("sd*2").distort(0.3),
  s("[hh oh]*16").gain(0.6),
  note("c3 eb3 g3 bb3").s("sawtooth")
)

// Final drop and fade
hush()
```

---

## Keyboard Shortcuts for Performance

| Shortcut | Action |
|----------|--------|
| `Ctrl+Enter` | Evaluate code block |
| `Alt+Enter` | Evaluate single line |
| `Ctrl+.` | Emergency stop (hush) |
| `F11` | Fullscreen mode |
| `Ctrl+L` | Clear console |

---

## Troubleshooting During Performance

**Code Won't Evaluate:**
- Check for syntax errors (missing quotes, parentheses)
- Press `Ctrl+.` to reset
- Re-type the code

**Audio Glitches:**
- Too many layers? Use `hush()` and simplify
- Lower gain values
- Reduce effects

**Lost Track of Patterns:**
- Use `hush()` to reset
- Start from saved pattern
- Simplify to just kick drum

**Audience Can't See Code:**
- Increase font size (browser zoom)
- Use high contrast theme
- Remove split-screen panels

---

## Post-Performance

1. **Save Your Code**: Copy final code to a file
2. **Record Session**: Use screen recording software
3. **Document Patterns**: Note interesting discoveries
4. **Share**: Post code to community forums
5. **Reflect**: What worked? What to improve?

---

## Community and Resources

**Learn from Others:**
- Watch live coding performances on YouTube
- Join Strudel Discord for tips
- Attend Algorave events (live coding music events)
- Check out TOPLAP (live coding community)

**Practice Resources:**
- [Strudel Workshop](https://strudel.cc/workshop/)
- [Pattern Club](https://strudel.patternclub.org/)
- [Live Coding Research](https://algorithmicpattern.org/)

---

## Final Tips for Success

1. **Practice Regularly**: Code daily, even just 15 minutes
2. **Start Simple**: Master basics before complex patterns
3. **Build a Library**: Save your favorite patterns
4. **Perform Often**: Start with short sets, build confidence
5. **Embrace Mistakes**: They're part of live coding!
6. **Have Fun**: The audience feels your energy

---

## Performance Checklist

**Before Show:**
- [ ] Test laptop and audio interface
- [ ] Load Strudel and verify audio
- [ ] Prepare starting code
- [ ] Test projector/screen
- [ ] Close unnecessary apps
- [ ] Disable notifications
- [ ] Have backup patterns ready
- [ ] Check internet connection
- [ ] Verify sample libraries loaded

**During Show:**
- [ ] Start with clear, simple pattern
- [ ] Build gradually
- [ ] Maintain eye contact with audience
- [ ] Explain what you're doing
- [ ] Use dynamics (loud/soft, busy/sparse)
- [ ] Have fun and stay calm!

**After Show:**
- [ ] Save your code
- [ ] Thank the audience
- [ ] Share code if requested
- [ ] Note what worked well

---

**Remember**: Live coding is about the **process**, not perfection. Mistakes are part of the art form. Your audience wants to see you create music in real-time, and they'll appreciate the journey!

Good luck with your performances! 🎵🎹✨
