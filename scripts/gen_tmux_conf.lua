-- Generates a native (dependency-free) tmux theme for a lazypunk variant from
-- its palette. Sets status bar, window, pane, message, mode, and clock colors
-- plus a minimal, overridable status line -- no tmux-powerline required.
-- tmux renders truecolor hex directly under a truecolor terminal.
-- Usage: nvim --headless -l scripts/gen_tmux_conf.lua <variant> <out.conf>
local variant = arg[1]
local out = arg[2]

vim.opt.runtimepath:prepend(vim.fn.getcwd())
local p = require('lazypunk.palettes.' .. variant)

-- Role -> palette key mapping for native tmux elements.
local sub = {
  variant       = variant,
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

set -g pane-border-style "fg={{border}}"
set -g pane-active-border-style "fg={{active_border}}"
set -g display-panes-colour "{{border}}"
set -g display-panes-active-colour "{{active_border}}"

set -g message-style "fg={{msg_fg}},bg={{msg_bg}}"
set -g message-command-style "fg={{msg_fg}},bg={{msg_bg}}"
set -g mode-style "fg={{mode_fg}},bg={{mode_bg}}"

set -g clock-mode-colour "{{clock}}"
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
