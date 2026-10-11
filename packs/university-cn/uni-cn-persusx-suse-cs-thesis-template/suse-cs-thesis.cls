% ============================================================
% 四川轻化工大学计算机科学与工程学院
% 本科毕业设计（论文）LaTeX 模板 (2026版)
% ============================================================
% 严格按《计算机学院-毕业设计(论文)模板(2026).doc》Word 模板格式制作
% ============================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{suse-cs-thesis}[2026/05/20 v2.0 SUSE CS Thesis Template]

% ---------- 文档类选项 ----------
\DeclareOption{print}{\PassOptionsToClass{openright}{ctexbook}}
\DeclareOption{electronic}{\PassOptionsToClass{openany}{ctexbook}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{electronic,a4paper,zihao=-4}
\ProcessOptions\relax

% ---------- 加载 ctexbook ----------
\LoadClass[UTF8,fontset=none]{ctexbook}

% ============================================================
% 1. 页面设置（Word 默认页边距）
% ============================================================
\RequirePackage{geometry}
\geometry{
    paperwidth=210mm,
    paperheight=297mm,
    top=2.54cm,
    bottom=2.54cm,
    left=3.17cm,
    right=3.17cm,
    headheight=30pt,
    headsep=20pt,
    footskip=25pt
}

% ============================================================
% 2. 字体设置
% ============================================================
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\xeCJKsetup{AutoFakeBold=true}

% 西文字体
\setmainfont{Times New Roman}
\setsansfont{Times New Roman}
\setmonofont{Times New Roman}

% 中文字体设置
% 根据操作系统自动选择（优先 macOS）
\IfFontExistsTF{Songti SC}{
    % macOS 系统
    % macOS 原生 Heiti SC 默认匹配 Light(细体)，太细；Hiragino W6 又太粗。
    % 改用 Heiti SC Medium（中黑体），字重介于 Light 与 Bold 之间，最接近 SimHei。
    \setCJKmainfont[
        BoldFont={Heiti SC Medium},
        ItalicFont={Kaiti SC}
    ]{STSong}
    \setCJKsansfont{Heiti SC Medium}
    \IfFontExistsTF{Kaiti SC}{
        \setCJKmonofont[AutoFakeBold]{Kaiti SC}
    }{
        \setCJKmonofont{Songti SC}
    }
}{
    \IfFontExistsTF{SimSun}{
        % Windows 系统
        \setCJKmainfont[
            BoldFont={SimHei},
            ItalicFont={KaiTi}
        ]{SimSun}
        \setCJKsansfont{SimHei}
        \setCJKmonofont{FangSong}
    }{
        % Linux / 其他系统
        \setCJKmainfont{Noto Serif CJK SC}
        \setCJKsansfont{Noto Sans CJK SC}
        \setCJKmonofont{Noto Sans Mono CJK SC}
    }
}

% 定义 ctex 字体切换命令
\newcommand{\songti}{\CJKfamily{zhsong}}
\newcommand{\heiti}{\CJKfamily{zhhei}}
\newcommand{\kaishu}{\CJKfamily{zhkai}}
\newcommand{\fangsong}{\CJKfamily{zhfs}}

% 设置字体族名称（用于 ctex 字体命令）
\IfFontExistsTF{Songti SC}{
    \setCJKfamilyfont{zhsong}{STSong}
    \setCJKfamilyfont{zhhei}{Heiti SC Medium}
    \IfFontExistsTF{Kaiti SC}{
        \setCJKfamilyfont{zhkai}{Kaiti SC}
    }{
        \setCJKfamilyfont{zhkai}{Songti SC}
    }
    \setCJKfamilyfont{zhfs}{Songti SC}
}{
    \IfFontExistsTF{SimSun}{
        \setCJKfamilyfont{zhsong}{SimSun}
        \setCJKfamilyfont{zhhei}{SimHei}
        \setCJKfamilyfont{zhkai}{KaiTi}
        \setCJKfamilyfont{zhfs}{FangSong}
    }{
        \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}
        \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}
        \setCJKfamilyfont{zhkai}{Noto Serif CJK SC}
        \setCJKfamilyfont{zhfs}{Noto Sans CJK SC}
    }
}

