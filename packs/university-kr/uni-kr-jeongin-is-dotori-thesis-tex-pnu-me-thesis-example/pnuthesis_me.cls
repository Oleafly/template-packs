%%
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pnuthesis_me}[2025/09/11 PNU mechanical systems design document class]
% edited version of [2021/09/05 PNU PHYS document class]
% https://github.com/Isaac-Kwon/ThesisLaTeXPNU/tree/master
% \documentclass에 대한 옵션 필드 설정
% Usage: \documentclass[degree]{class_file_name}
% degree는 두 가지 선택가능 master, doctor
\newif\if@Doctor
\DeclareOption{doctor} {\@Doctortrue}
\DeclareOption{master} {\@Doctorfalse}

% korean... 설정 된 경우 국문 논문임.
\newif\if@Korean
\DeclareOption{korean} {\@Koreantrue}
\DeclareOption{english} {\@Koreanfalse}

\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor}
\ProcessOptions

% base class: report class 사용
% report class에 대한 설명은 latex 관련 book에서 참고가능
\LoadClass[11pt,a4paper,onecolumn,oneside]{report}
\RequirePackage[
  a4paper,
  left=30mm,
  right=25mm,
  top=25mm,
  bottom=25mm,
  headheight=0mm,
  headsep=0mm,
  footskip=15mm,
  includefoot,
]{geometry}
% \LoadClass[11pt,a4paper,onecolumn, twoside]{report}
% \usepackage{showframe}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\usepackage{tikz}
\usepackage{chngcntr}
\counterwithin{figure}{section} 
\counterwithin{table}{section} 
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{ifthen}
\usepackage{times}
\usepackage{chngpage}
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage{xspace}
\usepackage{mathtools}
\usepackage{enumitem}
\usepackage{caption}
\usepackage{lscape}
\usepackage{lastpage}
\usepackage{tocloft}
\usepackage{listings}
\usepackage{setspace}
\usepackage{ragged2e}   % provides the 'justify' environment used by the class
\usepackage{bookmark}   % quiets rerun warnings for PDF outlines (optional)
\usepackage{nomencl}
\usepackage{booktabs}
\makenomenclature
\newcommand{\PNU@printnomencl}{%
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
	\phantomsection
	{\fontsize{11pt}{0pt}\selectfont\printnomenclature}
	\addcontentsline{toc}{chapter}{Nomenclature}%
	\if@restonecol\twocolumn\fi
}

\cftsetindents{section}{1em}{1.5em}
\cftsetindents{subsection}{2em}{2.5em}
\cftsetindents{subsubsection}{3em}{3.5em}

\pagenumbering{arabic}
% \rfoot{Page \thepage \hspace{1pt} of \pageref{LastPage}}


\if @Korean
	\usepackage{tocloft}
	\usepackage[hangul]{kotex}
	% \usepackage[d]{kotexutf}
\else
	\usepackage{kotex}
	% \usepackage[c]{kotexutf}
\fi

% \setlength{\paperwidth}  {210mm}
% \setlength{\paperheight} {297mm}

% % 페이지여백 설정
% % 기본적으로 LaTeX의 좌표계는 페이지 왼쪽 위가 아니라 (1in, 1in) 지점에서 본문이 시작됩니다. -> 다시 원점으로
% \addtolength{\hoffset}  {-1 in}
% \addtolength{\voffset}  {-1 in}

% \addtolength{\hoffset}  {25 mm}
% \addtolength{\voffset}  {35 mm}

% \setlength{\topmargin}  {0mm}
% \setlength{\headheight} {0mm}
% \setlength{\headsep}    {0mm}

% \setlength{\marginparwidth} {10mm}
% \setlength{\marginparsep}   {0mm}

% \setlength{\textwidth}      {150mm}
% \setlength{\textheight}     {227mm}
% \setlength{\oddsidemargin}  {5mm}
% \setlength{\footskip}       {17.5mm}

% \if@Korean
% 	\setlength{\textheight} {227mm}
% 	\setlength{\footskip}   {17.5mm}
% \fi

% 여백 설정을 geometry 패키지 사용하는 것으로 변경



% \title 명령어 재설정
% 한글, 영어 두 종류의 타이틀을 모두 넣는다.
% Usage: \title[korean]{Korean_Title}
% Usage: \title[english]{English_Title}

% renew related strings if Korean.

\if@Korean
\renewcommand{\contentsname}{목차\hfill}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\bibname}{참고 문헌}
\renewcommand{\figurename}{Figure}
\renewcommand{\tablename}{Table}
\else
\renewcommand{\contentsname}{Contents}
\renewcommand{\bibname}{References}
\renewcommand{\figurename}{Figure}
\renewcommand{\tablename}{Table}
\fi

\renewcommand{\title}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorTitle}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngTitle}{#2}}{}%
}
\@onlypreamble{\title}

