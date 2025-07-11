local M = {}

M.run = function()
  local isAvailable, Job = pcall(require, 'plenary.job')

  if not isAvailable then
    return
  end

  Job:new({
    command = 'figsay',
    cwd = '/Users/yo/.nix-profile/bin',
    args = {
      '-t "Neovim"',
      '-f "BlurVision ASCII"'
    },
    on_exit = function(j, return_val)
      print(return_val)
      local result = j:result()
      for k in pairs(result) do
        print(k)
      end
    end,
  }):start()
end

-- M.run()

M.headers = {
  -- NOTE: All ascii-art generated with ~rogeruiz/figsay on sourcehut.
  [[
░   ░░░  ░░        ░░░      ░░░  ░░░░  ░░        ░░  ░░░░  ░
▒    ▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒   ▒▒   ▒
▓  ▓  ▓  ▓▓      ▓▓▓▓  ▓▓▓▓  ▓▓▓  ▓▓  ▓▓▓▓▓▓  ▓▓▓▓▓        ▓
█  ██    ██  ████████  ████  ████    ███████  █████  █  █  █
█  ███   ██        ███      ██████  █████        ██  ████  █]],
  -- Bloody - https://patorjk.com/software/taag/#p=display&f=Bloddy&t=Neovim
  [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
         ░    ░  ░    ░ ░        ░   ░         ░
                                ░                  ]],
  -- BlurVision ASCII - https://patorjk.com/software/taag/#p=display&f=BlurVision%20ASCII&t=Neovim
  [[
░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
 ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  -- drpepper.flf
  [[
_ _  ___  ___  _ _  _  __ __
| \ || __>| . || | || ||  \  \
|   || _> | | || ' || ||     |
|_\_||___>`___'|__/ |_||_|_|_|
                              ]],
  -- Chiseled -- https://patorjk.com/software/taag/#p=display&f=Chiseled&t=Neovim
  [[
  .-._           ,----.     _,.---._           ,-.-. .=-.-.       ___
 /==/ \  .-._ ,-.--` , \  ,-.' , -  `.  ,--.-./=/ ,//==/_ /.-._ .'=.'\
 |==|, \/ /, /==|-  _.-` /==/_,  ,  - \/==/, ||=| -|==|, |/==/ \|==|  |
 |==|-  \|  ||==|   `.-.|==|   .=.     \==\,  \ / ,|==|  ||==|,|  / - |
 |==| ,  | -/==/_ ,    /|==|_ : ;=:  - |\==\ - ' - /==|- ||==|  \/  , |
 |==| -   _ |==|    .-' |==| , '='     | \==\ ,   ||==| ,||==|- ,   _ |
 |==|  /\ , |==|_  ,`-._ \==\ -    ,_ /  |==| -  ,/|==|- ||==| _ /\   |
 /==/, | |- /==/ ,     /  '.='. -   .'   \==\  _ / /==/. //==/  / / , /
 `--`./  `--`--`-----``     `--`--''      `--`--'  `--`-` `--`./  `--`  ]],
  -- cosmic.flf
  [[
:::.    :::.  .,::::::        ...       :::      .::.  :::  .        :
`;;;;,  `;;;  ;;;;''''     .;;;;;;;.    ';;,   ,;;;'   ;;;  ;;,.    ;;;
  [[[[[. '[[   [[cccc     ,[[     \[[,   \[[  .[[/     [[[  [[[[, ,[[[[,
  $$$ "Y$c$$   $$""""     $$$,     $$$    Y$c.$$"      $$$  $$$$$$$$"$$$
  888    Y88   888oo,__   "888,_ _,88P     Y88P        888  888 Y88" 888o
  MMM     YM   """"YUMMM    "YMMMMMP"       MP         MMM  MMM  M'  "MMM]],
  -- banner3-D.flf
  [[
'##::: ##:'########::'#######::'##::::'##:'####:'##::::'##:
 ###:: ##: ##.....::'##.... ##: ##:::: ##:. ##:: ###::'###:
 ####: ##: ##::::::: ##:::: ##: ##:::: ##:: ##:: ####'####:
 ## ## ##: ######::: ##:::: ##: ##:::: ##:: ##:: ## ### ##:
 ##. ####: ##...:::: ##:::: ##:. ##:: ##::: ##:: ##. #: ##:
 ##:. ###: ##::::::: ##:::: ##::. ## ##:::: ##:: ##:.:: ##:
 ##::. ##: ########:. #######::::. ###::::'####: ##:::: ##:
..::::..::........:::.......::::::...:::::....::..:::::..::]],
  -- smkeyboard.flf
  [[
____ ____ ____ ____ ____ ____
||N |||e |||o |||v |||i |||m ||
||__|||__|||__|||__|||__|||__||
 |/__\|/__\|/__\|/__\|/__\|/__\| ]],
}

return M.headers
