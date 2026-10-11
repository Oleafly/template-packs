%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file is `WSUThesis.cls'
%%  adapted by Sean Mossman <sean.mossman@wsu.edu>, February 2017
%%
%% Geniology:
%%  article.cls (LaTeX2e, Version 3.14159)
%%  osuthes.sty (OSU Grad. School)
%%  `gthesis.cls' adapted by Tolga Acar <acar@ece.orst.edu>, April 1997
%%  Edits by:
%%      Peter Kurahashi, 2009
%%      Parisa Rashidi, 2010
%%
%% This file is distributed in the hope that it will be useful,
%% but without ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%%
%% COPYRIGHT NOTICE
%% You can distribute this file as you please, keeping this copyright
%% notice and line lines above it.
%% Please send any bugs, suggestions to Sean Mossman c/o WSU GPSA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{WSUThesis}

\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\newif\if@abstractpage
\@titlepagefalse
\@abstractpagefalse

\if@compatibility\else
  \DeclareOption{a4paper}
     {\setlength\paperheight {297mm}\setlength\paperwidth  {210mm}}
  \DeclareOption{a5paper}
     {\setlength\paperheight {210mm}\setlength\paperwidth  {148mm}}
  \DeclareOption{b5paper}
     {\setlength\paperheight {250mm}\setlength\paperwidth  {176mm}}
  \DeclareOption{letterpaper}
     {\setlength\paperheight {11in}\setlength\paperwidth  {8.5in}}
  \DeclareOption{legalpaper}
     {\setlength\paperheight {14in}\setlength\paperwidth  {8.5in}}
  \DeclareOption{executivepaper}
     {\setlength\paperheight {10.5in}\setlength\paperwidth  {7.25in}}
  \DeclareOption{landscape}
     {\setlength\@tempdima   {\paperheight}%
      \setlength\paperheight {\paperwidth}%
      \setlength\paperwidth  {\@tempdima}}
\fi

\if@compatibility
  \renewcommand\@ptsize{0}
\else
  \DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

\if@compatibility\else
  \DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
  \DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
  \DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility\else
  \DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{letterpaper,12pt,oneside,onecolumn,final}
\ProcessOptions

\input{size1\@ptsize.clo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAGE LAYOUT
%  Layout lengths tied to margins and page number positions

\newlength{\headwidth}\setlength{\headwidth}{\textwidth}
\addtolength{\headwidth}{-2em}%{-6pt}
\newlength{\@headheight} \setlength{\@headheight}{\headheight}
\newlength{\@headsep} \setlength{\@headsep}{0.7in}
\newlength{\@topmargin} \setlength{\@topmargin}{.91in}
\newlength{\@extraheadheight} \setlength{\@extraheadheight}{4\baselineskip}
\newcounter{reducedpagenumber}
\newlength{\@pagenumberwidth}


\if@compatibility\else\@settopoint\textwidth\fi
\setlength\lineskip{1pt}
\setlength\normallineskip{1pt}
\renewcommand\baselinestretch{1.655}
\def\resetbaselineskip{\def\baselinestretch{1}\large\normalsize\relax}

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

\displaywidth\textwidth
\linewidth\textwidth
\def\footnoterule{\kern-5.25pt\hrule width.5in\kern4.85pt}
\parskip 0pt plus 1pt
\columnsep 10pt
\columnseprule 0pt
\arraycolsep 3pt
\tabcolsep 2pt
\arrayrulewidth .4pt
\doublerulesep 2pt
\tabbingsep \labelsep
\fboxsep 3pt
\fboxrule .4pt

\setcounter{topnumber}{2}
\renewcommand\topfraction{.8}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEAD STYLES

\def\ps@headings{%
    \setlength{\headheight}{\@headheight}
    \let\@oddfoot\@empty \let\@evenfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\normalfont\hfil\rmfamily\thepage}%
    \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \thesection\quad\relax
        \fi
        ##1}
      }
    }
    \def\chaptermark##1{}
  }
