export function snippets(variant) {
  const cs = `lazypunk-${variant}`;
  return [
    {
      id: 'lazy',
      label: 'lazy.nvim',
      code: `{ "achiurizo/lazypunk", lazy = false, priority = 1000 }\n\nvim.cmd.colorscheme("${cs}")`,
    },
    {
      id: 'lazyvim',
      label: 'LazyVim',
      code: `{ "LazyVim/LazyVim", opts = { colorscheme = "${cs}" } }`,
    },
    {
      id: 'tmux',
      label: 'tmux-powerline',
      code: `export TMUX_POWERLINE_THEME="${cs}"\nexport TMUX_POWERLINE_DIR_USER_THEMES="/path/to/lazypunk/tmux-powerline/themes"`,
    },
  ];
}
