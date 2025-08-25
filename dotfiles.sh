#!/usr/bin/env bash

# Collect all non-hidden directories, excluding `.git`
PACKAGES=()
while IFS= read -r dir; do
  PACKAGES+=("$dir")
done < <(find . -maxdepth 1 -type d ! -name '.' ! -name '.git' -exec basename {} \;)

TARGET="$HOME"
OPTIONS="--no-folding"

echo "Choose action for all packages:"
echo "  [s] Stow all"
echo "  [u] Unstow all"
echo "  [i] Ask for each"
read -rp "Your choice: " mode

# Convert to lowercase
mode="${mode,,}"

# Apply global action if selected
if [[ "$mode" == "s" ]]; then
  for pkg in "${PACKAGES[@]}"; do
    echo "→ Stowing $pkg..."
    stow -t "$TARGET" $OPTIONS -R "$pkg"
  done
  exit 0
elif [[ "$mode" == "u" ]]; then
  for pkg in "${PACKAGES[@]}"; do
    echo "→ Unstowing $pkg..."
    stow -t "$TARGET" $OPTIONS -D "$pkg"
  done
  exit 0
elif [[ "$mode" != "i" ]]; then
  echo "Invalid choice. Exiting."
  exit 1
fi

# Per-package prompt mode
skip_all=false
for pkg in "${PACKAGES[@]}"; do
  if [ "$skip_all" = true ]; then
    echo "→ Skipped $pkg (skip all active)."
    continue
  fi

  echo ""
  echo "Package: $pkg"
  read -rp "Action? [s]tow / [u]nstow / [s]kip / [k]skip all: " action
  action="${action,,}"

  case "$action" in
    s)
      echo "→ Stowing $pkg..."
      stow -t "$TARGET" $OPTIONS -R "$pkg"
      ;;
    u)
      echo "→ Unstowing $pkg..."
      stow -t "$TARGET" $OPTIONS -D "$pkg"
      ;;
    k)
      echo "→ Skipping all remaining packages."
      skip_all=true
      ;;
    *)
      echo "→ Skipped $pkg."
      ;;
  esac
done
