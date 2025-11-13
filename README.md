# Dotfiles Configuration

## Main .zshrc Configuration

Copy this entire content to `~/.zshrc`:

```zsh
# ===== CONFIGURACIÓN BÁSICA DE OH MY ZSH =====

# Path para Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema de Oh My Zsh
ZSH_THEME="fino"

# Plugins de Oh My Zsh
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    macos
    brew
    node
    npm
)

# Cargar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ===== CONFIGURACIÓN DE PATH Y VARIABLES DE ENTORNO =====

# Homebrew (gestor de paquetes)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Android SDK (configuración unificada)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# Toolbox de JetBrains
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# PNPM (gestor de paquetes Node.js)
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Flutter
export PATH="$HOME/develop/flutter/bin:$PATH"

# OpenJDK (Java)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Console Ninja
export PATH="$HOME/.console-ninja/.bin:$PATH"

# ===== CONFIGURACIÓN DE NVM =====

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carga nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carga autocompletado de nvm

# ===== CONFIGURACIÓN DE RBENV =====

# Ruby Version Manager
eval "$(rbenv init -)"

# ===== CONFIGURACIÓN DE CONDA/MINIFORGE =====

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ===== CONFIGURACIONES ESPECÍFICAS PARA macOS =====

# --- OpenMP (libomp) fix para PyTorch/torchvision en macOS ---
# Detecta si es Apple Silicon (arm64) o Intel y setea la ruta adecuada.
if [[ "$(uname -m)" == "arm64" ]]; then
  # Apple Silicon (M1/M2/M3/M4)
  if [ -d "/opt/homebrew/opt/libomp/lib" ]; then
    export DYLD_LIBRARY_PATH="/opt/homebrew/opt/libomp/lib:${DYLD_LIBRARY_PATH}"
  fi
else
  # Intel
  if [ -d "/usr/local/opt/libomp/lib" ]; then
    export DYLD_LIBRARY_PATH="/usr/local/opt/libomp/lib:${DYLD_LIBRARY_PATH}"
  fi
fi

# (Opcional) Evitar variables de workaround inseguras:
unset KMP_DUPLICATE_LIB_OK 2>/dev/null || true
# --- fin OpenMP fix ---

# ===== ALIASES Y FUNCIONES ÚTILES =====

# Navegación
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# Listados
alias ll="ls -la"
alias la="ls -A"
alias l="ls -CF"
alias ls="ls -G"  # Colorized output

# LSD con iconos (si está instalado)
if command -v lsd &> /dev/null; then
    alias ls="lsd"
    alias ll="lsd -la"
    alias la="lsd -A"
    alias l="lsd -l"
    alias lt="lsd --tree"
fi

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# Desarollo
alias pn="pnpm"
alias nr="npm run"
alias ni="npm install"
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrb="npm run build"

# Sistema
alias zshrc="code ~/.zshrc"
alias szsh="source ~/.zshrc"
alias brews="brew list"
alias update-all="brew update && brew upgrade && brew cleanup"

# Seguridad para rm
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ===== CONFIGURACIONES ADICIONALES =====

# Variables de entorno locales
if [ -f "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env"
fi

# Configuración de history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Mejorar autocompletado
autoload -Uz compinit && compinit

# Configuración de tiempo de ZSH
export UPDATE_ZSH_DAYS=7

# Habilitar corrección de comandos
ENABLE_CORRECTION="true"

# Mostrar red dots mientras se espera completado
COMPLETION_WAITING_DOTS="true"

# Deshabilitar marcar archivos no rastreados como sucios (mejora performance en repos grandes)
DISABLE_UNTRACKED_FILES_DIRTY="true"
```

## Installation Scripts

### Install ZSH Plugins

```bash
#!/bin/bash
echo "Installing ZSH plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi
if [ ! -f "$ZSH_CUSTOM/themes/fino.zsh-theme" ]; then
    curl -fSL "https://raw.githubusercontent.com/zsh-users/zsh-themes/master/themes/fino.zsh-theme" -o "$ZSH_CUSTOM/themes/fino.zsh-theme"
fi
echo "Plugins installed! Run: source ~/.zshrc"
```

### Dependency Checker

```bash
#!/bin/bash
echo "Checking dependencies..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "OK - Oh My Zsh"
else
    echo "MISSING - Oh My Zsh - Run: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
fi
if command -v brew &> /dev/null; then
    echo "OK - Homebrew"
else
    echo "MISSING - Homebrew - Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
fi
if [ -d "$HOME/.nvm" ]; then
    echo "OK - NVM"
else
    echo "MISSING - NVM - Run: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
fi
if command -v rbenv &> /dev/null; then
    echo "OK - rbenv"
else
    echo "OPTIONAL - rbenv - Install: brew install rbenv ruby-build"
fi#!/bin/bash
echo "Checking dependencies..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "OK - Oh My Zsh"
else
    echo "MISSING - Oh My Zsh - Run: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
fi
if command -v brew &> /dev/null; then
    echo "OK - Homebrew"
else
    echo "MISSING - Homebrew - Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
fi
if [ -d "$HOME/.nvm" ]; then
    echo "OK - NVM"
else
    echo "MISSING - NVM - Run: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
fi
if command -v rbenv &> /dev/null; then
    echo "OK - rbenv"
else
    echo "OPTIONAL - rbenv - Install: brew install rbenv ruby-build"
fi
```

### Quick Install Commands

```bash
# Install core components
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install additional tools
brew install rbenv ruby-build
```

## Included Tools

- **Shell**: ZSH + Oh My Zsh with fino theme
- **Package Managers**: Homebrew, PNPM, NPM
- **Version Managers**: NVM (Node), rbenv (Ruby)
- **Mobile Development**: Android SDK (adb, fastboot, emulator)
- **IDEs**: JetBrains Toolbox
- **Languages**: Node.js, Ruby, Java, Python (Conda)
- **Utilities**: Console Ninja, useful aliases

## Quick Start

1. Copy the .zshrc to your home directory
2. Run the plugin installer script
3. Verify dependencies with the checker script
4. Reload configuration: source ~/.zshrc

## Maintenance

- Update plugins: upgrade_oh_my_zsh
- Update Homebrew: brew update && brew upgrade
- Update NVM: nvm install --lts --latest-npm

**Maintainer**: @macrohex

**Compatibility**: macOS (Apple Silicon & Intel)

**Shell**: ZSH with Oh My Zsh