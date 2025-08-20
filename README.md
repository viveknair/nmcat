# nmcat - Node Modules Package Content Copier

A command-line tool that copies node module package contents to your clipboard using [llmcat](https://github.com/azer/llmcat).

## Features

- 🔍 Automatically finds `node_modules` by searching up the directory tree
- 📋 Copies package contents to clipboard for easy sharing
- 🐟 Smart Fish shell completions with instant response
- 🚀 Supports all llmcat options (print, tree view, ignore patterns, etc.)

## Installation

```bash
./install.sh
```

The installer will:

1. Create a symlink in `/usr/local/bin/nmcat`
2. Install smart Fish completions (if Fish is detected)

## Usage

```bash
# Copy package contents to clipboard
nmcat express

# Print package contents while copying
nmcat -p lodash

# Only show directory tree
nmcat -t react

# Print without copying to clipboard
nmcat -P axios
```

## Fish Completions

The Fish completions are optimized for performance, even with thousands of packages:

- **Instant response**: Shows common packages on first tab (no filesystem scanning)
- **Smart filtering**: As you type, uses efficient filtering to find matches
- **Scoped packages**: Handles `@scope/package` format intelligently

### How it works:

- Press `Tab` with empty input → Shows common packages instantly
- Type `exp` + `Tab` → Filters to packages starting with "exp"
- Type `@types/` + `Tab` → Shows only packages in the @types scope
- Type `@ty` + `Tab` → Shows matching scopes with example packages

## Options

- `-h, --help` - Show help message
- `-v, --version` - Show version
- `-p, --print` - Print copied files/content, and also copy to clipboard
- `-P, --print-only` - Print copied files/content, but DON'T copy to clipboard
- `-t, --tree-only` - Only output directory tree
- `-i, --ignore PATTERN` - Additional ignore patterns
- `-H, --hidden` - Include hidden files/directories
- `--debug` - Enable debug output

## Requirements

- [llmcat](https://github.com/azer/llmcat) must be installed
- Fish shell (optional, for completions)

## License

MIT
