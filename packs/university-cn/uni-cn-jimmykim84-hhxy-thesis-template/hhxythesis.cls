%%=====================================================================
%%  hhxythesis.cls —— 怀化学院本科生毕业论文（设计、创作）LaTeX 模板
%%
%%  作者：张乐冰 怀化学院 计算机与人工智能学院
%%  版本：V1.1.5  2026.9.10
%%  项目主页： https://github.com/jimmykim84/hhxy-thesis-template
%%
%%  特别说明：本模板为非官方模板，仅参照本校学位论文格式制作，仅供排版参考；不代表学校官方要求，也不代表示例论文内容正确。如与学校最新官方文件冲突，以学校官方文件为准。
%%
%%  依据：《怀化学院本科毕业论文(设计、创作)撰写规范及装订要求》
%%        （"本科生毕业论文格式.doc"，下称《规范》）
%%  编译：xelatex（依赖 fontspec / xeCJK 调用系统中文与西文字体）
%%  平台字体：自动识别 Windows / macOS 选用对应系统字体
%%           （亦可显式指定 [winfonts] / [macfonts] 覆盖自动判断）
%%
%%  凡范本（毕业设计（范本）.docx）与《规范》冲突处，一律以《规范》为准，
%%  相关取舍已在 %%【规范】 注释中说明。
%%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hhxythesis}[2026/09/10 v1.0 Huaihua University Thesis Template]

%%---------------------------------------------------------------
%%  一、类选项
%%---------------------------------------------------------------
\newif\ifhhxy@twoside      \hhxy@twosidefalse
\newif\ifhhxy@winfonts     \hhxy@winfontsfalse
\newif\ifhhxy@fontsoverride \hhxy@fontsoverridefalse

\DeclareOption{twoside}{\hhxy@twosidetrue}
\DeclareOption{oneside}{\hhxy@twosidefalse}
\DeclareOption{winfonts}{\hhxy@winfontstrue\hhxy@fontsoverridetrue}   % Windows 字体方案（显式覆盖）
\DeclareOption{macfonts}{\hhxy@winfontsfalse\hhxy@fontsoverridetrue}  % macOS 字体方案（显式覆盖）
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

%% 自动按操作系统选择字体方案：Windows → winfonts，其余(macOS/Linux) → macfonts。
%% 若用户显式给了 [winfonts]/[macfonts]，则以手动指定为准（\hhxy@fontsoverride）。
\ifhhxy@fontsoverride\else
  \RequirePackage{expl3}%
  \ExplSyntaxOn
  \sys_if_platform_windows:TF
    { \hhxy@winfontstrue }
    { \hhxy@winfontsfalse }
  \ExplSyntaxOff
\fi

\ifhhxy@twoside
  \PassOptionsToClass{twoside}{ctexart}
\else
  \PassOptionsToClass{oneside}{ctexart}
\fi
\LoadClass[a4paper,12pt,heading=true]{ctexart}
\makeatletter  %% 类文件内全程把 @ 视为字母

%%---------------------------------------------------------------
%%  二、基础宏包
%%---------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs,longtable,multirow,makecell,array}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{indentfirst}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage[normalem]{ulem}        % \uline：逐行下划线（每行撑满，含末行）
\RequirePackage{xeCJKfntef}            % 关键：加载后 \uline 才能对无空格的长中文断行，
                                       % 否则整段中文被当成一个不可断的词 → Overfull
\graphicspath{{figures/}}              % 插图默认目录

