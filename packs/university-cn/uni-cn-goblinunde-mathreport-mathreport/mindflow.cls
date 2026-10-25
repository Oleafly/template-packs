% =========================================================
% MindFlow - 数学与深度学习笔记类 (MindFlow Class)
% 文件名: mindflow.cls
% 版本: v1.0 (2026/01/05)
% 描述: 专为数学(PDE/分析)与深度学习笔记设计的模块化 LaTeX 类文件
% 原型: 基于 hustreport 重构
%
% 📌 模块结构索引 (Module Index):
% [01] 核心选项定义 ....... (Options: Mode, Fonts, Platforms)
% [02] 基类加载 ........... (Base Class: ctexart/book/rep)
% [03] 宏包依赖库 ......... (Packages: Math, Graphics, Tables)
% [04] 字体智能配置 ....... (Fonts: Auto-detect OS & Fonts)
% [05] 页面版式设置 ....... (Geometry: Margins, Headers)
% [06] 章节标题样式 ....... (Headings: Visual Designs)
% [07] 计数器与编号 ....... (Counters: Eq/Fig/Tab numbering)
% [08] 图表浮动体 ......... (Floats: Caption styles)
% [09] 数学定理环境 ....... (Theorems: Color-coded boxes)
% [10] 学科专用宏库 ....... (Macros: PDE operators, DL symbols)
% [11] PDF属性元数据 ...... (Hyperref: Metadata settings)
% [12] 高级图文排版 ....... (Layout: TextFigure, ParallelFigs)
% [13] 代码高亮环境 ....... (Code: Listings, TColorBox)
% [14] 语义化提示框 ....... (Boxes: Notice, Tip, Warning)
% [15] 列表环境优化 ....... (Lists: Itemize, Enumerate)
% [16] 导读与总结 ......... (Structure: Intro/Summary Box)
% [17] 批注系统 ........... (Review: Todo, Fixme, Note)
% [18] 教程演示系统 ....... (Demo: Code/Result visualization)
% [19] 附录与参考文献 ..... (Backmatter: Appendix, Bib)
% [20] 辅助工具 ........... (Utils: Dirtree etc.)
% =========================================================

% ---------------------------------------------------------
% 0. 版本与格式声明
% ---------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mindflow}[2026/01/05 v1.0 MindFlow Math & DL Notes Class]

% [0.1] 警告屏蔽 (Silence Warnings)
\RequirePackage{silence}
\WarningFilter{tocbasic}{Unknown message} % 屏蔽所有 tocbasic 不识别消息
\WarningFilter{siunitx}{Detected} % 屏蔽 siunitx/physics 冲突
\WarningFilter{latex}{Font shape} % 屏蔽 Fandol 字体替换警告

% [0.2] 修复 KOMA-Script 3.49 tocbasic bug
% 💡 tocbasic.sty 第 1376 行在第 1378 行定义前调用消息，这是上游 bug
%    我们先定义消息，然后临时补丁 msg_new 使其忽略重复定义
\ExplSyntaxOn
% 先预定义缺失的消息
\msg_new:nnn { tocbasic } { caption-code-by-class-deactivated }
  { KOMA-Script~3.49~bug~workaround~(MindFlow). }

