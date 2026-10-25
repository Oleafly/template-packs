%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                            %%
%%           Class 'GDUPT Bachelor Dissertation Template'                     %%
%% ---------------------------------------------------------------------------%%
%%     A Bachelor LaTeX template for Guangdong University of Petrochemical    %%
%%  Technology, Automation School                                             %%
%%                                                                            %%
%% Version: v1.0.1 (2026-05-27)                                               %%
%%                                                                            %%
%% Original Author:  Yicheng Zhang <zhangyicheng@gdupt.edu.cn>                %%
%%                              <YiZhang@lincoln.ac.uk>                       %%
%% Maintainer:       LiuyiRigel <https://github.com/LiuyiRigel>               %%
%%                              <oshhhs1@gmail.com>                           %%
%% License:          MIT License (c) 2021 Yicheng Zhang                       %%
%%                   MIT License (c) 2026 LiuyiRigel (modifications)          %%
%% GitHub Repo:      https://github.com/LiuyiRigel/GDUPT-Latex                %%
%%                                                                            %%
%% Reference Repos:  [1] https://github.com/kks32/phd-thesis-template/        %%
%%                   [2] https://github.com/tuna/thuthesis                    %%
%%                   [3] https://github.com/szsdk/LZUthesis/                  %%
%%----------------------------------------------------------------------------%%
%%  Modification History (LiuyiRigel):                                        %%
%%    v1.0.1 (2026-05-27)                                                     %%
%%      - 西文正文字体由 XITS 改为 Times New Roman（Overleaf 兼容性修复）     %%
%%      - 移除重复加载的 fontspec/unicode-math（原 3 处 → 统一 1 处）         %%
%%      - 保留 XITS 字体配置为注释，方便本地用户按需切换                     %%
%%      - README 全面优化（新增优化日志、重构快速开始、完善 FAQ）            %%
%%    v1.0.0 (2026-05-10)                                                     %%
%%      - 清理废弃/重复的包加载代码，精简类文件结构                            %%
%%      - 完善 .gitignore，移除编译中间文件                                   %%
%%      - 更新文档与 README，规范项目说明                                     %%
%%      - 修复多处注释中的笔误（Petrolchemical → Petrochemical 等）           %%
%%      - 优化代码可读性与维护性                                              %%
%%----------------------------------------------------------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%============================ Acknowledgment ================================%%
%%         Krishna Kumar  (Cambridge template author)                         %%
%%         Ruini Xue <xueruini@gmail.com>, TUNA  (thuthesis template author)  %%
%%         Shen Zhou (LZU template author)                                    %%
%%         zoho@bbs.ctex.org （a brief Latex guide book author）              %%
%%         HaoLuan <HLuan@lincoln.ac.uk> （who first lead me to use Latex）   %%
%%                                                                            %%
%%         ctex.org <http://www.ctex.org/HomePage>                            %%
%%     ...    ...                                                             %%
%%----------------------------------------------------------------------------%%
%%  Please forgive me copying and using a lot of the Krisna's and Ruini's     %%
%%  code, and simply changing the original class name to gdupt  (^_^)         %%
%%============================================================================%%
%% ***************************************************************************%%
%%  Changelog                                                                 %%
%%  v0.0.1 beta (2021-02-16, Yicheng Zhang)                                   %%
%%    * 初始版本                                                               %%
%%    * 修正了正文部分奇数页页眉会多出一个阿拉伯数字的章号                      %%
%%  v1.0.0 (2026-05-10, LiuyiRigel)                                           %%
%%    * 清理废弃/重复的包加载代码                                              %%
%%    * 修复多处注释笔误（Petrolchemical→Petrochemical, Technolgy→Technology） %%
%%    * 更新头部信息（版本号、作者、维护者、GitHub 仓库地址）                  %%
%%    * 优化代码可读性与维护性                                                 %%
%%  v1.0.1 (2026-05-27, LiuyiRigel)                                           %%
%%    * 西文正文字体由 XITS 改为 Times New Roman（Overleaf 不预装 XITS）      %%
%%    * 移除重复加载的 fontspec 和 unicode-math（原 3 处 → 统一 1 处）        %%
%%    * 保留 XITS 字体配置为注释，方便本地用户按需切换                        %%
%%                                                                            %%                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%----------  Class Identification ---------------------%%
\newcommand\fileversion{1.0.1}
\newcommand\filedate{2026/05/27}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gduptbe}[\filedate ~ A Bachelor Assertation class file
 by Yicheng Zhang, maintained by LiuyiRigel (Ver.~\fileversion)]
