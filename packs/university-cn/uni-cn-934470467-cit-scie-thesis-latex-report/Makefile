MAIN := report
SRC := $(MAIN).tex
OUTDIR := .tmp
PDF := $(MAIN).pdf
XELATEX := xelatex
BIBTEX := bibtex
XELATEX_FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=$(OUTDIR)
export TEXINPUTS := .:./gbt7714//:
export BIBINPUTS := .:$(CURDIR):
export BSTINPUTS := .:$(CURDIR):$(CURDIR)/gbt7714//:

.PHONY: all pdf clean distclean

all: pdf

pdf: $(PDF)

$(PDF): $(SRC) graduate-design-manual.cls $(MAIN).bib
	mkdir -p $(OUTDIR)
	$(XELATEX) $(XELATEX_FLAGS) $(SRC)
	awk 'BEGIN{seen=0} index($$0,"\\bibstyle{")==1 {if (seen) next; seen=1} {print}' $(OUTDIR)/$(MAIN).aux > $(OUTDIR)/$(MAIN).aux.tmp
	mv $(OUTDIR)/$(MAIN).aux.tmp $(OUTDIR)/$(MAIN).aux
	cd $(OUTDIR) && $(BIBTEX) $(MAIN)
	$(XELATEX) $(XELATEX_FLAGS) $(SRC)
	$(XELATEX) $(XELATEX_FLAGS) $(SRC)
	cp $(OUTDIR)/$(PDF) $(PDF)

clean:
	rm -rf $(OUTDIR)

distclean: clean
	rm -f $(PDF)
