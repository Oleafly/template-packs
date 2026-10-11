\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ritthesis}[2015/06/27]

% Requirements for title and signature sheets takes from:
% http://infoguides.rit.edu/thesis-services

% Preliminary commands that are available to the user but are set by some class
% options and are therefore defined here
\newcommand*\@documenttype{\ClassError{ritthesis}
	{\protect\@documenttype\ undefined. Use \protect\documenttype{} to set.}{}}
\newcommand*\@degreefield{\ClassError{ritthesis}
	{\protect\@degreefield undefined. Use \protect\degreefield{} to set}{}}
\newcommand*\@degreename{\ClassError{ritthesis}
	{\protect\@degreename\ undefined. Use \protect\degreename{} to set.}{}}
\newcommand*\@degreenameshort{\ClassError{ritthesis}
	{\protect\@degreename\ undefined. Use \protect\degreename{} to set.}{}}


\newcommand*\@city{\ClassError{ritthesis}
	{\protect\@city\ undefined. Use \protect\city{} to set.}{}}
\newcommand*\@university{\ClassError{ritthesis}
	{\protect\@university\ undefined. Use \protect\university{} to set.}{}}
\newcommand*\@universityshort{\ClassError{ritthesis}
	{\protect\@universityshort undefined. Use \protect\university{} to set.}{}}
\newcommand*\@college{\ClassError{ritthesis}
	{\protect\@college\ undefined. Use \protect\college{} to set.}{}}
\newcommand*\@collegeshort{\ClassError{ritthesis}
	{\protect\@collegeshort undefined. Use \protect\college{} to set.}{}}
\newcommand*\@department{\ClassError{ritthesis}
	{\protect\@department\ undefined. Use \protect\department{} to set.}{}}
\newcommand\@logo{}
\newcommand*\@logoopts{}

