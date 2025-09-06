# 🎮 REMNANTS

## 🧠 Game Summary (Pitch / Story Teaser)

You are two memories. Different, distant — and yet, bound by the same fate.

Inside a collapsing mind, you flicker between fragments of what once was.  
The red pulses come — slow and sharp — to erase you.  
Stop moving, and the mind forgets you even faster.

There’s no winning. Only surviving. Only the hope of staying remembered… just a little longer.

_A surreal top-down survival game where movement is survival, memory is life, and stillness is your undoing._

---

## 📄 Game Design Document

### 🏷️ Title

**REMNANTS**

### 📝 Short Description

A minimalist 2D survival game where you control two memories trying to survive inside a fading mind.  
Keep moving, dodge the erasing pulses, and stay remembered — together.

---

### 🎯 Game Objective

- Survive as long as possible inside a collapsing memoryspace.
- Continuously move both memories to avoid detection and erasure.
- Dodge incoming erasure pulses and collect fragments of memory to recover.
- **If either memory is lost, the game ends.**

---

### 🕹️ Core Mechanics

| Mechanic              | Description                                                                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **Dual Control**      | Player controls two memory entities independently (e.g. WASD + Arrow keys).                                        |
| **Stillness Erasure** | If either memory remains still for ~3 seconds, a detection event triggers: audio, spotlight, and eventual erasure. |
| **Erasing Pulses**    | Red pulses sweep in from the edges at intervals. Contact shrinks and dims the memory (no health bars used).        |
| **Memory Fragments**  | Periodic pickups (images, words, sounds) that restore part of the memory's glow and size.                          |
| **Visual Health**     | Memory health is shown by glow intensity, size, and behavior — no numeric indicators.                              |
| **Shared Death**      | If one memory is erased, the other vanishes too. Game over.                                                        |

---

### ⛔ Obstacles & Enemies

| Type                             | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
| **Red Pulses**                   | Linear beams that spawn at edges and move inward, erasing on contact. |
| **Stillness Erasure**            | Ambient detection that punishes inactivity — causes instant removal.  |
| **Decay Over Time** _(optional)_ | A slow fade over time without fragments to reinforce urgency.         |

---

### 🌌 Visual Design

**Perspective:** Top-down (2D)

**Characters:**

- Two glowing orbs/blobs, different colors (suggesting different memories).
- Change in size and brightness based on damage/health.
- Leave subtle motion trails.

**Environment:**

- Dark, surreal “memory floor” with shifting textures or symbols.
- Floating or scattered remnants of thoughts: text, photos, drawings.
- No walls, just an endless flat “mindspace” with occasional parallax or particle layers.

**Fragments:**

- Memory pickups appear as flickering icons — text (`"11:32PM"`), image thumbnails, sketches.

---

### 🔊 Sound & Music

| Element             | Description                                                                |
| ------------------- | -------------------------------------------------------------------------- |
| **Ambient Music**   | Lo-fi, fading memory tones, static, layered with reverb and subtle rhythm. |
| **Stillness Sound** | Breathing or low humming starts after 1 second of stillness.               |
| **Spotlight Lock**  | High-pitched ring + audio mute + erase sound (flash/pop).                  |
| **Pulses**          | Buzz, static wave, or sweeping “scanner” audio.                            |
| **Fragments**       | Soft chime or whisper sound when collected.                                |
| **Death**           | Low cutoff hum + silence + fade to black with final echo (e.g. “…”).       |

---

### 📦 UI & Feedback

- No health bars — **visual/audio cues only**.
- No HUD clutter — immersive experience.

**Game Over Screen:**

- _“They are both forgotten now.”_
- Or: _“Only fragments remain.”_
- _(Optional: show timeline of survival or memory flashes on game over.)_

---

### 🧩 Additional Notes

- Narrative is **environmental and visual**, not told through text or dialogue.
- Focus is on **emotional tone, mechanical clarity, and symbolic storytelling**.
- Suitable for submission to **game jams** or future expansion into an art-game.
