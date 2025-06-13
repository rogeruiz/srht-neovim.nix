require("luasnip.session.snippet_collection").clear_snippets("all")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")

ls.add_snippets("all", {
  s("agpl3", fmt([[{comment} {project}
{comment} Copyright (C) {year}  {author}
{comment}
{comment} This program is free software: you can redistribute it and/or modify
{comment} it under the terms of the GNU Affero General Public License as
{comment} published by the Free Software Foundation, either version 3 of the
{comment} License, or (at your option) any later version.
{comment}
{comment} This program is distributed in the hope that it will be useful,
{comment} but WITHOUT ANY WARRANTY; without even the implied warranty of
{comment} MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
{comment} GNU Affero General Public License for more details.
{comment}
{comment} You should have received a copy of the GNU Affero General Public License
{comment} along with this program.  If not, see <https://www.gnu.org/licenses/>.
{}]], {
    comment = i(1, "#"),
    project = i(2, "<PROJECT>"),
    year = i(3, "<YEAR>"),
    author = i(4, "<AUTHOR>"),
    i(0),
  }, {
    repeat_duplicates = true,
  })),
  s("gpl3", fmt([[{comment} {project}
{comment} Copyright (C) {year} {author}
{comment}
{comment} This program is free software: you can redistribute it and/or modify it
{comment} under the terms of the GNU General Public License as published by the Free
{comment} Software Foundation, either version 3 of the License, or (at your option)
{comment} any later version.
{comment}
{comment} This program is distributed in the hope that it will be useful, but WITHOUT
{comment} ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
{comment} FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
{comment} more details.
{comment}
{comment} You should have received a copy of the GNU General Public License along with
{comment} this program. If not, see <https://www.gnu.org/licenses/>.
{}]], {
    comment = i(1, "#"),
    project = i(2, "<PROJECT>"),
    year = i(3, "<YEAR>"),
    author = i(4, "<AUTHOR>"),
    i(0),
  }, {
    repeat_duplicates = true,
  })),
  s("CC0", fmt([[{comment} {project}
{comment} Public Domain (CC0) {year} {author}
{comment}
{comment} This program is free software: you can redistribute it and/or modify it
{comment} freely. It is in the public domain within the United States.
{comment}
{comment} The person who associated a work with this deed has dedicated the work to the
{comment} public domain by waiving all of his or her rights to the work worldwide under
{comment} copyright law, including all related and neighboring rights, to the extent
{comment} allowed by law.
{comment}
{comment} You can copy, modify, distribute and perform the work, even for commercial
{comment} purposes, all without asking permission.
{comment}
{comment} In no way are the patent or trademark rights of any person affected by CC0, nor
{comment} are the rights that other persons may have in the work or in how the work is
{comment} used, such as publicity or privacy rights.
{comment}
{comment} Unless expressly stated otherwise, the person who associated a work with this
{comment} deed makes no warranties about the work, and disclaims liability for all uses of
{comment} the work, to the fullest extent permitted by applicable law. When using or
{comment} citing the work, you should not imply endorsement by the author or the affirmer.
{comment}
{comment} You should have received a copy of the CC0 1.0 Universal License along with
{comment} this program. If not, see <https://creativecommons.org/publicdomain/zero/1.0/>.
{}]], {
    comment = i(1, "#"),
    project = i(2, "<PROJECT>"),
    year = i(3, "<YEAR>"),
    author = i(4, "<AUTHOR>"),
    i(0),
  }, {
    repeat_duplicates = true,
  })),
  s(":lgtm:", fmt([[🌈 lgtm
{}]], {
    i(0),
  }, {
    repeat_duplicates = true,
  })),
})
