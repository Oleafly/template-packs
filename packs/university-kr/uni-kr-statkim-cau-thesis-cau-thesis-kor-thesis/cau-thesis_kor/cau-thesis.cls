%%=================================================================
%%
%% cau-thesis.cls (Mar 02, 2001)
%%
%% Document class for CAU thesis with HLaTeX-0.98
%%
%% Modified By Choi, Jae-Hoon (goopy74@yahoo.com)
%%
%% Note 1: Required Packages: HLaTeX0.98 and setspace.
%%      2: The class file follws the guide distributed by
%%         the office of the academic affairs in CAU.
%%      3: The class file is based on kaist.cls 96/01/13 version
%%         made by Jae Choon Cha.
%%      4: The class file is based on kaist-thesis.cls 98/11/23
%%         version made by Jin-Hwan, Cho.
%%
%%================================================================
%%
%% cau-thesis.cls (Dec, 2007)
%% 
%% Modified by Nam, Kee-Hwan (khnam@phys.cau.ac.kr)
%%
%%================================================================
%%
%% cau-thesis.cls (Sep, 2020)
%% 
%% Modified by Kim, Hyunsung (hyunsung1021@gmail.com)
%%
%%================================================================
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cau-thesis}[2001/03/02 Document class for CAU thesis with HLaTeX-0.98]
%%
\RequirePackage{kotex}
%%
\ExecuteOptions{12pt,oneside,b5paper}
\DeclareOption{korean}{\gdef\@korean{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
%%
\ProcessOptions
%%
\LoadClass{report}
%%
% \AtBeginDocument{\makecovertitle}
%%
% \topmargin=0mm
% %\advance\topmargin 19mm        % comment out if want exact top margin
% \oddsidemargin=-2mm
% %\advance\oddsidemargin 10mm    % comment out if want exact left margin
% \evensidemargin=\oddsidemargin
% \textwidth=190mm
% %\advance\textwidth by-60mm
% %\textheight=262mm
% \textheight=260mm
% \advance\textheight by30mm
% \footskip=10mm
% \headheight=10mm
% \headsep=0mm
% \overfullrule=0pt

% % 위, 아래 여백 2cm, 좌, 우 여백 2.5cm, 머리말, 꼬리말 1cm
\RequirePackage[b5paper, top=20mm, bottom=30mm, left=25mm, right=25mm, 
               % showframe,   % 용지 및 frame 경계선 그어줌(용지 간격 확인할 때 사용)
                % footskip=10mm, headsep=10mm
                marginparwidth=0mm
                ]{geometry}
                
%%
\def\bibname{References}
\def\summaryname{요 약 문}
\def\ackname{감 사 의 글}
\def\vitaname{이 력 서}
\def\esummaryname{Summary in Korean}
\def\eackname{Acknowledgement in Korean}
\def\evitaname{Curriculum Vitae in Korean}
%%
\def\code#1{\def\@code{#1}}
\def\gcount#1{\def\@gcount{#1}}
\def\edegree#1{\def\@edegree{#1}}
\def\edept#1{\def\@edept{#1}}
\def\kdept#1{\def\@kdept{#1}}
\def\emajor#1{\def\@emajor{#1}}
\def\kmajor#1{\def\@kmajor{#1}}
\def\etitle#1{\def\@etitle{#1}}
\def\ktitle#1{\def\@ktitle{#1}}
\def\advisor#1{\def\@advisor{#1}}
\def\coadvisor#1{\def\@coadvisor{#1}}
\def\ename#1{\def\@ename{#1}}
\def\kname#1{\def\@kname{#1}}
\def\knamenospace#1{\def\@knamenospace{#1}}
\def\cname#1{\def\@cname{#1}}
\def\studentid#1{\def\@studentid{#1}}
\def\coveryear#1{\def\@coveryear{#1}}
\def\advisorsigndate#1#2#3{\def\@advisorsigndate{#1. #2. #3.}}
\def\refereesigndate#1#2#3{\def\@refereesigndate{#1년 #2월 #3일}}
\def\refereeA#1{\def\@refereeA{#1}}
\def\refereeB#1{\def\@refereeB{#1}}
\def\refereeC#1{\def\@refereeC{#1}}
\def\refereeD#1{\def\@refereeD{#1}}
\def\refereeE#1{\def\@refereeE{#1}}
\def\npages#1{\def\@npages{#1}}
\def\@npages{\pageref{paperlastpagelabel}}
\def\D@char{D}
\def\split@code#1#2\eop{\def\@md{#1}\def\@dept{#2}}
%%
\def\insert@hss#1#2{#1#2\hss}
\def\maketitlebreakwork{\def\titlebreak{\\\ignorespaces}}
\def\maketitlebreaknotwork{\def\titlebreak{\ }}
\maketitlebreaknotwork
\pagestyle{plain}
%%
\def\makecovertitle{%
%   \ifx\@korean\@@@@undefined@@@@\else
%     \def\contentsname{목 차}
%     \def\listfigurename{그 림 목 차}
%     \def\listtablename{표 목 차}
%     \def\refname{참 고 문 헌}
%     \def\bibname{참 고 문 헌}
%     \def\figurename{그림}
%     \def\tablename{표}
%   \fi
	\expandafter\split@code\@code\eop
	\ifx\D@char\@md\def\@kdegree{박사}\else\def\@kdegree{석사}\fi
	
	% 앞표지 및 속표지 (Front Cover and Inner cover)
	\thispagestyle{empty}
    \vspace*{0cm}  % 1cm 공백 만듬
	\begin{flushleft}
		\maketitlebreakwork\leavevmode%
		\makebox[23mm][s]{\fontsize{14}{34pt}\selectfont\expandafter{제 }\@gcount{ 회}}\hspace{5mm}
		\makebox[33mm][s]{\fontsize{14}{34pt}\selectfont\expandafter\@kdegree{학위논문}}\\[3mm]
		\makebox[23mm][s]{\fontsize{14}{34pt}\selectfont\expandafter{지 도 교 수}}\hspace{5mm}
		\makebox[27mm][s]{\fontsize{14}{34pt}\selectfont\expandafter\@advisor}\\
	\end{flushleft}
	\vspace{5cm}
	\begin{center}
    	% minipage로 별개의 box공간 만들어서 줄수가 넘어가더라도 vspace로 조절할 필요 없음
    	\begin{minipage}[c][1cm][c]{\linewidth}
    	    \begin{spacing}{1.3}
        	    \begin{center}
        	        \maketitlebreakwork
        	        \fontsize{21}{35pt}\selectfont\@etitle\\[5mm]
        	        \fontsize{17}{30pt}\selectfont\@ktitle\\
        	    \end{center}
    	    \end{spacing}
    	\end{minipage}
	\end{center}
	\vspace{5.9cm}
	\begin{spacing}{1.3}
		\begin{center}
			%% 종이 밑에서부터 학위수여 연도까지의 거리가 3cm이 되도록 위의 vspace 간격을 조절한다.
			\fontsize{18}{30pt}\selectfont중앙대학교\hspace{3mm} 대학원\\
			\fontsize{14}{30pt}\selectfont
			\@kdept{ }\@kmajor{ }전공\\
			\makebox[3.5cm][s]{\@kname}\\
			\@coveryear
			\maketitlebreaknotwork
		\end{center}
	\end{spacing}

	
	% 제출서(국,영문 제목 기재)
	\newpage\thispagestyle{empty}
    \vspace*{5cm}   % 6cm 공백
    \begin{center}
    	% minipage로 별개의 box공간 만들어서 줄수가 넘어가더라도 vspace로 조절할 필요 없음
    	\begin{minipage}[c][1cm][c]{\linewidth}
    	    \begin{spacing}{1.3}
        	    \begin{center}
        	        \maketitlebreakwork
        	        \fontsize{21}{35pt}\selectfont\@etitle\\[5mm]
        	        \fontsize{17}{30pt}\selectfont\@ktitle\\
        	    \end{center}
    	    \end{spacing}
    	\end{minipage}
	\end{center}
	\vspace{4cm}
	\begin{spacing}{1.3}
		\begin{center}
			%% 종이 밑에서부터 학위수여 연도까지의 거리가 3cm이 되도록 위의 [3cm]을 조절한다.
			\fontsize{14}{30pt}\selectfont이 논문을 \@kdegree학위 논문으로 제출함\\[0.5cm]
			\@coveryear\\[2cm]
			\fontsize{18}{30pt}\selectfont중앙대학교\hspace{3mm} 대학원\\
			\fontsize{14}{30pt}\selectfont
			\@kdept{ }\@kmajor{ }전공\\
			\makebox[3.5cm][s]{\@kname}
			\maketitlebreaknotwork
		\end{center}
	\end{spacing}
    		

	% 학위논문 심사완료 검인(실인으로 날인)
	\newpage\thispagestyle{empty}
   	\vspace*{0cm}   % 2cm 공백
	\begin{spacing}{1.3}
		\begin{center}
		    \fontsize{21}{35pt}\selectfont\@kname의 \@kdegree 학위 논문으로 인정함
		\end{center}
		\vspace{6cm}
		\begin{center}    
			\begin{minipage}[c][1cm][c]{\linewidth}
    			\begin{center}
    			    \fontsize{14}{30pt}\selectfont
        			\makebox[3cm][s]{심 사 위 원 장}\hspace{5mm}\underline{\hspace{40mm}}(인)\\
        			\makebox[3cm][s]{심 사 위 원}\hspace{5mm}\underline{\hspace{40mm}}(인)\\
        			\makebox[3cm][s]{심 사 위 원}\hspace{5mm}\underline{\hspace{40mm}}(인)\\
        			\ifx \D@char\@md
        			\makebox[3cm][s]{심 사 위 원}\hspace{5mm}\underline{\hspace{40mm}}(인)\\
        			\makebox[3cm][s]{심 사 위 원}\hspace{5mm}\underline{\hspace{40mm}}(인)\\
        			\fi
        		\end{center}
			\end{minipage}
		\end{center}
        \vspace{7.4cm}
		\begin{center}
			\fontsize{18}{30pt}\selectfont중앙대학교\hspace{3mm} 대학원\\
			\fontsize{14}{30pt}\selectfont
			\@coveryear
		\end{center}
	\end{spacing}

	\clearpage\newpage
} % end of \make@covertitle

\def\@chapapp{}
\def\@makechapterhead#1{%
	\vspace*{5mm}%
	{\parindent=0pt
		\begin{center}
			\ifnum\c@secnumdepth>\m@ne\LARGE\bfseries\@chapapp{ }\thechapter{. }\fi
			\LARGE\bfseries#1\par\nobreak
			\vspace{5mm}
		\end{center}%
	}%
}
\def\@makeschapterhead#1{%
	\vspace*{5mm}%
	{\parindent=0pt
		\begin{center}
			\LARGE\bfseries#1\par\nobreak
			\vspace{5mm}
		\end{center}%
	}%
}
\def\section{\@startsection {section}{1}{\z@}%
	{3.5ex plus 1ex minus .2ex}%
	{2.3ex plus .2ex}%
	{\normalfont\Large\bfseries}}
