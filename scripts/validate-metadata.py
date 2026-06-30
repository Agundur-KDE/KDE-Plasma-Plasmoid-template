#!/usr/bin/env python3
"""Validates package/metadata.json for Plasma 6 compliance."""

import json
import re
import sys

REQUIRED = [
    ("KPackageStructure",),
    ("KPlugin", "Id"),
    ("KPlugin", "Name"),
    ("KPlugin", "Description"),
    ("KPlugin", "Version"),
    ("KPlugin", "License"),
    ("X-Plasma-API-Minimum-Version",),
]

DEPRECATED = [
    "X-Plasma-API",
    "X-Plasma-MainScript",
    "X-KDE-PluginInfo-Name",
]

ID_RE = re.compile(r'^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*){2,}$')
URL_RE = re.compile(r'^https?://')


def get_nested(data, *keys):
    for k in keys:
        if not isinstance(data, dict) or k not in data:
            return None
        data = data[k]
    return data


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "package/metadata.json"
    errors = []
    warnings = []

    try:
        with open(path) as f:
            meta = json.load(f)
    except (OSError, json.JSONDecodeError) as e:
        print(f"FAIL  cannot read {path}: {e}")
        sys.exit(1)

    for keys in REQUIRED:
        if get_nested(meta, *keys) is None:
            errors.append(f"missing required field: {' > '.join(keys)}")

    for key in DEPRECATED:
        if key in meta:
            errors.append(f"deprecated key present: {key}")

    plugin_id = get_nested(meta, "KPlugin", "Id")
    if plugin_id and not ID_RE.match(plugin_id):
        errors.append(f"KPlugin.Id '{plugin_id}' is not reverse-domain format (e.g. de.example.myapplet)")

    for url_key in ("Website", "BugReportUrl"):
        val = get_nested(meta, "KPlugin", url_key)
        if val and not URL_RE.match(val):
            warnings.append(f"KPlugin.{url_key} looks like an email or invalid URL: '{val}'")

    api_ver = get_nested(meta, "X-Plasma-API-Minimum-Version")
    if api_ver and not str(api_ver).startswith("6"):
        warnings.append(f"X-Plasma-API-Minimum-Version is '{api_ver}', expected 6.x for Plasma 6")

    for w in warnings:
        print(f"WARN  {w}")
    for e in errors:
        print(f"FAIL  {e}")

    if not errors and not warnings:
        print(f"OK    {path}")

    sys.exit(1 if errors else 0)


if __name__ == "__main__":
    main()
