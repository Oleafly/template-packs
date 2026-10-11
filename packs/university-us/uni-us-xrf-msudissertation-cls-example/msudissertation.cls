% Class options:
%
%   - Either 'dissertation' (default) or 'thesis'.
%
% Commands:
%
%   - \def\thedegreeprogram{<subject>---<degree>} (*required* before \maketitle)
%
%     It should be obtained from the listing at
%     https://reg.msu.edu/academicprograms/
%
%     Example: "Underwater Basket Weaving---Doctor of Philosophy"
%
% Other than the above, everything else is mostly the same as your standard
% 'book' document.
%
% To switch to landscape mode, use \begin{landscape} ... \end{landscape}.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msudissertation}

% Options
% -------

\newcommand{\msudissertation@thesis}{dissertation}
\DeclareOption{dissertation}{\renewcommand{\msudissertation@thesis}{dissertation}}
\DeclareOption{thesis}{\renewcommand{\msudissertation@thesis}{thesis}}

% forward remaining options to the 'book' class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt,oneside]{book}

% Packages
% --------

\RequirePackage[singlelinecheck=false]{caption}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage[margin=1in,footskip=0.5in]{geometry}
\RequirePackage{setspace}               % must be loaded before bookmark/hyperref
\RequirePackage{tocloft}
\RequirePackage{totcount}
\RequirePackage{xstring}

% General
% -------

