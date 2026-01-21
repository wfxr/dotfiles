local M = {}

--- Returns a closure that calls require("dap")[method](...) on demand
function M.dap(method)
  return function(...)
    return require("dap")[method](...)
  end
end

--- Run neotest with dap strategy
function M.neotest_dap_test()
  require("neotest").run.run({ strategy = "dap" })
end

-- Go test helpers (Treesitter-based)

local function classify_go_test(name, params_text)
  if not name or name == "" then
    return nil
  end
  params_text = params_text or ""
  if name:match("^Test[%w_]+$") and params_text:find("*testing.T", 1, true) then
    return "test"
  end
  if name:match("^Benchmark[%w_]+$") and params_text:find("*testing.B", 1, true) then
    return "bench"
  end
  if name:match("^Fuzz[%w_]+$") and params_text:find("*testing.F", 1, true) then
    return "fuzz"
  end
  return nil
end

local function get_current_go_test_name(bufnr)
  local node = vim.treesitter.get_node({ bufnr = bufnr })
  while node do
    if node:type() == "function_declaration" then
      local name_node = node:field("name")[1]
      local params_node = node:field("parameters")[1]
      if name_node and params_node then
        local name = vim.treesitter.get_node_text(name_node, bufnr)
        local params_text = vim.treesitter.get_node_text(params_node, bufnr) or ""
        if classify_go_test(name, params_text) then
          return name
        end
      end
      return nil
    end
    node = node:parent()
  end
  return nil
end

local function list_go_tests_in_buf(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "go")
  if not ok or not parser then
    return {}
  end
  local trees = parser:parse()
  if not trees or not trees[1] then
    return {}
  end

  local query = vim.treesitter.query.parse(
    "go",
    [[
    (function_declaration
      name: (identifier) @name
      parameters: (parameter_list) @params)
  ]]
  )

  local tests, seen = {}, {}
  for id, node in query:iter_captures(trees[1]:root(), bufnr, 0, -1) do
    if query.captures[id] == "name" then
      local name = vim.treesitter.get_node_text(node, bufnr)
      if name and not seen[name] then
        local fn = node:parent()
        local params_node = fn and fn:field("parameters")[1]
        local params_text = params_node and vim.treesitter.get_node_text(params_node, bufnr) or ""
        if classify_go_test(name, params_text) then
          seen[name] = true
          tests[#tests + 1] = name
        end
      end
    end
  end
  return tests
end

local function pick_go_test()
  local bufnr = vim.api.nvim_get_current_buf()

  local current = get_current_go_test_name(bufnr)
  if current then
    return current
  end

  local tests = list_go_tests_in_buf(bufnr)
  if #tests == 0 then
    local file = vim.api.nvim_buf_get_name(bufnr)
    vim.notify("No Test/Benchmark/Fuzz found in " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.WARN)
    return nil
  end

  local co = coroutine.running()
  vim.ui.select(tests, { prompt = "Select Go test:" }, function(choice)
    coroutine.resume(co, choice)
  end)
  return coroutine.yield()
end

local function go_test_args_for_name(name)
  if not name then
    return { "-test.run", "^$", "-test.count=1" }
  end
  if name:match("^Test") then
    return { "-test.run", "^" .. name .. "$", "-test.count=1" }
  end
  if name:match("^Benchmark") then
    return { "-test.run", "^$", "-test.bench", "^" .. name .. "$" }
  end
  if name:match("^Fuzz") then
    return { "-test.run", "^$", "-test.fuzz", "^" .. name .. "$", "-test.fuzztime=5s" }
  end
  return { "-test.run", "^$", "-test.count=1" }
end

--- Returns args for dap-go: picks test at cursor or via picker, then generates appropriate flags
function M.go_test_args()
  return go_test_args_for_name(pick_go_test())
end

return M
