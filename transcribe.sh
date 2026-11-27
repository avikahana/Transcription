#!/bin/bash
set -euo pipefail

# Model file. Override with: WHISPER_MODEL=/path/ggml-base.bin ./transcribe.sh file.mp3
WHISPER_MODEL="${WHISPER_MODEL:-$HOME/Workspace/Whisper/models/ggml-large-v3.bin}"
# Spoken language: "auto" to detect, or a code like "en" or "he". Override with: WHISPER_LANG=he ./transcribe.sh file.mp3
WHISPER_LANG="${WHISPER_LANG:-auto}"

if [ $# -eq 0 ]; then
  echo "Usage: ./transcribe.sh file1.wav [file2.mp3 ...]" >&2
  exit 1
fi
if ! command -v whisper-cli >/dev/null; then
  echo "whisper-cli not found. Install it with: brew install whisper.cpp" >&2
  exit 1
fi
if [ ! -f "$WHISPER_MODEL" ]; then
  echo "Model not found: $WHISPER_MODEL" >&2
  exit 1
fi

# Temporary folder for converted audio, removed when the script ends
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

for AUDIO in "$@"; do
  EXT="$(echo "${AUDIO##*.}" | tr '[:upper:]' '[:lower:]')"
  case "$EXT" in
    wav|mp3|flac|ogg)
      INPUT="$AUDIO"
      ;;
    *)
      # whisper-cli cannot read this format (e.g. .m4a), so convert it to 16 kHz mono WAV first
      if ! command -v ffmpeg >/dev/null; then
        echo "ffmpeg is needed to convert $AUDIO. Install it with: brew install ffmpeg" >&2
        exit 1
      fi
      INPUT="$TMP_DIR/converted.wav"
      ffmpeg -loglevel error -y -i "$AUDIO" -ar 16000 -ac 1 "$INPUT"
      ;;
  esac
  whisper-cli "$INPUT" --model "$WHISPER_MODEL" --language "$WHISPER_LANG" --output-txt --output-file "$AUDIO"
done
