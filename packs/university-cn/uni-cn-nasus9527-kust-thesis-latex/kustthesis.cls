\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kustthesis}[2026/03/12 KUST Thesis Template]

% 基础文档类：基于 ctexbook
\LoadClass[a4paper, 12pt, openany, twoside]{ctexbook}

% ==========================================
% 宏包引入
% ==========================================
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage{bicaption} % 双语图表标题
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{setspace} % 设置行距
\RequirePackage[
    style=gb7714-2015,    % GB/T 7714-2015 顺序编码制
    gbpub=true,           % 著录出版项（出版地、出版社等）
    gbnamefmt=lowercase,  % 作者姓名小写
    doi=false,            % 不显示 DOI
    url=false,            % 不显示 URL
    eprint=false,         % 不显示 eprint（如 PubMed ID）
    isbn=false,           % 不显示 ISBN/ISSN
    maxbibnames=3,        % 最多显示3个作者
    minbibnames=3,        % 最少显示3个作者，超出用"等"
]{biblatex}

% ==========================================
% 定义字号映射（按照Word字号标准）
% ==========================================
\newcommand{\yihao}{\zihao{1}}    % 一号 26bp
\newcommand{\xiaoer}{\zihao{-2}}  % 小二 18bp
\newcommand{\sanhao}{\zihao{3}}   % 三号 16bp
\newcommand{\xiaosan}{\zihao{-3}} % 小三 15bp
\newcommand{\sihao}{\zihao{4}}    % 四号 14bp
\newcommand{\xiaosi}{\zihao{-4}}  % 小四 12bp
\newcommand{\wuhao}{\zihao{5}}    % 五号 10.5bp
\newcommand{\xiaowu}{\zihao{-5}}  % 小五 9bp

% 字体命令映射
\providecommand{\kaiti}{\kaishu}
\providecommand{\songti}{\songti}
\providecommand{\heiti}{\heiti}

% 全局字体设置：正文中文宋体，英文Times New Roman
\setmainfont{Times New Roman}

% ==========================================
% 页面设置（按Word批注要求）
% ==========================================
% 上边距 2.5 cm、下边距 2.0 cm、左边距 2.5 cm、右边距 2.0 cm。装订线在左 0 厘米。
% 页眉 1.5 cm，页脚 1.75 cm (从边界计算)
\geometry{
    a4paper,
    top=2.5cm,
    bottom=2.0cm,
    left=2.5cm,
    right=2.0cm,
    headheight=1.5cm,
    headsep=1.0cm, 
    footskip=0.25cm 
}

% ==========================================
% 行距设置
% ==========================================
% 正文格式要求：固定值 20 磅行距
\setlength{\parindent}{2em}
\setlength{\baselineskip}{20bp}
\renewcommand{\baselinestretch}{1}

% ==========================================
% 页眉页脚设置 (fancyhdr)
% ==========================================
\fancypagestyle{main}{
    \fancyhf{} % 清空页眉页脚
    % 页眉内容：中文字体为宋体，英文为 Times New Roman，五号，居中。
    % 奇数页为本章标题，偶数页为“昆明理工大学硕士学位论文”
    \fancyhead[CO]{\wuhao \songti \leftmark}
    \fancyhead[CE]{\wuhao \songti 昆明理工大学硕士学位论文}
    % 页眉下横线为单实线
    \renewcommand{\headrulewidth}{0.5pt}
    % 页码排版：底端居中。不加“－”修饰线，小五号，Times New Roman。
    \fancyfoot[C]{\xiaowu\rmfamily \thepage}
}

% 摘要等前置部分的页眉页脚格式
\fancypagestyle{front}{
    \fancyhf{}
    \fancyhead[CO]{\wuhao \songti \leftmark}
    \fancyhead[CE]{\wuhao \songti 昆明理工大学硕士学位论文}
    \renewcommand{\headrulewidth}{0.5pt}
    \fancyfoot[C]{\xiaowu\rmfamily \thepage}
}

% 英文摘要页眉单独固定为 Abstract
\fancypagestyle{enabstractstyle}{
    \fancyhf{}
    \fancyhead[CO]{\wuhao \rmfamily Abstract}
    \fancyhead[CE]{\wuhao \rmfamily Abstract}
    \renewcommand{\headrulewidth}{0.5pt}
    \fancyfoot[C]{\xiaowu\rmfamily \thepage}
}

% 重定义 ctex 的 plain 样式以覆盖默认的章首页格式
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyhead[CO]{\wuhao \songti \leftmark}
    \fancyhead[CE]{\wuhao \songti 昆明理工大学硕士学位论文}
    \renewcommand{\headrulewidth}{0.5pt}
    \fancyfoot[C]{\xiaowu\rmfamily \thepage}
}

