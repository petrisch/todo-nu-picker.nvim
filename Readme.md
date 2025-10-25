# Todo-nu Fuzzy Finder extension

A fuzzy finder for your todos.

## Requirements

- [nushell](https://www.nushell.sh/) is expected to be in path
- [todo-nu](https://github.com/petrisch/todo-nu) is supposed to be sourced in the nushell config.nu
- neovim and either:
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- Since todo-nu depends on ripgrep and git you need those too.

## Installation

With Lazy the installation goes like this:

```lua
  {
    "petrisch/todo-nu-picker.nvim",
    lazy = false,
    dependencies = {
      "telescope.nvim",
      "snacks.nvim",
      "ibhagwan/fzf-lua",
    },
    opts = function(_, opts)
      require("todo-nu-picker").setup({
        picker = "fzf-lua", -- or "telescope"
        nu_config = "~/.config/nushell/config.nu",
        wiki_path = Basic_paths.wiki_dir,
      })
    end,
  },
```

If the default paths are the same, the whole config function is optional.
Otherwise you have to provide the path to your nushell configuration,
where the `td` command is supposed to be sourced.
Also you need the path to your wiki added, where the todos are comming from.

## Usage

Telescope should be picking up the plugin extension and let you run it with `:Telescope todo-nu-picker`.

With fzf a keymap to `fd` is preset.
