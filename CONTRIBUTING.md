# Contributing to lazypunk

Thanks for your interest! lazypunk is palette-driven: every variant is a single
Lua palette table, and the Neovim highlight groups, the tmux theme, the showcase
images, and the README all read from it. Adding a variant means adding a palette
- nothing else is hand-written.

## Adding a variant

1. Drop a palette table at `lua/lazypunk/palettes/<name>.lua`, mirroring the keys
   in an existing palette. Its first-line comment
   `-- lazypunk-<name> — <blurb>.` becomes the README entry.
2. Add a two-line `colors/lazypunk-<name>.lua`:

   ```lua
   -- :colorscheme lazypunk-<name>
   require("lazypunk").load("<name>")
   ```

3. Regenerate the derived artifacts (tmux theme, both showcase SVGs, README
   Variants section):

   ```sh
   nvim --headless -l scripts/gen_tmux.lua <name> tmux-powerline/themes/lazypunk-<name>.sh
   nvim --headless -l scripts/gen_showcase.lua <name> assets/showcase-<name>.svg
   nvim --headless -l scripts/gen_tmux_showcase.lua <name> assets/tmux-<name>.svg
   nvim --headless -l scripts/gen_readme.lua README.md
   ```

## Before opening a PR

- **Load check** - every colorscheme must load cleanly:

  ```sh
  nvim --headless -l scripts/check_load.lua
  ```

- **No artifact drift** - the generated files must match their palettes. Run the
  regen commands above and confirm `git status` is clean. CI enforces this.
- **Lint** - `luacheck lua scripts colors` (Lua) and, if you touched `site/`,
  `cd site && bun run test`.

## The site

The showcase under `site/` is a Vite + Svelte app. Its palette data is generated
from the Lua palettes so it never drifts:

```sh
nvim --headless -l scripts/gen_site.lua site/src/lib/palettes.json   # from repo root
cd site && bun install && bun run dev
```

## Style

Keep changes minimal and palette-first. If a change can be driven from a palette
table instead of hand-edited into a generated file, do it that way.
