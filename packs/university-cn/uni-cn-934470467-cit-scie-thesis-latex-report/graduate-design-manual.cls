%% ----------------------------------------------------------------------
%% 常州工学院毕业设计说明书（论文）LaTeX 模版
%% 依据《计算机信息工程学院毕业设计说明书（论文）格式规范》定制
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{graduate-design-manual}[2026/01/15 v1.4 CZU Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[UTF8, fontset=none, 12pt, a4paper, twoside]{ctexart}
\RequirePackage{geometry}
\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{subcaption}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{amsmath, amssymb, mathtools}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage[justification=centering]{caption}
% 让图/表标签与编号之间留半角空格，例如"图 1-1"而不是"图1-1"
\DeclareCaptionLabelFormat{spaced}{#1~#2}
\RequirePackage{tabularx, booktabs, longtable, multirow}
\RequirePackage[pdfusetitle, hidelinks]{hyperref}
\RequirePackage[numbers,super,square]{gbt7714}
\RequirePackage{tikz}
\usetikzlibrary{positioning}
\RequirePackage{xeCJKfntef}
\RequirePackage{chngcntr}
\RequirePackage{calc}
\RequirePackage{enumitem}
\pretocmd{\section}{\clearpage}{}{}
\renewcommand{\baselinestretch}{1.0}
% 中英文混排断行容差
\setlength{\emergencystretch}{2em}
% 导入代码与算法相关宏包
\RequirePackage{listings}       % 基础代码环境
\RequirePackage{mdframed}       % 用于给代码块画连续背景，避免 listings 逐行画背景的细缝
\RequirePackage{algorithm}      % 算法框架
\RequirePackage{algpseudocode}  % 伪代码逻辑
\RequirePackage{newfloat}       % 用于定义新的浮动体
% 1. 字体定义
\setCJKmainfont{Simsun.ttc}[Path=fonts/, AutoFakeBold=3]
\newCJKfontfamily{\songti}{Simsun.ttc}[Path=fonts/, AutoFakeBold=3]
\newCJKfontfamily{\heiti}{SimHei.ttf}[Path=fonts/, AutoFakeBold=3]
\newCJKfontfamily{\kai}{Kaiti.ttf}[Path=fonts/]
\newCJKfontfamily{\zhongsong}{STZHONGS.ttf}[Path=fonts/, AutoFakeBold=3.17]
\setmainfont{times.ttf}[Path=fonts/, BoldFont=times.ttf, AutoFakeBold=3]
\newfontfamily{\Times}{times.ttf}[Path=fonts/, BoldFont=times.ttf, AutoFakeBold=3]
\newfontfamily{\Arial}{arial.ttf}[Path=fonts/, BoldFont=arialbd.ttf]
% 单个数字（用于年份逐位）
\newcommand{\digittochinese}[1]{%
\ifcase#1 〇\or 一\or 二\or 三\or 四\or 五\or 六\or 七\or 八\or 九\fi
}

% 年份转中文（逐位）
\newcommand{\yeartochinese}[1]{%
\expandafter\yeartochinesehelper#1\relax
}
\def\yeartochinesehelper#1#2\relax{%
\digittochinese{#1}%
\ifx#2\empty\else
\yeartochinesehelper#2\relax
\fi
}

% 月份转中文
\newcommand{\monthtochinese}[1]{%
\ifcase#1 \or 一\or 二\or 三\or 四\or 五\or 六\or 七\or 八\or 九\or 十\or 十一\or 十二\fi
}

\xeCJKsetup{CJKglue=\hspace{0.2pt plus 0.05pt}}

\renewcommand{\normalsize}{%
    \songti
    \Times
    \fontsize{12pt}{20pt}\selectfont
    \xeCJKsetup{CJKglue=\hspace{0.2pt plus 0.05pt}}
}

\setlength{\parskip}{0pt}
\AtBeginEnvironment{tabular}{
    \songti\Times\fontsize{10.5pt}{20pt}\selectfont
}
\AtBeginEnvironment{tabularx}{
    \songti\Times\fontsize{10.5pt}{20pt}\selectfont
}
\AtBeginEnvironment{longtable}{
    \songti\Times\fontsize{10.5pt}{20pt}\selectfont
}
\newcolumntype{Y}{>{\centering\arraybackslash}X}
% 2. 版面设置
\geometry{
    a4paper,
    top=2.5cm,          % 上边距
    bottom=2.5cm,       % 下边距
    left=2.1cm,         % 左边距
    right=2.1cm,        % 右边距
    bindingoffset=0.5cm,% 装订线（左侧 0.5cm）
    headheight=18pt,    % 页眉高度（fancyhdr 要求 ≥18pt）
    headsep=0.5cm,      % 算式：top(2.5) - 页眉(1.5) - headheight 约等于 0.5cm
    footskip=0.75cm     % 算式：bottom(2.5) - 页脚(1.75) = 0.75cm
}

\raggedbottom

\setlist[enumerate,1]{
    label=（\arabic*）, 
    leftmargin=*, 
    itemindent=2em,
    labelsep=0em,
    align=left,
    nosep
}

\setlist[itemize,1]{
    label=\textbullet,
    labelindent=1em,
    labelwidth=1em,
    labelsep=0pt,
    leftmargin=2em,
    itemindent=0pt,
    listparindent=0pt,
    align=left,
    nosep
}

\setlength{\parindent}{2em}
\RequirePackage{indentfirst}
% 3. 变量定义
\newcommand*{\academy}[1]{\def\@academy{#1}}
\newcommand*{\field}[1]{\def\@field{#1}}
\newcommand*{\class}[1]{\def\@class{#1}}
\newcommand*{\classid}[1]{\def\@classid{#1}}
\newcommand*{\id}[1]{\def\@id{#1}}
\newcommand*{\Instructor}[1]{\def\@Instructor{#1}}
\newcommand*{\InstructorTitle}[1]{\def\@InstructorTitle{#1}}
\newcommand*{\ReviewingTeacher}[1]{\def\@ReviewingTeacher{#1}}
\newcommand*{\ReviewingTeacherTitle}[1]{\def\@ReviewingTeacherTitle{#1}}
\newcommand*{\thedate}[2]{\def\@Year{#1}\def\@Month{#2}}
% 4. 页眉页脚
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}

% 全局奇偶页页眉设置
\fancyhead[CO]{% 奇数页居中
    \kai\fontsize{10.5pt}{12pt}\selectfont 计算机信息工程学院毕业设计说明书
}
\fancyhead[CE]{% 偶数页居中
    \kai\fontsize{10.5pt}{12pt}\selectfont \@title%
}

% 页脚设置
\fancyfoot[C]{\Times\fontsize{9pt}{11pt}\selectfont\thepage}
\fancypagestyle{abstract}{
    \fancyhf{}
    \fancyhead[C]{\kai\fontsize{10.5pt}{12pt}\selectfont 计算机信息工程学院毕业设计说明书}
    \fancyfoot{}
}
\fancypagestyle{englishabstract}{
    \fancyhf{}
    \fancyhead[C]{\kai\fontsize{10.5pt}{12pt}\selectfont 计算机信息工程学院毕业设计说明书}
    \fancyfoot{}
}

% 5. 标题格式
\setcounter{secnumdepth}{3}

% 一级标题：二号黑体加粗，居中，段前段后0.5行
\titleformat{\section}[block]
    {\centering\bfseries\heiti\fontsize{22pt}{33pt}\selectfont}
    {第{\Times\arabic{section}}章}
    {0.5em}{}
\titlespacing*{\section}{0pt}{0.5\baselineskip}{0.5\baselineskip}

% 二级标题：三号黑体加粗，顶格居左，1.5倍行距
\titleformat{\subsection}[block]
    {\bfseries\heiti\fontsize{16pt}{24pt}\selectfont}
    {\Times\arabic{section}.\arabic{subsection}}
    {0.5em}{}
\titlespacing*{\subsection}{0pt}{0.5\baselineskip}{0.5\baselineskip}

% 三级标题：四号黑体加粗，顶格居左，1.5倍行距
\titleformat{\subsubsection}[block]
    {\bfseries\heiti\fontsize{14pt}{21pt}\selectfont}
    {\Times\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}
    {0.5em}{}
\titlespacing*{\subsubsection}{0pt}{0.5\baselineskip}{0.5\baselineskip}

% 6. 封面标题绘制
% 用法：
%   \covertitle{第一行}{第二行}   —— 两行
%   \covertitle{第一行}{}         —— 单行
%   （\title{...} 仍由页眉 / PDF 元数据使用，和封面相互独立）
\newdimen\coverTitleAreaWidth
\coverTitleAreaWidth=10.67cm
\def\@coverTitleFirst{}
\def\@coverTitleSecond{}
\newcommand{\covertitle}[2]{%
    \gdef\@coverTitleFirst{#1}%
    \gdef\@coverTitleSecond{#2}%
}
\newcommand{\DrawCoverTitle}{%
    \node[right=1mm, anchor=north west](title) at (titleName.north east) {%
        \begin{minipage}[t][2.8cm][t]{\coverTitleAreaWidth}
            \centering\zhongsong\fontsize{18pt}{45pt}\selectfont
            \@coverTitleFirst
            \ifx\@coverTitleSecond\@empty\else\par\@coverTitleSecond\fi
        \end{minipage}
    };
    \draw (title.south west)++(0mm,23mm) -- ++(\coverTitleAreaWidth,0mm);
    \ifx\@coverTitleSecond\@empty\else
        \draw (title.south west)++(0mm,7mm) -- ++(\coverTitleAreaWidth,0mm);
    \fi
}

% 7. 封面主命令
\newcommand*{\makecover}{
    \usetikzlibrary{positioning}
    \thispagestyle{empty}

    %% 使用 Tikz 构造封面
    \begin{tikzpicture}[overlay,remember picture]
        \node[shape=rectangle,draw=black,minimum width =1.6cm, minimum height = 0.65cm,below left = 1.9cm and 2.6cm] at (current page.north east) {\songti\@classid};

        \node[below=3.2cm, xshift=1mm] at (current page.north) {%
            \includegraphics[scale=1]{figures/cit-name.png}};

        \node[below=7.4cm, xshift=5mm] at (current page.north) {%
            \color{black}\centering\zhongsong\fontsize{26pt}{26pt}{\textbf{毕\hspace{0.5em}业\hspace{0.5em}设\hspace{0.5em}计\hspace{0.5em}说\hspace{0.5em}明\hspace{0.5em}书}}};

        \node[below right=12.00cm and 4.20cm, opacity=0](titleFieldAnchor) at (current page.north west) {%
            \zhongsong\fontsize{18pt}{18pt}{\textbf{\hspace{36pt}题目：}}};
        \coordinate (coverFieldWest) at ([xshift=1mm]titleFieldAnchor.north east);
        \node[anchor=north east, opacity=0](coverLabelGuide) at ([xshift=-0.1cm]coverFieldWest) {%
            \songti\fontsize{15pt}{33pt}\selectfont 二级学院：};
        \node[anchor=north west](titleName) at (coverLabelGuide.north west) {%
            \color{black}\raggedright\zhongsong\fontsize{18pt}{18pt}{\textbf{题目：}}};
        \DrawCoverTitle
        \coordinate (coverFieldStart) at (coverFieldWest |- title.south west);

        \node[below left=1.25cm and 0.1cm,anchor=north east](Academy) at (coverFieldStart) {
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{二级学院：}};
        \node[right=1mm,minimum height = 0.6cm,minimum width =9.4cm](AcademyContents) at (Academy.east){
            \color{black}\centering\songti\fontsize{15pt}{33pt}{\@academy}};
        \draw (AcademyContents.south west) -- (AcademyContents.south east);
        
        \node[below left=0.8cm and 0cm](Field) at (Academy.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{专\hspace{30pt}业：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](FieldContents) at (Field.east){
            \color{black}\centering\songti\fontsize{15pt}{33pt}{\@field}};
        \draw (FieldContents.south west) -- (FieldContents.south east);

        \node[below left=0.8cm and 0cm, minimum height = 0.6cm,minimum width =3.5cm](ClassContents) at (AcademyContents.south east){
            \color{black}\centering\fontsize{15pt}{33pt}\Times{\@class}};
        \draw (ClassContents.south west) -- (ClassContents.south east);
        \node[left=0.1cm](Class) at (ClassContents.west) {%
            \color{black}\raggedright\fontsize{15pt}{33pt}{班级：}};

        \node[below left=0.8cm and 0cm](Name) at (Field.south east) {%
            \color{black}\raggedleft\songti\fontsize{15pt}{33pt}{学生姓名：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](NameContents) at (Name.east){
            \color{black}\centering\fontsize{15pt}{33pt}\Times{\@author}};
        \draw (NameContents.south west) -- (NameContents.south east);

        \node[below left=0.8cm and 0cm](Id) at (Class.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{学号：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](IdContents) at (Id.east){
            \color{black}\centering\fontsize{15pt}{33pt}\Times{\@id}};
        \draw (IdContents.south west) -- (IdContents.south east);

        \node[below left=0.8cm and 0cm](Instructor) at (Name.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{指导教师：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](InstructorContents) at (Instructor.east){
            \color{black}\centering\songti\fontsize{15pt}{33pt}{\@Instructor}};
        \draw (InstructorContents.south west) -- (InstructorContents.south east);

        \node[below left=0.8cm and 0cm](InstructorTitle) at (Id.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{职称：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](InstructorTitleContents) at (InstructorTitle.east){
            \color{black}\centering\fontsize{15pt}{33pt}\Times{\@InstructorTitle}};
        \draw (InstructorTitleContents.south west) -- (InstructorTitleContents.south east);

        \node[below left=0.8cm and 0cm](ReviewingTeacher) at (Instructor.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{评阅教师：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](ReviewingTeacherContents) at (ReviewingTeacher.east){
            \color{black}\centering\songti\fontsize{15pt}{33pt}{\@ReviewingTeacher}};
        \draw (ReviewingTeacherContents.south west) -- (ReviewingTeacherContents.south east);

        \node[below left=0.8cm and 0cm](ReviewingTeacherTitle) at (InstructorTitle.south east) {%
            \color{black}\raggedright\songti\fontsize{15pt}{33pt}{职称：}};
        \node[right=0.1cm,minimum height = 0.6cm,minimum width =3.5cm](ReviewingTeacherTitleContents) at (ReviewingTeacherTitle.east){
            \color{black}\centering\fontsize{15pt}{33pt}\Times{\@ReviewingTeacherTitle}};
        \draw (ReviewingTeacherTitleContents.south west) -- (ReviewingTeacherTitleContents.south east);
        
        \node[above=3.40cm, xshift=5mm] at (current page.south) {
    		\color{black}\centering\songti\Times\fontsize{15pt}{20pt}\selectfont
    		\@Year 年\number\@Month 月
};
    \end{tikzpicture}
    \newpage
}

% 独创性声明
\newenvironment{originalitystatement}
{
    \clearpage
    \thispagestyle{empty}

    % 标题
    \begin{center}
        {\songti\fontsize{22pt}{33pt}\selectfont 毕业论文（设计）独创性声明}
    \end{center}
    
    \vspace{1.5\baselineskip}
    
    % 正文：宋体四号，行距与正文一致
    \songti\fontsize{14pt}{21pt}\selectfont
}
{
    \par\vspace{9\baselineskip}
    \begin{flushright}
        \begin{tabular}{@{}l@{}}
            \songti\fontsize{14pt}{21pt}\selectfont 作者签名： \\[\baselineskip]
            ~ \\[\baselineskip]
            \songti\fontsize{14pt}{21pt}\selectfont 日\hspace{2em}期：
        \end{tabular}\hspace*{2.7cm}
    \end{flushright}
    \clearpage
}
% 摘要
\newenvironment{cnabstract}[2]
{
    \clearpage
    \pagestyle{abstract}
    \songti\fontsize{12pt}{20pt}\selectfont

    {
        \centering
        {\fontsize{16pt}{20pt}\selectfont #1\par}
        {\bfseries 摘~~要\par}
    }

    \def\tempkeywords{#2}
}
{
    \par
    \noindent{\songti\bfseries\fontsize{12pt}{20pt}\selectfont 关键词：}\tempkeywords
    \clearpage
}

\newenvironment{englishabstract}[2] % #1: Title, #2: Key words
{
    \clearpage
    \pagestyle{englishabstract}
    \Times\fontsize{12pt}{20pt}\selectfont

    {
        \centering
        {\Arial\bfseries\fontsize{14pt}{20pt}\selectfont \MakeUppercase{#1}\par}
        {\Arial\bfseries\fontsize{14pt}{20pt}\selectfont Abstract\par}
    }
    \def\tempekeywords{#2}
}
{
    \par
    \noindent{\Times\bfseries\fontsize{12pt}{20pt}\selectfont Keywords: }\tempekeywords
    \clearpage
}
%目录
%1. 引入宏包
\usepackage[titles]{tocloft}

%2. 统一字体定义：目录内容小四，1.5倍行距
\newcommand{\tocfont}{\songti\fontsize{12pt}{20pt}\selectfont}

%3. 目录标题：二号宋体加粗居中
\renewcommand{\contentsname}{\songti\bfseries\fontsize{22pt}{22pt}\selectfont 目录}

% 目录标题前后间距：各 0.5 行
\setlength{\cftbeforetoctitleskip}{10pt}
\setlength{\cftaftertoctitleskip}{10pt}

%4. 引导线疏密设置
\renewcommand{\cftdotsep}{0.3}
\renewcommand{\cftsecdotsep}{0.3}
\renewcommand{\cftsubsecdotsep}{0.3}
\renewcommand{\cftsubsubsecdotsep}{0.3}

%5. 页码字体
\renewcommand{\cftsecpagefont}{\tocfont}
\renewcommand{\cftsubsecpagefont}{\tocfont}
\renewcommand{\cftsubsubsecpagefont}{\tocfont}

% 一级标题
\renewcommand{\cftsecfont}{\tocfont\bfseries}
\setlength{\cftsecindent}{0em}
\setlength{\cftsecnumwidth}{3.5em}
\setlength{\cftbeforesecskip}{6pt}

% 二级标题
\renewcommand{\cftsubsecfont}{\tocfont}
\setlength{\cftsubsecindent}{2em}
\setlength{\cftsubsecnumwidth}{1.5em}
\setlength{\cftbeforesubsecskip}{6pt}

% 三级标题
\renewcommand{\cftsubsubsecfont}{\tocfont}
\setlength{\cftsubsubsecindent}{4em}
\setlength{\cftsubsubsecnumwidth}{1.5em}
\setlength{\cftbeforesubsubsecskip}{6pt}

\newcommand{\contents}
{
    \clearpage

    \setlength{\parskip}{0pt}
    \ctexset{section={name={第,章}}}

    % 目录使用大写罗马数字，从 I 开始；正文 \mainbody 再切回 arabic
    \pagenumbering{Roman}
    \pagestyle{fancy}

    \tableofcontents

    \clearpage
}

\newcommand{\mainbody}
{
    \clearpage
    \pagestyle{fancy}
    \pagenumbering{arabic}
	\fancyfoot[C]{\Times\fontsize{9pt}{11pt}\selectfont\thepage}
}

%9. 插图、表格、公式格式化
\DeclareCaptionFont{five}{\songti\Times\fontsize{10.5pt}{20pt}\selectfont}
% 三线表线宽（精确控制）
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\heavyrulewidth}{0.053cm}   % 上下边线
\setlength{\lightrulewidth}{0.0265cm}  % 表头分割线
\DeclareCaptionFont{tablefont}{
    \songti\Times\fontsize{10.5pt}{20pt}\selectfont
}
% 表题字体：五号，宋体+Times，1.5倍行距
\captionsetup[table]{
    font=tablefont,
    labelsep=quad,
    labelformat=spaced,
    justification=centering,
    position=top,
    skip=6pt,
    singlelinecheck=false
}
% 编号按章计：图 1-1, 表 3-1, 公式 (2.3)
\counterwithin{figure}{section}
\counterwithin{table}{section}
\counterwithin{equation}{section}

\renewcommand{\thefigure}{\thesection-\arabic{figure}}
\renewcommand{\thetable}{\thesection-\arabic{table}}
\renewcommand{\theequation}{\arabic{section}.\arabic{equation}}


\captionsetup{
    font=five,
    labelsep=quad,
    labelformat=spaced,
    justification=centering,
    singlelinecheck=false
}

% 针对插图：图号图题在下
\captionsetup[figure]{position=bottom, skip=10pt}
% 针对表格：表号表题在上
\captionsetup[table]{position=top}

% 公式括号形式
\makeatletter
\def\tagform@#1{%
    \maketag@@@{%
        \mbox{\Times\fontsize{10.5pt}{10.5pt}\selectfont(#1)}%
    }%
}
\makeatother

% 10. 致谢环境
\newenvironment{acknowledgement}
{
    \clearpage
    \section*{致谢}
    \addcontentsline{toc}{section}{致谢}
    \normalsize
}
{\clearpage}

% 11. 参考文献格式
\setcitestyle{open={[},close={]},citesep={,},super}
\renewcommand{\bibsection}{%
    \section*{参考文献}
    \addcontentsline{toc}{section}{参考文献}
}
\AtBeginEnvironment{thebibliography}{
    % 字体：中文宋体，英文Times，五号，固定20磅行距
    \songti\Times
    \fontsize{10.5pt}{20pt}\selectfont
    
    % 字间距
    \xeCJKsetup{CJKglue=\hspace{0.2pt plus 0.05pt}}
    
    % 悬挂缩进2字符
    \setlength{\bibhang}{2em}

    % 只保留20磅行距，不叠加条目额外间距
    \setlength{\bibsep}{0pt}
    \setlength{\itemsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\parskip}{0pt}
    
    % 对齐控制
    \setlength{\labelwidth}{2em}
    \setlength{\leftmargin}{\labelwidth}
    \addtolength{\leftmargin}{\labelsep}
}


% 12. 附录格式
\newenvironment{appendixsection}
{
    \clearpage
    
    % 使用正文一级标题样式（不编号）
    \section*{附录}
    
    % 正文格式（与主体一致）
    \songti\Times\fontsize{12pt}{20pt}\selectfont
    \xeCJKsetup{CJKglue=\hspace{0.2pt plus 0.05pt}}
}
{
    \clearpage
}
% 设置算法编号按章排序，例如：算法 3-1
\counterwithin{algorithm}{section}
\renewcommand{\thealgorithm}{\thesection-\arabic{algorithm}}
\floatname{algorithm}{算法}
% 用 mdframed 给 lstlisting 包一层连续灰底（替代 listings 逐行 backgroundcolor）
\definecolor{codeBg}{RGB}{217,217,217}
\surroundwithmdframed[
    backgroundcolor=codeBg,
    linewidth=0pt,
    skipabove=10pt,
    skipbelow=10pt,
    innerleftmargin=6pt,
    innerrightmargin=6pt,
    innertopmargin=6pt,
    innerbottommargin=6pt,
]{lstlisting}

\lstset{
    basicstyle=\songti\Times\fontsize{10.5pt}{12pt}\selectfont,
    columns=flexible,
    breaklines=true,
    breakatwhitespace=false,
    frame=none,
    framesep=0pt,
    showstringspaces=false,
    showspaces=false,
    showtabs=false,
    keepspaces=true,
    tabsize=4,
    captionpos=b
}


\endinput
