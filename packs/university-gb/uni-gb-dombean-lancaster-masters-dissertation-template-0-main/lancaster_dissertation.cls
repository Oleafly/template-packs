% ============================================================================
% DEFINING BASIC INFORMATION ABOUT THE CLASS
% ============================================================================

\newcommand{\UniThesisUpdate}{2014/09/14}
\newcommand{\UniThesisVersion}{1.0}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UniThesis}[\UniThesisUpdate\space Version
\UniThesisVersion\space by Dominic Bean]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[oneside]{book}

% ============================================================================
% REQUIRED PACKAGES
% ============================================================================

\usepackage[plainpages=false,pdfpagelabels,hidelinks,breaklinks=true]{hyperref}
\usepackage[letterpaper,top=3cm,bottom=3cm,right=2.5cm,left=3cm]{geometry}
\usepackage[toc,title,page]{appendix}
\usepackage{tocloft}
\usepackage{indentfirst}
\usepackage{fancyhdr}
\usepackage{graphicx}
\usepackage{setspace}
\usepackage[english]{babel}
\usepackage{color}
\usepackage{breakcites}
\usepackage[font=small,labelfont=bf,justification=centering]{caption}
\usepackage{multirow}
\usepackage{float}
\usepackage{enumerate}
\usepackage{etoolbox}
\usepackage[export]{adjustbox}

% ============================================================================
% NEW COMMANDS AND ENVIRONMENTS
% ============================================================================

\newcommand{\hackplain}{\fancypagestyle{plain}{\fancyhf{}}}
\renewcommand{\appendixpagename}{Appendix}
\appto\frontmatter{\pagestyle{plain}}
\appto\mainmatter{\pagestyle{fancy}}
\appto\backmatter{\pagestyle{fancy}}

\newenvironment{dedication}{\phantom{}\begin{flushright}\begin{em}\begin{minipage}{0.5\textwidth}\raggedleft}{\end{minipage}\end{em}\end{flushright}}

\newcounter{mycounter}
\newenvironment{noindlist}
 {\begin{list}{\arabic{mycounter}.~~}{\usecounter{mycounter} \labelsep=0em \labelwidth=0em \leftmargin=0em \itemindent=0em}}
 {\end{list}}

\gdef\@UniLocation{}
\gdef\@UniLogo{}
\gdef\@UniUniversity{}
\gdef\@UniThesisYear{}
\gdef\@UniMajor{}
\gdef\@UniDepartment{}
\gdef\@UniDocumentType{}
\gdef\@UniAuthor{}
\gdef\@title{}
\gdef\@UniSupervisor{}
\gdef\@subtitle{}

