require("luasnip.session.snippet_collection").clear_snippets("markdown")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")

ls.add_snippets("markdown", {
  -- Admonitions for GitHub Flavored Markdown are found here:
  -- https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
  s("admongh-note", fmt([[
> [!NOTE]
> {}]], {
    i(0),
  })),
  s("admongh-tip", fmt([[
> [!TIP]
> {}]], {
    i(0),
  })),
  s("admongh-important", fmt([[
> [!IMPORTANT]
> {}]], {
    i(0),
  })),
  s("admongh-warn", fmt([[
> [!WARNING]
> {}]], {
    i(0),
  })),
  s("admongh-caution", fmt([[
> [!CAUTION]
> {}]], {
    i(0),
  })),
  s("admon-note", fmt([[
> 📝 **Note**
>
> {}]], {
    i(0),
  })),
  s("admon-important", fmt([[
> ❗ **Important**
>
> {}]], {
    i(0),
  })),
  s("admon-info", fmt([[
> ℹ️ **Info**
>
> {}]], {
    i(0),
  })),
  s("admon-tip", fmt([[
> 💡 **Tip**
>
> {}]], {
    i(0),
  })),
  s("admon-question", fmt([[
> ❓ **Question**
>
> {}]], {
    i(0),
  })),
  s("admon-warn", fmt([[
> ⚠️ **Warning**
>
> {}]], {
    i(0),
  })),
  s("details", fmt([[
<details {1}>
<summary>{2}</summary>

{3}
</details>{}]], {
    i(1, "open"),
    i(2, "summary"),
    i(3, "body"),
    i(0),
  })),
  s("picture", fmt([[
<picture>
  <!-- User prefers light mode: -->
  <source srcset="{1}/{2}-light.png" media="(prefers-color-scheme: light)"/>

  <!-- User prefers dark mode: -->
  <source srcset="{1}/{2}-dark.png"  media="(prefers-color-scheme: dark)"/>

  <!-- User has no color preference: -->
  <img src="{1}/{2}-light.png"/>
</picture>{}]], {
    i(1, "./media/path/to"),
    i(2, "filename"),
    i(0),
  }, {
    repeat_duplicates = true,
  })),
  s("!badge",
    fmt(
      [[![{alt_text}](https://img.shields.io/badge/-{display_name}-{bg_color}?style=for-the-badge&logo={logo_icon}&logoColor={logo_color})
{}]], {
        alt_text = i(1, "Alternative text"),
        display_name = i(2, "Display name as URI-encoded string"),
        bg_color = i(3, "The background color for the text, either a hex without `#` or a string"),
        logo_icon = i(4, "Logo icon from Simple Icons (https://simpleicons.org)"),
        logo_color = i(5, "white"),
        i(0),
      }, {
        repeat_duplicates = true,
      }))
})
