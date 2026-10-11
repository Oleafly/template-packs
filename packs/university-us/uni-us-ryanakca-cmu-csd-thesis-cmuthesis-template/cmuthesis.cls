%% dkoes 5/10/2006
%% rak   2021

\LoadClassWithOptions{amsbook}

% pass tells geometry not to mess with amsbook's defaults,
% but instead to use them as the default.
\PassOptionsToPackage{pass}{geometry}
\RequirePackage{geometry}

%% dkoes - Here's a bunch of stuff taken from mjz-titlepage.sty that makes
% a pretty CMU techreport acceptable title page

%% rak - Updated in 2020 to use the amsbook class and to simplify some of
% the LaTeX code.

%% titlepage parameters
%%   required: title, author, date, Year, trnumber, committee
%%   optional: permission, support, disclaimer, keywords, subtitle

\def\title#1{\gdef\@title{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\author#1{\gdef\@author{#1}}
\def\date#1{\gdef\@date{#1}}
\def\Year#1{\gdef\@Year{#1}}
\def\trnumber#1{\gdef\@trnumber{#1}}
\def\committee#1{\gdef\@committee{#1}}
\def\permission#1{\gdef\@permission{#1}}
\def\support#1{\gdef\@support{#1}}
\def\disclaimer#1{\gdef\@disclaimer{#1}}
\def\keywords#1{\gdef\@keywords{#1}}

