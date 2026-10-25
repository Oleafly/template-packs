%	---	定义的新的类
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CUGThesis}[2024/04/18 Version 1.1 China University of Geosciences Thesis Template]
%\NeedsTeXFormat{LaTeX2e}




%
%	---	载入Class
%
\LoadClass[a4paper]{article}

%\LoadClass[ scheme=chinese, heading=true, %nofonts,
 %   12pt, utf8, a4paper, punct, fancyhdr, twoside, openright,
  %  amstex]{article}

%%%%%%%%%%%%%%%%%%%%%%% Load Packages %%%%%%%%%%%%%%%%%%%%%%
%页面基本设置
\RequirePackage[boldfont,slantfont]{xeCJK}
\RequirePackage[cs4size,UTF8,heading=true,fontset=fandol]{ctex}
\RequirePackage{xifthen, xparse, xstring, fancyhdr, etoolbox}

\RequirePackage{amstext, amsmath, amssymb, amsfonts}
\RequirePackage{mathrsfs, bm, mathtools}

\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}

\RequirePackage{array, longtable, makecell, tabu, booktabs}

\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\usepackage{ulem}
\usepackage{setspace}
\usepackage{float} % 在导言区加载 float 宏包



%------------------------------------------
%\RequirePackage{cugthesisfont}

%
%	---	定义页边距
%
%\RequirePackage{geometry}
%\geometry{left=3cm,right=3cm,top=2.5cm,bottom=2.0cm}
%\geometry{headsep=1em,footskip=2em}
%\geometry{headheight=14pt}

\RequirePackage[a4paper,
    marginparwidth=0pt, marginparsep=0pt,
    top=3cm, bottom=3cm, left=3cm, right=3cm,
    headheight=2.5cm, headsep=10pt, footskip=2cm]{geometry}
%
%	---	定义字体
%
%\RequirePackage{cugthesisfont}
\RequirePackage{xeCJK}
%用于设置非常用字体
\RequirePackage{fontspec}
%论文封面使用华文中宋
%\setCJKfamilyfont{song}{SimSun}                             %宋体 song
%\newcommand{\song}{\CJKfamily{song}}
%\RequirePackage{enumitem}
%\RequirePackage{xeCJK}
% 修改列表样式
%\RequirePackage{cugthesisfont}
%\usepackage[heading=true]{ctex}
%\setCJKfamilyfont{song}{SimSun}
                      %宋体 song

\setCJKmainfont[
        BoldFont =simhei.ttf,
        ItalicFont = STKAITI.TTF,
    ]{simsun.ttc}
\setCJKsansfont[
    BoldFont = simhei.ttf,
    ]{simsun.ttc}
\setCJKmonofont[
    BoldFont = simhei.ttf,
   ]{simsun.ttc}

\setCJKfamilyfont{song}{simsun.ttc}
\setCJKfamilyfont{hei}{simhei.ttf}
\newcommand{\song}{\CJKfamily{song}}    % 宋体   (Windows自带simsun.ttf)
\newcommand{\hei}{\CJKfamily{hei}}      % 黑体   (Windows自带simhei.ttf.ttf)

%\setCJKmainfont[BoldFont=simhei.ttf,ItalicFont=KaiTi]{SimSun}
\setmainfont[
    ItalicFont = {Times New Roman Italic},
    BoldFont = {Times New Roman Bold},
    BoldItalicFont = {Times New Roman Bold Italic},
    %SmallCapsFont = {Bodoni 72 Smallcaps},
    SmallCapsFeatures={Letters=SmallCaps},
]{Times New Roman}
\newcommand{\TimesNewRoman}{Times New Roman}    % 黑体   (Windows自带simhei.ttf)
\newcommand{\chuhao}{\fontsize{42pt}{\baselineskip}\selectfont}
\newcommand{\xiaochuhao}{\fontsize{36pt}{\baselineskip}\selectfont}
\newcommand{\yihao}{\fontsize{28pt}{\baselineskip}\selectfont}
\newcommand{\erhao}{\fontsize{21pt}{\baselineskip}\selectfont}
\newcommand{\xiaoerhao}{\fontsize{18pt}{\baselineskip}\selectfont}
\newcommand{\sanhao}{\fontsize{15.75pt}{\baselineskip}\selectfont}
\newcommand{\sihao}{\fontsize{14pt}{\baselineskip}\selectfont}
\newcommand{\xiaosihao}{\fontsize{12pt}{\baselineskip}\selectfont}
\newcommand{\wuhao}{\fontsize{10.5pt}{\baselineskip}\selectfont}
\newcommand{\xiaowuhao}{\fontsize{9pt}{\baselineskip}\selectfont}
\newcommand{\liuhao}{\fontsize{7.875pt}{\baselineskip}\selectfont}
\newcommand{\qihao}{\fontsize{5.25pt}{\baselineskip}\selectfont}
%	---	定义页眉页脚
%
%定义1.5倍行距
\renewcommand{\baselinestretch}{1.2}

