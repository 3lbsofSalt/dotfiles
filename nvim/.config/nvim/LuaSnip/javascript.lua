local ls = require("luasnip")
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local s = ls.snippet

return {
  -- Generic
  s({ trig = "cl", dscr = "console.log" }, {
    t("console.log("),
    i(1),
    t(");"),
  }),

  s({ trig = "afn", dscr = "Arrow function" }, {
    t("const "),
    i(1, "name"),
    t(" = ("),
    i(2),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "};" }),
  }),

  s({ trig = "try", dscr = "try/catch block" }, {
    t({ "try {", "\t" }),
    i(1),
    t({ "", "} catch ("},),
    i(2, "err"),
    t({ ") {", "\t" }),
    i(3),
    t({ "", "}" }),
  }),

  s({ trig = "imp", dscr = "ES module import" }, {
    t("import { "),
    i(1),
    t(" } from '"),
    i(2),
    t("';"),
  }),

  s({ trig = "impa", dscr = "ES module import default" }, {
    t("import "),
    i(1),
    t(" from '"),
    i(2),
    t("';"),
  }),

  s({ trig = "prm", dscr = "new Promise" }, {
    t({ "new Promise((resolve, reject) => {", "\t" }),
    i(1),
    t({ "", "});" }),
  }),

  -- React
  s({ trig = "fc", dscr = "React functional component", priority = 1100 }, {
    t({ "import React, { useEffect, useState } from 'react';", "", "export default function " }),
    i(1, "componentName"),
    t({ "() {", "\treturn (" }),
    i(2, "body"),
    t({ ");", "}" }),
  }),

  -- Express / Node
  s({ trig = "router", dscr = "Express router endpoint", priority = 1100 }, {
    t("router."),
    i(1, "get"),
    t("('/"),
    i(2, "route"),
    t({ "', async (req, res) => {" }),
    i(3),
    t({ "", "\treturn res.sendStatus(200);", "});" }),
  }),

  s({ trig = "winston", dscr = "Winston error log", priority = 1100 }, {
    t({ "winston.error({", "\tlocation: '" }),
    i(1, "location"),
    t({ "',", "\tmessage: '" }),
    i(2, "message"),
    t({ "',", "\terror" }),
    c(3, {
      t({ ",", "" }),
      i(nil, "errorObject"),
    }),
    t({ "\tdata: {", "\t\t" }),
    i(4),
    t({ "", "\t}", "});" }),
  }),
}
