# WUST-PhD-Thesis-Latex — English

WUSTThesis.cls 2025/05/15 version V1.0

[中文](README_ZH.md) | [日本語](README_JA.md) | **English**

---

Unofficial LaTeX template for Master's and Ph.D. theses at **Wuhan University of Science and Technology (WUST)**.

---

## Requirements

- **TeX Distribution:** TeX Live 2024+ / MiKTeX
- **Compiler:** XeLaTeX (required)
- **Bibliography:** BibTeX

## Quick Start

### Using latexmk (Recommended)

```bash
# Compile
latexmk -xelatex main.tex

# Clean build artifacts
latexmk -c main.tex

# Full clean (including PDF)
latexmk -C main.tex
```

### Manual Compilation

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

### Overleaf

Upload the entire project to Overleaf and select **XeLaTeX** as the compiler.

## Project Structure

```
├── main.tex          # Main entry file
├── WUSTthesis.cls    # Document class
├── WUSTThesis.bst    # Bibliography style
├── WUSTtils.sty      # Auxiliary macro package
├── .latexmkrc        # latexmk configuration
├── body/             # All chapter .tex files
│   ├── cover.tex     # Cover info (title, author, etc.)
│   ├── chap01.tex ~ chap04.tex  # Chapters (add/remove as needed)
│   ├── conclusion.tex
│   ├── ack.tex       # Acknowledgments
│   ├── publications.tex   # Appendix: publications
│   └── project.tex   # Appendix: projects
├── figures/          # Image files
├── font/             # Chinese fonts (for Overleaf etc.)
└── ref/
    └── refs.bib      # Bibliography database
```

## Usage

1. Select the format mode in `main.tex`:
   - `draftformat` — Draft (university name shown in page header)
   - `finalformat` — Blind review (university name hidden)
2. Fill in your thesis information in `body/cover.tex` (title, author, supervisor, abstract, etc.)
3. Add or remove chapter files under `body/` and update `\include` in `main.tex` accordingly
4. Place references in `ref/refs.bib`

---

## Acknowledgments

Based on [HUST-PhD-Thesis-Latex](https://github.com/XinzeZhang/HUST-PhD-Thesis-Latex) (V3.1).

Thanks to contributors: Lianghao Li, Jianqing Lin (2021 V3.1), Xinze Zhang (2020 V3.0), Huikan Liu (2006 V2.0), Feng Jiang (2005 V1.0).

Contributor: Wancheng Zhang (zhangwancheng@wust.edu.cn)

---

+ Faithfully reproduces the official WUST "Doctoral Thesis Layout Style (Science & Engineering).doc" template
+ English table of contents generation is not yet implemented; further refinements needed
+ The current version is production-ready (the author has completed their own thesis using this template)
+ Contributions from the community are welcome to continue improving the template