%%---------------------------------------------------------------
%%  三、字体  【规范 3.字体和字号】
%%     论文题目：3号黑体；大、小标题：小4号黑体；正文：小4号仿宋；
%%     页码：5号仿宋；数字和字母：Times New Roman 体；参考文献：5号仿宋。
%%     字号对照：三号16pt 小三15pt 四号14pt 小四12pt 五号10.5pt
%%---------------------------------------------------------------
%% 规范 3. 字体和字号：
%%   论文题目 3号黑体（中文）/ 3号 Times New Roman（英文）；大、小标题 小4号黑体；
%%   正文 小4号仿宋；页码 5号仿宋；**数字和字母 Times New Roman 体**；参考文献 5号仿宋。
%% 规范 6. 摘要：英文 "Abstract"/"Key words" 4号 Times New Roman；英文摘要内容与具体关键词 小4号 Times New Roman。
%% 实施：正文主字体 = Times New Roman（数字字母自动走 TNR），CJK 主字体 = STFangsong（中文走仿宋）；
%%       封面用宋体（Songti SC ≈ 新宋体）；
%%       **把 \CJKrmdefault（ctex 默认正文家族）显式重定向到 zhfs（仿宋）**，避免 ctex/xeCJK
%%       内部默认（rm=STSong）误被任何位置使用，从而保证正文与摘要中文均为仿宋。
\newcommand*{\hhxy@setupfonts@mac}{%
  \setmainfont{Times New Roman}%
  \setmonofont{Times New Roman}%               % 行内代码标识符也用 TNR（范本/规范3：字母一律TNR）
  \setCJKmainfont{STFangsong}[BoldFont = {Heiti SC}, ItalicFont = {Kaiti SC}]%
  \setCJKsansfont{Heiti SC}[BoldFont = {Heiti SC}]%
  \setCJKmonofont{STFangsong}%                 % 行内代码里的中文同样用仿宋
  \setCJKfamilyfont{zhsong}{Songti SC}[BoldFont = {Heiti SC}, ItalicFont = {Kaiti SC}]%
  %% 封面标签专用：宋体真粗体（Songti SC 自带 Bold 字重，不换成黑体）
  \setCJKfamilyfont{zhsongbd}{Songti SC}[BoldFont = {Songti SC Bold}]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[BoldFont = {Heiti SC}]%
  \setCJKfamilyfont{zhfs}{STFangsong}[BoldFont = {Heiti SC}, ItalicFont = {Kaiti SC}]%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[BoldFont = {Heiti SC}]%
}
\newcommand*{\hhxy@setupfonts@win}{%
  \setmainfont{Times New Roman}%
  \setmonofont{Times New Roman}%
  \setCJKmainfont{FangSong}[BoldFont = {SimHei}, ItalicFont = {KaiTi}]%
  \setCJKsansfont{SimHei}[BoldFont = {SimHei}]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[BoldFont = {SimHei}, ItalicFont = {KaiTi}]%
  %% 封面标签专用：宋体加粗（SimSun 无 Bold 字重，用 AutoFakeBold 伪粗，
  %% 保持宋体字形不变；粗细 3 与 Songti SC Bold 视觉接近）
  \setCJKfamilyfont{zhsongbd}{SimSun}[AutoFakeBold = 3]%
  \setCJKfamilyfont{zhhei}{SimHei}[BoldFont = {SimHei}]%
  \setCJKfamilyfont{zhfs}{FangSong}[BoldFont = {SimHei}, ItalicFont = {KaiTi}]%
  \setCJKfamilyfont{zhkai}{KaiTi}[BoldFont = {SimHei}]%
}
\ifhhxy@winfonts
  \hhxy@setupfonts@win
\else
  \hhxy@setupfonts@mac
\fi

%% 默认中文正文字族由 \setCJKmainfont{STFangsong} 负责映射（见上），
%% ctex 的默认 rm 族会自动指向 STFangsong（仿宋），正文与摘要中文一致。
%% 注意：不要再对 \CJKrmdefault 做任何重定义，否则会破坏该映射导致误用宋体。
%% 中文字体切换命令（覆盖 ctex 预设，确保黑体/仿宋/宋体为规范所指字体）
\def\songti{\CJKfamily{zhsong}}
%% 封面标签加粗用：宋体真粗体（Bold 字重），不改变字体类型
\def\songtibold{\CJKfamily{zhsongbd}}
\def\heiti{\CJKfamily{zhhei}}
\def\fangsong{\CJKfamily{zhfs}}
\def\kaishu{\CJKfamily{zhkai}}

%% 字号快捷命令
\newcommand*{\chuhao}{\zihao{0}}      % 初号   42pt
\newcommand*{\xiaochu}{\zihao{-0}}    % 小初   36pt
\newcommand*{\sanhao}{\zihao{3}}      % 三号   16pt
\newcommand*{\xiaosan}{\zihao{-3}}    % 小三   15pt
\newcommand*{\sihao}{\zihao{4}}       % 四号   14pt
\newcommand*{\xiaosi}{\zihao{-4}}     % 小四   12pt
\newcommand*{\wuhao}{\zihao{5}}       % 五号   10.5pt
\newcommand*{\xiaowu}{\zihao{-5}}     % 小五   9pt

%%---------------------------------------------------------------
%%  四、页面设置  【规范 5.(1)】
%%      上 2.0cm 下 2.0cm 左 3.0cm 右 2.0cm；行间距固定值 22 磅；不设页眉。
%%---------------------------------------------------------------
\geometry{
  a4paper,
  top=2.0cm, bottom=2.0cm, left=3.0cm, right=2.0cm,
  headheight=0pt, headsep=0pt,
  footskip=0.85cm,
  nohead
}

%% 行间距固定值 22 磅：改写 \@setfontsize，使任何字号下 \baselineskip 都锁定 22pt
\newlength{\hhxy@lineskip}
\setlength{\hhxy@lineskip}{22pt}
\let\hhxy@org@setfontsize\@setfontsize
\def\@setfontsize#1#2#3{%
  \hhxy@org@setfontsize{#1}{#2}{#3}%
  \ifdim\hhxy@lineskip>\z@
    \setlength{\baselineskip}{\hhxy@lineskip}%
    \setlength{\lineskiplimit}{0\p@}%
    \setlength{\lineskip}{2\p@}%
  \fi}
\setlength{\parskip}{0pt}
\setlength{\parindent}{2\ccwd}        % 正文首行缩进 2 个汉字

