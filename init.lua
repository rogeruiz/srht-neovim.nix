require('nixCatsUtils').setup {
  non_nix_value = true,
}
--[[
Nix puts the plugins
into the directories paq-nvim expects them to be in,
because both follow the normal neovim scheme.
So you just put the URLs and build steps in there, and use its opt option to do the same
thing as putting a plugin in nixCat's optionalPlugins field.
then load the plugins via paq-nvim
YOU are in charge of putting the plugin
urls and build steps in there, which will only be used when not on nix,
and you should keep any setup functions
OUT of that file, as they are ONLY loaded when this
configuration is NOT loaded via nix.
--]]
require("rstrz.non_nix_download")
-- OK, again, that isnt needed if you load this setup via nix, but it is an option.

--[[
outside of when you want to use the nixCats global command
to decide if something should be loaded, or to pass info from nix to lua,
thats pretty much everything specific to nixCats that
needs to be in your config.
If you always want to load it via nix,
you pretty much dont need this file at all, and you also won't need
anything within lua/nixCatsUtils, nor will that be in the default template.
that directory is addable via the luaUtils template.
it is not required, but has some useful utility functions.
--]]

--[[
ok thats enough for 1 file. Off to lua/rstrz/init.lua
all the config starts there in this example config.
This config is loadable with and without nix due to the above,
and the lua/rstrz/non_nix_download.lua file.
the rest is just example of how to configure nvim making use of various
features of nixCats and using the plugin lze for lazy loading.
--]]
require('rstrz')
