%%
%% This is file `knct-paper.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% jsclasses.dtx  (with options: `jbook')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from knct-paper.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file jsclasses.dtx.
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
\ProvidesClass{knct-paper}
\typeout{ 高知工業高等専門学校 電気情報工学科 論文クラスファイル}
%\typeout{ $Id: knct-paper.cls[version 3.3.2（のちのつき）], 2001/3/2$}
%\typeout{ $Id: knct-paper.cls[version 3.3.3（のちのつき）], 2001/12/20$}
\typeout{ $Id: knct-paper.cls[version 1.0.0（KNCT version）], 2004/02/19$}
\newif\if@restonecol
\newif\if@titlepage
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\newif\if@enablejfam \@enablejfamtrue
\DeclareOption{a4paper}{%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}{%
  \setlength\paperheight {210mm}%
  \setlength\paperwidth  {148mm}}
\DeclareOption{a6paper}{%
  \setlength\paperheight {148mm}%
  \setlength\paperwidth  {105mm}}
\DeclareOption{b4paper}{%
  \setlength\paperheight {364mm}%
  \setlength\paperwidth  {257mm}}
\DeclareOption{b5paper}{%
  \setlength\paperheight {257mm}%
  \setlength\paperwidth  {182mm}}
\DeclareOption{a4j}{%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
\DeclareOption{a5j}{%
  \setlength\paperheight {210mm}%
  \setlength\paperwidth  {148mm}}
\DeclareOption{b4j}{%
  \setlength\paperheight {364mm}%
  \setlength\paperwidth  {257mm}}
\DeclareOption{b5j}{%
  \setlength\paperheight {257mm}%
  \setlength\paperwidth  {182mm}}
\DeclareOption{b5var}{%
  \setlength\paperheight {230mm}%
  \setlength\paperwidth  {182mm}}
\DeclareOption{letterpaper}{%
  \setlength\paperheight {11in}%
  \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}{%
  \setlength\paperheight {14in}%
  \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}{%
  \setlength\paperheight {10.5in}%
  \setlength\paperwidth  {7.25in}}
\newcommand{\@ptsize}{10}
\DeclareOption{9pt}{\renewcommand{\@ptsize}{9}}
\DeclareOption{10pt}{\renewcommand{\@ptsize}{10}}
\DeclareOption{11pt}{\renewcommand{\@ptsize}{11}}
\DeclareOption{12pt}{\renewcommand{\@ptsize}{12}}
\DeclareOption{14pt}{\renewcommand{\@ptsize}{14}}
\DeclareOption{17pt}{\renewcommand{\@ptsize}{17}}
\DeclareOption{21pt}{\renewcommand{\@ptsize}{21}}
\DeclareOption{landscape}{%
  \setlength\@tempdima   {\paperheight}%
  \setlength\paperheight {\paperwidth}%
  \setlength\paperwidth  {\@tempdima}}
\hour\time \divide\hour by 60\relax
\@tempcnta\hour \multiply\@tempcnta 60\relax
\minute\time \advance\minute-\@tempcnta
\DeclareOption{tombow}{%
  \tombowtrue \tombowdatetrue
  \setlength{\@tombowwidth}{.1\p@}%
  \@bannertoken{%
     \jobname\space:\space\number\year/\number\month/\number\day
      (\number\hour:\number\minute)}
  \maketombowbox}
\DeclareOption{tombo}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{.1\p@}%
  \maketombowbox}
\DeclareOption{mentuke}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{\z@}%
  \@bannertoken\@empty
  \maketombowbox}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{disablejfam}{\@enablejfamfalse}
\newif\ifdraft
\DeclareOption{draft}{\drafttrue \setlength\overfullrule{5pt}}
\DeclareOption{final}{\draftfalse \setlength\overfullrule{0pt}}
\newif\ifjisfont
\jisfonttrue
\DeclareOption{mingoth}{\jisfontfalse}
\newif\ifpapersize
\papersizefalse
\DeclareOption{papersize}{\papersizetrue}
\ExecuteOptions{a4j,12pt,oneside,onecolumn,titlepage,openright,final}
\ProcessOptions
\ifpapersize
  \setlength{\@tempdima}{\paperwidth}
  \setlength{\@tempdimb}{\paperheight}
  \iftombow
    \advance \@tempdima 1in
    \advance \@tempdimb 1in
  \fi
  \AtBeginDvi{\special{papersize=\the\@tempdima,\the\@tempdimb}}
\fi
\def\n@baseline{16}
\ifnum\@ptsize=9
  \mag 913 % formerly 900
  \setlength\paperwidth{1.09529\paperwidth}%
  \setlength\paperheight{1.09529\paperheight}%
  \def\n@baseline{15}%
\fi
\ifnum\@ptsize=11
  \mag 1095 % formerly 1100
  \setlength\paperwidth{0.913242\paperwidth}% formerly 0.90909
  \setlength\paperheight{0.913242\paperheight}% 0.90909
\fi
\ifnum\@ptsize=12
  \mag 1200
  \setlength\paperwidth{0.833333\paperwidth}%
  \setlength\paperheight{0.833333\paperheight}%
\fi
\ifnum\@ptsize=14
  \mag 1440
  \setlength\paperwidth{0.694444\paperwidth}%
  \setlength\paperheight{0.694444\paperheight}%
\fi
\ifnum\@ptsize=17
  \mag 1728
  \setlength\paperwidth{0.578704\paperwidth}%
  \setlength\paperheight{0.578704\paperheight}%
\fi
\ifnum\@ptsize=21
  \mag 2074
  \setlength\paperwidth{0.48216\paperwidth}%
  \setlength\paperheight{0.48216\paperheight}%
\fi
\ifjisfont
  \DeclareFontShape{JY1}{mc}{m}{n}{<-> s * [0.961] jis}{}
  \DeclareFontShape{JY1}{gt}{m}{n}{<-> s * [0.961] jisg}{}
\else
  \DeclareFontShape{JY1}{mc}{m}{n}{<-> s * [0.961] min10}{}
  \DeclareFontShape{JY1}{gt}{m}{n}{<-> s * [0.961] goth10}{}
\fi
\DeclareFontShape{JY1}{mc}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{mc}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{sl}{<->ssub*gt/m/n}{}
\DeclareRobustCommand\sffamily
        {\not@math@alphabet\sffamily\mathsf
         \romanfamily\sfdefault\kanjifamily\gtdefault\selectfont}
\DeclareRobustCommand\ttfamily
        {\not@math@alphabet\ttfamily\mathtt
         \romanfamily\ttdefault\kanjifamily\gtdefault\selectfont}
