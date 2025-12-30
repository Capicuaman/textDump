# Strudel Usage Primer

## What is Strudel?

Strudel is a **browser-based live coding environment** for music creation. It's an official port of the TidalCycles pattern language to JavaScript, created by Alex McLean and Felix Roos in 2022.

**Key Features:**
- Runs entirely in your web browser at [strudel.cc](https://strudel.cc/)
- No installation required - just open and start coding
- Real-time audio generation
- Visual feedback with highlighted code and piano rolls
- Built-in sample library

**Note:** Despite being CLI-inspired, Strudel is actually a web-based REPL (Read-Eval-Print Loop), not a traditional command-line application.

---

## Getting Started

### Access Strudel

1. Open your browser and navigate to: **[https://strudel.cc/](https://strudel.cc/)**
2. You'll see the Strudel REPL editor with code examples
3. Press `Ctrl+Enter` (Mac: `Cmd+Enter`) to evaluate code and start playback

### Your First Sound

```javascript
sound("bd")
```

Press `Ctrl+Enter` and you'll hear a bass drum loop!

**Explanation:**
- `sound()` or `s()` plays named samples from Strudel's library
- `"bd"` = bass drum
- The pattern repeats every cycle (default tempo)

---

## Core Concepts

### 1. Patterns

Patterns are sequences of events over time. Everything in Strudel is a pattern.

**Basic Pattern Syntax:**
```javascript
// Single sound
sound("bd")

// Sequence of sounds
sound("bd sd cp hh")  // bass, snare, clap, hihat

// Repetition with *
sound("bd sd bd*2 sd")  // bd plays once, last bd plays twice

// Subdivision with []
sound("bd [sd cp] bd sd")  // sd and cp play in time of one beat
```

### 2. Cycles

A **cycle** is the basic unit of time in Strudel. By default, one cycle = one bar.

```javascript
// Set tempo (cycles per second)
setcps(0.75)  // Slower tempo
setcps(1)     // 1 cycle per second (default)

// Set BPM
setcpm(120)   // 120 cycles per minute
setcps(140/60/4)  // 140 BPM (4 beats per cycle)
```

---

## Essential Functions

### sound() / s()

Plays drum samples and sounds.

```javascript
// Basic drums
s("bd sd bd sd")

// Using sample banks
s("bd sd").bank("RolandTR909")

// Multiple samples with :
s("bd:0 bd:1 bd:2")  // Different bass drum variations
```

**Common drum samples:**
- `bd` - bass drum
- `sd` - snare drum
- `hh` - hihat
- `cp` - clap
- `oh` - open hihat
- `ch` - closed hihat
- `casio` - casio synth sounds

### note()

Plays musical notes with pitches.

```javascript
// Note names
note("c3 eb3 g3 bb3").s("piano")

// Note numbers (MIDI)
note("60 63 67 70").s("piano")  // Same as above

// Chords
note("c3 eb3 g3").s("sawtooth")
```

**Note format:**
- Letter (c, d, e, f, g, a, b)
- Optional accidental (# for sharp, b for flat)
- Octave number (0-8)

### stack()

Layers multiple patterns together.

```javascript
stack(
  s("bd sd bd sd"),
  s("hh*8"),
  note("c3 eb3 g3 bb3").s("sawtooth")
)
```

---

## Pattern Manipulation

### Time Modifiers

```javascript
// fast() - speed up pattern
s("bd sd").fast(2)  // Plays twice as fast

// slow() - slow down pattern
s("bd sd cp hh").slow(2)  // Plays twice as slow

// rev() - reverse pattern
s("bd sd cp hh").rev()

// every() - apply function every N cycles
s("bd sd").every(4, x => x.fast(2))
```

### Value Modifiers

```javascript
// gain() - volume (0-1)
s("bd sd").gain(0.8)

// pan() - stereo position (-1 left, 0 center, 1 right)
s("bd sd").pan("0 0.5 1")

// speed() - playback speed
s("bd").speed("1 1.5 2 0.5")
```

### Effects

```javascript
// room() - reverb
s("bd sd").room(0.5)

// lpf() - low pass filter
s("hh*8").lpf(2000)

// delay() - echo
s("cp").delay(0.5)

// distort() - distortion
s("bd").distort(0.3)

// phaser() - phaser effect
s("hh*8").phaser(4)
```

---

## Working with Notes and Scales

### Scales

```javascript
// Use scale() to constrain to a scale
note("0 2 4 7").scale("C:minor").s("piano")

// Different scales
note("0 1 2 3 4 5 6 7")
  .scale("D:dorian")
  .s("sawtooth")
```

**Common scales:**
- major, minor
- dorian, phrygian, lydian, mixolydian
- pentatonic, minor pentatonic

### Chords

```javascript
// chord() function
chord("Cm7").s("piano")

// Arpeggiate chords
chord("Cm7 Fm7 Gm7 Cm7")
  .s("piano")
  .arp()

// Voicings
chord("Cm7").voicing().s("sawtooth")
```

---

## Randomness and Variation

```javascript
// rand() - random value 0-1
s("bd").gain(rand)

// choose() - random from list
s(choose("bd", "sd", "cp"))

// sometimes() - randomly apply
s("bd sd").sometimes(x => x.speed(2))

// shuffle() - randomize order
s("bd sd cp hh").shuffle()
```

---

## Control Functions

### Stop and Mute

```javascript
// Stop everything
hush()

// Mute specific patterns (store in variables first)
const drums = s("bd sd")
const bass = note("c2 c2 eb2 g2").s("sawtooth")

// Play both
stack(drums, bass)

// Solo just drums
solo(drums)

// Mute drums
mute(drums)
```

### Variables

Store patterns for organization:

```javascript
const kick = s("bd*4")
const snare = s("~ sd ~ sd")
const hats = s("hh*8").gain(0.4)

stack(kick, snare, hats)
```

---

## Loading Custom Samples

```javascript
// Load from GitHub
samples('github:eddyflux/crate')

// Use custom samples
s("myBreak:0").cut(1)
```

---

## Example Sessions

### Basic Beat

```javascript
setcps(0.75)

const drums = s("bd sd bd sd").bank("RolandTR909")
const hats = s("hh*8").gain(0.3)

stack(drums, hats)
```

### Melodic Pattern

```javascript
setcps(0.6)

stack(
  // Bass
  note("c2 c2 eb2 g2")
    .s("sawtooth")
    .lpf(500),

  // Melody
  note("c4 eb4 g4 bb4 c5")
    .scale("C:minor")
    .s("piano")
    .room(0.5),

  // Drums
  s("bd ~ sd ~")
)
```

### Evolving Pattern

```javascript
const pattern = s("bd sd cp hh")
  .every(4, x => x.fast(2))
  .every(8, x => x.rev())
  .sometimes(x => x.speed(2))

pattern
```

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Enter` / `Cmd+Enter` | Evaluate code |
| `Alt+Enter` | Evaluate single line |
| `Ctrl+.` / `Cmd+.` | Stop all sound (hush) |
| `Ctrl+Shift+H` | Show/hide help |

---

## Tips for Beginners

1. **Start Simple**: Begin with basic drum patterns before adding melody
2. **Use Comments**: Add `//` comments to document your code
3. **Build Gradually**: Add one element at a time and evaluate frequently
4. **Experiment**: Change numbers and values to hear what happens
5. **Use Variables**: Store patterns in variables for cleaner code
6. **Check Examples**: Strudel REPL has many example patterns to learn from

---

## Common Sample Names

**Drums:**
- `bd` - bass/kick drum
- `sd` - snare
- `hh` - hihat
- `oh` - open hihat
- `cp` - clap
- `rim` - rimshot
- `lt`, `mt`, `ht` - toms (low, mid, high)

**Percussion:**
- `tabla`, `tabla2`
- `feel` - percussion samples
- `jazz` - jazz drum samples

**Melodic:**
- `piano`, `piano2`
- `sawtooth`, `square`, `triangle` - synth waveforms
- `casio` - FM synth sounds
- `superpiano`

---

## Learning Path

### Recommended Workshop Order:
1. [First Sounds](https://strudel.cc/workshop/first-sounds/)
2. [First Notes](https://strudel.cc/workshop/first-notes/)
3. [First Effects](https://strudel.cc/workshop/first-effects/)
4. [Pattern Effects](https://strudel.cc/workshop/pattern-effects/)
5. [Creating Patterns](https://strudel.cc/learn/factories/)

---

## Resources

- **Official Site**: [strudel.cc](https://strudel.cc/)
- **Getting Started**: [strudel.cc/workshop/getting-started/](https://strudel.cc/workshop/getting-started/)
- **Discord**: Join the Strudel community for help
- **Documentation**: [strudel.cc/learn/](https://strudel.cc/learn/)
- **Pattern Club**: [strudel.patternclub.org](https://strudel.patternclub.org/)

---

## Troubleshooting

**No Sound?**
- Check browser audio isn't muted
- Try clicking the page first (browsers require user interaction)
- Check if other tabs are using audio

**Code Not Running?**
- Make sure you press `Ctrl+Enter` to evaluate
- Check for syntax errors (red underlines)
- Try `hush()` then run code again

**Patterns Sound Wrong?**
- Check your `setcps()` or `setcpm()` tempo
- Verify pattern syntax (proper quotes and parentheses)
- Use `.log()` to debug: `pattern.log()`

---

**License**: Strudel is under GNU Affero General Public License v3 (AGPL-3.0)
