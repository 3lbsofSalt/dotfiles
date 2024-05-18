local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  -- alpha char
  ls.snippet({trig=";a", snippetType="autosnippet"},
    {
      t("\\alpha")
    }
  ),
  -- beta char
  ls.snippet({trig=";b", snippetType="autosnippet"},
    {
      t("\\beta")
    }
  ),
  -- gamma char
  ls.snippet({trig=";g", snippetType="autosnippet"},
    {
      t("\\gamma")
    }
  )
}