% 定义常用字号命令（Word 字号 → LaTeX pt）
\newcommand{\xiaochuhao}{\fontsize{44pt}{66pt}\selectfont}
\newcommand{\yihao}{\fontsize{26pt}{39pt}\selectfont}
\newcommand{\xiaoyihao}{\fontsize{24pt}{36pt}\selectfont}
\newcommand{\erhao}{\fontsize{22pt}{33pt}\selectfont}
\newcommand{\xiaoerhao}{\fontsize{18pt}{27pt}\selectfont}
\newcommand{\sanhao}{\fontsize{16pt}{24pt}\selectfont}
\newcommand{\xiaosanhao}{\fontsize{15pt}{22.5pt}\selectfont}
\newcommand{\sihao}{\fontsize{14pt}{21pt}\selectfont}
\newcommand{\xiaosihao}{\fontsize{12pt}{22pt}\selectfont}  % 小四号，行距22磅
\newcommand{\wuhao}{\fontsize{10.5pt}{22pt}\selectfont}      % 五号，行距22磅
\newcommand{\xiaowuhao}{\fontsize{9pt}{13.5pt}\selectfont}

% ============================================================
% 3. 行距设置（固定值22磅）
% ============================================================
\RequirePackage{setspace}
\setlength{\baselineskip}{22pt}

% ============================================================
% 4. 颜色与图形
% ============================================================
\RequirePackage{xcolor}
\RequirePackage{graphicx}

% ============================================================
% 5. 页眉页脚
% ============================================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}