% 正文章节页眉显示为“第X章 章名”，其余无编号章节保持原标题
\renewcommand{\chaptermark}[1]{%
    \ifnum\value{chapter}>0
        \markboth{第\chinese{chapter}章\quad #1}{}%
    \else
        \markboth{#1}{}%
    \fi
}

% ==========================================
% 各级标题格式设置 (ctexset)
% ==========================================
\ctexset{
    chapter = {
        name = {第,章},
        number = \chinese{chapter},
        format = \heiti\sanhao\centering, % 黑体 三号 居中
        nameformat = \heiti\sanhao,
        numberformat = \heiti\sanhao,
        titleformat = \heiti\sanhao,
        beforeskip = 20bp,
        afterskip = 20bp,
        aftername = \quad, % 题序与标题间空1格
        pagestyle = main,
    },
    section = {
        format = \heiti\xiaosan, % 黑体 小三 两端对齐
        beforeskip = 12bp,
        afterskip = 12bp,
        aftername = \quad,
    },
    subsection = {
        format = \heiti\sihao, % 黑体 四号 两端对齐
        beforeskip = 6bp,
        afterskip = 0bp,
        aftername = \quad,
    },
    subsubsection = {
        format = \heiti\xiaosi, % 黑体 小四 两端对齐
        beforeskip = 6bp,
        afterskip = 6bp,
        aftername = \quad,
    }
}

% 允许给四级标题（1.1.1.1 / subsubsection）编号
\setcounter{secnumdepth}{3}

% ==========================================
% 摘要环境及关键词
% ==========================================
% 中文摘要
\newenvironment{cnabstract}{
    \chapter*{摘要}
    \markboth{摘要}{摘要}
    \addcontentsline{toc}{chapter}{摘要}
    % 中文字体宋体，小四，两端对齐，首行缩进2字符，固定值20磅
    \songti\xiaosi
    \setlength{\parindent}{2em}
    \setlength{\baselineskip}{20bp}
}{
    \par\vspace{1ex}
}

% 中文关键词
\newcommand{\cnkeywords}[1]{
    \par\vspace{1ex}
    \noindent\textbf{\songti\sihao 关键词：}{\songti\xiaosi #1}
}

% 英文摘要
\newenvironment{enabstract}{
    \chapter*{Abstract}
    \markboth{Abstract}{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \thispagestyle{enabstractstyle}
    \pagestyle{enabstractstyle}
    \rmfamily\xiaosi
    \setlength{\parindent}{2em}
    \setlength{\baselineskip}{20bp}
}{
    \par\vspace{1ex}
    \pagestyle{front}
}

% 英文关键词
\newcommand{\enkeywords}[1]{
    \par\vspace{1ex}
    \noindent\textbf{\rmfamily\sihao Keywords: }{\rmfamily\xiaosi #1}
}

% ==========================================
% 目录及清单设置
% ==========================================
\renewcommand{\contentsname}{目\quad 录}
\renewcommand{\listfigurename}{插图清单}
\renewcommand{\listtablename}{附表清单}
% 目录项显示到 2 级（章、节）。
\setcounter{tocdepth}{1}

% 通用的目录/清单标题样式调整（固定20bp，无额外段前段后）
\newcommand{\setupTOCStyle}{
    \ctexset{
        chapter = {
            format = \heiti\sanhao\centering,
            nameformat = \heiti\sanhao,
            numberformat = \heiti\sanhao,
            titleformat = \heiti\sanhao,
            beforeskip = 20bp,
            afterskip = 20bp,
        }
    }
    \setlength{\baselineskip}{20bp}
}

\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
    \begingroup
    \setupTOCStyle
    \oldtableofcontents
    \endgroup
}

\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}{
    \begingroup
    \setupTOCStyle
    \oldlistoffigures
    \endgroup
}

\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{
    \begingroup
    \setupTOCStyle
    \oldlistoftables
    \endgroup
}

% 一级目录项 (章)：黑体 四号，无缩进
\titlecontents{chapter}[0pt]
    {\vspace{-0.2em}\heiti\sihao\setlength{\baselineskip}{20bp}} 
    {\thecontentslabel\quad} 
    {\hspace{0pt}} 
    {\titlerule*[0.5pc]{.}\rmfamily\contentspage}

% 二级目录项 (节)：宋体 四号，左缩进 2 字符
\titlecontents{section}[2.5em] 
    {\songti\sihao\setlength{\baselineskip}{20bp}}
    {\thecontentslabel\quad}
    {\hspace{0pt}}
    {\titlerule*[0.5pc]{.}\rmfamily\contentspage}

% ==========================================
% 图表及题注格式
% ==========================================
\DeclareCaptionFont{capfont}{\songti\rmfamily\xiaosi}
\captionsetup{
    font=capfont,
    labelsep=quad, % 空一格
    justification=centering,
    skip=6bp,
    belowskip=6bp,
}

\captionsetup[figure][bi-first]{
    name={图},
    belowskip=0bp
}
\captionsetup[figure][bi-second]{
    name={Figure},
    skip=0bp
}
\captionsetup[table][bi-first]{
    name={表},
    belowskip=0bp
}
\captionsetup[table][bi-second]{
    name={Table},
    skip=0bp
}

% 通栏三线表环境：按正文宽度均匀拉伸列间距。
\newenvironment{kusttabular}[1]
  {\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}#1}}
  {\end{tabular*}}

% ==========================================
% 表注/图注 (fignote)
% ==========================================
% 楷体 五号，两端对齐，首行缩进2字符，单倍行距。
\newcommand{\fignote}[1]{%
    \par
    \begingroup
    \kaiti\rmfamily\wuhao % 楷体 五号
    \linespread{1.0}\selectfont % 单倍行距
    \setlength{\parindent}{2em}
    \setlength{\parskip}{0bp}
    \leftskip=0pt
    \rightskip=0pt
    \parfillskip=0pt plus 1fil
    \spaceskip=0pt
    \xspaceskip=0pt
    \noindent
    \vspace{2bp} 
    \begin{minipage}{\textwidth}
    \setlength{\parindent}{2em}
    \setlength{\parskip}{0bp}
    #1\par
    \end{minipage}
    \endgroup
}

% 合并的"插图和附表清单"命令（合并到同一页面）
\newcommand{\listoffiguresandtables}{%
    \chapter*{插图和附表清单}
    \markboth{插图和附表清单}{插图和附表清单}
    \addcontentsline{toc}{chapter}{插图和附表清单}
    \vspace{0.5em}
    \@starttoc{lof}
    \vspace{1.5em}
    \@starttoc{lot}
}

% ==========================================
% 参考文献
% ==========================================
% 参考文献内容：宋体/Times 五号，左对齐，首行无缩进，
% 段前段后 0 磅，固定值 20 磅。
\renewcommand*{\bibfont}{\songti\rmfamily\wuhao\setlength{\baselineskip}{20bp}}
\AtBeginBibliography{%
    \songti\rmfamily\wuhao
    \setlength{\baselineskip}{20bp}
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\bibitemsep}{0pt}
    \setlength{\bibparsep}{0pt}
    \leftskip=0pt
    \rightskip=0pt
    \parfillskip=0pt plus 1fil
    \raggedright
}

% ==========================================
% 键值对配置与封面生成 (SJTUThesis-like)
% ==========================================
\RequirePackage{xparse}
\ExplSyntaxOn

\keys_define:nn { kust }
  {
    info .meta:nn = { kust / info } { #1 },
    info / title .tl_set:N = \kust@info@title,
    info / degree-type .tl_set:N = \kust@info@degreetype,
    info / author .tl_set:N = \kust@info@author,
    info / supervisor .tl_set:N = \kust@info@supervisor,
    info / major .tl_set:N = \kust@info@major,
    info / research-field .tl_set:N = \kust@info@researchfield,
    info / work-date .tl_set:N = \kust@info@workdate,
    info / submit-date .tl_set:N = \kust@info@submitdate,
  }

\NewDocumentCommand \kustsetup { +m }
  {
    \keys_set:nn { kust } { #1 }
  }

\ExplSyntaxOff

% 默认值
\kustsetup{
  info = {
    title = {论文题目},
    degree-type = {硕士学位论文},
    author = {作者姓名},
    supervisor = {导师姓名及职称},
    major = {学科专业},
    research-field = {研究方向},
    work-date = {202X年X月 $\sim$ 202X年X月},
    submit-date = {202X年X月},
  }
}

% 封面生成逻辑
\renewcommand{\maketitle}{
  \begin{titlepage}
      \songti\sihao\setlength{\baselineskip}{24pt} % 宋体 四号 2倍行距 
      \noindent
      \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll@{}}
          分类号\underline{\makebox[3cm]{}} & 密\hspace{1em}级\underline{\makebox[3cm]{}} \\
          U\hspace{0.5em}D\hspace{0.5em}C\underline{\makebox[3cm]{}} & \\
      \end{tabular*}

      \vspace{2cm}

      \begin{center}
          % 学校校名 Logo
          \includegraphics[width=9cm]{logo.jpeg} \par
          
          \vspace{1cm}
          
          % 学位类型文字：黑体小二号，居中，单倍行距，首行/左右缩进皆为0。
          {\heiti\xiaoer\linespread{1}\selectfont \kust@info@degreetype \par}
          
          \vspace{2cm}
          
          % 论文题名：题名宜＜20字。中文字体宋体，西文 Times New Roman，一号，居中，1.2倍行距。
          {\songti\yihao\linespread{1.2}\selectfont
          \underline{\makebox[0.8\textwidth][c]{\kust@info@title}}\par}
          
          \vspace{4cm}
          
          % 信息填写区
          % 标签部分（如“作者姓名：”）：宋体三号。
          % 填入内容：楷体三号 (西文 Times New Roman)。
          % 对齐与间距：两端对齐，1.25倍多倍行距。
          {\songti\sanhao
          \renewcommand{\arraystretch}{1.25} % 多倍行距 1.25
          \begin{tabular*}{0.96\textwidth}{@{\extracolsep{\fill}}p{5.1cm}p{9.2cm}@{}}
              \makebox[5.1cm][s]{研究生姓名} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@author}} \\
              \makebox[5.1cm][s]{指导教师姓名、职称} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@supervisor}} \\
              \makebox[5.1cm][s]{学科专业} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@major}} \\
              \makebox[5.1cm][s]{研究方向} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@researchfield}} \\
              \makebox[5.1cm][s]{论文工作起止日期} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@workdate}} \\
              \makebox[5.1cm][s]{论文提交日期} & \underline{\makebox[9.2cm][c]{\kaiti \kust@info@submitdate}} \\
          \end{tabular*}
          }
      \end{center}
  \end{titlepage}
  \cleardoublepage
}

