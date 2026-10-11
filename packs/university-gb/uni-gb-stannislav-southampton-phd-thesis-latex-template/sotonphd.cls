%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Identify, Process Options, and Load Class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sotonphd}[2018/04/05 v1.0]
\gdef\baseclass{book}

%%%%%%%%%%%%%%%%%%%%%
% Available options:
%
% sotonformat:  use 11pt font and 1.5-spacing for main text, margins as in the guidelines
% print:        disable link colouring
% final:        disable the "to do" command

\newif\if@sotonformat\@sotonformatfalse
\newif\if@print\@printfalse
\newif\if@final\@finalfalse

\DeclareOption{sotonformat}{\@sotonformattrue}
\DeclareOption{print}{\@printtrue}
\DeclareOption{final}{\@finaltrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ExecuteOptions{a4paper, twoside, openright}
\ProcessOptions\relax

\if@sotonformat
  \PassOptionsToClass{11pt}{\baseclass}
  \PassOptionsToPackage{inner=1.5in, outer=1in, top=1in, bottom=1in}{geometry}
  \PassOptionsToPackage{onehalfspacing}{setspace}
\fi

\LoadClass{\baseclass}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Essential Packages
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[l2tabu, orthodox]{nag}  % Issues warnings if deprecated packages are used
\RequirePackage{float}  % in order to force figure placement with option [H]
\RequirePackage{geometry}
\RequirePackage{mathtools,amsfonts,amssymb}
\RequirePackage{parskip}  % Leave some space between paragraphs instead of indenting a new paragraph
\RequirePackage[usenames,dvipsnames,svgnames,x11names]{xcolor}
\PassOptionsToPackage{hyphens}{url}  % hyperref loads the url package
\RequirePackage{hyperref}
\RequirePackage[english]{babel}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{bookmark}
\RequirePackage{xspace}  % Used in the definition of the \etc custom command
\RequirePackage{setspace}  % Loads \singlespacing, \onehalfspacing, \doublespacing
\RequirePackage{graphicx}
\RequirePackage[labelfont=bf]{caption}  % make "Figure x.x" be printed in bold face
\RequirePackage{fancyhdr}  %  Style page headers and footers
\RequirePackage{sectsty}  % Style titles for chapters, sections etc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Styling
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Headers and Footers
\setlength{\headheight}{14pt}
\fancyhead{} % Clear all header fields
\fancyhead[RE]{\itshape\nouppercase\leftmark}
\fancyhead[LO]{\itshape\nouppercase\rightmark}
\fancyhead[RO,LE]{\thepage}
\fancyfoot{}

% Chapters, Sections, etc.
\partfont{\normalfont\scshape\underline}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% New Commands
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add a chapter title to the table of contents and to the bookmarks
\newcommand*\TOCchapter[1]{
  \phantomsection{}
  \addcontentsline{toc}{chapter}{#1}
}

% Add a table of contents
\newcommand*\addTOC{
  \begingroup
  \singlespacing
  \renewcommand{\contentsname}{Table of Contents}
  \TOCchapter{\contentsname}
  \tableofcontents
  \cleardoublepage{}
  \endgroup
}

% Add a list of figures and a list of tables
\newcommand*\addFiguresTables{
  \begingroup
  \singlespacing
  \TOCchapter{List of Figures and Tables}
  \listoffigures
  \listoftables
  \cleardoublepage{}
  \endgroup
}

% For meta data
\newcommand*\university[1]{\gdef\@university{#1}}
\newcommand*\faculty[1]{\gdef\@faculty{#1}}
\newcommand*\department[1]{\gdef\@department{#1}}

% To do commands
\newcommand*\todo[1]{
\if@final
  {}
\else
  {\color{red}(#1)}
\fi
}

\newcommand*\todomaybe[1]{
\if@final
  {}
\else
  {\color{blue}(#1)}
\fi
}

% Abbreviations: e.g., i.e., etc.
\newcommand*\eg{e.g.\@\xspace}
\newcommand*\ie{i.e.\@\xspace}
\newcommand*\etc{\@ifnextchar{.}{etc}{etc.\@\xspace}}

% Maths operators
\DeclareMathOperator{\sech}{sech}
\DeclareMathOperator{\csch}{csch}
\DeclareMathOperator{\arcsec}{arcsec}
\DeclareMathOperator{\arccot}{arcCot}
\DeclareMathOperator{\arccsc}{arcCsc}
\DeclareMathOperator{\arccosh}{arcCosh}
\DeclareMathOperator{\arcsinh}{arcsinh}
\DeclareMathOperator{\arctanh}{arctanh}
\DeclareMathOperator{\arcsech}{arcsech}
\DeclareMathOperator{\arccsch}{arcCsch}
\DeclareMathOperator{\arccoth}{arcCoth}

\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\id}{id}
\DeclareMathOperator{\diag}{diag}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Configuration
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Meta data
\author{Name Surname}
\title{Title}
\date{Month Year}
\university{University of Southampton}
\faculty{Faculty of Physical Sciences and Engineering}
\department{Physics and Astronomy}

% Bookmarks
\bookmarksetup{
  open,
  numbered,
  addtohook={% CHANGE THE LEVELS DEPENDING ON WHETHER CHAPTER OR SECTION IS THE LOWEST LEVEL
    \ifnum\bookmarkget{level}=-1 %
      \bookmarksetup{bold}%
    \fi%
    \ifnum\bookmarkget{level}>0 %
      \bookmarksetup{italic}%
    \fi
  },
}

% Hyperlinks
\hypersetup{
  colorlinks=true,
  allcolors=DeepSkyBlue4,
  bookmarksopen=true,
  bookmarksopenlevel=0
}

\if@print
  \hypersetup{hidelinks}
\fi

% Allow long equations to be continued to the next page
\allowdisplaybreaks{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Document Structure
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [x] Title and subtitle
% [x] Abstract
% [x] List of contents
% [x] List of tables, illustrations etc.
% [-] List of accompanying material, if any
% [x] Author's declaration
% [x] Acknowledgements
% [-] Definitions, abbreviations used
% [x] Introduction
% [x] Main text, divided into chapters, sections etc.
% [x] Conclusion
% [x] Appendices
% [-] Glossary
% [x] List of references/Bibliography
% [-] Index

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title Page
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\maketitle{
  \TOCchapter{Title Page}
  \hypersetup{pdftitle={\@title}}
  \hypersetup{pdfauthor={\@author}}
  \thispagestyle{empty}

  \begin{titlepage}
    \begin{center}
      \setlength{\parskip}{0pt}
      {\Large\textbf{\@university}\par}
            {\large Faculty of Physical Sciences and Engineering\par \par}
      {\large Physics and Astronomy\par \par}
      \vfill
      {\huge \bfseries \@title \par}
      \vfill
      {\LARGE by \par}
      \smallskip
      {\LARGE \@author \par}
      \vfill
      {\large A thesis submitted for the degree of \par}
      {\large Doctor of Philosophy \par}
      \bigskip
      \bigskip
      \bigskip
      {\Large \@date \par}
      \bigskip
    \end{center}
  \end{titlepage}

  \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Abstract
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{abstract}
{
  \TOCchapter{Abstract}
  \singlespacing
  % \thispagestyle{empty}

  \begin{center}
    \setlength{\parskip}{0pt}
    {\large \bfseries \MakeUppercase{\@university} \par \par}
    \bigskip
    \bigskip
    {\LARGE \bfseries \underline{ABSTRACT} \par \par}
    \bigskip
    \bigskip
    {\normalsize \MakeUppercase{\@faculty} \par \par}
    \medskip
    {\normalsize \MakeUppercase{\@department} \par \par}
    \bigskip
    {\normalsize \underline{Thesis for the degree of Doctor of Philosophy} \par}
    \bigskip
    {\normalsize \bfseries \MakeUppercase{\@title} \par \par}
    \medskip
    {\normalsize by \@author \par \par}
  \end{center}
}{\cleardoublepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Declaration of Authorship
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\authorshipdeclaration[1]{
  \cleardoublepage
  \TOCchapter{Declaration of Authorship}
  \begin{center}
    {\Large\textbf{Declaration of Authorship}}
  \end{center}

  \begingroup
  \singlespacing
  I, {\@author}, declare that this thesis entitled \emph{\@title} and the work presented in it are my own and have been generated by me as the result of my own original research.

  I confirm that:
  \begin{enumerate}
    \item This work was done wholly or mainly while in candidature for a research degree at this University;
    \item Where any part of this thesis has previously been submitted for a degree or any other qualification at this University or any other institution, this has been clearly stated;
    \item Where I have consulted the published work of others, this is always clearly attributed;
    \item Where I have quoted from the work of others, the source is always given. With the exception of such quotations, this thesis is entirely my own work;
    \item I have acknowledged all main sources of help;
    \item Where the thesis is based on work done by myself jointly with others, I have made clear exactly what was done by others and what I have contributed myself;
    \item Either none of this work has been published before submission, or parts of this work have been published as:
      #1
  \end{enumerate}

  \bigskip
  \bigskip
  \bigskip

  Signed:

  \bigskip

  Date:

  \endgroup
  \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Acknowledgements
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\acknowledgements[1]{
  \TOCchapter{Acknowledgements}
  \chapter*{Acknowledgements}
  {\singlespacing\normalsize #1}
  \cleardoublepage
}

% (The End)
