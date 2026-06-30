#!/usr/bin/env bash
# Rename this template to a new project.
# Run once after cloning — do NOT run a second time.

set -euo pipefail

OLD_ID="myplasmoid"
OLD_DOMAIN="de.agundur.myplasmoid"
OLD_NAME="KDE-Template"

echo ""
echo "=== KDE Plasmoid Template — rename ==="
echo ""

read -rp "Project ID       (e.g. 'mysensor', no spaces, lowercase): " NEW_ID
read -rp "Display name     (e.g. 'My Sensor'):                        " NEW_NAME
read -rp "Description      (one line):                                " NEW_DESC
read -rp "Author name:                                                 " AUTHOR_NAME
read -rp "Author email:                                                " AUTHOR_EMAIL
read -rp "GitHub user/org  (for URLs, e.g. 'Agundur-KDE'):           " GITHUB_ORG

echo ""

# Validate
if [[ ! "$NEW_ID" =~ ^[a-z][a-z0-9-]*$ ]]; then
    echo "ERROR: ID must be lowercase letters/digits/hyphens only." >&2
    exit 1
fi

NEW_DOMAIN="de.agundur.${NEW_ID}"
NEW_PLUGIN="${NEW_ID}plugin"
OLD_PLUGIN="${OLD_ID}plugin"
GITHUB_URL="https://github.com/${GITHUB_ORG}/${NEW_NAME// /-}"

echo "Will rename:"
echo "  ID:     $OLD_DOMAIN  →  $NEW_DOMAIN"
echo "  Name:   $OLD_NAME    →  $NEW_NAME"
echo "  Plugin: ${OLD_PLUGIN}  →  ${NEW_PLUGIN}"
echo ""
read -rp "Continue? [y/N] " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 0

# ── Replace in files ──────────────────────────────────────────────────────────

FILES=$(git ls-files | grep -E '\.(txt|json|qml|h|cpp|xml|md|sh|po|py)$')

for f in $FILES; do
    sed -i \
        -e "s|${OLD_DOMAIN}|${NEW_DOMAIN}|g" \
        -e "s|${OLD_PLUGIN}|${NEW_PLUGIN}|g" \
        -e "s|${OLD_ID}|${NEW_ID}|g" \
        -e "s|${OLD_NAME}|${NEW_NAME}|g" \
        "$f"
done

# ── Update metadata.json fields ───────────────────────────────────────────────

python3 - <<PYEOF
import json, pathlib

p = pathlib.Path("package/metadata.json")
m = json.loads(p.read_text())
m["KPlugin"]["Name"]         = "${NEW_NAME}"
m["KPlugin"]["Description"]  = "${NEW_DESC}"
m["KPlugin"]["Authors"]      = [{"Name": "${AUTHOR_NAME}", "Email": "${AUTHOR_EMAIL}"}]
m["KPlugin"]["Website"]      = "${GITHUB_URL}"
m["KPlugin"]["BugReportUrl"] = "${GITHUB_URL}/issues"
p.write_text(json.dumps(m, indent=4) + "\n")
PYEOF

# ── Rename .po files ──────────────────────────────────────────────────────────

find translate -name "plasma_applet_${OLD_DOMAIN}.po" | while read -r po; do
    new_po="${po/${OLD_DOMAIN}/${NEW_DOMAIN}}"
    mv "$po" "$new_po"
    # update the po header too
    sed -i "s|${OLD_DOMAIN}|${NEW_DOMAIN}|g" "$new_po"
done

echo ""
echo "Done. Next steps:"
echo "  1. git remote set-url origin <your-repo-url>"
echo "  2. mkdir build && cd build && cmake .. && make"
echo "  3. sudo make install"
echo "  4. plasmoidviewer -a ${NEW_DOMAIN}"
