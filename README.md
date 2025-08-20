# nmcat - Node Module Context Sharing for LLMs

A command-line tool that instantly copies node module package contents to your clipboard for sharing with LLMs. Perfect for longer, more productive conversations with AI assistants like Gemini 2.5 Pro and Claude 4 Opus.

## Why nmcat?

Modern LLMs excel at understanding and working with large codebases when given proper context. **Gemini 2.5 Pro** in particular shines with its massive context window, allowing you to share entire npm packages and maintain deep, technical conversations about your dependencies. 

Instead of manually copying files or struggling to describe package internals, `nmcat` lets you instantly share complete package context with your LLM - enabling it to:
- Debug dependency issues with full visibility
- Suggest optimizations based on actual implementation
- Write code that properly integrates with your packages
- Understand the nuances of how libraries actually work

## How It Works

`nmcat` leverages the powerful [llmcat](https://github.com/azer/llmcat) tool to handle the heavy lifting of:
- Intelligently traversing package directories
- Filtering out unnecessary files (tests, docs, build artifacts)
- Formatting code for optimal LLM consumption
- Managing clipboard operations across platforms

We simply provide a convenient wrapper that:
1. Automatically locates your `node_modules` directory
2. Finds the specific package you want to share
3. Uses `llmcat` to process and copy the relevant source code
4. Puts everything in your clipboard, ready to paste into your LLM conversation

## Features

- 🤖 **LLM-Optimized**: Formatted output designed for AI comprehension
- 📦 **Smart Package Discovery**: Automatically finds node_modules in parent directories
- 🎯 **Focused Content**: Shares only relevant source code, not bloat
- 🐟 **Instant Fish Completions**: Tab-complete package names without delays
- 🔧 **Full llmcat Power**: Access all underlying options (tree view, ignore patterns, etc.)

## Installation

```bash
./install.sh
```

The installer will:
1. Create a symlink in `/usr/local/bin/nmcat`
2. Install smart Fish completions (if Fish is detected)

## Usage

### Basic LLM Workflow

```bash
# Copy a package to share with your LLM
nmcat express

# Then paste into your LLM chat:
# "Here's the Express source code: [paste]. Can you help me understand
# how middleware chaining works internally?"
```

### Advanced Options

```bash
# Preview what you're copying (useful for large packages)
nmcat -p lodash

# Just show the directory structure first
nmcat -t react

# Print without copying (for reviewing before sharing)
nmcat -P axios

# Include test files for comprehensive context
nmcat -i '' jest
```

## Perfect for Gemini 2.5 Pro

Gemini 2.5 Pro's massive context window means you can share entire npm packages and maintain conversation continuity. Example workflow:

1. Share your main package: `nmcat express`
2. Add middleware packages: `nmcat body-parser`, `nmcat cors`
3. Include your app code
4. Have a deep technical discussion with full context

The LLM can now see exactly how these packages work together, spot potential issues, and suggest improvements based on actual implementation details rather than assumptions.

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

- [llmcat](https://github.com/azer/llmcat) - The powerful engine that makes this possible
- Fish shell (optional, for completions)

## Tips for LLM Conversations

1. **Start with context**: Share the main package first before asking questions
2. **Layer dependencies**: Add related packages to build comprehensive context
3. **Be specific**: LLMs perform better when they can see actual code vs. descriptions
4. **Use tree view**: `nmcat -t package` helps you and the LLM understand structure
5. **Keep conversations focused**: Even with large context windows, focused discussions yield better results

## License

MIT
