%
% IIScthesis v1.0
% By Swaprava Nath <swaprava@gmail.com>
% 
% Minor edits by multiple CSA students
%
% thanks to Harish Bhanderi <harish.bhanderi@cantab.net> of Cambridge University
% for the base structure of the thesis
% Version 1.0 released 07/07/2013
% 
%-------------------------- identification ---------------------
%\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IIScthesisPSnPDF}[2013/07/07 v1.0 IISc thesis class]
%-------------------------- initial code -----------------------
\newif\ifIISc@bookmode
\IISc@bookmodetrue

\DeclareOption{report}{\IISc@bookmodefalse}
\DeclareOption{book}{\IISc@bookmodetrue}
\ProcessOptions\relax%

\ifIISc@bookmode
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}%
\ProcessOptions\relax%
\ifx\pdfoutput\undefined%
   \LoadClass[dvips, a4paper]{book}%
\else%
   \LoadClass[pdftex, a4paper]{book}%
\fi%
\else
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}%
\ProcessOptions\relax%
\ifx\pdfoutput\undefined%
  \LoadClass[dvips, a4paper]{report}%
\else%
   \LoadClass[pdftex, a4paper]{report}%
\fi%
%\renewcommand{\refname}{References}%
\fi

%\DeclareOption{book}{%
%}%
\usepackage{setspace}
\usepackage{tocbibind}
\usepackage{amssymb}
%\usepackage{graphicx}
\usepackage{fancyhdr}
\usepackage{eucal}
\usepackage{calc}
\usepackage[english]{babel}
\usepackage[usenames, dvipsnames]{color}
\usepackage[perpage]{footmisc}
%\usepackage[square, sort, numbers, authoryear]{natbib}
\usepackage[numbers]{natbib}
\usepackage{ifthen}
\usepackage{ifpdf}


%Bibliography
%uncomment next line to change bibliography name to references for Book document class
\renewcommand{\bibname}{References}
% note that this doesn't do much if you later define another bibliography style 
\newcounter{app}[chapter]

