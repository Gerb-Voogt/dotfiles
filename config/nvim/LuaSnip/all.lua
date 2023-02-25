return {
    s({trig = '[', snippetType="autosnippet"},
        fmt(
            "[<>]<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { trig = "hi" },
    { t("Hello, world!") }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  require("luasnip").snippet(
    { trig = "foo" },
    { t("Another snippet.") }
  ),
}
