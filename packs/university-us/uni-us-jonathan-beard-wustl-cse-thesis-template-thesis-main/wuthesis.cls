%%
%% This is file `wuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% wuthesis.dtx  (with options: `class')
%%
%% IMPORTANT NOTICE:
%%
%% For the copyright see the source file.
%%
%% Any modified versions of this file must be renamed
%% with new filenames distinct from wuthesis.cls.
%%
%% For distribution of the original source see the terms
%% for copying and modification in the file wuthesis.dtx.
%%
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% Copyright (C) 1996 Long Duan
%% 2005, 2007, and 2008 revisions by Greg Hackmann
%% 2014 revisions by Michael Hall
%%
%% Please note:  This document class is not compatable with the
%%               old LaTeX 2.09.  It uses LaTeX2e specific commands.
%%
%% Send bug reports to:
%%
%% gwh2@cse.wustl.edu
%%
\def\fileversion{1.7b}
\def\filedate{11/20/2014}
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
%%
\typeout{*************************************************************}
\typeout{** Wash U - Sever Institute thesis class                     }
\typeout{** version \fileversion, \filedate                           }
\typeout{** Copyright (c) 1995 Kevin Ruland                           }
\typeout{** with revisions by Long Duan, Greg Hackmann, and           }
\typeout{** Michael Hall                                              }
\typeout{*************************************************************}
%%
%% Actually not too much of this code remains but the copyright
%% remains.
%%*************************************************************
%%** UT Austin Thesis Style File, version 2.0, January 1995
%%**
%%** Copyright (c) 1995 Dinesh Das.  All rights reserved.
%%** This file is free and can be modified or distributed as
%%** long as you meet the following conditions:
%%**
%%** (1) This copyright notice is kept intact on all modified
%%**     copies.
%%** (2) If this file is modified, the original file name must
%%**     not be used.
%%*************************************************************
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wuthesis}[\filedate\space v\fileversion]
\DeclareOption{thesisdraft}{
  \AtEndOfClass{
    \def\ps@textpageheadings{%
     \let\@oddfoot\@empty\let\@evenfoot\@empty
     \def\@oddhead{\textsl{Draft of \timestamp}\hfil\thepage}%
     \let\@mkboth\@gobbletwo
     \let\chaptermark\@gobble
     \let\sectionmark\@gobble}
   }
}
\DeclareOption{phdthesis}{
    \newcommand{\thesistype}{Dissertation}
    \newcommand{\thesisdegree}{Doctor of Philosophy}
    \newcommand{\thesisdegreeabbreviation}{Ph.D.}
}
\DeclareOption{dscthesis}{
    \newcommand{\thesistype}{Dissertation}
    \newcommand{\thesisdegree}{Doctor of Science}
    \newcommand{\thesisdegreeabbreviation}{D.Sc.}
}
\DeclareOption{mastersthesis}{
    \newcommand{\thesistype}{Thesis}
    \newcommand{\thesisdegree}{Master of Science}
    \newcommand{\thesisdegreeabbreviation}{M.S.}
}
\DeclareOption{singlespace}{\AtBeginDocument{\singlespacing}}
\DeclareOption{oneandhalfspace}{\AtBeginDocument{\onehalfspacing}}
\DeclareOption{doublespace}{\AtBeginDocument{\doublespacing}}
\DeclareOption{indentfirst}{\let\@afterindentfalse\@afterindenttrue
                            \@afterindenttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{oneandhalfspace}
\ProcessOptions
\LoadClass[oneside,openany]{book}[1994/12/01]
\ifx\undefined\thesistype
  \ClassError{wuthesis}
   {Please select either the phdthesis or mastersthesis class options}
   {Use, for example, \protect\documentclass[phdthesis]{wuthesis}}
\fi
\RequirePackage[normalem]{ulem}
\RequirePackage{setspace}
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}
\newcommand{\thesisauthor}{Ima Gooden-Reddi}
\newcommand{\thesisauthorlastname}{Gooden-Reddi}
\newcommand{\thesisauthorpreviousdegrees}{}
\newcommand{\thesismonth}{May}
\newcommand{\thesisyear}{2009}
\newcommand{\thesistitle}{Title}
\newcommand{\thesisshorttitle}{Short Title}
\newcommand{\thesissupervisor}{Professor Katherine Doe}
\newcommand{\thesiscommittee}{Katherine Doe, Chair \\
Michael Allen \\
Robert Edward Thomas}
\newcommand{\thesisdepartment}{Department of Computer Science and Engineering}
\newcommand{\thesisfield}{Computer Science}

