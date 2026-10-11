% This file defines a thesis class for
% the University of York. The class 
% complied with the York Regulation 2.7
% in 2016.
%
% Written by J H Pickering, based on
% the UWA thesis class by R Huss.
% Then lovelingly updated by A West.
% Then subsequently butchered by D Shaw and P How

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yorkThesis}

\typeout{York Thesis style by D Shaw and P How 2018}

\LoadClass[11pt,a4paper,titlepage,openright,oneside]{book}
\usepackage[a4paper, inner=40mm, outer=16mm]{geometry}
\RequirePackage{ifthen}
\RequirePackage{setspace}

% Do we want lists of figures and tables? By default, yes.
\newboolean{@wantlistoffigures}
\setboolean{@wantlistoffigures}{true}
\newboolean{@wantlistoftables}
\setboolean{@wantlistoftables}{true}

\DeclareOption{nolof}{\setboolean{@wantlistoffigures}{false}}
\DeclareOption{nolot}{\setboolean{@wantlistoftables}{false}}

\ProcessOptions

% Set parameters for floats

\setcounter{totalnumber}{10}               % Pretty unlikely
\renewcommand{\topfraction}{0.85}          % Floats may occupy up to 85%
\renewcommand{\bottomfraction}{0.85}       %  of the page. This is slightly
\renewcommand{\textfraction}{0.15}         %  different to the old style
\renewcommand{\floatpagefraction}{0.60}    % Can allow quite a lot of whitespace on a float page


% Set margins so that (for A4) there is >40 mm on the left hand binding edge, and >15mm everywhere else
\setlength{\textheight}{230mm}
%\setlength{\oddsidemargin}{15mm}
%\setlength{\textwidth}{154mm}

% Call it what you like York regs distinguish
% between a list of Refs and a bibliography
% of not necessarily referenced material 
\renewcommand{\bibname}{List of References}

% Comply with York regs 2.7.3.j & 2.7.3.l
\setcounter{secnumdepth}{4}	% Allows numbering of sections up to 4 numbers (e.g. 3.2.1.4)
\pagenumbering{arabic}
 
% Macros to define department, supervisor and submission date

\def\dept#1{\gdef\@dept{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}

  \def\@title{}
  \def\@author{}
  \def\@dept{}
  \def\@supervisor{}
  \def\@submitdate{\ifcase\the\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space \number\the\year}

% Generate title page
\newcommand{\titlePage}{
	\begin{singlespace}
	\thispagestyle{empty}%
	\ \vspace{1in}%
	\begin{center}
		{\Huge\expandafter{\bf \@title}\par}
	\end{center}
        \vspace{0.75in}
	\begin{center}
		{\Huge\bf \@author} \\
        \vspace{1in}
        
        \begin{center}
        \begin{minipage}{5in}
         \begin{center}
		 \vspace{22 pt}
          %This thesis is submitted in partial fulfilment of the\\
          %requirements for the degree of\\
          Doctor of Philosophy
         \end{center}
        \end{minipage}
        \end{center}

        \vspace{0.5in}
		\vspace{0.25in}
            \vspace{33 pt}
		  University of York \\
		
         % York\\
          %YO10 5DD\\
         % UK \\
        \vspace{0.25in}
         \@dept \\
        \vspace{0.25in}
         \@submitdate
	\end{center}
        \end{singlespace}
}

%generate the corrections page - NO LONGER REQUIRED WHEN USING WORD-PROCESSING
\newcommand{\correctionsPage}{
	\newpage
	\thispagestyle{plain}
	\pagestyle{myheadings}
	\markright{CORRECTIONS}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\Huge\textbf{Corrections}}
	\end{flushleft}
	\vspace{20\p@}
}

%an abstract page - REMEMBER this should only be 300 words
\newcommand{\abstract}[1]{
	\newpage
	\markright{}
	\ \vspace{59\p@}
	\begin{flushleft}
 	  {\Huge\textbf{Abstract}}
	\end{flushleft}
	\vspace{20\p@}
	%#1
}

