alias h := default
alias a := default
alias help := default
alias ayuda := default


[private]
default:
    just --list

[doc('Construir la derivació de Neovim ')]
build out=".":
    nix build {{ out }}

[doc('Correr Neovim Dev con derivación local')]
dev: 
    [[ "{{ path_exists("./dev-result") }}" == "true" ]] || just build '.#neovim-dev --out-link ./dev-result'
    ./dev-result/bin/nnvim-dev

[doc('Borrar la derivación dev')]
dev-clean:
    rm -rvf ./dev-result
