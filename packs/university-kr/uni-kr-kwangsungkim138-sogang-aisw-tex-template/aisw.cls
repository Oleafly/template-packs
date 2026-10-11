\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{aisw}
              [Graduate School of AI\textbullet SW, Sogang University document class based on SNU EE]

% [korean] 옵션: 국문 논문 / [english]: 영문 논문
\newif\if@Korean
\DeclareOption{korean}{\@Koreantrue}
\DeclareOption{english}{\@Koreanfalse}


\DeclareOption{leqno}{\PassOptionsToClass{leqno}{report}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ProcessOptions

% base class: report class 사용
% report class에 대한 설명은 latex 관련 book에서 참고가능
\LoadClass[11pt,a4paper,onecolumn,oneside]{report}
\usepackage{geometry}
\geometry{
  a4paper,
  top=53mm,
  bottom=53mm,
  left=35mm,
  right=35mm,
  headheight=15mm,
  headsep=0mm,
  footskip=32mm
}
\usepackage{subcaption}
\usepackage{url}
\usepackage{epsfig}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{ifthen}
\usepackage{times}
\usepackage{chngpage}
\usepackage{indentfirst}
\setlength{\parindent}{2em}
\usepackage{multirow}
\usepackage{booktabs}% http://ctan.org/pkg/booktabs
\usepackage{hyperref}
\usepackage{enumitem} 
\if@Korean
	\usepackage{tocloft}
	\usepackage[hangul]{kotex}
\else
	\usepackage{kotex}
\fi


% 페이지 여백은 위 \geometry{...} 로 설정합니다.


\hypersetup{
    colorlinks=true,
    linkcolor=black,
    filecolor=magenta,      
    citecolor=black,
    urlcolor=cyan,
}

\newcommand{\tabitem}{~~\llap{\textbullet}~~}
% \title 명령어 재정의
% 한국어·영어 제목을 모두 넣습니다.
% 예: \title[korean]{한국어 제목}
%     \title[english]{English Title}

% 국문 논문용 번호·목차 표기
\if@Korean
	% 장·절 번호 (기본: 로마숫자 장 + 알파벳 절).
	% kotex의 \kscntformat 대신 \renewcommand로 지정합니다.
	\renewcommand\thechapter{\Roman{chapter}}
	\renewcommand{\cftchapnumwidth}{3.5em}
	\renewcommand\thesection{\Alph{section}}
	\renewcommand\thesubsection{(\arabic{subsection})}
	\renewcommand\thesubsubsection{(\alph{subsubsection})}

	% 표·그림 목차 접두어 (tocloft)
	\renewcommand\cftfigpresnum{그림 }
	\addtolength\cftfignumwidth{2.3em}
	\renewcommand\cfttabpresnum{표 }
	\addtolength\cfttabnumwidth{2.3em}

	% 그림·표·수식 번호는 아라비아 장 번호를 사용합니다 (예: 1.1).
	\renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
	\renewcommand\thetable{\arabic{chapter}.\arabic{table}}
	\renewcommand\theequation{\arabic{chapter}.\arabic{equation}}

	\renewcommand{\abstractname}{초록}

\fi

\renewcommand{\title}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorTitle}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngTitle}{#2}}{}%
}
\@onlypreamble{\title}

% 저자 정보
% 한국어(띄어쓰기)·영어·한국어(붙여쓰기, nospace)를 모두 넣습니다.
% 예: \author[korean]{김 석 사}
%     \author[english]{Seoksa Kim}
%     \author[nospace]{김석사}
\renewcommand{\author}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AuthorNS}{#2}}{}%
    }
\@onlypreamble{\author}

