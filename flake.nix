{
  description = "Neovim flake usando Nix y categorias (nixCats)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # No longer fetched to avoid forcing people to import it, but this remains here as a tutorial.
    # How to import it into your config is shown farther down in the startupPlugins set.
    # You put it here like this, and then below you would use it with `pkgs.neovimPlugins.hlargs`

    # "plugins-hlargs" = {
    #   url = "github:m-demare/hlargs.nvim";
    #   flake = false;
    # };

    "plugins-nvim-dap-powershell" = {
      url = "github:Willem-J-an/nvim-dap-powershell";
      flake = false;
    };

    "plugins-powershell-nvim" = {
      url = "github:TheLeoP/powershell.nvim";
      flake = false;
    };

    "plugins-indent-rainbowline" = {
        url = "github:TheGLander/indent-rainbowline.nvim";
        flake = false;
      };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.nixCats) utils;
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        allowUnfree = true;
      };
      # see :help nixCats.flake.outputs.overlays
      dependencyOverlays = /* (import ./overlays inputs) ++ */ [
        # This overlay grabs all the inputs named in the format
        # `plugins-<pluginName>`
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a set of our plugins.
        (utils.standardPluginOverlay inputs)
        # add any other flake overlays here.

        # when other people mess up their overlays by wrapping them with system,
        # you may instead call this function on their overlay.
        # it will check if it has the system in the set, and if so return the desired overlay
        # (utils.fixSystemizedOverlay inputs.codeium.overlays
        #   (system: inputs.codeium.overlays.${system}.default)
        # )
      ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions = { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
        # to define and use a new category, simply add a new list to a set here,
        # and later, you will include categoryname = true; in the set you
        # provide when you build the package using this builder function.
        # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

        # lspsAndRuntimeDeps:
        # this section is for dependencies that should be available
        # at RUN TIME for plugins. Will be available to PATH within neovim terminal
        # this includes LSPs
        lspsAndRuntimeDeps = {
          # some categories of stuff.
          general = with pkgs; [
            universal-ctags
            ripgrep
            fd
            tree-sitter
            nodePackages.typescript
            nodePackages.typescript-language-server
            yaml-language-server
            marksman

            # dwt1-shell-color-scripts
            # pokemon-colorscripts-mac
            bottom
            gh

            ninja
            cmake
            gettext
            curl
          ];
          # these names are arbitrary.
          lint = with pkgs; [
            shellcheck
          ];
          # but you can choose which ones you want
          # per nvim package you export
          debug = with pkgs; {
            go = [ delve ];
            pwsh = [ delve ];
          };
          pwsh = with pkgs; [
            powershell-editor-services
          ];
          go = with pkgs; [
            go
            gopls
            gotools
            go-tools
            gofumpt
            # gccgo
          ];
          rust = with pkgs; [
            openssl
            pkg-config
            cargo-deny
            cargo-edit
            cargo-watch
            rust-analyzer

          ];
          # and easily check if they are included in lua
          format = with pkgs; [
            shfmt
          ];
          neonixdev = {
            # also you can do this.
            inherit (pkgs) nix-doc lua-language-server nixd;
            # and each will be its own sub category
          };
        };

        # This is for plugins that will load at startup without using packadd:
        startupPlugins = {
          debug = with pkgs.vimPlugins; [
            nvim-nio
          ];
          general = with pkgs.vimPlugins; {
            # you can make subcategories!!!
            # (always isnt a special name, just the one I chose for this subcategory)
            always = [
              lze
              lzextras
              vim-repeat
              plenary-nvim
              nvim-notify
            ];
            extra = [
              alpha-nvim
              oil-nvim
              nvim-web-devicons
              telekasten-nvim
              zen-mode-nvim
            ];
          };
          # You can retreive information from the
          # packageDefinitions of the package this was packaged with.
          # :help nixCats.flake.outputs.categoryDefinitions.scheme
          themer = with pkgs.vimPlugins;
            (builtins.getAttr (categories.colorscheme or "catppuccin") {
              # Theme switcher without creating a new category
              "tokyonight" = tokyonight-nvim;
              "catppuccin" = catppuccin-nvim;
            }
            );
          # This is obviously a fairly basic usecase for this, but still nice.
        };

        # not loaded automatically at startup.
        # use with packadd and an autocommand in config to achieve lazy loading
        # or a tool for organizing this like lze or lz.n!
        # to get the name packadd expects, use the
        # `:NixCats pawsible` command to see them all
        optionalPlugins = {
          debug = with pkgs.vimPlugins; {
            # it is possible to add default values.
            # there is nothing special about the word "default"
            # but we have turned this subcategory into a default value
            # via the extraCats section at the bottom of categoryDefinitions.
            default = [
              nvim-dap
              nvim-dap-ui
              nvim-dap-virtual-text
            ];
            go = [ nvim-dap-go ];
            pwsh = [ pkgs.neovimPlugins.nvim-dap-powershell ];
            rust = [ pkgs.lldb ];
          };
          lint = with pkgs.vimPlugins; [
            nvim-lint
          ];
          format = with pkgs.vimPlugins; [
            conform-nvim
          ];
          markdown = with pkgs.vimPlugins; [
            markdown-preview-nvim
          ];
          neonixdev = with pkgs.vimPlugins; [
            lazydev-nvim
            hmts-nvim
          ];
          pwsh = with pkgs; [
            neovimPlugins.powershell-nvim
          ];
          general = {
            blink = with pkgs.vimPlugins; [
              luasnip
              cmp-cmdline
              blink-cmp
              blink-compat
              colorful-menu-nvim
            ];
            treesitter = with pkgs.vimPlugins; [
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              # This is for if you only want some of the grammars
              # (nvim-treesitter.withPlugins (
              #   plugins: with plugins; [
              #     nix
              #     lua
              #   ]
              # ))
            ];
            telescope = with pkgs.vimPlugins; [
              telescope-fzf-native-nvim
              telescope-ui-select-nvim
              telescope-nvim
            ];
            always = with pkgs.vimPlugins; [
              nvim-lspconfig
              lualine-nvim
              nvim-navic
              gitsigns-nvim
              vim-sleuth
              vim-fugitive
              vim-rhubarb
              nvim-surround
              focus-nvim
              editorconfig-nvim
              vim-illuminate
              toggleterm-nvim
              snacks-nvim
            ];
            extra = with pkgs.vimPlugins; [
              fidget-nvim
              # lualine-lsp-progress
              which-key-nvim
              comment-nvim
              undotree
              indent-blankline-nvim
              pkgs.neovimPlugins.indent-rainbowline
              vim-startuptime
              # If it was included in your flake inputs as plugins-hlargs,
              # this would be how to add that plugin in your config.
              # pkgs.neovimPlugins.hlargs
            ];
          };
        };

        # shared libraries to be added to LD_LIBRARY_PATH
        # variable available to nvim runtime
        sharedLibraries = {
          general = with pkgs; [
            # <- this would be included if any of the subcategories of general are
            # libgit2
          ];
        };

        # environmentVariables:
        # this section is for environmentVariables that should be available
        # at RUN TIME for plugins. Will be available to path within neovim terminal
        environmentVariables = {
          test = {
            default = {
              CATTESTVARDEFAULT = "It worked!";
            };
            subtest1 = {
              CATTESTVAR = "It worked!";
            };
            subtest2 = {
              CATTESTVAR3 = "It didn't work!";
            };
          };
          pwsh = {
            POWERSHELL_EDITOR_SERVICES_BUNDLE_PATH = "${pkgs.powershell-editor-services}";
          };
        };

        # If you know what these are, you can provide custom ones by category here.
        # If you dont, check this link out:
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
        extraWrapperArgs = {
          test = [
            '' --set CATTESTVAR2 "It worked again!"''
          ];
        };

        # lists of the functions you would have passed to
        # python.withPackages or lua.withPackages
        # do not forget to set `hosts.python3.enable` in package settings

        # get the path to this python environment
        # in your lua config via
        # vim.g.python3_host_prog
        # or run from nvim terminal via :!<packagename>-python3
        python3.libraries = {
          test = (_: [ ]);
        };
        # populates $LUA_PATH and $LUA_CPATH
        extraLuaPackages = {
          general = [ (_: [ ]) ];
        };

        # see :help nixCats.flake.outputs.categoryDefinitions.default_values
        # this will enable test.default and debug.default
        # if any subcategory of test or debug is enabled
        # WARNING: use of categories argument in this set will cause infinite recursion
        # The categories argument of this function is the FINAL value.
        # You may use it in any of the other sets.
        extraCats = {
          test = [
            [ "test" "default" ]
          ];
          debug = [
            [ "debug" "default" ]
          ];
          pwsh = [
            [ "debug" "pwsh" ] # yes it has to be a list of lists
          ];
          go = [
            [ "debug" "go" ] # yes it has to be a list of lists
          ];
        };
      };




      # packageDefinitions:

      # Now build a package with specific categories from above
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.
      # It is directly translated to a Lua table, and a get function is defined.
      # The get function is to prevent errors when querying subcategories.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # the name here is the name of the package
        # and also the default command name for it.
        neovim = { pkgs, name, ... }@misc: {
          # these also recieve our pkgs variable
          # see :help nixCats.flake.outputs.packageDefinitions
          settings = {
            suffix-path = true;
            suffix-LD = true;
            # The name of the package, and the default launch name,
            # and the name of the .desktop file, is `nixCats`,
            # or, whatever you named the package definition in the packageDefinitions set.
            # WARNING: MAKE SURE THESE DONT CONFLICT WITH OTHER INSTALLED PACKAGES ON YOUR PATH
            # That would result in a failed build, as nixos and home manager modules validate for collisions on your path
            aliases = [ "nix-neovim" "nnvim" ];

            # explained below in the `regularCats` package's definition
            # OR see :help nixCats.flake.outputs.settings for all of the settings available
            wrapRc = true;
            configDirName = "nix-neovim";
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            hosts.python3.enable = true;
            hosts.node.enable = true;
          };
          # enable the categories you want from categoryDefinitions
          categories = {
            markdown = true;
            general = true;
            lint = true;
            format = true;
            neonixdev = true;
            test = {
              subtest1 = true;
            };

            # enabling this category will enable the go category,
            # and ALSO debug.go and debug.default due to our extraCats in categoryDefinitions.
            # go = true; # <- disabled but you could enable it with override or module on install

            # this does not have an associated category of plugins,
            # but lua can still check for it
            lspDebugMode = false;
            # you could also pass something else:
            # see :help nixCats
            themer = true;
            colorscheme = "catppuccin";
          };
          extra = {
            # to keep the categories table from being filled with non category things that you want to pass
            # there is also an extra table you can use to pass extra stuff.
            # but you can pass all the same stuff in any of these sets and access it in lua
            nixdExtras = {
              nixpkgs = ''import ${pkgs.path} {}'';
              # or inherit nixpkgs;
            };
          };
        };
        neovim-dev = { pkgs, ... }@misc: {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = false;
            configDirName = "nix-neovim";

            aliases = [ "nix-neovim-dev" "nnvim-dev" ];
            hosts.python3.enable = true;
            hosts.node.enable = true;

            # If you wanted nightly, uncomment this, and the flake input.
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          categories = {
            markdown = true;
            general = true;
            neonixdev = true;
            lint = true;
            format = true;
            test = true;
            debug = true;
            go = true; # <- disabled but you could enable it with override or module on install
            pwsh = true;
            # rust = true;
            lspDebugMode = false;
            themer = true;
            colorscheme = "catppuccin";
          };
          extra = {
            # nixCats.extra("path.to.val") will perform vim.tbl_get(nixCats.extra, "path" "to" "val")
            # this is different from the main nixCats("path.to.cat") in that
            # the main nixCats("path.to.cat") will report true if `path.to = true`
            # even though path.to.cat would be an indexing error in that case.
            # this is to mimic the concept of "subcategories" but may get in the way of just fetching values.
            nixdExtras = {
              nixpkgs = ''import ${pkgs.path} {}'';
              # or inherit nixpkgs;
            };
          };
        };
      };

      defaultPackageName = "neovim";
      # I did not here, but you might want to create a package named nvim.

      # defaultPackageName is also passed to utils.mkNixosModules and utils.mkHomeModules
      # and it controls the name of the top level option set.
      # If you made a package named `nixCats` your default package as we did here,
      # the modules generated would be set at:
      # config.nixCats = {
      #   enable = true;
      #   packageNames = [ "nixCats" ]; # <- the packages you want installed
      #   <see :h nixCats.module for options>
      # }
      # In addition, every package exports its own module via passthru, and is overrideable.
      # so you can yourpackage.homeModule and then the namespace would be that packages name.
    in
    # you shouldnt need to change much past here, but you can if you wish.
      # but you should at least eventually try to figure out whats going on here!
      # see :help nixCats.flake.outputs.exports
    forEachSystem
      (system:
        let
          # and this will be our builder! it takes a name from our packageDefinitions as an argument, and builds an nvim.
          nixCatsBuilder = utils.baseBuilder luaPath
            {
              # we pass in the things to make a pkgs variable to build nvim with later
              inherit nixpkgs system dependencyOverlays extra_pkg_config;
              # and also our categoryDefinitions and packageDefinitions
            }
            categoryDefinitions
            packageDefinitions;
          # call it with our defaultPackageName
          defaultPackage = nixCatsBuilder defaultPackageName;

          # this pkgs variable is just for using utils such as pkgs.mkShell
          # within this outputs set.
          pkgs = import nixpkgs { inherit system; };
          # The one used to build neovim is resolved inside the builder
          # and is passed to our categoryDefinitions and packageDefinitions
        in
        {
          # these outputs will be wrapped with ${system} by utils.eachSystem

          # this will generate a set of all the packages
          # in the packageDefinitions defined above
          # from the package we give it.
          # and additionally output the original as default.
          packages = utils.mkAllWithDefault defaultPackage;

          # choose your package for devShell
          # and add whatever else you want in it.
          devShells = {
            default = pkgs.mkShell {
              name = defaultPackageName;
              packages = [ defaultPackage ];
              inputsFrom = [ ];
              shellHook = ''
        '';
            };
          };

        }) // (
      let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
      in
      {

        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath
          {
            inherit nixpkgs dependencyOverlays extra_pkg_config;
          }
          categoryDefinitions
          packageDefinitions
          defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );

}