%使用fancyhdr库
\RequirePackage{fancyhdr}
\RequirePackage{tikz}%用于绘制页脚横线

%设置页眉样式
\newcommand{\headstyle}{
	\fancyhead[OC]{\wuhao\song \defheadinfo}
	\fancyhead[OR]{\wuhao\song \thepage}

	\fancyhead[EC]{\wuhao\song \@author：\@title}
	\fancyhead[EL]{\wuhao\song \thepage}
}



%设置页脚样式
\newcommand{\footstyle}{%\fancyfoot[C]{\huawenzhongsong \zihao{5} \thepage}
	%\fancyfoot[L]{\tikz{\node (A) at (0,0) {}; \draw (0,1pt)--(6.7cm,1pt);}}
	%\fancyfoot[R]{\tikz{\node (A) at (0,0) {}; \draw (0,1pt)--(-6.7cm,1pt);}}
}
\pagestyle{fancy}
\fancyhf{} %清空原有样式
\headstyle
\footstyle

%定义一种新的格式叫做main
\fancypagestyle{main}{%
	\fancyhf{} %清空原有样式
	\headstyle
	\footstyle
    \renewcommand{\headrulewidth}{0.4pt}
}

%	---	标题样式设计
\RequirePackage{titlesec}
\ctexset{section={
        afterindent=true,
        %pagestyle=cug@pagestyle,
        aftername={\quad},
        format={\centering\sffamily\bfseries\sanhao\hei},
       beforeskip={50pt},
        afterskip={50pt},
        %parskip={2ex},
        name={第,章},
        number=\chinese{section}
        }
        } %节
\newcommand{\sectionbreak}{\clearpage} %小节从新的一页开始
\ctexset{subsection={
        afterindent=true,
        %pagestyle=cug@pagestyle,
        aftername={\quad},
        format={\centering\sffamily\bfseries\sihao \hei},
       % beforeskip={1ex},
       % afterskip={1ex},
        }
         } %小节
\ctexset{subsubsection={
        afterindent=true,
        aftername={\quad},
        format={\raggedright \hei \bfseries \xiaosihao}
        }
} %小小节
\ctexset{paragraph={beforeskip={0em}}}
\ctexset{subparagraph={beforeskip={0em}}}
%\titlespacing*{\section} {0pt}{2em}{2em}
%\titlespacing*{\section}
%{0pt}{0}{2\baselineskip}
\titlespacing*{\subsection}
{0pt}{\baselineskip}{\baselineskip}
\titlespacing*{\subsubsection}
{0pt}{\baselineskip}{\baselineskip}

