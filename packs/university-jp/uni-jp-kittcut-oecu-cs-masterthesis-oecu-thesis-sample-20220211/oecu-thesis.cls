%%% oecu-thesis.cls --- class for OECU thesis

%%% 2008年12月30日 北嶋 暁

%   * 特別研究用に\論文種別{}を導入
%   * 章の最初の段落がインデントされないのを修正
%   * subsubsection以降で番号付けしないように変更(あまり細かく分けるべきでない. )

%%% 2008年1月22日 升谷 保博
%%% 2010年1月25日 渡辺
%%% 2022年1月13日
%%% 2023年2月11日 升谷 保博（修士論文以外はテストしていない）

%%%%%%%%%% 以下のファイルを元に改変
%%% Copyright 2002-2004 Kitajima Akira.

%%% Author: KITAJIMA Akira <kitajima@isc.osakac.ac.jp>
%%% Create: Wed, Feb. 5, 2002

%%% $Id: oecu-thesis.cls,v 1.19 2008/01/10 08:10:03 kitajima Exp kitajima $
%%%%%%%%%%

\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{oecu-thesis}[2008/01/22 OECU thesis class]

%%% ページ
\def\ps@draft{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@draft
   \let\@oddhead\@empty
   \def\@oddfoot{\reset@font\hfil[\today \the\hour 時
   \the\minute 分 (\@author)]\quad
     $\mathit{\thepage}$\hspace*{1zw}}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot}
\def\ps@thesis{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@thesis
   \let\@oddhead\@empty
   \def\@oddfoot{\reset@font\hfill$\mathit{\thepage}$\hspace*{1zw}}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot
   }
\def\ps@oecu{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@oecu
   \renewcommand{\@oddhead}{{\rightmark}\hfill}
   \def\@oddfoot{\reset@font\hfil{\Large \makebox[61mm][s]{大阪電気通信大学大学院}}\hfil\null}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot
   }
\def\ps@oecuabst{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@oecuabst
   \renewcommand{\@oddhead}{{\rightmark}\hfill}
   \def\@oddfoot{\reset@font\hfil{\Large \makebox[61mm][s]{大阪電気通信大学大学院}}\hfil\null}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot
   }
\def\ps@paperlist{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@paperlist
   \renewcommand{\@oddhead}{{\rightmark}\hfill}
   \def\@oddfoot{}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot
   }
\def\ps@format{%
  \renewcommand{\@oddhead}{{\rightmark}\hfill}%
  \renewcommand{\@evenhead}{}%
  \renewcommand{\@evenfoot}{}%
  \renewcommand{\@oddfoot}{}%
}

\newif\if修士論文\修士論文false
\DeclareOption{master}{\修士論文true}

\newif\ifnotitlepage\notitlepagefalse
\DeclareOption{notitlepage}{\notitlepagetrue}

\newif\ifdraft\draftfalse
\DeclareOption{draft}{\pagestyle{draft}\drafttrue}

\newif\ifsmallfont\smallfontfalse
\DeclareOption{9pt}{%\def\baselinestretch{1.21}
  \smallfonttrue
  \let\large=\normalsize
  \renewcommand{\normalsize}{%
  \@setfontsize\normalsize\@ixpt{11}%
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 4\p@ \@plus2\p@ \@minus2\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
            \addtolength\baselineskip{2\p@}%
  \belowdisplayskip \abovedisplayskip}%
%  \let\normalsize=\small
  \let\small=\footnotesize
  \normalsize}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{jreport}}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{jarticle}}
\ProcessOptions

\LoadClass[fleqn,titlepage]{jreport}
%\LoadClass[fleqn,titlepage]{jarticle}
\usepackage{plext}
%ページの領域を表示する（デバッグ用）
%\usepackage{showframe}
\usepackage{geometry}

\西暦true

\if@twocolumn
\def\baselinestretch{1.05}
\else
\def\baselinestretch{1.22}
\fi

\ifdraft
\pagestyle{draft}
\else
\pagestyle{thesis}
\fi