\hoffset -1in
\voffset -1in
\setlength{\textheight}{9.0in} % Shortened to make page number appear exactly one inch from bottom (Modified by Michael Hall)
\advance\textheight -0pt % header      % Modified by Michael Hall
\advance\textheight -30pt % footer     % Modified by Michael Hall
\setlength{\textwidth}{6.5in}
\advance\textwidth 0in % left and right margins
\setlength{\oddsidemargin}{1.0in}
\setlength{\evensidemargin}{1.0in}
\setlength{\topmargin}{1in}
\setlength{\headheight}{0pt}
%\setlength{\headsep}{18pt}
\setlength{\headsep}{0pt}      % Modified by Michael Hall
%\setlength{\footskip}{18pt}
\setlength{\footskip}{30pt}    % Modified by Michael Hall
\setlength{\parskip}{12pt} % add 1 line skip between paragraphs
\setlength{\parindent}{0in} % use block indenting
\newlength{\chapterpadding}
\setlength{\chapterpadding}{1.75in}
\newlength{\chaptervspace}
\setlength{\chaptervspace}{\chapterpadding}
\addtolength{\chaptervspace}{-\topmargin}
\addtolength{\chaptervspace}{-60pt}
\widowpenalty =10000
\clubpenalty  =10000
\brokenpenalty=10000
\AtBeginDocument{\pagestyle{plain}}
\renewcommand{\frontmatter}{
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}}
\renewcommand{\mainmatter}{
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\def\ps@textpageheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble}
\newenvironment{thesisdedicationpage}{
    \strut \vfill
    \vspace{-20mm}
    \begin{spacing}{1.5}
    \begin{center}
      \thesisdedication
    \end{center}
    \end{spacing}}
    {\vfill \strut
    \newpage}
\newcommand{\thesisdedication}{To myself}
\newenvironment{thesisacknowledgments}
    {\chapter*{\thesisacknowledgmenthead}
     \addcontentsline{toc}{chapter}{\thesisacknowledgmenthead}
     %\begin{spacing}{1.1}
	 }
    {\nopagebreak%
     \thesisacknowledgmentsignature

     \vskip 5mm
     \thesisacknowledgmentpostscript
     %\end{spacing}
     \newpage}
\newcommand{\thesisacknowledgmenthead}{Acknowledgments}
\newcommand{\thesisacknowledgmentsigname}{\thesisauthor}
\newcommand{\thesisacknowledgmentsignametype}{\large}
\newcommand{\thesisacknowledgmentpostscript}{}
\newcommand{\thesisacknowledgmentsignature}%
    {\vskip 5mm
     \raggedleft
     {\thesisacknowledgmentsignametype\thesisacknowledgmentsigname}
     \vskip 3mm
     \raggedright
     {\slshape
      \noindent Washington University in Saint Louis \\
      \thesismonth\ \thesisyear}}
\newenvironment{thesistitlepage}{
   \thispagestyle{empty}
   \addtocounter{page}{-1}
   \begingroup
    %\advance\topmargin -18pt
    \thesistitlepagefont
     \strut %\vfill
    \begin{center}
    \begin{doublespace}
      WASHINGTON UNIVERSITY IN ST.\ LOUIS \\
      \begin{singlespace}
        School of Engineering and Applied Science \\
        \thesisdepartment
      \end{singlespace}
    \end{doublespace}

    \vspace{0.5in}

    \begin{singlespace}
      \thesistype\ Examination Committee: \\
      \thesiscommittee
    \end{singlespace}

    \vspace{0.5in}

    \begin{singlespace}
          {\thesistitle} \\
          by \\
          \thesisstudent \\
    \end{singlespace}

    \vspace{0.75in}

    \begin{singlespace}
      A \MakeLowercase{\thesistype}\ presented to the \\
      Graduate School of Arts and Sciences \\
      of Washington University in \\
      partial fulfillment of the \\
      requirements for the degree \\
      of {\thesisdegree} \\

      \vspace{0.75in}

      \thesismonth\ \thesisyear \\
      Saint Louis, Missouri
    \end{singlespace}
    \end{center}
    \vfill %\strut
    }
    {\newpage
   \endgroup}
\newcommand{\thesistitlepagefont}{\fontsize{14}{14}\selectfont}
\newcommand{\thesisstudent}{\thesisauthor\thesisauthorpreviousdegrees}
\newenvironment{thesiscopyrightpage}{
    \pagestyle{empty}
    \strut \vfill
    \vspace{-20mm}
    \large{
    \begin{center}
      \copyright~\thesisyear, \thesiscopyrightholder
    \end{center}}}
    {\vfill \strut
    \newpage}
\newenvironment{extranotespage}{
    \pagestyle{empty}}
    {\newpage}
\newcommand{\thesiscopyrightholder}{\thesisauthor}
\newcommand{\thesisabstracthead}{Abstract}
\newenvironment{thesisabstract}{
     %\setcounter{page}{2} % in revised edition abstract was moved.
     \addcontentsline{toc}{chapter}{\thesisabstracthead}
     \begin{center}
        \begin{singlespace}
\vbox to 18pt{}
ABSTRACT OF THE \@uppercase{\thesistype} \\
\vspace{18pt}
\thesistitle \\
by \\
\thesisauthor \\
\thesisdegree\ in \thesisfield \\
        %Washington University in St.\ Louis, \thesismonth\ \thesisyear \\
        %Research Advisor: \thesissupervisor
        Washington University in St.\ Louis, \thesisyear \\
        \thesissupervisor
        \end{singlespace}
     \end{center}
     \vspace{-12pt}
     \begin{doublespace}}
     { \end{doublespace}
     \newpage}
