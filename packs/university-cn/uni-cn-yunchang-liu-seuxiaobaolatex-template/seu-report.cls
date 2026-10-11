% seu-report.cls
% 东南大学校庆研究生学术报告会论文模板
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seu-report}[2026/03/11 SEU Anniversary Report Template]

\LoadClass[a4paper, zihao=5, linespread=1.08]{ctexart}

%% ========== 宏包 ==========
\RequirePackage{geometry}
\RequirePackage{multicol}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{hyperref}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage[sort,compress]{cite}
% cite.sty defaults to compressing ranges only when there are >=3 consecutive
% numbers. Redefine the compressor so 2 consecutive numbers are also ranged:
% [2,3] -> [2-3].
\def\@compress@cite#1#2#3{%% This is executed for each number
  \ifnum\@cite@incr=\z@
    \advance\@tempcnta\@cclvi
    \ifnum #1=\@tempcnta
       \def\@h@ld{\citedash \@cite@out{#3}}%
       \mathchardef\@cite@incr=\@cclvi
    \else
       \advance\@tempcnta-\@cclv
       \ifnum #1=\@tempcnta
         \def\@h@ld{\citedash \@cite@out{#3}}%
         \mathchardef\@cite@incr=\@ne
       \else
         \@citea \@cite@out{#3}%
       \fi
    \fi
  \else
    \advance\@tempcnta\@cite@incr
    \ifnum #1=\@tempcnta
       \def\@h@ld{\citedash \@cite@out{#3}}%
    \else
       \@h@ld \@citea \@cite@out{#3}%
       \let\@h@ld\@empty
       \mathchardef\@cite@incr=\z@
    \fi
  \fi
  \@tempcnta#1\let\@citea\citepunct
}
\RequirePackage{calc}

%% ========== 页面设置 ==========
\geometry{
  a4paper,
  top=3.1cm,
  bottom=3.0cm,
  left=2cm,
  right=2cm,
  headheight=2.0cm,
  headsep=1.0cm,   % 页眉底部到正文顶部
  footskip=1.25cm  % 正文底部到页脚底部
}

%% ========== 字体设置 ==========
\IfFontExistsTF{Times New Roman}
  {\setmainfont{Times New Roman}}
  {\setmainfont{TeX Gyre Termes}}
\setCJKmainfont[
  Path={font/},
  Extension=.ttf,
  UprightFont=SimSun,
  BoldFont=SimSun,
  ItalicFont=SimSun
]{SimSun}
\setCJKsansfont[
  Path={font/},
  Extension=.ttf
]{SimSun}
\setCJKmonofont[
  Path={font/},
  Extension=.ttf
]{SimSun}
% Heading-specific CJK font with stronger fake bold for section titles.
\newCJKfontfamily\seuheadingfont[
  Path={font/},
  Extension=.ttf,
  AutoFakeBold=4
]{SimSun}

%% ========== 行距 ==========
\renewcommand{\baselinestretch}{1.2}
\setlength{\parindent}{2em}
\flushbottom

%% ========== 页眉页脚 ==========
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{}
\fancyhead[R]{\raisebox{0.3cm}{\zihao{-4}\CJKfamily{zhhei} 2026 东南大学校庆研究生学术报告会}}
\fancyfoot[C]{}
\fancyfoot[R]{\zihao{-5} 2026东南大学校庆研究生学术报告会}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
% 重定义headrule：先画横线，再叠加logo（logo在最上层）
\renewcommand{\headrule}{%
  \hrule height \headrulewidth width \headwidth
  \vskip-\headrulewidth
  \smash{\rlap{\hspace{0.1cm}\raisebox{-0.75cm}{\includegraphics[height=1.83cm,width=1.91cm]{figures/seu-color-logo.png}}}}%
}

%% ========== 双栏设置 ==========
\setlength{\columnsep}{1.9em}  % 栏间距约1.9字符
% 使用 \twocolumn 时脚注只在当前栏显示（不跨栏）
\setlength{\skip\footins}{0pt}

%% ========== 标题层级 ==========
% 一级标题：四号宋体加粗，段前段后各0.5行，左顶格
\titleformat{\section}
  {\zihao{4}\seuheadingfont\bfseries}
  {\thesection}{0.5em}{}
\titlespacing{\section}{0pt}{0.5\baselineskip}{0.5\baselineskip}

% 二级标题：五号宋体加粗，段前段后各0.5行，左顶格
\titleformat{\subsection}
  {\zihao{5}\seuheadingfont\bfseries}
  {\thesubsection}{0.5em}{}
\titlespacing{\subsection}{0pt}{0.5\baselineskip}{0.5\baselineskip}

% 三级标题：五号宋体不加粗，段前段后各0.5行，左顶格，下接正文
\titleformat{\subsubsection}[runin]
  {\zihao{5}\CJKfamily{zhsong}}
  {\thesubsubsection}{0.5em}{}
\titlespacing{\subsubsection}{0pt}{0.5\baselineskip}{0.5em}

%% ========== 图表标题格式 ==========
% 图题：小五宋体，编号TNR，段后0.5行，居中
\DeclareCaptionFont{xiaowu}{\zihao{-5}}
\captionsetup[figure]{
  font=xiaowu,
  labelformat=empty,
  belowskip=0.5\baselineskip,
  aboveskip=0pt,
  justification=centering
}
% 表题：小五宋体，段前0.5行，居中
\captionsetup[table]{
  font=xiaowu,
  labelsep=space,
  aboveskip=0.5\baselineskip,
  belowskip=0pt,
  justification=centering
}

%% ========== 表注/图注命令 ==========
% 小5号宋体，顶格，段后0.5行
\newcommand{\tabnote}[1]{%
  \par\vspace{0.3em}%
  {\zihao{-5}\CJKfamily{zhsong}\noindent #1\par}%
  \vspace{0.5\baselineskip}%
}

%% ========== 三线表线宽 ==========
\setlength{\heavyrulewidth}{1.5pt}
\setlength{\lightrulewidth}{1.5pt}

%% ========== 公式编号右对齐 ==========
% 默认amsmath已支持公式居中、编号右对齐

%% ========== 参考文献格式 ==========
\renewcommand{\refname}{参考文献}
\renewenvironment{thebibliography}[1]{%
  {\vspace{0.5\baselineskip}\noindent\zihao{4}\seuheadingfont\bfseries 参考文献\par\vspace{0.5\baselineskip}}%
  \zihao{-5}%
  \list{[\@arabic\c@enumiv]}{%
    \settowidth\labelwidth{[#1]}%
    \setlength{\labelsep}{0.5em}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    \setlength{\itemindent}{0cm}%
    \setlength{\itemsep}{3pt}%
    \setlength{\parsep}{0pt}%
    \usecounter{enumiv}%
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr
   {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}

%% ========== 上标引用命令 ==========
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

%% ========== 论文元信息命令 ==========
\newcommand{\cnTitle}[1]{\def\@cnTitle{#1}}
\newcommand{\enTitle}[1]{\def\@enTitle{#1}}
\newcommand{\cnAuthor}[1]{\def\@cnAuthor{#1}}
\newcommand{\enAuthor}[1]{\def\@enAuthor{#1}}
\newcommand{\cnInstitute}[1]{\def\@cnInstitute{#1}}
\newcommand{\enInstitute}[1]{\def\@enInstitute{#1}}
\newcommand{\cnAbstract}[1]{\def\@cnAbstract{#1}}
\newcommand{\enAbstract}[1]{\def\@enAbstract{#1}}
\newcommand{\cnKeywords}[1]{\def\@cnKeywords{#1}}
\newcommand{\enKeywords}[1]{\def\@enKeywords{#1}}
\newcommand{\authorInfo}[1]{\def\@authorInfo{#1}}
\newcommand{\fundInfo}[1]{\def\@fundInfo{#1}}
\def\@fundInfo{}

%% ========== 生成标题页头部（单栏） ==========
\newcommand{\makeheader}{%
  \thispagestyle{fancy}%
  % 中文标题
  {\centering\zihao{-2}\seuheadingfont\bfseries\@cnTitle\par}
  \vspace{1em}
  % 中文作者
  {\centering\zihao{4}\CJKfamily{zhsong}\@cnAuthor\par}
  \vspace{0.8em}
  % 中文单位
  {\centering\zihao{-5}\@cnInstitute\par}
  \vspace{0.5em}
  % 中文摘要
  {\leftskip=0pt\rightskip=0pt\parfillskip=0pt plus 1fil\relax
   \zihao{-5}\linespread{1.4}\selectfont\noindent{\seuheadingfont\textbf{摘\quad 要：}}\@cnAbstract\par}
  \vspace{0.3em}
  % 中文关键词
  {\zihao{-5}\noindent{\seuheadingfont\textbf{关键词：}}\@cnKeywords\par}
  \vspace{0.5em}
  % 英文标题
  {\centering\zihao{-2}\bfseries\@enTitle\par}
  \vspace{1em}
  % 英文作者
  {\centering\zihao{4}\@enAuthor\par}
  \vspace{0.8em}
  % 英文单位
  {\centering\zihao{-5}\@enInstitute\par}
  \vspace{0.5em}
  % 英文摘要
  {\leftskip=0pt\rightskip=0pt\parfillskip=0pt plus 1fil\relax
   \zihao{-5}\linespread{1.4}\selectfont\noindent\textbf{Abstract: }\@enAbstract\par}
  \vspace{0.3em}
  % 英文关键词
  {\zihao{-5}\noindent\textbf{Key words: }\@enKeywords\par}
  \vspace{1.7em}
}

%% ========== 作者简介（第一页左栏底部） ==========
% 去掉脚注文本的缩进
\renewcommand{\@makefntext}[1]{\noindent #1}
% 作者简介块行距（可调）
\newlength{\authorinfobaselineskip}
\setlength{\authorinfobaselineskip}{15pt}
% 重定义脚注线：与正文空一行，线宽0.5栏宽
\renewcommand{\footnoterule}{%
  \kern \baselineskip
  \hrule width 0.5\columnwidth height 0.4pt
  \kern 0.3em
}
\newcommand{\makeauthorinfo}{%
  \begingroup
    \let\thefootnote\relax
    \footnotetext{%
      \parbox[t]{\columnwidth}{%
        \zihao{-5}\selectfont
        \setlength{\baselineskip}{\authorinfobaselineskip}%
        \ifx\@fundInfo\empty\else
          \@fundInfo\par
        \fi
        \@authorInfo
      }%
    }%
  \endgroup
}

%% ========== hyperref 设置 ==========
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  bookmarksnumbered=true
}

\endinput