% 저자 정보
\renewcommand{\author}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AuthorNS}{#2}}{}%
}
\@onlypreamble{\author}

% 지도교수 정보
\newcommand{\adviser}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAdviser}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAdviser}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AdviserNS}{#2}}{}%
}
\@onlypreamble{\adviser}

% 심사위원 정보 (국/영문 각각 보관)
% 사용법 예)
%   \committeeChair[korean]{홍 길동}
%   \committeeMemberA[korean]{김 철 수}
%   ... (B, C, D, E)
%   영어가 필요하면 [english] 옵션으로 동일 사용
\newcommand{\committeeChair}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorChair{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngChair{#2}}{}%
}
\@onlypreamble{\committeeChair}

\newcommand{\committeeMemberA}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorMemA{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngMemA{#2}}{}%
}
\@onlypreamble{\committeeMemberA}

\newcommand{\committeeMemberB}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorMemB{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngMemB{#2}}{}%
}
\@onlypreamble{\committeeMemberB}

\newcommand{\committeeMemberC}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorMemC{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngMemC{#2}}{}%
}
\@onlypreamble{\committeeMemberC}

\newcommand{\committeeMemberD}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorMemD{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngMemD{#2}}{}%
}
\@onlypreamble{\committeeMemberD}

\newcommand{\committeeMemberE}[2][korean]{%
  \ifthenelse{\equal{#1}{korean}}{\def\PNU@KorMemE{#2}}{}%
  \ifthenelse{\equal{#1}{english}}{\def\PNU@EngMemE{#2}}{}%
}
\@onlypreamble{\committeeMemberE}

% 초기값 비워두기
\def\PNU@KorChair{}\def\PNU@EngChair{}
\def\PNU@KorMemA{}\def\PNU@EngMemA{}
\def\PNU@KorMemB{}\def\PNU@EngMemB{}
\def\PNU@KorMemC{}\def\PNU@EngMemC{}
\def\PNU@KorMemD{}\def\PNU@EngMemD{}
\def\PNU@KorMemE{}\def\PNU@EngMemE{}

% 비어있으면 공백룰, 있으면 이름을 출력
\newcommand{\PNU@NameOrBlank}[1]{\if\relax\detokenize{#1}\relax\rule{6cm}{0pt}\else #1\fi}

% 논문 심사일
\newcommand{\examinationdate}[2][korean]{%
	\ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorExamYear}{#2}}{}%
	\ifthenelse{\equal{#1}{english}}{\newcommand{\@EngExamYear}{#2}}{}%
}
\@onlypreamble{\examinationdate}

% 졸업년월
\newcommand{\gradyear}[2][korean]{%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@GradYearEng}{#2}}{}%
    \ifthenelse{\equal{#1}{korean} }{\newcommand{\@GradYearKor}{#2}}{}%
}
\@onlypreamble{\gradyear}

% 초록
\newcommand{\abstracts}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAbstract}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAbstract}{#2}}{}%%
}
\@onlypreamble{\abstracts}

\newcommand{\pushAbstract}[1][english]{%
    \ifthenelse{\equal{#1}{korean}}{
		\begin{abstractKOR}
			\setstretch{1.3}
			\@KorAbstract
		\end{abstractKOR}
	}{}%
    \ifthenelse{\equal{#1}{english}}{		
		\begin{abstractENG}
			\setstretch{1.3}
			\@EngAbstract
		\end{abstractENG}
	}{}%%
}

\AtBeginDocument{%
	\pagenumbering{gobble}
    \makecover%
    \makeapproval%
	\pagenumbering{arabic}
    }
\AtEndDocument{
	\pagebreak
	\if@Korean
	\pushAbstract[english]
	\else
	\pushAbstract[korean]
	\fi
	\pagenumbering{gobble}
}

\renewcommand\appendix{
	\clearpage
	\if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
	\if@Korean
	% \chapter*{부록}
	\begin{center}
		\Huge\textbf{부~~록}
	\end{center}
	\addcontentsline{toc}{chapter}{부록}
	\else
	\begin{center}
    \Huge\textbf{Appendix}
	\end{center}
	\addcontentsline{toc}{chapter}{Appendix}
	\fi
	\renewcommand{\thechapter}{\Alph{chapter}}%
	\setcounter{chapter}{0}
	\setcounter{section}{0}
	\setcounter{subsection}{0}
	\let\clearpage\relax 

}

% 외표지 작성
\newcommand{\makecover}{
	\clearpage
  	\newgeometry{left=25mm,right=25mm,top=4.5cm,bottom=4cm,headheight=0mm,headsep=0mm,footskip=0mm}
  	\thispagestyle{empty}

  	\begin{center}
		\fontsize{16pt}{16pt}\selectfont
		\if@Korean
		\if@Doctor 박 사 학 위 논 문\\ \else 석 사 학 위 논 문\\ \fi
		\else
		\if@Doctor Dissertation for the degree of Doctor of Philosophy\\
		\else Thesis for the degree of Master of Science\\ \fi
		\fi

		\vspace*{2cm}
		
		{\setstretch{1.3}\fontsize{22pt}{24pt}\selectfont
		\if@Korean \@KorTitle\\ \else \@EngTitle\\ \fi
		}

	\end{center}
	\vfill
	\begin{center}
		{\fontsize{16pt}{18pt}\selectfont
		\if@Korean \@KorAuthor \\ \else \@EngAuthor \\ \fi
		}
		\vspace*{2cm}
		{\fontsize{16pt}{18pt}\selectfont
		\if@Korean
			부산대학교 대학원\\[0.5cm]
			기계공학부\\
		\else
			The Graduate School\\[0.5cm]
			School of Mechanical Engineering\\
			Pusan National University\\
		\fi
		\vspace*{2cm}
		}
		{\fontsize{16pt}{0pt}\selectfont
		\if@Korean \textbf{\@GradYearKor}\\ \else \textbf{\@GradYearEng}\\ \fi
		}
	\end{center}

	\restoregeometry
	\clearpage
}

\newcommand{\makeapproval}{
	\clearpage
	\newgeometry{top=4.5cm,bottom=4cm,left=25mm,right=25mm,headheight=0mm,headsep=0mm,footskip=0mm}%
	\thispagestyle{empty}

	\begin{center}
	% 제목
	\setstretch{1.3}
	\fontsize{22pt}{24pt}\selectfont
	\if@Korean
		\@KorTitle\\
	\else
		\@EngTitle\\
	\fi

	\vspace*{1.5cm}

	% --- 본문 (제출 문구)
	\if@Korean
		\fontsize{16pt}{18pt}\selectfont
		\if@Doctor
		이 논문을 공학박사 학위논문으로 제출함\\
		\else
		이 논문을 공학석사 학위논문으로 제출함\\
		\fi

		\vspace*{1cm}
		\fontsize{14pt}{16pt}\selectfont
		\@KorAuthor\\

		\vspace*{1cm}
		부산대학교 대학원\\
		\vspace*{0.5cm}
		기계공학부\\
		\vspace*{1cm}
		지도교수\quad{}\@KorAdviser\\

	\else
		\fontsize{14pt}{16pt}\selectfont
		\setstretch{1.3}
		\if@Doctor
		A Dissertation submitted to the Graduate School of Pusan National University in partial fulfillment of the requirements for the degree of Doctor of Philosophy in Mechanical Engineering\\
		under the direction of \textbf{\@EngAdviser}\\
		\else
		A Thesis submitted to the Graduate School of Pusan National University in partial fulfillment of the requirements for the degree of Master of Science in Mechanical Engineering\\
		under the direction of \textbf{\@EngAdviser}\\
		\fi
	\fi
	\end{center}

	\vfill

	% --- 하단부 (심사위원란)
	\begin{center}
	\fontsize{16pt}{18pt}\selectfont
	\if@Korean
		\if@Doctor
		\@AuthorNS 의 공학박사 학위논문을 인준함\\
		\else
		\@AuthorNS 의 공학석사 학위논문을 인준함\\
		\fi

		\vspace*{1cm}
		\fontsize{14pt}{16pt}\selectfont
		\textbf{\@KorExamYear}\\

		\vspace*{1cm}
		\setstretch{2.0}
		\fontsize{14pt}{16pt}\selectfont
		위~~원~~장\ \rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@KorChair}\rule{1.5cm}{0pt} 인\\
		위~~~~~~~~원\ \rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@KorMemA}\rule{1.5cm}{0pt} 인\\
		위~~~~~~~~원\ \rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@KorMemB}\rule{1.5cm}{0pt} 인\\
		\if@Doctor
		위~~~~~~~~원\ \rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@KorMemC}\rule{1.5cm}{0pt} 인\\
		위~~~~~~~~원\ \rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@KorMemD}\rule{1.5cm}{0pt} 인\\
		\fi
	\else
		\fontsize{14pt}{16pt}\selectfont
		\if@Doctor
		The dissertation for the degree of Doctor of Philosophy by \@EngAuthor\ has been approved by the committee members.\\
		\else
		The thesis for the degree of Master of Science by \@EngAuthor\ has been approved by the committee members.\\
		\fi

		\vspace*{1cm}
		\textbf{\@EngExamYear}\\

		\vspace*{1cm}
		\setstretch{2.0}
		Chair~~~\rule{3cm}{0pt}\PNU@NameOrBlank{\PNU@EngChair}\\
		Member~~\PNU@NameOrBlank{\PNU@EngMemA}\\
		Member~~\PNU@NameOrBlank{\PNU@EngMemB}\\
		\if@Doctor
		Member~~\PNU@NameOrBlank{\PNU@EngMemC}\\
		Member~~\PNU@NameOrBlank{\PNU@EngMemD}\\
		\fi
	\fi
	\end{center}

	\restoregeometry
	\clearpage
}

%chapter 설정
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
			\addcontentsline{toc}{chapter}{\numberline{제~\thechapter}~~장 ~#1}
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

%% Abstract
\newcounter{pagemarker}
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}}
\newenvironment{abstractKOR}{
	\newgeometry{left=30mm,right=25mm,top=35mm,bottom=25mm,headheight=0mm,headsep=0mm,footskip=0mm}
	\begin{center}
	\setstretch{1.3}	
	\pagestyle{plain}
	\fontsize{14pt}{14pt}
	\selectfont
	\@KorTitle\ \\
	\vspace*{1.5cm}
	\fontsize{12pt}{12pt}
	\selectfont
	\@KorAuthor\ \\
	\vspace*{1.0cm}
	\fontsize{11pt}{11pt}
	\selectfont
	부산대학교 대학원 기계공학부\\
	\vspace*{1.5cm}
	\fontsize{12pt}{12pt}
	\selectfont
	요약\\
	\vspace*{0.5cm}
	\fontsize{11pt}{13pt}
	\selectfont
	\end{center}
	\begin{justify}
		}
		{  %\setcounter{pagemarker}{\value{page}}
    % \addtocounter{pagemarker}{1}
	\end{justify}
    \newpage 
	% \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}

\newenvironment{abstractENG}{
  	\newgeometry{left=30mm,right=25mm,top=35mm,bottom=25mm,headheight=0mm,headsep=0mm,footskip=0mm}
    % \pagenumbering{roman}
	\begin{center}
	\setstretch{1.3}
    \pagestyle{plain}%
	% \vspace*{-0.7cm}
	\fontsize{14pt}{14pt}
	\selectfont
	\@EngTitle\ \\
	\vspace*{1.5cm}
	% \vspace*{-0.1cm}
	\fontsize{12pt}{12pt}
	\selectfont
	\@EngAuthor \\
	% \textbf{\@EngAuthor\ } \\
	\vspace*{1.0cm}
	% \vspace*{-0.2cm}
	\fontsize{11pt}{11pt}
	\selectfont
	School of Mechanical Engineering\\
	The Graduate School\\
	Pusan National University\\
	\vspace*{1.5cm}
	% \vspace*{-0.2cm}
	\fontsize{12pt}{12pt}
	\selectfont
	Abstract\\
	\vspace*{1.0cm}
	\vspace*{-0.2cm}
	\fontsize{11pt}{14pt}
	\selectfont
}{  %\setcounter{pagemarker}{\value{page}}
    % \addtocounter{pagemarker}{1}
	\end{center}
    \newpage 
	% \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}



%%
%% 목차
%%
\newcommand{\makelists}{%
	\pagenumbering{roman}% front matter uses roman numerals
	\setcounter{page}{1}
	\tableofcontents
	\clearpage
	\PNU@printnomencl
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listtablename}
	\listoftables
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listfigurename}
	\listoffigures
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{요약}
	\if@Korean
	\pushAbstract[korean]
	\else
	\pushAbstract[english]
	\fi
	\pagenumbering{arabic}
	\setcounter{page}{1}
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

\renewcommand{\cfttabpresnum}{Table~}
\renewcommand{\cfttabaftersnum}{\space}
\settowidth{\cfttabnumwidth}{Table~1.1.1\quad}

\renewcommand{\cftfigpresnum}{Figure~}
\renewcommand{\cftfigaftersnum}{\space}
\settowidth{\cftfignumwidth}{Figure~1.1.1\quad}

% Ensure bibliography appears in the TOC with a correct hyperlink target
\renewenvironment{thebibliography}[1]{%
    \chapter*{\bibname}%
    \phantomsection
    \addcontentsline{toc}{chapter}{\bibname}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
          \leftmargin\labelwidth
          \advance\leftmargin\labelsep
          \@openbib@code
          \usecounter{enumiv}%
          \let\p@enumiv\@empty
          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m
}{%
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}} 
    \addcontentsline{toc}{chapter}{\contentsname}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
}
% \fi

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \phantomsection%
    \addcontentsline{toc}{chapter}{\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \phantomsection%
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
}

\newcommand{\acknowledgement}{%
    % \vspace{-1cm}
	\if@Korean
		\chapter*{감사의 글}
		\phantomsection
		\addcontentsline{toc}{chapter}{감사의 글}
	\else
		\chapter*{ACKNOWLEGEMENT}
		\phantomsection
		\addcontentsline{toc}{chapter}{Acknowlegement}
	\fi
    \pagestyle{empty}
    \indent
}
