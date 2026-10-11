thesis-eit-latex
===

LaTeX thesis template Department of Electrical and Computer Engineering, RPTU Kaiserslautern-Landau

## How to use
This LaTeX report template can be used easily with any TeX distribution by running ```make``` or with any LaTeX IDE. Just start with the file ```main.tex``` and go ahead with your changes. Everything is documented in the file itself.

*Important*: This repository depends on a Git submodule that holds the style definition. Therefore, a regular ```git clone``` command is not sufficient to obain the submodule as well! Please use ```git clone --recursive``` instead.

You can use the ```cleanup.py``` script in order to remove unncesseary files that may prevent the template from compiling e.g. on Overleaf.


## Build
Use your favorite LaTeX IDE / editor or optionally open a terminal and use make.


## Known Dependencies
* texlive-science
* texlive-fonts-extra
* Git submodule style-eit-latex


## Contributors
* Christian De Schryver
* Julian Puderbach
