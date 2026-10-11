%%
%% This is file `jluthesis.cls',
%% generated based on user's existing settings in `beifen/main.tex`
%% and the cover design from `jluthesis-main`.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jluthesis}[2026/02/09 Custom Thesis Class]

% Load base class (from beifen/main.tex)
\LoadClass[10pt,a4paper]{article}

% =========================================================================
% 页面设置与几何尺寸 (Page Layout & Geometry)
% =========================================================================
% \RequirePackage[margin=1in]{geometry}
% 调整页面边距：left (左), right (右), top (上), bottom (下)
% 示例：\RequirePackage[left=3cm,right=3cm,top=3cm,bottom=3cm]{geometry}
\RequirePackage[margin=1in]{geometry}

% =========================================================================
% 基础宏包加载 (Basic Package Imports)
% =========================================================================
% \RequirePackage{ctex}       % 中文支持
% \RequirePackage{amsmath}    % 数学公式支持
% \RequirePackage{graphicx}   % 图片支持
% \RequirePackage{array}      % 表格扩展
% \RequirePackage{listings}   % 代码抄录
% \RequirePackage{hyperref}   % 超链接
\RequirePackage{afterpage}
\RequirePackage{diagbox}
\RequirePackage[UTF8,heading = true]{ctex}
\RequirePackage{xeCJKfntef}
\RequirePackage{amsmath,amssymb,amsfonts,mathrsfs}
\RequirePackage{graphicx}
\RequirePackage{ulem}
\RequirePackage{pdfpages}
\RequirePackage{lipsum}
\RequirePackage{booktabs}
\RequirePackage{array,tabularx,longtable}
\newcolumntype{Y}{>{\centering\arraybackslash}X}
\RequirePackage{multirow}
\RequirePackage{listings}
\RequirePackage{enumerate}
\RequirePackage{tikz}
\RequirePackage{tikz-qtree,tikz-qtree-compat}
\usetikzlibrary{arrows}
\RequirePackage{siunitx}
\RequirePackage{anyfontsize}
\RequirePackage{xeCJK}
\RequirePackage{calc}

% =========================================================================
% 字体设置 (from beifen)
% =========================================================================
% \setCJKmainfont[Path=fonts/]{SimSun.TTC}

% =========================================================================
% 排版与格式设置 (from beifen)
% =========================================================================
\RequirePackage{setspace}
\RequirePackage{color}
\RequirePackage{titletoc}

% 标题间距设置 (titlesec)
\RequirePackage[explicit]{titlesec}
% syntax: \titlespacing{command}{left}{before-sep}{after-sep}
% \section: 左间距0，段前0，段后20pt
\titlespacing{\section}{0pt}{0pt plus .0pt }{20pt plus .0pt}
% \subsection: 左间距0，段前6pt，段后6pt
\titlespacing{\subsection}{0pt}{6pt plus .0pt}{6pt plus .0pt}

% 算法环境设置
\RequirePackage{algorithm,algorithmic}
\RequirePackage{float}

% 参考文献设置
\RequirePackage[sort&compress]{gbt7714}
\citestyle{numbers}
\setcitestyle{numbers}
\renewcommand{\bibnumfmt}[1]{[#1]\hspace{0.5em}}
\bibliographystyle{jluthesis-gbt7714-numerical}

% 图片路径
\graphicspath{{images/}}

% =========================================================================
% 章节标题格式定制 (Section Heading Format)
% =========================================================================
% 修改 format 参数可调整字体和大小
% \zihao{3} = 三号, \zihao{4} = 四号, \zihao{-4} = 小四
% \heiti = 黑体, \songti = 宋体, \bfseries = 加粗
\ctexset{
	section={
		name={第,章},
		format=\bfseries\centering\heiti\zihao{3}, % 三号黑体居中
		numberformat=\bfseries\heiti\zihao{3},
	},
	subsection={
		format=\bfseries\raggedright\heiti\zihao{4}, % 四号黑体左对齐
		numberformat=\bfseries\heiti\zihao{4}
	},
	subsubsection={
		format=\bfseries\raggedright\heiti\zihao{-4} % 小四号黑体左对齐
	}
}

% =========================================================================
% 代码高亮设置 (from beifen)
% =========================================================================
\RequirePackage[framed,numbered,autolinebreaks,useliterate]{mcode}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.95}

\lstdefinestyle{general}{
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=4,
    frame=single,
    literate={}
} 

% =========================================================================
% 页眉页脚设置 (Header & Footer Settings)
% =========================================================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{} % 清空当前设置

% 通用页眉: 居中显示章节名称 (五号宋体)
\fancyhead[C]{\zihao{5}\songti{\nouppercase{\leftmark}}}
% 通用页脚: 右侧显示页码
\fancyfoot[R]{\thepage}

% 定义 'yemei' 样式 (用于正文)
\fancypagestyle{yemei}
{
	\fancyhf{}
	\fancyhead[C]{\zihao{5}\songti{\nouppercase{\leftmark}}}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.5pt} % 页眉线宽
}

% 定义 'mulu' 样式 (用于目录)
\fancypagestyle{mulu}
{
	\fancyhf{}
	\fancyhead[C]{\zihao{5}\songti{目录}} % 强制显示"目录"
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.5pt}
}

% =========================================================================
% 超链接设置 (from beifen)
% =========================================================================
\RequirePackage[colorlinks,linkcolor=black,citecolor=blue,bookmarks=true,bookmarksnumbered=true]{hyperref}
\hypersetup{
	filecolor=black,      
	urlcolor=black,
}

% =========================================================================
% 目录格式设置 (from beifen)
% =========================================================================
\RequirePackage{subcaption}
\RequirePackage[titles]{tocloft}
\RequirePackage{etoolbox}
\RequirePackage{xparse}

\renewcommand{\baselinestretch}{1.5}
\setlength\baselineskip{24pt}
\setlength{\headheight}{15pt}

\renewcommand{\cftdot}{.}
\renewcommand{\cftsecdotsep}{0.6}
\renewcommand{\cftsubsecdotsep}{0.6}
\renewcommand{\cftsubsubsecdotsep}{0.6}

\renewcommand{\cftsecfont}{\zihao{4}\songti}
\renewcommand{\cftsubsecfont}{\zihao{4}\songti}
\renewcommand{\cftsubsubsecfont}{\zihao{4}\songti}

\renewcommand{\cftsecpagefont}{\zihao{4}\songti}
\renewcommand{\cftsubsecpagefont}{\zihao{4}\songti}
\renewcommand{\cftsubsubsecpagefont}{\zihao{4}\songti}

\setlength{\cftsecindent}{0\ccwd}
\setlength{\cftsecnumwidth}{4\ccwd}
\setlength{\cftsubsecindent}{1\ccwd}
\setlength{\cftsubsecnumwidth}{2.5\ccwd}
\setlength{\cftsubsubsecindent}{2\ccwd}
\setlength{\cftsubsubsecnumwidth}{3.5\ccwd}

\let\heiti\relax 
\let\songti\relax

\RequirePackage{caption}
\RequirePackage{threeparttable}

% =========================================================================
% 图表标题格式 (Caption Format)
% =========================================================================
% 图表编号格式：章节号.序号 (如 1.1, 1.2)
\RequirePackage{chngcntr}
\counterwithin{equation}{section}
\counterwithin{table}{section}
\counterwithin{figure}{section}
\renewcommand\thetable{\thesection.\arabic{table}} 
\renewcommand\thefigure{\thesection.\arabic{figure}}

% 字体定义 (Font Definitions)
% 定义 \heiti 和 \songti 命令，指向 fonts/ 目录下的字体文件
% AutoFakeBold 用于伪粗体效果
\newCJKfontfamily{\heiti}[Path=fonts/, AutoFakeBold={1.7}]{SimHei.TTF}
\newCJKfontfamily{\songti}[Path=fonts/, AutoFakeBold={3}]{SimSun.TTC}

% 图表标签名称 (Figure/Table Label Names)
\renewcommand{\figurename}{图}
\renewcommand\tablename{表}

% 标题样式设置 (Caption Setup)
% labelsep=quad (标签与标题间空一格), font={small,heiti} (小号黑体)
\DeclareCaptionFont{heiti}{\heiti}
\captionsetup{labelformat=default,labelsep=quad,font={normalsize,heiti}}
\AtBeginEnvironment{tabular}{\zihao{-4}}
\AtBeginEnvironment{tabularx}{\zihao{-4}}
\AtBeginEnvironment{longtable}{\zihao{-4}}

% =========================================================================
% 加载配置文件
% =========================================================================
\input{jluthesis.cfg}

% 正文章节状态控制
\newif\ifjlu@mainmatter
\newif\ifjlu@sectionbreak
\jlu@mainmatterfalse
\jlu@sectionbreakfalse

% =========================================================================
% 封面设计 (from jluthesis-main, Level 2)
% =========================================================================
\newcommand{\clearpagebyprint}{\if@twoside\cleardoublepage\else\clearpage\fi}
\newcommand{\fillinblank}[2]{\CJKunderline{\makebox[#1]{#2}}}

\newcommand{\makecover}{
    \begin{titlepage}
        % 1. 校徽图片位置调整 (University Emblem Position)
        % \vspace*{0.7cm}: 距离页面顶部的垂直距离 (Vertical space from top)
        \vspace*{0.7cm}
        \begin{flushleft}
            % \hspace*{1.0cm}: 距离页面左侧的水平距离 (Horizontal space from left)
            \hspace*{1.0cm}
            \includegraphics[width=2.8cm]{images/jd-xhh.jpg}
        \end{flushleft}
        
        % 2. 校名图片位置调整 (University Name Position)
        % \vspace{-1.0cm}: 与上方校徽的垂直间距 (负值表示向上移动)
        \vspace{-1.0cm} 
        \begin{center}
            \includegraphics[width=5.75cm,height=1.75cm]{images/jd-xm.jpg}

            \vspace{-0.3cm}
            % 本科生毕业论文（设计）：36号字 (小初号)
            \songti \zihao{-0} \bfseries 本科生毕业论文（设计） \\[2.5cm]
            
            % 下方内容：16号字 (三号)
            \songti \zihao{3} \bfseries
            
            % 3. 封面行距设置 (Line Spacing)
            % \linespread{1.2}: 设置为 1.2 倍行距
            \linespread{1.6}\selectfont
            \newlength{\cover@linewidth}
            \newlength{\cover@labelwidth}
            \newlength{\cover@underline}
            \newlength{\cover@remain}
            \newlength{\cover@colone} 
            \newlength{\cover@coltwo}
            \setlength{\cover@linewidth}{13.5cm}
            \setlength{\cover@underline}{\cover@linewidth - 4em}
            \makebox[4em][s]{中文题目}\CJKunderline{\makebox[\cover@underline]{\songti \zihao{3} \bfseries \cover@ctitlef}} \\
            \hspace{4em}\CJKunderline{\makebox[\cover@underline]{\songti \zihao{3} \bfseries \cover@ctitles}} \\
            \setlength{\cover@underline}{\cover@linewidth - 4em}
            \makebox[4em][s]{英文题目}\CJKunderline{\makebox[\cover@underline]{\songti \zihao{-4} \bfseries \cover@etitlef}} \\
            \hspace{4em}\CJKunderline{\makebox[\cover@underline]{\songti \zihao{-4} \bfseries \cover@etitles}} \\
            \vspace{1.5cm}
            \setlength{\cover@colone}{3.0cm} 
            \setlength{\cover@coltwo}{3.0cm}
            \setlength{\cover@remain}{\cover@linewidth - 8em - \cover@colone - \cover@coltwo}
            \makebox[4em][s]{学生姓名}\CJKunderline{\makebox[\cover@colone]{\cover@author}}%
            \makebox[2em][s]{班级}\CJKunderline{\makebox[\cover@coltwo]{\cover@class}}%
            \makebox[2em][s]{学号}\CJKunderline{\makebox[\cover@remain]{\cover@studentid}} \\
            \setlength{\cover@underline}{\cover@linewidth - 4em}
            \makebox[4em][s]{学\hfill 院}\CJKunderline{\makebox[\cover@underline]{\cover@school}} \\
            \setlength{\cover@underline}{\cover@linewidth - 4em}
            \makebox[4em][s]{专\hfill 业}\CJKunderline{\makebox[\cover@underline]{\cover@major}} \\
            \setlength{\cover@colone}{4.9cm}
            \setlength{\cover@remain}{\cover@linewidth - 6em - \cover@colone}
            \makebox[4em][s]{指导教师}\CJKunderline{\makebox[\cover@colone]{\cover@mentor}}%
            \makebox[2em][s]{职称}\CJKunderline{\makebox[\cover@remain]{\cover@mentortitle}} \\
            \vfill
            {\songti \zihao{3} \bfseries \cover@time}
            % 4. 日期位置调整 (Date Position)
            % \vspace{0cm}: 调整此数值可微调垂直位置 (如 \vspace{-1cm} 可向下移动)
            \vspace{0.5cm}
        \end{center}
    \end{titlepage}
}

% =========================================================================
% =========================================================================
% 用户命令与环境 (User Commands & Environments)
% =========================================================================

% 1. 中文摘要环境 (Chinese Abstract Environment)
% 使用方法：\begin{cabstract} ... \end{cabstract}
\newenvironment{cabstract}{
    % Header
    \fancyhead[C]{\zihao{5}\songti{\abstract@cabstract}}
    % Title
    \vspace*{0pt}
    \centerline{\zihao{3}\songti\bfseries \abstract@cabstract}
    \vspace*{16pt}
    % Content Styling
    \linespread{1.4}
    \zihao{-4}
}{
    \par
}

% 2. 英文摘要环境 (English Abstract Environment)
% 使用方法：\begin{eabstract} ... \end{eabstract}
\newenvironment{eabstract}{
    \newpage
    % Header
    \fancyhead[C]{\zihao{5}\songti{\abstract@eabstract}}
    % Title
    \vspace*{0pt}
    \centerline{\zihao{3}\bfseries \abstract@eabstract}
    \vspace*{20pt}
    % Content Styling
    \linespread{1.4}
    \zihao{-4}
}{
    \par
}

% 3. 关键词命令 (Keywords Commands)
% 使用方法：\ckeywords{词1；词2...}
\newcommand{\ckeywords}[1]{
    \bigskip
    \noindent{\zihao{-4}\songti \textbf{\abstract@ckeywords}}
    \par
    \noindent\hspace*{2\ccwd}#1
}

% 使用方法：\ekeywords{Word1; Word2...}
\newcommand{\ekeywords}[1]{
    \bigskip
    \noindent\textbf{\zihao{-4} \abstract@ekeywords}
    \par
    #1
}

% 4. 目录生成命令 (Table of Contents Command)
% 使用方法：\makeTOC
\newcommand{\makeTOC}{
    \newpage
    \setcounter{secnumdepth}{4}
    \setcounter{tocdepth}{2}
    \renewcommand\contentsname{\zihao{3}\heiti\textbf{目\quad 录}}
    
    \begin{spacing}{1.7}
        {\centering\tableofcontents}
    \end{spacing}
    \thispagestyle{mulu}
    \vspace*{16pt}
}

% 5. 正文开始初始化命令 (Main Matter Initialization)
% 使用方法：\startmainmatter (在目录后，正文第一章前使用)
\newcommand{\startmainmatter}{
    \newpage
    \setcounter{page}{1}
    \pagenumbering{arabic}
    \pagestyle{yemei}
    \zihao{-4}
    \jlu@mainmattertrue
    \jlu@sectionbreakfalse
}

% 6. 章节命令重定义 (Section Command Redefinition)
% 自动处理页眉标记 (Auto Header Mark)
\let\oldsection\section
\RenewDocumentCommand{\section}{s m}{
    \IfBooleanTF{#1}{
        \oldsection*{#2}
    }{
        \ifjlu@mainmatter
            \ifjlu@sectionbreak
                \clearpage
            \else
                \global\jlu@sectionbreaktrue
            \fi
        \fi
        \oldsection{#2}
        \markboth{第\thesection 章\quad #2}{第\thesection 章\quad #2}
    }
}

% 7. 承诺书生成命令 (Commitment Command)
% 使用方法：\makecommitment
\newcommand{\makecommitment}{
    \clearpage
    \IfFileExists{docs/commitment.pdf}{
        \includepdf[pages=-,pagecommand={\thispagestyle{empty}}]{docs/commitment.pdf}
    }{
        \begin{titlepage}
            \thispagestyle{empty}
            \centering
            \vspace*{2.8cm}
            {\songti\zihao{2}\bfseries \commitment@title \par}
            \vspace{2.5cm}
            {\songti\zihao{3}\linespread{1.7}\selectfont
                \parindent=2\ccwd
                \noindent \commitment@content \par
            }
            \vfill
            \begin{flushright}
                {\songti\zihao{3} \commitment@sign \par}
                \vspace{1.8cm}
                {\songti\zihao{3} \commitment@time \par}
            \end{flushright}
        \end{titlepage}
    }
}

% 8. 致谢环境 (Acknowledgment Environment)
% 使用方法：\begin{acknowledgment} ... \end{acknowledgment}
\newenvironment{acknowledgment}{
    \newpage
    \section*{致谢}
    \phantomsection
    \addcontentsline{toc}{section}{致谢}
    \markboth{致谢}{致谢}
    \fancyhead[C]{\zihao{5}\songti{致谢}}
}{
    \par
}

% 9. 参考文献生成命令 (Bibliography Command)
% 使用方法：\makebibliography
\newcommand{\makebibliography}{
    \newpage
    \phantomsection
    \addcontentsline{toc}{section}{参考文献}
    \markboth{参考文献}{参考文献}
    \setlength{\bibhang}{0pt}
    \bibliography{references}
}

\endinput