% 正文页眉：宋体五号居中
\fancyhead[C]{\wuhao\songti 四川轻化工大学本科毕业设计（论文）}
\fancyfoot[C]{\wuhao\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% 隐藏/显示页眉的命令（避免 \fancypagestyle 在 fancyhdr v5.x 中的全局状态问题）
\newcommand{\hideheader}{%
    \fancyhead{}
    \renewcommand{\headrulewidth}{0pt}
}
\newcommand{\showheader}{%
    \fancyhead[C]{\wuhao\songti 四川轻化工大学本科毕业设计（论文）}
    \renewcommand{\headrulewidth}{0.4pt}
}

% 封面/声明页：无页眉页脚
\fancypagestyle{cover}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

% ============================================================
% 6. 章节标题格式
% ============================================================
\RequirePackage{titlesec}

% 一级标题：黑体3号、段前段后各12磅、居中、行距固定值22磅
% 使用 \CTEXthechapter 显示"第一章"格式
% [\thispagestyle{fancy}] 确保章节第一页也有页眉
\titleformat{\chapter}
    {\centering\sanhao\heiti}
    {\CTEXthechapter}{1em}{}
    [\thispagestyle{fancy}]
\titlespacing*{\chapter}{0pt}{12pt}{12pt}

% 二级标题：黑体4号，段前段后各12磅、行距固定值22磅
\titleformat{\section}
    {\sihao\heiti}
    {\thesection}{1em}{}
\titlespacing*{\section}{0pt}{12pt}{12pt}

% 三级标题：楷体加粗小4号，段前段后各6磅，行距固定值22磅
\titleformat{\subsection}
    {\xiaosihao\kaishu}
    {\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{6pt}{6pt}

% 四级标题：楷体小4号，段前段后各6磅
\titleformat{\subsubsection}
    {\xiaosihao\kaishu}
    {\thesubsubsection}{1em}{}
\titlespacing*{\subsubsection}{0pt}{6pt}{6pt}

% ============================================================
% 7. 目录格式
% ============================================================
\RequirePackage{titletoc}

% 目录标题：黑体3号，段前段后各12磅
\renewcommand{\contentsname}{\texorpdfstring{\vspace*{-2em}\begin{center}\sanhao\heiti 目\quad 录\end{center}\vspace{1em}}{目 录}}

\titlecontents{chapter}[0em]
    {\xiaosihao\songti\vspace{-0.3em}}
    {\thecontentslabel\quad}{}
    {\titlerule*[0.5em]{.}\contentspage}
    [\vspace{-0.3em}]

\titlecontents{section}[2em]
    {\xiaosihao\songti\vspace{-0.3em}}
    {\thecontentslabel\quad}{}
    {\titlerule*[0.5em]{.}\contentspage}
    [\vspace{-0.3em}]

\titlecontents{subsection}[4em]
    {\xiaosihao\songti\vspace{-0.3em}}
    {\thecontentslabel\quad}{}
    {\titlerule*[0.5em]{.}\contentspage}
    [\vspace{-0.3em}]

% ============================================================
% 8. 段落设置
% ============================================================
\RequirePackage{indentfirst}
\setlength{\parindent}{2em}      % 首行缩进2字符
\setlength{\parskip}{0pt}        % 段间距为0

% ============================================================
% 9. 列表设置
% ============================================================
\RequirePackage{enumitem}
\setlist{nosep,leftmargin=2em}

% ============================================================
% 10. 图表设置
% ============================================================
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{float}

% 图编号格式：图1-1（短横线连接，按章编号）
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
% 表编号格式：表1-1（短横线连接，按章编号）
\renewcommand{\thetable}{\thechapter-\arabic{table}}

% 图标题：五号字体(约10.5pt)，位于图下方
\captionsetup[figure]{
    font={small},
    labelsep=space,
    skip=6pt,
    position=below
}
\renewcommand{\figurename}{\small 图}

% 表标题：五号字体(约10.5pt)，位于表上方
\captionsetup[table]{
    font={small},
    labelsep=space,
    skip=6pt,
    position=above
}
\renewcommand{\tablename}{\small 表}

% 图表环境前后间距：段前段后12磅
\setlength{\floatsep}{12pt}
\setlength{\textfloatsep}{12pt}
\setlength{\intextsep}{12pt}

% ============================================================
% 11. 公式设置
% ============================================================
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% 公式编号按章连续编制，如 (1-1)
\renewcommand{\theequation}{\thechapter-\arabic{equation}}

% 公式段前段后6磅
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\abovedisplayshortskip}{6pt}
\setlength{\belowdisplayshortskip}{6pt}

% ============================================================
% 12. 参考文献设置
% ============================================================
\RequirePackage[numbers,sort&compress,super]{natbib}

% 引用格式：上标 [1]
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

% ============================================================
% 13. 超链接
% ============================================================
\RequirePackage[colorlinks=true,linkcolor=black,citecolor=black,urlcolor=blue]{hyperref}

% ============================================================
% 14. 辅助命令：垂直居中（将内容基线设在其视觉中心）
% ============================================================

\newsavebox{\@susethesis@tmpbox}
\newcommand{\@susethesis@vcenter}[1]{%
    \setbox\@susethesis@tmpbox=\hbox{#1}%
    \raisebox{\dimexpr-0.5\ht\@susethesis@tmpbox-0.5\dp\@susethesis@tmpbox\relax}{\usebox\@susethesis@tmpbox}%
}

% ============================================================
% 15. 封面定义
% ============================================================
\newcommand{\@susethesis@title}{}
\newcommand{\@susethesis@author}{}
\newcommand{\@susethesis@studentid}{}
\newcommand{\@susethesis@major}{}
\newcommand{\@susethesis@class}{}
\newcommand{\@susethesis@advisor}{}
\newcommand{\@susethesis@date}{}
\newcommand{\@susethesis@school}{四川轻化工大学计算机科学与工程学院}

\newcommand{\thesistitle}[1]{\renewcommand{\@susethesis@title}{#1}}
\newcommand{\thesisauthor}[1]{\renewcommand{\@susethesis@author}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\@susethesis@studentid}{#1}}
\newcommand{\major}[1]{\renewcommand{\@susethesis@major}{#1}}
\newcommand{\class}[1]{\renewcommand{\@susethesis@class}{#1}}
\newcommand{\advisor}[1]{\renewcommand{\@susethesis@advisor}{#1}}
\newcommand{\thesisdate}[1]{\renewcommand{\@susethesis@date}{#1}}
\newcommand{\school}[1]{\renewcommand{\@susethesis@school}{#1}}
\newcommand{\logo}[1]{\def\@susethesis@logo{#1}}

% 封面生成命令
\newcommand{\makecover}{%
    \thispagestyle{cover}
    \begin{center}
        \vspace*{1cm}
        
        % 校徽 + 学校名称行：文字与校徽中心水平对齐，小二号黑体
        \ifdefined\@susethesis@logo
            {\xiaoerhao
            \@susethesis@vcenter{\includegraphics[width=2.5cm]{\@susethesis@logo}}
            \quad
            \@susethesis@vcenter{\heiti 四川轻化工大学本科毕业设计（论文）}}
        \else
            {\xiaoerhao\heiti 四川轻化工大学本科毕业设计（论文）}
        \fi
        
        \vspace{2.5cm}
        
        % 论文题目：二号黑体，居中
        {\erhao\heiti \@susethesis@title}
        
        \vspace{3cm}
        
        % 学生信息：三号黑体，居中
        \begin{tabular}{rl}
            {\sanhao\heiti 学\qquad 生：} & {\sanhao\heiti \@susethesis@author} \\[0.6em]
            {\sanhao\heiti 学\qquad 号：} & {\sanhao\heiti \@susethesis@studentid} \\[0.6em]
            {\sanhao\heiti 专\qquad 业：} & {\sanhao\heiti \@susethesis@major} \\[0.6em]
            {\sanhao\heiti 班\qquad 级：} & {\sanhao\heiti \@susethesis@class} \\[0.6em]
            {\sanhao\heiti 指导教师：} & {\sanhao\heiti \@susethesis@advisor} \\
        \end{tabular}
        
        \vfill
        
        % 学院名称：小二号黑体，居中
        {\xiaoerhao\heiti \@susethesis@school}
        
        \vspace{0.5cm}
        
        % 日期：三号黑体，居中
        {\sanhao\heiti \@susethesis@date}
        
    \end{center}
    \clearpage
}

% ============================================================
% 15. 独创性声明 + 授权说明（合并一页）
% ============================================================
\newcommand{\makedeclaration}{%
    \thispagestyle{cover}
    \vspace*{0.5cm}
    \begin{center}
        {\xiaoerhao\heiti 独\quad 创\quad 性\quad 声\quad 明}
    \end{center}
    
    \vspace{0.3cm}
    
    \par\setlength{\baselineskip}{26pt}
    {\fontsize{14pt}{26pt}\selectfont\songti
    本人声明所呈交的学位论文是本人在导师指导下进行的研究工作及取得的研究成果。据我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得四川轻化工大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。}
    
    \vspace{0.8cm}
    
    \noindent{\sihao\songti
    作者签名：\underline{\hspace{3.5cm}} \hfill 日期：\underline{\hspace{0.8cm}}年\underline{\hspace{0.8cm}}月\underline{\hspace{0.8cm}}日}
    
    \vspace{1.2cm}
    
    \begin{center}
        {\xiaoerhao\heiti 关于论文使用授权的说明}
    \end{center}
    
    \vspace{0.3cm}
    
    \par\setlength{\baselineskip}{26pt}
    {\fontsize{14pt}{26pt}\selectfont\songti
    本学位论文作者完全了解四川轻化工大学有关保留、使用学位论文的规定，有权保留并向国家有关部门或机构送交论文的复印件和磁盘，允许论文被查阅和借阅。本人授权四川轻化工大学可以将学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存、汇编学位论文。
    （保密的学位论文在解密后应遵守此规定）}
    
    \vspace{0.8cm}
    
    \noindent{\sihao\songti
    作者签名：\underline{\hspace{3.5cm}} \hfill 导师签名：\underline{\hspace{3.5cm}}}
    
    \vspace{0.5cm}
    
    \noindent{\sihao\songti
    \hfill 日期：\underline{\hspace{0.8cm}}年\underline{\hspace{0.8cm}}月\underline{\hspace{0.8cm}}日}
    
    \clearpage
}

% ============================================================
% 16. 学术诚信与AI使用声明
% ============================================================
\newcommand{\makeintegrity}{%
    \thispagestyle{cover}
    \vspace*{0.5cm}
    \begin{center}
        {\xiaoerhao\heiti 学术诚信与AI使用声明}
    \end{center}
    
    \vspace{0.5cm}
    \vbox{\hsize=\textwidth
    \sihao\songti
    \setlength{\baselineskip}{28pt}
    本人郑重承诺：本毕业设计（论文）由本人在指导教师指导下独立完成，除标注引用外，不包含他人已发表或撰写的内容。使用AI工具情况：
    
    \vspace{0.3cm}
    
    \noindent\quad\quad$\square$未使用；
    
    \vspace{0.2cm}
    
    \noindent\quad\quad\makebox[\linewidth][l]{$\square$已使用，工具名称\underline{\hspace{9cm}}，}
 
 
    \noindent
    用途\underline{\hspace{13.4cm}}。
    
    \noindent  
    如有不实，本人愿承担一切责任。
    
    \vspace{1.5cm}
    
    \noindent
    学生签名：\underline{\hspace{3.5cm}} \hfill 日期：\underline{\hspace{0.8cm}}年\underline{\hspace{0.8cm}}月\underline{\hspace{0.8cm}}日
    
    \vspace{0.8cm}
    
    \noindent
    导师签名：\underline{\hspace{3.5cm}} \hfill 日期：\underline{\hspace{0.8cm}}年\underline{\hspace{0.8cm}}月\underline{\hspace{0.8cm}}日}
    
    % 恢复 baselineskip，防止泄漏到后续页面
    \xiaosihao\songti
    \setlength{\baselineskip}{22pt}
    \clearpage
}

% ============================================================
% 17. 中文摘要
% ============================================================
\newenvironment{cabstract}{%
    \hideheader
    \setcounter{page}{1}
    \pagenumbering{arabic}
    % 论文题目：黑体小2、行距固定值22磅，段前12磅段后12磅、居中
    \vspace*{12pt}
    {\centering\fontsize{18pt}{22pt}\selectfont\heiti \@susethesis@title\par}
    \vspace{12pt}
    
    \vspace{0.5cm}
    
    % 摘要标题：黑体小2、行距固定值22磅，段前12磅段后12磅、居中
    {\centering\fontsize{18pt}{22pt}\selectfont\heiti 摘\quad 要\par}
    \vspace{12pt}
    
    % 内容：小四号宋体，行距固定值22磅，首行缩进2字符
    \xiaosihao\songti
    \setlength{\baselineskip}{22pt}
    \setlength{\parindent}{2em}
}{%
    \clearpage
}

\newcommand{\ckeywords}[1]{%
    \vspace{0.5cm}
    \noindent{\xiaosihao\heiti\bfseries 关键词：}{\xiaosihao\songti #1}
}

% ============================================================
% 18. 英文摘要（严格按格式要求）
% ============================================================
\newcommand{\@susethesis@etitle}{}
\newcommand{\thesistitleen}[1]{\renewcommand{\@susethesis@etitle}{#1}}

\newenvironment{eabstract}{%
    \hideheader
    % 英文题目：Times New Roman 小2加粗、行距固定值22磅、段前12磅、段后12磅、居中
    \vspace*{12pt}
    {\centering\fontsize{18pt}{22pt}\selectfont\@susethesis@etitle\par}
    \vspace{12pt}
    
    \vspace{0.5cm}
    
    % ABSTRACT：Times New Roman 3号加粗、段前12磅、段后12磅、居中
    {\centering\sanhao ABSTRACT\par}
    \vspace{12pt}
    
    % 内容：Times New Roman 小4，行间距固定值22磅，首行缩进2字符，两端对齐
    \xiaosihao
    \setlength{\baselineskip}{22pt}
    \setlength{\parindent}{2em}
}{%
    \clearpage
}

\newcommand{\ekeywords}[1]{%
    \vspace{0.5cm}
    % Keywords: Times New Roman 小4 加粗，K大写
    \noindent{\xiaosihao\bfseries Keywords: }{\xiaosihao #1}
}

% ============================================================
% 19. 致谢环境
% ============================================================
\newenvironment{acknowledgements}{%
    \chapter*{致\quad 谢}
    \addcontentsline{toc}{chapter}{\texorpdfstring{致\quad 谢}{致谢}}
    \xiaosihao\songti
    \setlength{\parindent}{2em}
}{%
    \clearpage
}

% ============================================================
% 20. 参考文献标题
% ============================================================
\renewcommand{\bibname}{\texorpdfstring{\vspace*{-2em}\begin{center}\sanhao\heiti 参考文献\end{center}\vspace{1em}}{参考文献}}

% ============================================================
% 21. 附录
% ============================================================
\renewcommand{\appendixname}{附录}

% ============================================================
% 22. 每章自动分页 + 章节页也显示页眉
% ============================================================
% 章节页页眉已在 titleformat 中通过 [\thispagestyle{fancy}] 设置

% ============================================================
% 23. 其他实用命令
% ============================================================
\newcommand{\fig}[4][htbp]{%
    \begin{figure}[#1]
        \centering
        \includegraphics[width=#3]{#2}
        \caption{#4}
    \end{figure}
}

\newcommand{\tab}[4][htbp]{%
    \begin{table}[#1]
        \centering
        \caption{#4}
        #3
    \end{table}
}

\endinput
