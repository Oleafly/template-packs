%%%% Credits, acknowledgments, etc.
%%
%% This is a modified version of the file `report.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% classes.dtx  (with options: `report')
%% 
%% This is a generated file.
%% 
%% The source is maintained by the LaTeX Project team and bug
%% reports for it can be opened at https://latex-project.org/bugs.html
%% (but please observe conditions on bug reports sent to that address!)
%% 
%% 
%% Copyright (C) 1993-2021
%% The LaTeX Project and any individual authors listed elsewhere
%% in this file.
%% 
%% This file was generated from file(s) of the LaTeX base system.
%% --------------------------------------------------------------
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%% 
%% This file has the LPPL maintenance status "maintained".
%% 
%% This file may only be distributed together with a copy of the LaTeX
%% base system. You may however distribute the LaTeX base system without
%% such generated files.
%% 
%% The list of all files belonging to the LaTeX base distribution is
%% given in the file `manifest.txt'. See also `legal.txt' for additional
%% information.
%% 
%% The list of derived (unpacked) files belonging to the distribution
%% and covered by LPPL is defined by the unpacking scripts (with
%% extension .ins) which are part of the distribution.

%% Some parts of the USFDissertation.cls file, which was modified by David
%% E. Kephart (starting July 15th, 2004) and Daniel A. Cruz (starting March
%% 4th, 2019) have been adopted. In particular the title page and margin 
%% settings. Further modifications by Lina Fajardo Gómez starting on March
%% 22nd, 2022.

%% v.3.6:  Fixed the single/double spacing. _Finally_
%% v.3.5:  Removed hanging indents in long section/subsection headings
%% v.3.4:  Added \doublespacing and \singlespacing in main file. Bit of a hack but the commands built into TOC and friends were making the abstract and acknowledgments single spaced. 
%% v.3.3:  Changed \thispagestyle{empty} to \pagenumbering{gobble} in frontmatter chapters. Updated list of lcwords in preamble. Removed a topskip=0pt in chapter definition to fix a blank page at the end of the document and adjusted chaptoplen measurements to fix top margins. Fixed spacing in front matter.
%% v.3.2:  Margins are now consistent across different font sizes. No widow headings.
%% v.3.1:  Title case now implemented on chapters  Deleted a lot of unused
%%         or unnecessary options and commands. Also adjusted separation 
%%         between numbers and titles in the table of contents to scale with
%%         font size. 
%% v.3.0:  Now using tocloft for the table of contents and biblatex for
%%         the bibliography. Upper case for headings, title case for
%%         chapters, sections and subsections. Separated the document into 
%%         several files. In particular the style part of the preamble, 
%%         which supplements the style file, is set aside.
%%         
%% v.2.2b: cleaning up 2a, slightly, giving up on internal spacing of Table
%%         and Figure captions for right now...the mea culpa is included
%% v.2.2a: made bolding utterly consistent with USF's inconsistent scheme, 
%%         and made boldheadings affect Abstract, Chapter and section 
%%         headings, and the labels of floats. Sorry for earlier waffling
%%         on this, but bold is really the anathema of type-setting!!      
%% v.2.2:  fixed lists of tables and lists of figures to match USF's
%%         strenuous standards; also fixed vertical spacing in lot, lof; 
%%         also small bug (a missing \fi which hurt nothing but my 
%%         feelings)
%% v.2.1b: returned "fixes" of v.2.1a to correct settings, added some noise
%% v 2.1a: fixed bottom page margin (should stay the same for 8.x11 _only_)
%% v 2.11: fixed boldheadings to not bold ch ## in eqns
%%         added notes about tables, and a table to template file 
%% v 2.1:  added boldheadings option
%% v 2.0:  "final" made default, chapter entries in toc corrected, clean-up

%%%%  Title page entries
%%
%% In titlepage.tex, set the following:
%%
%% \title{`full length title`}         % of the dissertation!
%% \author{`name`}                     % you! (2 lines okay)
%% \degree{`spelled out`}              % what you are going for
%% \department{`dept`}                 % example: `Mathematics` 
%% \college{`college name`}            % example: `Arts and Sciences`
%% \university[`U of ...`]             % defaults to USF. there MUST be one
%% \majorprofessor{`name`}{`degree`}   % the major professor & their degree
%%                                     % if co-major professors use 
%%                                     % \mycomajorprofessorA and B
%% \chair{`name`}{`degree`}            % chairperson of your committee
%% \committeemember{`name`}{`degree`}  % for each member of your committee
%% \keyword{`key1`}{`key2`}...{`key5`} % ALL keywords (at least 5). 
%%      If there are more than five, include them in `key5` in the form:
%%                  `key5, key6, ..., keyN`     
%% \approvaldate{`date`}               % it ``was'' approved, wasn't it?
%%      Correct Format is Month Day, Year. Include it in your format check!
%% \copyrightdate{`date`}              % intellectual property...
%%      Correct Format is Year (only)... use the Gregorian calendar! }
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{USFDissertation}
              [2006/05/15 v3 University of South Florida Mathematics Department LaTeX dissertation class]