% 지도교수 정보
\newcommand{\adviser}[1]{\newcommand{\@adviser}{#1}}
\@onlypreamble{\adviser}

% 전공 정보
\newcommand{\major}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorMajor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngMajor}{#2}}{}%
}
\@onlypreamble{\major}

% 심사위원 정보
\newcommand{\committeememberA}[1]{\newcommand{\@committeememberA}{#1}}
\@onlypreamble{\committeememberA}
\newcommand{\committeememberB}[1]{\newcommand{\@committeememberB}{#1}}
\@onlypreamble{\committeememberB}
\newcommand{\committeememberC}[1]{\newcommand{\@committeememberC}{#1}}
\@onlypreamble{\committeememberC}

% 논문 제출일
\newcommand{\submissiondeadline}[1]{%
    \newcommand{\@SubmissionYear}{#1}
}
\@onlypreamble{\submissiondeadline}

% 논문 심사일
\newcommand{\examinationdate}[1]{%
    \newcommand{\@ExamYear}{#1}
}
\@onlypreamble{\examinationdate}

% 졸업년월 (표지용). 국문·영문 모두 넣습니다.
% 예: \gradyear[korean]{2026년 6월}
%     \gradyear[english]{June 2026}
% (1학기 졸업 → 6월, 2학기 졸업 → 12월)
\newcommand{\gradyear}[2][english]{%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@GradYearEng}{#2}}{}%
    \ifthenelse{\equal{#1}{korean} }{\newcommand{\@GradYearKor}{#2}}{}%
}
\@onlypreamble{\gradyear}


\AtBeginDocument{%
    \makecover%
    \makeinnercover%
    \makeapproval%
    }
\AtEndDocument{}

% 외표지 작성
\newcommand{\makecover}{%
            \thispagestyle{empty}
            %\changetext{}{10mm}{-5mm}{}{}
%           \noindent
%           \begin{center}
\begin{center}
                \vspace*{1cm}
                \fontsize {22pt}{26pt}
                \selectfont
				\if@Korean
					{\bf \@KorTitle} \\
				\else
					{\bf \@EngTitle} \\
				\fi
                \vspace*{1cm}
                \fontsize {16pt}{19pt}
                \selectfont
				\if@Korean
					{\bf \@EngTitle} \\
				\else
					{\bf \@KorTitle} \\
				\fi

				\if@Korean\else
					\vspace*{2cm}
					\Large
					BY\\
					\vspace*{1cm}
					\@EngAuthor \\
				\fi
            \vfill
            \end{center}
                \begin{minipage}[t][60mm][b]{\textwidth}
                    \begin{center}
                    \Large
					\if@Korean
						\@GradYearKor \\
					\else
						\@GradYearEng \\
					\fi
                    \addvspace{4cm}
                    \Large
					\if@Korean
						{
							\fontsize {16pt}{24pt}
							\selectfont
							서강대학교 AI \textbullet\ SW 대학원\\
						}
						\vspace{2mm}
						{
							\fontsize {14pt}{16pt}
							\selectfont
							\@KorMajor \\
						}
						{
							\fontsize {16pt}{24pt}
							\selectfont
							\@KorAuthor \\
						}
					\else
						\@EngMajor\\
						GRADUATE SCHOOL OF AI \textbullet SW\\
						SOGANG UNIVERSITY\\
					\fi
                    \end{center}
                \end{minipage}
            \newpage
            }

%내표지 작성
% The same as "outer" cover.
\newcommand{\makeinnercover}{%
	\makecover
}

%인준지 작성
\newcommand{\makeapproval}{%
            \thispagestyle{empty}
\vspace*{1cm}
            %\changetext{10mm}{-10mm}{5mm}{}{}
            \noindent
            \begin{center}
                \fontsize {22pt}{22pt}
                \selectfont
				\if@Korean
					{\bf \@KorTitle} \\
				\else
					{\bf \@EngTitle} \\
				\fi
                \vspace{1cm}
                \fontsize {16pt}{16pt}
                \selectfont
				\if@Korean
					{\bf \@EngTitle} \\
				\else
					{\bf \@KorTitle} \\
				\fi
                \vspace{1cm}
\vspace{1cm}
                \Large
                지도교수 \@adviser\\
                \vspace{2mm}
\vspace{2cm}
                \fontsize {16pt}{16pt}
                \selectfont
                이 논문을 석사학위 논문으로 제출함\\
                \vspace{5mm}

                \begin{minipage}[t][60mm][b]{\textwidth}
                    \begin{center}
                    \Large
					\if@Korean
%						\@GradYearKor \\
\@SubmissionYear\\
					\else
%						\@GradYearEng \\
\@SubmissionYear\\
					\fi
%                     \addvspace{4cm}
\addvspace{1cm}
                    \Large
					\if@Korean
						{
							\fontsize {16pt}{24pt}
							\selectfont
							서강대학교 AI \textbullet\ SW 대학원\\
						}
						\vspace{2mm}
						{
							\fontsize {14pt}{16pt}
							\selectfont
							\@KorMajor \\
						}
						{
							\fontsize {16pt}{24pt}
							\selectfont
							\@KorAuthor \\
						}
					\else
						\@EngMajor\\
						GRADUATE SCHOOL OF AI \textbullet SW\\
						SOGANG UNIVERSITY\\
					\fi
                    \end{center}
                \end{minipage}

{
\newpage
\thispagestyle{empty}
\vspace*{1cm}
\fontsize{22pt}{22pt}
\selectfont
{\bf 논문 인준서}\\
\vspace{2.5cm}
}

                \vspace{1cm}
                \fontsize{16pt}{16pt}
                \selectfont
                \@AuthorNS의 석사학위 논문을 인준함\\
            \vspace{5mm}
\vspace{3cm}
                \Large
%             \@GradYearKor\\
                \@ExamYear\\
                 \vfill
            \end{center}
            \begin{minipage}[t][20mm][b]{\textwidth}
                \begin{center}
                \Large
% 심사위원 명단을 넣을 때, (1) 자간 필히 준수, (2) 한글 1자 타이핑 후에는 스페이스바로 공백을 입력해야 글자가 깨지지 않음
                    주~~심:~~\underline{~~~~~~~~~~~~~~\@committeememberA~~~~~~~~~~~~~~~~~(인)~}\\
\vspace{1cm}
                    부~~심:~~\underline{~~~~~~~~~~~~~~\@committeememberB~~~~~~~~~~~~~~~~~(인)~}\\
\vspace{1cm}
                    부~~심:~~\underline{~~~~~~~~~~~~~~\@committeememberC~~~~~~~~~~~~~~~~~(인)~}\\
                \end{center}
            \end{minipage}
            \newpage
            %\changetext{-15mm}{}{}{}{}
            }

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\fontsize{13pt}{16pt}\selectfont\bfseries}}
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\thispagestyle{plain}
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{\@chapapp\space\thechapter.}%
		\if@Korean
			\addcontentsline{toc}{chapter}{\numberline{제~\thechapter~장} #1}
		\else
			\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading%
	\fi
}
\def\@makechapterhead#1{%
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\parindent\z@
	 \fontsize{16pt}{20pt}
	 \selectfont
	 \bfseries
	 \if@Korean
	 	{
			\centering
			\fontsize{16pt}{20pt}
			\selectfont
			제~\thechapter~장~#1
			\par
		}
	 \else
		{Chapter \thechapter \hspace{1ex}
		\vskip 40\p@
		\fontsize{16pt}{20pt}
		\selectfont
		} #1\par
	\fi
	}
	\vskip 40\p@
}
\def\@schapter#1{%
	\if@twocolumn
		\@topnewpage[\@makeschapterhead{#1}]%
	\else
		\@makeschapterhead{#1}%
		\@afterheading
	\fi}
\def\@makeschapterhead#1{
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\centering \parindent\z@
	\fontsize{22pt}{26pt}
	\selectfont
	\bfseries #1\par}
	\vskip 40\p@
}

%%
%% 목차
%%
\newcommand{\makelists}{%
	\if@Korean
		\tableofcontents
		%\thispagestyle{empty}
		\clearpage
		\listoftables
		%\thispagestyle{empty}
		\clearpage
		\listoffigures
		%\thispagestyle{empty}
		\clearpage
	\else
		\tableofcontents
		\listoftables
		\listoffigures
	\fi
}

%% Abstract
\newcounter{pagemarker}
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}}
\renewenvironment{abstract}{%
    %\pagenumbering{roman}
    \pagestyle{plain}%
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }
    \newlength{\@thesisinfowidth}
    \setlength{\@thesisinfowidth}{\textwidth}
    \addtolength{\@thesisinfowidth}{-20mm}
    %\noindent
    \begin{center}
    \fontsize {22pt}{22pt}
    \selectfont
    \textbf{\abstractname} \\
    \end{center}
    \vspace{20\p@}
    \addcontentsline{toc}{chapter}{\abstractname}
}{  \setcounter{pagemarker}{\value{page}}
    \addtocounter{pagemarker}{1}
    \newpage \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}

% Typesetting for toc, tot, tof
\if@Korean
	% TOC
    \setlength{\cftbeforetoctitleskip}{0pt}
	\renewcommand{\cftaftertoctitle}{\hfill}
	\renewcommand{\cfttoctitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOF
    \setlength{\cftbeforeloftitleskip}{0pt}
	\renewcommand{\cftafterloftitle}{\hfill}
	\renewcommand{\cftloftitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOT
    \setlength{\cftbeforelottitleskip}{0pt}
	\renewcommand{\cftafterlottitle}{\hfill}
	\renewcommand{\cftlottitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
\fi

\if@Korean\else
\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\contentsname}
    \@starttoc{toc}%
%    \if@restonecol\twocolumn\fi
%    \newpage \setcounter{pagemarker}{\value{page}}
%    \pagenumbering{arabic}
}
\fi

%%
%% \listoftables 재정의
%%
\if@Korean\else
\renewcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listtablename}
    \@starttoc{lot}%
%    \if@restonecol\twocolumn\fi
%    \newpage \setcounter{pagemarker}{\value{page}}
%    \pagenumbering{arabic}
}
\fi

%%
%% \listoffigures 재정의
%%
\if@Korean\else
\renewcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listfigurename}
    \@starttoc{lof}%
%    \if@restonecol\twocolumn\fi
%    \newpage \setcounter{pagemarker}{\value{page}}
%    \pagenumbering{arabic}
}
\fi

%%
%% 국문초록
%%
\newenvironment{summary}{%
	\if@Korean
		\chapter*{ABSTRACT}
		\addcontentsline{toc}{chapter}{ABSTRACT}
	\else
		\chapter*{국문 초록}
		\addcontentsline{toc}{chapter}{Abstract (In Korean)}
	\fi
    %\setlength{\parindent}{0pt}
    \indent
}

\newcommand{\acknowledgement}{%
    \pagenumbering{roman}
		\setcounter{page}{1}
    \vspace{-1cm}
	\if@Korean
		\chapter*{감사의 뜻}
		\addcontentsline{toc}{chapter}{감사의 뜻}
	\else
		\chapter*{ACKNOWLEDGEMENT}
		\addcontentsline{toc}{chapter}{Acknowledgement}
	\fi
    \indent
}

%----------------------------------------------------------------------
% 참고문헌 (AI·SW대학원 학위논문작성지침 2025.05.19, Ⅲ.다)
%
% LaTeX에서 \bibliography{...} + BibTeX을 쓰면 항목 서식은 .bst에 정의됩니다.
% (.cls는 여백·표지 등 문서 레이아웃, .bst는 참고문헌 각 항목의 표기 규칙 정의)
%----------------------------------------------------------------------
\newcommand{\aiswbibstyle}{aisw}
\let\aisw@save@bibliography\bibliography
\renewcommand{\bibliography}[1]{%
  \bibliographystyle{\aiswbibstyle}%
  \aisw@save@bibliography{#1}%
}

