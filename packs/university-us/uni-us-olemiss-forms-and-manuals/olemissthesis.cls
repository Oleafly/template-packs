%%%%%%%This thesis class was adapted by Caroline Turnage-Butterbaugh from the Princeton University thesis class created Jeff Dowskin
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{olemissthesis}[2015/04/18 v1 University of Mississippi Thesis class]

\RequirePackage{setspace,indentfirst}


\newcommand*{\frontmatter}{\pagenumbering{roman}} %Numbers the preliminary pages with Roman Numerals

\newcommand*{\mainmatter}{\pagenumbering{arabic}} %Numbers the body of the manuscript with Arabic Numerals

\newcommand*{\backmatter}{\pagenumbering{arabic}} %Numbers the body of the manuscript with Arabic Numerals

\newcommand*{\makelot}{} 

\newcommand*{\makelof}{} 

\newcommand*{\makelos}{} 

\newcommand*{\maketoc}{\tableofcontents}


\newcommand*{\bodyspacing}{\doublespacing} %Double spacing in manuscript.

%% Setup a command to set spacing for long tables, to be used manually in document
\newcommand*{\tablespacing}{\singlespacing}

%% Command inserted into the document immediately after \begin{document} to place all frontmatter
%%   This was formerly named 'begincmd' and called below in \AtBeginDocument{}
%%   However, that is not compatible with package 'hyperref'. \tableofcontents needs
%%   to be declared from within the document itself. 

\newcommand*{\makefrontmatter}{
\bodyspacing
\frontmatter\maketitlepage\makecopyrightpage\makeabstract\makededication
\makeacknowledgements\maketoc
\makelot\clearpage\makelof\clearpage\makelos
\clearpage\mainmatter
}




\def\submitted#1{\gdef\@submitted{#1}}
\def\authorcap#1{\gdef\@authorcap{#1\normalfont}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}
\def\@dept{Mathematics}
\def\@deptpref{Department of}
\long\def\acknowledgements#1{\gdef\@acknowledgements{#1}}
\def\dedication#1{\gdef\@dedication{#1}}
\def\vita#1{\gdef\@vita{#1}}



\newcommand{\maketitlepage}{{
  	\thispagestyle{empty}
	\vspace*{.75in}
	
	\begin{center}
	\@title\\
	DISSERTATION
	\end{center}
	\vfill
	\begin{center}
 	\singlespacing
    	A Dissertation \\
   	presented in partial fulfillment of requirements \\
    	for the degree of Doctor of Philosophy\\
    	in the Department of DEPARTMENT NAME\\
   	The University of Mississippi 
  	\end{center}
	\vfill
	\begin{center}
  	by\\
    	\@authorcap \\
    	\@submitted
  	\end{center} 
  	\clearpage}}
  
\newcommand*{\makecopyrightpage}{
	\thispagestyle{empty}
  	\vspace*{0in}
	\vfill
  	\begin{center}
  	\singlespacing
     	Copyright  \@author {} \@copyrightyear \\
    	ALL RIGHTS RESERVED
  	\end{center}
  	\clearpage}

\newcommand*{\makeabstract}{
  	\newpage
	\vspace*{.75in} % makes Abstract top margin 2"
  	\setcounter{page}{2} % makes Abstract page numbered as ii
  	\addcontentsline{toc}{chapter}{\normalfont ABSTRACT}
  	\begin{center}
  	ABSTRACT
  	\end{center}
  	\@abstract
 	\clearpage}
  
\def\makededication{
	\vspace*{.75in} % makes Dedication top margin 2"
  	\ifx\@dedication\undefined
  	\else
   	\ifdefined\phantomsection% makes hyperref recognize this section properly for pdf links
     	\phantomsection
    	\else
   	\fi

    	\addcontentsline{toc}{chapter}{\normalfont DEDICATION}
    	\begin{center}
      	DEDICATION
   	\end{center}
    	\@dedication
    	\clearpage
  	\fi}
  
\def\makeacknowledgements{
	\vspace*{.75in} % makes Acknowledgements top margin 2"
  	\ifx\@acknowledgements\undefined
  	\else
    	\ifdefined\phantomsection% makes hyperref recognize this section properly for pdf links
     	\phantomsection
    	\else
    	\fi

    	\addcontentsline{toc}{chapter}{\normalfont ACKNOWLEDGEMENTS}
    	\begin{center}
      	ACKNOWLEDGEMENTS
    	\end{center}
    	\@acknowledgements
    	\clearpage
 	 \fi}
	 




\DeclareOption{lot}{\renewcommand*{\makelot}{
  	\ifdefined\phantomsection
	% makes hyperref recognize this section properly for pdf links
    	\phantomsection
  	\else
  	\fi
  	\addcontentsline{toc}{chapter}{\normalfont List of Tables}\listoftables}}
	\DeclareOption{lof}{\renewcommand*{\makelof}{
  	\ifdefined\phantomsection
	% makes hyperref recognize this section properly for pdf links
    	\phantomsection
  	\else
 	\fi
  	\addcontentsline{toc}{chapter}{List of Figures}\listoffigures}}

\DeclareOption{los}{
  	\renewcommand*{\makelos}{
    	\RequirePackage{losymbol}
    	\section*{List of Symbols\@mkboth {\normalfont LIST OF SYMBOLS}{LIST OF SYMBOLS}}
    	\@starttoc{los}
  	\ifdefined\phantomsection
	% makes hyperref recognize this section properly for pdf links
    	\phantomsection
  	\else
  	\fi
    	\addcontentsline{toc}{chapter}{List of Symbols}}}

\DeclareOption{singlespace}{
  	\renewcommand*{\bodyspacing}{
  	\singlespacing}

%% Add extra space only if in singlespacing mode
\renewcommand*{\extravspace}[1]{\vspace{#1}}}

%% Doublespacing is the default for the thesis -- need not be declared.
\DeclareOption{doublespacing}{
  	\renewcommand*{\bodyspacing}{
  	\doublespacing}}
	
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\LoadClass{report}

\setlength{\oddsidemargin}{0in}   %{.4375in}
\setlength{\evensidemargin}{0in} %{.4375in}
\setlength{\topmargin}{-.5in}  %{-.5625in}
\setlength{\footskip}{.5in} % to put page number 3/4" from the bottom of the page (1/4" from bottom of body text)
\setlength{\textheight}{9in}
\setlength{\textwidth}{6.5in}

%%% Alter LaTeX defaults to try to eliminate all widows and orphans and pages ending with a hyphenated word
\clubpenalty=10000
\widowpenalty=10000
\brokenpenalty=10000

\long\def\abstract#1{\gdef\@abstract{#1}}

\endinput
%% 
%% End of file `olemissthesis.cls'.
