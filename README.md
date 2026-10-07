# mac-dev-setup

Ansible playbook that turns a fresh Mac into a web + Go development machine.

## Run it

```bash
cd mac-dev-setup
./bootstrap.sh
```

`bootstrap.sh` installs Homebrew (and the Xcode Command Line Tools), Ansible and the
`community.general` collection, then runs `main.yml`. It's safe to re-run any time.

Run just one part with tags: `./bootstrap.sh --tags node,go`
(tags: `homebrew`, `git`, `shell`, `iterm`, `python`, `node`, `go`, `macos`).
Preview without changing anything: `./bootstrap.sh --check`.

## Customise

Everything lives in `vars/config.yml`: git name/email, Homebrew packages and apps,
Oh My Zsh theme/plugins, Python version, Node versions, global npm packages, Go tools,
and whether to apply macOS preferences. Put your own shell tweaks in `~/.zshrc.local`
(the playbook manages `~/.zshrc` and backs up whatever was there before).

## What you get

| Area | Tools |
|---|---|
| Shell | Oh My Zsh, zsh-autosuggestions, zsh-syntax-highlighting, fzf, direnv, eza, bat, ripgrep, fd, jq/yq, tmux |
| Terminal | iTerm2 with a default "Dev" profile (JetBrains Mono Nerd Font, unlimited scrollback, Option as Meta) |
| Python | pyenv (latest 3.14.x as global), uv, ruff, pre-commit, ipython |
| Node | nvm (latest release), Node LTS as default, pnpm, TypeScript, npm-check-updates |
| Go | go, gopls, delve, goimports, gofumpt, staticcheck, govulncheck, golangci-lint, air |
| Infra | OpenTofu (`tf` alias), tflint |
| Containers | Colima + Docker CLI, compose, buildx |
| Web | PostgreSQL 17, Redis, mkcert, httpie, Bruno, VS Code, Chrome, Firefox |
| Git/SSH | gh, sensible git defaults, global gitignore, ed25519 key in the macOS keychain |
| macOS | Fast key repeat, no smart quotes/dashes, Finder shows dotfiles & extensions, screenshots to ~/Screenshots |

## After the first run

1. Open iTerm2 (or `exec zsh`).
2. `gh auth login` — sign in to GitHub; it can upload your new SSH key for you.
3. `colima start` — starts the Docker runtime (`docker run hello-world` to test).
4. `brew services start postgresql@17` / `brew services start redis` when you need them.
5. `mkcert -install` — once, for trusted local HTTPS certs (asks for your password).
# mac-dev-setup
