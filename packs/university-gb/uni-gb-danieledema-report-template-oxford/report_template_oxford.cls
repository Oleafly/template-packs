\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reportTemplateOxford}[2025/03/11 template for Oxford 3YP and 4YP]

\LoadClass[11pt]{article}

% GUIDELINES
% - Submit by noon on Wednesday of the fourth week of Trinity Term
% - Plagiarism! The University regards plagiarism in examinations as a serious matter. Cases will be investigated and penalties may range from deduction of marks to expulsion from the University, depending on the seriousness of the occurrence. Even if plagiarism is inadvertent, it can result in a penalty.
% - 30 pages per student
% - 20 mm margins
% - Arial (or similar) font size 11
% - Double line spacing

\usepackage[margin=20 mm]{geometry}
\usepackage{fontspec}
\usepackage{setspace}
\doublespacing
\setmainfont{Arial}

\usepackage{lipsum}

\usepackage{graphicx}
\usepackage{subcaption}
\usepackage{duckuments}

\usepackage{booktabs}

\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[L]{} % Left side of the header
\fancyhead[C]{} % Center of the header (optional)
\fancyhead[R]{} % Right side of the header (optional)

\usepackage{glossaries}
\makeglossaries

\newcommand{\subtitle}[1]{\def\@subtitle{#1}} 

\renewcommand{\maketitle}{
\begin{titlepage}
    \centering
    \vspace*{1cm}

    \includegraphics[width=0.4\textwidth]{figs/oxford_logo.png}

    \vspace*{1cm}

    \Huge
    \textbf{\@title}

    \vspace{0.5cm}
    \LARGE
    \@subtitle

    \vfill

    \vspace{1.5cm}

    \textbf{\@author}

    \Large
    \@date

    \thispagestyle{empty} % Suppress page number on the title page
\end{titlepage}
}

\usepackage{setspace}
\usepackage{multicol}

\newcommand{\printbibliography}[2]{
\begingroup\onehalfspacing
{\small
\begin{multicols}{2}
\bibliographystyle{plain}
\bibliography{#1}
\end{multicols}}
\endgroup
}
