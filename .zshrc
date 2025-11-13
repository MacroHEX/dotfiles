# Path para Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema de Oh My Zsh
ZSH_THEME="robbyrussell"

# Plugins de Oh My Zsh
plugins=(git)

# Cargar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ===== CONFIGURACIÓN DE PATH =====

# Homebrew (gestor de paquetes)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Android SDK
export PATH="$PATH:/Users/macrohex/Library/Android/sdk/platform-tools"

# Toolbox de JetBrains
export PATH="$PATH:/Users/macrohex/Library/Application Support/JetBrains/Toolbox/scripts"

# PNPM (gestor de paquetes Node.js)
export PNPM_HOME="/Users/macrohex/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# OpenJDK (Java)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ===== CONFIGURACIÓN DE NVM =====

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carga nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carga autocompletado de nvm