# serseri.vim

Classic Vim, a little serseri comfort. Customized for writing C on Unix.
Grab it, make yourself at home, write some C.

Four-space indentation, an 80-column guide, completion with clangd,
file search, Git, formatting and debugging. Space is the leader key.

## Install

Have Vim with Python 3 support, Git, curl, Node.js (for CoC), GCC, make,
clangd, clang-format, clang-tidy, ripgrep, fzf and Universal Ctags on your PATH.
GDB and Valgrind are optional debugging tools.

```sh
git clone https://github.com/oztrkmu/serseri.vim.git
cd serseri.vim
./install.sh
vim
```

Inside Vim:

```vim
:PlugInstall
:CocInstall coc-clangd
```

Restart Vim. The installer backs up your existing `~/.vimrc` before replacing it.
To update the config later, run `./install.sh` again.

## Use it

| Key | Action |
| --- | --- |
| Ctrl+Z | Save all changed files and quit (normal, insert or visual mode) |
| Space w | Save |
| Ctrl+P | Find files |
| Space fr | Search project |
| Space e | File tree |
| gd / gr / K | Definition / references / documentation |
| F5 / F6 | Save and make / open build errors |
| F7 / F8 | Format / symbols |
| Space cc / Space cr | Build / run the current C file |
| Space cs / Space cv | Sanitizer build / Valgrind |
| Space gs | Git status |
| F9 / F10 / F11 / F12 | Breakpoint / step over / step into / continue |
| Space tt | Terminal (Esc leaves terminal input mode) |

Ctrl+Z replaces Vim's usual suspend action. If a file cannot be saved,
Vim stays open; give unnamed buffers a filename with `:w filename.c` first.

Single-file builds use GCC and C17. `Space cs` creates a separate `-asan`
binary; run it from your shell. For projects, use a Makefile with F5 and
provide `compile_commands.json` for clangd and clang-tidy.

Debugging uses Vimspector: run `:VimspectorInstall vscode-cpptools` and add
a project `.vimspector.json` before using the debugger keys.
