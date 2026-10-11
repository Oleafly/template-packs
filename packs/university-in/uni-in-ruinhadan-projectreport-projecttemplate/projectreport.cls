\ProvidesClass{projectreport}[2020/04/08 SASTRA University Project Report]
\LoadClass{report}

\usepackage{listings}
\usepackage{color}
\usepackage{atbegshi}

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
{}% <above-code>
{\ \thecontentslabel\quad}% <numbered-entry-format>
{}% <numberless-entry-format>
{\hfill\contentspage}% <filler-page-format>

\titlecontents{section}% <section-type>
[0.5cm]% <left>
{}% <above-code>
{\thecontentslabel\quad}% <numbered-entry-format>
{}% <numberless-entry-format>
{\hfill\contentspage}% <filler-page-format>

\titlecontents{figure}% <section-type>
[0pt]% <left>
{}% <above-code>
{\thecontentslabel\hfill}% <numbered-entry-format>
{}% <numberless-entry-format>
{\hfill\contentspage}% <filler-page-format>

\titlecontents{table}% <section-type>
[0pt]% <left>
{}% <above-code>
{\thecontentslabel\hfill}% <numbered-entry-format>
{}% <numberless-entry-format>
{\hfill\contentspage}% <filler-page-format>

\renewcommand\cftsecfont{\large}
\renewcommand\cftsecpagefont{\large}
\renewcommand{\cftfigindent}{0pt}

\setcounter{tocdepth}{1}
\renewcommand\thesection{\thechapter.\arabic{section}}
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
		Table of Contents\\
		\vspace{1cm}
		\textbf{Title \hfill Page No.}\\
	\end{center}
}
\renewcommand{\listfigurename}{
	\begin{center}
		\Large \textbf{List of Figures}\\\vspace{0.5cm}
		\textbf{Figure No.\hfill Figure Name\hfill Page No.}
	\end{center}
}
\renewcommand{\listtablename}{
	\begin{center}
		\Large \textbf{List of Tables}\\\vspace{0.5cm}
		\textbf{Table No.\hfill Table Name\hfill Page No.}
	\end{center}
}
\setmainfont{Times New Roman}
