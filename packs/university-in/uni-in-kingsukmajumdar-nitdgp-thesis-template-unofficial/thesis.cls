%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Thesis Class File - NIT Durgapur
% Purpose: Robust LaTeX class file for UG/PG/PhD thesis at National Institute Of Technology Durgapur
% Compiler: pdflatex
% OS: Manjaro 
% Version: V1.0 (NIT Durgapur Edition)
% Written on: October 18, 2025
% Revision Date: October 18, 2025
% Author: Kingsuk Majumdar
% Copyright (c) 2025 Kingsuk Majumdar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2025/10/18 Thesis Class for National Institute Of Technology Durgapur - Version 1.0]

% Base class with improved options
\LoadClass[a4paper,12pt,twoside,openright,final]{book}

%%%%%%%%%% REQUIRED PACKAGES - OPTIMIZED ORDER %%%%%%%%%%
% Font and encoding packages first
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{fourier}

% Typography and justification
\RequirePackage{ragged2e}
\RequirePackage{microtype}
\RequirePackage[none]{hyphenat}

% Math packages
\RequirePackage[cmex10]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{siunitx}

% Layout and geometry
\RequirePackage[
a4paper,
textwidth=15.5cm,
textheight=23cm,
left=3cm,
right=2.5cm,
top=2.5cm,
bottom=2.5cm,
twoside,
bindingoffset=0.5cm,
asymmetric,
headheight=15pt,
headsep=1cm,
footskip=1cm
]{geometry}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}

% Text formatting and alignment
\RequirePackage{soul}
\RequirePackage{textcomp}
\RequirePackage{url}

% Tables and arrays
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{lscape}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{tabu}
\RequirePackage{adjustbox}

% Graphics and figures
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{color}
\RequirePackage{colortbl}
\RequirePackage{wrapfig}
\RequirePackage{subfigure}
\RequirePackage{changepage}
\RequirePackage{rotating}
\RequirePackage{float}

% Lists and enumeration
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{multicol}

% Algorithms
\RequirePackage{algcompatible}
\RequirePackage[algo2e]{algorithm2e}
\RequirePackage[chapter]{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}

% Citations and bibliography
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{bibentry}

% Captions and labels
\RequirePackage[labelfont=bf,justification=justified]{caption}

% Code highlighting
\RequirePackage[framed,numbered,autolinebreaks,useliterate]{mcode}

% Hyperlinks - load last
\RequirePackage[colorlinks=true,linkcolor=black,urlcolor=black,bookmarksopen=true,citecolor=black,hidelinks]{hyperref}

% Other utilities
\RequirePackage{ifpdf}

%%%%%%%%%% PACKAGE SETUP %%%%%%%%%%
\nobibliography*
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

% Define column types for tabularx
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}
\newcolumntype{C}{>{\centering\arraybackslash}X}

% Enable justification
\justifying
\hyphenpenalty=10000          % Completely disable hyphenation
\exhyphenpenalty=10000        % Disable hyphenation after explicit hyphens  
\tolerance=2000               % Allow more spacing variation
\emergencystretch=4em         % Allow more emergency stretching
\pretolerance=1000            % First-pass tolerance
\hbadness=2000 

%%%%%%%%%% COLOR DEFINITIONS %%%%%%%%%%
\definecolor{eggshell}{rgb}{0.94, 0.92, 0.84}
\definecolor{eggshell1}{rgb}{0.94, 0.92, 0.88}
\definecolor{LightCyan}{rgb}{0.96,0.96,0.96}
\definecolor{light}{rgb}{0.49, 0.98, 1.0}
\definecolor{darkblue}{rgb}{0.0, 0.0, 0.5}

%%%%%%%%%% THEOREM ENVIRONMENTS %%%%%%%%%%
\newtheorem{theoremm}{Theorem}[chapter]
\newtheorem{eqed}{Example}[chapter]
\newtheorem{lemmaa}[theoremm]{Lemma}
\newtheorem{observation}[theoremm]{Observation}
\newtheorem{defnn}{Definition}[chapter]
\newtheorem{corollaryy}[theoremm]{Corollary}
\newtheorem{conjecturee}[theoremm]{Conjecture}
\newtheorem{fact}[theoremm]{Fact}
\newtheorem{rules}{Rule}[chapter]

