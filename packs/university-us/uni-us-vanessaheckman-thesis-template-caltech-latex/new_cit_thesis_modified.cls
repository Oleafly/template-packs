%%
%% NEW_CIT_THESIS.CLS
%% Primary LaTeX2e Document Class for Caltech Ph.D. Thesis
%%
%% This class is an extension of the {report} document class, v1.4b, that
%% formats the title page and chapters according to Caltech's thesis 
%% regulations. It additionally adds the ability to use the Lucida Bright
%% font set and have the table of contents render properly, and
%% automatically includes the correct version of the graphicx graphics 
%% package when used with LaTeX or pdfLaTeX. This class requires the
%% "setspace" and "graphicx" packages.
%%
%% The files "cit_logo.eps" and "cit_logo.pdf" are the Caltech logos for the
%% title page, and should be distributed with this class.
%%
%% This class supports all options of the {report} document class, plus the 
%% following additional options:
%%
%% defended - causes the cover page to list a "Defended" date instead of a
%% "Submitted" date (the date itself is still set the same way it would
%% be in a standard report class document). The option "\ifthesisdefended"
%% allows the author to write conditional code based on whether or not 
%% this option is specified.
%%
%% techreport - causes a local publication number (see "\pubnum", below) to
%% be printed on the cover page instead of the copyright year and defense
%% or submission date.
%%
%% doublespace - causes the thesis to be rendered double-spaced, for ease in
%% writing comments
%%
%% draftfoot - adds a draft footer to each page, as well as changing the
%% "Submitted" (or "Defended") line on the cover to indicate that the thesis
%% is a draft copy. The macro "\ifthesisdraft" allows the author to write
%% conditional code based on whether or not this option is specified.
%%
%% lucida - causes the document to be typeset with the Lucida Bright font
%% set, and modifies spacing in the table of contents appropriately. The
%% macro "\iflucidafont" allows the author to write conditional code based 
%% on whether or not this option is specified. In order to use lists of
%% theorems with the ntheorem package and Lucida Bright fonts, the author
%% should use the "ntheorem-thesis" style included with this document class;
%% it will format the list of theorems similarly to the list of figures 
%% format defined herein.
%%
%% preprint - causes a local publication number (see "\pubnum", below) to be
%% added to the upper right corner of the title page. The macro
%% "\ifthesispreprint" allows the author to write conditional code based on
%% whether or not this option is specified.
%%
%% In addition to these options, the following macros are available:
%%
%% \ifpdf - allows the author to write conditional code based on whether or %% not pdftex is being used to typeset the thesis. This is potentially 
%% important when importing graphics files, and can also be used to 
%% determine whether or not to set PDF document attributes.
%%
%% \iftwoside - allows the author to detect whether two-sided layout was
%% selected (for the purpose of including extra blank pages and the like).
%%
%% The following macros are available with this class, in addition to the 
%% standard LaTeX macros for the report class (the macro arguments indicate
%% the default values as specified in this class):
%%
%% \degreeaward{Doctor of Philosophy}                 Degree to be awarded
%% \university{California Institute of Technology}    Institution name
%% \address{Pasadena, California}                     Institution address
%% \unilogo{cit_logo}                                 Institution logo
%% \copyyear{\the\year}                               Year on diploma
%% \pubnum{}                                          Publication number
%% \dedication{}                                      Dedication text
%%  
%%
%% The command "\maketitle" will generate a title page conforming to Caltech
%% requirements, and including all the above information except the 
%% dedication. Note that the logo specified in "\unilogo" should be 
%% provided as both an .eps and a .pdf file, for use with both regular LaTeX
%% and pdfLaTeX, and the file extension should not be specified in
%% "\unilogo". 
%%
%% The command "\makededication" will generate a page with the dedication
%% text. This command will cause an error if the dedication text has not
%% been set.
%%
%% The command "\extrachapter" will generate an unnumbered chapter heading,
%% and will produce a corresponding entry in the Table of Contents. This
%% command is used for the {abstract} and {acknowledgements} environments,
%% defined below, and can also be used for extra front matter content such
%% as lists of figures or theorems.
%%
%% The initial portion of the document, which usually includes the copyright
%% page, abstract, acknowledgements, table of contents, and any lists of
%% figures or other items that may be necessary, is numberred in roman 
%% numerals, while the body of the thesis is numbered in arabic numerals. 
%% The {frontmatter} environment handles these page numbering conventions.
%% The author should place the {frontmatter} environment immediately after
%% the \maketitle command, and it should be structured as follows (this is
%% the recommended order for components of the front matter):
%%
%%   \begin{frontmatter}
%%      \makecopyright            % copyright page, required by Caltech
%%      \makededication           % optional dedication
%%      \begin{acknowledgements}  % optional acknowledgements
%%         (body of acknowledgements)
%%      \end{acknowledgements}
%%      \begin{abstract}
%%         (body of abstract)     % abstract, required by Caltech
%%      \end{abstract}
%%      (tables of contents, figures, other front matter) 
%%   \end{frontmatter}
%%
%% The {abstract} and {acknowledgements} environments generate unnumbered 
%% chapters that are listed in the table of contents.
%%
%% This class is adapted from Michael H. Kelsey's cit_thesis.cls, from
%% February 1995. Unlike that class, this class does not work with LaTeX 
%% 2.09.
%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{new_cit_thesis}
              [2001/12/10 v1.2
 Caltech Thesis Class for LaTeX2e/pdfLaTeX2e, by Daniel M. Zimmerman.
 Adapted from the LaTeX2e report class and M. Kelsey's cit_thesis.sty.]
%
% Define our new \if's
%
\newif\ifdoublespace
\newif\ifthesisdefended
\newif\iftechreport
\newif\ifthesisdraft
\newif\ifthesispreprint
\newif\iflucidafont
%\newif\ifpdf
\newif\iftwoside
%
% Set up \ifpdf
%
%\ifx\pdfoutput\undefined
%  \pdffalse       % no pdfLaTeX
%\else
  \pdfoutput=1    % pdfLaTeX
  %\pdftrue
%\fi
%
% We require some other packages...
%
\RequirePackage{setspace}
%\ifpdf
  \RequirePackage[pdftex]{graphicx}
%\else
%  \RequirePackage{graphicx}
%\fi
%
% Much of the following code is taken directly from report.cls
%
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
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
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse \twosidefalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue \twosidetrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
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
%
% Our own, additional options
%
\DeclareOption{defended}{\thesisdefendedtrue}
\DeclareOption{techreport}{\techreporttrue}
\DeclareOption{draftfoot}{\thesisdrafttrue}
\DeclareOption{preprint}{\thesispreprinttrue}
\DeclareOption{lucida}{\lucidafonttrue}
\DeclareOption{doublespace}{\doublespacetrue}
%
% back to report.cls
%
\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final,openany}
\ProcessOptions
\input{size1\@ptsize.clo}
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
%
% We modify the headers and footers for Caltech requirements...
%
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\hss\thepage\hss}%
      \def\@oddhead{\hss\thepage\hss}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
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
    \def\@oddhead{\hss\thepage\hss}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\hss\thepage\hss}%
    \def\@oddhead{\hss\thepage\hss}%
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
    \vskip 1.5em
  }
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{3}
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
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
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
       \huge\bfseries \partname~\thepart
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
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
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
%
% Chapter headings at top of page, single line format
%
\def\@makechapterhead#1{\vspace*{50pt}
  {\parindent 0pt \raggedright \setstretch{1} \huge\bf%
   \ifnum \c@secnumdepth>\m@ne%
     \@chapapp{} \thechapter 
     \par
     \vskip 20pt
   \fi
   \Huge \bf 
   #1\par \nobreak \vskip 40pt  \setstretch{1.5}}
}				%% End of \@makechapterhead
%
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
%
% Chapter headings at top of page, single line format
\def\@makeschapterhead#1{\vspace*{50pt}
  {\parindent 0pt \raggedright \setstretch{1} \Huge\bf%
   #1\par \nobreak \vskip 40pt\setstretch{1.5} }
}				%% End of \@makeschapterhead
%
% Add a command to create an extra chapter with TOC entry.
%
\def\extrachapter{\@ifnextchar[{\@lextrachapter}{\@extrachapter}}

\def\@lextrachapter[#1]#2{%	User specified optional contents entry
  \chapter*{#2}\addcontentsline{toc}{chapter}{#1}%
}

\def\@extrachapter#1{%		Chapter heading used as contents entry
  \chapter*{#1}\addcontentsline{toc}{chapter}{#1}%
}
%
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
\if@titlepage
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi
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
\def\fnum@figure{\figurename~\thefigure}
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
\def\fnum@table{\tablename~\thetable}
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
%
% Table of contents parameters need to be changed, if we're using Lucida
%
\iflucidafont
  \newcommand\@pnumwidth{2.00em}
  \newcommand\@tocrmarg{2.75em}
\else
  \newcommand\@pnumwidth{1.55em}
  \newcommand\@tocrmarg{2.55em}
\fi
\newcommand\@dotsep{4.5}
%
% TOC depth is 3
%
\setcounter{tocdepth}{3}
%
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
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
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
    \chapter*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
%
% Contents lines for figures aren't indented, and can support long
% figure numbers (such as 2.17).
%
\newcommand*\l@figure{\@dottedtocline{-2}{0em}{3.2em}}
%
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
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
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
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
\newcommand\abstractname{Abstract}
\def\today{\ifcase\month\or
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
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
%
% end of report.cls
%
%
% Define \thispagestyle to null so that \chapter doesn't change page style.
%
\let\thesis@document\document
\def\document{\thesis@document\thispagestyle{empty}\def\thispagestyle##1{}}
%
% Define commands to generate draft-mode footers
%
\def\thesisfooter#1{\def\@oddfoot{#1} \def\@evenfoot{#1}}
%
% Construct timestamp information for draft-mode footer
%
\newcount\timehh\newcount\timemm
\def\thesistime{%
  \timehh=\time\divide\timehh by 60%
  \timemm=\timehh\multiply\timemm by -60%
  \advance\timemm by \time%
  \ifnum\timehh<10 0\fi\number\timehh\,:\,%
  \ifnum\timemm<10 0\fi\number\timemm%
  \ \ \today%
}				%% End of \thesistime
%
% Override headers and footers, if they aren't already
%
\def\@oddhead{\hss\thepage\hss} \def\@evenhead{\hss\thepage\hss}
\ifthesisdraft
  \thesisfooter{DRAFT - NOT FOR DISTRIBUTION\hss\thesistime}
\else
  \let\@oddfoot\@empty \let\@evenfoot\@empty
\fi
%
% Text Spacing
\ifdoublespace
  \setstretch{2.0}
\else
  \setstretch{1.5}		
\fi    	    
%
\setlength{\oddsidemargin}{.5in}	%% Left margin = 1-1/2 inches
\setlength{\evensidemargin}{0in}	%% Right margin = 1 1/2 on even pgs
\setlength{\textwidth}{6in}		    %% Makes right margin = 1 inch
\setlength{\topmargin}{-.3in}		%% Top margin = 3/4'' inch (incl pg#)
\setlength{\headsep}{.15in}		    %% Space between page # and text
\setlength{\textheight}{8.95in}		%% Makes bottom margin = 1 inch
\setlength{\footskip}{.4in}		    %% Space from bottom of text to foot
%
% Define spacing for use on titlepage
%
\def\titleskip{\vskip 4\bigskipamount}		%% Whitespace after title
\def\authorskip{\vskip 2\bigskipamount}		%% Whitespace after author
%
% We want roman page numbers in the frontmatter, and arabic afterward.
% use \begin{frontmatter} ... \end{frontmatter} to do this.
%
\newenvironment{frontmatter}%
{\pagenumbering{roman}}{\clearpage\pagenumbering{arabic}}
%
% Additional titlepage definitions
%
\def\degreeaward{\gdef\@degreeaward}
\degreeaward{Doctor of Philosophy}			        % Default is Ph.D.

\def\university{\gdef\@university}
\university{California Institute of Technology}		% Default is Caltech 

\def\unilogo{\gdef\@unilogo}
\unilogo{cit_logo}                                  % Caltech logo

\def\address{\gdef\@address}
\address{Pasadena, California}				        % Default is Caltech

\def\copyyear{\gdef\@copyyear}
\copyyear{\the\year}					            % Default is today

\def\pubnum{\gdef\@pubnum}
\pubnum{}						                    % No publication number
%
% The titlepage must conform to CIT requirements
%
\def\maketitle{%
 {\parindent=0pt
 \begin{titlepage}
   \let\footnotesize\small \let\footnoterule\relax \setcounter{page}{1}
   \vskip-\headsep
   \ifthesispreprint\ifx\empty\@pubnum\else
      {\singlespace\hfill\hbox{\begin{tabular}{l}\@pubnum\end{tabular}}}
      \titleskip
   \fi\fi
   \begin{center}
     {\setstretch{1.0}\Large\bf \@title\par}
     \titleskip
     Thesis by\\
     {\large \@author\par}
     \authorskip
     In Partial Fulfillment of the Requirements\\
     for the Degree of\\
     \@degreeaward\par
     \vfill
 	   %\ifpdf
 	     \includegraphics[width=2in]{\@unilogo} \\
 	   %\else
 	   %  \includegraphics[width=2in]{\@unilogo.eps} \\
 	   %\fi
     \@university\\ 
     \@address\par
     \authorskip
     \iftechreport
        {\normalsize Technical Report \@pubnum\par}
     \else
     \@copyyear\par
        \ifthesisdraft
           {\normalsize (DRAFT - NOT FOR DISTRIBUTION - \thesistime)\par}
        \else 
           \ifthesisdefended
              {\normalsize (Defended \@date)\par}
           \else
              {\normalsize (Submitted \@date)\par}
           \fi
        \fi
     \fi
   \end{center}
   \vspace*{.5in}
 \end{titlepage}}
}				%% End of \maketitle
%
% The copyright page is new, must conform to CIT requirements
%
\def\makecopyright{%
 \setcounter{page}{2}
 {\parindent=0pt
 \null				% Forces rest to bottom of page
 \vfill
 \begin{center}
   \copyright\quad \@copyyear\\
   \@author\\
   All Rights Reserved
 \end{center}}
 \newpage
}				%% End of \makecopyright
%
% The dedication page is not part of the Caltech thesis guidelines, but
% is an optional addition to the thesis. It is typically placed before
% the acknowledgements.
%
\def\dedication{\gdef\@dedication}
\dedication{}                                   % No dedication by default
%
\def\makededication{%
 {\parindent=0pt
 \vspace*{.1\textheight}
 \begin{center}
  \@dedication\\
 \end{center}}
 \newpage
}          %% End of \makededication
%
% The abstract and acknowledgements are treated as unnumbered chapters
% with Table of Contents entries.
%
\def\abstract{\extrachapter{Abstract}}		
\def\endabstract{\clearpage}			

\def\acknowledgements{\extrachapter{Acknowledgements}}
\def\endacknowledgements{\clearpage}
%
% The {thebibliography} environment should put an entry into the Table
% of Contents, just as the {abstract} and {acknowledgements} environments
% do.
%
\let\thesis@thebibliography=\thebibliography

\def\thebibliography#1{\thesis@thebibliography{#1}%
  \addcontentsline{toc}{chapter}{Bibliography}}
%
% If we're using the lucida fonts, let's load them
%
\iflucidafont
  \RequirePackage{lucidbry}
\fi
\endinput