% ==========================================
% 原创性声明与授权说明
% ==========================================
\newcommand{\kustdeclaration}{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    {\heiti\sanhao 遵守学术行为规范承诺}
  \end{center}
  \vspace{0.5em}
  
  {\songti\sihao
  \setlength{\parindent}{2em}
  \setlength{\baselineskip}{20pt}
  本人已熟知并愿意自觉遵守《昆明理工大学研究生学术规范实施细则(试行)》的所有内容，承诺所提交的毕业和学位论文是终稿，不存在学术不端行为，且论文的纸质版与电子版内容完全一致。
  \par}
  
  \vspace{1.5em}
  \begin{center}
    {\heiti\sanhao 独创性声明}
  \end{center}
  \vspace{0.5em}
  
  {\songti\sihao
  \setlength{\parindent}{2em}
  \setlength{\baselineskip}{20pt}
  本人声明所提交的论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得昆明理工大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示了谢意。本人完全意识到本声明的法律结果由本人承担。
  \par}
  
  \vspace{1.5em}
  \begin{center}
    {\heiti\sanhao 关于论文使用授权的说明}
  \end{center}
  \vspace{0.5em}
  
  {\songti\sihao
  \setlength{\parindent}{2em}
  \setlength{\baselineskip}{20pt}
  本人完全了解昆明理工大学有关保留使用学位论文的规定，即：学校有权保留送交论文的复印件，允许论文被查阅和借阅；学校可以公布论文的全部或部分内容，可以采用影印、缩印或其他复制手段保存论文。(保密的论文在解密后应遵守此规定)
  
  本学位论文属于(必须在以下相应方框内打“$\surd$”，否则一律按“非保密论文”处理)：
  
  1．保密论文：$\square$本学位论文属于保密。
  
  2．非保密论文：$\square$本学位论文属于内部论文，网上延后公开。\\
  \mbox{}\hspace{6.8em} $\square$本学位论文不属于保密范围，适用本授权书。
  
  是否同意授权以下单位(必须在以下相应方框内打“$\surd$”，否则一律按“同意授权”处理)：
  
  \noindent $\square$同意授权 \hspace{2em} $\square$不同意授权
  
  将本人学位论文著作权中的数字化复制权、发行权、汇编权和信息网络传播权的专有使用权在全世界范围内授予中国学术期刊(光盘版)电子杂志社，并在《中国优秀博硕士学位论文全文数据库》和CNKI系列数据库中出版。
  \par}
  
  \vspace{2.5em}
  {\songti\sihao
  \noindent
  \begin{tabular}{@{}p{0.45\textwidth}p{0.45\textwidth}@{}}
    研究生本人签名： & 签字日期：\makebox[2em]{}年\makebox[1.5em]{}月\makebox[1.5em]{}日 \\
    \\
    研究生导师签名： & 签字日期：\makebox[2em]{}年\makebox[1.5em]{}月\makebox[1.5em]{}日 \\
  \end{tabular}
  }
  \cleardoublepage
}

\endinput
