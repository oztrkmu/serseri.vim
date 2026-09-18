#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
command -v vim >/dev/null 2>&1 || { echo 'Vim is required.' >&2; exit 1; }
command -v curl >/dev/null 2>&1 || { echo 'curl is required.' >&2; exit 1; }

mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/undo"
if [ ! -s "$HOME/.vim/autoload/plug.vim" ]; then
    plug_tmp=$(mktemp "$HOME/.vim/autoload/plug.vim.XXXXXX")
    trap 'rm -f "$plug_tmp"' EXIT HUP INT TERM
    curl -fL --retry 2 -o "$plug_tmp" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mv "$plug_tmp" "$HOME/.vim/autoload/plug.vim"
    trap - EXIT HUP INT TERM
fi

if [ -e "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]; then
    backup=$(mktemp "$HOME/.vimrc.backup.XXXXXX")
    cp -P "$HOME/.vimrc" "$backup"
    printf 'Backup: %s\n' "$backup"
fi
# Replace a symlink itself, leaving its original target untouched.
vimrc_tmp=$(mktemp "$HOME/.vimrc.XXXXXX")
trap 'rm -f "$vimrc_tmp"' EXIT HUP INT TERM
cp "$repo_dir/vimrc" "$vimrc_tmp"
mv -f "$vimrc_tmp" "$HOME/.vimrc"
trap - EXIT HUP INT TERM
printf '%s\n' 'Installed. Open Vim and run :PlugInstall, then :CocInstall coc-clangd.'
