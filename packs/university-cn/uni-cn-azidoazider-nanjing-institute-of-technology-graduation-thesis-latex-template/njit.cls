%%%%%%%%%% NJIT 南京工程学院latex模板 %%%%%%%%%%
%%%%%%%%%% Azidiazide azide 3162572053@qq.com %%%%%%%%%%
%%%%%%%%%% 模板配置区域，宏包可自行添加（以下宏包已经过测试，不会发生冲突） %%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njit}
\LoadClass[a4paper,zihao=-4,UTF8]{ctexart}
\usepackage{calc} 
\usepackage{array}
\usepackage{listings}
\usepackage{xcolor}
\usepackage{float}
\usepackage{setspace}
\usepackage{mathtools}
\usepackage{booktabs}    
\usepackage{amsmath}    
\usepackage{algorithm} 
\usepackage{algpseudocode}  
\usepackage{tabularx}
\usepackage{tikz}
\usepackage{ulem}
\usepackage{geometry}
\usepackage{abstract}
%———————————————页边距（按要求谨慎调节，可能导致排版错乱）——————————————————————————————
\geometry{left=3cm,right=2.6cm,top=3.5cm,bottom=2.6cm,headheight=14pt} %页边距（本科规范）
%当使用研究生布局时，页边距会自用调整为研究生规范，无需调整
%———————————————页边距（按要求谨慎调节，可能导致排版错乱）——————————————————————————————

\usepackage{fancyhdr}
\pagestyle{fancy}
\usepackage{xeCJK} 


\setCJKmainfont{SimSun}[
    Path = ./,          % 字体在当前目录
    Extension = .ttf    % 文件扩展名
]
\setCJKfamilyfont{lishu}{lishu}[
    Path = ./,
    Extension = .ttf
]
\newcommand{\lishu}{\CJKfamily{lishu}}


\fancyhf{}
%——————————————————————————页眉调整——————————————————————————————————————
\fancyhead[C]{\zihao{4} \lishu  南京工程学院毕业设计说明书（论文）} %工科
%\fancyhead[C]{\zihao{4} \lishu  南京工程学院毕业论文} %文科
%\fancyhead[C]{\zihao{-5} \songti  南京工程学院硕士专业学位论文} %硕士
%——————————————————————————页眉调整——————————————————————————————————————

\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}

\setmainfont{Times New Roman}
\setmonofont{Times New Roman}
\usepackage{enumerate}

\usepackage{setspace}
\setstretch{1.5}

\usepackage{pdfpages}

\usepackage{algorithm}

\usepackage{listings}
\lstset{basicstyle=\zihao{-5}\ttfamily,flexiblecolumns,}
\usepackage{tcolorbox}
\tcbuselibrary{listings}
\usepackage{xcolor}
\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black,urlcolor=black]{hyperref}

\usepackage{graphicx}
\graphicspath{{./figs/color/}}
% \usepackage{subfigure}
\usepackage{subcaption}
\renewcommand{\thesubfigure}{\alph{subfigure}}

\usepackage{cleveref}
\usepackage{booktabs}
\usepackage{multirow}
\usepackage{longtable}
\renewcommand{\arraystretch}{1.5}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{bm}
\usepackage{mathtools}
\newtagform{brackets}{（}{）}
\usetagform{brackets}

\usepackage{caption}
\renewcommand{\captionfont}{\zihao{5}}
\renewcommand{\captionlabelfont}{}
\captionsetup{labelsep=space}

\numberwithin{figure}{section}
\numberwithin{table}{section}
\numberwithin{equation}{section}

\usepackage{xltxtra}
\usepackage{shapepar}

\ctexset {
    section       = {
        format    = {\zihao{3}  \heiti  \centering}
    },
    subsection    = {
        format    = {\zihao{4} \heiti  \raggedright}
    },
    subsubsection = {
        format    = {\zihao{-4} \heiti \raggedright}
    },
    paragraph     = {
        format    = {\zihao{-4} \songti \raggedright},
        runin     = false,
        afterskip = {1.5ex \@plus .2ex}
    }
}

\usepackage{titletoc}
\titlecontents{section}
[0em] {\color{black}\zihao{4}\heiti \addvspace{0.5ex}}
{\thecontentslabel\hspace*{1em}} {}
{\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsection}
[2em] {\color{black}\normalsize\addvspace{0.5ex}}
{\thecontentslabel\hspace*{1em}} {\hspace*{-2.3em}}
{\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsubsection}
[4em] {\color{black}\normalsize\addvspace{0.5ex}}
{\thecontentslabel\hspace*{1em}} {\hspace*{-2.3em}}
{\titlerule*[0.4pc]{.}\contentspage}

