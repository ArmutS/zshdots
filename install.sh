#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
target_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
plugin_dir="$HOME/.oh-my-zsh/custom/plugins"

for program in git zsh; do
    if ! command -v "$program" >/dev/null 2>&1; then
        printf 'Eksik program: %s\n' "$program" >&2
        exit 1
    fi
done

for file in "$repo_dir/.zshenv" "$repo_dir/zsh/.zshrc" "$repo_dir/zsh/user.zsh" "$repo_dir"/zsh/functions/*.zsh; do
    zsh -n "$file"
done

clone_if_missing() {
    url=$1
    destination=$2
    revision=$3
    if [ -d "$destination/.git" ]; then
        printf 'Zaten kurulu: %s\n' "$destination"
        return
    fi
    if [ -e "$destination" ]; then
        printf 'Var olan dizin Git deposu değil: %s\n' "$destination" >&2
        exit 1
    fi
    git clone "$url" "$destination"
    git -C "$destination" checkout --detach "$revision"
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git \
    "$HOME/.oh-my-zsh" 74965c96098134b192f00084f966b4b02438a739
mkdir -p "$plugin_dir"
clone_if_missing https://github.com/chrissicool/zsh-256color \
    "$plugin_dir/zsh-256color" 559fee48bb74b75cec8b9887f8f3e046f01d5d8f
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions \
    "$plugin_dir/zsh-autosuggestions" 85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting \
    "$plugin_dir/zsh-syntax-highlighting" 0bfcb582e71d3abe604ce67bc0fe5a21f377507e

backup_dir="$HOME/.zsh-portable-backups/$(date +%Y%m%d-%H%M%S)-$$"
for item in "$HOME/.zshenv" "$HOME/.zshrc" "$target_dir"; do
    if [ -e "$item" ] || [ -L "$item" ]; then
        mkdir -p "$backup_dir"
        mv "$item" "$backup_dir/$(basename "$item")"
    fi
done

mkdir -p "$(dirname "$target_dir")"
cp -R "$repo_dir/zsh" "$target_dir"
cp "$repo_dir/.zshenv" "$HOME/.zshenv"

printf 'Zsh ayarları kuruldu. Yeni terminal aç veya exec zsh çalıştır.\n'
if [ -d "$backup_dir" ]; then
    printf 'Eski ayarlar: %s\n' "$backup_dir"
fi
if ! command -v starship >/dev/null 2>&1; then
    printf 'Starship bulunamadı; kurulana kadar robbyrussell istemi kullanılacak.\n'
fi
