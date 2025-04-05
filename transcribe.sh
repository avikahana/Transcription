#!/bin/bash
export DYLD_LIBRARY_PATH=/Users/avikahana/Workspace/whisper.cpp/build:$DYLD_LIBRARY_PATH
MODEL="~/Workspace/Whisper/whisper.cpp/models/ggml-base.bin"
BIN="~/Workspace/Whisper/whisper.cpp/build/bin/whisper-cli"
AUDIO="$1"
"$BIN" "$AUDIO" --model "$MODEL" --output-txt
