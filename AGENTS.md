# Repository Guidelines

## Project Structure & Module Organization

This repository stores personal dotfiles and a small installer. `install.sh` is the entry point; it symlinks tracked files into `$HOME` and backs up any existing target first. Files in `home/` map directly to home-directory dotfiles, such as `home/.npmrc` -> `$HOME/.npmrc`. Files in `config/` map to XDG application config paths, such as `config/ghostty/config` -> `$HOME/.config/ghostty/config` and `config/Code/User/settings.json` -> VS Code user settings.

## Build, Test, and Development Commands

There is no build step. Use these checks before committing:

```sh
bash -n install.sh
```

Validates installer shell syntax without running it.

```sh
./install.sh
```

Installs the dotfiles by creating symlinks. Existing files are moved under `$HOME/.dotfiles-backup/<timestamp>/`.

```sh
git status --short
```

Confirms the exact files staged or modified before a commit.

## Coding Style & Naming Conventions

Shell scripts should use Bash with `set -euo pipefail`, quote variable expansions, and prefer small helper functions for repeated filesystem behavior. Keep symlink mappings explicit in `install.sh` so installation remains easy to audit. JSON files should remain valid JSON with two-space indentation where practical. Config filenames should match their target names exactly, especially under `home/`.

## Testing Guidelines

No automated test suite is present. For installer changes, run `bash -n install.sh`, then test `./install.sh` in a disposable or known-safe environment when changing link targets or backup behavior. For editor and terminal configs, validate by launching the relevant application after installation. Avoid committing generated caches, logs, local environment files, or machine-specific secrets; `.gitignore` already excludes common local artifacts.

## Commit & Pull Request Guidelines

The current history uses Conventional Commit style, for example `chore: initial`. Continue with short, imperative subjects such as `chore: add ghostty config` or `fix: quote install paths`. Pull requests should describe which dotfiles changed, why the change is needed, and any manual verification performed. Include screenshots only for visible UI changes, such as terminal or editor appearance updates.

## Agent-Specific Instructions

Do not overwrite user-local files directly. Update tracked files in this repository and rely on `install.sh` for installation. Preserve unrelated local modifications, and keep new mappings in `install.sh` paired with the corresponding tracked file path.
