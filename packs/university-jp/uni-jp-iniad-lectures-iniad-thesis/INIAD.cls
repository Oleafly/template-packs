%%
%% This is file `systemB.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% suribt.dtx  (with options: `suribt')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from suribt.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file suribt.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{INIAD}
  [2020/04/15 TOMOKAZU Ishikawa]
%% Copy from Bachelors Thesis Template for Keisu System, The University of Tokyo  
\newif\ifdraft
\DeclareOption{draft}{\drafttrue}
\DeclareOption{final}{\draftfalse}
\newif\ifjisfont
\jisfonttrue
\DeclareOption{mingoth}{\jisfontfalse}
\newif\ifwinjis
\winjisfalse
\DeclareOption{winjis}{\winjistrue}
\newif\iftombow
\tombowfalse
\DeclareOption{tombow}{\tombowtrue}
\newif\iftombo
\tombofalse
\DeclareOption{tombo}{\tombotrue}
\newif\ifmentuke
\mentukefalse
\DeclareOption{mentuke}{\mentuketrue}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\newif\ifpapersize
\papersizefalse
\DeclareOption{papersize}{\papersizetrue}
\newif\if@english
\@englishfalse
\DeclareOption{english}{\@englishtrue}
\newif\if@tocchaplong
\DeclareOption{tocchaplong}{\@tocchaplongtrue}
\DeclareOption{tocchapshort}{\@tocchaplongfalse}
\newif\if@belongstosuri
\DeclareOption{mi}{\@belongstosuritrue}
\DeclareOption{suri}{\@belongstosuritrue}
\DeclareOption{ipc}{\@belongstosurifalse}
\DeclareOption{system}{\@belongstosurifalse}
\newif\if@undergraduate
\newif\if@graduatedoctor
\DeclareOption{bachelor}{\@undergraduatetrue}
\DeclareOption{master}{\@undergraduatefalse\@graduatedoctorfalse}
\DeclareOption{doctor}{\@undergraduatefalse\@graduatedoctortrue}
%\ExecuteOptions{final,twoside,tocchaplong,mi,bachelor}
\ExecuteOptions{final,tocchaplong,mi,bachelor}
\ProcessOptions
\LoadClass[a4paper,onecolumn,titlepage,11pt
\ifdraft ,draft\else ,final\fi%
\ifwinjis ,winjis\else\ifjisfont\else ,mingoth\fi\fi%
\iftombow ,tombow\else\iftombo ,tombo\else\ifmentuke ,mentuke\fi\fi\fi%
\if@twoside ,twoside,openright\else ,oneside,openany\fi%
\ifpapersize ,papersize\fi%
\if@english ,english\fi%
]{jsbook}
\iftombowdate
  \newcount\@totalpage
  \def\@lastoftotalpage{?}
  \AtEndDocument{\protected@write\@auxout{\let\the\relax}%
      {\gdef\string\@lastoftotalpage{\the\@totalpage}}}
  \def\@put@totalpage{\global\advance\@totalpage1
      \raise4pt\hbox to\z@{\hss
          \@bannerfont page \the\@totalpage\ of \@lastoftotalpage.\hskip5mm}}
  \AtBeginDocument{%
      \let\@@TR\@TR
      \def\@TR{\@@TR\@put@totalpage}}
\fi
\setlength{\fullwidth}{\paperwidth}
\addtolength{\fullwidth}{-36mm}
\@tempdima=1zw
\divide\fullwidth\@tempdima \multiply\fullwidth\@tempdima
\ifdim \fullwidth>42zw
  \setlength{\fullwidth}{42zw}
\fi
\setlength{\textwidth}{\fullwidth}
\setlength{\oddsidemargin}{\paperwidth}
\addtolength{\oddsidemargin}{-\textwidth}
\setlength{\oddsidemargin}{.5\oddsidemargin}
\iftombow
  \addtolength{\oddsidemargin}{-1in}
\else
  \addtolength{\oddsidemargin}{-1truein}