\def\textmc#1{\relax\ifmmode\hbox\fi{\mcfamily #1}}
\def\textgt#1{\relax\ifmmode\hbox\fi{\gtfamily #1}}
\if@enablejfam
  \DeclareSymbolFont{mincho}{JY1}{mc}{m}{n}
  \DeclareSymbolFontAlphabet{\mathmc}{mincho}
  \SetSymbolFont{mincho}{bold}{JY1}{gt}{m}{n}
  \DeclareMathAlphabet{\mathgt}{JY1}{gt}{m}{n}
  \reDeclareMathAlphabet{\mathrm}{\@mathrm}{\@mathmc}
  \reDeclareMathAlphabet{\mathbf}{\@mathbf}{\@mathgt}
  \jfam\symmincho
\fi
\DeclareTextCommand{\textsterling}{OT1}{{\itshape\char`\$}}
\prebreakpenalty\jis"2147=10000      % 5000   ’
\postbreakpenalty\jis"2148=10000     % 5000   “
\prebreakpenalty\jis"2149=10000      % 5000   ”
\inhibitxspcode`〒=2
\def\@{\spacefactor3000\space}
\def\@setfontsize#1#2#3{%
  \ifx\protect\@typeset@protect
    \let\@currsize#1%
  \fi
  \fontsize{#2}{#3}\selectfont
  \ifdim\parindent>\z@
    \parindent=1zw
  \fi
  \kanjiskip=0zw plus .1zw minus .01zw
  \ifdim\xkanjiskip>\z@
    \xkanjiskip=0.25em plus 0.15em minus 0.06em
  \fi}
\emergencystretch 3zw
\newif\ifnarrowbaselines
\def\narrowbaselines{\narrowbaselinestrue\@currsize\selectfont}
\renewcommand{\normalsize}{%
  \ifnarrowbaselines
    \@setfontsize\normalsize\@xpt\@xiipt
  \else
    \@setfontsize\normalsize\@xpt{\n@baseline}%
  \fi
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\setbox0\hbox{\char\euc"A1A1}%
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}
\newcommand{\small}{%
  \ifnarrowbaselines
    \@setfontsize\small\@ixpt{11}%
  \else
    \@setfontsize\small\@ixpt{13}%
  \fi
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep \z@
              \parsep \z@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\footnotesize}{%
  \ifnarrowbaselines
    \@setfontsize\footnotesize\@viiipt{9.5}%
  \else
    \@setfontsize\footnotesize\@viiipt{11}%
  \fi
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep \z@
              \parsep \z@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}
\newcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\if@twocolumn
  \newcommand{\large}{\@setfontsize\large\@xiipt{\n@baseline}}
\else
  \newcommand{\large}{\@setfontsize\large\@xiipt{17}}
\fi
\newcommand{\Large}{\@setfontsize\Large\@xivpt{21}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{25}}
\newcommand{\huge}{\@setfontsize\huge\@xxpt{28}}
\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{33}}
\everydisplay=\expandafter{\the\everydisplay \narrowbaselines}
\newcommand{\headfont}{\rmfamily\bfseries}
\setlength\columnsep{2zw}
\setlength\columnseprule{0\p@}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\setlength\lineskiplimit{1\p@}
\setlength\normallineskiplimit{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip{0\p@}
\setlength\parindent{1zw}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setlength\topskip{10\p@}
\setlength\headheight{\topskip}
\setlength\footskip{0pt}
\setlength\headsep{6mm}
\setlength\maxdepth{.5\topskip}
\newdimen\fullwidth
\setlength\fullwidth{\paperwidth}
\addtolength\fullwidth{-36mm}
\if@twocolumn \@tempdima=2zw \else \@tempdima=1zw \fi
\divide\fullwidth\@tempdima \multiply\fullwidth\@tempdima
\setlength\textwidth{\fullwidth}
\if@twocolumn \else
  \ifdim \fullwidth>40zw
    \setlength\textwidth{40zw}
  \fi
\fi
\setlength{\textheight}{0.83\paperheight}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{-\topskip}
\divide\textheight\baselineskip
\multiply\textheight\baselineskip
\addtolength{\textheight}{\topskip}
\addtolength{\textheight}{0.1\p@}
\setlength\marginparsep{1zw}
\setlength\marginparpush{5\p@}
\setlength{\oddsidemargin}{\paperwidth}
\addtolength{\oddsidemargin}{-\fullwidth}
\setlength{\oddsidemargin}{.5\oddsidemargin}
\iftombow
  \addtolength{\oddsidemargin}{-1in}
\else
  \addtolength{\oddsidemargin}{-1truein}
\fi
\setlength{\evensidemargin}{\oddsidemargin}
\addtolength{\evensidemargin}{\fullwidth}
\addtolength{\evensidemargin}{-\textwidth}
\setlength\marginparwidth{\evensidemargin}
\addtolength\marginparwidth{1truein}
\addtolength\marginparwidth{-1cm}
\addtolength\marginparwidth{-\marginparsep}
\@tempdima=1zw
\divide\marginparwidth\@tempdima
\multiply\marginparwidth\@tempdima
\setlength\topmargin{\paperheight}
\addtolength\topmargin{-\textheight}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}
\addtolength\topmargin{-\footskip}
\setlength\topmargin{0.5\topmargin}
\iftombow
  \addtolength\topmargin{-1in}
\else
  \addtolength\topmargin{-1truein}
\fi
{\footnotesize\global\setlength\footnotesep{\baselineskip}}
\setlength\footnotesep{0.7\footnotesep}
\setlength{\skip\footins}{16\p@ \@plus 5\p@ \@minus 2\p@}
\setcounter{topnumber}{2}
\renewcommand{\topfraction}{.8}
\setcounter{bottomnumber}{1}
\renewcommand{\bottomfraction}{.8}
\setcounter{totalnumber}{3}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.8}
\setcounter{dbltopnumber}{2}
\renewcommand{\dbltopfraction}{.8}
\renewcommand{\dblfloatpagefraction}{.8}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \def\@evenhead{\hss
    \hbox to \fullwidth{\textbf{\thepage}\hfil}}%
  \def\@oddhead{%
    \hbox to \fullwidth{\hfil\textbf{\thepage}}\hss}}
