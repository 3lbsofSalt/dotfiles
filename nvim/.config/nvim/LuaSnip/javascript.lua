local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  ls.snippet(
    {
      trig="fc",
      dscr="React functional component snippet"
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    },
    {
      t({"import React, { useEffect, useState } from 'react';", "export default function "}),
      i(1, "componentName"),
      t({"() {", "return ("}),
      i(2, "body"),
      t({")","}"})
    }
  )
}
