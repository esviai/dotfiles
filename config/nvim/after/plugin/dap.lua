local map = require "main.map"

-- just want to make sure that we have dap and dapui
local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local has_dap_ui, dapui = pcall(require, "dapui")
if not has_dap_ui then
  return
end

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  -- change this to where you build vscode-php-debug
  args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
}

dap.configurations.php = {
  -- to run php right from the editor
  {
    name = "run current script",
    type = "php",
    request = "launch",
    port = 9003,
    cwd = "${fileDirname}",
    program = "${file}",
    runtimeExecutable = "php"
  },
  -- to listen to any php call
  {
    name = "listen for Xdebug local",
    type = "php",
    request = "launch",
    port = 9003,
  },
  -- to listen to php call in docker container
  {
    name = "listen for Xdebug docker",
    type = "php",
    request = "launch",
    port = 9003,
    -- this is where your file is in the container
    pathMappings = {
      ["/opt/project"] = "${workspaceFolder}"
    }
  }
}

-- toggle the UI elements after certain events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup()

require "dapui".setup {
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  }
}

require "nvim-dap-virtual-text".setup {
  commented = true,
}

map("n", "<F5>", require "dap".continue, {})
map("n", "<F10>", require "dap".step_over, {})
map("n", "<F11>", require "dap".step_into, {})
map("n", "<F12>", require "dap".step_out, {})
map("n", "<leader>b", require "dap".toggle_breakpoint, {})
map("n", "<leader>du", ":lua require'dapui'.toggle()<cr>", {})