\def\ps@headings{%
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \def\@evenhead{\hss
    \underline{\hbox to \fullwidth{\autoxspacing
        \textbf{\thepage}\hfil\leftmark}}}%
  \def\@oddhead{\underline{\hbox to \fullwidth{\autoxspacing
        {\rightmark}\hfil\textbf{\thepage}}}\hss}%
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
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\leftmark}%
  \def\@oddhead{{\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\chaptermark\@gobble
  \let\sectionmark\@gobble
}
\def\plainifnotempty{%
  \ifx \@oddhead \@empty
    \ifx \@oddfoot \@empty
    \else
      \thispagestyle{plain}%
    \fi
  \else
    \thispagestyle{plain}%
  \fi}
\newif\ifDoctorate
\let\ifDoctorate=\iffalse
\def\Doctorate{\let\ifDoctorate=\iftrue}
\newif\ifMaster
\let\ifMaster=\iffalse
\def\Master{\let\ifMaster=\iftrue}
\newif\ifBachelor
\let\ifBachelor=\iffalse
\def\Bachelor{\let\ifBachelor=\iftrue}
\newif\ifAssociate
\let\ifAssociate=\iffalse
\def\Associate{\let\ifAssociate=\iftrue}
\newif\ifEnglish
\let\ifEnglish=\iffalse
\def\English{\let\ifEnglish=\iftrue}
\newif\iffigurespage \figurespagetrue
\newif\iftablespage \tablespagetrue
\def\years#1{\gdef\@years{#1}}\def\@years{}
\def\Etitle#1{\gdef\@Etitle{#1}}\def\@Etitle{}
\def\idnumber#1{\gdef\@idnumber{#1}}\def\@idnumber{}
\def\Eauthor#1{\gdef\@Eauthor{#1}}\def\@Eauthor{}
\def\advisor#1{\gdef\@advisor{#1}}\def\@advisor{}
\long\def\abstract#1{\gdef\@abstract{#1}}\def\@abstract{}
\long\def\keyword#1{\gdef\@keyword{#1}}\def\@keyword{}
\long\def\Eabstract#1{\gdef\@Eabstract{#1}}\def\@Eabstract{}
\long\def\Ekeyword#1{\gdef\@Ekeyword{#1}}\def\@Ekeyword{}
\if@titlepage
  \newcommand{\maketitle}{%
    \ifEnglish
      \renewcommand{\@title}{\@Etitle}%
      \renewcommand{\@author}{\@Eauthor}%
      \renewcommand{\@abstract}{\@Eabstract}%
      \renewcommand{\@keyword}{\@Ekeyword}%
      \renewcommand{\prepartname}{\tmp@Eprepartname}%
      \renewcommand{\postpartname}{\tmp@Epostpartname}%
      \renewcommand{\prechaptername}{\tmp@Eprechaptername}%
      \renewcommand{\postchaptername}{\tmp@Epostchaptername}%
      \renewcommand{\contentsname}{\tmp@Econtentsname}%
      \renewcommand{\listfigurename}{\tmp@Elistfigurename}%
      \renewcommand{\listtablename}{\tmp@Elisttablename}%
      \renewcommand{\refname}{\tmp@Erefname}%
      \renewcommand{\bibname}{\tmp@Ebibname}%
      \renewcommand{\indexname}{\tmp@Eindexname}%
      \renewcommand{\figurename}{\tmp@Efigurename}%
      \renewcommand{\tablename}{\tmp@Etablename}%
      \renewcommand{\appendixname}{\tmp@Eappendixname}%
      \newcommand{\abstractname}{\tmp@Eabstractname}%
      \newcommand{\keywordname}{\tmp@Ekeywordname}%
      \newcommand{\ackname}{\tmp@Eackname}%
      \newcommand{\posteraname}{\tmp@Eposteraname}%
      \newcommand{\bachelorthesisname}{\tmp@Ebachelorthesisname}%
      \newcommand{\bachelordept}{\tmp@Ebachelordept}%
      \newcommand{\associatethesisname}{\tmp@Eassociatethesisname}%
      \newcommand{\associatedept}{\tmp@Eassociatedept}%
      \newcommand{\advisorname}{\tmp@Eadvisorname}%
      \newcommand{\masterthesisname}{\tmp@Emasterthesisname}%
      \ifMaster
        \newcommand{\mastercourse}{\tmp@Emastercourse}%
      \else
      \fi
      \newcommand{\doctoratethesisname}{\tmp@Edoctoratethesisname}%
      \ifDoctorate
        \newcommand{\doctoratecourse}{\tmp@Edoctoratecourse}%
      \else
      \fi
    \else
      \newcommand{\abstractname}{\tmp@abstractname}%
%%%
      \ifAssociate
       \newcommand{\keywordname}{\tmp@keywordname}%
       \newcommand{\Eabstractname}{\tmp@Eabstractname}%
       \newcommand{\Ekeywordname}{\tmp@Ekeywordname}%
      \else
%%%
       \newcommand{\keywordname}{\tmp@keywordname}%
       \newcommand{\Eabstractname}{\tmp@Eabstractname}%
       \newcommand{\Ekeywordname}{\tmp@Ekeywordname}%
%%%
      \fi
%%%
      \newcommand{\ackname}{\tmp@ackname}%
      \newcommand{\posteraname}{\tmp@posteraname}%
      \newcommand{\bachelorthesisname}{\tmp@bachelorthesisname}%
      \newcommand{\bachelordept}{\tmp@bachelordept}%
      \newcommand{\associatethesisname}{\tmp@associatethesisname}%
      \newcommand{\associatedept}{\tmp@associatedept}%
      \newcommand{\advisorname}{\tmp@advisorname}% 
      \newcommand{\masterthesisname}{\tmp@masterthesisname}%
      \ifMaster
        \newcommand{\mastercourse}{\tmp@mastercourse}%
      \else
      \fi
      \newcommand{\doctoratethesisname}{\tmp@doctoratethesisname}%
      \ifDoctorate
        \newcommand{\doctoratecourse}{\tmp@doctoratecourse}%
      \else
      \fi
    \fi
    \ifDoctorate
      \typeout{\doctoratethesisname}%
      \def\@thesis{\doctoratethesisname}%
      \def\@dept{\doctoratecourse}%
    \else
      \ifMaster
       \typeout{\masterthesisname}%
       \def\@thesis{\masterthesisname}%
       \def\@dept{\mastercourse}%
      \else
         \ifBachelor
          \typeout{\bachelorthesisname}%
          \def\@thesis{\bachelorthesisname}%
          \def\@dept{\bachelordept}%
         \else
          \typeout{\associatethesisname}%
          \def\@thesis{\associatethesisname}%
          \def\@dept{\associatedept}%
     \fi
    \fi
   \fi
   \begin{titlepage}%
      \let\footnotesize\small
      \let\footnoterule\relax
      \let\footnote\thanks
      \setcounter{page}{0}%
      \null\vfil
      \begin{center}%
        {\Large \@years\posteraname \par \@thesis \par}%
        \vskip 20\p@
        {\huge \textbf{\@title} \par}%
        \vskip 15\p@
%%%
        \ifEnglish \else 
		\ifAssociate 
			{\Large \textbf{\@Etitle} \par}
		\else
			{\Large \textbf{\@Etitle} \par}
	\fi\fi
%%%
        \vfill%
        {\large
          \lineskip .75em
          {\renewcommand{\arraystretch}{1.3}
          \begin{tabular}[t]{ll}%
            \@idnumber \hspace{.5zw} & \@author\\
            \advisorname \hspace{.5zw} & \@advisor
          \end{tabular}\par}%
          \vskip 1.8em
          {\large \@date \par}%
          \vskip 1.3em
          \@dept \par}%
      \end{center}\par
      \if@twoside
        \clearpage
        \thispagestyle{empty}%
      \fi
      \@thanks\vfil\null
    \end{titlepage}%
    \setcounter{page}{1}%
    {\def\thepage{\roman{page}}%
    \thispagestyle{noheadings}%
    \typeout{\abstractname}%
    \begin{center}%
      {\Large\textbf{\abstractname}}\par\vskip 2em
      {\Large\@title\par} \vskip 2em 
      {\large \lineskip .75em
        \begin{tabular}[t]{c} \@author \end{tabular}\par}%
      \vskip 2em
    \end{center}%
    \ifEnglish
      \setlength\parindent{\@Eindent}%
      \hskip \@Eindent \@abstract\par
      \vskip 2ex
      \begin{description}
        \item[\itshape\bfseries\keywordname] \hskip 1em \@keyword
      \end{description}\pagebreak
    \else
      \setlength\parindent{\@Jindent}%
      \hskip \@Jindent \@abstract\par
      \vskip 2ex
%%%
     \ifAssociate
      \begin{description}
        \item[\itshape\bfseries\keywordname] \hskip .5zw \@keyword
      \end{description}\pagebreak
     \else
%%%
      \begin{description}
        \item[\itshape\bfseries\keywordname] \hskip .5zw \@keyword
      \end{description}\pagebreak
%%%
     \fi
%%%
    \fi
    \backmatter
    \ifEnglish \else
%%%
     \ifAssociate 
      \typeout{\Eabstractname}%
      \begin{center}%
        {\Large\textbf{\Eabstractname}}\par\vskip 2em
        {\Large\@Etitle\par} \vskip 2em 
        {\large \lineskip .75em
          \begin{tabular}[t]{c} \@Eauthor \end{tabular}\par}%
        \vskip 2em
      \end{center}%
      \setlength\parindent{\@Eindent}%
      \hskip \@Eindent \@Eabstract\par
      \vskip 2ex
      \begin{description}
        \item[\itshape\bfseries\Ekeywordname] \hskip 1em \@Ekeyword
      \end{description}\pagebreak
      \setlength\parindent{\@Jindent}
     \else
%%%
      \typeout{\Eabstractname}%
      \begin{center}%
        {\Large\textbf{\Eabstractname}}\par\vskip 2em
        {\Large\@Etitle\par} \vskip 2em 
        {\large \lineskip .75em
          \begin{tabular}[t]{c} \@Eauthor \end{tabular}\par}%
        \vskip 2em
      \end{center}%
      \setlength\parindent{\@Eindent}%
      \hskip \@Eindent \@Eabstract\par
      \vskip 2ex
      \begin{description}
        \item[\itshape\bfseries\Ekeywordname] \hskip 1em \@Ekeyword
      \end{description}\pagebreak
      \setlength\parindent{\@Jindent}
%%%
     \fi
%%%
    \fi
    \typeout{\contentsname}%
    \tableofcontents
    \iffigurespage
      \typeout{\listfigurename}%
      \listoffigures
    \fi
    \iftablespage
      \typeout{\listtablename}%
      \listoftables
    \fi
    \backmatter}
    \setcounter{page}{1}%
    \ifEnglish
      \setlength\parindent{\@Eindent}%
    \else
      \setlength\parindent{\@Jindent}%
    \fi
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@years\@empty
    \global\let\@title\@empty
    \global\let\@Etitle\@empty
    \global\let\@idnumber\@empty
    \global\let\@author\@empty
    \global\let\@Eauthor\@empty
    \global\let\@advisor\@empty
    \global\let\@date\@empty
    \global\let\@abstract\@empty
    \global\let\@keyword\@empty
    \global\let\@Eabstract\@empty
    \global\let\@Ekeyword\@empty
    \global\let\years\relax
    \global\let\title\relax
    \global\let\Etitle\relax
    \global\let\idnumber\relax
    \global\let\author\relax
    \global\let\Eauthor\relax
    \global\let\advisor\relax
    \global\let\date\relax
    \global\let\abstract\relax
    \global\let\keyword\relax
    \global\let\Eabstract\relax
    \global\let\Ekeyword\relax
    \global\let\and\relax
  }%
\else
  \newcommand{\maketitle}{\par
    \begingroup
      \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
      \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
      \long\def\@makefntext##1{\advance\leftskip 3zw
        \parindent 1zw\noindent
        \llap{\@textsuperscript{\normalfont\@thefnmark}\hskip0.3zw}##1}%
      \if@twocolumn
        \ifnum \col@number=\@ne
          \@maketitle
        \else
          \twocolumn[\@maketitle]%
        \fi
      \else
        \newpage
        \global\@topnum\z@  % Prevents figures from going at top of page.
        \@maketitle
      \fi
      \plainifnotempty
      \@thanks
    \endgroup
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
  }
  \def\@maketitle{%
    \newpage\null
    \vskip 2em
    \begin{center}%
      \let\footnote\thanks
      {\LARGE \@title \par}%
      \vskip 1.5em
      {\large
        \lineskip .5em
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}%
      \vskip 1em
      {\large \@date}%
    \end{center}%
    \par\vskip 1.5em}
\fi
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{\everyparhook}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa<\z@
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}% 目次にフルネームを載せるなら #8
  \else
    \begingroup
      \interlinepenalty \@M % 下から移動
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
        #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}% 目次にフルネームを載せるならここは #8
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa<\z@
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{\everyparhook}%
      \fi\everyparhook}%
  \else
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \fi
  \par  % 2000-12-18
  \ignorespaces}
