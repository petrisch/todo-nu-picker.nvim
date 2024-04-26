# Todo-nu Telescope extension

A Telescope extension that allows to fuzzy find your todos.

## Requirements

- [nushell](https://www.nushell.sh/) is expected to be in path
- [todo-nu](https://github.com/petrisch/todo-nu) is supposed to be sourced in the nushell config.nu
- neovim and [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Since todo-nu depends on ripgrep and git you need those too.


## Installation

With Lazy the installation is:

```
{
  "petrisch/todo-nu-picker.nvim",
}
```
You have to provide the path to your nushell configuration,
where the `td` command is supposed to be sourced.
Also you need the path to your wiki added, where the todos are comming from.

Maybe you have that folder already set up for something like [vimwiki](https://github.com/vimwiki/vimwiki) or [Telekasten](https://github.com/renerocksai/telekasten.nvim)

## Usage

Telescope should be picking up the plugin extension and let you run it with `:Telescope todo-nu-picker`.