\newcommand{\contents}{
\clearpage
	%\phantomsection
	%\addcontentsline{toc}{chapter}{Contents}
	\tableofcontents
	\newpage
  \ifthenelse{\boolean{@wantlistoftables}}{
	  \clearpage
	  \phantomsection
	  \addcontentsline{toc}{chapter}{List of Tables}
	  \listoftables
  }{}
  \ifthenelse{\boolean{@wantlistoffigures}}{
	  \clearpage
	  \phantomsection
	  \addcontentsline{toc}{chapter}{List of Figures}
	  \listoffigures
	  \newpage
  }{}
}

\newcommand{\accompanyingMaterials}{
	\newpage
	\thispagestyle{plain}
	\pagestyle{myheadings}
	\markright{ACCOMPANYING MATERIALS}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\Huge\textbf{Accompanying Materials}}
	\end{flushleft}
	\vspace{20\p@}
}

\newcommand{\preface}[1]{
	\newpage
	\markright{}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\Huge \textbf{Preface}}
	\end{flushleft}
	\vspace{20\p@}
	#1
	\vspace{59\p@}
}

\newcommand{\acknowledgments}[1]{
	\newpage\pagestyle{plain}
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{Acknowledgements}
	\newlength{\candwidth}
	\settowidth{\candwidth}{(candidate)}
	%\markright{}
	%\ \vspace{59\p@}
	%\chaptermark{Acknowledgements}
	\begin{flushleft}
	  {\Huge \textbf{Acknowledgments}}
	\end{flushleft}
	\vspace{0.5in}
	\noindent
%	\vspace{59\p@}
}


%Generate an Author's Declaration page
\newcommand{\declaration}{
\newpage\thispagestyle{plain}
  \clearpage
  %\phantomsection
  \phantomsection
  \addcontentsline{toc}{chapter}{Declaration}
%  \newlength{\candwidth}
  \settowidth{\candwidth}{(candidate)}
  \begin{flushleft}
  {\Huge {\bf Declaration}}
  \end{flushleft}
  \vspace{0.5in}
  \noindent This thesis has not previously been accepted for any degree and is not being concurrently submitted in candidature
  for any degree other than Doctor of Philosophy of the University of York.
  This thesis is the result of my own investigations, except
  where otherwise stated. All other sources are acknowledged by explicit references.

 
  
  %I hereby give consent for my thesis, if accepted, to be made
  %available for photocopying and for inter-library loan, and for the
  %title and summary to be made available to outside organisations.
  %\vspace{0.5in}

 % \begin{minipage}{5.0in}
 %   \noindent Signed \dotfill (candidate)\\[1.5em]
 %   \noindent Date \dotfill \hspace{\candwidth}
 % \end{minipage}
}


% After the declaration, the main body and text goes here
% Followed by appendices


\newcommand{\definitions}{
	\newpage
	\thispagestyle{plain}
	\pagestyle{myheadings}
	\markright{DEFINITIONS}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\Huge \textbf{Definitions}}
	\end{flushleft}
	\vspace{20\p@}
	This section contains Definitions of any terms specific
        to the thesis, including abbreviations and codes used 
        in illustrations.\\
}

\newcommand{\yorkGlossary}{
	\newpage
	\thispagestyle{plain}
	\pagestyle{myheadings}
	\markright{GLOSSARY}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\Huge \textbf{Glossary}}
	\end{flushleft}
	\vspace{20\p@}
        Terms that require explanation are defined in this section, 
        including a key to any abbreviations used.\\
}



% list of references, then the bibliography.  The UoY makes a distinction between these two.
\newcommand{\yorkBib}[1]{
	\newpage
	\thispagestyle{plain}
	\pagestyle{myheadings}
	\markright{BIBLIOGRAPHY}
	\ \vspace{59\p@}
	\begin{flushleft}
	  {\huge \textbf{Bibliography}}
	\end{flushleft}
	\vspace{20\p@}
	The following is a list of material that is related to the 
        subject of this thesis but was not directly referenced.
	\input{#1}
}



\newcommand{\yorkIndex}{
	\thispagestyle{plain}
        \pagestyle{myheadings}
	\markright{INDEX}
        \printindex
}


