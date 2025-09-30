alias h := default
alias a := default
alias help := default
alias ayuda := default


[private]
default:
    just --list

[doc('Construir la derivación de Neovim localmente')]
build categoria="." *FLAGS:
    nix build {{ categoria }} {{ FLAGS }}

[doc('Construir la derivación de Neovim Dev localmente')]
build-dev:
    just build '.#neovim-dev' --out-link ./dev-result

[doc('Borrar la derivaciones locales')]
clean:
    rm -rvf ./dev-result
    rm -rvf ./result

[doc('Correr Neovim con la configuración adentro desde el almacenamiento de Nix')]
run *ARGS:
    nix run '.' {{ ARGS }}

[doc('Correr Neovim Dev con la configuración sin envolver la configuración dentro el almacenamiento de Nix')]
dev *ARGS:
    nix run '.#neovim-dev' {{ ARGS }}

[doc('Actualiza la ultima versión de `neovim-dev`')]
upgrade-dev *ARGS:
    nix profile upgrade neovim-dev {{ ARGS }}

[doc('Actualiza todo adentro de `flake.lock`')]
update:
    nix flake update --commit-lock-file
