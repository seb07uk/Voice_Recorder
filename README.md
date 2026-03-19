# 🎙 Dyktafon — Voice Recorder v4.0

> **Professional desktop voice recorder built with Python and PyQt6**

Developed by **Sebastian Januchowski** · [polsoft.ITS™ Group](https://github.com/seb07uk)

---

## Features

- **One-click recording** — start, pause, resume and stop with dedicated toolbar buttons
- **Real-time VU meter** — animated level bar with colour-coded segments (green / amber / red)
- **WAV output** — lossless audio at 44 100 Hz · Mono · 16-bit PCM
- **Recordings list** — all sessions shown as cards with name, duration and file size
- **Save dialog** — save to any location with a custom filename; auto-saved to `~/Recordings` by default
- **Compact mode** — shrink the window to a minimal control strip (⊟ button)
- **Always on top** — pin the window above all other applications (📌 button)
- **Multiple themes** — switch between Dark, Midnight, Slate, Sepia and Light palettes from the top bar
- **Bilingual UI** — toggle between English and Polish at runtime (EN / PL pill switch)
- **Graceful close** — prompts before discarding an active recording

---

## Requirements

| Package | Purpose |
|---------|---------|
| `PyQt6` | GUI framework |
| `sounddevice` | Microphone capture |
| `numpy` | Audio buffer handling |

Python **3.9 or newer** is recommended.

---

## Installation

```bash
pip install PyQt6 sounddevice numpy
```

---

## Running

```bash
python dyktafon.py
```

---

## Usage

| Control | Action |
|---------|--------|
| ⏺ **RECORD** | Start a new recording |
| ⏸ **PAUSE** | Pause the current recording |
| ▶ **RESUME** | Resume a paused recording |
| ⏹ **STOP** | Stop and discard (unsaved) recording |
| 💾 **SAVE** | Save the current recording to a WAV file |
| ✕ (on card) | Delete a saved recording |
| EN / PL toggle | Switch interface language |
| Theme combo | Change colour theme |
| ⊟ button | Toggle compact / full window |
| 📌 button | Toggle always-on-top |

Recordings are saved automatically in the `~/Recordings` folder unless you choose a different path via the Save dialog.

---

## Audio Format

```
Codec   : PCM WAV (lossless)
Rate    : 44 100 Hz
Channels: 1 (Mono)
Depth   : 16-bit
```

---

## Project Structure

```
dyktafon.py   — single-file application (all logic, UI and assets bundled)
```

---

## License

**Proprietary — polsoft.ITS™ Group**  
© 2026 Sebastian Januchowski & polsoft.ITS™ Group. All rights reserved.

---

## Contact

| | |
|-|--|
| Developer | Sebastian Januchowski |
| Company | polsoft.ITS™ Group |
| E-mail | polsoft.its@fastservice.com |
| GitHub | https://github.com/seb07uk |
