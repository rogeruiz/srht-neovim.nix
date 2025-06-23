return {
    "vim-matchup",
    for_cat = 'general.extra',
    after = function()
        vim.g.loaded_matchit = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_deferred_show_delay = 50
        vim.g.matchup_matchparen_deferred_hide_delay = 700
        vim.g.matchup_matchparen_singleton = 0
    end
}
