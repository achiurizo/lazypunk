# lazypunk

A palette-driven Neovim colorscheme engine with Cyberpunk: Edgerunners inspired
variants. The highlight groups are variant-agnostic and read only semantic role
names, so adding a variant means adding a palette - nothing else.

## Variants

### `lazypunk-lucy` — cool indigo night; neon violet / electric blue / magenta

![lazypunk-lucy](assets/showcase-lucy.svg)

### `lazypunk-david` — warm gritty night; signature electric yellow + teal

![lazypunk-david](assets/showcase-david.svg)

### `lazypunk-rebecca` — murky teal-green night; hot pink + mint + amber

![lazypunk-rebecca](assets/showcase-rebecca.svg)

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
vim.cmd.colorscheme("lazypunk-lucy")
```

Under LazyVim:

```lua
{ "LazyVim/LazyVim", opts = { colorscheme = "lazypunk-lucy" } }
```

## Structure

```
colors/lazypunk-{lucy,david,rebecca}.lua   -- :colorscheme entry points
lua/lazypunk/init.lua                       -- M.load(name)
lua/lazypunk/theme.lua                       -- assembles highlight groups from palette
lua/lazypunk/groups/                         -- editor, syntax, treesitter, lsp (pure palette -> hl table)
lua/lazypunk/palettes/                       -- one table per variant
```

## Adding a variant

Drop a palette table at `lua/lazypunk/palettes/<name>.lua` mirroring the keys in
an existing palette, then add a two-line `colors/lazypunk-<name>.lua`:

```lua
-- :colorscheme lazypunk-<name>
require("lazypunk").load("<name>")
```