\usepackage{gbt7714}
\renewcommand*{\bibfont}{\zihao{-4}}
\bibliographystyle{gbt7714-2005-numerical}
\renewcommand{\refname}{
    \vspace{2ex}
    \section*{参考文献}
    \phantomsection
    \addcontentsline{toc}{section}{参考文献}
}
\renewcommand{\bibsection}{\refname}
\setlength{\bibsep}{0.25em}


\RequirePackage{etoolbox} 

%------------------- 封面选项定义（选择哪个封面把后缀改成true，其余保持false） -------------------
\newif\if@usecoverA
\@usecoverAtrue % 使用工科封面
\newif\if@usecoverB
\@usecoverBfalse % 使用文科封面
\newif\if@usecoverC
\@usecoverCfalse % 使用硕士封面
%------------------- 封面选项定义（选择哪个封面把后缀改成true，其余保持false） -------------------

\DeclareOption{cover1}{\@usecoverAtrue\@usecoverBfalse\@usecoverCfalse}
\DeclareOption{cover2}{\@usecoverAfalse\@usecoverBtrue\@usecoverCfalse}
\DeclareOption{cover3}{\@usecoverAfalse\@usecoverBfalse\@usecoverCtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%------------------- 封面定义 -------------------
\if@usecoverA
    \newcommand{\cover}[9]{
        \begin{titlepage}
            \begin{center}
                \vspace*{-10mm}
                \hskip -40pt
                \includegraphics[height=4cm]{njit_logo/logo.pdf}

                \vspace*{15mm}
                \hskip -20pt
                {\heiti \zihao{-0} 毕业设计说明书\hspace{-0.5em}（\hspace{-0.1em}论文\hspace{-0.1em}）}\\
                \vspace{20mm}
                
                \zihao{-3}
                \setlength{\labelwidth}{3.5cm}

                \hskip -70pt
                \begin{tabular}{@{}>{\raggedleft}p{\labelwidth}@{\hspace{4pt}}l@{}}
                    作\hphantom{者}者： & \uline{\makebox[3.5cm][c]{#1}} \quad 学\hphantom{号}号：\uline{\makebox[3.5cm][c]{#2}} \\
                    单\hphantom{位}位： & \uline{\makebox[10cm][c]{#3}} \\
                    专\hphantom{业}业： & \uline{\makebox[10cm][c]{#4}} \\
                    题\hphantom{目}目： & \uline{\makebox[10cm][c]{#5}} \\
                    & \uline{\makebox[10cm][c]{#6}} \\ 
                    & \\
                    指导者： & \uline{\makebox[10cm][c]{#7}} \\
                    评阅者： & \uline{\makebox[10cm][c]{#8}}
                \end{tabular}   
                \vfill
                {\heiti\zihao{-2} #9 \quad 南\hspace{0.4em}京}
            \end{center}
        \end{titlepage}
    }
\else\if@usecoverB
    \newcommand{\cover}[9]{
        \begin{titlepage}
            \begin{center}
                \vspace*{-15mm}
                \includegraphics[height=8cm]{njit_logo/logo2.pdf}

                \vspace*{5mm}
                {\heiti \zihao{-0} 本\hspace{0.4em}科\hspace{0.4em}毕\hspace{0.4em}业\hspace{0.4em}论\hspace{0.4em}文}\\
                \vspace{15mm}
                
                \zihao{-3}
                \setlength{\labelwidth}{3.5cm}

                \hskip -60pt
                \begin{tabular}{@{}>{\raggedleft}p{\labelwidth}@{\hspace{4pt}}l@{}}
                    作\hphantom{者}者： & \uline{\makebox[3.5cm][c]{#1}} \quad 学\hphantom{号}号：\uline{\makebox[3.5cm][c]{#2}} \\
                    单\hphantom{位}位： & \uline{\makebox[10cm][c]{#3}} \\
                    专\hphantom{业}业： & \uline{\makebox[10cm][c]{#4}} \\
                    题\hphantom{目}目： & \uline{\makebox[10cm][c]{#5}} \\
                    & \uline{\makebox[10cm][c]{#6}} \\ 
                    指导者： & \uline{\makebox[10cm][c]{#7}} \\
                    评阅者： & \uline{\makebox[10cm][c]{#8}}
                \end{tabular}   
                \vfill
                {\heiti\zihao{-2} #9 \quad 南\hspace{0.4em}京}
            \end{center}
        \end{titlepage}
    }
\else
    \newcommand{\cover}[9]{
        \begin{titlepage}
            \begin{center}
                \vspace*{-1cm}
                {\fontsize{26}{26}\selectfont \kaishu \textbf{南\ 京\ 工\ 程\ 学\ 院} \\}
                \vspace{0.5cm}
                {\fontsize{26}{26}\selectfont \songti \textbf{硕\ 士\ 专\ 业\ 学\ 位\ 论\ 文} \\}
                \vspace{2.5cm}
                {\fontsize{26}{24}\selectfont 
                 \heiti \textbf{#5} \\
                 \vspace{12pt}
                 \textbf{#6} \\}
                \vspace{4.5cm}
             
\begin{spacing}{1.5}
    \fontsize{16}{19}\selectfont
    \begin{tabular}{@{}ll@{}}
        \makebox[5em][s]{专\hspace{0.33em}业\hspace{0.33em}名\hspace{0.33em}称：} & \uline{\makebox[8cm][c]{#4}} \\
        \makebox[5em][s]{研究生姓名：} & \uline{\makebox[8cm][c]{#1}} \\
        \makebox[5em][s]{导\hspace{0.33em}师\hspace{0.33em}姓\hspace{0.33em}名：} & \uline{\makebox[8cm][c]{#7}} \\
        \makebox[5em][s]{校\hspace{0.33em}外\hspace{0.33em}导\hspace{0.33em}师：} & \uline{\makebox[8cm][c]{#8}} \\
    \end{tabular}
\end{spacing}
                
                \vfill
                {\fontsize{14}{16}\selectfont \songti \textbf{#9}  }
            \end{center}
        \end{titlepage}
    }
\fi\fi

\newcommand{\mytableofcontents}{
    \renewcommand{\contentsname}{}
    {\zihao{3}\heiti
        \begin{center}
            目\quad 录
        \end{center}}
    \vspace*{-4.5em}
    \tableofcontents
}

\newcommand{\maketitleofchinese}[3]{
    \newpage
    \begin{center}
        \zihao{3} \heiti #1
        \vspace*{0.8em}
        \zihao{4} \songti #2 \vspace*{0.5em}
        \zihao{5} \songti 南京工程学院#3学院，江苏\ 南京\ 211167
        \zihao{5} ~
    \end{center}
}

\newcommand{\abstractofchinese}[2]{
    \noindent \zihao{-4} \heiti 摘要：\zihao{-4}\kaishu{#1}
    \noindent \zihao{-4} \heiti 关键词：\zihao{-4}\kaishu{#2}
    \songti \zihao{-4}
}

\newcommand{\maketitleofenglish}[3]{
    \newpage
    \begin{center}
        \zihao{3} \textbf{#1}
        \vspace*{0.8em}
        \zihao{4} #2 \vspace*{0.5em}
        \zihao{5} #3，NJIT，Nanjing 211167，China
        \zihao{5} ~
    \end{center}
}

\newcommand{\abstractofenglish}[2]{
    \noindent \zihao{-4} \textbf{Abstract：} \zihao{5} #1
    \noindent \zihao{-4} \textbf{Key words：} \zihao{5} #2
    \newpage
}

\newcommand{\thanking}[1]{
    \clearpage
    \begin{center}
        \zihao{3} \heiti 致\hspace{2em}谢
    \end{center}
    \phantomsection
    \addcontentsline{toc}{section}{致谢}
    \vspace{7.875pt} \par
    \zihao{-4}\kaishu #1
}

\newcommand{\append}[1]{
    \clearpage
    \begin{center}
        \zihao{3} \heiti 附\hspace{2em} 录
    \end{center}
    \phantomsection
    \vspace{7.875pt} \par
    \zihao{-4}\kaishu #1
}


\lstnewenvironment{tcode}[1][]{
    \lstset{
        basicstyle=\ttfamily\zihao{-5},
        backgroundcolor=\color{gray!10},
        numbers=left,
        frame=single,
        breaklines=true,
        #1 % 允许参数覆盖
    }
}{}

\makeatletter
\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
    \pagestyle{fancy} % 强制目录页使用页眉
    \oldtableofcontents
}
\makeatother