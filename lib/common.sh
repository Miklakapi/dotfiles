#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}

is_ubuntu() {
    [[ -f /etc/os-release ]] && grep -q '^ID=ubuntu$' /etc/os-release
}

install_package() {
    local package="$1"

    install_packages "$package"
}

install_packages() {
    if command_exists brew; then
        install_brew_packages "$@"
        return
    fi

    if command_exists apt; then
        install_apt_packages "$@"
        return
    fi

    echo "Could not install packages. Missing supported package manager: brew or apt"
    exit 1
}

install_brew_packages() {
    local packages=()

    packages=("$@")

    if [[ "${#packages[@]}" -eq 0 ]]; then
        return
    fi

    brew install "${packages[@]}"
}

install_apt_packages() {
    local packages=()

    packages=("$@")

    if [[ "${#packages[@]}" -eq 0 ]]; then
        return
    fi

    sudo apt update
    sudo apt install -y "${packages[@]}"
}

has_zsh_block() {
    local name="$1"
    local zshrc="$HOME/.zshrc"
    local start_marker="# dotfiles $name start"

    if [[ ! -f "$zshrc" ]]; then
        return 1
    fi

    grep -Fxq "$start_marker" "$zshrc"
}

append_zsh_block() {
    local name="$1"
    local zshrc="$HOME/.zshrc"
    local start_marker="# dotfiles $name start"
    local end_marker="# dotfiles $name end"
    local temp_file=""
    local block_file=""

    touch "$zshrc"

    temp_file="$(mktemp)"
    block_file="$(mktemp)"

    {
        echo "$start_marker"
        cat
        echo "$end_marker"
    } > "$block_file"

    if has_zsh_block "$name"; then
        awk -v start_marker="$start_marker" -v end_marker="$end_marker" -v block_file="$block_file" '
            $0 == start_marker {
                while ((getline line < block_file) > 0) {
                    print line
                }

                in_block = 1
                next
            }

            $0 == end_marker {
                in_block = 0
                next
            }

            !in_block {
                print
            }
        ' "$zshrc" > "$temp_file"

        cat "$temp_file" > "$zshrc"
        rm -f "$temp_file" "$block_file"

        echo "$name updated"
        return
    fi

    {
        echo ""
        cat "$block_file"
    } >> "$zshrc"

    rm -f "$temp_file" "$block_file"

    echo "$name configured"
}

remove_zsh_block() {
    local name="$1"
    local zshrc="$HOME/.zshrc"
    local start_marker="# dotfiles $name start"
    local end_marker="# dotfiles $name end"

    if [[ ! -f "$zshrc" ]]; then
        return
    fi

    sed -i.bak "/^$start_marker$/,/^$end_marker$/d" "$zshrc"
}

remove_zsh_line() {
    local line="$1"
    local zshrc="$HOME/.zshrc"
    local temp_file=""

    if [[ ! -f "$zshrc" ]]; then
        return
    fi

    temp_file="$(mktemp)"

    grep -Fxv "$line" "$zshrc" > "$temp_file" || true

    cat "$temp_file" > "$zshrc"
    rm -f "$temp_file"
}
