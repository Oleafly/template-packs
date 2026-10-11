%%==============================================================
%%  smbuthesis.cls  -  Shenzhen MSU-BIT University Thesis Class
%%  Compile with XeLaTeX (+ bibtex/biber for IEEE references)
%%==============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{smbuthesis}[2026/04/27 v1.0 SMBU Thesis Template]

% --- Pass unknown options to ctexbook ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

% --- Base class ---
% UTF8, A4, two-side off, font sizes managed manually with \zihao
\LoadClass[UTF8,a4paper,oneside,zihao=-4,fontset=none]{ctexbook}

%%==============================================================
%%  Required packages
%%==============================================================
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{etoc}
\RequirePackage{refcount}
\RequirePackage{caption}
\captionsetup{labelsep=space}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{newtxmath}
\RequirePackage{xcolor}
\RequirePackage{indentfirst}
% Bibliography: traditional BibTeX (ieeetr style for numeric IEEE-like citations)
% Compile chain: xelatex -> bibtex -> xelatex -> xelatex

% 引用格式：中括号上标 [1]
\RequirePackage[superscript]{cite}
\renewcommand\@citess[1]{\textsuperscript{[#1]}}

\RequirePackage[bookmarks=true,colorlinks=false,hidelinks,unicode]{hyperref}

%%==============================================================
%%  Page geometry  (Left 3.17 cm, Right 3.17 cm, Top 1.4 cm, Bottom 2 cm)
%%==============================================================
\geometry{
  a4paper,
  left=3cm,
  right=1.5cm,
  top=1.4cm,
  bottom=2cm,
  includehead,
  includefoot,
  headheight=1cm,
  headsep=0.5cm,
  footskip=1.1cm
}

%%==============================================================
%%  Line / paragraph spacing
%%==============================================================
\setstretch{1.5}                     % global 1.5x line spacing
\setlength{\parskip}{0.5ex}          % 0.5 line before/after paragraphs
\setlength{\parindent}{2em}          % standard Chinese 2-character indent

%%==============================================================
%%  Fonts
%%   - Western : Times New Roman
%%   - 中文宋体 : SimSun (default by ctex windows fontset)
%%   - 中文黑体 : SimHei (default by ctex windows fontset)
%%   AutoFakeBold synthesises a bold variant for CJK fonts that
%%   ship without one (e.g. SimSun), so bold Level-1 TOC entries
%%   render correctly.
%%==============================================================
% Western fonts from project root (all-caps filenames)
\setmainfont{TIMES.TTF}[
  Path=./,
  BoldFont=TIMESBD.TTF,
  ItalicFont=TIMESI.TTF,
  BoldItalicFont=TIMESBI.TTF
]

% CJK fonts from project root (all-caps filenames)
\setCJKmainfont{SIMSUN.TTC}[
  Path=./,
  UprightFeatures={FontIndex=0},
  AutoFakeBold=2.5,
  ItalicFont=SIMKAI.TTF
]
\setCJKsansfont{SIMHEI.TTF}[
  Path=./,
  AutoFakeBold=2.5
]
\setCJKfamilyfont{zhsong}{SIMSUN.TTC}[
  Path=./,
  UprightFeatures={FontIndex=0},
  AutoFakeBold=2.5
]
\setCJKfamilyfont{zhhei}{SIMHEI.TTF}[
  Path=./,
  AutoFakeBold=2.5
]

% fontset=none does not define \heiti / \songti; provide them manually
\newcommand{\heiti}{\CJKfamily{zhhei}}
\newcommand{\songti}{\CJKfamily{zhsong}}

% Convenience: Bold Times New Roman (for foreign abstract)
\newcommand{\tnrbf}[1]{{\bfseries #1}}

%%==============================================================
%%  Header & footer
%%   - header  : centered logo with rule below
%%   - footer  : "第 X 页 共 Y 页" centered, 五号宋体
%%==============================================================
\newcommand{\smbu@logo}{logo.jpeg}    % logo file in document root
\newcommand{\smbulogo}[1]{\renewcommand{\smbu@logo}{#1}}

\pagestyle{fancy}

\fancypagestyle{smbumain}{%
  \fancyhf{}
  \fancyhead[C]{\includegraphics[height=1cm,keepaspectratio]{\smbu@logo}}
  \fancyfoot[C]{\zihao{5}\songti 第~\thepage~页~共~\the\numexpr\getpagerefnumber{lastnumberedpage}\relax~页}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{smbumain}

% ctexbook switches to "plain" on chapter pages -> override it too.
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyhead[C]{\includegraphics[height=1cm,keepaspectratio]{\smbu@logo}}
  \fancyfoot[C]{\zihao{5}\songti 第~\thepage~页~共~\the\numexpr\getpagerefnumber{lastnumberedpage}\relax~页}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{nofoot}{%
  \fancyhf{}
  \fancyhead[C]{\includegraphics[height=1cm,keepaspectratio]{\smbu@logo}}
  % \fancyfoot[C]{\zihao{5}\songti 第~\thepage~页~共~\the\numexpr\getpagerefnumber{lastnumberedpage}\relax~页}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}

%%==============================================================
%%  Heading styles  (numeric hierarchy, Variant 5)
%%   Level 1  Chapter     -> 3号黑体, "1.  Title", new page, centered
%%   Level 2  Section     -> 小四黑体, "1.1  Title"
%%   Level 3  Subsection  -> 小四黑体, "1.1.1  Title"
%%   Level 4  Paragraph   -> 小四黑体
%%   No extra space between number and text.
%%==============================================================
\ctexset{
  chapter = {
    name        = {,.},
    number      = \arabic{chapter},
    format      = \zihao{3}\heiti\bfseries\centering,
    nameformat  = {},
    titleformat = {},
    aftername   = \space,
    beforeskip  = 4pt,
    afterskip   = 3ex,
    fixskip     = true,
    pagestyle   = smbumain
  },
  section = {
    format      = \zihao{-4}\heiti\bfseries,
    aftername   = \space,
    beforeskip  = 1ex,
    afterskip   = 1ex
  },
  subsection = {
    format      = \zihao{-4}\heiti\bfseries,
    aftername   = \space,
    beforeskip  = 0.8ex,
    afterskip   = 0.8ex
  },
  subsubsection = {
    format      = \zihao{-4}\heiti\bfseries,
    aftername   = \space,
    beforeskip  = 0.6ex,
    afterskip   = 0.6ex
  },
  paragraph = {
    format      = \zihao{-4}\heiti\bfseries,
    aftername   = \space
  }
}


%%==============================================================
%%  Table of contents (via etoc)
%%   - Bilingual TOC: Chinese and Russian share one .toc file
%%   - Use etoc level filtering to display one language at a time
%%==============================================================
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}

% Define Russian TOC levels (same numeric depths as Chinese)
\etocsetlevel{ruchapter}{0}
\etocsetlevel{rusection}{1}
\etocsetlevel{rusubsection}{2}

% Fixed spacing between number and title in TOC
\newcommand{\smbu@tocnumsep}{\unskip\hspace{.3em}}

% --- Shared etoc styles ----------------------------------------
\etocsetstyle{chapter}
  {}
  {\par\vspace{0.4em}\noindent}
  {\etocifnumbered
    {\bfseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname}
    {\bfseries\zihao{-4}\rmfamily\songti\etocname}%
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{section}
  {}
  {\par\hspace{-0.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{subsection}
  {}
  {\par\hspace{1.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{subsubsection}
  {}
  {\par\hspace{3em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

% Russian levels use the same styles
\etocsetstyle{ruchapter}
  {}
  {\par\vspace{0.4em}\noindent}
  {\etocifnumbered
    {\bfseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname}
    {\bfseries\zihao{-4}\rmfamily\songti\etocname}%
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{rusection}
  {}
  {\par\hspace{-0.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{rusubsection}
  {}
  {\par\hspace{1.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

% English levels use the same styles
\etocsetstyle{enchapter}
  {}
  {\par\vspace{0.4em}\noindent}
  {\etocifnumbered
    {\bfseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname}
    {\bfseries\zihao{-4}\rmfamily\songti\etocname}%
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{ensection}
  {}
  {\par\hspace{-0.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

\etocsetstyle{ensubsection}
  {}
  {\par\hspace{1.5em}}
  {\mdseries\zihao{-4}\rmfamily\songti\etocnumber\smbu@tocnumsep\etocname
   \nobreak\leaders\hbox{$\m@th\mkern 4.5mu\cdot\mkern 4.5mu$}\hfill
   \nobreak\etocpage\par}
  {}

% --- Chinese TOC -----------------------------------------------
\newcommand{\printchinesetoc}{%
  \cleardoublepage
  \phantomsection
  \addtocontents{toc}{\protect\thispagestyle{nofoot}}
  \pagestyle{nofoot}
  \etocsettocstyle{
    \chapter*{目\hspace{2em}录}
  }{\relax}
  % Show Chinese levels, hide others (>tocdepth)
  \etocsetlevel{chapter}{0}
  \etocsetlevel{section}{1}
  \etocsetlevel{subsection}{2}
  \etocsetlevel{ruchapter}{10}
  \etocsetlevel{rusection}{10}
  \etocsetlevel{rusubsection}{10}
  \etocsetlevel{enchapter}{10}
  \etocsetlevel{ensection}{10}
  \etocsetlevel{ensubsection}{10}
  \etocsetnexttocdepth{2}
  \tableofcontents
   % \pagestyle{smbumain}
}

% --- Russian TOC -----------------------------------------------
\newcommand{\printrussiantoc}{%
  \cleardoublepage
  \phantomsection
  \addtocontents{toc}{\protect\thispagestyle{nofoot}}
  \pagestyle{nofoot}
  \etocsettocstyle{%
    \chapter*{Оглавление}%
  }{\relax}
  \etocsetlevel{chapter}{10}
  \etocsetlevel{section}{10}
  \etocsetlevel{subsection}{10}
  \etocsetlevel{ruchapter}{0}
  \etocsetlevel{rusection}{1}
  \etocsetlevel{rusubsection}{2}
  \etocsetlevel{enchapter}{10}
  \etocsetlevel{ensection}{10}
  \etocsetlevel{ensubsection}{10}
  \etocsetnexttocdepth{2}
  \tableofcontents
  % \pagestyle{smbumain}
}

% --- English TOC -----------------------------------------------
\newcommand{\printenglishtoc}{%
  \cleardoublepage
  \phantomsection
  \addtocontents{toc}{\protect\thispagestyle{nofoot}}
  \pagestyle{nofoot}
  \etocsettocstyle{%
    \chapter*{Catalogue}%
  }{\relax}
  \etocsetlevel{chapter}{10}
  \etocsetlevel{section}{10}
  \etocsetlevel{subsection}{10}
  \etocsetlevel{ruchapter}{10}
  \etocsetlevel{rusection}{10}
  \etocsetlevel{rusubsection}{10}
  \etocsetlevel{enchapter}{0}
  \etocsetlevel{ensection}{1}
  \etocsetlevel{ensubsection}{2}
  \etocsetnexttocdepth{2}
  \tableofcontents
  % \pagestyle{smbumain}
}
% --- English TOC entry commands --------------------------------
% Write English entries to the .toc file with custom levels
\newcommand{\englishchaptertitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{enchapter}%
    {\protect\numberline{\thechapter}#1}{\thepage}{}}%
}
\newcommand{\englishunnumchaptertitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{enchapter}{#1}{\thepage}{}}%
}
\newcommand{\englishsectiontitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{ensection}%
    {\protect\numberline{\thesection}#1}{\thepage}{}}%
}
\newcommand{\englishsubsectiontitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{ensubsection}%
    {\protect\numberline{\thesubsection}#1}{\thepage}{}}%
}

% --- Russian TOC entry commands --------------------------------
% Write Russian entries to the .toc file with custom levels
\newcommand{\russianchaptertitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{ruchapter}%
    {\protect\numberline{\thechapter}#1}{\thepage}{}}%
}
\newcommand{\russianunnumchaptertitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{ruchapter}{#1}{\thepage}{}}%
}
\newcommand{\russiansectiontitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{rusection}%
    {\protect\numberline{\thesection}#1}{\thepage}{}}%
}
\newcommand{\russiansubsectiontitle}[1]{%
  \addtocontents{toc}{\protect\contentsline{rusubsection}%
    {\protect\numberline{\thesubsection}#1}{\thepage}{}}%
}

%%==============================================================
%%  Custom environments / commands
%%==============================================================
% --- Chinese abstract -----------------------------------------
\newenvironment{abstractZH}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{摘\hspace{2em}要}
  \addtocontents{toc}{\protect\contentsline{ruchapter}{Аннотация}{\thepage}{}}
  \chapter*{\zihao{-2}\heiti 摘\hspace{2em}要}
  \zihao{-4}\songti
}{%
  \par\vspace{1ex}
}

% \keywordsZH{a; b; c}
\newcommand{\keywordsZH}[1]{%
  \par\vspace{1.2em}
  \noindent{\zihao{-4}\heiti 【关键词】：}{\zihao{-4}\songti #1}\par
}

% --- Foreign abstract (English/Russian) -----------------------
\newenvironment{abstractEN}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \addtocontents{toc}{\protect\contentsline{ruchapter}{Оглавление}{\thepage}{}}
  \addtocontents{toc}{\protect\contentsline{enchapter}{Abstract}{\thepage}{}}
  \chapter*{\zihao{-2}\bfseries\rmfamily Abstract}
  \zihao{-4}\rmfamily
}{%
  \par\vspace{1ex}
}

\newcommand{\keywordsEN}[1]{%
  \par\vspace{1.2em}
  \noindent{\zihao{-4}\bfseries\rmfamily Key Words: }{\zihao{-4}\rmfamily #1}\par
}

\newenvironment{abstractRU}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Аннотация}
  \addtocontents{toc}{\protect\contentsline{ruchapter}{Оглавление}{\thepage}{}}
  \chapter*{\zihao{-2}\bfseries\rmfamily Аннотация}
  \zihao{-4}\rmfamily
}{%
  \par\vspace{1ex}
}

\newcommand{\keywordsRU}[1]{%
  \par\vspace{1.2em}
  \noindent{\zihao{-4}\bfseries\rmfamily 【Ключевые слова】: }{\zihao{-4}\rmfamily #1}\par
}

% --- Thesis title (shown before main body) --------------------
\newcommand{\smbu@title}{}
\newcommand{\smbutitle}[1]{\renewcommand{\smbu@title}{#1}}
\newcommand{\printtitle}{
  \clearpage
  \begin{center}
    \vspace*{0.3cm}
    {\zihao{-2}\heiti\bfseries \smbu@title}
  \end{center}
}

% --- Conclusion / Acknowledgments / Appendix as Level-1 -------
% Use \unnumchapter{标题} to get a chapter heading without number,
% still listed in the TOC as a Level-1 (bold) entry.
\newcommand{\unnumchapter}[1]{%
  \cleardoublepage
  \phantomsection
  \chapter*{\zihao{-2} #1}
  \addcontentsline{toc}{chapter}{#1}
}

% References: helper that prints the bibliography under a Level-1 heading
\newcommand{\printsmburefs}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{参考文献}
  \addtocontents{toc}{\protect\contentsline{ruchapter}{Список литературы}{\thepage}{}}
  \addtocontents{toc}{\protect\contentsline{enchapter}{Reference}{\thepage}{}}
  \begingroup
    \zihao{-4}
    \bibliographystyle{ieeetr}
    \bibliography{references}
  \endgroup
}

%%==============================================================
%%  In-text counters (figures/tables/equations)
%%   Sequential through entire document: 图 1, 图 2, ...
%%==============================================================
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}

%%==============================================================
%%  Misc
%%==============================================================
\sloppy                              % allow looser line breaks
\hyphenpenalty=500                   % allow hyphenation in EN/RU text
\tolerance=2000

\endinput
