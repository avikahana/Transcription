
# 🧠 Whisper.cpp Setup & Easy Transcription Script (macOS)

This guide walks you through setting up [whisper.cpp](https://github.com/ggml-org/whisper.cpp), downloading a model, and using the `transcribe.sh` script in this repo for simple, local audio transcription using OpenAI’s Whisper.

---

## ✅ Prerequisites

- macOS with `zsh` or `bash`
- Homebrew installed
- Internet connection (for downloading the model)
- `ffmpeg` (optional): only needed for formats `whisper-cli` cannot read, such as `.m4a`. The script converts them automatically.

Install ffmpeg if needed:

```bash
brew install ffmpeg
```

---

## 🛠️ 1. Install `whisper.cpp`

```bash
brew install whisper.cpp
```

---

## 📥 2. Download Whisper Model

```bash
mkdir -p ~/Workspace/Whisper/models
cd ~/Workspace/Whisper/models
curl -L -o ggml-large-v3.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3.bin
```

> ✅ This is a 3.1 GB download. The script expects `ggml-large-v3.bin` in this folder. To use another model (such as `base` or `large-v3-turbo`), download it and set `WHISPER_MODEL` (see step 3).

---

## 📝 3. Get the `transcribe.sh` Script

The script is in this repo: [`transcribe.sh`](transcribe.sh).

```bash
git clone https://github.com/avikahana/Transcription.git
cd Transcription
chmod +x transcribe.sh
```

By default it uses `~/Workspace/Whisper/models/ggml-large-v3.bin`. To use another model file, set `WHISPER_MODEL`:

```bash
WHISPER_MODEL=~/Workspace/Whisper/models/ggml-base.bin ./transcribe.sh ~/folder/file.wav
```

---

## ▶️ 4. Run It!

```bash
./transcribe.sh ~/folder/file.wav
```

The transcript is saved next to the input file, with `.txt` added to the full name. For example, `file.wav` becomes `file.wav.txt`.

You can pass several files at once: `./transcribe.sh ~/folder/*.m4a`

`.wav`, `.mp3`, `.flac` and `.ogg` are read directly. Other formats (such as `.m4a`) are converted automatically with ffmpeg, and the transcript is still named after the original file (`memo.m4a.txt`).

> ℹ️ The language is detected automatically. To set it yourself: `WHISPER_LANG=he ./transcribe.sh file.wav`

---

## 🧠 Optional Enhancements

- Add `--output-srt` or `--output-vtt` for subtitle files
- Use `ggml-large-v3-turbo.bin` (1.6 GB) for faster transcription with nearly the same accuracy
- Add logic to auto-download model if missing