\newcommand{\location}[1]     {\ifx\empty#1\else \gdef\@UniLocation{#1}\fi}
\newcommand{\logo}[1]         {\ifx\empty#1\else \gdef\@UniLogo{#1}\fi}
\newcommand{\university}[1]   {\ifx\empty#1\else \gdef\@UniUniversity{#1}\fi}
\newcommand{\thesisYear}[1]   {\ifx\empty#1\else \gdef\@UniThesisYear{#1}\fi}
\newcommand{\major}[1]        {\ifx\empty#1\else \gdef\@UniMajor{#1}\fi}
\newcommand{\department}[1]   {\ifx\empty#1\else \gdef\@UniDepartment{#1}\fi}
\newcommand{\documentType}[1] {\ifx\empty#1\else \gdef\@UniDocumentType{#1}\fi}
\renewcommand{\author}[1]     {\ifx\empty#1\else \gdef\@UniAuthor{#1}\fi}
\renewcommand{\title}[1]      {\ifx\empty#1\else \gdef\@title{#1}\fi}
\newcommand{\supervisor}[1]   {\ifx\empty#1\else \gdef\@UniSupervisor{#1}\fi}
\newcommand{\subtitle}[1]     {\ifx\empty#1\else \gdef\@subtitle{#1}\fi}

\newcommand{\theLocation}{%
    \ifx\@UniLocation\@empty
        \PackageError{UniThesis}{'location' has not been defined}\@ehc
    \else
        \@UniLocation
    \fi
}

\newcommand{\theLogo}{%
    \ifx\@UniLogo\@empty
        \PackageError{UniThesis}{'logo' has not been defined}\@ehc
    \else
        \@UniLogo
    \fi
}

\newcommand{\theUniversity}{%
    \ifx\@UniUniversity\@empty
        \PackageError{UniThesis}{'university' has not been defined}\@ehc
    \else
        \@UniUniversity
    \fi
}

\newcommand{\theThesisYear}{%
    \ifx\UniThesisYear\@empty
        \PackageError{UniThesis}{'thesisYear' has not been defined}\@ehc
    \else
        \@UniThesisYear
    \fi
}

\newcommand{\theMajor}{%
    \ifx\@UniMajor\@empty
        \PackageError{UniThesis}{'major' has not been defined}\@ehc
    \else
        \@UniMajor
    \fi
}

\newcommand{\theDepartment}{%
    \ifx\@UniDepartment\@empty
        \PackageError{UniThesis}{'department' has not been defined}\@ehc
    \else
        \@UniDepartment
    \fi
}

\newcommand{\theDocumentType}{%
    \ifx\@UniDocumentType\@empty
        \PackageError{UniThesis}{'documentType' has not been defined}\@ehc
    \else
        \@UniDocumentType
    \fi
}

\newcommand{\theAuthor}{%
    \ifx\@UniAuthor\@empty
        \PackageError{UniThesis}{'author' has not been defined}\@ehc
    \else
        \@UniAuthor
    \fi
}

\newcommand{\theTitle}{%
    \ifx\@title\@empty
        \PackageError{UniThesis}{'title' has not been defined}\@ehc
    \else
        \@title
    \fi
}

\newcommand{\theSupervisor}{%
    \ifx\@UniSupervisor\@empty
        \PackageError{UniThesis}{'supervisor' has not been defined}\@ehc
    \else
        \@UniSupervisor
    \fi
}

\newcommand{\theSubtitle}{%
    \ifx\@subtitle\@empty
        \PackageError{UniThesis}{'supervisor' has not been defined}\@ehc
    \else
        \@subtitle
    \fi
}

\newcommand{\newlinestretch}[1]{\renewcommand{\baselinestretch}{#1}\normalsize}

\newcommand{\inputfile}[1]{
    \input{#1} \clearpage
}

\newcommand{\addtotoc}[2]{
    \phantomsection
    \addcontentsline{toc}{chapter}{#1}
    #2 \clearpage
}

\renewcommand\contentsname{Table of Contents}

% ============================================================================
% DEFINING THE TITLE PAGE
% ============================================================================

\renewcommand{\maketitle}{
   \begin{titlepage}
   \newgeometry{top=2cm,bottom=4cm,right=2.5cm,left=3cm}
   \pagestyle{fancy}

       \begin{center}
          \theLogo
          \newlinestretch{1.5}
          {\ }\\[12ex]

          \noindent \rule[5mm]{\linewidth}{0.5mm}
          {\sc \LARGE  \textbf \theTitle}\\[3ex]
          { \Large \theSubtitle}\\[3ex]

          \noindent \rule[5mm]{\linewidth}{0.5mm}
          {\large by}\\[2ex]
          {\Large \textbf \theAuthor}\\[3ex]
          {\large Supervisor:}\\[2ex]
          {\Large \textbf \theSupervisor}\\[3ex]

          \noindent \rule[5mm]{\linewidth}{0.5mm}
          {\large \theDocumentType \space submitted in partial fulfilment for the
          degree of \\ {\theMajor} at the University of Lancaster.}\\[3ex]

          \noindent \rule[5mm]{\linewidth}{0.5mm}
          {\ }\\[11ex]
          {\large \theThesisYear}\\

       \end{center}
   \end{titlepage}
}

% ============================================================================
% ADDITIONAL PARAMETERS
% ============================================================================

\setlength{\parindent}{0.5in}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}

\lhead{\empty}
\chead{\empty}
\rhead{\thepage}
\lfoot{\empty}
\cfoot{\empty}
\rfoot{\empty}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}

\renewcommand{\setthesection}{\Alph{section}}

\DeclareRobustCommand{\changetochap}{
    \renewcommand{\cftchapleader}{\cftchapfont\cftdotfill{\cftdotsep}}%
    \cftsetpnumwidth{1.5em}
}
\changetochap

\makeatletter
\patchcmd{\@chap@pppage}{\thispagestyle{plain}}{\thispagestyle{empty}}{}{}
\makeatother