clone() {
  if [ "$1" = "" ]; then
    echo "Usage: clone <repo-name>"
    return 1
  fi
  git clone "git@github.com:Levizor/$1.git"
}
down() {
  local move=0
  local count=1
  local target=.
  local files=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -m | --move)
      move=1
      shift
      ;;
    [0-9]*)
      count=$1
      shift
      ;;
    *)
      target=$1
      shift
      ;;
    esac
  done

  # Use null delimiter to properly handle filenames with spaces
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find ~/Downloads -type f -printf '%T@ %p\0' 2>/dev/null |
    sort -zn | tail -z -n "$count" | cut -z -d' ' -f2-)

  for f in "${files[@]}"; do
    if [[ $move -eq 1 ]]; then
      mv -v "$f" "$target/"
      echo "Moved $f to $target"
    else
      rsync -r --info=progress2,name0 --human-readable "$f" "$target/" &&
        echo "Copied $f to $target"
    fi
  done
}

json2nix() {
  tmpfile=$(mktemp)
  cat >"$tmpfile"
  nix eval --raw --impure --expr "
    let
      j = builtins.fromJSON (builtins.readFile \"$tmpfile\");
      showValue = v:
        if builtins.isString v then \"\\\"\" + v + \"\\\"\"
        else if builtins.isInt v then builtins.toString v
        else if builtins.isBool v then (if v then \"true\" else \"false\")
        else builtins.toString v;
      showAttr = key: value: key + \" = \" + (showValue value) + \";\";
    in (builtins.concatStringsSep \"\\n\" (map (k: showAttr k j.\${k}) (builtins.attrNames j))) + \"\\n\"
  "
  rm -f "$tmpfile"
}

ffcompress() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: ffcompress <input_file> [size_in_MB] [output_file]"
    return 1
  fi

  local input="$1"
  local target_size_mb="$2"
  local output="$3"

  # If size is not provided or is not a number, default to 50% of original
  if [[ -z "$target_size_mb" || ! "$target_size_mb" =~ ^[0-9.]+$ ]]; then
    local original_size_bytes=$(ffprobe -v error -show_entries format=size -of default=noprint_wrappers=1:nokey=1 "$input")
    # Zsh floating point math: (( size / 1024 / 1024 ) * 0.5)
    target_size_mb=$(( (original_size_bytes / 1048576.0) * 0.5 ))

    # Shift output argument if $2 was actually a filename
    if [[ -n "$2" && ! "$2" =~ ^[0-9.]+$ ]]; then
        output="$2"
    fi
  fi

  # Default output naming
  if [[ -z "$output" ]]; then
    local base="${input%.*}"
    local ext="${input##*.}"
    output="${base}_compressed.${ext}"
  fi

  local duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input")

  # Bitrate Calculation in Zsh (MB * 8192 / duration)
  local audio_bitrate=128
  local total_bitrate=$(( (target_size_mb * 8192) / duration ))
  local video_bitrate=$(( total_bitrate - audio_bitrate ))

  # Floor check (min 100k)
  if (( video_bitrate < 100 )); then video_bitrate=100; fi

  # Convert to integer for FFmpeg
  video_bitrate=${video_bitrate%.*}

  echo "🎯 Target Size: ~${target_size_mb%.*}MB | Bitrate: ${video_bitrate}k"

  # Two-pass encoding
  ffmpeg -y -hide_banner -v error -stats -i "$input" \
    -c:v libx264 -b:v "${video_bitrate}k" -pass 1 -an -f mp4 /dev/null

  ffmpeg -hide_banner -v error -stats -i "$input" \
    -c:v libx264 -b:v "${video_bitrate}k" -pass 2 \
    -c:a aac -b:a "${audio_bitrate}k" "$output"

  rm -f ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree
  echo "✅ Done: $output"
}

spawn() {
  "$@" >/dev/null 2>&1 &!
}

alias s='spawn'

compdef _precommand spawn s
