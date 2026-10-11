% KoreaTech Thesis Document Class for LaTeX2e
%%%===========================================================================================================
%%%@LaTeX-class-file {
	%%	filename	= "koreatechthesis.cls",
	%%	version		= "2.1",
	%%	date		= "2025/08/07",
	%%	author   	= "Hongkeun Kim",
	%%	affiliation	= "School of Mechatronics Engineering",
	%%	keywords	= "LaTeX, KoreaTech, Korea University of Technology and Education, thesis",
	%%	docstring	= "This class file is intended to meet the requirements for KoreaTech thesis."
	%%	   			   The class file is based on: book.cls."
	%%}
%%%===========================================================================================================


%-- Identification -------------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{koreatechthesis}[2025/08/07 v2.1 LaTeX class for KoreaTech thesis]		% the first argument should always match with the file name.



%-- Initial code --------------------------------------------------------------------------------------------
\newif\if@bfive
\@bfivefalse

\newif\if@afour
\@afourfalse

\newif\if@kor
\@korfalse

\newif\if@eng
\@engfalse

\RequirePackage{calc}				% for parameter dependent computation of the paper margins



%-- Declaration of options ----------------------------------------------------------------------------------

\DeclareOption{bfive}{%
	\@bfivetrue%
	\typeout{KoreaTech Thesis Class Option: b5 paper mode}%
}
\DeclareOption{afour}{%
	\@afourtrue%
	\typeout{Koreatech Thesis Class Option: a4 paper mode}%
}
\DeclareOption{kor}{%
	\@kortrue%
	\typeout{Koreatech Thesis Class Option: Korean mode}%
}
\DeclareOption{eng}{%
	\@engtrue%
	\typeout{Koreatech Thesis Class Option: English mode}%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax



%-- paper layout --------------------------------------------------------------------------------------------

% units:	mm - millimeter, cm - centimeter
%			in - inch = 25.4 mm
%			pt - approximately 0.013837 inch or 0.35146 mm
%			ex - roughly the height of a lowercase x
%			em - roughly the width of an uppercase M
\if@bfive
	\LoadClass[11pt,openany]{book}
	\RequirePackage[paperwidth=182mm,paperheight=257mm,includeheadfoot]{geometry}		% define paper dimension: B5 paper (182mm * 257mm, 4*6배판)
	% Note: The size of B5 paper according to the ISO standard is 176*250 while according to the JIS standard is 182*257.
	%		And LaTeX accepts the ISO standard whereas most in Korea accept JIS standard unfortunately.
	
	\setlength{\hoffset}{25mm-1in}			% horizontal margins
	\setlength{\evensidemargin}{0mm}
	\setlength{\oddsidemargin}{0mm}
	\setlength{\textwidth}{\paperwidth-25mm-25mm}		% left margin = 25mm, right margin = 25mm
	\setlength{\marginparsep}{5mm}
	\setlength{\marginparwidth}{15mm}
	
	\setlength{\topmargin}{5mm}
	\setlength{\headheight}{5mm}
	\setlength{\headsep}{7mm}
	\setlength{\voffset}{25mm-1in-\topmargin-\headheight-\headsep}
	\setlength{\textheight}{\paperheight-25mm-25mm-15mm}	% top = 25mm = \topmargin+\headheight+\headsep+\voffset, bottom = 25mm, footer = 15mm
	\setlength{\footskip}{15mm}
\else
	\LoadClass[11pt,a4paper,openany]{book}
	\RequirePackage{geometry}
	
	\setlength{\hoffset}{39mm-1in}			% horizontal margins
	\setlength{\evensidemargin}{0mm}
	\setlength{\oddsidemargin}{0mm}
	\setlength{\textwidth}{182mm-25mm-25mm}		% left margin = 25mm, right margin = 25mm, b5 paper width = 182mm: to have the textwidth the same as that of b5 paper.
	\setlength{\marginparsep}{5mm}
	\setlength{\marginparwidth}{15mm}
	
	\setlength{\topmargin}{5mm}
	\setlength{\headheight}{5mm}
	\setlength{\headsep}{7mm}
	\setlength{\voffset}{52.5mm-1in-\topmargin-\headheight-\headsep}
	\setlength{\textheight}{257mm-25mm-25mm-15mm}	% top = 25mm, bottom = 25mm, footer = 15mm
	\setlength{\footskip}{15mm}
\fi



%-- Fonts, paragraph, and math style -------------------------------------------------------------------------

% 한글은 명조, 신명조, 휴먼명조 중 택일, 영문은 times new roman. 줄간격은 180%로 지정.
\RequirePackage{kotex}			% package for Korean
\RequirePackage[T1]{fontenc}	% T1 font encoding - uses 8 bits encoding so as to have many newer fonts available.
\RequirePackage{indentfirst}	% indentation of first paragraph
\RequirePackage[nodisplayskipstretch]{setspace}		% line stretch without display skip stretch
\RequirePackage{enumitem}

\setlength\parindent{11pt}
\setstretch{1.48}



%%-- Chapter and section style -------------------------------------------------------------------------------

\setcounter{secnumdepth}{3}

\def\@makechapterhead#1{%
	{\parindent \z@ \raggedright \normalfont \centering
		\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
		\LARGE\bfseries \thechapter.
		\fi
		\fi
		\interlinepenalty\@M
		\hspace{.5ex}\LARGE \bfseries #1\par\nobreak 
		\vskip 30\p@
}}
\def\@makeschapterhead#1{%
	{\parindent \z@ \raggedright
		\normalfont \centering
		\interlinepenalty\@M
		\LARGE \bfseries  #1\par\nobreak
		\vskip 30\p@
}}

