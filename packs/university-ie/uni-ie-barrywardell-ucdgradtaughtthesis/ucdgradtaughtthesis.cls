%%
%% LaTeX document style `ucdgradtaughtthesis', for use with LaTeX2e.
%% This is a style for typesetting thesis for submission in partial
%% fulfilment of a graduate taught degree at University College Dublin.
%%
%% COPYRIGHT 2018 by Barry Wardell <barry.wardell@ucd.ie>
%%

% Identification
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucdgradtaughtthesis}[2018/07/26 1.0 University College Dublin Graduate Taught Thesis Class]

% A4 paper is standard. Require 40mm margin on left, 20mm everywhere else
\PassOptionsToPackage{a4paper,left=30mm,top=20mm,right=20mm,bottom=30mm}{geometry}

% Use 12pt fonts
\PassOptionsToClass{12pt}{report}

% Based off the report class, 12pt font
\LoadClass{report}
\RequirePackage{geometry}

% Use doublespacing
\RequirePackage{setspace}
\onehalfspacing

% Enable \url{}
\RequirePackage{url}

\RequirePackage[square,numbers]{natbib}

% Fancy headers
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\lhead{\fancyplain{}{\textbf{\large\leftmark}}}
\rhead{\fancyplain{}{\textbf{\large\rightmark}}}
\setlength{\headheight}{30pt}
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter. #1}{}}
\renewcommand{\sectionmark}[1]{\markboth{}{\thesection. #1}}

% Code listings
\usepackage{listings}

% Abstract
\renewcommand{\abstractname}{\vspace{-2truecm}Abstract}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Title page %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Date thesis is submitted
\def\thesisdate#1{\gdef\@thesisdate{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The name of your advisor (AHB 00/9/18)
\def\supervisor#1{\gdef\@supervisor{#1}}

% the school
\def\school#1{\gdef\@school{#1}}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\college#1{\gdef\@college{#1}}

\def\maketitle{
  \newpage
  \thispagestyle{empty}
  \pagenumbering{roman}
  \vspace*{1cm}
  \begin{center}
	{\textbf{\huge{\begin{onehalfspace}\@title\end{onehalfspace}}}}
	\hspace{\fill}\\
	{\large \@author}\\
	\hspace{\fill}\\
	\hspace{\fill}\\
	The thesis is submitted to University College Dublin\\
	in part fulfilment of the requirements for the degree of\\
	{\bf \@degree}\\
	\hspace{\fill}\\
	\hspace{\fill}\\
	\includegraphics[height=6cm]{UCD_Logo}\\[1cm]
	\hspace{\fill}\\
	\hspace{\fill}\\
	\@school\\
	University College Dublin\\
	\hspace{\fill}\\
	\hspace{\fill}\\
	\begin{tabular}{rl}
	\textbf{Supervisor:}&\@supervisor\\
	\end{tabular}
	\hspace{\fill}\\
	\hspace{\fill}\\
	\hspace{\fill}\\
	{\@thesisdate}\\
  \end{center}
  \setcounter{footnote}{0}
}
