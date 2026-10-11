\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iitkthesis}[2020/11/26 IIT Thesis LaTeX class]

%% -----------------------------------
%% Parent Class
%% -----------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper,onecolumn]{book}
%% -----------------------------------

%% -----------------------------------
%% Page Margins
%% -----------------------------------
\RequirePackage[%
  a4paper,%
  left=1.4in,%
  top=1in,%
  right=1in,%
  bottom=1in%
]{geometry}
%% -----------------------------------

%% -----------------------------------
%% Line spacing
%% -----------------------------------
\RequirePackage{setspace}
\doublespacing
%% -----------------------------------

%% -----------------------------------
%% Graphics
%% -----------------------------------
\RequirePackage{graphicx}
\graphicspath{ {./images/} }
%% -----------------------------------

%% -----------------------------------
%% Compact Enumeration
%% -----------------------------------
\RequirePackage{enumitem}
\setlist[enumerate]{itemsep=0in}
%% -----------------------------------

%% -----------------------------------
%% Extra font sizes
%% -----------------------------------
\RequirePackage{anyfontsize}
%% -----------------------------------

%% -----------------------------------
%% Customizing section font
%% -----------------------------------
\RequirePackage{sectsty}
\allsectionsfont{\normalfont\sffamily}
\paragraphfont{\sffamily}
%% -----------------------------------

%% -----------------------------------
%% Class variable definitions
%% -----------------------------------

% Variable: rollno
\let\iitk@rollno\relax
\def\rollno#1{\def\iitk@rollno{#1}}

% Variable: degree
\let\iitk@degree\relax
\def\degree#1{\def\iitk@degree{#1}}

% Variable: department
\let\iitk@department\relax
\def\department#1{\def\iitk@department{#1}}

% Variable: submissiondate
\let\iitk@submissiondate\relax
\def\submissiondate#1{\def\iitk@submissiondate{#1}}

% Variable: logo
\def\iitk@logo{\includegraphics[width=40mm]{iitk-logo.pdf}}
\def\logo#1{\gdef\iitk@logo{\includegraphics[width=40mm]{#1}}}

% Variable: institute
\def\iitk@institute{Indian Institute of Technology Kanpur}
\def\institute#1{\gdef\iitk@institute{#1}}

% Variable: abbrevinst
\def\iitk@abbrevinst{\textsc{iit} Kanpur}
\def\abbrevinst#1{\gdef\iitk@abbrevinst{#1}}

% Variable: instaddress
\def\iitk@instaddress{Kanpur 208016}
\def\instaddress#1{\gdef\iitk@instaddress{#1}}

% Variable: advisors
\let\iitk@advisors\relax
\def\advisors#1{\gdef\iitk@advisors{#1}}

% Variable: advisornames
\let\iitk@advisornames\relax
\def\advisornames#1{\gdef\iitk@advisornames{#1}}

% Variable: advisenum
\let\iitk@advisenum\relax
\def\advisenum#1{\gdef\iitk@advisenum{#1}}

%% -----------------------------------

%% -----------------------------------
%% Force single-column layout
%% -----------------------------------

% Robustness to singlecolumn layout
\newenvironment{alwayssingle}{%
  \@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\if@openright\cleardoublepage\else\clearpage\fi
  \fi}%
{\if@restonecol\twocolumn
  \else\newpage\thispagestyle{empty}\fi}

%% -----------------------------------

%% -----------------------------------
%% Title Page
%% -----------------------------------

% Make title
\renewcommand\maketitle{
  \begin{titlepage}
    \cleardoublepage\thispagestyle{empty}
    \begin{alwayssingle}

      \begin{center}
        {\iitk@logo\par}

        \vspace*{\baselineskip}
        {\sffamily\Huge\scshape\MakeLowercase{\@title}}

        \vspace*{2\baselineskip}
        A Thesis Submitted\\
        In Partial Fulfilment of the Requirements\\
        for the Degree of

        \vspace*{\baselineskip}
        {\sffamily\huge\scshape\MakeLowercase{\iitk@degree}}

        \vspace*{\fill}

        by

        \vspace*{\baselineskip}
        {\sffamily\Large\@author}

        \vspace*{2\baselineskip}
        to the\\
        {\bfseries\sffamily\Large{\iitk@department}}\\
        {\LARGE\scshape\MakeLowercase{\iitk@institute}}

        \vspace*{\baselineskip}
        {\Large\iitk@submissiondate}


        % {\par\@logo\par\vspace*{15mm}}
        % {\Huge\bfseries\@title\par}
        % {\vspace*{0.75in}\Large\bfseries\@author\par}
        % {\ifx\@department\@empty\else\large\vspace*{1ex}\par\@department\par\fi}
        % {\ifx\@degree\@empty\else\Large\itshape\@degree\par\fi}
        % \vspace*{2ex}
        % {\today}
      \end{center}

    \end{alwayssingle}
  \end{titlepage}
}
%% -----------------------------------


%% -----------------------------------
%% Certificate page
%% -----------------------------------
\DeclareRobustCommand{\advisor}[3]{%
  \begin{minipage}[t]{0.35\linewidth}
    \vspace*{4\baselineskip}
    \noindent#1\\
    #2\\
    #3
  \end{minipage}%
}

