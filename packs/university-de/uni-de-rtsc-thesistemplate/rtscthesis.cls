\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rtscthesis}[2025/05/01 rtscthesis]

% --------------------------------------------------------------
% we are modifying the memoir base class
% --------------------------------------------------------------
\DeclareOption{paper}{%
 \PassOptionsToClass{article}{memoir}%
 \AtEndOfClass{\renewcommand\thesection{\arabic{section}}
  \renewcommand\sectiondot{.}
  \renewcommand\thesubsection{\thesection.\arabic{subsection}}
  \let\paper\@paper }
}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}%
\ProcessOptions
\LoadClass{memoir}
\setsecnumdepth{subsection}
\settocdepth{subsection}

% --------------------------------------------------------------
% own commands
% --------------------------------------------------------------
\newcommand{\sidenote}[1]{\marginpar[\footnotesize #1]{\footnotesize #1}}
\newcommand{\subtitle}[1]{\newcommand{\thesubtitle}{#1}}
\newcommand{\university}[1]{\newcommand{\theuniversity}{#1}}
\newcommand{\graduationsemester}[1]{\newcommand{\thegraduationsemester}{#1}}
\newcommand{\graduationyear}[1]{\newcommand{\thegraduationyear}{#1}}
\newcommand{\firstreviewer}[1]{\newcommand{\thefirstreviewer}{#1}}
\newcommand{\secondreviewer}[1]{\newcommand{\thesecondreviewer}{#1}}

% --------------------------------------------------------------
% required packages
% --------------------------------------------------------------
\RequirePackage{xcolor, graphicx}
\RequirePackage{amsmath, amsfonts, amssymb}
\RequirePackage{tikz, pgfplots}
\RequirePackage[largesc]{newpxtext} % font
\RequirePackage{xspace}
\RequirePackage{textcomp}
\RequirePackage[colorlinks, linkcolor=blue]{hyperref}
\RequirePackage{setspace}
\RequirePackage{listings}
\RequirePackage[nameinlink]{cleveref}

% --------------------------------------------------------------
% spaces
% --------------------------------------------------------------
\parskip=1mm plus 1mm minus 1mm\relax
\parindent=0pt\relax
\setlength{\textfloatsep}{10pt plus 2pt minus 2pt}
\frenchspacing\tolerance=1000\emergencystretch=1em
\setlength{\@fptop}{5pt}

% --------------------------------------------------------------
% color definitions
% --------------------------------------------------------------
\definecolor{TolBlue}   {HTML}{0077BB}
\definecolor{TolCyan}   {HTML}{33BBEE}
\definecolor{TolTeal}   {HTML}{009988}
\definecolor{TolOrange} {HTML}{EE7733}
\definecolor{TolRed}    {HTML}{CC3311}
\definecolor{TolMagenta}{HTML}{EE3377}
\definecolor{TolGrey}   {HTML}{BBBBBB}

\colorlet{blue}   {TolBlue}
\colorlet{green}  {TolTeal}
\colorlet{red}    {TolRed}
\colorlet{orange} {TolOrange}
\colorlet{grey}   {TolGrey}
\colorlet{magenta}{TolMagenta}
\colorlet{cyan}   {TolCyan}

% --------------------------------------------------------------
% paper size
% --------------------------------------------------------------
\settrimmedsize{220mm}{155mm}{*}
\setstocksize{220mm}{155mm}
\setlength{\trimtop}{30mm}
\setlength{\trimtop}{\stockheight}
\addtolength{\trimtop}{-\paperheight}
\setlength{\trimtop}{0.5\trimtop}
\setlength{\trimedge}{\stockwidth}
\addtolength{\trimedge}{-\paperwidth}
\setlength{\trimedge}{0.5\trimedge}
\trimFrame
\textheight=178mm%
\textwidth=117mm%
\setlrmargins{*}{*}{1.0}
\setulmargins{14mm}{*}{*}
\headheight=35pt\headsep=15pt\uppermargin=50pt
\checkandfixthelayout

% if you want to see how the borders look like, add the option "showframe"
\RequirePackage[top=2cm, bottom=2cm, right=3.5cm, left=2cm,
  marginparwidth=2.5cm, marginparsep=0.5cm]{geometry}

% --------------------------------------------------------------
% headers and footers
% --------------------------------------------------------------
\makepagestyle{thesis}
\makeevenhead{thesis}{\normalfont\itshape\leftmark}{}{}
\makeoddhead{thesis}{}{}{\normalfont\itshape\rightmark}
\makeoddfoot{thesis}{}{}{\normalfont\thepage}
\makeevenfoot{thesis}{\normalfont\thepage}{}{}
\copypagestyle{chapter}{thesis}
\makeevenhead{chapter}{}{}{}
\makeoddhead{chapter}{}{}{}
\pagestyle{thesis}

% --------------------------------------------------------------
% part style
% --------------------------------------------------------------
\let \origPart=\part
\renewcommand*{\part}{\@openrighttrue\origPart}
\let\origPartpageend=\partpageend
\renewcommand*{\partpageend}{{\origPartpageend\@openrightfalse}}
\renewcommand*{\cftpartname}{Part~}
\aliaspagestyle{part}{empty}

% --------------------------------------------------------------
% chapter style
% --------------------------------------------------------------
\makechapterstyle{rtscthesis}{
 \setlength{\beforechapskip}{0mm}
 \setlength{\afterchapskip}{10mm plus 2mm minus 2mm}
 \renewcommand\printchaptername{}
 \renewcommand\afterchapternum{\par\nobreak\vskip\midchapskip}
 \renewcommand\chapnumfont{\HUGE}
 \renewcommand\chaptitlefont{\HUGE}
 \renewcommand\printchapternum{\hrule height0pt\relax \chapnumfont\leftline{\thechapter}}
 \renewcommand\printchapternonum{
   \setbox0=\hbox{\chapnumfont 3}\hrule height 0pt
     \leftline{\vrule height \ht0 width 0pt}\vskip\midchapskip}%
   \def\@chap@mark##1{\ifnum \c@secnumdepth >\m@ne
     \if@mainmatter \@chapapp \ \thechapter . \ \fi \fi ##1}
   \def\chaptermark##1{\markboth{\@chap@mark{##1}}{\@chap@mark{##1}}}
}
\chapterstyle{rtscthesis}
\openright % Will be reset by the \tableofcontents command

% --------------------------------------------------------------
% section style
% --------------------------------------------------------------
\setbeforesecskip{-10mm plus 2mm minus 2mm}
\setsecheadstyle{\bfseries\Large\raggedright}
\setaftersecskip{2mm}
\def\sectionmark#1{\markright{\ifnum \c@secnumdepth > \z@ \thesection \quad\fi #1}}

% --------------------------------------------------------------
% subsection style
% --------------------------------------------------------------
\setbeforesecskip{-10mm plus 2mm minus 2mm}
\setsubsecheadstyle{\bfseries\large\raggedright}
\setaftersecskip{1mm}

% --------------------------------------------------------------
% subsubsection style
% --------------------------------------------------------------
\setbeforesecskip{-10mm plus 2mm minus 2mm}
\setaftersubsubsecskip{-1mm}
\newcommand{\subsubsecdot}[1]{\normalsize\bfseries\itshape #1.}
\setsubsubsecheadstyle{\subsubsecdot}

% --------------------------------------------------------------
% numbering style
% --------------------------------------------------------------
\setsecnumformat{\csname the#1\endcsname\csname #1dot\endcsname\quad}
\newcommand\sectiondot{}
\newcommand\subsectiondot{}
\newcommand\subsubsectiondot{}
\newcommand\captiondot{}

% --------------------------------------------------------------
% captions style
% --------------------------------------------------------------
\captiondelim{\captiondot\quad}
\captionnamefont{\small\bfseries}
\captiontitlefont{\small}
\captionstyle[\centering]{}
\AtBeginDocument{%
  \dimen0=\textwidth\advance\dimen0 -2\parindent
  \captionwidth{\dimen0}\changecaptionwidth
}
% The command \@minipagerestore is called at the start
% of every minipage. It is intended to set any necessary
% internal parameters. In this case we need to reset the 
% captionwidth. See 'texdoc source2e', section ltboxes.
\renewcommand\@minipagerestore{\normalcaptionwidth}
  
% --------------------------------------------------------------
% footnotes style
% --------------------------------------------------------------
\footmarkwidth=1.2em\footmarksep=0pt
\footmarkstyle{\textsuperscript{#1}\hskip1pt\relax}

% --------------------------------------------------------------
% title page style
% --------------------------------------------------------------
\renewcommand*{\maketitle}{%
\newgeometry{margin=2cm}
\thispagestyle{empty}
\begin{titlingpage}

\raggedleft
	
\rule{1pt}{\textheight}
\hspace{0.05\textwidth}
\parbox[b]{0.75\textwidth}{

{\Huge \bfseries \textcolor{blue}{\thetitle}}\\[1\baselineskip]
{\large\textit{\textcolor{blue}{\thesubtitle}}}\\[3\baselineskip]
{\Large\textsc{\theauthor}}

\vspace{0.45\textheight}

\noindent 
  {\textbf{First Reviewer:} \thefirstreviewer}\\
  {\textbf{Second Reviewer:} \thesecondreviewer}\\[2\baselineskip]
  \includegraphics[width=1.5cm]{preamble/uds.pdf}\\
  {\theuniversity, \thegraduationsemester\xspace\thegraduationyear}\\
}
\end{titlingpage}

\frontmatter
\tableofcontents

\restoregeometry
\mainmatter
}

% --------------------------------------------------------------
% listings style
% --------------------------------------------------------------
\makeatletter
\newcommand\BeraMonottfamily{%
  \def\fvm@Scale{0.85}% scales the font down
  \fontfamily{fvm}\selectfont% selects the Bera Mono font
}
\makeatother

\lstset{
  basicstyle=\ttfamily\BeraMonottfamily, 
  frame            = single,
  captionpos       = b,
  keywordstyle     = \bfseries\color{blue},
  stringstyle      = \color{red},
  commentstyle     = \color{green},
  showstringspaces = false,
  numberstyle      = \tiny\color{gray},
  numbers          = left,
  numbersep        = 5pt,
}