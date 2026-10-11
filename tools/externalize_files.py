import argparse
import concurrent.futures as cf
import hashlib
import json
import os
import shutil
import subprocess
import tempfile

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
MIRROR = "https://mirrors.oleafly.com/template-files"
FONT_EXTENSIONS = (".ttf", ".otf", ".ttc", ".otc")
KEEP = {"template.json", "SOURCE.json"}
LIMIT = 256 * 1024


def covered_families():
    names = set()
    for pack in json.load(open(os.path.join(ROOT, "typst", "font-packs.json"))):
        for file in pack["files"]:
            names.update(name.lower() for name in file["families"])
    return names


COVERED = covered_families()


def primary_family(path):
    try:
        from fontTools.ttLib import TTCollection, TTFont
        fonts = TTCollection(path).fonts if path.lower().endswith((".ttc", ".otc")) else [TTFont(path, lazy=True)]
        families = set()
        for font in fonts:
            names = {record.nameID: record.toUnicode().strip() for record in font["name"].names if record.nameID in (1, 16)}
            families.add((names.get(16) or names.get(1) or "").lower())
        return families
    except Exception:
        return set()


def sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def materialize(template_dir, store, target):
    shutil.copytree(template_dir, target)
    manifest = json.load(open(os.path.join(template_dir, "template.json")))
    for remote in manifest.get("remote_files", []):
        destination = os.path.join(target, remote["path"])
        os.makedirs(os.path.dirname(destination), exist_ok=True)
        shutil.copy2(os.path.join(store, os.path.basename(remote["url"])), destination)
    return manifest


def compiles(template_dir, store, typst, font_paths):
    with tempfile.TemporaryDirectory(prefix="externalize-") as work:
        target = os.path.join(work, "t")
        manifest = materialize(template_dir, store, target)
        if manifest.get("engine") != "typst":
            return True, ""
        main = os.path.join(target, manifest["main_doc"])
        args = [typst, "compile", "--root", target]
        for path in font_paths:
            args += ["--font-path", path]
        args += ["--font-path", target, main, os.path.join(work, "out.pdf")]
        proc = subprocess.run(args, cwd=os.path.dirname(main), capture_output=True, timeout=300)
        ok = proc.returncode == 0 and os.path.exists(os.path.join(work, "out.pdf"))
        return ok, (proc.stderr or proc.stdout).decode("utf-8", "replace").strip().splitlines()[-1:] if not ok else ""


def externalize(template_dir, store):
    manifest_path = os.path.join(template_dir, "template.json")
    manifest = json.load(open(manifest_path))
    remote = {item["path"]: item for item in manifest.get("remote_files", [])}
    dropped = []
    for directory, _, files in os.walk(template_dir):
        for name in files:
            path = os.path.join(directory, name)
            relative = os.path.relpath(path, template_dir)
            if relative in KEEP:
                continue
            is_font = name.lower().endswith(FONT_EXTENSIONS)
            if is_font and primary_family(path) and primary_family(path) <= COVERED:
                os.remove(path)
                dropped.append(relative)
                continue
            if not is_font and os.path.getsize(path) <= LIMIT:
                continue
            digest = sha256(path)
            extension = os.path.splitext(name)[1].lower()
            stored = os.path.join(store, digest + extension)
            if not os.path.exists(stored):
                shutil.copy2(path, stored)
            remote[relative] = {"path": relative, "sha256": digest, "bytes": os.path.getsize(path), "url": f"{MIRROR}/{digest}{extension}"}
            os.remove(path)
    for directory, subdirs, files in os.walk(template_dir, topdown=False):
        if directory != template_dir and not os.listdir(directory):
            os.rmdir(directory)
    if remote:
        manifest["remote_files"] = sorted(remote.values(), key=lambda item: item["path"])
    if dropped:
        manifest["fonts_from_packs"] = sorted(set(manifest.get("fonts_from_packs", [])) | set(dropped))
    if remote or dropped:
        open(manifest_path, "w").write(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
    return len(remote), len(dropped)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("packs", nargs="+")
    parser.add_argument("--store", required=True)
    parser.add_argument("--typst", required=True)
    parser.add_argument("--font-path", action="append", default=[])
    parser.add_argument("--jobs", type=int, default=6)
    parser.add_argument("--report", required=True)
    args = parser.parse_args()
    os.makedirs(args.store, exist_ok=True)
    templates = [os.path.join(ROOT, "packs", pack, name) for pack in args.packs for name in sorted(os.listdir(os.path.join(ROOT, "packs", pack)))]
    moved = dropped = 0
    for template in templates:
        remote, removed = externalize(template, args.store)
        moved += remote
        dropped += removed
    print(f"{len(templates)} templates: {moved} files moved to the mirror, {dropped} fonts dropped in favour of the Oleafly packs")
    failures = []
    with cf.ThreadPoolExecutor(args.jobs) as pool:
        for template, (ok, detail) in zip(templates, pool.map(lambda t: compiles(t, args.store, args.typst, args.font_path), templates)):
            if not ok:
                failures.append({"template": os.path.relpath(template, ROOT), "detail": detail})
    print(f"recompiled {len(templates)}: {len(templates) - len(failures)} ok, {len(failures)} failed")
    for failure in failures[:40]:
        print("  FAIL", failure["template"], failure["detail"])
    json.dump(failures, open(args.report, "w"), indent=1)
    store_bytes = sum(os.path.getsize(os.path.join(args.store, name)) for name in os.listdir(args.store))
    print(f"mirror store: {len(os.listdir(args.store))} files, {store_bytes / 1e6:.0f} MB")


if __name__ == "__main__":
    main()
