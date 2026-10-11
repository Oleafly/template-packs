%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is file 'hautthesis.cls',
%% modified based on hnuthesis project,
%% hnuthesis project GitHub: https://github.com/hnuthesis/hnuthesis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hautthesis}
    [2025/08/11 v0.1.1 HAUT thesis template]

% 变量
\newif\if@haut@doctor
\newif\if@haut@numerical
\newif\if@haut@super
\newif\if@haut@pdf
\newif\if@haut@pro % 专业硕士
\DeclareOption{doctor}{\@haut@doctortrue}
\DeclareOption{master}{\@haut@doctorfalse \@haut@profalse}
\DeclareOption{professional}{\@haut@protrue \@haut@doctorfalse} % 专业硕士
\DeclareOption{print}{\@haut@pdffalse}
\DeclareOption{pdf}{\@haut@pdftrue}
\DeclareOption{super}{\@haut@numericaltrue\@haut@supertrue}
\DeclareOption{numbers}{\@haut@numericaltrue\@haut@superfalse}
\DeclareOption{authoryear}{\@haut@numericalfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{doctor,chinese,print,super}
\ProcessOptions\relax
\newif\if@haut@addtocspace
\if@haut@pdf
  \PassOptionsToClass{oneside}{book}
\fi

% \PassOptionsToPackage{no-math}{fontspec}
\LoadClass[UTF8, a4paper, zihao=-4, twoside]{ctexbook}[2015/05/14]
\RequirePackage{etoolbox}
\@ifclasslater{ctexbook}{2015/05/14}{}{%
    \ClassError{hautthesis}{%
        Requiring ctex 2.0 or later version!\MessageBreak
        Please update the package using your\MessageBreak
        TeX package manager or from CTAN
    }{%
        See logs for more details.
    }
}

\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{hyperref}
\newcommand{\fontpath}{fonts/}
\setmainfont{times.ttf}[
  Path=\fontpath,
  BoldFont=timesbd.ttf,
  ItalicFont=timesi.ttf,
  BoldItalicFont=timesbi.ttf
]
\setsansfont{arial.ttf}[
  Path=\fontpath,
  BoldFont=arialbd.ttf,
  ItalicFont=ariali.ttf,
  BoldItalicFont=arialbi.ttf
]
\setmonofont{cour.ttf}[
  Path=\fontpath,
  BoldFont=courbd.ttf,
  ItalicFont=couri.ttf,
  BoldItalicFont=courbi.ttf
]
\setCJKmainfont{simsun.ttc}[Path=\fontpath]
\setCJKsansfont{simhei.ttf}[Path=\fontpath]
\setmathfont{texgyretermes-math.otf}[Path=\fontpath]

\DeclareRobustCommand{\checkmark}{\ding{51}}

\hypersetup{
    bookmarksopen=true,
    bookmarksnumbered=true,
    bookmarksopenlevel=1,
    CJKbookmarks=true,
    pdfborder=0 0 0,
    unicode=true,
    linktoc=all,
}
\if@haut@pdf
    \hypersetup{
        colorlinks=true,
        allcolors=blue,
    }
\fi

\AtBeginDocument{
    \hypersetup{
        pdftitle={\haut@title},
        pdfauthor={\haut@author}
    }
}

\RequirePackage{xparse}
\NewDocumentCommand\setfontsize{mo}{\IfValueTF{#2}{\fontsize{#1}{#2}}{\fontsize{#1}{2\dimexpr#1}}\linespread{1}\selectfont\relax}
\newcommand\zhspace[1][1]{\hspace{#1\ccwd}}

% 生成带有水平空白的下划线文本
\newcommand\haut@underline[2][6em]{%
    \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt\relax
}

\def\haut@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{
        \expandafter\gdef\csname haut@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}
\haut@define@term{hautcode}
\haut@define@term{hautname}
\haut@define@term{title}
\haut@define@term{dclc}
\haut@define@term{fclc}
\haut@define@term{secrettext}
\haut@define@term{author}
\haut@define@term{authorid}
\haut@define@term{college}
\haut@define@term{major}
\haut@define@term{workon}
\haut@define@term{supervisor}
\haut@define@term{cosupervisor}
\haut@define@term{submitdate}
\haut@define@term{defensedate}
\haut@define@term{chair}
\haut@define@term{subject}
\haut@define@term{type}
\haut@define@term{outsupervisor} % 校外指导教师
\haut@define@term{entitle}
\haut@define@term{enauthor}
\haut@define@term{enmajor}
\haut@define@term{endoctor}
\haut@define@term{enmaster}
\haut@define@term{enbachelor}
\haut@define@term{enhautname}
\haut@define@term{ensupervisor}
\haut@define@term{encosupervisor}
\haut@define@term{entype}
\haut@define@term{encollege}
\haut@define@term{endissertation}
\haut@define@term{endegree}
% \haut@define@term{enoutsupervisor} % 校外指导教师

% 设置学位类型
\AtBeginDocument{%
  \if@haut@doctor
    \type{博士}\entype{PhD}\endegree{Doctor}%
  \else\if@haut@pro
    \type{硕士}\entype{Master}\endegree{Master}%
  \else
    \type{硕士}\entype{Master}\endegree{Master}%
  \fi\fi
}

\if@haut@doctor
    \newcommand\haut@thesisname{博士学位论文}%
\else
    \newcommand\haut@thesisname{硕士学位论文}%
\fi

% 导出学位词（中文/英文）
\newcommand{\degreetypeCN}{\haut@type}
\newcommand{\degreetypeEN}{\haut@entype}

% 表格：
% 三线表
\RequirePackage{booktabs}
\RequirePackage{multirow}
% 跨页表格
\RequirePackage{longtable}

% 题注、标题
\renewcommand\listfigurename{插图索引}
\renewcommand\listtablename{附表索引}
\newcommand\haut@notesname{\textbf{注}：}
\newcommand\haut@enabstractname{Abstract}
\newcommand\haut@abstractname{摘\quad 要}
\newcommand\haut@acknowledgementsname{致\quad 谢}
\newcommand\haut@tocname{目\quad 录}
\newcommand\haut@summaryname{总结与展望}
\newcommand\haut@notationname{符号说明}
\def\equationautorefname~#1\null{公式~(#1)\null}%
\def\footnoteautorefname{脚注}%
\def\itemautorefname~#1\null{第~#1~项\null}%
\def\figureautorefname{图}%
\def\tableautorefname{表}%
\def\partautorefname~#1\null{第~#1~部分\null}%
\def\appendixautorefname{}%
\def\chapterautorefname~#1\null{第~#1~章\null}%
\def\sectionautorefname~#1\null{第~#1~节\null}%
\def\subsectionautorefname~#1\null{第~#1~小节\null}%
\def\subsubsectionautorefname~#1\null{第~#1~小小节\null}%
\def\paragraphautorefname~#1\null{第~#1~段\null}%
\def\subparagraphautorefname~#1\null{第~#1~小段\null}%
\def\theoremautorefname{定理}%
\def\pageautorefname~#1\null{第~#1~页\null}%

% 页面设置，包括页边距，页眉，页脚
\RequirePackage{geometry}
\geometry{
    paper=a4paper,
    top=2.54cm, bottom=2.54cm,
    left=2.6cm, right=2.6cm}
\RequirePackage{fancyhdr}
\fancypagestyle{haut@headings}{%
  \fancyhf{}%
  \fancyhead[C]{\sffamily\fontsize{12pt}{14pt}\selectfont\haut@hautname\haut@type\text{研究生学位论文}}%
  \fancyhead[LE]{\sffamily\fontsize{12pt}{14pt}\selectfont 第\thepage 页}%
  \fancyhead[RO]{\sffamily\fontsize{12pt}{14pt}\selectfont 第\thepage 页}%
  \fancyheadoffset[LO,LE]{3mm}
  \fancyheadoffset[RO,RE]{-3mm}
  \fancyfootoffset[LO,LE]{3mm}
  \fancyfootoffset[RO,RE]{-3mm}
}

% 重定义 plain 样式，与 haut@headings 完全一致以保证章节首页对齐
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[C]{\sffamily\fontsize{12pt}{14pt}\selectfont\haut@hautname\haut@type\text{研究生学位论文}}%
  \fancyhead[LE]{\sffamily\fontsize{12pt}{14pt}\selectfont 第\thepage 页}%
  \fancyhead[RO]{\sffamily\fontsize{12pt}{14pt}\selectfont 第\thepage 页}%
  \fancyheadoffset[LO,LE]{3mm}
  \fancyheadoffset[RO,RE]{-3mm}
  \fancyfootoffset[LO,LE]{3mm}
  \fancyfootoffset[RO,RE]{-3mm}
}

% 页眉文武线定义
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\headrule}{%
  \hrule height 3pt \@width\headwidth
  \vskip 1pt
  \hrule height 0.5pt \@width\headwidth
  \vskip 1mm
}
% 调整页眉高度
\setlength{\headheight}{1cm}
\setlength{\headsep}{0.3cm}

% 页脚文武线定义
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\footrule}{%
  \hrule height 0.5pt \@width\headwidth
  \vskip 1pt
  \hrule height 3pt   \@width\headwidth
  \vskip 1mm
}
% 调整页脚高度
\setlength{\footskip}{8mm}

\fancypagestyle{haut@notation}{\fancyfoot{}}
\pagestyle{haut@headings}
\patchcmd\chaptermark{#1}{\protect\spacetitle{#1}}{}{}
\renewcommand*{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{haut@headings}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\g@addto@macro\frontmatter{%
  \pagenumbering{Roman}%
  \setcounter{page}{1}
}
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \pagenumbering{arabic}%
  \setcounter{page}{1}
  \@mainmattertrue
}

% 列表
\RequirePackage{enumitem}
\setitemize{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=-0em}
\setenumerate{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em}

% 章节、段落、页眉、页脚
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \setlength{\baselineskip}{20pt}
  \renewcommand{\CJKglue}{\hskip 0.5pt plus \baselineskip}
  \global\@topnum\z@
  \@afterindenttrue
  \secdef\@chapter\@schapter
}

\RequirePackage{pifont}
\def\haut@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{hautthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ding{\the\numexpr\value{#1}+191\relax}
}

\RequirePackage{stringstrings}
\newcounter{titlelength}
\newcommand\spacetitle[1]{%
  \@getstringlength{#1}{titlelength}%
  \ifnum\thetitlelength=2{\ziju{2}#1}\else%
    \ifnum\thetitlelength=3{\ziju{1}#1}\else%
      \ifnum\thetitlelength=4{\ziju{0.5}#1}\else#1%
      \fi
    \fi
  \fi
}


% 附录样式
\newcommand{\hautappendix}{%
  \phantomsection
  \appendix

  \renewcommand{\thechapter}{\arabic{chapter}} % 使用阿拉伯数字编号
  \setcounter{chapter}{0}
  \ctexset{%
    chapter = {%
      name = {附录},
      number = \thechapter,
      format = \centering\sffamily\chapterheiti\setfontsize{16pt}\selectfont,
      nameformat = {},
      aftername = \hspace{\ccwd},
      beforeskip = -2em,
      afterskip = 1em,
    }%
  }%
}

% 定义新字体，设置每章标题加粗，避免与ctexset冲突
\newfontfamily\chapterheiti[Path=\fontpath,FakeBold=4]{simhei.ttf}
\setcounter{secnumdepth}{5}
\ctexset{
    chapter = {
        format      = \centering\sffamily\chapterheiti\setfontsize{18pt}\selectfont, % 每章标题应该加粗，但是代码不起作用，未修复
        nameformat  = {},
        % titleformat = \spacetitle,
        number      = \thechapter,
        aftername   = \hspace{\ccwd},
        beforeskip  = -2em, % 24bp - 31bp
        afterskip   = 1em, % 18bp - 10bp
        % fixskip   = true, 
    },
    section = {
        format     = \bf\sffamily\setfontsize{15pt},
        aftername  = \hspace{\ccwd},
        beforeskip = 12pt,
        afterskip  = 12pt,
    },
    subsection = {
        format     = \bf\sffamily\setfontsize{14pt},
        aftername  = \hspace{\ccwd},
        % indent     = 2\ccwd,
        beforeskip = 6pt,
        afterskip  = 6pt,
    },
    subsubsection = {
        format    = \sffamily\setfontsize{12pt},
        number    = (\arabic{subsubsection}),
        % aftername = \hspace{\ccwd},
        beforeskip = 6pt,
        afterskip  = 6pt,
        % indent    = 3\ccwd,
    },
    paragraph = {
        format    = \sffamily\setfontsize{12pt},
        number    = (\arabic{paragraph}),
        aftername = \hspace{\ccwd},
        % indent    = 3\ccwd,
    },
    subparagraph = {
        format    = \sffamily\setfontsize{12pt},
        number    = \haut@textcircled{subparagraph},
        aftername = \hspace{\ccwd},
        % indent    = 3\ccwd,
    },
}

% 书签
\newcounter{haut@pdfbookmark}
\NewDocumentCommand\haut@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \addtocounter{haut@pdfbookmark}\@ne
  \IfValueTF{#1}{%
    \pdfbookmark[0]{#1}{hautchapter.\thehaut@pdfbookmark}%
    \chaptermark{#1}%
  }{%
    \pdfbookmark[0]{#2}{hautchapter.\thehaut@pdfbookmark}%
    \chaptermark{#2}%
  }%
  \chapter*{#2}
}

% 生成封面、中英文扉页、使用授权书、原创性声明
\renewcommand\maketitle{%
    \newgeometry{
        top=3.8cm, bottom=3.8cm,
        left=3.2cm, right=3.2cm,
        headheight=0cm, headsep=0.8cm,
        footskip=0.8cm}
    \pagenumbering{gobble}
    \pdfbookmark[0]{封面}{cover}
    \make@cover
    % 保存原始的 \cleardoublepage 定义
    \let\oldcleardoublepage\cleardoublepage
    % 临时将 \cleardoublepage 定义为 \clearpage
    \renewcommand{\cleardoublepage}{\clearpage}
    \pdfbookmark[0]{标题}{titlepage}
    \make@cntitle
    % --修复openany时在中文扉页和英文扉页会出现空白页的问题 start--
    \if@openright
      \renewcommand*{\cleardoublepage}{%
        \clearpage
        \if@twoside
        \ifodd\c@page \else
          \hbox{}\thispagestyle{empty}\newpage
        \if@twocolumn \hbox{}\newpage\fi
        \fi
      \fi
    }
      \cleardoublepage
      \else
      \renewcommand*{\cleardoublepage}{\clearpage}
    \fi
    % --end--
    \pdfbookmark[0]{Title page}{entitlepage}
    \make@entitle
    \if@openright\cleardoublepage\fi
    \pdfbookmark[0]{使用授权书}{powerofattorney}
    \make@powerofattorney
    \if@openright\cleardoublepage\fi
    \pdfbookmark[0]{原创性声明}{statement}
    \make@statement
    \if@openright\cleardoublepage\fi
    \restoregeometry
    % 恢复原始的 \cleardoublepage 定义
    \let\cleardoublepage\oldcleardoublepage
}

% 多导师渲染（中文）
\newcommand{\haut@supervisorsCN}{%
  \ifx\haut@cosupervisor\@empty
    % 只有一位导师
    \sffamily\textbf{\haut@supervisor}%
  \else
    % 两位导师
    \parbox[t]{8cm}{%
      \sffamily\textbf{\haut@supervisor}\\[-0.3ex]%
      \makebox[\linewidth][l]{\haut@cosupervisor}%
      \vspace{0.8ex}
    }%
  \fi
}%

% 多导师渲染（英文）
\newcommand{\haut@supervisorsEN}{%
  \ifx\haut@encosupervisor\@empty
    % 只有一位导师
    \haut@ensupervisor
  \else
    % 两位导师
    \parbox[t]{8cm}{%
      \text{\haut@ensupervisor}\\[-0.3ex]%
      \makebox[\linewidth][l]{\haut@encosupervisor}%
      \vspace{0.8ex}
    }%
  \fi
}%



\RequirePackage{tikz}
\newcommand\vpostext[2]{%
  \tikz[remember picture,overlay]%
      \node [yshift=-#1] at (current page.north) [below,align=flush center]%
          {\parbox{\textwidth}{\centering#2}};
}

\newcommand\linetext[3]{%
  \underline{\makebox[#1][#2]{#3}}
}

% 绘制密级方框
\newcommand{\checkbox}[1][1.6ex]{%
  \tikz[baseline=0ex]\draw[line width=0.5pt] (0,0) rectangle (#1,#1);
}


% 均匀分布的左栏标签
\NewDocumentCommand{\evenlabel}{O{0pt} m}{%
  {\renewcommand{\CJKglue}{\hskip0pt plus 1fil}%
   \makebox[\@tw][s]{\hspace*{#1}\sffamily\bfseries #2}% 给个起始微移
  }%
}


% 封面
\RequirePackage{tabularx}
\newcommand\make@cover{%
  \begin{titlepage}%
     \tikz[remember picture,overlay]%
        \node [xshift=2.5cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {%

          \newlength{\@tw}
          \setlength{\@tw}{80pt}
          \newlength{\@cw}

          \setfontsize{12pt}%
          \begin{tabularx}{\linewidth}{rlcrl}%
            \makebox[\@tw][r]{\text{国内图书分类号:}} & \makebox[\@tw][l]{\haut@dclc} &
            \makebox[2.5cm][c]{\qquad} &
            \makebox[\@tw][r]{\text{学校代码:}} & \makebox[\@tw][l]{\haut@hautcode} \\%
            \makebox[\@tw][r]{\text{国际图书分类号:}} & \makebox[\@tw][l]{\haut@fclc} &
            \makebox[2.5cm][c]{\qquad} &
            \makebox[\@tw][r]{\text{密级:}} & \makebox[\@tw][l]{\checkbox}
          \end{tabularx}};%         
        
      \vpostext{7cm}{\includegraphics[height=2cm]{figures/logo/haut-logo.pdf}}%
      \vpostext{10cm}{%
        \begin{tabularx}{13cm}{@{}X@{}}%
          \fontsize{42pt}{42pt}\selectfont\CJKfontspec{STXinwei.TTF}[Path=\fontpath]\makebox[13cm][s]{\haut@thesisname}%
        \end{tabularx}%
      }
      \vpostext{13cm}{\CJKfontspec[Path=\fontpath,FakeBold=3]{simsun.ttc}\fontsize{32pt}{32pt}\selectfont\haut@title}%

      \tikz[remember picture,overlay]
        \node [xshift=6cm,yshift=-18cm] at (current page.north west)%
            [below right,align=left] {%

          \setlength{\@tw}{85pt}
          % \setlength{\@cw}{0.2em}

          \setfontsize{14pt}%
          \if@haut@pro
            % 专业硕士版式
            % FIX 对齐问题
            \begin{tabular}{@{}l@{\hspace{1.6em}}l@{}}
              \evenlabel[-0.95em]{作者姓名} & \sffamily\textbf{\haut@author} \\  % 不清楚为什么对不齐，加一点偏移补偿
              \evenlabel{指导教师} & \sffamily\textbf{\haut@supervisorsCN} \\
              \evenlabel{校外指导教师} & \sffamily\textbf{\haut@outsupervisor} \\
              \evenlabel{学位类别} & \sffamily\textbf{\haut@subject} \\
              \evenlabel{专业} & \sffamily\textbf{\haut@major} \\
              \evenlabel{研究方向} & \sffamily\textbf{\haut@workon} \\
              \evenlabel{培养单位} & \sffamily\textbf{\haut@college} \\
              \evenlabel{完成时间} & \sffamily\textbf{\haut@submitdate}
            \end{tabular}

          \else
             % 博/学硕 版式
            \begin{tabular}{@{}l@{\hspace{1.6em}}l@{}}
              \evenlabel[-0.95em]{作者姓名} & \sffamily\textbf{\haut@author} \\
              \evenlabel{指导教师} & \sffamily\textbf{\haut@supervisorsCN} \\
              \evenlabel{学科门类} & \sffamily\textbf{\haut@subject} \\
              \evenlabel{学科专业} & \sffamily\textbf{\haut@major} \\
              \evenlabel{研究方向} & \sffamily\textbf{\haut@workon} \\
              \evenlabel{培养单位} & \sffamily\textbf{\haut@college} \\
              \evenlabel{完成时间} & \sffamily\textbf{\haut@submitdate}
            \end{tabular}
          \fi
        };

    \end{titlepage}
}

% 中文扉页
\newcommand\make@cntitle{%
  \begin{titlepage}%
      \tikz[remember picture,overlay]
        \node [xshift=3cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {%

          \setlength{\@tw}{80pt}
          \setlength{\@cw}{-1em}

          \setfontsize{12pt}%
          \begin{tabularx}{\linewidth}{rlcrl}%
            \makebox[\@tw][r]{\textbf{国内图书分类号：}} & \makebox[\@tw][l]{\hspace{\@cw}\haut@dclc} &
            \makebox[2.5cm][c]{\qquad} & 
            \multirow{2}{*}[0pt]{\centering\makebox[\@tw][r]{\textbf{密级：}}} &
            \multirow{2}{*}[0pt]{\centering\makebox[\@tw][l]{\hspace{\@cw}\haut@secrettext}} \\
            \makebox[\@tw][r]{\textbf{国际图书分类号：}} & \makebox[\@tw][l]{\hspace{\@cw}\haut@fclc} & 
            \makebox[2.5cm][c]{\qquad} \\
          \end{tabularx}};%

      \tikz[remember picture,overlay]
        \node [xshift=5.4cm,yshift=-10cm] at (current page.north west)%
            [below right,align=center]%
            {\parbox{12cm}{\centering\CJKfontspec[Path=\fontpath,FakeBold=3]{simsun.ttc}\fontsize{28pt}{28pt}\selectfont\haut@title}};

      \tikz[remember picture,overlay]
        \node [xshift=5.2cm,yshift=-16cm] at (current page.north west)%
            [below right,align=left] {%
          \setlength{\@tw}{107pt}
          % \setlength{\@cw}{9.5cm}

          \setfontsize{14pt}%
          \if@haut@pro
            % 专业硕士版式
          % TODO 添加专硕模板
            \begin{tabular}{@{}l@{\hspace{1.6em}}l@{}}
              \evenlabel{学号} & \haut@authorid \\%
              \evenlabel{作者姓名} & \sffamily\textbf{\haut@author} \\
              \evenlabel{指导教师} & \sffamily\textbf{\haut@supervisorsCN} \\
              \evenlabel{校外指导教师} & \sffamily\textbf{\haut@outsupervisor} \\
              \evenlabel{申请学位级别} & \sffamily\textbf{\haut@type} \\
              \evenlabel{专业} & \sffamily\textbf{\haut@major} \\
              \evenlabel{研究方向} & \sffamily\textbf{\haut@workon} \\
              \evenlabel{培养单位} & \sffamily\textbf{\haut@college} \\
              \evenlabel{论文答辩日期} & \sffamily\textbf{\haut@defensedate}
              \end{tabular}
          \else
            % 博/学硕 版式
            \begin{tabular}{@{}l@{\hspace{1.6em}}l@{}}
              \evenlabel{学号} & \haut@authorid \\%
              \evenlabel{作者姓名} & \sffamily\textbf{\haut@author} \\
              \evenlabel{指导教师} & \sffamily\textbf{\haut@supervisorsCN} \\
              \evenlabel{申请学位级别} & \sffamily\textbf{\haut@type} \\
              \evenlabel{学科专业} & \sffamily\textbf{\haut@major} \\
              \evenlabel{研究方向} & \sffamily\textbf{\haut@workon} \\
              \evenlabel{培养单位} & \sffamily\textbf{\haut@college} \\
              \evenlabel{论文答辩日期} & \sffamily\textbf{\haut@defensedate}
              \end{tabular}
            \fi
          };%
    \end{titlepage}
}

% 英文扉页
\newcommand\make@entitle{%
    \begin{titlepage}%
      \tikz[remember picture,overlay]
      \node [xshift=2.5cm,yshift=-2.5cm] at (current page.north west)%
          [below right,align=left] {%

        \setlength{\@tw}{66.5pt}
        \setlength{\@cw}{3.2cm}

        \setfontsize{12pt}%
        \begin{tabularx}{\linewidth}{ll}%
          \makebox[\@tw][l]{\text{Classified Index：}} & \hspace{1em}\haut@dclc \\
          \makebox[\@tw][l]{\text{U.D.C：}} & \hspace{-3.2em}\haut@fclc
        \end{tabularx}};%

      \vpostext{5.5cm}{\setfontsize{18pt}\text{\haut@enhautname}}%
      \if@haut@doctor
        \vpostext{6.5cm}{\setfontsize{18pt}\haut@endegree\space\text{Degree Dissertation}}%
      \else
        \vpostext{6.5cm}{\setfontsize{18pt}\haut@endegree\space\text{Degree Thesis}}%
      \fi
      \vpostext{10cm}{\setfontsize{22pt}\textbf{\haut@entitle}}%
      
      \tikz[remember picture,overlay]
      \node [xshift=7.5cm,yshift=-16cm] at (current page.north west)%
          [below right,align=left] {%

        \setlength{\@tw}{66.5pt}
        \setlength{\@cw}{-0.7em}

        \setfontsize{15pt}%
        % TODO 添加专硕模板，待定
        \begin{tabularx}{\linewidth}{rl}%
          \makebox[\@tw][r]{\text{Student Number:}} & \hspace{\@cw}\haut@authorid\\
          \makebox[\@tw][r]{\text{Candidate:}} & \hspace{\@cw}\haut@enauthor \\
          \makebox[\@tw][r]{\text{Supervisor:}} & \hspace{\@cw}\haut@supervisorsEN \\
          \makebox[\@tw][r]{\text{Academic Degree Applied for:}} & \hspace{\@cw}\haut@entype\\
          \makebox[\@tw][r]{\text{Speciality:}} & \hspace{\@cw}\haut@enmajor\\
          \makebox[\@tw][r]{\text{Affiliations:}} & \hspace{\@cw}\parbox[t]{6cm}{\haut@encollege} \\
          ~ & ~ \\
          \makebox[\@tw][r]{\text{Dissertation Defense Date:}} & \hspace{\@cw}\haut@endissertation
        \end{tabularx}};%

    \end{titlepage}
}

% 授权书及原创性声明
\newcommand{\haut@declaretext} {
  本人郑重声明：所呈交的学位论文，是在导师指导下独立进行研究工作所得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的研究成果。对本文的研究做出贡献的个人和集体，均已在文中作了明确的说明。本人完全意识到本声明的法律结果由本人承担。
}
\newcommand{\haut@authorization}{
  本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权河南工业大学可以将本论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复印手段保存和汇编本学位论文。

\vspace{4cm}
本学位论文属于

1、保密 \checkbox，在\qquad 年解密后适用本授权书。

2、不保密 \checkbox，使用本授权书。

（请在以上方框内打“\ding{51}”）
}

% 授权书
\newcommand\make@powerofattorney{
    \newgeometry{left=2.6cm,right=2.6cm,top=3.5cm, bottom=3cm}
    \thispagestyle{empty}
    \setfontsize{12pt}[25pt]
    
    \begin{center}
      \CJKfontspec[Path=\fontpath,FakeBold=3]{simhei.ttf}\setfontsize{16pt}\selectfont
      \haut@hautname \\
      学位论文版权使用授权书
    \end{center}
    \vskip 0.3cm

    \haut@authorization\par
    \vskip 4cm

    学位论文作者签名：\qquad\qquad\qquad\qquad\qquad\quad 指导老师签名：\qquad\qquad\qquad\qquad\qquad\quad
    \vskip 1cm
    日期：\qquad\qquad\qquad\qquad\qquad\quad\quad\quad\quad\quad\quad\quad 日期：\qquad\qquad\qquad\qquad\qquad\quad\quad
    
    \restoregeometry
}

% 原创性声明
\newcommand\make@statement{
    \newgeometry{left=2.6cm,right=2.6cm,top=3.5cm, bottom=3cm}
    \thispagestyle{empty}
    \setfontsize{12pt}[25pt]

    \begin{center}
      \sffamily
      \setfontsize{16pt}
      \makebox[3.5cm][s]{\textbf\haut@hautname}\\
      \textbf{\haut@thesisname\text{原创性声明}}
    \end{center}
    \vskip 0.5cm

    \haut@declaretext\par

    \vskip 2cm
    \qquad\qquad\qquad\qquad\qquad\quad\qquad\quad\qquad\quad 学位论文作者签名：\qquad\qquad\qquad\qquad\qquad\quad
    \vskip 0.2cm
    \qquad\qquad\qquad\qquad\qquad\quad\qquad\quad\qquad\quad 日期：

    \restoregeometry
}

% 摘要、关键字
\newenvironment{abstract}{%
    \haut@chapter{\haut@abstractname}%
    \setcounter{page}{1}
    \pagenumbering{Roman}
  }{}
\newenvironment{enabstract}{%
    \haut@chapter[Abstract]{\haut@enabstractname}
  }{}

\newenvironment{summary}{%
    \haut@chapter{\haut@summaryname}%
}{}
\newenvironment{acknowledgements}{%
  \chapter*{\haut@acknowledgementsname}% 创建无编号章节
  \addcontentsline{toc}{chapter}{\haut@acknowledgementsname}% 将章节添加到目录
}{}

\newcommand\keywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=4\ccwd\relax%
  \CJKfontspec[Path=\fontpath,FakeBold=3]{simsun.ttc}\setfontsize{12pt}\selectfont\text{关键词}：
  \CJKfontspec[Path=\fontpath]{simsun.ttc}\setfontsize{12pt}#1}
\newcommand\enkeywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=5.3em\relax%
  \textbf{Key Words}: #1}

% 目录
\renewcommand\tableofcontents{%
    \clearpage%
    \setcounter{tocdepth}{2}
    \haut@chapter{\haut@tocname}%
    \@starttoc{toc}
}

\RequirePackage{titletoc}
\newcommand\haut@leaders{\titlerule*[0.5pc]{$\cdot$}}
  \titlecontents{chapter}[0bp]
    {\addvspace{6bp}\bf\sffamily\setfontsize{12.5pt}[15pt]}
    {\contentspush{\thecontentslabel\unskip\hskip\ccwd\relax}}
    {}{\haut@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}
  \titlecontents{section}
      [2\ccwd]
      {\setfontsize{12.5pt}[20pt]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\haut@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}
  \titlecontents{subsection}
      [4\ccwd]
      {\setfontsize{12.5pt}[20pt]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\haut@leaders\setfontsize{12.5pt}[12.5pt]\contentspage}

  \titlecontents{figure}[0bp]
      {\setfontsize{12.5pt}}
      {\figureautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\haut@leaders\contentspage}
  \titlecontents{table}[0bp]
      {\setfontsize{12.5pt}}
      {\tableautorefname\hspace*{0.5em}\thecontentslabel\quad}
      {}{\haut@leaders\contentspage}
      % 为了让图目录另页起，重新定义 \cs{listoffigures}
\renewcommand\listoffigures{%
    \clearpage
    \haut@chapter{\listfigurename}%
    \@starttoc{lof}}
    % 表目录同样
\renewcommand\listoftables{%
    \clearpage
    \haut@chapter{\listtablename}%
    \@starttoc{lot}}

\newenvironment{notation}{%
    \cleardoublepage
    \thispagestyle{haut@notation}
    \ctexset{chapter/format = \centering\rmfamily\setfontsize{12bp}}
    \haut@chapter{\haut@notationname}
    \setfontsize{10.5bp}[16bp]
    \setlength{\itemsep}{0bp}}{}
\newdimen\bp@ \bp@=1bp

\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{20\bp@}%
  \abovedisplayskip 12\bp@ \@plus3\bp@ \@minus7\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
  \renewcommand\small{%
     \@setfontsize\small{10.5\bp@}{17.5\bp@}%
     \abovedisplayskip 10.5\bp@ \@plus3\bp@ \@minus6\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini
                 \topsep 9\bp@ \@plus3\bp@ \@minus5\bp@
                 \parsep 4.5\bp@ \@plus2\bp@ \@minus\bp@
                 \itemsep \parsep}%
     \belowdisplayskip \abovedisplayskip
  }
  \renewcommand\footnotesize{%
     \@setfontsize\footnotesize{9\bp@}{15\bp@}
     \abovedisplayskip 9\bp@ \@plus2\bp@ \@minus5\bp@
     \abovedisplayshortskip \z@ \@plus3\bp@
     \belowdisplayshortskip 6\bp@ \@plus3\bp@ \@minus3\bp@
     \def\@listi{\leftmargin\leftmargini
                 \topsep 6\bp@ \@plus2\bp@ \@minus2\bp@
                 \parsep 3\bp@ \@plus2\bp@ \@minus\bp@
                 \itemsep \parsep}%
     \belowdisplayskip \abovedisplayskip
  }
  \renewcommand\scriptsize{\@setfontsize\scriptsize{7.5\bp@}{12.5\bp@}}
  \renewcommand\tiny{\@setfontsize\tiny{6.5\bp@}{10.83\bp@}}
  \renewcommand\large{\@setfontsize\large{15\bp@}{25\bp@}}
  \renewcommand\Large{\@setfontsize\Large{18\bp@}{30\bp@}}
  \renewcommand\LARGE{\@setfontsize\LARGE{22\bp@}{36.67\bp@}}
  \renewcommand\huge{\@setfontsize\huge{24\bp@}{40\bp@}}
  \renewcommand\Huge{\@setfontsize\Huge{26\bp@}{43.33\bp@}}

% 排版风格，标题，图表
\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{\z@}
\RequirePackage{upgreek}
\renewcommand\pi{\uppi}
% \RequirePackage{amssymb}
\renewcommand\le{\leqslant}
\renewcommand\leq{\leqslant}
\renewcommand\ge{\geqslant}
\renewcommand\geq{\geqslant}
\DeclareMathSizes{10.5bp}{10.5bp}{7.35bp}{5.25bp}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.65}
\renewcommand\textfraction{.15}
\renewcommand{\floatpagefraction}{.8}
\RequirePackage{graphicx}
\RequirePackage[font=small,labelfont=rm,skip=0pt]{caption}
\RequirePackage{subcaption}
\RequirePackage{calc}
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
\captionsetup{
    format = hang,
    font = {small,rm},
    labelsep = zhspace,
}
\captionsetup[figure]{
    position = bottom,
    aboveskip = 3pt,
    belowskip = 0pt,
}
\captionsetup[subfigure]{%
  aboveskip=0pt,   % 子图内容 ↔ 子题 之间的距离
  belowskip=0pt,   % 子题  ↔ 下行内容 之间的距离（也就是两排子图之间）
  font=footnotesize,
  labelfont=rm,
  labelsep=zhspace  % 保持你原来 “图(a)” 与文字之间的中文空格分隔
}
\captionsetup[table]{
    position = top,
    aboveskip = 2pt,
    belowskip = 0pt,
}

% 强制 H 模式下的间距
\setlength{\intextsep}{7pt}       % [H] 图 ↔ 正文
% 顶端／底部浮动时的间距
\setlength{\textfloatsep}{7pt}    % [t]/[b] 图 ↔ 正文

% 长表格垂直间距
\setlength{\LTpre}{0pt}    % 表格前不留空白
\setlength{\LTpost}{0pt}   % 表格后不留空白


\newcommand\note[1]{%
    \captionsetup{position = bottom, font = small}
    \caption*{\hangindent=2\ccwd\relax\haut@notesname\rmfamily#1}}
\renewcommand{\thefootnote}{\haut@textcircled{footnote}}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.25\textwidth
  \kern2.6\p@}
\renewcommand\@makefntext[1]{%
  \parindent 2\ccwd%
  \noindent
  \hb@xt@2\ccwd{\hss\@makefnmark}#1}
\RequirePackage[sort&compress]{natbib}
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
\def\tmp@numerical{numerical}
\def\tmp@authoryear{authoryear}
\newcommand\hautbibstyle[1]{%
  \def\tmp@gbt{#1}%
  \ifx\tmp@gbt\tmp@numerical%
    \bibliographystyle{hautnumerical}%
  \fi%
}

\if@haut@numerical
  \if@haut@super
    \citestyle{super}
  \else
    \citestyle{numbers}
  \fi
  \bibliographystyle{hautnumerical}%
\else
  \citestyle{authoryear}
  \bibliographystyle{hautauthoryear}%
\fi

% 引用
\patchcmd\NAT@citexnum{%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\NAT@cmt#2\fi
  }{}%
  \NAT@mbox{\NAT@@close}%
}{%
  \NAT@mbox{\NAT@@close}%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\textsuperscript{#2}\fi
  }{}%
}{}{}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa
\if*#2*\else#2\NAT@spacechar\fi
\unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
   \else #1\fi\endgroup}
\renewcommand\NAT@citenum%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\patchcmd{\NAT@citex}{%
  \if*#2*\else\NAT@cmt#2\fi
  \if\relax\NAT@date\relax\else\NAT@@close\fi
}{%
  \if\relax\NAT@date\relax\else\NAT@@close\fi
  \if*#2*\else\textsuperscript{#2}\fi
}{}{}
\renewcommand\NAT@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\renewcommand\bibfont{\setfontsize{10.5bp}[20bp]}
\setlength{\bibsep}{0bp}
\setlength{\bibhang}{2\ccwd}
\renewcommand\@biblabel[1]{[#1]\hfill}
\urlstyle{same}
\g@addto@macro\UrlBreaks{%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
  \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
  \do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J%
  \do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T%
  \do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0%
}
\renewcommand\bibsection{%
    \@mainmatterfalse
    \chapter{\bibname}%
    \@mainmattertrue
}

% 数学符号：
\RequirePackage{amsmath,amsthm}
\makeatletter
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{16pt}
  \setlength\belowdisplayskip{16pt}
  \setlength\abovedisplayshortskip{16pt}
  \setlength\belowdisplayshortskip{16pt}
}
% \newcommand\eu{\mathrm{e}}
% \newcommand\iu{\mathrm{i}}
%\newcommand*{\diff}{\mathop{}\!\mathrm{d}}
%\DeclareMathOperator*{\argmax}{arg\,max}
%\DeclareMathOperator*{\argmin}{arg\,min}
% 数学定理：
% 以下定义数学定理环境默认风格为 hautplain。
\newtheoremstyle{hautplain}%
    {}{}%
    {}{2\ccwd}%
    {\bfseries}{}%
    {\ccwd}{}
\theoremstyle{hautplain}
% 定义新的定理

\newcommand\haut@assertionname{断言}
\newcommand\haut@axiomname{公理}
\newcommand\haut@corollaryname{推论}
\newcommand\haut@definitionname{定义}
\newcommand\haut@examplename{例}
\newcommand\haut@lemmaname{引理}
\newcommand\haut@proofname{证明}
\newcommand\haut@propositionname{命题}
\newcommand\haut@remarkname{注}
\newcommand\haut@theoremname{定理}
\newtheorem{theorem}                {\haut@theoremname}     [chapter]
\newtheorem{assertion}  [theorem]   {\haut@assertionname}
\newtheorem{axiom}      [theorem]   {\haut@axiomname}
\newtheorem{corollary}  [theorem]   {\haut@corollaryname}
\newtheorem{lemma}      [theorem]   {\haut@lemmaname}
\newtheorem{proposition}[theorem]   {\haut@propositionname}
\newtheorem{definition}             {\haut@definitionname}  [chapter]
\newtheorem{example}                {\haut@examplename}     [chapter]
\newtheorem*{remark}                {\haut@remarkname}

\renewenvironment{proof}[1][\proofname]{\par
    \pushQED{\qed}%
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
        \item\relax\hskip2\ccwd
        \textbf{#1}
        \hskip\ccwd\ignorespaces
    }{%
    \popQED\endtrivlist\@endpefalse
}
\renewcommand\proofname\haut@proofname

% 算法和代码：
% 算法环境
\RequirePackage[algoruled, algochapter, lined, linesnumbered]{algorithm2e}
\renewcommand{\algorithmcfname}{算法}
\RequirePackage{listings}
\lstset{
    basicstyle=\small\ttfamily,
    xleftmargin=2pc,
    xrightmargin=2pc,
    frame=single,
    columns=flexible,
    numbers=left,
}
\newcommand{\rememberlines}{\xdef\rememberedlines{\number\value{AlgoLine}}}
\newcommand{\resumenumbering}{\setcounter{AlgoLine}{\rememberedlines}}

\RequirePackage[skins]{tcolorbox}
\newtcolorbox{talgorithm}[2][]{%
  blanker,float=tbp,grow to left by=#2,grow to right by=#2,
  before upper={\begin{algorithm}[H]},
  after upper={\end{algorithm}},
  #1
}
