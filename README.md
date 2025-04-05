
# 🧠 Whisper.cpp Setup & Easy Transcription Script (macOS)

This guide walks you through setting up [whisper.cpp](https://github.com/ggerganov/whisper.cpp), downloading the base model, and creating a reusable shell script for simple, local audio transcription using OpenAI’s Whisper.

---

## ✅ Prerequisites

- macOS with `zsh` or `bash`
- CMake and `make` installed
- `ffmpeg` (for audio compatibility)
- Internet connection (for downloading the model)

Install ffmpeg if needed:

```bash
brew install ffmpeg
```

---

## 🛠️ 1. Clone and Build `whisper.cpp`

```bash
cd ~/Workspace/Whisper
git clone https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp
mkdir build && cd build
cmake .. -DBUILD_SHARED_LIBS=OFF
make -j
```

---

## 📥 2. Download Whisper Model

```bash
cd ~/Workspace/Whisper/whisper.cpp
mkdir -p models
cd models
curl -L -o ggml-base.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin
```

> ✅ You can replace `base` with `small`, `medium`, or `large` if desired.

---

## 📝 3. Create `transcribe.sh` Script

Save this in:  
`~/Workspace/Whisper/transcribe.sh`

```bash
#!/bin/bash

# Add whisper.cpp build to library path if needed
export DYLD_LIBRARY_PATH="~/Workspace/Whisper/whisper.cpp/build:$DYLD_LIBRARY_PATH"

# Paths
MODEL="~/Workspace/Whisper/whisper.cpp/models/ggml-base.bin"
BIN="~/Workspace/Whisper/whisper.cpp/build/bin/whisper-cli"
AUDIO="$1"

# Transcribe
"$BIN" "$AUDIO" --model "$MODEL" --output-txt
```

Make it executable:

```bash
chmod +x ~/Workspace/Whisper/transcribe.sh
```

---

## ▶️ 4. Run It!

Use the script like this:

```bash
~/Workspace/Whisper/transcribe.sh ~/folder/file.wav
```

Output will be in the same folder as your input `.wav` file — with a `.txt` suffix.

---

## 🧠 Optional Enhancements

- Add `--output-srt` or `--output-vtt` for subtitle files
- Use `ggml-large.bin` for better accuracy
- Add logic to auto-download model if missing

---

Let me know if you'd like this saved to a file or extended into a tool that watches a folder and auto-transcribes!