\setcounter{secnumdepth}{2}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand{\thepart}{\@Roman\c@part}
\renewcommand{\thechapter}{\@arabic\c@chapter}
\renewcommand{\thesection}{\thechapter.\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{%
   \thesubsection.\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{%
   \thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{%
   \theparagraph.\@arabic\c@subparagraph}
\newcommand{\@chapapp}{\prechaptername}
\newcommand{\@chappos}{\postchaptername}
\newcommand{\@secapp}{}
\newcommand\frontmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \pagenumbering{roman}}
\newcommand\mainmatter{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse}
\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{empty}% 欧文用標準スタイルでは plain
  \if@twocolumn
    \onecolumn
    \@restonecoltrue
  \else
    \@restonecolfalse
  \fi
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{%
      \prepartname\thepart\postpartname\hspace{1zw}#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\centering
    \interlinepenalty \@M
    \normalfont
    \ifnum \c@secnumdepth >-2\relax
      \huge\headfont \prepartname\thepart\postpartname
      \par\vskip20\p@
    \fi
    \Huge \headfont #2\par}%
  \@endpart}
\def\@spart#1{{%
    \centering
    \interlinepenalty \M@
    \normalfont
    \Huge \headfont #1\par}%
  \@endpart}
\def\@endpart{\vfil\newpage
  \if@twoside
    \null
    \thispagestyle{empty}%
    \newpage
  \fi
  \if@restonecol
    \twocolumn
  \fi}
\newcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{noheadings}
  \global\@topnum\z@
  \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{\@chapapp\thechapter\@chappos}%
      \ifEnglish
        \addcontentsline{toc}{chapter}%
          {\protect\numberline{\@chapapp\thechapter\@chappos}\@Econtentchapspc#1}%
      \else
        \addcontentsline{toc}{chapter}%
          {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
      \fi
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
\def\@makechapterhead#1{%
%  \vspace*{2\Cvs}% 欧文は50pt
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\headfont \@chapapp\thechapter\@chappos
        \par\nobreak
        \vskip \Cvs % 欧文は20pt
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \headfont #1\par\nobreak
    \vskip 3\Cvs}} % 欧文は40pt
\def\@schapter#1{%
  \if@twocolumn
    \@topnewpage[\@makeschapterhead{#1}]%
  \else
    \@makeschapterhead{#1}\@afterheading
  \fi}
\def\@makeschapterhead#1{%
%  \vspace*{2\Cvs}% 欧文は50pt
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \huge \headfont #1\par\nobreak
    \vskip 2\Cvs}} % 欧文は40pt
\if@twocolumn
  \newcommand{\section}{%
    \@startsection{section}{1}{\z@}%
    {0.6\Cvs}{0.4\Cvs}%
    {\normalfont\large\headfont\@secapp}}
\else
  \newcommand{\section}{\@startsection{section}{1}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}% 前アキ
    {.5\Cvs \@plus.3\Cdp}% 後アキ
    {\normalfont\Large\headfont\@secapp}}