\fi
\setlength{\evensidemargin}{\oddsidemargin}
\def\ps@plainhead{%
  \let\@mkboth\@gobbletwo
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \def\@oddfoot{\small \normalfont \hfil \vfill \thepage \hfil}
  \def\@evenfoot{\small \normalfont \hfil \vfill \thepage \hfil}
}
\def\ps@headings{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \if@twoside
    \def\@oddfoot{\small \normalfont \hfil \thepage \hfil}%
    \def\@evenfoot{\small \normalfont \hfil \thepage \hfil}%
  \else
    \def\@oddfoot{\small \normalfont \hfil \thepage \hfil}%
    \let\@evenfoot\@oddfoot
  \fi
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \@chapapp\thechapter\@chappos\hskip1zw
      \fi
    \fi
    ##1}{}}%
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth >\z@ \thesection \hskip1zw\fi
    ##1}}}%
\renewenvironment{titlepage}{%
  \cleardoublepage
  \newpage
  \thispagestyle{empty}%
  \setcounter{page}\@ne
}%
{\newpage}
\newcommand*{\titlewidth}[1]{\gdef\title@width{#1}}% #1: タイトル幅
\gdef\title@width{\hsize}
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}% #1: 学生証番号
\gdef\@studentid@prefix{\if@english Student ID : \else 学籍番号：\fi}
\renewcommand{\and}{\\ &}
\gdef\@name@prefix{\if@english Name : \else 氏名：\fi}
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}% #1: 指導教員名 + 役職
\gdef\@supervisor@prefix{\if@english Supervisor : \else 指導教員名：\fi}
\newcommand*{\handin}[2]{\year #1 \month #2 \day 0}% #1: 年, #2: 月
\newcommand*{\eauthor}[1]{\gdef\@eauthor{#1}}% #1: 著者名英語つづり
\newcommand*{\email}[1]{\gdef\authors@email{#1}}% #1: e-mail アドレス
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}% #1: キーワード
\gdef\@keywordsprefix{\if@english Keywords\else キーワード\fi}
\if@undergraduate
  \if@english
%    \gdef\@subtitle{Bachelor's~Thesis}
     \gdef\@belongsto{Faculty of Information Networking for Innovation and Design, Toyo University}%
  \else
%    \gdef\@subtitle{卒業論文}
     \gdef\@belongsto{東洋大学情報連携学部情報連携学科}%
  \fi
\else
  \if@english
      \gdef\@belongsto{Graduate School of Information Networking for Innovation and Design\\%
        Toyo University}%
  \else
      \gdef\@belongsto{東洋大学情報連携学研究科情報連携学専攻}%
  \fi
  \if@graduatedoctor
    \if@english
%      \gdef\@subtitle{Doctoral~Thesis}
    \else
%      \gdef\@subtitle{博士論文}
    \fi
  \else
    \if@english
%      \gdef\@subtitle{Master's~Thesis}
    \else
%      \gdef\@subtitle{修士論文}
    \fi
  \fi
\fi
\renewcommand{\maketitle}{%
  \global\let\thanks\relax
  \global\let\@thanks\@empty
  \begin{titlepage}%
    \let\footnote\relax
    \null\vskip115\p@
%    \if@graduatedoctor
%    \else
%      \begin{center}
%        {\headfont\Large \@subtitle \par}
%      \end{center}%
%    \fi
    \begin{center}\headfont\huge%
      \parbox{\title@width}{\begin{center}\@title\end{center}}%
    \end{center}
    \null\vskip115\p@
    \if@graduatedoctor
      \begin{center}
        {\headfont\Huge\@author}
      \end{center}%
    \else
      \begin{center}
        \fontsize{11}{11}\selectfont
        {\begin{tabular}[t]{rl}%
          \ifx\@studentid\@undefined
          \else
            \@studentid@prefix & \@studentid
          \fi 
          \\[5\p@]
          \@name@prefix & \@author \\[5\p@]
          \@supervisor@prefix & \@supervisor
        \end{tabular}\par}%
        \vskip 2cm
        {\@date\par}%
        \vskip 2cm
        {\@belongsto \par}%
      \end{center}\par
      \@thanks%
    \fi
    \vskip60\p@\null
%    \newpage\clearpage
%    \thispagestyle{empty}
%    \setcounter{page}{0}
%    \null\vfill
%    \begin{flushleft}
%      Copyright {\copyright} {\number\year},~%
%      \ifx\@eauthor\@undefined \@author\else\@eauthor\fi.
%    \end{flushleft}\par
%    \vskip60\p@\null
  \end{titlepage}
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
%  \global\let\subtitle\relax
  \global\let\title\relax
  \global\let\supervisor\relax
  \global\let\belongto\relax
  \global\let\email\relax
  \global\let\eauthor\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}


\renewcommand{\tableofcontents}{%
  \settowidth\jsc@tocl@width{\presectionname\normalfont\postsectionname}%
  \settowidth\@tempdima{\normalfont\appendixname}%
  \ifdim\jsc@tocl@width<\@tempdima\relax\setlength\jsc@tocl@width{\@tempdima}\fi
  \ifdim\jsc@tocl@width<2zw \divide\jsc@tocl@width by 2 \advance\jsc@tocl@width 1zw\fi
  \section*{\headfont\contentsname}%
  \@mkboth{\contentsname}{\contentsname}%
  \@starttoc{toc}%
}



\renewcommand*{\l@chapter}{\@dottedtocline{0}{0pt}{3em}}
\renewcommand*{\l@section}{\@dottedtocline{1}{1em}{3em}}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{2em}{3em}}

\renewcommand\frontmatter{%
%  \if@openright
%    \cleardoublepage
%  \else
%    \clearpage
%  \fi
  \@mainmatterfalse
  \pagenumbering{roman}
  }
\renewcommand\mainmatter{%
  \@openrightfalse
  \@mainmattertrue
  \pagenumbering{arabic}}
\renewcommand\backmatter{%
  \clearpage
  \@openrightfalse
  \@mainmatterfalse}
\renewcommand{\appendix}{\par
  \@mainmattertrue%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\@chappos{}%
  \gdef\thechapter{\@Alph\c@chapter}}
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{\@chapapp\thechapter\@chappos}%
      \if@tocchaplong\addcontentsline{toc}{chapter}%
        {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
      \else\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
      \fi%
    \else\addcontentsline{toc}{chapter}{#1}\fi
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
    \@afterheading
  \fi}

\def\mojiparline#1{
    \newcounter{mpl}
    \setcounter{mpl}{#1}
    \@tempdima=\linewidth
    \advance\@tempdima by-\value{mpl}zw
    \addtocounter{mpl}{-1}
    \divide\@tempdima by \value{mpl}
    \advance\kanjiskip by\@tempdima
    \advance\parindent by\@tempdima
}

\def\linesparpage#1{
    \baselineskip=\textheight
    \divide\baselineskip by #1
}

\renewcommand{\subsubsection}{%
    \if@slide\clearpage\fi
    \@startsection{subsubsection}{1}{\z@}%
    {\Cvs \@plus.3\Cdp \@minus.3\Cdp}% 前アキ
    {.5\Cvs \@plus.3\Cdp}% 後アキ
    {\normalfont\large\raggedright}}

\renewcommand{\subsection}{%
    \if@slide\clearpage\fi
    \@startsection{subsection}{1}{\z@}%
    {\Cvs \@plus.3\Cdp \@minus.3\Cdp}% 前アキ
    {.5\Cvs \@plus.3\Cdp}% 後アキ
    {\normalfont\large\raggedright}}

\renewcommand{\section}{%
    \if@slide\clearpage\fi
    \@startsection{section}{1}{\z@}%
    {\Cvs \@plus.3\Cdp \@minus.3\Cdp}% 前アキ
    {.5\Cvs \@plus.3\Cdp}% 後アキ
    {\normalfont\large\raggedright}}

\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}.}
\renewcommand{\thesubsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.}

\renewcommand{\prechaptername}{}
\renewcommand{\postchaptername}{.}
\renewcommand{\thechapter}{\arabic{chapter}}

\def\@makechapterhead#1{\hbox{}%
  \vskip0\Cvs
  {\parindent\z@
   \raggedright% 左揃え（オリジナルの定義)
%  \centering% 中央揃え
%  \raggedleft% 右揃え
   \normalfont\large\raggedright%% フォントを変更する
   \leavevmode
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
    \if@mainmatter% ← report クラスの場合この行不要
     \setbox\z@\hbox{\@chapapp\thechapter\@chappos\hskip1zw}%
     \addtolength\@tempdima{-\wd\z@}%
     \unhbox\z@\nobreak
    \fi% ← report クラスの場合この行不要
     \vtop{\hsize\@tempdima#1}%
   \else
     #1\relax
   \fi}\nobreak\vskip0\Cvs}


\newcommand{\abstractname}{\if@english \large{Abstract}\else \large{論文要旨}\fi}
\renewenvironment{abstract}{%
  \titlepage
%  \null\vfill
  \@beginparpenalty\@lowpenalty
  \begin{center}%
    \headfont \abstractname
    \@endparpenalty\@M
  \end{center}\par}%
  {\par%
    \ifx\@keywords\@undefined\else%
      \vskip2\baselineskip
      \begin{description}%
        \item[\@keywordsprefix]\@keywords%
      \end{description}%
    \fi%
    \vfill\vfill\vfill\null
    \endtitlepage}
\newcommand{\eabstractname}{\if@english \large{概要} \else \large{Abstract}\fi}
\newcommand*{\etitle}[1]{\gdef\@etitle{#1}}
\newenvironment{eabstract}{%
 \titlepage
 \null
 \@beginparpenalty\@lowpenalty
 \begin{center}
     \begin{center}\headfont\Large%
	  \@etitle
    \end{center}
 \end{center}
     \vskip2\baselineskip
 \begin{center}%
    \headfont \eabstractname
    \@endparpenalty\@M
 \end{center}\par}%
 {\par%
    \ifx\@keywords\@undefined\else%
     \vskip2\baselineskip
     \begin{description}%
        \item[\@keywordsprefix]\@keywords%
     \end{description}%
    \fi%
    \vfill\vfill\vfill\null
    \endtitlepage}
%%%%
\renewenvironment{thebibliography}[1]{%
  \global\let\presectionname\relax
  \global\let\postsectionname\relax
  \chapter{\bibname}\@mkboth{\bibname}{}%
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
\long\def\@makecaption#1#2{{\small%
  \advance\leftskip2zw
  \advance\rightskip2zw
  \@tempdimb\hsize
  \advance\@tempdimb-4zw
  \vskip\abovecaptionskip
  \setbox\tw@=\hbox{\hskip2zw{\headfont#1.}~}%
  \sbox\@tempboxa{{\headfont#1.}~#2}%
  \ifdim \wd\@tempboxa >\@tempdimb
    \list{\headfont#1.}{%
      \renewcommand{\makelabel}[1]{\hskip2zw##1\hfil}
      \itemsep    \z@
      \itemindent \z@
      \labelsep   \z@
      \labelwidth \wd\tw@
      \listparindent\z@
      \leftmargin \wd\tw@
      \rightmargin 2zw}\item\relax #2\endlist
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}}
\def\today{%
  \if@english
    \ifcase\month\or
      January\or February\or March\or April\or May\or June\or
      July\or August\or September\or October\or November\or December\fi
      %\space\number\day
      , \number\year
  \else
    \if西暦
      \number\year 年
      \number\month 月
      %\number\day 日
    \else
      平成\number\heisei 年
      \number\month 月
      %\number\day 日
    \fi
  \fi}
\pagestyle{headings}
\pagenumbering{arabic}
\onecolumn
\raggedbottom
\endinput
%%
%% End of file `suribt.cls'.
