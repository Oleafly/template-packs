\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custhesis}[2026/05/18 Changchun University of Science and Technology undergraduate thesis template]

\LoadClass[UTF8,zihao=-4,oneside,openany,fontset=none]{ctexbook}

\RequirePackage{iftex}
\ifXeTeX\else
  \ClassError{custhesis}{Please compile this template with XeLaTeX}{Use: xelatex main.tex}
\fi

\RequirePackage{geometry}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{caption}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{enumitem}
\RequirePackage{tocloft}
\RequirePackage[numbers,sort&compress,square]{natbib}
\RequirePackage[hidelinks]{hyperref}

\makeatletter

\defaultfontfeatures{Ligatures=TeX}
\IfFileExists{fonts/sim/TIMES.TTF}
  {}
  {\ClassError{custhesis}{Missing Times New Roman fonts in fonts/sim}{Please add TIMES.TTF, TIMESBD.TTF, TIMESI.TTF and TIMESBI.TTF to fonts/sim}}
\setmainfont[
  Path=fonts/sim/,
  Extension=.TTF,
  UprightFont=TIMES,
  BoldFont=TIMESBD,
  ItalicFont=TIMESI,
  BoldItalicFont=TIMESBI
]{TIMES}
\setsansfont[
  Path=fonts/sim/,
  Extension=.TTF,
  UprightFont=TIMES,
  BoldFont=TIMESBD,
  ItalicFont=TIMESI,
  BoldItalicFont=TIMESBI
]{TIMES}

\xeCJKsetup{CJKmath=true,AutoFakeBold=true}
\IfFileExists{fonts/sim/SIMKAI.TTF}
  {}
  {\ClassError{custhesis}{Missing Chinese fonts in fonts/sim}{Please add simsun.ttc, simhei.ttf, FangSong_GB2312.ttf and SIMKAI.TTF to fonts/sim}}
\setCJKmainfont[
  Path=fonts/sim/,
  UprightFont=simsun.ttc,
  BoldFont=simsun.ttc,
  BoldFeatures={FakeBold=2},
  AutoFakeSlant=true
]{simsun}
\setCJKsansfont[
  Path=fonts/sim/,
  UprightFont=simhei.ttf,
  BoldFont=simhei.ttf,
  AutoFakeBold=true,
  AutoFakeSlant=true
]{simhei}
\setCJKfamilyfont{zhsong}[
  Path=fonts/sim/,
  UprightFont=simsun.ttc,
  BoldFont=simsun.ttc,
  BoldFeatures={FakeBold=2},
  AutoFakeSlant=true
]{simsun}
\setCJKfamilyfont{zhhei}[
  Path=fonts/sim/,
  UprightFont=simhei.ttf,
  BoldFont=simhei.ttf,
  AutoFakeBold=true,
  AutoFakeSlant=true
]{simhei}
\setCJKfamilyfont{zhfs}[
  Path=fonts/sim/,
  UprightFont=FangSong_GB2312.ttf,
  BoldFont=FangSong_GB2312.ttf,
  AutoFakeBold=true,
  AutoFakeSlant=true
]{fangsonggb}
\setCJKfamilyfont{zhkai}[
  Path=fonts/sim/,
  UprightFont=SIMKAI.TTF,
  BoldFont=SIMKAI.TTF,
  AutoFakeBold=true,
  AutoFakeSlant=true
]{simkai}
\providecommand{\songti}{\CJKfamily{zhsong}}
\providecommand{\heiti}{\CJKfamily{zhhei}}
\providecommand{\fangsong}{\CJKfamily{zhfs}}
\providecommand{\kaishu}{\CJKfamily{zhkai}}
\newcommand{\custfangsong}{\fangsong}

\geometry{
  a4paper,
  top=2.54cm,
  bottom=2.54cm,
  left=3.17cm,
  right=3.17cm,
  headheight=14pt,
  headsep=0.45cm,
  footskip=0.85cm
}

\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\setstretch{1.25}
\setlist[enumerate,1]{
  label=（\arabic*）,
  leftmargin=0pt,
  labelwidth=0pt,
  labelsep=0pt,
  itemindent=2em,
  listparindent=2em,
  align=left,
  itemsep=0pt,
  parsep=0pt,
  topsep=0pt
}
\setlist[itemize,1]{
  leftmargin=2em,
  labelsep=0.5em,
  itemsep=0pt,
  parsep=0pt,
  topsep=0pt
}
\newlist{custenum}{enumerate}{1}
\setlist[custenum,1]{
  label=（\arabic*）,
  leftmargin=0pt,
  labelwidth=0pt,
  labelsep=0pt,
  itemindent=2em,
  listparindent=2em,
  align=left,
  itemsep=0pt,
  parsep=0pt,
  topsep=0pt
}

