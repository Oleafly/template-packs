%% izdthesis.cls
%% 天津中德应用技术大学 软件工程专业 本科毕业设计（论文）LaTeX 模板
%% 依据《软件工程专业毕业设计指导文件 V2.0》（2025-12-19）编写
%% 编译方式：xelatex（推荐 latexmk）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{izdthesis}[2026/07/24 v1.0 IZD SE Undergraduate Thesis Template]

% ======================================================================
% 基类：ctexbook，小四正文
% 中文字体模式（指导文件要求：中文宋体/黑体，西文 Times New Roman）：
%   默认        —— 使用项目 fonts/ 目录内置的思源宋体/思源黑体
%                 （Source Han Serif/Sans SC，SIL OFL 开源，可自由分发）
%   fandol     —— 使用 TeX Live 自带的 Fandol 字体（不依赖 fonts/ 目录）
%   winfonts   —— 使用 Windows 中易字体（SimSun/SimHei，需系统已安装）
%   macfonts   —— 使用 macOS 系统字体（Songti SC/Heiti SC 等）
% 用法：\documentclass[fandol]{izdthesis} 等
% ======================================================================
\def\izd@fontmode{sourcehan}
\DeclareOption{fandol}{\def\izd@fontmode{fandol}}
\DeclareOption{winfonts}{\def\izd@fontmode{windows}}
\DeclareOption{macfonts}{\def\izd@fontmode{mac}}
\ProcessOptions\relax
\RequirePackage{etoolbox}
\ifdefstring{\izd@fontmode}{sourcehan}
  {\PassOptionsToClass{fontset=none}{ctexbook}}
  {\edef\izd@fontsetopt{fontset=\izd@fontmode}%
   \expandafter\PassOptionsToClass\expandafter{\izd@fontsetopt}{ctexbook}}
\LoadClass[zihao=-4,oneside]{ctexbook}

% ======================================================================
% 宏包
% ======================================================================
\RequirePackage{geometry}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{titletoc}
\RequirePackage[super,sort&compress]{gbt7714} % GB/T 7714-2015 顺序编码制，正文上标引用
\RequirePackage{hyperref}

% ======================================================================
% 西文字体：Times New Roman（规范要求）；找不到时退回 TeX Gyre Termes
% ======================================================================
\IfFontExistsTF{Times New Roman}
  {\setmainfont{Times New Roman}}
  {\setmainfont{TeX Gyre Termes}}

% ======================================================================
% 中文字体（默认模式）：
%   优先使用 fonts/ 目录下的中易字体（Simsun.ttc + simsunb.ttf + SimHei.ttf，
%   即 Word 模板所指的"宋体/黑体"原体，可由用户从本机 Office 字体目录复制）；
%   若未提供，则使用 fonts/ 目录内置的思源宋体/思源黑体（开源）。
% \songti → 宋体（加粗用其 Bold），\heiti → 黑体
% ======================================================================
\ifdefstring{\izd@fontmode}{sourcehan}{%
  \IfFileExists{fonts/Simsun.ttc}{%
    % ---- 中易字体（SimSun/SimHei）；SimSun 无 Bold 字重，与 Word 一样用伪粗 ----
    \setCJKmainfont[Path=fonts/,BoldFont=Simsun.ttc,BoldFeatures={FakeBold=2.2}]{Simsun.ttc}%
    \setCJKsansfont[Path=fonts/,BoldFont=SimHei.ttf,BoldFeatures={FakeBold=2.2}]{SimHei.ttf}%
    \setCJKmonofont[Path=fonts/]{SimHei.ttf}%
    \setCJKfamilyfont{zhsong}[Path=fonts/,BoldFont=Simsun.ttc,BoldFeatures={FakeBold=2.2}]{Simsun.ttc}%
    \setCJKfamilyfont{zhhei}[Path=fonts/,BoldFont=SimHei.ttf,BoldFeatures={FakeBold=2.2}]{SimHei.ttf}%
    \setCJKfamilyfont{zhkai}[Path=fonts/]{Simsun.ttc}% 模板未使用楷体，映射到宋体兜底
    \setCJKfamilyfont{zhfs}[Path=fonts/]{Simsun.ttc}%  模板未使用仿宋，映射到宋体兜底
  }{%
    % ---- 思源宋体/思源黑体（开源兜底）----
    \setCJKmainfont[Path=fonts/,BoldFont=SourceHanSerifSC-Bold.otf]{SourceHanSerifSC-Regular.otf}%
    \setCJKsansfont[Path=fonts/,BoldFont=SourceHanSansSC-Bold.otf]{SourceHanSansSC-Regular.otf}%
    \setCJKmonofont[Path=fonts/]{SourceHanSansSC-Regular.otf}%
    \setCJKfamilyfont{zhsong}[Path=fonts/,BoldFont=SourceHanSerifSC-Bold.otf]{SourceHanSerifSC-Regular.otf}%
    \setCJKfamilyfont{zhhei}[Path=fonts/,BoldFont=SourceHanSansSC-Bold.otf]{SourceHanSansSC-Regular.otf}%
    \setCJKfamilyfont{zhkai}[Path=fonts/]{SourceHanSerifSC-Regular.otf}% 模板未使用楷体，映射到宋体兜底
    \setCJKfamilyfont{zhfs}[Path=fonts/]{SourceHanSerifSC-Regular.otf}%  模板未使用仿宋，映射到宋体兜底
  }%
  % fontset=none 时 ctex 不定义 \songti 等命令，这里按 ctex 惯例补上
  \protected\def\songti{\CJKfamily{zhsong}}%
  \protected\def\heiti{\CJKfamily{zhhei}}%
  \protected\def\kaishu{\CJKfamily{zhkai}}%
  \protected\def\fangsong{\CJKfamily{zhfs}}%
}{}

