## Neovim Ultivisual

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

### The Ultimate visual mode plugin for neovim written by Lua Script

## Features

1. Ultimate **indent** making.
    - Whatever much times you wrote spaces, ***Ultivisual*** would make indent accurately.
    - If you use *2 spaces* for tab, the plugin would change all the selected line as *2 spaces*. ***(1 space would be changed to 2 spaces!)***
    - If you use *4 spaces* for tab, the plugin would cahnge all the selected line as *4 spaces*. ***(1~3 spaces would be changed to 4 spaces!)***
    - Also noexpandtab supported.
    - You can repeat to make indent as long as you don't deselect the line!

2. Ultimate **bracket** making.
    - Just select the line by ***visual mode***, and push key to bracket the selected line!
    - You can set the pair of ***bracket shapes*** whatever you want.
    - Optionally, you can set to ignore the indent of the start line.
    - At last, the cursor would automatically move to ***the end of the bracket***.

3. Ultimate yank **paste**
    - This feature makes that you can paste copied lines as you ***intended***.
    - At last, the cursor would automatically move to ***the end of the pasted line***.

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
  -- You can switch the ultimate visual features.
  features = {
    indent = true,
    bracket = true,
    paste = true,
  },

  -- The keymap settings for features here.
  -- key; mapped key
  -- modes; included mode (include Visual mode for ultimate features!)
  keymaps = {
    make_indent = {
      key = '<TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    delete_indent = {
      key = '<S-TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    bracket = {
      -- Only for 'v'; visual mode.
      -- You can config the bracket shapes whatever you want.
      { key = '(', shape = { '(',')' } },
      { key = '[', shape = { '[',']' } },
      { key = '{', shape = { '{','}' } },
    },

    paste = {
      key = '<C-V>',
      modes = { 'v','n','i' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },
  },

  -- The option settings for features here.
  options = {
    bracket = {
      -- Ignore the first line's indent when included while making bracket.
      ignore_indent = true,
    },
  },
})
```
