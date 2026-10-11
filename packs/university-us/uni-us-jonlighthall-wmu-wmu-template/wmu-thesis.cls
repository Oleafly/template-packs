%%-------------------Emacs PostScript "pretty-print" page width (97 columns)-------------------%%
%% WMU-compliant Thesis Template
%% Copyright 2011 2012 2016 2019 Jon Lighthall, Ph.D.
%
%  This work may be distributed and/or modified under the 
%  conditions of the LaTeX Project Public License, either version 1.3c
%  of this license or (at your option) any later version.
%  The latest version of this license is in
%     http://www.latex-project.org/lppl.txt
%  and version 1.3 or later is part of all distributions of LaTeX
%  version 2005/12/01 or later.
%
%  This work has the LPPL maintenance status `maintained'.
% 
%  The Current Maintainer of this work is Jon Lighthall, jon.lighthall@gmail.com
%
%% This file is `wmu-thesis.cls', based on the `book.cls' standard class file.
%%
%% Modifications to book.cls:
%% --------Version 1.0-------------(submitted 10/03/11)----------
%% * Automatic generation of front matter (based on document class options)
%%    - Abstract
%%    - Title Page
%%    - Copyright Page
%%    - Acknowledgments
%%    - Table of Contents
%%       + Leader dots after chapter headings
%%    - List of Tables
%%    - List of Figures
%% * Layout formatting
%%    - 1.25" left margin, 1.00" other margins (default)
%%    - 1.75" top margin on abstract, title page
%%    - 1.25" top margin on second page of abstract
%%    - centered header on second pages of acknowledgments, TOC, LOT, LOF
%%    - 1.25" header margin on second pages of acknowledgments, TOC, LOT, LOF
%%    - [blank] document class for two-sided printing
%% * One Appendix handling
%%    - TOC entry is simply APPENDIX
%%    - chapter number removed in chapter heading
%%    - chapter number removed from page heading
%% * Multiple Appendix handling
%%    - APPENDICES heading in TOC
%%    - Appendices page divider
%% --------Version 1.1-------------(submitted 10/13/11)----------
%% * Packages
%%    - Modern font support (utf8 input encoding, T1 encoding, textcomp)
%%    - include amsmath, indentfirst
%%    - support for hyperref
%% * Layout formatting
%%    - improved handling of double-sided pages
%%    - headings removed (page-number-only pagestyle) in main matter
%%    - no tables or figures from appendix in LOT or LOF
%% --------Version 1.2-------------(submitted 10/17/11)----------
%% * Robust margins support for 11pt and 12pt font options
%% * Subtle alterations (corrections) to vertical spacing
%%    - inclusion [orig] option to reproduce vertical spacing in JC_Lighthall_Thesis
%%    - use of {margins} environment to change \textheight in \frontmatter
%%    - \doublespacing is called by default
%% --------Version 1.21------------(updated 10/19/11)------------
%% * The command \projecttype is used on the title page.
%% --------Version 1.22------------(updated 10/19/11)------------
%% * Updated [orig] option
%%    - tocspace defined for TOC (not used)
%%    - Appendices are in a new part
%% --------Version 1.3-------------(updated 06/19/12)------------
%% * Settings for the [twoside] option are repaired
%%    - Corrected values of \evensidemargin, \marginparwidth, and \marginparsep 
%%    - \raggedbottom included to make vertical spacing identical
%% --------Version 1.4-------------(updated 09/17/16)------------SVN-937
%% * [abslist] option added
%%    - replaces orig behavior in abstract
%%    - added handling for supertabular environments 
%%
%% This is file `book.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% classes.dtx  (with options: `book')
%% 
%% This is a generated file.
%% 
%% Copyright 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
%% The LaTeX3 Project and any individual authors listed elsewhere
%% in this file.
%% 
%% This file was generated from file(s) of the LaTeX base system.
%% --------------------------------------------------------------
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
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
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{wmu-thesis}
              [2016/09/17 v1.4
                Custom LaTeX document class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
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
%% Vertical spacing on the Title Page----------------------------
%  The spacing on the Title Page is specified as 'about' ten lines.  However, for font sizes over
%  10pt, the \stretch command is used because 30 blank lines will not fit.
\newcommand{\titlespace}{10.0\baselineskip}
\newlength{\fontskip}% adjust \headheight based on font size
\newlength{\newtocskip}% 
\setlength{\newtocskip}{30pt}
\DeclareOption{11pt}{
  \renewcommand\@ptsize{1}
  \renewcommand{\titlespace}{\stretch{1}}
  \addtolength{\fontskip}{1.6pt}
  \setlength{newtocskip}{27.5pt}
}
\DeclareOption{12pt}{
  \renewcommand\@ptsize{2}
  \renewcommand{\titlespace}{\stretch{1}}
  \addtolength{\fontskip}{2.5pt}
  \setlength{newtocskip}{25pt}
}
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
\if@compatibility
\@openrighttrue
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
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
%% Switches------------------------%-----------------------------
\newif\if@abstract
\newif\if@ackno
\newif\if@listtab
\newif\if@listfig
\newif\if@abslist
\newif\if@orig %set minor formatting changes present in original dissertation

%% Name commands-------------------%-----------------------------
\newcommand{\authname}{Author Name}
\newcommand{\thesistitle}{Thesis Title}
\newcommand{\gradyear}{2011}
\newcommand{\gradmonth}{6} 
\newcommand{\departmentname}{Department Name}
\newcommand{\adviname}{Advisor Name, Ph.D.}

%% Degree names------------------%-------------------------------
\newcommand{\engineer}{}%
\newcommand{\degree}{}%
\newcommand{\degreename}{}%
\newcommand{\projecttype}{}%

%% Package options-----------------%-----------------------------
\DeclareOption{blank}{
\if@twoside
  \if@openright
    \def\cleardoublepage{
      \clearpage
      \if@twoside 
      \ifodd\c@page\else
       \hbox{}
       \thispagestyle{empty}%remove headers and footers from blank pages
       \newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
  \fi
\fi
}

\DeclareOption{abstract}{\@abstracttrue  \@mparswitchtrue}
\DeclareOption{ackno}{\@acknotrue  \@mparswitchtrue}
\DeclareOption{listtab}{\@listtabtrue  \@mparswitchtrue}
\DeclareOption{listfig}{\@listfigtrue  \@mparswitchtrue}
\DeclareOption{abslist}{\@abslisttrue  \@mparswitchtrue}
\DeclareOption{orig}{%
  \@origtrue  \@mparswitchtrue
  \@abslisttrue  \@mparswitchtrue
}

\DeclareOption{ma}{%
\renewcommand{\degree}{M.A.}%
\renewcommand{\degreename}{Master of Arts}%
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{mfa}{%
\renewcommand{\degree}{M.F.A.}%
\renewcommand{\degreename}{Master of Fine Arts}%
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{mm}{%
\renewcommand{\degree}{M.M.}%
\renewcommand{\degreename}{Master of Music}%
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{ms}{%
\renewcommand{\degree}{M.S.}%
\renewcommand{\degreename}{Master of Music}%
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{mse}{%
\renewcommand{\degree}{M.S.E.}%
\renewcommand{\degreename}{Master of Science in Engineering}%
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{msec}{%
\renewcommand{\degree}{M.S.E.}%
\renewcommand{\degreename}{Master of Science in Engineering}%
\renewcommand{\engineer}{~(Computer)}
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{msee}{%
\renewcommand{\degree}{M.S.E.}%
\renewcommand{\degreename}{Master of Science in Engineering}%
\renewcommand{\engineer}{~(Electrical)}
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{msei}{%
\renewcommand{\degree}{M.S.E.}%
\renewcommand{\degreename}{Master of Science in Engineering}%
\renewcommand{\engineer}{~(Industrial)}
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{msem}{%
\renewcommand{\degree}{M.S.E.}%
\renewcommand{\degreename}{Master of Science in Engineering}%
\renewcommand{\engineer}{~(Mechanical)}
\renewcommand{\projecttype}{Thesis}%
\renewcommand{\thesistitle}{THESIS TITLE}
}
\DeclareOption{eds}{%
\renewcommand{\degree}{Ed.S.}%
\renewcommand{\degreename}{Specialist in Education}%
\renewcommand{\projecttype}{Project}%
\renewcommand{\thesistitle}{PROJECT TITLE}
}
\DeclareOption{edd}{%
\renewcommand{\degree}{Ed.D.}%
\renewcommand{\degreename}{Doctor of Education}%
\renewcommand{\projecttype}{Dissertation}%
\renewcommand{\thesistitle}{DISSERTATION TITLE}
}
\DeclareOption{phd}{%
\renewcommand{\degree}{Ph.D.}%
\renewcommand{\degreename}{Doctor of Philosophy}%
\renewcommand{\projecttype}{Dissertation}%
\renewcommand{\thesistitle}{DISSERTATION TITLE}
}
\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final,openany}
\ProcessOptions
%% Required packages-------------%-------------------------------
%  The following packages are required in order for this template to work
\RequirePackage{amsmath}
\RequirePackage{fmtcount,datetime} %provides commands for displaying times and dates
\RequirePackage{setspace} %required for double spacing and used to control vertical spacing 
\RequirePackage{fancyhdr} %required for non-standard (fancy) headers
\RequirePackage{indentfirst} %indents first paragraph of each section

%% Text packages-----------------%-------------------------------
\usepackage{textcomp,lmodern}%for special symbols 
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}%modern font encoding
\providecommand{\draftno}{}
\input{bk1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
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
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}

%% Hyperlinks--------------------%-------------------------------
\AtEndOfPackage{
 \RequirePackage{hyperref}
}

\AtBeginDocument{
  \hypersetup{%
	bookmarksopen=true,            %Displays Bookmarks in the Navigation Panel
	bookmarksopenlevel=0,          %\maxdimen all levels, 0 chapters, 1 sections
	bookmarksnumbered=true,        %Numbers bookmarks with section numbers
	colorlinks=true,               %colors the links instead of using boxes
	urlcolor=blue,                 %makes URL hyperlinks blue (instead of pink)
	linkcolor=black,               %makes internal links black (instead of red)
	citecolor=black,               %makes citation links black (instead of green)
  }
}

%% Margins-----------------------%-------------------------------
%% The WMU guidlines are contradictory when it comes to margins.  The left-hand margin is either
%  required to be 1.5 inches excatly, or at least 1.5 inches.  The margins on the remaining 
%  sides must be at least 1.0 inch.  The following lines set the margins to maximum limits.

%% The following commands set the margins to their default for 10pt font for a one-sided book.
\setlength{\oddsidemargin}{62pt}
\setlength{\evensidemargin}{62pt}
\setlength{\topmargin}{22pt}
\setlength{\headsep}{18.06749pt}
\setlength{\textheight}{550pt}
\setlength{\textwidth}{345pt}
\setlength{\marginparwidth}{69pt}
\setlength{\footskip}{25.29494pt}
\setlength{\marginparpush}{5pt} %was 7pt in v1.21, why!?

%% For narrow margins (word processor style), set margins below.
\addtolength{\textwidth}{1.5in}   %increase text width to 6in
\addtolength{\textheight}{1.75in} %increase text width to 9in
\addtolength{\hoffset}{-0.4375in} %decrease left margin to 1.5in
\addtolength{\voffset}{-0.875in}  %decrease top margin to 1.0in
\reversemarginpar %Moves margin notes to the wider margin

%% Double-sided------------------%-------------------------------
%  Formatting for double-sided printing is prohibited by the WMU guidelines, however it produces
%  much better results when printing double-sided (i.e. in bound, printed book form).

%  For double-sided documents, include the document class option [twoside].
%  To allow chapters to open on even pages (to preserve pagination), include the document class 
%  option [openany].

%  For double-sided documents with narrow margins, set margins below.  These margin settings 
%  leave the odd-page margins unchanged while increasing the even-page left-hand margins by 
%  0.5 inches so that the margins are the same on both sides of the page.
\if@twoside
 \setlength{\oddsidemargin}{62pt}     %keep 1.5in left margin on odd pages
 \setlength{\evensidemargin}{89pt}    %restore default even-side margin for twoside
 \addtolength{\evensidemargin}{-1in}  %decrease left margin to 1.5in on even pages
 \setlength{\marginparwidth}{125pt}   %restore default margin paragraph width for twoside
 \addtolength{\marginparwidth}{-56pt} %keep 69pt margin paragraph width
\fi
\newlength{\titleskip} %places title 1.75" from top of page on Abstract and Title Page
\newlength{\tocskip}   %places TOC header 1.25" from top of page      
\newcommand{\tocspace}{}
\if@orig
%  based on ruler (PDF)
\setlength{\titleskip}{51pt}
\setlength{\tocskip}{60pt}
\else
%  based on measurements (printed)
\setlength{\titleskip}{35pt}
\setlength{\tocskip}{42pt}
\fi
\newlength{\abstskip}  %places Abstract text on the second page 1.25" from the top of the page
\setlength{\abstskip}{0pt}
\newcommand{\absthead}{
	\addtolength{\abstskip}{\headheight}%add
	\addtolength{\abstskip}{\headsep}
	\addtolength{\abstskip}{2pt}
	}
\newcommand{\addhead}[1]{%
\addtolength{\voffset}{#1}%
%\addtolength{\textheight}{-#1}%
\addtolength{\titleskip}{-#1}%
}
\newenvironment{margins}{\addtolength{\textheight}{-\tocskip}}{}
\addtolength{\headheight}{\fontskip}
%\doublespacing %standard word processor doublespace
\newcommand\frontmatter{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
%% Front matter--------------------%-----------------------------
\newdate{graddate}{1}{\gradmonth}{\gradyear}
\addhead{\tocskip}
\pagestyle{empty}%no headers, footers, or page numbers                     
\newdateformat{abstdate}{\THEYEAR}%date used in Abstract and Copyright Page
\if@abstract
\setcounter{page}{25}%Set here a number greater than the number of pages in the front matter (to 
                     %avoid 'destination with the same identifier' error from hyperref).  This number should be odd.

\enlargethispage{-\tocskip}
\begin{singlespace}%This environment declaration is required for proper formatting of the title,
                   %independent of the body formatting.
\begin{center}
\vspace*{\titleskip}
\thesistitle\\
\vspace*{2.0\baselineskip}%triple space
\authname, \degree\\
\vspace*{1.0\baselineskip}%double space
Western Michigan University, \abstdate\displaydate{graddate}%triple space
\end{center}%Ending the center environment creates an automatic double space.  The next line is 
            %also double spaced, so the result is the desired triple space.
\begin{spacing}{2}
%  Enter the text of the abstract below.
\InputIfFileExists{abstract_body}{}{
\begin{quote}
\begin{center}
\rule[0 pt]{1\linewidth}{0.5pt}
\noindent Warning---document class option \texttt{[abstract]} is called, but no abstract is file found.  Place the body of the abstract in a file named
\texttt{abstract\_body.tex}.
The text on this page will automatically be replaced with the contents of the file \texttt{abstract\_body.tex} when said file is saved in the present working directory.\\
\rule[0 pt]{1\linewidth}{0.5pt}
\end{center}
\end{quote}
\par The abstract is a succinct statement of the problem, methodology, findings, and conclusions of
the study. The author should prepare the content of the abstract with care; doctoral abstracts
are published and distributed nationally and internationally exactly as submitted. Abstracts are
written in present tense. Users who review indices to dissertations use the abstract to
determine the value and relevance of the study. The Graduate College reserves the right to edit
text of abstracts as needed to ensure quality of scholarly writing.

The abstract of a doctoral dissertation must not exceed 350 words and must be complete on
two pages. \textbf{If your dissertation abstract exceeds the 350-word limit, it will be 
shortened by ProQuest/UMI editors.}
%\pangram{30}
}
%\input{abstract_body}
\end{spacing}
\end{singlespace}
%% Margins will break down if abstract is over two pages.
\makeatletter
  \ifodd\c@page %adjust page margin on second page (only) of abstract.  
  \else
    \absthead 
  \fi
\makeatother
\addtolength{\voffset}{-\abstskip}
%% end abstract file
\fi
 
\cleardoublepage
\addtolength{\voffset}{\abstskip}
%\include{title_page}%Title page
\setcounter{page}{1}
\newdateformat{titldate}{\monthname[\THEMONTH]~\THEYEAR}
\begin{singlespace} %This environment declaration is required to achieve the desired vertical spacing
\begin{center}
\vspace*{\titleskip}
\thesistitle
\draftno\\
\vspace{\titlespace}
by\\
\vspace{1.0\baselineskip}
\authname\\
\vspace{\titlespace}
A \projecttype\\
Submitted to the\\
Faculty of The Graduate College\\
in partial fulfillment of the\\
requirements for the\\
Degree of \degreename\engineer\\
\departmentname\\
Advisor: \adviname\\
\vspace{\titlespace}
Western Michigan University\\
Kalamazoo, Michigan\\
\titldate\displaydate{graddate}\\
\end{center}
\end{singlespace}
\enlargethispage{- \tocskip}

%\include{copyright}%Copyright page
\clearpage
%% Copyright page
\setcounter{page}{0}  %this page is not included in the page numbering
\enlargethispage{-2\tocskip}
\vspace*{\stretch{1}} %text will be centered vertically on page
\begin{center}
\copyright~\authname~\abstdate\displaydate{graddate}\\
\end{center}
\vspace*{\stretch{1}}

%% Headings----------------------%-------------------------------
%  In the front matter, starting with the Acknowledgments, any section longer than one page in 
%  length requires a centered heading with upper- and lower-case titles.  The fancyhdr package
%  is required for this.

\pagestyle{fancy} %needed for non-standard centered headings in front matter
\lhead{}
\rhead{}
\renewcommand{\headrulewidth}{0.0pt}
\cfoot{\thepage} %all front matter uses roman numerals, centered at the bottom of the page
%% The following environment is necessary to reduce the textheight by tocskip within the front
%  matter without interfering with main matter vertical spacing.
\begin{margins} 
  \clearpage
  \if@twoside
   \if@openright
    \setcounter{page}{3}%preserve odd-on-right page numbering    
   \else \setcounter{page}{2}%This is the first numbered page, and must be "page ii"	    
   \fi
   \else
    \setcounter{page}{2}%This is the first numbered page, and must be "page ii"	    
   \fi

\if@ackno
\enlargethispage{-\tocskip}
%% Acknowledgments---------------%-------------------------------
\newcommand{\aknoname}{Acknowledgments}
\chead{\aknoname---Continued}
\if@orig
\begin{singlespace}%include chapter command within singlespace to keep ackno. to one page
\chapter[\texorpdfstring{\uppercase{\aknoname}}{\aknoname}]{\vspace{-\tocskip}\aknoname}
\else
\chapter[\texorpdfstring{\uppercase{\aknoname}}{\aknoname}]{\vspace{-\tocskip}\aknoname}
\begin{singlespace}%This environment declaration is redundant unless doublespacing is used
\fi
\begin{spacing}{2}
\InputIfFileExists{acknowledgments_body}{}{
\begin{quote}
\begin{center}
\rule[0 pt]{1\linewidth}{0.5pt}
\noindent Warning---document class option \texttt{[ackno]} is called, but no acknowledgments is file found.  Place the body of the acknowledgments in a file named
\texttt{acknowledgments\_body.tex}.
The text on this page will automatically be replaced with the contents of the file \texttt{acknowledgments\_body.tex} when said file is saved in the present working directory.\\
\rule[0 pt]{1\linewidth}{0.5pt}
\end{center}
\end{quote}
\par Although acknowledgments are optional, they are a courteous way of recognizing people to
whom the author is indebted for guidance, assistance, or special aid, including faculty mentors,
colleagues, friends, and family members. The acknowledgments should be expressed simply and
tactfully. It is best practice to secure permission of those to be cited in acknowledgments.
}
%\input{acknowledgments_body}
\end{spacing}
\vspace*{1.0\baselineskip}%The previous section is double spaced, so only an additional double-space is required to achieve the desired triple space.
\noindent\hspace*{0.5\textwidth}\authname%Author name with left-hand side at center
\end{singlespace}
\fi%\include{acknowledgments}

%% Table of Contents-------------%-------------------------------
%  The Table of Contents is not supposed to have an entry in the Table of Contents, but it is 
%  useful in the final PDF output.
\setcounter{tocdepth}{2}%Sets table of contents "depth" to include "Level 3 Headings"
\renewcommand \contentsname{Table of Contents}
\clearpage
\phantomsection
\pdfbookmark[0]{\contentsname}{\contentsname}
\chead{\contentsname---Continued}
\let\contname\contentsname
\renewcommand \contentsname{\vspace{-\tocskip}\contname}
\if@orig
%\begin{spacing}{\tocspace} %set single spacing in TOC
\fi
\tableofcontents
\if@orig
%\end{spacing}
\fi
\if@listtab
%% List of Tables----------------%-------------------------------
\cleardoublepage
\phantomsection
\chead{\listtablename---Continued}
\let\listtname\listtablename
\renewcommand \listtablename{\vspace{-\tocskip}\listtname}
\addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{\listtname}}{\listtname}}
\listoftables
\fi

\if@listfig
%% List of Figures---------------%-------------------------------
\cleardoublepage
\phantomsection
\chead{\listfigurename---Continued}
\let\listfname\listfigurename
\renewcommand \listfigurename{\vspace{-\tocskip}\listfname}
\addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{\listfname}}{\listfname}}
\listoffigures
\fi
\end{margins}
}
\newcommand\mainmatter{%
    \cleardoublepage
    \if@mainmatter
    \else
      \addhead{-\tocskip}%added
    \fi
  \@mainmattertrue
  \pagenumbering{arabic}
  
%% Headings----------------------%-------------------------------
%  The LaTeX-default 'headings' page style for one-sided printing displays the chapter title 
%  on each page.  The fancyhdr package redefines the default behavior to display the section 
%  title on each page (and modifies the page layout).  To maintain the default behavior of the 
%  headings page style in one-sided printing while using the fancyhdr package, the following
%  lines are needed.  However, the default behavior of the headings page style is unchanged by
%  the fancyhdr package for two-sided printing.

  \if@twoside
    \pagestyle{headings}
  \else
    \pagestyle{fancy}
    \addtolength{\voffset}{4pt}
    \addtolength{\headsep}{-4pt}
    \renewcommand{\headrulewidth}{0.0pt}
    \fancyhf{}
    \if@orig 
      \lhead{\textsl{\leftmark}} %No headings!!! 
    \else  
   %   \lhead{\textsl{\leftmark}} %No headings!!! 
    \fi
    \rhead{\thepage} %restore default single-sided behavior
  \fi
}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse}
\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright
                \null
                \thispagestyle{empty}%
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
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
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
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
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
%% Appendix commands-------------%-------------------------------
% Turn captions on or off in the TOC for figures, tables, supertabulars
\if@abslist \else
\long\def\@caption##1[##2]##3{%remove tables and figures from TOC
  \par
  %\addcontentsline{\csname ext@##1\endcsname}{##1}%
   %{\protect\numberline{\csname the##1\endcsname}{\ignorespaces ##2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@##1\endcsname}{\ignorespaces ##3}\par
    \endgroup}
\long\def\ST@caption##1[##2]##3{\par%remove subertabulars from TOC
%  \addcontentsline{\csname ext@#1\endcsname}{#1}%
%                  {\protect\numberline{%
%                      \csname the#1\endcsname}{\ignorespaces #2}}
  \begingroup
    \@parboxrestore
    \normalsize
    \if@topcaption \vskip -10\p@ \fi
    \@makecaption{\csname fnum@##1\endcsname}{\ignorespaces ##3}\par
    \if@topcaption \vskip 10\p@ \fi
    \endgroup}
\fi}

\newcommand\twoappendix{\appendix
\cleardoublepage
\phantomsection
\if@orig
\addcontentsline{toc}{part}{Appendices}
\else
\addcontentsline{toc}{chapter}{\texorpdfstring{APPENDICES}{Appendices}}
\fi
\part*{Appendices}
}

\newcommand\oneappendix{\appendix
\def\@chapter[##1]##2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\appendixname}}{\appendixname}}%
                       \else
                         \addcontentsline{toc}{chapter}{##1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{##1}%
                    \fi
                    \chaptermark{##1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{##2}]%
                    \else
                      \@makechapterhead{##2}%
                      \@afterheading
                    \fi}

\def\@makechapterhead##1{%Removes the chapter letter from  the chapter heading
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\bfseries \@chapapp
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries ##1\par\nobreak
    \vskip 40\p@
  }}

\def\chaptermark##1{%Removes the chapter letter from page headers
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp. \ %
          \fi
        \fi
        ##1}}{}}%
}
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
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
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
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
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
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
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
      #1\nobreak%add leader dots to chapter headings
      \normalfont\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}%
      \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
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
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
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
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}
\if@twoside
  \raggedbottom %added to make vertical spacing identical.
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%%
%% End of file `book.cls'.