% ======================================================================
% 页面设置
%   封面：    上3.0 下2.5 左3.0 右3.0（cm）
%   其余页面：上2.8 下2.4 左2.5 右2.2（cm）
% ======================================================================
\geometry{top=2.8cm,bottom=2.4cm,left=2.5cm,right=2.2cm,
          headheight=15pt,headsep=0.55cm,footskip=1.1cm}

% ======================================================================
% 全文段落：段前段后 0 行，1.25 倍行距，段首缩进 2 字符
% ======================================================================
\linespread{1.25}
\setlength{\parskip}{0pt}
\setlength{\parindent}{2\ccwd}

% ======================================================================
% 标题格式（\ctexset）
%   一级标题：第X章 + 4个半角空格 + 标题；小三、黑体、顶格居中；
%             段前段后 0.5 行；每章另起一页（book 默认）
%   二/三级标题：1.1 / 1.1.1 + 1 个半角空格；四号、黑体、顶格
% ======================================================================
\ctexset{
  chapter = {
    name        = {第,章},
    format      = \zihao{-3}\heiti\centering,
    aftername   = \hspace{2em},
    beforeskip  = 0.5\baselineskip,
    afterskip   = 0.5\baselineskip,
    pagestyle   = izdmain,
  },
  section = {
    format      = \zihao{4}\heiti,
    aftername   = \hspace{0.5em},
    beforeskip  = 0.5\baselineskip,
    afterskip   = 0.5\baselineskip,
  },
  subsection = {
    format      = \zihao{4}\heiti,
    aftername   = \hspace{0.5em},
    beforeskip  = 0.5\baselineskip,
    afterskip   = 0.5\baselineskip,
  },
}