\fi
\if@twocolumn
  \newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
    {\z@}{\z@}%
    {\normalfont\normalsize\headfont}}
\else
  \newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}% 前アキ
    {.5\Cvs \@plus.3\Cdp}% 後アキ
    {\normalfont\large\headfont}}
\fi
\if@twocolumn
  \newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
    {\z@}{\z@}%
    {\normalfont\normalsize\headfont}}
\else
  \newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
    {1.5\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.5\Cvs \@plus.3\Cdp}%
    {\normalfont\normalsize\headfont}}
\fi
\if@twocolumn
  \newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {\z@}{-1zw}% 改行せず 1zw のアキ
    {\normalfont\normalsize\headfont ■}}
\else
  \newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {0.5\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {-1zw}% 改行せず 1zw のアキ
    {\normalfont\normalsize\headfont ■}}
\fi
\newcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
   {\z@}{-1zw}%
   {\normalfont\normalsize\headfont}}
\setlength\leftmargini{2zw}
\if@twocolumn
  \setlength\leftmarginii {2zw} % 2.2em
  \setlength\leftmarginiii{2zw} % 1.87em
  \setlength\leftmarginiv {2zw} % 1.7em
  \setlength\leftmarginv  {1zw} % .5em
  \setlength\leftmarginvi {1zw} % .5em
\else
  \setlength\leftmarginii {2zw} % 2.2em
  \setlength\leftmarginiii{2zw} % 1.87em
  \setlength\leftmarginiv {2zw} % 1.7em
  \setlength\leftmarginv  {1zw} % 1em
  \setlength\leftmarginvi {1zw} % 1em
\fi
\setlength  \labelsep  {0.5zw} % .5em
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{\z@} % {2\p@ \@plus 1\p@ \@minus 1\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listi{\leftmargin\leftmargini
  \parsep \z@
  \topsep 0.5\baselineskip \@plus 0.2\baselineskip \@minus 0.1\baselineskip
  \itemsep \z@ \relax}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
  \labelwidth\leftmarginii \advance\labelwidth-\labelsep
  \topsep \z@
  \parsep \z@
  \itemsep\parsep}
\def\@listiii{\leftmargin\leftmarginiii
  \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
  \topsep \z@
  \parsep \z@
  \itemsep\parsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{\inhibitglue（\theenumii）\inhibitglue}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi\inhibitglue（\theenumii）}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}{%
  \list{}{%
    \labelwidth=\leftmargin
    \labelsep=1zw
    \advance \labelwidth by -\labelsep
    \let \makelabel=\descriptionlabel}}{\endlist}
\newcommand*\descriptionlabel[1]{\normalfont\headfont #1\hfil}
\newenvironment{verse}{%
  \let \\=\@centercr
  \list{}{%
    \itemsep \z@
    \itemindent -2zw % 元: -1.5em
    \listparindent\itemindent
    \rightmargin \z@
    \advance\leftmargin 2zw}% 元: 1.5em
  \item\relax}{\endlist}
\newenvironment{quotation}{%
  \list{}{%
    \listparindent\parindent
    \itemindent\listparindent
    \rightmargin \z@}%
  \item\relax}{\endlist}
\newenvironment{quote}%
  {\list{}{\rightmargin\z@}\item\relax}{\endlist}
\newenvironment{titlepage}{%
    \cleardoublepage
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse\newpage
    \fi
    \thispagestyle{empty}%
    \setcounter{page}\@ne
  }%
  {\if@restonecol\twocolumn \else \newpage \fi
    \if@twoside\else
      \setcounter{page}\@ne
    \fi}
\newcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\@chappos{}%
  \gdef\@Econtentchapspc{\app@Econtentchapspc}%
  \gdef\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne \hfil$\displaystyle{{}##{}}$\hfil
      &\global\@eqcnt\tw@ $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreak\thefigure}
\newenvironment{figure}%
               {\@float{figure}}%
               {\end@float}
\newenvironment{figure*}%
               {\@dblfloat{figure}}%
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreak\thetable}
\newenvironment{table}%
               {\@float{table}}%
               {\end@float}
\newenvironment{table*}%
               {\@dblfloat{table}}%
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{5\p@} % 元: 10\p@
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{{\small
  \advance\leftskip1cm
  \advance\rightskip1cm
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1\hspace{1zw}#2}%
  \ifdim \wd\@tempboxa >\hsize
    #1\hspace{1zw}#2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}}
\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{1}
\newcommand{\tableofcontents}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \ifEnglish
    \renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{2.5zw}}%
  \fi
  \chapter*{\contentsname
    \@mkboth{\contentsname}{\contentsname}}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}
\newcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@
      \rightskip \@tocrmarg
      \parfillskip -\@pnumwidth
      {\leavevmode
        \large \headfont
        \setlength\@lnumwidth{4zw}%
        #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
      \nobreak
    \global\@nobreaktrue
    \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\p@}%
    \begingroup
      \parindent\z@
      \rightskip\@tocrmarg
      \parfillskip-\rightskip
      \leavevmode\headfont
      \ifEnglish
        \setlength\@lnumwidth{10em}%
      \else
        \setlength\@lnumwidth{4.683zw}%
      \fi
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      #1\nobreak\hfil\nobreak\hbox to\@pnumwidth{\hss#2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*{\l@section}{\@dottedtocline{1}{1zw}{3.683zw}}
\newcommand*{\l@subsection}   {\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*{\l@subsubsection}{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*{\l@paragraph}    {\@dottedtocline{4}{10em}{5em}}
\newcommand*{\l@subparagraph} {\@dottedtocline{5}{12em}{6em}}
\newdimen\@lnumwidth
\def\numberline#1{\hb@xt@\@lnumwidth{#1\hfil}\hspace{0pt}}
\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip \z@ \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@lnumwidth #3\relax
   \advance\leftskip \@lnumwidth \null\nobreak\hskip -\leftskip
    {#4}\nobreak
    \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
       mu$}\hfill \nobreak\hb@xt@\@pnumwidth{%
         \hfil\normalfont \normalcolor #5}\par}\fi}
\newcommand{\listoffigures}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listfigurename
  \@mkboth{\listfigurename}{\listfigurename}}%
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi
}
\newcommand*{\l@figure}{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand{\listoftables}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listtablename
  \@mkboth{\listtablename}{\listtablename}}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi
}
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{2zw}
\newenvironment{thebibliography}[1]{%
  \typeout{\bibname}
  \global\let\@secapp\relax
  \chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
  \addcontentsline{toc}{chapter}{\protect\numberline{\bibname}}
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
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}{% 索引を3段組で出力する環境
    \if@twocolumn\onecolumn\else\clearpage\fi
    \columnseprule.4pt \columnsep 2zw
    \ifx\multicols\@undefined
      \twocolumn[\@makeschapterhead{\indexname}]%
    \else
      \ifdim\textwidth<\fullwidth
        \setlength{\evensidemargin}{\oddsidemargin}
        \setlength{\textwidth}{\fullwidth}
        \setlength{\linewidth}{\fullwidth}
        \begin{multicols}{3}[\chapter*{\indexname}]%
      \else
        \begin{multicols}{2}[\chapter*{\indexname}]%
      \fi
    \fi
    \@mkboth{\indexname}{\indexname}%
    \plainifnotempty % \thispagestyle{plain}
    \parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem
    \raggedright
    \footnotesize\narrowbaselines
  }{
    \ifx\multicols\@undefined
      \if@restonecol\onecolumn\else\clearpage\fi
    \else
      \end{multicols}\clearpage
    \fi
  }
\newcommand{\@idxitem}{\par\hangindent 4zw} % 元 40pt
\newcommand{\subitem}{\@idxitem \hspace*{2zw}} % 元 20pt
\newcommand{\subsubitem}{\@idxitem \hspace*{3zw}} % 元 30pt
\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\newcommand\seename{→}
\newcommand\alsoname{→}
\let\footnotes@ve=\footnote
\def\footnote{\inhibitglue\footnotes@ve}
\def\@makefnmark{\hbox{\@textsuperscript{\normalfont
      \ifx\@thefnmark\@empty\else
        \textasteriskcentered
      \fi
      \@thefnmark}}}
\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\long\def\@footnotetext{%
  \insert\footins\bgroup
    \normalfont\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces}%
      \futurelet\next\fo@t}
\def\fo@t{\ifcat\bgroup\noexpand\next \let\next\f@@t
                                \else \let\next\f@t\fi \next}
\def\f@@t{\bgroup\aftergroup\@foot\let\next}
\def\f@t#1{#1\@foot}
\def\@foot{\@finalstrut\strutbox\color@endgroup\egroup}
\newcommand\@makefntext[1]{%
  \advance\leftskip 3zw
  \parindent 1zw
  \noindent
  \llap{\@makefnmark\hskip0.3zw}#1}
\def\@xfootnotenext[#1]{%
  \begingroup
     \ifnum#1>\z@
       \csname c@\@mpfn\endcsname #1\relax
       \unrestored@protected@xdef\@thefnmark{\thempfn}%
     \else
       \unrestored@protected@xdef\@thefnmark{}%
     \fi
  \endgroup
  \@footnotetext}
\def\@inhibitglue{%
  \futurelet\@let@token\@@inhibitglue}
\def\@@inhibitglue{%
  \ifx\@let@token「
    \inhibitglue
  \else
    \ifx\@let@token（
      \inhibitglue
    \else
      \ifx\@let@token『
        \inhibitglue
      \else
        \ifx\@let@token［
          \inhibitglue
        \fi
      \fi
    \fi
  \fi}
\let\everyparhook=\@inhibitglue
\AtBeginDocument{\everypar{\everyparhook}}
\def\@doendpe{%
  \@endpetrue
  \def\par{%
    \@restorepar\everypar{\everyparhook}\par\@endpefalse}%
  \everypar{{\setbox\z@\lastbox}\everypar{\everyparhook}\@endpefalse\everyparhook}}
\def\@item[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@itempenalty
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
    \else
      \clubpenalty \@clubpenalty
      \everypar{\everyparhook}%
    \fi\everyparhook}%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
      \refstepcounter\@listctr
    \fi
  \fi
  \sbox\@tempboxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth
    \hskip -\labelsep
    \ifdim \wd\@tempboxa >\labelwidth
      \box\@tempboxa
    \else
      \hbox to\labelwidth {\unhbox\@tempboxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces}
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{\everyparhook}%
    \fi\everyparhook}}
\def\@gnewline #1{%
  \ifvmode
    \@nolnerr
  \else
    \unskip \reserved@e {\reserved@f#1}\nobreak \hfil \break \everyparhook
  \fi}
\def\小#1{\hbox{$\m@th$%
  \csname S@\f@size\endcsname
  \fontsize\sf@size\z@
  \math@fontsfalse\selectfont
  #1}}
\def\上小#1{{\sbox\z@ T\vbox to\ht0{\小{#1}\vss}}}
\def\cmr{cmr}
\def\ptm{ptm}
\def\pnc{pnc}
\def\txr{txr}
\def\cmrTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    T\kern-.25em\lower.5ex\hbox{E}\kern-.125emX\@
  \else
    T\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX\@
  \fi}
\def\cmrLaTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    L\kern-.32em\上小{A}\kern-.22em\cmrTeX
  \else
    L\kern-.36em\上小{A}\kern-.15em\cmrTeX
  \fi}
\def\sfTeX{T\kern-.1em\lower.4ex\hbox{E}\kern-.07emX\@}
\def\sfLaTeX{L\kern-.25em\上小{A}\kern-.08em\sfTeX}
\def\ptmTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    T\kern-.12em\lower.37ex\hbox{E}\kern-.02emX\@
  \else
    T\kern-.07em\lower.37ex\hbox{E}\kern-.05emX\@
  \fi}