\def\subsection{\@startsection{subsection}{2}{\z@}%
	{3.25ex plus 1ex minus .2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\large\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{3.25ex plus 1ex minus .2ex}%
	{1em}%
	{\normalfont\bfseries}}

% 백색 별지

% 표 및 그림 목록(Tables and Figures)
\def\makelist{%
	%  {\let\thispagestyle\@gobble \tableofcontents}%
% 	\pagenumbering{roman}\setcounter{page}{1}
    \listoftables
    \addcontentsline{toc}{chapter}{List of Tables}
	\listoffigures
	\addcontentsline{toc}{chapter}{List of Figures}
	\newpage
}

% 목차(Contents)
\def\makecontents{%
	%  {\let\thispagestyle\@gobble \tableofcontents}%
	\pagenumbering{roman}\setcounter{page}{1}
    \tableofcontents
	\newpage
}

\def\appendix{%
	\par\setcounter{chapter}{0}\setcounter{section}{0}
	\ifx\@korean\@@@@undefined@@@@\def\@chapapp{Appendix}\else\def\@chapapp{부 록}\fi
	\def\thechapter{\Alph{chapter}}%
}

% 국문요약(Summary, 본문이 외국어인 경우만 작성)
\def\summary{%
	\chapter*{\summaryname}
	\ifx\@korean\@@@@undefined@@@@
	    \addcontentsline{toc}{chapter}{\esummaryname}
	\else
	    \addcontentsline{toc}{chapter}{\summaryname}
	\fi
	\begin{center}
		\fontsize{14}{21pt}\selectfont{\maketitlebreakwork\bfseries\@ktitle\maketitlebreaknotwork}
	\end{center}
	\vspace*{5mm}%
}

% 참고문헌(References)
\def\thebibliography#1{%
	\chapter*{\bibname\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
	\addcontentsline{toc}{chapter}{\bibname}%
	\list{\@biblabel{\@arabic\c@enumiv}}%
	{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
		\itemsep\medskipamount
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty
		\renewcommand\theenumiv{\@arabic\c@enumiv}}%
	\sloppy
	\clubpenalty4000
	\@clubpenalty \clubpenalty
	\widowpenalty4000%
	\sfcode`\.\@m%
}

% 논문초록(Abstract, 영문으로 작성)
\def\abstract{%
	\begin{center}
		\section*{Abstract}
	\end{center}
% 	\pagenumbering{roman}\setcounter{page}{1}
	\addcontentsline{toc}{chapter}{Abstract}
% 	\vspace*{10mm}
%	\begin{center}
%		\fontsize{17}{25pt}\selectfont\bfseries Abstract
%	\end{center}
    % 	\vspace{10mm}
    % 	\advance\linewidth by-30mm
    \begin{spacing}{1.5}
    	\begin{center}
    		\fontsize{14}{25pt}\selectfont\bfseries\@etitle\\
    	\end{center}
	\end{spacing}
% 	\vspace{\baselineskip}   % 한 줄 띄기
	\begin{flushright}
		\parbox[t]{\linewidth}{\sffamily\fontsize{10}{12pt}\selectfont
			\begin{flushright}
				\@ename\\
			    Major in \@emajor\\
				Department of \@edept\\
				The Graduate School of Chung-Ang University
			\end{flushright}
		}\\
	\end{flushright}
	\vspace{\baselineskip}   % 한 줄 띄기
	\hspace{\parindent}      % indent
}
\def\endabstract{\newpage}

% 국문초록(Abstract, 국문으로 작성)
\def\kabstract{%
	\begin{center}
		\section*{국 문 초 록}
	\end{center}
	%\pagenumbering{roman}\setcounter{page}{4}
	\addcontentsline{toc}{chapter}{국 문 초 록}
% 	\vspace*{10mm}
%	\begin{center}
%		\fontsize{17}{25pt}\selectfont\bfseries 국 문 초 록
%	\end{center}
% 	\vspace{10mm}
% 	\advance\linewidth by-30mm]
    \begin{spacing}{1.5}
    	\begin{center}
    		\fontsize{14}{25pt}\selectfont\bfseries\@ktitle\\
    	\end{center}
    \end{spacing}
% 	\vspace{\baselineskip}   % 한 줄 띄기
	\begin{flushright}
		\parbox[t]{\linewidth}{\fontsize{10}{12pt}\selectfont
			\begin{flushright}
				\@kname\\
				\@kdept{ } \@kmajor{ } 전공\\
				중앙대학교 대학원
			\end{flushright}
		}\\
	\end{flushright}
	\vspace{\baselineskip}   % 한 줄 띄기
	\hspace{\parindent}      % indent
}
\def\endkabstract{\newpage}

% 감사의말(Acknowledgement)
\def\acknowledgement{%
	\label{paperlastpagelabel}
	\chapter*{\ackname}
	\thispagestyle{empty}\pagestyle{empty}
	%  \ifx\@korean\@@@@undefined@@@@
	%  \addtocontents{toc}{\protect\contentsline{chapter}{\eackname}{}}
	%  \addcontentsline{toc}{chapter}{\eackname}%
	%  \else
	%  \addtocontents{toc}{\protect\contentsline{chapter}{\ackname}{}}
	%  \addcontentsline{toc}{chapter}{\ackname}%
	%  \fi
}

% keyword footnote 설정
\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width \textwidth height 1pt
  \kern 2pt
}
\makeatletter
\renewcommand\@makefntext[1]{\leftskip=0em\hskip 0em\@makefnmark#1}
% \renewcommand\@makefntext[1]{\leftskip=2em\hskip-2em\@makefnmark#1}
\makeatother

% abstract의 keyword
\def \makekeyword#1{
    \let\thefootnote\relax\footnote{#1}
}

% 백색 별지

% 뒤표지(Back Cover)

\endinput

