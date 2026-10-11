%%
%% This is file `cimt.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cimt.dtx  (with options: `cimt')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from cimt.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file cimt.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{cimt}
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
\newif\if@emptypagenombre
\@emptypagenombrefalse
\DeclareOption{emptypagenombre}{\@emptypagenombretrue}
\newif\if@graduatedoctor
\@graduatedoctorfalse
\DeclareOption{master}{\@graduatedoctorfalse}
\DeclareOption{doctor}{\@graduatedoctortrue}
\ExecuteOptions{final,twoside,tocchaplong}
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
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \def\@oddhead{\hbox to \fullwidth{\hfil%
      {\small\textbf{\headfont\thepage}}}\hss}
  \if@twoside
    \def\@evenhead{\hss \hbox to \fullwidth{%
        {\small\textbf{\headfont\thepage}}\hfil}}
  \else
    \let\@evenhead\@oddhead
  \fi
}
\def\ps@headings{%
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \if@twoside
    \def\@oddhead{\hbox to \fullwidth{\hfil%
        {\small\headfont\rightmark\qquad\textbf{\thepage}}}\hss}%
    \def\@evenhead{\hss \hbox to \fullwidth{%
        {\small\headfont\textbf{\thepage}\qquad\leftmark}\hfil}}%
  \else
    \def\@oddhead{\hbox to \fullwidth{\hfil%
        {\small\headfont\leftmark\qquad\textbf{\thepage}}}\hss}%
    \let\@evenhead\@oddhead
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
{\newpage} %
\if@emptypagenombre
  \renewcommand{\cleardoublepage}{%
     \clearpage%
     \if@twoside%
       \ifodd\c@page\iftdir\hbox{}\thispagestyle{plainhead}\newpage%
                      \if@twocolumn\hbox{}\newpage\fi\fi%
       \else\ifydir\hbox{}\thispagestyle{plainhead}\newpage%
                      \if@twocolumn\hbox{}\newpage\fi\fi%
       \fi\fi}
\fi
\newcommand*{\titlewidth}[1]{\gdef\title@width{#1}}% #1: タイトル幅
\gdef\title@width{\hsize}
\newcommand*{\jtitle}[1]{\gdef\@jtitle{#1}}% #1: タイトル(和文)
\newcommand*{\etitle}[1]{\gdef\@etitle{#1}}% #1: タイトル(英文)
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}% #1: 学生証番号
\newcommand*{\jauthor}[1]{\gdef\@jauthor{#1}}% #1: 著者名(和文)
\newcommand*{\eauthor}[1]{\gdef\@eauthor{#1}}% #1: 著者名(英文)
\renewcommand{\and}{\\ &}%
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}% #1: 指導教員名(和文)
%% \newcommand*{\esupervisor}[1]{\gdef\@esupervisor{#1}}% #1: 指導教員名(英文)
%% \newcommand*{\jsupervisortitle}[1]{\gdef\@jsupervisortitle{#1}}% #1: 指導教員肩書(和文)
%% \newcommand*{\esupervisortitle}[1]{\gdef\@esupervisortitle{#1}}% #1: 指導教員肩書(英文)
\newcommand*{\handin}[2]{\year #1 \month #2}% #1: 年, #2: 月, #3: 日
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}% #1: キーワード
\gdef\@keywordsprefix{\if@english Keywords\else キーワード\fi}
\if@graduatedoctor
  \gdef\@jthesisname{博士論文}
  \gdef\@ethesisname{Doctor Thesis}
  \gdef\@thesisgrade{Doctor}
\else
  \gdef\@jthesisname{修士論文}
  \gdef\@ethesisname{Master Thesis}
  \gdef\@thesisgrade{Master}
\fi
\def\@ci@nl(#1,#2){\\[#1truemm minus#2truemm]}
\renewcommand{\maketitle}{%
  \global\let\thanks\relax
  \global\let\@thanks\@empty
  \@mainmatterfalse
  \pagenumbering{roman}
%%  \def\@fp@topskip{\if@english -15ex\else -12ex\fi}
  \null\vskip -7ex% \@fp@topskip\vfill
  \vbox to \textheight{
 \null\vskip 0pt plus 1fil
  \begin{center}
    \if@graduatedoctor
      \PackageWarning{cimt}{Option `doctor' is not officiallly supported.  You may need to modify the class file for appropriate results.}
    \fi
    \let\footnote\relax
    \if@english
      \headfont\Large
      Department of Creative Informatics\\
      Graduate School of Information Science and Technology\\
      THE UNIVERSITY OF TOKYO\@ci@nl(28,20)
      \@ethesisname\@ci@nl(10,2)
      {\LARGE\bf \@etitle\\}
      {\normalfont \@jtitle\@ci@nl(28,20)}
      {\LARGE\bf \@eauthor\\}
      {\normalfont \@jauthor\@ci@nl(28,20)}
      Supervisor:\quad\@supervisor\@ci@nl(15,8)
      \edate
    \else
      \headfont
      {\Large 東京大学\\情報理工学系研究科 創造情報学専攻\\\@jthesisname\@ci@nl(30,20)}
      {\LARGE \@jtitle\\}
      {\normalfont\large \@etitle\@ci@nl(30,20)}
      {\LARGE \@jauthor\\}
      {\normalfont\large \@eauthor\@ci@nl(30,20)}
      {\Large 指導教員\quad\@supervisor\@ci@nl(15,10)}
      {\Large \jdate}
    \fi
    \vskip 0pt plus 1fil
  \end{center}
  }
%%  \null\vfill
  \thispagestyle{empty}
  \clearpage
  \setcounter{page}{0}
  \null\vfill
  \begin{flushleft}
%%    Copyright {\copyright} {\number\year},~%
%%    \ifx\@eauthor\@undefined \@jauthor\else\@eauthor\fi.
  \end{flushleft}\par
  \thispagestyle{empty}
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax
  \global\let\subtitle\relax
  \global\let\title\relax
  \global\let\supervisor\relax
  \global\let\eauthor\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\renewcommand\frontmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \pagenumbering{roman}
}
\renewcommand\mainmatter{%
  \if@twoside
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@openrightfalse
  \@mainmattertrue
  \pagenumbering{arabic}
  \if@jabst@put\else
    \PackageError{cimt}{Japanese abstract is missing}
  \fi
  \if@eabst@put\else
    \PackageError{cimt}{English abstract is missing}
  \fi
}
\renewcommand\backmatter{%
  \clearpage
  \@openrightfalse
  \@mainmatterfalse
}
\newif\if@jabst@put \@jabst@putfalse
\newenvironment{jabstract}{
  \if@english
    \if@eabst@put\else
      \PackageError{cimt}{English abstract should precede Japanese abstract}
    \fi
  \fi
  \global\@jabst@puttrue
  \cleardoublepage
  \begin{center}
    \Huge\headfont 概要
  \end{center}
  \par\bigskip
}{%
}
\newif\if@eabst@put \@eabst@putfalse
\newenvironment{eabstract}{
  \if@english\else
    \if@jabst@put\else
      \PackageError{cimt}{Japanese abstract should precede English abstract}
    \fi
  \fi
  \global\@eabst@puttrue
  \cleardoublepage
  \begin{center}%
    \Huge\headfont Abstract
  \end{center}
  \par\bigskip
}{%
}
\newenvironment{acknowledgements}{
  \def\@acktitle{\if@english Acknowledgements\else 謝辞\fi}
    \cleardoublepage
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright \normalfont
    \interlinepenalty\@M
    {\Huge\headfont \@acktitle}\par\nobreak
    \vskip 40\p@}%
}{%
    \cleardoublepage
}
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
\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\p@}
    \begingroup
      \parindent\z@
      \rightskip\@tocrmarg
      \parfillskip-\rightskip
      \leavevmode\headfont
      \if@tocchaplong
        \@tempdima4.683zw%
        \setbox\tw@=\hbox{\headfont{}\appendixname{}M\hskip.683zw}%
        \ifdim \wd\tw@>\@tempdima \@tempdima\wd\tw@\fi
        \setbox\thr@@=\hbox{\headfont{}\@chapapp{99}\@chappos\hskip.683zw}%
        \ifdim \wd\thr@@>\@tempdima \@tempdima\wd\thr@@\fi
        \setlength\@lnumwidth{\@tempdima}%
      \else
        \setlength\@lnumwidth{1.5em}%
      \fi
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      #1\nobreak\hfil\nobreak\hbox to\@pnumwidth{\hss#2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*{\l@section}{%
  \if@tocchaplong%
    \@tempdima4.683zw%
    \setbox\tw@=\hbox{\headfont{}\appendixname{}M\hskip.683zw}%
    \ifdim \wd\tw@>\@tempdima \@tempdima\wd\tw@\fi
    \setbox\thr@@=\hbox{\headfont{}\@chapapp{99}\@chappos\hskip.683zw}%
    \ifdim \wd\thr@@>\@tempdima \@tempdima\wd\thr@@\fi
    \advance\@tempdima-3.683zw%
    \ifdim \@tempdima<1zw \@tempdima1zw\fi
    \@tempdimb3.683zw%
  \else
    \@tempdima1.5em \@tempdimb2.3em
  \fi
  \@dottedtocline{1}{\@tempdima}{\@tempdimb}}
\renewcommand{\bibname}{\if@english References\else 参考文献\fi}
\renewenvironment{thebibliography}[1]{%
  \global\let\presectionname\relax
  \global\let\postsectionname\relax
  \chapter{\refname}\@mkboth{\refname}{}%
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
\newif\if@pubLongName \@pubLongNamefalse
\newcommand{\pubUseLongName}{\@pubLongNametrue}
\newenvironment{publications}{
  \def\@cname{\if@english\if@pubLongName
                  Publications and Research Activities \else Publications \fi
              \else \if@pubLongName 発表文献と研究活動 \else 発表文献 \fi\fi}
  \chapter{\@cname}
  \begin{enumerate}
  \renewcommand{\labelenumi}{(\theenumi)}
}{%
  \end{enumerate}
}
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
\def\edate{%
  \ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
  \ \number\year%
}
\def\jdate{\number\year 年\number\month 月}
\pagestyle{headings}
\pagenumbering{arabic}
\onecolumn
\raggedbottom
\endinput
%%
%% End of file `cimt.cls'.
