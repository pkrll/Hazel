#!/usr/bin/env bash

_hazel_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local line="${COMP_WORDS[@]}"
  local completions="$(hazel cmplt "$line" "$word")"
  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -F _hazel_complete hazel