\DeclareRobustCommand{\certificate}{
  \cleardoublepage\thispagestyle{empty}
  \begin{alwayssingle}
    \vspace*{3\baselineskip}
    \begin{center}
      {\sffamily\Huge\scshape\MakeLowercase{Certificate}}
    \end{center}

    \vspace*{2\baselineskip} It is certified that the work contained in
    the thesis titled ``\textbf{\@title},'' by ``\emph{\@author}'' has
    been carried out under my/our supervision and that this work has
    not been submitted elsewhere for a degree.

    \vspace*{2\baselineskip}
    \begin{flushright}
      \noindent
      \begin{minipage}[t]{0.25\linewidth}
        \vspace*{4\baselineskip}
        \noindent\iitk@submissiondate
      \end{minipage}
      \hfill\iitk@advisors
    \end{flushright}
  \end{alwayssingle}
}
%% -----------------------------------


%% -----------------------------------
%% Declaration page
%% -----------------------------------

\DeclareRobustCommand{\declaration}{
  \cleardoublepage\thispagestyle{empty}
  \begin{alwayssingle}
    \vspace*{3\baselineskip}
    \begin{center}
      {\sffamily\Huge\scshape\MakeLowercase{Declaration}}
    \end{center}

    \vspace*{2\baselineskip} This is to certify that the thesis titled
    ``\textbf{\@title},'' has been authored by me. It presents the
    research conducted by me under the supervision of
    \emph{\iitk@advisornames}.

    To the best of my knowledge, it is an original work both in
    terms of research content and narrative, and has not been
    submitted elsewhere, in part or in full, for a degree. Further,
    due credit has been attributed to the relevant state-of-the-art
    and collaborations (if any) with appropriate citations and
    acknowledgements, in line with established norms and practices.

    \vspace*{4\baselineskip}
    \begin{singlespace}
      \begin{flushright}
        \noindent\iitk@submissiondate\hfill
        \begin{minipage}[t]{0.5\linewidth}
          {\sffamily\@author} \\
          \iitk@degree

          \vspace*{0.5\baselineskip}
          {\sffamily\iitk@department} \\
          \iitk@institute \\
          \iitk@instaddress
        \end{minipage}
      \end{flushright}
    \end{singlespace}
  \end{alwayssingle}
}
%% -----------------------------------


%% -----------------------------------
%% Abstract
%% -----------------------------------

\DeclareRobustCommand{\abstract}[1]{
  \cleardoublepage\thispagestyle{empty}
  \begin{alwayssingle}
    \begin{center}
      {\sffamily\Huge\scshape\MakeLowercase{Abstract/Synopsis}}
    \end{center}

    \vspace*{\baselineskip}
    \begin{singlespace}
      \noindent{}{\itshape{}Name of Student:}\hspace{0.5em}
      {\sffamily\@author} \hfill {\itshape{}Roll no:}
      \hspace{0.5em}{\sffamily{\iitk@rollno}}
    \end{singlespace}

    \begin{singlespace}
      \noindent{}{\itshape{}Degree:}\hspace{0.5em}
      {\sffamily\iitk@degree} \hfill {\itshape{}Department:}
      \hspace{0.5em}{\sffamily{\iitk@department}}

      \noindent{}{\itshape{}Thesis Title:}\hspace{0.5em}
      \begin{minipage}[t]{0.83\linewidth}
        \sffamily{\@title}
      \end{minipage}

    \end{singlespace}

    \begin{singlespace}
      \noindent{}{\itshape{}Name(s) of Thesis Supervisors:}

      \vspace{-0.6\baselineskip}
      {\sffamily
        \begin{enumerate}[itemsep=-0.4\baselineskip]
          \iitk@advisenum
        \end{enumerate}
      }
    \end{singlespace}


    #1
 \end{alwayssingle}
}
%% -----------------------------------

%% -----------------------------------
%% Pagestyle hack for chapters, and part
%% -----------------------------------
\renewcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{empty}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}

\renewcommand{\part}{%
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \thispagestyle{empty}%
  \if@twocolumn
  \onecolumn
  \@tempswatrue
  \else
  \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}
%% -----------------------------------

%% -----------------------------------
%% Customizing Chapter titles
%% -----------------------------------
\RequirePackage{titlesec}
\titleformat{\chapter}[display]
{\vspace{2\baselineskip}}
{\filleft\fontsize{64}{72}\selectfont\thechapter}
{\baselineskip}
{\filleft\sffamily\fontsize{24}{18}\selectfont}
[\titlerule]
%% -----------------------------------

%% -----------------------------------
%% Customizing page headers
%% -----------------------------------

\renewcommand{\chaptermark}[1]{%
  \markboth{\normalfont{\footnotesize\thechapter}.~\scshape\MakeLowercase{#1}}{}%
}
\renewcommand{\sectionmark}[1]{%
  \markright{\normalfont{\footnotesize\thesection}~\scshape\MakeLowercase{#1}}{}%
}
%% -----------------------------------

