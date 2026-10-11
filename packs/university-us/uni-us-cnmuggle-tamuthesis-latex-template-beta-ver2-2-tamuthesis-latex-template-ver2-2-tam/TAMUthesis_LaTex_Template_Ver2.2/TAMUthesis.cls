\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TAMUthesis}[2015/04/15 Texas A&M University Thesis Template Version 2.2 By Gaofeng@tamu.edu from OGAPS/TAMU based on book.cls]

\newif\if@ChapterMethod\@ChapterMethodtrue
\DeclareOption{ChapterMethod}{\@ChapterMethodtrue}
\DeclareOption{SectionMethod}{\@ChapterMethodfalse}
%\ExecuteOptions{ChapterMethod}	%default is ChapterMethod

\newif\if@ListStyle\@ListStyletrue
\DeclareOption{ListStyleI}{\@ListStyletrue}
\DeclareOption{ListStyleII}{\@ListStylefalse}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
%\ExecuteOptions{}
\ProcessOptions\relax


\LoadClass[12pt, letterpaper,oneside]{book}


\RequirePackage[T1]{fontenc}


\RequirePackage[xetex,bookmarks, hidelinks]{hyperref}  % comment to disable hyper-link in table of contents
%For hyperref 
%\providecommand\phantomsection{}


\RequirePackage{color, graphicx}
\RequirePackage{amsmath}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage[top=1.25in, bottom=1.25in, left=1.4in, right=1.15in]{geometry}
\RequirePackage{caption}
\RequirePackage{mathptmx}
\RequirePackage{pdflscape}

\if@ChapterMethod

\else
	\RequirePackage[titletoc,title]{appendix}
\fi

\RequirePackage{setspace}
%\setstretch{1}
%\linespread{1.6}


%font type
\RequirePackage{fontspec}
%\setmainfont{Arial}	%change font style to Arial
\setmainfont{Times New Roman}
\renewcommand*\large{\fontsize{14.05}{14.05}\selectfont}	%fine tunement to adjust \large to be 14pt exactly


%remove vertical space between itemize/enumerate/description
\RequirePackage{enumitem}
%remove vertical space between items in itemize
\setlist[itemize]{noitemsep, nolistsep}
\setlist[enumerate]{noitemsep, nolistsep}
\setlist[description]{noitemsep, nolistsep}

%indent after chapter/sectioin, only affect the first one
\RequirePackage{indentfirst}
\setlength{\parindent}{1cm} %first indent


%Header/Footer Modification
\RequirePackage{fancyhdr}
\lhead{}
\chead{}
\rhead{}
%\lfoot{}
%\rfoot{\thepage}
\cfoot{\thepage}
%\fancyfoot[RO, LE]{\thepage}
\renewcommand{\headrulewidth}{0pt}


\RequirePackage{titlesec}

%modify section title font size
\titleformat*{\section}{\normalfont\bfseries}
\titleformat*{\subsection}{\normalfont\bfseries}
\titleformat*{\subsubsection}{\normalfont\bfseries}
\titleformat*{\paragraph}{\normalfont\bfseries}


\if@ChapterMethod
	%chapter title format
	\titleformat{\chapter}[display]{\large\bfseries\centering}{\chaptertitlename\ \thechapter}{0pt}{\large}
	%modify chapter title name
	\renewcommand{\chaptertitlename}{CHAPTER}
\else
	%chapter title format
	\titleformat{\chapter}{\vspace{1ex}\large\bfseries\centering}{\thechapter}{1em}{\large}
	%modify chapter title name
	%\renewcommand{\chaptertitlename}{CHAPTER}
\fi


\renewcommand{\appendixname}{APPENDIX} % this command is overlapped by something else, I believe comment it won't cause any difference in APPENDIX title
\renewcommand{\bibname}{REFERENCES}


\RequirePackage{tocloft}
%enable that toc has no section number, no subsection number as well
\if@ChapterMethod
\renewcommand{\cftsecpresnum}{\begin{lrbox}{\@tempboxa}}		%for section
\renewcommand{\cftsecaftersnum}{\end{lrbox}}				%for section
\renewcommand{\cftsubsecpresnum}{\begin{lrbox}{\@tempboxa}}	%for subsection
\renewcommand{\cftsubsecaftersnum}{\end{lrbox}}				%for subsection
\fi



