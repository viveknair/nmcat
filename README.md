# nmcat - Node Module Cat

A command-line utility that copies node module package contents to clipboard using [llmcat](https://github.com/azer/llmcat).

## Features

- Automatically finds `node_modules` by searching up the directory tree
- Uses `llmcat` for processing and copying package contents
- Supports all `llmcat` options
- Fish shell completions for installed packages

## Installation

```bash
# Clone this repository
cd /Users/vivek/Code/nmcat

# Run the install script
./install.sh
```

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

# Handle scoped packages
nmcat @types/node
```

## Options

- `-h, --help` - Show help message
- `-v, --version` - Show version
- `-p, --print` - Print copied files/content, and also copy to clipboard
- `-P, --print-only` - Print copied files/content, but DON'T copy to clipboard
- `-t, --tree-only` - Only output directory tree
- `-i, --ignore PATTERN` - Additional ignore patterns (fd exclude format)
- `-H, --hidden` - Include hidden files/directories
- `--debug` - Enable debug output

## Fish Completions

The fish completions will be automatically installed if fish is detected. They provide tab completion for:
- All installed packages in the nearest `node_modules`
- Scoped packages (e.g., `@types/node`)
- Command options

## Requirements

- `llmcat` must be installed at `/Users/vivek/Code/llmcat/llmcat`
- `bash` shell
- `pbcopy` (macOS) or `xclip`/`xsel` (Linux) for clipboard support

## How It Works

1. `nmcat` searches up the directory tree to find the nearest `node_modules` directory
2. It looks for the specified package (including scoped packages)
3. It calls `llmcat` with the package directory and any provided options
4. The package contents are copied to clipboard (or printed, based on options)