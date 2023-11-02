local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  ls.snippet(
    {
      trig="ternary",
      dscr="c style ternary statement"
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    },
    {
      i(1, "cond"),
      t(" ? "),
      i(2, "then"),
      t(" : "),
      i(3, "else")
    }
  )
}
