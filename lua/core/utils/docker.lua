local M = {}

local TERMINAL = require("toggleterm.terminal").Terminal

-- Docker
local docker_tui = "lazydocker"

local docker_client = TERMINAL:new({
    cmd = docker_tui,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function M.docker_client_toggle()
    docker_client:toggle()
end

-- Docker ctop
local docker_ctop = "ctop"

local docker_ctop = TERMINAL:new({
    cmd = docker_ctop,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function M.docker_ctop_toggle()
    docker_ctop:toggle()
end

-- Docker dockly
local docker_dockly = "dockly"

local docker_dockly = TERMINAL:new({
    cmd = docker_dockly,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function M.docker_dockly_toggle()
    docker_dockly:toggle()
end

return M