%%% 大きさ・長さの調整
\oddsidemargin=-1in
\addtolength{\oddsidemargin}{34mm}
\topmargin=-1in
\addtolength{\topmargin}{30mm}
\addtolength{\topmargin}{-\headsep}
\addtolength{\topmargin}{-\headheight}
%% \ifdraft
%%   \footskip=5mm
%% \else
%%   \footskip=12mm
%% \fi
% a4 の高さ……297mm
\textheight=232mm
% a4 の幅……210mm
\textwidth=148mm
\columnsep=2zw
\raggedbottom
\parskip=\z@
\partopsep=\z@

\dbltextfloatsep=15pt
\textfloatsep=15pt

\abovecaptionskip=\z@
\belowcaptionskip=10pt

%% 数式モード
% \abovedisplayskip=\z@
% \belowdisplayskip=\z@
% \abovedisplayshortskip=\z@
% \belowdisplayshortskip=\z@
\topsep=\z@
\jot=\z@

%%% from ipsjpapers.sty
\def\ipsj@warning{\ClassWarning{ipsjreport}}                    % 2.00(3)

\newdimen\@mojihaba \@mojihaba=1zw

\newdimen\@Q \@Q=0.25mm

\newif\ifDS@english \DS@englishfalse

\let\fs@header\footnotesize
\let\fs@abst\small
\def\fs@eabst{\small\baselineskip13\@Q}
\let\fs@type\fn@fontxv
\let\fs@title\huge
\let\fs@author\large
\let\fs@chap\Large
\let\fs@sec\large
\let\fs@subsec\normalsize
\let\fs@affil\large

\let\jintercharskip\kanjiskip
\let\jasciikanjiskip\xkanjiskip
\let\jmathkanjiskip\xkanjiskip
\newdimen\jspaceskip \jspaceskip1zw

%%% 卒業論文の情報マクロ

