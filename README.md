# go.nvim

A toy plugin with miscellaneous functions for go.

## Features

- Generate tests by gotests
- Run tests close to the cursor

## Install

<details>
    <summary>lazy.nvim</summary>

```lua
{
    "aryonal/go.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = {
        "go",
    },
    config = function()
        require("go").setup({})
    end
}
```

</details>

## Configuration

Default options

```lua
{
    mode = "terminal", -- one of "terminal", "sync", "async"
    run = {
        enabled = true,
        mode = "terminal",
        async = true, ---@deprecated: use mode instead, ignore if mode is set
        test_flag = "", -- go help testflag, string | table
    },
    gotests = {
        enabled = true,
        mode = "terminal",
        async = true, ---@deprecated: use mode instead, ignore if mode is set
        named = true, -- gotests -named
        template_dir = "",
    }
}
```

## Usage

For gotests

- `GoTestsGenFunc`: generate test for the function cursor is in
- `GoTestsGen`: generate test for current file

For run

- `GoTestPkg`: run `go test` over current package
- `GoTestFunc`: run `go test` over function cursor is in
- `GoTestFunc <test case name>`: run `go test` over certain sub case in the function cursor is in

## Roadmap

- [ ] Support Fuzz and Bench
- [ ] Support package management, packspec or rockspec

## Relevant

- [gotests-vim](https://github.com/buoto/gotests-vim)
