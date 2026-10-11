% \iffalse meta-comment
% 
% hmcthesis.cls -- Harvey Mudd College Senior Thesis LaTeX Class File
%
% Copyright (C) 2003--2015
%
% Claire Connelly <cmc@math.hmc.edu>
%              and 
% Melissa O'Neill <oneill@cs.hmc.edu>
%
% Written for Harvey Mudd College's
%
%   Department of Computer Science
%   Department of Mathematics
%
% *** HMC STUDENTS SHOULD NOT CHANGE THE TYPESETTING PARAMETERS FOR  ***
% *** THEIR THESIS REPORTS.  STUDENTS WISHING TO ADD FEATURES SHOULD ***
% *** DO SO WITH OTHER FILES, NOT BY MODIFYING THIS FILE.            *** 
%
% License:
% 
%   This program is free software; you can redistribute it and/or
%   modify it under the terms of the GNU General Public License as
%   published by the Free Software Foundation; either version 2 of the
%   License, or (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details. 
%
%   You should have received a copy of the GNU General Public License
%   along with this program; if not, write to the Free Software
%   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
%   02111-1307  USA 
%
% \fi
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hmcthesis}[2016/08/23 HMC Math Thesis class, version 6.0]

%%% Get some useful information when errors occur.
\setcounter{errorcontextlines}{25}


%%% Declare and set some options.

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\newif\if@sigpage
\@sigpagefalse
\newif\if@cclicense
\DeclareOption{cclicense}{\@cclicensetrue}
\DeclareOption{sigpage}{\@sigpagetrue}


% Department for report.
\newif\ifbio@dept
\bio@deptfalse
\DeclareOption{biology}{%
  \bio@depttrue
}
\newif\ifcs@dept
\cs@deptfalse
\DeclareOption{computer-science}{%
  \cs@depttrue
}
\DeclareOption{cs}{%
  \cs@depttrue
}
\newif\ifchem@dept
\chem@deptfalse
\DeclareOption{chemistry}{%
  \chem@depttrue
}
\newif\ifeng@dept
\eng@deptfalse
\DeclareOption{engineering}{%
  \eng@depttrue
}
\newif\ifmath@dept
\math@deptfalse
\DeclareOption{math}{%
  \math@depttrue
}
\DeclareOption{mathematics}{%
  \math@depttrue
}
\newif\ifphysics@dept
\physics@deptfalse
\DeclareOption{physics}{%
  \physics@depttrue
}

% Load amsthm by default.  We need to load it before the newpxmath
% font package, as it defines or redefines some commands provided
% by amsthm.  We provide a "noamsthm" option to not load amsthm.

\newif\if@amsthm
\@amsthmtrue
\DeclareOption{noamsthm}{%
  \@amsthmfalse
}

\ExecuteOptions{}
\ProcessOptions


%%% Load the book class with some default options.
\LoadClass[11pt,openright]{book}


%%% Load some required/very useful packages.
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\if@amsthm
  \RequirePackage{amsthm}
\fi
\RequirePackage{calc}
\RequirePackage{xspace}
\RequirePackage{verbatim}
\RequirePackage{booktabs}         % Publication-quality tables.
\RequirePackage{natbib}           % Better bibliography handling.
\RequirePackage{ifthen}
\RequirePackage{graphics}
\RequirePackage[obeyspaces,spaces]{url}
\RequirePackage{fancyhdr}
\RequirePackage{caption}[2010/01/09]
\captionsetup{
  font={small,sf}                % Use small, sans-serif text.
  ,labelfont=bf                  % Make label bold.
  ,labelsep=quad                 % Separate label from text with a space.
  ,justification=justified       % Justify caption.
  ,margin=2em
}


\AtBeginDocument{
  %%% Define caption appearance for subfigures (requires subfig
  %%% package to be loaded in the document preamble).
  \captionsetup*[subfloat]{
    font={small,sf}               % Use small, sans-serif font.
    ,labelformat=simple           % No parentheses on labels.
    ,labelsep=period              % Period and space separator.
    ,justification=justified
    ,format=hang
    ,margin=0pt
  }
}


%%% Set typefaces.
\RequirePackage[full]{textcomp}
\RequirePackage[theoremfont]{newpxtext}
\RequirePackage[scaled=0.98]{sourcesanspro} % sans-serif
\RequirePackage{sourcecodepro} % sans-serif typewriter
\RequirePackage[bigdelims,vvarbb]{newpxmath} % bb from STIX
\RequirePackage[scr=rsfso]{mathalfa} % mathcal
\RequirePackage{microtype}
\DisableLigatures{encoding = T1, family = tt* }
\linespread{1.025}