% Nomenclature
\usepackage{nomencl}
\makenomenclature
\renewcommand\nomgroup[1]{%
  \ifthenelse{\equal{#1}{A}}{%
   \item[\textbf{Roman Symbols}] }{%             A - Roman
    \ifthenelse{\equal{#1}{G}}{%
     \item[\textbf{Greek Symbols}]}{%             G - Greek
      \ifthenelse{\equal{#1}{R}}{%
        \item[\textbf{Superscripts}]}{%              R - Superscripts
          \ifthenelse{\equal{#1}{S}}{%
           \item[\textbf{Subscripts}]}{{%             S - Subscripts
	    \ifthenelse{\equal{#1}{X}}{%
	     \item[\textbf{Other Symbols}]}{{%    X - Other Symbols
	    \ifthenelse{\equal{#1}{Z}}{%
	     \item[\textbf{Acronyms}]}%              Z - Acronyms
              			{{}}}}}}}}}}

\ifpdf
%-->
%--> Google.com search "hyperref options"
%--> 
%--> http://www.ai.mit.edu/lab/sysadmin/latex/documentation/latex/hyperref/manual.pdf
%--> http://www.chemie.unibas.ch/~vogtp/LaTeX2PDFLaTeX.pdf 
%--> http://www.uni-giessen.de/partosch/eurotex99/ oberdiek/print/sli4a4col.pdf
%--> http://me.in-berlin.de/~miwie/tex-refs/html/latex-packages.html
%-->
    \usepackage[ pdftex, plainpages = false, pdfpagelabels, 
                 pdfpagelayout = OneColumn, % display single page, advancing flips the page - Sasa Tomic
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 pagebackref,
                 colorlinks = true,
                 linkcolor = blue,
                 urlcolor  = blue,
                 citecolor = red,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref} 
    \usepackage[pdftex]{graphicx}
    \DeclareGraphicsExtensions{.png, .jpg, .pdf}

    \pdfcompresslevel=9
    \graphicspath{{ThesisFigs/PNG/}{ThesisFigs/PDF/}{ThesisFigs/}}
\else
    \usepackage[ dvips, 
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 pagebackref,
                 colorlinks = true,
                 linkcolor = blue,
                 urlcolor  = blue,
                 citecolor = red,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref}

    %\usepackage{epsfig}
    \usepackage{graphicx}
    \DeclareGraphicsExtensions{.eps, .ps}
    \graphicspath{{ThesisFigs/EPS/}{ThesisFigs/}}
\fi

%define the page size including an offset for binding
%\setlength{\topmargin}{0.0in}
%\setlength{\oddsidemargin}{0in}
%\setlength{\evensidemargin}{0in}
%\setlength{\textheight}{700pt}
%\setlength{\textwidth}{500pt}


%A4 settings
\ifpdf
   \pdfpageheight=297mm
   \pdfpagewidth=210mm
\else
   \setlength{\paperheight}{297mm}
   \setlength{\paperwidth}{210mm}
\fi

\setlength{\hoffset}{0.00cm}
\setlength{\voffset}{0.00cm}

% \setlength{\evensidemargin}{1.96cm}
% %\setlength{\oddsidemargin}{-0.54cm}
% \setlength{\topmargin}{1mm}
% \setlength{\headheight}{1.36cm}
% \setlength{\headsep}{1.00cm}
% \setlength{\textheight}{20.84cm}
% \setlength{\textwidth}{14.5cm}
% \setlength{\marginparsep}{1mm}
% \setlength{\marginparwidth}{3cm}
% \setlength{\footskip}{2.36cm}

% \setlength{\evensidemargin}{0.2in}
\setlength{\oddsidemargin}{-0.1in}
\setlength{\topmargin}{-0.25in}
\setlength{\headheight}{1.36cm}
\setlength{\headsep}{1.0cm}
\setlength{\textheight}{8.7in}
\setlength{\textwidth}{6.7in}
\setlength{\marginparsep}{1mm}
\setlength{\marginparwidth}{3cm}
\setlength{\footskip}{1cm}

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter. #1 }}{}}
\renewcommand{\sectionmark}[1]{}
\fancyhf{}
\fancyhead[RO]{\bfseries\rightmark}
\fancyhead[LE]{\bfseries\leftmark}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\addtolength{\headheight}{0.5pt}
\fancypagestyle{plain}{
  \fancyhead{}
  \renewcommand{\headrulewidth}{0pt}
}

\nonstopmode % Do not stop if the font is not available
% boldface
\newfont{\degfntbf}{eufb10 scaled\magstep3} 
% Bigger
\newfont{\degfnt}{eufm10 scaled\magstep3} 
\errorstopmode % revert back to stop on error

% Font to print title on the cover page
% Use any other font of your choice if this is not available.
% Use \titlefnt if you want smaller font

\nonstopmode % Do not stop if the font is not available
\newfont{\titlefnt}{cmssdc10 scaled\magstep3} 
\newfont{\Titlefnt}{cmssdc10 scaled\magstep4} 
\newfont{\twelvessf}{lcmss8 scaled\magstep2}
\errorstopmode % revert back to stop on error


% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}


% \author, \title are defined in report; here are the rest of the
% front matter defining macros
\def\dept#1{\gdef\@dept{#1}}
%\def\enggfaculty{\gdef\@faculty{Faculty of Engineering}}
\def\sciencefaculty{\gdef\@faculty{Faculty of Science}}
\def\degreein#1{\gdef\@faculty{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\phd{\gdef\@degree{Doctor of Philosophy}}
\def\mtechresearch{\gdef\@degree{Master of Technology (Research)}}
\def\mtech{\gdef\@degree{Master of Technology}\mtechtrue}
\def\bibtitle#1{\gdef\@bibtitle{#1}}
\def\faculty#1{\gdef\@faculty{#1}}

\newif\iffigurespage \newif\iftablespage 
\newif\ifiisclogo 
\newif\ifmtech % To print project report in the title page

\figurespagetrue \tablespagefalse 
\iisclogofalse \mtechfalse

\def\iisclogo#1{
	% For first  call,   load the  file  iisclogo.sty  which  will
	% redefine this macro!
	\makeatletter\input{iisclogo.sty}\makeatother
	\iisclogo{#1}
	}

\renewcommand{\appendix}{%
  \par
%  \setcounter{section}{0}%
  \setcounter{app}{1}
  \renewcommand{\thesection}{\thechapter.\Alph{app}}%
%  \addtocounter{app}{1}
}

% From titlepage.sty  27 Jan 85
\renewcommand{\maketitle}{%
\begin{titlepage}\begin{singlespace}
\setcounter{page}{0}
%\null
\vskip -1.0in
	%{\baselineskip 1cm
	{\huge %\baselinestretch{4}
	\begin{center}
		%\Huge\uppercase\expandafter{\@title} 
		{\Titlefnt \@title} 
	\end{center} \par} % The spacing between second and  third line
			   % is not proper
\vfill
\begin{center}
	%\sc 
	\Large \twelvessf 
	A \ifmtech PROJECT REPORT \else THESIS \fi \\
	SUBMITTED \ifmtech IN PARTIAL FULFILMENT OF THE \\
	REQUIREMENTS FOR \else FOR \fi THE DEGREE OF\\
	{\degfntbf \@degree} \\
	%\sc
	\Large \twelvessf 
	IN \ifmtech \\ \else THE \\ \fi {\degfntbf \@faculty }
\end{center}
\vfill
	{\lineskip .75em
	\begin{center}
	\twelvessf 
	BY \\[0.75em]
	{\large \bf \@author}
	\end{center}\par} 
\vfill

	\vfill
	\begin{center}
	\begin{figure}[h!]
	  \centering
	  \includegraphics[height=1.5in]{iisclogo.jpg}
 % IISc1.png: 526x488 pixel, 72dpi, 18.56x17.22 cm, bb=
	\end{figure}
%	\iisclogo{950} % Laser printer gives error 21 for lower sizes
	\end{center}

\vfill
\begin{center}
 	\large \twelvessf 
	\@dept \\
 	Indian Institute of Science \\
 	Bangalore -- 560 012 (INDIA)\\[0.75em]
	\@submitdate\\
\end{center}
\vskip -0.5in
\null
\end{singlespace}\end{titlepage}
%\pagenumbering{roman} % Already in frotmater env!
} %maketitle


\def\prefacesection#1{%
	\chapter*{#1}
% 	\begin{center}
% 	 {\LARGE \bf #1}
% 	\end{center}
	\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{#1}
	}

%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).

\newenvironment{romanpages}
{\setcounter{page}{1}
  \renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}}
%{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}