\newsavebox{\@copyrightbox}
%\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifthenelse{\lengthtest{\wd\@copyrightbox > \linewidth}}{\noindent #1 \par}{\begin{center} #1 \end{center}}}}
\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifdim\wd\@copyrightbox>\linewidth \noindent #1 \par\else\begin{center} #1 \end{center}\fi}}

% The 2020 classification is online, but amsbook hasn't been updated
% yet to include it.
\@ifundefined{subjclassname@2020}{%
  \@namedef{subjclassname@2020}{%
  \textup{2020} Mathematics Subject Classification}%
}

% stolen from amsart.cls
\let\@concepts\@empty
\newcounter{@concepts}
\newcommand\ccsdesc[2][100]{%
  \ccsdesc@parse#1~#2~~\ccsdesc@parse@end}
\def\textrightarrow{$\rightarrow$}
\def\ccsdesc@parse#1~#2~#3~{%
  \stepcounter{@concepts}%
  \expandafter\ifx\csname CCS@General@#2\endcsname\relax
  \expandafter\gdef\csname CCS@General@#2\endcsname{
    \textrm{#2}}%
  \expandafter\gdef\csname CCS@Punctuation@#2\endcsname{; }%
  \expandafter\gdef\csname CCS@Specific@#2\endcsname{}%
  \g@addto@macro{\@concepts}{\csname CCS@General@#2\endcsname
    \csname CCS@Punctuation@#2\endcsname
    \csname CCS@Specific@#2\endcsname}%
  \fi
  \ifx#3\relax\relax\else
  \expandafter\gdef\csname CCS@Punctuation@#2\endcsname{
    \textrightarrow\ }%
  \expandafter\g@addto@macro\expandafter{\csname CCS@Specific@#2\endcsname}{%
    \addtocounter{@concepts}{-1}%
    \textit{#3}%
    \ifnum\value{@concepts}=0.\else; \fi}%
  \fi
  \ccsdesc@parse@finish}
\def\ccsdesc@parse@finish#1\ccsdesc@parse@end{}

\def\@maketitle{
\thispagestyle{empty}

%% Centered things on the title page must be *physically* centered
%% on the page, so they line up with the cut-out window. So we hardwire
%% the margins for the title page so that left margin = right margin.
\newgeometry{hmargin={0cm, 0cm}}

% calculate skip needed to ensure that title appears in the cut-out
\newlength{\@cutoutvskip}
\setlength{\@cutoutvskip}{2.1875 true in}       % position of cut-out
\addtolength{\@cutoutvskip}{-1 true in}         % printer margin
\addtolength{\@cutoutvskip}{-\topmargin}
\addtolength{\@cutoutvskip}{-\headheight}
\addtolength{\@cutoutvskip}{-\headsep}

\let\footnoterule\relax
\vglue\@cutoutvskip
\begin{center}
%\begin{minipage}[t]{4.875in}   % must be a minipage due to \thanks
\begin{minipage}[t]{4.8in}      % hackery
\vbox to 2in{
\vfill
\begin{center}
{\Large \strut \@title\par}
\@ifundefined{@subtitle}{}{\large \strut \@subtitle\par}
\vfill
{\large \begin{tabular}[t]{c}\@author\end{tabular}\par}
\vfill
{\sc \@trnumber\par}
\smallskip
{\large \@date\par}
\end{center}
\vfill}
\end{minipage}
\end{center}

\vskip 3em

\begin{center}
    Computer Science Department\\
    School of Computer Science \\
    Carnegie Mellon University \\
    Pittsburgh, PA 15213
\end{center}
\vskip 1em
\begin{center}
    {\bf Thesis Committee:} \\
    \@committee
\end{center}
\vspace{1em}
\begin{center}
    \em
    Submitted in partial fulfillment of the requirements \\
    for the degree of Doctor of Philosophy.
\end{center}


\vfill

\@ifundefined{@permission}{\@copyrightnotice{Copyright \copyright\ \@Year\ \@author}}{\@copyrightnotice{Copyright \copyright\ \@Year\ \@author. \@permission}}

\@ifundefined{@support}{}{{\medskip\footnotesize\begin{center}\noindent\parbox{5in}{\@support}\end{center}\par}}

\@ifundefined{@disclaimer}{}{{\medskip\footnotesize\begin{center}\noindent\parbox{5in}{\@disclaimer}\end{center}\par}}

% keywords go at bottom of page ii (the rear of the titlepage)
% if keywords are omitted, this page is blank

% abstract goes at top of page iii

% amsbook default textwidth / textheight is 30pc / 50.5pc (p. 10
% of amsclass manual). To save Catherine paper (and to allow us
% slightly wider inference rule displays), we increase the width
% by two pica and scale the height accordingly.
% Then call \calclayout to have AMS recalculate whatever it needs
% to recalculate (p. 80 of manual).
% positioning of subjclass, keywords, and abstract based on p.61
% of manual.
\restoregeometry\thispagestyle{empty}
%\newgeometry{textwidth=32pc,textheight=53.9pc}\thispagestyle{empty}
\calclayout
\vspace*{\fill}
\begin{center}
  \ifx\@empty\@subjclass\else\@setsubjclass\fi
  \ifx\@concepts\@empty\else\bgroup
  {\textit{CCS Concepts}.%
    \noindent\@concepts\par}\egroup
  \fi
  \ifx\@empty\@keywords\else\@setkeywords\fi
\end{center}
\clearpage
\@setabstract
}

\newenvironment{dedication}
  {\cleardoublepage \thispagestyle{empty} \vspace*{\stretch{1}} \begin{center} \em}
  {\end{center} \vspace*{\stretch{3}} \clearpage}


\newenvironment{psuedochapter}[1]
{\cleardoublepage
  \thispagestyle{empty}
  \vspace*{\stretch{1}}
  \begin{center} \large {\bf #1} \end{center}
  \vspace{\medskipamount}
  \begin{quotation}}
  {\end{quotation}
  \vspace*{\stretch{3}}
  \clearpage}

\newenvironment{acknowledgments}
{\begin{psuedochapter}{Acknowledgments}}
  {\end{psuedochapter}}


\setlength{\textwidth}{32pc}
\setlength{\textheight}{53.9pc}
\calclayout

\renewcommand{\thesection}{\thechapter.\arabic{section}}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}