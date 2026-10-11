% -*- coding: utf-8 -*-
%
% Original Title: kaist.cls
% Original Author: Unknown, KAIST
% Date: Unknown
%
% LaTeX class file for GIST thesis
%
% Modification Log:
% -----------------
% .01 Nov/21/96 S.H. Lee Set page dimensions
% .02 Dec/30/96 Y. Chung Redefine plain pagestyle
%                        Reformat and rearrage cover sheets
% .03 Jan/14/97 Y. Chung Added dedication page
% .04 Jan/17/97 S.H. Lee Correct the page mismatching
% .05 Nov/25/98 S.H. Lee Enable more referees up to 7
% .06 Dec/25/98 S.H. Lee Respell "&" to "and"
% .07 Jun/30/99 S.H. Lee Added Curriculum Vitae
% .08 Jul/01/99 S.H. Lee Support Hangul thesis
% .09 Jan/01/00 S.H. Lee Support doctoral dissertation
% .10 Dec/03/03 K. Chun  Fixed the region name
% .11 Jan/03/04 K. Chun  Added "publication'' tag
% .12 Nov/22/07 H. Kim   Fixed and added some comments
% .13 Nov/22/07 H. Kim   Respelled "ProvidesClass{kjist}" to "ProvidesClass{gist}"
% .14 Nov/22/07 H. Kim   Edited and respelled "[1996/12/30 Document class for K-JIST thesis]" to "[2007/11/23 Document class for GIST thesis]"
% .15 Nov/22/07 H. Kim   Respelled all "Kwangju" to "Gwangju"
% .16 Nov/23/07 H. Kim   Added a definition about "School of Information and Mechatronics"
% .17 Nov/23/07 H. Kim   Inserted "School of" to several places where it is necessary
% .18 Nov/24/07 H. Kim   Defined 'scode' for the code of school
% .19 Oct/31/12 K. Chun  Changed the character encoding to utf-8.
%                        Removed 'scode', and reflected the current department system.
%                        Support multiple awards.
% .20 Dec/13/12 K. Chun  Added a space in a korean degree title.
%                        Enabled the description of total page on the abstract.
% .21 Apr/09/26 K.H. Kim Complete revisions.

% ToDos
%
% * 'Publications' should be classified depending on the type.
% * The long caption of floats exceeds the lower page boundary.
% * The long word exceeds the right page boundary.
% * Migration to LaTeX2e✔ or LaTeX3
% * Remove a blank page with no page number after a 'acknowledgement'.
% * Make correct the wrong hyperlinks in the preambles.

% Identify gist class file.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gist}[2012/10/31 Document class for GIST thesis]

% ----------------------------------------------------------------------
% Class options
% ----------------------------------------------------------------------

\def\gist@natbiboptions{sort&compress,square,numbers}
\def\gistbibliographystyle{plainnat}
\newif\ifgist@dense
\gist@densefalse

