local ls = require("luasnip")
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local s = ls.snippet

return {
  s({ trig = "fn", dscr = "Function" }, {
    t("fn "),
    i(1, "name"),
    t("("),
    i(2),
    t(") "),
    i(3),
    t({ " {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),

  s({ trig = "fnp", dscr = "pub function" }, {
    t("pub fn "),
    i(1, "name"),
    t("("),
    i(2),
    t(") "),
    i(3),
    t({ " {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),

  s({ trig = "st", dscr = "struct definition" }, {
    t("struct "),
    i(1, "Name"),
    t({ " {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "stp", dscr = "pub struct definition" }, {
    t("pub struct "),
    i(1, "Name"),
    t({ " {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "en", dscr = "enum definition" }, {
    t("enum "),
    i(1, "Name"),
    t({ " {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "impl", dscr = "impl block" }, {
    t("impl "),
    i(1, "Type"),
    t({ " {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "implt", dscr = "impl Trait for Type" }, {
    t("impl "),
    i(1, "Trait"),
    t(" for "),
    i(2, "Type"),
    t({ " {", "\t" }),
    i(3),
    t({ "", "}" }),
  }),

  s({ trig = "trt", dscr = "trait definition" }, {
    t("trait "),
    i(1, "Name"),
    t({ " {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "match", dscr = "match expression" }, {
    t("match "),
    i(1, "expr"),
    t({ " {", "\t" }),
    i(2, "pattern"),
    t(" => "),
    i(3),
    t({ ",", "}" }),
  }),

  s({ trig = "der", dscr = "#[derive(...)]" }, {
    t("#[derive("),
    i(1, "Debug"),
    t(")]"),
  }),

  s({ trig = "test", dscr = "#[test] fn" }, {
    t({ "#[test]", "fn " }),
    i(1, "test_name"),
    t({ "() {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "tmod", dscr = "tests module" }, {
    t({ "#[cfg(test)]", "mod tests {", "\tuse super::*;", "", "\t#[test]", "\tfn " }),
    i(1, "test_name"),
    t({ "() {", "\t\t" }),
    i(2),
    t({ "", "\t}", "}" }),
  }),

  s({ trig = "pl", dscr = "println!" }, {
    t('println!("'),
    i(1),
    t('"'),
    c(2, {
      t(")"),
      { t(", "), i(1), t(")") },
    }),
    t(";"),
  }),

  s({ trig = "res", dscr = "Result return type" }, {
    t("Result<"),
    i(1, "T"),
    t(", "),
    i(2, "E"),
    t(">"),
  }),

  s({ trig = "ok", dscr = "Ok(...)" }, {
    t("Ok("),
    i(1),
    t(")"),
  }),

  s({ trig = "some", dscr = "Some(...)" }, {
    t("Some("),
    i(1),
    t(")"),
  }),
}