\def\ps@myheadings{
    \setlength{\headheight}{\@headheight}
    \setlength{\topmargin}{\@topmargin}
    \setlength{\headsep}{\@headsep}
    \let\@oddfoot\@empty \let\@evenfoot\@empty
    \def\@evenhead{\normalfont\rmfamily\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\rightmark}\hfil\normalfont\rmfamily\thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble \let\subsectionmark\@gobble \let\chaptermark\@gobble
}

\def\ps@pretext{
    \setlength{\headheight}{\@headheight}
    \let\@oddfoot\@empty \let\@evenfoot\@empty
    \let\@evenhead{\normalfont\rmfamily\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\rightmark}\normalfont\hfil\rmfamily\thepage}
    \let\@mkboth\@gobbletwo
    \def\sectionmark##1{} \def\subsectionmark##1{} \def\chaptermark##1{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section Number Styles
%%
\setcounter{secnumdepth}{3}   %-- AOC depth setting
%\setcounter{secnumdepth}{3}  %-- Dist depth setting

\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

\renewcommand\thechapter      {\@arabic\c@chapter}
\renewcommand\thesection      {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand{\nohyphens}{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}

\newcommand\chapter{%
  \secdef\@chapter\@schapter}

%%% Parisa changed. \phantomsection required for the hyperref package to
%% work correctly. Also replace part by section to add to toc.
\def\@chapter[#1]#2{%

      \refstepcounter{chapter}%
      %\def\toclevel@section{0}
      \cleardoublepage
      \phantomsection
      \addcontentsline{toc}{chapter}{\thechapter.\hspace{1em}#1}
      \addtocontents{toc}{\vspace{ 9.5pt}}
      \def\toclevel@chapter{0}
    \markboth{}{}%
    {\ifnum \c@secnumdepth >-2\relax
       \flushleft\large\bfseries{CHAPTER~\thechapter.} % font size 14
     \fi
     \centering\large\bfseries\MakeUppercase{#2}\par}% font size 14
     %\vspace{2ex}{\hrule height 2pt}\vspace{7ex}
     \vspace{4.5ex}
}
\def\@schapter#1{%
    {
     \refstepcounter{chapter}%
     \centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand\section{
                   \@startsection {section}{2}{\z@}%
                   {3em}
                   {2em}
                   {\resetbaselineskip\normalfont\large\bfseries}} % font size 14

\newcommand\subsection{
                      \@startsection{subsection}{3}{\z@}%
                       {3em}%
                       {2em}
                       {\resetbaselineskip\normalfont\large\slshape}} % font size 14

\newcommand\subsubsection{
                         \@startsection{subsubsection}{4}{\z@}%
                         {-3.25ex\@plus -1ex \@minus -.2ex}%
                         {1.5ex \@plus .2ex}%
                         {\resetbaselineskip\normalfont\normalsize\bfseries}}
\setlength\leftmargini  {2.5em}
\leftmargin\leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}

\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\if@compatibility
  \newenvironment{titlepage}
    {\newpage \thispagestyle{empty} \setcounter{page}\z@}%
    {\if@restonecol\twocolumn \else \newpage \fi }
\else
  \newenvironment{titlepage}
    {\newpage \thispagestyle{empty} \setcounter{page}\@ne}%
    {\newpage \if@twoside\else\setcounter{page}\@ne\fi }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Appendix settings
%%  Compromises regarding appendix section headers made due to
%%  spacing conflicts with the TOC

\newcommand\appendix{\par
    \phantomsection
    \chapter*{\large{\MakeUppercase{Appendix}}}
    \addcontentsline{toc}{chapter}{\appendixname}
    \addtocontents{toc}{\vskip 9.5pt}
    \def\toclevel@chapter{0}
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \renewcommand\thesection{\@Alph\c@section.}
}


\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\@addtoreset{equation}{chapter}
\renewcommand\theequation{\@arabic\c@chapter.\@arabic\c@equation}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{figure}
\@addtoreset{figure}{chapter}
\renewcommand\thefigure{\@arabic\c@chapter.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}

\newenvironment{figure}
               {\@float{figure}} %% Modified by Pavan
               {\end@float}
\newenvironment{figure*}
               {\vskip 1.5em\@dblfloat{figure}}
               {\vskip .1em \end@dblfloat}     %{\vskip 3em\end@dblfloat}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{table}
\@addtoreset{table}{chapter}
\renewcommand\thetable{\@arabic\c@chapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}} %% Modified by Pavan
               {\end@float}
\newenvironment{table*}
               {\vskip 1.5em\@dblfloat{table}}
               {\vskip .1em \end@dblfloat}                   %{\vskip 3em \end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{1.5em} % jeff
\setlength\belowcaptionskip{0.0em} % changed from 0.5em by Pavan

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \reset@font\normalsize\normalfont\rmfamily
  \baselineskip 1\@ptsize pt \@plus 2pt \@minus 1pt
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip
}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

\newcommand\@pnumwidth{2.55em}
\newcommand\@tocrmarg{3.55em}
\newcommand\@dotsep{1.5}
\setcounter{tocdepth}{1}    %-- AOC: WSU guidelines05 depth
%\setcounter{tocdepth}{3}   %-- Dist depth
\def\tableofcontents{\chapter*{\centering \textbf{\large \contentsname}}\@starttoc{toc}}

\newcommand\listoffigures{
    \chapter*{\large\listfigurename\@mkboth{%
        \MakeUpperCase\listfigurename}{\MakeUpperCase\listfigurename}}
    \addcontentsline{toc}{chapter}{\listfigurename}    \@starttoc{lof}
}
\newcommand*\l@figure[2]{\vskip 9.5pt
            {\baselineskip 14.5pt
            \@dottedtocline{1}{1.5em}{2.3em}{#1}{#2}}}
\newcommand\listoftables{%
    \chapter*{\large\listtablename\@mkboth{%
        \MakeUpperCase\listtablename}{\MakeUpperCase\listtablename}}

    \addcontentsline{toc}{chapter}{\listtablename}
    \@starttoc{lot}%
}
\let\l@table\l@figure

%% AOC trying to fix the spacing - all previous settings are overwritten

\newcommand*\l@chapter{\@dottedtocline{0}{0em}{2.8em}}
\newcommand*\l@section{\vskip -9.5pt \@dottedtocline{1}{1.7em}{2.0em}}
\newcommand*\l@subsection{\@dottedtocline{2}{7em}{2.9em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7em}{3.8em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{11.1em}{4.7em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{16.1em}{5.7em}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIBLIOGRAPHY

\newdimen\bibindent
\setlength\bibindent{1ex}
\newenvironment{thebibliography}[1]
 {\chapter*{\large{\MakeUppercase\refname}%\refname
           \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
  \addvspace{2.0em \@plus\p@}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {\settowidth\labelwidth{\@biblabel{#1}}%
   \leftmargin\labelwidth
   \advance\leftmargin\labelsep
   \@openbib@code
   \usecounter{enumiv}%
   \let\p@enumiv\@empty
   \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy\clubpenalty4000\widowpenalty4000%
  \sfcode`\.\@m%
  \baselineskip 14.5pt
 }
 {\def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist%
  \resetbaselineskip
 }
\renewcommand{\@biblabel}[1]{[#1]\hspace{\bibindent}}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INDEX

\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOOTNOTE

\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}

\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \baselineskip 1\@ptsize pt
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\addtolength{\skip\footins}{1em \@plus 4\p@ \@minus 2\p@}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE

\newcommand\today{}
\edef\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi

\onecolumn

\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file `WSUThesis.cls'.
