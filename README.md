# gou.nvim

An experimental plugin with miscellaneous functions for go.

## Features

- Generate tests by gotests

## Install

<details>
    <summary>lazy.nvim</summary>

```lua
{
    "aryonal/gou.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    ft = {
        "go",
    },
    cmd = {
        "GoTests",
        "GoTestsFunc",
    },
    config = function()
        require("gou").setup({})
    end
}
```

</details>

## Configuration

Default options

```lua
{
    gotests = {
        named = true,
        template_dir = "",
    }
}
```

## Usage

- `GoTestsFunc`: generate test for function cursor is in
- `GoTests`: generate test for current file

## Relevant

- [gotests-vim](https://github.com/buoto/gotests-vim)
