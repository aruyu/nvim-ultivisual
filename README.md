## Neovim Ultivisual

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

<div align='center'>

```css
      __  ______  _       _                  __
     / / / / / /_(_)   __(_)______  ______ _/ /
   / / / / / __/ / | / / / ___/ / / / __ `/ /
 / /_/ / / /_/ /| |/ / (__  ) /_/ / /_/ / /
\____/_/\__/_/ |___/_/____/\__,_/\__,_/_/
```

### The Ultimate visual mode plugin for neovim written by Lua Script

![main](https://user-images.githubusercontent.com/75081360/223333562-0f954e54-44be-450b-acac-9396261e925b.gif)

</div>

## Features

1. Ultimate **indent** making.
    - Whatever much times you wrote spaces, ***Ultivisual*** would make indent accurately.
    - As your *'shiftwidth'* setting, the plugin would change all the selected lines. ***(change accurately according to 'shiftwidth')***
    - Also noexpandtab supported.
    - You can repeat to make indent as long as you don't deselect the line!

https://user-images.githubusercontent.com/75081360/223304085-dff6c9e2-145d-4975-ace3-e4f727da0056.mp4

2. Ultimate **brackets** making.
    - Just select the line by ***visual mode***, and push key to brackets the selected line!
    - You can set the pair of ***brackets' shape*** whatever you want.
    - Optionally, you can set to ignore the indent of the start line.
    - At last, the cursor would automatically move to ***the end of the brackets***.

https://user-images.githubusercontent.com/75081360/223304118-abfd88f1-f854-4a3c-9291-c2807c24599e.mp4

3. Ultimate yank **paste**.
    - This feature makes that you can paste copied lines as you ***intended***.
    - At last, the cursor would automatically move to ***the end of the pasted line***.

https://user-images.githubusercontent.com/75081360/223304150-fc7abeb8-c150-40dc-bdfb-11e6bf540278.mp4

## Installation

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'aruyu/nvim-ultivisual',
  config = function() require("nvim-ultivisual").setup() end,
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'aruyu/nvim-ultivisual'
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
    brackets = true,
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

    brackets = {
      -- Only for 'v'; visual mode.
      -- You can config the brackets' shape whatever you want.
      { key = '(', shapes = { '(',')' } },
      { key = '{', shapes = { '{','}' } },
    },

    paste = {
      key = '<C-V>',
      modes = { 'v','n','i' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },
  },

  -- The option settings for features here.
  options = {
    brackets = {
      -- Ignore the first line's indent when included while making brackets.
      ignore_indent = true,
    },
  },
})
```

## Contributors

> Always be welcomed all the pull requests! :D
