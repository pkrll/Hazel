# init.sh

if [ -n "$BASH_VERSION" ]; then
  root="$(dirname "${BASH_SOURCE[0]}")"
  source "$root/bash/hazel"

elif [ -n "$ZSH_VERSION" ]; then
  root="$(dirname "$0")"
  source "$root/zsh/_hazel"
fi
