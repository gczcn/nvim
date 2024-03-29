local opt = vim.opt

vim.g.encoding = "UTF-8"

opt.fileencoding = "UTF-8"                          -- file content encoding for the buffer
opt.autowrite = true                                -- Enable auto write
opt.number = true                                   -- show numberline
opt.relativenumber = true                           -- show relative numberline
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.signcolumn = "yes"                              -- always show the sign column
opt.cursorline = true                               -- highlight the text line of the cursor
opt.cursorcolumn = true                             -- highlight the text column of the cursor
opt.scrolloff = 8                                   -- Lines of context
opt.sidescrolloff = 8                               -- Columns of context
opt.wrap = false                                    -- Disable line wrap
opt.tabstop = 2                                     -- Number of spaces tabs count for
opt.softtabstop = 2
opt.shiftwidth = 2                                  -- number of space inserted for indentation
opt.shiftround = true                               -- Round indent
opt.expandtab = true                                -- Use spaces instead of tabs
opt.autoindent = true                               -- Enable autoindent
opt.breakindent = true                              -- wrap indent to match  line start
opt.smartindent = true                              -- Insert indents automatically
opt.ignorecase = true                               -- Ignore case
opt.smartcase = true                                -- case sensitive searching
opt.incsearch = true
opt.whichwrap = "b,s,<,>,[,],h,l"                   -- Move the beginning and end of a line across lines
opt.autoread = true
opt.mouse = "a"                                     -- enable mouse support
opt.updatetime = 100                                -- Save swap file and trigger CursorHold
opt.splitbelow = true                               -- Put new windows below current
opt.splitright = true                               -- Put new windows right of current
opt.termguicolors = true                            -- True color support
opt.list = true
opt.showmode = false                                -- disable showing modes in command line
opt.foldenable = true                               -- enable fold
opt.foldlevel = 99                                  -- set high foldlevel
opt.foldlevelstart = 99                             -- start with all code unfolded
opt.foldcolumn = "1"                                -- show foldcolumn
opt.conceallevel = 2                                -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true                                  -- Confirm to save changes before exiting modified buffer
opt.colorcolumn = "100"                             -- Line number reminder
opt.copyindent = true                               -- copy the previous indentation on autoindenting
opt.history = 300
opt.linebreak = true                                -- wrap lines at 'breakat'
opt.undofile = true
opt.winminwidth = 5                                 -- Minimum window width
opt.smoothscroll = true
opt.pumblend = 25                                   -- Set popup menu transparency
opt.fillchars = { foldopen = "-", foldclose = ">" }
