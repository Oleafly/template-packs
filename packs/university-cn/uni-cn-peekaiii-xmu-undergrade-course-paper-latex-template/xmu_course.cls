\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xmu_course}[2026/06/06 v1.0 XMU Course Paper Template]

% --- 选项 ---
\newif\if@xmu@cover \@xmu@covertrue
\DeclareOption{nocover}{\@xmu@coverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

% --- 基础文档类 ---
\LoadClass[a4paper,fontset=none,zihao=5,linespread=1.0,scheme=chinese]{ctexart}

% --- 宏包 ---
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{hyperref}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{pifont}

% --- 字体：从 typeface/ 加载 ---
\setCJKmainfont{SimSun}[Path=./typeface/, Extension=.ttc, AutoFakeBold]
\setCJKfamilyfont{zhsong}{SimSun}[Path=./typeface/, Extension=.ttc, AutoFakeBold]

\setCJKsansfont{SimHei}[Path=./typeface/, Extension=.ttf]
\setCJKfamilyfont{zhhei}{SimHei}[Path=./typeface/, Extension=.ttf]

\setCJKfamilyfont{zhkai}{SimKai}[Path=./typeface/, Extension=.ttf, AutoFakeBold]

\setCJKmonofont{SimKai}[Path=./typeface/, Extension=.ttf]
\setCJKfamilyfont{zhfs}{SimKai}[Path=./typeface/, Extension=.ttf]

\newCJKfontfamily\dengexian{Deng}[
  Path=./typeface/, Extension=.ttf,
  BoldFont=Dengb, ItalicFont=Dengl,
]
\newCJKfontfamily\dengexianbold{Dengb}[Path=./typeface/, Extension=.ttf]

\newcommand{\songti}{\CJKfamily{zhsong}}
\newcommand{\heiti}{\CJKfamily{zhhei}}
\newcommand{\kaiti}{\CJKfamily{zhkai}}
\newcommand{\fangsong}{\CJKfamily{zhfs}}

% --- 页面布局 ---
\geometry{
  a4paper,
  top=2.54cm, bottom=2.54cm,
  left=3.18cm, right=3.18cm,
  headheight=14pt, headsep=0.8cm, footskip=1.0cm,
}

% --- 封面数据 ---
\newcommand{\@covertitle}{2023--2024学年\ 春季学期期末论文}
\newcommand{\covertitle}[1]{\renewcommand{\@covertitle}{#1}}
\newcommand{\@coursename}{}
\newcommand{\coursename}[1]{\renewcommand{\@coursename}{#1}}
\newcommand{\@classinfo}{}
\newcommand{\classinfo}[1]{\renewcommand{\@classinfo}{#1}}
\newcommand{\@college}{}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\@major}{}
\newcommand{\major}[1]{\renewcommand{\@major}{#1}}
\newcommand{\@grade}{}
\newcommand{\grade}[1]{\renewcommand{\@grade}{#1}}
\newcommand{\@authorname}{}
\newcommand{\authorname}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\@studentid}{}
\newcommand{\studentid}[1]{\renewcommand{\@studentid}{#1}}
\newcommand{\@coverdate}{\the\year 年\the\month 月}
\newcommand{\coverdate}[1]{\renewcommand{\@coverdate}{#1}}

% --- 封面信息行：标签与内容均左对齐 ---
\newcommand{\@coverinfoline}[2]{#1：& #2 \\}

\newcommand{\makecover}{%
  \thispagestyle{empty}%
  \begin{titlepage}%
    \centering
    \vspace*{0pt}%

    \includegraphics[width=6.96cm,height=2.51cm,keepaspectratio]{logo/logotype.png}\par
    \vspace{0.8cm}
    \includegraphics[width=5.48cm,height=5.48cm,keepaspectratio]{logo/logo.png}\par
    \vspace{1.2cm}

    % 标题：等线二号加粗
    {\dengexianbold\zihao{2}\@covertitle\par}

    \bigskip

    % 信息区：等线三号加粗，1.5 倍行距，标签与内容均左对齐
    {\dengexianbold\zihao{3}%
      \renewcommand{\arraystretch}{1.5}%
      \begin{tabular}{@{}l@{}l@{}}%
        \ifdefempty{\@coursename}{}{\@coverinfoline{课程名称}{\@coursename}}%
        \ifdefempty{\@classinfo}{}{\@coverinfoline{班级}{\@classinfo}}%
        \ifdefempty{\@college}{}{\@coverinfoline{学院}{\@college}}%
        \ifdefempty{\@major}{}{\@coverinfoline{专业}{\@major}}%
        \ifdefempty{\@grade}{}{\@coverinfoline{年级}{\@grade}}%
        \ifdefempty{\@authorname}{}{\@coverinfoline{姓名}{\@authorname}}%
        \ifdefempty{\@studentid}{}{\@coverinfoline{学号}{\@studentid}}%
      \end{tabular}\par
    }%

    \bigskip\bigskip\bigskip

    {\dengexianbold\zihao{3}\@coverdate\par}

    \vfill
  \end{titlepage}%
  \restoregeometry
}

% --- 正文元数据 ---
\newcommand{\@authorcn}{}
\renewcommand{\author}[1]{\renewcommand{\@authorcn}{#1}}
\newcommand{\@affiliation}{}
\newcommand{\affiliation}[1]{\renewcommand{\@affiliation}{#1}}
\newcommand{\@authorbio}{}
\newcommand{\authorbio}[1]{\renewcommand{\@authorbio}{#1}}
\newcommand{\@receivedate}{}
\newcommand{\receivedate}[1]{\renewcommand{\@receivedate}{#1}}
\newcommand{\@fundproject}{}
\newcommand{\fundproject}[1]{\renewcommand{\@fundproject}{#1}}
\newcommand{\@clcnumber}{}
\newcommand{\clcnumber}[1]{\renewcommand{\@clcnumber}{#1}}
\newcommand{\@doccode}{}
\newcommand{\doccode}[1]{\renewcommand{\@doccode}{#1}}

% --- 中文摘要与关键词 ---
\newcommand{\@cnabstract}{}
\renewcommand{\abstract}[1]{\renewcommand{\@cnabstract}{#1}}
\newcommand{\@cnkeywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@cnkeywords}{#1}}

\newcommand{\makecnabstract}{%
  \ifdefempty{\@cnabstract}{}{%
    \vspace{0.5cm}
    {\noindent\zihao{-5}\songti\textbf{摘要：}\@cnabstract\par}%
  }%
  \ifdefempty{\@cnkeywords}{}{%
    \vspace{0.3cm}
    {\noindent\zihao{-5}\songti\textbf{关键词：}\@cnkeywords\par}%
  }%
}

% --- 英文摘要与关键词（文后） ---
\newcommand{\@entitle}{}
\newcommand{\entitle}[1]{\renewcommand{\@entitle}{#1}}
\newcommand{\@enauthor}{}
\newcommand{\enauthor}[1]{\renewcommand{\@enauthor}{#1}}
\newcommand{\@enaffiliation}{}
\newcommand{\enaffiliation}[1]{\renewcommand{\@enaffiliation}{#1}}
\newcommand{\@enabstract}{}
\newcommand{\enabstract}[1]{\renewcommand{\@enabstract}{#1}}
\newcommand{\@enkeywords}{}
\newcommand{\enkeywords}[1]{\renewcommand{\@enkeywords}{#1}}

\newcommand{\makeenabstract}{%
  \clearpage
  \ifdefempty{\@entitle}{}{%
    {\centering\zihao{3}\bfseries\@entitle\par}\vspace{0.5cm}%
  }%
  \ifdefempty{\@enauthor}{}{%
    {\centering\zihao{4}\@enauthor\par}\vspace{0.3cm}%
  }%
  \ifdefempty{\@enaffiliation}{}{%
    {\centering\zihao{-5}\@enaffiliation\par}\vspace{0.5cm}%
  }%
  \ifdefempty{\@enabstract}{}{%
    {\noindent\zihao{-5}\textbf{Abstract:}\ \@enabstract\par}\vspace{0.3cm}%
  }%
  \ifdefempty{\@enkeywords}{}{%
    {\noindent\zihao{-5}\textbf{Key words:}\ \@enkeywords\par}%
  }%
}

% --- \maketitle：篇首页信息块 ---
\newcommand{\maketitleblock}{%
  \ifdefempty{\@clcnumber}{}{%
    {\noindent\zihao{-5}\songti 中图分类号：\@clcnumber}%
  }%
  \ifdefempty{\@doccode}{}{%
    {\hfill\zihao{-5}\songti 文献标识码：\@doccode\par}%
  }%
  \vspace{0.3cm}
  {\centering\zihao{2}\songti\bfseries\@title\par}
  \vspace{0.8cm}
  \ifdefempty{\@authorcn}{}{%
    {\centering\zihao{4}\kaiti\@authorcn\par}\vspace{0.3cm}%
  }%
  \ifdefempty{\@affiliation}{}{%
    {\centering\zihao{-5}\songti（\@affiliation）\par}\vspace{0.5cm}%
  }%
  \makecnabstract
}
\renewcommand{\maketitle}{\maketitleblock}

% --- 首页地脚 ---
\newcommand{\makefirstpagefooter}{%
  \vspace{1cm}
  \ifdefempty{\@receivedate}{}{%
    {\noindent\zihao{-5}\kaiti 收稿日期：\@receivedate\par}%
  }%
  \ifdefempty{\@fundproject}{}{%
    {\noindent\zihao{-5}\kaiti 基金项目：\@fundproject\par}%
  }%
  \ifdefempty{\@authorbio}{}{%
    {\noindent\zihao{-5}\kaiti 作者简介：\@authorbio\par}%
  }%
}

% --- 节标题：一级四号楷体居中，二级五号黑体 ---
\ctexset{
  section = {
    format     = {\centering\setstretch{1.5}\zihao{4}\kaiti\bfseries},
    aftername  = {\quad},
    beforeskip = {1.0ex plus 0.2ex minus 0.2ex},
    afterskip  = {0.8ex plus 0.2ex minus 0.2ex},
  },
  subsection = {
    format     = {\zihao{5}\heiti},
    aftername  = {\quad},
    beforeskip = {0.8ex plus 0.2ex minus 0.2ex},
    afterskip  = {0.5ex plus 0.2ex minus 0.2ex},
  },
  subsubsection = {
    format     = {\zihao{5}\kaiti},
    aftername  = {\quad},
    beforeskip = {0.5ex plus 0.2ex minus 0.2ex},
    afterskip  = {0.3ex plus 0.2ex minus 0.2ex},
  },
}
\ctexset{punct=quanjiao, space=true, autoindent=true}
\setlength{\parindent}{2em}

% --- 脚注：小五号宋体，圈码 ---
\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}\relax}}
\renewcommand{\footnoterule}{\noindent\rule{0.25\textwidth}{0.4pt}\vspace{0.2cm}}

% --- 引用：上标方括号 [1] 格式 ---
\let\@cite@orig\cite
\renewcommand{\cite}[1]{\textsuperscript{\@cite@orig{#1}}}

% --- 图表标题 ---
\captionsetup{font={small}, labelfont={bf}, justification=centering, labelsep=quad}

% --- 三线表 ---
\newcommand{\tabletoprule}{\toprule[1.5pt]}
\newcommand{\tablemidrule}{\midrule[0.75pt]}
\newcommand{\tablebottomrule}{\bottomrule[1.5pt]}

% --- 辅助命令 ---
\newcommand{\xmuemdash}{——}

% --- 参考文献 ---
\renewcommand{\refname}{\zihao{4}\kaiti\bfseries 参考文献}
\AtBeginEnvironment{thebibliography}{\zihao{-5}\songti}

% --- 页眉页脚 ---
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\zihao{-5}\songti 厦门大学课程论文}
\fancyfoot[C]{\zihao{-5}\songti\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\zihao{-5}\songti\thepage}\renewcommand{\headrulewidth}{0pt}}

% --- 超链接 ---
\hypersetup{
  colorlinks=true, linkcolor=black, citecolor=black, urlcolor=blue,
  pdfcreator={XMU Course LaTeX Template},
}
