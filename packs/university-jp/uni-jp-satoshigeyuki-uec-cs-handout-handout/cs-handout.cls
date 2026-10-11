\NeedsTeXFormat{pLaTeX2e}
\ProvidesPackage{cs-handout}[2026-03-28 SATO Shigeyuki]
\RequirePackage{ifthen}
\RequirePackage{ifuptex}
\ifthenelse{\boolean{nativeuptex}}{}{
  \ClassError{cs-handout}{upLaTeX is required}{}%
}

\LoadClass[head_space=20truemm,foot_space=15truemm,gutter=3zw,line_length=26zw,twocolumn,article,uplatex,dvipdfmx]{jlreq}

\RenewBlockHeading{section}{1}{%
  font={\normalfont\large\bfseries},
  before_space=\bigskipamount,
  after_space=\medskipamount
}

% フォント関連
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[uplatex,jis2004]{otf}

% ヘッダ・フッタ
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\cfoot{}

\makeatletter

\newcommand*{\@studentid}[1]{\ClassError{cs-handout}{No \noexpand \studentid given}{}}
\newcommand*{\@office}[1]{\ClassError{cs-handout}{No \noexpand \office given}{}}

\newcommand*{\studentid}[1]{\def\@studentid{#1}}
\newcommand*{\office}[1]{\def\@office{#1}}
\newcommand*{\presentationdate}[3]{%
  \year #1 \month #2 \day #3
  \setacademicyear
  \rhead{\the\year/\the\month/\the\day}
}
\newcounter{academicyear}
\newcommand{\setacademicyear}{%
  \setcounter{academicyear}{\the\year}
  \ifnum \the\month < 4
    \addtocounter{academicyear}{-1}
  \fi
}
\setacademicyear

\renewcommand{\@maketitle}{%
  \begin{center}
    {\LARGE \@title}
    \vspace{5mm}\par
    {\large \@studentid\quad\@author\qquad\@office\\}
    \vspace{5mm}
  \end{center}
}

%%====Adapted from jlreq.cls====
\renewcommand{\maketitle}{
  \par
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \renewcommand{\@makefnmark}{\hbox{%
      \jlreq@iftdir{\yoko}{}%
      \rlap{\@textsuperscript{\normalfont\@thefnmark}}%
    }}%
    \renewcommand{\jlreq@referencemark@format}[1]{\@makefnmark}%
    \ifnum\col@number=\@ne
      \@maketitle
    \else
      \twocolumn[\@maketitle]%
    \fi
    %% \maketitle があってもヘッダを表示する
    \@thanks
  \endgroup
  \jlreq@endofmaketitle
}

\renewenvironment{thebibliography}[1]{%
  \jlreq@oldfontcommand@enable
  \section*{\refname}%
  \footnotesize %% [MOD]
  \@mkboth{\refname}{\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
      {\settowidth\labelwidth{\@biblabel{#1}}%
      \labelsep=1\jlreq@zw
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \itemindent=0pt
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty~`thebibliography'~environment}}%
  \endlist
  \jlreq@oldfontcommand@disable
}
%%====Adapted from jlreq.cls end====

\makeatother
