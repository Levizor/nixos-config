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

  files=($(find ~/Downloads -type f -printf '%T@ %p\n' 2>/dev/null | \
    sort -n | tail -n "$count" | cut -d' ' -f2-))

  for f in "${files[@]}"; do
    if [[ $move -eq 1 ]]; then
      mv -v "$f" "$target/"
    else
      rsync -r --info=progress2 --human-readable "$f" "$target/"
    fi
  done
}