%%---------------------------------------------------------------
%%  五、页码  【规范 5.(2)】页码位于页面底端居中，5 号仿宋
%%---------------------------------------------------------------
\fancypagestyle{hhxy}{%
  \fancyhf{}%
  \fancyfoot[C]{\fangsong\wuhao\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\fangsong\wuhao\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{hhxy}

%%---------------------------------------------------------------
%%  六、标题  【规范 3.】大、小标题：小 4 号黑体，顶格
%%---------------------------------------------------------------
\ctexset{
  section = {
    name        = {,},
    number      = {\arabic{section}},
    format      = {\xiaosi\fontspec{Times New Roman}\heiti\mdseries\raggedright},
    aftername   = {\hspace{0.5em}},
    beforeskip  = 12pt,
    afterskip   = 6pt,
    indent      = 0pt,
    afterindent = true,
  },
  subsection = {
    name        = {,},
    number      = {\thesection.\arabic{subsection}},
    format      = {\xiaosi\fontspec{Times New Roman}\heiti\mdseries\raggedright},
    aftername   = {\hspace{0.5em}},
    beforeskip  = 6pt,
    afterskip   = 6pt,
    indent      = 0pt,
    afterindent = true,
  },
  subsubsection = {
    name        = {,},
    number      = {\thesubsection.\arabic{subsubsection}},
    format      = {\xiaosi\fontspec{Times New Roman}\heiti\mdseries\raggedright},
    aftername   = {\hspace{0.5em}},
    beforeskip  = 6pt,
    afterskip   = 6pt,
    indent      = 0pt,
    afterindent = true,
  },
}
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3}

%%---------------------------------------------------------------
%%  七、图、表、公式编号  【规范 9./10./13.】一律按"章"（一级标题）编排
%%---------------------------------------------------------------
\@addtoreset{figure}{section}
\@addtoreset{table}{section}
\@addtoreset{equation}{section}
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\renewcommand{\thetable}{\thesection.\arabic{table}}
\renewcommand{\theequation}{\thesection.\arabic{equation}}

%% 图表题注 【规范 10.(2) 图题在下居中 5 号宋体；9. 表序表名在上居中，表名后无标点】
\DeclareCaptionLabelFormat{hhxy}{#1#2}
\DeclareCaptionFont{hhxycapfont}{\wuhao\songti\mdseries}
\captionsetup{
  labelformat   = hhxy,
  labelsep      = space,
  font          = hhxycapfont,
  justification = centering,
  skip          = 4pt,
}
\captionsetup[figure]{position=below}
\captionsetup[table]{position=top}

%% 图注（置于图题之上，5 号仿宋）
\newcommand{\figurenote}[1]{%
  \par\vspace{2pt}\wuhao\fangsong #1\par\vspace{2pt}}
%% 表内空缺数据：占两个数字位的"—"【规范 9.】
\newcommand{\voiddata}{\makebox[2em]{---}}
%% 表内文字 5 号仿宋【规范 9.】
\AtBeginEnvironment{table}{\wuhao\fangsong}
\AtBeginEnvironment{tabular}{\wuhao\fangsong}

%% 圈码 ①-⑳ 归入 CJK 字符类，避免落到西文字体（Times New Roman）里缺字
\xeCJKDeclareCharClass{CJK}{"2460 -> "2473}

%%---------------------------------------------------------------
%%  八、注释：页下注，注号 ① ② ③ 【规范 14.】
%%---------------------------------------------------------------
\newcommand*{\hhxy@circledi}[1]{%
  \ifcase\numexpr\value{#1}\relax
    \or ①\or ②\or ③\or ④\or ⑤\or ⑥\or ⑦\or ⑧\or ⑨\or ⑩%
    \or ⑪\or ⑫\or ⑬\or ⑭\or ⑮\or ⑯\or ⑰\or ⑱\or ⑲\or ⑳%
  \else
    \arabic{#1}%
  \fi}
\renewcommand{\thefootnote}{\hhxy@circledi{footnote}}
\renewcommand{\thempfootnote}{\hhxy@circledi{mpfootnote}}
\renewcommand{\footnoterule}{%
  \kern-3\p@\hrule width 0.35\textwidth height 0.4\p@ \kern 2.6\p@}
\setlength{\footnotesep}{8pt}
\patchcmd{\@makefntext}{\@thefnmark}{\makebox[1.6em][l]{\@thefnmark}}{}{}

%%---------------------------------------------------------------
%%  九、列表（范本使用"（1）（2）……"编号）
%%---------------------------------------------------------------
\setlist[enumerate,1]{label=（\arabic*）, leftmargin=2.6em, itemsep=0pt, parsep=0pt, topsep=4pt}
\setlist[enumerate,2]{label=\arabic*）, leftmargin=2.2em, itemsep=0pt, parsep=0pt, topsep=2pt}
\setlist[itemize,1]{label=\textbullet, leftmargin=2.6em, itemsep=0pt, parsep=0pt, topsep=4pt}

%%---------------------------------------------------------------
%%  十、代码环境
%%---------------------------------------------------------------
\definecolor{hhxycodebg}{gray}{0.95}
%% 代码字体：【规范 3.】数字和字母一律 Times New Roman；中文注释用仿宋。
%%   原先 basicstyle 用 \ttfamily（Menlo/黑体），与规范不符。改为：
%%   Latin → Times New Roman（沿用正文主字体），CJK → 仿宋（zhfs）。
%%   同时把左右边距清零，使灰色背景与正文两端对齐（不再宽出正文宽度）。
\lstset{
  basicstyle        = \wuhao\fangsong,
  backgroundcolor   = \color{hhxycodebg},
  frame             = none,
  tabsize           = 2,
  breaklines        = true,
  breakatwhitespace = true,
  xleftmargin       = 0pt,
  xrightmargin      = 0pt,
  aboveskip         = 6pt,
  belowskip         = 6pt,
  showstringspaces  = false,
  columns           = fullflexible,
  keepspaces        = true,
  commentstyle      = \color[gray]{0.35},
  stringstyle       = \color[gray]{0.2},
}
%% listings 未内置 JavaScript 方言，这里手工声明词法
\lstdefinelanguage{HHXYJavaScript}{%
  morekeywords={wx,Page,App,Promise,Proxy,let,var,const,function,return,new,
                if,else,for,while,this,module,exports,require,import,null,true,false},
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]",
  morestring=[b]',
}
\lstdefinestyle{js}{language=HHXYJavaScript,
  morekeywords={wx,Page,App,Promise,Proxy,let,var,const,function,return,new,if,else,this,module,exports,require,import}}
\lstdefinestyle{xml}{language=XML}

%%---------------------------------------------------------------
%%  十一、封面信息（在 main.tex 中填写）
%%---------------------------------------------------------------
\newcommand*{\ClassificationNumber}[1]{\gdef\hhxy@classno{#1}}
\newcommand*{\ThesisType}[1]{\gdef\hhxy@thesistype{#1}}  % 本科生毕业论文/毕业设计/毕业创作
\newcommand*{\WorkType}[1]{\gdef\hhxy@worktype{#1}}      % 毕业论文/毕业设计/毕业创作
\newcommand*{\TitleCN}[1]{\gdef\hhxy@titlecn{#1}}
\newcommand*{\TitleEN}[1]{\gdef\hhxy@titleen{#1}}
\newcommand*{\Author}[1]{\gdef\hhxy@author{#1}}
\newcommand*{\StudentID}[1]{\gdef\hhxy@studentid{#1}}
\newcommand*{\StudentId}[1]{\gdef\hhxy@studentid{#1}}
\newcommand*{\College}[1]{\gdef\hhxy@college{#1}}
\newcommand*{\Major}[1]{\gdef\hhxy@major{#1}}
\newcommand*{\Advisor}[2]{\gdef\hhxy@advisorname{#1}\gdef\hhxy@advisortitle{#2}}
\newcommand*{\SecondAdvisor}[2]{%
  \gdef\hhxy@advisornameb{#1}\gdef\hhxy@advisortitleb{#2}}
\newcommand*{\Duration}[1]{\gdef\hhxy@duration{#1}}
\newcommand*{\SubmitDate}[1]{\gdef\hhxy@submitdate{#1}}

\ClassificationNumber{0809}
\ThesisType{本科生毕业设计}
\WorkType{毕业设计}
\TitleCN{}\TitleEN{}
\Author{}\StudentID{}
\College{}\Major{}
\Advisor{}{}
\gdef\hhxy@advisornameb{}\gdef\hhxy@advisortitleb{}   % 第二指导教师（默认无）
\Duration{}
\SubmitDate{}

%%---------------------------------------------------------------
%%  十二、封面  【严格按用户提供的参考封面图（Bilibili 弹幕情感分析）复刻】
%%
%%  参考图实测版式参数（像素→pt，页宽 595.3pt，左边距≈86pt）：
%%    学科分类号        x[331-462]pt  四号宋体，分类号带下划线，整体偏右
%%    校徽 wordmark     x[154-421]pt  居中，墨迹宽≈267pt/高≈46pt（图宽≈12cm）
%%    论文类型          x[168-416]pt  小初(36pt)宋体，居中
%%    题目 中文/英文    标签 x=114pt 起，值列 x=204pt 起、下划线满宽至≈498pt；
%%                      首行缩进 2 字符；22pt 行距；可随题目长度换行
%%    学生信息 6 行     标签 x=149pt(缩进4.5字符)，值列下划线 x[218-454]pt、
%%                      值居中；行距≈31pt
%%    提交日期          居中，四号宋体，页底偏上
%%
%%  关键排版技巧（可复用）：
%%    * 标题换行且每行下划线满宽：\parbox[t]{宽}{\uline{...\hfill}}
%%      （ulem 的 \uline 逐行加下划线，结尾 \hfill 使最后一行也划满；
%%        切记 \uline 要放在 \parbox 内部，否则只划盒底一条）。
%%    * 字段值居中 + 满宽下划线：\uline{\makebox[宽][c]{值}}。
%%---------------------------------------------------------------
%% —— 封面下划线统一 ——
%% 封面所有下划线一律使用 ulem 的 \uline：原生 \underline 走数学字体，线厚随字号变化，
%% 与 \uline 的 \ULthickness 并不一致；且 \underline 无法对多行内容逐行画线。
%% 固定 \ULthickness 后，无论单行还是换行，下划线粗细完全一致（想调整粗细改此值即可）。
\renewcommand\ULthickness{0.5pt}
\newlength{\hhxy@titletw}   % 题目值列宽
\newlength{\hhxy@fieldw}    % 字段值列宽
\newlength{\hhxy@labw}      % 题目标签宽
\newlength{\hhxy@clsw}      % 分类号下划线宽（=值宽+2字符）
\newcommand{\makecover}{%
  %% 封面单独用对称边距（左右均 3cm），使校徽/类型/日期按物理页面居中，
  %% 与参考图一致；\restoregeometry 之后恢复正文 left=3cm/right=2cm 装订边距。
  \newgeometry{left=3.0cm,right=3.0cm,top=2.0cm,bottom=2.0cm,nohead}%
  \thispagestyle{empty}%
  \songti\zihao{4}%                      % 全封面：宋体(=新宋体) 四号(14pt)
  \vspace*{-14pt}
  %
  %% —— 学科分类号（四号，标签与值均粗体=黑体；标签与值间空一格；
  %%    下划线长度 = 值宽 + 2 字符）——
  \settowidth{\hhxy@clsw}{\bfseries\hhxy@classno}%
  \addtolength{\hhxy@clsw}{2em}%
  \noindent\hfill{\songtibold\bfseries 学科分类号}\quad\uline{\makebox[\hhxy@clsw][c]{\bfseries\hhxy@classno}}\hspace*{48pt}\par
  \vspace{36pt}
  %
  %% —— 校徽（居中，墨迹宽≈267pt，用裁剪去白边后的 logo）——
  \centerline{\includegraphics[width=267pt]{hhu_logo_trim.jpg}}%
  \vspace{44pt}
  %
  %% —— 论文/设计类型（小初 36pt，粗体，居中）——
  \centerline{\zihao{-0}\songtibold\bfseries\hhxy@thesistype}%
  \vspace{50pt}
  %
  %% —— 题目 中文/英文（四号宋体，标签悬挂在题目列左侧；
  %%    值列左对齐、可换行、每行下划线满宽；
  %%    行距固定 28pt —— 中文标题折成多行时，行与行之间、
  %%    以及中文标题末行到英文标题首行，基线间距统一为 28pt）——
  %%    注：封面布局不用 tabular（cls 有 \AtBeginEnvironment{tabular}{\wuhao}
  %%    表格钩子会把内容变五号），改用 \makebox+\par 保证四号。
  \begingroup
    \zihao{4}\songti
    \setlength{\baselineskip}{28pt}%                % 外层段落行距（真正作用于题目各行的是
                                                    % parbox 内部的那处设置，见下）
    \setlength{\parskip}{0pt}%                      % 中/英两块之间不加额外段距
    \setlength{\lineskiplimit}{0\p@}%               % 与类文件一致：d<0 才退化为 \lineskip
    \setlength{\lineskip}{2\p@}%
    \setlength{\parindent}{0pt}%                    % 关掉正文 2 字符首行缩进
    \settowidth{\hhxy@labw}{{\songtibold\bfseries 题目（中文）：}}%   % 题目标签实测宽（粗体）
    \setlength{\hhxy@titletw}{294pt}%                % 题目值列宽（参考图 x204→498）
    %% 版式：题目值放在一个 294pt 的 \parbox 里（= 值列，x 204→498）；
    %%   「题目（中文）：」「（英文）：」两个标签用零宽盒子悬挂在该列左侧
    %%   （宽度 = \hhxy@labw），每个标签写在它所标注那一块的【首行行首】，
    %%   因此「（英文）：」自动跟随英文标题首行 —— 中文标题无论折成几行都对得上。
    %%   外层段落左缩进 = 2 字符 + 标签宽，正好把值列的左边缘推到参考图位置。
    %% 中/英两块都在【同一个 \parbox 内】，只隔一个 \par：
    %%   这样两块同属该 \parbox 的垂直列表，interline glue 正常取
    %%   \baselineskip，行距恒为 28pt（含「中文末行 → 英文首行」）。
    %%   反例（已实测）：若把中/英写成外层两个 \par 段落、每段末尾又是
    %%   一个 \parbox[t]，则跨段处 interline glue 退化为 \lineskip＝2pt，
    %%   「中文末行 → 英文首行」只剩 16.5pt（≠ 22pt）。故必须合并进同一个 \parbox。
    %% 中英文题目均可按长度自动换行，且每行下划线等长（都撑满 294pt）：
    %%   * \parbox[t]{294pt}{...} 提供固定列宽 → 按内容自动折行；
    %%   * \uline 逐行加下划线，行尾 \hfill 让末行也撑满，故各行等长；
    %%   * \expandafter 先展开宏再交给 \uline，否则整个标题无法断行；
    %%   * 必须加载 xeCJKfntef，否则长中文（无空格）会被当成一个词而溢出。
    \leftskip=\dimexpr 2em+\hhxy@labw\relax
    \noindent
    \parbox[t]{\hhxy@titletw}{%                      % —— 值列（中/英两块同一 \parbox）——
      %% 【必须写在 parbox 内部】\parbox 会执行 \@parboxrestore，其中
      %%   \baselineskip\normalbaselineskip、\lineskip\normallineskip，
      %%   而本类把 \normalbaselineskip 锁死为 22pt —— 所以行距若只写在
      %%   parbox 外面会被立刻覆盖（实测「外面设 28pt、内里仍 22pt」）。
      %%   下文这三行放在 parbox 内，才真正作用于题目各行的 interline glue。
      \setlength{\baselineskip}{28pt}%               % 题目区行距固定 28pt（中/英、折行均一致）
      \setlength{\lineskip}{2\p@}%
      \setlength{\lineskiplimit}{0\p@}%
      \leftskip\z@skip\rightskip\z@skip \parindent\z@
      \noindent\makebox[0pt][r]{\makebox[\hhxy@labw][l]{\songtibold\bfseries 题目（中文）：}}%
      \expandafter\uline\expandafter{\hhxy@titlecn\hfill}\par
      \noindent\makebox[0pt][r]{\makebox[\hhxy@labw][r]{\songtibold\bfseries （英文）：}}%
      \expandafter\uline\expandafter{\hhxy@titleen\hfill}%
    }%
    \par
  \endgroup
  \par\vspace{46pt}
  %
  %% —— 学生信息 6 行（四号宋体，左对齐缩进 4.5 字符；标签 5 字符宽，
  %%    值居中、下划线满宽 236pt；行距≈31pt）——
  \begingroup
    \zihao{4}\songti
    \setlength{\hhxy@fieldw}{236pt}%
    \setlength{\baselineskip}{31pt}%                % 行距≈31pt
    \setlength{\parindent}{0pt}%                    % 关掉正文 2 字符首行缩进
    \leftskip=4.5em\relax                           % 缩进 4.5 字符（作用于每一行）
    \makebox[5em][l]{\songtibold\bfseries 学生姓名：}\uline{\makebox[\hhxy@fieldw][c]{\hhxy@author}}\par
    \makebox[5em][l]{\songtibold\bfseries 学\qquad 号：}\uline{\makebox[\hhxy@fieldw][c]{\hhxy@studentid}}\par
    \makebox[5em][l]{\songtibold\bfseries 院\qquad 别：}\uline{\makebox[\hhxy@fieldw][c]{\hhxy@college}}\par
    \makebox[5em][l]{\songtibold\bfseries 专\qquad 业：}\uline{\makebox[\hhxy@fieldw][c]{\hhxy@major}}\par
    \makebox[5em][l]{\songtibold\bfseries 指导教师：}%
    \ifx\hhxy@advisornameb\@empty
      \uline{\makebox[\hhxy@fieldw][c]{\hhxy@advisorname\quad\hhxy@advisortitle}}%
    \else
      \parbox[t]{\hhxy@fieldw}{%
        \uline{\makebox[\hhxy@fieldw][c]{\hhxy@advisorname\quad\hhxy@advisortitle}}%
        \\[2pt]%
        \uline{\makebox[\hhxy@fieldw][c]{\hhxy@advisornameb\quad\hhxy@advisortitleb}}%
      }%
    \fi
    \par
    \makebox[5em][l]{\songtibold\bfseries 起止日期：}\uline{\makebox[\hhxy@fieldw][c]{\hhxy@duration}}\par
  \endgroup
  \par\vfill
  %
  %% —— 提交日期（四号宋体，居中，页底偏上）——
  \centerline{\songti\zihao{4}\hhxy@submitdate}%
  \vspace{12pt}
  \clearpage
  \restoregeometry
}

%%---------------------------------------------------------------
%%  十三、诚信声明  【排版与范本一致：标题 四号 宋体(新宋体) 居中；
%%     正文 四号 仿宋_GB2312(仿宋)，签名与日期 四号 仿宋。】
%%---------------------------------------------------------------
\newcommand{\makedeclaration}{%
  \clearpage
  \thispagestyle{empty}%
  %% —— 按范本还原（范本 XML 实测）：
  %%   标题：页顶空 1 行(22pt)后（范本节首空行属上一节），新宋体(宋体)加粗
  %%         四号 居中，行距 22pt；标题下空 2 行(44pt)；
  %%   正文：仿宋 四号，首行缩进 2 字符，1.5 倍行距(行高≈25.2pt)；
  %%   正文后空 8 行(176pt) → 签名行(左起 11.5 字符=161pt)；
  %%   空 1 行(22pt) → 日期行(左起 21 字符=294pt，年/月/日间 3 空格≈0.75字)。
  %% 注：不用 center 环境（其 \topsep 会多出 ~10pt 空隙），改用 \centering。
  \vspace*{0pt}%
  {\centering\songtibold\bfseries\zihao{4} 怀化学院本科\hhxy@worktype 诚信声明\par}
  \vspace{44pt}%
  %% 正文（1.5 倍行距：直接锁定 \baselineskip≈25.2pt，
  %%   因类文件 \@setfontsize 会把行距锁回 22pt）
  {\fangsong\zihao{4}%
   \setlength{\baselineskip}{25.2pt}%
   作者郑重声明：所呈交的本科\hhxy@worktype，是在指导老师的指导下，独立进行研究所取得的成果，成果不存在知识产权争议。除文中已经注明引用的内容外，\hhxy@worktype 不含任何其他个人或集体已经发表或撰写过的成果。对\hhxy@worktype 的研究做出重要贡献的个人和集体均已在文中以明确的方式标明。本声明的法律结果由作者承担。\par}
  \vspace{176pt}%
  \noindent\fangsong\zihao{4}\hspace*{11.5\ccwd}本科\hhxy@worktype 作者签名：\par
  \vspace{22pt}%
  \noindent\fangsong\zihao{4}\hspace*{21\ccwd}年\hspace{1.85\ccwd}月\hspace{1.85\ccwd}日\par
  \clearpage
}

%%---------------------------------------------------------------
%%  十四、目录  【规范：目录（小3号黑体居中），条目小4号宋体】
%%---------------------------------------------------------------
\newcommand{\l@front}{\@dottedtocline{1}{0em}{0em}}
\newcommand{\toclevel@front}{0}
%% \phantomsection：为目录条目建立独立锚点，否则 PDF 里点击"参考文献"会跳到
%% 上一个 section（旧实现所有前置条目共用 Doc-Start / section.7 锚点）。
\newcommand{\addfronttotoc}[1]{\phantomsection\addcontentsline{toc}{front}{#1}}
%% 让目录编号后紧跟标题
\def\numberline#1{#1\enspace}
%% 目录缩进与范本一致：一级标题顶格、二级缩进 2 字符、三级缩进 4 字符
%% （范本 TOC2 firstLineChars=200、TOC3 firstLineChars=400，1字符≈1em）。
%% Standard \@dottedtocline 把首行(\null\hskip -numwidth)拉回左边界、不接受"首行缩进"，
%% 故必须重写以实现 Word 的"firstLineChars"效果。每条目录首行左缩进=indent，
%% leftskip=indent 控制换行缩进。
\renewcommand*\l@section{\@dottedtocline{1}{0em}{0em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{0em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{4em}{0em}}
%% 引导点密度：【范本】目录条目后的点应较密（LaTeX 默认 \@dotsep=4.5 偏稀）。
%%   \@dotsep 单位为 mu（1mu=1/18em），点与点中心距 = 2\@dotsep mu + 点宽，
%%   数值越小点越密。取 2.0，得到与范本截图接近的密度。
\renewcommand\@dotsep{2.0}
%% 本类文件已在开头 \makeatletter（@ 视为字母），此处不再开/闭 @ 状态，
%% 直接重定义（避免中断后续 \hhxy@... 宏名的解析）。
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\parindent\z@\relax
     \leftskip #2\relax \rightskip\@tocrmarg
     \parfillskip-\rightskip
     \interlinepenalty\@M \leavevmode
     #4\nobreak
     \leaders\hbox{$\m@th
       \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalcolor\normalfont #5}%
     \par}%
  \fi}

\newcommand{\makehhxytoc}{%
  \clearpage
  \pagestyle{empty}%
  \begin{center}\xiaosan\heiti 目　录\end{center}
  \vspace{0.6cm}
  \xiaosi\songti
  \setlength{\baselineskip}{22pt}%                 % 目录条目行距固定值 22 磅
  \@starttoc{toc}%
  \clearpage
  \pagestyle{hhxy}
}

%%---------------------------------------------------------------
%%  十五、中英文摘要与关键词  【规范 6.】
%%      题目 3 号（中文黑体 / 英文 Times New Roman）居中；
%%      "摘要""关键词"标示字 4 号黑体居中，内容小 4 号仿宋；
%%      "Abstract""Key words"标示字 4 号 TNR 居中，内容小 4 号 TNR。
%%---------------------------------------------------------------
%% 行距说明（范本 docx 实测 w:line="440" w:lineRule="exact"，即固定值 22pt）：
%%   三号题目行距 = 22pt。类文件 \@setfontsize 会把 \baselineskip 压回正文行距
%%   （对三号字过窄，多行题目会挤在一起），故须在 \sanhao 之后显式重设，顺序不可颠倒。
%% 目录页码说明：\addfronttotoc 必须写在"该标题所在段落内部"（center 环境里），
%%   因为 \write 节点跟段落走；若写在 \begin{center} 之前，标题被挤到下一页时
%%   目录里记的仍是上一页的页码（范本目录为 摘要I / 关键词I / AbstractI / Key wordsII）。
\newenvironment{cnabstract}{%
  \clearpage
  \begin{center}\sanhao\heiti\setlength{\baselineskip}{22pt}\hhxy@titlecn\end{center}
  \vspace{0.5cm}
  \begin{center}\sihao\heiti\addfronttotoc{摘　要}摘　要\end{center}
  \vspace{0.25cm}
  \xiaosi\fangsong\par\indent\ignorespaces
}{\par\vspace{0.7cm}}

\newenvironment{cnkeywords}{%
  \begin{center}\sihao\heiti\addfronttotoc{关键词}关键词\end{center}
  \vspace{0.25cm}
  \xiaosi\fangsong\par\indent\ignorespaces
}{\par\vspace{0.7cm}}

\newenvironment{enabstract}{%
  \begin{center}\sanhao\fontspec{Times New Roman}\setlength{\baselineskip}{22pt}\hhxy@titleen\end{center}
  \vspace{0.5cm}
  \begin{center}\sihao\fontspec{Times New Roman}\addfronttotoc{Abstract}Abstract\end{center}
  \vspace{0.25cm}
  \xiaosi\fontspec{Times New Roman}\par\indent\ignorespaces
}{\par\vspace{0.7cm}}

\newenvironment{enkeywords}{%
  \begin{center}\sihao\fontspec{Times New Roman}\addfronttotoc{Key words}Key words\end{center}
  \vspace{0.25cm}
  \xiaosi\fontspec{Times New Roman}\par\indent\ignorespaces
}{\par}

%%---------------------------------------------------------------
%%  ## 正文起始宏：在目录/摘要等前置部分之后、正文章节开始前调用，
%%     强制复位正文字体为"小 4 号仿宋"，避免封面/目录里无分组的
%%     \songti 泄漏污染正文（规范：正文小4号仿宋，与摘要一致）。
%%---------------------------------------------------------------
\newcommand{\mainbody}{\normalfont\fangsong\zihao{-4}}

%%---------------------------------------------------------------
%%  十六、参考文献  【规范 15.】序号左顶格 [1]，5 号仿宋，条目以"."结束
%%---------------------------------------------------------------
\renewenvironment{thebibliography}[1]{%
  \clearpage
  \addfronttotoc{参考文献}%
  \begin{center}\xiaosi\heiti 参考文献\end{center}
  \vspace{0.25cm}
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep=0pt \parsep=0pt
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \wuhao\fangsong
  \sloppy
  \clubpenalty=4000
  \widowpenalty=4000
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}

%%---------------------------------------------------------------
%%  十七、致谢  【规范：致谢（小4号黑体居中，另起一页）】
%%---------------------------------------------------------------
\newenvironment{acknowledgement}{%
  \clearpage
  \addfronttotoc{致　谢}%
  \begin{center}\xiaosi\heiti 致　谢\end{center}
  \vspace{0.25cm}
  %% \end{center} 的 \@endparenv 会置 \@afterindentfalse，下一段不缩进，
  %% 故须显式 \indent（与 cnabstract/cnkeywords 同），否则首段顶格。
  \xiaosi\fangsong\par\indent\ignorespaces
}{\par}

%%---------------------------------------------------------------
%%  十八、附录  【规范：另起一页，小4号黑体，顶格；公式编号为（A1）】
%%---------------------------------------------------------------
\newenvironment{theappendix}{%
  \clearpage
  \addfronttotoc{附　录}%
  \noindent{\xiaosi\heiti 附录：}\par
  \vspace{0.25cm}
  \setcounter{equation}{0}%
  \setcounter{figure}{0}%
  \setcounter{table}{0}%
  \renewcommand{\theequation}{A\arabic{equation}}%
  \renewcommand{\thefigure}{A\arabic{figure}}%
  \renewcommand{\thetable}{A\arabic{table}}%
  \xiaosi\fangsong\ignorespaces
}{\par}

%%---------------------------------------------------------------
%%  十九、固定名称（放在 document 开头，避免被 ctex 覆盖）
%%---------------------------------------------------------------
\AtBeginDocument{%
  \renewcommand{\figurename}{图}%
  \renewcommand{\tablename}{表}%
  \renewcommand{\refname}{参考文献}%
  \renewcommand{\contentsname}{目　录}%
  \renewcommand{\lstlistingname}{代码}%
}

%%---------------------------------------------------------------
%%  二十、超链接（最后加载）
%%---------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  hidelinks,
  bookmarksnumbered = false,
  bookmarksopen     = true,
  pdfencoding       = auto,
  pdflang           = zh-CN,
}
\RequirePackage{bookmark}

%%---------------------------------------------------------------
%%  二十·补、参考文献长网址自动换行
%%    \biburl{https://...}：自动在 / - . _ ? & = : ~ % 等符号后断行，
%%    无需手写 \allowbreak（URL 本身无空格，TeX 找不到断点会 Overfull）；
%%    字体强制 \rmfamily（Times New Roman，规范 3.：数字和字母用 TNR），
%%    且不产生超链接框/颜色（hidelinks 已设，这里用 \nolinkurl 语义）。
%%    用法：把文献条目里的网址写成 \biburl{https://……} 即可。
%%---------------------------------------------------------------
\DeclareUrlCommand\biburl{%
  \def\UrlFont{\rmfamily}%
  \def\UrlLeft{}%
  \def\UrlRight{}%
  \def\UrlBreaks{\do\/\do\-\do\.\do\_\do\?\do\&\do\=\do\:\do\~\do\%\do\#}%
}

%%---------------------------------------------------------------
%%  二十一、文献引用一律上标（GB 7714 / 规范 15. 顺序编码制：[1] 上标）
%%     hyperref/bookmark 已对 \@citex 完成加载，包住其输出整体上标化；
%%     仍保留可选参数（[opt]{key}）和多键（{a,b}）的正确性。
%%---------------------------------------------------------------
\let\hhxy@citex@save\@citex
\renewcommand\cite[2][]{%
  \textsuperscript{\hhxy@citex@save[#1]{#2}}%
}

\makeatother
\endinput
