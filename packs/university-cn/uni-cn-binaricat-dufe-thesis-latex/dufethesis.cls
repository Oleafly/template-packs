%% dufethesis.cls
%% 东北财经大学研究生学位论文 LaTeX 模板
%% 根据《东北财经大学研究生学位论文格式要求》制作

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dufethesis}[2024/01/01 东北财经大学研究生学位论文模板]

%% 论文类型选项
\newif\ifdoctor
\doctorfalse
\newif\ifprofmaster  % 专业硕士
\profmasterfalse
\DeclareOption{doctor}{\doctortrue}
\DeclareOption{master}{\doctorfalse\profmasterfalse}
\DeclareOption{profmaster}{\doctorfalse\profmastertrue}  % 专业硕士

%% 其他选项传递给 ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

%% 基于 ctexbook 类
\LoadClass[zihao=-4,a4paper,openany,oneside,fontset=fandol]{ctexbook}

%% 允许使用 @ 宏
\makeatletter

%% ========== 宏包加载 ==========
\RequirePackage{geometry}       % 页面设置
\RequirePackage{fancyhdr}       % 页眉页脚
\RequirePackage{graphicx}       % 图片
\RequirePackage{amsmath,amssymb}% 数学
\RequirePackage{newtxmath}      % Times 风格数学字体
\RequirePackage{booktabs}       % 表格线
\RequirePackage{array}          % 表格
\RequirePackage{longtable}      % 长表格
\RequirePackage{tabularx}       % 可调宽度表格
\RequirePackage{multirow}       % 多行表格
\RequirePackage{caption}        % 图表标题
\RequirePackage{subcaption}     % 子图
\RequirePackage{enumitem}       % 列表
\RequirePackage{xcolor}         % 颜色
\RequirePackage{hyperref}       % 超链接
\RequirePackage{bookmark}       % 书签
\RequirePackage{pdfpages}       % PDF 页面插入
\RequirePackage{setspace}       % 行距
\RequirePackage{titletoc}       % 目录格式
\RequirePackage{titlesec}       % 标题格式
\RequirePackage[no-math]{fontspec}       % 字体（不处理数学字体）
\RequirePackage{xeCJK}          % 中文支持
\RequirePackage{etoolbox}       % 工具宏
\RequirePackage{xstring}        % 字符串处理
\RequirePackage{zhnumber}       % 中文数字
\RequirePackage[bottom]{footmisc} % 脚注

%% ========== 页面设置 ==========
%% 16开纸 184mm x 260mm
%% 送印页边距：上20mm，下20mm，左20mm，右20mm
%% 页眉和页脚计入版心，确保页码不会落入页面底部留白区
\geometry{
    paperwidth=184mm,
    paperheight=260mm,
    top=20mm,
    bottom=20mm,
    left=20mm,
    right=20mm,
    includehead,
    includefoot,
    headheight=30pt,
    headsep=5pt,
    footskip=10mm
}

%% ========== 字体设置 ==========
%% 设置英文字体
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}


%% ========== 字号定义 ==========
\newcommand{\chuhao}{\fontsize{42pt}{50.4pt}\selectfont}
\newcommand{\xiaochu}{\fontsize{36pt}{43.2pt}\selectfont}
\newcommand{\yihao}{\fontsize{26pt}{31.2pt}\selectfont}
\newcommand{\xiaoyi}{\fontsize{24pt}{28.8pt}\selectfont}
\newcommand{\erhao}{\fontsize{22pt}{26.4pt}\selectfont}
\newcommand{\xiaoer}{\fontsize{18pt}{21.6pt}\selectfont}
\newcommand{\sanhao}{\fontsize{16pt}{19.2pt}\selectfont}
\newcommand{\xiaosan}{\fontsize{15pt}{18pt}\selectfont}
\newcommand{\sihao}{\fontsize{14pt}{16.8pt}\selectfont}
\newcommand{\xiaosi}{\fontsize{12pt}{14.4pt}\selectfont}
\newcommand{\wuhao}{\fontsize{10.5pt}{12.6pt}\selectfont}
\newcommand{\xiaowu}{\fontsize{9pt}{10.8pt}\selectfont}
\newcommand{\liuhao}{\fontsize{7.5pt}{9pt}\selectfont}

