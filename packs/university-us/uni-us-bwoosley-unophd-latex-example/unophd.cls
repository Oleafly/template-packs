% --- Class structure: declaration of options part
% ---
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.min" exists, then it is loaded

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
% --- Class structure: execution of options part
% ---
\ProcessOptions \relax
% --- Class structure: declaration of options part
% ---
\LoadClass{book}

\RequirePackage[inner=1.5in,outer=1in,top=1in,bottom=1in]{geometry}


\RequirePackage{fancyhdr}
\fancypagestyle{plain}{%
\fancyhf{}
\fancyhead[R]{\thepage}
\fancyhead[L]{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}

\renewcommand\rightmark{}
\renewcommand\leftmark{}


\RequirePackage{setspace}

\RequirePackage{etoolbox}

\doublespacing

%\def\@subtitle{None}
%\newcommand{\subtitle}[1]{\def\@subtitle{#1}}

\def\@degree{None}
\newcommand{\degree}[1]{\def\@degree{#1}}

\def\@major{None}
\newcommand{\major}[1]{\def\@major{#1}}

\def\@advisor{None}
\newcommand{\advisor}[1]{\def\@advisor{#1}}

%\def\@committeeOne{None}
%\newcommand{\committeeOne}[1]{\def\@committeeOne{#1}}

%\def\@committeeTwo{None}
%\newcommand{\committeeTwo}[1]{\def\@committeeTwo{#1}}

%\def\@committeeThree{None}
%\newcommand{\committeeThree}[1]{\def\@committeeThree{#1}}


\newcounter{cnt}
\newcommand\textlist{}
\newcommand\settext[2]{%
  \csdef{text#1}{#2}}
\newcommand\addcommitteemember[1]{%
  \stepcounter{cnt}%
  \csdef{text\thecnt}{#1}}
\newcommand\getcommitteemember[1]{%
  \csuse{text#1}}

%\newcounter{colnum}
%\newcommand\maketabularrow[1]{%
%  \setcounter{colnum}{0}%
%  \whileboolexpr
%    { test {\ifnumcomp{\value{colnum}}{<}{#1}} }%
%    {&\stepcounter{colnum}\thecolnum}
%  }



%\makeatletter
\renewcommand\maketitle{%
\begin{titlepage}
    \begin{center}
        \vspace*{1cm}
        
        {\huge{\textbf{\@title}}}
        
        \vspace{0.5cm}
        
        {\large
        By
        
        \vspace{1.5cm}
        
        \textbf{\@author}
        
        %\vfill
        A DISSERTATION
        
        Presented to the Faculty of
        
        The Graduate College at the University of Nebraska
        
        In Partial Fulfillment of Requirements
        
        For the Degree of \@degree
        
        Major: \@major
        
        Under the Supervision of \@advisor
        
        Omaha, Nebraska
        
        \@date
        
        
        \vfill
        
        Supervisory Committee:
        
        \@advisor
        
       \newcounter{colnum}
       %\newcommand\maketabularrow[1]{%
         \setcounter{colnum}{0}
         \whileboolexpr
           { test {\ifnumcomp{\value{colnum}}{<}{\thecnt}} }%
           {\stepcounter{colnum}\getcommitteemember{\thecolnum}\\}
        }
         %}
        
        %Dr. \@committeeOne
                
        %Dr. \@committeeTwo
                        
        %Dr. \@committeeThree
        %\@committee3
        
        %A thesis presented for the degree of\\
        %Doctor of Philosophy
        
        %\vspace{0.8cm}
        
        
        %Department Name\\
        %University Name\\
        %Country\\
        %\@date
        
    \end{center}
\end{titlepage}}
%\makeatother



\def\@abrv{None}
\newcommand{\abrv}[1]{\def\@abrv{#1}}

\def\@dateyear{None}
\newcommand{\dateyear}[1]{\def\@dateyear{#1}}

\def\@abstract{None}
\newcommand{\abstract}[1]{\def\@abstract{#1}}

\newcommand{\makeabstract}{%
\begin{center}
{\huge{\@title}}

\vspace{.5cm}

\@author, \@abrv


\vspace{.5cm}

University of Nebraska, \@dateyear

\vspace{.5cm}

Advisor: \@advisor

\vspace{.5cm}

\end{center}

\@abstract
}


% CODE STARTS HERE
% Based on `tocloft` package
\RequirePackage[titles]{tocloft}
\newcommand{\listmultimedianame}{List of Figures and Tables}
\newlistof{figtab}{loft}{\listmultimedianame}
\makeatletter
% Change the file extension of both lot and lof
\def\ext@figure{loft}
\def\ext@table{loft}
% Store the original `\thefigure` and `\thetable`
\let\tohe@thefigure\thefigure
\let\tohe@thetable\thetable
% Redefine them to contain a "dummy" `\tohe@list...`
\def\thefigure{\tohe@listfig\tohe@thefigure}
\def\thetable{\tohe@listtab\tohe@thetable}
% Make the two dummy commands truly dummy
\let\tohe@listfig\relax
\let\tohe@listtab\relax
% Store the original `\listoffigtab`
\let\tohe@listoffigtab\listoffigtab
% Redefine it in such a way that the dummy commands insert "Fig." or "Tab." respectively
\def\listoffigtab{%
	\begingroup
	\def\tohe@listfig{Fig.~}
	\def\tohe@listtab{Tab.~}
	\tohe@listoffigtab
	\endgroup  
}
% Change \listoffigtab spacing
\setlength{\cftfignumwidth}{5em}
\setlength{\cfttabnumwidth}{5em}
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}
\makeatother
% CODE ENDS HERE

\newcommand{\listequationsname}{List of Equations}
\newlistof{myequations}{equ}{\listequationsname}
\def\tohe@listeq{Eq.~}
\newcommand{\myequations}[1]{%
	\addcontentsline{equ}{myequations}{\protect\numberline{Eq.~\theequation}#1}\par}
\setlength{\cftmyequationsnumwidth}{3.5em}% Width of equation number in List of Equations


% TODO: add equations to above list, see http://tex.stackexchange.com/questions/173102/table-of-equations-like-list-of-figures  for idea on how to do it