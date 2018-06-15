# completion.zsh

_hazel_complete() {
  local line word completions
  read -c line
  word="$1"
  completions="$(hazel cmplt "${line}" "${word}")"
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _hazel_complete hazel
