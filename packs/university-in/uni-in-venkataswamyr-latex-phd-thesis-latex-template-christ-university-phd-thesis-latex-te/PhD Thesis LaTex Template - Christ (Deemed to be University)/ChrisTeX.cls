% Name of the University
\newcommand{\UniversityName}{Christ (Deemed to be University)}

% Name of the Research Center
\newcommand{\ResearchCenter}{CENTER OF RESEARCH}

% Place name
\newcommand{\Place}{Bengaluru}

% Program name
\newcommand{\ProgramName}{Doctor of Philosophy}

%-----------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%-----------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{Thesis}[2007/22/02 v1.0 LaTeX document class]
\def\baseclass{book}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\def\@checkoptions#1#2{
	\edef\@curroptions{\@ptionlist{\@currname.\@currext}}
	\@tempswafalse
	\@tfor\@this:=#2\do{
		\@expandtwoargs\in@{,\@this,}{,\@curroptions,}
		\ifin@ \@tempswatrue \@break@tfor \fi}
	\let\@this\@empty
	\if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
\@checkoptions{11pt}{{10pt}{11pt}{12pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}
\newcommand\bhrule{\typeout{------------------------------------------------------------------------------}}

\newcommand\btypeout[1]{\bhrule\typeout{\space #1}\bhrule}
\def\today{\ifcase\month\or
	January\or February\or March\or April\or May\or June\or
	July\or August\or September\or October\or November\or December\fi
	\space \number\year}
\usepackage{setspace}
\onehalfspacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage{vmargin}
\RequirePackage[utf8]{inputenc} 


%-------------------------------------------
%	MARGINS
%-------------------------------------------
\setmarginsrb  { 1.5in}  % left margin
{ 1.0in}  % top margin
{ 1.0in}  % right margin
{ 1.0in}  % bottom margin
{  20pt}  % head height
{0.25in}  % head sep
{   9pt}  % foot height
{ 0.3in}  % foot sep
%--------------------------------------------
\raggedbottom
\setlength{\topskip}{1\topskip \@plus 5\p@}
\doublehyphendemerits=10000       % No consecutive line hyphens.
\brokenpenalty=10000              % No broken words across columns/pages.
\widowpenalty=9999                % Almost no widows at bottom of page.
\clubpenalty=9999                 % Almost no orphans at top of page.
\interfootnotelinepenalty=9999    % Almost never break footnotes.

\usepackage{fancyhdr}
%\lhead[\rm\]{\fancyplain{}{\sl{\rightmark}}}
%\rhead[\fancyplain{}{\sl{\leftmark}}]{\rm\thepage}
%\chead{}\lfoot{}\rfoot{}\cfoot{}
%\pagestyle{fancy}

\renewcommand{\chaptermark}[1]{\btypeout{\thechapter\space #1}\markboth{\@chapapp\ \thechapter\ #1}{\@chapapp\ \thechapter\ #1}}
\renewcommand{\sectionmark}[1]{}
\renewcommand{\subsectionmark}[1]{}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\usepackage{amsmath,amsfonts,amssymb,amscd,amsthm,xspace}
\theoremstyle{plain}
\newtheorem{example}{Example}[chapter]
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{axiom}[theorem]{Axiom}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}
\usepackage[centerlast,small,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\newcommand{\aref}[1]{Appendix~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\floatpagefraction}{0.75}
\renewcommand{\dblfloatpagefraction}{.75}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\usepackage{graphicx}
\usepackage{epstopdf}
\usepackage{booktabs}
\usepackage{rotating}
\usepackage{listings}
\usepackage{lstpatch}
\lstset{captionpos=b,
	frame=tb,
	basicstyle=\scriptsize\ttfamily,
	showstringspaces=false,
	keepspaces=true}
\lstdefinestyle{matlab} {
	language=Matlab,
	keywordstyle=\color{blue},
	commentstyle=\color[rgb]{0.13,0.55,0.13}\em,
	stringstyle=\color[rgb]{0.7,0,0} }
\usepackage[pdfpagemode={UseOutlines},bookmarks=true,bookmarksopen=true,
bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
colorlinks,linkcolor={blue},citecolor={blue},urlcolor={red},
pdfstartview={FitV},unicode,breaklinks=true]{hyperref}
\pdfstringdefDisableCommands{
	\let\\\space
}


\usepackage{tfrupee}
\usepackage{hyperref}
\usepackage{graphicx,multirow}
\usepackage[square, numbers, comma, sort&compress]{natbib}
\usepackage{algorithm}% http://ctan.org/pkg/algorithms
\usepackage[noend]{algpseudocode}% http://ctan.org/pkg/algorithmicx
\usepackage{listings}
\usepackage{color}
\usepackage{textcomp}
\usepackage{datetime}
\usepackage{ragged2e}
%\usepackage{draftwatermark}
%\SetWatermarkText{Sample}

\usepackage{pdfpages}

\usepackage{amsmath, amsthm, amssymb, float, mathrsfs, lscape,  caption, color, xcolor, mathtools, enumerate, multicol, epsfig, latexsym,graphicx, epstopdf, underscore, longtable, subcaption, lipsum}
%\usepackage[usenames,dvipsnames]{pstricks}
\usepackage[pdf]{pstricks}
%\usepackage{auto-pst-pdf}
\usepackage{pst-grad} % For gradients
\usepackage{pst-plot} % For axes
\usepackage[T1]{fontenc}
\usepackage{times}
\usepackage{setspace}
\usepackage{xcolor}
\usepackage{subcaption}
\usepackage{float}
\usepackage{algorithm}
\usepackage{fourier} 
\usepackage{titlesec} 
\usepackage{array}
\usepackage[noend]{algpseudocode}% http://ctan.org/pkg/algorithmicx

\usepackage{imakeidx}
\makeindex[intoc]


\newcolumntype{x}[1]{>{\centering\arraybackslash\hspace{0pt}}p{#1}} 
\algrenewcommand\Return{\State \algorithmicreturn{} }%

\definecolor{universitycolor}{rgb}{0.0, 0.5, 0.69}
\definecolor{titlenamescolor}{rgb}{0.09, 0.45, 0.27}
\definecolor{titlecolor}{rgb}{1.0, 0.03, 0.0}
\definecolor{phdcolor}{rgb}{0.89, 0.0, 0.13}

\hypersetup{urlcolor=blue, colorlinks=true, linkcolor=black}

\definecolor{listinggray}{gray}{0.9}
\definecolor{lbcolor}{rgb}{0.9,0.9,0.9}
\lstset{
	backgroundcolor=\color{lbcolor},
	tabsize=4,
	rulecolor=,
	language=matlab,
	basicstyle=\scriptsize,
	upquote=true,
	aboveskip={1.5\baselineskip},
	columns=fixed,
	showstringspaces=false,
	extendedchars=true,
	breaklines=true,
	prebreak = \raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}},
	frame=single,
	showtabs=false,
	showspaces=false,
	showstringspaces=false,
	identifierstyle=\ttfamily,
	keywordstyle=\color[rgb]{0,0,1},
	commentstyle=\color[rgb]{0.133,0.545,0.133},
	stringstyle=\color[rgb]{0.627,0.126,0.941},
}


% PDF meta-data


\hypersetup{pdfkeywords=\UniversityName}
\hypersetup{pdfproducer={LaTeX}}
\hypersetup{pdfcreator={TeXLive 2020}}

%\usepackage{atbegshi}% http://ctan.org/pkg/atbegshi
%\AtBeginDocument{\AtBeginShipoutNext{\AtBeginShipoutDiscard}}

\newcommand\makecover{
	\begin{titlepage}					
		\begin{center}
			\setstretch{1.5} 
			{\Large \textbf{\textrm{{\MakeUppercase{\ResearchTitle}}}}}\\			
			\vspace{0.2in}		
			{\large{\textit{Thesis submitted to CHRIST (Deemed to be University})}} \\
			{\large{\textit{for the award of the Degree of}}} \\
			
			\vspace{0.2in}
			
			{\Large{{\textbf{\textrm{ {\MakeUppercase{\ProgramName}}\\}}}}}
			
			{\large{{\textbf{\textrm{in\\}}}}}
			
			{\large{{\textbf{\textrm{ {\MakeUppercase{\Discipline}}\\}}}}}
			\vspace{0.2in}			
			{\large{by}}\\		
			{\Large{\textrm{\textbf{{{\MakeUppercase{\AuthorName}}}}}}} \\ 
			
			\vspace{0.3in}
			{\large{Under the Supervision of}}\\
			
			{\Large{\textrm{\textbf{{\GuideName} \\ \vspace{-0.15in} {\large \GuideDesignation} \\  
			 \ifdefempty{\CoGuideName}{}{\vspace{-0.1in} {\normalsize and} \\ {\CoGuideName} \\ \vspace{-0.15in} {\large \CoGuideDesignation}\\}}}}} 
		 	\ifdefempty{\CoGuideName}{\vspace{0.3in}}{}		
			\vspace{0.1in}						
			\begin{figure}[H]
				\centering {{\includegraphics[totalheight=1.0in]{Assets/christ}}}
			\end{figure}
			\vspace{-0.1in}
			{{\large \MakeUppercase{\textbf{\ResearchCenter}}}} \\			
			{{\Large \MakeUppercase{\textbf{\UniversityName}}}} \\			
			{{\Large \MakeUppercase{\textbf{\Place}}}} \\
			\vspace{0.1in}
			\textbf{{\MakeUppercase{\SubmissionDate}}} 
		\end{center}		
	\end{titlepage}	
	\clearpage
}


\renewcommand\maketitle{
	\begin{titlepage}					
		\begin{center}
			\setstretch{1.5} 
			{\Large \textbf{\textrm{{\MakeUppercase{\ResearchTitle}}}}}\\			
			\vspace{0.2in}		
			{\large{\textit{Thesis submitted to CHRIST (Deemed to be University})}} \\
			{\large{\textit{for the award of the Degree of}}} \\
			
			\vspace{0.2in}
			
			{\Large{{\textbf{\textrm{ {\MakeUppercase{\ProgramName}}\\}}}}}
			
			{\large{{\textbf{\textrm{in\\}}}}}
			
			{\large{{\textbf{\textrm{ {\MakeUppercase{\Discipline}}\\}}}}}
			\vspace{0.2in}			
			{\large{by}}\\		
			{\Large{\textrm{\textbf{{{\MakeUppercase{\AuthorName}}}}}}} \\ 
			
			\vspace{0.3in}
			{\large{Under the Supervision of}}\\
			
			{\Large{\textrm{\textbf{{\GuideName} \\ \vspace{-0.15in} {\large \GuideDesignation} \\  
							\ifdefempty{\CoGuideName}{}{\vspace{-0.1in} {\normalsize and} \\ {\CoGuideName} \\ \vspace{-0.15in} {\large \CoGuideDesignation}\\}}}}} 
			\ifdefempty{\CoGuideName}{\vspace{0.3in}}{}
			\vspace{0.1in}						
			\begin{figure}[H]
				\centering {{\includegraphics[totalheight=1.0in]{Assets/christ}}}
			\end{figure}
			\vspace{-0.1in}
			{{\large \MakeUppercase{\textbf{\ResearchCenter}}}} \\			
			{{\Large \MakeUppercase{\textbf{\UniversityName}}}} \\			
			{{\Large \MakeUppercase{\textbf{\Place}}}} \\
			\vspace{0.1in}
			\textbf{{\MakeUppercase{\SubmissionDate}}}
		\end{center}		
	\end{titlepage}	
	\clearpage
}

 
%-------------------------------------------------
%	ABSTRACT PAGE DESIGN
%------------------------------------------------
\newenvironment{abstract}
{
	\clearpage % Start a new page
	\btypeout{Abstract Page}
	\addtotoc{ABSTRACT} 
	\addtocontents{toc}{\vspace{0em}} 
	\thispagestyle{plain}	
	\begin{center}
		\setlength{\parskip}{2pt}
		{\Large \textbf{\textrm{ABSTRACT}} \par}
		\bigskip
	\end{center}
	
}


\addtocounter{secnumdepth}{1}
\setcounter{tocdepth}{6}
\newcounter{dummy}
\newcommand\addtotoc[1]{
	\refstepcounter{dummy}
	\addcontentsline{toc}{chapter}{#1}}


\renewcommand\contentsname{\centering {\Large \textbf{\textrm{TABLE OF CONTENTS}}}}

\renewcommand\tableofcontents{
	\btypeout{TABLE OF CONTENTS}
	\addtotoc{TABLE OF CONTENTS}
	\begin{spacing}{1}{
			\setlength{\parskip}{1pt}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\contentsname
				\@mkboth{
					\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
			\@starttoc{toc}
			\if@restonecol\twocolumn\fi
			\cleardoublepage
	}\end{spacing}
}

\newcommand\listfigurenametwo{\begin{center}
		\setlength{\parskip}{2pt}
		{\Large \textbf{\textrm{LIST OF FIGURES}} \par}
		\bigskip
	\end{center}}


\renewcommand\listoffigures{
	\btypeout{LIST OF FIGURES}
	\addtotoc{LIST OF FIGURES}
	\begin{spacing}{1}{
			\setlength{\parskip}{1pt}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listfigurenametwo
				\@mkboth{\MakeUppercase\listfigurenametwo}
				{\MakeUppercase\listfigurenametwo}}
			\@starttoc{lof}
			\if@restonecol\twocolumn\fi
			\cleardoublepage
	}\end{spacing}
}




\newcommand\listtablenametwo{\centering {\Large \textbf{\textrm{LIST OF TABLES}}}}

\renewcommand\listoftables{
	\btypeout{LIST OF TABLES}
	\addtotoc{LIST OF TABLES}
	\begin{spacing}{1}{
			\setlength{\parskip}{1pt}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listtablenametwo
				\@mkboth{
					\MakeUppercase\listtablenametwo}{\MakeUppercase\listtablenametwo}}
			\@starttoc{lot}
			\if@restonecol\twocolumn\fi
			\cleardoublepage
	}\end{spacing}
}


\newcommand\approvalofthesisname{\centering {\Large \textbf{\textrm{APPROVAL OF THESIS}}}}

\newcommand\approvalofthesis{
	\btypeout{APPROVAL OF THESIS}
	\addtotoc{APPROVAL OF THESIS}	
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{APPROVAL OF THESIS}} \par}\end{center}
	
	The thesis titled \textquotedblleft \textbf{\MakeUppercase{\ResearchTitle}} \textquotedblright~by \textbf{\AuthorName}~is approved by the Research Advisory Committee (RAC) for submission to the Centre for Research.\\
	\begin{center}
		
	
	\begin{tabular}{ccl}
		1 & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  & Chairperson of RAC \\
		& \GuideName &  \\
		&&\\
		&&\\
		\ifdefempty{\CoGuideName}{}{2 & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  & Co Supervisor  \\
		& \CoGuideName &  \\
		&&\\
		&&\\}
		\ifdefempty{\CoGuideName}{2}{3} & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  & RAC Member  \\
		& \RACMemberOne &  \\
		&&\\
		&&\\
		\ifdefempty{\CoGuideName}{3}{4} & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  & RAC member  \\
		& \RACMemberTwo &  \\
		&&\\
	\end{tabular}
\end{center}

	\begin{tabular}{p{10cm}x{5cm}}	
		Accepted to Centre for Research &  \\
		&\\
		& \\
		\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ & Seal \\
		&\\
		\textbf{\DirectorResearchCenter}& \\
		Director, Centre for Research &  \\
		
	\end{tabular}

	
	\cleardoublepage
}


\newcommand\listsymbolname{\centering {\Large \textbf{\textrm{ABBREVIATIONS}}}}

\usepackage{longtable}
\newcommand\abbreviations[2]{
	\clearpage
	\btypeout{ABBREVIATIONS}
	\addtotoc{ABBREVIATIONS}
	\thispagestyle{plain}
	\setstretch{1.5}
	\lhead{\emph{Abbreviations}}
	\begin{center}{\Large \textbf{\textrm{ABBREVIATIONS}} \par}\end{center}
	\begin{longtable}[c]{#1}#2\end{longtable}\par
	\cleardoublepage
}


\newcommand\listconstantsname{PHYSICAL CONSTANTS}
\newcommand\listofconstants[2]{
	\btypeout{\listconstantsname}
	\addtotoc{\listconstantsname}
	\clearpage
	\lhead{\emph{Physical Constants}} 
	\begin{center}{\Large \textbf{\textrm{\listconstantsname}} \par}\end{center}
	\begin{longtable}[c]{#1}#2\end{longtable}\par
	\cleardoublepage
}
\newcommand\listnomenclaturename{SYMBOLS}
\newcommand\listofnomenclature[2]{
	\btypeout{\listnomenclaturename}
	\addtotoc{\listnomenclaturename}
	\clearpage 	
	\lhead{\emph{Symbols}} 
	\begin{center}{\Large \textbf{\textrm{\listnomenclaturename}} \par}\end{center}
	\begin{longtable}[c]{#1}#2\end{longtable}\par
	\cleardoublepage
}
\newcommand\Acknowledgementname{ACKNOWLEDGEMENT}

\newcommand\acknowledgements[1]{
	\btypeout{\Acknowledgementname}
	\addtotoc{\Acknowledgementname}
	\newpage
	\setstretch{1.3}
	%\addtocontents{toc}{\vspace{0em}} 
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{ACKNOWLEDGMENT}} \par}\end{center}
	{\normalsize #1}
	\vfil\vfil\null
	\clearpage 
}



\newcommand\publicationlistname{PUBLICATIONS AND PRESENTATIONS}

\newenvironment{publicationlist}
{
	\clearpage
	\btypeout{\publicationlistname}
	\addtotoc{\publicationlistname}
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{PUBLICATIONS AND PRESENTATIONS}} \par}\end{center}
}




\newcommand\IndustryCertificatename{INDUSTRY CERTIFICATE}
\newenvironment{IndustryCertificate}
{
	\btypeout{\IndustryCertificatename}
	\addtotoc{\IndustryCertificatename}
	\thispagestyle{plain}
}

\newcommand\Certificatename{CERTIFICATE}

\newenvironment{certificate}
{
	\btypeout{\Certificatename}
	\addtotoc{\Certificatename}
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{\Certificatename}} \par}\end{center}
}

\newcommand\BonafideCertificatename{BONAFIDE CERTIFICATE}
\newenvironment{BonafideCertificate}
{
	\btypeout{\BonafideCertificatename}
	\addtotoc{\BonafideCertificatename}
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{\BonafideCertificatename}} \par}\end{center}
}


