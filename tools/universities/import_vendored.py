import argparse
import datetime
import json
import os
import shutil

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
UNLICENSED = "Unlicensed (no license stated)"
COUNTRIES = {
    "AT": "Austria",
    "CH": "Switzerland",
    "CN": "China",
    "CZ": "the Czech Republic",
    "DE": "Germany",
    "GB": "the UK",
    "HK": "Hong Kong",
    "IE": "Ireland",
    "JP": "Japan",
    "KR": "Korea",
    "MO": "Macau",
    "SK": "Slovakia",
    "TW": "Taiwan",
}
KIND_CATEGORY = {
    "thesis": "Theses & Reports",
    "report": "Theses & Reports",
    "lab-report": "Theses & Reports",
    "proposal": "Theses & Reports",
    "assignment": "Assignments",
}


def host_name(url):
    host = url.split("/")[2].lower()
    if host == "github.com":
        return "GitHub"
    if host == "gitlab.com" or host.startswith("gitlab."):
        return "GitLab"
    if "overleaf" in host:
        return "Template gallery"
    return host


def manifests(entry, result, order):
    university = entry["university"]
    local = entry.get("university_local")
    name = university if not local or local == university else f"{university} ({local})"
    kind = entry.get("kind") or "thesis"
    faculty = entry.get("faculty")
    description = " · ".join(part for part in [kind.replace("-", " ").capitalize(), faculty, ", ".join(entry.get("degrees") or [])] if part)
    main = result.get("main") or entry["main_file"]
    builtin = entry["compiles"] == "builtin"
    if entry["format"] == "typst":
        engine, requires = "typst", {"packages": [], "fonts": [], "engine": "typst"}
    elif builtin:
        engine, requires = "xetex", {"packages": [], "fonts": [], "engine": "tectonic"}
    else:
        engine, requires = "latexmk", {"packages": [], "fonts": [], "engine": "latexmk", "tex_flavor": entry["engine"]}
    author = entry["credit_url"].rstrip("/").split("/")[3] if host_name(entry["credit_url"]) in ("GitHub", "GitLab") else None
    manifest = {
        "id": result["template"],
        "name": name,
        "category": KIND_CATEGORY.get(kind, "Theses & Reports"),
        "description": description,
        "main_doc": main,
        "engine": engine,
        "license": {"spdx": entry.get("license"), "author": author, "url": entry["credit_url"]},
        "requires": requires,
        "kind": kind,
        "country": entry["country"],
        "institution": university,
        "order": order,
    }
    if not entry.get("license"):
        manifest["license"]["label"] = UNLICENSED
    if entry.get("official") is True:
        manifest["official"] = True
    source = {
        "source": host_name(entry["credit_url"]),
        "source_url": entry["credit_url"],
        "original_author": author,
        "license": entry.get("license") or UNLICENSED,
        "downloaded_at": datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "main_file": main,
    }
    if result.get("commit") and result["commit"] != "gallery":
        source["commit"] = result["commit"]
    return manifest, source


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--staging", required=True)
    parser.add_argument("--results", required=True)
    parser.add_argument("--input", required=True)
    args = parser.parse_args()
    inputs = {}
    for line in open(args.input):
        if line.strip():
            row = json.loads(line)
            inputs[row["id"]] = row
    inventory = {}
    for path in sorted(os.listdir(os.path.join(ROOT, "universities", "inventory"))):
        for line in open(os.path.join(ROOT, "universities", "inventory", path)):
            if line.strip():
                row = json.loads(line)
                inventory.setdefault(row.get("repo"), []).append(row)
    index = {entry["id"]: entry for entry in json.load(open(os.path.join(ROOT, "universities", "index.json")))["entries"]}
    for pack in os.listdir(os.path.join(ROOT, "packs")):
        if pack.startswith("university-"):
            shutil.rmtree(os.path.join(ROOT, "packs", pack))
    hosted, placed, skipped, countries = {}, 0, 0, set()
    for order, line in enumerate(open(args.results)):
        result = json.loads(line)
        staged = os.path.join(args.staging, result.get("template", ""))
        if not result.get("ok") or not os.path.isdir(staged):
            skipped += 1
            continue
        source_row = inputs[result["id"]]
        entry = index.get(result["id"])
        if entry is None:
            record = next(iter(inventory.get(source_row["repo"], [])), {})
            entry = {
                "id": result["id"],
                "country": source_row["country"],
                "university": record.get("university") or source_row["country"],
                "university_local": record.get("university_local"),
                "faculty": record.get("faculty"),
                "kind": record.get("kind") or "thesis",
                "degrees": record.get("degrees") or [],
                "format": "latex",
                "engine": source_row["engine"],
                "compiles": "builtin",
                "credit_url": source_row["repo"],
                "main_file": result.get("main") or source_row["main_file"],
                "license": None if record.get("license_spdx") in (None, "NOASSERTION", "OTHER") else record.get("license_spdx"),
                "official": record.get("official") == "yes" or None,
            }
        manifest, source = manifests(entry, result, order)
        pack = f"university-{entry['country'].lower()}"
        target = os.path.join(ROOT, "packs", pack, manifest["id"])
        if not os.path.exists(target):
            shutil.copytree(staged, target)
            open(os.path.join(target, "template.json"), "w").write(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
            open(os.path.join(target, "SOURCE.json"), "w").write(json.dumps(source, ensure_ascii=False, indent=2) + "\n")
            placed += 1
        hosted[result["id"]] = {
            "pack": pack,
            "template": manifest["id"],
            "main_doc": manifest["main_doc"],
            "compiles": entry["compiles"],
            "engine": entry["engine"],
        }
        countries.add(entry["country"])
    open(os.path.join(ROOT, "universities", "hosted.json"), "w").write(json.dumps(hosted, ensure_ascii=False, indent=1) + "\n")
    meta_path = os.path.join(ROOT, "tools", "directory-packs.json")
    meta = json.load(open(meta_path))
    for key in [key for key in meta if key.startswith("university-")]:
        del meta[key]
    for code in sorted(countries):
        country = COUNTRIES.get(code, code)
        meta[f"university-{code.lower()}"] = {
            "label": f"University templates: {country[4:] if country.startswith('the ') else country}",
            "description": f"Thesis and report templates from universities in {country}, each checked to compile.",
            "category": "Theses & Reports",
            "group": "university",
        }
    open(meta_path, "w").write(json.dumps(meta, ensure_ascii=False, indent=2) + "\n")
    print(f"placed {placed} university templates in {len(countries)} packs for {len(hosted)} directory entries, skipped {skipped}")


if __name__ == "__main__":
    main()
