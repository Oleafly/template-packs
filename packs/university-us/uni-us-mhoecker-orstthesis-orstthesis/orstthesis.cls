% Oregon State University Thesis class
% by Martin Hoecker-Martinez
% mhoecker@coas.oregonstate.edu
%
%
%
%
% Documentation is in the companion document (orstthesis.tex)
%

\ProvidesClass{orstthesis}[2010/04/09]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[letterpaper,openany,twoside]{book}
\special{papersize=8.5in,11in}
\setlength{\paperheight}{11in}
\setlength{\paperwidth}{8.5in}
\usepackage{geometry}
\geometry{paperheight=11in,paperwidth=8.5in,includehead,left=1.6in,right=1in,top=1.5in,bottom=1in}
\usepackage[nottoc,notlof,notlot]{tocbibind}
\usepackage{fancyhdr}
\usepackage{ifthen}
\usepackage{calc}
\usepackage{setspace}
\usepackage{titlesec}
\usepackage{makeidx}
\usepackage{tocloft}
\usepackage{afterpage}

\newlength{\figwidth}
\setlength{\figwidth}{.9\textwidth}
\newlength{\figheight}
\setlength{\figheight}{.6\textheight}
\setlength{\headheight}{15pt}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}


\renewcommand{\cftdotsep}{1}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftdot}{\ensuremath{\cdot}}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}

\renewcommand{\cfttoctitlefont}{\normalfont\hfill}
\renewcommand{\cftaftertoctitle}{\hfill\ }
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\setlength{\cftbeforetoctitleskip}{0em}
\setlength{\cftaftertoctitleskip}{0em}
\setlength{\cftbeforechapskip}{1em}

\renewcommand{\cftloftitlefont}{\normalfont\hfill}
\renewcommand{\cftafterloftitle}{\hfill\ }
\renewcommand{\listfigurename}{LIST OF FIGURES}
\setlength{\cftbeforeloftitleskip}{\cftbeforetoctitleskip}
\setlength{\cftafterloftitleskip}{\cftaftertoctitleskip}

\renewcommand{\cftlottitlefont}{\normalfont\hfill}
\renewcommand{\cftafterlottitle}{\hfill\ }
\renewcommand{\listtablename}{LIST OF TABLES}
\setlength{\cftbeforelottitleskip}{\cftbeforetoctitleskip}
\setlength{\cftafterlottitleskip}{\cftaftertoctitleskip}

\DeclareRobustCommand*{\extratochead}{\afterpage{\hfill\underline{Page}\par}}
\addtocontents{toc}{\protect{\hfill\underline{Page}\par}}
\addtocontents{toc}{\protect\thispagestyle{empty}}
\addtocontents{toc}{\extratochead}
\addtocontents{lof}{\protect{\underline{Figures}\hfill\underline{Page}\par}}
\addtocontents{lof}{\protect\thispagestyle{empty}}
%\addtocontents{lof}{\extratochead}
\addtocontents{lot}{\protect{\underline{Tables}\hfill\underline{Page}\par}}
\addtocontents{lot}{\protect\thispagestyle{empty}}
%\addtocontents{lot}{\extratochead}


\newlength{\sigheight}
\setlength{\sigheight}{.5in}


\newlength{\sigwidth}
\setlength{\sigwidth}{.9\textwidth}

