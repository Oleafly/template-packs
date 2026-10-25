% 成都信息工程大学硕士学位论文 LaTeX 模板
% 依据“成都信息工程大学硕士学位论文规范”和“（2025年版）中文硕士学位论文格式范例”整理。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cuitthesis}[2026/05/27 CUIT master thesis class]

\LoadClass[UTF8,zihao=-4,scheme=chinese,openany,fontset=fandol]{ctexbook}

\RequirePackage{geometry}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{tocloft}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{enumitem}
\RequirePackage{ragged2e}
\RequirePackage{lastpage}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}

\geometry{
  a4paper,
  top=2.5cm,
  bottom=2.5cm,
  left=3cm,
  right=3cm,
  headheight=15pt,
  headsep=0.75cm,
  footskip=1.0cm
}

\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Menlo}
\setCJKmainfont[AutoFakeBold=2.5]{Songti SC}
\setCJKsansfont{Heiti SC}
\setCJKmonofont{STFangsong}
\setCJKfamilyfont{zhsong}[AutoFakeBold=2.5]{Songti SC}
\setCJKfamilyfont{zhhei}{Heiti SC}
\setCJKfamilyfont{cuitfangsong}[BoldFont=STFangsong]{STFangsong}
\newcommand{\cuitfangsong}{\CJKfamily{cuitfangsong}}
\newfontfamily{\cuitcoverlatinbold}{Times New Roman Bold}
\newcommand{\cuitcoverinfofont}{\cuitfangsong\cuitcoverlatinbold\fontsize{14bp}{24bp}\selectfont}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  bookmarksnumbered=true,
  bookmarksopen=true
}
\urlstyle{same}

