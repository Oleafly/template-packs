\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hwthesis}[2005/03/16 v0.4 Heriot-Watt Thesis Class]

\newif\ifcrest
\crestfalse

\DeclareOption{crest}{
  \cresttrue
}

\def\shieldonfront{shield}
\DeclareOption{shield}{\def\useshield{shield}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[a4paper,12pt,oneside]{report}
\ifcrest
\RequirePackage{graphicx}
\fi

\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage[includefoot]{geometry}

\pagestyle{fancy}
\pagenumbering{roman}

\fancyhead{}


\fancyfoot{}

\renewcommand{\chaptermark}[1]{%
\markboth{\chaptername
\ \small\thechapter:\ #1}{}}		

\renewcommand{\headrulewidth}{0pt}	
\addtolength{\headheight}{\baselineskip}

\lhead{\small\emph{\leftmark}}
\cfoot{\thepage}

% Space out equations better
\setlength{\jot}{0.5cm}

% Define date format to fit thesis requirements
\usepackage[calc,en-GB]{datetime2}
\DTMnewdatestyle{monthyeardate}{%
\renewcommand*{\DTMenglishfmtordsuffix}{\DTMenGBfmtordsuffix}%
\renewcommand{\DTMdisplaydate}[4]{%
\DTMenglishmonthname{##2}, \number##1 }%
\renewcommand{\DTMDisplaydate}{\DTMdisplaydate}%
}
\DTMsetdatestyle{monthyeardate}

% Define blankpage macro
\usepackage{afterpage}
\newcommand\blankpage{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage}

% Renew the title page to include the declaration
\renewcommand\maketitle{\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \null\vfil
    \begin{center}
      
      {\bf {\LARGE \@title \par}}%
      \vskip 3em%
      {\large
        \lineskip .75em%
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}%
      \vskip 1.5em%
      %Submitted for the degree of Philosophi\ae{} Doctor in Mathematics
      {\sc Submitted for the degree of\par Doctor of Philosophy \par}
        %Mathematics\par on completion of research in the\par Department of
        %Mathematics,\par School of Mathematical and Computer Sciences.}
        \vskip 3em%

        \ifx\useshield\undefined%
            \includegraphics[width=4.5cm]{LogoBlack.jpg}
            \vskip 1em%
        \fi%
        \ifx\useshield\shieldonfront%
            {\large {\sc Heriot-Watt University}}\par

            \vskip 2em%
            \includegraphics[width=3.5cm]{LogoBlack.pdf}
            \vskip 1em%
        \fi%
		
        \vskip .75em%
        {\sc Department of
        Mathematics,\par School of Mathematical and Computer Sciences.\par}
        \vskip 1.5em%
        {\large \@date \par}%       % Set date in \large size.
    \end{center}\par
    \vskip 4em %50\p@
    \noindent
    The copyright in this thesis is owned by the author. 
    Any quotation from the thesis or use of any of the information contained in it 
    must acknowledge this thesis as the source of the quotation or information.
%    \@thanks
    \null
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
