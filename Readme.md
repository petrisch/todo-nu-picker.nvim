# Todo-nu Telescope extension

A Telescope extension that allows to fuzzy find your todos.

## Requirements

- [nushell](https://www.nushell.sh/) is expected to be in path
- [todo-nu](https://github.com/petrisch/todo-nu) is supposed to be sourced in the nushell config.nu
- neovim and [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Since todo-nu depends on ripgrep and git you need those too.

## Installation

With Lazy the installation goes like this:

```lua
  {
    "petrisch/todo-nu-picker.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          todo_nu_picker = {
            ext_config = {
              nu_config = "~/.config/nushell/config.nu",
              wiki_path = "~/wiki/",
            },
          },
        },
      })
    end,
  },
```

If the default paths are the same, the whole config function is optional.
Otherwise you have to provide the path to your nushell configuration,
where the `td` command is supposed to be sourced.
Also you need the path to your wiki added, where the todos are comming from.

Maybe you have that folder already set up for something like [vimwiki](https://github.com/vimwiki/vimwiki) or [Telekasten](https://github.com/renerocksai/telekasten.nvim)

## Usage

Telescope should be picking up the plugin extension and let you run it with `:Telescope todo-nu-picker`.

On Lazy distro I have set the keymap to `<leader>fd` for "find doings",
since the "search todo" is already taken for `TODO` and `FIXME` entries.
