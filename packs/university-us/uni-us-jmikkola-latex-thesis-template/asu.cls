\newcommand{\asuthesisupdate}{2004/02/07}
\newcommand{\asuthesisversion}{v1.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asu}

\newcommand{\comment}[1]{}

\newcommand{\@thesisptsz}{}
\newcommand{\@thesisside}{}
\newcommand{\@thesisopen}{}
\newcommand{\@thesislnsp}{}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[\@thesisptsz,\@thesisside,\@thesisopen]{report}

\newcommand{\degree}[1]{\ifx\empty#1\else\gdef\@degree{#1}\fi}
\newcommand{\thesistype}[1]{\ifx\empty#1\else\gdef\@thesistype{#1}\fi}
\newcommand{\department}[1]{\ifx\empty#1\else\gdef\@department{#1}\fi}
\newcommand{\gradmonth}[1]{\ifx\empty#1\else\gdef\@gradmonth{#1}\fi}
\newcommand{\gradyear}[1]{\ifx\empty#1\else\gdef\@gradyear{#1}\fi}
\newcommand{\projectdirector}[1]{\ifx\empty#1\else\gdef\@projectdirector{#1}\fi}
\newcommand{\honorsdirector}[1]{\ifx\empty#1\else\gdef\@honorsdirector{#1}\fi}
\newcommand{\secondreader}[1]{\ifx\empty#1\else\gdef\@secondreader{#1}\fi}
\newcommand{\deptchair}[1]{\ifx\empty#1\else\gdef\@deptchair{#1}\fi}
\newcommand{\dean}[1]{\ifx\empty#1\else\gdef\@dean{#1}\fi}
\renewcommand{\author}[1]{\ifx\empty#1\else\gdef\@author{#1}\fi}
\renewcommand{\title}[1]{\ifx\empty#1\else\gdef\@title{#1}\fi}

\newcommand{\newlinestretch}[1]{\renewcommand{\baselinestretch}{#1}\normalsize}

\newenvironment{preliminary}
  {\pagestyle{plain}\pagenumbering{roman}}
  {\cleardoublepage\pagenumbering{arabic}}

\renewcommand{\maketitle}{
   \begin{titlepage}
   \begin{singlespace}
   \begin{center}
      \MakeUppercase{\@title} \\[6ex] 
      \newlinestretch{2}
      by \\ 
      {\@author} \\[6ex] 
      {\@thesistype} \\[3ex] 
      Appalachian State University \\[3ex] 
      Submitted to the Department of Computer Science \\*
      in partial fulfillment of the requirements for the degree of \\[3ex]
      {\@degree} \\[3ex]
      {\@gradmonth}, {\@gradyear} \\
   \end{center}
   \vspace{1cm}
   Approved by: \\ [2ex]
   \begin{flushright}
   \underline{\hspace{3.5in}} \\
   {\@projectdirector},
   Thesis Project Director \\[4ex]
   \underline{\hspace{3.5in}} \\
   {\@secondreader},
   Second Reader \\[4ex]
   \underline{\hspace{3.5in}} \\
   {\@honorsdirector},
   Departmental Honors Director \\[4ex]
   \underline{\hspace{3.5in}} \\
   {\@deptchair},
   Chair, {\@department} \\[4ex]
   \end{flushright}
   \setcounter{page}{1}
   \end{singlespace}
   \end{titlepage}
   \setcounter{page}{2}
}

\newcommand{\makecopyright}{
    \vspace*{3.5in}
    \begin{center}
    Copyright{\copyright} {\@author} {\@gradyear}\\
    All Rights Reserved
    \end{center}
    \setcounter{page}{3}
    \newpage
}

\renewenvironment{abstract}{
   \vspace*{0.5in}
   \begin{center}
      ABSTRACT \\[2ex]
      \newlinestretch{2}
      {\@title}.\\
      ({\@gradmonth} {\@gradyear})\\
      {\@author}, Appalachian State University\\
      Appalachian State University \\
      Thesis Chairperson:  {\@thesischair}
   \end{center}
   \newlinestretch{2}
}{\par\newpage}

\newenvironment{acknowledgement}{
   \vspace*{0.5in}
   \begin{center}
      ACKNOWLEDGEMENTS \\[2ex]
      \newlinestretch{2}
   \end{center}
   \newlinestretch{2}
}{\par\newpage}

\newenvironment{dedication}{
   \vspace*{0.5in}
   \newlinestretch{2}
}{\par\newpage}

%
%  PAGE STYLE
%
\newcommand{\ps@asu}{%
   \renewcommand{\@oddhead}{%
      \begin{minipage}{\textwidth}\normalfont
          \hfill \thepage
      \end{minipage}}
   \renewcommand{\@evenhead}{\@oddhead}
   \renewcommand{\@oddfoot}{}
   \renewcommand{\@evenfoot}{}
}
\pagestyle{asu}
\setlength{\parindent}{0.5in}
\setcounter{secnumdepth}{1}
\setcounter{tocdepth}{1}

\flushbottom
