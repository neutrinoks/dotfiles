return {
    "github/copilot.vim",
    name = "copilot",
    config = function()
        require('git-conflict').setup()
    end
}