\makeatletter
\renewcommand{\@cite}[2]{\textsuperscript{[#1\if@tempswa, #2\fi]}}
\renewcommand{\thefootnote}{\textcircled{\arabic{footnote}}}
\renewcommand{\footnotesize}{\@setfontsize\footnotesize{9bp}{10.8bp}}
\renewcommand{\@makefntext}[1]{%
  \noindent\makebox[2em][l]{\normalfont\thefootnote}%
  {\songti\fontspec{Times New Roman}\footnotesize #1}%
}
\renewcommand{\maketag@@@}[1]{%
  \hbox{\m@th\normalfont\fontspec{Times New Roman}\fontsize{10.5bp}{20bp}\selectfont#1}%
}
\makeatother

\makeatletter
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 10bp plus 2bp minus 5bp%
  \abovedisplayshortskip \z@ plus 3bp%
  \belowdisplayshortskip 6bp plus 3bp minus 3bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\makeatother
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{3em}
\linespread{1}\selectfont

\ctexset{
  chapter = {
    name = {第,章},
    number = \chinese{chapter},
    format = \centering\songti\bfseries\fontsize{16bp}{20bp}\selectfont,
    nameformat = {},
    titleformat = {},
    aftername = \space,
    beforeskip = 10bp,
    afterskip = 10bp,
    pagestyle = cuitmain
  },
  section = {
    format = \raggedright\songti\bfseries\fontsize{14bp}{20bp}\selectfont,
    aftername = \space,
    beforeskip = 10bp,
    afterskip = 10bp
  },
  subsection = {
    format = \raggedright\songti\bfseries\fontsize{12bp}{20bp}\selectfont,
    aftername = \space,
    beforeskip = 10bp,
    afterskip = 10bp
  },
  subsubsection = {
    format = \raggedright\songti\bfseries\fontsize{12bp}{20bp}\selectfont,
    aftername = \space,
    beforeskip = 10bp,
    afterskip = 10bp
  }
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}
\makeatletter
\@addtoreset{equation}{chapter}
\makeatother

\DeclareCaptionFont{cuitcap}{\songti\fontsize{10.5bp}{20bp}\selectfont}
\captionsetup{
  font=cuitcap,
  labelsep=space,
  justification=centering,
  singlelinecheck=false
}
\captionsetup[figure]{position=bottom,aboveskip=6bp,belowskip=0bp}
\captionsetup[table]{position=top,aboveskip=0bp,belowskip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\newenvironment{cuitsubfigure}[2][b]{%
  \begin{subfigure}[#1]{#2}%
  \centering
  \captionsetup{font=cuitcap,labelformat=simple,labelsep=space,justification=centering,singlelinecheck=false}%
}{%
  \end{subfigure}%
}
\AtBeginEnvironment{equation}{\fontsize{10.5bp}{20bp}\selectfont}
\AtBeginEnvironment{align}{\fontsize{10.5bp}{20bp}\selectfont}
\AtBeginEnvironment{gather}{\fontsize{10.5bp}{20bp}\selectfont}
\AtBeginEnvironment{multline}{\fontsize{10.5bp}{20bp}\selectfont}

\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcommand{\cuitcaptionnote}[1]{%
  \par\vspace{2bp}{\centering\songti\fontsize{10.5bp}{20bp}\selectfont #1\par}
}
\newcommand{\cuitcontinuedtable}[2][\thetable]{%
  \multicolumn{#2}{r}{\songti\fontsize{10.5bp}{20bp}\selectfont 续表\ #1}%
}

\newcommand{\cuitheadertext}{\songti\fontsize{9bp}{12bp}\selectfont 成都信息工程大学硕士学位论文}

\pagestyle{fancy}
\fancypagestyle{cuitfront}{%
  \fancyhf{}%
  \fancyhead[C]{\cuitheadertext}%
  \fancyfoot[C]{\songti\fontsize{9bp}{12bp}\selectfont\thepage}%
  \renewcommand{\headrulewidth}{0.4pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{cuitmain}{%
  \fancyhf{}%
  \fancyhead[C]{\cuitheadertext}%
  \fancyfoot[C]{\songti\fontsize{9bp}{12bp}\selectfont 第 \thepage 页\quad 共 \pageref{LastPage} 页}%
  \renewcommand{\headrulewidth}{0.4pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{cuitplain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\renewcommand{\contentsname}{目\ 录}
\renewcommand{\cfttoctitlefont}{\hfill\songti\bfseries\fontsize{16bp}{20bp}\selectfont}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftbeforetoctitleskip}{10bp}
\renewcommand{\cftaftertoctitleskip}{10bp}
\renewcommand{\cftchapfont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftchappagefont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftsecfont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftsecpagefont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftsubsecfont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftsubsecpagefont}{\songti\fontsize{12bp}{20bp}\selectfont}
\renewcommand{\cftdotsep}{0.8}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftchapindent}{0em}
\setlength{\cftsecindent}{1em}
\setlength{\cftsubsecindent}{2em}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\makeatletter
\newcommand{\cuittableofcontents}{%
  \clearpage
  \pagestyle{cuitfront}
  \begin{center}
    \vspace*{10bp}%
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 目\ 录\par}
    \vspace{10bp}%
  \end{center}
  \noindent\hfill{\songti\fontsize{12bp}{20bp}\selectfont 论文总页数：\pageref{LastPage}页}\par
  \vspace{10bp}
  \@starttoc{toc}%
  \clearpage
}
\makeatother

\newcommand{\classification}{}
\newcommand{\udc}{}
\newcommand{\security}{公开}
\newcommand{\studentnumber}{}
\newcommand{\ctitle}{}
\newcommand{\etitle}{}
\newcommand{\coverctitle}{}
\newcommand{\coveretitle}{}
\newcommand{\cauthor}{}
\newcommand{\college}{}
\newcommand{\degreetype}{学术型}
\newcommand{\studytype}{全日制}
\newcommand{\discipline}{}
\newcommand{\researchfield}{}
\newcommand{\supervisor}{}
\newcommand{\cosupervisor}{}
\newcommand{\finishdate}{}

\newcommand{\cuitclassification}[1]{\renewcommand{\classification}{#1}}
\newcommand{\cuitudc}[1]{\renewcommand{\udc}{#1}}
\newcommand{\cuitsecurity}[1]{\renewcommand{\security}{#1}}
\newcommand{\cuitstudentnumber}[1]{\renewcommand{\studentnumber}{#1}}
\newcommand{\cuitctitle}[1]{\renewcommand{\ctitle}{#1}}
\newcommand{\cuitetitle}[1]{\renewcommand{\etitle}{#1}}
\newcommand{\cuitcoverctitle}[1]{\renewcommand{\coverctitle}{#1}}
\newcommand{\cuitcoveretitle}[1]{\renewcommand{\coveretitle}{#1}}
\newcommand{\cuitauthor}[1]{\renewcommand{\cauthor}{#1}}
\newcommand{\cuitcollege}[1]{\renewcommand{\college}{#1}}
\newcommand{\cuitdegreetype}[1]{\renewcommand{\degreetype}{#1}}
\newcommand{\cuitstudytype}[1]{\renewcommand{\studytype}{#1}}
\newcommand{\cuitdiscipline}[1]{\renewcommand{\discipline}{#1}}
\newcommand{\cuitresearchfield}[1]{\renewcommand{\researchfield}{#1}}
\newcommand{\cuitsupervisor}[1]{\renewcommand{\supervisor}{#1}}
\newcommand{\cuitcosupervisor}[1]{\renewcommand{\cosupervisor}{#1}}
\newcommand{\cuitfinishdate}[1]{\renewcommand{\finishdate}{#1}}

\newcommand{\cuitfield}[2]{%
  \makebox[4.5em][s]{#1}\quad
  \underline{\makebox[20em][c]{#2}}%
}
\newsavebox{\cuitcoverfitbox}
\newcommand{\cuitcoverfit}[2]{%
  \sbox{\cuitcoverfitbox}{#2}%
  \ifdim\wd\cuitcoverfitbox>#1
    \resizebox{#1}{!}{\usebox{\cuitcoverfitbox}}%
  \else
    \usebox{\cuitcoverfitbox}%
  \fi
}
\newcommand{\cuitcoverline}[2]{\underline{\makebox[#1][c]{\cuitcoverfit{#1}{#2}}}}
\newcommand{\cuitcoverplainline}[2]{\makebox[#1][c]{\cuitcoverfit{#1}{#2}}}
\newcommand{\cuitcovermetavalue}[2]{\makebox[#1][l]{#2}}
\newcommand{\cuitcoverrightplainlabel}[1]{\makebox[4.2em][r]{#1}：}
\newcommand{\cuitcoverlabel}[1]{\makebox[6em][s]{#1}}
\newcommand{\cuitchecked}{\ensuremath{\mbox{\rlap{\hspace{0.18em}\raisebox{0.08em}{\scriptsize\checkmark}}\(\square\)}}}
\newcommand{\cuitunchecked}{\ensuremath{\square}}
\newcommand{\cuitdegreeboxes}{%
  \ifdefstring{\degreetype}{学术型}{\cuitchecked}{\cuitunchecked}学术型\quad
  \ifdefstring{\degreetype}{专业学位}{\cuitchecked}{\cuitunchecked}专业学位%
}
\newcommand{\cuitstudyboxes}{%
  \ifdefstring{\studytype}{全日制}{\cuitchecked}{\cuitunchecked}全日制\quad
  \ifdefstring{\studytype}{非全日制}{\cuitchecked}{\cuitunchecked}非全日制%
}

\newcommand{\makecuitcover}{%
  \clearpage
  \thispagestyle{cuitplain}
  \begingroup
  \songti
  \noindent{\songti\bfseries\fontsize{12bp}{20bp}\selectfont
  分类号：\cuitcovermetavalue{12em}{\classification}%
  \hspace{6em}%
  \cuitcoverrightplainlabel{UDC}\cuitcovermetavalue{7em}{\udc}}\par
  \vspace{0.5em}
  \noindent{\songti\bfseries\fontsize{12bp}{20bp}\selectfont
  密\quad 级：\cuitcovermetavalue{12em}{\security}%
  \hspace{6em}%
  \cuitcoverrightplainlabel{编\quad 号}\cuitcovermetavalue{7em}{\studentnumber}}\par
  \vspace{1.0cm}
  \begin{center}
    \IfFileExists{figures/cuit-logo-title.png}{%
      \includegraphics[width=14.8cm]{figures/cuit-logo-title.png}\par
    }{%
      {\songti\bfseries\fontsize{22bp}{28bp}\selectfont 成都信息工程大学}\par
      {\fontspec{Times New Roman}\bfseries\fontsize{18bp}{24bp}\selectfont Chengdu University of Information Technology}\par
    }
  \end{center}
  \vspace{1.2cm}
  \begin{center}
    {\heiti\bfseries\fontsize{22bp}{28bp}\selectfont 硕\quad 士\quad 学\quad 位\quad 论\quad 文}\par
    \vspace{1.1cm}
    {\songti\bfseries\fontsize{16bp}{24bp}\selectfont \coverctitle\par}
    \vspace{0.3cm}
    {{\fontspec{Times New Roman}\bfseries\fontsize{16bp}{24bp}\selectfont \coveretitle}\par}
    \vspace{1.5cm}
    {\cuitcoverinfofont
    \begin{tabular}{@{}l@{\quad}l@{}}
      \cuitcoverlabel{姓名} & \cuitcoverline{13em}{\cauthor}\\[0.45em]
      \cuitcoverlabel{学号} & \cuitcoverline{13em}{\studentnumber}\\[0.45em]
      \cuitcoverlabel{学院} & \cuitcoverline{13em}{\college}\\[0.45em]
      \cuitcoverlabel{学位类型} & \cuitcoverline{13em}{\cuitdegreeboxes}\\[0.45em]
      \cuitcoverlabel{学习形式} & \cuitcoverline{13em}{\cuitstudyboxes}\\[0.45em]
      \cuitcoverlabel{学科/领域} & \cuitcoverline{13em}{\discipline}\\[0.45em]
      \cuitcoverlabel{研究方向} & \cuitcoverline{13em}{\researchfield}\\[0.45em]
      \cuitcoverlabel{第一导师} & \cuitcoverline{13em}{\supervisor}\\[0.45em]
      \cuitcoverlabel{其他导师} & \cuitcoverline{13em}{\cosupervisor}\\[0.45em]
      \cuitcoverlabel{论文完成时间} & \cuitcoverline{13em}{\finishdate}
    \end{tabular}}\par
  \end{center}
  \endgroup
  \clearpage
}

\newcommand{\cuitstatementtitle}[1]{%
  \begin{center}
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 成都信息工程大学\par}
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont #1\par}
  \end{center}
  \vspace{0.5em}
}

\newcommand{\makecuitstatements}{%
  \clearpage
  \pagestyle{cuitfront}
  \cuitstatementtitle{硕士学位论文原创性声明}
  本人郑重声明：所呈交的学位论文《\underline{\makebox[12em][c]{}}》，是本人在指导教师\underline{\makebox[5em][c]{}}指导下，进行研究工作所取得的成果。除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人创作的、已公开发表或者没有公开发表的作品的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。本学位论文原创性声明的法律责任由本人承担。\par
  \vspace{1.5em}
  \noindent 论文作者签名：\hfill 年\quad 月\quad 日\par
  \vspace{1.0em}
  \noindent 指导教师签名：\hfill 年\quad 月\quad 日\par
  \vspace{2em}
  \cuitstatementtitle{硕士学位论文版权使用授权书}
  本人完全了解成都信息工程大学关于收集、保留、使用学位论文的规定，同意学校保留并向国家有关部门或者机构送交论文的原件、复印件和电子版，允许论文被查阅和借阅。本人授权成都信息工程大学将本学位论文的全部或部分内容编入有关数据库进行检索、下载及信息技术服务，可以采用影印、扫描等复制手段保存、汇编学位论文。（保密学位论文在解密后遵守此规定）\par
  除非另有科研合同和其他法律文书的制约，本论文的科研成果属于成都信息工程大学。\par
  \vspace{1.5em}
  \noindent 论文作者签名：\hfill 年\quad 月\quad 日\par
  \vspace{1.0em}
  \noindent 指导教师签名：\hfill 年\quad 月\quad 日\par
  \vspace{1.0em}
  \noindent 本学位论文密级属于\underline{\makebox[4em][c]{}}\ 级，保密期限为\underline{\makebox[4em][c]{}}\ 年，解密后适用本授权书。\par
  \vspace{0.6em}
  {\songti\fontsize{10.5bp}{16bp}\selectfont
  \setlength{\tabcolsep}{2pt}%
  \renewcommand{\arraystretch}{1.45}%
  \noindent\begin{tabular}{|>{\centering\arraybackslash}m{0.156\textwidth}|>{\centering\arraybackslash}m{0.156\textwidth}|>{\centering\arraybackslash}m{0.156\textwidth}|>{\centering\arraybackslash}m{0.156\textwidth}|>{\centering\arraybackslash}m{0.156\textwidth}|>{\centering\arraybackslash}m{0.156\textwidth}|}
    \hline
    密\quad 级 & & 解密时间 & \multicolumn{3}{c|}{年\quad 月\quad 日}\\
    \hline
    \rule{0pt}{3.6em}\shortstack{学位论文作\\者签名} & 年\quad 月\quad 日 & \shortstack{指导教师签\\名} & 年\quad 月\quad 日 & \shortstack{学校保密办\\公室审核情\\况} & \shortstack{年\quad 月\quad 日\\（公章）}\\
    \hline
  \end{tabular}\par}
  \vspace{0.6em}
  {\cuitfangsong 注：答辩通过后，定稿提交的论文中，均须附由作者本人签名的原创声明及使用授权书。}\par
  \clearpage
}

\newenvironment{cuitabstract}[1]{%
  \clearpage
  \pagestyle{cuitfront}
  \begin{center}
    \vspace*{10bp}%
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont #1\par}
    \vspace{10bp}%
  \end{center}
  \songti\fontsize{12bp}{20bp}\selectfont
}{}

\newenvironment{cuitabstractcn}{%
  \clearpage
  \pagestyle{cuitfront}
  \begin{center}
    \vspace*{10bp}%
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 摘\ 要\par}
    \vspace{10bp}%
  \end{center}
  \songti\fontsize{12bp}{20bp}\selectfont
}{}

\newenvironment{cuitabstracten}{%
  \clearpage
  \pagestyle{cuitfront}
  \begin{center}
    \vspace*{10bp}%
    {{\fontspec{Times New Roman}\bfseries\fontsize{14bp}{20bp}\selectfont ABSTRACT}\par}
    \vspace{10bp}%
  \end{center}
  \fontspec{Times New Roman}\fontsize{12bp}{20bp}\selectfont
}{}

\newcommand{\cuitkeywords}[1]{%
  \par\vspace{10bp}\noindent{\songti\bfseries\fontsize{12bp}{20bp}\selectfont 关键词：}%
  {\songti\fontsize{12bp}{20bp}\selectfont #1}\par
}
\newcommand{\cuitenglishkeywords}[1]{%
  \par\vspace{10bp}\noindent{{\fontspec{Times New Roman}\bfseries\fontsize{12bp}{20bp}\selectfont Key words: }}%
  {{\fontspec{Times New Roman}\fontsize{12bp}{20bp}\selectfont #1}}\par
}

\newcommand{\cuitfrontmatter}{%
  \clearpage
  \pagenumbering{roman}
  \pagestyle{cuitfront}
}
\newcommand{\cuitmainmatter}{%
  \clearpage
  \pagenumbering{arabic}
  \pagestyle{cuitmain}
}

\newcounter{cuitappendix}
\newcommand{\cuitappendix}[1]{%
  \clearpage
  \refstepcounter{cuitappendix}%
  \phantomsection
  \addcontentsline{toc}{chapter}{附录\quad #1}%
  \begin{center}
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 附录\quad #1\par}
  \end{center}
  \vspace{10bp}%
  \songti\fontsize{12bp}{20bp}\selectfont
  \setlength{\parindent}{2em}%
  \setlength{\parskip}{0pt}%
  \justifying
}

\renewenvironment{thebibliography}[1]
  {\clearpage
   \phantomsection
   \addcontentsline{toc}{chapter}{参考文献}%
   \begin{center}
     {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 参考文献\par}
   \end{center}
   \vspace{10bp}%
   \list{[\arabic{enumi}]}{%
     \settowidth\labelwidth{[#1]}%
     \leftmargin=2em%
     \labelsep=0.5em%
     \itemindent=0pt%
     \itemsep=0pt%
     \parsep=0pt%
     \usecounter{enumi}}%
   \songti\fontspec{Times New Roman}\fontsize{12bp}{20bp}\selectfont}
  {\endlist}

\newcommand{\cuitachievement}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{作者简历及攻读学位期间发表的学术论文与研究成果}
  \begin{center}
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 作者简历及攻读学位期间发表的学术论文与研究成果\par}
  \end{center}
  \vspace{10bp}
  \songti\fontsize{12bp}{20bp}\selectfont
}
\newcommand{\cuitacknowledgement}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{致 谢}
  \begin{center}
    {\songti\bfseries\fontsize{16bp}{20bp}\selectfont 致\ 谢\par}
  \end{center}
  \vspace{10bp}
  \songti\fontsize{12bp}{20bp}\selectfont
}

\AtBeginDocument{\pagestyle{cuitmain}}
