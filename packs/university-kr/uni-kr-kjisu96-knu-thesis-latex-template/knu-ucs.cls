%% TeX: UTF-8
%%
%% Kyungpook National University Thesis Template for LaTeX
%% 경북대학교 학위 논문 LaTeX 양식
%%
%% @releasedate  Mar. 2025
%%
%% @author       Jisu Kwon
%%               mailto: kjisu96@knu.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% Acknowledgement
%% 본 템플릿은 2가지 양식을 참고하여 작성되었습니다. 제작자 분들께 감사를 표합니다.
%% 1. 겉표지, 인준서
%%    - https://github.com/seonho/KNU-Thesis.git
%% 2. 본문
%%    - POSTECH LaTeX Thesis Template
%%    - https://github.com/lonelywing/POSTECH_thesis_template_latex.git
%% 

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{knu-ucs}%
%       [2020/7/9 v0.6 Standard POSTECH Thesis document class, ko.TeX version]

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
\DeclareOption{english}{\@isKoreanfalse}
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

%% 11pt,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[11pt,onecolumn,oneside]{report} % ver0.3 : 본문 글자 크기 11pt


%%들여쓰기
\usepackage{indentfirst}
\setlength\parindent{2.0em}

%폰트 Times Roman으로 변경 (Times New Roman은 기본 패키지에 탑재되어 있지 않음.) ver0.5
\renewcommand{\rmdefault}{ptm}

%%zref package is used for page referencing.
\usepackage{refcount}
\usepackage[savepos,totpages,titleref,dotfill,counter,user]{zref}
%\usepackage{zref-thepage}

%\usepackage{tocloft}
%\renewcommand{\cftchapfont}{\rmdefault}

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
      bookmarks=true,%
     colorlinks=true,%
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
    % \checkparameters                         % 문서 변수가 올바른지 점검
    \if@isFinal                              % final 옵션이 지정되어 있으면
        % \makefrontcover \maketitle         % 앞표지, 속표지 생성
        % \maketitle                         % 앞표지, 속표지 생성
        % \makeapproval                      % 제출승인서, 심사완료검인 생성
    \else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 편집용지 설정 ver0.5
\usepackage[paperheight=257mm,paperwidth=182mm,
			left=25mm,right=25mm,top=35mm,bottom=30mm]{geometry}
%상단여백 20
%하단여백 15
%머리말 15
%꼬리말 15
%왼쪽 25
%오른쪽 25
%top=상단여백+머리말 bottom=하단여백+꼬리말
%용지 사이즈 JIS B5 257X182 (국내 4X6 배판)

%% ver0.2 : blank page 정의
\usepackage{afterpage}
\newcommand\blankpage{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage}

%% 줄간격 설정
%\renewcommand{\baselinestretch}{1.3}
\linespread{1.4}			% ver0.2 : 줄간격 170 이상

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi


%% pagestyle
\def\ps@postech{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil--\ \thepage\ --
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{postech}

\def\@title{\title}
\def\@titleKor{최종 논문 제목}
\def\@author{\author}
\def\@authorKor{홍\space\space\space\space\space길\space\space\space\space\space동}
\def\@major{\major}
\def\@majorKor{전자전기공학부 정보통신전공}
\def\@advisor{Gildong Hong}
\def\@advisorKor{김철수}
\def\@degreedate{\degreedate}

\def\@refereeChief{Gildong Hong}
\def\@refereeSecond{Chulsoo Kim}
\def\@refereeThird{Gildong Hong}
\def\@refereeFourth{Gildong Hong}
\def\@refereeFifth{Gildong Hong}

\newcommand{\major}[1]{\def\@major{#1}}
\newcommand{\degreedate}[2]{\def\@degreedate{#2 #1}}


\renewcommand{\maketitle}{
    \renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty}
	\begin{center}
		% space at least 3cm
		% \vspace*{3cm}
		% 12pt 명조, 굵게
		{\fontsize{11pt}{1pt}\selectfont Thesis for the Degree of Ph.D.}\\
		% space at least 2cm
		\vspace{2cm}
		% 21pt 바탕, 굵게
		{\fontsize{21pt}{1pt}\selectfont \@title}\\
		% space at least 3cm
		\vspace{3cm}
		% 12pt 바탕, 굵게
		{\fontsize{12pt}{1pt}\selectfont \@major\\The Graduate School}\\
		% space at least 2cm
		\vspace{2cm}
		% 14pt 바탕, 성과 이름은 띄어쓰고 이름의 각 음절은 붙여 씀
		% 예) Hong Gildong 또는 Hong Gil-dong
		{\fontsize{14pt}{1pt}\selectfont \@author}\\
		% space fill
		\vspace{6.6cm}
		% 12pt 바탕, 굵게, 1학기 June, 2학기 December
		{\fontsize{12pt}{1pt}\selectfont \noindent \@degreedate}\\
		% space at least 1cm
		\vspace{1cm}
		% 16 pt 맑은 고딕, 굵게
		{\fontsize{16pt}{1pt}\selectfont The Graduate School\\Kyungpook National University}\\
		% space at least 2cm
		% \vspace*{2cm}
		% finish title page
	\end{center}
    \newpage
}


%%
%% 학위논문 제출승인서 및 심사완료 검인서 생성
%%
\newcommand{\makeapproval}{
    \renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty}
	% \newgeometry{left=2cm,top=2.5cm,right=2cm,bottom=1.5cm}
	% \setstretch{1.3}
	\begin{center}
		% space at least 3cm
		% \vspace*{3cm}
		{\fontsize{21pt}{1pt}\selectfont \@title}\\
		% space at least 1cm
		\vspace{2cm}
		% 14pt 바탕, 성과 이름은 띄어쓰고 이름의 각 음절은 붙여 씀
		% 예) Hong Gildong 또는 Hong Gil-dong
		{\fontsize{14pt}{1pt}\selectfont \@author}\\
		% space at least 1cm
		\vspace{1cm}
		% 12pt 바탕
		{\fontsize{12pt}{1pt}\selectfont \@major\\The Graduate School}\\
		% space at least 1cm
		\vspace{1cm}
		{\fontsize{12pt}{1pt}\selectfont Supervised by Professor \@advisor}\\
		% space at least 1cm
		\vspace{1.7cm}
		{\fontsize{12pt}{1pt}\selectfont Approved as a qualified thesis of \@author\\for the degree of Ph.D.~by the Evaluation Committee}\\
		% space at least 1cm
		\vspace{1cm}
		% 12pt 바탕, 1학기 June, 2학기 December
		{\fontsize{12pt}{1pt}\selectfont \@degreedate}\\
		% space at least 1cm
		\vspace{0.5cm}

        \begin{flushright}
            \renewcommand{\arraystretch}{1.5}    
            \begin{tabular}{r c r}   % 심사위원명단
                {\fontsize{12pt}{24pt}\selectfont Chairman} 
                    & \underline{\textbf{\@refereeChief}\hspace{2.8cm}\textcircled{인}} \\ 
                & \underline{\textbf{\@refereeSecond}\hspace{2.8cm}\textcircled{인}} \\
                & \underline{\textbf{\@refereeThird}\hspace{2.8cm}\textcircled{인}} \\
                & \underline{\textbf{\@refereeFourth}\hspace{2.8cm}\textcircled{인}} \\
                & \underline{\textbf{\@refereeFifth}\hspace{2.8cm}\textcircled{인}}
            \end{tabular}
        \end{flushright}        

		\vspace{0.4cm}
		{\fontsize{14pt}{1pt}\selectfont The Graduate School Council\\Kyungpook National University}\\
		% \vspace*{2cm}
	\end{center}
	% \restoregeometry
    \newpage
}

%%
%% 초록(abstract)페이지 생성
%%
\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\renewenvironment{abstract}{%
    %\thispagestyle{plain}

    \begin{center} \Large \textbf{ABSTRACT} \end{center}      % 초록명 -> Abstract
    \vspace{8mm}
    \hspace*{5mm}
    \chapter*{ABSTRACT}
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\rmfamily{Abstract (in English)}}% 초록을 목차(TOC)에 삽입    
    \fontsize{11pt}{19pt}\selectfont

}
{
%	  \label{pg:abstractLastPage}
	  \newpage
  	%   \setcounter{pagemarker}{\value{page}}

     %\pagenumbering{Roman}
%\pagenumbering{arabic}              % 페이지 아라비아 숫자 포맷
\let\linebreak\@tempbreak                    % \linebreak 명령 복원
%    \afterpage{\blankpage}                      % % ver0.2 : 초록 이후 백색별지
}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
    \tableofcontents
    \listoftables
    \listoffigures
}

%%%% 부록 section을 위한...
\renewenvironment{appendix}{
	\setcounter{chapter}{0}
	\renewcommand{\thechapter}{\Alph{chapter}}
	\renewcommand{\thesection}{\Alph{chapter}.\arabic{section}} %ex) A.1
	\renewcommand{\thefigure}{\Alph{chapter}.\arabic{figure}} %ex) A.1
	\renewcommand{\thetable}{\Alph{chapter}.\arabic{table}} %ex) A.1
	\renewcommand{\theequation}{\Alph{chapter}.\arabic{equation}} %ex) A.1
}
%%%%


%%
%% 한글요약문 생성 - 영문논문의 경우만 해당
%%
\newenvironment{summary}{%              % 요약문 생성 환경
    \thispagestyle{postech}               % ver0.2 : 국문 요약문 쪽번호 유지
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }      % \linebreak 명령 바꿔치기
    \if@isKorean
    \else
        \chapter*{Summary}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{Abstract (in Korean)}}
        \begin{quote}
            \begin{center}
                \noindent \textsf{\Large \@titleEng} \\[6mm]
            \end{center}
        \end{quote}% \setlength{\parindent}{0pt}
    \fi
}{  \let\linebreak\@tempbreak          % \linebreak 명령 되돌리기
}

