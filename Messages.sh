#!/usr/bin/env bash
# Extracts translatable strings (i18n/i18nc/i18np/i18ncp calls in the QML)
# into translate/template.pot, then merges that into each existing
# translate/<lang>/*.po file so translators get the new/changed strings.
#
# Run this after adding or changing any i18n*() call in the QML, before
# translators start working on the .po files.
set -euo pipefail

cd "$(dirname "$0")"

PROJECT_ID="de.agundur.myplasmoid"
POT="translate/template.pot"

xgettext \
    --language=C \
    --from-code=UTF-8 \
    --qt \
    --keyword=i18n \
    --keyword=i18nc:1c,2 \
    --keyword=i18np:1,2 \
    --keyword=i18ncp:1c,2,3 \
    --package-name="$PROJECT_ID" \
    --copyright-holder="Agundur" \
    --output="$POT" \
    $(find package/contents -name '*.qml')

for po in translate/*/plasma_applet_${PROJECT_ID}.po; do
    [ -f "$po" ] || continue
    msgmerge --update --backup=none "$po" "$POT"
    echo "Updated $po"
done

echo "Done. $POT and the .po files above are up to date with the current QML."
