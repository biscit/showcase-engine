#!/bin/bash

# Define script name without path
SCRIPT_NAME=$(basename $0)

info() {
    # blue
    echo -e "$(gum style --foreground 27 --padding "0 1" " $SCRIPT_NAME ") $1" >&2
}

success() {
    # green
    echo -e "$(gum style --foreground 76 --padding "0 1" " $SCRIPT_NAME ") $1" >&2
}

error() {
    # red
    echo -e "$(gum style --foreground 196 --padding "0 1" " $SCRIPT_NAME ") $1" >&2
}

warning() {
    # yellow
    echo -e "$(gum style --foreground 226 --padding "0 1" " $SCRIPT_NAME ") $1" >&2
}

help() {
    # grey
    echo -e "$(gum style --foreground 248 --padding "0 1" " $SCRIPT_NAME ") $1" >&2
}
