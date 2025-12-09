# Neovim Configuration

This Neovim configuration supports per-project customization through `.nvim.lua` files.

## Project-Specific Configuration

You can create a `.nvim.lua` file in the root of any project to customize Neovim behavior for that specific repository.

### Location

Place the `.nvim.lua` file in the root directory of your project (the directory where you open Neovim).

### Format

The `.nvim.lua` file should return a Lua table with configuration options:

```lua
-- .nvim.lua
return {
  lsp = { "svelte", "ts_ls", "tailwindcss", "eslint" }
}
```

### Available Options

#### `lsp` (array of strings)

Specifies which Language Server Protocol (LSP) servers to enable for this project.

**Example:**
```lua
return {
  lsp = { "svelte", "ts_ls" }
}
```

Common LSP server names:
- `"ts_ls"` - TypeScript/JavaScript
- `"svelte"` - Svelte
- `"tailwindcss"` - Tailwind CSS
- `"eslint"` - ESLint
- `"lua_ls"` - Lua
- `"pyright"` - Python
- `"rust_analyzer"` - Rust
- `"gopls"` - Go

### Example Configurations

**Svelte Web App:**
```lua
return {
  lsp = { "svelte", "ts_ls", "tailwindcss", "eslint" }
}
```

**Python Project:**
```lua
return {
  lsp = { "pyright" }
}
```

**Rust Project:**
```lua
return {
  lsp = { "rust_analyzer" }
}
```

### Git Integration

You can either:
- **Commit** `.nvim.lua` to share LSP configuration across your team
- **Add to `.gitignore`** to keep it local to your machine

### Notes

- The configuration is loaded once when Neovim starts
- LSP servers must be installed separately (via Mason or your system package manager)
- Invalid configurations will show a warning notification but won't prevent Neovim from starting
