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
    else
      rsync -r --info=progress2 --human-readable "$f" "$target/"
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
