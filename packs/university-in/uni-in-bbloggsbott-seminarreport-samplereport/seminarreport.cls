\ProvidesClass{seminarreport}[2019/10/19 SASTRA University Seminar Report]
\LoadClass{report}

\usepackage{geometry}
\geometry{
	a4paper,
	left=1.5in,
	top=1in,
	bottom=1.15in,
	right=0.6in
}
\usepackage{setspace}
\usepackage{tocloft}
\usepackage{lipsum}

\renewcommand\cftsecfont{\Large}
\renewcommand\cftsecpagefont{\Large}

\renewcommand\thesection{\arabic{section}}
\renewcommand\thesubsection{\thesection.\arabic{subsection}}

\renewcommand{\cftdot}{}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}

\renewcommand\bibname{\LARGE References}

\usepackage{fontspec}
\renewcommand{\contentsname}{
	\begin{center}
		INDEX PAGE
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