%%% Set URLs in sans-serif type.
\AtBeginDocument{\urlstyle{sf}}

%%% Set some defaults for bibliographic punctuation used by natbib.sty.
\bibpunct[:~]{(}{)}{;}{a}{,}{,~} 


%%% Define some environments.
\newenvironment{abstract}{\chapter*{Abstract}%
\addcontentsline{toc}{chapter}{Abstract}}{}

\newenvironment{acknowledgments}{\chapter*{Acknowledgments}%
\addcontentsline{toc}{chapter}{Acknowledgments}}{}


%%% Set the headers and footers.

\setlength{\headheight}{14pt}

\pagestyle{fancy}{%
  \fancyhf{} %% Clear all headers and footers.
  \fancyhead[LE]{\textbf{\thepage{}}\hspace{1em}\nouppercase\leftmark}
  \fancyhead[RE]{\chaptername\ \thechapter}
  \fancyhead[LO]{Section \thesection}
  \fancyhead[RO]{\nouppercase\rightmark\hspace{1em}\textbf{\thepage}}
  \fancyfoot{}
}

%%% Redefine the \chaptermark and \sectionmark commands.  Note that
%%%  this redefinition must occur after setting pagestyle to fancy.
\renewcommand{\chaptermark}[1]{%
  \markboth{#1}{}}
\renewcommand{\sectionmark}[1]{%
  \markright{#1}{}}

\addtolength{\headwidth}{.5\marginparsep}
\addtolength{\headwidth}{.5\marginparwidth}

\fancypagestyle{plain}{%
  \fancyhf{} %% Clear all headers and footers.
%  \fancyfoot[LE,RO]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{empty}{%
  \fancyhf{} %% Clear all headers and footers.
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{front}{%
  \fancyhf{} %% Clear all headers and footers.
  \fancyhead[LE]{\textbf{\thepage{}}\hspace{1em}\nouppercase\leftmark}
  \fancyhead[RO]{\nouppercase\rightmark\hspace{1em}\textbf{\thepage}}
}




%%% Define the layout of the title page.

\newcommand{\@sigline}{\vspace{2ex}\hbox to \textwidth{\hrulefill}\hfill}

\if@sigpage
\else
\renewcommand{\@sigline}{\relax}
\fi

\renewcommand\maketitle{\begin{titlepage}%
      \enlargethispage{1.5in}
      \let\footnotesize\small
      \let\footnoterule\relax
      \let\thanks\ignoreit
      \parindent\z@
      \vspace*{-1in}
      \begin{center}%
      % {\scalebox{0.55}{\includegraphics{hmcseal}}\par}%
      % \vspace{\stretch{1.5}}
      % \if@sigpage
      %   \vspace{\stretch{1.5}}
      % \else
      %   \vspace{\stretch{3}}
      % \fi
      {\LARGE \noindent\@title \par}%
      \vskip 2em
      {\Large
        \let\and\par
        \textbf{\@author}
        \par}%
      \if@sigpage
        \vspace{3in}
      \else
        \vspace{\stretch{4}}
      \fi
      {\if@sigpage\small\else\Large\fi
        \def\and{\!, Advisor\par\@sigline}
        \@sigline\@advisor, Advisor\par}
      \vspace{\stretch{.5}}
      {\if@sigpage\small\else\Large\fi
        \def\and{\!, Reader\par\@sigline}
        \@sigline\@reader, Reader\par}
      \vspace{\stretch{3}}
      {\large \scalebox{0.25}{\includegraphics{hmclogo}}\\[2ex]
        \raisebox{36bp-0.5\depth}{\textsf{\textbf{Department of \@department}}}}\par%
      \vspace{8ex}
    {\large \@thesismonth, \@thesisyear\\[1em]}
\end{center}
                                %\par
    \@thanks
    \vfill\null
  \end{titlepage}%
  \setcounter{footnote}{0}%

  %%% Define Copyright Page (appears on verso of title page).
  \thispagestyle{empty}
  \hbox{}
  \vfill{}
  \begin{small}
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{1em}

  Copyright \textcopyright~\@thesisyear{} \@author.

  \smallskip

  \@copyrighttext

  \end{small}
  \newpage
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

%%% Define some commands for specifying information for the title page
%%%  (and other parts of the document).

\def\reader#1{\gdef\@reader{#1}}
\def\@reader{\@latex@warning@no@line{No \noexpand\liaison given}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\@advisor{\@latex@warning@no@line{No \noexpand\advisor given}}
\def\department#1{\gdef\@department{#1}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\newcommand{\thesisyear}[1]{\gdef\@thesisyear{#1}}
\newcommand{\@thesisyear}{\@latex@warning@no@line{No \noexpand\thesisyear given}}
\newcommand{\thesismonth}[1]{\gdef\@thesismonth{#1}}
\newcommand{\@thesismonth}{May}

%%% Define the text to appear on the copyright page.
\newcommand{\@defaultCopyrightText}{%

  The author grants Harvey Mudd College and the Claremont Colleges
  Library the nonexclusive right to make this work available for
  noncommercial, educational purposes, provided that this
  copyright statement appears on the reproduced materials and
  notice is given that the copying is by permission of the author.
  To disseminate otherwise or to republish requires written
  permission from the author.  }

\if@cclicense
\RequirePackage{ccicons}
\newcommand{\@ccCopyrightText}{%

  \@defaultCopyrightText

  {\Huge\ccbyncsa}

  The author is also making this work available under a Creative
  Commons Attribution--NonCommercial--ShareAlike license.

  See \url{http://creativecommons.org/licenses/by-nc-sa/3.0/} for
  a summary of the rights given, withheld, and reserved by this
  license and
  \url{http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode}
  for the full legal details.
}
\fi

\newcommand{\copyrighttext}[1]{\gdef\@copyrighttext{#1}}
\def\@copyrighttext{\@defaultCopyrightText}
\if@cclicense
\renewcommand{\@copyrighttext}{\@ccCopyrightText}
\else\fi


%%% Make \eqref behave the way we want.
\renewcommand{\eqref}[1]{Equation~\ref{#1}}


%%% Make \eqref behave the way we want.
\renewcommand{\eqref}[1]{Equation~\ref{#1}}


%%% Print only the chapter and section number in the Table of Contents.

\setcounter{tocdepth}{1}

%%% Specify some details about the appearance of the table of contents.


\renewcommand{\tableofcontents}{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }


%%% Set Metafont font.  If logo not available, use the second form.
%%%
%%% \font\mffont=logosl10 scaled\magstep1
\let\mffont=\sf

\renewcommand{\frontmatter}{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \pagestyle{front}}

\renewcommand{\mainmatter}{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
\pagestyle{fancy}}



\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\bibname}{\bibname}
      \addcontentsline{toc}{chapter}{\bibname}}%
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
\renewcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

\AtBeginDocument{\@ifundefined{bibsection}{}{%
    % Handle natbib
    \let\N@tbibsection\bibsection
    \def\bibsection{\N@tbibsection\addcontentsline{toc}{chapter}{\bibname}}%
}}

\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                        \addcontentsline{toc}{chapter}{\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}


%%% Fix \cleardoublepage so it doesn't put headers on pages that are
%%% supposed to be blank.

\renewcommand*{\cleardoublepage}{%
% original definition, see latex.ltx
  \clearpage
  \if@twoside
     \ifodd\c@page
  \else
     \thispagestyle{empty}% added
     \hbox{}\newpage
     \if@twocolumn
        \hbox{}\newpage
     \fi
     \fi
  \fi
}

%% Ragged bottom is better than the alternative...

\raggedbottom

%% Set the department name.
\ifbio@dept
  \AtEndOfClass{\department{Biology}}
\else
  \ifcs@dept
    \AtEndOfClass{\department{Computer Science}}
  \else
    \ifchem@dept
      \AtEndOfClass{\department{Chemistry}}
    \else
      \ifeng@dept
        \AtEndOfClass{\department{Engineering}}
      \else
        \ifmath@dept
          \AtEndOfClass{\department{Mathematics}}
        \else
          \ifphysics@dept
            \AtEndOfClass{\department{Physics}}
          \else
            \AtEndOfClass{\department{\textbf{\huge no department document-class option found}}}
            \ClassError{hmcthesis}{No departmental document-class option found}%
            {See the template file and documentation for more information}
          \fi
        \fi
      \fi
    \fi
  \fi
\fi

\endinput