\usepackage{ifthen}
\usepackage{titlecaps} % For Title Case headings

\newlength{\h@rdreturn}
\newlength{\tempdim@}
\newcommand\@ptsize{}

\newif\if@titlepage

% Headings format
\newif\if@boldchapters
\newif\if@capschaps
\newif\if@boldcapschaps
\newif\if@boldsections

\newif\if@appendix
\newif\if@restonecol
\@titlepagetrue

%%%% Paper size. Since Spring 2019, MUST be letter.
\if@compatibility\else
  \DeclareOption{letterpaper}
     {\setlength\paperheight {11in}%
      \setlength\paperwidth  {8.5in}}
  \DeclareOption{landscape}
     {\setlength\@tempdima   {\paperheight}%
      \setlength\paperheight {\paperwidth}%
      \setlength\paperwidth  {\@tempdima}}
\fi
\newcommand{\chapsep}{1em}
\newcommand{\secsep}{1em}
\newcommand{\subsecsep}{1em}
\newcommand{\subsubsecsep}{1em}

\if@compatibility
  \renewcommand\@ptsize{0}
\else
  \DeclareOption{10pt}
  {\renewcommand\@ptsize{0}
   \renewcommand{\chapsep}{-0.7em}
   \renewcommand{\secsep}{0.3em}
   \renewcommand{\subsecsep}{1em}
   \renewcommand{\subsubsecsep}{1.8em}}
\fi
\DeclareOption{11pt}
  {\renewcommand\@ptsize{1}   
   \renewcommand{\chapsep}{-.5em}
   \renewcommand{\secsep}{0.5em}
   \renewcommand{\subsecsep}{1.3em}
   \renewcommand{\subsubsecsep}{2em}}
\DeclareOption{12pt}
  {\renewcommand\@ptsize{2}   
   \renewcommand{\chapsep}{-.4em}
   \renewcommand{\secsep}{0.83em}
   \renewcommand{\subsecsep}{1.5em}
   \renewcommand{\subsubsecsep}{2.2em}}
   
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
  \DeclareOption{notitlepage}{\@titlepagefalse}
\fi

\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}

\DeclareOption{boldheadings}{\@boldchapterstrue\@boldsectionstrue} % Bolding Abstract, Chapters, Sections and Caption Labels
\DeclareOption{plainheadings}{\@boldchaptersfalse\@boldsectionsfalse} % NOT bolding Abstract, Chapters, Sections and Caption Labels
\DeclareOption{allcaps}{\@capschapstrue\@boldchaptersfalse} % Make chapter headings all caps
\DeclareOption{boldcaps}{\@boldcapschapstrue\@boldsectionstrue} % Make chapter headings bold and all caps

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

% Importing front/main/back matter from the book class to fix page numbering
\newcommand\frontmatter{%
    \cleardoublepage
  \pagenumbering{roman}}

\newcommand\mainmatter{%
    \cleardoublepage
  \pagenumbering{arabic}}

\newcommand\backmatter{%
   \clearpage
   }

%%%% Default options loaded
\ExecuteOptions{letterpaper, 10pt}
\ProcessOptions

%%%% Layout
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\h@rdreturn{.9\baselineskip}
\usepackage[margin=1in]{geometry}

% Double-spacing is cleaner when done with a package
\usepackage{setspace}