%
%	---	定义新的中英文摘要环境
%
%中文摘要环境
\newenvironment{cnabstract}[1]{
	\def \cnkeyword {#1}
	\clearpage
	\thispagestyle{empty}
	%\phantomsection
	%\addcontentsline{toc}{section}{摘要}
	\begin{center} \hei \bfseries \xiaoerhao 摘 \hspace{2em} 要 \end{center}
	
}{
	\vspace{1em}
	\paragraph{\song \xiaosihao \bfseries 关键词：} \cnkeyword
	\clearpage
}

%英文摘要环境
\newenvironment{enabstract}[1]{
	\def \enkeyword {#1}
	\clearpage
	\thispagestyle{empty}
	%\phantomsection
	%\addcontentsline{toc}{section}{Abstract}
	\begin{center} \bfseries \xiaoerhao Abstract \end{center}
	
}{
	\vspace{1em}
	\paragraph{\song \xiaosihao \bfseries Key Words: } \enkeyword
	\clearpage
}


%设置附录

\RequirePackage[title,titletoc]{appendix}
\renewcommand{\appendixname}{附录}


%	---	定义新的目录页面
%
\RequirePackage{tocloft}
\tocloftpagestyle{empty}
\renewcommand{\cfttoctitlefont}{\hei \sanhao \bfseries }
%\renewcommand{\contentsname}{目录}
\renewcommand{\contentsname}{\hspace*{\fill}目\quad 录\hspace*{\fill}}
%\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftbeforesubsubsecskip}{0pt}
\renewcommand{\cftsecdotsep}{\cftdotsep} %设置Section引导点
\setlength{\cftsecindent}{0em}
\setlength{\cftsubsecindent}{1\ccwd}
\setlength{\cftsubsubsecindent}{2\ccwd}
\renewcommand{\cftsecfont}{\sihao\song}
\renewcommand{\cftsubsecfont}{\xiaosihao\song}
\renewcommand{\cftsubsubsecfont}{\xiaosihao\song}



%	---	设置图表格式
%
%设置图表标题的计数方式
\makeatletter
\@addtoreset{figure}{section}
\@addtoreset{table}{section}
\renewcommand{\thefigure}{\ifnum \c@section>\z@ \thesection.\fi \@arabic\c@figure}
\renewcommand{\thetable}{\ifnum \c@section>\z@ \thesection.\fi \@arabic\c@table}

%设置标题的样式
\RequirePackage{caption}
\captionsetup{labelsep=quad,font={normalsize,bf,singlespacing}}
\captionsetup[figure]{position=bottom,skip={0pt},font={footnotesize}}
\captionsetup[table]{position=top,skip={0pt},font={footnotesize}}
\setlength{\textfloatsep}{0pt}
\setlength{\floatsep}{0pt}
\setlength{\intextsep}{6pt}
\setlength{\abovecaptionskip}{0pt}
\setlength{\belowcaptionskip}{0pt}

%重新设置图表autoref
\newcommand{\figureautorefname}{图}
\newcommand{\tableautorefname}{表}

%使用tabularx库并定义新的左右中格式
\RequirePackage{tabularx}
\RequirePackage{makecell}
\newcolumntype{L}{X}
\newcolumntype{C}{>{\centering \arraybackslash}X}
\newcolumntype{R}{>{\raggedright \arraybackslash}X}

%添加复杂的表格需求库
\RequirePackage{booktabs}
%设置三线表格式
\setlength{\heavyrulewidth}{1.5pt}
\setlength{\lightrulewidth}{0.5pt}
\setlength{\cmidrulewidth}{0.5pt}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\abovetopsep}{0pt}
\setlength{\belowbottomsep}{0pt}

%添加图需要的库
\RequirePackage{graphicx}

