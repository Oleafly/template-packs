%% 완전히 처음부터 다시 만드는 것 .
%% 이 문서의 라이센스는  해당파일을 참조해주시길.
%% 아직 미완성입니다. 최소한 제가 졸업하기 전에는 완성할 예정이고
%% 도와주시면 금방 완성되겠지요. 
%% @author	KIM, Hyeok mailto:ekh0324@gmail.com
%%
%% @requirements
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{konkukthesis}[2023/06/22]
%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@isTitle
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse
%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{title}  {\@isTitletrue}
\DeclareOption{notitle}  {\@isTitlefalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {oblivoir}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {oblivoir}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{oblivoir}}
%
\ExecuteOptions{doctor,korean,final,title}         % doctor,korean,final,title이 기본값
\ProcessOptions* %
%
%
%% 10pt,a4paper,onecolumn,oneside 옵션으로 oblivoir 클래스 불러오기
\LoadClass[11pt,
onecolumn,    	% 건국대 서식
oneside,     	% 건국대 서식
b5paper,
hangul,			% 한글을 쓰려고 oblivoir사용.
chapter,		% 장이 가장 큰 영역.
%kosection,      % section에 제1절 표시 제~1~이 아니라 붙여써야.
figtabcapt,]{oblivoir}
%figtabcapt   표caption을 <표3.1>과 같은 형태로 해줌.

% \renewcommand{\LARGE}{\fontsize{16pt}{20pt}\selectfont}
% \newcommand{\HUGE}{\fontsize{24.88pt}{28pt}\selectfont}
%
%%들여쓰기
\usepackage{indentfirst}
\usepackage{ob-mathleading}
\usepackage{ob-koreanappendix}

\RequirePackage{ifthen}       % 추가 패키지 설정

%%%% Hangul-ucs preamble.......
% \RequirePackage[nonfrench,hangul]{dhucs}
% \RequirePackage[hangul]{kotex}
% \RequirePackage[hangul]{kotex}

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

\ifpdf
\input{glyphtounicode}
\pdfgentounicode=1
\fi

\RequirePackage[\@drivername]{graphicx,xcolor}
% 
% \if@PDFdoc
%   \RequirePackage[unicode,%
%       \@drivername=true,%
%       bookmarks=true,%
%      colorlinks=true,%
%    ]{hyperref}
% \else
%   \RequirePackage[unicode,%
%       \@drivername=true,%
%       bookmarks=false,%
%      colorlinks=false,%
%    ]{hyperref}
% \fi

\AtBeginDocument{%                           % \begin{document}와 함께 실행
    \checkparameters                        % 문서 변수가 올바른지 점검
    \if@isTitle             % final 옵션이 지정되어 있으면
      \bfseries
       \makefrontcover 		% 앞표지
        %$\makeinnertitle %  속표지 생성 2023속표지 규격 삭제
        \makesubmit			% 제출승인서
        \makeapproval		% 심사완료검인 생성
        \mdseries
   \fi    %
   }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 편집용지 설정
\usepackage[left=25mm,right=25mm,top=25mm,bottom=25mm,b5j]{geometry}
\usepackage{fapapersize}
\usefapapersize{182mm,257mm,25mm,*,25mm,*}
\usepackage{calc}
\usepackage{glossaries}
\usepackage{acronym}
\usepackage{textcomp}
% \usepackage[hangul]{kotex}

\usepackage{iftex}
\ifPDFTeX
\usepackage{dhucs-nanumfont}
\else\ifXeTeX
\setmainhangulfont{NanumMyeongjo}
 \renewcommand{\normalsize}{\fontsize{11pt}{13.2pt}\selectfont}
 \renewcommand{\large}{\fontsize{13pt}{15.6pt}\selectfont}
 \renewcommand{\Large}{\fontsize{14pt}{16.8pt}\selectfont}
 \renewcommand{\LARGE}{\fontsize{16pt}{19.2pt}\selectfont}
 \renewcommand{\huge}{\fontsize{18pt}{21.6pt}\selectfont}
 \renewcommand{\Huge}{\fontsize{22pt}{26.4pt}\selectfont}