\addtocontents{toc}{\linespread{1.4}\selectfont}
%\renewcommand\cftbeforechapskip{0pt}
%\renewcommand\cftchapafterpnum{\vskip14pt}

\renewcommand\cftbeforesecskip{-7pt}
%\renewcommand\cftsecafterpnum{\vskip0pt}

\renewcommand\cftbeforesubsecskip{-7pt}
%\renewcommand\cftsubsecafterpnum{\vskip0pt}

%redefine section to have 14pt space in first appearance at toc
\renewcommand\section{\@startsection{section}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -0.2ex}%
  {1.5ex \@plus 0.2ex}%
  {\normalfont\bfseries%
  \ifnum\value{section}>1 \else \addtocontents{toc}{\protect\addvspace{14pt}}\fi}}


%add vertical space in lof to have equal space for each figure item
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}
\addtocontents{lof}{\linespread{2.1}\selectfont}
%add vertical space in lof to have equal space for each figure item
\addtocontents{lot}{\linespread{2.1}\selectfont}


\RequirePackage{afterpage} 			%enable the "PAGE" or other information on the consequencing next page


\if@ListStyle
	%LIST STYLE I
	\addtocontents{toc}{~\hfill {Page} \par}	%add "PAGE" to toc/lof/lot 
	%\addtocontents{toc}{~\hfill \par}		%double space of toc word `'Page' and the chapter title.
	\addtocontents{lof}{{FIGURE}~\hfill {Page} \par}
	%\addtocontents{lof}{~\hfill  \par}
	\addtocontents{lot}{{TABLE}~\hfill {Page} \par}
	%\addtocontents{lot}{~\hfill \par}
\else
	%LIST STYLE II
	\addtocontents{lof}{~\hfill {Page} \par}
	\addtocontents{lot}{~\hfill {Page} \par}
	%%list of figures with "FIGURE"
	\renewcommand{\cftfigfont}{Figure ~}
	\renewcommand{\cfttabfont}{Table ~}
\fi



%modify the vertical space after title but before the content in toc/lof/lot
\setlength{\cftafterloftitleskip}{27pt}
\setlength{\cftafterlottitleskip}{27pt}
\setlength{\cftaftertoctitleskip}{33pt}



%toc title
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}

\if@ChapterMethod
	\renewcommand{\cftchappresnum}{CHAPTER }
	\renewcommand{\cftchapnumwidth}{7em}
	%Chapter Roman Numbering
	\renewcommand\thechapter{\Roman{chapter}}
\else
	%Chapter Arabic  Numbering
	\renewcommand\thechapter{\arabic{chapter}}
\fi





%leader dots in TABLE OF CONTENTS
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}} % for parts
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % for chapters


\newcommand*\updatechaptername{%
        \addtocontents{toc}{\protect\renewcommand*\protect\cftchappresnum{\@chapapp\ }}
}

%modify toc/lof/lot font size and align horizontal middle
\renewcommand{\cfttoctitlefont}{\large\bfseries}
\renewcommand{\cftloftitlefont}{\large\bfseries}
\renewcommand{\cftlottitlefont}{\large\bfseries}
\renewcommand{\contentsname}{\centerline{TABLE OF CONTENTS}}
\renewcommand{\listfigurename}{\centerline{LIST OF FIGURES}}
\renewcommand{\listtablename}{\centerline{LIST OF TABLES}}


%remove the vertical spacing before toc/lof/lot
\setlength{\cftbeforetoctitleskip}{-6ex}
\setlength{\cftbeforeloftitleskip}{-5.5ex}
\setlength{\cftbeforelottitleskip}{-2.4ex}


%modify the horizontal spacing  in lof/lot
\setlength{\cfttabnumwidth}{4em}
\setlength{\cftfignumwidth}{4em}


%remove the vertical space above CHAPTER title in each chapter, not toc
\titlespacing*{\chapter}{0pt}{-5.5ex}{6ex}
%modify the vertical space above/below section/subsection title in the main content, not toc.
\titlespacing*{\section}{0pt}{1ex}{0.5ex}
\titlespacing*{\subsection}{0pt}{1ex}{0.5ex}
\titlespacing*{\subsubsection}{0pt}{1ex}{0.5ex}
\titlespacing*{\paragraph}{0pt}{1ex}{0.5ex}


%%change equation vertical space
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{0ex plus 1ex minus 1ex}
  \setlength\belowdisplayskip{4pt plus 4pt minus 4pt}% plus 1ex minus 1ex}
  \setlength\abovedisplayshortskip{0ex  plus 1ex minus 1ex}
  \setlength\belowdisplayshortskip{4pt plus 4pt minus 4pt}%x plus 1ex minus 1ex}
}


%set figure/table display method to be Arabic.arabic instead of following chapter Roman Number.
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}



%new environment definition
\newenvironment{Contfigure}{%
%\renewcommand{\thefigure}{\Roman{chapter}.\arabic{figure} Continued.}%
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure} Continued.}%
\addtocounter{figure}{-1}%
\begin{figure}}{%
%\renewcommand{\thefigure}{\Roman{chapter}.\arabic{figure} }
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure} }
\end{figure}}



%new environment definition
\newenvironment{Conttable}{%
%\renewcommand{\thetable}{\Roman{chapter}.\arabic{table} Continued.}%
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table} Continued.}%
\addtocounter{table}{-1}%
\begin{table}}{%
%\renewcommand{\thetable}{\Roman{chapter}.\arabic{table} }
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\end{table}}
%command must be used when applying Contfigure and Conttable %\captionsetup{list=no} %disable figures/table to appear in lof/lot
%%%%%%%%%%%%%%%%%


%hook definition

\AtBeginDocument{
	\pagestyle{empty} %
	\pagenumbering{roman} %
}
\renewcommand\frontmatter{
	\clearpage
	\setcounter{page}{2} %abstract page number starts from 2.
	\pagestyle{fancy}
	\linespread{2}\selectfont
}


\newcommand{\TAMUTableofContentsFormat}{
%	\addtocontents{toc}{\protect\afterpage{~\hfill \par\medskip}} %command to enable second page "PAGE" in toc, together with package{afterpage}
	\phantomsection
	\addcontentsline{toc}{chapter}{TABLE OF CONTENTS}	
}


\newcommand{\TAMUTocAddWordPage}{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	\addtocontents{toc}{\protect\afterpage{~\hfill{Page}\par\medskip\vspace{1ex}}} %command to enable second page "PAGE" in toc,

	%\addtocontents{toc}{\protect\afterpage{~\hfill \par\medskip}} %command to enable second page "PAGE" in toc, together
%this is a manul way to do so, pleaer refer to http://www.latex-community.org/forum/viewtopic.php?f=5&t=252
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
}

\newcommand{\TAMUListOfFiguresFormat}{
	\newpage
	\phantomsection
	\addcontentsline{toc}{chapter}{LIST OF FIGURES}

%	\addtocontents{lof}{\protect\afterpage{~\hfill \par\medskip}} %command to enable second page "PAGE" in toc, together with package{afterpage}
}

\newcommand{\TAMULofAddWordPage}{
\if@ListStyle
	\addtocontents{lof}{\protect\afterpage{\noindent{FIGURE}~\hfill{Page}\par\medskip\vspace{-1ex}}} %command to enable second page "PAGE" in toc,
\else
	\addtocontents{lof}{\protect\afterpage{~\hfill{Page}\par\medskip\vspace{-1ex}}} %command to enable second page "PAGE" in toc,
\fi
}

\newcommand{\TAMULotAddWordPage}{
\if@ListStyle
	\addtocontents{lot}{\protect\afterpage{\noindent{TABLE}~\hfill{Page}\par\medskip\vspace{-1ex}}} %command to enable second page "PAGE" in toc,
	%\addtocontents{toc}{\protect\afterpage{~\hfill \par\medskip}} %command to enable second page "PAGE" in toc, together
%this is a manul way to do so, pleaer refer to http://www.latex-community.org/forum/viewtopic.php?f=5&t=252
\else
	\addtocontents{lot}{\protect\afterpage{~\hfill{Page}\par\medskip\vspace{-1ex}}} %command to enable second page "PAGE" in toc,
\fi
}

\newcommand{\TAMUListOfTablesFormat}{
	\linespread{1}\selectfont
	\newpage
	\phantomsection	%optional for hyper-ref:
	\addcontentsline{toc}{chapter}{LIST OF TABLES}

     %
%\addtocontents{lot}{\protect\afterpage{{TABLE}~\hfill{Page}\par\medskip}} %command to enable second page "PAGE" in toc, together with package{afterpage}
%\addtocontents{lot}{\protect\afterpage{~\hfill{Page}\par\medskip}} %command to enable second page "PAGE" in toc, together with package{afterpage}
}


\newcommand{\TAMUAbstractFormat}{
	%\cleardoublepage
	\phantomsection %optional for hyperref
	%\addtocontents{toc}{chapter}{\protect\numberline{}Abstract
	\addcontentsline{toc}{chapter}{ABSTRACT}
%	\begin{spacing}{2}
	\begin{center}
	\MakeUppercase{\textbf{\large Abstract}}
	%		\MakeUppercase
	\end{center}
	\vspace{14pt}
}

\newcommand{\TAMUNomenclatureFormat}{
	%\cleardoublepage
	%\addtocontents{toc}{chapter}{\protect\numberline{}Abstract
	\phantomsection	%optional for hyperref
	\addcontentsline{toc}{chapter}{NOMENCLATURE}

	\begin{center}
	\MakeUppercase{\textbf{\large Nomenclature}}
	\end{center}
	\vspace{5pt}
}

\newcommand{\TAMUDedicationFormat}{
%\cleardoublepage
\phantomsection
%\addtocontents{toc}{chapter}{\protect\numberline{}Abstract
\addcontentsline{toc}{chapter}{DEDICATION}

}

\newcommand{\TAMUAcknowledgmentFormat}{
    \phantomsection %optional for hyperref
\addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}
\begin{center}
\MakeUppercase{\textbf{\large Acknowledgments}}
\end{center}
\vspace{14pt} 
}

\newcommand{\TAMUReferenceFormat}{
	\newpage
	\phantomsection
    	\addcontentsline{toc}{chapter}{REFERENCES}
}

\newcommand{\TAMUAppendixFormat}{
	\captionsetup{list=no} %disable figures/table to appear in lof/lot
	\renewcommand{\thefigure}{\Alph{chapter}.\arabic{figure}}	%fixed the bug caused by Figure/Table Continued, all appendix figure/table in appendix will be labeled as A.1, A.2, A.3...
	\renewcommand{\thetable}{\Alph{chapter}.\arabic{table}}	%fixed the bug caused by Figure/Table Continued, all appendix figure/table in appendix labeled as A.1, A.2
\if@ChapterMethod
	\renewcommand{\chaptertitlename}{APPENDIX}  % some unknown bugs, comment this line will cause the Appendix title in main content becomes CHAPTER A instead of APPENDIX A
	\updatechaptername	%this cmd is needed for chatper method to update toc title for appendix
\fi
}


\renewcommand\mainmatter{
	\clearpage
	\pagenumbering{arabic}
	\linespread{2}\selectfont
}

%end of hook definition

\let\@documentname\@empty
\let\@degreename\@empty
\let\@majorname\@empty

\let\@ChairOfCommittee\@empty
\let\@CoChairOfCommittee\@empty
\let\@CommitteeMemberOne\@empty
\let\@CommitteeMemberTwo\@empty
\let\@CommitteeMemberThree\@empty
\let\@CommitteeMemberFour\@empty
\let\@HeadOfDepartment\@empty

\let\@GraduateMonth\@empty
\let\@GraduateYear\@empty

\let\@GradMajor\@empty


\newcommand{\TAMUdocument}[1]{\def\@documentname{#1}}\TAMUdocument{Thesis/Dissertation/Record of Study}
\def\@TAMUdocument{\@documentname}
\newcommand{\TAMUdegree}[1]{\def\@degreename{#1}}\TAMUdegree{Master of Science}
\def\@TAMUdegree{\@degreename}


\newcommand{\ChairOfCommitteeName}[1]{\def\@ChairOfCommittee{#1}}\ChairOfCommitteeName{Chair's Name}
\def\@ChairOfCommitteeName{\@ChairOfCommittee}
\newcommand{\CommitteeMemberOneName}[1]{\def\@CommitteeMemberOne{#1}}\CommitteeMemberOneName{Committee Member One's Name}
\def\@CommitteeMemberOneName{\@CommitteeMemberOne}
\newcommand{\CommitteeMemberTwoName}[1]{\def\@CommitteeMemberTwo{#1}}\CommitteeMemberTwoName{Committee Member Two's Name}
\def\@CommitteeMemberTwoName{\@CommitteeMemberTwo}

\newcommand{\HeadOfDepartmentName}[1]{\def\@HeadOfDepartment{#1}}\HeadOfDepartmentName{Head Of Department's Name}
\def\@HeadOfDepartmentName{\@HeadOfDepartment}

\newcommand{\CoChairOfCommitteeName}[1]{\def\@CoChairOfCommittee{#1}}
\newcommand{\CommitteeMemberThreeName}[1]{\def\@CommitteeMemberThree{#1}}
\newcommand{\CommitteeMemberFourName}[1]{\def\@CommitteeMemberFour{#1}}

\newcommand{\TAMUgradMonth}[1]{\def\@GraduateMonth{#1}}\TAMUgradMonth{May/August/December}
\def\@TAMUgradMonth{\@GraduateMonth}
\newcommand{\TAMUgradYear}[1]{\def\@GraduateYear{#1}}\TAMUgradYear{20XX}
\def\@TAMUgradYear{\@GraduateYear}

\newcommand{\TAMUmajor}[1]{\def\@GradMajor{#1}}\TAMUmajor{Your Major}
\def\@TAMUmajor{\@GradMajor}


\renewcommand\maketitle{
	\begin{center}
	\begin{spacing}{2.1}
		{\large\bfseries\@title\par}
		\vspace{17mm} \par
		A \@documentname \par
		by \par
		\MakeUppercase{\@author} \\		
	\end{spacing}
	\vspace{8mm}\par
	{Submitted to the Office of Graduate and Professional Studies of  \par
		Texas A\&M University \par
	in partial fulfillment of the requirement for the degree of \par
%			\vspace{9mm}	
			\vspace{14pt}	
		\MakeUppercase{\@degreename}
	}
	\end{center}
%	\vspace{6mm}
	\vspace{24pt}
\begin{flushleft}
	\begin{tabular}{l l}
		Chair of Committee, 	& 	\@ChairOfCommittee	\\ 
		%
		\ifx\@CoChairOfCommittee\@empty %
			\expandafter\@firstoftwo
		\else %
			\expandafter\@secondoftwo
		\fi %
		{}			%
		{Co-Chair of Committe,& \@CoChairOfCommittee  \\ }%
		
		Committee Members, 	& 	\@CommitteeMemberOne		\\
						&	 \@CommitteeMemberTwo		\\ 	%
		\ifx\@CommitteeMemberThree\@empty %
			\expandafter\@firstoftwo
		\else %
			\expandafter\@secondoftwo %
		\fi 	%
		{}	%
		{ & \@CommitteeMemberThree	\\}	%
		\ifx\@CommitteeMemberFour\@empty %
			\expandafter\@firstoftwo
		\else %
			\expandafter\@secondoftwo %
		\fi	%
		{}%
		{ & \@CommitteeMemberFour	\\}	%
		%http://tex.stackexchange.com/questions/4072/how-to-display-some-text-based-on-a-condition-inside-a-tabular-environment
		Head of Department, 	&	\@HeadOfDepartment	\\  
	\end{tabular}
\end{flushleft}
	\begin{center}
		\vspace{31pt} \par
		\@GraduateMonth			%August%December %
		~	%
		\@GraduateYear				% 20XX
		%university requires that graduating data must be
		\par
		\vspace{40pt}
		Major Subject:  \@GradMajor
		\par
		\vspace{42pt}
		Copyright  \@GraduateYear %
		~\@author
	\end{center}
}

\endinput
