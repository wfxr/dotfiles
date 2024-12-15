---@diagnostic disable: missing-fields

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        on_highlights = function(hl, palette)
          -- stylua: ignore start
          -- Git Signs
          hl.GitSignsAdd    = { fg = "#50FA7B" }
          hl.GitSignsDelete = { fg = "#FF5555" }
          hl.GitSignsChange = { fg = "#FFB86C" }

          -- Float
          hl.FloatBorder = { bg   = palette.none }
          hl.FloatTitle  = { bg   = palette.none, bold = true      }
          -- hl.NormalFloat = { link = "Normal"     }

          -- NeoTree
          hl.NeoTreeNormal        = { link = "Normal"      }
          hl.NeoTreeFloatBorder   = { link = "FloatBorder" }
          hl.NeoTreeFloatTitle    = { link = "FloatTitle"  }
          hl.NeoTreeFloatTitleBar = { link = "FloatBorder" }
          hl.NeoTreeFloatNormal   = { link = "NormalFloat" }
          hl.NeoTreeTitleBar      = { link = "FloatTitle"  }
          hl.NeoTreeEndOfBuffer   = { link = "EndOfBuffer" }

          hl.AlphaHeader   = { bg = palette.bg, fg = palette.aqua }
          hl.AlphaShortcut = { bg = palette.bg, fg = palette.orange, bold = true }
          hl.AlphaButtons  = { bg = palette.bg, fg = palette.blue }
          hl.AlphaFooter   = { bg = palette.bg, fg = palette.aqua }

          hl.CurSearch  = { link = "IncSearch" }
          hl.FlashMatch = { link = "Search"    }
          hl.FlashLabel = { bg = "#db4b4b", fg = "#eeeeee", bold = true }

          hl.NeoTreeGitUntracked = { fg = palette.yellow }
        end,
      })
    end,
  },
}