\else\ifLuaTeX
\setmainhangulfont{NanumMyeongjo}
\fi\fi\fi

%% 줄간격 설정 (References, Contents(그림, 표 목차 포함)는 줄간격이 모두 1.3으로 고정되어 있습니다.)
\renewcommand{\baselinestretch}{1.6}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% 건국대학교 공식 영문명칭
\newcommand{\@kuEng}{Graduate School of Konkuk University}
\newcommand{\@kuKor}{건국대학교 대학원}
% Graduate School of Konkuk University
% 이 부문은 본인이 수정해서 하세요 .
% 건축전문대학원 : Graduate School of Architecture, Konkuk University
% 행정대학원 : Graduate School of Public Administration, Konkuk University
% 교육대학원 : Graduate School of Education, Konkuk University
% 산업대학원 : Graduate School of Engineering, Konkuk University
% 경영대학원: Graduate School of Business Administration, Konkuk University
% 농축대학원 : Graduate School of Agriculture and Animal Science,
%              Konkuk University
% 언론홍보대학원 : Graduate School of Mass Communication and public
%                  relations, Konkuk University
% 정보통신대학원 : Graduate School of Information and Telecommunications,
%                  Konkuk University
% 예술디자인대학원 : Graduate School of Art and Design, Konkuk University
% 부동산대학원 : Graduate School of Real Estate studies, Konkuk University



