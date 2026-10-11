% Thesis/project template for WSU ECE MS degrees
% 
% Written September 2019 by Eric Gibbons
% modified for the Weber State University MSEE/MSCE programs

%%%%% 
%%%%% PRELIMS
%%%%% 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wsuthesis-1e}[2019/09/01 WSU ECE thesis class]

\typeout{Note that this tries to fulfill the Weber State University Thesis
  requirements but it is unofficial}

%%%%% 
%%%%% PRELIMINARY DECLARATIONS
%%%%% 

\LoadClass[12pt]{report}
\RequirePackage{setspace}
\RequirePackage{nomencl}
\makenomenclature

%%%%% 
%%%%% SETUP MARGINS AND PENALTIES NEEDED FOR STANFORD THESIS
%%%%% 

% We need 1" margins except on the binding edge, where it is 1 1/2"
% Theses may be either single or double sided
\if@twoside
\usepackage[top=1in, bottom=1in, right=1in, left=1.5in, assymetric]{geometry} % margins
\else
\usepackage[top=1in, bottom=1in, right=1in, left=1.5in]{geometry} % margins
\fi

%%%%% 
%%%%% OPTIONS
%%%%% 

\def\thesistype#1{\gdef\@thesistype{#1}}
\def\engineeringtype#1{\gdef\@engineeringtype{#1}}
\def\principaladvisor#1{\gdef\@principaladvisor{#1}}
\def\firstreader#1{\gdef\@firstreader{#1}}
\def\secondreader#1{\gdef\@secondreader{#1}}
\def\thirdreader#1{\gdef\@thirdreader{#1}}
\def\fourthreader#1{\gdef\@fourthreader{#1}}

\def\@copyrightyear{\number\the\year}

\newif\iffigurespage
\newif\iftablespage
\newif\ifnomenclaturepage

\figurespagetrue
\tablespagetrue

\renewcommand{\contentsname}{Table of Contents}


\newlength{\signaturespace}
\setlength{\signaturespace}{.5in}

\newcommand{\signature}[2]{%
  \begin{minipage}{5in}
    \underline{\hspace{3in}}\\
    #1\\
    #2
  \end{minipage}
  \vskip0.6in
}

\newcommand{\titlep}{
  \thispagestyle{empty}
  \begin{center}
    \doublespacing\uppercase\expandafter{\@title}

    by

    \@author
  \end{center}

  \begin{center}
    A \@thesistype\  submitted in partial fulfillment\\
    of the requirements for the degree\\
    of\\
    MASTER OF SCIENCE\\
    in\\
    \@engineeringtype\ Engineering
  \end{center}

  \vfill

  \begin{flushleft}
    Approved:
    \vskip0.6in
    \signature{\@principaladvisor}{Major Professor}
    \signature{\@firstreader}{Committee Member}
    \signature{\@secondreader}{Committee Member}

  \end{flushleft}
  \mbox{}
  \vfill
  \begin{center}
    Weber State University\\
    Ogden, Utah\\
    \the\year
  \end{center}
  \clearpage
}

\newcommand{\thesiscopyrightpage}{%
  \null\vfill
  \begin{center}
    \large
    \copyright\ Copyright\ by \@author\ \@copyrightyear\\
    All Rights Reserved
  \end{center}
  \vfill
  \clearpage
}

\newcommand{\beforepreface}{%
        \pagenumbering{roman}
        \pagestyle{plain}
        \titlep
        \thesiscopyrightpage
        \cleardoublepage
      }



\newcommand{\prefacesection}[1]{%
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
}

\newcommand{\afterpreface}{%
  \newpage
  \tableofcontents
  \iftablespage
  \listoftables
  \fi
  \iffigurespage
  \listoffigures
  \fi
  \ifnomenclaturepage
  \printnomenclature
  \fi
}

\newcommand{\startchapters}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \pagestyle{headings}
}

\let\@ldthebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \newpage
  \@ldthebibliography{#1}%
  \addcontentsline{toc}{chapter}{\bibname}
}


%%%%% 
%%%%% MORE DECLARATIONS
%%%%% 

