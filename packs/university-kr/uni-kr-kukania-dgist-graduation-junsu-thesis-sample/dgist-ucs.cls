% -*- TeX:UTF-8 -*-
%% KAIST Thesis Template for LaTeX
%%
%% @version      0.4
%% @releasedate  Apr 28th, 2007
%%
%% @author       Chae, Seugbyung 채승병
%%               mailto:chess@kaist.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% Karnes Kim, converted to ko.TeX version.
%%    2008/10/21
%%
%% Seokwoo Choi, modified according to the 2008 thesis format
%%    2008/12/29
%%
%% Jong Mun Lee, modified according to the 2010 thesis format
%% 2010/11/25
%% 본 수정은 대학원학생회와 교무팀의 지원으로 진행되었습니다.
%%
%% Jin Hyun Ahn, modified according to the 2016 thesis format
%% 2016/04/08
%% 교무팀의 지원을 받아 송익호 교수님 연구실에서 수정하였습니다.
%%
%% Yeonjae Shin, modified according to the DGIST 2020 thesis format
%% 2020/08/18


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dgist-ucs}%
[2008/10/21 v0.4 Standard KAIST Thesis document class, ko.TeX version]

%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english} {\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor,korean,final}         % doctor,korean,final이 기본값
\ProcessOptions

%% 10pt,a4paper,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[12pt,a4paper,onecolumn,oneside]{report}



%%들여쓰기
\usepackage{indentfirst}
\setlength\parindent{2.0em}

\RequirePackage{ifthen}       % 추가 패키지 설정

%%%% Hangul-ucs preamble.......
\RequirePackage[nonfrench]{dhucs}
%\RequirePackage[default]{dhucs-interword}
\RequirePackage{ifpdf}
\ifpdf
\def\@drivername{pdftex}
\else
\def\@drivername{dvipdfmx}
\fi
\if@dvips
\def\@drivername{dvips}
\fi

%\ifpdf
%  \input glyphtounicode\pdfgentounicode=1
%\fi

\RequirePackage[\@drivername]{graphicx,xcolor}

\if@PDFdoc
\RequirePackage[unicode,%
\@drivername=true,%
bookmarks=false,%
colorlinks=false,%
]{hyperref}
\else
\RequirePackage[unicode,%
\@drivername=true,%
bookmarks=false,%
colorlinks=false,%
]{hyperref}
\fi

%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

