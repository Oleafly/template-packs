% FIU disseration class; adapted by Geoffrey Smith from cornell.cls.
% Last modified July 29, 2011.

%%
%% This is file `cornell.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cornell.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from cornell.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file cornell.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% Document class `cornell' to use with LaTeX 2e.
%% Based on `crnlphd' class.  The following is from the file `crnlphd.dtx':
%%   Based loosely on old cuphdthesis style file.
%%   Found to give good results, according to the thesis secretary.
%%   File: crnlphd.dtx (C) 1994 Sergio Gelato
%%   Made available without any warranty, express or implied.
%%
%% $Id: cornell.dtx,v 1.7 2007/07/02 14:50:16 andru Exp $
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
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{fiu}
[2011/07/29 v1.0
  Florida International University dissertation class]
\newif\ifphd
\DeclareOption{phd}{\phdtrue}
\DeclareOption{master}{\phdfalse}
\ExecuteOptions{phd}
\newif\ifcornellheadings
\newif\ifhalfcornellheadings
\newif\ifsmallerheadings
\DeclareOption{latexheadings}{\cornellheadingsfalse \halfcornellheadingsfalse}
\DeclareOption{cornellheadings}{\cornellheadingstrue \halfcornellheadingsfalse}
\DeclareOption{halfcornellheadings}{\halfcornellheadingstrue \cornellheadingsfalse}
\DeclareOption{normalsizeheadings}{\smallerheadingsfalse}
\DeclareOption{smallerheadings}{\smallerheadingstrue}
\ExecuteOptions{halfcornellheadings}
\ExecuteOptions{smallerheadings}
\DeclareOption{10pt}{%
 \iffinal%
  \OptionNotUsed%
  \ClassWarningNoLine{cornell}{Font size 10pt not allowed; using 12pt}%
 \else%
  \PassOptionsToClass{10pt}{report}%
 \fi%
}
\DeclareOption{11pt}{%
 \final%
  \OptionNotUsed%
  \ClassWarningNoLine{cornell}{Font size 11pt not allowed; using 12pt}%
 \else%
  \PassOptionsToClass{11pt}{report}%
 \fi
}
\newcommand{\prelim@contents}[1]{}
\DeclareOption{tocprelim}{%
  \renewcommand{\prelim@contents}[1]{\addcontentsline{toc}{section}{#1}}
}
\DeclareOption{draft}{%
  \let\ifdraft\iftrue%
  \let\iffinal\iffalse%
  \PassOptionsToClass{final}{report}%
}
\DeclareOption{final}{%
  \let\ifdraft\iffalse%
  \let\iffinal\iftrue%
  \PassOptionsToClass{final}{report}%
}
\DeclareOption{semifinal}{%
  \let\ifdraft\iffalse%
  \let\iffinal\iftrue%
  \PassOptionsToClass{draft}{report}%
}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
\ExecuteOptions{final}
\ProcessOptions

\iffinal\LoadClass[12pt]{report}[1994/06/01]\else\LoadClass{report}[1994/06/01]\fi
\newif\ifpdf
\ifx\pdfoutput\undefined
\else
  \ifx\pdfoutput\relax
  \else
    \ifcase\pdfoutput
    \else
      \pdftrue
    \fi
  \fi
\fi
\ifpdf
  \setlength{\pdfpagewidth}{8.5in}
  \setlength{\pdfpageheight}{11in}
\fi
\ifcornellheadings
  \def\@makechapterhead#1{%
    \begin{center}%
      \MakeUppercase{\@chapapp\space \thechapter} \\
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
  \def\@makeschapterhead#1{%
    \begin{center}%
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
\fi
\ifhalfcornellheadings
  \def\@makeschapterhead#1{%
    \begin{center}%
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
  \def\@makechapterhead#1{%
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright \normalfont
      \ifnum \c@secnumdepth >\m@ne
          \huge\bfseries \@chapapp\space \thechapter
          \par\nobreak
          \vskip 20\p@
      \fi
      \interlinepenalty\@M
      \singlespacing \Huge \bfseries #1\par\nobreak
      \vskip 40\p@
    }}
  \ifsmallerheadings
    \def\@makechapterhead#1{%
      {\parindent \z@ \raggedright \normalfont
        \ifnum \c@secnumdepth >\m@ne
            \LARGE\bfseries \@chapapp\space \thechapter
            \par\nobreak
        \fi
        \interlinepenalty\@M
        \singlespacing \LARGE \bfseries #1\par\nobreak
      }}
  \fi