% 保存原始的 msg_new:nnnn，并创建一个允许重复定义的版本
\cs_set_eq:NN \mf_msg_new_orig:nnnn \msg_new:nnnn
\cs_set:Npn \msg_new:nnnn #1#2#3#4 {
  \msg_if_exist:nnTF {#1} {#2}
    { } % 如果已存在，静默跳过
    { \mf_msg_new_orig:nnnn {#1} {#2} {#3} {#4} }
}
\cs_set_eq:NN \mf_msg_new_orig:nnn \msg_new:nnn  
\cs_set:Npn \msg_new:nnn #1#2#3 {
  \msg_if_exist:nnTF {#1} {#2}
    { } % 如果已存在，静默跳过
    { \mf_msg_new_orig:nnn {#1} {#2} {#3} }
}
\ExplSyntaxOff


% ---------------------------------------------------------
% 1. 核心选项定义
% ---------------------------------------------------------
% [1.1] 系统平台检测开关
\newif\ifmf@oswin    \mf@oswinfalse
\newif\ifmf@osmac    \mf@osmacfalse
\newif\ifmf@oslinux  \mf@oslinuxfalse
\newif\ifmf@optfonts \mf@optfontsfalse

% [1.2] 文档模式开关 (note/book/report)
\newif\ifmf@note     \mf@notetrue   % 💡 默认为 note 模式
\newif\ifmf@book     \mf@bookfalse
\newif\ifmf@report   \mf@reportfalse

% [1.3] 编号模式开关
\newif\ifmf@chapnum  \mf@chapnumfalse % 是否按章节编号

% [1.4] 声明参数选项
\DeclareOption{win}{\mf@oswintrue}
\DeclareOption{mac}{\mf@osmactrue}
\DeclareOption{linux}{\mf@oslinuxtrue}
\DeclareOption{fonts}{\mf@optfontstrue}

% 文档模式选项
\DeclareOption{note}{%
    \mf@notetrue\mf@bookfalse\mf@reportfalse
}
\DeclareOption{book}{%
    \mf@notefalse\mf@booktrue\mf@reportfalse
    \mf@chapnumtrue % book 模式默认按章编号
}
\DeclareOption{report}{%
    \mf@notefalse\mf@bookfalse\mf@reporttrue
    \mf@chapnumtrue % report 模式默认按章编号
}

% 编号模式
\DeclareOption{chapnum}{\mf@chapnumtrue}
\DeclareOption{nochapnum}{\mf@chapnumfalse}

% [1.5] Section 样式选项
% classic: 蓝色编号块+浅蓝背景 (默认)
% modern:  渐变底边线+大号编号
% minimal: 纯文本+左侧竖线
% boxed:   完整边框卡片
% --- 极致美化样式 (v1.1) ---
% neon:      霓虹发光边框 (赛博朋克风)
% terminal:  终端风格 (Hacker 风)
% gradient:  多色渐变背景 (科技感)
% elegant:   金色装饰线 (学术典雅)
% blueprint: 蓝图网格背景 (工程师风)
% ribbon:    折叠丝带效果 (精致卡片)
\def\mf@secstyle{classic}
\DeclareOption{secstyle-classic}{\def\mf@secstyle{classic}}
\DeclareOption{secstyle-modern}{\def\mf@secstyle{modern}}
\DeclareOption{secstyle-minimal}{\def\mf@secstyle{minimal}}
\DeclareOption{secstyle-boxed}{\def\mf@secstyle{boxed}}
\DeclareOption{secstyle-neon}{\def\mf@secstyle{neon}}
\DeclareOption{secstyle-terminal}{\def\mf@secstyle{terminal}}
\DeclareOption{secstyle-gradient}{\def\mf@secstyle{gradient}}
\DeclareOption{secstyle-elegant}{\def\mf@secstyle{elegant}}
\DeclareOption{secstyle-blueprint}{\def\mf@secstyle{blueprint}}
\DeclareOption{secstyle-ribbon}{\def\mf@secstyle{ribbon}}

% [1.6] 审稿模式
\newif\ifmf@review \mf@reviewfalse
\DeclareOption{review}{\mf@reviewtrue}

% 传递未定义选项给底层类
\DeclareOption*{%
    \ifmf@book
        \PassOptionsToClass{\CurrentOption}{ctexbook}%
    \else\ifmf@report
        \PassOptionsToClass{\CurrentOption}{ctexrep}%
    \else
        \PassOptionsToClass{\CurrentOption}{ctexart}%
    \fi\fi
}
\PassOptionsToClass{fontset=fandol}{ctexart}
\PassOptionsToClass{fontset=fandol}{ctexbook}
\PassOptionsToClass{fontset=fandol}{ctexrep}
\ProcessOptions\relax

% ---------------------------------------------------------
% 2. 基类加载 (根据模式选择)
% ---------------------------------------------------------
% [参数说明]
% a4paper: A4纸张
% UTF8: 编码格式
% zihao=-4: 正文默认小四号字
% linespread=1.5: 默认 1.5 倍行距
\ifmf@book
    \LoadClass[a4paper,UTF8,zihao=-4,linespread=1.5]{ctexbook}
    \typeout{>> [MindFlow] Loading book mode (ctexbook)}
\else\ifmf@report
    \LoadClass[a4paper,UTF8,zihao=-4,linespread=1.5]{ctexrep}
    \typeout{>> [MindFlow] Loading report mode (ctexrep)}
\else
    \LoadClass[a4paper,UTF8,zihao=-4,linespread=1.5]{ctexart}
    \typeout{>> [MindFlow] Loading note mode (ctexart)}
\fi\fi


% ---------------------------------------------------------
% 3. 宏包加载 (按功能分类)
% ---------------------------------------------------------

% [3.1] 页面与布局
\RequirePackage{geometry}   % 页面边距设置
\RequirePackage{fancyhdr}   % 页眉页脚定制
\RequirePackage{float}      % 浮动体控制 (H参数)
\RequirePackage[sort&compress,numbers,square]{natbib} % 参考文献管理

% [3.2] 标题与目录
\RequirePackage{titletoc}   % 目录格式定制
\RequirePackage{titlesec}   % 章节标题格式定制

% [3.3] 数学与物理
\RequirePackage{amsmath,amssymb,amsfonts,amsthm} % 数学公式核心包
\RequirePackage{physics}    % 物理符号便捷包
\RequirePackage{siunitx}    % 国际单位制支持
\RequirePackage{newtxmath}  % 数学字体优化
\RequirePackage{calc}       % 长度计算支持
\RequirePackage{bm}         % 粗体数学符号

% [3.4] 图形与颜色
\RequirePackage{graphicx}   % 图片插入
\RequirePackage{subcaption} % 子图支持
\RequirePackage{tikz}       % 绘图与绝对定位
\RequirePackage{tikz-3dplot} % 3D 几何绘图
\RequirePackage[dvipsnames, svgnames, x11names]{xcolor} % 颜色支持

% [3.5] 表格与列表
\RequirePackage{booktabs}   % 三线表支持
\RequirePackage{threeparttable}
\RequirePackage{caption}
\RequirePackage{tabularx}   % 自适应宽度表格
\RequirePackage{xltabular}  % 跨页长表格
\RequirePackage{multirow}   % 表格多行合并
\RequirePackage{makecell}   % 表格单元格换行
\RequirePackage{array}      % 表格列格式扩展
\RequirePackage{enumitem}   % 列表环境定制
\RequirePackage{diagbox}

% [3.6] 字体与修饰
\RequirePackage{anyfontsize} % 任意字号支持

% [3.7] 超链接与PDF属性
\RequirePackage{hyperref}   % 超链接支持

% [3.8] 高级功能
\RequirePackage{xparse}     % 高级参数处理
\RequirePackage[normalem]{ulem} % 下划线支持
\RequirePackage{etoolbox}   % 条件判断 (提供 \ifblank 等)
\RequirePackage{algorithm}  % 算法伪代码环境
\RequirePackage{algpseudocode}
% ---------------------------------------------------------
% 21. 学术功能扩展 (New)
% ---------------------------------------------------------
% [21.1] 审稿模式 (Review Mode)
\ifmf@review
    \RequirePackage{lineno}
    \linenumbers
\fi
% (Note: \ProcessOptions moved to top)

% [21.1.1] 水印系统 (Watermark System)
\RequirePackage[stamp=false]{draftwatermark} % 默认不显示

% 文本水印命令
% 用法: \mfWatermarkText[color][scale]{Content}
% 示例: \mfWatermarkText[red!15][6]{绝密}
\NewDocumentCommand{\mfWatermarkText}{O{gray!25} O{4} m}{%
    \DraftwatermarkOptions{
        stamp=true,
        text={\bfseries #3},
        color=#1,
        scale=#2
    }%
}

% 图片水印命令
% 用法: \mfWatermarkImage{path/to/image}
% 示例: \mfWatermarkImage{figure/logo.png}
\NewDocumentCommand{\mfWatermarkImage}{m}{%
    \DraftwatermarkOptions{
        stamp=true,
        text={\includegraphics{#1}},
        scale=1,
        color=white % 避免文本颜色影响图片
    }%
}

% [21.2] 科学绘图 (PGFPlots)
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}

% 定义 MindFlow 绘图风格
\pgfplotsset{
    mfplot/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        grid=major,
        grid style={dashed,gray!30},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        legend style={
            at={(0.95,0.05)},
            anchor=south east,
            draw=none,
            fill=white,
            fill opacity=0.8,
            font=\small
        },
        cycle list={
            {mf@thm@blue, thick, mark=*},
            {mf@cor@orange, thick, mark=square*},
            {mf@def@green, thick, mark=triangle*},
            {mf@prop@purple, thick, mark=diamond*},
            {red, thick, mark=x},
        }
    },
    % === 深色主题样式 ===
    mfplot-dark/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        axis background/.style={fill=black!90},
        axis line style={white},
        tick style={white},
        tick label style={white},
        label style={white},
        title style={white, font=\bfseries},
        grid=major,
        grid style={gray!40},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        legend style={
            at={(0.95,0.95)},
            anchor=north east,
            fill=black!70,
            text=white,
            font=\small
        },
        cycle list={
            {cyan, thick, mark=*},
            {yellow, thick, mark=square*},
            {magenta, thick, mark=triangle*},
            {green, thick, mark=diamond*},
            {orange, thick, mark=x},
        }
    },
    % === 极简样式 ===
    mfplot-minimal/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        axis lines=left,
        axis line style={->,thick},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        xtick style={draw=none},
        ytick style={draw=none},
        legend style={
            at={(0.5,-0.15)},
            anchor=north,
            draw=none,
            font=\small,
            legend columns=-1
        },
        cycle list={
            {mf@thm@blue, thick},
            {mf@cor@orange, thick, dashed},
            {mf@def@green, thick, dotted},
        }
    },
    % === 柱状图样式 ===
    mfplot-bar/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        ybar,
        bar width=15pt,
        enlarge x limits=0.15,
        ymajorgrids=true,
        grid style={dashed,gray!30},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        legend style={
            at={(0.5,-0.15)},
            anchor=north,
            legend columns=-1,
            draw=none,
            font=\small
        },
        symbolic x coords={A,B,C,D,E},
        xtick=data,
    },
    % === 散点图样式 ===
    mfplot-scatter/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        only marks,
        mark size=2pt,
        grid=major,
        grid style={dashed,gray!20},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        legend style={
            at={(0.95,0.95)},
            anchor=north east,
            draw=none,
            fill=white,
            fill opacity=0.8,
            font=\small
        },
    },
    % === 填充面积图样式 ===
    mfplot-area/.style={
        width=0.8\textwidth,
        height=0.5\textwidth,
        area style,
        stack plots=y,
        grid=major,
        grid style={dashed,gray!20},
        xlabel style={font=\small\bfseries},
        ylabel style={font=\small\bfseries},
        legend style={
            at={(0.5,-0.15)},
            anchor=north,
            legend columns=-1,
            draw=none,
            font=\small
        },
    }
}

% ---------------------------------------------------------
% [21.4] TikZ 绘图样式库 (拓扑图/图论/神经网络/流程图)
% ---------------------------------------------------------
\usetikzlibrary{arrows.meta, positioning, shapes.geometric, shapes.misc, 
                calc, fit, backgrounds, decorations.pathreplacing, 
                decorations.markings, patterns, shadows, matrix, tqft}

% === 通用节点样式 ===
\tikzset{
    % 基础节点
    mf@node/.style={
        draw, 
        thick, 
        minimum size=8mm,
        font=\small
    },
    % 圆形节点 (图论/拓扑)
    mfnode/.style={
        mf@node,
        circle,
        fill=mf@thm@blue!20,
        draw=mf@thm@blue
    },
    % 方形节点
    mfbox/.style={
        mf@node,
        rectangle,
        rounded corners=2pt,
        fill=mf@def@green!15,
        draw=mf@def@green
    },
    % 菱形节点 (判断)
    mfdiamond/.style={
        mf@node,
        diamond,
        aspect=1.5,
        fill=mf@cor@orange!20,
        draw=mf@cor@orange
    },
    % 椭圆节点 (开始/结束)
    mfellipse/.style={
        mf@node,
        ellipse,
        fill=mf@prop@purple!15,
        draw=mf@prop@purple
    },
}

% === 神经网络样式 ===
\tikzset{
    % 神经元节点
    neuron/.style={
        circle,
        draw=mf@thm@blue,
        fill=mf@thm@blue!25,
        minimum size=10mm,
        thick,
        font=\small
    },
    % 输入层节点
    input neuron/.style={
        neuron,
        draw=mf@def@green,
        fill=mf@def@green!25
    },
    % 输出层节点
    output neuron/.style={
        neuron,
        draw=mf@cor@orange,
        fill=mf@cor@orange!25
    },
    % 隐藏层节点
    hidden neuron/.style={
        neuron,
        draw=mf@prop@purple,
        fill=mf@prop@purple!20
    },
    % 神经网络连接线
    nnedge/.style={
        ->,
        >=Stealth,
        thick,
        draw=gray!60
    },
}

% === 图论/拓扑样式 ===
\tikzset{
    % 图论边 (无向)
    graphedge/.style={
        thick,
        draw=mf@thm@blue!70
    },
    % 图论边 (有向)
    dirgraphedge/.style={
        ->,
        >=Stealth,
        thick,
        draw=mf@thm@blue!80
    },
    % 加权边标签
    edgelabel/.style={
        font=\footnotesize,
        fill=white,
        inner sep=1pt
    },
    % 高亮节点
    highlight node/.style={
        fill=mf@cor@orange!40,
        draw=mf@cor@orange,
        line width=2pt
    },
    % 高亮边
    highlight edge/.style={
        draw=red!70,
        line width=2pt
    },
}

% === 流程图样式 ===
\tikzset{
    % 流程图箭头
    flowedge/.style={
        ->,
        >=Stealth,
        thick,
        draw=gray!70
    },
    % 处理框
    process/.style={
        rectangle,
        rounded corners=3pt,
        draw=mf@thm@blue,
        fill=mf@thm@blue!10,
        minimum width=25mm,
        minimum height=10mm,
        font=\small,
        thick
    },
    % 判断框
    decision/.style={
        diamond,
        aspect=2,
        draw=mf@cor@orange,
        fill=mf@cor@orange!10,
        minimum width=20mm,
        minimum height=10mm,
        font=\small,
        thick
    },
    % 开始/结束框
    terminal/.style={
        rounded rectangle,
        draw=mf@prop@purple,
        fill=mf@prop@purple!10,
        minimum width=20mm,
        minimum height=8mm,
        font=\small,
        thick
    },
    % 数据框
    io/.style={
        trapezium,
        trapezium left angle=70,
        trapezium right angle=110,
        draw=mf@def@green,
        fill=mf@def@green!10,
        minimum width=20mm,
        minimum height=8mm,
        font=\small,
        thick
    },
}

% === 状态机样式 ===
\tikzset{
    % 状态节点
    state/.style={
        circle,
        draw=mf@thm@blue,
        fill=mf@thm@blue!15,
        minimum size=12mm,
        thick,
        font=\small
    },
    % 初始状态
    initial state/.style={
        state,
        draw=mf@def@green,
        fill=mf@def@green!15
    },
    % 终止状态
    final state/.style={
        state,
        double,
        double distance=2pt,
        draw=mf@cor@orange,
        fill=mf@cor@orange!15
    },
    % 状态转移边
    transition/.style={
        ->,
        >=Stealth,
        thick,
        draw=gray!70
    },
    % 自环
    loop edge/.style={
        ->,
        >=Stealth,
        thick,
        looseness=5,
        draw=gray!70
    },
}

% === 数学拓扑样式 ===
\tikzset{
    % 拓扑空间背景
    topology space/.style={
        draw=mf@thm@blue!50,
        fill=mf@thm@blue!5,
        rounded corners=5pt,
        dashed
    },
    % 开集
    open set/.style={
        draw=mf@def@green,
        fill=mf@def@green!10,
        thick
    },
    % 闭集
    closed set/.style={
        draw=mf@prop@purple,
        fill=mf@prop@purple!10,
        thick
    },
    % 点
    point/.style={
        circle,
        fill=black,
        inner sep=1.5pt
    },
    % 连续映射箭头
    continuous map/.style={
        ->,
        >=Stealth,
        thick,
        draw=mf@cor@orange,
        decorate,
        decoration={snake, amplitude=0.5mm, segment length=3mm}
    },
}

% ---------------------------------------------------------
% [21.6] 高级拓扑绘图命令 (莫比乌斯带/环面/Klein瓶等)
% ---------------------------------------------------------
\usetikzlibrary{3d, perspective}

% === 莫比乌斯带 (Möbius Strip) ===
% 用法: \mobiusstrip[选项]{x位置}{y位置}{大小}
\newcommand{\mobiusstrip}[4][]{
    \begin{scope}[shift={(#2,#3)}, scale=#4, #1]
        % 外边缘
        \draw[thick, mf@thm@blue] 
            plot[domain=0:360, samples=100, smooth] 
            ({(2+0.5*cos(\x/2))*cos(\x)}, {(2+0.5*cos(\x/2))*sin(\x)}, {0.5*sin(\x/2)});
        % 内边缘 (扭曲)
        \draw[thick, mf@prop@purple, dashed]
            plot[domain=0:360, samples=100, smooth] 
            ({(2-0.5*cos(\x/2))*cos(\x)}, {(2-0.5*cos(\x/2))*sin(\x)}, {-0.5*sin(\x/2)});
        % 中线
        \draw[mf@cor@orange, thick]
            plot[domain=0:360, samples=80, smooth] 
            ({2*cos(\x)}, {2*sin(\x)}, 0);
    \end{scope}
}

% === 环面 (Torus) ===
% 用法: \torus[选项]{x位置}{y位置}{大半径}{小半径}
\newcommand{\torus}[5][]{
    \begin{scope}[shift={(#2,#3)}, #1]
        % 外轮廓
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!10] 
            (0,0) ellipse ({#4+#5} and {(#4+#5)*0.4});
        % 内孔
        \draw[thick, mf@thm@blue, fill=white] 
            (0,0) ellipse ({#4-#5} and {(#4-#5)*0.4});
        % 顶部边缘
        \draw[thick, mf@prop@purple]
            ({-#4},0) arc (180:360:{#4} and {#4*0.4});
        % 经线示意
        \draw[mf@cor@orange, dashed] 
            ({#4},0) arc (0:180:{#5} and {#5*0.6});
        \draw[mf@cor@orange] 
            ({#4},0) arc (0:-180:{#5} and {#5*0.6});
    \end{scope}
}

% === 球面 (Sphere) ===
\newcommand{\sphere}[4][]{
    \begin{scope}[shift={(#2,#3)}, #1]
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!10] (0,0) circle (#4);
        % 赤道
        \draw[mf@cor@orange] (0,0) ellipse ({#4} and {#4*0.3});
        % 经线
        \draw[mf@prop@purple, dashed] (0,{-#4}) arc (-90:90:{#4*0.3} and {#4});
        \draw[mf@prop@purple] (0,{-#4}) arc (270:90:{#4*0.3} and {#4});
    \end{scope}
}

% === 圆柱面 (Cylinder) ===
\newcommand{\cylinder}[5][]{
    \begin{scope}[shift={(#2,#3)}, #1]
        % 侧面
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!8] 
            ({-#4},0) -- ({-#4},{#5}) 
            arc (180:360:{#4} and {#4*0.3}) 
            -- ({#4},0) arc (0:180:{#4} and {#4*0.3});
        % 顶面
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!15] 
            (0,{#5}) ellipse ({#4} and {#4*0.3});
        % 底面虚线
        \draw[dashed, mf@thm@blue] 
            ({-#4},0) arc (180:0:{#4} and {#4*0.3});
    \end{scope}
}

% === Klein 瓶 (简化平面表示) ===
\newcommand{\kleinbottle}[4][]{
    \begin{scope}[shift={(#2,#3)}, scale=#4, #1]
        % 主体轮廓
        \draw[thick, mf@thm@blue] 
            (-1.5,-1) .. controls (-2,0) and (-2,1) .. (-1.5,1.5)
            .. controls (-1,2) and (0,2) .. (0.5,1.5)
            .. controls (1,1) and (1,0.5) .. (0.8,0)
            .. controls (0.6,-0.5) and (0,-0.8) .. (-0.5,-0.5)
            .. controls (-0.8,-0.3) and (-0.8,0.3) .. (-0.5,0.5)
            .. controls (0,0.8) and (0.5,0.5) .. (0.5,0)
            .. controls (0.5,-0.5) and (0,-1) .. (-0.5,-1)
            .. controls (-1,-1) and (-1.5,-1) .. (-1.5,-1);
        % 自交叉标记
        \draw[mf@cor@orange, thick, dashed] 
            (-0.5,-0.5) .. controls (-0.2,-0.2) .. (0.2,0.2);
        % 箭头指示
        \draw[->, >=Stealth, mf@prop@purple, thick] 
            (-1.5,0) -- (-1.5,0.8);
        \draw[->, >=Stealth, mf@prop@purple, thick] 
            (0.8,-0.5) -- (0.8,0.3);
    \end{scope}
}

% === 环 (Circle/Loop) ===
\newcommand{\topologyloop}[4][]{
    \begin{scope}[shift={(#2,#3)}, #1]
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!10] (0,0) circle (#4);
        \node[point] at (0,{#4}) {};
        \node[above] at (0,{#4}) {\small 基点};
    \end{scope}
}

% === 基本群示意 (八字形) ===
\newcommand{\bouquet}[4][]{
    \begin{scope}[shift={(#2,#3)}, scale=#4, #1]
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!10] (-0.8,0) circle (0.8);
        \draw[thick, mf@prop@purple, fill=mf@prop@purple!10] (0.8,0) circle (0.8);
        \node[point] at (0,0) {};
        \node[below] at (0,-0.2) {\small $\ast$};
        % 生成元标记
        \node at (-0.8,0) {$a$};
        \node at (0.8,0) {$b$};
    \end{scope}
}

% === 同伦等价箭头 ===
\tikzset{
    homotopy arrow/.style={
        <->,
        >=Stealth,
        thick,
        draw=mf@def@green,
        decorate,
        decoration={snake, amplitude=0.8mm, segment length=4mm, post length=2mm, pre length=2mm}
    },
}

% === 纤维丛示意 ===
\newcommand{\fiberbundle}[5][]{
    \begin{scope}[shift={(#2,#3)}, #1]
        % 底空间 B
        \draw[thick, mf@thm@blue, fill=mf@thm@blue!10] 
            (0,0) ellipse ({#4} and {#4*0.3});
        \node[below] at (0,{-#4*0.3-0.3}) {$B$};
        % 纤维 F
        \foreach \x in {-0.6,-0.2,0.2,0.6} {
            \draw[mf@prop@purple, thick] 
                ({\x*#4},0) -- ({\x*#4},{#5});
        }
        % 总空间 E
        \draw[thick, mf@cor@orange, dashed] 
            ({-#4},{#5}) -- ({#4},{#5});
        \node[above] at (0,{#5}) {$E$};
        % 投影箭头
        \draw[->, >=Stealth, thick] 
            ({#4+0.5},{#5*0.5}) -- ({#4+0.5},0.1) node[midway, right] {$\pi$};
    \end{scope}
}

% ---------------------------------------------------------
% [21.7] 交换图样式 (代数拓扑/范畴论)
% ---------------------------------------------------------
\tikzset{
    % 交换图箭头
    cd arrow/.style={
        ->,
        >=Stealth,
        thick
    },
    % 单射
    cd mono/.style={
        cd arrow,
        >={Hooks[right]}
    },
    % 满射
    cd epi/.style={
        cd arrow,
        ->>
    },
    % 同构
    cd iso/.style={
        cd arrow,
        <->
    },
    % 虚线箭头 (存在性)
    cd exists/.style={
        cd arrow,
        dashed
    },
    % 交换图节点
    cd node/.style={
        font=\normalsize,
        inner sep=3pt
    },
}

% ---------------------------------------------------------
% [21.8] 向量场与微分几何样式
% ---------------------------------------------------------
\tikzset{
    % 向量箭头
    vector/.style={
        ->,
        >=Stealth,
        thick,
        draw=mf@thm@blue
    },
    % 切向量
    tangent vector/.style={
        vector,
        draw=mf@cor@orange
    },
    % 法向量
    normal vector/.style={
        vector,
        draw=mf@prop@purple
    },
    % 流线
    streamline/.style={
        thick,
        draw=mf@def@green,
        decoration={markings, mark=at position 0.5 with {\arrow{>}}},
        postaction={decorate}
    },
}

% === 向量场绘制命令 ===
% 用法: \vectorfield{x起点}{y起点}{行数}{列数}{缩放}
\newcommand{\vectorfield}[5]{
    \foreach \i in {0,...,#3} {
        \foreach \j in {0,...,#4} {
            \pgfmathsetmacro{\vx}{0.3*cos(\i*30+\j*20)}
            \pgfmathsetmacro{\vy}{0.3*sin(\i*20+\j*30)}
            \draw[vector, scale=#5] 
                ({#1+\i*0.8},{#2+\j*0.8}) -- ++(\vx,\vy);
        }
    }
}

% ---------------------------------------------------------
% [21.9] 科学绘图辅助工具
% ---------------------------------------------------------

% === 坐标系绘制 ===
\newcommand{\drawaxes}[4][]{
    \draw[->, >=Stealth, thick, #1] (#2,0) -- (#3,0) node[right] {$x$};
    \draw[->, >=Stealth, thick, #1] (0,#2) -- (0,#4) node[above] {$y$};
}

% === 3D 坐标系 ===
\newcommand{\drawaxesthree}[2][]{
    \draw[->, >=Stealth, thick, #1] (0,0,0) -- (#2,0,0) node[right] {$x$};
    \draw[->, >=Stealth, thick, #1] (0,0,0) -- (0,#2,0) node[above] {$y$};
    \draw[->, >=Stealth, thick, #1] (0,0,0) -- (0,0,#2) node[below left] {$z$};
}

% === 网格绘制 ===
\newcommand{\drawgrid}[5][gray!30]{
    \draw[step=#5, #1, thin] (#2,#3) grid (#4-0.01,#4-0.01);
}

% === 函数曲线样式 ===
\tikzset{
    function curve/.style={
        thick,
        draw=mf@thm@blue,
        smooth,
        samples=100
    },
    parametric curve/.style={
        thick,
        draw=mf@prop@purple,
        smooth,
        samples=100
    },
}

% === 区域填充样式 ===
\tikzset{
    region fill/.style={
        fill=mf@thm@blue!15,
        draw=mf@thm@blue,
        thick
    },
    integral region/.style={
        pattern=north east lines,
        pattern color=mf@cor@orange!50
    },
}

% === 等高线样式 ===
\tikzset{
    contour/.style={
        draw=mf@def@green,
        thick
    },
    level set/.style={
        contour,
        dashed
    },
}

% === 奇点标记 ===
\tikzset{
    singularity/.style={
        circle,
        fill=red,
        inner sep=2pt
    },
    saddle point/.style={
        diamond,
        fill=mf@cor@orange,
        inner sep=2pt
    },
    source/.style={
        circle,
        draw=mf@def@green,
        fill=mf@def@green!30,
        inner sep=2pt
    },
    sink/.style={
        circle,
        draw=mf@prop@purple,
        fill=mf@prop@purple!30,
        inner sep=2pt
    },
}

% === 测地线样式 ===
\tikzset{
    geodesic/.style={
        thick,
        draw=mf@cor@orange,
        decoration={markings, mark=at position 0.3 with {\arrow{>}}, mark=at position 0.7 with {\arrow{>}}},
        postaction={decorate}
    },
}

% ---------------------------------------------------------
% [21.10] 古卷轴 (Papyrus) 装饰环境
% ---------------------------------------------------------
% 💡 创建类似古老羊皮纸卷轴效果的文本框

\pgfdeclarelayer{mf@papyrus@bg}
\pgfsetlayers{mf@papyrus@bg,main}

\tikzset{
    papyrus line/.style={ line width=1pt, draw=mf@ex@brown }
}

% 内部命令: 绘制卷轴边缘
\def\mf@drawRole#1#2#3{%
    \begin{scope}[yscale=#2,scale=0.6*#3]
        \draw[papyrus line] (A.#1 west) .. controls +(0,1) and +(0,1) .. +(-1,0) 
            .. controls +(0,-1) and +(0,-1) .. +(-.2,0) 
            .. controls +(0,.7) and +(0,.7) .. +(-.8,0) 
            .. controls +(0,-.5) and +(0,-.5) .. +(-.5,0) -- +(-.2,0);
        \draw[papyrus line] (A.#1 west) +(-.6,-.75) -- +(0,-.75);
        \draw[papyrus line] (A.#1 west) +(-.65,-.375) -- +(-.25,-.375);
        \draw[papyrus line] (A.#1 east) .. controls +(0,.7) and +(.4,0) .. +(-.5,0.751) 
            -- ($(A.#1 west)+(-.5,.751)$);
    \end{scope}
}

% 用法: \papyrus[缩放]{内容}
\newcommand\papyrus[2][1]{%
    \tikz{
        \node[inner xsep=1em, inner ysep=0.5em] (A) {#2};
        \begin{pgfonlayer}{mf@papyrus@bg}
            \mf@drawRole{north}{1}{#1}
            \mf@drawRole{south}{-1}{#1}
            \draw[papyrus line] (A.north east) -- (A.south east);
            \draw[papyrus line] (A.south west) -- (A.north west);
        \end{pgfonlayer}
    }
}

% papyrus 环境版本
\newenvironment{papyrusbox}[1][1]{%
    \begin{center}
    \papyrus[#1]\bgroup
}{%
    \egroup
    \end{center}
}

% ---------------------------------------------------------
% [21.11] 公式注释/解读系统 (Formula Annotation)
% ---------------------------------------------------------
% 💡 用于给数学公式添加带箭头的解释说明

\tikzset{
    % 公式注释框样式
    formula box/.style={
        rectangle,
        draw=mf@thm@blue,
        fill=mf@thm@blue!10,
        rounded corners=3pt,
        minimum height=2em,
        text centered,
        thick,
        font=\small
    },
    % 公式主框 (突出显示)
    formula main/.style={
        rectangle,
        draw=mf@cor@orange,
        fill=mf@cor@orange!10,
        rounded corners=3pt,
        minimum height=2.5em,
        text centered,
        thick,
        font=\normalsize
    },
    % 公式说明框 
    formula note/.style={
        rectangle,
        draw=mf@def@green,
        fill=mf@def@green!8,
        rounded corners=2pt,
        minimum height=1.5em,
        text centered,
        font=\footnotesize,
        thick
    },
    % 公式项高亮
    formula term/.style={
        rectangle,
        draw=#1,
        fill=#1!20,
        rounded corners=3pt,
        minimum height=2em,
        inner sep=0.5em,
        thick,
        font=\large
    },
    formula term/.default=mf@thm@blue,
    % 注释箭头
    formula arrow/.style={
        draw,
        -Stealth,
        thick,
        #1
    },
    formula arrow/.default=gray!70,
    % 虚线注释箭头
    formula arrow dashed/.style={
        draw,
        -Stealth,
        thick,
        dashed,
        #1
    },
    formula arrow dashed/.default=gray!50,
}

% === 公式流程图样式 (Kohn-Sham 风格) ===
\tikzset{
    % 流程步骤框
    ks box/.style={
        rectangle,
        draw=gray!50,
        fill=DarkGray!20,
        rounded corners=3pt,
        minimum height=2em,
        text width=15em,
        text centered,
        thick
    },
    % 输入框 
    ks input/.style={
        ks box,
        fill=orange!20,
        text width=18em
    },
    % 输出框
    ks output/.style={
        ks box,
        fill=blue!20,
        text width=18em
    },
    % 判断框
    ks decision/.style={
        ks box,
        fill=yellow!20
    },
    % 循环标记
    ks loop/.style={
        rectangle,
        draw=gray!60,
        dashed,
        inner sep=1em,
        rounded corners=5pt
    },
    % 流程箭头
    ks arrow/.style={
        draw,
        -Stealth,
        thick
    },
}

% === 公式组件解释图 (多项式分解风格) ===
\tikzset{
    % 公式组件框 (可自定义颜色)
    eq part/.style={
        rectangle,
        draw,
        fill=#1!30,
        rounded corners=3pt,
        minimum height=3em,
        inner sep=0.5em,
        thick,
        font=\Large
    },
    eq part/.default=gray,
    % 运算符
    eq operator/.style={
        font=\Huge,
        inner sep=0.3em
    },
    % 说明标签
    eq label/.style={
        align=left,
        font=\normalsize,
        text width=12em
    },
    % 说明箭头
    eq arrow/.style={
        draw,
        -Stealth,
        ultra thick,
        #1
    },
    eq arrow/.default=gray!70,
}

% === 快捷命令 ===

% 创建带注释的公式项
% 用法: \eqitem[颜色]{公式}{标签位置}{说明文字}
\newcommand{\eqitem}[4][mf@thm@blue]{%
    \node[eq part=#1] (#2-box) {$#2$};
    \node[eq label, #3=of #2-box] (#2-label) {#4};
    \draw[eq arrow] (#2-label) -- (#2-box);
}

% 公式解读环境
% 用法: \begin{formulaexplain}[node distance] ... \end{formulaexplain}
\newenvironment{formulaexplain}[1][1.5cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% 公式流程图环境
\newenvironment{formulaflow}[1][0.5cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.13] 计算机科学可视化样式 (CS Visualization)
% ---------------------------------------------------------
% 💡 层次结构图/Hasse图/类继承图/蝴蝶网络/数据结构

\usetikzlibrary{shapes.multipart, shadows.blur}

% === 配色定义 ===
\definecolor{cs@blue}{RGB}{70,130,180}
\definecolor{cs@green}{RGB}{60,179,113}
\definecolor{cs@orange}{RGB}{255,140,0}
\definecolor{cs@purple}{RGB}{147,112,219}
\definecolor{cs@red}{RGB}{220,80,80}
\definecolor{cs@gray}{RGB}{128,128,128}

% === 层次结构图/Hasse图样式 ===
\tikzset{
    % 层次结构节点 (带阴影)
    hasse node/.style={
        thick,
        draw=cs@blue!80!black,
        fill=cs@blue!15,
        rounded corners=2pt,
        blur shadow={shadow blur steps=20, shadow xshift=1pt, shadow yshift=-1pt},
        minimum width=2cm,
        minimum height=0.8cm,
        font=\small,
        align=center
    },
    % 抽象类节点
    abstract node/.style={
        hasse node,
        draw=cs@purple!80!black,
        fill=cs@purple!15,
        font=\small\itshape
    },
    % 接口节点
    interface node/.style={
        hasse node,
        draw=cs@green!80!black,
        fill=cs@green!15,
        dashed
    },
    % 具体类节点
    concrete node/.style={
        hasse node,
        draw=cs@blue!80!black,
        fill=cs@blue!20
    },
    % 层次连接线
    hasse edge/.style={
        thick,
        draw=cs@gray
    },
    % 继承箭头
    inherit arrow/.style={
        ->,
        >=Stealth,
        thick,
        draw=cs@gray
    },
    % 实现箭头 (虚线)
    implement arrow/.style={
        ->,
        >=Stealth,
        thick,
        dashed,
        draw=cs@green!70!black
    },
}

% === UML 类图样式 ===
\tikzset{
    % UML 类框
    uml class/.style={
        rectangle split,
        rectangle split parts=3,
        draw=cs@blue!80!black,
        fill=white,
        thick,
        font=\small,
        align=left,
        minimum width=3cm
    },
    % UML 抽象类
    uml abstract/.style={
        uml class,
        draw=cs@purple!80!black,
        rectangle split part fill={cs@purple!20, white, white}
    },
    % UML 接口
    uml interface/.style={
        uml class,
        draw=cs@green!80!black,
        dashed,
        rectangle split part fill={cs@green!15, white, white}
    },
    % 聚合关系
    aggregation/.style={
        ->,
        >=Diamond[open],
        thick
    },
    % 组合关系
    composition/.style={
        ->,
        >=Diamond[fill=black],
        thick
    },
    % 依赖关系
    dependency/.style={
        ->,
        >=Stealth,
        dashed,
        thick
    },
}

% === 蝴蝶网络/数据流图样式 ===
\tikzset{
    % 数据节点 (蝴蝶网络)
    bf node/.style={
        rectangle,
        draw=cs@blue!80!black,
        fill=cs@blue!10,
        minimum width=1.5cm,
        minimum height=0.5cm,
        font=\footnotesize,
        align=center
    },
    % 蝴蝶操作节点 (交叉点)
    bf op/.style={
        circle,
        draw=cs@orange!80!black,
        fill=cs@orange!30,
        inner sep=2pt,
        font=\tiny
    },
    % 数据流边
    bf edge/.style={
        thick,
        draw=cs@gray!70
    },
    % 交叉数据流
    bf cross/.style={
        thick,
        draw=cs@red!70
    },
    % 阶段分割线
    stage line/.style={
        dashed,
        draw=cs@gray!50
    },
}

% === 数据结构可视化样式 ===
\tikzset{
    % 数组单元格
    array cell/.style={
        rectangle,
        draw=cs@blue!80!black,
        fill=cs@blue!10,
        minimum width=1cm,
        minimum height=0.8cm,
        font=\small,
        anchor=west
    },
    % 数组索引标签
    array index/.style={
        font=\tiny,
        text=cs@gray
    },
    % 链表节点
    list node/.style={
        rectangle split,
        rectangle split parts=2,
        rectangle split horizontal,
        draw=cs@green!80!black,
        fill=cs@green!10,
        minimum height=0.8cm,
        font=\small
    },
    % 链表指针
    list pointer/.style={
        ->,
        >=Stealth,
        thick,
        draw=cs@gray
    },
    % 二叉树节点
    tree node/.style={
        circle,
        draw=cs@purple!80!black,
        fill=cs@purple!15,
        minimum size=0.8cm,
        font=\small
    },
    % 树边
    tree edge/.style={
        thick,
        draw=cs@gray
    },
    % 空节点 (NULL)
    null node/.style={
        rectangle,
        draw=cs@gray,
        fill=cs@gray!20,
        minimum width=0.5cm,
        minimum height=0.3cm,
        font=\tiny
    },
    % 堆栈单元
    stack cell/.style={
        rectangle,
        draw=cs@orange!80!black,
        fill=cs@orange!15,
        minimum width=2cm,
        minimum height=0.6cm,
        font=\small
    },
    % 堆栈指针
    stack pointer/.style={
        ->,
        >=Stealth,
        very thick,
        draw=cs@red
    },
}

% === 内存/寄存器图样式 ===
\tikzset{
    % 内存块
    memory block/.style={
        rectangle,
        draw=cs@blue!80!black,
        fill=cs@blue!8,
        minimum width=3cm,
        minimum height=0.6cm,
        font=\footnotesize\ttfamily,
        anchor=north
    },
    % 地址标签
    address label/.style={
        font=\tiny\ttfamily,
        text=cs@gray,
        anchor=east
    },
    % 寄存器
    register/.style={
        rectangle,
        draw=cs@orange!80!black,
        fill=cs@orange!15,
        minimum width=2cm,
        minimum height=0.5cm,
        font=\small\ttfamily
    },
    % 位域
    bitfield/.style={
        rectangle split,
        rectangle split parts=8,
        rectangle split horizontal,
        draw=cs@purple!80!black,
        fill=cs@purple!10,
        font=\tiny\ttfamily
    },
}

% === 有限状态机增强样式 ===
\tikzset{
    % 状态 (圆角矩形)
    fsm state/.style={
        rectangle,
        rounded corners=5pt,
        draw=cs@blue!80!black,
        fill=cs@blue!15,
        minimum width=1.5cm,
        minimum height=0.8cm,
        font=\small,
        thick
    },
    % 初始状态
    fsm initial/.style={
        fsm state,
        draw=cs@green!80!black,
        fill=cs@green!15
    },
    % 终止状态
    fsm final/.style={
        fsm state,
        double,
        double distance=2pt,
        draw=cs@red!80!black,
        fill=cs@red!10
    },
    % 状态转移
    fsm trans/.style={
        ->,
        >=Stealth,
        thick,
        draw=cs@gray
    },
    % 转移标签
    fsm label/.style={
        font=\footnotesize,
        fill=white,
        inner sep=1pt
    },
}

% === 快捷绘图命令 ===

% 绘制数组
% 用法: \drawarray{起始x}{起始y}{元素列表}
\newcommand{\drawarray}[3]{%
    \foreach \elem [count=\i from 0] in {#3} {
        \node[array cell] at ({#1+\i*1cm}, #2) {\elem};
        \node[array index] at ({#1+\i*1cm+0.5cm}, {#2-0.6cm}) {\i};
    }
}

% 绘制栈
% 用法: \drawstack{x}{y}{元素列表}
\newcommand{\drawstack}[3]{%
    \foreach \elem [count=\i from 0] in {#3} {
        \node[stack cell] at (#1, {#2+\i*0.7cm}) {\elem};
    }
    \draw[stack pointer] ({#1-1.5cm}, {#2+0.3cm}) -- ({#1-0.2cm}, {#2+0.3cm}) node[midway, above] {\tiny SP};
}

% 层次结构环境
\newenvironment{hassediagram}[1][2cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% 蝴蝶网络环境
\newenvironment{butterflynet}[1][2cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, line cap=round]
}{%
    \end{tikzpicture}
    \end{center}
}

% 数据结构环境
\newenvironment{datastructure}[1][1cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.15] 化学与物理可视化样式 (Chemistry & Physics)
% ---------------------------------------------------------
% 💡 元素周期表/粒子物理标准模型/分子结构/能级图

% === 元素周期表配色 ===
\definecolor{chem@alkali}{RGB}{255,102,102}       % 碱金属
\definecolor{chem@alkaline}{RGB}{255,222,173}     % 碱土金属
\definecolor{chem@transition}{RGB}{255,192,203}   % 过渡金属
\definecolor{chem@metal}{RGB}{204,204,255}        % 其他金属
\definecolor{chem@metalloid}{RGB}{204,255,204}    % 类金属
\definecolor{chem@nonmetal}{RGB}{160,255,160}     % 非金属
\definecolor{chem@halogen}{RGB}{255,255,153}      % 卤素
\definecolor{chem@noble}{RGB}{192,255,255}        % 稀有气体
\definecolor{chem@lanthanide}{RGB}{255,191,255}   % 镧系
\definecolor{chem@actinide}{RGB}{255,153,204}     % 锕系

% === 粒子物理配色 ===
\definecolor{phys@quark}{RGB}{170,130,255}        % 夸克
\definecolor{phys@lepton}{RGB}{130,200,130}       % 轻子
\definecolor{phys@gauge}{RGB}{255,120,120}        % 规范玻色子
\definecolor{phys@scalar}{RGB}{255,200,100}       % 标量玻色子

% === 元素周期表样式 ===
\tikzset{
    % 基础元素框
    element/.style={
        rectangle,
        draw=black!70,
        thick,
        minimum width=2cm,
        minimum height=2cm,
        font=\sffamily,
        align=center
    },
    % 碱金属
    alkali metal/.style={
        element,
        fill=chem@alkali!60
    },
    % 碱土金属
    alkaline earth/.style={
        element,
        fill=chem@alkaline!70
    },
    % 过渡金属
    transition metal/.style={
        element,
        fill=chem@transition!60
    },
    % 其他金属
    post-transition/.style={
        element,
        fill=chem@metal!60
    },
    % 类金属
    metalloid/.style={
        element,
        fill=chem@metalloid!70
    },
    % 非金属
    nonmetal/.style={
        element,
        fill=chem@nonmetal!70
    },
    % 卤素
    halogen/.style={
        element,
        fill=chem@halogen!80
    },
    % 稀有气体
    noble gas/.style={
        element,
        fill=chem@noble!70
    },
    % 镧系
    lanthanide/.style={
        element,
        fill=chem@lanthanide!60
    },
    % 锕系
    actinide/.style={
        element,
        fill=chem@actinide!60
    },
}

% === 粒子物理标准模型样式 ===
\tikzset{
    % 粒子基础框
    particle box/.style={
        rectangle,
        draw=black!50,
        thick,
        rounded corners=3pt,
        minimum width=1.8cm,
        minimum height=1.8cm,
        font=\sffamily,
        align=center,
        drop shadow={shadow xshift=1pt, shadow yshift=-1pt, opacity=0.3}
    },
    % 夸克
    quark/.style={
        particle box,
        top color=phys@quark!40,
        bottom color=phys@quark!70
    },
    % 轻子
    lepton/.style={
        particle box,
        top color=phys@lepton!40,
        bottom color=phys@lepton!70
    },
    % 规范玻色子
    gauge boson/.style={
        particle box,
        top color=phys@gauge!40,
        bottom color=phys@gauge!70
    },
    % 标量玻色子 (Higgs)
    scalar boson/.style={
        particle box,
        top color=phys@scalar!50,
        bottom color=phys@scalar!80
    },
    % 粒子分组框
    particle group/.style={
        draw=black!30,
        fill=black!5,
        rounded corners=5pt,
        inner sep=0.5em
    },
}

% === 分子结构样式 ===
\tikzset{
    % 原子节点
    atom/.style={
        circle,
        draw=black!70,
        thick,
        minimum size=1cm,
        font=\sffamily\bfseries,
        align=center
    },
    % 碳原子
    carbon/.style={
        atom,
        fill=black!20
    },
    % 氢原子
    hydrogen/.style={
        atom,
        fill=white,
        minimum size=0.6cm
    },
    % 氧原子
    oxygen/.style={
        atom,
        fill=red!30
    },
    % 氮原子
    nitrogen/.style={
        atom,
        fill=blue!30
    },
    % 硫原子
    sulfur/.style={
        atom,
        fill=yellow!50
    },
    % 磷原子
    phosphorus/.style={
        atom,
        fill=orange!40
    },
    % 单键
    single bond/.style={
        thick,
        draw=black!70
    },
    % 双键
    double bond/.style={
        thick,
        draw=black!70,
        double,
        double distance=2pt
    },
    % 三键
    triple bond/.style={
        thick,
        draw=black!70,
        double,
        double distance=3pt,
        postaction={draw=black!70, thick}
    },
    % 虚键 (氢键等)
    dashed bond/.style={
        thick,
        dashed,
        draw=black!50
    },
    % 楔形键 (立体化学)
    wedge bond/.style={
        -Triangle[length=8pt, width=6pt],
        thick,
        draw=black!70,
        fill=black!70
    },
    % 虚楔形键
    hashed bond/.style={
        thick,
        draw=black!70,
        decorate,
        decoration={ticks, segment length=2pt, amplitude=3pt}
    },
}

% === 能级图样式 ===
\tikzset{
    % 能级线
    energy level/.style={
        thick,
        draw=cs@blue!80!black
    },
    % 基态
    ground state/.style={
        energy level,
        draw=cs@green!80!black
    },
    % 激发态
    excited state/.style={
        energy level,
        draw=cs@red!80!black
    },
    % 能级跃迁箭头
    transition arrow/.style={
        ->,
        >=Stealth,
        thick,
        draw=cs@orange,
        decorate,
        decoration={snake, amplitude=1mm, segment length=3mm, post length=2mm}
    },
    % 能级标签
    energy label/.style={
        font=\small,
        anchor=west
    },
}

% === 化学反应图样式 ===
\tikzset{
    % 反应物/产物框
    reactant/.style={
        rectangle,
        draw=cs@blue!70,
        fill=cs@blue!10,
        rounded corners=3pt,
        minimum height=1.5em,
        inner sep=0.5em,
        font=\large
    },
    product/.style={
        rectangle,
        draw=cs@green!70,
        fill=cs@green!10,
        rounded corners=3pt,
        minimum height=1.5em,
        inner sep=0.5em,
        font=\large
    },
    % 反应箭头
    reaction arrow/.style={
        ->,
        >=Stealth,
        very thick,
        draw=black!70
    },
    % 可逆反应箭头
    reversible arrow/.style={
        <->,
        >=Stealth,
        very thick,
        draw=black!70
    },
    % 催化剂标签
    catalyst/.style={
        font=\footnotesize,
        above,
        text=cs@orange!80!black
    },
    % 反应条件标签
    condition/.style={
        font=\footnotesize,
        below,
        text=cs@gray
    },
}

% === 快捷命令 ===

% 绘制元素
% 用法: \drawelement[样式]{符号}{原子序数}{名称}{相对原子质量}
\newcommand{\drawelement}[5][element]{%
    \node[#1] {%
        \begin{minipage}{1.8cm}
            \centering
            {\footnotesize #3} \hfill {\footnotesize #5}\\[2pt]
            {\Huge\bfseries #2}\\[2pt]
            {\small #4}
        \end{minipage}
    }
}

% 绘制粒子
% 用法: \drawparticle[样式]{符号}{名称}{质量}{电荷}{自旋}
\newcommand{\drawparticle}[6][particle box]{%
    \node[#1] {%
        \begin{minipage}{1.5cm}
            \centering
            {\tiny #4}\\[-2pt]
            {\Large\bfseries #2}\\[-2pt]
            {\scriptsize #3}\\[-3pt]
            {\tiny Q=#5, S=#6}
        \end{minipage}
    }
}

% 元素周期表环境
\newenvironment{periodictable}[1][0.4]{%
    \begin{center}
    \begin{tikzpicture}[scale=#1, every node/.style={transform shape}]
}{%
    \end{tikzpicture}
    \end{center}
}

% 分子结构环境
\newenvironment{molecule}[1][1cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% 能级图环境
\newenvironment{energydiagram}[1][1cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.17] 高级数学流程图样式 (Advanced Math Flowcharts)
% ---------------------------------------------------------
% 💡 DMFT循环图/科学计算流程/研究工作流

% === 配色定义 ===
\definecolor{flow@blue}{RGB}{70,130,180}
\definecolor{flow@green}{RGB}{60,179,113}
\definecolor{flow@red}{RGB}{220,80,80}
\definecolor{flow@purple}{RGB}{147,112,219}
\definecolor{flow@orange}{RGB}{255,140,0}
\definecolor{flow@cyan}{RGB}{0,180,180}

% === DMFT 风格分组框样式 ===
\tikzset{
    % 基础分组框
    basic box/.style={
        shape=rectangle,
        rounded corners=8pt,
        align=center,
        draw=#1!80!black,
        fill=#1!20,
        thick,
        inner sep=1em
    },
    basic box/.default=flow@blue,
    % 带标题样式 (使用label)
    with header/.style={
        label={[
            fill=white,
            draw=gray!60,
            thick,
            font=\bfseries\ttfamily,
            inner sep=0.3em,
            anchor=south
        ]north:#1}
    },
    with header/.default={Title},
    % 循环框 (DMFT loop style)
    loop box/.style={
        basic box=flow@blue,
        minimum width=8cm,
        minimum height=4cm
    },
    % 前置框
    prelude box/.style={
        basic box=flow@green,
        minimum width=4cm
    },
    % 更新框
    update box/.style={
        basic box=flow@orange,
        minimum width=3cm
    },
    % 计算框
    compute box/.style={
        basic box=flow@purple,
        minimum width=4cm
    },
}

% === 科学计算流程样式 ===
\tikzset{
    % 输入/输出节点
    sci input/.style={
        rectangle,
        draw=flow@green!80!black,
        fill=flow@green!25,
        rounded corners=3pt,
        minimum height=1.5em,
        minimum width=3cm,
        font=\small,
        thick
    },
    sci output/.style={
        rectangle,
        draw=flow@red!80!black,
        fill=flow@red!25,
        rounded corners=3pt,
        minimum height=1.5em,
        minimum width=3cm,
        font=\small,
        thick
    },
    % 计算步骤
    sci step/.style={
        rectangle,
        draw=flow@blue!80!black,
        fill=flow@blue!15,
        minimum height=2em,
        minimum width=4cm,
        font=\small,
        thick
    },
    % 判断节点
    sci decision/.style={
        diamond,
        draw=flow@orange!80!black,
        fill=flow@orange!20,
        minimum width=2cm,
        minimum height=2cm,
        font=\small,
        thick,
        aspect=2
    },
    % 循环标记
    sci loop/.style={
        rectangle,
        draw=flow@purple!80!black,
        fill=flow@purple!15,
        dashed,
        rounded corners=5pt,
        inner sep=1em
    },
    % 粗蓝线
    fat blue line/.style={
        ultra thick,
        flow@blue
    },
    % 流程箭头
    sci arrow/.style={
        ->,
        >=Stealth,
        thick,
        draw=gray!70
    },
    % 正交路径箭头
    ortho arrow/.style={
        ->,
        >=Stealth,
        thick,
        draw=gray!70,
        rounded corners=3pt
    },
}

% === 迭代算法样式 ===
\tikzset{
    % 初始化
    iter init/.style={
        rectangle,
        draw=flow@green!80!black,
        fill=flow@green!20,
        rounded corners=5pt,
        minimum height=2em,
        minimum width=5cm,
        font=\small
    },
    % 迭代步骤
    iter step/.style={
        rectangle,
        draw=flow@blue!80!black,
        fill=flow@blue!15,
        minimum height=2em,
        minimum width=5cm,
        font=\small
    },
    % 收敛判断
    iter converge/.style={
        diamond,
        draw=flow@orange!80!black,
        fill=flow@orange!15,
        minimum width=3cm,
        aspect=2.5,
        font=\small
    },
    % 输出结果
    iter result/.style={
        rectangle,
        draw=flow@red!80!black,
        fill=flow@red!15,
        rounded corners=5pt,
        minimum height=2em,
        minimum width=5cm,
        font=\small
    },
    % 循环箭头
    iter loop/.style={
        ->,
        >=Stealth,
        thick,
        draw=flow@purple,
        looseness=1.5
    },
}

% === 研究工作流样式 ===
\tikzset{
    % 阶段框
    phase box/.style={
        rectangle,
        draw=#1!80!black,
        fill=#1!20,
        rounded corners=10pt,
        minimum height=3em,
        minimum width=4cm,
        font=\bfseries,
        thick
    },
    phase box/.default=flow@blue,
    % 阶段连接
    phase arrow/.style={
        ->,
        >=Stealth,
        very thick,
        draw=gray!60
    },
    % 里程碑
    milestone/.style={
        star,
        star points=5,
        star point ratio=2,
        draw=flow@orange!80!black,
        fill=flow@orange!40,
        minimum size=1cm,
        font=\small\bfseries
    },
    % 数据流
    data flow/.style={
        ->,
        >=Stealth,
        thick,
        dashed,
        draw=flow@cyan
    },
    % 反馈循环
    feedback loop/.style={
        ->,
        >=Stealth,
        thick,
        draw=flow@purple,
        bend left=60
    },
}

% === 3D 多重态图样式 ===
\tikzset{
    % 粒子球
    particle ball/.style={
        shading=ball,
        ball color=white!80!black,
        circle,
        minimum size=0.8cm,
        font=\small
    },
    % 层面填充
    level plane/.style={
        fill=gray!20,
        draw=gray!50,
        opacity=0.7
    },
    % 连接线
    multiplet edge/.style={
        thick,
        draw=gray!60
    },
    multiplet edge dashed/.style={
        thick,
        dashed,
        draw=gray!40
    },
    % 坐标轴
    axis3d/.style={
        ->,
        >=Stealth,
        thick,
        draw=black
    },
    axis label/.style={
        font=\small
    },
}

% === 快捷命令 ===

% 创建带标题的分组框
% 用法: \headerbox[颜色]{标题}{内容宽度}{内容高度}
\newcommand{\headerbox}[4][flow@blue]{%
    \node[basic box=#1, minimum width=#3, minimum height=#4] (box) {};
    \node[fill=white, draw=#1!80!black, thick, font=\bfseries\ttfamily, 
          inner sep=0.3em] at (box.north) {#2};
}

% 科学流程图环境
\newenvironment{sciflow}[1][1.5cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth, thick]
}{%
    \end{tikzpicture}
    \end{center}
}

% 迭代算法环境  
\newenvironment{iterflow}[1][1.2cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% 研究工作流环境
\newenvironment{workflow}[1][2cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.19] 3D 几何图形样式 (3D Geometry Visualization)
% ---------------------------------------------------------
% 💡 多面体/斜多边形/曲面/坐标系

% === 3D 配色定义 ===
\definecolor{geo3d@face}{RGB}{100,200,220}
\definecolor{geo3d@edge}{RGB}{200,80,80}
\definecolor{geo3d@vertex}{RGB}{80,80,200}
\definecolor{geo3d@hidden}{RGB}{150,150,150}
\definecolor{geo3d@surface}{RGB}{0,200,200}

% === 多面体样式 ===
\tikzset{
    % 多面体面 (可见)
    poly face/.style={
        thick,
        draw=geo3d@edge,
        fill=geo3d@face!35,
        opacity=0.75
    },
    % 多面体面 (带自定义颜色)
    poly face color/.style={
        thick,
        draw=geo3d@edge,
        fill=#1!35,
        opacity=0.75
    },
    poly face color/.default=geo3d@face,
    % 多面体边 (可见)
    poly edge/.style={
        thick,
        draw=geo3d@edge
    },
    % 多面体边 (隐藏/虚线)
    poly edge hidden/.style={
        thick,
        dashed,
        draw=geo3d@hidden
    },
    % 顶点
    poly vertex/.style={
        circle,
        fill=geo3d@vertex,
        inner sep=1.5pt
    },
    % 顶点标签
    vertex label/.style={
        font=\small,
        text=black
    },
}

% === 曲面/斜多边形样式 ===
\tikzset{
    % 曲面网格线
    surface grid/.style={
        thin,
        draw=geo3d@surface,
        opacity=0.25
    },
    % 曲面边界
    surface boundary/.style={
        very thick,
        draw=geo3d@edge
    },
    % 参数曲面填充
    surface fill/.style={
        fill=geo3d@face!20,
        draw=none,
        opacity=0.5
    },
    % 斜多边形边
    skew edge/.style={
        very thick,
        draw=geo3d@edge
    },
}

% === 3D 坐标系样式 ===
\tikzset{
    % 坐标轴
    3d axis/.style={
        ->,
        >=Stealth,
        thick,
        draw=black
    },
    % 坐标轴标签
    3d axis label/.style={
        font=\small
    },
    % 辅助平面
    aux plane/.style={
        fill=gray!10,
        draw=gray!30,
        opacity=0.3
    },
    % 辅助线
    aux line/.style={
        thin,
        dashed,
        draw=gray!50
    },
}

% === 晶体学/多面体特殊样式 ===
\tikzset{
    % 正多面体面 (柏拉图立体)
    platonic face/.style={
        thick,
        draw=geo3d@edge!80!black,
        fill=geo3d@face!40,
        opacity=0.8
    },
    % 阿基米德多面体面
    archimedean face/.style={
        thick,
        draw=geo3d@edge!70!black,
        fill=#1!30,
        opacity=0.75
    },
    archimedean face/.default=geo3d@face,
    % 菱形面
    rhombic face/.style={
        thick,
        draw=geo3d@edge,
        fill=cyan!35,
        opacity=0.75
    },
    % 晶格点
    lattice point/.style={
        circle,
        fill=black,
        inner sep=1pt
    },
    % 晶格边
    lattice edge/.style={
        thin,
        draw=gray!60
    },
}

% === 投影样式 ===
\tikzset{
    % 投影面
    projection plane/.style={
        fill=gray!5,
        draw=gray!40,
        opacity=0.5
    },
    % 投影线
    projection line/.style={
        thin,
        dashed,
        draw=gray!40
    },
    % 投影点
    projection point/.style={
        circle,
        fill=gray!60,
        inner sep=1pt
    },
}

% === 快捷命令 ===

% 绘制 3D 坐标轴
% 用法: \drawaxes3d{x长度}{y长度}{z长度}
\newcommand{\drawaxesthreeD}[3]{%
    \draw[3d axis] (0,0,0) -- (#1,0,0) node[3d axis label, right] {$x$};
    \draw[3d axis] (0,0,0) -- (0,#2,0) node[3d axis label, above] {$y$};
    \draw[3d axis] (0,0,0) -- (0,0,#3) node[3d axis label, above] {$z$};
}

% 绘制长方体框架
% 用法: \drawbox{a}{b}{c} (三边长)
\newcommand{\drawcuboid}[3]{%
    % 底面
    \draw[poly edge hidden] (0,0,0) -- (#1,0,0) -- (#1,#2,0) -- (0,#2,0) -- cycle;
    % 顶面
    \draw[poly edge] (0,0,#3) -- (#1,0,#3) -- (#1,#2,#3) -- (0,#2,#3) -- cycle;
    % 垂直边
    \draw[poly edge hidden] (0,0,0) -- (0,0,#3);
    \draw[poly edge] (#1,0,0) -- (#1,0,#3);
    \draw[poly edge] (#1,#2,0) -- (#1,#2,#3);
    \draw[poly edge] (0,#2,0) -- (0,#2,#3);
}

% 3D 几何环境 (使用 tikz-3dplot)
\newenvironment{geometry3d}[2][70]{%
    \begin{center}
    \tdplotsetmaincoords{#1}{#2}
    \begin{tikzpicture}[tdplot_main_coords, scale=1.5]
}{%
    \end{tikzpicture}
    \end{center}
}

% 多面体环境
\newenvironment{polyhedron}[2][80]{%
    \begin{center}
    \tdplotsetmaincoords{#1}{#2}
    \begin{tikzpicture}[tdplot_main_coords]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.21] 神经网络可视化样式 (Neural Network Visualization)
% ---------------------------------------------------------
% 💡 全连接网络/自编码器/CNN/MADE/VAE

% === 神经网络配色 ===
\definecolor{nn@input}{RGB}{100,180,100}
\definecolor{nn@hidden}{RGB}{100,150,220}
\definecolor{nn@output}{RGB}{220,100,100}
\definecolor{nn@mu}{RGB}{255,220,100}
\definecolor{nn@sigma}{RGB}{100,150,255}
\definecolor{nn@sample}{RGB}{100,220,150}
\definecolor{nn@conv}{RGB}{180,130,220}
\definecolor{nn@pool}{RGB}{130,200,200}

% === 神经元样式 ===
\tikzset{
    % 基础神经元
    neuron/.style={
        circle,
        draw=black!70,
        thick,
        minimum size=4ex,
        font=\small
    },
    % 输入层神经元
    input neuron/.style={
        neuron,
        fill=nn@input!30
    },
    % 隐藏层神经元
    hidden neuron/.style={
        neuron,
        fill=nn@hidden!30
    },
    % 输出层神经元
    output neuron/.style={
        neuron,
        fill=nn@output!30
    },
    % 偏置节点
    bias node/.style={
        neuron,
        fill=gray!20,
        font=\small\bfseries
    },
    % 激活函数标记
    activation/.style={
        font=\scriptsize,
        text=black!60
    },
}

% === 连接样式 ===
\tikzset{
    % 普通连接
    nn edge/.style={
        ->,
        >=Stealth,
        draw=gray!60,
        shorten >=1pt,
        shorten <=1pt
    },
    % 权重连接 (加粗)
    weight edge/.style={
        nn edge,
        thick,
        draw=nn@hidden!70
    },
    % 稀疏连接
    sparse edge/.style={
        nn edge,
        draw=nn@hidden!50
    },
    % 跳跃连接 (残差)
    skip connection/.style={
        ->,
        >=Stealth,
        thick,
        draw=nn@output!70,
        dashed,
        bend left=40
    },
    % 反向传播
    backprop edge/.style={
        <-,
        >=Stealth,
        draw=red!50,
        dashed
    },
}

% === 层样式 ===
\tikzset{
    % 层框
    layer box/.style={
        rectangle,
        draw=gray!50,
        fill=#1!10,
        rounded corners=5pt,
        minimum width=1.5cm,
        minimum height=3cm,
        thick
    },
    layer box/.default=nn@hidden,
    % 卷积层
    conv layer/.style={
        rectangle,
        draw=nn@conv!80!black,
        fill=nn@conv!25,
        minimum width=0.5cm,
        minimum height=2.5cm,
        thick
    },
    % 池化层
    pool layer/.style={
        rectangle,
        draw=nn@pool!80!black,
        fill=nn@pool!25,
        minimum width=0.3cm,
        minimum height=2cm,
        thick
    },
    % 全连接层
    fc layer/.style={
        rectangle,
        draw=nn@hidden!80!black,
        fill=nn@hidden!20,
        minimum width=0.8cm,
        minimum height=2.5cm,
        thick
    },
    % Dropout层
    dropout layer/.style={
        rectangle,
        draw=gray!60,
        fill=gray!10,
        dashed,
        minimum width=0.3cm,
        minimum height=2cm
    },
}

% === VAE 特殊样式 ===
\tikzset{
    % 均值向量
    mu block/.style={
        rectangle,
        draw=nn@mu!80!black,
        fill=nn@mu!40,
        rounded corners=3pt,
        minimum width=1cm,
        minimum height=1.5cm,
        thick
    },
    % 方差向量
    sigma block/.style={
        rectangle,
        draw=nn@sigma!80!black,
        fill=nn@sigma!30,
        rounded corners=3pt,
        minimum width=1cm,
        minimum height=1.5cm,
        thick
    },
    % 采样块
    sample block/.style={
        rectangle,
        draw=nn@sample!80!black,
        fill=nn@sample!30,
        rounded corners=3pt,
        minimum width=1cm,
        minimum height=1.5cm,
        thick
    },
    % 潜在空间
    latent space/.style={
        ellipse,
        draw=nn@mu!60!nn@sigma,
        fill=nn@mu!10!nn@sigma!10,
        minimum width=2cm,
        minimum height=1.5cm,
        thick
    },
}

% === 特殊网络组件 ===
\tikzset{
    % 注意力机制
    attention/.style={
        rectangle,
        draw=orange!80!black,
        fill=orange!20,
        rounded corners=3pt,
        minimum width=1.5cm,
        minimum height=0.8cm,
        font=\small
    },
    % BatchNorm
    batchnorm/.style={
        rectangle,
        draw=green!60!black,
        fill=green!15,
        minimum width=0.3cm,
        minimum height=1.5cm
    },
    % 特征图
    feature map/.style={
        rectangle,
        draw=nn@conv!60,
        fill=nn@conv!15,
        minimum width=#1,
        minimum height=#1
    },
    feature map/.default=1cm,
    % Mask (MADE)
    mask matrix/.style={
        draw=black,
        thick
    },
    mask cell/.style={
        fill=black,
        draw=none
    },
}

% === 标签样式 ===
\tikzset{
    % 层标签
    layer label/.style={
        font=\small\bfseries,
        text=black!70
    },
    % 网络标题
    nn title/.style={
        font=\large\bfseries
    },
    % 维度标签
    dim label/.style={
        font=\scriptsize,
        text=gray!70
    },
}

% === 快捷命令 ===

% 绘制全连接层的神经元
% 用法: \drawlayer{命名空间}{层号}{神经元数}{x位置}{起始y}{间距}
\newcommand{\drawlayer}[6]{%
    \foreach \i in {1,...,#3} {
        \pgfmathsetmacro{\ypos}{#5 - (\i-1)*#6}
        \node[hidden neuron] (#1-#2-\i) at (#4, \ypos) {};
    }
}

% 全连接两层
% 用法: \connectlayers{命名空间}{源层号}{源数量}{目标层号}{目标数量}
\newcommand{\connectlayers}[5]{%
    \foreach \i in {1,...,#3} {
        \foreach \j in {1,...,#5} {
            \draw[nn edge] (#1-#2-\i) -- (#1-#4-\j);
        }
    }
}

% 神经网络环境
\newenvironment{neuralnet}[1][1.5cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth, shorten >=1pt, shorten <=1pt]
}{%
    \end{tikzpicture}
    \end{center}
}

% 自编码器环境
\newenvironment{autoencoder}[1][2cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% CNN 环境
\newenvironment{convnet}[1][0.8cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.23] 概率树与决策树样式 (Probability & Decision Trees)
% ---------------------------------------------------------
% 💡 概率树/决策树/贝叶斯网络/概率表

% === 概率树配色 ===
\definecolor{prob@highlight}{RGB}{70,130,220}
\definecolor{prob@event}{RGB}{100,180,100}
\definecolor{prob@outcome}{RGB}{220,150,100}

% === 概率树节点样式 ===
\tikzset{
    % 概率树根节点
    prob root/.style={
        circle,
        draw=black!70,
        fill=white,
        minimum size=3pt,
        inner sep=0pt
    },
    % 事件节点
    prob event/.style={
        circle,
        draw=black!70,
        thick,
        minimum size=2em,
        font=\small
    },
    % 高亮事件节点
    prob event highlight/.style={
        prob event,
        draw=prob@highlight,
        thick
    },
    % 结果节点
    prob outcome/.style={
        rectangle,
        draw=black!50,
        rounded corners=2pt,
        minimum height=1.5em,
        font=\small
    },
    % 决策节点 (方形)
    decision node/.style={
        rectangle,
        draw=black!70,
        thick,
        minimum size=2em,
        font=\small
    },
    % 机会节点 (圆形)
    chance node/.style={
        circle,
        draw=black!70,
        thick,
        minimum size=2em,
        font=\small
    },
}

% === 概率树边样式 ===
\tikzset{
    % 概率边
    prob edge/.style={
        ->,
        >=Stealth,
        thick,
        draw=black!60
    },
    % 高亮概率边
    prob edge highlight/.style={
        prob edge,
        draw=prob@highlight,
        very thick
    },
    % 概率标签
    prob label/.style={
        font=\footnotesize,
        inner sep=1pt,
        outer sep=2pt,
        circle
    },
    % 高亮概率标签
    prob label highlight/.style={
        prob label,
        draw=prob@highlight,
        text=prob@highlight
    },
}

% === 概率表格样式 ===
\tikzset{
    % 概率表格矩阵
    prob table/.style={
        matrix of math nodes,
        nodes in empty cells,
        row sep=-\pgflinewidth,
        column sep=5mm,
        nodes={
            minimum height=2em,
            anchor=center
        }
    },
    % 表格高亮单元格
    prob cell highlight/.style={
        draw=prob@highlight,
        fill=prob@highlight!10
    },
    % 表格标题行
    prob header/.style={
        font=\bfseries,
        fill=gray!10
    },
}

% ---------------------------------------------------------
% [21.24] 卷积运算可视化样式 (Convolution Operation)
% ---------------------------------------------------------
% 💡 CNN卷积/核/特征图/2D矩阵

% === 卷积配色 ===
\definecolor{conv@input}{RGB}{255,180,100}
\definecolor{conv@kernel}{RGB}{100,180,180}
\definecolor{conv@output}{RGB}{100,130,220}

% === 2D数组矩阵样式 ===
\tikzset{
    % 2D数组基础样式
    2d array/.style={
        matrix of nodes,
        row sep=-\pgflinewidth,
        column sep=-\pgflinewidth,
        nodes={
            draw,
            minimum size=2em,
            anchor=center,
            font=\small
        }
    },
    % 输入矩阵
    input matrix/.style={
        2d array,
        nodes={draw=black!50}
    },
    % 卷积核矩阵
    kernel matrix/.style={
        2d array,
        nodes={draw=conv@kernel!80!black, fill=conv@kernel!30}
    },
    % 输出矩阵
    output matrix/.style={
        2d array,
        nodes={draw=black!50}
    },
    % 高亮输入区域
    conv input highlight/.style={
        fill=conv@input!30
    },
    % 高亮输出单元
    conv output highlight/.style={
        fill=conv@output!30
    },
    % 卷积核单元
    kernel cell/.style={
        fill=conv@kernel!30
    },
}

% === 卷积连接样式 ===
\tikzset{
    % 卷积映射线
    conv map/.style={
        dashed,
        draw=conv@kernel!80!black
    },
    % 输出映射线
    output map/.style={
        dashed,
        draw=conv@output!80!black
    },
    % 卷积运算符
    conv operator/.style={
        font=\Large
    },
    % 乘法标注
    multiply label/.style={
        font=\tiny,
        scale=0.6,
        shift={(-1.2ex,-2ex)}
    },
}

% === 快捷命令 ===

% 绘制概率标签
% 用法: \problabel{概率值}
\newcommand{\problabel}[1]{edge node[prob label]{#1}}

% 绘制高亮概率标签
% 用法: \problabelhigh{概率值}
\newcommand{\problabelhigh}[1]{edge node[prob label highlight]{#1}}

% 概率树环境
\newenvironment{probtree}[1][1.5cm]{%
    \begin{center}
    \begin{tikzpicture}[
        grow=right,
        level distance=#1,
        sibling distance=8mm,
        edge from parent/.style={prob edge},
        >=Stealth
    ]
}{%
    \end{tikzpicture}
    \end{center}
}

% 决策树环境
\newenvironment{decisiontree}[1][2cm]{%
    \begin{center}
    \begin{tikzpicture}[
        grow=right,
        level distance=#1,
        sibling distance=10mm,
        >=Stealth
    ]
}{%
    \end{tikzpicture}
    \end{center}
}

% 卷积运算环境
\newenvironment{convolution}[1][1cm]{%
    \begin{center}
    \begin{tikzpicture}[node distance=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.26] TQFT 协边图样式 (Topological Quantum Field Theory)
% ---------------------------------------------------------
% 💡 拓扑量子场论/协边/pants/cup/cap

% === TQFT 基础样式 ===
\tikzset{
    % TQFT 通用样式
    tqft style/.style={
        every tqft/.append style={
            transform shape,
            rotate=90,
            tqft/circle x radius=7pt,
            tqft/boundary separation=1cm,
            tqft/view from=incoming
        }
    },
    % 协边边界
    cobordism boundary/.style={
        draw
    },
    % 协边边
    cobordism edge/.style={
        draw
    },
    % 协边填充
    cobordism fill/.style={
        fill=blue!10
    },
}

% === TQFT 注释样式 ===
\tikzset{
    % 时间参数标注
    time param/.style={
        dashed,
        draw=black!70
    },
    % 空间参数标注
    space param/.style={
        ->,
        >=Stealth,
        draw=black!70
    },
    % 参数标签
    tqft label/.style={
        font=\small
    },
}

% === 拓扑对象样式 ===
\tikzset{
    % 环面切片
    torus slice/.style={
        draw,
        thick
    },
    % 球面
    sphere boundary/.style={
        draw,
        shape=circle,
        minimum width=1.5cm
    },
    % 亏格标记
    genus mark/.style={
        dashed
    },
}

% === 快捷 TQFT 设置 ===

% TQFT 协边环境
\newenvironment{cobordism}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[
        scale=#1,
        every tqft/.append style={
            transform shape,
            rotate=90,
            tqft/circle x radius=7pt,
            tqft/boundary separation=1cm,
            tqft/view from=incoming
        }
    ]
}{%
    \end{tikzpicture}
    \end{center}
}

% TQFT 图环境 (水平方向)
\newenvironment{tqftdiagram}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[
        scale=#1,
        every tqft/.append style={
            transform shape,
            tqft/circle x radius=7pt,
            tqft/boundary separation=1cm
        }
    ]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.28] 晶格与拓扑等价样式 (Lattice & Topological Identification)
% ---------------------------------------------------------
% 💡 晶格/基本域/等价粘合/环面构造

% === 晶格配色 ===
\definecolor{lattice@primary}{RGB}{70,130,180}
\definecolor{lattice@domain}{RGB}{255,200,100}
\definecolor{lattice@arrow}{RGB}{180,80,80}

% === 晶格样式 ===
\tikzset{
    % 晶格网格
    lattice grid/.style={
        draw=gray!50,
        thin
    },
    % 坐标轴
    lattice axis/.style={
        ->,
        >=Stealth,
        ultra thick,
        draw=black
    },
    % 基本域
    fundamental domain/.style={
        draw=lattice@primary,
        ultra thick,
        rectangle,
        minimum width=1cm,
        minimum height=1cm
    },
    % 周期性标注
    period label/.style={
        font=\small
    },
}

% === 拓扑等价样式 ===
\tikzset{
    % 等价箭头 (用于粘合边)
    identification arrow/.style={
        postaction={decorate},
        decoration={
            markings,
            mark=at position 0.5 with {\arrow{latex}}
        }
    },
    % 反向等价箭头
    identification arrow reversed/.style={
        postaction={decorate},
        decoration={
            markings,
            mark=at position 0.5 with {\arrowreversed{latex}}
        }
    },
    % 双向箭头标记
    identification double/.style={
        postaction={decorate},
        decoration={
            markings,
            mark=at position 0.25 with {\arrow{latex}},
            mark=at position 0.75 with {\arrow{latex}}
        }
    },
}

% === 曲面构造样式 ===
\tikzset{
    % 圆柱面边
    cylinder side/.style={
        draw=black,
        thick
    },
    % 圆柱面端
    cylinder end/.style={
        draw=black,
        thick,
        ellipse
    },
    % 环面外环
    torus outer/.style={
        draw=black,
        thick
    },
    % 环面内环 (虚线)
    torus inner/.style={
        draw=black,
        thick,
        dashed
    },
    % Möbius 带边
    mobius edge/.style={
        draw=black,
        thick
    },
}

% === 手术/粘合标记 ===
\tikzset{
    % 切割线
    cut line/.style={
        draw=lattice@arrow,
        thick,
        dashed
    },
    % 粘合点
    glue point/.style={
        circle,
        fill=lattice@arrow,
        inner sep=2pt
    },
    % 等价标记
    equiv mark/.style={
        font=\small,
        text=lattice@primary
    },
}

% === 晶格环境 ===
\newenvironment{latticediag}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[scale=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% === 曲面构造环境 ===
\newenvironment{surfaceconstruct}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[scale=#1]
}{%
    \end{tikzpicture}
    \end{center}
}

% ---------------------------------------------------------
% [21.30] 电磁波与光学样式 (Electromagnetic Waves & Optics)
% ---------------------------------------------------------
% 💡 偏振光/电磁波/光学元件

% === 电磁波配色 ===
\definecolor{em@efield}{RGB}{220,50,50}
\definecolor{em@bfield}{RGB}{50,50,220}
\definecolor{em@propagation}{RGB}{50,150,50}
\definecolor{em@polarizer}{RGB}{100,100,100}

% === 波动样式 ===
\tikzset{
    % 传播方向
    propagation arrow/.style={
        very thick,
        ->,
        >=Stealth,
        draw=em@propagation
    },
    % 电场向量
    E field/.style={
        ->,
        >=Latex,
        thick,
        draw=em@efield
    },
    % 磁场向量
    B field/.style={
        ->,
        >=Latex,
        thick,
        draw=em@bfield
    },
    % 波形曲线
    wave curve/.style={
        very thick,
        draw=em@efield,
        samples=300
    },
    % 波形曲线 (磁场)
    wave curve B/.style={
        very thick,
        draw=em@bfield,
        samples=300
    },
}

% === 偏振元件样式 ===
\tikzset{
    % 偏振片
    polarizer/.style={
        thick,
        fill=em@polarizer!40,
        draw=em@polarizer
    },
    % 偏振方向
    polarization axis/.style={
        thick,
        dashed,
        draw=em@polarizer
    },
    % 波片
    wave plate/.style={
        thick,
        fill=blue!20,
        draw=blue!60
    },
}

% === 3D 光学样式 ===
\tikzset{
    % 光束截面
    beam cross section/.style={
        thick,
        fill=black!10,
        draw=black!50
    },
    % 螺旋线 (圆偏振)
    helix path/.style={
        very thick,
        draw=em@efield
    },
    % 场向量小箭头
    field vector/.style={
        -{Latex[length=0.8mm]},
        draw=em@efield
    },
}

% === 光学注释 ===
\tikzset{
    % 传播标签
    propagation label/.style={
        font=\small,
        align=center
    },
    % 偏振类型标签
    polarization label/.style={
        font=\small,
        align=center
    },
}

% === 快捷命令 ===

% 绘制3D矩形截面
% 用法: \drawbeamrect{x位置}{y半宽}{z半宽}
\newcommand{\drawbeamrect}[3]{%
    \begin{scope}[canvas is xz plane at y=#2]
        \draw[beam cross section] (#1,-#3) rectangle (#1+0.2,#3);
    \end{scope}
    \begin{scope}[canvas is xy plane at z=#3]
        \draw[beam cross section] (#1,-#2) rectangle (#1+0.2,#2);
    \end{scope}
    \begin{scope}[canvas is yz plane at x=#1]
        \draw[beam cross section] (-#2,-#3) rectangle (#2,#3);
        \draw[thick, dashed] (0,0) ellipse (0.7*#2 and 0.7*#3);
    \end{scope}
}

% 电磁波环境
\newenvironment{emwave}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[
        scale=#1,
        x={(0.8cm, 0.4cm)},
        y={(0.9cm, -0.3cm)},
        z={(0cm,1cm)},
        line cap=round,
        line join=round,
        >=Stealth
    ]
}{%
    \end{tikzpicture}
    \end{center}
}

% 光学系统环境
\newenvironment{optics}[1][1]{%
    \begin{center}
    \begin{tikzpicture}[scale=#1, >=Stealth]
}{%
    \end{tikzpicture}
    \end{center}
}

% [21.31] 术语表 (Nomenclature) Stub
% 预留接口，用户需自行引入 nomencl 包
\newcommand{\makenom}{\typeout{>> [MindFlow] Nomenclature support enabled.}}

\floatname{algorithm}{算法}
\renewcommand{\algorithmicrequire}{\textbf{输入:}}
\renewcommand{\algorithmicensure}{\textbf{输出:}}


% ---------------------------------------------------------
% 4. 字体配置 (智能检测 + 多平台适配)
% ---------------------------------------------------------
\makeatletter

% 清除旧定义
\let\songti\relax
\let\heiti\relax
\let\kaiti\relax

% --- 4.1 英文字体配置 ---
\IfFileExists{fonts/times.ttf}{
    \typeout{>> [MindFlow] Local English fonts found (fonts/times.ttf).}
    \setmainfont{times.ttf}[
        Path = fonts/,
        BoldFont = timesbd.ttf,
        ItalicFont = timesi.ttf,
        BoldItalicFont = timesbi.ttf
    ]
}{
    \ifmf@oswin
        \setmainfont{Times New Roman}
    \else
        \ifmf@osmac
            \setmainfont{Times New Roman}
        \else
            \setmainfont{TeX Gyre Termes}
        \fi
    \fi
}

% --- 4.2 中文字体配置 ---
\IfFileExists{fonts/SimSun.ttf}{
    \typeout{>> [MindFlow] Local Chinese fonts found (fonts/SimSun.ttf).}
    \defaultfontfeatures{Ligatures=TeX}
    
    % 预判字体文件
    \IfFileExists{fonts/SimHei.ttf}{%
        \def\mf@cjk@bold{SimHei.ttf}%
        \def\mf@cjk@fakebold{false}%
    }{%
        \def\mf@cjk@bold{SimSun.ttf}%
        \def\mf@cjk@fakebold{2.5}%
    }%
    
    \IfFileExists{fonts/KaiTi.ttf}{%
        \def\mf@cjk@italic{KaiTi.ttf}%
    }{%
        \def\mf@cjk@italic{SimSun.ttf}%
    }%
    
    % 主字体设置
    \setCJKmainfont{SimSun.ttf}[
        Path = fonts/,
        BoldFont = \mf@cjk@bold,
        ItalicFont = \mf@cjk@italic,
        AutoFakeBold = \mf@cjk@fakebold
    ]
    
    % 配套字体设置
    \IfFileExists{fonts/SimHei.ttf}{
        \setCJKsansfont{SimHei.ttf}[Path = fonts/]
        \newCJKfontfamily\heiti{SimHei.ttf}[Path=fonts/]
    }{
        \setCJKsansfont{SimSun.ttf}[Path = fonts/, AutoFakeBold=2.5]
        \newCJKfontfamily\heiti{SimSun.ttf}[Path=fonts/, AutoFakeBold=2.5]
    }
    
    \IfFileExists{fonts/KaiTi.ttf}{
        \setCJKmonofont{KaiTi.ttf}[Path = fonts/]
        \newCJKfontfamily\kaiti{KaiTi.ttf}[Path=fonts/]
    }{
        \setCJKmonofont{SimSun.ttf}[Path = fonts/, AutoFakeBold=2.5]
        \newCJKfontfamily\kaiti{SimSun.ttf}[Path=fonts/, AutoFakeBold=2.5]
    }
    
    \newCJKfontfamily\songti{SimSun.ttf}[Path=fonts/, AutoFakeBold=2.5]

}{
    % [系统回退] Fandol
    \typeout{>> [MindFlow] Using Fandol fonts (Linux/Fallback).}
    \setCJKmainfont[
        Extension=.otf,
        BoldFont=FandolHei-Regular,
        BoldFeatures={FakeBold=3},
        ItalicFont=FandolKai-Regular,
        ItalicFeatures={FakeSlant=0.2}
    ]{FandolSong-Regular}
    \setCJKsansfont[Extension=.otf, BoldFont=FandolHei-Regular, BoldFeatures={FakeBold=3}]{FandolHei-Regular}
    \setCJKmonofont[Extension=.otf, BoldFont=FandolKai-Regular, BoldFeatures={FakeBold=3}]{FandolKai-Regular}
    \newCJKfontfamily\songti[Extension=.otf]{FandolSong-Regular}
    \newCJKfontfamily\heiti[Extension=.otf]{FandolHei-Regular}
    \newCJKfontfamily\kaiti[Extension=.otf]{FandolKai-Regular}
}


% ---------------------------------------------------------
% 5. 页面布局
% ---------------------------------------------------------
\geometry{
    a4paper,
    left=2.5cm,
    right=2.5cm,
    top=2.5cm,
    bottom=2.5cm,
    headheight=15pt
}
\pagestyle{plain}

% [5.1] 自定义目录命令：目录使用罗马数字页码，正文从1开始
% 💡 book 模式使用 \frontmatter/\mainmatter，其他模式使用 \pagenumbering
% 💡 同时重置 section/chapter 计数器，确保正文编号从1开始
\newcommand{\mftableofcontents}{%
    \ifmf@book
        \frontmatter  % book 模式：罗马数字页码
        \tableofcontents
        \mainmatter   % 切换到阿拉伯数字，页码从1开始
        \setcounter{chapter}{0}%  重置章计数器
    \else
        \pagenumbering{roman}%
        \tableofcontents%
        \clearpage
        \pagenumbering{arabic}%
        \setcounter{section}{0}%  重置节计数器
    \fi
}


% ---------------------------------------------------------
% 6. 章节标题样式 (经典中文书籍风格)
% ---------------------------------------------------------
% 💡 样式说明：顶部横线 + 右侧竖排"第X章" + 左下方章节标题

% 定义章节标题绘制命令
\newcommand{\mf@chaptertitle}[2]{%
    % #1 = 章节编号 (如 1, 2, 3...)
    % #2 = 章节标题
    \begin{tikzpicture}[remember picture, overlay]
        % 顶部横线 (从左边距到右边距)
        \draw[line width=1.2pt, black] 
            ([yshift=-0.5cm]current page.north west |- 0,0) ++(\dimexpr\oddsidemargin+1in,0)
            -- ++(\textwidth,0);
    \end{tikzpicture}%
    \noindent
    \begin{minipage}[t]{\textwidth}
        \vspace{0.8cm}
        \begin{flushright}
            % 右侧竖排"第X章"
            \begin{minipage}[t]{1.5cm}
                \centering
                \fontsize{18pt}{22pt}\selectfont\heiti
                第\\[0.3em]
                {\fontsize{36pt}{40pt}\selectfont #1}\\[0.3em]
                章
            \end{minipage}
        \end{flushright}
        \vspace{-1.5cm}
        % 左侧章节标题
        \noindent
        {\fontsize{22pt}{28pt}\selectfont\heiti\bfseries #2}
        \par\vspace{1.5cm}
    \end{minipage}
}

% 定义简洁章节标题 - Classic 样式 (默认)
% 💡 蓝色编号块 + 浅蓝背景标题
\newcommand{\mf@sectitle@classic}[2]{%
    \definecolor{mf@sec@blue}{RGB}{30,90,150}
    \begin{tcolorbox}[
        enhanced,
        colback=white,
        colframe=white,
        boxrule=0pt,
        arc=0pt,
        left=0pt, right=0pt, top=0pt, bottom=0pt,
        before skip=15pt,
        after skip=15pt
    ]
        % 编号块
        \begin{tcolorbox}[
            enhanced,
            width=1.5cm,
            nobeforeafter,
            colback=mf@sec@blue,
            colframe=mf@sec@blue,
            halign=center,
            valign=center,
            arc=4pt,
            boxrule=0pt,
            top=6pt, bottom=6pt
        ]
            \color{white}\bfseries\zihao{3} #1
        \end{tcolorbox}%
        \hspace{0.5em}%
        % 标题块
        \begin{tcolorbox}[
            enhanced,
            width=\dimexpr\textwidth-1.5cm-0.8em\relax,
            nobeforeafter,
            colback=mf@sec@blue!8!white,
            colframe=mf@sec@blue!8!white,
            valign=center,
            arc=4pt,
            boxrule=0pt,
            left=10pt,
            top=6pt,
            bottom=6pt
        ]
            \color{mf@sec@blue}\bfseries\zihao{-3}\heiti #2
        \end{tcolorbox}
    \end{tcolorbox}%
}

% Modern 样式: 渐变底边线 + 大号编号
\newcommand{\mf@sectitle@modern}[2]{%
    \definecolor{mf@mod@start}{RGB}{70,130,180}
    \definecolor{mf@mod@end}{RGB}{135,206,250}
    \par\vspace{20pt}
    \noindent
    \begin{minipage}{\textwidth}
        % 大号编号
        {\fontsize{32pt}{36pt}\selectfont\bfseries\color{mf@mod@start}#1}%
        \hspace{0.5em}%
        % 标题
        {\fontsize{16pt}{20pt}\selectfont\heiti\bfseries #2}
        \par\vspace{6pt}
        % 渐变底线
        \begin{tikzpicture}
            \shade[left color=mf@mod@start, right color=mf@mod@end, opacity=0.8]
                (0,0) rectangle (\textwidth, 2pt);
        \end{tikzpicture}
    \end{minipage}
    \par\vspace{15pt}
}

% Minimal 样式: 纯文本 + 左侧竖线
\newcommand{\mf@sectitle@minimal}[2]{%
    \definecolor{mf@min@gray}{RGB}{100,100,100}
    \par\vspace{18pt}
    \noindent
    \begin{tikzpicture}[baseline=(text.base)]
        % 左侧竖线
        \fill[mf@min@gray] (0, -0.3em) rectangle (3pt, 1.2em);
        % 编号和标题
        \node[anchor=west, inner sep=0] (text) at (10pt, 0.4em) {%
            {\zihao{3}\bfseries\color{mf@min@gray}#1}\hspace{0.8em}%
            {\zihao{-3}\heiti\bfseries #2}%
        };
    \end{tikzpicture}
    \par\vspace{12pt}
}

% Boxed 样式: 完整边框卡片
\newcommand{\mf@sectitle@boxed}[2]{%
    \definecolor{mf@box@border}{RGB}{60,60,60}
    \definecolor{mf@box@bg}{RGB}{250,250,250}
    \begin{tcolorbox}[
        enhanced,
        colback=mf@box@bg,
        colframe=mf@box@border,
        boxrule=1.5pt,
        arc=6pt,
        left=12pt, right=12pt, top=10pt, bottom=10pt,
        before skip=18pt,
        after skip=15pt,
        shadow={2pt}{-2pt}{0pt}{black!20}
    ]
        {\zihao{3}\bfseries\color{mf@box@border}#1}\hspace{1em}%
        {\zihao{-3}\heiti\bfseries #2}
    \end{tcolorbox}
}

% =========================================================
% 极致美化样式 (v1.1)
% =========================================================

% Neon 样式: 霓虹发光边框 (赛博朋克风)
% 💡 深色背景 + 多层发光边框 + 霓虹色文字
\newcommand{\mf@sectitle@neon}[2]{%
    \definecolor{mf@neon@bg}{RGB}{15,15,25}
    \definecolor{mf@neon@glow}{RGB}{0,255,200}
    \definecolor{mf@neon@pink}{RGB}{255,0,128}
    \begin{tcolorbox}[
        enhanced,
        colback=mf@neon@bg,
        colframe=mf@neon@glow,
        boxrule=2pt,
        arc=3pt,
        left=15pt, right=15pt, top=12pt, bottom=12pt,
        before skip=18pt,
        after skip=15pt,
        shadow={0pt}{0pt}{8pt}{mf@neon@glow!60},
        borderline={1pt}{1pt}{mf@neon@pink!70}
    ]
        {\fontsize{28pt}{32pt}\selectfont\bfseries\color{mf@neon@glow}#1}%
        \hspace{0.8em}%
        {\zihao{-3}\bfseries\color{white}#2}
    \end{tcolorbox}
}

% Terminal 样式: 终端/Hacker 风格
% 💡 模拟命令行界面：黑底绿字 + 命令提示符
\newcommand{\mf@sectitle@terminal}[2]{%
    \definecolor{mf@term@bg}{RGB}{30,30,30}
    \definecolor{mf@term@green}{RGB}{0,255,0}
    \definecolor{mf@term@gray}{RGB}{100,100,100}
    \begin{tcolorbox}[
        enhanced,
        colback=mf@term@bg,
        colframe=mf@term@gray,
        boxrule=1pt,
        arc=0pt,
        left=10pt, right=10pt, top=8pt, bottom=8pt,
        before skip=18pt,
        after skip=15pt,
        fontupper=\ttfamily
    ]
        \textcolor{mf@term@gray}{user@mindflow:}\textcolor{mf@term@green}{\textasciitilde}\textcolor{white}{\$}~%
        \textcolor{mf@term@green}{\bfseries section}~%
        \textcolor{white}{--id=}\textcolor{yellow}{#1}~%
        \textcolor{white}{--title="}{\color{mf@term@green}\bfseries #2}\textcolor{white}{"}
    \end{tcolorbox}
}

% Gradient 样式: 多色渐变背景 (科技感)
% 💡 从左到右的彩虹渐变 + 白色标题文字
\newcommand{\mf@sectitle@gradient}[2]{%
    \par\vspace{18pt}
    \noindent
    \begin{tikzpicture}
        % 渐变背景矩形
        \shade[left color=blue!70!cyan, right color=purple!70!magenta, rounded corners=6pt]
            (0,0) rectangle (\textwidth, 1.6cm);
        % 编号圆形
        \fill[white, opacity=0.25] (0.8cm, 0.8cm) circle (0.55cm);
        \node at (0.8cm, 0.8cm) {\fontsize{24pt}{28pt}\selectfont\bfseries\color{white}#1};
        % 标题文字
        \node[anchor=west] at (1.8cm, 0.8cm) {\zihao{-3}\bfseries\color{white}#2};
    \end{tikzpicture}
    \par\vspace{15pt}
}

% Elegant 样式: 金色装饰线 (学术典雅风)
% 💡 上下金色装饰线 + 中央标题 + 衬线字体
\newcommand{\mf@sectitle@elegant}[2]{%
    \definecolor{mf@gold}{RGB}{180,140,60}
    \definecolor{mf@gold@light}{RGB}{240,220,180}
    \par\vspace{20pt}
    \begin{center}
        % 上装饰线
        \begin{tikzpicture}
            \draw[mf@gold, line width=0.8pt] (0,0) -- (0.15\textwidth,0);
            \fill[mf@gold] (0.16\textwidth, 0) circle (2pt);
            \node[inner sep=0] at (0.5\textwidth, 0) {\color{mf@gold}\tiny$\blacklozenge$~~$\blacklozenge$~~$\blacklozenge$};
            \fill[mf@gold] (0.84\textwidth, 0) circle (2pt);
            \draw[mf@gold, line width=0.8pt] (0.85\textwidth,0) -- (\textwidth,0);
        \end{tikzpicture}
        \par\vspace{8pt}
        % 标题
        {\fontsize{14pt}{18pt}\selectfont\color{mf@gold}\textsc{Section}~#1}\\[4pt]
        {\zihao{3}\bfseries\heiti #2}
        \par\vspace{8pt}
        % 下装饰线  
        \begin{tikzpicture}
            \draw[mf@gold, line width=0.8pt] (0,0) -- (0.3\textwidth,0);
            \draw[mf@gold, line width=0.8pt] (0.7\textwidth,0) -- (\textwidth,0);
        \end{tikzpicture}
    \end{center}
    \par\vspace{15pt}
}

% Blueprint 样式: 蓝图网格背景 (工程师风格)
% 💡 深蓝网格背景 + 白色工程字体 + 坐标标记
\newcommand{\mf@sectitle@blueprint}[2]{%
    \definecolor{mf@bp@bg}{RGB}{0,40,80}
    \definecolor{mf@bp@grid}{RGB}{0,80,140}
    \definecolor{mf@bp@line}{RGB}{100,180,255}
    \par\vspace{18pt}
    \noindent
    \begin{tikzpicture}
        % 背景
        \fill[mf@bp@bg] (0,0) rectangle (\textwidth, 1.5cm);
        % 网格线
        \foreach \x in {0,0.5,...,17} {
            \draw[mf@bp@grid, line width=0.3pt] (\x cm,0) -- (\x cm,1.5cm);
        }
        \foreach \y in {0,0.5,1,1.5} {
            \draw[mf@bp@grid, line width=0.3pt] (0,\y cm) -- (\textwidth,\y cm);
        }
        % 坐标角标
        \node[anchor=south west, font=\tiny\ttfamily, text=mf@bp@line] at (0.1cm, 0.1cm) {SEC-#1};
        % 编号
        \draw[mf@bp@line, line width=1.5pt] (0.8cm,0.3cm) -- (0.8cm,1.2cm) -- (1.3cm,1.2cm);
        \node[anchor=west, font=\fontsize{22pt}{26pt}\selectfont\bfseries, text=white] at (0.9cm, 0.75cm) {#1};
        % 标题
        \node[anchor=west, font=\zihao{-3}\bfseries, text=white] at (2.2cm, 0.75cm) {#2};
    \end{tikzpicture}
    \par\vspace{15pt}
}

% Ribbon 样式: 折叠丝带效果 (精致卡片风)
% 💡 左侧折叠丝带装饰 + 阴影层次感
\newcommand{\mf@sectitle@ribbon}[2]{%
    \definecolor{mf@rb@main}{RGB}{200,60,60}
    \definecolor{mf@rb@dark}{RGB}{140,40,40}
    \definecolor{mf@rb@bg}{RGB}{255,250,245}
    \par\vspace{18pt}
    \noindent
    \begin{tikzpicture}
        % 主卡片 (带阴影)
        \fill[black!15, rounded corners=4pt] (0.15cm,-0.1cm) rectangle (\textwidth+0.1cm, 1.4cm);
        \fill[mf@rb@bg, rounded corners=4pt] (0,0) rectangle (\textwidth, 1.5cm);
        \draw[mf@rb@main!30, line width=0.5pt, rounded corners=4pt] (0,0) rectangle (\textwidth, 1.5cm);
        % 左侧丝带主体
        \fill[mf@rb@main] (-0.3cm, 0.3cm) -- (1.8cm, 0.3cm) -- (1.8cm, 1.2cm) -- (-0.3cm, 1.2cm) -- cycle;
        % 丝带折叠部分 (深色三角)
        \fill[mf@rb@dark] (-0.3cm, 0.3cm) -- (0, 0) -- (0, 0.3cm) -- cycle;
        % 丝带尾部缺口
        \fill[mf@rb@bg] (1.8cm, 0.6cm) -- (1.5cm, 0.75cm) -- (1.8cm, 0.9cm) -- cycle;
        % 编号 (丝带上)
        \node[font=\fontsize{20pt}{24pt}\selectfont\bfseries, text=white] at (0.65cm, 0.75cm) {#1};
        % 标题
        \node[anchor=west, font=\zihao{-3}\heiti\bfseries, text=mf@rb@dark] at (2.1cm, 0.75cm) {#2};
    \end{tikzpicture}
    \par\vspace{15pt}
}

% [6.1] 样式选择器: 根据 secstyle 选项调用对应样式
\newcommand{\mf@simpletitle}[2]{%
    \ifx\mf@secstyle\mf@style@modern
        \mf@sectitle@modern{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@minimal
        \mf@sectitle@minimal{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@boxed
        \mf@sectitle@boxed{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@neon
        \mf@sectitle@neon{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@terminal
        \mf@sectitle@terminal{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@gradient
        \mf@sectitle@gradient{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@elegant
        \mf@sectitle@elegant{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@blueprint
        \mf@sectitle@blueprint{#1}{#2}%
    \else\ifx\mf@secstyle\mf@style@ribbon
        \mf@sectitle@ribbon{#1}{#2}%
    \else
        \mf@sectitle@classic{#1}{#2}%
    \fi\fi\fi\fi\fi\fi\fi\fi\fi
}
\def\mf@style@modern{modern}
\def\mf@style@minimal{minimal}
\def\mf@style@boxed{boxed}
\def\mf@style@neon{neon}
\def\mf@style@terminal{terminal}
\def\mf@style@gradient{gradient}
\def\mf@style@elegant{elegant}
\def\mf@style@blueprint{blueprint}
\def\mf@style@ribbon{ribbon}

\ifmf@book
    % Book 模式：使用 chapter，经典样式
    \ctexset{
        chapter = {
            format = {},
            nameformat = {},
            titleformat = {},
            aftername = {},
            beforeskip = 0pt,
            afterskip = 0pt,
            fixskip = true
        },
        section = {
            format = \zihao{3}\heiti\bfseries,
            beforeskip = 15pt,
            afterskip = 15pt
        },
        subsection = {
            format = \zihao{4}\heiti\bfseries,
            beforeskip = 10pt,
            afterskip = 10pt
        },
        subsubsection = {
            format = \zihao{-4}\songti,
            beforeskip = 8pt,
            afterskip = 8pt
        }
    }
    % 重定义 chapter 格式
    \renewcommand{\chapter}[1]{%
        \clearpage
        \refstepcounter{chapter}%
        \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
        \mf@chaptertitle{\thechapter}{#1}%
    }
\else\ifmf@report
    % Report 模式：使用 section 作为章，经典样式
    \ctexset{
        section = {
            format = {},
            nameformat = {},
            titleformat = {},
            aftername = {},
            beforeskip = 20pt,
            afterskip = 0pt,
            fixskip = true
        },
        subsection = {
            format = \zihao{4}\heiti\bfseries,
            beforeskip = 12pt,
            afterskip = 8pt,
            aftername = \hspace{1em}
        },
        subsubsection = {
            format = \zihao{-4}\songti,
            beforeskip = 8pt,
            afterskip = 6pt,
            aftername = \hspace{1em}
        }
    }
    % 使用 titlesec 重定义 section 格式
    \titleformat{\section}[block]
        {}  % format
        {}  % label
        {0pt}  % sep
        {\mf@chaptertitle{\arabic{section}}}  % before-code
        []  % after-code
\else
    % Note 模式 (默认)：简洁样式，使用类书风格的 section
    \ctexset{
        section = {
            format = {},
            nameformat = {},
            titleformat = {},
            aftername = {},
            beforeskip = 15pt,
            afterskip = 0pt,
            fixskip = true
        },
        subsection = {
            format = \zihao{4}\heiti\bfseries,
            beforeskip = 10pt,
            afterskip = 8pt,
            aftername = \hspace{1em}
        },
        subsubsection = {
            format = \zihao{-4}\heiti,
            beforeskip = 8pt,
            afterskip = 6pt,
            aftername = \hspace{1em}
        }
    }
    % 使用 titlesec 重定义 section 格式
    \titleformat{\section}[block]
        {}
        {}
        {0pt}
        {\mf@simpletitle{\arabic{section}}}
        []
\fi\fi

% 目录深度
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}


% ---------------------------------------------------------
% 7. 计数器与编号设置
% ---------------------------------------------------------
\ifmf@chapnum
    % 按章节编号
    \ifmf@book
        \counterwithin{equation}{chapter}
        \counterwithin{figure}{chapter}
        \counterwithin{table}{chapter}
    \else
        \counterwithin{equation}{section}
        \counterwithin{figure}{section}
        \counterwithin{table}{section}
    \fi
\fi


% ---------------------------------------------------------
% 8. 图表公式样式
% ---------------------------------------------------------
\setkeys{Gin}{draft=false}

% 浮动体参数优化
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.70}
\renewcommand{\textfraction}{0.10}
\renewcommand{\floatpagefraction}{0.50}

% Caption 样式
\DeclareCaptionFont{heiti}{\heiti}
\DeclareCaptionFont{fivehao}{\zihao{5}}
\captionsetup{
    format=hang,
    labelsep=quad,
    font={fivehao,heiti},
    labelfont={fivehao,heiti},
    textfont={fivehao,heiti},
    skip=6pt
}
\captionsetup[sub]{labelformat=simple}

% 长表格标题宽度
\AtBeginEnvironment{longtable}{\setlength{\LTcapwidth}{\textwidth}}
\AtBeginEnvironment{xltabular}{\setlength{\LTcapwidth}{\textwidth}}

% 编号格式
\renewcommand\thesubfigure{(\alph{subfigure})}
\ifmf@chapnum
    \ifmf@book
        \renewcommand{\theequation}{\thechapter-\arabic{equation}}
        \renewcommand{\thefigure}{\thechapter-\arabic{figure}}
        \renewcommand{\thetable}{\thechapter-\arabic{table}}
    \else
        \renewcommand{\theequation}{\thesection-\arabic{equation}}
        \renewcommand{\thefigure}{\thesection-\arabic{figure}}
        \renewcommand{\thetable}{\thesection-\arabic{table}}
    \fi
\fi

% 引用格式
\labelformat{figure}{图~#1}
\labelformat{table}{表~#1}
\labelformat{equation}{式~(#1)}

% 符号重定义
\renewcommand{\leq}{\leqslant}
\renewcommand{\geq}{\geqslant}


% ---------------------------------------------------------
% 9. 数学定理环境
% ---------------------------------------------------------
% 定理样式
\theoremstyle{plain}
\ifmf@book
    \newtheorem{theorem}{定理}[chapter]
\else\ifmf@chapnum
    \newtheorem{theorem}{定理}[section]
\else
    \newtheorem{theorem}{定理}
\fi\fi

\newtheorem{lemma}[theorem]{引理}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{corollary}[theorem]{推论}

% 定义样式
\theoremstyle{definition}
\ifmf@book
    \newtheorem{defn}{定义}[chapter]
    \newtheorem{example}{例}[chapter]
\else\ifmf@chapnum
    \newtheorem{defn}{定义}[section]
    \newtheorem{example}{例}[section]
\else
    \newtheorem{defn}{定义}
    \newtheorem{example}{例}
\fi\fi

% 注记样式
\theoremstyle{remark}
\newtheorem*{remark}{注}
\newtheorem*{solution}{解}

% 证明环境汉化
\renewcommand{\proofname}{证明}


% ---------------------------------------------------------



% ---------------------------------------------------------
% 10. 数学与深度学习专用宏
% ---------------------------------------------------------

% [10.1] 基础微积分与分析
% physics 包已提供 \dd (微分) 和 \grad (梯度)，此处不再重复定义
% \dd 会自动处理间距，如 \dd x
\newcommand{\dx}{\,\dd x}
\newcommand{\dy}{\,\dd y}
\newcommand{\dz}{\,\dd z}
\newcommand{\dt}{\,\dd t}
\newcommand{\ds}{\,\dd s}
\newcommand{\dw}{\,\dd w}
\newcommand{\dtau}{\,\dd \tau}
\newcommand{\dm}{\,\dd m}
\newcommand{\dmu}{\,\dd \mu}

% 算子
\newcommand{\pd}[2]{\frac{\partial #1}{\partial #2}}     % 偏导
\newcommand{\pdd}[2]{\frac{\partial^2 #1}{\partial #2^2}} % 二阶偏导
% \grad 已由 physics 提供 (\nabla)
\let\div\relax \DeclareMathOperator{\div}{div}        % 散度
\let\curl\relax \DeclareMathOperator{\curl}{curl}     % 旋度 (重定义为 textual operator)
\DeclareMathOperator{\lap}{\Delta}                     % 拉普拉斯
\DeclareMathOperator{\supp}{supp}                      % 支集
\DeclareMathOperator{\dist}{dist}                      % 距离
\DeclareMathOperator{\diam}{diam}                      % 直径
\DeclareMathOperator*{\argmin}{arg\,min}               % argmin
\DeclareMathOperator*{\argmax}{arg\,max}               % argmax

% 极限与收敛
\newcommand{\limn}{\lim_{n\to\infty}}
\newcommand{\limk}{\lim_{k\to\infty}}
\newcommand{\limx}[1][0]{\lim_{x\to #1}}
\newcommand{\weakto}{\rightharpoonup}                  % 弱收敛
\newcommand{\embeds}{\hookrightarrow}                  % 嵌入
\newcommand{\compactembeds}{\subset\subset}            % 紧嵌入

% 常用积分
\newcommand{\intR}{\int_{\R}}
\newcommand{\intRn}{\int_{\R^n}}
\newcommand{\intO}{\int_\Omega}
\newcommand{\intpO}{\int_{\partial\Omega}}

% 函数空间
\newcommand{\Cinf}{C^\infty}
\newcommand{\Cc}{C_c^\infty}                           % 紧支集光滑函数
\newcommand{\Lp}[1][p]{L^{#1}}                         % Lp 空间
\newcommand{\Wkp}[2]{W^{#1,#2}}                        % Sobolev 空间 W^{k,p}
\newcommand{\Hk}[1][1]{H^{#1}}                         % Hilbert 空间 H^k
\newcommand{\normL}[2][p]{\norm{#2}_{L^{#1}}}          % Lp 范数

% [10.2] 集合与逻辑
\newcommand{\set}[1]{\{#1\}}
\newcommand{\Set}[1]{\left\{#1\right\}}
\newcommand{\st}{\;|\;}                                % such that
\newcommand{\lra}{\Longleftrightarrow}                 % 等价
\newcommand{\ra}{\Longrightarrow}                      % 推出

% [10.3] 深度学习扩展
% 损失函数
\newcommand{\loss}{\ensuremath{\mathcal{L}}}           % 损失函数
\DeclareMathOperator{\MSE}{MSE}
\DeclareMathOperator{\CE}{CE}
\DeclareMathOperator{\BCE}{BCE}
\DeclareMathOperator{\KLdiv}{KL}

% 数据与模型
\newcommand{\data}{\ensuremath{\mathcal{D}}}           % 数据集
\newcommand{\model}{\ensuremath{\mathcal{M}}}          % 模型
\newcommand{\param}{\ensuremath{\bm{\theta}}}          % 参数向量
\newcommand{\weight}{\ensuremath{\bm{W}}}              % 权重矩阵
\newcommand{\bias}{\ensuremath{\bm{b}}}                % 偏置向量

% 概率与期望
\DeclareMathOperator*{\expect}{\mathbb{E}}             % 期望
\newcommand{\prob}{\ensuremath{\mathbb{P}}}            % 概率
\DeclareMathOperator{\Var}{Var}                        % 方差
\DeclareMathOperator{\Cov}{Cov}                        % 协方差

% 激活函数
\DeclareMathOperator{\relu}{ReLU}
\newcommand{\sigmoid}{\ensuremath{\sigma}}
\DeclareMathOperator{\softmax}{softmax}
\DeclareMathOperator{\tanhfunc}{tanh}

% 网络层
\newcommand{\LSTM}{\mathrm{LSTM}}
\newcommand{\GRU}{\mathrm{GRU}}
\newcommand{\Conv}{\mathrm{Conv}}
\newcommand{\Pool}{\mathrm{Pool}}
\newcommand{\BatchNorm}{\mathrm{BatchNorm}}
\newcommand{\Dropout}{\mathrm{Dropout}}

% 向量与矩阵
\newcommand{\vect}[1]{\ensuremath{\bm{#1}}}            % 向量
\newcommand{\mat}[1]{\ensuremath{\bm{#1}}}             % 矩阵
\newcommand{\tensor}[1]{\ensuremath{\mathcal{#1}}}     % 张量

% [10.4] 常用集合
\newcommand{\R}{\ensuremath{\mathbb{R}}}               % 实数集
\newcommand{\N}{\ensuremath{\mathbb{N}}}               % 自然数集
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}               % 整数集
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}               % 有理数集
\newcommand{\C}{\ensuremath{\mathbb{C}}}               % 复数集


% ---------------------------------------------------------
% 11. PDF 属性设置
% ---------------------------------------------------------
\hypersetup{
    hidelinks,
    colorlinks=false,
    bookmarksnumbered=true,
    bookmarksopen=true,
    pdfstartview=FitH
}

\AtBeginDocument{
    \hypersetup{
        pdftitle={\@title},
        pdfauthor={\@author},
        pdfsubject={Math \& Deep Learning Notes},
        pdfcreator={MindFlow LaTeX Class}
    }
}


% ---------------------------------------------------------
% 12. 高级图文混排环境
% ---------------------------------------------------------
% [12.1] 图文混排环境 (textfigure)
\newsavebox{\tf@textbox}
\newlength{\tf@imagew}
\newlength{\tf@textw}
\def\tf@left{left}

\NewDocumentEnvironment{textfigure}{O{right} m m O{0.4}}{%
    \def\tf@pos{#1}%
    \def\tf@path{#2}%
    \def\tf@cap{#3}%
    \setlength{\tf@imagew}{#4\textwidth}%
    \setlength{\tf@textw}{\textwidth}%
    \addtolength{\tf@textw}{-\tf@imagew}%
    \addtolength{\tf@textw}{-1.5em}%
    \begin{lrbox}{\tf@textbox}%
        \begin{minipage}{\tf@textw}%
            \setlength{\parindent}{2em}%
            \linespread{1.5}\selectfont%
}{%
        \end{minipage}%
    \end{lrbox}%
    \par\vspace{1em}\noindent
    \ifx\tf@pos\tf@left
        \begin{minipage}[c]{\tf@imagew}
            \centering
            \includegraphics[width=\linewidth]{\tf@path}
            \captionsetup{hypcap=false}%
            \captionof{figure}{\tf@cap}
        \end{minipage}%
        \hfill
        \usebox{\tf@textbox}
    \else
        \usebox{\tf@textbox}%
        \hfill
        \begin{minipage}[c]{\tf@imagew}
            \centering
            \includegraphics[width=\linewidth]{\tf@path}
            \captionsetup{hypcap=false}%
            \captionof{figure}{\tf@cap}
        \end{minipage}
    \fi
    \par\vspace{1em}
}

% [12.2] 并行图片环境 (parallelfigures)
\newcommand{\pf@maincap}{}
\NewDocumentEnvironment{parallelfigures}{m}{%
    \renewcommand{\pf@maincap}{#1}%
    \begin{figure}[H]
        \centering
        \newcommand{\addfig}[3][0.48]{%
            \begin{subfigure}[b]{##1\textwidth}
                \centering
                \includegraphics[width=\linewidth]{##2}
                \caption{##3}
            \end{subfigure}%
            \hspace{\fill}%
        }%
}{%
        \caption{\pf@maincap}%
    \end{figure}%
}

% [12.3] 多图行环境 (figurerow)
\newcommand{\fr@maincap}{}
\newcommand{\fr@cols}{2}
\NewDocumentEnvironment{figurerow}{m O{2}}{%
    \renewcommand{\fr@maincap}{#1}%
    \renewcommand{\fr@cols}{#2}%
    \begin{figure}[H]
        \centering
        \newlength{\fr@width}%
        \setlength{\fr@width}{\dimexpr(\textwidth-1em*#2)/#2\relax}%
        \newcommand{\figitem}[2]{%
            \begin{subfigure}[b]{\fr@width}
                \centering
                \includegraphics[width=\linewidth]{##1}
                \caption{##2}
            \end{subfigure}\hfill
        }%
}{%
        \caption{\fr@maincap}
    \end{figure}
}

% [12.4] 网格图片环境 (figuregrid)
\newcommand{\fg@maincap}{}
\NewDocumentEnvironment{figuregrid}{m}{%
    \renewcommand{\fg@maincap}{#1}%
    \begin{figure}[H]
        \centering
        \newcommand{\gridrow}[1]{%
            ##1\par\vspace{0.5em}%
        }%
        \newcommand{\gridfig}[3][0.48]{%
            \begin{subfigure}[b]{##1\textwidth}
                \centering
                \includegraphics[width=\linewidth]{##2}
                \caption{##3}
            \end{subfigure}\hfill
        }%
}{%
        \caption{\fg@maincap}
    \end{figure}
}


% ---------------------------------------------------------
% 13. 代码环境配置
% ---------------------------------------------------------
\RequirePackage{listings}
\RequirePackage[most,listings,xparse,breakable]{tcolorbox}

% ---------------------------------------------------------
% 13.0 美化定理环境 (tcolorbox 版本)
% ---------------------------------------------------------
% 💡 说明：以下 *new 环境与原环境共享计数器，提供精美的可视化效果
% 编号格式统一为 section-编号 (或 chapter-编号 在 book 模式下)

% === 配色方案 ===
\definecolor{mf@thm@blue}{RGB}{30,90,150}      % 定理蓝
\definecolor{mf@thm@bluebg}{RGB}{235,245,255}  % 定理背景
\definecolor{mf@lem@teal}{RGB}{0,128,128}      % 引理青
\definecolor{mf@lem@tealbg}{RGB}{230,250,250}  % 引理背景
\definecolor{mf@prop@purple}{RGB}{100,50,150}  % 命题紫
\definecolor{mf@prop@purplebg}{RGB}{245,235,255} % 命题背景
\definecolor{mf@cor@orange}{RGB}{200,100,0}    % 推论橙
\definecolor{mf@cor@orangebg}{RGB}{255,245,230} % 推论背景
\definecolor{mf@def@green}{RGB}{0,100,60}      % 定义绿
\definecolor{mf@def@greenbg}{RGB}{235,250,240} % 定义背景
\definecolor{mf@ex@brown}{RGB}{150,80,40}      % 例题棕
\definecolor{mf@ex@brownbg}{RGB}{255,250,240}  % 例题背景
\definecolor{mf@rem@gray}{RGB}{80,80,80}       % 注记灰
\definecolor{mf@rem@graybg}{RGB}{245,245,245}  % 注记背景
\definecolor{mf@prf@darkblue}{RGB}{40,60,100}  % 证明深蓝
\definecolor{mf@prf@darkbluebg}{RGB}{248,250,255} % 证明背景

% === 基础样式模板 ===
\tcbset{
    mf@thmbase/.style={
        enhanced,
        breakable,
        sharp corners,
        boxrule=0pt,
        left=10pt,
        right=10pt,
        top=22pt,           % 💡 增加顶部内边距，为标题框留出空间
        bottom=10pt,
        before skip=20pt,
        after skip=20pt,
        fonttitle=\bfseries\heiti,
        separator sign={~},
        description font=\normalfont\heiti,
        description delimiters parenthesis,
        terminator sign={.},
    },
    mf@thmframe/.style={
        mf@thmbase,
        borderline west={3pt}{0pt}{#1},
        colback=#1!8!white,
        coltitle=#1,
        colbacktitle=white,
        attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2-2pt},
        boxed title style={
            colback=white,
            colframe=#1,
            boxrule=1pt,
            arc=3pt,
            left=5pt,
            right=5pt,
            top=3pt,
            bottom=3pt
        }
    }
}

% === theoremnew: 定理 (蓝色) ===
\newtcolorbox[use counter=theorem, number within=section]{theoremnew}[2][]{
    mf@thmframe=mf@thm@blue,
    colback=mf@thm@bluebg,
    title={定理~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === lemmanew: 引理 (青色) ===
\newtcolorbox[use counter=theorem]{lemmanew}[2][]{
    mf@thmframe=mf@lem@teal,
    colback=mf@lem@tealbg,
    title={引理~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === propositionnew: 命题 (紫色) ===
\newtcolorbox[use counter=theorem]{propositionnew}[2][]{
    mf@thmframe=mf@prop@purple,
    colback=mf@prop@purplebg,
    title={命题~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === corollarynew: 推论 (橙色) ===
\newtcolorbox[use counter=theorem]{corollarynew}[2][]{
    mf@thmframe=mf@cor@orange,
    colback=mf@cor@orangebg,
    title={推论~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === defnnew: 定义 (绿色) ===
\newtcolorbox[use counter=defn, number within=section]{defnnew}[2][]{
    mf@thmframe=mf@def@green,
    colback=mf@def@greenbg,
    title={定义~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === examplenew: 例 (棕色) ===
\newtcolorbox[use counter=example, number within=section]{examplenew}[2][]{
    mf@thmframe=mf@ex@brown,
    colback=mf@ex@brownbg,
    title={例~\thetcbcounter\ifblank{#2}{}{~(#2)}},
    #1
}

% === remarknew: 注 (灰色，无编号) ===
\newtcolorbox{remarknew}[1][]{
    mf@thmbase,
    borderline west={2pt}{0pt}{mf@rem@gray},
    colback=mf@rem@graybg,
    coltitle=mf@rem@gray,
    fonttitle=\bfseries\heiti,
    title={注},
    #1
}

% === proofnew: 证明 (深蓝色，无编号) ===
\newtcolorbox{proofnew}[1][]{
    mf@thmbase,
    borderline west={2pt}{0pt}{mf@prf@darkblue},
    colback=mf@prf@darkbluebg,
    coltitle=mf@prf@darkblue,
    fonttitle=\bfseries\heiti,
    title={证明},
    after upper={\hfill$\square$},
    #1
}

% === solutionnew: 解 (与证明类似) ===
\newtcolorbox{solutionnew}[1][]{
    mf@thmbase,
    borderline west={2pt}{0pt}{mf@ex@brown},
    colback=mf@ex@brownbg,
    coltitle=mf@ex@brown,
    fonttitle=\bfseries\heiti,
    title={解},
    #1
}

% [13.1] 计数器
\newcounter{mfcode}[section]
\renewcommand{\themfcode}{\thesection-\arabic{mfcode}}

% [13.2] 配色 (VSCode Light)
\definecolor{mf@codeback}{RGB}{250,250,250}
\definecolor{mf@codeframe}{RGB}{220,220,220}
\definecolor{mf@keyword}{RGB}{0,92,197}
\definecolor{mf@comment}{RGB}{80,161,79}
\definecolor{mf@string}{RGB}{227,17,108}
\definecolor{mf@number}{RGB}{160,160,160}

% [13.3] listings 样式
\lstdefinestyle{mfstyle}{
    basicstyle=\small\ttfamily,
    keywordstyle=\bfseries\color{mf@keyword},
    commentstyle=\itshape\color{mf@comment},
    stringstyle=\color{mf@string},
    numberstyle=\tiny\color{mf@number},
    numbers=left,
    numbersep=10pt,
    stepnumber=1,
    breaklines=true,
    breakatwhitespace=false,
    showstringspaces=false,
    showtabs=false,
    captionpos=b,
    frame=none,
    extendedchars=false,
    escapechar=,
    upquote=true,
    tabsize=4,
    keepspaces=true,
    mathescape=false,
    texcl=false,
    columns=flexible
}

% [13.4] tcolorbox 样式 (Mac 风格)
\tcbset{
    mfcodestyle/.style={
        enhanced,
        breakable,
        colback=mf@codeback,
        colframe=mf@codeframe,
        listing only,
        title={\textbf{代码 \themfcode：}#1},
        coltitle=black,
        fonttitle=\bfseries\heiti\small,
        attach boxed title to top center={yshift=-3mm},
        boxed title style={
            colback=white,
            colframe=mf@codeframe,
            boxrule=0.5pt,
            arc=3pt,
            drop shadow
        },
        sharp corners,
        rounded corners=southeast,
        arc=5pt,
        top=12pt, bottom=2pt, left=6pt, right=6pt,
        boxrule=0.8pt,
        drop shadow,
        overlay unbroken and first={
            \draw[fill=red!70!white, draw=none] ([xshift=6mm,yshift=-1.5mm]frame.north west) circle (2.5pt);
            \draw[fill=yellow!70!white, draw=none] ([xshift=11mm,yshift=-1.5mm]frame.north west) circle (2.5pt);
            \draw[fill=green!70!white, draw=none] ([xshift=16mm,yshift=-1.5mm]frame.north west) circle (2.5pt);
        }
    }
}

% [13.5] codeblock 环境
\newtcblisting{codeblock}[2][c]{
    mfcodestyle={#2},
    listing engine=listings,
    listing options={style=mfstyle, language=#1},
    code={\refstepcounter{mfcode}}
}

% [13.6] filecode 命令
\NewDocumentCommand{\filecode}{O{c} m m}{%
    \refstepcounter{mfcode}%
    \tcbinputlisting{
        mfcodestyle={#2},
        listing engine=listings,
        listing file={#3},
        listing options={style=mfstyle, language=#1}
    }%
}


% ---------------------------------------------------------
% 14. 提示框环境
% ---------------------------------------------------------
\tcbset{
    commonbox/.style={
        enhanced,
        breakable,
        sharp corners,
        rounded corners=southeast,
        arc=4pt,
        boxrule=1pt,
        drop shadow,
        attach boxed title to top left={yshift=-2mm, xshift=5mm},
        boxed title style={boxrule=0pt, colframe=white, colback=white},
        fonttitle=\bfseries\heiti,
        top=12pt
    }
}

% 注意框 (蓝色)
\newtcolorbox{notice}[1]{
    commonbox,
    colback=Azure1,
    colframe=DodgerBlue3,
    coltitle=DodgerBlue3,
    title={【注意】#1}
}

% 定义框 (绿色) - 注意与 defn 定理环境区分
\newtcolorbox{defbox}[1]{
    commonbox,
    colback=Honeydew1,
    colframe=ForestGreen,
    coltitle=ForestGreen,
    title={【定义】#1}
}

% 结论框 (红色)
\newtcolorbox{conclusion}[1]{
    commonbox,
    colback=LavenderBlush1,
    colframe=Crimson,
    coltitle=Crimson,
    title={【结论】#1}
}

% 技巧框 (紫色)
\newtcolorbox{tip}[1]{
    commonbox,
    colback=Lavender,
    colframe=DarkOrchid,
    coltitle=DarkOrchid,
    title={【技巧】#1}
}

% 警告框 (橙色)
\newtcolorbox{warning}[1]{
    commonbox,
    colback=LemonChiffon,
    colframe=DarkOrange,
    coltitle=DarkOrange,
    title={【警告】#1}
}


% ---------------------------------------------------------
% 15. 列表环境优化
% ---------------------------------------------------------
\RequirePackage{amssymb}

% 绘图标号
\newcommand{\mf@item@square}{%
    \tikz[baseline=-0.6ex] \node[fill=black, shape=rectangle, inner sep=0pt, minimum size=0.5em] {};%
}
\newcommand{\mf@item@circle}{%
    \tikz[baseline=-0.6ex] \node[fill=darkgray, shape=circle, inner sep=0pt, minimum size=0.35em] {};%
}
\newcommand{\mf@item@dash}{%
    \tikz[baseline=-0.6ex] \draw[line width=0.8pt] (0,0) -- (0.5em,0);%
}
\newcommand{\mf@circled}[1]{%
    \begin{tikzpicture}[baseline=(char.base)]
        \node[shape=circle, draw=black, inner sep=0.5pt, minimum size=1.2em, line width=0.6pt] (char) {\small\bfseries #1};
    \end{tikzpicture}%
}
\newcommand{\mf@squared}[1]{%
    \begin{tikzpicture}[baseline=(char.base)]
        \node[shape=rectangle, draw=black, fill=black, text=white, rounded corners=2pt, inner sep=1pt, minimum size=1.2em] (char) {\small\bfseries #1};
    \end{tikzpicture}%
}

% 全局列表设置
\setlist{
    nosep,
    itemsep=3pt,
    parsep=0pt,
    topsep=4pt,
    partopsep=0pt
}

% 无序列表
\setlist[itemize,1]{label=\protect\mf@item@square, leftmargin=2.0em, labelsep=0.6em}
\setlist[itemize,2]{label=\protect\mf@item@circle, leftmargin=1.8em, labelsep=0.6em}
\setlist[itemize,3]{label=\protect\mf@item@dash, leftmargin=1.8em, labelsep=0.6em}

% 有序列表
\setlist[enumerate,1]{label=\arabic*., leftmargin=2.0em, labelsep=0.5em}
\setlist[enumerate,2]{label=(\arabic*), leftmargin=2.0em, labelsep=0.5em}

% 自定义样式
\newlist{enumpar}{enumerate}{1}
\setlist[enumpar]{label=(\arabic*), leftmargin=2.5em, labelsep=0.5em, itemsep=2pt, align=left}

\newlist{enumbra}{enumerate}{1}
\setlist[enumbra]{label=\arabic*), leftmargin=2.5em, labelsep=0.5em, itemsep=2pt, align=left}

\newlist{enumcircled}{enumerate}{1}
\setlist[enumcircled]{label=\protect\mf@circled{\arabic*}, leftmargin=2.8em, labelsep=0.6em, itemsep=3pt}

\newlist{enumsquared}{enumerate}{1}
\setlist[enumsquared]{label=\protect\mf@squared{\arabic*}, leftmargin=2.8em, labelsep=0.6em, itemsep=3pt}


% ---------------------------------------------------------
% 16. 导读与总结环境
% ---------------------------------------------------------

% 配色
\definecolor{mf@intro@frame}{RGB}{100, 100, 180} % 淡靛蓝
\definecolor{mf@intro@bg}{RGB}{245, 245, 255}
\definecolor{mf@sum@frame}{RGB}{60, 140, 100}   % 深海绿
\definecolor{mf@sum@bg}{RGB}{245, 255, 248}

% 导读环境 (Intro)
\newtcolorbox{introbox}[1][本章导读]{
    enhanced,
    colback=mf@intro@bg,
    colframe=mf@intro@frame,
    fonttitle=\bfseries\heiti\large,
    coltitle=white,
    title={#1},
    attach boxed title to top left={xshift=20pt, yshift*=-\tcboxedtitleheight/2},
    boxed title style={
        colback=mf@intro@frame,
        frame hidden,
        arc=4pt,
        rounded corners,
    },
    drop shadow,
    arc=6pt,
    before skip=15pt,
    after skip=15pt,
    overlay={
        \node[anchor=north east, opacity=0.1] at ([xshift=-10pt, yshift=-5pt]frame.north east) {\Huge\itshape i};
    }
}

% 总结环境 (Summary)
\newtcolorbox{summarybox}[1][本章小结]{
    enhanced,
    colback=mf@sum@bg,
    colframe=mf@sum@frame,
    fonttitle=\bfseries\heiti\large,
    coltitle=white,
    title={#1},
    attach boxed title to top right={xshift=-20pt, yshift*=-\tcboxedtitleheight/2},
    boxed title style={
        colback=mf@sum@frame,
        frame hidden,
        arc=4pt,
        rounded corners,
    },
    drop shadow,
    arc=6pt,
    before skip=15pt,
    after skip=15pt
}


% ---------------------------------------------------------
% 16. 批注系统
% ---------------------------------------------------------
\tcbset{
    mf@todostyle/.style={
        enhanced,
        breakable,
        width=\textwidth,
        sharp corners,
        rounded corners=southeast,
        arc=3pt,
        boxrule=1pt,
        left=4pt, right=4pt, top=2pt, bottom=2pt,
        before skip=8pt, after skip=8pt,
        fonttitle=\bfseries\small,
        attach boxed title to top left={yshift=-2mm, xshift=3mm},
        boxed title style={boxrule=0pt, colframe=white}
    }
}

% TODO 待办
\newcommand{\todo}[1]{%
    \begin{tcolorbox}[
        mf@todostyle,
        colback=orange!5,
        colframe=orange!80!black,
        coltitle=orange!80!black,
        boxed title style={colback=orange!10},
        title={TODO (待办)}
    ]
        #1
    \end{tcolorbox}%
}

% FIXME 需修正
\newcommand{\fixme}[1]{%
    \begin{tcolorbox}[
        mf@todostyle,
        colback=red!5,
        colframe=red!75!black,
        coltitle=red!75!black,
        boxed title style={colback=red!10},
        title={FIXME (需修正)}
    ]
        #1
    \end{tcolorbox}%
}

% NOTE 备注
\newcommand{\notebox}[1]{%
    \begin{tcolorbox}[
        mf@todostyle,
        colback=blue!5,
        colframe=blue!65!black,
        coltitle=blue!65!black,
        boxed title style={colback=blue!10},
        title={NOTE (备注)}
    ]
        #1
    \end{tcolorbox}%
}


% ---------------------------------------------------------
% 17. 教程展示环境
% ---------------------------------------------------------
\definecolor{mf@demo@codebg}{RGB}{248,248,248}
\definecolor{mf@demo@resultbg}{RGB}{255,255,245}
\definecolor{mf@demo@frame}{RGB}{200,200,200}
\definecolor{mf@api@bg}{RGB}{240,248,255}
\definecolor{mf@api@frame}{RGB}{70,130,180}

% 代码展示样式
\lstdefinestyle{demostyle}{
    basicstyle=\small\ttfamily,
    keywordstyle=\bfseries\color{mf@keyword},
    commentstyle=\itshape\color{mf@comment},
    stringstyle=\color{mf@string},
    backgroundcolor=\color{mf@demo@codebg},
    frame=none,
    breaklines=true,
    showstringspaces=false,
    tabsize=2,
    columns=flexible,
    keepspaces=true,
    extendedchars=false,
    texcl=false,
    mathescape=false
}

% democode 环境
\newtcblisting{democode}[1]{
    enhanced,
    breakable,
    title={#1},
    fonttitle=\bfseries\heiti,
    coltitle=black,
    colbacktitle=gray!15,
    colframe=mf@demo@frame,
    boxrule=0.8pt,
    arc=3pt,
    listing engine=listings,
    listing options={style=demostyle},
    sidebyside,
    sidebyside align=top,
    lefthand ratio=0.5,
    righthand width=0.46\linewidth,
    colback=mf@demo@codebg,
    segmentation style={solid, mf@demo@frame},
    bicolor,
    colbacklower=mf@demo@resultbg,
    left=3pt, right=3pt, top=2pt, bottom=2pt,
    middle=3pt
}

% demovert 环境
\newtcblisting{demovert}[1]{
    enhanced,
    breakable,
    title={#1},
    fonttitle=\bfseries\heiti,
    coltitle=black,
    colbacktitle=gray!15,
    colframe=mf@demo@frame,
    boxrule=0.8pt,
    arc=3pt,
    listing engine=listings,
    listing options={style=demostyle},
    listing and text,
    colback=mf@demo@codebg,
    segmentation style={solid, mf@demo@frame},
    bicolor,
    colbacklower=mf@demo@resultbg,
    left=5pt, right=5pt, top=3pt, bottom=3pt,
    middle=3pt
}

% codeonly 环境
\newtcblisting{codeonly}[1]{
    enhanced,
    breakable,
    title={#1},
    fonttitle=\bfseries\heiti,
    coltitle=black,
    colbacktitle=gray!15,
    colframe=mf@demo@frame,
    colback=mf@demo@codebg,
    boxrule=0.8pt,
    arc=3pt,
    listing engine=listings,
    listing options={style=demostyle},
    listing only,
    left=5pt, right=5pt, top=3pt, bottom=3pt
}

% API 卡片
\newcommand{\apibox}[3]{%
    \begin{tcolorbox}[
        enhanced,
        colback=mf@api@bg,
        colframe=mf@api@frame,
        boxrule=1pt,
        arc=4pt,
        left=8pt, right=8pt, top=6pt, bottom=6pt,
        fonttitle=\bfseries\ttfamily,
        title={\textbackslash #1},
        coltitle=white,
        colbacktitle=mf@api@frame,
        attach boxed title to top left={xshift=5mm, yshift=-3mm},
        boxed title style={arc=2pt, boxrule=0pt}
    ]
    \textbf{参数：} \texttt{#2} \\[3pt]
    \textbf{说明：} #3
    \end{tcolorbox}
}

% 选项列表
\newenvironment{optionlist}{%
    \par\vspace{0.5em}%
    \noindent%
}{%
    \par\vspace{0.5em}%
}

\newcommand{\option}[2]{%
    \noindent\hspace{1em}%
    \texttt{\bfseries\color{mf@api@frame}#1}%
    \hspace{0.5em}---\hspace{0.5em}#2%
    \par\vspace{0.3em}%
}

% 行内代码命令
\newcommand{\cmd}[1]{\texttt{\textbackslash #1}}
\newcommand{\env}[1]{\texttt{#1}}
\newcommand{\opt}[1]{\texttt{[#1]}}


% ---------------------------------------------------------
% 18. 附录环境
% ---------------------------------------------------------
\newenvironment{appendixblock}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{section}{附录}
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \renewcommand{\thesection}{\Alph{section}}
    \ctexset{
        section = {
            name = {附录,},
            number = \thesection,
            format = \centering\zihao{4}\heiti\bfseries
        }
    }
    \titlecontents{section}[0pt]
    {\addvspace{6pt}\bfseries\heiti\zihao{4}}
    {附录\thecontentslabel\quad}
    {}
    {\titlerule*[0.5pc]{.}\contentspage}
}{}


% ---------------------------------------------------------
% 19. 参考文献
% ---------------------------------------------------------
\newcommand{\upcite}[1]{%
    \textsuperscript{\cite{#1}}%
}

\newcommand{\MyBibliography}[1]{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{section}{参考文献}
    \renewcommand{\section}[2]{}%
    \bibliographystyle{plain}
    \bibliography{#1}
}


% ---------------------------------------------------------
% 20. 目录树
% ---------------------------------------------------------
\RequirePackage{dirtree}
\renewcommand{\DTstyle}{\ttfamily\small}


% [21.3] 术语表 (Nomenclature)
\RequirePackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nomname}{术语与符号表}
\setlength{\nomitemsep}{-\parsep} % 紧凑排列

% [21.4] 分章参考文献 (Chapterbib)
% 仅在 book 模式下且非 review 模式推荐使用
\ifmf@book
    \RequirePackage{chapterbib}
\fi

% [21.5] 徽章系统 (Badges)
\newcommand{\mfbadge}[3][mf@thm@blue]{%
    \tikz[baseline=(b.base)]{
        \node[inner sep=2pt, font=\sffamily\tiny\bfseries, text=white, fill=#1!80!black, rounded corners=2pt, anchor=west] (b) at (0,0) {#2\hspace{2pt}\vrule\hspace{2pt}#3};
    }%
}

% 仿 GitHub 风格 (左灰右蓝)
\newcommand{\ghbadge}[2]{%
    \tikz[baseline=(text.base)]{
        \node[fill=gray!30, inner sep=2pt, rounded corners=2pt, font=\tiny\sffamily] (label) at (0,0) {#1};
        \node[fill=mf@thm@blue, text=white, inner sep=2pt, rounded corners=2pt, font=\tiny\sffamily, anchor=west] (text) at (label.east) {\hspace{-2pt}#2};
    }%
}


% ---------------------------------------------------------
% 22. 学术封面设计
% ---------------------------------------------------------
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\advisor}[1]{\gdef\@advisor{#1}}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand{\version}[1]{\gdef\@version{#1}}
\newcommand{\coverdate}[1]{\gdef\@coverdate{#1}}

% 默认值
\gdef\@subtitle{}
\gdef\@advisor{}
\gdef\@institute{MindFlow Lab}
\gdef\@version{1.0}
\gdef\@coverdate{\today}

\newcommand{\makecover}{
    \begin{titlepage}
        \linespread{1.2}
        \begin{center}
            \vspace*{2cm}
            % 标题
            \Huge\heiti\bfseries \@title \\
            \vspace{0.5cm}
            \Large\heiti \@subtitle \\
            
            \vspace{3cm}
            
            \ifmf@review
                \textcolor{red}{\Huge DRAFT / CONFIDENTIAL} \\
            \else
                % 装饰线
                \begin{tikzpicture}
                    \draw[thick, mf@thm@blue] (0,0) -- (\textwidth,0);
                    \draw[thick, mf@thm@blue] (0,0.1) -- (\textwidth,0.1);
                \end{tikzpicture}
            \fi
            
            \vspace{3cm}
            
            % 信息块
            \Large\songti
            \begin{tabular}{rl}
                \textbf{作者：} & \@author \\
                \ifblank{\@advisor}{}{\textbf{导师：} & \@advisor \\}
                \textbf{机构：} & \@institute \\
                \textbf{版本：} & \@version \\
                \textbf{日期：} & \@coverdate
            \end{tabular}
            
            \vfill
            
            % 底部 Logo (可选，此处用文字代替)
            {\large\scshape MindFlow Academic Template}
            \vspace{1cm}
            
        \end{center}
    \end{titlepage}
}

\makeatother
% =========================================================
% End of MindFlow Class File
% =========================================================
