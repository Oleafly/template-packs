# style-eit-latex

Changed LaTeX style for the Department of Electrical and Computer Engineering, RPTU Kaiserslautern-Landau

## Build

There is nothing to build right here in this repository. It is included as a submodule into the document templates where required.
However, if you really want to use it directly in your own documents, you can do so by including:

```
% for English documents (standard)
\usepackage{style-eit-latex/EIT}

```

or

```
% use [de] option for German documents
\usepackage[de]{style-eit-latex/EIT}

```

## Known Dependencies

* submodule RedHatText - Fonts
   * clone with `git clone --recursive` if font download is desired
* LaTeX packages
   * texlive-science

## Contributors:

* Christian De Schryver <mailto:christian.deschryver@rptu.de>
* Matthias Jung <mailto:jungma@eit.uni-kl.de>
* Julian Puderbach
