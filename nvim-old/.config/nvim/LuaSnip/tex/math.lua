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
    }),
  ls.snippet({
    trig="x1tn",
    dscr="Expand into x sub 1 to x sub n"
  }, {
      t("x_1 \\cdots x_n")
    }),
  ls.snippet({
    trig="y1tn",
    dscr="Expand into y sub 1 to y sub n"
  }, {
      t("y_1 \\cdots y_n")
    })
}