\newcommand\glossarylistname{GLOSSARY}

\newenvironment{glossarylist}
{
	\clearpage
	\btypeout{\glossarylistname}
	\addtotoc{\glossarylistname}
	\thispagestyle{plain}
	\setstretch{1.5}
	\begin{center}{\Large \textbf{\textrm{\glossarylistname}} \par}\end{center}
}

\newcommand\declaration{
	\btypeout{DECLARATION}
	\addtotoc{DECLARATION}
	\thispagestyle{plain}
	%\null\vfil
	%\vskip 60\p@
	\begin{center}{\Large \textbf{\textrm{DECLARATION}} \par}\end{center}
	\justify
	{
		I, \AuthorName, hereby declare that the thesis entitled \textquotedblleft \MakeUppercase{\textbf{\ResearchTitle}}\textquotedblright~is a record of original research work undertaken by me for the award of the degree of \textbf{\ProgramName} in \Discipline~Discipline under the supervision of \textbf{\GuideName}, \GuideDesignation, \GuideDepartment, \GuideAddress~and \textbf{\CoGuideName}, \CoGuideDesignation, \CoGuideDepartment, \CoGuideAddress~and has not formed the basis for the award of any	degree, diploma, associate ship, fellowship, or titles.
	
	I hereby confirm the originality of the work and that there is no plagiarism in any part of the dissertation.	
	
    }
	\vspace{2.5cm}
	\begin{tabular}{lp{1cm}p{10cm}}
		\textbf{Place:} Bengaluru  && \textbf{\AuthorName} \\
		\textbf{Date:} \DateofDeclaration&& Register No: \RegisterNo \\
		&& \DepartmentName \\
		&& \CollegeName\\
		&& \UniversityName\\
	\end{tabular}

	\clearpage
}



