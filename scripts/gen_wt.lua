-- Generates a Windows Terminal color scheme for a lazypunk variant from its
-- palette. Add the object to settings.json "schemes", then set a profile's
-- "colorScheme" to "lazypunk-<variant>".
-- Keys are written in a fixed order by hand: vim.json.encode does not keep key
-- order, and CI's regenerate-and-diff check needs byte-stable output.
-- Usage: nvim --headless -l scripts/gen_wt.lua <variant> <out.json>
local variant = arg[1]
local out = arg[2]

vim.opt.runtimepath:prepend(vim.fn.getcwd())
local p = require('lazypunk.palettes.' .. variant)

assert(type(p.ansi) == 'table' and #p.ansi == 16,
  'palette ' .. variant .. ': ansi must hold 16 colors')

local ansi_keys = {
  'black', 'red', 'green', 'yellow', 'blue', 'purple', 'cyan', 'white',
  'brightBlack', 'brightRed', 'brightGreen', 'brightYellow',
  'brightBlue', 'brightPurple', 'brightCyan', 'brightWhite',
}

local fields = {
  { 'name', 'lazypunk-' .. variant },
  { 'background', p.bg },
  { 'foreground', p.fg },
  { 'cursorColor', p.accent },
  { 'selectionBackground', p.bg_sel },
}
for i, key in ipairs(ansi_keys) do
  fields[#fields + 1] = { key, p.ansi[i] }
end

local lines = { '{' }
for i, f in ipairs(fields) do
  local sep = i < #fields and ',' or ''
  lines[#lines + 1] = string.format('    "%s": "%s"%s', f[1], f[2], sep)
end
lines[#lines + 1] = '}'

vim.fn.mkdir(vim.fn.fnamemodify(out, ':h'), 'p')
vim.fn.writefile(lines, out)
print('wrote ' .. out)
