#!/bin/sh

set -eu

# Exit if rbw is in $PATH and works
command -v rbw >/dev/null 2>&1 && exit 0

# Get OS
if [ -r /etc/os-release ]; then
  . /etc/os-release
else
  echo "[RBW] Cannot detect OS"
  exit 1
fi

# Get user
USER_NAME="$(whoami)"

mayhaps_sudo() {
  case "$USER_NAME" in
  "root")
    "$@"
    ;;
  *)
    sudo "$@"
    ;;
  esac
}

install_arch() {
  mayhaps_sudo pacman -Fy
  mayhaps_sudo pacman -S --noconfirm rbw
}

install_ubuntu() {
  mayhaps_sudo apt update

  command -v curl >/dev/null 2>&1 || mayhaps_sudo apt install -y curl
  command -v minisign >/dev/null 2>&1 || mayhaps_sudo apt install -y minisign

  RBW_URL="https://git.tozt.net/rbw/releases/deb/"
  RBW_MINISIGN_PUBKEY="RWTM0AZ5RpROOfAIWx1HvYQ6pw1+FKwN6526UFTKNImP/Hz3ynCFst3r"

  latest_deb="$(curl -fsSL "$RBW_URL" |
    grep -oP 'href="rbw_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb"' |
    sed 's/^href="//;s/"$//' |
    sort -V |
    tail -1)"

  if [ -z "$latest_deb" ]; then
    echo "[RBW] No matching rbw .deb found."
    exit 1
  fi

  tmp_deb="/tmp/$latest_deb"
  tmp_sig="${tmp_deb}.minisig"

  trap 'rm -f "$tmp_deb" "$tmp_sig"' EXIT INT TERM

  curl -fsSL -o "$tmp_deb" "${RBW_URL}${latest_deb}"
  curl -fsSL -o "$tmp_sig" "${RBW_URL}${latest_deb}.minisig"

  minisign -P "$RBW_MINISIGN_PUBKEY" -V -m "$tmp_deb" -x "$tmp_sig"

  mayhaps_sudo apt install -y "$tmp_deb"
}

case "$ID" in
arch)
  install_arch
  ;;
ubuntu)
  install_ubuntu
  ;;
*)
  echo "[RBW] Unsupported distro: $ID"
  exit 1
  ;;
esac
