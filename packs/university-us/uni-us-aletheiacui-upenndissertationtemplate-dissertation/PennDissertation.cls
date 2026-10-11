%-------------------------------------------------------------%
% Dissertation template for the University of Pennsylvania
% Created by Aletheia Cui
% Penn Dissertation formatting guide:
%    http://guides.library.upenn.edu/dissertation_manual/formatting
% ------------------------------------------------------------%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PennDissertation}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass{book}

\usepackage{graphicx}
\setcounter{secnumdepth}{4}

% This creates hyperlinks within your document for references,
% table of contents, etc.
\usepackage[hidelinks]{hyperref}

% Penn style guide:
%   "For the sake of readability, it is recommended that the text of the dissertation be double-spaced"
\usepackage{setspace}
\doublespacing

% Modify the default chapter title look.
% You can delete this if you prefer the default look.
\usepackage{titlesec}
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries\singlespacing}{\chaptertitlename~\thechapter}{20pt}{\Huge}
\titlespacing*{\chapter}{0pt}{10pt}{30pt}

% Penn paper requirement:
%    8 1/2 x 11 inches in size (i.e. letter paper)
% Penn margin requirements:
%    Left-hand margin: 1.5 inches
%    Right-hand margin: 1 inch
%    Top and bottom margins: 1 inch
\usepackage{geometry}
\geometry{
  letterpaper,
  includefoot,
  left=1.5in,
  top=1in,
  right=1in,
  bottom=1in
}

% Commands to set up the title page
\newcommand{\subject}[1]{\def\Subject{#1}}
\newcommand{\supervisor}[1]{\def\Supervisor{#1}}
\newcommand{\supervisortitle}[1]{\def\SupervisorTitle{#1}}
\newcommand{\chairperson}[1]{\def\Chairperson{#1}}
\newcommand{\chairpersontitle}[1]{\def\ChairpersonTitle{#1}}
\newcommand{\committee}[1]{\def\Committee{#1}}

% Preliminary Pages, in the following order:
% 1. Title Page
% 2. Copyright Notice (optional)
% 3. Dedication (optional)
% 4. Acknowledgment (optional)
% 5. Abstract
% 6. Table of Contents
% 7. List of Tables (If lengthy, it may be included as an appendix.)
% 8. List of Illustrations (If lengthy, it may be included as an appendix.)
% 9. Preface (optional)

% 1. Title Page
\renewcommand\maketitle{
  \pagestyle{empty}
  \begin{titlepage}
    \setlength{\parskip}{3pt}
    \setlength{\parindent}{0in}

    \begin{center}
      \@title \par
      \@author \par
      A DISSERTATION \par
      in \par
      \Subject \par
      Presented to the Faculties of the University of Pennsylvania \par
      in \par
      Partial Fulfillment of the Requirements for the \par
      Degree of Doctor of Philosophy \par
      \Date \par
    \end{center}

    \vspace{3em}

    {Supervisor of Dissertation \par}
    \vspace{2em}
    {\noindent\rule{8cm}{0.4pt}
\par}
    \vspace{-1em}
    {\Supervisor, \SupervisorTitle \par}
    % chairperson signature slot
    {Graduate Group Chairperson \par}
    \vspace{2em}
    {\noindent\rule{8cm}{0.4pt} \par}
    \vspace{-1em}
    {\Chairperson, \ChairpersonTitle \par}

    \bigskip
    {Dissertation Committee: \par}
    {\Committee \par}

  \end{titlepage}
  \clearpage
}

% 2. Copyright Notice (optional)
\newcommand\copyrightpage{
  % set to be "empty" to not print a page number
  \pagestyle{empty}
  \setlength{\parskip}{15pt}
  \setlength{\parindent}{0pt}
  \null\vfil
  \begin{center}
    \Title \par
    COPYRIGHT \par
    \Date \par
    \Author \par
  \end{center}
  \vfil\null
  \clearpage
}

% 3. Dedication (optional)
\newcommand\dedication[1]{
  \pagestyle{plain}
  \setlength{\parskip}{20pt}
  \setlength{\parindent}{0pt}
  \null\vfil
  \begin{center}{\sl #1}\end{center}
  \vfil\null
  \clearpage
}

% 4. Acknowledgment (optional)
\newcommand\acknowledgment[1]{
  \addcontentsline{toc}{chapter}{Acknowledgment}
  \pagestyle{plain}
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{0pt}
  \begin{center}{\bf ACKNOWLEDGMENT}\end{center}
  \setlength{\parindent}{0.25in}
  {\normalsize #1}
  \clearpage
}

% 5. Abstract
\newcommand\abstract[1]{
  \addcontentsline{toc}{chapter}{Abstract}
  \pagestyle{plain}
  \setlength{\parskip}{0pt}
  \setlength{\parindent}{0pt}
  \begin{center}
    {\bf ABSTRACT \par}
    \Title \par
    \Author \par
    \Supervisor
  \end{center}
  \setlength{\parindent}{0.25in}
  {\normalsize #1}
  \vfil\null
  \clearpage
}

% 6. Table of Contents
\renewcommand\tableofcontents{
\begin{singlespace}
    \setlength{\parskip}{2pt}
    \chapter*{Table of Contents}
    \@starttoc{toc}
    \clearpage
\end{singlespace}
}

% 7. List of Tables (If lengthy, it may be included as an appendix.)
\renewcommand\listoftables{
\addcontentsline{toc}{chapter}{List of Tables}
\begin{singlespace}
    \setlength{\parskip}{0pt}
    \setlength{\parindent}{0pt}
    \chapter*{List of Tables}
    \@starttoc{lot}
    \clearpage
\end{singlespace}
}

% 8. List of Illustrations (If lengthy, it may be included as an appendix.)
\renewcommand\listoffigures{
\addcontentsline{toc}{chapter}{List of Figures}
\begin{singlespace}
    \setlength{\parskip}{0pt}
    \setlength{\parindent}{0pt}
    \chapter*{List of Figures}
    \@starttoc{lof}
    \clearpage
\end{singlespace}
}

% 9. Preface (optional)
\newcommand\preface[1]{
   \addcontentsline{toc}{chapter}{Preface}
   #1
}