\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%%%% Making a title page
\if@titlepage
  \newcommand\maketitle{
  \begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  % Custom title page here
  \centering
  \topskip=0pt
        % \vspace*{0.8in}
        \phantom{?}\vspace{4\h@rdreturn}\par
        \begin{doublespace}
        \titlecap{\@title}\par
        \end{doublespace}
        \vspace{3\h@rdreturn}\par
        by
        \par\vspace{3\h@rdreturn}\par
        \@author\par
        \vspace{4\h@rdreturn}\par
        {A dissertation submitted in partial fulfillment\\
         of the requirements for the degree of\\
        \mydegree\\
        Department of \mydepartment\\
        College of \mycollege\\
        \ifdefined\myuniversity
          \myuniversity
        \else
           University of South Florida
        \fi
        }
        \par\vspace{3\h@rdreturn}
        {
          \ifdefined\mymajorprofessor Major Professor: \mymajorprofessor \par \fi
          \ifdefined\mycomajorprofessorA Co-Major Professor:  \mycomajorprofessorA\par \fi
          \ifdefined\mycomajorprofessorB Co-Major Professor: \mycomajorprofessorB\par\fi
          \ifdefined\mycommitteememberA\mycommitteememberA\par\fi
          \ifdefined\mycommitteememberB\mycommitteememberB\par\fi
          \ifdefined\mycommitteememberC\mycommitteememberC\par\fi
          \ifdefined\mycommitteememberD\mycommitteememberD\par\fi
          \ifdefined\mycommitteememberE\mycommitteememberE\par\fi
        }
        \par\vspace{2\h@rdreturn}
        {Date of Approval:\par
             \myapprovaldate\par
        }
        \vspace{3\h@rdreturn}
        {Keywords: \mykeywords}
        \par\vspace{\h@rdreturn}
        {Copyright $\copyright$ \mycopyrightdate, \@author}

        \end{titlepage}%
        \setcounter{footnote}{0}%
        \global\let\thanks\relax
        \global\let\maketitle\relax
        \global\let\@thanks\@empty
        \global\let\and\relax
        }
\fi

