%% modern_umthesis.cls -- modernized thesis class for UMass Amherst
%% Based on report class, replaces umthesis.sty (2007)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umthesis}[2025/04/21 Modernized UMass Thesis Class]

\LoadClass[12pt]{report} % base class

% ---------- Packages ----------
\RequirePackage[left=1.5in, right=1in, top=1in, bottom=1in]{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{caption}
\RequirePackage{chngcntr}
\RequirePackage{etoolbox}
\RequirePackage{apptools}

% ---------- Page Style ----------
\pagestyle{plain}

% ---------- Spacing ----------
\doublespacing

% ---------- Section Formatting ----------
\titleformat{\chapter}[display]
  {\normalfont\Large\bfseries\centering}
  {\chaptertitlename\ \thechapter}{15pt}{\Large\centering}

\titleformat{\section}
  {\normalfont\large\bfseries}{\thesection}{1em}{}

\titleformat{\subsection}
  {\normalfont\normalsize\bfseries}{\thesubsection}{1em}{}

% ---------- Captions ----------
\captionsetup{font=small,labelfont=bf}

% ---------- TOC, LOF, LOT spacing ----------
\setlength{\cftbeforechapskip}{10pt}
\setlength{\cftbeforesecskip}{2pt}
% Set dot leaders and indentation for chapter entries
% \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % enable dot leaders
\renewcommand{\cftchapdotsep}{1.7}
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftpartdotsep}{1.7}
\renewcommand{\cftpartleader}{\cftdotfill{\cftpartdotsep}}
\renewcommand{\cftsecdotsep}{1.7}
\renewcommand{\cftsubsecdotsep}{1.7}
\renewcommand{\cfttabdotsep}{1.7}
\renewcommand{\cftfigdotsep}{1.7}
% Line spacing
\setlength{\cftbeforepartskip}{2pt}
\setlength{\cftbeforechapskip}{1.5pt}
\setlength{\cftbeforesecskip}{1pt}
% indent in toc
\cftsetindents{chapter}{1.5em}{1.5em}
\cftsetindents{section}{3.0em}{2.3em}
\cftsetindents{subsection}{5.3em}{3.2em}
\renewcommand{\cftchapfont}{\rmfamily}
\renewcommand{\cftpartfont}{\bfseries}
\renewcommand{\cftchappagefont}{\rmfamily}
\renewcommand{\cftpartpagefont}{\rmfamily}


\renewcommand{\contentsname}{\hfill\bfseries\Large TABLE OF CONTENTS \hfill} % Table of contents
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\listtablename}{\hfill\bfseries\Large LIST OF TABLES \hfill} %
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\listfigurename}{\hfill\bfseries\Large LIST OF FIGURES \hfill} %
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftfigindent}{0em}
\setlength{\cftfignumwidth}{3em}
\setlength{\cfttabindent}{0em}
\setlength{\cfttabnumwidth}{3em}
% Line spacing
\setlength{\cftbeforefigskip}{1pt}
\setlength{\cftbeforetabskip}{1pt}


% ---------- Appendix Setup ----------
\AtAppendix{
  \counterwithin{figure}{chapter}
  \counterwithin{table}{chapter}
  \renewcommand{\thefigure}{\thechapter.\arabic{figure}}
  \renewcommand{\thetable}{\thechapter.\arabic{table}}
}