\newcommand{\sig}[1]{\begin{center}\vspace{\sigheight}\rule{\sigwidth}{1pt}\\#1\end{center}}
\newcommand{\lsig}[1]{\begin{flushleft}
\vspace{\sigheight}\rule{\sigwidth}{1pt}\\
#1
\end{flushleft}
}

%\titleformat{\chapter}{\normalfont}{\thechapter.}{0pt}{\begin{center}}{\end{center}%%
% \addtocontents{lof}{\protect\addvspace{\cftbeforechapskip}}%
% \addtocontents{lot}{\protect\addvspace{\cftbeforechapskip}}%
% }

\renewcommand{\chapter}{%
\cleardoublepage%
\addtocontents{lof}{\protect\addvspace{\cftbeforechapskip}}%
\addtocontents{lot}{\protect\addvspace{\cftbeforechapskip}}%
\@startsection{chapter}{1}{0pt}{4em}{4em}{\clearpage\centering\singlespace\MakeUppercase}%
}
\renewcommand{\section}{\@startsection{section}{2}{0pt}{3em}{3em}{\centering}}
\renewcommand{\subsection}{\@startsection{subsection}{3}{0pt}{2em}{2em}{\centering}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{1em}{1em}{1ex}{\centering}}

\newcommand{\osu}{Oregon State University}

\newcommand{\dept}{Department}
\newcommand{\deptis}[1]{\renewcommand{\dept}{#1}}

\newcommand{\prof}{Major Professor}
\newcommand{\profis}[1]{\renewcommand{\prof}{#1}}

\newcommand{\name}{Degree S. Student}
\newcommand{\nameis}[1]{\renewcommand{\name}{#1}}

\newcommand{\degreename}{Doctor of Philosophy}
\newcommand{\degreeis}[1]{\renewcommand{\degreename}{#1}}

\newcommand{\major}{Major}
\newcommand{\majoris}[1]{\renewcommand{\major}{#1}}

\newcommand{\defensedate}{\today}
\newcommand{\defensedateis}[1]{\renewcommand{\defensedate}{#1}}

\newcommand{\commencement}{June \number\year}
\newcommand{\commencementis}[1]{\renewcommand{\commencement}{June #1}}

\newcommand{\thesistitle}{Thesis Title}
\newcommand{\thesistitleis}[1]{\renewcommand{\thesistitle}{#1}}

\newcommand{\depthead}{Dean}
\newcommand{\deptheadis}[1]{\renewcommand{\depthead}{#1}}

\newcommand{\flyleaf}{
\newpage
\thispagestyle{empty} \ 
\newpage
}

\newcommand{\phdabstract}[1]{
\begin{center}
AN ABSTRACT OF THE DISSERTATION OF
\end{center}
\underline{\name} for the degree of \underline{\degreename} in \underline{\major} presented on \underline{\defensedate}.\\
Title:\ \underline{\thesistitle}.\\
\\
\\
Abstract Approved:\\
\sig{\prof}
\doublespacing
#1
\singlespace
}

\newcommand{\copyrightpage}{
\newpage
\ \vspace{10\baselineskip}
\begin{center}
\copyright Copyright by \name\\
\defensedate\\
All Rights Reserved
\end{center}
\vfill
\newpage
}

\newcommand{\osutitle}{
\newpage
\begin{center}
\thesistitle\\
\vfill
by\\
\name\\
\vfill
A DISSERTATION\\
submitted to\\
\vfill
\osu\\
\vfill
in partial fulfillment of\\
the requirements for the\\
degree of\\
\vfill
\degreename\\
\vfill
Presented \defensedate\\
Commencement \commencement
\end{center}
\newpage
}

\newcommand{\approval}{
\newpage
\noindent
\underline{\degreename} dissertation of \underline{\name} presented \underline{\defensedate}.
\vfill
\noindent
APPROVED:
\lsig{\prof, representing \major}
\lsig{\depthead{} of the \dept}
\lsig{Dean of the Graduate School}
\vfill
I understand that my dissertation will become a part of the permanent collection of \osu{} libraries. My signature below authorizes release of my dissertation to any reader upon request.
\sig{\name, Author}
\newpage
}

\newcommand{\acknowledge}[1]{
\newpage
\begin{center}
ACKNOWLEDGEMENTS
\end{center}
\doublespacing
#1
\singlespace
\newpage
}

\newcommand{\authors}[1]{
\newpage
\begin{center}
CONTRIBUTION OF AUTHORS
\end{center}
\doublespacing
#1
\singlespace
\newpage
}

\newcommand{\dedication}[1]{
\newpage
\begin{center}
Preface
\end{center}
\doublespacing
#1
\singlespace
\newpage
}

\newcommand{\preface}[1]{
\newpage
\begin{center}
Preface
\end{center}
\doublespacing
#1
\singlespace
\newpage
}

\renewcommand\frontmatter{%
  \@mainmatterfalse
  \fancypagestyle{conthead}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[C]{\leftmark{} (CONTINUED)}
  }
  \fancypagestyle{empty}{%
   \renewcommand{\headrulewidth}{0pt}
   \fancyhf{}
  }
  \pagestyle{empty}
  \sloppy
}


\newcommand\mainmatters{
\mainmatter
\fussy
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[RO,LE]{\ifthenelse{\value{page}>1}{\thepage}{}}
\pagestyle{fancy}
}



\newcommand\appendices{
\appendix
\rule{0pt}{.3\textheight}\\
\begin{center}
\addcontentsline{toc}{chapter}{\protect{Appendices}}
\Large\textbf{APPENDICES}
\addtocontents{toc}{\protect\setcounter{tocdepth}{-1}}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
\end{center}
\vfill
\pagebreak
\def\thechapter{\Alph{chapter}}
\def\thesection{\thechapter.\arabic{section}}
}

