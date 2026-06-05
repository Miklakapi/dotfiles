# dotfiles

Personal setup scripts for macOS and Ubuntu.

## Install

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

Run everything:

```bash
./run
```

Run selected setup:

```bash
./run zsh
./run git
./run node
./run python
./run golang
./run fonts
./run nvim
./run bin
./run docker
./run tmux
./run core
```

Dry run:

```bash
./run --dry
./run nvim --dry
```

## Commands

Custom commands are stored in:

```text
bin/
```

After running:

```bash
./run bin
```

they are available from anywhere, for example:

```bash
kill-port 3000
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
