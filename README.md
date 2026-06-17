# dotfiles

Personal setup scripts for macOS and Debian/Ubuntu-based systems.

## Installation

Clone the repository.

For most users, HTTPS is the recommended option:

```bash
git clone https://github.com/Miklakapi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

If you already have GitHub SSH access configured, you can use SSH instead:

```bash
git clone git@github.com:Miklakapi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Setup scripts

Run all setup scripts:

```bash
./run
```

This runs all executable scripts from the `runs/` directory in alphabetical order:

```text
bin core docker fonts git golang node nvim python tmux zsh
```

Run only one setup script:

```bash
./run core
./run nvim
./run tmux
```

Available setup scripts:

```text
bin      Adds custom dotfiles commands from bin/ to PATH in ~/.zshrc and installs lsof if needed.
core     Installs common CLI tools used by the rest of the setup.
docker   Installs Docker on Ubuntu using the official Docker repository and adds the current user to the docker group.
fonts    Installs JetBrains Mono Nerd Font using Homebrew on macOS or downloads it manually on Linux.
git      Installs Git, applies global Git defaults, asks for missing user details, and optionally configures repo-clone environment variables.
golang   Installs Go using Homebrew on macOS or the official Go tarball on Ubuntu, then adds Go paths to ~/.zshrc.
node     Removes old nvm configuration, installs fnm, configures it in ~/.zshrc, and installs the latest Node.js version.
nvim     Installs Neovim dependencies, downloads Neovim on Ubuntu, clones or updates the Neovim config, and adds vim=nvim alias to ~/.zshrc.
python   Installs uv, installs a Python version through uv, and configures uv shell integration in ~/.zshrc.
tmux     Installs tmux and clipboard support, copies the tmux config, and optionally configures tmux project directories in ~/.zshrc.
zsh      Installs Zsh, sets it as the default shell on Linux, and configures prompt, colors, aliases, and completion in ~/.zshrc.
```

Preview what would be executed without running the scripts:

```bash
./run --dry
./run nvim --dry
```

## Test Ubuntu setup

Build test image:

```bash
docker build -f tests/ubuntu.Dockerfile -t dotfiles-ubuntu .
```

Run test container:

```bash
docker run --rm -it dotfiles-ubuntu
```

Remove test image:

```bash
docker rmi dotfiles-ubuntu
```
