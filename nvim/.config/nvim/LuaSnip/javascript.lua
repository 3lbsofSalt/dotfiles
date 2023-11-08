local ls = require("luasnip")
i = ls.insert_node
t = ls.text_node

return {
  ls.snippet(
    {
      trig="fc",
      dscr="React functional component snippet",
      priority="1100"
    },
    {
      t({"import React, { useEffect, useState } from 'react';", "", "export default function "}),
      i(1, "componentName"),
      t({"() {", "\treturn ("}),
      i(2, "body"),
      t({");","}"})
    }
  ),


  ls.snippet(
    {
      trig="router",
      dsrc="Express router endpoint",
      priority="1100"
    },
    {
      t("router."),
      i(1, "http-method"),
      t("('/"),
      i(2, "routename"),
      t({"', async (req, res) => {"}),
      i(3, "body"),
      t({"", "\treturn res.sendStatus(200);", "});"})
    }
  )
}
