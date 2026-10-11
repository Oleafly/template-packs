%
% ClemsonThesis.cls
%
% Clemson University Thesis/Dissertation Template
% Developed by Andrew R. Dalton, School of Computing
%
\newcommand{\ClemsonThesisUpdate}{2007/05/31}
\newcommand{\ClemsonThesisVersion}{1.0}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ClemsonThesis}[\ClemsonThesisUpdate\space Version
\ClemsonThesisVersion\space by Andrew R. Dalton, School of Computing]


%
% This document class is based on the 'book' document class
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[oneside]{book}


%
% Some packages we depend upon
%
\usepackage[plainpages=false,pdfpagelabels]{hyperref} % Get nice PDF document links
\usepackage[letterpaper,margin=1.25in]{geometry}      % Easily set margins
\usepackage[toc,title,page]{appendix}                 % Configure appendix formatting
\usepackage{tocloft}                                  % Configure ToC Lo{F,T} formatting
\usepackage{indentfirst}                              % Always indent first paragraph
\usepackage{fancyhdr}                                 % Control page location
\usepackage{graphicx}                                 % Include figures
\usepackage{setspace}                                 % Control spacing


%
% Initially define all of our variables as empty
%
\gdef\@ClemsonGraduationMonth{}
\gdef\@ClemsonGraduationYear{}
\gdef\@ClemsonDegree{}
\gdef\@ClemsonMajor{}
\gdef\@ClemsonDepartment{}
\gdef\@ClemsonDocumentType{}
\gdef\@ClemsonCommitteeChair{}
\gdef\@ClemsonCommitteeMemberOne{}
\gdef\@ClemsonCommitteeMemberTwo{}
\gdef\@ClemsonCommitteeMemberThree{}
\gdef\@ClemsonCommitteeMemberFour{}
\gdef\@ClemsonCommitteeMemberFive{}
\gdef\@ClemsonCommitteeMemberSix{}
\gdef\@ClemsonAuthor{}
\gdef\@title{}