\newcommand{\summarykorean}{%           % ver 0.1 요약문 생성 명령
    \renewcommand{\linebreak}{\ }      % 차후 버젼에서 삭제 예정
   	\setlength{\parindent}{10pt}
    \ifx\@textlang\@english
        % \chapter*{요 약 문}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{Abstract (in Korean)}}

        \begin{center}
            % \noindent\textsf{\Large \@title} \\[6mm]
            {\fontsize{12pt}{1pt}\selectfont \textbf{\@titleKor}}\\
            \vspace{1cm}
            {\fontsize{10pt}{1pt}\selectfont \textbf{\@authorKor}}\\
            \vspace{1cm}
            {\fontsize{9pt}{1pt}\selectfont 경북대학교 대학원 \@majorKor \\ (지도교수 \@advisorKor)}\\
        \end{center}% \setlength{\parindent}{0\p@}

        \vspace{1.3cm}
        {\fontsize{12pt}{1pt}\selectfont (초\space\space\space록)}\\
        \fontsize{10pt}{1pt}\selectfont
    \fi
}

\newcommand{\summaryenglish}{%           
    \renewcommand{\linebreak}{\ }
   	\setlength{\parindent}{10pt}
    \ifx\@textlang\@english
        \chapter*{ABSTRACT}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{Abstract (in English)}}        
        \fontsize{11pt}{19pt} \selectfont
    \fi
}

%%
%% 감사의 글 및 이력서 생성
%%
\newcommand{\acknowledgement}[1][default]{%     % 이력서
   % \thispagestyle{empty} \noindent             % ver0.2 : 쪽 번호없음
	\setlength{\parindent}{10pt}
    \newcommand{\@acklang}{#1}
    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
        {\let\@acklang\@textlang}{}           % 논문 언어대로 이력서 언어설정
%    \ifthenelse{\equal{\@acklang}{\@korean}}
%        {\chapter*{감 사 의 글}}                 % korean  옵션일 경우
        {\chapter*{Acknowledgements}}         % english 옵션일 경우
}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{%
    \if@isKorean 목 차       \else Contents        \fi}
\renewcommand{\listfigurename}{%
    \if@isKorean 그 림 목 차 \else List of Figures \fi}
\renewcommand{\listtablename}{%
    \if@isKorean 표 목 차    \else List of Tables  \fi}
\renewcommand{\bibname}{%
    \if@isKorean 참 고 문 헌 \else References      \fi}

%%%
%%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%%
\renewcommand\part{%
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%

\renewcommand{\thechapter}{\Roman{chapter}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\Roman{part}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\arabic{chapter}} %Enumerate chapter as Roman number
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}} %Enumerate section as arabic number
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}} % ver0.2 : figure 번호를 아라비아 숫자로 표기
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}   % ver0.2 : table 번호를 아라비아 숫자로 표기
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

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
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{%
        \protect \rmfamily{\numberline{\thechapter.}}#1
        }% <-- 목차에 나타나는 형식 - 변경사항
    \else
       \addcontentsline{toc}{chapter}{#1}%
%       \addcontentsline{toc}{}{#1}%
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
    %{\centering \parindent\z@ \LARGE\bfseries
%    \ifthenelse{\equal{\@textlang}{korean}}
%        {제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
%        {Chapter\hspace{1.4ex}\thechapter.\hspace{1ex}}
%        {\thechapter.\hspace{1ex}}
    \thechapter.\hspace{1ex}
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
    {\centering \parindent\z@ \LARGE\bfseries #1\par}
    \vspace*{20\p@}
}

%%
%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\tableofcontents{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
	\chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
%   \pagenumbering{arabic}                         % Roman 페이지번호로 복원

%    \addtocounter{pagemarker}{1}
% 	\setcounterpageref{page}{pg:abstractLastPage}
    \setcounter{pagemarker}{\value{page}}

%	\addtocounter{pagemarker}{1}
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname} % 목차(TOC)에 추가
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    % \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
%    \pagenumbering{arabic}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% 목차(TOC)에 추가
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\listtablename}% 목차(TOC)에 추가
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
%    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
%    \pagenumbering{arabic}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% 목차(TOC)에 추가
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\listfigurename}% 목차(TOC)에 추가
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%
%\newcommand{\l@content}{\normalsize\bf\@dottedtocline{1}{0em}{0em}}
\newcommand{\l@content}{\normalfont\normalsize\@dottedtocline{1}{0em}{0em}}

\renewcommand*\l@chapter[2]{%
   % \thispagestyle{plain}           % ver0.2 : 목차 쪽번호 유지
    \thispagestyle{postech}           % ver0.2 : 목차 쪽번호 유지
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip 1.3em \@plus\p@      % ver0.2 : 줄간격 조정
        \if@isKorean                     % <-- 변경 부분
            \setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
        \else
            \setlength\@tempdima{2.0em} % english 옵션일 때는 2.0em
        \fi
        \begingroup
            \parindent \z@\rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \normalsize \sffamily \bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak \hfil \nobreak\hb@xt@\@pnumwidth{\hss\rmfamily #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi}


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
    \chapter*{\rmfamily{\bibname}}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{\bibname}}%
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
}{  \label{paperlastpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
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
