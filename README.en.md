# `neovim.nix` — A custom _Neovim_ configuration using _Nix Cats_ for @rogeruiz

> ℹ️ **Info**
>
> ¿No lees inglés? [Mire este documento][es].

> 📝 **Note**
>
> Everything below this was inspired from the original `nix init` command for
> leveraging the `example` configuration from `nixCats`.

This repository is my _Nix_-derivation based configuration for _Neovim_ with a
base plugin pack. You can use this project to start using _Neovim_ with _Nix_.

Since this project uses _Nix Cats_, the _Neovim_ configuration uses a plugin
called `BirdeeHub/lze` to lazy load other plugins. The tools `paq` and `mason`
are also part of the configuration so you can use this without `nix` installed.

The name `nixCats` is a reference to the `nixpkgs`-based package manager and
it also refers to a _Lua_ plugin that's used as a bridge between _Nix_ and _Lua_
to allow for categorization of _Neovim_ configurations.

## Directory structure

This configuration uses the structure from below:

- The `./lua` directory for the core configuration.
- The `./after/plugin` directory to demonstrate compatibility.

Also you can use any _Neovim_ directories that are loaded on launch:

- `./ftplugin` contains the configurations for specific files.
- `./plugin` contains the configurations for global plugins.
- Including `./pack/*/{start,opt}` support to create and maintain plugins inside
  of your configuration.
- And more can be found in the _Neovim_ runtime path documentation. [Refer to
  the documentation][doc].

[doc]: https://neovim.io/doc/user/options.html#'rtp'
[es]: https://git.sr.ht/~rogeruiz/neovim.nix/tree/main/README.md