%%%% Sectioning commands
\DeclareRobustCommand{\MakeBold}[1]{\bfseries{#1}}
\DeclareRobustCommand*{\MakeTitlecase}[1]{\titlecap{#1}}

\@boldchapterstrue
\if@boldchapters\newcommand{\chapfont}[1]{\MakeBold{#1}}
  \else\if@capschaps \newcommand{\chapfont}[1]{\MakeUppercase{#1}}
    \else\if@boldcapschaps\newcommand{\chapfont}[1]{\MakeUppercase{\MakeBold{#1}}}
      \else \newcommand{\chapfont}[1]{#1}
    \fi
  \fi
\fi

\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand\thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}

\newcommand\chapter{\clearpage
                    \doublespacing 
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter
                  }

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                            {\@chapapp~\protect\numberline{\thechapter:}\titlecap{#1}}%
                    \else
                      \addcontentsline{toc}{chapter}{\titlecap{#1}}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{0\p@}}%
                    \addtocontents{lot}{\protect\addvspace{0\p@}}%
                    \@makechapterhead{#2}%
                    \@afterheading
                    }

% Adjusting the margins when creating a chapter heading
\newlength\chaptoplen
\setlength\chaptoplen{\dimexpr \topskip+\baselineskip-1in\relax}
\newlength\schaptoplen
\setlength\schaptoplen{\dimexpr\topskip+\baselineskip-1in\relax}
%%%% Special chapter heads required
\def\@makechapterhead#1{%
  \begingroup
  \vspace*{-\chaptoplen}
     \centering
     \ifnum \c@secnumdepth >\m@ne
      \chapfont{\@chapapp \space \thechapter:}
      % \par
     \nobreak
     \fi                
        \interlinepenalty\@M
          \chapfont{\titlecap{#1}}
          \par\nobreak 
       \endgroup
  \vspace{\baselineskip}
  }
\def\@schapter#1{%
  \@makeschapterhead{#1}%
  \@afterheading
}
\def\@makeschapterhead#1{%
  \begingroup
  \vspace*{-\schaptoplen}
    \centering
       \interlinepenalty\@M
          \chapfont{\titlecap{#1}}
       \par\nobreak % 
  \endgroup
    \vspace{1\h@rdreturn}%
}

\@boldsectionsfalse

\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\if@boldsections\bfseries\else\normalfont\fi}}

% Subsection headings are indented to be different from section headings                       
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                    {\if@boldsections\bfseries\else\normalfont\fi}}

\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1em \@plus .2ex}%
                                     {\if@boldsections\bfseries\else\normalfont\fi\itshape}}

\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {1em \@plus.2ex}%
                                    {\itshape}}

\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\itshape}}

%% There is no good way to implement sentence case, since proper names will not
%% be recognized and the list of exceptions would be endless

\setlength\leftmargini  {2.5em}
\leftmargin  \leftmargini
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
\newcommand\labelitemi  {\labelitemfont \textbullet}
\newcommand\labelitemii {\labelitemfont \bfseries \textendash}
\newcommand\labelitemiii{\labelitemfont \textasteriskcentered}
\newcommand\labelitemiv {\labelitemfont \textperiodcentered}
\newcommand\labelitemfont{\normalfont}

%%%% Names
\newcommand\contentsname{Table of Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}

% USF Dissertation specific
\newcommand\dedicationname{Dedication}
\newcommand\acknowledgmentsname{Acknowledgments}
\newcommand\bioname{About the Author}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont#1}

\newenvironment{abstract}{%
  \clearpage
  \begin{doublespace}
  \chapter*{\abstractname}
  \phantomsection%adds hyperref anchor
\addcontentsline{toc}{chapter}{\abstractname}
}
{\end{doublespace}}

%% Optional environments
%  dedication (optional)        To [person]/In Memory of [person]
% acknowledgments (optional)   Intelectual debts acknowledged
%  bio (optional)               ``About the author'' page

\newenvironment{dedication}{%
  \clearpage
  \begin{doublespace}
  \chapter*{\dedicationname}
  \thispagestyle{empty}  
}{\end{doublespace}}
\newenvironment{acknowledgments}{%
  \clearpage
  \begin{doublespace}
  \chapter*{\acknowledgmentsname}
  % \thispagestyle{empty/
  \pagenumbering{gobble} %omit page numbers even if the acknowledgments run for more than one page.
}{\end{doublespace}}

\newenvironment{bio}{%
  \clearpage
  \begin{doublespace}
  \chapter*{\bioname}
  \thispagestyle{empty}
    \pagenumbering{gobble} %omit page numbers even if the bio runs for more than one page.
}
{\end{doublespace}}

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
    {%
      \@restonecolfalse\newpage
      \thispagestyle{empty}%
      \setcounter{page}\@ne\relax
    }%
    {\eject
      \setcounter{page}\@ne\relax
    }
\else
  \newenvironment{titlepage}
    {%
      \@restonecolfalse\newpage
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {
      \setcounter{page}\@ne
    }
\fi
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \@appendixtrue
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}

\newcounter{figure}
\renewcommand \thefigure
     {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
              {\@float{figure}}
              {\end@float}
\newenvironment{figure*}
              {\@dblfloat{figure}}
              {\end@dblfloat}
\newcounter{table}
\renewcommand \thetable
     {\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
              {\@float{table}}
              {\end@float}
\newenvironment{table*}
              {\@dblfloat{table}}
              {\end@dblfloat}
              
%%% New
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}  
%%% In case there are any deprecated stragglers... 
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

%%%% The table of contents and friends
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}

\def\@pnumwidth{0.5in}
\def\@tocrmarg{1.0in}

\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \clearpage
    \pagenumbering{roman}
    \pagestyle{plain}
    \@restonecolfalse
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    }
    
\newcommand*\l@abstract{%
  \vskip 1em \@plus.2\p@\@dottedtocline{0}{0in}{2.3em}
  }

% Hopefully doesn't need changes beyond what tocloft can do
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil
      \nobreak\hb@xt@\@pnumwidth{\hss #2%
                                 \kern-\p@\kern\p@}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

\newcommand\listoffigures{
    \clearpage
      \@restonecolfalse
    \chapter*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    }

\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \clearpage
      \@restonecolfalse
    \chapter*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
    }


\newcommand\contents{%
    %% Insert a table of contents
    \begin{singlespace}
    \tableofcontents
    \end{singlespace}


    % Adjust right margin (between dots and page numbers columns)
    \def\@pnumwidth{0.5in}
    \def\@tocrmarg{1.0in}

    %% Insert a table of tables -- comes before figures in the format.
    % The tocloft package does not include a clear page, so we override that here.
    \clearpage
    \addcontentsline{toc}{chapter}{List of Tables}% Print LOT in TOC
    \listoftables


    %% Insert a table of figures
    \clearpage
    \addcontentsline{toc}{chapter}{List of Figures}% Print LOF in TOC
    \listoffigures
}

\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\bibname}{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\@restonecoltrue
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
 
% Leaving LOT and LOF to tocloft package
% All formatting happens here
\usepackage{tocloft}
\renewcommand{\cfttoctitlefont}{\hfill\normalfont}
\renewcommand{\contentsname}{\chapfont{Table of Contents}}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\normalfont}
\renewcommand{\listtablename}{\chapfont{List of Tables}}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\normalfont}
\renewcommand{\listfigurename}{\chapfont{List of Figures}}
\renewcommand{\cftafterloftitle}{\hfill}

% Reset fonts so they appear plain in the TOC
\renewcommand{\cftchapfont}{\normalfont}
\setlength{\cftparskip}{\baselineskip}

% Adjust length from top of page to heading
\setlength{\cftbeforetoctitleskip}{-\baselineskip}
\addtolength{\cftbeforetoctitleskip}{1in}
\setlength{\cftbeforelottitleskip}{-\baselineskip}
\addtolength{\cftbeforelottitleskip}{1in}
\setlength{\cftbeforeloftitleskip}{-\baselineskip}
\addtolength{\cftbeforeloftitleskip}{1in}
% Adjust length from heading to first line
\setlength{\cftaftertoctitleskip}{\baselineskip}
\setlength{\cftafterlottitleskip}{\baselineskip}
\setlength{\cftafterloftitleskip}{\baselineskip}

% Format LOT and LOF titles
\renewcommand{\cftfigpresnum}{\figurename~}
\renewcommand{\cfttabpresnum}{\tablename~}
\renewcommand{\cftfigaftersnum}{:}
\renewcommand{\cfttabaftersnum}{:}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapleader}{\normalfont\cftdotfill{\cftchapdotsep}}

% Adjust spacing between section numbers and titles
\renewcommand{\cftchapaftersnumb}{\hspace*{\chapsep}} 
\renewcommand{\cftsecaftersnumb}{\hspace*{\secsep}}
\renewcommand{\cftsubsecaftersnumb}{\hspace*{\subsecsep}}
\renewcommand{\cftsubsubsecaftersnumb}{\hspace*{\subsubsecsep}}


% As depth increases, so does indentation by 0.5in
\setlength{\cftsecindent}{0.5in}
\setlength{\cftsubsecindent}{1in}
\setlength{\cftsubsubsecindent}{1.5in}

% Single line spacing within chapter in TOC
\setlength\cftparskip{-2pt}

% Extra long titles have a hanging indentation of 0.25in
\setlength{\cftchapnumwidth}{0.25in}
\setlength{\cftsecnumwidth}{0.25in}
\setlength{\cftsubsecnumwidth}{0.25in}
\setlength{\cftsubsubsecnumwidth}{0.25in}


% For the LOT and LOF, titles start 0.75in from left margin
\setlength{\cfttabnumwidth}{0.75in}
\setlength{\cfttabindent}{0 em} 
\setlength{\cftfignumwidth}{0.75in}
\setlength{\cftfigindent}{0 em} 

% Line breaks on long titles 0.5in from right edge of page numbers in TOC
\renewcommand{\@tocrmarg}{0.5in}

% Entries in LOT and LOF are one line apart
\setlength\cftbeforefigskip{\baselineskip}
\setlength\cftbeforetabskip{\baselineskip}


%%%% Other formatting bits and bobs: spacing, window/orphan line management, appendix 
% Adjusting figure/table captions
\usepackage{caption}

% \usepackage{inputenc}

\usepackage{float}

\usepackage[titletoc]{appendix}

% The option nobottomtitles prevents widow headings.
\usepackage[nobottomtitles]{titlesec}

% Remove hanging indents in long headings
\titleformat{name=\section}[block]
  {\if@boldsections\bfseries\else\normalfont\fi}{\thesection}{2em}{\hspace{-1em}}{}
\titleformat{name=\subsection}[block]
  {\if@boldsections\bfseries\else\normalfont\fi}{\thesubsection}{2em}{\hspace{-1em}}{}  

% Adding Title Case to section and subsection headings.
\let\oldsection\section
\def\section#1{\oldsection{\titlecap{#1}}}
\let\oldsubsection\subsection
\def\subsection#1{\oldsubsection{\titlecap{#1}}}

% No widows or orphan lines, hopefully. This defaults to at least 2 lines at a page break but you can change that. 
\usepackage[all]{nowidow}

% Adjusting figure and table captions and titles
\captionsetup[figure]{name=Figure, labelsep=colon, labelfont = {bf, singlespacing}, labelformat=default, position=bottom}

% The position=top option only adds vertical space to fit the caption. For the correct placement, include the \caption command before the table starts, right after \begin{table}.
\captionsetup[table]{name=Table, labelsep=colon, labelfont = {bf, singlespacing}, labelformat=default, position=top}


% The position=top option only adds vertical space to fit the caption. For the correct placement, include the \caption command before the table starts, right after \begin{table}.
% \captionsetup[lstlisting]{name=Figure, labelsep=colon, labelfont = {bf, singlespacing}, labelformat=default, position=top}

% Number subsubsections

\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{2}
\pagestyle{plain}

\pagenumbering{arabic}
  \raggedbottom
\endinput


%%
%% End of file `USFDissertation.cls'.

