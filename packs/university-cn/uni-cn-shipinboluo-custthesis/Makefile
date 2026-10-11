MAIN = main

.PHONY: all xelatex tectonic clean

all:
	@if command -v xelatex >/dev/null 2>&1; then \
		$(MAKE) xelatex; \
	elif command -v tectonic >/dev/null 2>&1; then \
		$(MAKE) tectonic; \
	else \
		echo "No LaTeX engine found. Install XeLaTeX or Tectonic."; \
		exit 1; \
	fi

xelatex:
	xelatex -interaction=nonstopmode $(MAIN).tex
	bibtex $(MAIN)
	xelatex -interaction=nonstopmode $(MAIN).tex
	xelatex -interaction=nonstopmode $(MAIN).tex

tectonic:
	tectonic -X compile -r 1 $(MAIN).tex

clean:
	rm -f $(MAIN).aux $(MAIN).bbl $(MAIN).bcf $(MAIN).blg $(MAIN).fdb_latexmk
	rm -f $(MAIN).fls $(MAIN).log $(MAIN).out $(MAIN).run.xml $(MAIN).synctex.gz
	rm -f $(MAIN).toc $(MAIN).xdv
