import argparse
import datetime
import json
import os
import re
import shutil

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
UNLICENSED = "Unlicensed (no license stated)"
HOST_PREFIX = {"github": "gh", "gitlab": "gl", "codeberg": "cb"}
HOST_NAME = {"universe": "Typst Universe", "github": "GitHub", "gitlab": "GitLab", "codeberg": "Codeberg"}
CATEGORIES = {
    "thesis": "Theses & Reports",
    "report": "Theses & Reports",
    "book": "Theses & Reports",
    "paper": "Journals & Conferences",
    "cv": "CVs & Resumes",
    "slides": "Presentations",
    "poster": "Presentations",
    "letter": "Business",
    "homework": "Assignments",
    "notes": "Assignments",
    "other": "Community",
}
PACKS = {
    "thesis": ("Typst theses", "Thesis and dissertation templates for Typst"),
    "paper": ("Typst papers", "Paper and article templates for Typst"),
    "report": ("Typst reports", "Report templates for Typst"),
    "homework": ("Typst homework", "Homework and assignment templates for Typst"),
    "notes": ("Typst notes", "Lecture and study note templates for Typst"),
    "book": ("Typst books", "Book templates for Typst"),
    "slides": ("Typst slides", "Slide deck templates for Typst"),
    "poster": ("Typst posters", "Poster templates for Typst"),
    "cv": ("Typst CVs", "CV and resume templates for Typst"),
    "letter": ("Typst letters", "Letter and office templates for Typst"),
    "other": ("Typst community templates", "More Typst templates"),
}


def slug(text):
    return re.sub(r"-+", "-", re.sub(r"[^a-z0-9]+", "-", text.lower())).strip("-")


def template_id(entry):
    if entry["source"] == "universe":
        return f"tu-{slug(entry['name'])}"[:90]
    return f"{HOST_PREFIX[entry['source']]}-{slug(entry['name'])}"[:90]


def license_block(spdx, author, url):
    block = {"spdx": spdx, "author": author, "url": url}
    if not spdx:
        block["label"] = UNLICENSED
    return block


def universe_author(entry):
    path = os.path.expanduser(f"~/Library/Caches/typst/packages/preview/{entry['name']}/{entry['version']}/typst.toml")
    if not os.path.exists(path):
        return None
    match = re.search(r"authors\s*=\s*\[(.*?)\]", open(path).read(), re.S)
    if not match:
        return None
    names = [re.sub(r"\s*<[^>]*>", "", name).strip() for name in re.findall(r'"([^"]+)"', match.group(1))]
    return ", ".join(name for name in names if name) or None


def manifests(entry, result, order):
    kind = entry.get("kind") or "other"
    universe = entry["source"] == "universe"
    author = universe_author(entry) if universe else entry["name"].split("/")[0]
    credit = entry["credit_url"]
    name = entry["name"] if universe else entry["name"].split("/", 1)[1]
    manifest = {
        "id": template_id(entry),
        "name": name,
        "category": CATEGORIES.get(kind, "Community"),
        "description": entry.get("description") or "",
        "main_doc": result["main"],
        "engine": "typst",
        "license": license_block(entry.get("license"), author, credit),
        "requires": {"packages": [], "fonts": entry.get("font_packs", []), "engine": "typst"},
        "kind": kind,
        "languages": entry.get("languages", []),
        "order": order,
    }
    for key in ("country", "institution"):
        if entry.get(key):
            manifest[key] = entry[key]
    if universe:
        manifest["typst_universe"] = f"@preview/{entry['name']}:{entry['version']}"
    source = {
        "source": HOST_NAME[entry["source"]],
        "source_url": credit,
        "original_author": author,
        "license": entry.get("license") or UNLICENSED,
        "downloaded_at": datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    }
    if not universe:
        source["commit"] = entry["commit"]
        source["main_file"] = result["main"]
    else:
        source["package"] = f"@preview/{entry['name']}:{entry['version']}"
    return manifest, source


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--staging", required=True)
    parser.add_argument("--results", required=True)
    args = parser.parse_args()
    index = json.load(open(os.path.join(ROOT, "typst", "index.json")))
    results = {}
    for line in open(args.results):
        if line.strip():
            row = json.loads(line)
            results[row["id"]] = row
    for pack in PACKS:
        shutil.rmtree(os.path.join(ROOT, "packs", f"typst-{pack}"), ignore_errors=True)
    placed, skipped, seen, hosted = 0, 0, set(), {}
    for order, entry in enumerate(index["entries"]):
        result = results.get(entry["id"])
        staged = os.path.join(args.staging, entry["id"].replace(":", "-").replace("/", "-"))
        if not result or not result.get("ok") or not os.path.isdir(staged):
            skipped += 1
            continue
        manifest, source = manifests(entry, result, order)
        if manifest["id"] in seen:
            manifest["id"] = f"{manifest['id']}-{order}"
        seen.add(manifest["id"])
        target = os.path.join(ROOT, "packs", f"typst-{manifest['kind']}", manifest["id"])
        shutil.copytree(staged, target)
        open(os.path.join(target, "template.json"), "w").write(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
        open(os.path.join(target, "SOURCE.json"), "w").write(json.dumps(source, ensure_ascii=False, indent=2) + "\n")
        hosted[entry["id"]] = {"pack": f"typst-{manifest['kind']}", "template": manifest["id"], "main_doc": manifest["main_doc"]}
        placed += 1
    open(os.path.join(ROOT, "typst", "hosted.json"), "w").write(json.dumps(hosted, ensure_ascii=False, indent=1) + "\n")
    meta_path = os.path.join(ROOT, "tools", "directory-packs.json")
    meta = json.load(open(meta_path)) if os.path.exists(meta_path) else {}
    for kind, (label, description) in PACKS.items():
        meta[f"typst-{kind}"] = {
            "label": label,
            "description": f"{description} from Typst Universe and public repositories, each checked to compile with Typst {index['checked_compiler']}.",
            "category": CATEGORIES[kind],
            "group": "typst",
        }
    open(meta_path, "w").write(json.dumps(meta, ensure_ascii=False, indent=2) + "\n")
    print(f"placed {placed} templates, skipped {skipped}")


if __name__ == "__main__":
    main()
