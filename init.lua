require("./options")
require("./keymap")
require("./autocommand")
if not vim.g.vscode then
    require("./plugin")
end
