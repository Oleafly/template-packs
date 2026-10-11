\def\filedate{2017/5/25}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mytuftsthesis}[\filedate\space Tufts University PhD Thesis Class]

\makeatletter
\newif\if@draft

\DeclareOption{draft}{\@drafttrue\PassOptionsToClass{draft,oneside}{book}} 
\DeclareOption{final}{\@draftfalse\PassOptionsToClass{final,oneside}{book}} 
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{book}} 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{11pt,final,letterpaper}

\ProcessOptions\relax
\LoadClass{book}
\RequirePackage{setspace}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}

\geometry{nofoot,nomarginpar,truedimen}
\geometry{hmargin=1.5in,bottom=1in,top=1in,headsep=.1in}

% redefine plain style
\fancypagestyle{plain}{% 
\fancyhf{}
\fancyheadoffset[R]{.75in}
\rhead{\thepage} 
\renewcommand{\headrulewidth}{0pt} 
\renewcommand{\footrulewidth}{0pt}
}

\renewcommand{\@makechapterhead}[1]{%
  \vspace*{-10\p@}%
  {\parindent \z@ \raggedright \reset@font
        {\huge \bfseries \@chapapp ~\thechapter }
        \par\nobreak
        \vspace*{10\p@}%
        \interlinepenalty\@M
        {\huge \bfseries #1\par\nobreak}
    \vskip 20\p@
  }}

\def\@makeschapterhead #1{%
  \vspace*{-25\p@}%
  {\parindent \z@ \raggedright \reset@font
        \interlinepenalty\@M
        {\huge \bfseries #1\par\nobreak}
    \vskip 20\p@
  }}

  
% Disallow page breaks at hyphens (this will give some underfull vbox's,
% so an alternative is to use \brokenpenalty=100 and manually search
% for and fix such page breaks)
\brokenpenalty=10000
 
% For the final version use double spacing, for the draft version use single spacing
\if@draft\singlespacing\else\doublespacing\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quote
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\myquote}[1]{
  \begin{minipage}{.8\textwidth}
  	  \singlespacing#1
  \end{minipage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \author, \title are defined in book; define rest
\def\institute#1{\gdef\@institute{#1}}
\def\adviser#1{\gdef\@adviser{#1}}
\def\degreedate#1{\gdef\@degreedate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}

\def\titlepg{
  \topskip0pt
  \vspace*{\fill}
  \begin{center}
    {\huge\MakeUppercase \@title}\\
	\bigskip
	\Large A dissertation\\
	\bigskip
	submitted by\\
	\bigskip
	\@author\\
	\bigskip
	in partial fulfillment of the requirements\\[-.1em]
	for the degree of\\
	\bigskip
	Doctor of Philosophy\\
	\bigskip
	in\\
	\bigskip
	Mathematics\\
	\bigskip
	{\MakeUppercase \@institute}\\
	\bigskip
	\@degreedate\\
	\bigskip
	\copyright\ Copyright \@copyrightyear\space by \@author\\
	\bigskip
	Adviser: \@adviser\\
  \end{center}
  \vspace*{\fill}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract, acknowledgments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\myabstract#1{\gdef\@myabstract{#1}}
\def\myacknowledgments#1{\gdef\@myacknowledgments{#1}}
\def\mydedication#1{\gdef\@mydedication{#1}}

\def\abstractchapter{
  \chapter*{Abstract}
  \@myabstract
}

\def\acknowledgmentschapter{
  \chapter*{Acknowledgments}
  \@myacknowledgments
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Include everything needed before thesis proper
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\beforethesisproper{
  \pagenumbering{roman}
  \thispagestyle{empty}
  \titlepg
  \pagestyle{plain}
  \pdfbookmark{Abstract}{abstract}\abstractchapter
  \clearpage
  \bigskip\noindent\bigskip\@mydedication
  \pdfbookmark{Acknowledgments}{acknowledgments}\acknowledgmentschapter
  \clearpage
  \pdfbookmark{Contents}{contents}\tableofcontents

% If you don't want a list of tables or figures, comment out
% the corresponding lines below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}\listoftables
  \clearpage
  \setlength{\cftfignumwidth}{3em}
  \phantomsection
  \addcontentsline{toc}{chapter}{List of
    Figures}\listoffigures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \setcounter{page}{0}
  \pagenumbering{arabic}
  % \noindent\@title
}

\makeatother
\endinput