\def\ptmLaTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    L\kern-.2em\上小{A}\kern-.1em\ptmTeX
  \else
    L\kern-.3em\上小{A}\kern-.1em\ptmTeX
  \fi}
\def\pncTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    T\kern-.2em\lower.5ex\hbox{E}\kern-.08emX\@
  \else
    T\kern-.13em\lower.5ex\hbox{E}\kern-.13emX\@
  \fi}
\def\pncLaTeX{%
  \ifdim \fontdimen\@ne\font >\z@
    L\kern-.3em\上小{A}\kern-.1em\pncTeX
  \else
    L\kern-.3em\上小{A}\kern-.1em\pncTeX
  \fi}
\DeclareRobustCommand{\TeX}{%
  \ifx\f@family\cmr\cmrTeX
  \else
    \ifx\f@family\ptm\ptmTeX
    \else
      \ifx\f@family\txr\ptmTeX
      \else
        \ifx\f@family\pnc\pncTeX
        \else\sfTeX
        \fi
      \fi
    \fi
  \fi}
\DeclareRobustCommand{\LaTeX}{%
  \ifx\f@family\cmr\cmrLaTeX
  \else
    \ifx\f@family\ptm\ptmLaTeX
    \else
      \ifx\f@family\txr\ptmLaTeX
      \else
        \ifx\f@family\pnc\pncLaTeX
        \else\sfLaTeX
        \fi
      \fi
    \fi
  \fi}
\DeclareRobustCommand{\LaTeXe}{$\mbox{%
  \if b\expandafter\@car\f@series\@nil\boldmath\fi
  \LaTeX\kern.15em2\raisebox{-.37ex}{$\textstyle\varepsilon$}}$}
\def\pTeX{p\kern-.05em\TeX}
\def\pLaTeX{p\LaTeX}
\def\pLaTeXe{p\LaTeXe}
\def\AmSTeX{\protect\AmS-\protect\TeX{}}
\DeclareRobustCommand{\BibTeX}{B\kern-.05em\小{I\kern-.025em B}%
  \ifx\f@family\cmr\kern-.08em\else\kern-.15em\fi\TeX}
\DeclareRobustCommand{\SliTeX}{%
  S\kern-.06emL\kern-.18em\上小{I}\kern -.03em\TeX}
\newcommand{\prepartname}{第}
\newcommand{\postpartname}{部}
\newcommand{\prechaptername}{第}
\newcommand{\postchaptername}{章}
\newcommand{\contentsname}{目次}
\newcommand{\listfigurename}{図目次}
\newcommand{\listtablename}{表目次}
\newcommand{\refname}{参考文献}
\newcommand{\bibname}{参考文献}
\newcommand{\indexname}{索引}
\newcommand{\figurename}{図}
\newcommand{\tablename}{表}
\newcommand{\appendixname}{付録}
\newif\if西暦 \西暦true
\def\西暦{\西暦true}
\def\和暦{\西暦false}
\newcount\heisei \heisei\year \advance\heisei-1988\relax
\def\today{%
  \if西暦
    \number\year 年
    \number\month 月
    \number\day 日
  \else
    平成\number\heisei 年
    \number\month 月
    \number\day 日
  \fi}
\hyphenation{ado-be post-script ghost-script phe-nom-e-no-log-i-cal man-u-script}
\pagestyle{headings}
\pagenumbering{arabic}
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
  \raggedbottom