\typeout{https://github.com/LiuyiRigel/GDUPT-Latex}

%%-------------------- Error Hints --------------------%%
\newcommand\gdupt@error[1]{%
  \ClassError{gduptbe}{#1}{}%
}
\newcommand\gdupt@warning[1]{%
  \ClassWarning{gduptbe}{#1}%
}
\newcommand\gdupt@patch@error[1]{%
  \gdupt@error{Failed to patch command \protect#1}%
}
\newcommand\gdupt@deprecate[2]{%
  \def\gdupt@@tmp{#2}%
  \gdupt@warning{%
    The #1 is deprecated%
    \ifx\gdupt@@tmp\@empty\else
      . Use #2 instead%
    \fi
  }%
}
\@ifl@t@r\fmtversion{2020/10/01}{}{
  \gdupt@error{%
    TeX Live 2020/W32TeX or later version is required to compile this document%
  }
}


\RequirePackage{iftex}
\ifXeTeX\else
  \gdupt@error{XeLaTeX is required to compile this document}
\fi

%%------------------------ Preliminary Declarations --------------------------%%
% use ctexbook class as basic template
% and pass all declarations to class ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}  
\PassOptionsToClass{fontset=fandol}{ctexbook}
\ProcessOptions\relax   % doing notheing
%set page size and default font
\LoadClass[a4paper,UTF8,zihao=-4]{ctexbook}[2017/04/01]
% \setmainfont{STsong}
% \DeclareOption{times}{\setmainfont{Times New Roman}} 
% \AtEndOfPackage{\input{../Preamble/preamble.tex}}
\RequirePackage{amsmath, amsfonts, amssymb, graphicx}
%======= packages ======%
% \RequirePackage{graphicx}
\RequirePackage[svgnames]{xcolor}
% \RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
\RequirePackage{epigraph, titlesec, textcomp}
\RequirePackage[square, comma, sort&compress, numbers]{natbib}

% ************************** Layout and Formatting *****************************

\RequirePackage{lscape}   % Supports Landscape Layout
\RequirePackage{setspace} % Define line spacing in paragraph
\RequirePackage{calc}     % calculate vertical spacing

% ************************* Conditional Statements *****************************
\RequirePackage{ifthen}   % Conditional statements
\RequirePackage{ifpdf}    % Check for pdfLaTeX
\RequirePackage{ifxetex}  % XeLaTeX
\RequirePackage{etoolbox}
\RequirePackage{filehook}
\RequirePackage{xparse}
% \RequirePackage{geometry}%
\RequirePackage{fancyhdr}
% \RequirePackage{titletoc}
% \RequirePackage{notoccite}
% \RequirePackage{amsmath}
% \RequirePackage{unicode-math}
% \RequirePackage{graphicx}
% \RequirePackage[labelformat=simple]{subcaption}
% \RequirePackage{pdfpages}
% \includepdfset{fitpaper=true}
% \RequirePackage[shortlabels]{enumitem}
% \RequirePackage{environ}
% \RequirePackage{xeCJKfntef}
% \RequirePackage{soul}
% \RequirePackage{array}
% \RequirePackage{booktabs}
\RequirePackage{url}

% \usepackage{fontspec}  % 已移至下方统一设置，避免重复加载
% \usepackage[]{unicode-math}  % 已移至下方统一设置，避免重复加载
% \usepackage{ulem}
%% footnote 脚注
\RequirePackage[perpage, bottom]{footmisc}

% Redefining urlstyle to use smaller fontsize in References with URLs
\newcommand{\url@leostyle}{%
 \@ifundefined{selectfont}{\renewcommand{\UrlFont}{\sffamily}}
 {\renewcommand{\UrlFont}{\normalsize}}}
\urlstyle{leo}

%%自定义字体
\newcommand{\book@title}{\heiti \fontsize{40pt}{\baselineskip}\selectfont}


% option to split urls over multiple lines for latex >> DVIPS >> PDF option
\ifpdf
  % PDFLaTeX does it automatically.
\else
  % dvips
  \ifxetex
  \else % If not XeLaTeX
    \RequirePackage{breakurl} % to split the url over multiple lines
  \fi
\fi

% Don't break enumeration (etc.) across pages in an ugly manner
\clubpenalty=10000
\widowpenalty=10000
% ********************************** Fonts **********************************
\usepackage{amsmath}
% \usepackage{fontspec}  % 已在文档类头部加载，此处不再重复
% \usepackage {xeCJK}
\usepackage[]{unicode-math}

% ===== 西文正文字体：推荐 Times New Roman（Overleaf 可用）=====
% Overleaf 不自带 XITS 字体，若本地安装了 XITS 可启用以下配置：
% \setmainfont[
%   Extension = .otf,
%   UprightFont = *-regular,
%   BoldFont = *-bold,
%   ItalicFont = *-italic,
%   BoldItalicFont = *-bolditalic,
% ]{xits}
\setmainfont{Times New Roman}

\setmathfont{latinmodern-math.otf}
%设置为默认的unicode 数学字体


%%==== some other CJK fonts
% \setCJKfamilyfont{GDUPT@songti}{STSong}             %使用STsong 宋体
% \newcommand{\songti}{\CJKfamily{GDUPT@songti}}

\setCJKfamilyfont{GDUPT@kaiti}{STKaiti}             %使用STsong 楷体
\newcommand{\kaiti}{\CJKfamily{GDUPT@kaiti}}

% \setCJKfamilyfont{GDUPT@hwxk}{STXingkai}             %使用STXingkai华文行楷字体
% \newcommand{\huawenxingkai}{\CJKfamily{GDUPT@hwxk}}


% \setCJKfamilyfont{GDUPT@MSyahei}{Microsoft YaHei}             %使用STXingkai仿宋字体
% \newcommand{\YaHei}{\CJKfamily{GDUPT@MSyahei}}

% 目前较好地定义积分符号
\newcommand*{\dif}{\mathop{}\!\mathrm{d}}

% **************** Clear Header Style on the Last Empty Odd pages **************
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else%
	\hbox{}%
	\thispagestyle{empty}  % Empty header styles
	\newpage%
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}


% ******************************************************************************
% **************************** Macro Definitions *******************************
% ******************************************************************************
%%=====================声明常量和变量=====================%%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

%%-------------变量-------------%%
% Student Number  学号
% 先定义一个内部命令
\newcommand{\@stunum}{}
%通过指令将参数值传入内部变量   
\newcommand{\stunum}[1]{\renewcommand{\@stunum}{#1}}  
% Subtitle (optional)  子标题
\newcommand{\@subtitle}{}  
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
% Subtitle (optional)  英文标题
\newcommand{\@entitle}{}   
\newcommand{\entitle}[1]{\renewcommand{\@entitle}{#1}} 
% The year and term the degree will be officially conferred
\newcommand{\@degreedate}{\monthname[\the\month]\space\the\year}
\newcommand{\degreedate}[1]{\renewcommand{\@degreedate}{#1}}
% The full (unabbreviated) name of the degree
\newcommand{\@degreetitle}{}
\newcommand{\degreetitle}[1]{\renewcommand{\@degreetitle}{#1}}
% The name of your department(eg. Engineering, Maths, Physics) 专业 
\newcommand{\@dept}{}
\newcommand{\dept}[1]{\renewcommand{\@dept}{#1}}
% The name of your school (eg. Automation) 学院
\newcommand{\@school}{}
\newcommand{\school}[1]{\renewcommand{\@school}{#1}}
% The name of your University  学校名
\newcommand{\@university}{}
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}
% Defining the crest
\newcommand{\@crest}{}
\newcommand{\crest}[1]{\renewcommand{\@crest}{#1}}

% Advisor 导师
\newcommand{\@advisor}{}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}}

% Student Class 班级
\newcommand{\@stucls}{}
\newcommand{\stucls}[1]{\renewcommand{\@stucls}{#1}}

% Design Ttime  设计时间
\newcommand{\@designtime}{DesignTime From to}
\newcommand{\designtime}[1]{\renewcommand{\@designtime}{#1}}

%%-------------常量-------------%%
% stunum Title 
\newcommand{\@stunumtitle}{学号：}
\newcommand{\stunumtitle}[1]{\renewcommand{\@stunumtitle}{#1}}

% Book Type
\newcommand{\@booktype}{毕 \space 业 \space 设 \space 计}
\newcommand{\booktype}[1]{\renewcommand{\@booktype}{#1}}


% Advisor Title (Default, can be changed)
\newcommand{\@advisorrole}{指导教师（职称）}
\newcommand{\advisorrole}[1]{\renewcommand{\@advisorrole}{#1}}


% Advisor width to align
\newcommand{\@advisorlinewidth}{0.3\textwidth}
\newcommand{\advisorlinewidth}[1]{\renewcommand{\@advisorlinewidth}{#1}}

% subjectline (This subject will appear in the PDF meta-information
% called `pdfsubject`.)
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}


% These macros define an environment for front matter that is always
% single column even in a double-column document. 保持单栏
\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}

% Set single column even under two column layout 设为单栏模式
\newcommand{\setsinglecolumn}{
\if@twocolumn
   \onecolumn
\else
\fi
}

% ******************************** Line Spacing ********************************
% Set spacing as 1.5 line spacing for the PhD Thesis
% In practice, fortunately, nobody knows really what “one-and-a-half spaced
% type” means exactly (in terms of millimetres baseline distance). The following
% LaTeX setting has routinely been considered perfectly acceptable:
\renewcommand\baselinestretch{1.2}

% define  underline
% 带参数的下划线
\RequirePackage{array}
\def\GDUPT@underline[#1]#2{%
    \CJKunderline{\hbox to #1{\hfill#2\hfill}}}
\def\GDUPTunderline{\@ifnextchar[\GDUPT@underline\underline}
%定义双划线
\DeclareOption{doublelines}{
    \def\GDUPT@doublelines {}
}
% 中文空格
\newcommand\Cspace{\hspace{\ccwd}}

% 章节的各级标题中文设置
% \titleformat{\chapter}{\raggedright\huge\bfseries}{第\,\thechapter\,章}{1em}{}
\titleformat{\section}{\raggedright\Large\bfseries}{\,\thesection\,}{1em}{}
\titleformat{\subsection}{\raggedright\large\bfseries}{\,\thesubsection\,}{1em}{}

% CTEX设置为中文主题
\ctexset{
   chapter/name = {第, 章},
}

%%=============== 页眉页脚样式
%=======head and foot

\pagestyle{fancy}          % Enables the custom headers/footers
%% 页脚设置
\fancypagestyle{frontmatterstyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot{} % clear all footer fields
    \fancyfoot[CE,CO]{\thepage} %
    \renewcommand{\thepage}{\Roman{page}}
}

\appto\frontmatter{\pagestyle{frontmatterstyle}}


\ProcessOptions\relax

% fancy 中通过\@chapapp  替代 \chaptername
%% 章名 用汉字来显示
\renewcommand{\@chapapp}{第\,\thechapter\,章 \Cspace}
%更新 leftmark显示的内容，去除多出来的 \thechapter部分
\renewcommand{\chaptermark}[1]{ \markboth{\@chapapp #1}{}}
%% 正文的页眉设置
\fancypagestyle{mainmatterstyle}{%
    % clear header and footer first
    \fancyhf{}
    %\headrulewidth 0.4pt
    \renewcommand{\headrulewidth}{0.4pt}
    % 页眉到页面顶部的水平距离
    % \setlength{\voffset}{0mm}
    % \setlength{\textwidth}{370pt}
    \setlength{\headheight}{12.64732pt}
    % !make the header line as wide as the text area
    \setlength{\headwidth}{\textwidth}
    % 将leftmark内容的章号换成中文
    %偶数页页眉
    \fancyhead[CE]{\small \@university 本科毕业设计 }
    % \def\chaptermark#1{\markboth{ \@chapapp}{}}
    
    %奇数页页眉
    \fancyhead[CO]{\small \leftmark }
    % Footers 页码为阿拉伯数字，位于页脚中间位置
    \fancyfoot{} % clear all footer fields
    \fancyfoot[CE,CO]{\thepage} % in the middle bottom
    % \fancyfoot[LE,RO]{\thepage}  % at the outter bottom 
}

\appto\mainmatter{\pagestyle{mainmatterstyle}}
% \appto\mainmatter{\linespread{1.3889}\selectfont}

% plain 去除页眉区域
\fancypagestyle{plain}{
    \fancyhead{}
    \renewcommand{\headrulewidth}{0pt}
}
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{frontmatterstyle}}}
%\renewcommand{\headrulewidth}{1pt}% % No header rule
%\newcommand{\headrulecolor}[1]{\patchcmd{\headrule}{\hrule}{\color{#1}\hrule}{}{}}
%\headrulecolor{black}

%=======format
\usepackage[font=small]{caption}

\RequirePackage[titles]{tocloft}
\renewcommand\cftchapdotsep{\cftdotsep}
\renewcommand\cftchapfont{\zihao{4}}
\renewcommand\cftsecfont{\zihao{-4}}
\renewcommand\cftsubsecfont{\zihao{-4}}
\renewcommand\cftchappagefont{\mdseries}
% *************************** Front Matter Layout ***************************
%% ============= 封面布局 ============= %%
%% ************* Title Page ********** %%
\renewcommand{\maketitle}
{
% To compute the free vertical space in Title page
% 计算垂直间距
\computeTitlePageSpacing
%清空页面样式
\thispagestyle{empty}
%单栏页面布局
 \begin{singlespace}
    %居中元素  
  
    %student number  to top right
   \rightline{\usebox{\GDUPT@stunum}}
   \begin{center}
   \vspace{.05\GDUPT@titlepagespacing}
    
   % Crest  %校名图
    {\usebox{\GDUPT@crest}}
    \vspace{.05\GDUPT@titlepagespacing}
    
    {\usebox{\GDUPT@booktype}}
    \vspace{.27\GDUPT@titlepagespacing}
   
    % \vspace{0.3\GDUPT@titlepagespacing}
    % {\usbox{Granduate Paper}}
    % Title  标题
    {\usebox{\GDUPT@Title}} 
    \vspace{.06\GDUPT@titlepagespacing}
   
    {\usebox{\GDUPT@entitle}} 
    \vspace*{1em}
 

  \vspace{.3\GDUPT@titlepagespacing}
       % Author
    % {\usebox{\GDUPT@author}}
    % \vspace*{0.5em}
    %    % Supervisor
    %   {\usebox{\PHD@supervisor}}
    %   \vspace*{0.5em}
    % Advisor
    {\usebox{\GDUPT@stuinfo}}
    % \vspace*{0.5em}
    \vfill
 
  \end{center}
 \end{singlespace}

}

%% ============= 诚信承诺书 ============= %%
%% ============= Statement ============= %%

\newcommand{\gdupt@statement@text}{本人郑重承诺：《\@title 》毕业设计（论文）的内容真实、可靠，是本人在 \underline{ \Cspace \@advisor  \Cspace }        指导教师的指导下，独立进行研究所完成。毕业设计（论文）中引用他人已经发表或未发表的成果、数据、观点等，均已明确注明出处，如果存在弄虚作假、抄袭、剽窃的情况，本人愿承担全部责任。对本论文所涉及的研究工作做出贡献的
  其他个人和集体，均已在文中以明确方式标明。} 
\newcommand{\gdupt@signature}{学生签名：}
\newcommand{\gdupt@backdate}{\hspace{3em}年\hspace{1.5em}月\hspace{1.5em}日}

\newcommand\statement{%
  \cleardoublepage
    \begin{center}
    \heiti \Large{广东石油化工学院本科毕业设计（论文）诚信承诺保证书}%
    \end{center}

    \vspace{1.5em}
   
      \begin{flushleft} 
        \fangsong \large \Cspace \Cspace \gdupt@statement@text
      \end{flushleft}
  \bigskip
  \vspace{8em}

      \begin{flushright}
      {
      \fangsong \large \gdupt@signature \space \hspace{5cm}
      \par
      \vspace{5mm}
      \gdupt@backdate\hspace{2.5cm}
      %\relax
      }
      \end{flushright} 

}%


%% ============= 摘 要 ============= %%
%% ------------- Chinese Abstract environment ------------- %%
\newenvironment{cnabstract} {

% Normal abstract in the thesis
  \cleardoublepage
  \setsinglecolumn

  \chapter*{\centering \Large {\abstractname}}
  \zihao{-4} \songti
  \thispagestyle{empty}

  % \textbf{关键词：} \@cnkeywords
}
%% ------------- English Abstract environment ------------- %%

\newenvironment{enabstract} {

% Normal abstract in the thesis
  \cleardoublepage
  \setsinglecolumn

  \chapter*{\centering \Large {Abstract}}
  \thispagestyle{empty}

  % \textbf{Keywords:} \@enkeywords
}



%% ============= 致 谢 ============= %%

% ****************************** Acknowledgements ********************************
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}{
\cleardoublepage
\setsinglecolumn
\chapter*{\centering \Large 致\Cspace 谢}
\thispagestyle{empty}
}


%% ============= 术 语 ============= %%
% ******************************* Nomenclature *********************************
\RequirePackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nomgroup}[1]{%
\ifthenelse{\equal{#1}{A}}{\item[\textbf{Roman Symbols}]}{%
\ifthenelse{\equal{#1}{G}}{\item[\textbf{Greek Symbols}]}{%
\ifthenelse{\equal{#1}{Z}}{\item[\textbf{Acronyms / Abbreviations}]}{%
\ifthenelse{\equal{#1}{R}}{\item[\textbf{Superscripts}]}{%
\ifthenelse{\equal{#1}{S}}{\item[\textbf{Subscripts}]}{%
\ifthenelse{\equal{#1}{X}}{\item[\textbf{Other Symbols}]}
{}
}% matches mathematical symbols > X
}% matches Subscripts           > S
}% matches Superscripts         > R
}% matches Abbreviations        > Z
}% matches Greek Symbols        > G
}% matches Roman Symbols        > A

% To add nomenclature in the header
\renewcommand{\nompreamble}{\markboth{\nomname}{\nomname}}

% Add nomenclature to contents and print out nomenclature
\newcommand{\printnomencl}[1][]{
\ifthenelse{\equal {#1}{}}
{\printnomenclature}
{\printnomenclature[#1]}
%\addcontentsline{toc}{chapter}{\nomname}
}

%% ============= 目 录 ============= %%
%% ************* Index ************* %%
% \RequirePackage{makeidx}
% \makeindex
% \newcommand{\printthesisindex}{
%     \cleardoublepage
%     \phantomsection
%     \printindex}



%% ============= 参 考 文 献 ============= %%
%% ************* Refference ************* %%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 封面的元素间距设置是通过显示内容计算得到的，good！
% ******************** To compute empty space in title page *******************
% Author: Krishna Kumar
% Boxes below are used to space different contents on the title page
% Based on https://github.com/cambridge/thesis

%生成封面所需的文本框（boxes）并计算封面元素的间距
\newcommand{\computeTitlePageSpacing}
{
  % student number  右上方的学号
  \songti
 \newsavebox{\GDUPT@stunum}
  \begin{lrbox}{\GDUPT@stunum}
    \begin{minipage}[c]{0.3\textwidth}
      \bfseries \@stunumtitle \underline{\space \@stunum \space} 
       %调用学号指令
    \end{minipage}
  \end{lrbox}  
  % University Crest Box  %学校的校名（图）
  \newsavebox{\GDUPT@crest}
  \begin{lrbox}{\GDUPT@crest}
    {\@crest  }
  \end{lrbox}

  % 毕业设计
  % \heiti
  \newsavebox{\GDUPT@booktype}
  \begin{lrbox}{\GDUPT@booktype}
    %\heiti
     { \centering \bfseries \book@title  \@booktype}
  \end{lrbox}

  % Title Box    %论文标题
  \newsavebox{\GDUPT@Title}
  \begin{lrbox}{\GDUPT@Title}
    \begin{minipage}[c]{0.95\textwidth}
      %\CJKfontspec{微软雅黑}  
     %\heiti
      \centering \bfseries \zihao{-2} \heiti {\@title }
   
      % 子标题
      % \ifthenelse{\equal{\@subtitle}{}}{
      %   % subtitle is not defined
      % }{
      %   \\
      %   \centering \Large {\@subtitle}
      % } % subtitle is defined
    \end{minipage}
  \end{lrbox}

% English Title  % 英文标题
% \newfontfamily\enfont{Times new Roman}

    \newsavebox{\GDUPT@entitle}
    \begin{lrbox}{\GDUPT@entitle}
    
      \begin{minipage}[c]{0.95\textwidth}
        {
        \centering  \bfseries \Large \fontspec{Times New Roman} {\@entitle} 
     
        % 子标题
        % \ifthenelse{\equal{\@subtitle}{}}{
        %   % subtitle is not defined
        % }{
        %   
        %   \centering \Large {\@subtitle}
        % } % subtitle is defined
        }
      \end{minipage}
     
    \end{lrbox}


  % Info Box  % 学生个人信息
  \newsavebox{\GDUPT@stuinfo}
  \begin{lrbox}{\GDUPT@stuinfo}
    \songti
    \bfseries
      \begin{minipage}[c]{\textwidth}
      { 
         \zihao{-3} {% 
        {学院}\underline{\makebox[26mm][c]{\@school}}{专业}\underline{\makebox[50mm][c]{\@dept}}{班级}\underline{\makebox[30mm][c]{\@stucls}}
        \par \vspace{3mm}
        {学生}\underline{\makebox[26mm][c]{\@author}} {指导教师（职称）}\underline{\makebox[60mm][c]{\@advisor}}
        \par \vspace{3mm}
        {设计时间}{\@designtime}
        % \vspace{0.2em}
        }
      } 
    \end{minipage}
  \end{lrbox}

   %  Now to compute the free vertical space  计算垂直间距
  \newlength{\GDUPT@titlepagespacing}
  \setlength{\GDUPT@titlepagespacing}{ \textheight %
        - \totalheightof{\usebox{\GDUPT@stunum}}
        - \totalheightof{\usebox{\GDUPT@crest}}
        - \totalheightof{\usebox{\GDUPT@booktype}}
        - \totalheightof{\usebox{\GDUPT@Title}}
        - \totalheightof{\usebox{\GDUPT@entitle}}
        % - \totalheightof{\usebox{\GDUPT@author}}
      % - \totalheightof{\usebox{\GDUPT@supervisor}}
        - \totalheightof{\usebox{\GDUPT@stuinfo}}
        % - \totalheightof{\usebox{\GDUPT@dept}}
        % - \totalheightof{\usebox{\GDUPT@submissiontime}}
        % - \totalheightof{\usebox{\GDUPT@collegedate}}
        }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%item style
\usepackage{enumitem}
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}



%math theorem
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\theorembodyfont{\rmfamily\songti}
\theoremheaderfont{\rmfamily\heiti}
\theoremsymbol{\ensuremath{\square}}
\newtheorem*{proof}{证明}
\theoremstyle{plain}
\theoremsymbol{}
\qedsymbol{\ensuremath{\square}}
\newtheorem{assumption}{假设}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{example}{例}[chapter]
\newtheorem{conjecture}{猜想}[chapter]


\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\sloppy

\endinput
%% End of Class File