% This class is adopted from a, now defunct, package named, "ODUthesis",
% originally written by Dr. J. W. Van Orden, Professor, Department of Physics.
% The class file is resurrected and heavily modified by the
% Web Science and Digital Libraries (WS-DL) Research Group, Department of Computer Science
% to suit their needs.
% While this class can be used by any ODU graduate student, it may be more suitable for
% the Computer Science students at ODU.
%
% This file is meant to be used as a class named, "wsdlthesis".
% The formatting of this class corresponds to
% "The Old Dominion University Guide for the Preparation of These and Dissertation",
% https://www.odu.edu/content/dam/odu/offices/graduate-studies/thesis-dissertation/docs/thesis_dissertation_guide.pdf
% (as per the guide last updated in May 2018).

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wsdlthesis}[2018/07/17 v0.2 ODU WS-DL Thesis/Dissertation Template]

\LoadClass[12pt,fleqn]{report}

\RequirePackage{background}
\RequirePackage[us]{datetime}
\RequirePackage{xstring}

\newif\ifmaster
\masterfalse
\newif\ifproposal
\proposalfalse
\newif\ifrevision
\revisionfalse

\DeclareOption{master}{\mastertrue}
\DeclareOption{proposal}{\proposaltrue}
\DeclareOption{revision}{\revisiontrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\setlength{\voffset}{-0.5in}
\marginparwidth 40pt \marginparsep 10pt
\topmargin 0in \headsep .31in
\textheight 8.94in \textwidth 6.46in
\brokenpenalty=10000

\oddsidemargin 0.0in
\if@twoside
  \evensidemargin 0.0in
\else
  \evensidemargin 0.0in
\fi

\textfloatsep  40pt plus 2pt minus 4pt
\floatsep  40pt plus 2pt minus 4pt
%\intextsep  40pt plus 2pt minus 4pt %%%% added FRW

% \def\textfraction{.4}  %%%%% frw
\def\textfraction{.25}
\def\floatpagefraction{.5}

\def\cl@chapter{\@elt{section}\@elt{footnote}}
\def\thefigure{\@arabic\c@figure}
\def\thetable{\@arabic\c@table}
\def\thechapter{\@arabic\c@chapter}
\def\theequation{\arabic{equation}}
\renewcommand{\figurename}{Fig.}
\renewcommand{\tablename}{TABLE}
\renewcommand{\bibname}{REFERENCES}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\appendixname}{APPENDIX}

\setcounter{tocdepth}{1}

\renewcommand\@dotsep{2.}

