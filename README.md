# Neovim configuration for [Colemak](https://colemak.com) users

> NOTE: This readme may be out of date and not yet complete

[chinese README](./README.zh_CN.md)

## Table of contents
* [Dependencies](#dependencies)
* [Installation](#installation)
* [Basic Settings](#basic-settings)
* [Keyboard Shortcuts](#keyboard-shortcuts)
  - [1 Basic Editor Features](#1-basic-editor-features)
    + [1.1 The Most Basics](#1.1-the-most-basics)
    + [1.2 Remapped Cursor Movement](#1.2-remapped-cursor-movement)
    + [1.3 Remapped Insert Mode Keys](#1.3-remapped-insert-mode-keys)
    + [1.4 Command Mode Keymaps](#1.4-command-mode-keymaps)
    + [1.5 Remapped Text Manipulating Commands in Normal Mode](#1.5-remapped-text-manipulating-commands-in-normal-mode)
    + [1.6 Other Useful Normal Mode Remappings](#1.6-other-useful-normal-mode-remappings)
    + [1.7 Register related settings](#1.7-register-related-settings)
  - [2 Window Management](#2-window-management)
    + [2.1 Creating Window Through Split Screen](#2.1-creating-window-through-split-screen)
    + [2.2 Moving the Cursor Between Different Windows](#2.2-moving-the-cursor-between-different-windows)

-----

## Dependencies
* [**Neovim**](https://neovim.io/) >= 0.10 (nightly)
* [curl](https://curl.se/)
* [git](https://git-scm.com/)
* [node.js](https://nodejs.org/)
* [npm](https://www.npmjs.com/)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [xclip](https://github.com/astrand/xclip) (or other clipboard tools)
* [make](https://www.gnu.org/software/make/)
* [Lazygit](https://github.com/jesseduffield/lazygit)
* [z](https://github.com/rupa/z/)
* [dotnet](https://dotnet.microsoft.com/en-us/download)
* Optional:
  - [Nerd Font](https://www.nerdfonts.com/)

## Installation
1. Install all the above dependencies
2. Run `git clone https://github.com/gczcn/nvim.git ~/.config/nvim` to clone the repository
3. Run `npm install -g neovim` in terminal
4. Run `nvim`

## Basic Settings
|Opt|Value|Action|
|---|------|-----|
|`fileencoding`|`'UTF-8'`|file content encoding for the buffer|
|`autowrite`|`true`|Enable auto write|
|`number`|`true`|Show numberline|
|`relativenumber`|`true`|Show relative numberline|
|`completeopt`|`{ "menu", "menuone", "noselect" }`|Options for insert mode completion|
|`signcolumn`|`'yes'`|always show the sign column|
|`cursorline`|`true`|highlight the text line of the cursor|
|`cursorcolumn`|`true`|highlight the text column of the cursor|
|`scrolloff`|`5`|Lines of context|
|`sidescrolloff`|`8`|Colunms of context|
|`wrap`|`false`|Disable Line wrap|
|`tabstop`|`2`|Number of space tabs count for|
|`softtabstop`|`2`|keep the default tab stop size|
|`shiftwidth`|`2`|number of space inserted for indentation|
|`shiftround`|`true`|Round indent|
|`expandtab`|`true`|Use spaces instead of tabs|
|`autoindent`|`true`|Enable autoindent|
|`breakindent`|`true`|wrap indent to match  line start|
|`smartindent`|`true`|Insert indents automatically|
|`ignorecase`|`true`|Ignore case|
|`smartcase`|`true`|case sensitive searching|
|`incsearch`|`true`|enable incremental search|
|`whichwrap`|`"b,s,<,>,[,],h,l"`|Move the beginning and end of a line across lines|
|`autoread`|`true`|Automatically read modified files|
|`mouse`|`"a"`|enable mouse support|
|`updatetime`|`100`|Save swap file and trigger CursorHold|
|`splitbelow`|`true`|Put new windows below current|
|`splitright`|`true`|Put new windows right of current|
|`termguicolors`|`true`|True color support|
|`list`|`true`|Show some hidden characters|
|`showmode`|`false`|disable showing modes in command line|
|`foldenable`|`true`|enable fold|
|`foldlevel`|`99`|set high foldlevel|
|`foldlevelstart`|`99`|start with all code unfolded|
|`foldcolumn`|`"1"`|show foldcolumn|
|`conceallevel`|`2`|Hide * markup for bold and italic, but not markers with substitutions|
|`confirm`|`true`|Confirm to save changes before exiting modified buffer|
|`colorcolumn`|`"100"`|Line number reminder|
|`copyindent`|`true`|copy the previous indentation on autoindenting|
|`expandtab`|`true`|enable the use of space in tab|
|`history`|`300`|Save historical quantity|
|`linebreak`|`true`|wrap lines at 'breakat'|
|`undofile`|`true`|Save undo history|
|`winminwidth`|`5`|Minimum window width|
|`fillchars`|`{foldopen='-',foldclose='>',}`|set fillchars|

## Keyboard Shortcuts
**Note**: Some settings here refer to this repository: [<u>repository</u>](https://github.com/theniceboy/nvim/)

leader key settings:
`vim.g.mapleader = ' '`

#### 1 Basic Editor Features

##### 1.1 The Most Basics
`k`: switchs to **`INSERT`** : mode (same as key `i` in vanilla vim)  
`Q`: quits current vim window (same as command `:q` in vanilla vim)  
`S`: saves the current file (same as command `:w` in vanilla vim )  

##### 1.2 Remapped Cursor Movement
|Shortcut|Action|Equivalent|
|--------|------|----------|
|`u`|Cursor up a terminal line|`k`|
|`e`|Cursor down a terminal line|`j`|
|`n`|Cursor left|`h`|
|`i`|Cursor right|`l`|
|`U`|Cursor up 5 terminal line|`5k`|
|`E`|Cursor down 5 terminal line|`5j`|
|`N`|Cursor to the start of the line|`0`|
|`I`|Cursor to the end of t line|**`$`|
|`h`|Move to the end of this word|`e`|
|`W`|Move cursor five words forward|`5w`|
|`B`|Move cursor five words back|`5b`|

##### 1.3 Remapped Insert Mode Keys
|Shortcut|Action|Equivalent|
|--------|------|----------|
|`<M-u>`|Cursor up a terminal line|`<up>`|
|`<M-e>`|Cursor down a terminal line|`<down>`|
|`<M-n>`|Cursor left|`<left>`|
|`<M-i>`|Cursor right|`<right>`|
|`<M-U>`|Cursor up 5 terminal line|**`:normal! 5k<>`|
|`<M-E>`|Cursor down 5 terminal line|**`:normal! 5j<>`|
|`<M-N>`|Cursor to the start of the line|**`:normal 0<>`|
|`<M-I>`|Cursor to the end of the line|**`:normal $<CR>ight>`|

##### 1.4 Command Mode Keymaps
|Shortcut|Action|
|--------|------|
|`<M-n>`|Cursor left|
|`<M-i>`|Cursor right|
|`<M-n>`|Cursor 5 spaces to the left|
|`<M-i>`|Cursor 5 spaces to the right|

##### 1.5 Remapped Text Manipulating Commands in Normal Mode
|Shortcut|Action|Equivalent|
|--------|------|----------|
|`l`|undo|`u`|
|`L`|redo|`u`|

##### 1.6 Other Useful Normal Mode Remappings
|Shortcut|Action|Equivalent|
|--------|------|----------|
|`;`|Enter Cmand mode|`:`|
|`<leader>r`|Run code|`:RunCode`|

##### 1.7 Register related settings
|Shortcut|Action|Equivalent|
|--------|------|----------|
|`<M-y>`|Copy to system clipboard|`"+y`|
|`<M-p>`|Paste to system clipboard|`"+gp`|
|`<M-v>`|Paste to system clipboard (mode = i)|`:normal"+gp<CR><right>`|

#### 2 Window Management
##### 2.1 Creating Window Through Split Screen
|Shortcut|Action|
|--------|------|
|`<leader>su`|Create a new horizontal split screen and place it above the current window|
|`<leader>se`|Create a new horizontal split screen and place it below the current window|
|`<leader>sn`|Create a new vertical split screen and place it left to the current window|
|`<leader>si`|Create a new vertical split screen and place it right to the current window|
|`<leader>sv`|Set the two splits to be vertical|
|`<leader>sh`|Set the two splits to be horizontal|
|`<leader>srv`|Rotate splits and arrange splits vertically|
|`<leader>srh`|Rotate splits and arrange splits horizontally|

##### 2.2 Moving the Cursor Between Different Windows
|Shortcut|Action|
|--------|------|
|`<leader>ww`|Move cursor to the next window|
|`<leader>wn`|Move cursor one window left|
|`<leader>wi`|Move cursor one window right|
|`<leader>wu`|Move cursor one window up|
|`<leader>we`|Move cursor one window down|
