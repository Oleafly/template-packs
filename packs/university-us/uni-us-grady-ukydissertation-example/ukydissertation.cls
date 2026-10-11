%%
%% This is file `ukydissertation.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ukydissertation.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2015 by Grady Weyenberg <grady.weyenberg@uky.edu>.
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ukydissertation}
[2015/06/05 v0.2 UKY Dissertation Class]
\newif\if@endorse

\newif\if@dedication
\@dedicationfalse

\newif\if@acknowledgements
\@acknowledgementsfalse

\newif\if@mainmatter
\@mainmatterfalse

\DeclareOption{endorse}{\@endorsetrue}
\DeclareOption{noendorse}{\@endorsefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{noendorse, 12pt, letterpaper}
\ProcessOptions
\LoadClass{report}
\RequirePackage[hmargin={1.5in,1in},vmargin=1in,foot=0.5in]{geometry}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{needspace}

\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\@college}{\@latex@warning@no@line%
  {No \noexpand\college given} COLLEGE}
  \newcommand{\director}[1]{\renewcommand{\@director}{#1}}
  \newcommand{\@director}{\@latex@warning@no@line%
    {No \noexpand\director given} Advisor}
\newcommand{\dgs}[1]{\renewcommand{\@dgs}{#1}}
\newcommand{\@dgs}{\@latex@warning@no@line%
  {No \noexpand\dgs given} DGS}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\@department}{\@latex@warning@no@line%
  {No \noexpand\department given} DEPARTMENT}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}
\newcommand{\@keywords}{\@latex@warning@no@line%
  {No \noexpand\keywords given}}
\renewcommand{\abstract}[1]{\renewcommand\@abstract{#1}}
\newcommand{\@abstract}{\@latex@warning@no@line%
  {No \noexpand\abstract given}}
\newcommand{\dedication}[1]{\@dedicationtrue
  \newcommand{\@dedication}{#1}}
\newcommand{\acknowledgements}[1]{\@acknowledgementstrue
  \newcommand{\@acknowledgements}{#1}}
\newcommand\makefrontmatter{%
  \maketitle \@makeabstract \@makeapproval
  \if@dedication\@makededication\fi
  \setcounter{page}{3}
  \pagestyle{plain}
  \if@acknowledgements\@makeacknowledgements\fi
  \pdfbookmark[chapter]{\contentsname}{toc}
  \tableofcontents \listoftables \listoffigures
  \clearpage
  \pagenumbering{arabic} \global\let\thanks\relax
  \global\let\maketitle\relax \global\let\title\relax
  \global\let\author\relax \global\let\date\relax
  \global\let\and\relax \global\let\abstract\relax
  \global\let\dedication\relax}
\newcommand{\backmatter}{\@mainmatterfalse\appendix}
\newcommand{\vita}{\clearpage\chapter*{Vita}%
  \addcontentsline{toc}{chapter}{Vita}}
\renewcommand{\@makechapterhead}[1]{%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
    \bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 10\p@
    \fi
    \interlinepenalty\@M
    \bfseries #1\par\nobreak
    \vskip 20\p@
  }}
\renewcommand{\@makeschapterhead}[1]{%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \centering\bfseries  #1\par\nobreak
    \vskip 20\p@
  }}
\renewcommand{\section}{%
  \@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\bfseries}}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\bfseries}}
\newcommand{\@period}[1]{#1.--- }
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {\z@}%
  {\normalfont\normalsize\itshape\@period}}

\renewcommand\maketitle{%
  \setcounter{page}{0}
  \pagestyle{empty}
  {\let\footnotesize\small
  \let\footnoterule\relax
  \let\footnote\thanks
  \null
  \bookmark[named=FirstPage,level=0]{Title Page}
  \vskip 1.5in%
  \begin{center}%
  \parbox[t][1.5in]{\textwidth}%
  {\centering\MakeUppercase\@title\par}%
  \par
  \parbox[t][3\baselineskip]%
  {0.5\textwidth}{\hrule\vskip\baselineskip%
    \centering DISSERTATION%
    \par\vskip\baselineskip\hrule}
  \vskip\baselineskip%
  {A dissertation submitted in partial fulfillment of the \\
    requirements for the degree of Doctor of Philosophy in the \\
    \@college\\ at the University of Kentucky\par}%
  \vskip 2\baselineskip%
    {By\par\vskip 0.5\baselineskip\@author\par}%
    \vskip 0.5\baselineskip%
    {Lexington, Kentucky\par}%
    \vskip 1em%
    {Director: Dr. \@director, Professor of \@department\par}%
    \vskip 0.5\baselineskip%
    {Lexington, Kentucky\par}%
    \vfill
    {Copyright \textcopyright\ \@author\ \the\year\par}%
    \vspace*{1.5in}\par
  \end{center}\par
  \null}
  \clearpage
  \setcounter{footnote}{0}}

\newcommand\@makeabstract{%
  \pagestyle{empty}
  \pagenumbering{Roman}
  \hypertarget{abstract}{}
\bookmark[dest=abstract,level=0]{Abstract}
\null\vskip 1.5in
\begin{center}%
  \parbox[t][1in]{\textwidth}{\centering ABSTRACT OF DISSERTATION\par}
  \MakeUppercase\@title\par
\end{center}
\@abstract
\par\vspace\baselineskip\noindent
  KEYWORDS: \parbox[t]{0.8\textwidth}{\@keywords}
  \par\needspace{1.5in}\null\vfill
  \hfill\parbox[t][1.5in]{0.5\textwidth}{%
    \if@endorse
    {\centering\MakeUppercase\@author\par}\vskip 2pt
    \else\fi
    \hrule
    \vskip 2pt
    Student's Signature\par
    \vfil
    \if@endorse
    {\centering\MakeUppercase\@date\par}\vskip 2pt
    \else\fi
    \hrule
  \vskip 2pt
  Date\par}
  \par\null\clearpage}

\newcommand\@makeapproval{
  \pagenumbering{roman}
  \null\vskip 2in
  \noindent\parbox[t][1in]{\textwidth}%
  {\centering\MakeUppercase\@title\par}\par
  \begin{centering}
    By
    \vskip0.5\baselineskip
    \@author\par
  \end{centering}
  \vfill
  \hfill\parbox[t][3in]{0.5\textwidth}{%
    \if@endorse
    {\centering\MakeUppercase\@director\par}\vskip 2pt
    \else\fi
    \hrule
    \vskip 2pt
    Director of Dissertation\par
    \vfil
    \if@endorse
    {\centering\MakeUppercase\@dgs\par}\vskip 2pt
    \else\fi
    \hrule
    \vskip 2pt
    Director of Graduate Studies\par
    \vfil
    \if@endorse
    {\centering\MakeUppercase\@date\par}\vskip 2pt
    \else\fi
    \hrule
  \vskip 2pt
  Date\par}\hskip 1in
    \par\vfil\clearpage}

\newcommand\@makeacknowledgements{
  \phantomsection
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \null
  {\centering ACKNOWLEDGEMENTS \par}
  \vspace{\baselineskip}\noindent
  \@acknowledgements
  \par\vfil\clearpage}

\newcommand\@makededication{%
  \null\vfil
  \@dedication
  \par\vfil
  \clearpage}

\renewcommand{\contentsname}{Table of Contents}
\endinput
%%
%% End of file `ukydissertation.cls'.
