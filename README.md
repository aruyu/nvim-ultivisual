## Neovim Ultivisual

### A visual mode plugin for neovim written by Lua Script

## Features

-

## Installation

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'astaos/nvim-ultivisual',
  config = function() require("nvim-ultivisual").setup() end,
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'astaos/nvim-ultivisual'
lua << EOF
  require("nvim-ultivisual").setup()
EOF
```

## Configuration

You can setup the features by the following options.

```lua
-- Default options.
require("nvim-ultivisual").setup({
  --
  features = {
    indent = true,
    delimiter = true,
    paste = true,
  },

  --
  keymaps = {
    make_indent = {
      key = '<TAB>',
      modes = { 'v','n' },
    },

    delete_indent = {
      key = '<S-TAB>',
      modes = { 'v','n' },
    },

    delimiter = {
      { key = '(', shape = { '(',')' } },
      { key = '[', shape = { '[',']' } },
      { key = '{', shape = { '{','}' } },
    },

    paste = { key = '<C-V>' },
  },
})
```
