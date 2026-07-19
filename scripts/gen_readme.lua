-- Rewrites the Variants section of the README from the palette headers, so a
-- new palette self-wires its README entry. Only the region between the
-- `<!-- variants:start ... -->` and `<!-- variants:end -->` markers is touched;
-- the rest of the README is left exactly as written.
-- Usage: nvim --headless -l scripts/gen_readme.lua [README.md]
local readme = arg[1] or 'README.md'
local palette_dir = 'lua/lazypunk/palettes'

-- Known display order; any palette not listed is appended alphabetically.
local order = { 'lucy', 'david', 'rebecca' }

-- Discover variants from the palette files.
local present = {}
for _, f in ipairs(vim.fn.glob(palette_dir .. '/*.lua', false, true)) do
  present[vim.fn.fnamemodify(f, ':t:r')] = true
end

local ordered, seen = {}, {}
for _, v in ipairs(order) do
  if present[v] then ordered[#ordered + 1] = v; seen[v] = true end
end
local rest = {}
for v in pairs(present) do if not seen[v] then rest[#rest + 1] = v end end
table.sort(rest)
for _, v in ipairs(rest) do ordered[#ordered + 1] = v end

-- Blurb = text after the em dash on the palette's first line, sans trailing dot.
local function blurb(v)
  local first = (vim.fn.readfile(palette_dir .. '/' .. v .. '.lua', '', 1))[1] or ''
  local d = first:match('—%s*(.+)$') or first:gsub('^%-%-%s*', '')
  return (d:gsub('%s*%.%s*$', ''))
end

local block = {}
for _, v in ipairs(ordered) do
  block[#block + 1] = string.format('### `lazypunk-%s` — %s', v, blurb(v))
  block[#block + 1] = ''
  block[#block + 1] = string.format('![lazypunk-%s neovim](assets/showcase-%s.svg)', v, v)
  block[#block + 1] = string.format('![lazypunk-%s tmux](assets/tmux-%s.svg)', v, v)
  if v ~= ordered[#ordered] then block[#block + 1] = '' end
end

local content = table.concat(vim.fn.readfile(readme), '\n')
local sm = content:find('<!%-%- variants:start')
local em = content:find('<!%-%- variants:end %-%->', 1)
if not sm or not em then error('variants markers not found in ' .. readme) end
-- keep the start-marker line intact, replace everything up to the end marker
local start_line_end = content:find('\n', sm) or #content
local before = content:sub(1, start_line_end)         -- through the start-marker line + newline
local after = content:sub(em)                          -- from the end marker onward
local new = before .. table.concat(block, '\n') .. '\n' .. after

if new ~= content then
  vim.fn.writefile(vim.split(new, '\n', { plain = true }), readme)
  print('updated ' .. readme)
else
  print(readme .. ' already current')
end