\newcommand*\documenttype[1]{\renewcommand*\@documenttype{#1}}
\newcommand*\degreefield[1]{\renewcommand*\@degreefield{#1}}

%\@ifundefined{degreename}
	\def\degreename{%
		\@ifnextchar[{\@degnamecomplex}{\@degnamesimple}}
	\def\@degnamesimple#1{%
		\renewcommand*\@degreename{#1}\renewcommand*\@degreenameshort{#1}}
	\def\@degnamecomplex[#1]#2{%
		\renewcommand*\@degreename{#2}\renewcommand*\@degreenameshort{#1}}
%\fi

\newcommand*\city[1]{\renewcommand*\@city{#1}}
\newcommand*\department[1]{\renewcommand*\@department{#1}}
\newcommand\logo[1]{\renewcommand\@logo{#1}}

%\@ifundefined{logo}
	\def\logo{\@ifnextchar[{\@logob}{\@logoa}}
	\long\def\@logoa#1{%
		\renewcommand\@logo{#1}\renewcommand*\@logoopts{}}
	\long\def\@logob[#1]#2{%
		\renewcommand\@logo{#2}\renewcommand*\@logoopts{#1}}
%\fi

%\@ifundefined{university}
	\def\university{\@ifnextchar[{\@universityb}{\@universitya}}
	\def\@universitya#1{%
		\renewcommand*\@university{#1}\renewcommand*\@universityshort{#1}}
	\def\@universityb[#1]#2{%
		\renewcommand*\@university{#2}\renewcommand*\@universityshort{#1}}
%\fi

%\@ifundefined{college}
	\def\college{\@ifnextchar[{\@collegeb}{\@collegea}}
	\def\@collegea#1{%
		\renewcommand*\@college{#1}\renewcommand*\@collegeshort{#1}}
	\def\@collegeb[#1]#2{%
		\renewcommand*\@college{#2}\renewcommand*\@collegeshort{#1}}
%\fi

\newcommand*\certificationmessage{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%           Options           %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% General Settings %%%%%

% Font Size
\DeclareOption{10pt}{
	\PassOptionsToClass\CurrentOption{article}
	\PassOptionsToClass\CurrentOption{report}
}
\DeclareOption{11pt}{
	\PassOptionsToClass\CurrentOption{article}
	\PassOptionsToClass\CurrentOption{report}
}
\DeclareOption{12pt}{
	\PassOptionsToClass\CurrentOption{article}
	\PassOptionsToClass\CurrentOption{report}
}

% Equation Alignment
\DeclareOption{fleqn}{
	\PassOptionsToClass{\CurrentOption}{article}
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{leqno}{
	\PassOptionsToClass{\CurrentOption}{article}
	\PassOptionsToClass{\CurrentOption}{report}
}

% Line spacing in the main document
\newcommand*\@documentspacing\undefined
\DeclareOption{singlespacing}{
	\PassOptionsToPackage{singlespacing}{setspace}
	\renewcommand*\@documentspacing\singlespacing
}
\DeclareOption{onehalfspacing}{
	\PassOptionsToPackage{onehalfspacing}{setspace}
	\renewcommand*\@documentspacing\onehalfspacing
}
\DeclareOption{doublespacing}{
	\PassOptionsToPackage{doublespacing}{setspace}
	\renewcommand*\@documentspacing\doublespacing
}

% Line spacing for the lists (toc, lof and lot)
\newcommand*\@listspacing\undefined
\newcommand*\@tocspacing\@listspacing
\newcommand*\@lofspacing\@listspacing
\newcommand*\@lotspacing\@listspacing
\newcommand*\@losspacing\@listspacing
\DeclareOption{singlespacelists}{
	\renewcommand*\@listspacing\singlespacing
}
\DeclareOption{onehalfspacelists}{
	\renewcommand*\@listspacing\onehalfspacing
}
\DeclareOption{doublespacelists}{
	\renewcommand*\@listspacing\doublespacing
}

% Line spacing for the bibliography
\newcommand\@bibspacing\undefined
\DeclareOption{singlespacebib}{
	\renewcommand\@bibspacing\singlespacing
}
\DeclareOption{onehalfspacebib}{
	\renewcommand\@bibspacing\onehalfspacing
}
\DeclareOption{doublespacebib}{
	\renewcommand\@bibspacing\doublespacing
}

% Draft mode
\DeclareOption{draft}{
	\PassOptionsToClass{\CurrentOption}{article}
	\PassOptionsToClass{\CurrentOption}{report}
}


%%%%% Header and footer options %%%%%
\newif\if@header\@headertrue
\newcommand\@pagenumpos\undefined

% Completely disables header
\DeclareOption{nohead}{
	\@headerfalse
}
\DeclareOption{pagenumouter}{
	\renewcommand\@pagenumpos{R}
}
\DeclareOption{pagenumcenter}{
	\renewcommand\@pagenumpos{C}
}

%%%%% Different modes  or presets%%%%%
\newif\if@proposal
\newif\if@microsys
\newif\if@microe
\newif\if@cmpe
\newcommand\@toplevel{chapter}
\newcommand\@baseclass{report}

\DeclareOption{proposal}{
	\@proposaltrue
	\@headerfalse
	\renewcommand\@baseclass{article}
	\renewcommand\@toplevel{section}
}
\DeclareOption{ms}{
	\documenttype{Thesis}
	\degreename[MS]{Master of Science}
}
\DeclareOption{phd}{
	\documenttype{Dissertation}
	\degreename[PhD]{Doctorate of Philosophy}
}
\DeclareOption{microe}{
	\@microetrue
	\documenttype{Thesis}
	\degreefield{Microelectronic Engineering}
	\degreename[MS]{Master of Science}
	\college[KGCOE]{Kate Gleason College of Engineering}
	\department{Department of Electrical and Microelectronic Engineering}
	\logo[15em]{kgcoelogohoriz}
	\city{Rochester, New York}
	\university[RIT]{Rochester Institute of Technology}
}
\DeclareOption{cmpe}{
\@cmpetrue
\documenttype{Thesis}
\degreefield{Computer Engineering}
\degreename[MS]{Master of Science}
\college[KGCOE]{Kate Gleason College of Engineering}
\department{Department of Computer Engineering}
\logo[15em]{kgcoelogohoriz}
\city{Rochester, New York}
\university[RIT]{Rochester Institute of Technology}
}
\DeclareOption{microsys}{
	\@microsystrue
	\documenttype{Dissertation}
	\degreefield{Microsystems Engineering}
	\degreename[PhD]{Doctorate of Philosophy}
	\college[KGCOE]{Kate Gleason College of Engineering}
	\department{Microsystems Engineering Department}
	\logo[0.25\linewidth]{kgcoelogovert}
	\renewcommand\certificationmessage{%
		We, the undersigned committee members, certify that we have advised and/or
		supervised the candidate on the work described in this dissertation. We
		further certify that we have reviewed the dissertation manuscript and
		approve it in partial fulfillment of the requirements of the degree of
		\@degreename\ in \@degreefield.}
	\city{Rochester, New York}
	\university[RIT]{Rochester Institute of Technology}
}
\DeclareOption{rit}{
	\city{Rochester, New York}
	\university[RIT]{Rochester Institute of Technology}
	\ifx\@logo\empty
	\logo[10em]{ritlogo}
	\else
	\fi
}

% Default options
\ExecuteOptions{letterpaper,12pt,doublespacing,onehalfspacelists,singlespacebib,pagenumouter}

% Process options
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%        Initial Setup        %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@proposal
	\PassOptionsToPackage{left=1in, right=1in, top=1in, bottom=1in}{geometry}
\else
	\PassOptionsToPackage{left=1.5in, right=1in, top=1in, bottom=1in}{geometry}
\fi

\AtBeginDocument{
	\pagestyle{fancy}
	% Reset the header/footer
	\fancyhf{}
	% Footer
	\fancyfoot[\@pagenumpos]{\thepage}
	% Header
	\if@header
		\fancyhead[L]{\footnotesize\textbf\leftmark}
		\renewcommand{\headrulewidth}{0.7pt}
	\else
		\renewcommand\headrulewidth{0pt}
	\fi
	% Plain page style
	\fancypagestyle{plain}{%
		\fancyhf{}
		\fancyfoot[\@pagenumpos]{\thepage}
		\renewcommand{\headrulewidth}{0pt}
		\renewcommand{\footrulewidth}{0pt}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%        Load Base Class      %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{\@baseclass}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%           Packages          %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{geometry}			% Set up page margins
\RequirePackage{titlesec}			% Customize the chapter headings
\RequirePackage{setspace}			% We needed double spacing
\RequirePackage{fancyhdr}			% Set up the header and footer
\RequirePackage{longtable}		% Used for table of symbols
\RequirePackage{booktabs}			% Used for better \hrule in table of symbols
\RequirePackage[font=small,labelfont={bf,small}]{caption}	% customize captions
% If using the subcaption (preferred) package for subfigures, the caption
% formatting is automatically adapted for subcaptions.
% If using the subfig package instead, the settings must be coppied over.
\PassOptionsToPackage{font=small,labelfont={bf,small}}{subfig}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%       Custom Commands       %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Misc. Commands %%%%%
\providecommand\phantomsection{}		% Make work with or without hyperref

%%%%% Front Matter %%%%%
\newcommand\frontmatter{\pagenumbering{roman}\maketitlepage\makesignaturepage}

% Commands to track information about the author and document
\renewcommand\@author{\ClassError{ritthesis}
	{\protect\@author undefined. Use \protect\author{} to set.}{}}
\renewcommand\author[1]{\renewcommand\@author{#1}}

\renewcommand\@date\today
\renewcommand\date[1]{\renewcommand\@date{#1}}

\renewcommand\@title{\ClassError{ritthesis}
	{\protect\@title undefined. Use \protect\title{} to set.}{}}
\renewcommand\title[1]{\renewcommand\@title{#1}}

% How things get displayed
\newcommand\thetitle{\textbf{\Large\@title}}
\newcommand\theauthor{\textsc{\@author}}

% Title page(s)
\newcommand\maketitlepage{{
	\cleardoublepage
	\singlespacing
	\centering
	\pagestyle{empty}
	\if@microsys
		\setcounter{page}{0}
		\ \vspace{-12pt}
		\vfill
		
		\ifx\@logoopts\empty
			\includegraphics{\@logo}
		\else
			\includegraphics[width=\@logoopts]{\@logo}
		\fi
		
		\vfill
		
		\thetitle
		
		\theauthor
		
		\vfill
		
		A \MakeLowercase{\@documenttype} submitted in partial fulfillment of the requirements\\
		for the degree of \@degreename\ in \@degreefield\
		
		\vfill
		
		\@degreefield\ Program
		
		\@college
		
		\vfill
		
		\textit\@university
		
		\textit\@city
		
		\textit\@date
		
		\vfill
		\hrule
		\cleardoublepage
	\else
		\pagestyle{empty}
		\setcounter{page}{-1}
		\ \vspace{-12pt}
		\hrule
		\vfill\vfill
		\thetitle
		
		\vfill
		
		\theauthor
		
		\vfill\vfill
		\hrule
		\cleardoublepage
		\ \vspace{-12pt}
		\hrule
		\vfill
		\thetitle
		
		\theauthor\\
		
		\@date
		
		\vfill
		
		A Thesis Submitted\\
		in Partial Fulfillment\\
		of the Requirements for the Degree of\\
		\@degreename\\
		in\\
		\@degreefield
		
		\vfill
		
		\ifx\@logoopts\empty
			\includegraphics{\@logo}
		\else
			\includegraphics[width=\@logoopts]{\@logo}
		\fi
		
		\vfill
		
		\textit\@department
		
		\vspace{1ex}
		\hrule
		\cleardoublepage
	\fi
}}

%%%%% Commands for making the signature sheet %%%%%
\newcommand*\@siglinelength\linewidth
\newlength\@siglineheight
\setlength\@siglineheight{1pt}
% Spacing between individual committee members
\newlength\@committeeskip
\setlength\@committeeskip{5ex}
% Space after "Certified By, etc."
\newlength\@committeetablelabelskip
\setlength\@committeetablelabelskip{5ex}
% Space after a committee table and the next one
\newlength\@committeetableskip
\setlength\@committeetableskip{7ex}

% Syntax of \addcommittee is:
% \addcommittee[Title (Dr.)]{Position (Prof)}{First MI.}{Last}{Role (Advisor)}
% #1 -> Title
% #2 -> Position
% #3 -> First MI
% #4 -> Last
% #5 -> Position
\newcommand*{\@committeetable}{}
\newcommand*\committee[5][Dr.]{\g@addto@macro\@committeetable{%
	\rule{\linewidth}{\@siglineheight}\\
	#1\ #3 #4 \textit{#5}\hfill Date\\
	#2\vskip\@committeeskip\relax%
}}

\newcommand*{\@certifiedbytable}{}
\newcommand*{\certifiedby}[5][Dr.]{\g@addto@macro\@certifiedbytable{%
	\rule{\linewidth}{\@siglineheight}\\
	#1\ #3 #4 \textit{#5}\hfill Date\\
	#2\vskip\@committeeskip\relax%
}}

% Syntax for \advisor and \committee commands
% \advisor[Position]{First}{Last}
% \committee[Position]{First}{Last}
\newcommand*{\advisor}[3]{
	\providecommand{\@advisor}{Dr.\ \textsc{#2 #3}}
	\committee{#1}{#2}{#3}{Advisor}
}
% todo: consider renaming this macro, or removing
%\newcommand*{\committee}[3]{
%	\addcommittee{#1}{#2}{#3}{}
%}
\newcommand*\setadvisor[3][Dr.]{
	\providecommand{\@advisor}{#1\ \textsc{#2 #3}}
}

\newcommand{\@makecommitteetable}{
	\begin{minipage}{\@siglinelength}
		\setlength\parindent{0pt}\small
		\@committeetable\removelastskip
		\ifx\@certifiedbytable\empty
		\else
			\vskip\@committeetableskip
			{\normalsize\bfseries Certified By:}\vskip\@committeetablelabelskip
			\@certifiedbytable
		\fi
	\end{minipage}
}

\newcommand{\makesignaturepage}{
	\cleardoublepage
	\thispagestyle{plain}
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{Signature Sheet}
	{
		\setlength\parindent{0pt}
		\singlespacing
		\begin{center}
			\thetitle
			
			\theauthor
		\end{center}
		
		\vfill
		\textbf{Committee Approval:}\vspace{0.5em}
		
		{\small\certificationmessage}
		
		\centering
		\ifx\certificationmessage\empty
		\vskip\@committeetablelabelskip
		\else
		\vfill\vfill
		\fi
		
		\@makecommitteetable
		
		\vfill
	}
}

%%%%% Main Matter %%%%%
\newcommand{\mainmatter}{\pagenumbering{arabic}}

\newcommand{\makealllists}{%
	{%
		\cleardoublepage
		\phantomsection
		\@tocspacing
		\addcontentsline{toc}{\@toplevel}{Table of Contents}\tableofcontents
		\cleardoublepage
		\phantomsection
		\@lofspacing
		\addcontentsline{toc}{\@toplevel}{List of Figures}\listoffigures
		\cleardoublepage%
		\phantomsection
		\@lotspacing
		\addcontentsline{toc}{\@toplevel}{List of Tables}\listoftables
		\cleardoublepage%
	}
}

% Chapter headings
\setcounter{secnumdepth}{3}
\if@proposal
\else
	\titleformat{\chapter}[display]
		{\singlespacing\raggedright\normalfont\LARGE\bfseries}
		{\chaptertitlename{} \thechapter}
		{0em}
		{\titlerule[2pt]\vspace{0.25em}\raggedleft\large}
		[\vspace{0.5em}]
	\titleformat*{\section}{\normalfont\large\bfseries}
	\titleformat*{\subsection}{\normalfont\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries}
	\titleformat{name=\chapter,numberless}[display]
		{\singlespacing\raggedright\normalfont\bfseries}
		{}
		{-8em}
		{\raggedright\Large}
		[\titlerule]
\fi


% Header formatting stuff
\if@header
	\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. #1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection{} #1}{}}
\fi


% Bibliography
\newcommand{\makebibliography}[1]{%
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{Bibliography}
	\bibliographystyle{IEEEtran}
	{
		\@bibspacing
		\bibliography{#1}
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Custom Environments %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*\@yesoption{y}
\newcommand*\@nooption{n}
\renewenvironment{abstract}[1][y]
	{%
		\cleardoublepage
		\newcommand*\@option{#1}
		\ifx\@option\@yesoption
			\phantomsection
			\addcontentsline{toc}{\@toplevel}{\abstractname}
		\else\ifx\@option\empty
			\phantomsection
			\addcontentsline{toc}{\@toplevel}{\abstractname}
		\fi\fi
		\pagestyle{plain}
		\begin{center}
			\textbf{\large\abstractname}
		\end{center}%
	}
	{\cleardoublepage}

\newcommand{\acknowledgmentsname}{Acknowledgments}
\newenvironment{acknowledgments}[1][]
	{%
		\cleardoublepage
		\newcommand*\@option{#1}
		\ifx\@option\@yesoption
			\phantomsection
			\addcontentsline{toc}{\@toplevel}{\acknowledgmentsname}
		\fi
		\pagestyle{plain}
		\begin{center}
			\textbf{\large\acknowledgmentsname}
		\end{center}%
	}
	{\cleardoublepage}

\newcommand{\dedicationname}{Dedication}
\newenvironment{dedication}[1][]
	{%
		\cleardoublepage
		\newcommand*\@option{#1}
		\ifx\@option\@yesoption
			\phantomsection
			\addcontentsline{toc}{\@toplevel}{\dedicationname}
		\fi
		\pagestyle{plain}
		\centering\itshape
		\ \vfill%
	}
	{\vfill\cleardoublepage}

\newcommand{\listofsymbname}{List of Symbols}
\newenvironment{listofsymbols}[3][\listofsymbname]
	{
		\cleardoublepage
		\phantomsection
		% todo: make sure this works
		\csname\@toplevel\endcsname*{#1}
		\addcontentsline{toc}{\@toplevel}{#1}
		\pagestyle{plain}
		\centering
		\@losspacing
		\begin{longtable}{#2}
			\toprule
			#3\\
			\midrule
			\endhead
			\bottomrule
			\endfoot
	}
	{\end{longtable}\cleardoublepage}


% Setting the chapter title formatting different for appenndices
\let\@original@appendix\appendix
\renewcommand\appendix{\@setappendixtitleformat\@original@appendix}
\newcommand\@setappendixtitleformat{
	\titleformat{\chapter}[hang]
		{\singlespacing\raggedright\vspace{-18ex}\normalfont\Large\bfseries}
		{\chaptertitlename{} \thechapter:}
		{1em}
		{\Large}
		[\vspace{-5ex}]
	\titleformat*{\section}{\normalfont\large\bfseries}
	\titleformat*{\subsection}{\normalfont\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries}
	\titleformat{name=\chapter,numberless}[display]
		{\singlespacing\raggedright\vspace{-18ex}\normalfont\Large\bfseries}
		{}
		{1em}
		{\raggedright\Large}
		[\titlerule]
}


\newenvironment{theappendix}[1]
	{
		% Note: This is very broken for proposals. In fact, it is probably better
		% to just not even use this single appendix environment when writing one
		\if@proposal
			%\titleformat{\section}[display]
			%{\normalfont\bfseries}
			%{\LARGE{Appendix}}
			%{0em}
			%{\titlerule[2pt]\vspace{0.25em}\raggedleft\large}
			%[\vspace{0.5em}]
		\else
			\titleformat{\chapter}[hang]
				{\singlespace\raggedright\vspace{-18ex}\normalfont\Large\bfseries}
				{\chaptertitlename{} \thechapter:}
				{1em}
				{\Large}
				[\vspace{-5ex}]
		\fi
		
		\@original@appendix
		\if@header
			\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{}: ##1}{}}
		\fi
		\chapter{#1}
	}
	{
		\if@header
			\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. ##1}{}}
		\fi
	}

% Done
\endinput
