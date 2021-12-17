local opt = vim.opt

opt.hidden = true                   -- Required to keep multiple buffers open multiple buffers
opt.wrap = false                    -- Display long lines as just one line
opt.number = true                   -- Line numbers are displayed on the left side
opt.relativenumber = true           -- Line numbers are relative to current
opt.tabstop = 4                     -- Insert 4 spaces for a tab
opt.shiftwidth = 4                  -- Change the number of space characters inserted for indentation
opt.expandtab = true                -- Converts tab to spaces
opt.smartindent = true              -- Makes indenting smart
opt.smarttab = true                 -- Makes tabbing smarter will realize you have 2 vs 4
opt.autoindent = true               -- Good auto indent