\def\section{\@startsection{section}{1}{\z@}% name, level, indent
	{-3.5ex \@plus -1ex \@minus -.2ex}% beforeskip
	{2.3ex \@plus.2ex}%after skip
	{\normalfont\Large\bfseries}} % style
\def\subsection{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{.5ex \@plus .2ex}%
	{\normalfont\normalsize\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{.1ex \@plus .2ex}%
	{\normalfont\normalsize\bfseries}}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{1ex}}



%-- Formats of toc, lof, lot, figures, tables, etc. ---------------------------------------------------------

\RequirePackage[unicode,pdfpagelabels]{hyperref}	% generate pdf references. recommend not to remove it.
\usepackage[numbered]{bookmark}		% generate pdf bookmarks
\bookmarksetup{depth=3}
\RequirePackage{titletoc}
\RequirePackage[titles]{tocloft}
\RequirePackage[font=bf,format=hang]{caption}
\RequirePackage{footmisc}		% to format footnotes
\RequirePackage{graphicx}
\RequirePackage{lmodern}

%%-- Table of contents
\DeclareRobustCommand*{\tocbox}[1]{%
	\parbox{1.68cm}{#1}%
}
\pdfstringdefDisableCommands{\let\tocbox\@firstofone}
\newcommand{\namebox}[1]{\parbox{3.2cm}{\LARGE\bfseries #1}}

\if@eng
	\def\contentsname{Table of Contents}
	\def\listtablename{List of Tables}
	\def\listfigurename{List of Figures}
\else
	\def\contentsname{\namebox{목\hfill 차}}
	\def\listtablename{\namebox{표\hfill 목\hfill 차}}
	\def\listfigurename{\namebox{그\hfill 림\hfill 목\hfill 차}}
\fi

\renewcommand\cftchapaftersnum{.}	% add a period after chapter/section number in the table of contents.
\renewcommand\cftsecaftersnum{.}
\renewcommand\cftsubsecaftersnum{.}
%\renewcommand\cftsecnumwidth{2.0em}	% separation between section number and section title in the toc.
%\renewcommand\cftsubsecindent{5em}		% indentation of subsection in the toc.

%%-- Lists of figures and tables
\if@eng
	\setlength{\cftfignumwidth}{65pt} 
	\renewcommand{\cftfigpresnum}{[Figure } 
	\renewcommand{\cftfigaftersnum}{]} 
	\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
	\setlength{\cfttabnumwidth}{65pt} 
	\renewcommand{\cfttabpresnum}{<Table } 
	\renewcommand{\cfttabaftersnum}{>} 
	\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
\else
	\setlength{\cftfignumwidth}{55pt} 
	\renewcommand{\cftfigpresnum}{[그림 } 
	\renewcommand{\cftfigaftersnum}{]} 
	\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
	\setlength{\cfttabnumwidth}{55pt} 
	\renewcommand{\cfttabpresnum}{<표 } 
	\renewcommand{\cfttabaftersnum}{>} 
	\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
\fi

%%-- Caption of figures and tables
\if@eng
	\def\figurename{Figure}
	\DeclareCaptionLabelFormat{figurebrackets}{[Figure #2]}
	\captionsetup[figure]{labelformat=figurebrackets,labelsep=space}
	\def\tablename{Table}
	\DeclareCaptionLabelFormat{tablebrackets}{<Table #2>}
	\captionsetup[table]{labelformat=tablebrackets,labelsep=space,singlelinecheck=false,position=above,skip=8pt}
\else
	\def\figurename{그림}
	\DeclareCaptionLabelFormat{figurebrackets}{[그림 #2]}
	\captionsetup[figure]{labelformat=figurebrackets,labelsep=space}
	\def\tablename{표}
	\DeclareCaptionLabelFormat{tablebrackets}{<표 #2>}
	\captionsetup[table]{labelformat=tablebrackets,labelsep=space,singlelinecheck=false,position=above,skip=8pt}
\fi

%%-- footnote
\counterwithout{footnote}{chapter}
\renewcommand{\footnotelayout}{\setstretch{1.2}}
\renewcommand{\thefootnote}{\arabic{footnote})}


%-- Necessary information ------------------------------------------------------------------------------------

\def\author#1{\def\@author{#1}}
\def\authoreng#1{\def\@authoreng{#1}}
\def\title#1{\def\@title{#1}}
\def\subtitle#1{\def\@subtitle{#1}}
\def\titleeng#1{\def\@titleeng{#1}}
\def\keywords#1{\def\@keywords{#1}}
\def\keywordseng#1{\def\@keywordseng{#1}}

\def\degree#1{\def\@degree{#1}}
\def\advisor#1{\def\@advisor{#1}}

\def\degreeyear#1{\def\@degreeyear{#1}}
\def\degreemonth#1{\def\@degreemonth{#1}}

\def\department#1{\def\@department{#1}}
\def\departmenteng#1{\def\@departmenteng{#1}}
\def\major#1{\def\@major{#1}}
\def\majoreng#1{\def\@majoreng{#1}}
\def\field#1{\def\@field{#1}}

\def\numberofcommitteemembers#1{\def\@numberofcommitteemembers{#1}}		% Number of committee members
\numberofcommitteemembers{}				% Set empty committee

\def\spinetitle#1{\def\@spinetitle{#1}}
\def\spineauthor#1{\def\@spineauthor{#1}}
\def\spinedegreeyear#1{\def\@spinedegreeyear{#1}}
\def\spinedegreemonth#1{\def\@spinedegreemonth{#1}}

%-- committee ------
\newcommand\committeemember[2]{%
\expandafter\def\csname @committeemember@#1\endcsname{#2}}
\newcommand\committeemembername[1]{\csname @committeemember@#1\endcsname}



%-- Front cover ---------------------------------------------------------------------------------------------

\def\frontcover{%
	\typeout{making front cover}
	
	\addtolength{\textheight}{15mm}		% increase \textheight by the length of footer for frontmatter.	
	
	\if@eng
		\bfseries\noindent\Large%
		Dissertation for the \@degree~degree	% approximately 14.4pt when the base font size is 11pt.
		
		\vspace{1mm}
		\noindent%
		Approved by Thesis Advisor of ~\@advisor
				
		\vspace{1.5cm}
		{\centering%
			\huge\@title\\				% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
				\mdseries\LARGE\@subtitle	% approximately 17.28pt when the base font size is 11pt.
			\fi
			\vfill
			
			\bfseries
			\LARGE\@degreemonth~\@degreeyear
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE The Graduate School of \\
			\vspace{-.5cm}
			\text{Korea University of Technology \& Education}\\
			\Large\@department\\
			\vspace{-.4cm}
			\@major~Major\\
			\centering\LARGE\@author
			
			\vspace{-14mm}
		}
	\else
		\bfseries\noindent\Large%
		\@degree~학위 논문				% approximately 14.4pt when the base font size is 11pt.
		
		\vspace{1mm}
		\noindent%
		지도교수 \@advisor
				
		\vspace{1.5cm}
		{\centering%
			\huge\@title\\				% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
			\mdseries\LARGE\@subtitle	% approximately 17.28pt when the base font size is 11pt.
			\fi
			\vfill
			
			\bfseries
			\LARGE\@degreeyear 년 \@degreemonth 월
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE 한국기술교육대학교 대학원\\
			\Large\@department~\@major 전공 \\
			\centering\LARGE\@author
			
			\vspace{-14mm}
		}
	\fi
	
	\mdseries
	\normalsize
	% \cleardoublepage
}



%%-- Thesis spine --------------------------------------------------------------------------------------------

\def\thesisspine{%
	\newpage
	\typeout{making the spine of the thesis}
	
	\setlength{\fboxrule}{0pt}		% Comment this if you want to see the boundaries of \fbox.
	
	\if@eng
		\vspace*{-1.25cm}
				
		{\renewcommand{\baselinestretch}{1.0}
			{\centering%
				\rotatebox{270}{
				\fbox{%
				\parbox[c][1cm][c]{11.9cm}{%
					\raggedright
					\bfseries
					\large
					\@spinetitle
				}%
				}
				}
				
				\vspace*{-.17cm}
				
				\fbox{\parbox[c][0.5cm][c]{1cm}{}}
						
				\vspace*{-.05cm}
				
				\fbox{%
					\parbox[c][3.2cm][c]{1cm}{%
						\centering
						\bfseries
						\large
						\@spinedegreeyear\\
						$\cdot$\\
						\@spinedegreemonth
					}%
				}
				
				\vspace*{-.05cm}
							
				\fbox{\parbox[c][0.5cm][c]{1cm}{}}
				
				\vspace*{-.45cm}
				
				\rotatebox{270}{%
				\fbox{%
					\parbox[c][1cm][c]{3.5cm}{%
						\raggedright
						\bfseries
						\large
						\@spineauthor
					}%
				}
				}
				
			}
		}
	\else
		\vspace*{-0.45cm}
		
		{\renewcommand{\baselinestretch}{1.0}
			{\centering%
				\fbox{
					\parbox[c][11.9cm][t]{1cm}{%
						\centering
						\bfseries
						\large
						\@spinetitle
					}
				}
				
				\vspace*{-.06cm}
				
				\fbox{\parbox[c][0.5cm][c]{1cm}{}}
				
				\vspace*{-.05cm}
				
				\fbox{
					\parbox[c][3.2cm][c]{1cm}{%
						\centering
						\bfseries
						\large
						\@spinedegreeyear\\
						$\cdot$\\
						\@spinedegreemonth
					}
				}
				
				\vspace*{-.05cm}
				
				\fbox{\parbox[c][0.5cm][c]{1cm}{}}
				
				\vspace*{-.05cm}
				
				\fbox{
					\parbox[c][3.5cm][t]{1cm}{%
						\centering
						\bfseries
						\large
						\@spineauthor
					}
				}
			
			}
		}
	\fi
	
	\mdseries
	\normalsize
	\cleardoublepage
}


%-- Inside cover --------------------------------------------------------------------------------------------

\def\insidecover{%
	\newpage
	\typeout{making inside cover}
	
	\if@eng
		\bfseries\noindent\Large%
		Dissertation for the \@degree~degree	% approximately 14.4pt when the base font size is 11pt.
		
		\vspace{1mm}
		\noindent%
		Approved by Thesis Advisor of ~\@advisor
		
		
		\vspace{1.5cm}
		{\centering%
			\huge\@title\\				% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
				\mdseries\LARGE\@subtitle	% approximately 17.28pt when the base font size is 11pt.
			\fi
			\vfill
			
			\bfseries
			\LARGE\@degreemonth~\@degreeyear%
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE The Graduate School of \\
			\vspace{-.5cm}
			\text{Korea University of Technology \& Education}\\
			\Large\@department\\
			\vspace{-.4cm}
			\@major~Major\\
			\centering\LARGE\@author
			
			\vspace{1mm}
		}
	\else
		\bfseries\noindent\Large%
		\@degree~학위 논문				% approximately 14.4pt when the base font size is 11pt.
		
		\vspace{1mm}
		\noindent%
		지도교수 \@advisor
		
		
		\vspace{1.5cm}
		{\centering%
			\huge\@title\\				% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
			\mdseries\LARGE\@subtitle	% approximately 17.28pt when the base font size is 11pt.
			\fi
			\vfill
			
			\mdseries\LARGE\@titleeng
			\vfill
			
			\bfseries
			\LARGE\@degreeyear 년 \@degreemonth 월
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE 한국기술교육대학교 대학원\\
			\Large\@department~\@major 전공\\
			\centering\LARGE\@author
			
			\vspace{1mm}
		}
	\fi
	
	\mdseries
	\normalsize
}



%-- Submission statement ------------------------------------------------------------------------------------

\def\submissionstatement{%
	\newpage
	\typeout{making submission statement page}
	
	\if@eng
		\vspace*{1.5cm}
		{\centering%
			\bfseries\huge\@title\\		% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
			\mdseries\LARGE\@subtitle\\	% approximately 17.28pt when the base font size is 11pt.
			\fi
			
			\vfill
			\bfseries
			
			\LARGE This dissertation is hereby submitted for the degree of \@degree\\
			% \vspace{-.3cm}
			
			\vfill
			\LARGE\@degreemonth~\@degreeyear%
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE The Graduate School of \\
			\vspace{-.5cm}
			\text{Korea University of Technology \& Education}\\
			\Large\@department\\
			\vspace{-.4cm}
			\@major~Major\\
			\centering\LARGE\@author
			
			\vspace{1mm}
		}
	\else
		\vspace*{1.5cm}
		{\centering%
			\bfseries\huge\@title\\		% approximately 20.74pt when the base font size is 11pt.
			\ifx \@subtitle \@empty
			\else
			\mdseries\LARGE\@subtitle\\	% approximately 17.28pt when the base font size is 11pt.
			\fi
			\@titleeng
			
			\vfill
			\bfseries
			\LARGE 이 논문을 \@field~\@degree 학위 논문으로 제출합니다.
			
			\vfill
			\LARGE\@degreeyear 년 \@degreemonth 월
			
			\vspace{2cm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE 한국기술교육대학교 대학원\\
			\Large\@department~\@major 전공\\
			\centering\LARGE\@author
			
			\vspace{1mm}
		}
	\fi
	
	\mdseries
	\normalsize
}



%-- Approval papge ------------------------------------------------------------------------------------------

\def\approvalpage{%
	\newpage
	\typeout{making approval page}
	
	\if@eng
		\vspace*{0.3cm}
		\bfseries
		{\renewcommand{\baselinestretch}{1.2}
		\LARGE\noindent\@author's dissertation for the degree of {\@degree} is hereby approved by
		}
		
		{\centering%
			\vfill
			
			\Large		% approximately 14.4pt when the base font size is 11pt.
			$\vbox{
				 \baselineskip = 50pt \tabskip = 10pt \halign{
					\hbox to 3.2cm{\raggedright##}\;& \underline{\hbox to 6cm{\hspace{1.5cm}##\hfil}\quad(Signature)}\cr 
					\shortstack[l]{Committee\\Chair} & \committeemembername{1} \cr 
					\shortstack[l]{Committee\\Member} & \committeemembername{2} \cr 
					\shortstack[l]{Committee\\Member} & \committeemembername{3} \cr 
					\ifnum\@numberofcommitteemembers>3 \shortstack[l]{Committee\\Member} & \committeemembername{4} \cr 
					\ifnum\@numberofcommitteemembers>4 \shortstack[l]{Committee\\Member} & \committeemembername{5} \cr 
					\fi 
					\fi 
				 } }$
			\vfill
			\LARGE\@degreemonth~\@degreeyear%
			
			\vspace{5mm}
			\renewcommand{\baselinestretch}{1.6}
			\LARGE The Graduate School of \\
			\vspace{-.5cm}
			\text{Korea University of Technology \& Education}
			
			\vspace{1cm}
		}
	\else
		\vspace*{0.3cm}
		\bfseries
		\LARGE\indent\@author 의 \\
		\indent\@field~\@degree 학위 논문을 인준함.
		
		{\centering%
			\vfill
			
			\Large		% approximately 14.4pt when the base font size is 11pt.
			$\vbox{
				\baselineskip = 50pt
				\tabskip = 10pt
				\halign{
					##&\underline{\hspace{2.5cm}##\hspace{2.5cm}(인)}\cr
					심\hfill 사\hfill 위\hfill 원\hfill 장	& \cr
					심\hfill 사\hfill 위\hfill 원			& \cr
					심\hfill 사\hfill 위\hfill 원			& \cr
					\ifnum\@numberofcommitteemembers>3
						심\hfill 사\hfill 위\hfill 원			& \cr
						\ifnum\@numberofcommitteemembers>4
							심\hfill 사\hfill 위\hfill 원			& \cr
						\fi
					\fi
				}
			}$
			
			\vfill
			\LARGE\@degreeyear 년 \@degreemonth 월
			
			\vspace{5mm}
			\LARGE 한국기술교육대학교 대학원
			
			\vspace{1cm}
		}
	\fi
	
	\mdseries
	\normalsize
}



%-- Front matter --------------------------------------------------------------------------------------------

\def\makefrontmatter{%
	\hypersetup{pageanchor=false}	% Related to hyperref package. Since the front matter has no page numbers, page anchoring is set to be false.
	
	\pagestyle{empty}		% No headers, no footers, no pagenumberings.
	\frontcover
	\thesisspine
	\insidecover
	\submissionstatement
	\approvalpage
	\addtolength{\textheight}{-15mm}	% Do not remove. It recovers the orginal \textheight.
}



%%-- Acknowledgement in Korean -------------------------------------------------------------------------------

\newenvironment{acknowledgement}{
	\if@eng
		\chapter*{\LARGE\bfseries Acknowledgements}
	\else
		\chapter*{\LARGE\bfseries\namebox{감\hfill 사\hfill 의\hfill 글}}
	\fi
	\thispagestyle{empty}
	\normalsize
}

%%-- Korean Abstract -----------------------------------------------------------------------------------------

\newenvironment{abstractkor} {
	\newpage
	\typeout{making abstractkor}
	% \phantomsection%		% \phantomsection -> anchoring
	\if@eng
		\addcontentsline{toc}{chapter}{Abstract in Korean}
		\noindent{\Large\bfseries Abstract in Korean}
		\vspace{10pt}
	\else
		\addcontentsline{toc}{chapter}{\tocbox{국\hfill 문\hfill 요\hfill 약}}
		\noindent{\Large\bfseries 국문요약}
		\vspace{10pt}
	\fi
	
	\begin{center}
		{\LARGE\bfseries\@title}
	\end{center}
	\vspace{25pt}
	
	\normalsize
}
{
	\vfill
	\noindent\rule{\textwidth}{0.4pt}
	\begin{spacing}{1.1}
		\begin{description}[leftmargin=!,labelwidth=\widthof{\bfseries 주제어:},nosep]
			\item[주제어:]	\@keywords
		\end{description}
	\end{spacing}
	\vspace*{2mm}
	% \cleardoublepage
}



%%-- Bibliography --------------------------------------------------------------------------------------------

\if@eng
	\def\refname{References}
	\def\bibname{References}
\else
	\def\refname{\namebox{참\hfill 고\hfill 문\hfill 헌}}
	\def\bibname{\namebox{참\hfill 고\hfill 문\hfill 헌}}
\fi



%%-- Abstract in English -------------------------------------------------------------------------------------

\newenvironment{abstracteng} {
	\cleardoublepage
	\phantomsection%		% \phantomsection -> anchoring
	\addcontentsline{toc}{chapter}{Abstract}
	\noindent{\Large\bfseries ABSTRACT}
	\vspace{10pt}
	
	\begin{center}
		\if@eng
			{\LARGE\bfseries\@title}
		\else
			{\LARGE\bfseries\@titleeng}
		\fi
	\end{center}
	\normalsize
	\vspace{-10pt}
	\begin{flushright}
		\begin{spacing}{1.2}
			\if@eng
				\@author\\
				\@department\\
				\@major~Major\\
			\else
				\@authoreng\\
				\@departmenteng\\
				\@majoreng~Major\\
			\fi
			The Graduate School\\
			\text{Korea University of Technology \& Education}
		\end{spacing}
	\end{flushright}
	\vspace{10pt}
	
	\normalsize
}
{
	\vfill
	\noindent\rule{\textwidth}{0.4pt}
	\begin{spacing}{1.1}
		\begin{description}[leftmargin=!,labelwidth=\widthof{\bfseries Keywords:},nosep]
			\item[Keywords:]	\@keywordseng
		\end{description}
	\end{spacing}
	\vspace*{2mm}
}



%%-- Appendix customized -------------------------------------------------------------------------------------

\RequirePackage{titlesec}

\newenvironment{appendixformatted} {
	\cleardoublepage
	\phantomsection
	\if@eng
		\addcontentsline{toc}{chapter}{Appendix}
	\else
		\addcontentsline{toc}{chapter}{\tocbox{부\hfill 록}}
	\fi
	\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
	\setcounter{chapter}{0}
	\setcounter{section}{0}
	\setcounter{figure}{0} 
	\setcounter{table}{0}   
	\setcounter{equation}{0}   
	\renewcommand{\thefigure}{A-\arabic{figure}}
	\renewcommand{\thetable}{A-\arabic{table}}
	\renewcommand\thesection{\arabic{section}}
	\if@eng
		\titleformat{\section}{\Large\bfseries}{<Appendix \thesection>}{1ex}{}
		\titleformat{\subsection}{\normalsize\bfseries}{Appendix \thesubsection.}{1ex}{}
		\titleformat{\subsubsection}{\normalsize\bfseries}{Appendix \thesubsubsection.}{1ex}{}
	\else
		\titleformat{\section}{\Large\bfseries}{<부록 \thesection>}{1ex}{}
		\titleformat{\subsection}{\normalsize\bfseries}{부록 \thesubsection.}{1ex}{}
		\titleformat{\subsubsection}{\normalsize\bfseries}{부록 \thesubsubsection.}{1ex}{}
	\fi
	\renewcommand{\theequation}{A.\arabic{equation}}
	\addtocontents{lof}{\protect\addvspace{10\p@}}
	\addtocontents{lot}{\protect\addvspace{10\p@}}
	
	\if@eng
		\chapter*{Appendix}
	\else
		\chapter*{\namebox{부\hfill 록}}
	\fi
}





