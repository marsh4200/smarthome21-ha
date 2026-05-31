#!/usr/bin/env bash
#
# Smart Home 21 - dashboard deploy/update helper
# Clones the repo on first run, pulls on later runs, then copies the dashboard
# (and room images) into place under /config.
#
# Usage:  bash update.sh
# After running: Developer Tools -> YAML -> Reload Dashboards
#
set -euo pipefail

REPO_URL="https://github.com/marsh4200/smarthome21-ha.git"
REPO_DIR="/config/smarthome21-ha"
CONFIG_DIR="/config"

echo "==> Smart Home 21 dashboard update"

# Clone on first run, pull on subsequent runs
if [ -d "${REPO_DIR}/.git" ]; then
  echo "==> Repo exists, pulling latest..."
  git -C "${REPO_DIR}" pull --ff-only
else
  echo "==> Cloning repo..."
  git clone "${REPO_URL}" "${REPO_DIR}"
fi

# Ensure target folders exist
mkdir -p "${CONFIG_DIR}/dashboards" "${CONFIG_DIR}/www/smarthome21/rooms"

# Copy dashboard
echo "==> Copying dashboard..."
cp "${REPO_DIR}/dashboards/smarthome21.yaml" "${CONFIG_DIR}/dashboards/smarthome21.yaml"

# Copy room images if any are present in the repo
if compgen -G "${REPO_DIR}/www/smarthome21/rooms/*" > /dev/null; then
  echo "==> Copying room images..."
  cp -r "${REPO_DIR}/www/smarthome21/rooms/." "${CONFIG_DIR}/www/smarthome21/rooms/"
fi

echo "==> Done. Now: Developer Tools -> YAML -> Reload Dashboards"
