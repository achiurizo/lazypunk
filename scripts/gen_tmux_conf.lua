-- Generates a native (dependency-free) tmux theme for a lazypunk variant from
-- its palette. Sets status bar, window, pane, message, mode, and clock colors
-- plus a minimal, overridable status line -- no tmux-powerline required.
-- tmux renders truecolor hex directly under a truecolor terminal.
-- Usage: nvim --headless -l scripts/gen_tmux_conf.lua <variant> <out.conf>
local variant = arg[1]
local out = arg[2]

vim.opt.runtimepath:prepend(vim.fn.getcwd())
local p = require('lazypunk.palettes.' .. variant)

-- Role -> palette key mapping. The `p_*` keys are exported as @lazypunk_<role>
-- user options (the machine-readable palette, same role vocabulary as the
-- Neovim theme); the rest drive the native status/accent styles.
local sub = {
  variant       = variant,
  -- exported palette roles (read back via `tmux show-option -gqv @lazypunk_<role>`)
  p_bg          = p.bg,
  p_bg_dark     = p.bg_dark,
  p_bg_float    = p.bg_float,
  p_border      = p.border,
  p_fg          = p.fg,
  p_fg_dim      = p.fg_dim,
  p_comment     = p.comment,
  p_string      = p.string,
  p_keyword     = p.keyword,
  p_number      = p.number,
  p_accent      = p.accent,
  p_accent2     = p.accent2,
  p_warn        = p.warn,
  p_error       = p.error,
  -- style roles
  bar_bg        = p.bg_dark,  -- status bar background
  bar_fg        = p.fg,       -- default status text
  session_bg    = p.string,   -- session segment (mint/teal)
  session_fg    = p.bg_dark,  -- text on the bright session segment
  cur_bg        = p.keyword,  -- current window (violet)
  cur_fg        = p.bg_dark,
  inact_fg      = p.fg_dim,   -- inactive windows
  date_fg       = p.fg_dim,
  time_fg       = p.fg,
  border        = p.border,   -- inactive pane border
  active_border = p.keyword,  -- active pane border (accent)
  msg_bg        = p.accent2,  -- command/message line
  msg_fg        = p.bg_dark,
  mode_bg       = p.warn,     -- copy-mode selection highlight
  mode_fg       = p.bg_dark,
  clock         = p.accent,   -- clock-mode digits
  activity      = p.warn,     -- window activity flag
  bell          = p.error,    -- window bell flag
}

local template = [[
# lazypunk-{{variant}} — native tmux theme
# Generated from lua/lazypunk/palettes/{{variant}}.lua by scripts/gen_tmux_conf.lua.
# Truecolor terminal required. Source from your ~/.tmux.conf:
#   source-file /path/to/lazypunk/tmux/lazypunk-{{variant}}.conf
# or via TPM: set -g @plugin 'achiurizo/lazypunk'  (+ set -g @lazypunk_variant '{{variant}}')
#
# Set `@lazypunk_status off` BEFORE sourcing to skip the status bar (keep only
# the accent colors) -- e.g. when another status plugin owns the bar.

# --- palette (machine-readable; read with: tmux show-option -gqv @lazypunk_accent)
set -g @lazypunk_variant "{{variant}}"
set -g @lazypunk_bg       "{{p_bg}}"
set -g @lazypunk_bg_dark  "{{p_bg_dark}}"
set -g @lazypunk_bg_float "{{p_bg_float}}"
set -g @lazypunk_border   "{{p_border}}"
set -g @lazypunk_fg      "{{p_fg}}"
set -g @lazypunk_fg_dim  "{{p_fg_dim}}"
set -g @lazypunk_comment "{{p_comment}}"
set -g @lazypunk_string  "{{p_string}}"
set -g @lazypunk_keyword "{{p_keyword}}"
set -g @lazypunk_number  "{{p_number}}"
set -g @lazypunk_accent  "{{p_accent}}"
set -g @lazypunk_accent2 "{{p_accent2}}"
set -g @lazypunk_warn    "{{p_warn}}"
set -g @lazypunk_error   "{{p_error}}"

# --- accents (pane borders, message, copy-mode, clock, display-panes)
set -g pane-border-style "fg={{border}}"
set -g pane-active-border-style "fg={{active_border}}"
set -g display-panes-colour "{{border}}"
set -g display-panes-active-colour "{{active_border}}"

set -g message-style "fg={{msg_fg}},bg={{msg_bg}}"
set -g message-command-style "fg={{msg_fg}},bg={{msg_bg}}"
set -g mode-style "fg={{mode_fg}},bg={{mode_bg}}"

set -g clock-mode-colour "{{clock}}"

# --- status bar (skipped when @lazypunk_status is 'off')
%if "#{!=:#{@lazypunk_status},off}"
set -g status-style "fg={{bar_fg}},bg={{bar_bg}}"
set -g status-left-length 40
set -g status-right-length 60
set -g status-left "#[fg={{session_fg}},bg={{session_bg}},bold] #S #[fg={{session_bg}},bg={{bar_bg}}] "
set -g status-right "#[fg={{date_fg}}] %Y-%m-%d #[fg={{time_fg}},bold] %H:%M "

set -g window-status-separator ""
set -g window-status-current-format "#[fg={{cur_fg}},bg={{cur_bg}},bold] #I #W "
set -g window-status-format "#[fg={{inact_fg}}] #I #W "
set -g window-status-activity-style "fg={{activity}}"
set -g window-status-bell-style "fg={{bell}}"
%endif
]]

local outstr = template:gsub('{{([%w_]+)}}', function(k)
  local v = sub[k]
  if v == nil then error('unmapped placeholder: ' .. k) end
  return v
end)

vim.fn.mkdir(vim.fn.fnamemodify(out, ':h'), 'p')
local f = io.open(out, 'w')
f:write(outstr)
f:close()
print('wrote ' .. out)