%重新定义图和表的浮动环境，使其方便使用
\newenvironment{generalfig}[3][t]{
	\def \figcaption {#2}
	\def \figlabel {#3}
	\begin{figure}[#1]
		\centering
		\wuhao
	}{
		\caption{\figcaption} \label{\figlabel}
	\end{figure}
}
\newenvironment{generaltab}[3][t]{
	\def \tabcaption {#2}
	\def \tablabel {#3}
	\begin{table}[#1]
		\caption{\tabcaption} \label{\tablabel}
		\wuhao
		\centering
	}{
	\end{table}
}


%
%	---	设置公式格式
%
%使用ams的数学库
\RequirePackage{amsmath}
\RequirePackage{bm}

%设置公式间距为零
\AtBeginDocument{
	\setlength{\abovedisplayskip}{6pt}
	\setlength{\belowdisplayskip}{6pt}
	\setlength{\abovedisplayshortskip}{0pt}
	\setlength{\belowdisplayshortskip}{0pt}
}

%公式编号带章节
\numberwithin{equation}{section}

%重新设置公式autoref
\newcommand{\equationautorefname}{等式}




%
%	---	定义列表项的样式
%
\RequirePackage{enumitem}
\setenumerate{fullwidth,itemindent=\parindent,listparindent=\parindent,itemsep=0ex,partopsep=0pt,parsep=0ex}
\setlist{noitemsep}

\def\defcodelinenoswitch{yes}
\newcommand{\codelinenoswitch}[1]{\def\defcodelinenoswitch{#1}}


\usepackage{listings}
% 代码格式设置
\lstset{
    language=Python, % 设置语言
 basicstyle=\ttfamily, % 设置字体族
 breaklines=true, % 自动换行
 keywordstyle=\bfseries\color{NavyBlue}, % 设置关键字为粗体，颜色为 NavyBlue
 morekeywords={}, % 设置更多的关键字，用逗号分隔
 emph={self}, % 指定强调词，如果有多个，用逗号隔开
    emphstyle=\bfseries\color{Rhodamine}, % 强调词样式设置
    commentstyle=\itshape\color{black!50!white}, % 设置注释样式，斜体，浅灰色
    stringstyle=\bfseries\color{PineGreen!90!black}, % 设置字符串样式
    columns=flexible,
    numbers=left, % 显示行号在左边
    numbersep=2em, % 设置行号的具体位置
    numberstyle=\footnotesize, % 缩小行号
    frame=single, % 边框
    framesep=1em % 设置代码与边框的距离
}



%%	---	设置图表格式
%%
%%设置图表标题的计数方式
%\renewcommand{\thefigure}{\ifnum \c@section>\z@ \thesection-\fi \@arabic\c@figure}
%\renewcommand{\thetable}{\ifnum \c@section>\z@ \thesection-\fi \@arabic\c@table}
%
%%设置标题的样式
%\RequirePackage{caption}
%\captionsetup{font={normalsize,bf,singlespacing}}
%\captionsetup[figure]{position=bottom,skip={0pt}}
%\captionsetup[table]{position=top,skip={0pt}}
%\setlength{\textfloatsep}{0pt}
%\setlength{\floatsep}{0pt}
%\setlength{\intextsep}{6pt}
%\setlength{\abovecaptionskip}{0pt}
%\setlength{\belowcaptionskip}{0pt}
%
%%重新设置图表autoref
%%\newcommand{\figureautorefname}{图}
%%\newcommand{\tableautorefname}{表}
%
%%使用tabularx库并定义新的左右中格式
%\RequirePackage{tabularx}
%\RequirePackage{makecell}
%\newcolumntype{L}{X}
%\newcolumntype{C}{>{\centering \arraybackslash}X}
%\newcolumntype{R}{>{\raggedright \arraybackslash}X}
%
%%添加复杂的表格需求库
%\RequirePackage{booktabs}
%%设置三线表格式
%\setlength{\heavyrulewidth}{1.5pt}
%\setlength{\lightrulewidth}{0.5pt}
%\setlength{\cmidrulewidth}{0.5pt}
%\setlength{\aboverulesep}{0pt}
%\setlength{\belowrulesep}{0pt}
%\setlength{\abovetopsep}{0pt}
%\setlength{\belowbottomsep}{0pt}
%
%%添加图需要的库
%\RequirePackage{graphicx}
%
%%重新定义图和表的浮动环境，使其方便使用
%%\newenvironment{generalfig}[3][htbp]{
%%	\def \figcaption {#2}
%%	\def \figlabel {#3}
%%	\begin{figure}[#1]
%%		\centering
%%	}{
%%		\caption{\figcaption} \label{\figlabel}
%%	\end{figure}
%%}
%%\newenvironment{generaltab}[3][htbp]{
%%	\def \tabcaption {#2}
%%	\def \tablabel {#3}
%%	\begin{table}[#1]
%%		\caption{\tabcaption} \label{\tablabel}
%%		\zihao{5}
%%		\centering
%%	}{
%%	\end{table}
%%}


%
%	---	设置公式格式
%
%使用ams的数学库
\RequirePackage{amsmath}
\RequirePackage{bm}

%设置公式间距为零
\AtBeginDocument{
	\setlength{\abovedisplayskip}{6pt}
	\setlength{\belowdisplayskip}{6pt}
	\setlength{\abovedisplayshortskip}{0pt}
	\setlength{\belowdisplayshortskip}{0pt}
}

%公式编号带章节
\numberwithin{equation}{section}

%重新设置公式autoref
%\newcommand{\equationautorefname}{等式}


%-------------------------封面制作---------------------------

\RequirePackage{zhnumber}
%\newcommand{\cugthesisdate}[2]{%
 %   \date{\zhdigits{#1}年\zhdigits{#2}月}
%}
%	---	定义新的标题页面
%
%添加几个新的文档属性
\def \defschool {}
\def \defclassnum {}
\def \defstunum {}
\def \definstructor {}
\newcommand{\school}[1]{\def \defschool {#1}}
\newcommand{\classnum}[1]{\def \defclassnum {#1}}
\newcommand{\stunum}[1]{\def \defstunum {#1}}
\newcommand{\instructorone}[1]{\def \definstructorone {#1}}
\newcommand{\instructoronelevel}[1]{\def \definstructoronelevel {#1}}
\newcommand{\instructortwo}[1]{\def \definstructortwo {#1}}
\newcommand{\instructortwolevel}[1]{\def \definstructortwolevel {#1}}
\newcommand{\logoname}[1]{\def \deflogoname {#1}}
\newcommand{\headinfo}[1]{\def \defheadinfo {#1}}
\newcommand{\lineflag}[1]{\def \deflineflag {#1}}
\newcommand{\yearzh}[1]{\def \defyear {#1}}
\newcommand{\monthzh}[1]{\def \defmonth {#1}}


\RequirePackage{zhnumber}
%\newcommand{\cugthesisdate}[2]{%

%}
%
%	---	定义列表项的样式
%
\RequirePackage{enumitem}
\setlist{noitemsep}


\newcommand{\maybeuline}[1]{%
  \ifthenelse{\equal{\deflineflag}{yes}}%
    {\uline{\makebox[12em][c]{#1}}}% 下划线+居中
    {#1}% 正常显示
}


% 重置命令 maketitle
\renewcommand{\maketitle}[1][12em]{
    \begin{titlepage}
        \centering
        \begin{center}
            \vspace*{42.2825pt}
            \includegraphics[height=7cm]{\deflogoname}\\  % 插入 logo
            \vspace{62.6825pt}
            {\huge \hei \bfseries \@title}\\  % 主标题，字体更大
            \vspace{2em}  % 适当增加标题和副标题之间的空白
            {\xiaoerhao \bfseries \subtitle}\\  % 副标题，字体设置为小一些
            \vspace{4em}  % 适当增加副标题和表格之间的空白
            {\sanhao \song
            \renewcommand\arraystretch{1.5}
            \hspace*{4em}
            \begin{tabular}{lc}
                \makebox[6em][s]{学\ \ \ \ 号:} &
                \makebox[#1][l]{\quad\maybeuline{\defstunum}} \\
                \makebox[6em][s]{姓\ \ \ \ 名:} &
                \makebox[#1][l]{\quad\maybeuline{\@author}} \\
                \makebox[6em][s]{学 \ 科 \ 专 \ 业:} &
                \makebox[#1][l]{\quad\maybeuline{\defclassnum}} \\
                \makebox[6em][s]{指 \ 导 \ 教 \ 师:} &
                \makebox[#1][l]{\quad\maybeuline{\definstructorone\ \definstructoronelevel}} \\
                \makebox[6em][s]{培 \ 养 \ 单 \ 位:} &
                \makebox[#1][l]{\quad\maybeuline{\defschool}} \\
            \end{tabular}}\\
            \vspace{6em}
            {\sanhao \zhdigits{\defyear}年\zhdigits{\defmonth}月}\\
        \end{center}
    \end{titlepage}
}
% 新命令：插入副标题
\newcommand{\subtitle}[1]{\def\subtitle{#1}}



\RequirePackage{setspace}
%设置命令
\newcommand{\makestatement}[2][0]{
	\clearpage
	\thispagestyle{empty}
	\vspace*{1em}
	\begin{center}
\begin{spacing}{1.25}{
		\hei \sanhao
		中国地质大学（武汉）学士学位论文原创性声明
}
\end{spacing}
	\end{center}

\begin{spacing}{1.5}
 %\@title
 \song \sihao 

本人郑重声明：本人所呈交的学士学位论文《\@title》，是本人在指导老师的指导下，在中国地质大学（武汉）攻读学士学位期间独立进行研究工作所取得的成果。
论文中除已注明部分外不包含他人已发表或撰写过的研究成果，对论文的完成提供过帮助的有关人员已在文中说明并致以谢意。

本人所呈交的学士学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的法律责任和法律后果。\\

	
	\rightline{
	\begin{tabular}{r}
		\\
		学位论文作者签名：\uline{\makebox[6em]{}}\\
		\\
		日\hspace{1em}期： \hspace{3em}年 \hspace{2em} 月 \hspace{2em} 日
	\end{tabular}
	}
	\end{spacing}
	
	\clearpage
}



\newcommand{\makeToc}{%
\pagestyle{empty}
\tableofcontents
\clearpage
\pagestyle{main}
\pagenumbering{arabic}
\setcounter{page}{1}
}

% 参考文献
\RequirePackage[sort&compress]{natbib}
\bibliographystyle{gbt7714-2005}
\bibpunct{[}{]}{;}{s}{}{;}
%--------------- Source Code ---------------
\endinput
