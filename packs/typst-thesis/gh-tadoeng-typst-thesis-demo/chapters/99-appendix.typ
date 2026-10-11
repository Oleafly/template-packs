= Appendix

A real computational structural engineering thesis will often need appendices for command examples, schema snapshots, and additional result tables.

Example CLI sketch for the case study:

```bash
ext init
ext branch new drift-study
ext version commit -m "Adjust wall stiffness and export baseline"
ext diff main/v3 drift-study/v2
ext report generate --template thesis-demo
```

Example thesis folder idea:

```text
thesis/
  main.typ
  theme.typ
  meta.toml
  refs.bib
  chapters/
  figures/
  data/
  extras/
```
