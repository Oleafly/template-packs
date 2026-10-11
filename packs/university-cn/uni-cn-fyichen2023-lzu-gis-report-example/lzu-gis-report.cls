%% lzu-gis-report.cls
%% 兰州大学 GIS 空间分析实习报告模板
%% 作者: fyichen
%% 版本: 1.0
%% 日期: 2026-01-12

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lzu-gis-report}[2026/01/12 v1.0 Lanzhou University GIS Lab Report Template]

% 基于 ctexart 文档类
\LoadClass[a4paper,12pt]{ctexart}

% ==================== 必需的宏包 ====================

% 页面边距设置
\RequirePackage[left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm]{geometry}

% 图形支持
\RequirePackage{graphicx}
\RequirePackage{float}

% 强大的 tcolorbox（核心样式组件）
\RequirePackage[most]{tcolorbox}

% 代码高亮包
\RequirePackage{listings}
\RequirePackage{xcolor}

% 表格相关
\RequirePackage{array}
\RequirePackage{booktabs}

% 数学符号和公式支持
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% 超链接支持
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    filecolor=black,      
    urlcolor=blue,
    citecolor=black,
}

% ==================== 代码样式定义 ====================

\lstdefinestyle{pythonstyle}{
    language=Python,
    basicstyle=\ttfamily\footnotesize,
    keywordstyle=\color{blue}\bfseries,
    commentstyle=\color{gray}\itshape,
    stringstyle=\color{red},
    showstringspaces=false,
    numbers=left,
    numberstyle=\tiny\color{gray},
    stepnumber=1,
    numbersep=8pt,
    backgroundcolor=\color{white},
    frame=single,
    frameround=tttt,
    framesep=5pt,
    breaklines=true,
    breakatwhitespace=true,
    tabsize=4,
    captionpos=b,
    xleftmargin=15pt,
    xrightmargin=5pt
}

\lstset{style=pythonstyle}

% ==================== 核心环境定义：ReportBox ====================

% 定义报告盒子环境，模拟 Word 表格效果
% 参数 #1: 标题（如：实习目的、实习内容等）
\newtcolorbox{ReportBox}[1]{
    enhanced,            % 启用高级绘图引擎
    breakable,           % 允许跨页
    sharp corners,       % 直角，模拟Word表格
    colback=white,       % 背景色
    colframe=black,      % 边框颜色
    boxrule=0.5pt,       % 边框粗细
    coltitle=black,      % 标题颜色
    fonttitle=\bfseries\small, % 标题字体
    attach title to upper, % 标题不单独占一栏
    after title={\par\vspace{0.5em}}, % 标题后换行并留空隙
    title={#1},          % 传入的标题参数
    nobeforeafter,       
    before skip=-0.5pt,  % 向上移动，覆盖上一个盒子的底边
    top=5mm, bottom=5mm, left=5mm, right=5mm, % 内部边距
    parbox=false,
    fontupper=\small,    % 正文字体
    skin first=enhanced,
    skin middle=enhanced,
    skin last=enhanced,
}

% ==================== 文档格式设置 ====================

% 消除段落缩进
\setlength{\parindent}{0pt}

% 行距设置（可选）
\linespread{1.2}

% ==================== 自定义命令 ====================

% 定义实习报告的基本信息命令
\newcommand{\labNumber}[1]{\def\@labNumber{#1}}
\newcommand{\labTitle}[1]{\def\@labTitle{#1}}
\newcommand{\studentName}[1]{\def\@studentName{#1}}
\newcommand{\studentID}[1]{\def\@studentID{#1}}

% 初始化默认值
\labNumber{未设置}
\labTitle{未设置}
\studentName{未设置}
\studentID{未设置}

% 生成标题盒子的命令
\newcommand{\makeReportHeader}{
    \begin{ReportBox}{实习序号和题目}
        \@labNumber\ \@labTitle
    \end{ReportBox}
    
    \begin{ReportBox}{实习人}
        姓名：\@studentName\\ 学号：\@studentID
    \end{ReportBox}
}

% ==================== 其他设置 ====================

% 图表编号格式
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}

% 图表标题格式
\RequirePackage{caption}
\captionsetup{
    font=small,
    labelfont=bf,
    labelsep=space
}

\endinput
