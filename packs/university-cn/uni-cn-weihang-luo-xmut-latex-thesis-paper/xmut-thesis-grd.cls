% ============================================================================
% XMUT Thesis Template - 厦门理工学院硕士学位论文模板样式类
% ============================================================================
% 修改者：罗伟航
% 修改日期：2025年6月22日
% 版本：v1.2-template
% 说明：用于厦门理工学院硕士学位论文排版
% ============================================================================

%% math packages -- conflict with xunicode
% Use mathalfa for scalable script fonts (avoids discrete-size rsfs bitmap warnings)
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
\RequirePackage[scr=rsfs]{mathalfa}
\RequirePackage{upgreek} % 直立希腊字母字体
\RequirePackage[final]{pdfpages}
\RequirePackage{ragged2e}
\usepackage{tabularx}
\usepackage{dsfont}
\providecommand{\mathbbm}[1]{\mathds{#1}}

% --- Table formatting defaults ---
\newcommand{\xmu@defaulttablestretch}{1.2}
\renewcommand{\arraystretch}{\xmu@defaulttablestretch}
\newcommand{\setxmuttablestretch}[1]{\renewcommand{\arraystretch}{#1}}

\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{xmut-thesis-grd}[2021/12/28 v1.2 xmut-thesis-grd document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\newif\ifxmu@master\xmu@masterfalse
\newif\ifxmu@doctor\xmu@doctorfalse
\newif\ifxmu@istwoside\xmu@istwosidefalse
\newif\ifxmu@pdf\xmu@pdffalse
\newif\ifxmu@compact\xmu@compactfalse
\DeclareOption{twoside}{\xmu@istwosidetrue}
\DeclareOption{master}{\xmu@mastertrue}
\DeclareOption{doctor}{\xmu@doctortrue}
\DeclareOption{pdf}{\xmu@pdftrue}
\DeclareOption{compact}{\xmu@compacttrue}

\ProcessOptions\relax
\ifxmu@istwoside
	\LoadClass[zihao=-4,a4paper,twoside,openright,UTF8,space=auto]{ctexbook}
\else
	\LoadClass[zihao=-4,a4paper,oneside,openany,UTF8,space=auto]{ctexbook}
\fi

%% 论文原创性和论文著作权使用声明内容
\def\xmu@label@originality@title{厦门理工学院学位论文原创性声明}
\def\xmu@label@originality@authorsign{声明人~~~~（签名）：}
\def\xmu@label@originality@supervisorsign{指导教师（签名）：}
\def\xmu@label@originality@signdate{~~~~~~~~年~~~~月~~~~日}
\def\xmu@label@originality@content{本人呈交的学位论文是本人在导师指导下,独立完成的研究成果。本人在论文写作中参考其他个人或集体已经发表的研究成果，均在文中以适当方式明确标明，并符合法律规范和《厦门理工学院研究生学术活动规范（试行）》。\par
	另外，该学位论文为（~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~）课题（组）的研究成果，获得（~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~）课题（组）经费或实验室的资助，在（~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~）实验室完成。（请在以上括号内填写课题或课题组负责人或实验室名称，未有此项声明内容的，可以不作特别声明。）\par
	本人声明该学位论文不存在剽窃、抄袭等学术不端行为，并愿意承担因学术不端行为所带来的一切后果和法律责任。
}

\def\xmu@label@copyright@title{厦门理工学院学位论文著作权使用声明}
\def\xmu@label@copyright@content{本人同意厦门理工学院根据《中华人民共和国学位条例暂行实施办法》等规定保留和使用此学位论文，并向主管部门或其指定机构送交学位论文（包括纸质版和电子版），允许学位论文进入厦门理工学院图书馆及其数据库被查阅、借阅。本人同意厦门理工学院将学位论文加入全国博士、硕士学位论文共建单位数据库进行检索，将学位论文的标题和摘要汇编出版，采用影印、缩印或者其它方式合理复制学位论文。\par
	本学位论文属于：\par
	（\hspace{4.5em}） 1.经厦门理工学院保密委员会审查核定的涉密学位论文，于~~~~~~~~年~~~~月~~~~日解密，解密后适用上述授权。\par
	（\hspace{4.5em}） 2.不涉密，适用上述授权。\par
	（请在以上相应括号内打“√”或填上相应内容。涉密学位论文应是已经厦门理工学院保密委员会审定过的学位论文，未经厦门理工学院保密委员会审定的学位论文均为公开学位论文。此声明栏不填写的，默认为公开学位论文，均适用上述授权。）
}
\def\xmu@label@copyright@authorsign{声明人（签名）：}
\def\xmu@label@copyright@signdate{~~~~~~~~年~~~~月~~~~日}

%% 学位论文答辩委员会名单
\def\xmu@label@namelist@title{学位论文答辩委员会名单}

%% 定义一些标签 
\def\xmu@label@namelist{学位论文答辩委员会名单}
\def\xmu@label@abstract{摘~~~~要}
\def\xmu@label@compactabstract{摘要}
\def\xmu@label@enabstract{Abstract}
\def\xmu@label@abstractincontent{Abstract-Chinese}
\def\xmu@label@enabstractincontent{Abstract-English}
\def\xmu@label@keywords{关键词：}
\def\xmu@label@enkeywords{Keywords:~}
\def\xmu@label@appendix{附录}
\def\xmu@label@enappendix{Appendix}
\def\xmu@label@publications{在学期间完成的相关学术成果}
\def\xmu@label@enpublications{Relevant Academic Achievements Completed During the Acad-\linebreak emic Period}
\def\xmu@label@reference{参考文献}
\def\xmu@label@enreference{References}
\def\xmu@label@acknowledgements{致~~~~谢}
\def\xmu@label@compactacknowledgements{致谢}
\def\xmu@label@enacknowledgements{Acknowledgements}
\def\xmu@label@contents{目~~~~录}
\def\xmu@label@compactcontents{目录}
\def\xmu@label@encontents{Contents}
\def\xmu@label@acronymlist{主要缩略词表}
\def\xmu@label@symbollist{主要符号表}
\def\xmu@label@enacronymlist{List of Acronyms}
\def\xmu@label@ensymbollist{List of Symbols}
\def\xmu@label@figurelist{图索引}
\def\xmu@label@enfigurelist{List of Figures}
\def\xmu@label@tablelist{表索引}
\def\xmu@label@entablelist{List of Tables}
\def\xmu@value@templateversion{v1.0}

%% 封面标签
\def\xmu@label@schoolserialnumber{学校编码：}
\def\xmu@label@studentnumber{学~~~~~~~~号：}
\def\xmu@label@advisor{指导教师姓名：}
\def\xmu@label@major{专~~业~~~~名~~称：}
\def\xmu@label@submitdate{论文提交日期：}
\def\xmu@label@defenddate{论文答辩日期：}
\def\xmu@label@grantdate{学位授予日期：}

%% 封面内容
\def\xmu@value@schoolserialnumber{11062}
\def\xmu@value@studentnumber{2222031292}
\ifxmu@master
	\def\xmu@value@thesistype{硕~~~~士~~~~学~~~~位~~~~论~~~~文}
\else 
	\def\xmu@value@thesistype{博~~~~士~~~~学~~~~位~~~~论~~~~文}
\fi
\def\xmu@value@title{厦门理工学院硕士学位论文}%\def\xmu@value@title{标题}
\def\xmu@value@entitle{Capital Reorganization: }
\def\xmu@value@author{作者姓名:姓名}
\def\xmu@value@advisor{XXXX教授}
\def\xmu@value@major{}
\def\xmu@value@submitdate{~~~~年~~~~月}
\def\xmu@value@defenddate{~~~~年~~~~月}
\def\xmu@value@grantdate{~~~~年~~~~月}
\def\xmu@value@printdate{~~~~年~~~~月}

%% 设置封面内容的命令
\newcommand\schoolserialnumber[1]{\def\xmu@value@schoolserialnumber{#1}}
\newcommand\studentnumber[1]{\def\xmu@value@studentnumber{#1}}
\renewcommand\title[2][\xmu@value@title]{
	\def\xmu@value@title{#2}
	\def\xmu@value@titlemark{\MakeUppercase{#1}}}
\newcommand\entitle[2][\xmu@value@entitle]{
	\def\xmu@value@entitle{#2}
	\def\xmu@value@entitlemark{\MakeUppercase{#1}}}
\renewcommand\author[1]{\def\xmu@value@author{#1}}
\newcommand\advisor[1]{\def\xmu@value@advisor{#1}}
\newcommand\major[1]{\def\xmu@value@major{#1}}
\newcommand\submitdate[1]{\def\xmu@value@submitdate{#1}}
\newcommand\defenddate[1]{\def\xmu@value@defenddate{#1}}
\newcommand\grantdate[1]{\def\xmu@value@grantdate{#1}}
\newcommand\printdate[1]{\def\xmu@value@printdate{#1}}

%% 绘制封面
\newcommand\makecover{
	\setstretch{1.78889} % 设置行间距
	\newpage
	\cleardoublepage
	\thispagestyle{empty}
	\pdfbookmark[0]{封面}{cover}

	\ifxmu@pdf
		\includepdf[pages=-]{pdf_files/cover.pdf}
	\else

	{\bfseries \songti \zihao{-4} \noindent \xmu@label@schoolserialnumber \xmu@value@schoolserialnumber}  \\
	{\bfseries \songti \zihao{-4} \xmu@label@studentnumber \xmu@value@studentnumber}

	\vskip 20pt

	\begin{figure}[htb!]
		\centering
		\includegraphics[width=4.82cm]{figures/xmu-logo.pdf}
	\end{figure}

	\begin{center}
		{\bfseries \songti \zihao{2} \xmu@value@thesistype}
		\vskip 35pt
			{\bfseries \heiti \zihao{-2} \xmu@value@title}
		\vskip 15pt
			{\bfseries \zihao{3} \xmu@value@entitle}
		\vskip 55pt
			{\bfseries \kaishu \zihao{-2} \xmu@value@author}
		\vskip 30pt

			{\kaishu \zihao{-3}
				\begin{tabular}{r p{1mm} l}
					\xmu@label@advisor    &  & \xmu@value@advisor
					\\
					\xmu@label@major      &  & \xmu@value@major
					\\
					\xmu@label@submitdate &  & \xmu@value@submitdate
					\\
					\xmu@label@defenddate &  & \xmu@value@defenddate
					\\
					\xmu@label@grantdate  &  & \xmu@value@grantdate
				\end{tabular}}

		\vskip 100pt
			{\bfseries \songti \zihao{-4} \xmu@value@printdate}
	\end{center}

	\vskip \stretch{0.5}
		
	\fi

	\clearpage
}

%% 学位论文答辩委员会决议
\newcommand\makestatementone{
	\cleardoublepage
	\pdfbookmark[0]{学位论文答辩委员会决议}{thesis_Committee_Resolution}
	\thispagestyle{empty}
	
	\setstretch{2.2}
	\ifxmu@pdf
		\includepdf[pages=-]{pdf_files/thesisResolution.pdf}
	\else
		\begin{center}
			{\bfseries \heiti \zihao{-2} \xmu@label@originality@title}
		\end{center}
		\vskip 10pt
			{\songti\zihao{4} \par \xmu@label@originality@content}
		\vskip 20pt
		\hspace{8cm}{\zihao{4}\xmu@label@originality@authorsign\par}
		\hspace{8cm}{\zihao{4}\xmu@label@originality@supervisorsign\par}
		\vskip 20pt
		\hspace{8.4cm} {\zihao{4}\xmu@label@originality@signdate}
	\fi
	
	\clearpage
}

%% 论文著作权使用声明
\newcommand\makecopyrightstatement{
	\cleardoublepage
	\pdfbookmark[0]{著作权使用声明}{copyright_statement}
	\thispagestyle{empty}
	
	\setstretch{2.2}
	\ifxmu@pdf
		\includepdf[pages=-]{pdf_files/copyright_statement.pdf}
	\else
 		\begin{center}
			{\bfseries \heiti \zihao{-2} \xmu@label@copyright@title}
		\end{center}
		\vskip 10pt
			{\songti\zihao{4} \par \xmu@label@copyright@content}
		\vskip 20pt
		\hspace{8cm}{\zihao{4}\xmu@label@copyright@authorsign\par}
		\vskip 20pt
		\hspace{8.4cm} {\zihao{4}\xmu@label@copyright@signdate}
	\fi

	\clearpage
}

%% 学位论文答辩委员会名单
\newenvironment{namelist}{
	\cleardoublepage
	
	\thispagestyle{plain}
	\thispagestyle{empty}
	
	\songti\zihao{4}
	\setstretch{1.58889} % 设置行间距
}

\newcommand\makenamelist{
	\cleardoublepage
	\pdfbookmark[0]{学位论文答辩委员会名单}{name_list}
	\thispagestyle{empty}
	
	\ifxmu@pdf
		\includepdf[pages=-]{pdf_files/name_list.pdf}
	\else
		\input{chapters/name_list.tex}
	\fi

	\clearpage
}

%% 设置中文字体（优先从项目 fonts/ 目录加载，避免重复定义警告）
\let\songti\relax
\let\heiti\relax
\let\kaishu\relax
% 使用 setCJK 系列命令统一设置，避免与 newCJKfontfamily 冲突
% 先设置字体族，供后续调用
\setCJKfamilyfont{songti}{SimSun.ttc}[Path=./fonts/,AutoFakeSlant,AutoFakeBold={2}]
\setCJKfamilyfont{kaishu}{SimKai.ttf}[Path=./fonts/,AutoFakeSlant,AutoFakeBold={2}]
\setCJKfamilyfont{heiti}{SimHei.ttf}[Path=./fonts/,AutoFakeSlant,AutoFakeBold={2}]
% 定义字体命令
\newcommand{\songti}{\CJKfamily{songti}}
\newcommand{\kaishu}{\CJKfamily{kaishu}}
\newcommand{\heiti}{\CJKfamily{heiti}}


%% 设置英文字体
\setmainfont{Times New Roman}
\setsansfont{Arial Black}
\setmonofont{Times New Roman}

% 确保数字、字母、标点符号使用Times New Roman
\xeCJKsetup{CJKmath=true}

%% 中文破折号
\newcommand{\cndash}{\rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}}

%% the setup of ctex package
\def\contentsname{\xmu@label@contents}
\def\encontentsname{\xmu@label@encontents}
\def\listfigurename{\xmu@label@figurelist}
\def\listtablename{\xmu@label@tablelist}

%% 当前模板的版本
\newcommand{\version}{\xmu@value@templateversion}

%% 页面设置。设置纸张类型、页面边距和页眉、页脚
\RequirePackage[%
	paper = a4paper,%
	top = 2.5cm,%        % 正文上边距2.5cm
	bottom = 2.5cm,%     % 正文下边距2.5cm  
	left = 2.5cm,%       % 页面左边距2.5cm
	right = 2.5cm,%      % 页面右边距2.5cm
	headheight = 12pt,%  % 页眉高度
	headsep = 0.5cm,%    % 页眉到正文间距
	footskip = 1.0cm%    % 正文到页脚间距
]{geometry}

%% 设置段落间距
\setlength{\parskip}{0em}
\setlength{\abovedisplayskip}{0em}
\setlength{\belowdisplayskip}{0em}

%% 让空白页前后页码连续
\newcounter{blankpage}
\def\cleardoublepage{
	\clearpage
	\if@twoside 
		\ifodd 
			\c@page 
		\else
			\stepcounter{blankpage}%
			\hbox {}\newpage
		\fi 
	\fi 
}

%% 设置章节格式（一倍行距为字体大小 × 1.297(1.3) × 1.25）
\ctexset{chapter={
		name = {第,章},
		number = {\chinese{chapter}},
		format = {\bfseries \sffamily \heiti \centering \fontsize{18pt}{27pt}\selectfont}, % 小二黑体，行距 1.5 倍
		pagestyle = {xmu@headings},
		beforeskip = 0.5\baselineskip,    % 段前0.5 行
		afterskip = 0.5\baselineskip,     % 段后0.5 行
		fixskip = true,
		aftername = ~~~~,
	}
}

%% 设置一级节标题格式（3号 = 16pt）
\ctexset{section={
			format={\raggedright \bfseries \sffamily \heiti \fontsize{16pt}{16pt}\selectfont},
			beforeskip = 0.5\baselineskip,    % 段前0.5行
			afterskip = 0.5\baselineskip,     % 段后0.5行
			fixskip = true,
		}
}

%% 设置二级节标题格式（小3号 = 15pt）
\ctexset{subsection={
			format = {\bfseries \sffamily \heiti \raggedright \fontsize{15pt}{15pt}\selectfont},
			beforeskip = 0.5\baselineskip,
			afterskip = 0.5\baselineskip,
			fixskip = true,
		}
}

%% 设置三级节标题格式（小4号 = 12pt）
\ctexset{subsubsection={
			format={\bfseries \sffamily \heiti \raggedright \fontsize{12pt}{12pt}\selectfont},
			beforeskip = 0.5\baselineskip,
			afterskip = 0.5\baselineskip,
			fixskip = true,
		}
}

%% 选择编译
\RequirePackage{ifthen}

%% check pdfTeX mode
\RequirePackage{ifpdf}

%% 设置前置
\renewcommand{\frontmatter}{ % 修改 frontmatter 的页码为大写罗马格式，前置部分不显示页眉
	\if@openright\cleardoublepage\else\clearpage\fi
	\@mainmatterfalse
	\setcounter{blankpage}{0}
	\global\c@page \@ne
	\renewcommand\thepage{\@Roman{\the\numexpr\value{page}-\value{blankpage}\relax}}
	\thispagestyle{plain} % 前置部分默认不显示页眉
}

%% 设置正文
\RequirePackage[nodisplayskipstretch]{setspace}
\renewcommand{\mainmatter}{ % 修改 mainmatter 的页码为阿拉伯格式，并调整页面风格
	\if@openright\cleardoublepage\else\clearpage\fi
	\@mainmattertrue
	\pagestyle{xmu@headings}
	% removed global \setstretch{1.5} to avoid redundant multiplicative and explicit baseline controls
	\setcounter{blankpage}{0}
	\global\c@page \@ne
	\renewcommand\thepage{\@arabic{\the\numexpr\value{page}-\value{blankpage}\relax}}
}

%% 设置后置
\renewcommand{\backmatter}{%
	\@mainmatterfalse
}

%% 复杂表格
\RequirePackage{threeparttable}
\RequirePackage{dcolumn}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\newcolumntype{d}[1]{D{.}{.}{#1}}% or D{.}{,}{#1} or D{.}{\cdot}{#1}

%% 算法
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\floatname{algorithm}{算法}  
\renewcommand{\algorithmicrequire}{\textbf{输入:}}  
\renewcommand{\algorithmicensure}{\textbf{输出:}} 

%% 定理
\theoremstyle{plain}
\newtheorem{algo}{算法~}[chapter]
\newtheorem{thm}{定理~}[chapter]
\newtheorem{lem}[thm]{引理~}
\newtheorem{prop}[thm]{命题~}
\newtheorem{cor}[thm]{推论~}
\theoremstyle{definition}
\newtheorem{defn}{定义~}[chapter]
\newtheorem{conj}{猜想~}[chapter]
\newtheorem{exmp}{例~}[chapter]
\newtheorem{rem}{注~}
\newtheorem{case}{情形~}
\renewcommand{\proofname}{\bf 证明}

%% graphics packages
\RequirePackage{graphicx}

%% 并列子图
\RequirePackage{subcaption}
\RequirePackage{wrapfig}

%% 设置图表相关选项
\RequirePackage{float}
\RequirePackage{amsmath}
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{zhspace}{~~}

% 图表标题：宋体、五号（\zihao{5}），紧凑行距、非加粗
\DeclareCaptionFont{captionfont}{\songti\zihao{5}}
\DeclareCaptionFont{subcaptionfont}{\songti\zihao{5}}

\captionsetup[sub]{
    font = {subcaptionfont}
}
\captionsetup{
    font = {captionfont},
    labelsep = zhspace,
}
\captionsetup[table]{
	position = top,
	aboveskip = 8pt,    % 表格与标题之间的距离
	belowskip = 10pt,    % 标题与之前正文之间的距离
}
\numberwithin{table}{chapter}
\captionsetup[figure]{
	position = bottom,
	aboveskip = 8pt,    % 减少图片标题上方空白
	belowskip = 5pt,    % 标题与之后正文之间的距离
}

\setlength{\textfloatsep}{6pt}
\setlength{\floatsep}{6pt}    % 两个浮动体之间
\setlength{\intextsep}{6pt}   % 插在正文中的浮动体上下

% 带来源的标题命令
\newcommand*{\captionwithsource}[2]{%
    \caption[{#1}]{#1}%
    \vspace{3pt}%
    \parbox{\textwidth}{\zihao{-5}\hspace{2em}#2}%
}

%% 如果插入的图片没有指定扩展名，那么依次搜索下面的扩展名所对应的文件
\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg,.jpeg}

%% 定公式、图、表编号格式
\renewcommand\theequation{\arabic{chapter}-\arabic{equation}}
\renewcommand\thefigure{\arabic{chapter}-\arabic{figure}}
\renewcommand\thetable{\arabic{chapter}-\arabic{table}}

%% 颜色宏包
\RequirePackage{xcolor}

%% 设置源代码显示格式
\RequirePackage{listings}
\lstset{tabsize=4, %
	frame = shadowbox, %把代码用带有阴影的框圈起来
	commentstyle = \color{red!50!green!50!blue!50},%浅灰色的注释
	rulesepcolor = \color{red!20!green!20!blue!20},%代码块边框为淡青色
	keywordstyle = \color{blue!90}\bfseries, %代码关键字的颜色为蓝色，粗体
	showstringspaces = false,%不显示代码字符串中间的空格标记
	stringstyle = \ttfamily, % 代码字符串的特殊格式
	keepspaces = true, %
	breakindent = 22pt, %
	numbers = left,%左侧显示行号
	stepnumber = 1,%
	numberstyle = \tiny, %行号字体用小号
	basicstyle = \footnotesize, %
	showspaces = false, %
	flexiblecolumns = true, %
	breaklines = true, %对过长的代码自动换行
	breakautoindent = true,%
	breakindent = 4em, %
	aboveskip = 1em, %代码块边框
	%% added by http://bbs.ctex.org/viewthread.php?tid=53451
	fontadjust, %
	captionpos = t, %
	framextopmargin = 2pt, %
	framexbottommargin = 2pt, %
	abovecaptionskip = -3pt, %
	belowcaptionskip = 3pt, %
	xleftmargin = 4em, %
	xrightmargin = 4em, % 设定listing左右的空白
	texcl=true, %
	% 设定中文冲突，断行，列模式，数学环境输入，listing数字的样式
	extendedchars=false, %
	columns=flexible, %
	mathescape=true %
}
\renewcommand{\lstlistingname}{代码} %% 重命名Listings标题头

%% hyperref package
\RequirePackage{hyperref}
\hypersetup{
	bookmarksnumbered,%
	linktoc = all,
	colorlinks = true,
	citecolor = black,
	filecolor = black,
	linkcolor = black,
	linkbordercolor = black,
	urlcolor = black,
	plainpages = false,%
	pdfstartview = FitH
}

%% enumerate 列表环境间距调节
\RequirePackage{enumitem}

%% 页眉页脚
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancypagestyle{xmu@empty}{ %无页眉页脚
	\fancyhf{}}
\fancypagestyle{xmu@headings}{ %有页眉页脚
	\fancyhf{}
	\fancyfoot[C]{\songti\fontsize{10pt}{12pt}\selectfont \thepage}

	% 奇数页页眉：显示章节标题（如：第一章 绪 论）
	\fancyhead[CO]{\centering\fontsize{10pt}{12pt}\selectfont \songti \nouppercase\leftmark}
	% 偶数页页眉：显示固定文字（厦门理工学院硕士学位论文）
	\fancyhead[CE]{\centering\fontsize{10pt}{12pt}\selectfont \songti 厦门理工学院硕士学位论文}
	% 页眉横线
	\renewcommand{\headrulewidth}{0.4pt}
}

% 为 plain 页面定义无页眉横线的样式（用于目录、摘要等）
\fancypagestyle{plain}{%
	\fancyhf{}%
	\fancyfoot[C]{\songti\fontsize{10pt}{12pt}\selectfont \thepage}%
	% plain 页面无横线（chapter* 等通常会调用 thispagestyle{plain}）
	\renewcommand{\headrulewidth}{0pt}%
}

%% 脚注样式 
% 设置圈型角标
\interfootnotelinepenalty=100000
\RequirePackage{pifont}
\RequirePackage[hang,flushmargin,perpage,symbol*]{footmisc}
\DefineFNsymbols{circled}{{\ding{192}}{\ding{193}}{\ding{194}}
{\ding{195}}{\ding{196}}{\ding{197}}{\ding{198}}{\ding{199}}{\ding{200}}{\ding{201}}}
\setfnsymbol{circled}

% 设置角标数字的字体和正文一致，并且1.5字符缩进
\RequirePackage{scrextend}
\deffootnote{1.6em}{0em}{\thefootnotemark \enskip}


%中文摘要格式%%%%%%%%%%%%%%%%%%%

%% 新建中文摘要环境2
\newenvironment{cnabstract}{
	\cleardoublepage
	% 摘要页不显示页眉，仅保留页脚页码
	\thispagestyle{plain}

	% 保留原有目录页眉逻辑
    \ifxmu@compact
        \addcontentsline{toc}{chapter}{\xmu@label@compactabstract}
        \markboth{\xmu@label@compactabstract}{\xmu@label@compactabstract}
    \else
        \addcontentsline{toc}{chapter}{\xmu@label@abstract}
        \markboth{\xmu@label@abstract}{\xmu@label@abstract}
    \fi
    
    % 保留etoc目录条目
    \addcontentsline{etoc}{chapter}{\sffamily \xmu@label@abstractincontent}
	% 消除默认间距
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{0pt}

	% 中文标题
	\begingroup
	\centering
	% 移除过多的顶部间距，与章节标题保持一致
	{\bfseries\heiti\fontsize{18pt}{18pt}\selectfont \xmu@value@title\par}
	\vspace{6pt}
	\endgroup
    
    % 摘要标题
    \begingroup
    \centering
    {\bfseries\heiti\fontsize{14pt}{14pt}\selectfont 摘\quad 要\par}
	\vspace{6pt}
    \endgroup
    
	% 设置正文格式
	\songti\fontsize{12pt}{14pt}\selectfont % 小4宋体
	\setlength{\parindent}{2em} % 首行缩进
}

%% 配套关键词命令
\newcommand\cnkeywords[1]{
	\par\vspace{0.8\baselineskip} % 正文与关键词间距
	\noindent
	% removed redundant \setstretch{1.0}
	{\heiti\fontsize{12pt}{12pt}\selectfont\textbf{关键词：}} 
	{\songti\fontsize{12pt}{12pt}\selectfont #1\par}
}

%英文摘要格式%%%%%%%%%%%%%%%

%% 英文摘要环境
\newenvironment{enabstract}{
	\cleardoublepage
	% 摘要页不显示页眉，仅保留页脚页码
	\thispagestyle{plain}
	\ifxmu@compact
	\addcontentsline{toc}{chapter}{\xmu@label@compactenabstract} % 使用英文标签
	\markboth{\xmu@label@compactenabstract}{\xmu@label@compactenabstract}
	\else
	\addcontentsline{toc}{chapter}{\xmu@label@enabstract} % 使用英文标签
	\markboth{\xmu@label@enabstract}{\xmu@label@enabstract}
	\fi
    % 消除默认间距
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{0pt}
    
    % 英文标题
	\begingroup
	\centering
	% 移除过多的顶部间距，与章节标题保持一致
	{\bfseries\sffamily\fontsize{18pt}{18pt}\selectfont \xmu@value@entitle\par}
	\endgroup

	% 英文题目与 Abstract 之间的间距
	\vspace{12pt}
    \begingroup
    \centering
    {\bfseries\sffamily\fontsize{14pt}{16pt}\selectfont Abstract\par}
    \endgroup
    
	% 正文格式
	% 使用Times New Roman，调整设置以接近Word效果
	\fontspec{Times New Roman}\fontsize{12pt}{14pt}\selectfont
	\setlength{\parindent}{2em} % 英文段落缩进
}

%% 英文关键词
\newcommand\enkeywordst[1]{
	\par\vspace{1.0\baselineskip} % 正文与关键词间距
	\noindent
	% removed redundant \setstretch{1.0}
	{\fontspec{Arial Black}\bfseries\fontsize{12pt}{12pt}\selectfont Keywords: } 
	{\rmfamily\fontsize{12pt}{12pt}\selectfont #1\par}
}
%%%%%%%%%%%%%%

%% 设置目录各级标题样式
\RequirePackage{titletoc}
\titlecontents{chapter}[0pt]
	{\contentsmargin{0mm} \bfseries \songti \fontsize{14pt}{21pt}\selectfont}
	{\thecontentslabel\hspace{\ccwd}}
	{\bfseries}
	{\hspace{.5em}\titlerule*{\fontsize{12pt}{12pt}\selectfont \normalfont.} {\normalfont \fontsize{12pt}{12pt}\selectfont \thecontentspage}}
\titlecontents{section}[1\ccwd]
	{\contentsmargin{0mm} \songti \fontsize{12pt}{18pt}\selectfont}
	{\thecontentslabel\hspace{\ccwd}}
	{\bfseries}
	{\hspace{.5em}\titlerule*{\fontsize{12pt}{12pt}\selectfont \normalfont.} {\normalfont \fontsize{12pt}{12pt}\selectfont \thecontentspage}}
\titlecontents{subsection}[2\ccwd]
	{\contentsmargin{0mm} \songti \fontsize{12pt}{18pt}\selectfont}
	{\thecontentslabel\hspace{\ccwd}}
	{}
	{\hspace{.5em}\titlerule*{\fontsize{12pt}{12pt}\selectfont \normalfont.} {\normalfont \fontsize{12pt}{12pt}\selectfont \thecontentspage}}

%% 设置图索引样式
\titlecontents{figure}[0pt]{\songti\fontsize{12pt}{12pt}\selectfont}
	{\parbox[t]{1.55cm}{\figurename~\thecontentslabel}}{\hspace*{-1.5cm}}
	{\hspace{.5em}\titlerule*{\fontsize{12pt}{12pt}\selectfont \normalfont.} {\normalfont \fontsize{12pt}{12pt}\selectfont \thecontentspage}}

%% 设置表索引样式
\titlecontents{table}[0pt]{\songti\fontsize{12pt}{12pt}\selectfont}
	{\parbox[t]{1.55cm}{\tablename~\thecontentslabel}}{\hspace*{-1.5cm}}
	{\hspace{.5em}\titlerule*{\fontsize{12pt}{12pt}\selectfont \normalfont.} {\normalfont \fontsize{12pt}{12pt}\selectfont \thecontentspage}}


%% 中英文目录
\addtocontents{toc}{\protect\hypersetup{hidelinks}}
\addtocontents{etoc}{\protect\hypersetup{hidelinks}}

%% 中文目录
\renewcommand\tableofcontents{
	%\setstretch{1}

	\chapter*{\contentsname}
	\thispagestyle{plain}
	\pagestyle{plain}

	\ifxmu@compact
		\addcontentsline{toc}{chapter}{\xmu@label@compactcontents}
	\else
		\addcontentsline{toc}{chapter}{\xmu@label@contents}
	\fi

% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily \encontentsname}{\sffamily \thepage}{chapter.\thechapter}} %将Contents加入到英文目录中
	
	\addcontentsline{etoc}{chapter}{\sffamily \encontentsname}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily \encontentsname}{\thepage}{chapter.\thechapter}} %将Contents加入到英文目录中
	
	\makeatletter
	\renewcommand{\@pnumwidth}{0em}
	\makeatother
	% 在启动目录前使用局部分组并关闭页眉横线，防止遗留的页眉文字或横线显示在目录页
	\begingroup
	\pagestyle{plain}
	\markboth{}{}
	% 确保目录内所有页面都使用无横线样式
	\renewcommand{\chapter}[1]{\thispagestyle{plain}}
	\@starttoc{toc}%
	\endgroup

	% 目录生成后恢复默认页眉样式并设置页眉文字
	\clearpage
	\pagestyle{xmu@headings}
	\ifxmu@compact
		\markboth{\xmu@label@compactcontents}{\xmu@label@compactcontents}
	\else
		\markboth{\xmu@label@contents}{\xmu@label@contents}
	\fi
}
\setcounter{secnumdepth}{4}  % 目录显示的章节编号深度 (part 对应 -1)
\setcounter{tocdepth}{2}     % 目录深度 (part 对应 -1)

%% 添加英文目录条目的命令
\newcommand\enchapter[1]{\addtocontents{etoc}
	{\protect\contentsline{chapter}
		{\protect\numberline{\sffamily Chapter \thechapter}#1}
% 		{\sffamily \thepage}{chapter.\thechapter}}
		{\thepage}{chapter.\thechapter}}
}
\newcommand\ensection[1]{\addtocontents{etoc}
	{\protect\contentsline{section}
		{\protect\numberline{\sffamily \thesection}#1}
% 		{\sffamily \thepage}{section.\thesection}}
		{\thepage}{section.\thesection}}
}
\newcommand\ensubsection[1]{\addtocontents{etoc}
    {\protect\contentsline{subsection}
        {\protect\numberline{\sffamily \thesubsection}#1}
        {\thepage}{subsection.\thesubsection}}
}
% \newcommand\ensubsection[1]{\addcontentsline{etoc}{subsection}{\protect\numberline{\thesubsection}#1}}
% \newcommand\ensubsubsection[1]{\addcontentsline{etoc}{subsubsection}{\protect\numberline{\thesubsubsection}#1}}

%% 英文目录

\newcommand\entableofcontents{
	% removed redundant \setstretch{1} for English TOC
	% 英文目录页不显示页眉，仅保留页脚页码
	\thispagestyle{plain}

	\chapter*{\sffamily\encontentsname}
	
	\pdfbookmark[0]{\encontentsname}{english_contents}
	
	% \markboth{\encontentsname}{\encontentsname} % 修改页眉文字
	
	% \makeatletter
	% \renewcommand{\@pnumwidth}{0em}
	% \makeatother

	% \@starttoc{etoc}%

	% 增加页眉保护（关键修改）
	% 在局部分组内强制使用 plain 页样式，避免目录页显示页眉
	\begingroup
	\pagestyle{plain}
	\makeatletter
	\renewcommand{\@pnumwidth}{0em}
	\makeatother
	% 在启动英文目录前使用局部分组并关闭页眉横线，防止遗留的页眉文字或横线显示在目录页
	\begingroup
	\renewcommand{\headrulewidth}{0pt}%
	\pagestyle{plain}
	\markboth{}{}
	\@starttoc{etoc}%
	\endgroup
	\endgroup

	% 英文目录生成后恢复默认页眉样式并设置页眉文字
	\clearpage
	\pagestyle{xmu@headings}
	\markboth{\encontentsname}{\encontentsname} % 设置后续页眉
}

\RequirePackage{glossaries-cn}

%% 缩略词表
\newcommand\makeacronymlist{
	% converted 1.5x stretch into explicit baseline for acronym list
	\songti\fontsize{12pt}{18pt}\selectfont
	\markboth{\xmu@label@acronymlist}{\xmu@label@acronymlist} % 页眉
	\addcontentsline{etoc}{chapter}{\sffamily \xmu@label@enacronymlist}
	\printacronymlist
	
	\clearpage
}

%% 符号表
\newcommand\makesymbollist{
	% converted 1.5x stretch into explicit baseline for symbol list
	\songti\fontsize{12pt}{18pt}\selectfont
	\markboth{\xmu@label@symbollist}{\xmu@label@symbollist} % 页眉
	\addcontentsline{etoc}{chapter}{\sffamily \xmu@label@ensymbollist}
	\printsymbollist
	\clearpage
}

\glssetup{
	term list title    = \xmu@label@acronymlist,
	symbol list title  = \xmu@label@symbollist,
	list level         = chapter,
	term color         = black,
	symbol color       = black,
	list head distance = -3.6em
}


%% 图索引
\newcommand\makefigurelist{
% 	\pdfbookmark[0]{\xmu@label@figurelist}{figure_list}
	{\renewcommand{\addvspace}[1]{}
		\listoffigures}
	\addcontentsline{toc}{chapter}{\xmu@label@figurelist}
	\addcontentsline{etoc}{chapter}{\sffamily \xmu@label@enfigurelist}
	
}

%% 表索引
\newcommand\maketablelist{
% 	\pdfbookmark[0]{\xmu@label@tablelist}{table_list}
	{\renewcommand{\addvspace}[1]{}
		\listoftables}
	\addcontentsline{toc}{chapter}{\xmu@label@tablelist}
	\addcontentsline{etoc}{chapter}{\sffamily \xmu@label@entablelist}
	
}


%% 参考文献风格
\RequirePackage[sort&compress]{gbt7714}
\bibliographystyle{reference/gbt7714-numerical} 
\citestyle{numbers}

%% 引用文献序号的排序与压缩
\newcommand{\supercite}[1]{{\citestyle{super}\cite{#1}}} % 上标引用

%% 参考文献环境
\renewenvironment{thebibliography}[1]{
	\zihao{5}
	\setlength{\baselineskip}{16pt}
	\chapter*{\bibname}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enreference}{\sffamily \thepage}{chapter.\thechapter}}
	\addcontentsline{etoc}{chapter}{\sffamily\xmu@label@enreference}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enreference}{\thepage}{chapter*.\thepage}}
	\markboth{\bibname}{\bibname}%
	\addcontentsline{toc}{chapter}{\xmu@label@reference}
	\vspace{3pt}
	\list{\@biblabel{\@arabic\c@enumiv}}%
	{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
		\setlength{\parsep}{0mm}
		\setlength{\labelsep}{0.5em}
		\setlength{\itemsep}{3pt}
		\setlength{\listparindent}{0in}
		\setlength{\itemindent}{0in}
		\setlength{\rightmargin}{0in}
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty
		\renewcommand\theenumiv{\@arabic\c@enumiv}}%
	\sloppy
	\clubpenalty4000
	\@clubpenalty \clubpenalty
	\widowpenalty4000%
	\sfcode`\.\@m}
{\def\@noitemerr
	{\@latex@warning{Empty `thebibliography' environment}}%
	\endlist}

%% 在学期间完成的相关学术成果
\newenvironment{publications}[1]{
	\zihao{-4}
	\setlength{\baselineskip}{21pt}
	\chapter*{\xmu@label@publications}
	\pdfbookmark[0]{在学期间完成的相关学术成果}{publications}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enpublications}{\sffamily {\thepage}}{chapter.\thechapter}}
    \addcontentsline{toc}{chapter}{\xmu@label@publications}
	\addcontentsline{etoc}{chapter}{\sffamily\xmu@label@enpublications}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enpublications}{\thepage}{chapter*.\thepage}}
	\markboth{\MakeUppercase\xmu@label@publications}
	{\MakeUppercase\xmu@label@publications}%
	\list{\@biblabel{\@arabic\c@enumiv}}%
	{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
		\setlength{\parsep}{0mm}
		\setlength{\labelsep}{0.5em}
		\setlength{\itemsep}{3pt}
		\setlength{\listparindent}{0in}
		\setlength{\itemindent}{0in}
		\setlength{\rightmargin}{0in}
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty
		\renewcommand\theenumiv{\@arabic\c@enumiv}}%
	\sloppy
	\clubpenalty4000
	\@clubpenalty \clubpenalty
	\widowpenalty4000%
	\sfcode`\.\@m}
{\def\@noitemerr
	{\@latex@warning{Empty `publications' environment}}%
	\endlist}
\newcommand\publicationpreamble[1]{
	\item[]\vspace{0.75cm}\hspace{-\labelwidth}\hspace{-\labelsep}{\heiti  \bfseries #1}
}

%% 致谢 
\newenvironment{acknowledgements}{
	\cleardoublepage
	\chapter*{\xmu@label@acknowledgements}
	\label{acknowledgements}
	\ifxmu@compact
		\markboth{\xmu@label@compactacknowledgements}{\xmu@label@compactacknowledgements} % 页眉
		\addcontentsline{toc}{chapter}{\xmu@label@compactacknowledgements}
	\else
		\markboth{\xmu@label@acknowledgements}{\xmu@label@acknowledgements} % 页眉
		\addcontentsline{toc}{chapter}{\xmu@label@acknowledgements}
	\fi
	
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enacknowledgements}{\sffamily \thepage}{chapter.\thechapter}}
	\addcontentsline{etoc}{chapter}{\sffamily\xmu@label@enacknowledgements}
% 	\addtocontents{etoc}{\protect\contentsline{chapter}{\sffamily\xmu@label@enacknowledgements}{\thepage}{chapter*.\thepage}}
	\songti
}

%% 单位宏包
\RequirePackage[version=4]{mhchem}
\RequirePackage[per-mode=symbol]{siunitx}

%% 附录编号样式
\newcommand\setappendixnumberformat{
	\renewcommand\theequation{\Alph{chapter}-\arabic{equation}}  % 附录中编号形式是"A-1"的样子
	\renewcommand\thefigure{\Alph{chapter}-\arabic{figure}}
	\renewcommand\thetable{\Alph{chapter}-\arabic{table}}
}

\endinput