\newcommand{\cust@serial}{}
\newcommand{\cust@doctype}{本科生毕业设计}
\newcommand{\cust@headertitle}{长春理工大学本科生毕业设计}
\newcommand{\cust@title}{中文毕业设计题目}
\newcommand{\cust@englishtitle}{Design and Implementation of Distributed KV Database}
\newcommand{\cust@student}{}
\newcommand{\cust@major}{}
\newcommand{\cust@studentid}{}
\newcommand{\cust@supervisor}{}
\newcommand{\cust@school}{计算机科学技术学院}
\newcommand{\cust@date}{二〇二六年五月}

\newcommand{\custserial}[1]{\gdef\cust@serial{#1}}
\newcommand{\custdoctype}[1]{\gdef\cust@doctype{#1}}
\newcommand{\custheadertitle}[1]{\gdef\cust@headertitle{#1}}
\newcommand{\custtitle}[1]{\gdef\cust@title{#1}}
\newcommand{\custenglishtitle}[1]{\gdef\cust@englishtitle{#1}}
\newcommand{\custstudent}[1]{\gdef\cust@student{#1}}
\newcommand{\custmajor}[1]{\gdef\cust@major{#1}}
\newcommand{\custstudentid}[1]{\gdef\cust@studentid{#1}}
\newcommand{\custsupervisor}[1]{\gdef\cust@supervisor{#1}}
\newcommand{\custschool}[1]{\gdef\cust@school{#1}}
\newcommand{\custdate}[1]{\gdef\cust@date{#1}}

\fancypagestyle{custheadings}{
  \fancyhf{}
  \fancyhead[C]{\songti\zihao{5}\cust@headertitle}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[C]{\songti\zihao{5}\cust@headertitle}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{custheadings}

\ctexset{
  chapter = {
    name = {第,章},
    number = \arabic{chapter},
    aftername = \hspace{0.25em},
    format = \centering\songti\bfseries\zihao{3},
    beforeskip = 0pt,
    afterskip = 1\baselineskip,
    fixskip = true,
    pagestyle = custheadings
  },
  section = {
    format = \songti\bfseries\zihao{4},
    indent = 2em,
    aftername = \hspace{0.25em},
    beforeskip = 0.5\baselineskip,
    afterskip = 0pt
  },
  subsection = {
    format = \songti\bfseries\zihao{-4},
    indent = 2em,
    aftername = \hspace{0.25em},
    beforeskip = 0.5\baselineskip,
    afterskip = 0pt
  }
}

\renewcommand{\contentsname}{目录}
\renewcommand{\cfttoctitlefont}{\hfill\songti\bfseries\zihao{3}}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{1\baselineskip}
\renewcommand{\cftchapfont}{\songti\zihao{-4}}
\renewcommand{\cftsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}
\renewcommand{\cftchappagefont}{\songti\zihao{-4}}
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{2.35em}
\setlength{\cftsubsecindent}{4.7em}
\setlength{\cftchapnumwidth}{2.8em}
\setlength{\cftsecnumwidth}{1.75em}
\setlength{\cftsubsecnumwidth}{2.65em}
\setlength{\cftbeforechapskip}{0pt}

\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\numberwithin{equation}{chapter}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter-\arabic{equation}}

\DeclareCaptionFont{custcaption}{\songti\zihao{5}}
\captionsetup{
  font=custcaption,
  labelsep=quad,
  skip=6pt
}
\captionsetup[figure]{position=bottom}
\captionsetup[table]{position=top}

\def\tagform@#1{\maketag@@@{（#1）}}

\newcommand{\custcite}[1]{\textsuperscript{\cite{#1}}}
\newcommand{\custeqref}[1]{式（\ref{#1}）}

\newcommand{\cust@coverlabel}[1]{\makebox[2.65cm][s]{#1}}
\newcommand{\cust@coverrow}[2]{%
  {\heiti\zihao{-3}#1} & {\heiti\zihao{-3}\underline{\makebox[6.65cm][c]{#2}}}\\[0.95em]
}

\newcommand{\makecustcover}{%
  \begin{titlepage}
    \thispagestyle{empty}
    \noindent{\songti\zihao{-4}编号\underline{\makebox[3.0cm][c]{\cust@serial}}}
    \vspace{0.9cm}
    \begin{center}
      \IfFileExists{figures/cust-logo.png}{%
        \includegraphics[width=10.4cm]{figures/cust-logo.png}\par
      }{\vspace*{1.3cm}}
      \vspace{1.4cm}
      {\heiti\zihao{1}\cust@doctype\par}
      \vspace{1.45cm}
      {\heiti\zihao{2}\cust@title\par}
      \vspace{0.65cm}
      {\rmfamily\zihao{3}\cust@englishtitle\par}
      \vfill
      \begingroup
      \setlength{\tabcolsep}{0pt}
      \begin{tabular}{>{\centering\arraybackslash}p{3.30cm}@{}>{\centering\arraybackslash}p{6.65cm}}
        \cust@coverrow{\cust@coverlabel{学\hfil 生\hfil 姓\hfil 名}}{\cust@student}
        \cust@coverrow{\cust@coverlabel{专\hfil 业}}{\cust@major}
        \cust@coverrow{\cust@coverlabel{学\hfil 号}}{\cust@studentid}
        \cust@coverrow{\cust@coverlabel{指\hfil 导\hfil 教\hfil 师}}{\cust@supervisor}
        \cust@coverrow{\cust@coverlabel{学\hfil 院}}{\cust@school}
      \end{tabular}
      \endgroup
      \vfill
      {\songti\zihao{-2}\cust@date\par}
    \end{center}
  \end{titlepage}
}
\renewcommand{\maketitle}{\makecustcover}

\newcommand{\makecustdeclaration}{%
  \clearpage
  \pagestyle{empty}
  \thispagestyle{empty}
  \begingroup
    \custfangsong\zihao{-3}\setstretch{2}
    \begin{center}
      {\songti\zihao{3}\bfseries 毕业设计（论文）原创承诺书\par}
    \end{center}
    \vspace{1.2cm}
    \setlength{\parindent}{0pt}
    \noindent\hspace*{2em}1．本人承诺：所呈交的毕业设计（论文）《\cust@title》，是认真学习理解学校的《长春理工大学本科毕业设计（论文）工作条例》后，在教师的指导下，保质保量独立地完成了任务书中规定的内容，不弄虚作假，不抄袭别人的工作内容。

    \noindent\hspace*{2em}2．本人在毕业设计（论文）中引用他人的观点和研究成果，均在文中加以注释或以参考文献形式列出，对本文的研究工作做出重要贡献的个人和集体均已在文中注明。

    \noindent\hspace*{2em}3．在毕业设计（论文）中对侵犯任何方面知识产权的行为，由本人承担相应的法律责任。

    \noindent\hspace*{2em}4．本人完全了解学校关于保存、使用毕业设计（论文）的规定，即：按照学校要求提交论文和相关材料的印刷本和电子版本；同意学校保留毕业设计（论文）的复印件和电子版本，允许被查阅和借阅；学校可以采用影印、缩印或其他复制手段保存毕业设计（论文），可以公布其中的全部或部分内容。\par\vspace{\baselineskip}
    \noindent\hspace*{2em}以上承诺的法律结果将完全由本人承担！

    \vspace{1.2cm}
    \begin{flushright}
      \makebox[3.0cm][s]{作\hfil 者\hfil 签\hfil 名}：\hspace{3.2cm}年\hspace{1.0cm}月\hspace{1.0cm}日\hspace{1.5cm}
    \end{flushright}
  \endgroup
  \clearpage
  \pagestyle{custheadings}
}

\newcommand{\custfrontmatter}{%
  \cleardoublepage
  \pagenumbering{Roman}
  \setcounter{page}{1}
  \pagestyle{custheadings}
}

\newcommand{\custmainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \pagestyle{custheadings}
}

\newenvironment{custcnabstract}{%
  \cleardoublepage
  \chapter*{摘要}
  \phantomsection
  \addcontentsline{toc}{chapter}{摘要}
  \songti\zihao{-4}
  \setstretch{1.25}
  \setlength{\parindent}{2em}
}{%
  \cleardoublepage
}

\newcommand{\custkeywords}[1]{%
  \par\vspace{\baselineskip}
  \noindent{\heiti 关键词：#1}\par
}

\newenvironment{custenabstract}{%
  \cleardoublepage
  \chapter*{Abstract}
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \rmfamily\zihao{-4}
  \setstretch{1.25}
  \setlength{\parindent}{2em}
}{%
  \cleardoublepage
}

\newcommand{\custkeywordsen}[1]{%
  \par\vspace{\baselineskip}
  \noindent Key words: #1\par
}

\newcommand{\custtableofcontents}{%
  \cleardoublepage
  \tableofcontents
  \cleardoublepage
}

\newcommand{\custbackmattertitle}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}
  \begin{center}
    {\songti\bfseries\zihao{3}#1\par}
  \end{center}
  \vspace{0.5\baselineskip}
}

\renewcommand{\bibname}{参考文献}
\renewcommand{\refname}{参考文献}
\renewcommand{\bibsection}{%
  \custbackmattertitle{参考文献}%
}
\renewcommand{\bibfont}{\songti\zihao{-4}}
\setlength{\bibsep}{0pt}
\newcommand{\cust@bibstyle}{gbt7714-numerical}
\newcommand{\custbibstyle}[1]{\gdef\cust@bibstyle{#1}}
\newcommand{\custbibliography}[1]{%
  \bibliographystyle{\cust@bibstyle}%
  \bibliography{#1}%
  \clearpage
}

\newcounter{custappendix}
\newcommand{\custappendixstart}{%
  \clearpage
  \appendix
  \setcounter{chapter}{0}
  \setcounter{custappendix}{0}
}
\newcommand{\custappendixchapter}[1]{%
  \clearpage
  \refstepcounter{chapter}
  \stepcounter{custappendix}
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \custbackmattertitle{附录\arabic{custappendix} #1}
}

\newenvironment{custacknowledgements}{%
  \clearpage
  \custbackmattertitle{致谢}
  \setlength{\parindent}{2em}
}{%
  \par
}

\makeatother