%
% Some commands to set our variables
%
\newcommand{\graduationMonth}[1]      {\ifx\empty#1\else \gdef\@ClemsonGraduationMonth{#1}      \fi}
\newcommand{\graduationYear}[1]       {\ifx\empty#1\else \gdef\@ClemsonGraduationYear{#1}       \fi}
\newcommand{\degree}[1]               {\ifx\empty#1\else \gdef\@ClemsonDegree{#1}               \fi}
\newcommand{\major}[1]                {\ifx\empty#1\else \gdef\@ClemsonMajor{#1}                \fi}
\newcommand{\department}[1]           {\ifx\empty#1\else \gdef\@ClemsonDepartment{#1}           \fi}
\newcommand{\documentType}[1]         {\ifx\empty#1\else \gdef\@ClemsonDocumentType{#1}         \fi}
\newcommand{\committeeChair}[1]       {\ifx\empty#1\else \gdef\@ClemsonCommitteeChair{#1}       \fi}
\newcommand{\committeeMemberOne}[1]   {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberOne{#1}   \fi}
\newcommand{\committeeMemberTwo}[1]   {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberTwo{#1}   \fi}
\newcommand{\committeeMemberThree}[1] {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberThree{#1} \fi}
\newcommand{\committeeMemberFour}[1]  {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberFour{#1}  \fi}
\newcommand{\committeeMemberFive}[1]  {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberFive{#1}  \fi}
\newcommand{\committeeMemberSix}[1]   {\ifx\empty#1\else \gdef\@ClemsonCommitteeMemberSix{#1}   \fi}
\renewcommand{\author}[1]             {\ifx\empty#1\else \gdef\@ClemsonAuthor{#1}               \fi}
\renewcommand{\title}[1]              {\ifx\empty#1\else \gdef\@title{#1}                       \fi}


%
% Some commands to get the values of our variables
%
\newcommand{\theGraduationMonth}{%
    \ifx\@ClemsonGraduationMonth\@empty
        \PackageError{ClemsonThesis}{'graduationMonth' has not been defined}\@ehc
    \else
        \@ClemsonGraduationMonth
    \fi
}

\newcommand{\theGraduationYear}{%
    \ifx\ClemsonGraduationYear\@empty
        \PackageError{ClemsonThesis}{'graduationYear' has not been defined}\@ehc
    \else
        \@ClemsonGraduationYear
    \fi
}


\newcommand{\theDegree}{%
    \ifx\ClemsonDegree\@empty
        \PackageError{ClemsonThesis}{'degree' has not been defined}\@ehc
    \else
        \@ClemsonDegree
    \fi
}

\newcommand{\theMajor}{%
    \ifx\@ClemsonMajor\@empty
        \PackageError{ClemsonThesis}{'major' has not been defined}\@ehc
    \else
        \@ClemsonMajor
    \fi
}


\newcommand{\theDepartment}{%
    \ifx\@ClemsonDepartment\@empty
        \PackageError{ClemsonThesis}{'department' has not been defined}\@ehc
    \else
        \@ClemsonDepartment
    \fi
}

\newcommand{\theDocumentType}{%
    \ifx\@ClemsonDocumentType\@empty
        \PackageError{ClemsonThesis}{'documentType' has not been defined}\@ehc
    \else
        \@ClemsonDocumentType
    \fi
}

\newcommand{\theAuthor}{%
    \ifx\@ClemsonAuthor\@empty
        \PackageError{ClemsonThesis}{'author' has not been defined}\@ehc
    \else
        \@ClemsonAuthor
    \fi
}

\newcommand{\theTitle}{%
    \ifx\@title\@empty
        \PackageError{ClemsonThesis}{'title' has not been defined}\@ehc
    \else
        \@title
    \fi
}

\newcommand{\theCommitteeChair}{%
    \ifx\@ClemsonCommitteeChair\@empty
        \PackageError{ClemsonThesis}{'committeeChair' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeChair
    \fi
}

\newcommand{\theCommitteeMemberOne}{%
    \ifx\@ClemsonCommitteeMemberOne\@empty
        \PackageError{ClemsonThesis}{'committeeMemberOne' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberOne
    \fi
}

\newcommand{\theCommitteeMemberTwo}{%
    \ifx\@ClemsonCommitteeMemberTwo\@empty
        \PackageError{ClemsonThesis}{'committeeMemberTwo' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberTwo
    \fi
}

\newcommand{\theCommitteeMemberThree}{%
    \ifx\@ClemsonCommitteeMemberThree\@empty
        \PackageError{ClemsonThesis}{'committeeMemberThree' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberThree
    \fi
}

\newcommand{\theCommitteeMemberFour}{%
    \ifx\@ClemsonCommitteeMemberFour\@empty
        \PackageError{ClemsonThesis}{'committeeMemberFour' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberFour
    \fi
}

\newcommand{\theCommitteeMemberFive}{%
    \ifx\@ClemsonCommitteeMemberFive\@empty
        \PackageError{ClemsonThesis}{'committeeMemberFive' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberFive
    \fi
}

\newcommand{\theCommitteeMemberSix}{%
    \ifx\@ClemsonCommitteeMemberSix\@empty
        \PackageError{ClemsonThesis}{'committeeMemberSix' has not been defined}\@ehc
    \else
        \@ClemsonCommitteeMemberSix
    \fi
}


%
% A command to control the line spacing
%
\newcommand{\newlinestretch}[1]{\renewcommand{\baselinestretch}{#1}\normalsize}


%
% Input the specified file, and add a \clearpage afterwards
%
\newcommand{\inputfile}[1]{
    \input{#1} \clearpage
}

%
% Generate a phantom section to help the 'hyperref' package understand where
% a section begins, add a line to the ToC with the specified title, then
% execute the specified command (e.g., \maketitle).
%
\newcommand{\addtotoc}[2]{
    \phantomsection
    \addcontentsline{toc}{chapter}{#1}
    #2 \clearpage
}

%
% We want our Table of Contents (ToC) to be named 'Table of Contents' rather than
% just 'Contents'
%
\renewcommand\contentsname{Table of Contents}


%
% Format of the title page
%
\renewcommand{\maketitle}{
   \begin{titlepage}
       \pagestyle{fancy}
       \begin{center}
          {\ }\\[1in]
          \newlinestretch{1.2}
          {\sc{{\Large \theTitle}}}
          \normalsize\\[2.5ex]
          \rule{4in}{0.5pt}\\[2.5ex]
          A \theDocumentType \\
          Presented to\\
          the Graduate School of\\
          Clemson University\\[2.5ex]
          \rule{4in}{0.5pt}\\[2.5ex]
          In Partial Fulfillment\\
          of the Requirements for the Degree\\
          \theDegree\\
          \theMajor\\[2.5ex]
          \rule{4in}{0.5pt}\\[2.5ex]
          by\\
          \theAuthor\\
          {\theGraduationMonth} {\theGraduationYear}\\[2.5ex]
          \rule{4in}{0.5pt}\\[2.5ex]
          Accepted by:\\
          {\@ClemsonCommitteeChair}, Committee Chair\\
          \ifx \@ClemsonCommitteeMemberOne   \empty \else \@ClemsonCommitteeMemberOne\\   \fi
          \ifx \@ClemsonCommitteeMemberTwo   \empty \else \@ClemsonCommitteeMemberTwo\\   \fi
          \ifx \@ClemsonCommitteeMemberThree \empty \else \@ClemsonCommitteeMemberThree\\ \fi
          \ifx \@ClemsonCommitteeMemberFour  \empty \else \@ClemsonCommitteeMemberFour\\  \fi
          \ifx \@ClemsonCommitteeMemberFive  \empty \else \@ClemsonCommitteeMemberFive\\  \fi
          \ifx \@ClemsonCommitteeMemberSix   \empty \else \@ClemsonCommitteeMemberSix\\   \fi
       \end{center}
   \end{titlepage}
}


%
% Set paragraph indention to 0.5 inches
%
\setlength{\parindent}{0.5in}


%
% Make the ToC only show Chapters and Sections
%
\setcounter{tocdepth}{1}


%
% Make subsections get numbered
%
\setcounter{secnumdepth}{3}


%
% Setup the page format.  All headers are empty.  The center footer
% contains the page number.  Also, remove the headrule from all pages.
% Finally, use the 'fancy' page style (which uses all the things we
% just setup).
%
\lhead{\empty}
\chead{\empty}
\rhead{\empty}
\lfoot{\empty}
\cfoot{\thepage}
\rfoot{\empty}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}


%
% Set the appendix to just have a letter not prepended by the main division
% number in the ToC (see the documentation for the 'appendix' package)
%
\renewcommand{\setthesection}{\Alph{section}}


%
% Setup the ToC and List of {Tables|Figures|Whatever} to
% include the ellipses between the name and the page number.  Also make
% the page number big enough so that three digit numbers can be used.
%
\DeclareRobustCommand{\changetochap}{%
    \renewcommand{\cftchapleader}{\cftchapfont\cftdotfill{\cftdotsep}}%
    \cftsetpnumwidth{1.5em}
}
\changetochap