% double-space in Word = 0.391" (37.5px @ 96 DPI)
\renewcommand{\doublespacing}{\setstretch{1.865}}
\doublespacing
\let\tightlist\relax                    % used by Pandoc
\setlist{nosep}                         % remove extraneous spacing
\pagestyle{plain}
\DeclareMathSizes{12}{12}{10}{10}
\AtBeginDocument{%
  \def\LS@rot{\setbox\@outputbox\vbox{\hbox{%
    \rotatebox{90}{\box\@outputbox}%
    \rotatebox{90}{\raisebox{-0.5in}{\makebox[\hsize][c]{\thepage}}}%
  }}}%
  \apptocmd{\landscape}{\pagestyle{empty}}{}{}%
}
% macros for hyperref if the user loads it later
\newcommand{\msudissertation@texorpdfstring}[2]{%
  \ifdefined\texorpdfstring
    \texorpdfstring{#1}{#2}%
  \else
    #1%
  \fi
}
\newcommand{\msudissertation@bookmark}[3]{%
  \ifdefined\hypertarget
    \hypertarget{#1}{#2}%
    \pdfbookmark{#3}{#1}%
  \else
  \fi
}

% Title page
% ----------

\newcommand{\msudissertation@title}[1]{%
  \begin{center}%
    \vspace{-\topskip}%
    \begin{singlespace}%
      \MakeUppercase{#1\@title}%
    \end{singlespace}

    By

    \@author
  \end{center}%
}

\date{\the\year}
\newcommand{\thedegreeprogram}{%
  \ClassWarningNoLine{msudissertation}{\noexpand\thedegreeprogram was not defined}%
}
% if the user uses titling, our maketitle would get overwritten
% so postpone this until beginning of document
\AtBeginDocument{%
  \renewcommand{\maketitle}{%
    \newgeometry{top=2in, left=1in, right=1in, bottom=1.5in}%
    \begin{titlepage}%
      \nointerlineskip
      \vspace*{-2\topskip}%
      \msudissertation@title{\large}

      \vspace{2.5in}

      \begin{center}%
        A \MakeUppercase{\msudissertation@thesis}

        \begin{singlespace}%
          Submitted to \\
          Michigan State University \\
          in partial fulfillment of the requirements \\
          for the degree of
        \end{singlespace}

        \thedegreeprogram

        \@date
      \end{center}%
    \end{titlepage}%
    \stepcounter{page}%
    \restoregeometry
  }%
}

% After-chapter hook
% ------------------

% this is such an awful hack: a global hook for "after-chapter" macros
\gdef\msudissertation@afterChapter{\relax}
\newcommand{\msudissertation@callAfterChapter}{%
  \msudissertation@afterChapter%
  \gdef\msudissertation@afterChapter{\relax}%
}
% register the places where the hook gets called
\pretocmd{\chapter}{\msudissertation@callAfterChapter}{}{}
\pretocmd{\frontmatter}{\msudissertation@callAfterChapter}{}{}
\pretocmd{\mainmatter}{\msudissertation@callAfterChapter}{}{}
\pretocmd{\appendix}{\msudissertation@callAfterChapter}{}{}
\AtEndDocument{\msudissertation@callAfterChapter}

% Front matter
% ------------

\newcommand{\msudissertation@frontMatterHead}[1]{%
  \begin{center}%
    \vspace{-\topskip}%
    \textbf{\large\MakeUppercase{#1}}%
    \vspace{-\topskip}%
  \end{center}%
}

\newcommand{\msudissertation@abstractHead}[1]{%
  \thispagestyle{empty}%
  \msudissertation@frontMatterHead{#1}%
  \vspace{\parskip}%
  \msudissertation@title{}%
  \vspace{-1.05\topskip}%
}

% temporary counter for saving front matter page numbers
\newcounter{msudissertation@oldPage}

\let\msudissertation@old@chapter\@chapter
\def\@chapter[#1]#2{\IfStrEqCase{#1}{%
  {Abstract}{\msudissertation@abstractHead{#1}}%
  {Public Abstract}{%
    % Public Abstract aren't counted in the front matter page numbers
    % so we assign them a new sequence of uppercase roman letters
    \clearpage
    \setcounter{msudissertation@oldPage}{\value{page}}%
    \pagenumbering{Roman}%
    \msudissertation@abstractHead{#1}%
    \gdef\msudissertation@afterChapter{%
      \clearpage
      % restore the front matter page numbers
      \pagenumbering{roman}%
      \setcounter{page}{\value{msudissertation@oldPage}}%
    }%
  }%
  {Copyright}{%
    \thispagestyle{empty}%
    \nointerlineskip
    \vspace*{-\topskip}%
    \vspace{\fill}%
    \begin{center}%
    \begin{singlespace}%
    \begin{tabular}{l}%
    \gdef\msudissertation@afterChapter{%
      \end{tabular}%
      \end{singlespace}%
      \end{center}%
      \vspace{\fill}%
    }%
    \endlinechar=-1%
  }%
  {Dedication}{%
    \nointerlineskip
    \vspace*{-\topskip}%
    \vspace{\fill}%
    \begin{center}%
    \begin{singlespace}%
    \gdef\msudissertation@afterChapter{%
      \end{singlespace}%
      \end{center}%
      \vspace{\fill}%
    }%
  }%
  {Acknowledgments}{\@makeschapterhead{#1}}%
  {Acknowledgements}{\@makeschapterhead{#1}}%
  {Preface}{%
    \msudissertation@bookmark{msudissertation@preface}{}{#1}%
    \@makeschapterhead{#1}%
  }%
}[%
  \phantomsection
  \addcontentsline{toc}{chapter}{%
    \msudissertation@texorpdfstring{\MakeUppercase{#1}}{#1}%
  }%
  \@makechapterhead{#2}%
  \@afterheading%
]}
\let\msudissertation@old@makechapterhead\@makechapterhead
\newcommand{\msudissertation@makeAuxiliaryHead}[1]{%
  \msudissertation@frontMatterHead{#1}%
  \vspace{\baselineskip}%
}
\renewcommand{\@makechapterhead}[1]{\msudissertation@makeAuxiliaryHead{#1}}
\renewcommand{\@makeschapterhead}[1]{\msudissertation@makeAuxiliaryHead{#1}}

\let\msudissertation@oldList\list
\apptocmd{\list}{%
  \apptocmd{\item}{%
    \singlespacing
    \vspace{-0.1\baselineskip}%
  }{}{}%
}{}{}

\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttabpresnum}{\tablename{} }
\renewcommand{\cftfigpresnum}{\figurename{} }
\renewcommand{\cfttabaftersnum}{:}
\renewcommand{\cftfigaftersnum}{:}
\setlength{\cftfigindent}{0em}
\setlength{\cfttabindent}{0em}
\setlength{\cftchapnumwidth}{6em}
\setlength{\cfttabnumwidth}{5.5em}
\setlength{\cftfignumwidth}{5.8em}
\renewcommand{\cfttabafterpnum}{\vspace{12pt}}
\renewcommand{\cftfigafterpnum}{\vspace{12pt}}

\renewcommand{\contentsname}{Table of Contents}
% tocloft overwrites these AtBeginDocument, so we have to do the same
\AtBeginDocument{%
  \renewcommand{\tableofcontents}{%
    \clearpage
    \msudissertation@bookmark{msudissertation@tableofcontents}{}{\contentsname}%
    \chapter*{\contentsname}%
    \vspace{-10pt}%
    \begin{singlespace}%
      \@starttoc{toc}%
    \end{singlespace}%
  }%
  \renewcommand{\listoftables}{%
    \clearpage
    \chapter{\listtablename}%
    \begin{singlespace}%
      \@starttoc{lot}%
    \end{singlespace}%
  }%
  \renewcommand{\listoffigures}{%
    \clearpage
    \chapter{\listfigurename}%
    \begin{singlespace}%
      \@starttoc{lof}%
    \end{singlespace}%
  }%
}

% Main matter
% -----------

\def\msudissertation@mainmatter@chapter[#1]#2{%
  \refstepcounter{chapter}%
  \addcontentsline{toc}{chapter}{%
    \protect\numberline{\@chapapp{} \thechapter}#1%
  }%
  \@makechapterhead{#2}%
  \@afterheading
}
\newcommand{\msudissertation@makeChapterHead}[1]{%
  \begin{flushleft}%
    \textbf{\huge\@chapapp{} \thechapter}%
  \end{flushleft}

  \nobreak
  \vspace{20pt}%
  \begin{flushleft}%
    \textbf{\Huge #1}%
  \end{flushleft}

  \nobreak
  \vspace{25pt}%
}
\apptocmd{\mainmatter}{%
  \renewcommand{\list}\msudissertation@oldList
  \renewcommand{\@chapter}\msudissertation@mainmatter@chapter
  \renewcommand{\@makechapterhead}\msudissertation@makeChapterHead
}{}{}

% Appendices
% ----------

\regtotcounter{chapter}
\newcommand{\appendicesname}{%
  \ifnumgreater{\totvalue{chapter}}{1}{Appendices}{Appendix}%
}
\def\msudissertation@appendices@chapter[#1]#2{%
  \refstepcounter{chapter}%
  \addcontentsline{toc}{section}{%
    \@chapapp{} \thechapter{} #1%
  }%
  \@makechapterhead{#2}%
  \@afterheading
}
\def\msudissertation@appendix@chapter[#1]#2{%
  \refstepcounter{chapter}%
  \@makechapterhead{#2}%
  \@afterheading
}
\def\msudissertation@unstarSect#1#2#3#4#5#6[#7]#8{\@ssect{#3}{#4}{#5}{#6}{#8}}
\apptocmd{\appendix}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{%
    \msudissertation@texorpdfstring{\MakeUppercase{\appendicesname}}{\appendicesname}%
  }%
  \nointerlineskip
  \vspace*{-\topskip}%
  \vspace{\fill}%
  \msudissertation@frontMatterHead{\appendicesname}%
  \vspace{\fill}%
  \clearpage
  \ifnumgreater{\totvalue{chapter}}{1}{%
    \let\@chapter\msudissertation@appendices@chapter
  }{%
    \let\@chapter\msudissertation@appendix@chapter
  }%
  \let\@sect\msudissertation@unstarSect
}{}{}

% Bibliography
% ------------

\newcommand{\msudissertation@makeBiblioHead}[1]{%
  \msudissertation@makeAuxiliaryHead{#1}%
  \vspace{14pt}%
}

% For natbib
\pretocmd{\bibliography}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{%
    \msudissertation@texorpdfstring{\MakeUppercase{\bibname}}{\bibname}%
  }%
  \nointerlineskip
  \vspace*{-\topskip}%
  \vspace{\fill}%
  \msudissertation@frontMatterHead{\bibname}%
  \vspace{\fill}%
  \clearpage
  \renewcommand{\@makeschapterhead}{\msudissertation@makeBiblioHead}%
  \singlespacing
}{}{}

% For biblatex
\newcommand{\msudissertation@bibheading}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{%
    \msudissertation@texorpdfstring{\MakeUppercase{#1}}{#1}%
  }%
  \nointerlineskip
  \vspace*{-\topskip}%
  \vspace{\fill}%
  \msudissertation@frontMatterHead{#1}%
  \vspace{\fill}%
  \clearpage
  \renewcommand{\@makeschapterhead}{\msudissertation@makeBiblioHead}%
  \chapter*{\MakeUppercase{#1}}%
  \markboth{#1}{#1}%
  \vspace*{-1.2\topskip}%
  \singlespacing
  \setlength{\bibitemsep}{0.9\baselineskip}%
}
\AtBeginDocument{%
  \ifdef{\defbibheading}{%
    \defbibheading{bibliography}[\bibname]{\msudissertation@bibheading{#1}}%
    \defbibheading{bibintoc}[\bibname]{\msudissertation@bibheading{#1}}%
  }{}%
}
