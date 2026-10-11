\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{BYUthesis}[2015/03/20 v0.1 Simple prospectus class]
\LoadClass[12pt,letterpaper]{report}

\RequirePackage[margin=1in]{geometry}
\RequirePackage[T1]{fontenc} % looks better than default font encoding
\RequirePackage{lmodern} % need a newer font to work with T1 font encoding
\RequirePackage[hang,small,bf]{caption} % smaller captions
\RequirePackage{etoolbox} % forlistloop, listadd
\RequirePackage{setspace} % singlespacing, doublespacing
\RequirePackage{tocloft} % configure table of contents and list of figs/tabs
\RequirePackage{indentfirst} % indent the first paragraph in each section
\RequirePackage{titlesec} % format chapter titles
\usepackage[all]{nowidow} % remove widows and orphans
%\RequirePackage{mathpazo} % Palatino font (optional)

\DeclareOption{etd}{\newcommand{\etd}{etd}} %TODO implement ETD
\ProcessOptions\relax

% Process or warn about required inputs for title page
\newcommand{\department}[1]{\gdef\@department{#1}}
  \def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
  \def\@degree{\@latex@warning@no@line{No \noexpand\degree given}}
\newcommand{\papertype}[1]{\gdef\@papertype{#1} }
  \def\@papertype{\@latex@warning@no@line{No \noexpand\papertype given}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1} }
  \def\@copyrightyear{\@latex@warning@no@line{No \noexpand\copyrightyear given}}
\newcommand{\keywords}[1]{\gdef\@keywords{#1} }
  \def\@keywords{\@latex@warning@no@line{No \noexpand\keywords given}}

\newcommand*{\@committeelist}{}
\newcommand*{\committeemember}[1]{\listadd{\@committeelist}{#1}}
\newcommand\tmpprintlist[1]{#1\\} % Print item in list

% format title page
%   note - the features of the titlepage env are not helpful here
\newcommand{\includetitle}{%
    \pdfbookmark[0]{Title Page}{titlepage}
    \begin{center}
    \doublespacing
    \@title  \par
    \vspace{\stretch{1}}
    \@author \par
    \vspace{\stretch{1}}
    \singlespacing
    A \@papertype{} submitted to the faculty of\\
    Brigham Young University\\
    in partial fulfillment of the requirements for the degree of\\
    \vspace*{\baselineskip}
    \@degree{} \par
    \vspace{\stretch{1}}
    \forlistloop{\tmpprintlist}{\@committeelist}
    \vspace{\stretch{1}}
    \doublespacing
    \@department\\
    Brigham Young University\\
    \vspace{\stretch{1}}
    Copyright \copyright\ \@copyrightyear\ \@author \\
    All Rights Reserved
    \end{center}
    \thispagestyle{empty} % suppress page number (and header/footer)
    \clearpage
}

% format abstract page
\newcommand{\includeabstract}[1]{
  \pdfbookmark[0]{Abstract}{Abstract}
  \begin{center}
  \singlespacing
  ABSTRACT\\
  \vspace*{\baselineskip}
  \@title\\
  \vspace*{\baselineskip}
  \@author\\
  \@department, BYU\\
  \@degree
  \end{center}
  \par % ensure indent
  \setlength{\parskip}{\baselineskip} % full line between paragraphs
  \vspace{-\baselineskip} % only one line between degree and abstract
  \input{#1}
  \vfill % position keywords at bottom of page
  \noindent Keywords: \@keywords
  \thispagestyle{empty} % suppress page number (and header/footer)
  \clearpage
}

% format acknowledgments page
\newcommand{\includeacknowledgments}[1]{
  \doublespacing
  \begin{center}
  ACKNOWLEDGMENTS
  \end{center}
  \par
  \vspace{-\baselineskip} % only one line between heading and text
  \input{#1}
  \thispagestyle{empty} % suppress page number (and header/footer)
  \clearpage
}

% format table of contents
\newcommand{\includetableofcontents}{
  \doublespacing
  \pdfbookmark[0]{Table of Contents}{toc}
  \renewcommand{\cfttoctitlefont}{\large\bfseries} % change toc font
  \renewcommand{\contentsname}{Table of Contents} % rename toc
  \renewcommand{\appendixname}{Paper} % rename appendices
  \renewcommand{\cftchapdotsep}{\cftdotsep} % add dots to chapters in toc
  \renewcommand{\cftloftitlefont}{\large\bfseries} % change lof font
  \renewcommand{\cftlottitlefont}{\large\bfseries} % change lot font

   % This adds the words Chapter and Appendix to table of contents
   \newlength\shifttofitchapter
   \renewcommand\cftchappresnum{\chaptername~}
   \settowidth\shifttofitchapter{\cftchappresnum\cftchapaftersnum\quad}
   \addtolength\cftchapnumwidth{\shifttofitchapter}
   \makeatletter
   \g@addto@macro\appendix{\addtocontents{toc}{%
       \protect\renewcommand{\protect\cftchappresnum}{\appendixname\space}}}
   \makeatother

  % add table of contents
  \tableofcontents
  \clearpage

  % add list of tables
  \phantomsection % necessary for hyperref link
  \addcontentsline{toc}{chapter}{List of Tables}
  \listoftables
  \clearpage

  % add list of figures
  \phantomsection % necessary for hyperref link
  \addcontentsline{toc}{chapter}{List of Figures}
  \listoffigures
  \clearpage
}

% update chapter labels
\titleformat{\chapter}[display]{\normalfont\large\bfseries}{\chaptertitlename\ \thechapter}{0pt}{\large}
\titlespacing*{\chapter}{0pt}{30pt}{0pt} % ensures 2in top margin

% update section/subsection labels
% \@startsection{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
\renewcommand{\section}{
  \@startsection{section}{1}{0pt}{1pt}{1pt}{\normalsize\bf}}
\renewcommand{\subsection}{
  \@startsection{subsection}{1}{0pt}{1pt}{1pt}{\normalsize\bf}}
\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{1}{0pt}{1pt}{1pt}{\normalsize\bf}}

% format bibliography
\renewcommand{\bibname}{\large References} % rename bibliography
\let\oldbibliography\thebibliography % save bibliography command
\renewcommand{\thebibliography}[1]{\singlespacing \oldbibliography{#1}} % reducing spacing in the bibliography.

\providecommand{\frontmatter}{
  \hypersetup{pageanchor=false}
  \pagenumbering{roman}}
\providecommand{\mainmatter}{
  \doublespacing
  \hypersetup{pageanchor=true}
  \pagenumbering{arabic}}
