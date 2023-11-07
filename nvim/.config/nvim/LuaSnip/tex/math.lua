local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  ls.snippet({
    trig="ff",
    dscr="Expand ff into frac{}{}"
  }, {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}")
  })
}
