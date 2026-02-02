# Bash & Vim GTD Workflow

A lightweight, terminal-based "Getting Things Done" (GTD) environment. It combines powerful Bash aliases for daily logging with a turbocharged Vim configuration for task management.

## 📂 Repository Structure

```text
.
├── aliases_general        # The core logic (Bash functions)
├── vim/
│   ├── ftplugin/
│   │   └── todo.vim       # Vim Logic (Mappings, Functions)
│   └── syntax/
│       └── todo.vim       # Vim Visuals (Colors, Syntax)
└── templates/
    └── daily.txt          # predefined template files

```

## 🚀 Installation

### 1. Prerequisites

* **OS:** Linux or macOS (Bash or Zsh)
* **Editor:** Vim (version 8.0+)
* **Utils:** `grep`, `sed`, `date`, `column` (usually part of `bsdmainutils`)

### 2. Setup Directories

Create the directory structure where your notes will live (defined in `aliases_general`):

```bash
mkdir -p ~/notes/todo/daily
mkdir -p ~/notes/todo/templates

```

### 3. Install Vim Configuration

Symlink (or copy) the Vim files from this repo to your local `.vim` directory.

> **Note:** Run these commands from the root of this cloned repository.

```bash
# Create Vim directories if they don't exist
mkdir -p ~/.vim/ftplugin ~/.vim/syntax

# Symlink the files (Recommended)
ln -s $(pwd)/vim/ftplugin/todo.vim ~/.vim/ftplugin/todo.vim
ln -s $(pwd)/vim/syntax/todo.vim ~/.vim/syntax/todo.vim

```

### 4. Configure .vimrc

Add the following lines to your `~/.vimrc` to enable filetype detection and syntax highlighting:

```vim
" Enable filetype plugins and syntax
filetype plugin indent on
syntax on

" Auto-detect .txt files in your todo folder as 'todo' filetype
autocmd BufRead,BufNewFile */todo/daily/*.txt set filetype=todo

```

### 5. Load the Aliases

Source the `aliases_general` file in your shell configuration (`~/.bashrc` or `~/.zshrc`).

```bash
# Add this to your .bashrc
source /path/to/your/repo/aliases_general

```

Restart your terminal or run `source ~/.bashrc`.

### 6. Configure Templates
Symlink (or copy) the template files from this repo to your local `~/notes/todo/templates` directory.

---

## ⌨️ Usage Guide

### ⚡ CLI Commands

| Command | Description |
| --- | --- |
| **`todo`** | **Start the day.** Creates today's file, fills gaps (sick/holiday), and **auto-migrates** unfinished tasks from the last active day. Opens Vim. |
| **`yodo`** | **Review Yesterday.** Opens the most recent previous file. |
| **`sodo <term>`** | **Search.** Case-insensitive grep across all files. (e.g., `sodo "docker"`). |
| **`note <text>`** | **Quick Capture.** Appends a timestamped note to today's file without opening Vim. |

### 📝 Vim Shortcuts (Inside Todo Files)

**Task Management**
| Key | Action | Logic |
| :--- | :--- | :--- |
| `<leader>x` | **Toggle Done** | `[ ]` ↔ `[x]` |
| `<leader>w` | **Cycle Status** | `[ ]` → `[!]` → `[?]` → `[~]` → `[ ]` |

---

## 📄 File Format

The system relies on a specific file structure to perform auto-migration and logging.

```text
DATE: 2026-02-02 (Monday)
================================================================================

[PLAN]
[x] Finished Task
[ ] Active Task (Will be migrated tomorrow)
[!] Urgent Task
[?] Question / Waiting
[~] Canceled Task

[LOG]
Start | Dur  | Ticket     | Activity
------+------+------------+---------------------------------------------------
09:00 | 0:15 | #123       | Standup meeting
10:00 | 2:00 | #456       | Deep work

[NOTES]: Quick note about the server...
________________________________________________________________________________

```

## ⚙️ Customization

* **File Paths:** Edit `export TODO_BASE_DIR` in `aliases_general` and references to it in `.vimrc`.
* **Colors:** Edit `vim/syntax/todo.vim` to match your terminal theme.
