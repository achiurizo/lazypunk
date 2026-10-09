#!/usr/bin/env bash
# TPM entry point for the lazypunk tmux theme.
#   set -g @plugin 'achiurizo/lazypunk'
#   set -g @lazypunk_variant 'lucy'   # optional: lucy (default), david, rebecca, sasha
# Sources the matching native theme in tmux/, falling back to lucy if the
# requested variant does not exist.
set -euo pipefail

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

variant="$(tmux show-option -gqv @lazypunk_variant)"
[ -n "$variant" ] || variant="lucy"

conf="$current_dir/tmux/lazypunk-$variant.conf"
[ -f "$conf" ] || conf="$current_dir/tmux/lazypunk-lucy.conf"

tmux source-file "$conf"
