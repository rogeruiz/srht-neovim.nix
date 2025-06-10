# `neovim.nix` — Una configuración personalizada usando _Nix Cats_

> pa' [@rogeruiz][rsr].

> ℹ️ **Info**
>
> Can't read Spanish? [Look at this document][en].

> 📝 **Nota**
>
> Todo lo que sigue bajo esto fue inspirado es del origine `nix init` que usa la
> configuración `example` de `nixCats`.

Este repositorio es mi configuración que usa _Nix_ para crear derivaciones de
_Neovim_ con complementos que tiene una base. Puedes usar este proyecto pa'
empezar usando _Neovim_ con _Nix_.

Como este proyecto usa _Nix Cats_, la configuración de _Neovim_ usa el
complemento llamado `BirdeeHub/lze` para cargar suavemente diferida. También se
incluye `paq` y `mason` para que la configuración se puede usar sin tener `nix`
instalado.

El nombre `nixCats` se refiere a el administrador de paquetes en base de
`nixpkgs` y también es un complemento de _Lua_ que se usa para

## Estructura de carpetas

Esta configuración usa la estructura que se refiere abajo:

- La carpeta `./lua` pa' la configuración núcleo.
- La carpeta `./after/plugin` pa' mostrar compatibilidad.

También se puede usar carpetas que _Neovim_ carga en el arranque como:

- `./ftplugin` pa' las configuraciones de archivos particulares.
- `./plugin` pa' las configuraciones global de complementos.
- incluyendo `pack/*/{start,opt}` pa' crear y mantener complementos adentro de
  su configuración.
- Y más que se puede encontrar en la documentación del camino de arrancamiento
  de _Neovim_. [Referirte a la documentación][doc].

[doc]: https://neovim.io/doc/user/options.html#'rtp'
[en]: https://git.sr.ht/~rogeruiz/neovim.nix/tree/main/README.en.md
[rsr]: https://rog.gr/
