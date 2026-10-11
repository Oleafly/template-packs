% CMU Statistics & Data Science thesis, building on memoir
% Alex Reinhart, 2023
% Based on work by Heidi Sestrich building on a template by Tony Saad.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cmustatthesis}[2023/04/13 cmustatthesis]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=statthesis,prefix=statthesis@}

\DeclareBoolOption{printing}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions
\ProcessKeyvalOptions{statthesis}

\ifstatthesis@printing
  % If printing to produce a bound copy, use twoside printing so chapters always
  % start on the right, and disable hyperref's colored links
  \PassOptionsToClass{twoside}{memoir}
  \PassOptionsToPackage{hidelinks}{hyperref}
\else
  % For screen use, omit the blank pages and keep colored links
  \PassOptionsToClass{oneside}{memoir}
\fi

\LoadClass[11pt]{memoir}

% Metadata about the department/thesis
\newcommand{\thedepartment}{Department of Statistics \& Data Science}
\newcommand{\dean}[1]{\def\thedean{#1}}

\def\theadvisors{}
\newcommand{\advisor}[1]{%
  \g@addto@macro\theadvisors{{#1},}
}
\def\thecommittee{}
\newcommand{\committee}[1]{%
  \g@addto@macro\thecommittee{{#1},}
}

% Math packages
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}

% define theorem, corollary, lemma, and definition environments
\theoremstyle{plain}
\newtheorem*{theorem*}{Theorem}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}

% Fonts
\RequirePackage[T1]{fontenc}

% Typesetting options
\RequirePackage{microtype}
\RequirePackage[hyphens,obeyspaces]{url}

\RequirePackage[pdfa,final]{hyperref}

\RequirePackage[final]{graphicx}
\graphicspath{ {figures/} } % specify the path where figures are located

% Fancypants logic
\RequirePackage{pgffor}

% Algorithms
\RequirePackage[chapter]{algorithm}
\RequirePackage[noend]{algpseudocode} % from algorithmicx

% Headings and chapters
\chapterstyle{dash}
\headstyles{memman}
\setsecnumdepth{subsection}
\maxtocdepth{subsection}

% Bibliography
\RequirePackage{natbib}
\bibliographystyle{apalike} % bibliography style - recommend using apalike-doi as it hyperlinks DOIs


% Headers and footers
\makeevenhead{ruled}{\scshape\MakeLowercase{\leftmark}}{}{}
\ifdraftdoc
  \newcommand{\draftmark}{{\sffamily Draft as of \today}}
  \makeevenfoot{ruled}{\thepage}{\draftmark}{}
  \makeoddfoot{ruled}{}{\draftmark}{\thepage}
\fi

% Abstract
\renewcommand{\abstracttextfont}{\normalfont}
\abstractnum
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}

% Captions
\captionnamefont{\sffamily\itshape}
\captiontitlefont{\sffamily}

% PDF metadata
\AtBeginDocument{%
  \hypersetup{%
    bookmarksnumbered=true,
    pdftitle={\thetitle},
    pdfauthor={\theauthor},
    pdfsubject={\thedepartment, Carnegie Mellon University}
  }
}

% Title page
% memoir's title layout uses hooks. Basically:
% Hook A
% Title
% Hook B
% Author
% Hook C
% Date
% Hook D
%
% We want:
% CMU (A)
% Title
% Dissertation submitted in... (B)
% Author
% Address, logo (C)
% Date
\renewcommand{\maketitlehooka}{%
  \begin{center}
    {\huge \textsc{Carnegie Mellon University}}
  \end{center}
}
\renewcommand{\maketitlehookb}{%
  \ifdraftdoc
    \begin{center}
      \draftmark
    \end{center}
  \fi
  \begin{center}
    A dissertation submitted in partial fulfillment\\
    of the requirements for the degree of
  \end{center}
  \vspace{1cm}
  \begin{center}
    Doctor of Philosophy\\
    in\\
    Statistics
  \end{center}
  \vspace{1cm}
  \begin{center}
    by
  \end{center}
}
\renewcommand{\maketitlehookc}{%
  \begin{center}
    \thedepartment \\
    Carnegie Mellon University \\
    5000 Forbes Ave \\
    Pittsburgh, PA 15213
  \end{center}
  \vspace{1cm}
  \begin{center}
    \includegraphics[width=3in,alt={Carnegie Mellon wordmark}]{cmu-wordmark-horizontal-r}
  \end{center}
}
% memoir automatically sets title pages to the title pagestyle, which includes a
% page number at the bottom. nuke it.
\aliaspagestyle{title}{empty}

%% Signature page commands
% If your signatures don't fit all on one page, try reducing \signatureheight so
% there's less space between signature lines
\newlength{\signatureheight}
\setlength{\signatureheight}{0.5in}

% We use geometry on the signature page to set its margin specially
\RequirePackage[pass]{geometry} % pass tells it not to mess with memoir's layout

\newcommand{\sigline}[1]{\noindent
\makebox[#1]{\hrulefill}\\}
\newcommand{\signature}[1]{%
  \vskip \signatureheight

  \noindent
  \begin{minipage}[t]{3in}
    \sigline{2.75in}
    \textsc{\MakeLowercase{#1}}
  \end{minipage}
}
\newcommand{\dateline}{%
  \begin{minipage}[t]{1in}
    \sigline{1in}
    \textsc{date}
  \end{minipage}
}

% Copyright page
\newcommand{\setlicense}[1]{\def\cmulicense{#1}}
\newcommand{\makecopyright} {
  \phantom{.}
  \vspace*{4in}
  \begin{center}
    \copyright\ \theauthor, \thedate \\
    \cmulicense
  \end{center}
  \thispagestyle{empty}
}

% Dedication page (optional)
\newcommand{\makededication}[1]{
  \phantom{.}
  \vspace*{2in}
  \begin{center}
    \textit{#1}
  \end{center}
  \thispagestyle{empty}
}

% Support large landscape tables
\RequirePackage{pdflscape}
\newenvironment{landscapepage}[1][1in]{%
  \newgeometry{margin=#1}%
  \begin{landscape}}{%
  \end{landscape}%
  \aftergroup\restoregeometry}