% ---------- Custom Commands for Front Matter ----------
\newcommand{\thesistitle}[1]{\def\@thesistitle{#1}}
\newcommand{\thesisauthor}[1]{\def\@thesisauthor{#1}}
\newcommand{\thesisdept}[1]{\def\@thesisdept{#1}}
\newcommand{\thesisdate}[1]{\def\@thesisdate{#1}}
\newcommand{\committeechair}[1]{\def\@committeechair{#1}}
\newcommand{\firstreader}[1]{\def\@firstreader{#1}}
\newcommand{\secondreader}[1]{\def\@secondreader{#1}}
\newcommand{\outsidereader}[1]{\def\@outsidereader{#1}}
\newcommand{\depthead}[1]{\def\@depthead{#1}}
\newcommand{\thesisabstract}[1]{\def\@thesisabstract{#1}}
\newcommand{\thesisacknowledgment}[1]{\def\@thesisacknowledgment{#1}}
\newcommand{\prevdegree}[1]{\def\@prevdegree{#1}}
\newcommand{\advisorname}[1]{\def\@advisorname{#1}}


\def\maketitlepage{
  \thispagestyle{empty}
  \begin{center}
    {\Large \textbf{\@thesistitle} \par}
    \vfill
    A Thesis Presented 
    \\ by 
    \\
    {\textbf{\MakeUppercase{\@thesisauthor}}} \\
    \vfill
    Submitted to the Graduate School of the \\
    University of Massachusetts Amherst in partial fulfillment\\
    of the requirements for the degree of \\
    \vfill
    Doctor of Philosophy \\
    \vfill
    {\@thesisdate} \\
    Department of {\@thesisdept} 
  \end{center}
  \newpage
}

\def\makesignaturepage{
  \thispagestyle{empty}
  \noindent{\Large \textbf{\@thesistitle}}\par
  \vfill
  \begin{center}
  A Dissertation Presented \\
  By \\
  {\textbf{\MakeUppercase{\@thesisauthor}}} \\
  \vfill
  Approved as to style and content by: \\[1cm]
  \end{center}
  \noindent\makebox[3in][l]{\hrulefill} \\[-0.5ex]
  \@committeechair, Chair \\[1cm]
  \noindent\makebox[3in][l]{\hrulefill} \\[-0.5ex]
  \@firstreader, Member \\[1cm]
  \noindent\makebox[3in][l]{\hrulefill} \\[-0.5ex]
  \@secondreader, Member \\[1cm]
  \noindent\makebox[3in][l]{\hrulefill} \\[-0.5ex]
  \@outsidereader, Member \\
  \vfill
  \hfill \shortstack[l]{\hrulefill \\ \@depthead, Department Head \\ \@thesisdept}
  \newpage
}

\def\makecopyrightpage{
  \thispagestyle{empty}
  \null\vfill
  \begin{center}
    \copyright\ Copyright by \\[1ex]
    {\@thesisauthor} {\@thesisdate} \\[2ex]
    All Rights Reserved
  \end{center}
  \vfill
  \newpage
}

\def\makeacknowledgmentpage{
  \chapter*{ACKNOWLEDGMENT}
  \addcontentsline{toc}{part}{ACKNOWLEDGMENT}
  \@thesisacknowledgment
  \newpage
}

\def\makeabstractpage{
  \chapter*{ABSTRACT}
  \addcontentsline{toc}{part}{ABSTRACT}
  \begin{center}
  \MakeUppercase\@thesistitle\par
  \vspace{0.25\baselineskip}
  \MakeUppercase{\@thesisdate}\par
  \vspace{0.25\baselineskip}
  \MakeUppercase{\@thesisauthor}\par
  % Degree lines with BA on its own line, MS optional on its own line
  \@prevdegree\par
  Ph.D., University of Massachusetts Amherst\par
  \vspace{0.25\baselineskip}
  \textbf{Directed by:} \@advisorname\par
  \end{center}
  \vspace{0.75 \baselineskip}
  \@thesisabstract
  \newpage
}

\newcommand{\makeintropage}[1]{%
  \chapter*{INTRODUCTION}%
  \addcontentsline{toc}{chapter}{INTRODUCTION}%
  \input{#1}%
  \newpage%
}

\newcommand{\makeconclusionpage}[1]{%
  \chapter*{CONCLUSION}%
  \addcontentsline{toc}{chapter}{CONCLUSION}%
  \input{#1}%
  \newpage%
}

\endinput