\fi

\ifsmallerheadings
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries}}
\fi

% The FIU Graduate School wants footnotes to be \small.
\renewcommand{\footnotesize}{\small}
\renewcommand{\@makefntext}[1]{%
  \parindent 1em%
  \noindent
  \footnotespacing
  \hbox to 1.8em{\hss\@makefnmark}#1
  \par\normalspacing
}
\renewcommand{\defaultscriptratio}{.75}
\renewcommand{\defaultscriptscriptratio}{.6}
\setlength\headsep{25\p@}
\if@twocolumn
\else
%  \setlength\topmargin{-0.4in}
  \setlength\topmargin{-0.5in}
  \setlength\headheight{0.16667in}
  \setlength\headsep{0.33333in}
%  \setlength\textheight{8.8in}
  \setlength\textheight{8.6in}
% Adjusting \footskip lets me change the height of the page numbers.
%  \setlength\footskip{0.5in}
  \setlength\footskip{0.8in}
%  \setlength\oddsidemargin{.6in}
  \setlength\oddsidemargin{.55in}
%  \setlength\evensidemargin{.6in}
  \setlength\evensidemargin{.55in}
%  \setlength\textwidth{5.80in}
  \setlength\textwidth{5.90in}
  \setlength\marginparsep{0.1in}
  \setlength\marginparwidth{0.8in}
\fi
\if@compatibility
  \setlength\topmargin{0\p@}
\else
\fi
\newcommand{\ps@cornell}{%
\def\@oddhead{}
\def\@oddfoot{\hfil\thepage\hfil}%
\def\@evenhead{}%
\def\@evenfoot{\@oddfoot}%
\def\chaptermark##1{}%
\def\sectionmark##1{}%
}
\newcommand{\ps@oldcornell}{%
\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
\def\@oddfoot{}%
\def\@evenhead{\thepage\hfil{\slshape\leftmark}}%
\def\@evenfoot{}%
\def\chaptermark##1{}%
\def\sectionmark##1{}%
}
\newcommand{\ps@cornellc}{%
\def\@oddhead{\hfil\thepage\hfil}%
\def\@oddfoot{}%
\def\@evenhead{\@oddhead}%
\def\@evenfoot{}%
\def\chaptermark##1{}%
\def\sectionmark##1{}%
}
\raggedbottom
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\l@figure}{\@dottedtocline{1}{1.5em}{2.6em}}
\let\l@table\l@figure

\renewcommand{\bibname}{BIBLIOGRAPHY}
% The FIU Graduate School insists that \bibname should not be in boldface.
% So I put it into {\rm   }.
\renewenvironment{thebibliography}[1]
     {\chapter*{{\rm \bibname}
        \@mkboth{\uppercase{\bibname}}{\uppercase{\bibname}}}%
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
    \itemsep=12pt
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\arabic{enumiv}}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m\relax
      \addcontentsline{toc}{chapter}{\bibname}
      \listspacing{bib}}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \normalspacing
      \endlist}

\newcommand{\@titlesize}{\Large}
\newcommand{\@subtitlesize}{\large}
\newcommand{\@authorsize}{\normalsize} % No Pharaoh he.
\newcommand{\@conferralmonth}{January}
\newcommand{\@conferralyear}{1900}
\newcommand{\@defensedate}{January 1, 1900}
\newcommand{\@advisor}{Theadvisor}
\newcommand{\@memberone}{Thefirstcommitteemember}
\newcommand{\@membertwo}{Thesecondcommitteemember}
\newcommand{\@memberthree}{Thethirdcommitteemember}
\newcommand{\@memberfour}{Thefourthcommitteemember}

\newcommand{\@degreefield}{Thedegreefield}
\newcommand{\@college}{Thecollege}
\newcommand{\@collegedean}{Dean Thecollegedean}
\newcommand{\@gradschooldean}{Dean Thegradschooldean}