\DeclareOption{korean}{\gdef\@korean{}}
\DeclareOption{bibplainnat}{\gdef\gistbibliographystyle{plainnat}}
\DeclareOption{bibunsrtnat}{\gdef\gistbibliographystyle{unsrtnat}}
\DeclareOption{bibabbrvnat}{\gdef\gistbibliographystyle{abbrvnat}}
\DeclareOption{bibieee}{\gdef\gistbibliographystyle{IEEEtranN}}
\DeclareOption{citenumeric}{\gdef\gist@natbiboptions{sort&compress,square,numbers}}
\DeclareOption{citesuper}{\gdef\gist@natbiboptions{sort&compress,super,numbers}}
\DeclareOption{citeauthoryear}{\gdef\gist@natbiboptions{authoryear,round}}
\DeclareOption{standard}{\gist@densefalse}
\DeclareOption{dense}{\gist@densetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

% ----------------------------------------------------------------------
% Core class/package loading
% ----------------------------------------------------------------------

\newcommand\myDRIVER{\ifpdf pdftex\else dvipdfm\fi}
\input{gist/gist-class-load.tex}
\input{gist/gist-layout.tex}

% ----------------------------------------------------------------------
% User-facing commands and metadata macros
% ----------------------------------------------------------------------

\newcommand{\gistename}{Gwangju Institute of Science and Technology}
\newcommand{\gistkname}{광주과학기술원}
\newcommand{\gistknamen}{광 주 과 학 기 술 원}

\newcommand{\gistbibliography}[1]{%
    \bibliographystyle{\gistbibliographystyle}%
    \bibliography{#1}%
}

\def\code#1{\def\@code{#1}}
\def\degreeabbr#1{\def\@degreeabbr{#1}}
\def\emajor#1{\def\@emajor{#1}}
\def\kmajor#1{\def\@kmajor{#1}}
\def\etitle#1{\def\@etitle{#1}}
\def\ktitle#1{\def\@ktitle{#1}}
\def\advisor#1{\def\@advisor{#1}}
\def\coadvisor#1{\def\@coadvisor{#1}}
\def\kadvisor#1{\def\@kadvisor{#1}}
\def\kcoadvisor#1{\def\@kcoadvisor{#1}}
\def\ename#1{\def\@ename{#1}}
\def\kname#1{\def\@kname{#1}}
\def\studentid#1{\def\@studentid{#1}}
\def\college#1{\def\@college{#1}}
\def\kcollege#1{\def\@kcollege{#1}}
\def\coveryear#1{\def\@coveryear{#1}}
\def\advisorsigndate#1#2#3{\def\@advisorsigndate{#1 #2, #3}}

\ifx\@korean\@@@@undefined@@@@
    \def\refereesigndate#1#2#3{\def\@refereesigndate{#1 #2, #3}}
    \def\@reftitlea{Committee Chair}
    \def\@reftitleb{Committee Member}
    \def\birthday#1#2#3{\def\@birthday{#1 #2, #3}}
\else
    \def\refereesigndate#1#2#3{\def\@refereesigndate{#1년 #2월 #3일}}
    \def\@reftitlea{심사위원장}
    \def\@reftitleb{심~사~위~원}
    \def\birthday#1#2#3{\def\@birthday{#1년 #2월 #3일}}
\fi

\def\refereeA#1{\def\@refereeA{#1}}
\def\refereeB#1{\def\@refereeB{#1}}
\def\refereeC#1{\def\@refereeC{#1}}
\def\refereeD#1{\def\@refereeD{#1}}
\def\refereeE#1{\def\@refereeE{#1}}
\def\refereeF#1{\def\@refereeF{#1}}
\def\refereeG#1{\def\@refereeG{#1}}
\def\npages#1{\def{\@npages{#1}}}
\newcommand{\@npages}{\pageref{LastPage}}%{\pageref{paperlastpagelabel}}
\def\dedication#1{\def\@dedication{#1}}
\def\birthplace#1{\def\@birthplace{#1}}
\def\addr#1{\def\@addr{#1}}

\def\B@char{B/}
\def\M@char{M/}
\def\D@char{D/}
\def\split@code#1#2\eop{\def\@md{#1}\def\@dept{#2}}
\def\split@kname#1#2#3\eop{\def\@korname{#1 #2 #3}}
\def\MRE{MRE}

\def\insert@hss#1#2{#1#2\hss}
\newcommand{\maketitlebreakwork}{\def\titlebreak{\\\ignorespaces}}
\newcommand{\maketitlebreaknotwork}{\def\titlebreak{\ }}
\maketitlebreaknotwork
% ----------------------------------------------------------------------
% User utilities
% ----------------------------------------------------------------------

\newcommand{\subfig}[4][]{%
    \begin{subfigure}[b]{#2}
        \includegraphics[width=\textwidth]{#3}%
        \if\relax\detokenize{#1}\relax
            \phantomcaption
        \else
            \caption{#1}
        \fi
        \if\relax\detokenize{#4}\relax
        \else
            \label{#4}
        \fi
    \end{subfigure}%
}

\DeclareMathOperator*{\argmin}{argmin}
\newcommand{\tcell}[2]{\multirow{2}{*}{\multirowcell{2}[7pt][c]{#1 \\ #2}}}
\newcommand{\red}[1]{\textcolor{red}{#1}}
\newcommand{\blue}[1]{\textcolor{blue}{#1}}
\newcommand{\green}[1]{\textcolor{green}{#1}}
\newcommand{\degc}[1]{$^\circ$C}
\newcommand{\tf}{\fontsize{6.5}{7.5}\selectfont}
\renewcommand\cellset{\renewcommand\arraystretch{0.7}%
    \setlength\extrarowheight{1pt}}
\newcommand{\str}[1]{\st{#1}}

% ----------------------------------------------------------------------
% Structured class implementation
% ----------------------------------------------------------------------

\input{gist/gist-frontmatter.tex}
\input{gist/gist-headings.tex}
\input{gist/gist-backmatter.tex}

%
% end of gist.cls
%
