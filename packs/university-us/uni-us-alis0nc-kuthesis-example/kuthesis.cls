%%
%% This is file `kuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% kuthesis.dtx  (with options: `main')
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kuthesis}[2015/04/15 Kettering University Thesis class definition]
\RequirePackage{setspace}
\RequirePackage{times}
\RequirePackage{helvet}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{etoolbox}
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
\ExecuteOptions{letterpaper,12pt,oneside,onecolumn,final,openany}
\ProcessOptions
\input{size1\@ptsize.clo}
\def\normalspacing{1.25} % default line spacing
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
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
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
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\newcommand{\employer}[1]{\ifx\empty#1\else\gdef\@employer{#1}\fi}
\newcommand{\department}[1]{\ifx\empty#1\else\gdef\@department{#1}\fi}
\newcommand{\departmentdual}[1]{\ifx\empty#1\else\gdef\@departmentdual{#1}\fi}
\renewcommand{\author}[1]{\ifx\empty#1\else\gdef\@author{#1}\fi}
\renewcommand{\title}[1]{\ifx\empty#1\else\gdef\@title{#1}\fi}
\newcommand{\gdate}[1]{\ifx\empty#1\else\gdef\@gdate{#1}\fi}

\global\def\@employer{\mbox{}}
\global\def\@degree{\mbox{}}
\global\def\@author{\mbox{}}
\global\def\@title{\mbox{}}
\global\def\@gdate{\number\date} % Default date is current date
\newcommand{\maketitle}[1][coop]
{
\begin{titlepage}
   \setcounter{page}{1}
   \begin{spacing}{1}
   \begin{center}
      \mbox{}
      \textbf{\MakeUppercase{\@title}}\\
      \vspace{2em}
      \ifstrequal{#1}{coop}
      {A Co-op Thesis written for \\
       \vspace{1em}
       \textbf{\@employer} \\}
      {}
      \ifstrequal{#1}{research}
      {A Research Thesis written for \\
       \vspace{1em}
       \textbf{KETTERING UNIVERSITY} \\}
      {}
      \ifstrequal{#1}{pp}
      {A Professional Practice Thesis written for \\
       \vspace{1em}
       \textbf{\@employer} \\}
      {}
      \ifstrequal{#1}{eship}
      {An E-Ship Thesis written by \\
       \vspace{1em}
       \textbf{\MakeUppercase{{\@author}}} \\}
      {}
      \vspace{1em}
      and submitted to \\
      \vspace{1em}
      \textbf{KETTERING UNIVERSITY} \\
      \vspace{3em}
      in partial fulfillment \\
      of the requirements for the \\
      degree\ifx\@departmentdual\undefined\else{s}\fi{} of \\
      \vspace{1em}
      \textbf{BACHELOR OF SCIENCE IN \MakeUppercase{\@department}} \\
      \ifx\@departmentdual\undefined\else
      \vspace{1em}
      and \\
      \vspace{1em}
      \textbf{BACHELOR OF SCIENCE IN \MakeUppercase{\@departmentdual}} \\
      \fi
      \vspace{3em}
      \ifstrequal{#1}{eship}
      {}
      {by \\
       \vspace{1em}
       \textbf{\MakeUppercase{{\@author}}}\\
      }
      \vspace{1em}
      {\@gdate} \\
      \vfill
   \end{center}

   \begin{flushright}

   \begin{tabular}{@{}l}
   \\ \hline
   Student    \\
   \\
   \\ \hline
   \ifstrequal{#1}{coop}{Employer Thesis Advisor~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}{}%
\ifstrequal{#1}{research}{Faculty Thesis Advisor~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}{}%
\ifstrequal{#1}{pp}{Company Liaison~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}{}%
\ifstrequal{#1}{eship}{Faculty Thesis Advisor~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}{} \\
   \\
   \\ \hline
   \ifstrequal{#1}{coop}{Faculty Thesis Advisor}{}%
\ifstrequal{#1}{research}{Committee Member}{}%
\ifstrequal{#1}{pp}{Faculty Thesis Advisor}{}%
\ifstrequal{#1}{eship}{Committee Member}{} \\
   \end{tabular}

   \end{flushright}
   \end{spacing}
   \end{titlepage}
   \setcounter{page}{2}
   \setcounter{secnumdepth}{-1}

   \chapter{DISCLAIMER}
   \begin{doublespace}
   \par
    This thesis is being submitted as partial fulfillment of the
    graduation requirements of Kettering University needed
    to obtain
    \ifx\@departmentdual\undefined
      a Bachelor of Science in {\@department} degree.
    \else
      Bachelor of Science in {\@department} and
      Bachelor of Science in {\@departmentdual} degrees.
    \fi
    \par
    The conclusions and opinions expressed in this thesis are those
    of the student author and do not necessarily represent the position
    of Kettering University or anyone else affiliated with this
    culminating undergraduate experience.
   \end{doublespace}
}%\maketitle

\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{0}
\setcounter{secnumdepth}{0}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@Roman\c@chapter}
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
                \null
                \thispagestyle{empty}%
                \newpage
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
                                   {\protect\numberline{\thechapter\@.}\MakeUppercase{#1}}%
                    \else
                      \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}%
                    \fi
                    \chaptermark{#1}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \bfseries \thechapter.\enspace
    \fi
    \bfseries\MakeUppercase{#1}\par\nobreak
    \vskip 40\p@
  }}
\def\@makeschapterhead#1{%
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    \bfseries\MakeUppercase{#1}\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\newcommand\section{\@startsection{section}{1}{0mm}%
                                    {3.5ex \@plus 1ex \@minus .2ex}%
                                    {2.3ex \@plus.2ex}%
                                    {\raggedright\normalsize\bfseries\underline}}%
\newcommand\subsection{\@startsection{subsection}{2}{0mm}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries\underline}}%
\newcommand\subsubsection{\@startsection{subsubsection}{3}{0mm}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries\underline}}%
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
               {\singlespacing\begin{list}{}{%
                \renewcommand{\makelabel}[1]{\normalfont ##1:\hfil}%
                \setlength{\labelwidth}{1.5 in}%
                \setlength{\leftmargin}{\labelwidth+\labelsep}}}
               {\end{list}\doublespacing}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                 \normalfont #1:\hfil}
\newenvironment{preface}
{
\setcounter{secnumdepth}{-1}
\chapter{\prefacename}\begin{doublespacing}
}
{\end{doublespacing}\setcounter{secnumdepth}{0}}
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
  \thispagestyle{plain}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \markboth{}{}%
  {\setcounter{secnumdepth}{-1}
  \chapter{\appendixtocname}
  \setcounter{secnumdepth}{0}}%
  \vfil\newpage
  \if@twoside
    \if@openright
      \null
      \thispagestyle{empty}%
      \newpage
    \fi
  \fi
  \if@tempswa
    \twocolumn
  \fi

  \setcounter{section}{0}
  \setcounter{chapter}{0}
  \renewcommand\@chapapp{\appendixname}
  \renewcommand\thechapter{\@Alph\c@chapter}
  \let\oldacl@pp=\addcontentsline
  \def\addcontentsline##1##2##3{%
    \ifthenelse{\equal{##1}{toc}}{%
      \ifthenelse{\equal{##2}{chapter}}{%
        \addtocontents{##1}{\protect\contentsline{##2}%
                            {\appendixname\space ##3}{\thepage}}}%
      {\oldacl@pp{##1}{##2}{##3}}}%
    {\oldacl@pp{##1}{##2}{##3}}}
\def\@chapter[##1]##2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter}%
                         \addcontentsline{toc}{section}%
                                   {\@chapapp\space\thechapter: ##1}%
                    \else
                      \addcontentsline{toc}{chapter}{##1}%
                    \fi
                    \chaptermark{##1}%
                      \if@twocolumn
                      \@topnewpage[\@makechapterhead{##2}]%
                    \else
                      \@makechapterhead{##2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead##1{%
  \vspace*{1in}%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \bfseries \@chapapp\  \thechapter\@\par
    \fi
    \vskip 40\p@
    \bfseries \MakeUppercase##1\par\nobreak
    \clearpage
  }}
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
\newcounter{figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\underline{\figurename~\thefigure.}}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\underline{\tablename~\thetable.}}
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
  \sbox\@tempboxa{#1 #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1 #2\par
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
\newcommand\@dotsep{0.25}
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
\newcommand*\l@chapter{\vspace{1em}\@dottedtocline{0}{0em}{3em}}
\newcommand*\l@section{\@dottedtocline{1}{6em}{0em}}
\newcommand*\l@subsection{\@dottedtocline{2}{9em}{0em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{12em}{0em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{15em}{0em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{18em}{0em}}
\newcommand\listofillustrations{%
    \setcounter{secnumdepth}{-1}
    \chapter{\listillusname%
      \@mkboth{\MakeUppercase\listillusname}%
              {\MakeUppercase\listillusname}}%
\begin{doublespace}%
\begin{raggedright}%
\textbf{\underline{Figures}\hfill\underline{Page}}%
\end{raggedright}%
\@starttoc{lof}%
\vspace{2em}
\begin{raggedright}%
\textbf{\underline{Tables}\hfill\underline{Page}}%
\end{raggedright}%
\@starttoc{lot}%
\end{doublespace}
\setcounter{secnumdepth}{0}
}
\newcommand*\l@figure{\@dottedtocline{1}{0em}{2.3em}}
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
\newcommand\contentsname{TABLE OF CONTENTS}
\newcommand\listillusname{LIST OF ILLUSTRATIONS}
\newcommand\bibname{REFERENCES}             % APA format!
\newcommand\indexname{INDEX}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{PART}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{APPENDIX}
\newcommand\appendixtocname{APPENDICES}
\newcommand\prefacename{PREFACE}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\newcommand\begincontent{
\clearpage
\doublespacing
}
\setlength{\oddsidemargin}{.5 in}
\setlength{\footskip}{.5 in}
\setlength{\textheight}{9 in}
\setlength{\textwidth}{6 in}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\voffset}{0pt}
\setlength{\hoffset}{0pt}
\setlength{\textheight}{9in}

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
%%%% free to distribute by John_Lavagnino@Brown.edu on Thu, 23 Mar 1995
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\@definecounter{endnote}
\def\theendnote{\arabic{endnote}}

\def\@makeenmark{\hbox{$^{\@theenmark}$}}

\newdimen\endnotesep

\def\endnote{\@ifnextchar[{\@xendnote}{\stepcounter
   {endnote}\xdef\@theenmark{\theendnote}\@endnotemark\@endnotetext}}

\def\@xendnote[#1]{\begingroup \c@endnote=#1\relax
   \xdef\@theenmark{\theendnote}\endgroup
   \@endnotemark\@endnotetext}


\let\@doanenote=0
\let\@endanenote=0

\newwrite\@enotes
\newif\if@enotesopen \global\@enotesopenfalse

\def\@openenotes{\immediate\openout\@enotes=\jobname.ent\relax
      \global\@enotesopentrue}


\long\def\@endnotetext#1{%
     \if@enotesopen \else \@openenotes \fi
     \immediate\write\@enotes{\@doanenote{\@theenmark}}%
     \begingroup
        \def\next{#1}%
        \newlinechar='40
        \immediate\write\@enotes{\meaning\next}%
     \endgroup
     \immediate\write\@enotes{\@endanenote}}


\long\def\addtoendnotes#1{%
     \if@enotesopen \else \@openenotes \fi
     \begingroup
        \newlinechar='40
        \let\protect\string
        \immediate\write\@enotes{#1}%
     \endgroup}


\def\endnotemark{\@ifnextchar[{\@xendnotemark
    }{\stepcounter{endnote}\xdef\@theenmark{\theendnote}\@endnotemark}}

\def\@xendnotemark[#1]{\begingroup \c@endnote #1\relax
   \xdef\@theenmark{\theendnote}\endgroup \@endnotemark}

\def\@endnotemark{\leavevmode\ifhmode
  \edef\@x@sf{\the\spacefactor}\fi \@makeenmark
   \ifhmode\spacefactor\@x@sf\fi\relax}

\def\endnotetext{\@ifnextchar
    [{\@xendnotenext}{\xdef\@theenmark{\theendnote}\@endnotetext}}

\def\@xendnotenext[#1]{\begingroup \c@endnote=#1\relax
   \xdef\@theenmark{\theendnote}\endgroup \@endnotetext}



\def\notesname{NOTES}% <------ AE
\def\enoteheading{\chapter*{\notesname
  \@mkboth{\uppercase{\notesname}}{\uppercase{\notesname}}}%
     \leavevmode\par\vskip-\baselineskip}

\def\enoteformat{\vspace{\baselineskip}\rightskip\z@ \leftskip\z@ \parindent=1.8em
     \leavevmode\llap{\hbox{$^{\@theenmark}$}}}

\def\enotesize{\normalsize}


\def\theendnotes{\immediate\closeout\@enotes \global\@enotesopenfalse
  \begingroup
    \makeatletter
\edef\@tempa{`\string >}%
\ifnum\catcode\@tempa=11\let\@ResetGT\relax% accepts also that > were active
  \else\edef\@ResetGT{\noexpand\catcode\@tempa=\the\catcode\@tempa}%
\fi%
    \catcode`>=12% char > will be read as char so force it to \catcode 12 --bg\edef\GOfrench{`\string @}% temp def futher correctly defined
    \def\@doanenote##1##2>{\def\@theenmark{##1}\par\begingroup
        \@ResetGT%\catcode`>=13
        \edef\@currentlabel{\csname p@endnote\endcsname\@theenmark} %DW
        \enoteformat}
    \def\@endanenote{\par\endgroup}%
    \def\ETC.{\errmessage{Some long endnotes will be truncated; %
                            use BIGLATEX to avoid this}%
          \def\ETC.{\relax}}
    \clearpage
    \enoteheading
    \enotesize
    \begin{singlespacing}
    \input{\jobname.ent}%
    \end{singlespacing}
  \endgroup
  \setcounter{endnote}{0}}
\endinput
%%
%% End of file `kuthesis.cls'.