\newcommand{\titlesize}[1]{\renewcommand{\@titlesize}{#1}}
\newcommand{\subtitlesize}[1]{\renewcommand{\@subtitlesize}{#1}}
\newcommand{\authorsize}[1]{\renewcommand{\@authorsize}{#1}}
\newcommand{\conferraldate}[2]{%
  \renewcommand{\@conferralmonth}{#1}
  \renewcommand{\@conferralyear}{#2}
}
\newcommand{\defensedate}[1]{\renewcommand{\@defensedate}{#1}}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}}
\newcommand{\memberone}[1]{\renewcommand{\@memberone}{#1}}
\newcommand{\membertwo}[1]{\renewcommand{\@membertwo}{#1}}
\newcommand{\memberthree}[1]{\renewcommand{\@memberthree}{#1}}
\newcommand{\memberfour}[1]{\renewcommand{\@memberfour}{#1}}
\newcommand{\degreefield}[1]{\renewcommand{\@degreefield}{#1}}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\collegedean}[1]{\renewcommand{\@collegedean}{#1}}
\newcommand{\gradschooldean}[1]{\renewcommand{\@gradschooldean}{#1}}

\renewcommand{\maketitle}{
  \begin{titlepage}
    \begin{center}
%      \@subtitlesize
      FLORIDA INTERNATIONAL UNIVERSITY \\
      Miami, Florida
    \end{center}
    \vfill
    \begin{center}%
%      \@titlesize
% FIU Grad School doesn't want the title in a larger font!
%\large
      \expandafter\uppercase\expandafter{\@title}
    \end{center}
    \vfill
    \begin{center}
%      \@subtitlesize
      A dissertation submitted in partial
      fulfillment of the \\
      requirements for the degree of \\
      DOCTOR OF PHILOSOPHY \\
      in \\
      BIOLOGY \\
      by \\
      \@author \\
    \end{center}
    \vfill
    \begin{center}
      \@conferralyear
    \end{center}
  \end{titlepage}
}

\renewenvironment{titlepage}{%
  \typeout{Title page}
  \pagestyle{empty}
  \doublespacing
}{%
  \normalspacing\clearpage
}

% Needs to be generalized to allow different-sized committees!
% (So far it allows only committees of size 4.)
\newcommand{\makeapproval}[1]{
  \clearpage
  \thispagestyle{plain}
  \singlespacing
  \vskip 3\baselineskip
  \par\noindent To: {\@collegedean} \\
          \indent\ \@college
  \vskip \baselineskip
  % I'm crudely trying to stop latex from breaking words here:
  \begin{sloppypar} \noindent
  This dissertation, written by \@author, and entitled \@title,
  having been \mbox{approved} in respect to style and intellectual content,
  is referred to you for \mbox{judgment}.
  \end{sloppypar}

\vskip 1\baselineskip

\par\noindent We have read this dissertation and recommend that it be approved.

  \vskip 2\baselineskip
  \begin{flushright}
    % These give a small gap between signature lines and names,
    % and keep the margins correct.
    {\setlength{\baselineskip}{0.7\baselineskip}
      \linespread{1.6}
      \rule{3in}{0.5pt} \\
      \@memberone \\[2.5\baselineskip]
      \rule{3in}{0.5pt} \\
      \@membertwo \\[2.5\baselineskip]
      \rule{3in}{0.5pt} \\
      \@memberthree \\[2.5\baselineskip]
      \rule{3in}{0.5pt} \\
      \@memberfour \\[2.5\baselineskip]
      \rule{3in}{0.5pt} \\
      \@advisor, Major Professor \\
    \par}
  \end{flushright}

\vskip 1\baselineskip
\par\noindent Date of Defense: {\@defensedate}

\vskip 1\baselineskip
\noindent The dissertation of \@author\ is approved.
  \begin{flushright}
    {\setlength{\baselineskip}{0.7\baselineskip}
      \vskip 3\baselineskip
      \rule{3in}{0.5pt} \\
      \@collegedean \\[1ex]
      \@college \\[3\baselineskip]
      \rule{3in}{0.5pt} \\
      \@gradschooldean \\[1ex]
      Vice President for Research and Economic Development \\
      and Dean of the University Graduate School
    \par}
  \end{flushright}

\begin{center}
\vskip 2.3\baselineskip
Florida International University, \@conferralyear
\end{center}

\normalspacing\clearpage
}

\newenvironment{copyrightpage}{%
  \typeout{Copyright page}
  \null\vfill
  
}{%
  %\end{flushleft}
  \vfill\null
  \newpage
  \clearpage%
}

%\newcommand{\makecopyright}{%
 % \begin{copyrightpage}
 % \copyright\ Copyright \@copyrightyear{} by \@copyrightholder \\
%  All rights reserved.
 % \end{copyrightpage}%
%}
%\newcommand{\@copyrightholder}{\@author}
%\newcommand{\@copyrightyear}{\@conferralyear}

%\newcommand{\copyrightholder}[1]{\renewcommand{\@copyrightholder}{#1}}
%\newcommand{\copyrightyear}[1]{\renewcommand{\@copyrightyear}{#1}}

%\newcommand{\makepublicdomain}{%
  %\begin{copyrightpage}
 % This document is in the public domain.
  %\end{copyrightpage}%
%}


\newlength{\@abhdskip}%
\renewenvironment{abstract}{
  \typeout{Abstract}
  \setlength{\@abhdskip}{.6in}
  \addtolength{\@abhdskip}{-\topmargin}
  \addtolength{\@abhdskip}{-\headheight}
  \addtolength{\@abhdskip}{-\headsep}
  \addtolength{\@abhdskip}{-\baselineskip}
  \begin{center}%
    %\vspace*{\@abhdskip}%
    \ifphd%
      ABSTRACT OF THE DISSERTATION \\
      {\def\\{\noexpand\\} \xdef\@abstracttitle{\@abstracttitle}}
      \expandafter\uppercase\expandafter{\@abstracttitle} \\
      by \\
      \@author \\
      Florida International University,\ \@conferralyear \\
      Miami, Florida \\
      Professor \@advisor, Major Professor
    \else
      \normalsize \bfseries\selectfont
      ABSTRACT
    \fi%
    %\vspace{0.5\baselineskip}
  \end{center}%
  %\pagestyle{empty}
  %\thispagestyle{empty}
}{%
  \clearpage
}

\newcommand{\@abstracttitle}{\@title}
\newcommand{\abstracttitle}[1]{\renewcommand{\@abstracttitle}{#1}}


\newenvironment{vita}{%
  \typeout{Vita}
  \prelim@contents{Vita}
  \clearpage
  \singlespacing
  \addcontentsline{toc}{chapter}{VITA}
  \begin{center}
    VITA
  \end{center}
%  \chapter*{Vita}
}{%
  \normalspacing
  \clearpage
}

\newenvironment{dedication}{%
  \prelim@contents{Dedication}
  \null\vfill
  \begin{center}
    DEDICATION \\
}{
  \end{center}
  \vfill\null
  \clearpage
}


\newenvironment{acknowledgments}{
  \begin{center}%
%    \ifphd%
      ACKNOWLEDGMENTS \\
  \end{center}%
  %\pagestyle{empty}
  %\thispagestyle{empty}
}{%
  \clearpage
}

% This version pushes the Acknowledgments up to the top of the page,
% which is uglier, but used to be required by the FIU Graduate School.
%\newenvironment{acknowledgments}{%
%  \prelim@contents{Acknowledgments}
%  \setlength{\@abhdskip}{.6in}
%  \addtolength{\@abhdskip}{-\topmargin}
%  \addtolength{\@abhdskip}{-\headheight}
%  \addtolength{\@abhdskip}{-\headsep}
%  \addtolength{\@abhdskip}{-\baselineskip}
%  \begin{center}
%    ACKNOWLEDGMENTS
%  \end{center}
%  \par
%  \vspace{-1em}
%}{%
%  \vfill\null
%  \cleardoublepage
%}

% Format the Table of Contents as the FIU Graduate School demands.
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begin{center}
      TABLE OF CONTENTS \\[1.5ex]
      CHAPTER \hfill{} PAGE
    \end{center}
    \vspace{-1em}
    %\chapter*{\contentsname
    %    \@mkboth{%
    %       \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }

% This command formats entries for Chapters in the Table of Contents.
% The FIU Graduate School does not want these lines in boldface, so I
% commented out "\bfseries" in line 9.
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
% These three lines cause a line of dots after each TOC entry:
      #1\nobreak\ 
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
      \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

% The . in the \numberline command gives a period at the end of chapter
% numbers in the Table of Contents
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter.}#1}%
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

\newcommand{\contentspage}{%
  \listspacing{toc}
  \label{toc}
  \prelim@contents{\contentsname}
  \tableofcontents
  \normalspacing
  \clearpage
}

% Format the List of Tables as the FIU Graduate School demands.
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begin{center}
      LIST OF TABLES \\[1.5ex]
      TABLE \hfill{} PAGE
    \end{center}
    \vspace{-1em}
    %\chapter*{\listtablename}%
    %  \@mkboth{%
    %      \MakeUppercase\listtablename}%
    %     {\MakeUppercase\listtablename}%
    \begingroup
    \renewcommand\addvspace[1]{}
    \setlength{\parskip}{\baselineskip}
    \@starttoc{lot}%
    \endgroup
    \if@restonecol\twocolumn\fi
    }

\newcommand{\tablelistpage}{%
  \realsinglespacing
  %\listspacing{tab}
  \label{lot}
  \prelim@contents{\listtablename}
  \listoftables
  \normalspacing
  \clearpage
}

% Format the List of Figures as the FIU Graduate School demands.
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begin{center}
      LIST OF FIGURES \\[1.5ex]
      FIGURE \hfill{} PAGE
    \end{center}
    \vspace{-1em}
    %\chapter*{\listfigurename}%
    %  \@mkboth{\MakeUppercase\listfigurename}%
    %          {\MakeUppercase\listfigurename}%
    \begingroup
    \renewcommand\addvspace[1]{}
    \setlength{\parskip}{\baselineskip}
    \@starttoc{lof}%
    \endgroup
    \if@restonecol\twocolumn\fi
    }

\newcommand{\figurelistpage}{%
  \realsinglespacing
  %\listspacing{fig}
  \label{lof}
  \prelim@contents{\listfigurename}
  \listoffigures
  \normalspacing
  \clearpage
}
\newcommand{\abbrlist}{%
  \listspacing{abbr}
  \prelim@contents{List of Abbreviations}
  \chapter*{List of Abbreviations}
}

\newcommand{\symlist}{%
  \listspacing{sym}
  \prelim@contents{List of Symbols}
  \chapter*{List of Symbols}
}

\newcommand{\preface}{%
  \listspacing{pref}
  \prelim@contents{Preface}
  \chapter*{Preface}
}

\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xiipt{12}%
   \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \parsep 5\p@  \@plus2.5\p@ \@minus\p@
               \topsep 10\p@ \@plus4\p@   \@minus6\p@
               \itemsep \z@  \@plus2.5\p@ \@minus\p@}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\small{%
   \@setfontsize\small\@xipt{11}%
   \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 9\p@ \@plus3\p@ \@minus5\p@
               \parsep 4.5\p@ \@plus2\p@ \@minus\p@
               \itemsep \z@  \@plus2\p@ \@minus\p@}%
   \belowdisplayskip \abovedisplayskip
}
% Why is this here??? Earlier we set \footnotesize to \normalsize.
%\renewcommand\footnotesize{%
%   \@setfontsize\footnotesize\@xpt\@xpt
%   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
%   \abovedisplayshortskip \z@ \@plus3\p@
%   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
%   \def\@listi{\leftmargin\leftmargini
%               \topsep 6\p@ \@plus2\p@ \@minus2\p@
%               \parsep 3\p@ \@plus2\p@ \@minus\p@
%               \itemsep \parsep}%
%   \belowdisplayskip \abovedisplayskip
%}

\newcommand{\realsinglespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.0}\CS}
\newcommand{\singlespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.208333}\CS}
\newcommand{\singlespacingplus}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.5}\CS}
\newcommand{\doublespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{2}\CS}
\newcommand{\realdoublespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{2}\CS}
\newcommand{\normalspacing}{\doublespacing}
\newcommand{\footnotespacing}{\singlespacing}
\newcommand{\listspacing}[1]{\singlespacing} % extra arg is extensibility hook
\newcommand{\changespacing}[2]{%
  \renewcommand{#1}{%
    \let\CS=\@currsize\renewcommand{\baselinestretch}{#2}\CS}%
}
\ifdraft\changespacing{\normalspacing}{1}\fi
\newcommand{\changenormalspacing}[1]{\renewcommand{\normalspacing}{#1}}
\normalspacing

\def \@floatboxreset {%
        \reset@font
        \normalsize
        \singlespacing
        \@setminipage
}

\endinput
%%
%% End of file `cornell.cls'.
