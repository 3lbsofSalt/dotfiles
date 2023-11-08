local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  ls.snippet(
    {
      trig="fc",
      dscr="Typescript React functional component snippet",
      priority="1100"
    },
    {
      t({
        "import React, { useEffect, useState } from 'react';", 
        "", 
        "export default function "
      }),
      i(1, "componentName"),
      t({
        "() {", 
        "\treturn ("
      }),
      i(2, "body"),
      t({
        ");",
        "}"
      })
    }
  )
}
