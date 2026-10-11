% $Log: ncfthesis.cls,v $
% Copyright (c) 2020, by Chris Kottke
%%
% Changelog: 
%
% 04/21/2020 Cleaner interface for front matter (redefined toc, frontmatter, backmatter commands, default to 12pt)
% 04/20/2020 Fixed improper handling of font size. (Was not being passed through to report class correctly).
% 04/15/2019 Default to letter paper, dotted signature line optional (default to solid)
% 04/11/2019 nobind option added, support for multiple sponsors, correct handling of two sided documents
% 04/05/2019 Basic version
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncfthesis}[2020/04/21 NCF thesis class]
 
 
% Allow for a singlespace option
\def\@mystretch{1.5} % Default to double space
\DeclareOption{singlespace}{\def\@mystretch{1}}

% Library margin requirements for binding are the default
% nobind option gives symmetric margins
\def\@innermargin{1.5in}
\def\@outermargin{1in}
\DeclareOption{nobind}{\def\@innermargin{1.25in}\def\@outermargin{1.25in}}

% dots option for dotted signature line instead of solid line
\def\@filltype{\hrulefill}
\DeclareOption{dots}{\def\@filltype{\dotfill}}

\def\@fontsizept{12pt}
\DeclareOption{11pt}{\def\@fontsizept{11pt}}
\DeclareOption{10pt}{\def\@fontsizept{10pt}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} 
\ProcessOptions\relax
% End options section

\LoadClass[\@fontsizept]{report} % Use report class as a base

\RequirePackage{setspace}
\setstretch{\@mystretch}

\RequirePackage{geometry}
\geometry{letterpaper, inner=\@innermargin, outer=\@outermargin, top=1in, bottom=1in}

 
% Default degree
\gdef\@degree{Bachelor of Arts}
\newcommand\degree[1]{\gdef\@degree{#1}}
\newcommand\division[1]{\gdef\@division{#1}}
\newcommand\degreemonth[1]{\gdef\@degreemonth{#1}}
\newcommand\degreeyear[1]{\gdef\@degreeyear{#1}}
\newcommand\thesisdate[1]{\gdef\@thesisdate{#1}}


% Signature line macro
\newcommand\@sigline[2]{
\vbox\bgroup\setstretch{1}
  \noindent\@filltype
  \\\null\hfill #1
  \\\null\hfill #2
\egroup}

\newcommand\sponsor[2]{ % Support for multiple sponsors
\@ifundefined{@sponsorname}{
	\gdef\@sponsorname{#1}
	\gdef\@sponsorsig{\@sigline{#1, #2}{\@thesisdate}}
}{
	\g@addto@macro\@sponsorname{\ and\ #1}
	\g@addto@macro\@sponsorsig{\vfill\@sigline{#1, #2}{\@thesisdate}}
}}



% Generate the title page using vfills to fill page
\renewcommand{\maketitle}
{\thispagestyle{empty} % No page number
\vspace*{1in}         % A bit of space at the top
\bgroup\setstretch{1} % Single spaced
\begin{center}
{\bf \MakeUppercase{\@title}}
\vfill
\MakeUppercase{by}
\\ \MakeUppercase{\@author}
\vfill
A Thesis
\vfill
Submitted to the \@division
\\ New College of Florida
\\ in partial fulfillment of the requirements for the degree
\\ \@degree
\\ under the sponsorship of \@sponsorname
\vfill
Sarasota, Florida
\\ \@degreemonth\ \@degreeyear
\end{center}
\egroup  % End single spaced
}

% Abstract page
\renewenvironment{abstract}
{\cleardoublepage
\thispagestyle{plain}
\vspace*{1in}
\bgroup\setstretch{2} % Spacing for title and author
\begin{center}
{\large\bf \@title}
\par {\large \@author}
\par New College of Florida, \@degreeyear
\end{center}
\egroup               % end extra spacing
\vfill
\addcontentsline{toc}{chapter}{Abstract}
\section*{Abstract} }
{\vfill\@sponsorsig\vfill} % Now handles multiple sponsors

% Centered dedication page
\newenvironment{dedication}
{\cleardoublepage\vspace*{2in}\begin{center}\large}
{\end{center}\@normalsize}

% Acknowledgements page (added to TOC)
\newenvironment{acknowledgements}
{\cleardoublepage\vspace*{2in}
\addcontentsline{toc}{chapter}{Acknowledgements}
\section*{Acknowledgements} }
{}

% Table of contents to start on right hand page in double sided mode
\let\@oldtoc\tableofcontents
\renewcommand{\tableofcontents}{\cleardoublepage\@oldtoc}

% Front matter pages numbered in roman numerals
\pagenumbering{roman}
\newcommand\frontmatter{\cleardoublepage \pagenumbering{roman}}

% Main matter pages numbered in arabic
\newcommand\mainmatter{\cleardoublepage\pagenumbering{arabic}}