\newcommand\certificateguides{
	\btypeout{CERTIFICATE}
	\addtotoc{CERTIFICATE}
	\thispagestyle{plain}
	%\null\vfil
	%\vskip 60\p@
	\begin{center}{\Large \textbf{\textrm{CERTIFICATE}} \par}\end{center}
	\justify
	{
		This is to certify that the thesis submitted by \textbf{\AuthorName} (Reg No. \textbf{\RegisterNo}), entitled \textquotedblleft \textbf{\MakeUppercase{\ResearchTitle}} \textquotedblright~in fulfillment for the award of  \textbf{\ProgramName} in \Discipline~is a record of original research work carried out by \ifthenelse{\equal{\AuthorGender}{Male}}{him}{her} during the academic year \AcademicYear~under \ifdefempty{\CoGuideName}{my}{our} supervision.
		
		The thesis has not formed the basis for the award of any degree, diploma, associateship, fellowship or other titles. We hereby confirm the originality of the work and that there is no plagiarism in any part of the dissertation.
	}
	
		\vspace{2.5cm}
	\begin{tabular}{lp{1cm}p{10cm}}
		\textbf{Place:} Bengaluru  && \textbf{\GuideName} \\
		\textbf{Date:} \DateofDeclaration&& \GuideDesignation \\
		&& \GuideDepartment \\
		&& \GuideCollegeName\\
		&& \GuideAddress\\
		&& \\
		&& \\
		&& \\
		&& \\
		&& \textbf{\CoGuideName}\\
		&& \CoGuideDesignation \\
		&& \CoGuideDepartment \\
		&& \CoGuideCollegeName\\
		&& \GuideAddress\\
	\end{tabular}
	
	\clearpage
}



