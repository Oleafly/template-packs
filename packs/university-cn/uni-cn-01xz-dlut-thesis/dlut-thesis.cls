% The LaTeX class file should maintain a clean separation between the style and content.
% Users should not have to modify the class file to change the document's content.


%-----------------------------------------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\ProvidesClass{dlut-thesis}
[2024/03/05 0.0.1 Dalian University of Technology Thesis Template]
\def\version{0.0.1}


%-----------------------------------------------------------------------------------------------------------------------
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm,mathrsfs}
\RequirePackage{upgreek}
\RequirePackage[version=4]{mhchem}
\RequirePackage{siunitx}
\RequirePackage{pdfpages}
\RequirePackage{notoccite}
\RequirePackage{ifthen}
\RequirePackage{ifpdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\newif\ifdlut@istwoside\dlut@istwosidefalse
\newif\ifdlut@adobe\dlut@adobefalse
\DeclareOption{twoside}{\dlut@istwosidetrue}
\DeclareOption{adobe}{\dlut@adobetrue}

\ProcessOptions\relax
\ifdlut@istwoside
    \LoadClass[zihao=-4,a4paper,twoside,openright,UTF8,space=auto,fontset=none]{ctexbook}
\else
    \LoadClass[zihao=-4,a4paper,oneside,openany,UTF8,space=auto,fontset=none]{ctexbook}
\fi

\setlength{\parskip}{0pt}

%-----------------------------------------------------------------------------------------------------------------------
% Font settings
\ProcessOptions\relax
\ifdlut@adobe
    \setCJKmainfont[AutoFakeBold=true, Path="fonts/adobe/"]{AdobeSongStd-Light.otf}
    \newCJKfontfamily{\songti}   [AutoFakeBold=true, Path="fonts/adobe/"] {AdobeSongStd-Light.otf}
    \newCJKfontfamily{\heiti}    [AutoFakeBold=true, Path="fonts/adobe/"] {AdobeHeitiStd-Regular.otf}
    \newCJKfontfamily{\kaishu}   [AutoFakeBold=true, Path="fonts/adobe/"] {AdobeKaitiStd-Regular.otf}
    \newCJKfontfamily{\fangsong} [AutoFakeBold=true, Path="fonts/adobe/"] {AdobeFangsongStd-Regular.otf}
    \newCJKfontfamily{\xingkai}  [AutoFakeBold=true, Path="fonts/windows/"] {STXingKai.ttf}
    \newCJKfontfamily{\xihei}    [AutoFakeBold=true, Path="fonts/windows/"] {STXiHei.ttf}
\else
    \setCJKmainfont[AutoFakeBold=true, Path="fonts/windows/"]{SimSun.ttc}
    \newCJKfontfamily{\songti}   [AutoFakeBold=true, Path="fonts/windows/"] {SimSun.ttc}
    \newCJKfontfamily{\heiti}    [AutoFakeBold=true, Path="fonts/windows/"] {SimHei.ttf}
    \newCJKfontfamily{\kaishu}   [AutoFakeBold=true, Path="fonts/windows/"] {SimKai.ttf}
    \newCJKfontfamily{\fangsong} [AutoFakeBold=true, Path="fonts/windows/"] {SimFang.ttf}
    \newCJKfontfamily{\xingkai}  [AutoFakeBold=true, Path="fonts/windows/"] {STXingKai.ttf}
    \newCJKfontfamily{\xihei}    [AutoFakeBold=true, Path="fonts/windows/"] {STXiHei.ttf}
\fi

\setmainfont[
    Path="fonts/windows/",
    BoldFont={timesbd.ttf},
    ItalicFont={timesi.ttf},
    BoldItalicFont={timesbi.ttf},
]{times.ttf}


%-----------------------------------------------------------------------------------------------------------------------
% originality statement
\def\dlut@label@original{学位论文原创性申明}
\def\dlut@label@authorization{大连理工大学学位论文版权使用授权书}
\def\dlut@label@authorsign{作~~者~~签~~名~~：}
\def\dlut@label@Supervisorsign{导~~师~~签~~名~~：}
\def\dlut@label@originalDate{日期：}
\def\dlut@label@originaltitle{学位论文题目：}
\def\dlut@label@originalchairman{答辩委员会主席：}
\def\dlut@label@originalcontent{\dlutspace\dlutspace 本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经指明引用的内容外，学位论文不含任何其他个人、法人或者非法人组织已经发表或尚未发表的作品，且学位论文中已经指明作者姓名或者名称、作品名称的内容，不影响该作品的正常使用，也不存在不合理地损害相关权利人的合法权益的任何情形。对学位论文研究做出重要贡献的个人和法人或者非法人组织，均已在论文中以明确方式标明，且不存在任何著作权纠纷。\par 若因声明不实，本人愿意为此承当相应的法律责任。}
\def\dlut@label@authorizationcontent{\dlutspace\dlutspace 本人完全了解大连理工大学有关学位论文知识产权的规定，在校攻读学位期间论文工作的知识产权属于大连理工大学，允许论文被查阅和借阅。学校有权保留论文并向国家有关部门或机构送交论文的复印件和电子版，可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印、或扫描等复制手段保存和汇编本学位论文。}


%-----------------------------------------------------------------------------------------------------------------------
% Keys and Values in both Chinese(zh) and English(en)
% Keys
\def\dlut@key@zh@title{论文题目}
\def\dlut@key@en@title{Title of Thesis}

\def\dlut@key@zh@schoolname{学校名称}
\def\dlut@key@en@schoolname{School Name}

\def\dlut@key@zh@thesistype{论文类型}
\def\dlut@key@en@thesistype{Thesis Type}

\def\dlut@key@zh@author{作~~者~~姓~~名：}
\def\dlut@key@en@author{Author Name}

\def\dlut@key@zh@authorid{学~~~~~~~~~~~~~~号：}
\def\dlut@key@en@authorid{Student ID}

\def\dlut@key@zh@advisor{指~~导~~教~~师：}
\def\dlut@key@en@advisor{Supervisor Name}

\def\dlut@key@zh@major{学科~、~专业：}
\def\dlut@key@en@major{Major}

\def\dlut@key@zh@defenddate{答~~辩~~日~~期：}
\def\dlut@key@en@defenddate{Defend Date}

% Values
\def\dlut@value@zh@title{（论文题目）}
\def\dlut@value@en@title{(Title of Thesis)}

\def\dlut@value@zh@schoolname{大连理工大学}
\def\dlut@value@en@schoolname{Dalian University of Technology}

\def\dlut@value@zh@thesistype{硕~~士~~学~~位~~论~~文}
\def\dlut@value@en@thesistype{Master Thesis}

\def\dlut@value@zh@author{（作者姓名）}
\def\dlut@value@en@author{(Author Name)}

\def\dlut@value@zh@authorid{（学号）}
\def\dlut@value@en@authorid{(Student ID)}

\def\dlut@value@zh@advisor{（导师姓名）}
\def\dlut@value@en@advisor{(Supervisor Name)}

\def\dlut@value@zh@major{（专业）}
\def\dlut@value@en@major{(Major)}

\def\dlut@value@zh@defenddate{\today}
\def\dlut@value@en@defenddate{\today}


%-----------------------------------------------------------------------------------------------------------------------
% New commands for setting values
\renewcommand\title[2]{\def\dlut@value@zh@title{#1}\def\dlut@value@en@title{#2}}
\renewcommand\author[2]{\def\dlut@value@zh@author{#1}\def\dlut@value@en@author{#2}}
\newcommand\authorid[1]{\def\dlut@value@zh@authorid{#1}\def\dlut@value@en@authorid{#1}}
\newcommand\advisor[2]{\def\dlut@value@zh@advisor{#1}\def\dlut@value@en@advisor{#2}}
\newcommand\major[2]{\def\dlut@value@zh@major{#1}\def\dlut@value@en@major{#2}}
\newcommand\defenddate[1]{\def\dlut@value@zh@defenddate{#1}\def\dlut@value@en@defenddate{#1}}


%-----------------------------------------------------------------------------------------------------------------------
% Labels in both Chinese(zh) and English(en)
\def\dlut@label@zh@thesistypetitle{大连理工大学硕士学位论文}
\def\dlut@label@en@thesistypetitle{Master~Thesis~of~Dalian~University~of~Technology}

\def\dlut@label@zh@abstract{摘~~~~~~~~要}
\def\dlut@label@en@abstract{ABSTRACT}

\def\dlut@label@zh@keywords{关键词：}
\def\dlut@label@en@keywords{Key Words:~}

\def\dlut@label@zh@toc{目~~~~~~~~录}
\def\dlut@label@en@toc{TABLE OF CONTENTS}

\def\dlut@label@zh@listfigurename{图目录}

\def\dlut@label@zh@listtablename{表目录}

\def\dlut@label@zh@listdenotationname{主要符号表}

\def\dlut@label@zh@references{参~~考~~文~~献}
\def\dlut@label@en@references{References}

\def\dlut@label@zh@appendix{附录}
\def\dlut@label@en@appendix{Appendix}

\def\dlut@label@zh@achievements{攻读硕士学位期间科研项目及科研成果}
\def\dlut@label@en@achievements{Achievements}

\def\dlut@label@zh@acknowledgements{致~~~~~~~~谢}
\def\dlut@label@en@acknowledgements{Acknowledgements}


%-----------------------------------------------------------------------------------------------------------------------
% Page Layout
\RequirePackage[%
    paper=a4paper,
    top=4.1cm,
    bottom=3.5cm,
    left=2.5cm,
    right=2.5cm,
    headsep=1.2cm,
    headheight=0.5cm,
    footskip=1.65cm,
]{geometry}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \thispagestyle{empty}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\RequirePackage{setspace}
\setstretch{1.35}


%-----------------------------------------------------------------------------------------------------------------------
% Title style
\ctexset{%
    chapter={
        name = {},
        number = {\arabic{chapter}},
        format = { \CTEXifname{\raggedright\heiti\zihao{3}}{\centering\heiti\zihao{-3}\textbf}},,
        pagestyle = {dlut@headings},
        beforeskip = 4bp,
        afterskip = 26bp,
        fixskip = true,
        lofskip = 0pt,
        lotskip = 0pt,
    },
    section={
        format = {\heiti\zihao{4}},
        beforeskip = 14bp,
        afterskip = 14bp,
        fixskip = true,
    },
    subsection={
        format = {\raggedright\heiti\zihao{-4}},
        beforeskip = 13bp,
        afterskip = 13bp,
        fixskip = true,
    },
    subsubsection={
        name = {(,)},
        number = {\arabic{subsubsection}},
        format = {\raggedright\heiti\zihao{-4}},
        beforeskip = 12bp,
        afterskip = 12bp,
        fixskip = true,
    }%
}


%-----------------------------------------------------------------------------------------------------------------------
% Table of contents style
\RequirePackage{titletoc}

\contentsmargin{\z@}

\titlecontents{chapter}
  [0pt]{\songti\zihao{-4}}
  {\thecontentslabel\;}{}
  {\titlerule*[4bp]{.}\thecontentspage}

\titlecontents{section}
  [2\ccwd]{\songti\zihao{-4}}
  {\thecontentslabel\;}{}
  {\titlerule*[4bp]{.}\thecontentspage}

\titlecontents{subsection}
  [4\ccwd]{\songti\zihao{-4}}
  {\thecontentslabel\;}{}
  {\titlerule*[4bp]{.}\thecontentspage}

\titlecontents{figure}
  [0pt]{\songti\zihao{-4}}
  {\figurename\thecontentslabel\;}{\hspace*{-1.5cm}}
  {\titlerule*[4bp]{.}\thecontentspage}

\titlecontents{table}
  [0pt]{\songti\zihao{-4}}
  {\tablename\thecontentslabel\;}{\hspace*{-1.5cm}}
  {\titlerule*[4bp]{.}\thecontentspage}

% Table of contents in Chinese
\newcommand\mktoc{
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\dlut@label@zh@toc}
    \addcontentsline{toc}{chapter}{\dlut@label@zh@toc}
    \@starttoc{toc}
    \if@restonecol
        \twocolumn
    \fi
}

% Table of contents in English
\newcommand\mktoe{
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\dlut@label@en@toc}
    \addcontentsline{toc}{chapter}{\dlut@label@en@toc}
    \@starttoc{toe}
    \if@restonecol
        \twocolumn
    \fi
}

\renewcommand\listfigurename{\dlut@label@zh@listfigurename}
\renewcommand\listtablename{\dlut@label@zh@listtablename}


%-----------------------------------------------------------------------------------------------------------------------
% denotation
\newenvironment{denotation}
{\chapter*{\dlut@label@zh@listdenotationname}
    \addcontentsline{toc}{chapter}{\dlut@label@zh@listdenotationname}}
{}


%-----------------------------------------------------------------------------------------------------------------------
% new commands for chapter, section, subsection
\newcommand{\bichapter}[2]
{   \chapter{#1}
    \addcontentsline{toe}{chapter}{\protect\numberline{\csname thechapter\endcsname}#2}
}

\newcommand{\bisection}[2]
{   \section{#1}
    \addcontentsline{toe}{section}{\protect\numberline{\csname thesection\endcsname}#2}
}

\newcommand{\bisubsection}[2]
{   \subsection{#1}
    \addcontentsline{toe}{subsection}{\protect\numberline{\csname thesubsection\endcsname}#2}
}


%-----------------------------------------------------------------------------------------------------------------------
% settings for header and footer
\RequirePackage{fancyhdr}
\fancypagestyle{dlut@empty}{\fancyhf{}}

\fancypagestyle{dlut@headings}{%
    \fancyhf{}
    \fancyfoot[C]{\songti\zihao{-5}{$-$~\thepage~$-$}}
    \fancyhead[CO]{\zihao{5}{\songti\dlut@label@zh@thesistypetitle}}
    \fancyhead[CE]{\zihao{5}{\songti\dlut@value@zh@title}}
}

\let\dlut@cleardoublepage\cleardoublepage
\newcommand{\dlut@clearemptydoublepage}{%
    \clearpage{\pagestyle{dlut@empty}\dlut@cleardoublepage}}
\let\cleardoublepage\dlut@clearemptydoublepage

\renewcommand{\frontmatter}{
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmatterfalse
    \pagenumbering{Roman}
    \pagestyle{dlut@headings}
}

\renewcommand{\mainmatter}{
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmattertrue
    \pagenumbering{arabic}
    \pagestyle{dlut@headings}
}


%-----------------------------------------------------------------------------------------------------------------------
% tables
\RequirePackage{threeparttable}
\RequirePackage{dcolumn}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\newcolumntype{d}[1]{D{.}{.}{#1}}

\newcommand{\me}{\mathrm{e}}
\newcommand{\mi}{\mathrm{i}}
\newcommand{\mj}{\mathrm{j}}
\newcommand{\dif}{\,\mathrm{d}}

\theoremstyle{definition}
\newtheorem{algo}{算法~}[chapter]
\newtheorem{thm}{定理~}[chapter]
\newtheorem{lem}[thm]{引理~}
\newtheorem{prop}[thm]{命题~}
\newtheorem{cor}[thm]{推论~}
\theoremstyle{definition}
\newtheorem{defn}{定义~}[chapter]
\newtheorem{conj}{猜想~}[chapter]
\newtheorem{exmp}{例~}[chapter]
\newtheorem{rem}{注~}
\newtheorem{case}{情形~}
\renewcommand{\proofname}{\bf 证明}

\RequirePackage{xltxtra}
\RequirePackage{graphicx}
\RequirePackage{makecell}
\RequirePackage{wrapfig}

\RequirePackage[labelformat=simple]{subcaption}
\renewcommand{\thesubfigure}{(\alph{subfigure})}


%-----------------------------------------------------------------------------------------------------------------------
% title settings for tables and figures
\RequirePackage{amsmath}
\RequirePackage[list=off]{bicaption}
\RequirePackage[justification=centering]{caption}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\DeclareCaptionLabelSeparator{zhspace}{\hspace{1\ccwd}}
\DeclareCaptionFont{fontsize}{\songti\zihao{5}}
\captionsetup{
    font = {fontsize},
    labelsep = zhspace,
}
\captionsetup[figure][bi-second]{name=Fig.}
\captionsetup[table]{
    position = top,
    aboveskip = 6bp,
    belowskip = 6bp,
}
\numberwithin{table}{chapter}
\captionsetup[figure]{
    position = bottom,
    aboveskip = 6bp,
    belowskip = 6bp,
}
\captionsetup[table][bi-second]{name=Tab.}

\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg,.jpeg}

\setlength{\intextsep}{12pt}
\setlength{\textfloatsep}{12pt}

%-----------------------------------------------------------------------------------------------------------------------
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}


%-----------------------------------------------------------------------------------------------------------------------
% number style for equations, figures and tables
\renewcommand\theequation{\arabic{chapter}.\arabic{equation}}
\renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
\renewcommand\thetable{\arabic{chapter}.\arabic{table}}


%-----------------------------------------------------------------------------------------------------------------------
\RequirePackage{xcolor}
\RequirePackage{float}


%-----------------------------------------------------------------------------------------------------------------------
\newcommand{\cndash}{\rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}}


%-----------------------------------------------------------------------------------------------------------------------
% algorithm
\newcounter{algorithm}[chapter]
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}
\renewcommand{\algorithmicrequire}{\textbf{Input:}}
\renewcommand{\algorithmicensure}{\textbf{Output:}}
\renewcommand\thealgorithm{\thechapter.\arabic{algorithm}}
\floatname{algorithm}{算法}


%-----------------------------------------------------------------------------------------------------------------------
% hyperref
\RequirePackage{hyperref}
\hypersetup{
    bookmarksnumbered,
    linktoc=all,
    colorlinks=true,
    citecolor=black,
    filecolor=cyan,
    linkcolor=black,
    linkbordercolor=black,
    urlcolor=black,
    plainpages=false,
    pdfstartview=FitH
}


%-----------------------------------------------------------------------------------------------------------------------
% enumerate
\RequirePackage{enumitem}
\RequirePackage{supertabular}

\setenumerate[1]{label=\arabic*), itemindent=1em, itemsep=0pt, partopsep=0pt, parsep=\parskip, topsep=0pt}


%-----------------------------------------------------------------------------------------------------------------------
% cite the reference style
\RequirePackage[numbers,square,comma,sort&compress,super]{natbib}
\bibliographystyle{gbt7714-2005}


%-----------------------------------------------------------------------------------------------------------------------
% dlut space
\newcommand{\dlutspace}[1][1]{\hspace{#1\ccwd}}

\def\dlut@underline[#1]#2{%
    \underline{\hbox to #1{\hfill#2\hfill}}}
\def\dlutunderline{\@ifnextchar[\dlut@underline\underline}


%-----------------------------------------------------------------------------------------------------------------------
% title page in Chinese
\renewcommand\maketitle
{
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \vskip \stretch{1}
        \def\tabcolsep{1pt}
        \def\arraystretch{1.5}
        \parbox[t][4.40cm][c]{\textwidth}
        {
            \begin{center}
                \vspace{3.5cm}
                {\songti\zihao{-1}\textbf{\dlut@value@zh@thesistype}\\}
                \vspace{1.34cm}
                {\xihei\zihao{2}\textbf{\dlut@value@zh@title}\\}
                \vspace{0.13cm}
                {\zihao{3}\textbf{\dlut@value@en@title}\\}
            \end{center}
        }
        \vspace{8.1cm}\\
        {\songti\zihao{-3}\dlut@key@zh@author}\dlutunderline[170pt]{\songti\zihao{-3}\dlut@value@zh@author}
            \vskip 10pt
        {\songti\zihao{-3}\dlut@key@zh@authorid}\dlutunderline[170pt]{\songti\zihao{-3}\dlut@value@zh@authorid}
            \vskip 10pt
        {\songti\zihao{-3}\dlut@key@zh@advisor}\dlutunderline[170pt]{\songti\zihao{-3}\dlut@value@zh@advisor}
            \vskip 10pt
        {\songti\zihao{-3}\dlut@key@zh@major}\dlutunderline[170pt]{\songti\zihao{-3}\dlut@value@zh@major}
            \vskip 10pt
        {\songti\zihao{-3}\dlut@key@zh@defenddate}\dlutunderline[170pt]{\songti\zihao{-3}\dlut@value@zh@defenddate}
            \\
        \vspace{1.8cm}
        {\Large\xingkai\dlut@value@zh@schoolname\\}
        \vspace{2.3mm}
        {\zihao{-4}\dlut@value@en@schoolname}
    \end{center}
    \vskip \stretch{0.5}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage
    \fi
}


%-----------------------------------------------------------------------------------------------------------------------
% originality statement
\newcommand\makeDeclareOriginal{%
    \cleardoublepage
    \pdfbookmark[0]{声明}{statement}
    \thispagestyle{empty}
    \begin{center}
        \parbox[t][1.52cm][c]{\textwidth}
        {\heiti\zihao{-2}\centerline \dlut@label@original}
    \end{center}
    \vskip 10pt
        {\songti\zihao{-4}\dlut@label@originalcontent}
    \vskip 10pt
        {\songti\zihao{-4}\dlut@label@originaltitle}\dlutunderline[303pt]{\dlut@value@zh@title}
    \vskip 3pt
    \indent{\songti\zihao{-4}\dlut@label@authorsign} \dlutunderline[8em]{} \hspace{1.3em} {\songti\zihao{-4}\dlut@label@originalDate}\dlutunderline[4em]{}~年~\dlutunderline[2em]{}~月~\dlutunderline[2em]{}~日~
    \vskip 20mm
    \begin{center}
        {\heiti\zihao{-2} \dlut@label@authorization}
    \end{center}
    \vskip 10pt
        {\songti\zihao{-4} \dlut@label@authorizationcontent}
    \vskip 25pt
        {\songti\zihao{-4}\dlut@label@originaltitle}\dlutunderline[303pt]{\dlut@value@zh@title}
    \vskip 3pt
    \indent{\songti\zihao{-4}\dlut@label@authorsign} \dlutunderline[10.65em]{} {\songti\zihao{-4}\dlut@label@originalDate}\dlutunderline[3em]{}年~\dlutunderline[2em]{}~月~\dlutunderline[2em]{}~日~
    \vskip 3pt
    \indent{\songti\zihao{-4}\dlut@label@Supervisorsign} \dlutunderline[10.65em]{} {\songti\zihao{-4}\dlut@label@originalDate}\dlutunderline[3em]{}~年~\dlutunderline[2em]{}~月~\dlutunderline[2em]{}~日~
    \vskip 3pt
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage
    \fi
}


%-----------------------------------------------------------------------------------------------------------------------
% abstract and keywords in Chinese
\newenvironment{abstract}
{
    \cleardoublepage
    \chapter{\dlut@label@zh@abstract}
}
{}

\newcommand\beginatevenpage{
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage
    \fi
}

\newcommand\keywords[1]{%
    \vspace{2ex}\indent{\heiti\zihao{-4} \dlut@label@zh@keywords} #1}


%-----------------------------------------------------------------------------------------------------------------------
% abstract and keywords in English
\newenvironment{englishabstract}
{
    \clearpage
    \chapter{\dlut@label@en@abstract}
}
{}

\newcommand\englishkeywords[1]{%
    \vspace{2ex}\indent{\bf\zihao{-4} \dlut@label@en@keywords} #1}


%-----------------------------------------------------------------------------------------------------------------------
% references
\renewenvironment{thebibliography}[1]
{\songti\zihao{5}
    \chapter*{\dlut@label@zh@references}
    \addcontentsline{toc}{chapter}{\dlut@label@zh@references}
    \addcontentsline{toe}{chapter}{\dlut@label@en@references}
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \setlength{\parsep}{1mm}
        \setlength{\labelsep}{0.5em}
        \setlength{\itemsep}{0.05pc}
        \setlength{\listparindent}{0in}
        \setlength{\itemindent}{0in}
        \setlength{\rightmargin}{0in}
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m
}{\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}\endlist}


%-----------------------------------------------------------------------------------------------------------------------
% appendix


%-----------------------------------------------------------------------------------------------------------------------
% achievements
\newenvironment{achievements}
{
    \ifodd
        \c@page
    \else
        \clearpage
        \phantom{s}
        \thispagestyle{empty}
    \fi
    \chapter*{\dlut@label@zh@achievements}
    \addcontentsline{toc}{chapter}{\dlut@label@zh@achievements}
    \addcontentsline{toe}{chapter}{\dlut@label@en@achievements}
}{}


%-----------------------------------------------------------------------------------------------------------------------
% acknowledgements
\newenvironment{acknowledgements}
{
    \ifodd
        \c@page
    \else
        \clearpage
        \phantom{s}
        \thispagestyle{empty}
    \fi
    \chapter*{\dlut@label@zh@acknowledgements}
    \addcontentsline{toc}{chapter}{\dlut@label@zh@acknowledgements}
    \addcontentsline{toe}{chapter}{\dlut@label@en@acknowledgements}
}{}


%-----------------------------------------------------------------------------------------------------------------------
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{2}


\endinput
%%
%% End of file `dlut-thesis.cls'.