%% pagestyle 
\def\ps@ku{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil--\ \thepage\ --
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}
% \usepackage{tocloft}
\makeheadstyles{konkuk}{
% chapter
\setlength{\beforechapskip}{3.5ex \@plus 1ex \@minus .2ex}
\renewcommand*{\chapterheadstart}{\vspace{\beforechapskip}}
\setlength{\afterchapskip}{10mm \@plus 1ex}
\renewcommand{\chaptitlefont}{\centering\normalfont\LARGE\bfseries \selectfont}
% section
% \setbeforesecskip{1.5\onelineskip
% \@plus -0.5\onelineskip \@minus -.5\onelineskip}%
\setsecindent{0ex}
% \setaftersecskip{0.667\onelineskip \@plus 0.1\onelineskip}%
\setsecheadstyle{\Large\bfseries\raggedright}%
% subsection
% \setbeforesubsecskip{-0.667\onelineskip
% \@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
\setsubsecindent{1ex}
% \setaftersubsecskip{0.333\onelineskip \@plus 0.1\onelineskip}%
\setsubsecheadstyle{\normalfont\large\bfseries}%
% subsubsection
\setbeforesubsubsecskip{-0.667\onelineskip
\@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
\setsubsubsecindent{2ex}
% \setaftersubsubsecskip{0.333\onelineskip \@plus 0.1\onelineskip}%
% \setsubsubsecheadstyle{\normalfont\large\bfseries\raggedright}%
% paragarph
% \setbeforeparaskip{-0.333\onelineskip
% \@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
\setparaindent{3ex}
% \setafterparaskip{0.333\onelineskip \@plus 0.1\onelineskip}%
\setparaheadstyle{\normalfont\normalsize\bfseries}%
}
\makeheadstyles{appendixkonkuk}{
\headstyles{konkuk}
}

\makechapterstyle{konkuk}{
	\chapterstyle{hangul}
	\headstyles{konkuk}

	\renewcommand{\contentsname}{ { 목차}}
	\renewcommand{\listfigurename}{ { 그림~목차}}
	\renewcommand{\listtablename}{ { 표~목차}}
	\renewcommand{\appendixname}{ {부록}}

% 	\renewcommand{\printchaptername}{} %무의미
	\renewcommand{\chapternamenum}{\null}

	% chapnamefont 제 <--
	\renewcommand{\chapnamefont}{\chaptitlefont}
	\renewcommand{\chapnumfont}{\chaptitlefont}
	\renewcommand{\printchapternum}{\chapnumfont \thechapter}
	\renewcommand{\afterchapternum}{\quad}

	\renewcommand*{\prechapternum}{\chapnamefont\centering 제}
	\renewcommand*{\postchapternum}{\chapnamefont장}
	\renewcommand*{\hchaptertitlehead}{제\thechapter장}

	\renewcommand{\thesection}{제\arabic{section}절}
	\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
	%\renewcommand{\thesubsection}{\bfseries\arabic{subsection}}
	\renewcommand{\thesubsection}{\arabic{subsection}.}
	% cft --- toc change 
	\renewcommand*{\cftchapterfont}{}%
	\renewcommand*{\cftchapterpagefont}{}%
% 	\renewcommand*{\cftchapterpagefont}{\large\bfseries\sffamily}%
%%% Equation counter 식번호 초기화
\counterwithin{equation}{chapter}
% \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\renewcommand{\theequation}{\arabic{equation}}

%%% Table of Contents 서식
	\cftsetindents{chapter}{0em}{5em}
	\cftsetindents{section}{1em}{4.0em}
	\cftsetindents{subsection}{2.8em}{2.2em}
	\renewcommand\cftchapterleader{\cftdotfill{\cftsectiondotsep}} % 점선채우기
}
\makechapterstyle{appendixkonkuk}{
	\chapterstyle{konkuk}
	\renewcommand{\prechapternum}{}
	\renewcommand{\postchapternum}{}
% 	\renewcommand{\chapternamenum}{\enskip}

  \setlength{\beforechapskip}{50pt}
  \setlength{\midchapskip}{20pt}
  \setlength{\afterchapskip}{40pt}
%%%%

	\renewcommand\thechapter{\appendixname\arabic{APPchapter}}
%	\renewcommand\theequation{\thechapter.\arabic{equation}}
	\renewcommand\thesection{\thechapter.\arabic{APPsection}}
%	\renewcommand\thesubsection{\thesection.\arabic{APPsubsection}}
%	\setcounter{APPchapter}{1}
	
%	\chapterstyle{appendixdefault}

	\renewcommand*\prechapternum{}
	\renewcommand*\postchapternum{}
	%\renewcommand{\printchapternum}{\chapnumfont[\thechapter]}
	
% 	\renewcommand*{\chaptitlefont}{\huge\scshape\bfseries\centering}
	%\renewcommand{\printchapternum}{\prechapternum\chapnumfont~\thechapter\postchapternum}
% 	\renewcommand{\printchapternum}{\prechapternum\chapnumfont\thechapter\postchapternum}
%
% 	\renewcommand{\printchaptertitle}[1]{%
% 	\chaptitlefont ##1}
% 	\setsecheadstyle{\normalfont\bfseries}
	\setsecnumformat{the##1}



	%\renewcommand\hchaptertitlehead{부록\,\thechapter\,}

	\renewcommand{\thesection}{[부록\arabic{section}.]}
	\headstyles{appendixkonkuk}
}

%$  \renewcommand{\thetable}{\textlangle표 \arabic{chapter}.\arabic{table}\textrangle}   
 %\renewcommand{\tablename}{}   


% \setlength{\cftchapterindent}{0em}
% \cftc{\large}

% \renewcommand{\cftchapterfont}{\normal}
% \cftsetindents{subsubsection}{8.4em}{4.8em}
% \cftsetindents{paragraph}{10.7em}{5.7em}
% \cftsetindents{subparagraph}{12.7em}{6.7em}  
% \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} 


% \pagestyle{hangul}
% \chapterstyle{hangul}
\chapterstyle{konkuk}

%%
%% 문서 정보 변수 정의
%%


% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목

% \newcommand{\@titleKor}{}{}
\usepackage{ifthen}
\newcommand{\titles}[2][default] {%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@titleKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@titleEng}{#2}}{}%
    \ifthenelse{\equal{#1}{subtitle}}%
	{\newcommand{\@titleSub}{#2}}{}%false
	
% 	\endinput
}
\@onlypreamble{\titles}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% 옛날 서식에는 한자가 필요했는데 이제 안 필요한지 
% 공식서식에는 없습니다. 석사과정만 한자가 필요한 것일 수도.
% @options [default: (none)]
% - korean: 한글이름 | hanja: 한문이름 | english: 영문이름
% 
% \newcommand{\@authorKor}{}
% \newcommand{\@authorHanja}{}
% \newcommand{\@authorEng}{}
% % 
\renewcommand{\author}{}
\renewcommand{\author}[2][valid] {%
	\ifthenelse{\equal{#1}{korean}}%
            {\newcommand{\@authorKor}{#2}}{}% false
	\ifthenelse{\equal{#1}{hanja}}%
            {\newcommand{\@authorHanja}{#2}}{}% false
	\ifthenelse{\equal{#1}{english}}%
            {\newcommand{\@authorEng}{#2}}{}% false
} % end author define	
\@onlypreamble{\author}

% @command advisor 지도교수 
\newcommand{\advisor}[3]{%
	\newcommand{\@advisorMajorKor}{#1} % 한글이름 저장
	\newcommand{\@advisorMajorEng}{#2} % 영문이름 저장
	\newcommand{\@advisorMajorHanja}{#3} % 한자이름 저장
}
\@onlypreamble{\advisor}

% @command department 학과이름 - 아래 표에 따라 코드를 입력
%
% 물리학   physics 
% 각 단과대에 따라 추가할 수 있습니다.

\newcommand{\@deptNameKor}{몰라학}
\newcommand{\@deptNameEng}{Department of Unknown}
\newcommand{\@degreeField}{Philosophy}
\newcommand{\@degreeFieldKor}{잡학}
\newcommand{\@degreeNameKor}{잡학박사}
\newcommand{\@degreeName}{잡학박사}

\newcommand{\department}[1][physics]{}
\renewcommand{\department}[1][physics]{%
	\ifthenelse{\equal{#1}{physics}}%
            {\renewcommand{\@deptNameKor}{물리학과}%
		\renewcommand{\@deptNameEng}{Department of Physics}%
		\renewcommand{\@degreeField}{Science} 
		\renewcommand{\@degreeFieldKor}{이학}}{}
        \ifthenelse{\equal{#1}{chemistry}}
            {\renewcommand{\@deptNameKor}{화학과}
            \renewcommand{\@deptNameEng}{Department of Chemistry}
		\renewcommand{\@degreeField}{Science} 
		\renewcommand{\@degreeFieldKor}{이학}}{}
%
			 \renewcommand{\@degreeName}{%                       % 학위 영문이름
            \ifthenelse{\boolean{@isDoctor}}
                {Doctor of Philosophy} {%                 % 박사는 모두 Ph.D.
                \ifthenelse{\equal{\@degreeField}{science}}%
                    {Master of Science}{}%               % 이학석사는 M.S.
                \ifthenelse{\equal{\@degreeField}{engineering}}%
                    {Master of Science in Engineering}{}%           % 공학석사는 M.E.
                \ifthenelse{\equal{\@degreeField}{business}}%
                    {Master of Business Administration}{}% 경영학석사는 M.B.A.
                }
        }
        \renewcommand{\@degreeNameKor}{%                       % 학위 영문이름
            %\@degreeFieldKor
            \ifthenelse{\boolean{@isDoctor}} {박사}{석사}학위
        }
        
}
\@onlypreamble{\department}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
% ... 직접 이름을 쓰시면 되는데... 이거 귀찮은 작업임.
% 왜 ____이것 때문에.
\newcommand{\@refereeChief} {}
\newcommand{\@refereeSecond}{}
\newcommand{\@refereeThird} {}
\newcommand{\@refereeFourth}{}
\newcommand{\@refereeFifth} {}

\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\renewcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\renewcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\renewcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\renewcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\renewcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command gradyear 졸업년도
\newcommand{\gradyear}[2]{%
	\newcommand{\@gradYear}{#1}
	\newcommand{\@gradMonth}{#2}
}
\newcommand{\appryear}[2]{%
	\newcommand{\@apprYear}{#1}
	\newcommand{\@apprMonth}{#2}
}
\newcommand{\submityear}[2]{%
	\newcommand{\@submitYear}{#1}
	\newcommand{\@submitMonth}{#2}
}
%\@onlypreamble{\gradyear}

% @command keywords 키워드
\newcommand{\keywords}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@keywordsKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@keywordsEng}{#2}}{}%
}
\@onlypreamble{\keywords}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전.
%%
\newcommand{\checkparameters}{%
	\@ifundefined{@titleKor}{%
		\ClassError{konkuk}{The korean title is not found}{}
	}{}
	\@ifundefined{@titleEng}{%
		\ClassError{konkuk}{The english title is not found}{}
	}{}
	\@ifundefined{@authorKor}{%
		\ClassError{konkuk}{The korean name of the author is not found}{}
	}{}
	\@ifundefined{@authorHanja}{%
		\ClassError{konkuk}{The chinese name of the author is not found}{}
	}{}
	\@ifundefined{@authorEng}{%
		\ClassError{konkuk}{The english name of the author is not found}{}
	}{}
	\@ifundefined{@advisorMajorKor}{%
		\ClassError{konkuk}{The korean name of the major advisor is not found}{}
	}{}
	\@ifundefined{@advisorMajorEng}{%
		\ClassError{konkuk}{The english name of the major advisor is not found}{}
	}{}
}


%%
%% 앞표지 생성
\newcommand{\makefrontcover}{}
\newcommand{\makesubmit}{}
\newcommand{\makeapproval}{}
\newcommand{\makeinnertitle}{}

\renewcommand{\makefrontcover}{%
	\renewcommand{\baselinestretch}{1.3} 
	\thispagestyle{empty} \noindent%
		\begin{minipage}[t][3cm][t]{\textwidth}
			\Large \bfseries \ttfamily
                        \@degreeNameKor 청구논문  \par
			지도교수 \makebox[\widthof{청구논문}][s]{\@advisorMajorKor} 
		\end{minipage}
        	
	\begin{minipage}[t][8.5cm][t]{\textwidth}
		\centering	\Huge  \@titleKor \par% \fontsize{24pt}{24pt}\selectfont
		\centering	 \LARGE  \@titleSub
		\if@isKorean 
		\else
		\par\Large \@titleEng       
		\fi
	\end{minipage}

	\vfill
	\begin{minipage}[t][3.0cm][t]{\textwidth}
		\centering\LARGE \@gradYear년 \@gradMonth월
	\end{minipage}

	\begin{minipage}[t][1.0cm][c]{\textwidth}
		\centering
			{\huge건국대학교 대학원}	
	\end{minipage}\\[0mm]

	\begin{minipage}[t][1.5cm][c]{\textwidth}
		\centering
			{\LARGE\@deptNameKor} 
	\end{minipage}\\[0mm]

	\begin{minipage}[t][2.0cm][t]{\textwidth}
		\centering
			{\huge \@authorKor}
	\end{minipage}
	\clearpage
}
%%
%% 속표지 생성 
%%
\renewcommand{\makeinnertitle}{%
	\renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty} \noindent%
	\begin{minipage}[t][3cm][t]{\textwidth}
			\Large  \ttfamily
			  \@degreeNameKor  청구논문 
			\par 지도교수 \makebox[\widthof{청구논문}][s]	{\@advisorMajorKor}
	\end{minipage}

	\begin{minipage}[t][6.6cm][t]{\textwidth}
		\centering
		\if@isKorean 
		{\HUGE  \@titleKor }
		\else
		{\HUGE  \@titleKor }
		{\smallskip \Large \@titleEng}            
		\fi
	\end{minipage}\\[0mm]

	\begin{minipage}[c][3.0cm][t]{\textwidth}
		\centering	\Large \@gradYear년 \@gradMonth월
	\end{minipage}\\[0mm]

	\begin{minipage}[c][1.7cm][c]{\textwidth}
		\centering
			{\LARGE건국대학교 대학원}	
	\end{minipage}\\[0mm]

	\begin{minipage}[c][1.5cm][c]{\textwidth}
		\centering
			{\Large\@deptNameKor} 
	\end{minipage}\\[0mm]

	\begin{minipage}[c][1.1cm][c]{\textwidth}
		\centering
			{\LARGE \@authorKor}
	\end{minipage}\\[0mm]
		\begin{comment}
	\begin{minipage}[c][2cm][b]{\textwidth}
		\centering
			{\LARGE건국대학교 대학원}\par
			{\Large\@deptNameKor} \par
			{\LARGE \@authorKor}
	\end{minipage}
	\end{comment}
	\clearpage
}
% %%
% %% 제출지 인준지
% %%
\renewcommand{\makesubmit}{%
\thispagestyle{empty} \noindent
	\begin{minipage}[t][9cm][t]{\textwidth}
		\centering
			\Huge \@titleKor           % 학위논문 한글제목
                       \par 
			\LARGE \@titleSub           % 학위논문 한글제목
                       \par 
			\LARGE \@titleEng           % 학위논문 한글제목		
%                        \par 
% 			\Large\@titleEngSub           % 학위논문 한글제목
	\end{minipage}
	\vspace*{10mm}   
	
	\begin{minipage}[t][6cm][t]{\textwidth}
		\centering
			\LARGE
			이 논문을 \@degreeNameKor  청구논문으로 제출합니다\par \vfill  
			\@submitYear년 \@submitMonth월
	\end{minipage}
	\vspace{1cm}

	\begin{minipage}[t][2cm][b]{\textwidth}
		\centering
		{\huge건국대학교 대학원}\\

		{\LARGE\@deptNameKor} \\

		{\huge\@authorKor}\\
	\end{minipage}\\[0mm]
	\clearpage
}

\renewcommand{\makeapproval}{
	\thispagestyle{empty}
	{
	\centering \LARGE\bfseries \@authorKor의 \@degreeFieldKor~\@degreeNameKor 청구논문을 인준함.\\ %공대 외에서 쓰려면 수정해야함.
	\bigskip

	\if@isDoctor
	\begin{minipage}[t][11cm][b]{\textwidth}
	%
		\bfseries \Large\centering%
					%委 員 長
		{심사위원장\underline{\makebox[\widthof{안녕하세요 반갑습니다. }][r]{(인)}}} 
		\null\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
		\null\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
		\null\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
		\null\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
	\end{minipage}
	\else
	\begin{minipage}[t][7cm][b]{\textwidth}
		\Large\centering
		{심사위원장\underline{\makebox[\widthof{안녕하세요 반갑습니다. }][r]{(인)}}} 
		\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
		\vspace{1cm}
		{심사위원\underline{\makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(인)}}}
		\vspace{1cm}
	\end{minipage}
	\fi
	\vfill %\centering
	\begin{minipage}[t][2.0cm][t]{\textwidth}
		\centering \bfseries	\LARGE \@apprYear년 \@apprMonth월
	\end{minipage}
	
	\begin{minipage}[t][2cm][t]{\textwidth}
		\centering 	\bfseries \huge 건국대학교 대학원
	\end{minipage}\\[0mm]
        }
	\clearpage
	
}
%%
%% 초록(abstract)페이지 생성
%%
\newcommand{\@tempbreak}{\linebreak}  % \linebreak 명령 보관용
\newcounter{pagemarker}  % 페이지 번호 임시 저장용
%
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
%
% \usepackage{abstract}
\newenvironment{abstractKor}{%
% 	\pagenumbering{roman}  % 로마자 페이지 시작
	\clearpage
	\phantomsection
	\pagestyle{plain}%
	\addcontentsline{toc}{chapter}{국문초록}
	% 초록을 목차(TOC)에 삽입%
	\renewcommand{\linebreak}{\ } % \linebreak -> 공백 대체
	{\raggedleft \bfseries \Large국문초록}\\
	\begin{center}
		\textbf{\LARGE\@titleKor} % 초록명 -> Abstract
\\  
		\textbf{\Large\@titleEng}
	\end{center}%
		%여기에 초록이 들어옴.
}{%
%         \setcounter{pagemarker}{\thepage}             % 마지막 페이지 번호를 저장
%         \setcounter{pagemarker}{\value{\page}}             % 마지막 페이지 번호를 저장
    \\
    \vfill
	{\noindent\rule{\linewidth}{.5mm}}
	\\ \textbf{주제어} :\ \@keywordsKor
	\\
	%\\ \textbf{Student Number}:\ \@studentID
	\addtocounter{pagemarker}{1}% 백색별지분을 고려
% 	\newpage \pagenumbering{arabic}% 페이지 아라비아 숫자 포맷
	\let\linebreak\@tempbreak % \linebreak 명령 복원
    \indent
}
\newenvironment{abstractEng}{%
% 	\pagenumbering{roman}  % 로마자 페이지 시작
	\clearpage
	\phantomsection
	\pagestyle{plain}%
	%\addcontentsline{toc}{chapter}{영문초록}
	\addcontentsline{toc}{chapter}{ABSTRACT}
	% 초록을 목차(TOC)에 삽입

	\glsresetall
	\onehalfspacing
	\renewcommand{\linebreak}{\ } % \linebreak -> 공백 대체
	{\raggedleft \bfseries \Large ABSTRACT}
	\begin{center}
		\bfseries\LARGE\@titleEng\\
		\Large % 초록명 -> Abstract
	\end{center}%
	
	\begin{flushright}
       \bfseries\@authorEng \\
	\@deptNameEng \\
	\@kuEng
	\end{flushright}
		%여기에 초록이 들어옴.
		    \indent
}{%
%         \setcounter{pagemarker}{\thepage}             % 마지막 페이지 번호를 저장
%         \setcounter{pagemarker}{\value{\page}}             % 마지막 페이지 번호를 저장
    \\
    \vfill
	{\noindent\rule{\linewidth}{.4mm}}
	\\ \textbf{Keyword} :\ \@keywordsEng
	%\\ \textbf{Student Number}:\ \@studentID
	\addtocounter{pagemarker}{1}% 백색별지분을 고려
% 	\newpage \pagenumbering{arabic}% 페이지 아라비아 숫자 포맷
	\let\linebreak\@tempbreak % \linebreak 명령 복원
    \indent
}
%
%%
%% 목차 일괄 생성
%% 이거 서식작업 학교도서관에서 빠꾸나와서 잘해야함. 
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
%     \pagenumbering{roman}
\frontmatter
\tableofcontents \clearpage
	\listoftables \clearpage
	\listoffigures \clearpage
% 		\clearpage\pagenumbering{arabic}
}
\newcommand{\main}{%
\mainmatter \setlength\parindent{1.0em} 
	\renewcommand{\baselinestretch}{1.6}\selectfont %

}
\def\set@appendix@chapterkonkuk{%
  \gdef\@chapapp{\appendixname}%
%   \gdef\thechapter{\arabic{APPchapter}}%
  \gdef\thesection{\thechapter.\arabic{APPsection}}%
%  \counterwithout{figure}{chapter}\counterwithout{table}{chapter}%
  \counterwithin{figure}{APPchapter}\counterwithin{table}{APPchapter}%
  \counterwithin{equation}{APPchapter}%
  \renewcommand\thefigure{\thechapter.\arabic{figure}}%
  \renewcommand\thetable{\thechapter.\arabic{table}}%
  \renewcommand\theequation{\thechapter.\arabic{equation}}%
  \set@appendix@chapsec
%   \renewcommand\hchaptertitlehead{[\appendixname\\thechapter.]}%
}

\renewcommand{\appendix}{\par
 \setcounter{chapter}{1}%
%  \setcounter{section}{0}%
 \gdef\@chapapp{\appendixname}%
%  \gdef\thechapter{\@Alph\c@chapter}%
  \set@appendix@chapterkonkuk
  \anappendixtrue
  \chapterstyle{appendixkonkuk}%
}

\newcommand{\back}{%
	\backmatter
	%\addcontentsline{toc}{chapter}{{ 부록}}
	\appendix
}
\AppendixTitleToToc
\AttachAppendixTitleToSecnum
%\AppendixTitle
\endinput