% ======================================================================
% 页眉页脚：从正文开始；页眉五号居中，页脚页码居中
% ======================================================================
\newcommand{\izd@gradyear}{}
\newcommand{\gradyear}[1]{\gdef\izd@gradyear{#1}}

\fancypagestyle{izdmain}{%
  \fancyhf{}%
  \fancyhead[C]{\xeCJKsetup{CJKecglue={}}\zihao{5}\songti
    天津中德应用技术大学\izd@gradyear 届本科生毕业设计（论文）}%
  \fancyfoot[C]{\zihao{5}\thepage}%
  \renewcommand{\headrulewidth}{0.4pt}%
}

% 正文开始：页码从第 1 页重新计数，启用页眉页脚
\newcommand{\izdmainmatter}{%
  \clearpage
  \pagenumbering{arabic}%
  \pagestyle{izdmain}%
}

% ======================================================================
% 论文信息（封面用）
% ======================================================================
\def\izd@ctitle{}\def\izd@etitle{}
\def\izd@stuname{}\def\izd@college{软件与通信学院}
\def\izd@major{软件工程}\def\izd@advisor{}\def\izd@advisortitle{}\def\izd@finishdate{}
\newcommand{\ctitle}[1]{\gdef\izd@ctitle{#1}}
\newcommand{\etitle}[1]{\gdef\izd@etitle{#1}}
\newcommand{\stuname}[1]{\gdef\izd@stuname{#1}}
\newcommand{\college}[1]{\gdef\izd@college{#1}}
\newcommand{\major}[1]{\gdef\izd@major{#1}}
\newcommand{\advisor}[1]{\gdef\izd@advisor{#1}}
\newcommand{\advisortitle}[1]{\gdef\izd@advisortitle{#1}}
\newcommand{\finishdate}[1]{\gdef\izd@finishdate{#1}}

% 封面信息行：标签两端对齐 + 等长下划线（横线比文字稍长）
\newcommand{\izd@inforow}[2]{%
  \makebox[4em][s]{#1} & \underline{\makebox[7cm][c]{#2}}\\[10pt]}

% ======================================================================
% 封面
% ======================================================================
\newcommand{\makecover}{%
  \pagenumbering{Alph}% 封面不占页码，仅为保证 hyperref 锚点唯一
  \newgeometry{top=3cm,bottom=2.5cm,left=3cm,right=3cm}%
  \begin{titlepage}
    \centering
    \includegraphics[width=14.6cm]{figures/logo.png}\par
    \vspace{1.2cm}
    {\zihao{1}\heiti 本科生毕业设计\par}
    \vspace{1.8cm}
    {\zihao{3}\songti\bfseries \izd@ctitle\par}
    \vspace{0.5cm}
    {\zihao{3}\bfseries \izd@etitle\par}
    \vfill
    {\zihao{3}\songti\bfseries
      \renewcommand{\arraystretch}{1.2}%
      \begin{tabular}{@{}c c@{}}
        \izd@inforow{姓\hfill 名}{\izd@stuname}
        \izd@inforow{学\hfill 院}{\izd@college}
        \izd@inforow{专\hfill 业}{\izd@major}
        \izd@inforow{指导教师}{\izd@advisor}
        \izd@inforow{职\hfill 称}{\izd@advisortitle}
        \izd@inforow{完成时间}{\izd@finishdate}
      \end{tabular}\par}
    \vspace{0.8cm}
  \end{titlepage}
  \restoregeometry
  % 前置部分不显示页码；用大写罗马页码仅为避免 hyperref 页面锚点重复
  \pagenumbering{Roman}%
}

% ======================================================================
% 声明页
% ======================================================================
\newcommand{\makedeclaration}{%
  \clearpage
  \thispagestyle{empty}%
  \vspace*{0.6cm}
  {\centering\zihao{-3}\songti\bfseries
    天津中德应用技术大学\par
    本科生毕业设计（论文）的声明\par}
  \vspace{0.8cm}
  {\zihao{-4}\songti
    本人郑重声明：所呈交的毕业设计（论文），是本人在指导教师指导下，
    进行研究工作所取得的成果。除文中已经注明引用的内容外，本毕业设计
    （论文）的研究成果不包含任何他人创作的、已公开发表或没有公开发表
    的作品内容。对本设计（论文）所涉及的研究工作做出贡献的其他个人和
    集体，均已在文中以明确方式标明。本毕业设计（论文）原创性声明的法
    律责任由本人承担。\par}
  \vspace{1.2cm}
  \begin{flushright}
    \zihao{-4}\songti
    毕业设计（论文）作者签名：\underline{\makebox[3.5cm][c]{}}\quad\par
    \vspace{0.3cm}
    \makebox[3.5cm][c]{}年\quad 月\quad 日\quad\par
  \end{flushright}
  \vspace{1.2cm}
  {\zihao{-4}\songti
    本人声明：该毕业设计（论文）是本人指导学生完成的研究成果，已经审
    阅过设计（论文）的全部内容，并能够保证题目、关键词、摘要部分中英
    文内容的一致性和准确性。\par}
  \vspace{1.2cm}
  \begin{flushright}
    \zihao{-4}\songti
    毕业设计（论文）指导教师签名：\underline{\makebox[3.5cm][c]{}}\quad\par
    \vspace{0.3cm}
    \makebox[3.5cm][c]{}年\quad 月\quad 日\quad\par
  \end{flushright}
  \clearpage
}

% ======================================================================
% 中文摘要：标题三号黑体居中，“摘”“要”之间空 2 个全角空格；
% 正文小四宋体；无页眉、无页码
% ======================================================================
\newenvironment{cnabstract}{%
  \clearpage
  \thispagestyle{empty}%
  {\centering\zihao{3}\heiti 摘\hspace{2em}要\par}%
  \vspace{\baselineskip}
  \zihao{-4}\songti
}{\par}

% 关键词：小四；首行悬挂 4 字符；“关键词”三字黑体顶格 + 中文冒号；
% 各词之间用中文分号“；”，最后一个词后无分号（由使用者保证）
\newcommand{\keywords}[1]{%
  \par\vspace{\baselineskip}
  {\zihao{-4}\songti\hangindent=4em\hangafter=1
   {\heiti 关键词：}#1\par}}

% ======================================================================
% 英文摘要：标题三号 Times New Roman 加粗居中；正文小四 TNR；
% 无页眉、无页码
% ======================================================================
\newenvironment{enabstract}{%
  \clearpage
  \thispagestyle{empty}%
  {\centering\zihao{3}\bfseries ABSTRACT\par}%
  \vspace{\baselineskip}
  \zihao{-4}
}{\par}

% Key words：小四 TNR；“Key words：”加粗顶格（冒号为中文冒号）；
% 换行悬挂约 5 字符
\newcommand{\enkeywords}[1]{%
  \par\vspace{\baselineskip}
  {\zihao{-4}\hangindent=5em\hangafter=1
   \textbf{Key words：}#1\par}}

% ======================================================================
% 目录：标题三号黑体居中，“目”“录”之间空 4 个半角空格；
% 章条目四号宋体，节条目小四宋体；无页眉、无页码
% ======================================================================
\makeatletter
\newcommand{\izdtableofcontents}{%
  \clearpage
  \thispagestyle{empty}%
  {\centering\zihao{3}\heiti 目\hspace{2em}录\par}%
  \vspace{\baselineskip}
  \@starttoc{toc}%
  \clearpage
}
\makeatother

\titlecontents{chapter}[0pt]
  {\vspace{2pt}\zihao{4}\songti}
  {\thecontentslabel\hspace{2em}}
  {}
  {\titlerule*[6pt]{.}\contentspage}
\titlecontents{section}[5.3em]
  {\zihao{-4}\songti}
  {\contentslabel{2.3em}}
  {}
  {\titlerule*[6pt]{.}\contentspage}
\titlecontents{subsection}[7.6em]
  {\zihao{-4}\songti}
  {\contentslabel{3.2em}}
  {}
  {\titlerule*[6pt]{.}\contentspage}

% ======================================================================
% 图、表、公式
%   按章编号：图2.1 / 表3.1 / 式（3.1）（公式编号用中文括号）
%   图题在图下方，表题在表上方；五号宋体居中；编号与名称间空 2 个半角空格
% ======================================================================
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}

\DeclareCaptionFont{izdfive}{\zihao{5}\songti}
\DeclareCaptionLabelSeparator{izdtwosp}{\ \ }
\captionsetup{font=izdfive,labelsep=izdtwosp,justification=centering}

% 公式编号：式（3.1），括号为中文全角括号
\makeatletter
\def\tagform@#1{\maketag@@@{（\ignorespaces#1\unskip\@@italiccorr）}}
\makeatother

% ======================================================================
% 代码：五号、等宽；每段不超过半页（由使用者保证）
% ======================================================================
\lstset{
  basicstyle      = \ttfamily\zihao{5},
  breaklines      = true,
  columns         = flexible,
  keepspaces      = true,
  frame           = none,
  numbers         = none,
  showstringspaces= false,
  aboveskip       = 6pt,
  belowskip       = 6pt,
}

% ======================================================================
% 参考文献
%   标题：四号、黑体、顶格（注意：与一级标题格式不同）；
%   条目：五号宋体/TNR，GB/T 7714-2015 顺序编码制，悬挂缩进
% ======================================================================
\newcommand{\izdbibliography}[1]{%
  \clearpage
  \phantomsection\addcontentsline{toc}{chapter}{参考文献}%
  {\noindent\zihao{4}\heiti 参考文献\par}%
  \vspace{0.5\baselineskip}
  \renewcommand{\bibsection}{}% 抑制 natbib 自带的章标题
  \renewcommand{\bibfont}{\zihao{5}\songti}%
  \setlength{\bibsep}{0pt}%
  % gbt7714 宏包已自动指定 gbt7714-numerical 样式，无需 \bibliographystyle
  \bibliography{#1}%
}

% ======================================================================
% 致谢：标题小三黑体居中，“致”“谢”之间空 4 个半角空格；
% 正文小四宋体，首行缩进 2 字符；内容限 1 页
% ======================================================================
\newenvironment{acknowledgements}{%
  \clearpage
  \phantomsection\addcontentsline{toc}{chapter}{致谢}%
  {\centering\zihao{-3}\heiti 致\hspace{2em}谢\par}%
  \vspace{\baselineskip}
  \zihao{-4}\songti
}{\par\clearpage}

% ======================================================================
% 附录（可选）：标题小三黑体居中；正文小四；可放较长代码，
% 附录字数不计入正文字数要求
% ======================================================================
\newenvironment{izdappendix}{%
  \clearpage
  \phantomsection\addcontentsline{toc}{chapter}{附录}%
  {\centering\zihao{-3}\heiti 附\hspace{2em}录\par}%
  \vspace{\baselineskip}
  \zihao{-4}\songti
}{\par\clearpage}

% ======================================================================
% 超链接
% ======================================================================
\hypersetup{hidelinks,bookmarksnumbered,bookmarksopen}

\endinput