\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
   {\protect\numberline{\csname the#1\endcsname.}{\ignorespaces #2}}%
  \begingroup
   \@parboxrestore
   \if@minipage
   \@setminipage
   \fi
   \normalsize
   \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

\def\dept#1{\gdef\@dept{#1}}
\def\principaladviser#1{\gdef\@principaladviser{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\degrees#1{\gdef\@degrees{#1}}
\def\abstract#1{\def\@abstract{#1}}
\def\@title{}\def\@author{}\def\@dept{computer science}
\def\@principaladviser{}
\def\@degrees{}
\def\@abstract{}
\def\vita#1{\gdef\@vita{#1}}
\def\@vita{}

\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \def\@copyrightyear{\number\the\year}
\fi
\newif\ifcopyright \newif\iffigurespage \newif\iftablespage
\copyrighttrue \figurespagetrue \tablespagetrue

% FRW  fix for 2e over 2.09
\def\signline#1{\\
                %\rule{2.5in}{0.5pt}\\ % Signature lines are no longer needed
                 {\small #1} \\}

\def\@member{}
\def\member#1{\expandafter\def\expandafter\@member\expandafter
{\@member{\signline{#1\ (Member)}}}}

\def\titlep{%
        \def\baselinestretch{2.0}\@normalsize
        \thispagestyle{empty}%
        \begin{center}
                {\large\bf\uppercase\expandafter{\@title}}
        \end{center}
        \renewcommand{\baselinestretch}{1.0}\@normalsize
        \begin{center}
                 by\\
                \vspace{18pt}
                \@author\\
                \@degrees\\
        \end{center}
        \vfill
        \begin{center}
                \ifproposal
                        A \ifmaster Master's \else Candidacy \fi Proposal Submitted to\\
                        the Faculty of Old Dominion University\\
                \else
                        A \ifmaster Thesis \else Dissertation \fi Submitted to the Faculty of\\
                        Old Dominion University in Partial Fulfillment of the\\
                        Requirements for the Degree of\\
                \fi
                \vspace{18pt}
                \ifmaster \uppercase{Master of Science} \else \uppercase{Doctor of Philosophy} \fi \\
                \vspace{18pt}
                \uppercase\expandafter{\@dept}\\
                \vspace{18pt}
                \uppercase{Old Dominion University}\\
                \@submitdate\\
        \end{center}
        \vfill
        \hfill\parbox[t]{2.5in}{Approved by:\\
                                \signline{\@principaladviser\ (Director)}
                                \@member}
        \vfill\newpage}

\def\abstractpage{\def\baselinestretch{1.3}\@normalsize\pagestyle{empty}%
        \begin{center}
                {\large\bf ABSTRACT}\\
                \vspace{18pt}
                \renewcommand{\baselinestretch}{1.0}\@normalsize
                {\large\uppercase\expandafter{\@title}}\\
                \vspace{18pt}
                \@author\\
                Old Dominion University, \number\the\year\\
                Director: Dr. \@principaladviser\\
        \end{center}
        \par
        \@abstract
        \vfill\newpage}

\def\vitapage{\def\baselinestretch{1.3}\@normalsize\pagestyle{myheadings}
              \chapter*{VITA}
              \addtocontents{toc}{\vspace*{12pt}}
              \addcontentsline{toc}{chapter}{VITA}
              \begin{flushleft}
                 \@author\\
                 Department of \@dept \\
                 Old Dominion University \\
                 Norfolk, VA 23529
              \end{flushleft}
              \par
              \@vita
              \vfill
              \begin{flushleft}
                 Typeset using \LaTeX .
              \end{flushleft}}

\def\copyrightpage{%
        \pagestyle{myheadings}
        \vspace*{2in}
        \begin{center}
                Copyright,\ \@copyrightyear,\ by
                \@author,\
                All Rights Reserved.
        \end{center}
        \vfill\newpage}

\def\beforepreface{
        \pagenumbering{roman}
        \pagestyle{empty}
        \newpage
        \titlep
      \cleardoublepage
        \abstractpage
      \cleardoublepage
        \ifcopyright\copyrightpage\fi }

\def\prefacesection#1{%
      \pagestyle{myheadings}
      \cleardoublepage
        \def\baselinestretch{1.3}\@normalsize
        \chapter*{#1}}

\def\afterpreface{\cleardoublepage
        \phantomsection
        \def\baselinestretch{1}\@normalsize
        \tableofcontents
        \cleardoublepage
        \phantomsection
        \iftablespage
                \addcontentsline{toc}{chapter}{\uppercase{List of Tables}}
                \listoftables
                \cleardoublepage
                \phantomsection
        \fi
        \iffigurespage
                \addcontentsline{toc}{chapter}{\uppercase{List of Figures}}
                \listoffigures
                \cleardoublepage
                \phantomsection
        \fi
        \def\baselinestretch{1.3}\@normalsize
        \pagenumbering{arabic}
        \pagestyle{myheadings}
        \labelchaptersintableofcontents}

\def\tableofcontents{\pagestyle{myheadings}\chapter*{Table of Contents}
 \@starttoc{toc}
 \addtocontents{toc}{\hfill Page\par}}

\def\listoffigures{\chapter*{List of Figures}
 %\newline
 {\setlength{\parskip}{12\p@}
  \@starttoc{lof}}
 \addtocontents{lof}{\noindent Figure\hfill Page\par}}

\renewcommand*\l@figure{\@dottedtocline{1}{0em}{2.3em}}

\renewcommand*\l@table{\@dottedtocline{1}{0em}{2.3em}}

\def\listoftables{\chapter*{List of Tables}
 {\setlength{\parskip}{12\p@} \@starttoc{lot}}
 \addtocontents{lot}{\noindent Table\hfill Page\par}}

% Start with pagestyle{myheadings} in case front matter isn't processed
\pagestyle{myheadings}
\markboth{}{}

% FRW added custom footnote without number for document style phrase
\def\nnfootnote{%
     \@ifnextchar [\@xfootnotenext
       {\protected@xdef%
%       \@thefnmark{\thempfn}%   removed the number from FOOTNOTETEXT command:
        \@thefnmark{ }%
    \@footnotetext}}
%
\renewcommand{\chapter}{\if@openright\cleardoublepage\else\clearpage\fi
%                   \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter}%
                         \IfStrEq{\@chapapp}{APPENDIX}{%
                           \addcontentsline{toc}{section}%
                         }{%
                           \addcontentsline{toc}{chapter}%
                         }
                         {\protect\numberline{\thechapter.}\uppercase{#1}}%
                    \else
                      \addcontentsline{toc}{chapter}{\uppercase{#1}}%
                    \fi
                    %\chaptermark{#1}%
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\def\@makechapterhead#1{%
%  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \renewcommand{\baselinestretch}{2}
    \ifnum \c@secnumdepth >\m@ne
%        \centerline{\large\bfseries \@chapapp\space \thechapter}
        \begin{center}
        \large\bfseries \@chapapp\space \thechapter
        \end{center}
        \par\nobreak
        \vskip 12\p@
    \fi
    \interlinepenalty\@M
 %    \centerline{\large \bfseries \uppercase{#1}}\par\nobreak
    \begin{center}
    \large \bfseries \uppercase{#1}
    \end{center}
    \vskip 18\p@
  }}

\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}

\def\@makeschapterhead#1{%
  %\vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
 %   \centerline{
     \begin{center}
     \large \bfseries  \uppercase{#1}
     \end{center}
     \par\nobreak
   \vskip 18\p@
  }}

\renewcommand{\section}{
                    \secdef\@section\@ssection}
\def\@section[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{section}%
                         \addcontentsline{toc}{section}%
                                   {\protect\numberline{\thesection}\uppercase{#1}}%
                    \else
                      \addcontentsline{toc}{section}{\uppercase{#1}}%
                    \fi
                       \@makesectionhead{#2}%
                     }

\def\@makesectionhead#1{%
        \vskip 12\p@
         {\bfseries \noindent \thesection\space\parbox[t]{5.5in}{\raggedright\uppercase{#1}}}
        \vskip 12\p@
  }

\def\@ssection#1{
                   \@makessectionhead{#1}%
                 }

\def\@makessectionhead#1{%
        \vskip 12\p@
     {\bfseries \noindent \raggedright\uppercase{#1}}
   \vskip 12\p@
  }

\renewcommand{\subsection}{
                    \secdef\@subsection\@ssubsection}

\def\@subsection[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{subsection}%
                         \addcontentsline{toc}{subsection}%
                                   {\protect\numberline{\thesubsection}\uppercase{#1}}%
                     \fi
                    %\chaptermark{#1}%
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                       \@makesubsectionhead{#2}%
                     }

\def\@makesubsectionhead#1{%
        \vskip 12\p@
        {\bfseries \noindent \raggedright\thesubsection\space\uppercase{#1}}
        \vskip 12\p@
  }

\def\@ssection#1{
                   \@makessubsectionhead{#1}%
                 }

\def\@makessubsectionhead#1{%
        \vskip 12\p@
     {\bfseries \noindent \raggedright\uppercase{#1}}
   \vskip 12\p@
  }

\newcommand{\labelchaptersintableofcontents}{%
     \addtocontents{toc}{\vspace*{12pt}}
    \addtocontents{toc}{\noindent Chapter}
              \addtocontents{toc}{} }
\newcommand{\labelappendicesintableofcontents}{%
     \addtocontents{toc}{\vspace*{12pt}}
     \addtocontents{toc}{\noindent APPENDICES}
     \addtocontents{toc}{}}
\renewcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \labelappendicesintableofcontents%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\dotfill \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

% Add revision draft date and time in the footer
\def\setrevision{
  \ifrevision
    \backgroundsetup{placement=bottom,
                     vshift=1.1in,
                     anchor=right,
                     scale=1,
                     opacity=0.9,
                     contents=\texttt{Revised on {\usdate\today} at \currenttime}}
  \else
    \backgroundsetup{contents=}
  \fi
}
