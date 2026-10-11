% Turabian Formatting for LaTeX -- Theses and Dissertations
%
% Based on the Chicago Manual of Style (16th edition) and Kate Turabian's A Manual for Writers of Research Papers, Theses, and Dissertations (8th edition)
%
% ==============================
% Copyright 2013 Omar Abdool
%
% This work may be distributed and/or modified under the conditions of the LaTeX
% Project Public License (LPPL), either version 1.3 of this license or (at your
% option) any later version.
%
% The latest version of this license is in:
%	http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% LPPL Maintenance Status: maintained (by Omar Abdool)
%
% This work consists of the files: turabian-formatting.sty,
% turabian-researchpaper.cls, turabian-thesis.cls, turabian-formatting-doc.tex, % and turabian-formatting-doc.pdf (in addition to this README file).
%
% ==============================
%
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{turabian-thesis}[2014/12/27 Turabian Theses and Dissertations]



% Options for document class, some passed to book class

\DeclareOption{draft}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}
	\PassOptionsToClass{\CurrentOption}{book}}

\DeclareOption{raggedright}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{emptymargins}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{twocolumn}{\OptionNotUsed}

\DeclareOption{notitlepage}{\OptionNotUsed}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions\relax


\LoadClass[titlepage,oneside]{book}



\RequirePackage{geometry}


\RequirePackage{turabian-formatting}

\geometry{bindingoffset=0.5in}
\setlength{\@bindingoffsetfm}{0.5in}
	

\institution{[Institution]}

\newcommand{\faculty}[1]{\def\@faculty{#1}}
\faculty{[Faculty]}

\newcommand{\mydegree}[1]{\def\@mydegree{#1}}
\mydegree{[Degree]}

\newcommand{\department}[1]{\def\@department{#1}}
\department{[Department]}

\newcommand{\location}[1]{\def\@location{#1}}
\location{[City], [State/Province]}


\renewcommand{\maketitle}{%
	\normalfont\normalsize
	\begin{center}
		\vspace*{-1.2\baselineskip}
		\parskip=0.833\baselineskip
		\@institution\par
		\vspace*{\stretch{1}}
		\ifthenelse{\equal{\@subtitle}{}}%
			{%
				{\bfseries\@title}\par%
			}%
			{%
				{\bfseries\@title :}\par
				{\bfseries\@subtitle}\par%
			}
		\vspace*{\stretch{1}}
		A Dissertation Submitted to\par
		\@faculty\par
		in Candidacy for the Degree of\par
		\@mydegree\par
		\vspace*{1\baselineskip}
		\@department\par
		\vspace*{\stretch{1}}
		by\par
		{\bfseries\@author}\par
		\vspace*{\stretch{1}}
		\@location\par
		\@date
		\parskip=0pt
	\end{center}
	\clearpage
	\singlespacing
	\vspace*{\stretch{1}}
	\noindent Copyright \copyright\ \the\year\ by \@author \\*\noindent All rights reserved
	\newpage
}


