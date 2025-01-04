local M = {}

function M.setup()
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  npairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
    enable_check_bracket_line = true,
    ignored_next_char = [=[[%w%%%'%[%"%.]]=],
    enable_moveright = true,
    enable_afterquote = true,
    map_c_h = false,
    map_c_w = false,
    disable_in_macro = false,
    disable_in_visualblock = false,
  })

  -- Add spaces between parentheses
  npairs.add_rules({
    Rule(" ", " ")
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
      end),
    Rule("", " )")
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == ")" end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key(")"),
    Rule("", " ]")
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == "]" end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key("]"),
    Rule("", " }")
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == "}" end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key("}"),
  })

  -- Integration with nvim-cmp
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if cmp_status_ok then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end

  -- Add support for markdown files
  npairs.add_rule(Rule("$", "$", { "tex", "latex", "markdown" }))
  npairs.add_rule(Rule("```", "```", "markdown"):with_cr(true))
end

return M 