\newcommand\dedicatory{
	\btypeout{Dedicatory}
	\thispagestyle{plain}
	\setstretch{1.3} 
	\pagestyle{empty}
	\null\vfil
	\vskip 60\p@
	\begin{center}{\Large \sl \DedicationString}\end{center}
	\addtocontents{toc}{\vspace{2em}}
	\vfil\null
	\cleardoublepage
}


\newcommand\certification[4]{
	\btypeout{#1}
	\addtotoc{#1}
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{#1}} \par}\end{center}
		\pagestyle{empty}
	\begin{center}		
		\begin{figure}[H]
			\begin{center}
				\centering
				\hspace*{-3cm}
				\includegraphics[width=#3,height=#4]{#2}
			\end{center}
		\end{figure}
		
	\end{center}
	\clearpage
}


\newcommand\letter[4]{
	\btypeout{#1}
	\addtotoc{#1}
	\thispagestyle{plain}
	\begin{center}{\Large \textbf{\textrm{#1}} \par}\end{center}
	\pagestyle{empty}
	\begin{center}		
		\begin{figure}[H]
			\begin{center}
				\centering
				\hspace*{-3cm}
				\includegraphics[width=#3,height=#4]{#2}
			\end{center}
		\end{figure}
		
	\end{center}
	\clearpage
}


\usepackage{titlesec}

\newcommand{\Chapter}[1]{\newpage%
	\topskip0pt%
	%\vspace*{\fill}%
	\null\vfil
	\vspace{5cm}
	\addtocounter{chapter}{1}%
	\begin{center}%
		\setstretch{3}
		\textbf{\Huge{{CHAPTER NO. \thechapter \\ \uppercase{#1}}}}%
	\end{center}%
	\vspace*{\fill}%
	\addtocounter{chapter}{-1}
	%\addtotoc{\thechapter #1}
	\newpage%
	\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter.\hspace{15pt}}{0pt}{\Huge\bfseries}
    \chapter{#1}
}

\renewcommand\backmatter{
	\if@openright
	\cleardoublepage
	\else
	\clearpage
	\fi
	\addtotoc{\bibname}
	\btypeout{\bibname}
	\@mainmatterfalse}
\endinput




