# lazypunk

A palette-driven Neovim colorscheme engine with Cyberpunk: Edgerunners inspired
variants. The highlight groups are variant-agnostic and read only semantic role
names, so adding a variant means adding a palette - nothing else.

## Variants

| Colorscheme          | Mood                                                      |
| -------------------- | -------------------------------------------------------- |
| `cyberpunk-lucy`     | Cool indigo night; neon violet / electric blue / magenta |
| `cyberpunk-david`    | Warm gritty night; signature electric yellow + teal      |
| `cyberpunk-rebecca`  | Murky teal-green night; hot pink + mint + amber          |

## Install

### lazy.nvim

```lua
{ "achiurizo/lazypunk", lazy = false, priority = 1000 }
```

Local development (from a clone):

```lua
{ dir = vim.fn.expand("~/code/lazypunk"), name = "lazypunk", lazy = false, priority = 1000 }
```

Then:

```lua
vim.cmd.colorscheme("cyberpunk-lucy")
```

Under LazyVim:

```lua
{ "LazyVim/LazyVim", opts = { colorscheme = "cyberpunk-lucy" } }
```

## Structure

```
colors/cyberpunk-{lucy,david,rebecca}.lua   -- :colorscheme entry points
lua/cyberpunk/init.lua                       -- M.load(name)
lua/cyberpunk/theme.lua                       -- assembles highlight groups from palette
lua/cyberpunk/groups/                         -- editor, syntax, treesitter, lsp (pure palette -> hl table)
lua/cyberpunk/palettes/                       -- one table per variant
```

## Adding a variant

Drop a palette table at `lua/cyberpunk/palettes/<name>.lua` mirroring the keys in
an existing palette, then add a two-line `colors/cyberpunk-<name>.lua`:

```lua
-- :colorscheme cyberpunk-<name>
require("cyberpunk").load("<name>")
```
