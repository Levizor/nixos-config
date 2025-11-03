clone() {
  if [ -z "$1" ]; then
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
      -m|--move)
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
  done < <(find ~/Downloads -type f -printf '%T@ %p\0' 2>/dev/null | \
    sort -zn | tail -z -n "$count" | cut -z -d' ' -f2-)

  for f in "${files[@]}"; do
    if [[ $move -eq 1 ]]; then
      mv -v "$f" "$target/"
      echo "Moved $f to $target"
    else
      rsync -r --info=progress2,name0 --human-readable "$f" "$target/"&&
      echo "Copied $f to $target"
    fi
  done
}

json2nix() {
  tmpfile=$(mktemp)
  cat > "$tmpfile"
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
    echo "Usage: ffcompress [-d] <input_file> [output_file]"
    echo "  -d   Use H.264 for Discord"
    return 1
  fi

  local discord=false
  if [[ "$1" == "-d" ]]; then
    discord=true
    shift
  fi

  local input="$1"
  shift

  local output
  if [[ $# -ge 1 ]]; then
    output="$1"
  else
    local base="${input%.*}"
    local ext="${input##*.}"
    output="${base}_compressed.${ext}"
  fi

  if $discord; then
    # Discord-friendly compression (H.264 + AAC)
    ffmpeg -hide_banner -v error -stats -i "$input" \
      -c:v libx264 -crf 23 -preset medium \
      -c:a aac -b:a 128k "$output"
  else
    # Default compression (H.265 + AAC)
    ffmpeg -hide_banner -v error -stats -i "$input" \
      -c:v libx265 -crf 28 -preset medium \
      -c:a aac -b:a 128k "$output"
  fi

  echo "✅ Compression complete: $output"
}
