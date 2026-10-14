-- lua/shiv/tools/include_rename.lua
-- Universal file rename updater: Automatically updates imports/includes across project files
-- Supported languages: C, C++, Python, Rust, JavaScript, TypeScript, Lua
local M = {}

local function normalize(path)
  return path:gsub("\\", "/")
end

local function split_path(path)
  local parts = {}
  for p in path:gmatch("[^/]+") do
    parts[#parts + 1] = p
  end
  return parts
end

local function join_path(parts, from_idx, to_idx)
  return table.concat(vim.list_slice(parts, from_idx, to_idx), "/")
end

local function find_project_root(path)
  local cwd = (vim.uv or vim.loop).cwd()
  return vim.fs.root(path, { ".git", "compile_commands.json", "Cargo.toml", "pyproject.toml", "package.json" }) or cwd
end

local function filename_stem(path)
  local file = path:match("([^/]+)$") or path
  return file:match("^(.*)%.") or file
end

local function get_file_lang(path)
  local ext = path:match("%.([%a%d]+)$")
  if not ext then return nil end
  ext = ext:lower()

  if vim.tbl_contains({ "h", "hh", "hpp", "hxx", "inl", "ipp", "tpp", "c", "cc", "cpp", "cxx" }, ext) then
    return "cpp"
  elseif ext == "py" then
    return "python"
  elseif ext == "rs" then
    return "rust"
  elseif vim.tbl_contains({ "ts", "tsx", "js", "jsx", "mjs", "cjs" }, ext) then
    return "js_ts"
  elseif ext == "lua" then
    return "lua"
  end
  return nil
end

local function is_lang_file(path, lang)
  return get_file_lang(path) == lang
end

local function compute_replacements(old_abs, new_abs)
  local root = find_project_root(old_abs)
  local old_rel = vim.fs.relpath(root, old_abs)
  local new_rel = vim.fs.relpath(root, new_abs)

  if not old_rel or not new_rel then
    return {}, root
  end

  old_rel = normalize(old_rel)
  new_rel = normalize(new_rel)

  local old_parts = split_path(old_rel)
  local new_parts = split_path(new_rel)
  local replacements = {}

  local max_suffix = math.min(#old_parts, #new_parts)
  for n = max_suffix, 2, -1 do
    local old_suffix = join_path(old_parts, #old_parts - n + 1, #old_parts)
    local new_suffix = join_path(new_parts, #new_parts - n + 1, #new_parts)
    replacements[#replacements + 1] = {
      old = old_suffix,
      new = new_suffix,
      priority = n,
    }
  end

  local old_base = old_parts[#old_parts]
  local new_base = new_parts[#new_parts]
  replacements[#replacements + 1] = {
    old = old_base,
    new = new_base,
    priority = 1,
  }

  table.sort(replacements, function(a, b)
    return a.priority > b.priority
  end)

  return replacements, root
end

-- 1. C/C++ line rewriter
local function rewrite_cpp_line(line, replacements)
  local prefix, include_path, suffix = line:match('^(%s*#%s*include%s*[<"])([^>"]+)([>"].*)$')
  if not include_path then return line, false end

  local normalized = normalize(include_path)
  for _, item in ipairs(replacements) do
    if normalized == item.old then
      return prefix .. item.new .. suffix, true
    end
    if normalized:sub(-(item.old:len() + 1)) == "/" .. item.old then
      local rewritten = normalized:sub(1, #normalized - #item.old) .. item.new
      return prefix .. rewritten .. suffix, true
    end
  end
  return line, false
end

-- 2. Python line rewriter
local function rewrite_python_line(line, old_stem, new_stem)
  local changed = false
  -- from old import ... -> from new import ...
  local new_line, n = line:gsub("^(%s*from%s+)([%w_%.]*)%f[%w_]" .. old_stem .. "%f[%W](%s+import)", "%1%2" .. new_stem .. "%3")
  if n > 0 then line = new_line; changed = true end

  -- import old as ... or import old
  new_line, n = line:gsub("^(%s*import%s+)([%w_%.]*)%f[%w_]" .. old_stem .. "%f[%W]", "%1%2" .. new_stem)
  if n > 0 then line = new_line; changed = true end

  return line, changed
end

-- 3. Rust line rewriter
local function rewrite_rust_line(line, old_stem, new_stem)
  local changed = false
  -- mod old; or pub mod old;
  local new_line, n = line:gsub("^(%s*[%w%(%)]*%s*mod%s+)%f[%w_]" .. old_stem .. "%f[%W](%s*;)", "%1" .. new_stem .. "%2")
  if n > 0 then line = new_line; changed = true end

  -- use ...::old; or use ...::old::...
  new_line, n = line:gsub("(use%s+.-::)%f[%w_]" .. old_stem .. "%f[%W]", "%1" .. new_stem)
  if n > 0 then line = new_line; changed = true end

  return line, changed
end

-- 4. JS/TS line rewriter
local function rewrite_js_ts_line(line, old_stem, new_stem, replacements)
  local prefix, import_path, suffix = line:match("^(.*['\"])(.-)(['\"].*)$")
  if prefix and import_path and suffix then
    local normalized = normalize(import_path)
    for _, item in ipairs(replacements) do
      local old_no_ext = item.old:gsub("%.%w+$", "")
      local new_no_ext = item.new:gsub("%.%w+$", "")
      if normalized == item.old or normalized == old_no_ext then
        local replace_with = normalized == item.old and item.new or new_no_ext
        return prefix .. replace_with .. suffix, true
      end
      if normalized:sub(-(old_no_ext:len() + 1)) == "/" .. old_no_ext then
        local rewritten = normalized:sub(1, #normalized - #old_no_ext) .. new_no_ext
        return prefix .. rewritten .. suffix, true
      end
    end
    if normalized:match("/" .. old_stem .. "$") or normalized == "./" .. old_stem or normalized == old_stem then
      local rewritten = normalized:gsub(old_stem .. "$", new_stem)
      return prefix .. rewritten .. suffix, true
    end
  end
  return line, false
end

-- 5. Lua line rewriter
local function rewrite_lua_line(line, old_stem, new_stem)
  local changed = false
  local new_line, n = line:gsub("(require%s*%(?%s*['\"][%w_%.]*)[%.%/]" .. old_stem .. "(['\"])", "%1." .. new_stem .. "%2")
  if n > 0 then line = new_line; changed = true end

  new_line, n = line:gsub("(require%s*%(?%s*['\"])" .. old_stem .. "(['\"])", "%1" .. new_stem .. "%2")
  if n > 0 then line = new_line; changed = true end

  return line, changed
end

local function rewrite_line_for_lang(lang, line, old_stem, new_stem, replacements)
  if lang == "cpp" then
    return rewrite_cpp_line(line, replacements)
  elseif lang == "python" then
    return rewrite_python_line(line, old_stem, new_stem)
  elseif lang == "rust" then
    return rewrite_rust_line(line, old_stem, new_stem)
  elseif lang == "js_ts" then
    return rewrite_js_ts_line(line, old_stem, new_stem, replacements)
  elseif lang == "lua" then
    return rewrite_lua_line(line, old_stem, new_stem)
  end
  return line, false
end

local function loaded_buf_for_file(path)
  local target = normalize(vim.fn.fnamemodify(path, ":p"))
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= "" and normalize(vim.fn.fnamemodify(name, ":p")) == target then
        return bufnr
      end
    end
  end
  return nil
end

local function rewrite_lines(lang, lines, old_stem, new_stem, replacements)
  local changed = false
  for i, line in ipairs(lines) do
    local rewritten, line_changed = rewrite_line_for_lang(lang, line, old_stem, new_stem, replacements)
    if line_changed then
      lines[i] = rewritten
      changed = true
    end
  end
  return changed
end

local IGNORED_DIRS = {
  [".git"] = true,
  ["node_modules"] = true,
  [".venv"] = true,
  ["venv"] = true,
  ["target"] = true,
  ["build"] = true,
  ["dist"] = true,
  [".cache"] = true,
}

local function get_project_files(dir)
  local files = {}
  local function scan(current_dir)
    local ok, iter = pcall(vim.fs.dir, current_dir)
    if not ok or not iter then return end
    for name, type in iter do
      if type == "directory" then
        if not IGNORED_DIRS[name] then
          scan(current_dir .. "/" .. name)
        end
      elseif type == "file" then
        files[#files + 1] = current_dir .. "/" .. name
      end
    end
  end
  scan(dir)
  return files
end

local function rewrite_references_in_project(lang, old_abs, new_abs)
  local replacements, root = compute_replacements(old_abs, new_abs)
  local old_stem = filename_stem(old_abs)
  local new_stem = filename_stem(new_abs)

  local changed_files = 0
  local files = get_project_files(root)

  for _, file in ipairs(files) do
    if is_lang_file(file, lang) and file ~= new_abs then
      local bufnr = loaded_buf_for_file(file)
      local lines = bufnr and vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) or vim.fn.readfile(file)

      if rewrite_lines(lang, lines, old_stem, new_stem, replacements) then
        if bufnr then
          if not vim.bo[bufnr].modifiable then
            vim.notify("Skipped unmodifiable buffer: " .. file, vim.log.levels.WARN)
          else
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_buf_call(bufnr, function()
              if not vim.bo.readonly then
                vim.cmd("silent write")
              end
            end)
            changed_files = changed_files + 1
          end
        else
          vim.fn.writefile(lines, file)
          changed_files = changed_files + 1
        end
      end
    end
  end

  return changed_files
end

local function apply_lsp_file_rename(old_abs, new_abs)
  local files = {
    {
      oldUri = vim.uri_from_fname(old_abs),
      newUri = vim.uri_from_fname(new_abs),
    },
  }

  local any_applied = false
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client:supports_method("workspace/willRenameFiles") then
      local result = client:request_sync("workspace/willRenameFiles", { files = files }, 2000)
      local edit = result and result.result
      if edit then
        vim.lsp.util.apply_workspace_edit(edit, client.offset_encoding or "utf-16")
        any_applied = true
      end
    end
  end

  return any_applied
end

function M.on_node_renamed(data)
  local old_abs = data and data.old_name
  local new_abs = data and data.new_name

  if not old_abs or not new_abs then return end

  old_abs = normalize(old_abs)
  new_abs = normalize(new_abs)

  local lang = get_file_lang(old_abs)
  if not lang then return end

  -- 1. Attempt standard LSP workspace file rename
  apply_lsp_file_rename(old_abs, new_abs)

  -- 2. Universal guaranteed fallback rewrite for C++, Python, Rust, TS/JS, Lua
  local changed = rewrite_references_in_project(lang, old_abs, new_abs)
  if changed > 0 then
    local lang_names = {
      cpp = "C/C++ include",
      python = "Python import",
      rust = "Rust module/use",
      js_ts = "JS/TS import",
      lua = "Lua require",
    }
    local display_lang = lang_names[lang] or (lang:upper() .. " import")
    vim.notify(("Updated %s references in %d file(s)"):format(display_lang, changed), vim.log.levels.INFO)
  end
end

function M.setup(api)
  if not api or not api.events or not api.events.subscribe or not api.events.Event then
    return
  end

  api.events.subscribe(api.events.Event.NodeRenamed, M.on_node_renamed)
end

return M