\fi
\def \check@nocorr@ #1#2\nocorr#3\@nil {%
  \let \check@icl \relax
  \def \check@icr {\ifvmode \else \aftergroup \maybe@ic \fi}%
  \def \reserved@a {\nocorr}%
  \def \reserved@b {#1}%
  \def \reserved@c {#3}%
  \ifx \reserved@a \reserved@b
    \ifx \reserved@c \@empty
      \let \check@icl \@empty
    \else
      \let \check@icl \@empty
      \let \check@icr \@empty
    \fi
  \else
    \ifx \reserved@c \@empty
    \else
      \let \check@icr \@empty
    \fi
  \fi
}
%%%%%%%%%%%%%%%%%%%%%% Add FontShape %%%%%%%%%%%%%%%%%%%%%%%
\DeclareFontShape{JY1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{m}{sl}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sl}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{it}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JT1}{mc}{bx}{it}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JY1}{mc}{bx}{sl}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JT1}{mc}{bx}{sl}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JY1}{mc}{bx}{sc}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JT1}{mc}{bx}{sc}{<->ssub*mc/bx/n}{}
\DeclareFontShape{JY1}{mc}{sbc}{n}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{sbc}{n}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{sc}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{sc}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{bx}{it}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JT1}{gt}{bx}{it}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JY1}{gt}{bx}{sl}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JT1}{gt}{bx}{sl}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JY1}{gt}{bx}{sc}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JT1}{gt}{bx}{sc}{<->ssub*gt/bx/n}{}
\DeclareFontShape{JY1}{gt}{sbc}{n}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{sbc}{n}{<->ssub*gt/m/n}{}
\DeclareFontShape{OT1}{cmr}{bx}{sc}{<->ssub*cmr/bx/n}{}
\DeclareFontShape{OT1}{cmss}{m}{it}{<->ssub*cmss/m/sl}{}
\DeclareFontShape{OT1}{cmss}{m}{sc}{<->ssub*cmr/m/sc}{}
\DeclareFontShape{OT1}{cmtt}{bx}{it}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OT1}{cmtt}{bx}{sl}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OT1}{cmtt}{bx}{sc}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OT1}{cmss}{bx}{it}{<->ssub*cmss/bx/n}{}
\DeclareFontShape{OT1}{cmss}{bx}{sl}{<->ssub*cmss/bx/n}{}
\DeclareFontShape{OT1}{cmss}{bx}{sc}{<->ssub*cmss/bx/n}{}
\DeclareFontFamily{OMS}{cmtt}{\skewchar\font 48}
\DeclareFontShape{OMS}{cmtt}{m}{n}{<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{it}{<->ssub*cmtt/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{sl}{<->ssub*cmtt/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{sc}{<->ssub*cmtt/m/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{n}{<->ssub*cmtt/m/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{it}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{sl}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{sc}{<->ssub*cmtt/bx/n}{}
\DeclareFontShape{OT1}{cmtt}{sbc}{n}{<->ssub*cmtt/m/n}{}
\DeclareFontFamily{OMS}{cmss}{\skewchar\font48}
\DeclareFontShape{OMS}{cmss}{m}{n}{<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmss}{m}{it}{<->ssub*cmss/m/n}{}
\DeclareFontShape{OMS}{cmss}{m}{sl}{<->ssub*cmss/m/n}{}
\DeclareFontShape{OMS}{cmss}{m}{sc}{<->ssub*cmss/m/n}{}
\DeclareFontShape{OMS}{cmss}{bx}{n}{<->ssub*cmss/m/n}{}
\DeclareFontShape{OMS}{cmss}{bx}{it}{<->ssub*cmss/bx/n}{}
\DeclareFontShape{OMS}{cmss}{bx}{sl}{<->ssub*cmss/bx/n}{}
\DeclareFontShape{OMS}{cmss}{bx}{sc}{<->ssub*cmss/bx/n}{}
%%%%%%%%%%%%%%%%%%%%% Header & Footer %%%%%%%%%%%%%%%%%%%%%%
\def\ps@newheadings{%
  \def\@oddfoot{\reset@font\hfil--\ \textbf{\thepage}\ --\hfil}%
  \let\@evenfoot\@oddfoot
  \def\@evenhead{\hss
    \hbox to \fullwidth{\autoxspacing
    \hfil\leftmark}}%
  \def\@oddhead{\hbox to \fullwidth{\autoxspacing
        {\rightmark}\hfil}\hss}%
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
\def\ps@noheadings{%
  \let\@mkboth\@gobbletwo
  \def\@oddfoot{\reset@font\hfil--\ \textbf{\thepage}\ --\hfil}%
  \let\@evenfoot\@oddfoot
  \let\@evenhead\@empty
  \let\@oddhead\@empty}
%%%%%%%%%%%%%%%%%%% New Command & Macro %%%%%%%%%%%%%%%%%%%%
\newcommand{\acknowledgement}{%
  \typeout{\ackname}%
  \chapter*{\ackname\@mkboth{\ackname}{\ackname}}%
  \addcontentsline{toc}{chapter}{\protect\numberline{\ackname}}}
\def\Hline{\noalign{\ifnum0=`}\fi
  \hrule \@height 3\arrayrulewidth \futurelet \@tempa\@xhhline}
\def\@xhhline{\ifx\@tempa\Hline\vskip \doublerulesep\fi \ifnum0=`{\fi}}
\newcommand{\up}[1]{\hspace*{-.1zw}\raisebox{.4zh}%
  {\footnotesize{\kern 0cm{#1}}}}
\newcommand{\lw}[1]{\smash{\lower2.ex\hbox{#1}}}
\newcommand{\MARU}[1]{{%
  \ooalign{\hfil#1\/\hfil\crcr\raise.167ex\hbox{\mathhexbox20D}}}}
%%%%%%%%%%%% Adjustment for table of contents %%%%%%%%%%%%%%
\def\@Econtentchapspc{\hspace{-4.7em}}
\def\app@Econtentchapspc{\hspace{-3.7em}}
%%%%%%%%%%%%%%%%%%%%%%%%%% Indent %%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@Jindent{1\Cwd}
\def\@Eindent{2em}
%%%%%%%%%%%%%%%%%%%% Language setting %%%%%%%%%%%%%%%%%%%%%%
\def\tmp@abstractname{要 旨}
\def\tmp@keywordname{キーワード}
\def\tmp@ackname{謝辞}
\def\tmp@posteraname{年度}
\def\tmp@doctoratethesisname{博士学位論文}
\def\tmp@doctoratecourse{高知工業高等専門学校大学院 工学研究科\\機械・電気工学専攻}
\def\tmp@masterthesisname{修士学位論文}
\def\tmp@mastercourse{高知工業高等専門学校大学院 工学研究科\\機械・電気工学専攻}
\def\tmp@bachelorthesisname{学士学位論文}
\def\tmp@bachelordept{高知工業高等専門学校 専攻科\\機械・電気工学専攻}
\def\tmp@associatethesisname{準学士論文}
\def\tmp@associatedept{高知工業高等専門学校 電気情報工学科}
\def\tmp@advisorname{指導教員}
\def\tmp@Eabstractname{Abstract}
\def\tmp@Ekeywordname{key words}
\def\tmp@Eackname{Acknowledgement}
\def\tmp@Eposteraname{}
\def\tmp@Edoctoratethesisname{Doctorate thesis}
\def\tmp@Emasterthesisname{Master's thesis}
\def\tmp@Ebachelorthesisname{Bachelor's thesis}
\def\tmp@Eassociatethesisname{Associate of Engineering's thesis}
\def\tmp@Edoctoratecourse{Course of Mechanical and Electrical Engineering \\ Graduate School of Engineering, Kochi National College of Technology}
\def\tmp@Emastercourse{Course of Mechanical and Electrical Engineering \\ Graduate School of Engineering, Kochi National College of Technology}
\def\tmp@Ebachelordept{Advanced Course in Mechanical and Electrical Engineering \\Kochi National College of Technology}
\def\tmp@Eassociatedept{Department of Electrical Engineering\\Kochi National College of Technology}
\def\tmp@Eadvisorname{Advisor}
\def\tmp@Eprepartname{Part }
\def\tmp@Epostpartname{}
\def\tmp@Eprechaptername{Chapter }
\def\tmp@Epostchaptername{}
\def\tmp@Econtentsname{Contents}
\def\tmp@Elistfigurename{List of Figures}
\def\tmp@Elisttablename{List of Tables}
\def\tmp@Erefname{References}
\def\tmp@Ebibname{References}
\def\tmp@Eindexname{Index}
\def\tmp@Efigurename{Fig. }
\def\tmp@Etablename{Table }
\def\tmp@Eappendixname{Appendix }
%%%%%%%%%%%%%%%%%%%%%% Style setting %%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{newheadings}
\setcounter{tocdepth}{3}
\renewcommand{\baselinestretch}{1.333}
\def\left@margin{25mm}
\def\right@margin{25mm}
\def\top@margin{30mm}
\def\bot@margin{30mm}
\setlength{\oddsidemargin}{\left@margin}
\addtolength{\oddsidemargin}{-1in}
\setlength{\oddsidemargin}{0.833333\oddsidemargin}
\setlength{\evensidemargin}{\left@margin}
\addtolength{\evensidemargin}{-1in}
\setlength{\evensidemargin}{0.833333\evensidemargin}
\setlength{\textwidth}{210mm}
\addtolength{\textwidth}{-\left@margin}
\addtolength{\textwidth}{-\right@margin}
\setlength{\textwidth}{0.833333\textwidth}
\setlength{\headheight}{10pt}
\setlength{\headsep}{10mm}
\setlength{\footskip}{15mm}
\setlength{\topmargin}{\top@margin}
\addtolength{\topmargin}{-1in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength{\topmargin}{0.833333\topmargin}
\setlength{\textheight}{297mm}
\addtolength{\textheight}{-5mm}
\addtolength{\textheight}{-\top@margin}
\addtolength{\textheight}{-\bot@margin}
\setlength{\textheight}{0.833333\textheight}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Change for your environment %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\hoffset}{0mm}
\setlength{\voffset}{0mm}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
%%
%% End of file `knct-paper.cls'.