\newenvironment{thesisshorttitlepage}{
    \clearpage
    \thispagestyle{empty}
    \addtocounter{page}{-1}
    \vbox to 4.1in{\vfil
    {\small \textbf{\thesisshorttitle,
      \thesisauthorlastname, \thesisdegreeabbreviation\ \thesisyear}
}}}
{\newpage}
\renewcommand{\listoffigures}{%
  \chapter*{\listfigurename}%
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \@starttoc{lof}%
}
\renewcommand{\listoftables}{%
  \chapter*{\listtablename}%
  \addcontentsline{toc}{chapter}{\listtablename}%
  \@starttoc{lot}%
  \listoftablespostscript
}
\newcommand{\listoftablespostscript}{}
\let\oldtoc=\@starttoc
\renewcommand*{\@starttoc}[1]{%
  {%
    \setlength{\parskip}{0pt}%
    \oldtoc{#1}%
  }%
}
\renewcommand\contentsname{Table of Contents} 

\renewcommand{\chapter}{\if@openright\cleardoublepage\else\clearpage\fi%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\newif\if@appendix\@appendixfalse
\renewcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\thechapter}{\Alph{chapter}}
  \@appendixtrue}

\newlength{\appendixhspace}
\setlength{\appendixhspace}{1.0in}
\addtolength{\appendixhspace}{1.1em}

\def\wrappedappendix#1#2{%
  \refstepcounter{chapter}%
  \addcontentsline{toc}{chapter}%
  {\hbox to \appendixhspace{\appendixname\ \thechapter \hfill} #1}%
  \@makechapterhead{#2}%
}

\providecommand{\texorpdfstring}[2]{{#1}}    % Added by Michael Hall

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \if@appendix
                           \addcontentsline{toc}{chapter}%
                                   %{\hbox to \appendixhspace{\appendixname\ \thechapter \hfill} #1}%
                                   %{\hbox to \appendixhspace{\appendixname\ \protect\numberline{\thechapter}\hfill}#1}%
                                   {\texorpdfstring{\hbox to \appendixhspace{\appendixname\ \protect\numberline{\thechapter}\hfill}#1}
                                         {\appendixname\ #1}}     % Modified by Michael Hall
                         \else
                           \addcontentsline{toc}{chapter}%
                                   {Chapter \protect\numberline{\thechapter:}#1}%
                         \fi
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
  \vspace*{\chaptervspace}%
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
\def\@makeschapterhead#1{%
  \vspace*{\chaptervspace}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
\renewcommand*{\l@chapter}[2]{%
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
      #1\nobreak%
      \leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill
      \nobreak\hbox to\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewenvironment{quote}
  {\begin{singlespace}\list{}{\rightmargin\leftmargin}%
    \item\relax}
  {\endlist\end{singlespace}}
\newenvironment{thesisauthorvita}
   {
    \clearpage
    \begin{spacing}{1.1}
    \addcontentsline{toc}{chapter}{\thesisvitahead}
    \thesisvitatop}
    {\end{spacing}}
\newcommand{\thesisvitahead}{Vita}
\newcommand{\thesisvitatop}{%
    \begin{center}
      {\huge\bfseries\thesisvitahead}
    \end{center}}
\renewcommand{\bibname}{References}
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \addcontentsline{toc}{chapter}{\bibname}
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
    \@openbib@code
            %\if@openbib
              %\advance\leftmargin\bibindent
              %\itemindent -\bibindent
              %\listparindent \itemindent
              %\parsep \z@
            %\fi
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\arabic{enumiv}}}%
      %\if@openbib
        %\renewcommand\newblock{\par}
      %\else
        %\renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
      %\fi
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcount\hour \newcount\minute
\hour=\time  \divide \hour by 60
\minute=\time
\loop \ifnum \minute > 59 \advance \minute by -60 \repeat
\def\thesistime{\ifnum \hour<13 \number\hour:%
                      \ifnum \minute<10 0\fi
                      \number\minute
                      \ifnum \hour<12 \ am\else \ pm\fi
         \else \advance \hour by -12 \number\hour:%
                      \ifnum \minute<10 0\fi
                      \number\minute \ pm\fi}
\def\timestamp{\thesistime, \today}
\newcommand{\@uppercase}[1]{{\expandafter\uppercase\expandafter{#1}}}
\newcommand\@seperator{\vrule height.4pt depth0pt width3.5in}
\newcommand\@numberword[1]{\ifcase#1 zero\or one\or  two\or three\or
four\or five\or six\or seven\or eight\else nine\fi\relax}
\endinput
%%
%% End of file `wuthesis.cls'.
