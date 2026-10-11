%%%%%%% CSM LaTeX Style for PhD thesis %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developed by Chris Yeomans & Robert Pell from original .cls file by Keith Gillow (Oxford)
%% Contact <c.m.yeomans@exeter.ac.uk> or <r.pell@exeter.ac.uk> or contact via GitHub @SWgeoscience

%% CSM Version 0.2
%
% Original Code
% ociamthesis v2.2
% By Keith A. Gillow
% Version 1.0 released 26/11/1997
%-------------------------- identification ---------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csmthesis}[2021/02/15 v0.2 CSM thesis class] % Adapted from ociamthesis by Keith Gillow (Oxford Mathematical Institute)
%-------------------------- initial code -----------------------
\LoadClass[a4paper]{report}
% As an alternative to the above could use next line for twosided output
%\LoadClass[a4paper,twoside,openright]{report}

\RequirePackage{graphicx} % needed for latest frontpage logo
\RequirePackage{ifthen}   % needed for option parsing for logo
%\RequirePackage{datetime} % for live dates

\raggedbottom

%%%%%% This is currently redundant
%define the default submitted text
\newcommand{\submittedtext}{{A thesis submitted for the degree of}}

%
%%%%%% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

%%%% This all gets set in the preamble but you need it here
% The year and term the thesis is submitted 
\def\degreedate#1{\gdef\@degreedate{#1}}
% The full (unabbreviated) name of the degree 
\def\degreename#1{\gdef\@degreename{#1}} % this is currently broken
% College name macro
\def\college#1{\gdef\@college{#1}}


%
%%%%%% Setup chosen crest/logo
%

%%%%%% This is the CSM crest logo
% it should be hi-res and the original included here is a jpg
\def\logo{{\includegraphics[width=50mm]{csmlogo}}}
%%%%%% THis is the Exeter logo
%\def\logo{{\includegraphics[width=100mm]{exlogo}}}
%%
%
% Define text area of page and margin offsets
%
%\setlength{\topmargin}{20mm}
%\setlength{\oddsidemargin}{30mm}
%\setlength{\evensidemargin}{30mm}
%\setlength{\textheight}{9.0in}
%\setlength{\textwidth}{6.0in}

%
% Environments
%

% This macro define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}

%define title page layout
\renewcommand{\maketitle}{%
\begin{alwayssingle}
    \renewcommand{\footnotesize}{\small}
    \renewcommand{\footnoterule}{\relax}
    \thispagestyle{empty}
  \null\vfill
  \begin{center}
    { \Huge {\bfseries {\@title}} \par}
{\large \vspace*{12mm} {\logo \par} \vspace*{12mm}}
    {{\Large \@author} \par}
{
\large \vspace*{1ex}
    {{\@college} \par}
\vspace*{5mm}
    {{\@degreedate} \par}
\small \vspace*{5mm}
}
    \end{center}
    {{\submittedtext} \par}
%\vspace*{1ex}
%    {\it {\@degreename} \par}
%\vspace*{1ex}
%    {\it {\@degreedate} \par}
  \null\vfill

\end{alwayssingle}}

% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\LARGE }
  \end{center}
  \vspace{0.5cm}
  \begin{verse}\begin{center}}
{\end{center}\end{verse}\end{alwayssingle}}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}
{\begin{alwayssingle} \thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Acknowledgements}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}\end{alwayssingle}}

% The acknowledgementslong environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgement itself 
% does not appears in a quote environment so you can get more in.

\newenvironment{acknowledgementslong}
{\begin{alwayssingle} \thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\chapter*{Acknowledgements}}
\end{center}
\vspace{0.5cm}}
{\end{alwayssingle}}

% STATEMENT OF ORIGINALITY (AS SUGGESTED BY GSW)
%
% The originality environment puts a large, bold, centered 
% "Statement of originality" label at the top of the page. The statement 
% of originality itself appears in a quote environment, i.e. tabbed in at 
% both sides, and on its own page.

\newenvironment{declaration}
{\begin{alwayssingle} \thispagestyle{empty}
\vspace*{1.5cm}
{\chapter*Declaration}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}\end{alwayssingle}}

% The originalitylong environment puts a large, bold, centered 
% "Statement of originality" label at the top of the page. The statement 
% of originality itself does not appears in a quote environment so you can 
% get more in.

\newenvironment{declarationlong}
{\begin{alwayssingle} \thispagestyle{empty}
  \begin{center}
	\vspace*{1.5cm}
	{\Large \bfseries Declaration}
\end{center}
\vspace{0.5cm}}
{\end{alwayssingle}}
% Table of Contents
\renewcommand\tableofcontents{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\contentsname
		\@mkboth{%
			\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
}
% List of Figures
\renewcommand\listoffigures{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\listfigurename}%
	\@mkboth{\MakeUppercase\listfigurename}%
	{\MakeUppercase\listfigurename}%
	\@starttoc{lof}%
	\if@restonecol\twocolumn\fi
}
% List of Tables
\renewcommand\listoftables{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\listtablename}%
	\@mkboth{%
		\MakeUppercase\listtablename}%
	{\MakeUppercase\listtablename}%
	\@starttoc{lot}%
	\if@restonecol\twocolumn\fi
}
% List of Abbreviations/Acronyms
%%% This is a bit of a bodge
\newcommand{\abbrlabel}[1]{\makebox[3cm][l]{#1\ \dotfill}}
\newenvironment{abbreviations}
{\noindent \Huge \bfseries List of Abbreviations\vspace*{1.5cm}\normalsize \normalfont\begin{list}{}{\renewcommand{\makelabel}{\abbrlabel}}}{\end{list}}
%{\begin{alwayssingle} \thispagestyle{empty}
%		\begin{center}
%			\vspace*{1.5cm}
%			{\Large \bfseries List of Acronyms}
%		\end{center}
%		\vspace{0.5cm}}
%	{\end{alwayssingle}}
%ABSTRACT
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\renewenvironment{abstract} {\begin{alwayssingle} \thispagestyle{empty}
  \begin{center}
	\vspace*{1.5cm}
	{\Large \bfseries  Abstract}
\end{center}
\vspace{0.5cm}}
{\end{alwayssingle}}

%The abstractlong environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself does not appears in a quote
%environment so you can get more in.

\newenvironment{abstractlong} {\begin{alwayssingle} \thispagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Abstract}
  \end{center}
  \vspace{0.5cm}}
{\end{alwayssingle}}

%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately

\newenvironment{abstractseparate} {\begin{alwayssingle} \thispagestyle{empty}
  \vspace*{-1in}
 \begin{center}
    { \Large {\bfseries {\@title}} \par}
    {{\large \vspace*{1ex} \@author} \par}
{\large \vspace*{1ex}
    {{\@college} \par}
    {University of Exeter \par}
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degreename} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}}
{\end{alwayssingle}}

%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).

\newenvironment{romanpages}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}
