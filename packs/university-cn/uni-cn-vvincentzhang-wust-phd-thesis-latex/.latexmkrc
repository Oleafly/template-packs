# LaTeXMK configuration for WUST PhD Thesis
# Compile with: latexmk -xelatex main.tex
# Clean with:     latexmk -c main.tex
# Clean all:      latexmk -C main.tex

$xelatex = "xelatex -synctex=1 -interaction=nonstopmode %O %S";
$bibtex = "bibtex %O %B";
$pdf_mode = 1;        # Use xelatex as the PDF generator
$recorder = 1;        # Enable file recording for dependency tracking

# BibTeX is needed for bibliography
@default_files = ("main.tex");

$clean_ext = "aux bbl blg brf fdb_latexmk fls glg gls idx ilg ind ist lof log lot nav out snm toc synctex.gz thm vrb";
