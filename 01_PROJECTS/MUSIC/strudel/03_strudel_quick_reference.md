# Strudel Quick Reference

## Essential Commands

```javascript
// START/STOP
hush()                    // Stop everything
setcps(0.75)             // Set tempo (cycles per second)
setcpm(120)              // Set tempo (cycles per minute)

// PLAY SOUNDS
s("bd sd")               // Play samples (shorthand for sound())
sound("bd sd cp hh")     // Play samples
note("c4 eb4 g4").s("piano")  // Play notes

// LAYER PATTERNS
stack(pattern1, pattern2, pattern3)

// CONTROL
solo(pattern)            // Solo one pattern
mute(pattern)            // Mute pattern
unmute(pattern)          // Unmute pattern
```

---

## Pattern Syntax

```javascript
// SEQUENCES
"bd sd cp hh"           // Sequential sounds

// REPETITION
"bd*4"                  // Repeat 4 times per cycle
"bd*<2 4 8>"           // Alternate repetitions

// SUBDIVISION
"[bd sd]"              // Play both in time of one
"bd [sd cp hh]"        // Nested subdivision

// RESTS
"bd ~ sd ~"            // ~ is silence

// POLYPHONY (play together)
"[bd sd, hh*4]"        // Comma separates simultaneous
```

---

## Common Samples

```javascript
// DRUMS
bd, sd, hh, oh, ch     // Kick, snare, hihat, open hat, closed hat
cp, rim, clap          // Claps and rims
lt, mt, ht             // Toms (low, mid, high)

// PERCUSSION
tabla, tabla2
jazz, jazz:0-7

// MELODIC
piano, piano2
sawtooth, square, triangle, sine
casio
```

---

## Time Functions

```javascript
.fast(2)               // 2x speed
.slow(2)               // 0.5x speed
.rev()                 // Reverse
.every(4, x => x.fast(2))  // Apply every 4 cycles
.sometimes(x => x.speed(2))  // Randomly apply
.often(x => ...)       // Apply 75% of time
.rarely(x => ...)      // Apply 25% of time
```

---

## Effects

```javascript
.gain(0.8)             // Volume (0-1+)
.pan(0.5)              // Stereo (-1 to 1)
.speed(1.5)            // Playback speed
.room(0.5)             // Reverb
.delay(0.5)            // Echo
.lpf(2000)             // Low-pass filter
.hpf(500)              // High-pass filter
.distort(0.3)          // Distortion
.phaser(4)             // Phaser effect
.crush(4)              // Bit crusher
```

---

## Notes & Scales

```javascript
// NOTES
note("c3 eb3 g3")      // Note names (c-b, with # or b)
note("60 63 67")       // MIDI numbers

// SCALES
.scale("C:minor")
.scale("D:major")
.scale("E:dorian")

// CHORDS
chord("Cm7")
chord("Am Dm G C")
.arp()                 // Arpeggiate
```

---

## Randomness

```javascript
rand                   // Random 0-1
choose("bd", "sd", "cp")  // Pick random
.shuffle()             // Randomize order
irand(8)               // Random integer 0-7
perlin                 // Smooth random
```

---

## Variables

```javascript
const kick = s("bd*4")
const snare = s("~ sd ~ sd")
const hats = s("hh*8")

stack(kick, snare, hats)
```

---

## Modulation

```javascript
// OSCILLATORS
sine, saw, square, tri

// RANGES
sine.range(500, 2000)  // Map sine to range
.slow(4)               // Slow down oscillator

// EXAMPLE
s("hh*8").lpf(sine.range(500, 5000).slow(4))
```

---

## Common Patterns

```javascript
// BASIC BEAT
s("bd sd bd sd")

// FOUR-ON-FLOOR
s("bd*4")

// BREAKBEAT
s("bd [~ sd] bd [sd ~]")

// HIHAT GROOVE
s("hh*8").gain("0.8 0.4 0.8 0.4 0.8 0.4 0.8 0.6")

// BASSLINE
note("c2 c2 eb2 g2").s("sawtooth").lpf(800)
```

---

## Performance Tips

```javascript
// BUILD TENSION
.every(4, x => x.fast(2))
.lpf(sine.range(500, 8000).slow(8))

// DROP
s("bd ~ ~ ~").gain(1.5)

// STUTTER
.stut(4, 0.5, 0.125)

// CHOP BREAK
s("break:0").chop(16).shuffle()
```

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+Enter` | Run code |
| `Alt+Enter` | Run line |
| `Ctrl+.` | Stop all |
| `F11` | Fullscreen |

---

## Emergency Recovery

```javascript
hush()                 // Stop everything
s("bd*4")             // Start simple
```

---

## Sample Banks

```javascript
.bank("RolandTR909")
.bank("RolandTR808")
samples('github:user/samples')
```

---

## Links

- **REPL**: https://strudel.cc/
- **Docs**: https://strudel.cc/learn/
- **Workshop**: https://strudel.cc/workshop/

---

## Quick Example Session

```javascript
setcps(0.75)

const drums = stack(
  s("bd*4"),
  s("~ sd ~ sd"),
  s("hh*8").gain(0.4)
)

const bass = note("c2 c2 eb2 g2")
  .s("sawtooth")
  .lpf(800)

stack(drums, bass)
```
