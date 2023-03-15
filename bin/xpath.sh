#!/usr/bin/env bash

selected=$(find . | grep '.xml' | fzf)
xidel -s --xpath "$@" $selected
