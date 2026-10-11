\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csm-thesis}[2020/01/08 CSM Thesis Template]
%% JOSEPH MCKINSEY %%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[letterpaper,12pt]{report}
\RequirePackage{titletoc}
\RequirePackage[explicit]{titlesec}

\RequirePackage{setspace}
\renewcommand{\baselinestretch}{2}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{graphicx}

\RequirePackage{indentfirst}

\renewcommand*{\maketitle}{
  \begin{titlepage}
    \leavevmode
    \vfill
    \begin{center}
      \MakeUppercase{\@title}
    \end{center}
    \vfill
    \begin{center}
      by
      
      \@author
    \end{center}
    \thispagestyle{empty}
  \end{titlepage}
}

\newcommand{\makecopyright}[1]{
  \leavevmode
  \vfill
  \begin{center}
    \textbf{{\textcopyright} Copyright by {\@author}, {#1}} \\
    All Rights Reserved
  \end{center}
  \vfill
  \thispagestyle{empty}
}

\newcommand*{\degree}[1]{\gdef\@degree{#1}}
\newcommand*{\discipline}[1]{\gdef\@discipline{#1}}
\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\advisor}[1]{\gdef\@advisor{#1}}
\newcommand*{\coadvisor}[1]{\gdef\@coadvisor{#1}}
\newcommand*{\dpthead}[2]{\gdef\@dpthead{#1}\def\@dptheadtitle{#2}}

\newcommand{\makesubmittal}{
  \pagenumbering{roman}
  \setcounter{page}{2}

  A thesis submitted to the Faculty and the Board of Trustees of the Colorado
  School of Mines in partial fulfillment of the requirements for the degree of
  {\@degree} ({\@discipline}).

  %% The city, state and signature date are flush with the left text margin.
  \vspace*{2\baselineskip}
  \begin{raggedright}
    \noindent
    Golden, Colorado \newline
    Date \makebox[2in]{\hrulefill}
    \vspace*{\baselineskip}
  \end{raggedright}

  %% The lines for signatures are flush with the right margin
  \begin{raggedleft}
    \begin{singlespace}
      \noindent
      Signed: \makebox[2in]{\hrulefill} \linebreak
      \makeatletter\@author\makeatother
    \end{singlespace}
    \vspace*{\baselineskip}
    \begin{singlespace}
      \noindent
      Signed: \makebox[2in]{\hrulefill} \linebreak
      \makeatletter\@advisor\makeatother \linebreak
      Thesis Advisor
    \end{singlespace}
    \ifx\@coadvisor\@empty
    \relax
    \else
    \vspace*{\baselineskip}
    \begin{singlespace}
      \noindent
      Signed: \makebox[2in]{\hrulefill} \linebreak
      \makeatletter\@coadvisor\makeatother \linebreak
      Thesis Advisor
    \end{singlespace}
    \fi
  \end{raggedleft}

  %% The city, state and signature date are flush with the left text margin.
  \vspace*{3\baselineskip}
  \begin{raggedright}
    \noindent
    Golden, Colorado \newline
    Date \makebox[2in]{\hrulefill}
    \vspace*{\baselineskip}
  \end{raggedright}

  %% The lines for signatures are flush with the right margin
  \begin{raggedleft}
    \begin{singlespace}
      \noindent
      Signed: \makebox[2in]{\hrulefill} \linebreak
      \makeatletter\@dpthead\makeatother \linebreak
      \makeatletter\@dptheadtitle\makeatother \linebreak
      Department of {\@department}
    \end{singlespace}
  \end{raggedleft}
}

\renewcommand*{\abstractname}{ABSTRACT}
\renewenvironment{abstract}{
  \addcontentsline{toc}{chapter}{Abstract}
  \begin{center}
    \abstractname
  \end{center}
}{}

\renewcommand{\contentsname}%
    {\normalsize TABLE OF CONTENTS}

\titlecontents{chapter}[0em]
{\vspace{1em}\begin{spacing}{1}}
{\MakeUppercase\chapappname\space \thecontentslabel \quad \setstretch{1}\selectfont \MakeUppercase}
{\MakeUppercase}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\titlecontents{section}[2.3em]
{\vspace{1em}\begin{spacing}{1}}
{\contentslabel{2em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\titlecontents{subsection}[4.6em]
{\vspace{1em}\begin{spacing}{1}}
{\contentslabel{2em}\space}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\titlecontents{subsubsection}[6.9em]
{\vspace{1em}\begin{spacing}{1}}
{\contentslabel{2em}\space}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\renewcommand{\tableofcontents}{%
  \begin{center}
  \MakeUppercase\contentsname
  \end{center}
  \@starttoc{toc}%
}

\titlecontents{figure}[0em]
{\vspace{1em}\begin{spacing}{1}}
{FIGURE \thecontentslabel \quad \setstretch{1}\selectfont \MakeUppercase}
{\MakeUppercase}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\renewcommand{\listfigurename}{\normalsize{LIST OF FIGURES}}
\renewcommand{\listoffigures}{%
  \begin{center}
  \listfigurename
  \end{center}
  \@starttoc{lof}
  \addcontentsline{toc}{chapter}{\listfigurename}
}

\renewcommand{\listtablename}{\normalsize{LIST OF TABLES}}
\renewcommand{\listoftables}{%
  \begin{center}
  \listtablename
  \end{center}
  \@starttoc{lot}
  \addcontentsline{toc}{chapter}{\listtablename}
}

\titlecontents{table}[0em]
{\vspace{1em}\begin{spacing}{1}}
{TABLE \thecontentslabel \quad \setstretch{1}\selectfont \MakeUppercase}
{\MakeUppercase}
{\titlerule*[1pc]{.}\contentspage}
[\end{spacing}\vspace{1em}]

\newcommand*{\dotted}[2]{#1 \dotfill #2 \newline}

\titleformat{\chapter}[block]
{\centering}{\chaptertitlename\space \thechapter \\ \MakeUppercase{#1}}{1em}{\normalsize}
\titlespacing*{\chapter}{0pt}{-19pt}{0pt}

\titleformat{\section}{\bfseries}{\thesection \quad #1}{1em}{}
\titleformat{\subsection}{\bfseries}{\thesubsection \quad #1}{1em}{}

\let\chapappname\chaptername
\let\oldappendix\appendix
\renewcommand{\appendix}{
  \oldappendix
  \addtocontents{toc}{\string\let\string\chapappname\string\appendixname}
}
