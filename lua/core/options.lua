vim.g.encoding = "UTF-8"

local options = {
  fileencoding = "UTF-8",                          -- file content encoding for the buffer
  autowrite = true,                                -- Enable auto write
  number = true,                                   -- show numberline
  relativenumber = true,                           -- show relative numberline
  completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion
  signcolumn = "yes",                              -- always show the sign column
  cursorline = true,                               -- highlight the text line of the cursor
  cursorcolumn = true,                             -- highlight the text column of the cursor
  scrolloff = 8,                                   -- Lines of context
  sidescrolloff = 8,                               -- Columns of context
  wrap = false,                                    -- Disable line wrap
  tabstop = 2,                                     -- Number of spaces tabs count for
  softtabstop = 2,
  shiftwidth = 2,                                  -- number of space inserted for indentation
  shiftround = true,                               -- Round indent
  expandtab = true,                                -- Use spaces instead of tabs
  autoindent = true,                               -- Enable autoindent
  breakindent = true,                              -- wrap indent to match  line start
  smartindent = true,                              -- Insert indents automatically
  ignorecase = true,                               -- Ignore case
  smartcase = true,                                -- case sensitive searching
  incsearch = true,                                -- enable incremental search
  whichwrap = "b,s,<,>,[,],h,l",                   -- Move the beginning and end of a line across lines
  autoread = true,
  mouse = "a",                                     -- enable mouse support
  updatetime = 100,                                -- Save swap file and trigger CursorHold
  splitbelow = true,                               -- Put new windows below current
  splitright = true,                               -- Put new windows right of current
  termguicolors = true,                            -- True color support
  list = true,
  showmode = false,                                -- disable showing modes in command line
  foldenable = true,                               -- enable fold
  foldlevel = 99,                                  -- set high foldlevel
  foldlevelstart = 99,                             -- start with all code unfolded
  foldcolumn = "1",                                -- show foldcolumn
  conceallevel = 2,                                -- Hide * markup for bold and italic, but not markers with substitutions
  confirm = true,                                  -- Confirm to save changes before exiting modified buffer
  colorcolumn = "100",                             -- Line number reminder
  copyindent = true,                               -- copy the previous indentation on autoindenting
  history = 300,
  linebreak = true,                                -- wrap lines at 'breakat'
  undofile = true,
  winminwidth = 5,                                 -- Minimum window width
  smoothscroll = true,
  pumblend = 25,                                   -- Set popup menu transparency
  fillchars = { foldopen = "-", foldclose = ">" },
  laststatus = 0,
  spell = true,
  spelllang = { 'en_us' },
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- If using TTY, set the following to false
vim.g.notty = true
