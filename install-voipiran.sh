#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================================
# VOIPIRAN - Issabel Call Center Installer
# ============================================================

REPO_URL="https://github.com/YOUR-GITHUB-USERNAME/callcenter-issabel5.git"
REPO_DIR="/usr/src/callcenter-issabel5"
INSTALLER="build/5.0/install-issabel-callcenter.sh"

# ------------------------------------------------------------
# Check root privileges
# ------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "[ERROR] Please run this script as root."
    exit 1
fi

# ------------------------------------------------------------
# Check dependencies
# ------------------------------------------------------------

for cmd in git bash; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "[ERROR] Required command not found: $cmd"
        exit 1
    fi
done

# ------------------------------------------------------------
# Configure repository
# ------------------------------------------------------------

if [[ "$REPO_URL" == *"YOUR-GITHUB-USERNAME"* ]]; then
    echo "[ERROR] Configure REPO_URL with your actual GitHub username."
    exit 1
fi

echo
echo "============================================================"
echo "       VOIPIRAN - Issabel Call Center Installer"
echo "============================================================"
echo

# ------------------------------------------------------------
# Clone or update repository
# ------------------------------------------------------------

if [[ -d "$REPO_DIR/.git" ]]; then
    echo "[INFO] Repository already exists: $REPO_DIR"
    echo "[INFO] Using the existing repository."
else
    if [[ -e "$REPO_DIR" ]]; then
        echo "[ERROR] $REPO_DIR exists but is not a Git repository."
        echo "[ERROR] Please inspect it manually."
        exit 1
    fi

    echo "[INFO] Cloning VOIPIRAN Call Center repository..."

    git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

# ------------------------------------------------------------
# Verify installer
# ------------------------------------------------------------

if [[ ! -f "$INSTALLER" ]]; then
    echo "[ERROR] Call Center installer not found:"
    echo "        $REPO_DIR/$INSTALLER"
    exit 1
fi

# ------------------------------------------------------------
# Run original installer using the local repository
# ------------------------------------------------------------

echo
echo "[INFO] Starting Issabel Call Center installation..."
echo "[INFO] Using the local repository (-l)."
echo

bash "$INSTALLER" -l

# ------------------------------------------------------------
# Verify service
# ------------------------------------------------------------

echo
echo "[INFO] Checking issabeldialer service..."

if systemctl is-active --quiet issabeldialer; then
    echo "[SUCCESS] issabeldialer is running."
else
    echo "[WARNING] issabeldialer is not running."
    echo "[INFO] Check the service using:"
    echo "        systemctl status issabeldialer"
fi

echo
echo "============================================================"
echo "[SUCCESS] VOIPIRAN Call Center installation process finished."
echo "============================================================"
echo