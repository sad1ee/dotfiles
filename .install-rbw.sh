#!/bin/sh

set -e

# exit immediately if password-manager-binary is already in $PATH
type rbw >/dev/null 2>&1 && exit

if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

case "$ID" in
"arch")
  sudo pacman -S --noconfirm rbw
  ;;
"ubuntu")
  RBW_URL="https://git.tozt.net/rbw/releases/deb/"
  RBW_MINISIGN_PUBKEY="RWTM0AZ5RpROOfAIWx1HvYQ6pw1+FKwN6526UFTKNImP/Hz3ynCFst3r"

  sudo apt update
  sudo apt install -y curl minisign

  latest_deb=$(curl -s "$RBW_BASE_URL" |
    grep -oP 'href="rbw_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb"' |
    sed 's/^href="//;s/"$//' |
    sort -V |
    tail -1)

  if [ -z "$latest_deb" ]; then
    echo "Failed to find a .deb file in $BASE_URL"
    exit 1
  fi

  tmp_deb="/tmp/$latest_deb"
  tmp_sig="${tmp_deb}.minisig"

  curl -sL -o "$tmp_deb" "${RBW_BASE_URL}${latest_deb}"
  curl -sL -o "$tmp_sig" "${RBW_BASE_URL}${latest_deb}.minisig"

  minisign -p "$RBW_MINISIGN_PUBKEY" -V -m "$tmp_deb" -x "$tmp_sig" || {
    echo "Signature verification failed."
    exit 1
  }

  sudo dpkg -i "$tmp_deb"
  ;;
*)
  echo "Unsupported distro: $ID"
  exit 1
  ;;
esac
