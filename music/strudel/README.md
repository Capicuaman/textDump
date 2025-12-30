# Strudel Learning Resources

Welcome to your Strudel live coding music creation guide!

## What is Strudel?

**Strudel** is a browser-based live coding environment for music creation. It's a JavaScript port of the powerful TidalCycles pattern language, making algorithmic music composition accessible directly in your web browser.

**Key Features:**
- 🌐 Runs entirely in the browser (no installation!)
- 🎵 Built-in sample library and synthesizers
- 🔴 Real-time pattern evaluation
- 🎹 Visual feedback with code highlighting
- 🚀 Perfect for live performances and education

**Access Strudel:** [https://strudel.cc/](https://strudel.cc/)

---

## Learning Path

### 1. Start Here: Basic Usage
📄 **File:** `01_strudel_usage_primer.md`

Learn the fundamentals:
- How to use the Strudel REPL
- Basic pattern syntax
- Core functions (sound, note, stack)
- Effects and modulation
- Working with scales and chords
- Common samples and sounds

**Time Investment:** 2-4 hours to get comfortable

---

### 2. Level Up: Live Performance
📄 **File:** `02_strudel_live_performance_guide.md`

Master live coding:
- Pre-performance setup
- Building patterns incrementally
- Performance workflows
- Improvisation strategies
- Advanced techniques
- Example performance set
- Troubleshooting

**Time Investment:** Practice sessions, build to full performance

---

### 3. Quick Reference
📄 **File:** `03_strudel_quick_reference.md`

Essential commands and patterns for:
- Quick lookup during coding
- Performance cheat sheet
- Common patterns
- Keyboard shortcuts
- Emergency recovery

**Usage:** Keep this open during practice and performances!

---

## Recommended Learning Order

### Week 1: Foundations
- [ ] Read the usage primer
- [ ] Open strudel.cc and try examples
- [ ] Create your first drum pattern
- [ ] Experiment with samples
- [ ] Learn basic effects

### Week 2: Pattern Building
- [ ] Practice layering with stack()
- [ ] Work with notes and scales
- [ ] Create melodic patterns
- [ ] Use time modifiers (fast, slow, every)
- [ ] Add effects and automation

### Week 3: Live Coding Basics
- [ ] Read live performance guide
- [ ] Practice starting/stopping patterns
- [ ] Work on transitions
- [ ] Build a simple 3-minute set
- [ ] Practice with variables

### Week 4: Performance Ready
- [ ] Create a full 10-minute set
- [ ] Practice improvisation
- [ ] Work on recovery techniques
- [ ] Record yourself coding
- [ ] Share with community

---

## Quick Start (5 Minutes)

1. **Open Strudel:**
   - Go to [strudel.cc](https://strudel.cc/)

2. **Try This Code:**
   ```javascript
   setcps(0.75)

   stack(
     s("bd*4"),
     s("~ sd ~ sd"),
     s("hh*8").gain(0.4)
   )
   ```

3. **Press:** `Ctrl+Enter` (or `Cmd+Enter` on Mac)

4. **Hear:** A basic drum pattern!

5. **Modify:** Change numbers, add effects, experiment!

---

## Practice Exercises

### Beginner

1. Create a 4/4 kick drum pattern
2. Add a snare on beats 2 and 4
3. Layer in hi-hats
4. Add a simple bassline with notes

### Intermediate

1. Build a techno beat with variations
2. Create a pattern that evolves every 4 cycles
3. Make a melodic sequence with effects
4. Use randomness to vary your patterns

### Advanced

1. Create a 5-minute improvised performance
2. Build generative patterns with JavaScript
3. Layer 6+ elements cohesively
4. Perform a live set for friends

---

## Essential Resources

### Official Resources
- **Main Site:** [strudel.cc](https://strudel.cc/)
- **Documentation:** [strudel.cc/learn/](https://strudel.cc/learn/)
- **Workshop Series:** [strudel.cc/workshop/](https://strudel.cc/workshop/)
- **Source Code:** [github.com/tidalcycles/strudel](https://github.com/tidalcycles/strudel)

### Community
- **Discord:** Strudel community server
- **Pattern Club:** [strudel.patternclub.org](https://strudel.patternclub.org/)
- **TOPLAP:** Live coding community
- **Algorave:** Live coding music events

### Learning Materials
- [Getting Started Guide](https://strudel.cc/workshop/getting-started/)
- [Strudel Basics Workshop](https://strudel.patternclub.org/workshop/strudel-basics/)
- [Creating Patterns Tutorial](https://strudel.cc/learn/factories/)
- [Pattern Effects Guide](https://strudel.cc/workshop/pattern-effects/)
- [Live Coding with Strudel (Hackaday)](https://hackaday.com/2025/10/16/live-coding-techno-with-strudel/)

### Inspiration
- Search YouTube for "Strudel live coding"
- Watch Algorave performances
- Check out TidalCycles videos (similar syntax)
- Follow #livecoding on social media

---

## Common Questions

**Q: Do I need to know JavaScript?**
A: No! Strudel uses JavaScript syntax, but you don't need prior experience. Start with simple patterns and learn as you go.

**Q: Do I need to install anything?**
A: No! Strudel runs entirely in your browser. Just go to strudel.cc.

**Q: Can I use my own samples?**
A: Yes! You can load samples from GitHub or use built-in sample banks.

**Q: Is this good for live performance?**
A: Absolutely! Strudel is designed for live coding performances. Many artists use it at Algorave events.

**Q: Can I save my code?**
A: Yes! Copy your code to a text file, or use browser bookmarks to save patterns.

**Q: What if I make mistakes during a performance?**
A: Mistakes are part of live coding! Press `Ctrl+.` to stop everything, then restart with a simple pattern.

---

## Tips for Success

1. **Start Simple:** Don't try to do everything at once
2. **Practice Daily:** Even 15 minutes makes a difference
3. **Copy Examples:** Learn by modifying existing code
4. **Join Community:** Get help and share your work
5. **Perform Early:** Start with short 5-minute sets
6. **Have Fun:** Experimentation is the point!

---

## Keyboard Shortcuts Reference

| Shortcut | Action |
|----------|--------|
| `Ctrl+Enter` | Evaluate code block |
| `Alt+Enter` | Evaluate single line |
| `Ctrl+.` | Stop all sound (hush) |
| `Ctrl+Shift+H` | Toggle help panel |
| `F11` | Browser fullscreen |
| `Ctrl+L` | Clear console |

---

## File Structure

```
strudel/
├── README.md                           # This file
├── 01_strudel_usage_primer.md          # Learn basics
├── 02_strudel_live_performance_guide.md # Live performance
└── 03_strudel_quick_reference.md       # Quick lookup
```

---

## Contributing Your Knowledge

As you learn Strudel:
- Add your own patterns to these files
- Document discoveries
- Share what worked for your performances
- Create your own examples

---

## License & Attribution

**Strudel** is licensed under GNU Affero General Public License v3 (AGPL-3.0)

Created by:
- Alex McLean (creator of TidalCycles)
- Felix Roos (JavaScript port)
- Strudel community contributors

This guide compiled from:
- Official Strudel documentation
- Community tutorials and guides
- Live coding performance best practices

---

## Get Started Now!

1. Open [strudel.cc](https://strudel.cc/)
2. Read `01_strudel_usage_primer.md`
3. Try the examples
4. Start making music!

**Remember:** Live coding is about the creative process, not perfection. Every performance is unique, and mistakes are part of the art form.

Happy live coding! 🎵✨

---

**Last Updated:** December 2024
**Sources:**
- [Strudel Official Site](https://strudel.cc/)
- [Strudel Getting Started Guide](https://strudel.cc/workshop/getting-started/)
- [Live Coding Techno with Strudel (Hackaday)](https://hackaday.com/2025/10/16/live-coding-techno-with-strudel/)
- [Strudel Pattern Club](https://strudel.patternclub.org/)
- [Universe of Tracks Strudel Guide](https://universeoftracks.com/guide-strudel-live-coding/)
