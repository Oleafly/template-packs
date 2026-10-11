% File name: gsuthesis.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gsuthesis}[2023/09/24 Thesis class for PhD and MS theses]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

% Packages and settings formerly in gsuthesis.sty
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{mathptmx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{enumitem}
\RequirePackage{tikz}
\RequirePackage{caption}

\geometry{a4paper, left=1in, right=1in, top=1.5in, bottom=1in, headheight=15pt}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[C]{\thepage}

\setstretch{1.5}
\setlength{\intextsep}{1\baselineskip}
\setlength{\textfloatsep}{1\baselineskip}
\footnotesep\baselineskip

\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}{\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titlespacing*{\chapter}{0pt}{0pt}{40pt}

\captionsetup[table]{position=top, labelsep=period, font={bf,small}, skip=0.5\baselineskip}
\captionsetup[figure]{position=bottom, labelsep=period, font={bf,small}, skip=0.5\baselineskip}

\setlength{\abovedisplayskip}{2\baselineskip plus 0.5\baselineskip minus 0.5\baselineskip}
\setlength{\belowdisplayskip}{2\baselineskip plus 0.5\baselineskip minus 0.5\baselineskip}

\newcommand{\addcontentslineandpage}[3]{
    \addcontentsline{#1}{#2}{#3}
    \thispagestyle{empty}
}

% End of content from gsuthesis.sty

% Definitions from original gsuthesis.cls
\newcommand\frontmatter{%
    \pagenumbering{roman}
    \fancyhead[C]{\thepage}
}

\newcommand\mainmatter{%
    \pagenumbering{arabic}
    \fancyhead[C]{\thepage}
}

\newcommand\backmatter{%
    \fancyhead{}
}

\newcommand{\acknowledgmentname}{Acknowledgments}

\newcommand{\thesistitle}[2]{
    \begin{titlepage}
        \centering
        #1 \\[2in]  % Title
        #2 \\[1in]  % Author
        \today
    \end{titlepage}
}

\newenvironment{acknowledgments}
    {\clearpage \thispagestyle{plain} \chapter*{\acknowledgmentname}}
    {\clearpage}

\newenvironment{gsuabstract}
    {\clearpage \thispagestyle{empty} \chapter*
    {\abstractname}}
    {\clearpage}

\endinput
