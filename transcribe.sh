#!/bin/bash
# Path to your local whisper.cpp clone/build. Override with: WHISPER_DIR=/path ./transcribe.sh file.mp3
WHISPER_DIR="${WHISPER_DIR:-$HOME/Workspace/Whisper/whisper.cpp}"

export DYLD_LIBRARY_PATH="$WHISPER_DIR/build:$DYLD_LIBRARY_PATH"
MODEL="$WHISPER_DIR/models/ggml-base.bin"
BIN="$WHISPER_DIR/build/bin/whisper-cli"
AUDIO="$1"
"$BIN" "$AUDIO" --model "$MODEL" --output-txt
