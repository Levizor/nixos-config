function clone
    if test -z "$argv[1]"
        echo "Usage: clone <repo-name>"
        return 1
    end
    git clone "git@github.com:Levizor/$argv[1].git"
end

function down
    set -l move 0
    set -l count 1
    set -l target .
    set -l files

    set -l i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case -m --move
                set move 1
            case '[0-9]*'
                set count $argv[$i]
            case '*'
                set target $argv[$i]
        end
        set i (math $i + 1)
    end

    # Find the N most recent files in ~/Downloads
    set files (find ~/Downloads -type f -printf '%T@ %p\0' 2>/dev/null \
        | sort -zn | tail -z -n $count | cut -z -d' ' -f2- \
        | tr '\0' '\n')

    for f in $files
        if test $move -eq 1
            mv -v $f $target/
            echo "Moved $f to $target"
        else
            rsync -r --info=progress2,name0 --human-readable $f $target/ \
                && echo "Copied $f to $target"
        end
    end
end

function json2nix
    set -l tmpfile (mktemp)
    cat >$tmpfile
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
    rm -f $tmpfile
end

function ffcompress
    if test (count $argv) -lt 1
        echo "Usage: ffcompress <input_file> [size_in_MB] [output_file]"
        return 1
    end

    set -l input $argv[1]
    set -l target_size_mb $argv[2]
    set -l output $argv[3]

    # If size is not provided or is not a number, default to 50% of original
    if test -z "$target_size_mb"; or not string match -qr '^[0-9.]+$' "$target_size_mb"
        set -l original_size_bytes (ffprobe -v error -show_entries format=size \
            -of default=noprint_wrappers=1:nokey=1 $input)
        set target_size_mb (math "$original_size_bytes / 1048576.0 * 0.5")

        # Shift output argument if $argv[2] was actually a filename
        if test -n "$argv[2]"; and not string match -qr '^[0-9.]+$' "$argv[2]"
            set output $argv[2]
        end
    end

    # Default output naming
    if test -z "$output"
        set -l base (string replace -r '\.[^.]+$' '' $input)
        set -l ext (string match -r '[^.]+$' $input)
        set output "{$base}_compressed.$ext"
    end

    set -l duration (ffprobe -v error -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 $input)

    set -l audio_bitrate 128
    set -l total_bitrate (math "($target_size_mb * 8192) / $duration")
    set -l video_bitrate (math "floor($total_bitrate - $audio_bitrate)")

    # Floor check (min 100k)
    if test $video_bitrate -lt 100
        set video_bitrate 100
    end

    echo "🎯 Target Size: ~$(math "floor($target_size_mb)")MB | Bitrate: {$video_bitrate}k"

    # Two-pass encoding
    ffmpeg -y -hide_banner -v error -stats -i $input \
        -c:v libx264 -b:v {$video_bitrate}k -pass 1 -an -f mp4 /dev/null

    ffmpeg -hide_banner -v error -stats -i $input \
        -c:v libx264 -b:v {$video_bitrate}k -pass 2 \
        -c:a aac -b:a {$audio_bitrate}k $output

    rm -f ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree
    echo "✅ Done: $output"
end

function spawn
    $argv >/dev/null 2>&1 &
    disown
end

abbr --add s spawn


# 'ztree' helper: list archive contents as tree
function ztree
    if not test -f $argv[1]
        echo "Usage: ztree <archive.zip>"
        return 1
    end
    unzip -Z1 $argv[1] | tree --fromfile
end


# ── extract function (OMZ extract plugin equivalent) ──────────────
function extract
  if test (count $argv) -eq 0
      echo "Usage: extract <archive>"
      return 1
  end
  for f in $argv
      if not test -f $f
          echo "extract: '$f' is not a valid file"
          continue
      end
      switch $f
          case '*.tar.bz2' '*.tbz2'
              tar xjf $f
          case '*.tar.gz' '*.tgz'
              tar xzf $f
          case '*.tar.xz' '*.txz'
              tar xJf $f
          case '*.tar.zst'
              tar --zstd -xf $f
          case '*.tar'
              tar xf $f
          case '*.bz2'
              bunzip2 $f
          case '*.gz'
              gunzip $f
          case '*.zip'
              unzip $f
          case '*.7z'
              7z x $f
          case '*.rar'
              unrar x $f
          case '*.Z'
              uncompress $f
          case '*'
              echo "extract: '$f' - unknown archive format"
      end
  end
end

# run on enter
function __magic_enter_or_execute
    set -l cmd (string trim (commandline))
    if test -z "$cmd"
        commandline "lsd"
        commandline -f execute
    else
        commandline -f execute
    end
end

