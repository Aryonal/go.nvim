# gou.nvim

An experimental plugin with miscellaneous functions for go.

## Features

- Generate tests by gotests, require treesitter

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
    run = {
        enabled = true,
        test_flag = "", -- go help testflag
    },
    gotests = {
        enabled = true,
        named = true, -- gotests -named
        template_dir = "",
    }
}
```

## Usage

For gotests

- `GoTestsFunc`: generate test for function cursor is in
- `GoTests`: generate test for current file

For run

- `RunTestPkg`: run `go test` over current package
- `RunTestFunc`: run `go test` over function cursor is in
- `RunTestFunc <test case name>`: run `go test` over certain sub case in the function cursor is in

## Relevant

- [gotests-vim](https://github.com/buoto/gotests-vim)