%%%%%%%%%% CUSTOM ENVIRONMENTS %%%%%%%%%%
\newenvironment{example}{\begin{eqed}\rm}{\hfill\end{eqed}}
\newenvironment{lemma}{\begin{lemmaa}\sl}{\end{lemmaa}}
\newenvironment{theorem}{\begin{theoremm}{\bf :}\sl}{\end{theoremm}}
\newenvironment{defn}{\begin{defnn}\sl}{\end{defnn}}
\newenvironment{corollary}{\begin{corollaryy}{\bf :}\sl}{\end{corollaryy}}
\newenvironment{conjecture}{\begin{conjecturee}\sl}{\end{conjecturee}}
\newenvironment{justified}{\justifying}{}

%%%%%%%%%% ALGORITHM SETUP %%%%%%%%%%
\renewcommand{\thealgorithm}{\arabic{chapter}.\arabic{algorithm}}

%%%%%%%%%% PAIRED DELIMITERS %%%%%%%%%%
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

%%%%%%%%%% TITLE FORMATTING - IMPROVED %%%%%%%%%%
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}{\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
{\normalfont\Large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}
{\normalfont\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}
{\normalfont\normalsize\bfseries}{\thesubsubsection}{1em}{}

% Improved title spacing
\titlespacing*{\chapter}{0pt}{20pt}{30pt}
\titlespacing*{\section}{0pt}{18pt plus 4pt minus 2pt}{12pt plus 2pt minus 2pt}
\titlespacing*{\subsection}{0pt}{16pt plus 4pt minus 2pt}{8pt plus 2pt minus 2pt}
\titlespacing*{\subsubsection}{0pt}{14pt plus 4pt minus 2pt}{6pt plus 2pt minus 2pt}

% Better paragraph spacing
\setlength{\parskip}{6pt plus 2pt minus 1pt}
\setlength{\parindent}{0pt}

% Improved float spacing
\setlength{\floatsep}{12pt plus 2pt minus 2pt}
\setlength{\textfloatsep}{20pt plus 2pt minus 4pt}
\setlength{\intextsep}{12pt plus 2pt minus 2pt}

% Better table spacing
\renewcommand{\arraystretch}{1.2}

% Improved footnote spacing
\setlength{\footnotesep}{8pt}
\setlength{\skip\footins}{10pt plus 4pt minus 2pt}

% Better list spacing
\setlength{\itemsep}{3pt plus 1pt minus 1pt}

%%%%%%%%%% GRAPHICS PATH SETUP %%%%%%%%%%
\graphicspath{{Figures/}{Figures/Chapter01/}{Figures/Chapter02/}{Figures/Chapter03/}{Figures/Chapter04/}{Figures/Chapter05/}{Figures/Chapter06/}}

%%%%%%%%%% GLOBAL VARIABLE DEFINITIONS %%%%%%%%%%

% Thesis Information
\newcommand{\ThesisTitle}[1]{\def\@ThesisTitle{#1}}
\newcommand{\ShortTitle}[1]{\def\@ShortTitle{#1}}
\let\@ShortTitle\@ThesisTitle
\newcommand{\Department}[1]{\def\@Department{#1}}
\newcommand{\College}[1]{\def\@College{#1}}
\newcommand{\University}[1]{\def\@University{#1}}
\newcommand{\ThesisYear}[1]{\def\@ThesisYear{#1}}
\newcommand{\ThesisMonth}[1]{\def\@ThesisMonth{#1}}
\newcommand{\DegreeType}[1]{\def\@DegreeType{#1}}
\newcommand{\Address}[1]{\def\@Address{#1}}
\newcommand{\Location}[1]{\def\@Location{#1}}
\newcommand{\AY}[1]{\def\@AY{#1}}

% Project Information
\newcommand{\GroupNo}[1]{\def\@GroupNo{#1}}
\newcommand{\PaperName}[1]{\def\@PaperName{#1}}
\newcommand{\PaperCode}[1]{\def\@PaperCode{#1}}

% Student Information (up to 5 students)
\newcommand{\StudentOne}[1]{\def\@StudentOne{#1}}
\newcommand{\StudentTwo}[1]{\def\@StudentTwo{#1}}
\newcommand{\StudentThree}[1]{\def\@StudentThree{#1}}
\newcommand{\StudentFour}[1]{\def\@StudentFour{#1}}
\newcommand{\StudentFive}[1]{\def\@StudentFive{#1}}

% Roll Numbers
\newcommand{\RollOne}[1]{\def\@RollOne{#1}}
\newcommand{\RollTwo}[1]{\def\@RollTwo{#1}}
\newcommand{\RollThree}[1]{\def\@RollThree{#1}}
\newcommand{\RollFour}[1]{\def\@RollFour{#1}}
\newcommand{\RollFive}[1]{\def\@RollFive{#1}}

% Registration Numbers  
\newcommand{\RegOne}[1]{\def\@RegOne{#1}}
\newcommand{\RegTwo}[1]{\def\@RegTwo{#1}}
\newcommand{\RegThree}[1]{\def\@RegThree{#1}}
\newcommand{\RegFour}[1]{\def\@RegFour{#1}}
\newcommand{\RegFive}[1]{\def\@RegFive{#1}}

% Email IDs
\newcommand{\EmailOne}[1]{\def\@EmailOne{#1}}
\newcommand{\EmailTwo}[1]{\def\@EmailTwo{#1}}
\newcommand{\EmailThree}[1]{\def\@EmailThree{#1}}
\newcommand{\EmailFour}[1]{\def\@EmailFour{#1}}
\newcommand{\EmailFive}[1]{\def\@EmailFive{#1}}

% Photo paths
\newcommand{\PhotoOne}[1]{\def\@PhotoOne{#1}}
\newcommand{\PhotoTwo}[1]{\def\@PhotoTwo{#1}}
\newcommand{\PhotoThree}[1]{\def\@PhotoThree{#1}}
\newcommand{\PhotoFour}[1]{\def\@PhotoFour{#1}}
\newcommand{\PhotoFive}[1]{\def\@PhotoFive{#1}}

% Supervisor Information
\newcommand{\Supervisor}[1]{\def\@Supervisor{#1}}
\newcommand{\SupervisorDesignation}[1]{\def\@SupervisorDesignation{#1}}
\newcommand{\SupervisorEmail}[1]{\def\@SupervisorEmail{#1}}
\newcommand{\SupervisorDept}[1]{\def\@SupervisorDept{#1}}
\newcommand{\SupervisorCollege}[1]{\def\@SupervisorCollege{#1}}

% Co-supervisor Information  
\newcommand{\CoSupervisor}[1]{\def\@CoSupervisor{#1}}
\newcommand{\CoSupervisorDesignation}[1]{\def\@CoSupervisorDesignation{#1}}
\newcommand{\CoSupervisorEmail}[1]{\def\@CoSupervisorEmail{#1}}
\newcommand{\CoSupervisorDept}[1]{\def\@CoSupervisorDept{#1}}
\newcommand{\CoSupervisorCollege}[1]{\def\@CoSupervisorCollege{#1}}

% HoD Information
\newcommand{\HoD}[1]{\def\@HoD{#1}}
\newcommand{\HoDDesignation}[1]{\def\@HoDDesignation{#1}}
\newcommand{\HoDDept}[1]{\def\@HoDDept{#1}}

% Configuration
\newcommand{\NumberOfStudents}[1]{\def\@NumberOfStudents{#1}}
\newcommand{\HasCoSupervisor}[1]{\def\@HasCoSupervisor{#1}}

%%%%%%%%%% DEFAULT VALUES %%%%%%%%%%
\def\@NumberOfStudents{2}
\def\@HasCoSupervisor{1}
\def\@College{National Institute Of Technology Durgapur}
\def\@University{National Institute Of Technology Durgapur}
\def\@DegreeType{Bachelor of Technology (B. Tech.)}
\def\@ShortTitle{\@ThesisTitle}
\def\@Address{Mahatma Gandhi Avenue, Durgapur – 713209, West Bengal, India}
\def\@Location{Durgapur}
\def\@SupervisorDesignation{Professor}
\def\@CoSupervisorDesignation{Assistant Professor}
\def\@HoDDesignation{Professor \& Head}
\def\@SupervisorCollege{National Institute Of Technology Durgapur}
\def\@CoSupervisorCollege{National Institute Of Technology Durgapur}

%%%%%%%%%% HELPER COMMANDS %%%%%%%%%%

% Command to generate student list dynamically for certificate
\newcommand{\GenerateStudentList}{%
	\makeatletter%
	\textbf{\@StudentOne, \@RollOne}%
	\ifnum\@NumberOfStudents>1\relax%
	\\ \textbf{\@StudentTwo, \@RollTwo}%
	\fi%
	\ifnum\@NumberOfStudents>2\relax%
	\\ \textbf{\@StudentThree, \@RollThree}%
	\fi%
	\ifnum\@NumberOfStudents>3\relax%
	\\ \textbf{\@StudentFour, \@RollFour}%
	\fi%
	\ifnum\@NumberOfStudents>4\relax%
	\\ \textbf{\@StudentFive, \@RollFive}%
	\fi%
	\makeatother%
}

% Command to generate detailed student list for declaration
\newcommand{\GenerateDetailedStudentList}{%
	\makeatletter%
	\@StudentOne\\
	Roll No: \@RollOne\\
	\ifx\@RegOne\undefined\else Registration No: \@RegOne\\\fi
	\ifx\@EmailOne\undefined\else Email: \@EmailOne\\\fi
	[1cm]
	\ifnum\@NumberOfStudents>1\relax
	\@StudentTwo\\
	Roll No: \@RollTwo\\
	\ifx\@RegTwo\undefined\else Registration No: \@RegTwo\\\fi
	\ifx\@EmailTwo\undefined\else Email: \@EmailTwo\\\fi
	[1cm]
	\fi
	\ifnum\@NumberOfStudents>2\relax
	\@StudentThree\\
	Roll No: \@RollThree\\
	\ifx\@RegThree\undefined\else Registration No: \@RegThree\\\fi
	\ifx\@EmailThree\undefined\else Email: \@EmailThree\\\fi
	[1cm]
	\fi
	\ifnum\@NumberOfStudents>3\relax
	\@StudentFour\\
	Roll No: \@RollFour\\
	\ifx\@RegFour\undefined\else Registration No: \@RegFour\\\fi
	\ifx\@EmailFour\undefined\else Email: \@EmailFour\\\fi
	[1cm]
	\fi
	\ifnum\@NumberOfStudents>4\relax
	\@StudentFive\\
	Roll No: \@RollFive\\
	\ifx\@RegFive\undefined\else Registration No: \@RegFive\\\fi
	\ifx\@EmailFive\undefined\else Email: \@EmailFive\\\fi
	\fi
	\makeatother%
}

% Command for student signatures in declaration
\newcommand{\GenerateSignatureList}{%
	\makeatletter%
	\begin{tabular}{@{}l p{0.5cm} l@{}}
		Date: \underline{\hspace{3cm}} & &Signature: \underline{\hspace{4cm}}\\[0.5cm]
		Place: \underline{\hspace{3cm}} & & \@StudentOne\\
		&& Roll No: \@RollOne\\[1cm]
		\ifnum\@NumberOfStudents>1\relax
		& & Signature: \underline{\hspace{4cm}}\\[0.3cm]
		& & \@StudentTwo\\
		&  & Roll No: \@RollTwo\\[1cm]
		\fi
		\ifnum\@NumberOfStudents>2\relax
		& & Signature: \underline{\hspace{4cm}}\\[0.3cm]
		& & \@StudentThree\\
		& & Roll No: \@RollThree\\[1cm]
		\fi
		\ifnum\@NumberOfStudents>3\relax
		& & Signature: \underline{\hspace{4cm}}\\[0.3cm]
		& & \@StudentFour\\
		& & Roll No: \@RollFour\\[1cm]
		\fi
		\ifnum\@NumberOfStudents>4\relax
		& & Signature: \underline{\hspace{4cm}}\\[0.3cm]
		& & \@StudentFive\\
		& & Roll No: \@RollFive\\
		\fi
	\end{tabular}
	\makeatother%
}

%%%%%%%%%% FRONT COVER COMMAND - IMPROVED %%%%%%%%%%
\newcommand{\makefrontcover}{
	\cleardoublepage
	\thispagestyle{empty}
	\begin{titlepage}
		\begin{center}
			\vspace*{0.3cm}
			
			% Title
			\begin{large}
				\textbf{\MakeUppercase{\@ThesisTitle}}
			\end{large}
			\vskip 0.1cm
			
			% Subtitle
			\emph{A Project Report Submitted in Partial Fulfillment of the Requirements\\ for the Degree of}\\
			\vskip 0.1cm
			
			\begin{large}
				\textbf{\@DegreeType}\\
				\textbf{in \@Department}\\
			\end{large}
			\vskip 0.2cm
			
			% Students (WITHOUT EMAIL IDs)
			\begin{normalsize}
				\emph{by}\\
				\vskip 0.1cm
				\makeatletter
				\textbf{\@StudentOne}\\
				Roll No: \@RollOne\\
				\ifx\@RegOne\undefined\else Registration No: \@RegOne\\\fi
				\vskip 0.2cm
				\ifnum\@NumberOfStudents>1\relax
				\textbf{\@StudentTwo}\\
				Roll No: \@RollTwo\\
				\ifx\@RegTwo\undefined\else Registration No: \@RegTwo\\\fi
				\vskip 0.2cm
				\fi
				\ifnum\@NumberOfStudents>2\relax
				\textbf{\@StudentThree}\\
				Roll No: \@RollThree\\
				\ifx\@RegThree\undefined\else Registration No: \@RegThree\\\fi
				\vskip 0.2cm
				\fi
				\ifnum\@NumberOfStudents>3\relax
				\textbf{\@StudentFour}\\
				Roll No: \@RollFour\\
				\ifx\@RegFour\undefined\else Registration No: \@RegFour\\\fi
				\vskip 0.2cm
				\fi
				\ifnum\@NumberOfStudents>4\relax
				\textbf{\@StudentFive}\\
				Roll No: \@RollFive\\
				\ifx\@RegFive\undefined\else Registration No: \@RegFive\\\fi
				\vskip 0.2cm
				\fi
				\makeatother
			\end{normalsize}
			
			\vskip 0.1cm
			
			% Supervisors
			\begin{normalsize}
				\emph{Under the supervision of}\\
				\vskip 0.1cm
				\textbf{\@Supervisor}\\
				\@SupervisorDesignation\\
				\@SupervisorDept\\
				\@SupervisorCollege\\
				\makeatletter
				\ifnum\@HasCoSupervisor>1\relax
				\&\\
				\vskip 0.05cm
				\textbf{\@CoSupervisor}\\
				\@CoSupervisorDesignation\\
				\@CoSupervisorDept\\
				\@CoSupervisorCollege\\
				\fi
				\makeatother
			\end{normalsize}
			
			\vskip 0.05cm
			
			% College logo
			\begin{figure}[H]
				\centering
				\includegraphics[width=0.16\textwidth]{college_logo.png}
			\end{figure}
			
			\vskip 0.05cm
			
			% College details
			\begin{normalsize}
				\textbf{\MakeUppercase{\@College}}\\
				\textbf{\@Address}\\
				\textbf{\MakeUppercase{\@ThesisMonth}, \@ThesisYear}
			\end{normalsize}
			
		\end{center}
	\end{titlepage}
	\cleardoublepage
}

%%%%%%%%%% COPYRIGHT PAGE - IMPROVED %%%%%%%%%%
\newcommand{\makecopyrightpage}{
	\thispagestyle{empty}
	\begin{titlepage}
		\vspace*{\fill}
		\begin{center}
			\makeatletter
			\textit{All Rights Reserved\\ 
				Copyright \copyright\ \@ThesisYear\ \@StudentOne%
				\ifnum\@NumberOfStudents>1\relax, \@StudentTwo\fi%
				\ifnum\@NumberOfStudents>2\relax, \@StudentThree\fi%
				\ifnum\@NumberOfStudents>3\relax, \@StudentFour\fi%
				\ifnum\@NumberOfStudents>4\relax, \@StudentFive\fi}
			\makeatother
		\end{center}
		\vspace*{\fill}
	\end{titlepage}
	\cleardoublepage
}

%%%%%%%%%% ENHANCED ENVIRONMENT %%%%%%%%%%
\newenvironment{kmenv}
{\begin{center}
		\arrayrulecolor{darkblue}
		\begin{tabular}{|p{0.9\textwidth}|}
			\hline\\
			\rowcolor{eggshell}
		}
		{ 
			\\\\\hline
		\end{tabular} 
		\arrayrulecolor{black}
	\end{center}
}

%%%%%%%%%% FANCY HEADER SETUP - IMPROVED %%%%%%%%%%
\newcommand{\setupheaders}{
	\pagestyle{fancy}
	\fancyhf{}
	
	\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\chaptername\ \thechapter.\ ##1}}{}}
	\renewcommand{\sectionmark}[1]{\markright{\MakeUppercase{\thesection.\ ##1}}}
	
	% Different headers for even and odd pages
	\fancyhead[LE]{\small\textbf{\leftmark}}
	\fancyhead[RO]{\small\textbf{\rightmark}}
	
	% Page numbers in footer
	\fancyfoot[LE,RO]{\textbf{\thepage}}
	
	% Center footer for thesis title
	\fancyfoot[CE,CO]{\small\textit{\@ShortTitle}}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\setlength{\headheight}{14.5pt}
	
	% Plain style for chapter pages
	\fancypagestyle{plain}{%
		\fancyhf{}
		\fancyfoot[CE,CO]{\textbf{\thepage}}
		\renewcommand{\headrulewidth}{0pt}
		\renewcommand{\footrulewidth}{0.4pt}
	}
}

%%%%%%%%%% SKIP TABLE COUNTER ENVIRONMENT %%%%%%%%%%
\newenvironment{Longtabu}[2][c]{%
	\longtabu[#1]{#2}  
}{\addtocounter{table}{-1}\endlongtabu}

%%%%%%%%%% ABBREVIATION LIST ENVIRONMENT %%%%%%%%%%
\newlist{abbrv}{description}{1}
\setlist[abbrv,1]{
	labelwidth=3cm,
	leftmargin=3.5cm,
	itemsep=0.1\baselineskip,
	font=\normalfont\bfseries
}

%%%%%%%%%% UTILITY COMMANDS %%%%%%%%%%
% Command to create blank page
\newcommand{\blankpage}{%
	\null
	\thispagestyle{empty}%
	\addtocounter{page}{-1}%
	\newpage}

% Command for consistent spacing
\newcommand{\thesisspacing}{\onehalfspacing}

%%%%%%%%%% ENHANCED TOC FORMATTING %%%%%%%%%%
\renewcommand{\contentsname}{\centering Table of Contents}
\renewcommand{\listfigurename}{\centering List of Figures}
\renewcommand{\listtablename}{\centering List of Tables}

%%%%%%%%%% CONDITIONAL FONT SIZE %%%%%%%%%%
\newcommand{\ConditionalFrontFontSize}{
	\ifnum\@NumberOfStudents>3
	\scriptsize
	\else
	\normalsize
	\fi
}

%%%%%%%%%% WRAPPER COMMANDS FOR SAFE ACCESS %%%%%%%%%%

\newcommand{\GetStudentOne}{\@StudentOne}
\newcommand{\GetStudentTwo}{\@StudentTwo}
\newcommand{\GetStudentThree}{\@StudentThree}
\newcommand{\GetStudentFour}{\@StudentFour}
\newcommand{\GetStudentFive}{\@StudentFive}

\newcommand{\GetEmailOne}{\@EmailOne}
\newcommand{\GetEmailTwo}{\@EmailTwo}
\newcommand{\GetEmailThree}{\@EmailThree}
\newcommand{\GetEmailFour}{\@EmailFour}
\newcommand{\GetEmailFive}{\@EmailFive}

\newcommand{\GetRollOne}{\@RollOne}
\newcommand{\GetRollTwo}{\@RollTwo}
\newcommand{\GetRollThree}{\@RollThree}
\newcommand{\GetRollFour}{\@RollFour}
\newcommand{\GetRollFive}{\@RollFive}

\newcommand{\GetRegOne}{\@RegOne}
\newcommand{\GetRegTwo}{\@RegTwo}
\newcommand{\GetRegThree}{\@RegThree}
\newcommand{\GetRegFour}{\@RegFour}
\newcommand{\GetRegFive}{\@RegFive}

\newcommand{\GetPhotoOne}{\@PhotoOne}
\newcommand{\GetPhotoTwo}{\@PhotoTwo}
\newcommand{\GetPhotoThree}{\@PhotoThree}
\newcommand{\GetPhotoFour}{\@PhotoFour}
\newcommand{\GetPhotoFive}{\@PhotoFive}

\newcommand{\GetCollege}{\@College}
\newcommand{\GetDepartment}{\@Department}
\newcommand{\GetAddress}{\@Address}
\newcommand{\GetThesisTitle}{\@ThesisTitle}
\newcommand{\GetShortTitle}{\@ShortTitle}
\newcommand{\GetPaperName}{\@PaperName}
\newcommand{\GetPaperCode}{\@PaperCode}
\newcommand{\GetGroupNo}{\@GroupNo}
\newcommand{\GetDegreeType}{\@DegreeType}
\newcommand{\GetLocation}{\@Location}
\newcommand{\GetUniversity}{\@University}
\newcommand{\GetAY}{\@AY}

\newcommand{\GetSupervisor}{\@Supervisor}
\newcommand{\GetSupervisorDesignation}{\@SupervisorDesignation}
\newcommand{\GetSupervisorDept}{\@SupervisorDept}
\newcommand{\GetSupervisorCollege}{\@SupervisorCollege}

\newcommand{\GetCoSupervisor}{\@CoSupervisor}
\newcommand{\GetCoSupervisorDesignation}{\@CoSupervisorDesignation}
\newcommand{\GetCoSupervisorDept}{\@CoSupervisorDept}
\newcommand{\GetCoSupervisorCollege}{\@CoSupervisorCollege}

\newcommand{\GetHoD}{\@HoD}
\newcommand{\GetHoDDesignation}{\@HoDDesignation}
\newcommand{\GetHoDDept}{\@HoDDept}

\newcommand{\GetNumberOfStudents}{\@NumberOfStudents}
\newcommand{\GetHasCoSupervisor}{\@HasCoSupervisor}

% Ensure justification in chapters and sections
\let\oldchapter\chapter
\let\oldschapter\@schapter

% Handle both \chapter{} and \chapter*{}
\renewcommand{\chapter}{\@ifstar{\schapterjustify}{\chapterjustify}}
\newcommand{\chapterjustify}[1]{\oldchapter{#1}\justifying}
\newcommand{\schapterjustify}[1]{\oldschapter{#1}\justifying}

% Handle sections
\let\oldsection\section
\renewcommand{\section}{\@ifstar{\ssectionjustify}{\sectionjustify}}
\newcommand{\sectionjustify}[1]{\oldsection{#1}\justifying}
\newcommand{\ssectionjustify}[1]{\oldsection*{#1}\justifying}

% Ensure ShortTitle defaults to ThesisTitle
\AtBeginDocument{%
	\ifx\@ShortTitle\@ThesisTitle
	\def\@ShortTitle{\@ThesisTitle}%
	\fi
}

% Remove headers/footers from blank pages
\renewcommand{\cleardoublepage}{%
	\clearpage%
	\if@twoside%
	\ifodd\c@page%
	\else%
	\hbox{}%
	\thispagestyle{empty}%
	\newpage%
	\if@twocolumn%
	\hbox{}%
	\newpage%
	\fi%
	\fi%
	\fi%
}

%%%%%%%%%% END OF CLASS FILE %%%%%%%%%%