%% ========== 行距设置 ==========
%% 学校要求：行间距 20 磅。ctexbook 默认 zihao=-4 时 baselineskip 约 14.4pt，
%% 因此需将 baselinestretch 设为 20/14.4 ≈ 1.389 使得全局行距为 20 磅。
%% 使用 \linespread 而非 \setlength{\baselineskip} —— 后者会被字体切换重置。
\linespread{1.389}\selectfont
\AtBeginDocument{%
    \linespread{1.389}\selectfont
    \setlength{\parindent}{2em}%
    \setlength{\parskip}{0pt}%
}

%% ========== 论文信息变量 ==========
\newcommand{\dufe@schoolcode}{10173}
\newcommand{\dufe@classno}{}
\newcommand{\dufe@secretlevel}{}
\newcommand{\dufe@studentid}{}
\newcommand{\dufe@udc}{}
\newcommand{\dufe@title}{}
\newcommand{\dufe@entitle}{}
\newcommand{\dufe@author}{}
\newcommand{\dufe@supervisor}{}
\newcommand{\dufe@supervisortitle}{}
\newcommand{\dufe@major}{}        % 一级学科
\newcommand{\dufe@submajor}{}     % 二级学科
\newcommand{\dufe@discipline}{}   % 学科门类（专硕）
\newcommand{\dufe@proftype}{}     % 专业学位类别（专硕）
\newcommand{\dufe@college}{}      % 所在学院
\newcommand{\dufe@submitdate}{}
\newcommand{\dufe@defenddate}{}