\AtBeginDocument{%                           % \begin{document}와 함께 실행
	\checkparameters                        % 문서 변수가 올바른지 점검
	\if@isFinal                             % final 옵션이 지정되어 있으면
	\makefrontcover \maketitle         % 앞표지, 속표지 생성
	\makeapproval                      % 제출승인서, 심사완료검인 생성
	\else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 편집용지 설정
\usepackage[left=25.4mm,right=25.4mm,top=30mm,bottom=25.4mm,a4paper]{geometry}


%% 줄간격 설정
\renewcommand{\baselinestretch}{2}
\linespread{2}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
\let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
\let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% DGIST 공식 영문명칭
\newcommand{\@dgist}{Daegu Gyeongbuk Institute of Science and Technology}

%% pagestyle
\def\ps@dgist{\let\@mkboth\@gobbletwo
	\let\@oddhead\@empty
	\def\@oddfoot{\reset@font\hfil--\ \thepage\ --
		\hfil}%
	\let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{dgist}

%%
%% 문서 정보 변수 정의
%%

% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목
\renewcommand{\title}[2][korean] {%
	\ifthenelse{\equal{#1}{korean}}%
	{\newcommand{\@titleKor}{#2}}{}%
	\ifthenelse{\equal{#1}{english}}%
	{\newcommand{\@titleEng}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 | chinese: 한문이름 | english: 영문이름
\renewcommand{\author}[3][korean] {%
	\ifthenelse{\equal{#1}{korean}}
	{\newcommand{\@authorKorFN}{#2}
		\newcommand{\@authorKorGN}{#3}
		\newcommand{\@authorKor}{#2\ #3}}{}%
	\ifthenelse{\equal{#1}{korean2}}
	{\newcommand{\@authorKorHN}{#2}
		\newcommand{\@authorKorIN}{#3}
		\newcommand{\@authorKorCont}{#2#3}}{}%
	\ifthenelse{\equal{#1}{chinese}}
	{\newcommand{\@authorChnFN}{#2}
		\newcommand{\@authorChnGN}{#3}
		\newcommand{\@authorChn}{#2\ #3}}{}%
	\ifthenelse{\equal{#1}{english}}
	{\newcommand{\@authorEngFN}{#2}
		\newcommand{\@authorEngGN}{#3}
		\newcommand{\@authorEng}{#2\ #3}}{}%
}

\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[4][major]{%
	\ifthenelse{\equal{#1}{major}} {%       % 주 지도교수이면
		\newcommand{\@advisorMajorKor}{#2} % 한글이름 저장
		\newcommand{\@advisorMajorEng}{#3} % 영문이름 저장
		% nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
		\ifthenelse{\equal{#4}{nosign}}{}{%
			\newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
	\ifthenelse{\equal{#1}{major2}} {%       % 주 지도교수이면
		\newcommand{\@advisorMajorKorCont}{#2} % 한글이름 저장
		\newcommand{\@advisorMajorEngCont}{#3} % 영문이름 저장
		% nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
		\ifthenelse{\equal{#4}{nosign}}{}{%
			\newcommand{\@advisorSignedCont}{\@advisorMajorEngCont}} }{}%
	\ifthenelse{\equal{#1}{coopr}} {%       % 부 지도교수이면
		\newcommand{\@advisorCooprKor}{#2} % 한글이름 저장
		\newcommand{\@advisorCooprEng}{#3} % 영문이름 저장
		% signed를 명시해야 부 지도교수가 서명한 것으로 간주
		\ifthenelse{\equal{#4}{signed}}{%
			\newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
	\ifthenelse{\equal{#1}{coopr2}} {%       % 부 지도교수이면
		\newcommand{\@advisorCooprKorCont}{#2} % 한글이름 저장
		\newcommand{\@advisorCooprEngCont}{#3} % 영문이름 저장
		% signed를 명시해야 부 지도교수가 서명한 것으로 간주
		\ifthenelse{\equal{#4}{signed}}{%
			\newcommand{\@advisorSignedCont}{\@advisorCooprEngCont}}{} }{}%
}
\@onlypreamble{\advisor}

%% 제출승인서에 들어가는 교수님 정보 명령
\newcommand{\advisorinfo}[1]{\newcommand{\@advisorinfo}{#1}}

% @command department
%
\newcommand{\@degreeCode}{}          % 학위 영문코드
\newcommand{\@degreeName}{}          % 학위명
\newcommand{\@degreeversion}{}       % 학과 표현 종류
\newcommand{\@parentDeptNameKor}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameKor}{}       % 학과/전공 둘째줄
\newcommand{\@parentDeptNameEng}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameEng}{}       % 학과/전공 둘째줄
\newcommand{\@affFullNameKor}{}      % 학과/전공 한글이름
\newcommand{\@affFullNameEng}{}      % 학과/전공 영문이름
\newcommand{\@parentAcademNameEng}{} % 학문 영문이름 첫째줄
\newcommand{\@childAcademNameEng}{} % 학문 영문이름 둘째줄
\newcommand{\@appFullAcademName}{}
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{Ph.D/}{MS/}}
\newcommand{\department}[3] {%
	\ifthenelse{\equal{#1}{EM}}
	{\renewcommand{\@degreeCode}{\@degreePrefix #1}
		\renewcommand{\@childDeptNameKor}{신물질과학전공}
		\renewcommand{\@childDeptNameEng}{Department of Emerging Materials Science}
		\renewcommand{\@parentDeptNameKor}{}
		\renewcommand{\@parentDeptNameEng}{}
		\renewcommand{\@parentAcademNameEng}{}
		\renewcommand{\@childAcademNameEng}{}
		\renewcommand{\@degreeField}{#2}
		\renewcommand{\@degreeversion}{#3}}{}
	\ifthenelse{\equal{#1}{IC}}
	{\renewcommand{\@degreeCode}{\@degreePrefix #1}
		\renewcommand{\@childDeptNameKor}{정보통신융합전공}
		\renewcommand{\@childDeptNameEng}{Department of Information and Communication Engineering}
		\renewcommand{\@parentDeptNameKor}{}
		\renewcommand{\@parentDeptNameEng}{}
		\renewcommand{\@parentAcademNameEng}{}
		\renewcommand{\@childAcademNameEng}{}
		\renewcommand{\@degreeField}{#2}
		\renewcommand{\@degreeversion}{#3}}{}
	\ifthenelse{\equal{#1}{RT}}
	{\renewcommand{\@degreeCode}{\@degreePrefix #1}
		\renewcommand{\@childDeptNameKor}{로봇공학전공}
		\renewcommand{\@childDeptNameEng}{Department of Robotics Engineering}
		\renewcommand{\@parentDeptNameKor}{}
		\renewcommand{\@parentDeptNameEng}{}
		\renewcommand{\@parentAcademNameEng}{}
		\renewcommand{\@childAcademNameEng}{}
		\renewcommand{\@degreeField}{#2}
		\renewcommand{\@degreeversion}{#3}}{}
	\ifthenelse{\equal{#1}{ES}}
	{\renewcommand{\@degreeCode}{\@degreePrefix #1}
		\renewcommand{\@childDeptNameKor}{에너지시스템공학전공}
		\renewcommand{\@childDeptNameEng}{Department of Energy Systems Engineering}
		\renewcommand{\@parentDeptNameKor}{}
		\renewcommand{\@parentDeptNameEng}{}
		\renewcommand{\@parentAcademNameEng}{}
		\renewcommand{\@childAcademNameEng}{}
		\renewcommand{\@degreeField}{#2}
		\renewcommand{\@degreeversion}{#3}}{}
	\ifthenelse{\equal{#1}{BS}}
	{\renewcommand{\@degreeCode}{\@degreePrefix #1}
		\renewcommand{\@childDeptNameKor}{뇌과학전공}
		\renewcommand{\@childDeptNameEng}{Department of Brain Science}
		\renewcommand{\@parentDeptNameKor}{}
		\renewcommand{\@parentDeptNameEng}{}
		\renewcommand{\@parentAcademNameEng}{}
		\renewcommand{\@childAcademNameEng}{}
		\renewcommand{\@degreeField}{#2}
		\renewcommand{\@degreeversion}{#3}}{}
	\renewcommand{\@affFullNameKor}{%               % 학과/전공 한글이름
		\ifthenelse{\equal{\@parentDeptNameKor}{}}
		{\@childDeptNameKor}{%
			\ifthenelse{\equal{\@degreeversion}{a}}{\@parentDeptNameKor}{}%
			\ifthenelse{\equal{\@degreeversion}{b}}{\@parentDeptNameKor \ (\@childDeptNameKor)}{}%
			\ifthenelse{\equal{\@degreeversion}{c}}{\@childDeptNameKor}{}}
	}
	\renewcommand{\@affFullNameEng}{%               % 학과/전공 영문이름
		\ifthenelse{\equal{\@parentDeptNameEng}{}}
		{\@childDeptNameEng}{%
			\ifthenelse{\equal{\@degreeversion}{a}}{\@parentDeptNameEng}{}%
			\ifthenelse{\equal{\@degreeversion}{b}}{\@parentDeptNameEng \ (\@childDeptNameEng)}{}%
			\ifthenelse{\equal{\@degreeversion}{c}}{\@childDeptNameEng}{}}
	}
	\renewcommand{\@appFullAcademName}{%               % 학문 승인서용 영문이름
		\ifthenelse{\equal{\@parentAcademNameEng}{}}
		{\@childAcademNameEng}{%
			\ifthenelse{\equal{\@degreeversion}{a}}{\@parentAcademNameEng}{}%
			\ifthenelse{\equal{\@degreeversion}{b}}{\@parentAcademNameEng \ (\@childAcademNameEng)}{}%
			\ifthenelse{\equal{\@degreeversion}{c}}{\@childAcademNameEng}{}}
	}
	\renewcommand{\@degreeName}%                       % 학위 영문이름
		{\ifthenelse{\boolean{@isDoctor}}{Doctor of Philosophy}{Master of Science}}
}
\@onlypreamble{\department}

% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
	\ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
	\ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
	\ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
	\ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
	\ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\approvaldate}[3] {%
	 \newcommand{\@approvalYear}{#1}
	 \newcommand{\@approvalMonth}{#2}
	 \newcommand{\@approvalDay}{#3}

}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\refereedate}[3] {%
	\newcommand{\@refereeYear}{#1}
	\newcommand{\@refereeMonth}{#2}
	\newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전. 그대로 놔둠
%%
\newcommand{\checkparameters}{%
	\@ifundefined{@titleKor}{%
		\ClassError{dgist}{The korean title is not found}{}}{}
	\@ifundefined{@titleEng}{%
		\ClassError{dgist}{The english title is not found}{}}{}
	\@ifundefined{@authorKor}{%
		\ClassError{dgist}{The korean name of the author is not found}{}}{}
	\@ifundefined{@authorChn}{%
		\ClassError{dgist}{The chinese name of the author is not found}{}}{}
	\@ifundefined{@authorEng}{%
		\ClassError{dgist}{The english name of the author is not found}{}}{}
	\@ifundefined{@advisorMajorKor}{%
		\ClassError{dgist}{The korean name of the major advisor is not found}{}}{}
	\@ifundefined{@advisorMajorEng}{%
		\ClassError{dgist}{The english name of the major advisor is not found}{}}{}
}

%%
%% 앞표지 생성
%% Don't change size of letters.
\newcommand{\makefrontcover}{%
	\renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty} \noindent%
	\begin{minipage}[b][10mm][b]{\textwidth}
		\begin{center}
			\if@isDoctor
			\fontsize{14pt}{14pt}\selectfont{Ph.D. Thesis} \\  \fontsize{14pt}{14pt}\selectfont{박 사 학 위 논 문}
			\else
			\fontsize{14pt}{14pt}\selectfont{Master's Thesis}\\
			\fontsize{14pt}{14pt}\selectfont{석 사 학 위 논 문}
			\fi
		\end{center}
	\end{minipage}\\[40mm]
	\begin{minipage}[t][30mm][t]{\textwidth}
		\begin{center}
			%            \fontsize{21pt}{21pt}\selectfont  \@titleKor \\[21pt]
			\fontsize{21pt}{21pt}\selectfont  \@titleEng \\[21pt]
			%            \fontsize{18pt}{18pt}\selectfont \@gradYear
		\end{center}
	\end{minipage}\\[40mm]
	\begin{minipage}[c][40mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont
			\ifthenelse{\equal{\@authorChnFN}{}}
			{\@authorEng\  \hspace{0.5mm} \fontsize{18pt}{18pt}\selectfont  (\@authorKor) \\}
			{\@authorEng\  \hspace{0.5mm} \fontsize{18pt}{18pt}\selectfont   (\@authorChn\
				\@authorKor) \\}[15mm]

		\end{center}
	\end{minipage}\\[15mm]
	\begin{minipage}[c][15mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont \@childDeptNameEng\\[10mm] %Department of Information and Communication Engineering\\[10mm]

			\fontsize{14pt}{14pt}\selectfont DGIST\\[10mm] 
			\fontsize{14pt}{14pt}\selectfont \@gradYear 
		\end{center}
	\end{minipage} \newpage
}


%%
%% 속표지 생성
%%  Don't change size of letters.
\renewcommand{\maketitle}{ \makefrontcover}

%%
%% 학위논문 심사완료 검인서 및 제출승인서 생성
%%  Don't change size of letters.

\newcommand{\makeapproval}{%% 학위논문 제출승인서
	\newpage
	\renewcommand{\baselinestretch}{1.3}
	\hyphenation{institute department division program} % word division 방지
	\thispagestyle{empty} \noindent
	
	\begin{minipage}[b][20mm][b]{\textwidth}
		\begin{center}
			\fontsize{21pt}{21pt}\selectfont \@titleEng
		\end{center}
	\end{minipage}\\[10mm]
	
	\begin{minipage}[c][0mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont
			\begin{tabular}{lcl}             % 학위논문 지도교수 영문이름
				\@ifundefined{@advisorCooprEng}
				% 단독지도교수이면 Advisor 하나만 출력
				{Advisor:&&\hspace{-0.8cm} \@advisorMajorEng}
				% 공동지도교수이면 Major,Co-Advisor 둘 다 출력
				{Advisor &&\hspace{-0.8cm}: Professor  \@advisorMajorEng \\
				Co-Advisor &&\hspace{-0.8cm}: Professor  \@advisorCooprEng}\\[10mm]
			\end{tabular} \vfill
		\end{center}
	\end{minipage}\\[8mm]
	
	\begin{minipage}[c][0mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont by \\[8mm]
			\fontsize{14pt}{14pt}\selectfont\@authorEngFN ~\@authorEngGN \\
			\fontsize{14pt}{14pt}\selectfont  \@childDeptNameEng \\ %Department of Information and Communication Engineering \\
			\fontsize{14pt}{14pt}\selectfont DGIST\\
		\end{center}
	\end{minipage}\\[10mm]
	
	\begin{minipage}[t][10mm][t]{\textwidth}
		\fontsize{14pt}{14pt}\selectfont
		\hspace*{10mm}
		  \fontsize{14pt}{14pt}\selectfont \indent A thesis submitted to the faculty of DGIST in partial fulfillment of the requirements for the degree of \@degreeName~ in the \@childDeptNameEng. The study was conducted in accordance with Code of Research Ethics$^{1)}$.\\[15mm]

	\end{minipage}\\[15mm]
	\mbox{} \hfill
	
	\begin{minipage}[t][30mm][t]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont \noindent
			\@dateUSenglish{\@approvalYear}{\@approvalMonth}{\@approvalDay} \\[24pt] % 제출승인일자
			Approved by \\
			\vspace*{18mm}
			\fontsize{14pt}{14pt}\selectfont
			\begin{tabular}{lll}             % 학위논문 지도교수 영문이름
				\@ifundefined{@advisorCooprEng}
				% 단독지도교수이면 Advisor 하나만 출력
				{Advisor:&&\hspace{-0.8cm} \@advisorMajorEng}
				% 공동지도교수이면 Major,Co-Advisor 둘 다 출력
				{Professor && \@advisorMajorEng \hspace{1cm} (signature)\\ (Advisor) \\ [5mm]
				Professor && \@advisorCooprEng} \hspace{1cm} (signature) \\(Co-Advisor)\\[10mm]
			\end{tabular} \vfill
			\vspace*{20mm}
		\end{center}
	\end{minipage}\\[0mm]
	
	\footnotetext[1]{\fontsize{9pt}{9pt} Declaration of Ethical Conduct in Research: I, as a graduate student of DGIST, hereby declare that I have not committed any acts that may damage the credibility of my research. These include, but are not limited to: falsification, thesis written by some-one else, distortion of research findings or plagiarism. I affirm that my thesis contains honest conclusions based on my own careful research under the guidance of my thesis advisor.}
	\hfill \newpage
	
	
	
	%% 학위논문 심사완료 검인서
	\thispagestyle{empty} \noindent
	\begin{minipage}[c][30mm][c]{\textwidth}
		\begin{center}
			\fontsize{21pt}{21pt}\selectfont \@titleEng \\          % 학위논문 제목
		\end{center}
	\end{minipage}\\[20mm]
	\begin{minipage}[c][10mm][c]{\textwidth}
		\begin{center}
			\fontsize{16pt}{16pt}\selectfont \@authorEng
		\end{center}
	\end{minipage}\\[0mm]
	\begin{minipage}[c][60mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont Accepted in partial fulfillment of the requirements for\\
			the degree of \@degreeName.
			\linebreak
		\end{center}
	\end{minipage}\\[13mm]
	\begin{minipage}[t][40mm][b]{\textwidth}
		\begin{center}
			
			\begin{tabular}{rll}
				\multicolumn{3}{r}{\fontsize{14pt}{14pt}\selectfont (\@dateUSenglish{\@refereeYear}{\@refereeMonth}{\@refereeDay})}\mbox{\ }
				
				\@ifundefined{@refereeChief}{}
				{\\[15pt] \fontsize{14pt}{14pt}\selectfont Head of Committee   & \ \makebox[.5\textwidth][r]{\hrulefill}{\fontsize{14pt}{14pt}\selectfont (signature)} \\ & {\fontsize{14pt}{14pt}\selectfont  Prof. \@refereeChief} &}
				\@ifundefined{@refereeSecond}{}
				{\\[15pt] \fontsize{14pt}{14pt}\selectfont Committee Member   & \ \makebox[.5\textwidth][r]{\hrulefill}{\fontsize{14pt}{14pt}\selectfont (signature)} \\ & {\fontsize{14pt}{14pt}\selectfont  Prof. \@refereeSecond} &}
				\@ifundefined{@refereeThird}{}
				{\\[15pt] \fontsize{14pt}{14pt}\selectfont Committee Member   & \ \makebox[.5\textwidth][r]{\hrulefill}{\fontsize{14pt}{14pt}\selectfont (signature)} \\ & {\fontsize{14pt}{14pt}\selectfont  Prof. \@refereeThird} &}
				\@ifundefined{@refereeFourth}{}
				{\\[15pt] \fontsize{14pt}{14pt}\selectfont Committee Member   & \ \makebox[.5\textwidth][r]{\hrulefill}{\fontsize{14pt}{14pt}\selectfont (signature)} \\ & {\fontsize{14pt}{14pt}\selectfont  Prof. \@refereeFourth} & }
				\@ifundefined{@refereeFifth}{}
				{\\[15pt] \fontsize{14pt}{14pt}\selectfont Committee Member   & \ \makebox[.5\textwidth][r]{\hrulefill}{\fontsize{14pt}{14pt}\selectfont (signature)} \\ & {\fontsize{14pt}{14pt}\selectfont  Prof. \@refereeFifth} & }
			\end{tabular}
			%\end{flushright}
		\end{center}
	\end{minipage}
	\newpage
}


%%
%% 한글 초록과 영문 초록, 논문서지(Korean summary and abstract) 페이지 생성
%%  Don't change size of letters.

\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\newcommand{\@lastRomanPage}{\pageref{paperlastromanpagelabel}} % 총 로마자 페이지 수 계산용

\newcommand{\thesisinfo}{
	\pagestyle{plain}%
	\newcommand{\@tempbreak}{}                   % \linebreak 명령 보관용
	\let\@tempbreak\linebreak
	\renewcommand{\linebreak}{\ }                % \linebreak -> 공백 대체
	\newlength{\@thesisinfowidth}
	\setlength{\@thesisinfowidth}{\textwidth}    % 논문정보박스 사이즈는
	\addtolength{\@thesisinfowidth}{-30mm}       % 텍스트 폭보다 30mm 작게
	\noindent
	\parbox[t]{30mm}{\fontsize{14pt}{14pt} \textsf{\@degreeCode \\ \@studentID}}
	\raisebox{3pt}{\begin{minipage}[t]{\@thesisinfowidth}
			\fontsize{10pt}{10pt} \selectfont \sffamily
			\ifthenelse{\equal{\@authorKorFN}{}}
			{}
			{\@authorKorCont.}
			\@authorEngFN~\@authorEngGN.           % 저자 영문이름
			\@titleEng .                 % 학위논문 영문제목
			\@affFullNameEng .     % 학과/전공 영문이름
			\@gradYear .            % 졸업년도
			\@lastPage p.
			\@ifundefined{@advisorCooprEng}         % 공동지도교수 유무판정
			{Advisor Prof. \@advisorMajorEng.} % 단독지도교수 영문이름
			{Advisor Prof. \@advisorMajorEng, % 공동 주 지도교수 영문이름
			Co-Advisor Prof.	\@advisorCooprEng.}         % 공동 부 지도교수 영문이름
	\end{minipage}}\\[16pt] \if@PDFdoc\phantomsection\fi}


%%
%% 논문초록 생성
%%
\renewenvironment{abstract}{\vspace*{9mm}
	\begin{center}
		\section*{Abstract}
	\end{center}


}{\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\abstractname}
}

%%
%% Keyword 생성
%%
\newenvironment{Engkeyword}{\vspace*{10mm}
	
	\noindent \fontsize{14pt}{14pt}Keywords: }
{%\let\linebreak\@tempbreak          % \linebreak 명령 되돌리기
%	\newpage
}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%        가    % TOC, LOT, LOF 생성
	\afterpage{\blankpage}
	\setcounter{pagemarker}{2}                 % 백색별지분을 고려
	\pagenumbering{roman}                        % 로마자 페이지 시작
	\tableofcontents
	\listoftables
	\listoffigures
}


%%
%% 요약문 생성
%%

\newenvironment{summary}{
	\fontsize{14pt}{14pt}
}{}

\newcommand{\summarykorean}{%           % ver 0.1 요약문 생성 명령
	\renewcommand{\linebreak}{\ }      % 차후 버젼에서 삭제 예정
	\ifx\@textlang\@english
	\chapter*{\Large 요 약 문}
	\begin{center}
		\noindent\fontsize{14pt}{14pt}\textsf{\@titleKor} \\[6mm]
	\end{center}% \setlength{\parindent}{0\p@}
	\fi
}{}

%%
%% 핵심 낱말 생성
%%
\newenvironment{Korkeyword}{\vspace*{\fill}
		\noindent 핵심어: 
}{}

%%
%% 사사 및 이력서 생성
%%

\newcommand{\acknowledgment}[1][default]{%     % 사사
	\newcommand{\@acklang}{#1}
	\ifthenelse{\equal{\@acklang}{1}}
	{\chapter*{사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{사 사}}{}                 % 본문과 사사가 둘 다 한글일 때
	\ifthenelse{\equal{\@acklang}{2}}
	{\chapter*{영 문 사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 사 사}}{}         % 본문은 한글인데 사사가 영어일 때
	\ifthenelse{\equal{\@acklang}{3}}
	{\chapter*{Acknowledgment} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments}}{}        % 본문과 사사가 둘 다 영어일 때
	\ifthenelse{\equal{\@acklang}{4}}
	{\chapter*{Acknowledgments in Korean} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments in Korean}}{}\noindent}         % 본문은 영어인데 사사가 한글일 때


\newcommand{\nacknowledgment}[1][default]{%% 사사를 여러 개 쓰고 싶을때는 이 것과 같이 명령어를 바꾸고, 같은 구조로 쓰면 됩니다. 사사 뿐만 아니라 약력도 여러 개 쓰고 싶으실 때 같은 방법으로, 명령어 이름을 바꾸고 같은 구조로 쓴 다음 본문에서 그 명령어를 사용하시면 됩니다.
	\newcommand{\@nacklang}{#1}
	\ifthenelse{\equal{\@nacklang}{1}}
	{\chapter*{사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{사 사}}{}                 % 본문과 사사가 둘 다 한글일 때
	\ifthenelse{\equal{\@nacklang}{2}}
	{\chapter*{영 문 사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 사 사}}{}         % 본문은 한글인데 사사가 영어일 때
	\ifthenelse{\equal{\@nacklang}{3}}
	{\chapter*{Acknowledgment} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments}}{}        % 본문과 사사가 둘 다 영어일 때
	\ifthenelse{\equal{\@nacklang}{4}}
	{\chapter*{Acknowledgments in Korean} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments in Korean}}{}\noindent}         % 본문은 영어인데 사사가 한글일 때

\newcommand{\curriculumvitae}[1][default]{%     % 약력
	\newcommand{\@ccvlang}{#1}
	\ifthenelse{\equal{\@ccvlang}{1}}
	{\chapter*{약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{약 력}}{}                 % 본문과 약력이 둘 다 한글일 때
	
	\ifthenelse{\equal{\@ccvlang}{2}}
	{\chapter*{영 문 약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 약 력}}{}         % 본문은 한글인데 약력이 영어일 때
	
	\ifthenelse{\equal{\@ccvlang}{3}}
	{\chapter*{Curriculum Vitae} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae}}{}        % 본문과 약력이 둘 다 영어일 때
	\ifthenelse{\equal{\@ccvlang}{4}}
	{\chapter*{Curriculum Vitae in Korean} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae in Korean}}{}}% 본문은 영어인데 약력이 한글일 때




%%
%% 이력서 내부 요소 생성
%%


\newenvironment{personaldata}{%            % 개인정보
	
	\begin{list}{}{%
			\setlength{\labelwidth}{70pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1:\ }}}
		\newcommand{\name}[1]{%               % 이름
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Name\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Name\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		\newcommand{\dateofbirth}[3]{%        % 생년월일
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Date of Birth\hfill]}    \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
			}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Date of Birth\hfill]}
				\expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
			}{}
		}
		
		\newcommand{\birthplace}[1]{%         % 출생지
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Birthplace\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Birthplace\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		%%       \newcommand{\domicile}[1]{%           % 본적지
		%%\ifthenelse{\equal{\@ccvlang}{1}}
		%%            {\def\@arg{[본\hfill적\hfill지]}}{}
		%% \ifthenelse{\equal{\@ccvlang}{4}}
		%% {\def\@arg{[본\hfill적\hfill지]}}{}
		%%      \ifthenelse{\equal{\@ccvlang}{2}}
		%%   {\def\@arg{[Domicile\hfill]}}{}
		%%
		%%   \ifthenelse{\equal{\@ccvlang}{3}}
		%%       {\def\@arg{[Domicile\hfill]}}{}
		%%     \expandafter\item\@arg ##1}
		
		
		\newcommand{\address}[1]{%            % 주소지
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Address\hfill]}}{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Address\hfill]}}{}
			
			\expandafter\item\@arg ##1}
		
		\newcommand{\email}[1]{%              % E-mail
			
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[E-mail\hfill]}}{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[E-mail\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		
		%이력서에 집어넣을 추가 필드가 필요하면 위를 참고하여 만들어 쓸 것.
		%\newcommand{(필드명령)}[1]{%
		%  \ifthenelse{\equal{\@ccvlang}{1}}
		%        {\def\@arg{[한글 필드 이름]}}{}
		%   \ifthenelse{\equal{\@ccvlang}{4}}
		%        {\def\@arg{[한글 필드 이름]}}{}
		%   \ifthenelse{\equal{\@ccvlang}{2}}
		%     {\def\@arg{[영어 필드 이름]}}{}
		%
		%    \ifthenelse{\equal{\@ccvlang}{3}}
		%        {\def\@arg{[영어 필드 이름]}}{}
		%         \expandafter\item\@arg ##1}
	}{\end{list}}

\newenvironment{education}{%               % 학력
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{}
	\ifthenelse{\equal{\@ccvlang}{4}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{}
	\ifthenelse{\equal{\@ccvlang}{2}}{
		\textbf{\large Educations}
	}{}
	\ifthenelse{\equal{\@ccvlang}{3}}{
		\textbf{\large Educations}
	}{}
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}

\newenvironment{career}{%                  % 경력
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{4}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{2}}
	{\textbf{\large Career}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{3}}
	{\textbf{\large Career}
	}{ }
	
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{\z@}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}

\newcounter{itemnum1}

%%\newenvironment{activity}{%                % 학회활동
%%
%%        \vspace*{5mm} \noindent
%%
%%\ifthenelse{\equal{\@ccvlang}{1}}
%%            {\begin{center}
%%                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
%%            \end{center}
%%        }{ }
%%
%%\ifthenelse{\equal{\@ccvlang}{4}}
%%            {\begin{center}
%%                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
%%            \end{center}
%%        }{ }
%%
%%\ifthenelse{\equal{\@ccvlang}{2}}
%%           {\textbf{\large Academic Activities}
%%        }{ }
%%
%%\ifthenelse{\equal{\@ccvlang}{3}}
%%            {\textbf{\large Academic Activities}
%%        }{ }
%%
%%
%% \begin{list}{}{%
%%            \usecounter{itemnum1}
%%            \setlength{\labelwidth}{1.5em}
%%            \setlength{\leftmargin}{\labelwidth}
%%            \addtolength{\leftmargin}{\labelsep}
%%            \setlength{\parsep}{\z@}
%%            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
%%    }{\end{list}}
%%
\newcounter{itemnum2}

\newenvironment{publication}{%             % 연구업적
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
	\end{center}}
	{}
	
	\ifthenelse{\equal{\@ccvlang}{4}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
	\end{center}}
	{}
	
	\ifthenelse{\equal{\@ccvlang}{2}}{ \textbf{\large Publications}}
	{}
	
	\ifthenelse{\equal{\@ccvlang}{3}}{ \textbf{\large Publications}}
	{}
	
	
	\begin{list}{}{%
			\usecounter{itemnum2}
			\setlength{\labelwidth}{1.5em}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{\z@}
			\renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
	}{
\end{list}}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{
	\if@isKorean 차 례        \else List of Contents        \fi}
\renewcommand{\listfigurename}{
	\if@isKorean 그림 차례 \else List of Figures \fi}
\renewcommand{\listtablename}{
	\if@isKorean 표 차례    \else List of Tables  \fi}
\renewcommand{\bibname}{%
	\if@isKorean 참 고 문 헌 \else References      \fi}
\renewcommand{\abstractname}{
	\if@isKorean 요 약 문 \else Abstract      \fi}
\renewcommand{\figurename}{
	\if@isKorean 그림 \else Figure      \fi}
\renewcommand{\tablename}{
	\if@isKorean 표 \else table      \fi}
%%
%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%
\renewcommand\part{%
	\secdef\@part\@spart}
\def\@part[#1]#2{%
	\ClassError{dgist}{The use of \protect\part\space is prohibited.
		\MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
	\ClassError{dgist}{The use of \protect\part\space is prohibited.
		\MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%

\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi
	%   \thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
	\refstepcounter{chapter}%
	\typeout{\@chapapp\thechapter.}%
	\addcontentsline{toc}{chapter}{%
		\if@isKorean
		\protect\numberline{제 \thechapter\ 장}#1
		\else
		\protect{\: \thechapter.}#1
		\fi
	}% <-- 목차에 나타나는 형식 - 변경사항
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
\def\@makechapterhead#1{% <-- 전체 변경
	\vspace*{10\p@}
	{\centering \parindent\z@ \LARGE\bfseries
		\ifthenelse{\equal{\@textlang}{korean}}
		{제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
		{\thechapter.\hspace{1ex}}
		#1\par}
	\vspace*{20\p@}
}

\def\@schapter#1{%
	\if@twocolumn
	\@topnewpage[\@makeschapterhead{#1}]%
	\else
	\@makeschapterhead{#1}%
	\@afterheading
	\fi}
\def\@makeschapterhead#1{% <-- 전체 변경
	\vspace*{10\p@}
	{\centering \parindent\z@ \fontsize{14pt}{14pt}\selectfont \bfseries #1\par}
	\vspace*{20\p@}
}
\renewcommand*\thechapter{\Roman{chapter}} \renewcommand*\thesection{\arabic{chapter}.\arabic{section}}

%%
%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\tableofcontents{%
	\thispagestyle{plain}
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\Large\contentsname}
	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
	\pagenumbering{roman}                         % roman 페이지번호로 복원
	\setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
	\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname} % 목차(TOC)에 추가
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
	\newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
	\pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}


%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
	\thispagestyle{plain}
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\Large\listtablename}%
	\@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
	\pagenumbering{roman}                         % roman 페이지번호로 복원
	\setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
	\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% 목차(TOC)에 추가
	\@starttoc{lot}%
	\if@restonecol\twocolumn\fi
	\newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
	\pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
	\thispagestyle{plain}
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\Large\listfigurename}%
	\@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
	\pagenumbering{roman}                         % roman 페이지번호로 복원
	\setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
	\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% 목차(TOC)에 추가
	\label{paperlastromanpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
	\@starttoc{lof}%
	\if@restonecol\twocolumn\fi
	\newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
	\pagenumbering{arabic}                        % arabic 페이지번호로 재시작
%
}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%

%\newcommand{\l@content}{\@dottedtocline{1}{0em}{0em}}
\newcommand{\l@content}[2]{
	\ifnum \c@tocdepth >\m@ne
	\addpenalty{-\@highpenalty}%
	\vskip .5em \@plus\p@
	\if@isKorean                     % <-- 변경 부분
	\setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
	\else
	\setlength\@tempdima{1.5em} % english 옵션일 때는 1.5em
	\fi
	\begingroup
	\parindent \z@ \rightskip \@pnumwidth
	\parfillskip -\@pnumwidth
	\leavevmode \bfseries \large %\sffamily
	\advance\leftskip\@tempdima
	\hskip -\leftskip
	#1\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfil  \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
	\penalty\@highpenalty
	\endgroup
	\fi}

\renewcommand{\l@chapter}[2]{
	\ifnum \c@tocdepth >\m@ne
	\addpenalty{-\@highpenalty}%
	\vskip 2.0em \@plus\p@
	\if@isKorean                     % <-- 변경 부분
	\setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
	\else
	\setlength\@tempdima{1.5em} % english 옵션일 때는 1.5em
	\fi
	\begingroup
		\parindent \z@ \rightskip \@pnumwidth
		\parfillskip -\@pnumwidth
		\leavevmode \bfseries \large %\sffamily
		\advance\leftskip\@tempdima
		\hskip -\leftskip
%		#1\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
		#1\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfil  \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
		\penalty\@highpenalty
	\endgroup
	\fi}

%\renewcommand*\l@section{\normalsize}
%\setcounter{tocdepth}{2}

\if@isKorean % 한글이면 각종 치수를 변경
\renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠

%%
%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewenvironment{thebibliography}[1]{%
	\chapter*{\Large\bibname}%
	\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
	\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\bibname}%
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
	\sfcode`\.\@m%
}{  %% \label{paperlastpagelabel}    %  <-- 추가 부분: 마지막 페이지 위치 지정
	\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
	\endlist
}

%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
	\newcommand{\@year}{#1}%
	\newcommand{\@month}{#2}%
	\newcommand{\@day}{#3}%
	\ifcase\@month \or
	January \or February \or March \or April \or May \or June \or
	July \or August \or September \or October \or November \or December \fi
	\@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
	\newcommand{\@year}{#1}%
	\newcommand{\@month}{#2}%
	\newcommand{\@day}{#3}%
	\@day\ifcase\@day \or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
	\space\ifcase\@month \or
	January\or February\or March\or April\or May\or June\or
	July\or August\or September\or October\or November\or December\fi,
	\@year
}