\def\@論文種別{卒業論文}
\newcommand{\論文種別}[1]{\def\@論文種別{#1}}
\def\@指導教員{}
\newcommand{\指導教員}[1]{\def\@指導教員{#1}}
\def\@所属{}
\newcommand{\所属}[1]{\def\@所属{#1}}
\def\@専攻{}
\newcommand{\専攻}[1]{\def\@専攻{#1}}
\def\@学生番号{}
\newcommand{\学生番号}[1]{\def\@学生番号{#1}}
\def\@年度{平成??}
\newcommand{\年度}[1]{\def\@年度{#1}}

\def\@研究科{総合情報学}
\newcommand{\研究科}[1]{\def\@研究科{#1}}

\def\title{%
  \@ifnextchar[%]
  {\@defxtitle}{\@deftitle}}%
\def\@defxtitle[#1]#2{\gdef\@title{#2}\gdef\@titleabstract{#1}}
\def\@deftitle#1{\gdef\@title{#1}\gdef\@titleabstract{#1}}


%%% 表紙

\renewcommand{\maketitle}{\begin{titlepage}%
\if修士論文
\thispagestyle{oecu}
\newgeometry{a4paper,textheight=240mm,width=185mm,top=12.7mm,left=12.7mm,includeheadfoot=true,headsep=10mm,footskip=15mm}
\markright{\scriptsize 様式---M02}
\vspace*{10mm}
\large

\noindent\hfill{\huge\makebox[45mm][s]{修士学位論文}}\hfill
\vspace{23mm}

{\large\makebox[16mm][s]{論文題目}}
\vspace{7mm}

\noindent\underline{\makebox[182mm][c]{\ \Large\shortstack{\@title}\ }}
\vfill

\renewcommand{\arraystretch}{1.4}
\hspace*{64mm}%
\begin{tabular}{ll}
\makebox[3zw][s]{専攻} &
        \hspace{0.5zw}\makebox[6zw][s]{\@専攻}\\
\makebox[3zw][s]{コース} &
        \hspace{0.5zw}\normalsize\makebox[6zw][s]{\@所属}\\
\makebox[4zw][s]{学生番号}& 
        \underline{\makebox[60mm][l]{\hspace{0.5zw}\Large\@学生番号}}\\
\makebox[3zw][s]{氏名}&
        \underline{\makebox[60mm][l]{\hspace{0.5zw}{\Large\@author}}}\\
\makebox[6zw][s]{担当指導教員} &
        \underline{\makebox[60mm][l]{\hspace{0.5zw}\Large\makebox[6zw][s]{\@指導教員}}}\\
\makebox[6zw][s]{申請年月日} &
        \underline{\makebox[60mm][s]{\hspace{3zw}\@date}}
\end{tabular}
\restoregeometry

\else% 卒業論文
  \let\footnotesize\small
  \let\footnoterule\relax
  \let\footnote\thanks
  \null\vfil
  \vskip 80\p@
  \begin{center}%
    {      \large \@年度 年度%
      \vskip 2ex%
    \Large \makebox[40mm][s]{\@論文種別}}%
    \vskip 6ex%
    {\LARGE \@title \par}%
    \vfill%
    {\lineskip 1.5ex%
      \begin{tabular}[t]{c}%
        {\Large\@学生番号\quad\@author}
      \end{tabular}\par}%
      \vskip 3ex%
    {\large 指導教員\quad\@指導教員}\hspace{10mm}\fbox{印}\\%
	  \underline{\tiny 注意: 教員印またはサインがないものは受理しない。}\\[4ex]
      {\normalsize\@date}\\[10ex]%
      {\large{\spaceskip=1zw 大阪電気通信大学 \@所属}\par}%
  \end{center}\par
  \@thanks\vfil\null
\fi
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
%   \global\let\@author\@empty
%   \global\let\@date\@empty
%   \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

%%% 貼り付け用表紙 (背表紙を含む)
\newcommand{\makeextratitle}{%
\thispagestyle{empty}
\hspace{-20mm}
\begin{minipage}<t>{\textwidth}
\framebox[30mm][c]{%
\parbox<y>{\textwidth}{\centering
\large\bigskip
\if修士論文
修士学位論文
\else
\@論文種別
\fi\\
\LARGE\@title
\bigskip}}
\framebox[30mm][c]{%
\parbox<y>{\textwidth}{\centering
\large\bigskip
    {\Large
     \lineskip 1.5ex%
      \begin{tabular}[t]{c}%
        \@学生番号\ \ \@author 
      \end{tabular}\par}%
    {\large 大阪電気通信大学%
\if修士論文
大学院\@研究科{}研究科\@所属 専攻%
\else
 \@所属
\fi
\par
\medskip
\@date
\bigskip
\par}
\bigskip}}
\framebox[30mm][c]{%
\parbox<y>{\textwidth}{\centering
\large\bigskip
\if修士論文
修士学位論文
\else
\@論文種別
\fi\\
\LARGE\@title
\bigskip}}
\framebox[30mm][c]{%
\parbox<y>{\textwidth}{\centering
\large\bigskip
    {\Large
     \lineskip 1.5ex%
      \begin{tabular}[t]{c}%
        \@学生番号\ \ \@author 
      \end{tabular}\par}%
    {\large 大阪電気通信大学%
\if修士論文
大学院\@研究科{}研究科\@所属 専攻%
\else
 \@所属
\fi
\par
\medskip
\@date
\bigskip
\par}
\bigskip}}
\vskip10mm
\parbox<t>{\textheight}{\makebox[160mm]{\@titleabstract}\hfill\@学生番号\quad \@author\quad \@date}
\vskip5mm
\parbox<t>{\textheight}{\makebox[160mm]{\@titleabstract}\hfill\@学生番号\quad \@author\quad \@date}

\end{minipage}
\cleardoublepage}

%%% 修士学位論文目録
\newcommand{\paperlist}[1]{%
\begingroup
\large
\thispagestyle{paperlist}
\newgeometry{a4paper,textheight=237mm,width=184mm,top=12.7mm,left=12.7mm,includeheadfoot=true,headsep=13mm}
\markright{\scriptsize 様式---M03}
\hfill{\large \makebox[46mm][s]{\quad\@date}}%

\noindent 大阪電気通信大学大学院\\
\hspace*{1zw}\@研究科{}研究科長

\vspace{7mm}
\renewcommand{\arraystretch}{1.3}
\hspace*{64mm}
\begin{tabular}{ll}
\makebox[3zw][s]{専攻} & 
        \quad\@専攻\\
\makebox[3zw][s]{コース} &
        \quad\normalsize\@所属\\
\makebox[4zw][s]{学生番号}& 
        \underline{\makebox[67mm][l]{\quad\Large\@学生番号}}\\
\makebox[3zw][s]{氏名}&
        \underline{\makebox[67mm][l]{\quad\@author}}
\end{tabular}
\vspace{10mm}

\hfill{\huge \makebox[61mm][s]{修士学位論文目録}}\hfill
\vspace{22mm}

\noindent
{\Large \makebox[6zw][s]{学位論文題目}}
\vspace{10mm}

\noindent
\hfill{\ \Large\shortstack{\@title}\ }\hfill
\vspace{10mm}

\noindent
\makebox[37mm][s]{\Large 関連する業績等}
\vspace{10mm}
#1
\vfill
\hfill
\underline{\makebox[72mm][l]{担当指導教員\quad\Large\@指導教員}}
\restoregeometry
\endgroup
\cleardoublepage
}


%%% 時間(ページに使用)
%%% from time.sty by Sunando Sen <sens@nyuacf.bitnet> <sens@acfcluster.nyu.edu>
\newcount\hour
\newcount\minute
\hour=\time
\divide \hour by 60
\minute=\time
\count99=\hour \multiply \count99 by -60 \advance \minute by \count99

%%%%%% Font Size Macros %%%%%%

\def\fs@setsize#1#2#3#4{\normalsize\dimen@\normalbaselineskip
        \@ifstar{\@setsize{#1}{\dimen@}{#3}{#4}}%
                {\@setsize{#1}{#2}{#3}{#4}}}

% s = (4*b - (h' + d') - (h + d))/2
% s_a = s + h' + d - b
% s_b = s + h + d' - b
\def\sec@setskips#1{\setbox0\hbox{\fs@sec\bf#1}\setbox1\hbox{#1}
        \@tempdima4\baselineskip
        \advance\@tempdima-\ht0 \advance\@tempdima-\dp0
        \advance\@tempdima-\ht1 \advance\@tempdima-\dp1
        \divide\@tempdima\tw@ \advance\@tempdima-\baselineskip
        \@tempdimb\@tempdima
        \advance\@tempdima\ht0 \advance\@tempdima\dp1
        \advance\@tempdimb\ht1 \advance\@tempdimb\dp0
        \edef\sec@aboveskip{\the\@tempdima}
        \edef\sec@belowskip{\the\@tempdimb}}

\sec@setskips{A}

%%% from ipsjcommon.sty

%%%%%% Sectioning Commands %%%%%%

\renewcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{jpl@in}%
  \global\@topnum\z@
%  \@afterindentfalse
  \secdef\@chapter\@schapter}

\def\@makechapterhead#1{\hbox{}%
  \vskip0\Cvs
  {\parindent\z@
   \raggedright
   \fs@chap\bfseries
   \leavevmode
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
     \setbox\z@\hbox{\@chapapp\thechapter\@chappos\hskip1zw}%
     \addtolength\@tempdima{-\wd\z@}%
     \unhbox\z@\nobreak
     \vtop{\hsize\@tempdima\sec@mojidori{#1}}%
   \else
     \sec@mojidori{#1}\relax
   \fi}\nobreak\vskip1\Cvs}

\def\@makeschapterhead#1{\hbox{}%
  \vskip0\Cvs
  {\parindent\z@
   \raggedright
   \fs@chap\bfseries
   \leavevmode
   \setlength\@tempdima{\linewidth}%
   \vtop{\hsize\@tempdima\sec@mojidori{#1}}}\vskip1\Cvs}

\def\section{\@startsection
        {section}{1}{\z@}{1ex}{0.5ex}{\fs@sec\bf}}
\def\subsection{\@startsection
        {subsection}{2}{\z@}{1ex}{0.5ex}{\fs@subsec\bf}}
\def\subsubsection{\@startsection
        {subsubsection}{3}{\z@}{\z@}{\z@}{\fs@subsec\bf}}
\def\paragraph{\@startsection
        {paragraph}{4}{\z@}{\z@}{-\@mojihaba}{\fs@subsec\bf}}
\def\subparagraph{\@startsection
        {subparagraph}{5}{\@mojihaba}{\z@}{-\@mojihaba}{\fs@subsec\bf}}

%% \def\thesection{\thechapter.\arabic{section}}
%% %\def\sec@section@postfix{.}
%% \def\thesubsection{\thesection.\arabic{subsection}}
%% \def\thesubsubsection{\thesubsection.\arabic{subsubsection}}
%% \def\theparagraph{\thesubsubsection.\arabic{paragraph}}
%% \def\thesubparagraph{\theparagraph.\arabic{subparagraph}}

\setcounter{secnumdepth}{2}

%% \def\appendix{\let\sec@sec\section
%%         \def\section{\@startsection
%%                 {section}{1}{\z@}{\sec@aboveskip}{1ex}{\fs@subsec\bf}}%
%%         \def\thesection{\appendixprefix\arabic{section}}%
%%         \def\sec@section@postfix{\appendixpostfix}%
%%         \stepcounter{section}\setcounter{section}{0}%
%%         \@ifnextchar[%]
%%                      {\sec@oappendix}{\sec@xappendix}}
%% \def\sec@xappendix{\@ifstar{\let\section\sec@sec}%
%%         {\sec@sec*{\ifDS@english Appendix\else 付録\fi}}}
%% \def\sec@oappendix[#1]{\sec@sec*{\ifDS@english Appendix: \else
%%         付録\hskip\jspaceskip\fi #1}}
%% \def\appendixprefix{A.}
%% \def\appendixpostfix{}

% \def\acknowledgment{\par
%         {\bf \ifDS@english Acknowledgments\else 謝辞\fi}\hskip\@mojihaba
%         \ignorespaces}
% \let\endacknowledgment\par

% Modified \@startsection has a trick for 2行取り of \section, which must
% work even if \section appears the top of a page.  The BEFORESKIP must be
% inserted with respect to the previous baseline.  So, we must go back to
% the imaginary previous baseline at the top of a page.  That is, we do;
%       \vskip\baselineskip \vspace*{-\baselineskip}
% which resuls;
%       <a> do nothing at midpage
%       <b> go to the first baseline by \topskip, then go back to 0th
%           baseline by \vspace*.
% The trick "\vskip-\prevdepth \prevdepth\z@" will assure exact vertical
% space even when the last line has much depth.
%
% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
        \par \@tempskipa #4\relax
        \@afterindenttrue
        \ifdim\@tempskipa<\z@ \@tempskipa-\@tempskipa \@afterindentfalse\fi
        \if@nobreak \everypar{}\else \addpenalty{\@secpenalty}\fi
        \ifdim\@tempskipa>\z@
% Here is the trick for \section.
                \vskip-\prevdepth \prevdepth\z@ \vskip\baselineskip
                \vspace*{-\baselineskip}\vskip\@tempskipa\fi
        \@ifstar
        {\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{%
            \@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

% \@sect is modified to cope with `.' for \section and 文字取り
%
% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}[TITLE]{TITLE}
\def\@sect#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
        \def\@svsec{}\else 
        \refstepcounter{#1}
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}%
                                                                % 2.00(1)>>
        \let\@@protect\protect \def\protect{\noexpand\protect\noexpand}
        \edef\@svsec{\csname the#1\endcsname \csname sec@#1@postfix\endcsname
                \hskip\@mojihaba} \let\protect\@@protect\fi     % 2.00(1)<<
        \@tempskipa #5\relax
        \ifdim \@tempskipa<\z@ 
                \def\@svsechd{#6\hskip #3\relax%\@svsec
 #8}      % 2.00(1)
        \else
                \begingroup #6\relax
                \@hangfrom{\hskip #3\relax\@svsec}%
                        {\interlinepenalty\@M \sec@mojidori{#8}\par}%
                \endgroup
        \fi \@xsect{#5}}

% \@ssect is modified to cope with 文字取り
%
% \@sect{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}{TITLE}
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
        \ifdim \@tempskipa<\z@ \def\@svsechd{#4\hskip #1\relax #5}%
        \else \begingroup #4%
                \@hangfrom{\hskip #1}{\interlinepenalty\@M
                        \sec@mojidori{#5}\par}\endgroup
        \fi \@xsect{#3}}

%% Modify \@xsect to avoid (buggy) \clubpenalty=10000. (H.N.)
\def\@xsect#1{\@tempskipa #1\relax
        \ifdim \@tempskipa<\z@
                \global\@nobreakfalse \global\@noskipsectrue
                \everypar{\global\@noskipsecfalse \hskip-\parindent
                        \begingroup \@svsechd \endgroup \unskip
                        \hskip -#1\everypar{}}%
        \else
                \par \nobreak
                \vskip \@tempskipa \global\@nobreaktrue
                \everypar{\global\@nobreakfalse
                        \if@afterindent\else {\setbox0\lastbox}\fi \everypar{}}
        \fi\ignorespaces}

% Here is a trick for 文字取り of sectioning title.  The rule is;
%       2 - 4 Kanji char -> 5 Kanji char
%       otherwise    -> natural width
%
\def\sec@mojidori#1{\setbox0\hbox{#1}\settowidth\@tempdimb{あ}%
        \ifdim\wd0>4.5\@tempdimb #1\else
        \ifdim\wd0<1.5\@tempdimb #1\else
        \jintercharskip\fill \jasciikanjiskip\fill \jmathkanjiskip\fill
        \leavevmode\hbox to5\@tempdimb{#1\hfil}\fi\fi}

%%%%%% List-like Environments %%%%%%
%
%               LM      RM      LW      LS      LPI     II
% default       2K      0       0.75K   0.25K   0       0
% \enumerate    3K      0       3K      0       0       0
% \enumerate*   1K      0       3K      0       0       2K
% \itemize      2K      0       2K      0       0       0
% \itemize*     1K      0       2K      0       0       1K
% \description  2K      0       0       1K      0       -1K
% \description* 1K      0       0       1K      0       0
% \verse        3K      2K      0.75K   0.25K   -1K     -1K
% \quotation    2K      2K      0.75K   0.25K   1K      1K
% \quote        2K      2K      0.75K   0.25K   0       0
%
% where LM is \leftmargin, RM is \rightmargin, LW is \labelwidth, LS is
% \labelsep, \LPI is \listparindent, II is \itemindent, and K is Kanji char
% width (\@mojihaba).
%
% All vertical space parameters, \topsep, \partopsep, \itemsep and \parsep,
% are 0pt.

\leftmargini2\@mojihaba
\leftmarginii2\@mojihaba
\leftmarginiii2\@mojihaba
\leftmarginiv2\@mojihaba
\leftmarginv2\@mojihaba
\leftmarginvi2\@mojihaba

\def\lst@listi{\labelsep.75\@mojihaba \labelwidth.25\@mojihaba
        \rightmargin\z@ \listparindent\z@ \itemindent\z@
        \partopsep\z@ \parsep\z@ \topsep\z@ \itemsep\z@}
\def\@listi{\leftmargin\leftmargini \lst@listi}
\def\@listii{\leftmargin\leftmarginii \lst@listi}
\def\@listiii{\leftmargin\leftmarginiii \lst@listi}
\def\@listiv{\leftmargin\leftmarginiv \lst@listi}
\def\@listv{\leftmargin\leftmarginv \lst@listi}
\def\@listvi{\leftmargin\leftmarginvi \lst@listi}

\@listi

\def\labelenumi{\theenumi.} 
\def\theenumi{\arabic{enumi}} 
\def\labelenumii{\theenumii.}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}
\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}
\def\labelenumiv{(\,\theenumiv\,)}
\def\theenumiv{\Alph{enumiv}}
\def\p@enumiv{\p@enumiii\theenumiii}
\def\enumerate{\ifnum \@enumdepth >3 \@toodeep\else
        \advance\@enumdepth \@ne 
        \edef\@enumctr{enum\romannumeral\the\@enumdepth}
        \list{\csname label\@enumctr\endcsname}{\usecounter
                {\@enumctr}\def\makelabel##1{##1\hss}%
                \ifnum \@listdepth =\@ne \leftmargin1zw\relax
                \else\leftmargin\leftskip\fi
                \advance\leftmargin 2zw
                \labelwidth1.7\@mojihaba \labelsep\z@%
                \itemsep=\z@\parsep=\z@\topsep=\z@}\fi}
\let\endenumerate\endlist

\def\labelitemi{$\bullet$}
\def\labelitemii{\bf --}
\def\labelitemiii{\rule[0.3ex]{3pt}{3pt}}
\def\labelitemiv{$\cdot$}
\def\itemize{\ifnum \@itemdepth >3 \@toodeep\else \advance\@itemdepth \@ne
        \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
        \list{\csname\@itemitem\endcsname}{\def\makelabel##1{\hss##1\hss}%
                \ifnum \@listdepth =\@ne \leftmargin1zw\relax
                \else\leftmargin\leftskip\fi
                \advance\leftmargin 2zw
                \labelwidth2\@mojihaba \labelsep\z@%
                \itemsep=\z@\parsep=\z@\topsep=\z@}\fi}
\let\enditemize\endlist

\def\description{\list{}{\labelwidth\z@ \labelsep\@mojihaba
        \itemindent\labelsep \advance\itemindent-\leftmargin
        \def\makelabel##1{\bf ##1}}}
\let\enddescription\endlist

\let\latex@trivlist\@trivlist
\def\lst@trivlist#1#2{\leftmargin#1\relax
        \itemindent\labelwidth \advance\itemindent\labelsep
        \advance\itemindent#2\relax
        \let\@trivlist\latex@trivlist \@trivlist}

\def\lst@strivlist{\def\@trivlist{\lst@trivlist\@mojihaba{-\@mojihaba}}}
\@namedef{enumerate*}{\lst@strivlist \enumerate}
\@namedef{endenumerate*}{\endlist}
\@namedef{itemize*}{\lst@strivlist \itemize}
\@namedef{enditemize*}{\endlist}
\@namedef{description*}{\lst@strivlist \description}
\@namedef{enddescription*}{\endlist}

\def\verse{\let\\=\@centercr 
        \list{}{\itemindent-\@mojihaba \listparindent\itemindent 
        \rightmargin\leftmargin \advance\leftmargin\@mojihaba}\item[]}
\let\endverse\endlist
\def\quotation{\list{}{\listparindent\@mojihaba \itemindent\listparindent
        \rightmargin\leftmargin}\item[]}
\let\endquotation\endlist
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}
\let\endquote\endlist

\def\newtheorem{\@ifstar
        {\theo@newtheorem{\theo@it}{\ }}{\theo@newtheorem{}{\theo@sp}}}
\def\theo@newtheorem#1#2#3{\@namedef{theo@it@#3}{#1}\@namedef{theo@sp@#3}{#2}%
        \@ifnextchar[%]
                     {\@othm{#3}}{\@nthm{#3}}}
\def\@begintheorem#1#2{\DESCRIPTION \csname theo@it@\@currenvir\endcsname
        \item[#1\csname theo@sp@\@currenvir\endcsname #2]}
\def\@opargbegintheorem#1#2#3{\DESCRIPTION
        \csname theo@style@\@currenvir\endcsname
        \item[#1\csname theo@sp@\@currenvir\endcsname #2\ (#3)]}
\let\@endtheorem\endlist                                        % 1.02(2)
\ifDS@english
\let\theo@it\it \let\theo@sp\ %
\else
\let\theo@it\relax \let\theo@sp\relax
\fi


%%% キャプション

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \iftdir\sbox\@tempboxa{#1\hskip1zw#2}%
    \else\sbox\@tempboxa{\gt\sffamily\small#1\quad#2}%
  \fi
  \ifdim \wd\@tempboxa >\hsize
    \iftdir #1\hskip1zw#2\relax\par
      \else {\gt\sffamily\small#1\quad#2}\relax\par\fi
  \else
    \global \@minipagefalse
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%%% コマンド

\newcommand{\acknowledgment}{\chapter*{謝辞}
  \addcontentsline{toc}{chapter}{謝辞}}
\newcommand{\keywords}{\bigskip\subsection*{主な用語}\noindent\ignorespaces}

\newcommand{\comment}[1]{\ifdraft{%
    \@ifundefined{color}{\bfseries}{\color{red}}[[#1]]}\fi\ignorespaces}

%%% 環境

\let\origeqnarray\eqnarray
\def\eqnarray{\begingroup\par\topsep=2ex\vspace{-\topsep}\origeqnarray}

\let\origendeqnarray\endeqnarray
\def\endeqnarray{\origendeqnarray\endgroup}

\let\origverbatim\verbatim
\def\verbatim{\begingroup\par\baselineskip=1.3zh\medskip\origverbatim}

\let\origendverbatim\endverbatim
\def\endverbatim{\origendverbatim\endgroup}

\renewcommand{\contentsname}{目次}
\renewcommand{\listfigurename}{図目次}
\renewcommand{\listtablename}{表目次}
\renewcommand{\bibname}{参考文献}
\renewcommand{\indexname}{索引}
\renewcommand{\appendixname}{付録}
\renewcommand{\abstractname}{概要}

\renewenvironment{thebibliography}[1]
{\chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
  \addcontentsline{toc}{chapter}{\bibname}%
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
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

\renewenvironment{abstract}{%
\if修士論文
\thispagestyle{oecuabst}
\newgeometry{a4paper,textheight=250mm,width=184mm,top=12.7mm,left=12.7mm,includeheadfoot=true,headsep=10mm,footskip=8mm}
\markright{\scriptsize 様式---M04}

\hfill{\normalsize \makebox[40mm][s]{\quad\@date}提出}%
\vspace{7mm}

\noindent\hfil{\huge \makebox[68mm][s]{修士学位論文の概要}}%
	\quad{\normalsize\makebox[24mm][s]{(2000字程度)}}
\vspace{10mm}

\noindent\hspace*{6mm}
{\Large\makebox[21mm][s]{論文題目}}\ %
 \underline{\makebox[135mm][l]{\large\ \parbox{132mm}{\@titleabstract}\ }}%
\vskip 5mm
\begingroup
\small
\else% 卒業論文
      \noindent\@年度 年度 \@論文種別\par
      \vskip3zw
      \noindent\@titleabstract
      \medskip
      \par\hfill\@author
      \subsection*{内容梗概}
\fi}%
{\if修士論文
\endgroup
\par
\vfill
{\large\noindent
\renewcommand{\arraystretch}{0.9}%
\begin{tabular}{ll}
\makebox[3zw][s]{専攻} &
	\@専攻\\
\makebox[4zw][s]{学生番号}& 
        \underline{\makebox[57mm][l]{\quad\@学生番号}}
\end{tabular}%
\hspace{12mm}%
\begin{tabular}{ll}
\makebox[3zw][s]{コース} &
	\normalsize\@所属\\
\makebox[3zw][s]{氏名}&
        \underline{\makebox[57mm][l]{\quad\@author}}
\end{tabular}}
\setcounter{page}{0}
\fi
\par\vfil\null
%\endtitlepage
\restoregeometry
}

%%% 文献引用
%%% from ieicej.sty Version 1.1 [2 August 1995]

%% from "citesort.sty", with a little modified
\newcount\@minsofar
\newcount\@min
\newcount\@cite@temp
\def\@citex[#1]#2{%
\if@filesw \immediate \write \@auxout {\string \citation {#2}}\fi
\@tempcntb\m@ne \let\@h@ld\relax \def\@citea{}%
\@min\m@ne%
\@cite{%
  \@for \@citeb:=#2\do {\@ifundefined {b@\@citeb}%
    {\@h@ld\@citea\@tempcntb\m@ne{\bf ?}%
    \@warning {Citation `\@citeb ' on page \thepage \space undefined}}%
{\@minsofar\z@ \@for \@scan@cites:=#2\do {%
  \@ifundefined{b@\@scan@cites}%
    {\@cite@temp\m@ne}
    {\@cite@temp\number\csname b@\@scan@cites \endcsname \relax}%
\ifnum\@cite@temp > \@min% select the next one to list
    \ifnum\@minsofar = \z@
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\else
    \ifnum\@cite@temp < \@minsofar
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\fi\fi\fi}\@tempcnta\@min
  \ifnum\@minsofar > \z@ % some more
    \advance\@tempcnta\@ne
    \@min\@minsofar
    \ifnum\@tempcnta=\@minsofar %   Number follows previous--hold on to it
      \ifx\@h@ld\relax
        \edef \@h@ld{\@citea\csname b@\@scan@copy\endcsname}%
      \else \edef\@h@ld{\ifmmode{]〜[}\else]〜[\fi\csname b@\@scan@copy\endcsname}%
      \fi
    \else \@h@ld\@citea\csname b@\@scan@copy\endcsname
          \let\@h@ld\relax
  \fi % no more
\fi}%
\def\@citea{],\penalty\@highpenalty\,[}}\@h@ld}{#1}}
%% end of citesort.sty

\def\@cite#1#2{\leavevmode\unskip
  \ifnum\lastpenalty=\z@\penalty\@highpenalty\fi% highpenalty before
  \,[{\multiply\@highpenalty 3 #1%             % triple-highpenalties within
      \if@tempswa,\penalty\@highpenalty\ #2\fi % and before note.
    }]\spacefactor\@m}

%%% oecu-thesis.cls ends here
