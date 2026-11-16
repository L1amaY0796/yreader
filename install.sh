#!/bin/sh
# yreader installer / 安裝程式
#   ./install.sh [DIR]         install into DIR (default: ~/.local/bin)
#   YREADER_LANG=en ./install.sh    skip the language question
set -e

dest="${1:-$HOME/.local/bin}"
src="$(cd "$(dirname "$0")" && pwd)/yreader"
url="https://raw.githubusercontent.com/L1amaY0796/yreader/main/yreader"

if ! command -v python3 >/dev/null 2>&1; then
    echo "yreader needs Python 3.7+ (python3 not found) / 需要 Python 3.7 以上" >&2
    exit 1
fi

# --- language / 語言 ---
lang="$YREADER_LANG"
if [ -z "$lang" ]; then
    case "${LC_ALL:-${LC_MESSAGES:-$LANG}}" in
        zh*) def=1 ;;
        *)   def=2 ;;
    esac
    ans=
    if [ -r /dev/tty ]; then
        printf 'Select interface language / 選擇介面語言\n  1) 繁體中文\n  2) English\n[1/2] (default %s): ' "$def"
        read -r ans </dev/tty || ans=
    fi
    case "${ans:-$def}" in
        1|zh*) lang=zh ;;
        2|en*) lang=en ;;
        *) [ "$def" = 1 ] && lang=zh || lang=en ;;
    esac
fi

# --- install / 安裝 ---
mkdir -p "$dest"
if [ -f "$src" ]; then
    cp "$src" "$dest/yreader"
else    # run via "curl ... | sh": download the program itself
    curl -fsSL "$url" -o "$dest/yreader"
fi
chmod 755 "$dest/yreader"
"$dest/yreader" --lang "$lang"

if [ "$lang" = zh ]; then
    echo "已安裝到 $dest/yreader"
    echo "之後可用 yreader --lang en 或閱讀中按 L 切換語言"
    case ":$PATH:" in *":$dest:"*) ;; *) echo "注意：$dest 不在 PATH 裡，請把它加進 ~/.bashrc" ;; esac
else
    echo "Installed to $dest/yreader"
    echo "Change the language any time with: yreader --lang zh   (or press L while reading)"
    case ":$PATH:" in *":$dest:"*) ;; *) echo "Note: $dest is not in your PATH; add it in ~/.bashrc" ;; esac
fi
