%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
% THIS TEMPLATE IS TESTED WITH PDFLATEX INCLUDED IN TEXLIVE/   %
% MACTEX 2023 DISTRIBUTION.                                    %
%                                                              %
% PLEASE SUGGEST ANY IMPROVEMENTS VIA yhlee@memphis.edu.       %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
% LICENSES                                                     %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
% Copyright (C) 2023, Yong Hoon Lee (yhlee@memphis.edu)        %
% This LaTeX template was developed to assist students in      %
% writing their thesis and dissertation. If you find this      %
% resource helpful, you may choose to acknowledge it briefly   %
% in the Acknowledgments section of your document. However,    %
% this is entirely at the author's discretion and is not a     %
% requirement.                                                 %
%                                                              %
% Please note that while this template has been designed to    %
% assist students in writing their thesis or dissertation, it  %
% may not fully conform to the Thesis/Dissertation Guidelines  %
% provided on the Graduate School of the University of Memphis %
% website. It is the responsibility of the individual author   %
% to carefully review and ensure that their document adheres   %
% to the formatting and style requirements outlined in the     %
% guidelines. The author of this template cannot guarantee     %
% full compliance with the guidelines.                         %
%                                                              %
% This work may be distributed and/or modified under the       %
% conditions of the LaTeX Project Public License,              %
% either version 1.3 of this license or (at your option) any   %
% later version. The latest version of this license is in      %
% http://www.latex-project.org/lppl.txt and version 1.3 or     %
% later is part of all distributions of LaTeX version          %
% 2005/12/01 or later.                                         %
% Original `uofm' class package can be obtained from           %
% https://github.com/yonghoonlee/UofM-thesis-template          %
% (Original work directed per requirements of the LPPL)        %
%                                                              %
% This work has the LPPL maintenance status `maintained'.      %
% The Current Maintainer of this work is Yong Hoon Lee.        %
% This work consists of the files abbrev.tex, bibstyle.bst,    %
% glo.tex, main.tex, ref.bib, symb.tex, and uofm.cls.          %
%                                                              %
% The reference style file: bibstyle.bst is adopted from       %
% `elsarticle-num.bst', (C) 2007, 2008, 2009 Elsevier Ltd.,    %
% under the conditions of the LaTeX Project Public License,    %
% either version 1.2 of this license or (at your option) any   %
% later version. http://www.latex-project.org/lppl.txt         %
% Original `elsarticle' package can be obtained from           %
% https://www.ctan.org/pkg/elsarticle                          %
% (Original work directed per requirements of the LPPL)        %
%                                                              %
% The class file: uofm.cls is adopted partially from           %
% `report.cls', (C) 1993-2021 LaTeX Project.,                  %
% under the conditions of the LaTeX Project Public License,    %
% either version 1.3c of this license or (at your option) any  %
% later version. https://www.latex-project.org/lppl.txt        %
% Original `base' kernel of the LaTeX that contains the        %
% `report' package can be obtained from                        %
% https://www.ctan.org/pkg/report                              %
% (Original work directed per requirements of the LPPL)        %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{uofm}[2023/12/08 v1.1 Customized LaTeX document class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@master
\newif\if@proposal
\newif\if@showabstract
\newif\if@secnum
\newif\if@nohyphen
\newif\if@boundcopy
\newif\if@boundcover
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{secnum}{\@secnumtrue}
\DeclareOption{nosecnum}{\@secnumfalse}
\DeclareOption{hyphenation}{\@nohyphenfalse}
\DeclareOption{nohyphenation}{\@nohyphentrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{master}{\@mastertrue}
\DeclareOption{doctoral}{\@masterfalse}
\DeclareOption{proposal}{\@proposaltrue}
\DeclareOption{showabstract}{\@showabstracttrue}
\DeclareOption{hideabstract}{\@showabstractfalse}
\DeclareOption{fulldocument}{\@proposalfalse}
\DeclareOption{boundcopy}{\@boundcopytrue}
\DeclareOption{pdfonly}{\@boundcopyfalse}
\DeclareOption{boundcover}{\@boundcovertrue}
\DeclareOption{noboundcover}{\@boundcoverfalse}

% paper size
\setlength{\paperheight}{11in}%
\setlength{\paperwidth}{8.5in}%

% default options
\ExecuteOptions{12pt,final,master,fulldocument,hideabstract,nosecnum,nohyphenation,pdfonly,boundcover}
\ProcessOptions

% packages and defs
\input{size1\@ptsize.clo}
\RequirePackage{times}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\setlength\parindent{0.5in}
\RequirePackage{ragged2e}
\setlength{\RaggedRightParindent}{\parindent}
\RequirePackage{ifthen}
\def\degree#1{\def\@degree{#1}}
\def\major#1{\def\@major{#1}}
\def\advisor#1{\def\@advisor{#1}}

% page layout
\if@boundcopy % Left margin 1.5 inch
    \setlength\oddsidemargin{0.5in}
    \setlength\textwidth{6.0in}
\else % Left margin 1.0 inch
    \setlength\oddsidemargin{0in}
    \setlength\textwidth{6.5in}
\fi
\setlength\textheight{8.95in}
\setlength\hoffset{0in}
\setlength\voffset{0in}
\setlength\headheight{0.35in}
\setlength\headsep{0.15in}
\setlength\topmargin{-0.5in}
\setlength\marginparsep{0.15in}
\setlength\marginparwidth{0.6in}
\setlength\footskip{0.51in}
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

% Prevent hyphenation if nohyphen
\if@nohyphen
    \RequirePackage[none]{hyphenat}
\else
    \RequirePackage{hyphenat}
    \hyphenpenalty=500 % Default: 500
\fi
\sloppy % To prevent overfull

\newcommand{\eqref}[1]{(\ref{#1})}

% Preliminary contents - Roman number starting from ii
\newcommand{\frontmatter}{%
    \pagenumbering{roman}%
    \setcounter{page}{2}%
    \RaggedRight%
}

% Main contents - Arabic number starting from 1
\newcommand{\mainmatter}{%
    \pagenumbering{arabic}%
    \setcounter{page}{1}%
    \RaggedRight%
}

% Title page creation
\newcommand\maketitle{%
    \singlespacing%
    \begin{titlepage}%
        \vspace*{0.85in}%
        \setlength{\parindent}{0mm}%
        \begin{minipage}{6.5in}%
            \if@boundcopy\else
                \if@boundcover
                    \hspace*{0.5in}%
                \fi
            \fi
            \begin{minipage}{%
                \if@boundcopy
                    6.0in%
                \else
                    \if@boundcover
                        6.0in%
                    \else
                        6.5in%
                    \fi
                \fi     
            }%
                \begin{center}%
                    {\normalsize \MakeUppercase \@title \par}%
                    \vspace*{13.2pt}%
                    {\normalsize by \par}%
                    \vspace*{13.2pt}%
                    {\normalsize \@author \par}%
                \end{center}%
            \end{minipage}\par%
        \end{minipage}\par
        \vfill
        \begin{minipage}{6.5in}%
            \if@boundcopy\else
                \if@boundcover
                    \hspace*{0.5in}%
                \fi
            \fi
            \begin{minipage}{%
                \if@boundcopy
                    6.0in%
                \else
                    \if@boundcover
                        6.0in%
                    \else
                        6.5in%
                    \fi
                \fi
            }%
                \begin{center}%
                    \if@master%
                        \if@proposal%
                            {\normalsize A Thesis Proposal \par}%
                        \else%
                            {\normalsize A Thesis \par}%
                        \fi
                        \vspace*{13.2pt}%
                    \else%
                        \if@proposal%
                            {\normalsize A Dissertation Proposal \par}%
                        \else%
                            {\normalsize A Dissertation \par}%
                        \fi
                        \vspace*{13.2pt}%
                    \fi%
                    \if@proposal%
                        {\normalsize Submitted for the Committee's Review \par}%
                        \vspace*{0.5in}%
                        {\normalsize Academic Advisor: \par}%
                        \vspace*{13.2pt}%
                        {\normalsize \@advisor \par}%
                        \vspace*{0.5in}%
                        {\normalsize Major: \@major \par}%
                    \else%
                        {\normalsize Submitted in Partial Fulfillment of the \par}%
                        \vspace*{13.2pt}%
                        {\normalsize Requirements for the Degree of \par}%
                        \vspace*{13.2pt}%
                        {\normalsize \@degree \par}%
                        \vspace*{0.5in}%
                        {\normalsize Major: \@major \par}%
                    \fi
                \end{center}%
            \end{minipage}\par%
        \end{minipage}\par
        \vfill
        \begin{minipage}{6.5in}%
            \if@boundcopy\else
                \if@boundcover
                    \hspace*{0.5in}%
                \fi
            \fi
            \begin{minipage}{%
                \if@boundcopy
                    6.0in%
                \else
                    \if@boundcover
                        6.0in%
                    \else
                        6.5in%
                    \fi
                \fi
            }%
                \begin{center}%
                    {\normalsize The University of Memphis \par}%
                    \vspace*{13.2pt}%
                    {\normalsize \@date \par}%
                \end{center}%
            \end{minipage}%
        \end{minipage}%\par
        \vspace*{1.0in}
    \end{titlepage}%
    \setcounter{footnote}{0}%
    \global\let\maketitle\relax%
    \doublespacing
}

\newcommand*\chaptermark[1]{}
\if@secnum{\setcounter{secnumdepth}{2}}
\else{\setcounter{secnumdepth}{0}}
\fi
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

\newcommand\part{%
    \clearpage
    \thispagestyle{plain}%
    \@tempswafalse
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
    {%
        \centering
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
    {\centering%
     \interlinepenalty \@M%
     \normalfont%
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage}

\newcommand\chapter{%
    \clearpage%
    \thispagestyle{plain}%
    \global\@topnum\z@%
    \@afterindenttrue%
    \secdef\@chapter\@schapter%
}

\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne%
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}%
            {\protect\numberline{\thechapter}#1}%
    \else
        \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{%
    \protect\addvspace{0\p@}}%
    \addtocontents{lot}{%
    \protect\addvspace{0\p@}}%
    \@makechapterhead{#2}%
    \@afterheading%
}

\def\@makechapterhead#1{%
    {\centering{%
        \ifnum \c@secnumdepth >\m@ne%
            \normalfont\normalsize\bfseries%
            \@chapapp\space \thechapter
            \par\nobreak
        \fi%
        \interlinepenalty\@M
        \normalsize\bfseries{#1}\par\nobreak
        \vskip 12\p@
        %\vskip 40\p@
        }\par}}
        
\def\@schapter#1{\@makeschapterhead{#1}%
                 \@afterheading}
                   
\def\@makeschapterhead#1{%
    {\centering{%
        \normalsize\bfseries{#1}\par\nobreak
        \vskip 12\p@
    }\par}}

\newcommand\section{\@startsection{section}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus.2ex}%
    {\normalfont\normalsize\bfseries}}

\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalsize\itshape}}
    
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalsize}}
    
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
    {3.25ex \@plus1ex \@minus.2ex}%
    {-1em}%
    {\normalfont\normalsize\bfseries}}
    
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
    {3.25ex \@plus1ex \@minus .2ex}%
    {-1em}%
    {\normalfont\normalsize\bfseries}}

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
\newenvironment{description}
    {\list{}{\labelwidth\z@ \itemindent-\leftmargin
            \let\makelabel\descriptionlabel}}
    {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                 \normalfont\bfseries #1}

\newcommand\copyrightpage{%
    \if@proposal\else%
        \prelimpage
            \singlespacing
            \topskip0pt
            \vspace*{\fill}
            \begin{center}{\normalsize%
                Copyright\copyright~\@author \par
                All rights reserved}
            \end{center}
            \vspace*{\fill}
            \doublespacing
        \endprelimpage
    \fi
}

\newenvironment{dedication}{%
    \if@proposal%
        \setbox\z@\vbox\bgroup
    \else
        \prelimpage
        \@makeschapterhead{\dedicationname}\par
        \doublespacing%
    \fi%
}{%
    \if@proposal%
        \egroup
    \else%
    \endprelimpage
    \fi}

\newenvironment{acknowledgments}{%
    \if@proposal%
        \setbox\z@\vbox\bgroup
    \else
        \prelimpage
        \@makeschapterhead{\acknowledgmentsname}\par
        \doublespacing%
    \fi%
}{%
    \if@proposal%
        \egroup
    \else
        \endprelimpage
    \fi}

\newenvironment{preface}{%
    \if@proposal%
        \setbox\z@\vbox\bgroup
    \else
        \prelimpage
        \@makeschapterhead{\prefacename}\par
        \doublespacing%
    \fi
}{%
    \if@proposal%
        \egroup
    \else
        \endprelimpage
    \fi}

\newenvironment{abstract}{%
    \if@proposal%
        \if@showabstract%
            \prelimpage
            \@makeschapterhead{\abstractname}\par
            \doublespacing%
        \else
            \setbox\z@\vbox\bgroup
        \fi%
    \else
        \prelimpage
        \@makeschapterhead{\abstractname}\par
        \doublespacing%
    \fi
}{%
    \if@proposal%
        \if@showabstract%
            \endprelimpage
        \else
            \egroup
        \fi%
    \else
        \endprelimpage
    \fi}

\newenvironment{keywords}{%
    \par
    \vspace{13.2pt}
    {\bfseries\normalsize\noindent Keywords:~}}{}%

\newcommand\listsymbols[1]{%
    \input{#1}%
    \if@proposal\else%
        \prelimpage%
        \singlespacing%
        \renewcommand*{\glossarypreamble}{\vspace{0.3\baselineskip}}%
        \printglossary[type=symbols,title={\symbolname},style=index2,nogroupskip=true]
        \endprelimpage%
    \fi
}

\newcommand\newsymb[3]{%
    \glsxtrnewsymbol[description={#3}]{#1}{\ensuremath{#2}}%
}

\newcommand\listabbreviations[1]{%
    \input{#1}%
    \if@proposal\else%
        \prelimpage
        \singlespacing%
        \renewcommand*{\glossarypreamble}{\vspace{0.3\baselineskip}}%
        \printglossary[type=\acronymtype,title={\acronymname},style=index2,nogroupskip=true]%
        \doublespacing%
        \endprelimpage%
    \fi
}

\newcommand\useglossaries[1]{\input{#1}}

\newcommand\newglo[3]{%
    \newglossaryentry{#1}{name=#2,description={#3}}}

\newcommand\listglossaries{%
    \if@proposal\else%
        \singlespacing%
        \renewcommand*{\glsclearpage}{}%
        \printglossary[title=\glossaryname,style=index2,nogroupskip=true]%
        \doublespacing%
    \fi%
}%
     
\newenvironment{verse}
    {\let\\\@centercr
    \list{}{\itemsep \z@
        \itemindent -1.5em%
        \listparindent \itemindent
        \rightmargin \leftmargin
        \advance\leftmargin 1.5em}%
    \item\relax}
    {\endlist}
    
\newenvironment{quotation}
    {\list{}{\listparindent 1.5em%
        \itemindent \listparindent
        \rightmargin \leftmargin
        \parsep \z@ \@plus\p@}%
    \item\relax}
    {\endlist}
    
\newenvironment{quote}
    {\list{}{\rightmargin\leftmargin}%
        \item\relax}
    {\endlist}

\newenvironment{titlepage}{%
    \pagestyle{empty}%
}{%
    \newpage%
    \pagestyle{plain}%
}

\newenvironment{prelimpage}{%
    \pagestyle{plain}%
}{%
    \newpage%
    \pagestyle{plain}%
}

\newcommand\appendix{\par
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
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

% Remove dotted lines tweak
\def\@dottedtocline#1#2#3#4#5{%
\ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@tempdima #3\relax
    \advance\leftskip \@tempdima \null\hskip -\leftskip
    {#4}\nobreak
    \hfill
    \nobreak
    \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
    \par}%
\fi}

\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{3}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@proposal\else%
        \prelimpage%
        \begin{center}%
            \bfseries \contentsname
        \end{center}%
        \singlespacing
        \vspace*{-0.06in}%
        Chapter \hfill Page \par%
        \@starttoc{toc}%
        \doublespacing
        \endprelimpage
    \fi
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
       \large \bfseries #1\hfil
       \hb@xt@\@pnumwidth{\hss #2%
                          \kern-\p@\kern\p@}}\par
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
      \leavevmode %\bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil
      \nobreak\hb@xt@\@pnumwidth{\hss #2%
                                 \kern-\p@\kern\p@}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{2.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{4.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.1em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{9.4em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{11.7em}{6em}}
\newcommand\listoffigures{%
    \if@proposal\else%
        \prelimpage%
        \addcontentsline{toc}{chapter}{\listfigurename}
        \begin{center}%
            \bfseries \listfigurename
        \end{center}%
        \figurename \hfill Page \par
        \singlespacing
        \@mkboth{\MakeUppercase\listfigurename}%
                {\MakeUppercase\listfigurename}%
        \@starttoc{lof}%
        \doublespacing
        \endprelimpage
    \fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{0em}{2.3em}}
\newcommand\listoftables{%
    \if@proposal\else%
        \prelimpage%
        \addcontentsline{toc}{chapter}{\listtablename}
        \begin{center}%
            \bfseries \listtablename
        \end{center}%
        \tablename \hfill Page \par
        \singlespacing
        \@mkboth{\MakeUppercase\listtablename}%
                {\MakeUppercase\listtablename}%
        \@starttoc{lot}%
        \doublespacing
        \endprelimpage
    \fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {%
    \prelimpage%
    \addcontentsline{toc}{chapter}{\bibname}
    \begin{center}%
        \bfseries \bibname
    \end{center}%
    \singlespacing
    %\chapter*{\bibname}%
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
      \endlist
      \doublespacing}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\onecolumn}
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
\newcommand\contentsname{Table of Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\dedicationname{Dedication}
\newcommand\acknowledgmentsname{Acknowledgments}
\newcommand\prefacename{Preface}
\newcommand\symbolname{Key to Symbols}
\newcommand\acronymname{Abbreviations}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\raggedbottom
\onecolumn
\doublespacing

% Caption style setup for Table, Figure
\RequirePackage[margin=0pt,font={small},skip=10pt]{caption}
\RequirePackage[acronym,symbols,nonumberlist,automake]{glossaries-extra}
\makeglossaries[main,acronym,symbols]
\setabbreviationstyle[acronym]{long-short}
\RequirePackage{subcaption}

% index style modified
\newglossarystyle{index2}{%
  \renewenvironment{theglossary}%
    {\setlength{\parindent}{0pt}%
     \setlength{\parskip}{0pt plus 0.3pt}%
     \let\item\glstreeitem
     \let\subitem\glstreesubitem
     \let\subsubitem\glstreesubsubitem
    }%
    {\par}%
  \renewcommand*{\glossaryheader}{}%
  \renewcommand*{\glsgroupheading}[1]{}%
  \renewcommand*{\glossentry}[2]{%
     \item\glsentryitem{##1}\glstreenamefmt{\glstarget{##1}{\glossentryname{##1}}}%
     \ifglshassymbol{##1}{\space(\glossentrysymbol{##1})}{}%
     \glstreepredesc~~~~\glossentrydesc{##1}\glspostdescription\space ##2%
  }%
  \renewcommand{\subglossentry}[3]{%
    \ifcase##1\relax
      \item
    \or
      \subitem
      \glssubentryitem{##2}%
    \else
      \subsubitem
    \fi
    \glstreenamefmt{\glstarget{##2}{\glossentryname{##2}}}%
    \ifglshassymbol{##2}{\space(\glossentrysymbol{##2})}{}%
    \glstreechildpredesc\glossentrydesc{##2}\glspostdescription\space ##3%
  }%
  \renewcommand*{\glsgroupskip}{\ifglsnogroupskip\else\indexspace\fi}}

% Float-to-text spacing, and spacing between floats
\setlength{\textfloatsep}{48pt plus 1.0pt minus 2.0pt}
\setlength{\floatsep}{24pt plus 1.0pt minus 2.0pt}

\counterwithout{figure}{chapter}
\counterwithout{figure}{section}
\counterwithout{table}{chapter}
\counterwithout{table}{section}
\counterwithout{equation}{chapter}
\counterwithout{equation}{section}

\endinput
