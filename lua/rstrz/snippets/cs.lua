require("luasnip.session.snippet_collection").clear_snippets("cs")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cs", {
  s("<returns",
    fmt([[/// <returns>
/// {comment}
/// </returns>{}]], {
      comment = i(1, "What does the method below return?"),
      i(0),
    }, {
      repeat_duplicates = true,
    }
    )
  ),
  s("<summary",
    fmt([[/// <summary>
/// {comment}
/// </summary>{}]], {
      comment = i(1, "Summarize the code below."),
      i(0),
    }, {
      repeat_duplicates = true,
    }
    )
  ),
  s("<param",
    fmt([[/// <param name="{name}">{desc}</param>{}]], {
      name = i(1, "Parameter name"),
      desc = i(2, "Parameter description"),
      i(0),
    }, {
      repeat_duplicates = true,
    }
    )
  ),
})
