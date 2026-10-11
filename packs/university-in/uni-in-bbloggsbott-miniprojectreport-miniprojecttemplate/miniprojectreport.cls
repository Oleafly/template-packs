\ProvidesClass{miniprojectreport}[2019/10/22 SASTRA University Seminar Report]
\LoadClass{report}
\usepackage[nottoc]{tocbibind}

\usepackage{listings}
\usepackage{color}

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

\lstset{frame=tb,
	language=Python,
	aboveskip=3mm,
	belowskip=3mm,
	showstringspaces=false,
	columns=flexible,
	basicstyle={\Large\ttfamily},
	numbers=none,
	numberstyle=\tiny\color{gray},
	keywordstyle=\color{blue},
	commentstyle=\color{dkgreen},
	stringstyle=\color{mauve},
	breaklines=true,
	breakatwhitespace=false,
	tabsize=4
}

\newenvironment{hyphenatedcode}
 {\par\hyphenpenalty=50 \exhyphenpenalty 50 }
 {\par}

\usepackage{geometry}
\geometry{
	a4paper,
	left=1.25in,
	top=1in,
	bottom=1in,
	right=1in
}
\usepackage[none]{hyphenat}
\sloppy
\usepackage{setspace}
\usepackage{tocloft}
\usepackage{lipsum}
\usepackage{titletoc}
\usepackage{titlesec}
\titlecontents{chapter}% <section-type>
[0pt]% <left>
{\addvspace{1em}}% <above-code>
{\chaptername\ \thecontentslabel\quad}% <numbered-entry-format>
{}% <numberless-entry-format>
{\cftdotfill{\cftdotsep}\contentspage}% <filler-page-format>

\renewcommand\cftsecfont{\Large}
\renewcommand\cftsecpagefont{\Large}
\renewcommand{\contentsname}{Table of contents}

\setcounter{tocdepth}{0}
\renewcommand\thesection{\arabic{section}}
\renewcommand\thesubsection{\thesection.\arabic{subsection}}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}


\titleformat{\chapter}[display]
{\normalfont%
	\LARGE% %change this size to your needs for the first line
	\bfseries \centering}{\chaptertitlename\ \thechapter}{20pt}{%
	\LARGE \centering %change this size to your needs for the second line
}

\renewcommand\bibname{References}

\usepackage{fontspec}
\renewcommand{\contentsname}{
	\begin{center}
		TABLE OF CONTENTS
	\end{center}
}
\renewcommand{\listfigurename}{
	\begin{center}
		\Large \textbf{FIGURES}
	\end{center}
}
\renewcommand{\listtablename}{
	\begin{center}
		\Large \textbf{TABLES}
	\end{center}
}

\setmainfont{Times New Roman}
