local ls = require("luasnip")
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet

return {
  s({ trig = "fn", dscr = "Function" }, {
    t("func "),
    i(1, "name"),
    t("("),
    i(2),
    t(") "),
    i(3),
    t({ " {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),

  s({ trig = "fne", dscr = "Function returning error" }, {
    t("func "),
    i(1, "name"),
    t("("),
    i(2),
    t({ ") error {", "\t" }),
    i(3),
    t({ "", "\treturn nil", "}" }),
  }),

  -- The bread and butter of Go error handling
  s({ trig = "err", dscr = "if err != nil { return err }" }, {
    t({ "if err != nil {", "\treturn err", "}" }),
  }),

  s({ trig = "errf", dscr = "if err != nil { return fmt.Errorf(...) }" }, {
    t({ "if err != nil {", '\treturn fmt.Errorf("' }),
    i(1, "context"),
    t(': %w", err)'),
    t({ "", "}" }),
  }),

  s({ trig = "main", dscr = "main function" }, {
    t({ "func main() {", "\t" }),
    i(1),
    t({ "", "}" }),
  }),

  s({ trig = "st", dscr = "struct definition" }, {
    t("type "),
    i(1, "Name"),
    t({ " struct {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "iface", dscr = "interface definition" }, {
    t("type "),
    i(1, "Name"),
    t({ " interface {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "meth", dscr = "Method on a type" }, {
    t("func ("),
    i(1, "r"),
    t(" *"),
    i(2, "Receiver"),
    t(") "),
    i(3, "name"),
    t("("),
    i(4),
    t(") "),
    i(5),
    t({ " {", "\t" }),
    i(6),
    t({ "", "}" }),
  }),

  s({ trig = "forr", dscr = "for range loop" }, {
    t("for "),
    i(1, "i"),
    t(", "),
    i(2, "v"),
    t(" := range "),
    i(3, "slice"),
    t({ " {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),

  s({ trig = "test", dscr = "Test function" }, {
    t("func Test"),
    i(1, "Name"),
    t({ "(t *testing.T) {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s({ trig = "tcase", dscr = "Table-driven test case struct" }, {
    t({ "tests := []struct {", "\t" }),
    i(1, "name string"),
    t({ "", "}{", "\t{" }),
    i(2),
    t({ "}", "}", "", "for _, tt := range tests {", '\tt.Run(tt.name, func(t *testing.T) {', "\t\t" }),
    i(3),
    t({ "", "\t})", "}" }),
  }),

  s({ trig = "gor", dscr = "goroutine" }, {
    t({ "go func() {", "\t" }),
    i(1),
    t({ "", "}()" }),
  }),
}