%% 设置论文信息的命令
\newcommand{\schoolcode}[1]{\renewcommand{\dufe@schoolcode}{#1}}
\newcommand{\classno}[1]{\renewcommand{\dufe@classno}{#1}}
\newcommand{\secretlevel}[1]{\renewcommand{\dufe@secretlevel}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\dufe@studentid}{#1}}
\newcommand{\udc}[1]{\renewcommand{\dufe@udc}{#1}}
\renewcommand{\title}[1]{\renewcommand{\dufe@title}{#1}}
\newcommand{\entitle}[1]{\renewcommand{\dufe@entitle}{#1}}
\renewcommand{\author}[1]{\renewcommand{\dufe@author}{#1}}
\newcommand{\supervisor}[1]{\renewcommand{\dufe@supervisor}{#1}}
\newcommand{\supervisortitle}[1]{\renewcommand{\dufe@supervisortitle}{#1}}
\newcommand{\major}[1]{\renewcommand{\dufe@major}{#1}}
\newcommand{\submajor}[1]{\renewcommand{\dufe@submajor}{#1}}
\newcommand{\discipline}[1]{\renewcommand{\dufe@discipline}{#1}}  % 学科门类
\newcommand{\proftype}[1]{\renewcommand{\dufe@proftype}{#1}}      % 专业学位类别
\newcommand{\college}[1]{\renewcommand{\dufe@college}{#1}}
\newcommand{\submitdate}[1]{\renewcommand{\dufe@submitdate}{#1}}
\newcommand{\defenddate}[1]{\renewcommand{\dufe@defenddate}{#1}}

%% ========== 封面 ==========
\newcommand{\makecover}{%
    \begin{titlepage}
    \thispagestyle{empty}
    \begin{center}
        %% 顶部信息（两行格式，按Word文档排版）
        \vspace*{-10mm}
        \begin{flushleft}
            {\xiaosi\songti\bfseries
            学校编码：\dufe@schoolcode\hspace{5mm}分类号\underline{\makebox[15mm][c]{\dufe@classno}}\hspace{2mm}密级\underline{\makebox[15mm][c]{\dufe@secretlevel}}\\[2mm]
            学\hspace{2em}号：\dufe@studentid\hspace{5mm}UDC\underline{\makebox[20mm][c]{\dufe@udc}}}
        \end{flushleft}

        \vspace{10mm}

        %% 学校名称（六个艺术字图片，尺寸按Word文档设置，增加间距）
        \includegraphics[width=12.84mm,height=15.36mm]{figures/logo_chars/image1.jpeg}\hspace{5mm}%
        \includegraphics[width=10.62mm,height=11.38mm]{figures/logo_chars/image2.jpeg}\hspace{5mm}%
        \includegraphics[width=11.80mm,height=14.01mm]{figures/logo_chars/image3.jpeg}\hspace{5mm}%
        \includegraphics[width=10.30mm,height=11.41mm]{figures/logo_chars/image4.jpeg}\hspace{5mm}%
        \includegraphics[width=11.13mm,height=12.22mm]{figures/logo_chars/image5.jpeg}\hspace{5mm}%
        \includegraphics[width=10.85mm,height=12.56mm]{figures/logo_chars/image6.jpeg}

        \vspace{7mm}

        %% 论文类型
        {\xiaoer\songti
        \ifdoctor
            博{\kern 0.6em}士{\kern 0.6em}学{\kern 0.6em}位{\kern 0.6em}论{\kern 0.6em}文
        \else
            硕{\kern 0.6em}士{\kern 0.6em}学{\kern 0.6em}位{\kern 0.6em}论{\kern 0.6em}文
        \fi}

        \vspace{10mm}

        %% 论文题目
        {\erhao\heiti\bfseries \dufe@title}

        \vspace{5mm}

        %% 英文题目（Times New Roman 3号加重）
        {\sanhao\bfseries\rmfamily \dufe@entitle}

        \vspace{12mm}

        %% 作者姓名（楷体小2号）
        {\xiaoer\kaishu \dufe@author}

        \vspace{8mm}

        %% 作者信息（带下划线）
        %% 根据论文类型显示不同字段：专硕按学校封面样式显示学科专业和学院
        \ifprofmaster
        \begin{tabular}{@{}r@{\hspace{2mm}}l@{}}
            {\sihao\kaishu 指导教师姓名：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@supervisor\hspace{1em}\dufe@supervisortitle}}} \\[4mm]
            {\sihao\kaishu 学科专业名称：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@proftype}}} \\[4mm]
            {\sihao\kaishu 所在学院名称：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@college}}} \\[3mm]
            {\sihao\kaishu 论文提交日期：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@submitdate}}} \\[3mm]
            {\sihao\kaishu 论文答辩时间：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@defenddate}}} \\
        \end{tabular}
        \else
        \begin{tabular}{@{}r@{\hspace{2mm}}l@{}}
            {\sihao\kaishu 指导教师姓名：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@supervisor\hspace{1em}\dufe@supervisortitle}}} \\[5mm]
            {\sihao\kaishu 一级学科名称：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@major}}} \\[5mm]
            {\sihao\kaishu 二级学科名称：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@submajor}}} \\[5mm]
            {\sihao\kaishu 论文答辩时间：} & {\sihao\kaishu \underline{\makebox[64mm][c]{\dufe@defenddate}}} \\
        \end{tabular}
        \fi

        \vfill

    \end{center}
    \end{titlepage}
    \clearpage
}

%% ========== 原创性声明 ==========
\newcommand{\makedeclaration}{%
    \clearpage
    \pagestyle{empty}

    \begin{center}
        {\xiaosan\heiti\bfseries 东北财经大学研究生学位论文原创性声明}
    \end{center}
    \vspace{6mm}

    {\xiaosi\songti\setlength{\parindent}{2em}
    \noindent 本人郑重声明：此处所提交的\ifdoctor 博士\else 硕士\fi 学位论文《\underline{\hspace{50mm}}》，是本人在导师指导下，在东北财经大学攻读\ifdoctor 博士\else 硕士\fi 学位期间独立进行研究所取得的成果。论文中除已注明的部分外，不包含他人已发表或撰写过的研究成果，对本文的研究工作做出重要贡献的个人和集体均已注明。本声明的法律结果将完全由本人承担。
    }

    \vspace{8mm}

    \hfill\begin{minipage}{0.5\textwidth}
        \xiaosi\songti
        作者签名：\underline{\hspace{40mm}}\\[4mm]
        日\hspace{2em}期：\underline{\hspace{10mm}}年\underline{\hspace{8mm}}月\underline{\hspace{8mm}}日
    \end{minipage}

    \vspace{32mm}

    \begin{center}
        {\xiaosan\heiti\bfseries 东北财经大学研究生学位论文使用授权书}
    \end{center}
    \vspace{6mm}

    {\xiaosi\songti\setlength{\parindent}{2em}
    本论文作者完全了解学校关于保存、使用学位论文的规定，即按照学校要求提交学位论文的印刷本和电子版本；同意学校保留论文的复印件和电子版本，允许论文被查阅和借阅；本人授权东北财经大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，学校可以采用影印、缩印或其他复制手段保存或汇编论文。
    }

    \vspace{8mm}

    \noindent\begin{minipage}[t]{0.48\textwidth}
        \xiaosi\songti
        作者签名：\underline{\hspace{35mm}}\\[4mm]
        日\hspace{2em}期：\underline{\hspace{8mm}}年\underline{\hspace{6mm}}月\underline{\hspace{6mm}}日
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.48\textwidth}
        \xiaosi\songti
        导师签名：\underline{\hspace{35mm}}\\[4mm]
        日\hspace{2em}期：\underline{\hspace{8mm}}年\underline{\hspace{6mm}}月\underline{\hspace{6mm}}日
    \end{minipage}

    \clearpage
}

%% ========== 摘要环境 ==========
%% 中文摘要
\newenvironment{cabstract}{%
    \clearpage
    \thispagestyle{frontmatter}
    \begin{center}
        {\sanhao\heiti 摘\hspace{1em}要}
    \end{center}
    \vspace{20pt}
    \xiaosi\songti
    \setlength{\parindent}{2em}%
    \noindent\hspace*{2em}\ignorespaces
}{%
    \par
}

%% 中文关键词
\newcommand{\ckeywords}[1]{%
    \vspace{20pt}
    \par\noindent
    {\xiaosi\heiti 关键词：}{\xiaosi\songti #1}
}

%% 英文摘要
\newenvironment{eabstract}{%
    \clearpage
    \thispagestyle{frontmatter}
    \begin{center}
        {\sanhao\bfseries ABSTRACT}
    \end{center}
    \vspace{20pt}
    \xiaosi
    \setlength{\parindent}{2em}%
    \emergencystretch=3em % 允许额外拉伸以避免长英文词导致的 overfull
    \noindent\hspace*{2em}\ignorespaces
}{%
    \par
}

%% 英文关键词
\newcommand{\ekeywords}[1]{%
    \vspace{20pt}
    \par\noindent
    \begingroup
    \emergencystretch=3em
    {\xiaosi\bfseries Key Words }{\xiaosi #1}\par
    \endgroup
}

%% ========== 目录格式 ==========
\makeatletter
\renewcommand{\contentsname}{目\hspace{1em}录}
\renewcommand{\listfigurename}{图目录}
\renewcommand{\listtablename}{表目录}

%% 目录标题格式
%% 学校要求：目录两字下空二行为目录内容
\renewcommand{\tableofcontents}{%
    \clearpage
    \thispagestyle{frontmatter}
    \begin{center}
        {\sanhao\heiti 目\hspace{1em}录}
    \end{center}
    \vspace{2\baselineskip}%  % 下空二行
    \begingroup
        \linespread{1.30}\selectfont
        \@starttoc{toc}
    \endgroup
}

%% 目录条目格式
%% 学校要求：一级标题四号宋体，二三级标题小四号宋体
%% 每一级目录后退两个中文字符（2em）
\titlecontents{chapter}[0pt]
    {\sihao\songti}
    {\contentslabel{1.2em}}
    {\hspace*{-1.2em}}
    {\nobreak\leaders\hbox{$\m@th\mkern 1.5mu.\mkern 1.5mu$}\hskip 0pt plus 1filll\thecontentspage}

\titlecontents{section}[2em]
    {\xiaosi\songti}
    {\contentslabel{2.0em}}
    {}
    {\nobreak\leaders\hbox{$\m@th\mkern 1.5mu.\mkern 1.5mu$}\hskip 0pt plus 1filll\thecontentspage}

\titlecontents{subsection}[4em]
    {\xiaosi\songti}
    {\contentslabel{2.8em}}
    {}
    {\nobreak\leaders\hbox{$\m@th\mkern 1.5mu.\mkern 1.5mu$}\hskip 0pt plus 1filll\thecontentspage}

%% ========== 章节标题格式 ==========
%% 按学校要求：一级标题小三号黑体，二级标题四号黑体，三级标题小四号黑体
%% 编号采用国际标准：1, 1.1, 1.1.1
\ctexset{
    chapter = {
        format = {\xiaosan\heiti\raggedright},
        nameformat = {},
        titleformat = {},
        name = {},
        number = \arabic{chapter},
        aftername = \hspace{1em},
        beforeskip = 20pt,
        afterskip = 40pt,
        pagestyle = fancy,
        fixskip = true,
        lofskip = 0pt,
        lotskip = 0pt
    },
    section = {
        format = {\sihao\heiti},
        aftername = \hspace{0.5em},
        beforeskip = 40pt,
        afterskip = 20pt
    },
    subsection = {
        format = {\xiaosi\heiti},
        aftername = \hspace{0.5em},
        beforeskip = 20pt,
        afterskip = 0pt
    },
    subsubsection = {
        format = {\xiaosi\heiti},
        aftername = \hspace{0.5em},
        beforeskip = 0pt,
        afterskip = 0pt
    }
}

%% 设置章节页眉标记
\AtBeginDocument{%
    \renewcommand{\chaptermark}[1]{%
        \dufe@setheadmark{\thechapter\hspace{1em}#1}%
    }%
}

%% ========== 页眉页脚 ==========
\pagestyle{fancy}
\fancyhf{}

%% 章节页眉缓存（避免 mark 失效导致页眉为空）
\def\dufe@headmark{}
\newcommand{\dufe@setheadmark}[1]{%
    \gdef\dufe@headmark{#1}%
    \markboth{#1}{}%
}
\newcommand{\dufe@headshow}{%
    \ifdefempty{\dufe@headmark}%
        {\leftmark}%
        {\dufe@headmark}%
}

%% 页眉：上粗下细文武线
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\headrule}{}

%% 页眉内容：章标题在上，文武线在下
\fancyhead[C]{%
    \begin{minipage}[b]{\headwidth}%
        \centering\wuhao\heiti\dufe@headshow\par\vspace{2pt}%
        \hrule height 1.5pt\relax\vspace{0.5pt}%
        \hrule height 0.4pt\relax%
    \end{minipage}%
}

%% 页脚：页码居中
\fancyfoot[C]{\wuhao\thepage}

%% plain 页面样式（章首页）
\fancypagestyle{plain}{%
    \fancyhf{}
    \fancyhead[C]{%
        \begin{minipage}[b]{\headwidth}%
            \centering\wuhao\heiti\dufe@headshow\par\vspace{2pt}%
            \hrule height 1.5pt\relax\vspace{0.5pt}%
            \hrule height 0.4pt\relax%
        \end{minipage}%
    }
    \fancyfoot[C]{\wuhao\thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
}

%% 前言部分页面样式
\fancypagestyle{frontmatter}{%
    \fancyhf{}
    \fancyfoot[C]{\wuhao\thepage}
    \renewcommand{\headrulewidth}{0pt}
}

%% ========== 图表标题格式 ==========
%% 图表序号按章编排
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}

%% 图表标题格式
%% 表序/图序：五号黑体；表名/图名：五号黑体
%% 学校要求：表/图与上下正文之间各空一行
\DeclareCaptionLabelSeparator{dufequad}{\hspace{2em}}
\captionsetup{
    font = {bf},
    labelfont = {bf},
    textfont = {bf},
    labelsep = dufequad,
    skip = 10pt,
    format = plain
}
%% 表/图上下空行：由 floatsep 与 textfloatsep 控制
\setlength{\floatsep}{16pt plus 2pt minus 2pt}
\setlength{\textfloatsep}{16pt plus 2pt minus 2pt}
\setlength{\intextsep}{16pt plus 2pt minus 2pt}
\DeclareCaptionFont{wuhao}{\wuhao\heiti}
\captionsetup{font=wuhao}

%% 表格标题在上方
\captionsetup[table]{position=top}
%% 图标题在下方
\captionsetup[figure]{position=bottom}

%% 表格正文字体（五号宋体）
\AtBeginEnvironment{table}{\wuhao\songti}
\AtBeginEnvironment{longtable}{\wuhao\songti}

%% 图表编号格式
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}

%% 图表名称
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

%% ========== 公式编号 ==========
\counterwithin{equation}{chapter}
\renewcommand{\theequation}{\thechapter-\arabic{equation}}

%% ========== 脚注格式 ==========
%% 每页重新编号，使用圈码
\renewcommand{\thefootnote}{\textcircled{\scriptsize\arabic{footnote}}}
\@addtoreset{footnote}{page}
\renewcommand{\footnoterule}{%
    \kern-3pt
    \hrule width 0.4\textwidth height 0.4pt
    \kern 2.6pt
}

%% ========== 参考文献格式 ==========
\renewcommand{\bibname}{参考文献}

%% 参考文献环境
\newenvironment{references}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{参考文献}
    \markboth{参考文献}{}%  设置页眉标题
    \begin{center}
        {\xiaosan\heiti 参考文献}
    \end{center}
    \vspace{10pt}
    \xiaosi\kaishu
    % 混合引用格式：正文 APA（作者, 年份），参考文献列表按字母顺序但保留 [N] 编号
    \setlength{\parindent}{0pt}
    \setlength{\baselineskip}{20pt}%  行距20磅
    % 允许 TeX 在参考文献段落里额外拉伸空白，避免 arXiv URL 造成的 overfull
    \emergencystretch=4em
    \tolerance=2000
    \hbadness=10000
    \begin{enumerate}[label={[\arabic*]},leftmargin=2em,itemsep=0pt,parsep=0pt,topsep=0pt]
}{%
    \end{enumerate}
}

%% 英文参考文献字体（Times New Roman 小四）
\newcommand{\enref}{\xiaosi\rmfamily}

%% ========== 附录格式 ==========
\renewcommand{\appendixname}{附录}
\let\dufe@origappendix\appendix
\renewcommand{\appendix}{%
    \dufe@origappendix
    \ctexset{chapter = {format = {\xiaosi\songti}}}
}

%% ========== 后记环境 ==========
\newenvironment{acknowledgements}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{后记}
    \markboth{后记}{}%  设置页眉标题
    \begin{center}
        {\xiaosan\heiti 后\hspace{1em}记}
    \end{center}
    \vspace{40pt}
    \xiaosi\kaishu
    \setlength{\parindent}{2em}
}{%
    \par
}

%% 后记署名
\newcommand{\ackauthor}[2]{%
    \vspace{20pt}
    \begin{flushright}
        \xiaosi\heiti #1\\[5pt]
        {\xiaosi\heiti\rmfamily #2}
    \end{flushright}
}

%% ========== 博士论文科研成果 ==========
\ifdoctor
\newenvironment{publications}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{在学期间发表的科研成果}
    \begin{center}
        {\xiaosan\heiti 在学期间发表的科研成果}
    \end{center}
    \vspace{10pt}
    \xiaosi\songti
    \setlength{\parindent}{0pt}
}{%
    \par
}
\fi

%% ========== 超链接设置 ==========
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
    urlcolor=blue,
    bookmarksnumbered=true,
    bookmarksopen=true,
    pdfstartview=FitH
}

%% ========== 前言和正文命令 ==========
\renewcommand{\frontmatter}{%
    \clearpage
    \@mainmatterfalse
    \pagenumbering{Roman}
    \pagestyle{frontmatter}
    \gdef\dufe@headmark{}%
}

\renewcommand{\mainmatter}{%
    \clearpage
    \@mainmattertrue
    \pagenumbering{arabic}
    %% 重新设置章节标记
    \renewcommand{\chaptermark}[1]{%
        \markboth{\thechapter\hspace{1em}##1}{}%
    }
    %% 重新设置页眉页脚
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[C]{%
        \begin{minipage}[b]{\headwidth}%
            \centering\wuhao\heiti\leftmark\par\vspace{2pt}%
            \hrule height 1.5pt\relax\vspace{0.5pt}%
            \hrule height 0.4pt\relax%
        \end{minipage}%
    }
    \fancyfoot[C]{\wuhao\thepage}
}

\renewcommand{\backmatter}{%
    \clearpage
    \@mainmatterfalse
}

\makeatother

\endinput
