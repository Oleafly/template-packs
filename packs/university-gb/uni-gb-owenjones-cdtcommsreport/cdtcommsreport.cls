\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cdtcommsreport}

\LoadClass[11pt,notitlepage,openright]{report}

% ====  Package Setup  ====
\RequirePackage{ifthen}
\RequirePackage{xstring}
\RequirePackage{xparse}

\RequirePackage[a4paper,margin=25mm]{geometry}
\RequirePackage[english]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{times}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{enumerate}
\RequirePackage[usenames,dvipsnames]{xcolor}

\RequirePackage{graphicx}
\graphicspath{{./figures/}}

\RequirePackage{float}
\RequirePackage[labelfont=bf]{caption}
\RequirePackage[super]{nth}
\RequirePackage{tocloft}
\RequirePackage{parskip}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage{caption}
\RequirePackage{multirow}
\RequirePackage{framed}
\RequirePackage{csquotes}
\RequirePackage[figure,table]{totalcount}
\RequirePackage{enumitem}

\RequirePackage{fancyhdr}
\fancyhf{}
\cfoot{\thepage}
\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{14pt}

\RequirePackage[intoc]{nomencl}
\let\acronym\nomenclature
\renewcommand{\nomname}{List of Acronyms}
\setlength{\nomitemsep}{-0.8\parsep}
\setlength{\nomlabelwidth}{3cm}
\makenomenclature

\RequirePackage[en-GB]{datetime2}
\DTMsetup{useregional=text}

\newcommand{\setbibliography}[1]{
\RequirePackage[backend=biber,style=ieee]{biblatex}
\DefineBibliographyStrings{english} {
    backrefpage  = {p.},
    backrefpages = {p.},
    bibliography = {References}
 }
 \addbibresource{#1}
 }

\newcommand{\doctype}[1]{
    \newcommand{\@doctype}{#1}
}

% ====  Title Page Setup  ====
\newcommand{\frontpage}{%
\hypersetup{pdfauthor={\@author},
            pdftitle={\@title},
            pdfsubject={},
            hidelinks}
\pagestyle{empty}
\pagenumbering{gobble}
\vspace*{1.5em}
\begin{center}
\includegraphics[width=0.5\textwidth]{logo-uob-bw} \\
\vspace{1.5em}
{\Large%
Department of Electrical and Electronic Engineering}
\vfill
{\Huge\textbf\@title\\%
\vspace{0.8em}%
\Large\@author
}
\vfill
\large%
A {\@doctype} \\ submitted to the University of Bristol in accordance with the requirements of \\ the degree of PhD in Communications in the Faculty of Engineering.\\
\vspace{1em}
\large\@date
\end{center}
\vspace{3em}
\clearpage
\pagestyle{plain}
\pagenumbering{roman}
}

% ==== Statements Page ====
\newcommand{\declaration}[1]{
	\def\@declarationdate{#1}
}

\newcommand{\statements}{
\null\vfill
\begin{center}
\begin{minipage}{0.875\textwidth}
\setstretch{1.2}
\setlength{\FrameSep}{1.5em}
\begin{framed}
\textbf{DECLARATION AND DISCLAIMER}\par
\vspace{0.5em}
Unless otherwise acknowledged, the content of this report is the original work of the author. None of the work in this document has been submitted by the author in support of an application for another degree or qualification at this or any other university or institute of learning. The views in this document are those of the author and do not in any way represent those of the University.\par
\vspace{0.5em}
Name: \@author\par
Date: \@declarationdate
\end{framed}
\end{minipage}
\end{center}
\vfill
\clearpage
}

% ====  TOC Page Style  ====
\cftsetindents{figure}{0em}{3em}
\cftsetindents{table}{0em}{3em}
\setlength\cftbeforetoctitleskip{4ex}
\setlength\cftbeforeloftitleskip{4ex}
\setlength\cftbeforelottitleskip{4ex}
\setlength\cftaftertoctitleskip{2ex}
\setlength\cftafterloftitleskip{2ex}
\setlength\cftafterlottitleskip{2ex}

\renewcommand{\cfttoctitlefont}{\LARGE\textbf}
\renewcommand{\cftloftitlefont}{\LARGE\textbf}
\renewcommand{\cftlottitlefont}{\LARGE\textbf}

\newcommand{\tables}{%
\setcounter{tocdepth}{1}
\tableofcontents
\clearpage

\iftotalfigures
\listoffigures
\clearpage
\fi

\iftotaltables
\listoftables
\clearpage
\fi

\printnomenclature
\clearpage
}

% ====  Document Page Style  ====
\newcommand{\maincontent}{%
\setlength{\parskip}{1.25em}
\pagenumbering{arabic}
\pagestyle{fancy}
\setcounter{page}{1}
\setstretch{1.5}
}

\titleformat{\chapter}[hang]{\LARGE\setstretch{1.1}}{\textbf\thechapter}{1em}{\raggedright\textbf}
\titlespacing*{\chapter}{0ex}{*0}{*1}

\titleformat{\section}{\Large\bfseries\setstretch{1.1}}{\thesection}{1em}{}
\titlespacing{\section}{0pt}{4pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

\titleformat{\subsection}{\large\bfseries\setstretch{1.1}}{\thesubsection}{1em}{}
\titlespacing{\subsection}{0pt}{4pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

\titlespacing{\subsubsection}{0pt}{4pt plus 4pt minus 2pt}{0pt plus 1pt minus 1pt}

% ====  References Page Style ====
\newcommand{\references}{%
\appendix
\ifx\printbibliography\undefined%
\else%
\clearpage
\addcontentsline{toc}{chapter}{References}
\printbibliography
\fi%
}
\endinput
