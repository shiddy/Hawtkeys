#!/bin/bash
# ===== CONFIG =====

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    CHOOSE="rofi"
    CHOOSE_FLAGS="-dmenu"
    CLIPBOARD="xclip"
    CLIPBOARD_FLAGS="-selection c"
    PLAY='mpg123'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CHOOSE="choose"
    CHOOSE_FLAGS=""
    CLIPBOARD="pbcopy"
    CLIPBOARD_FLAGS=""
    PLAY='afplay'

    # check the usual places
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:/opt/homebrew/bin"

    # muh emojis
    export LC_CTYPE=UTF-8
fi

HOTKEYDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# ===== Tests =====
# does the $CHOOSE Program exist?
if ! type $CHOOSE 2>/dev/null 1>&2; then
    echo "\$CHOOSE Not in $$PATH."
    exit 1
fi

# Does the $CLIPBOARD program exist?
if ! type $CLIPBOARD 2>/dev/null 1>&2; then
    echo "\$CLIPBOARD Not in $$PATH."
    exit 1
fi

#  Does the $PLAY Program exist?
if ! type $PLAY 2>/dev/null 1>&2; then
    echo "\$PLAY Not in $$PATH."
    exit 1
fi

# ===== Choices =====
COMMAND="$1"
case $COMMAND in
    emoji)
        # Assign $CHOICE; The if allows a graceful exit
        if CHOICE="$($CHOOSE $CHOOSE_FLAGS < $HOTKEYDIR/choices/emojis)"; then
            printf "%s" "$CHOICE" | $CLIPBOARD $CLIPBOARD_FLAGS
        fi
        ;;

    macros)
        if CHOICE="$(awk -F"	" '{print $1}' "$HOTKEYDIR/choices/macros" | $CHOOSE $CHOOSE_FLAGS)"; then
            grep "$CHOICE" "$HOTKEYDIR/choices/macros" | awk -F"	" '{for (i=2; i<NF; i++) printf $i " "; print $NF}' | "$SHELL"
        fi
        ;;

    sfx)
        if CHOICE="$(ls $HOTKEYDIR/choices/sfx | sed s/.mp3//g | $CHOOSE $CHOOSE_FLAGS)"; then
            echo "$PLAY \"$HOTKEYDIR/choices/sfx/$CHOICE.mp3\"" | "$SHELL"
        fi
        ;;
esac
