%% uofm.cls
%% University of Memphis dissertation/thesis LaTeX class
%% Legacy CERI/department-approved visual formatting, modernized for LuaLaTeX,
%% Overleaf, and accessibility-oriented PDF workflows.
%%
%% Compiled and developed by Navin Thapa.
%% Updated against the public University of Memphis Graduate School
%% Thesis/Dissertation Preparation Guide, last revised October 2025.
%%
%% CERI-modified community template. NOT an official University of Memphis,
%% Graduate School, or CERI template. Use at your own risk; final formatting,
%% accessibility, and submission approval remain the responsibility of the user.
%%
%% Copyright (c) 2026 Navin Thapa.
%% SPDX-License-Identifier: LPPL-1.3c
%%
%% The bundled uomagu.bst file retains its original LPPL/custom-bib notice
%% and copyright attribution to Patrick W. Daly and the custom-bib project.
%%
%% Recommended compiler: LuaLaTeX, TeX Live 2025 or Rolling on Overleaf.

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{uofm}[2026/06/26 v2.12 TOC hyperlinks with conservative spacing]

% -----------------------------------------------------------------------------
% Options compatible with the older class
% -----------------------------------------------------------------------------
\newcommand\@uofm@fontsize{12pt}
\newif\if@master
\newif\if@proposal
\newif\if@showabstract
\newif\if@secnum
\newif\if@nohyphen
\newif\if@boundcopy
\newif\if@boundcover

\DeclareOption{10pt}{\renewcommand\@uofm@fontsize{10pt}}
\DeclareOption{11pt}{\renewcommand\@uofm@fontsize{11pt}}
\DeclareOption{12pt}{\renewcommand\@uofm@fontsize{12pt}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{secnum}{\@secnumtrue}
\DeclareOption{nosecnum}{\@secnumfalse}
\DeclareOption{hyphenation}{\@nohyphenfalse}
\DeclareOption{nohyphenation}{\@nohyphentrue}
\DeclareOption{master}{\@mastertrue}
\DeclareOption{doctoral}{\@masterfalse}
\DeclareOption{proposal}{\@proposaltrue}
\DeclareOption{showabstract}{\@showabstracttrue}
\DeclareOption{hideabstract}{\@showabstractfalse}
\DeclareOption{fulldocument}{\@proposalfalse}
\DeclareOption{boundcopy}{\@boundcopytrue}
\DeclareOption{pdfonly}{\@boundcopyfalse}
\DeclareOption{boundcover}{\@boundcovertrue}
\DeclareOption{noboundcover}{\@boundcoverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% Default follows the old department-approved class. Use nosecnum if your final
% Graduate School review asks you to remove numbered section headings.
\ExecuteOptions{12pt,final,master,fulldocument,hideabstract,secnum,nohyphenation,pdfonly,boundcover}
\ProcessOptions\relax

\LoadClass[\@uofm@fontsize,oneside,letterpaper]{report}

% -----------------------------------------------------------------------------
% Packages
% -----------------------------------------------------------------------------
\RequirePackage{iftex}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{ragged2e}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{pdflscape}
\RequirePackage{etoolbox}
\RequirePackage{natbib}
% Do not load caption/subcaption by default. The legacy format is handled by
% a simple \@makecaption below. This reduces Acrobat Lbl/LBody warnings that
% can be triggered by caption package tagging in some tagged-PDF workflows.
\RequirePackage[unicode,hidelinks,linktoc=all]{hyperref}
\RequirePackage{bookmark}

% If tagging is not enabled, keep table-header examples compilable.
\providecommand{\tagpdfsetup}[1]{}
% The sample main.tex intentionally does not enable the experimental math
% tagging testphase, because some current LuaLaTeX/tagged-PDF builds can
% visually distort complex math. Normal LaTeX equations remain available.

\makeatletter

% -----------------------------------------------------------------------------
% Fonts: Times-compatible and accessible
% -----------------------------------------------------------------------------
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
\fi
% Math/font setup.
% LuaLaTeX uses fontspec + unicode-math to avoid visual distortions that can
% occur when legacy Type 1 math fonts are combined with tagged-PDF workflows.
% pdfLaTeX falls back to the Times-compatible newtx stack.
% Do not also load newtxmath, fontspec, or unicode-math in main.tex.
\ifLuaTeX
  \RequirePackage{fontspec}
  \RequirePackage{unicode-math}
  % Use TeX Gyre Termes X by file name because some TeX installations do not
  % expose a stable system font family name for this bundled Times-like font.
  \setmainfont{TeXGyreTermesX-Regular.otf}[
    BoldFont       = TeXGyreTermesX-Bold.otf,
    ItalicFont     = TeXGyreTermesX-Italic.otf,
    BoldItalicFont = TeXGyreTermesX-BoldItalic.otf
  ]
  \IfFontExistsTF{TeX Gyre Heros}{\setsansfont{TeX Gyre Heros}}{}
  \IfFontExistsTF{TeX Gyre Cursor}{\setmonofont{TeX Gyre Cursor}}{}
  % STIX Two Math is a robust OpenType math font available in TeX Live/Overleaf.
  % It avoids the visual equation distortions seen with legacy Type 1 math fonts.
  \setmathfont{STIXTwoMath-Regular.otf}
  % The main document should not enable the experimental `math` tagging
  % testphase. With math testphase omitted, MathML/luamml is not activated,
  % which keeps visual math stable in current Overleaf/TeX Live builds.
\else
  \RequirePackage{amssymb}
  \RequirePackage{newtxtext,newtxmath}
\fi


% Backward-compatible helper for uncertainty values. Normal inline math such as
% \(1.2 \pm 0.1\) is supported in captions and body text; this helper is
% retained only for users who prefer text-mode uncertainty notation.
\DeclareRobustCommand{\uomuncert}[2]{%
  \ifmmode #1\,\pm\,#2\else #1\,\textpm\,#2\fi%
}


% -----------------------------------------------------------------------------
% User metadata commands from the old class
% -----------------------------------------------------------------------------
\def\degree#1{\def\@degree{#1}}
\def\major#1{\def\@major{#1}}
\def\advisor#1{\def\@advisor{#1}}
\def\@degree{Doctor of Philosophy}
\def\@major{Geophysics}
\def\@advisor{}

% -----------------------------------------------------------------------------
% Page layout: old class geometry expressed with modern geometry package
% Standard electronic PDF: 1-inch margins. Bound copy: 1.5-inch left margin.
% Page numbers are centered at bottom, approximately 1/2 inch from bottom.
% -----------------------------------------------------------------------------
\if@boundcopy
  \geometry{letterpaper,top=1in,bottom=1in,left=1.5in,right=1in,footskip=0.51in,headheight=0pt,headsep=0pt}
\else
  \geometry{letterpaper,top=1in,bottom=1in,left=1in,right=1in,footskip=0.51in,headheight=0pt,headsep=0pt}
\fi

\setlength\parindent{0.5in}
\setlength\parskip{0pt}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\raggedbottom
\onecolumn

% UofM requires left-aligned text with jagged right margin.
\AtBeginDocument{%
  \RaggedRight\doublespacing%
  \setlength{\parindent}{0.5in}%
  \setlength{\parskip}{0pt}%
  \setlength{\RaggedRightParindent}{\parindent}%
  % Keep floats in the normal manuscript flow without adding large
  % journal-style white space. These values are intentionally smaller than a
  % full double-spaced line because the surrounding body text is already
  % double-spaced.
  \setlength{\textfloatsep}{0.45\baselineskip}%
  \setlength{\floatsep}{0.45\baselineskip}%
  \setlength{\intextsep}{0.45\baselineskip}%
  \setlength{\dbltextfloatsep}{0.45\baselineskip}%
  \setlength{\dblfloatsep}{0.45\baselineskip}%
}
\setlength{\RaggedRightParindent}{\parindent}
\sloppy

% Prevent hyphenation if requested.
\if@nohyphen
  \RequirePackage[none]{hyphenat}
\else
  \RequirePackage{hyphenat}
  \hyphenpenalty=500
\fi

% -----------------------------------------------------------------------------
% Page numbers: no running headers, centered bottom numbers only
% -----------------------------------------------------------------------------
\pagestyle{plain}
\pagenumbering{arabic}
\makeatletter
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \def\@oddfoot{\hfil\thepage\hfil}%
  \let\@evenfoot\@oddfoot}
% @ remains a letter for class internals.


% -----------------------------------------------------------------------------
% Tagged-PDF compatibility helpers.
% The legacy UofM class manually formats the Table of Contents and generated
% lists. Current LaTeX PDF tagging can produce TOCI/MC warnings for these custom
% lists. These wrappers let the class suspend tagging locally for those generated
% lists while keeping the visible Graduate School/department-approved formatting.
% -----------------------------------------------------------------------------
\ExplSyntaxOn
\cs_new_protected:Npn \uofm_tagsuspend:n #1
  { \cs_if_exist:NT \tag_suspend:n { \tag_suspend:n {#1} } }
\cs_new_protected:Npn \uofm_tagresume:n #1
  { \cs_if_exist:NT \tag_resume:n { \tag_resume:n {#1} } }
\cs_new_eq:NN \uofmTagSuspend \uofm_tagsuspend:n
\cs_new_eq:NN \uofmTagResume \uofm_tagresume:n
\ExplSyntaxOff

% -----------------------------------------------------------------------------
% ADA navigation: PDF bookmarks for pages that are not in TOC
% -----------------------------------------------------------------------------
\newcommand\@uofm@navbookmark[2]{%
  \@ifundefined{pdfbookmark}{}{\pdfbookmark[0]{#1}{#2}}%
}

% -----------------------------------------------------------------------------
% Preliminary and main matter commands, old interface
% -----------------------------------------------------------------------------
\newcommand{\frontmatter}{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{2}%
  \pagestyle{plain}%
  \RaggedRight\doublespacing%
}

\newcommand{\mainmatter}{%
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \pagestyle{plain}%
  \RaggedRight\doublespacing%
}

% -----------------------------------------------------------------------------
% Title page: old department-approved visual layout
% -----------------------------------------------------------------------------
\renewcommand\maketitle{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{1}%
  \singlespacing%
  \begin{titlepage}%
    \@uofm@navbookmark{Title Page}{uofm-titlepage}%
    \thispagestyle{empty}%
    \vspace*{0.85in}%
    \setlength{\parindent}{0mm}%
    \begin{minipage}{6.5in}%
      \if@boundcopy\else
        \if@boundcover\hspace*{0.5in}\fi
      \fi
      \begin{minipage}{%
        \if@boundcopy 6.0in\else\if@boundcover 6.0in\else 6.5in\fi\fi}%
        \begin{center}%
          {\normalsize\MakeUppercase{\@title}\par}%
          \vspace*{13.2pt}%
          {\normalsize by\par}%
          \vspace*{13.2pt}%
          {\normalsize\@author\par}%
        \end{center}%
      \end{minipage}\par%
    \end{minipage}\par
    \vfill
    \begin{minipage}{6.5in}%
      \if@boundcopy\else
        \if@boundcover\hspace*{0.5in}\fi
      \fi
      \begin{minipage}{%
        \if@boundcopy 6.0in\else\if@boundcover 6.0in\else 6.5in\fi\fi}%
        \begin{center}%
          \if@master
            \if@proposal {\normalsize A Thesis Proposal\par}\else {\normalsize A Thesis\par}\fi
            \vspace*{13.2pt}%
          \else
            \if@proposal {\normalsize A Dissertation Proposal\par}\else {\normalsize A Dissertation\par}\fi
            \vspace*{13.2pt}%
          \fi
          \if@proposal
            {\normalsize Submitted for the Committee's Review\par}%
            \vspace*{0.5in}%
            {\normalsize Academic Advisor:\par}%
            \vspace*{13.2pt}%
            {\normalsize\@advisor\par}%
            \vspace*{0.5in}%
            {\normalsize Major: \@major\par}%
          \else
            {\normalsize Submitted in Partial Fulfillment of the\par}%
            \vspace*{13.2pt}%
            {\normalsize Requirements for the Degree of\par}%
            \vspace*{13.2pt}%
            {\normalsize\@degree\par}%
            \vspace*{0.5in}%
            {\normalsize Major: \@major\par}%
          \fi
        \end{center}%
      \end{minipage}\par%
    \end{minipage}\par
    \vfill
    \begin{minipage}{6.5in}%
      \if@boundcopy\else
        \if@boundcover\hspace*{0.5in}\fi
      \fi
      \begin{minipage}{%
        \if@boundcopy 6.0in\else\if@boundcover 6.0in\else 6.5in\fi\fi}%
        \begin{center}%
          {\normalsize The University of Memphis\par}%
          \vspace*{13.2pt}%
          {\normalsize\@date\par}%
        \end{center}%
      \end{minipage}%
    \end{minipage}%
    \vspace*{1.0in}%
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax%
  \doublespacing%
  \setcounter{page}{2}%
}

% -----------------------------------------------------------------------------
% Chapter and heading style from old class
% -----------------------------------------------------------------------------
\renewcommand*\chaptermark[1]{}
\if@secnum
  \setcounter{secnumdepth}{3}
\else
  \setcounter{secnumdepth}{0}
\fi
\setcounter{tocdepth}{2}

\renewcommand\chapter{%
  \clearpage%
  \thispagestyle{plain}%
  \global\@topnum\z@%
  \@afterindenttrue%
  \secdef\@chapter\@schapter%
}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne%
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{0\p@}}%
  \addtocontents{lot}{\protect\addvspace{0\p@}}%
  \@makechapterhead{#2}%
  \@afterheading%
}

\def\@makechapterhead#1{%
  {\centering{%
    \ifnum \c@secnumdepth >\m@ne%
      \normalfont\normalsize\bfseries \@chapapp\space\thechapter\par\nobreak
    \fi%
    \interlinepenalty\@M
    \normalsize\bfseries #1\par\nobreak
    \vskip 12\p@}
  \par}}

\def\@schapter#1{\@makeschapterhead{#1}\@afterheading}
\def\@makeschapterhead#1{%
  {\centering{\normalsize\bfseries #1\par\nobreak\vskip 12\p@}\par}}

\def\@seccntformat#1{\csname the#1\endcsname\quad}
% Graduate School spacing compliance: headings remain in the normal
% double-spaced manuscript flow.  Use the same controlled vertical space before
% and after section/subsection headings, and keep paragraph indentation after
% headings.
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {.35\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip}%
  {\normalfont\normalsize\bfseries}}

% -----------------------------------------------------------------------------
% Preliminary page environments from the old class
% -----------------------------------------------------------------------------
\newenvironment{prelimpage}{%
  \pagestyle{plain}%
  \RaggedRight\doublespacing%
  \setlength{\parindent}{0.5in}%
  \setlength{\parskip}{0pt}%
}{\clearpage\pagestyle{plain}}

\newcommand\copyrightpage{%
  \if@proposal\else
    \begin{prelimpage}
      \@uofm@navbookmark{Copyright}{uofm-copyright}%
      \singlespacing
      \topskip0pt
      \vspace*{\fill}
      \begin{center}{\normalsize
        Copyright\copyright~\@author\par
        All rights reserved}
      \end{center}
      \vspace*{\fill}
      \doublespacing
    \end{prelimpage}
  \fi
}

\newenvironment{dedication}{%
  \if@proposal\setbox\z@\vbox\bgroup\else
    \begin{prelimpage}
    \@uofm@navbookmark{Dedication}{uofm-dedication}%
    \@makeschapterhead{Dedication}\par\doublespacing
  \fi}{%
  \if@proposal\egroup\else\end{prelimpage}\fi}

\newenvironment{acknowledgments}{%
  \if@proposal\setbox\z@\vbox\bgroup\else
    \begin{prelimpage}
    \@uofm@navbookmark{Acknowledgments}{uofm-acknowledgments}%
    \@makeschapterhead{Acknowledgments}\par\doublespacing
  \fi}{%
  \if@proposal\egroup\else\end{prelimpage}\fi}

\newenvironment{preface}{%
  \if@proposal\setbox\z@\vbox\bgroup\else
    \begin{prelimpage}
    \@uofm@navbookmark{Preface}{uofm-preface}%
    \@makeschapterhead{Preface}\par\doublespacing
  \fi}{%
  \if@proposal\egroup\else\end{prelimpage}\fi}

\renewenvironment{abstract}{%
  \if@proposal
    \if@showabstract
      \begin{prelimpage}\@uofm@navbookmark{Abstract}{uofm-abstract}%
      \@makeschapterhead{Abstract}\par\doublespacing
    \else
      \setbox\z@\vbox\bgroup
    \fi
  \else
    \begin{prelimpage}\@uofm@navbookmark{Abstract}{uofm-abstract}%
    \@makeschapterhead{Abstract}\par\doublespacing
  \fi}{%
  \if@proposal
    \if@showabstract\end{prelimpage}\else\egroup\fi
  \else
    \end{prelimpage}
  \fi}


\newenvironment{keywords}{\par\vspace{13.2pt}{\bfseries\normalsize\noindent Keywords:~}}{}

% Optional List of Abbreviations page. If used, it is added to the TOC.
\newenvironment{abbreviations}{%
  \if@proposal\setbox\z@\vbox\bgroup\else
    \prelimpage
    \@uofm@navbookmark{Abbreviations}{uofm-abbreviations}%
    \addcontentsline{toc}{chapter}{Abbreviations}%
    \@makeschapterhead{Abbreviations}\par
    \singlespacing
  \fi}{%
  \if@proposal\egroup\else\doublespacing\endprelimpage\fi}


% -----------------------------------------------------------------------------
% Appendix behavior from old class
% -----------------------------------------------------------------------------
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{Appendix}%
  \gdef\thechapter{\@Alph\c@chapter}%
  \gdef\theHchapter{appendix.\@Alph\c@chapter}%
  \gdef\theHsection{appendix.\@Alph\c@chapter.\@arabic\c@section}%
}

% -----------------------------------------------------------------------------
% Captions and floats: old class visual style without the caption package.
% Table captions must be placed above the tabular in main.tex; figure captions
% must be placed below the image in main.tex.
% -----------------------------------------------------------------------------

\setlength\abovecaptionskip{4\p@}
\setlength\belowcaptionskip{0\p@}
% Caption label format for legacy UofM/CERI style.
% The figure/table label and number are bold (e.g., ``Figure 3.9:'' or
% ``Table 2.1:''), while the caption text remains regular.
\renewcommand\fnum@figure{{\normalfont\bfseries \figurename\nobreakspace\thefigure}}
\renewcommand\fnum@table{{\normalfont\bfseries \tablename\nobreakspace\thetable}}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \begingroup
    % UofM/CERI caption style: normal 12-pt body-size font, single-spaced;
    % only the figure/table label is bold. This matches the old visual format
    % while avoiding the smaller caption text produced by font=small.
    \normalsize
    \singlespacing
    \RaggedRight
    \noindent{\normalfont\bfseries #1:}\normalfont\space #2\par%
  \endgroup
  \vskip\belowcaptionskip}
% If a user loads the caption package in main.tex, caption.sty will override
% \@makecaption. Reapply the same visual rule through caption's interface.
\AtBeginDocument{%
  \@ifpackageloaded{caption}{%
    \DeclareCaptionFont{uofmcaption}{\normalsize\singlespacing}%
    \captionsetup{font=uofmcaption,labelfont=bf,textfont=normalfont,labelsep=colon,justification=raggedright,singlelinecheck=false}%
  }{}%
}
% Float spacing. Do not add manual \vspace before or after figure/table
% environments in main.tex. These lengths keep figure/table separation close
% to the approved manuscript examples while avoiding large blank gaps.
\setlength{\textfloatsep}{0.45\baselineskip}
\setlength{\floatsep}{0.45\baselineskip}
\setlength{\intextsep}{0.45\baselineskip}
\setlength{\dbltextfloatsep}{0.45\baselineskip}
\setlength{\dblfloatsep}{0.45\baselineskip}


% -----------------------------------------------------------------------------
% Clickable TOC/LOF/LOT entries for tagged-PDF workflows.
% In PDF/UA mode, the legacy custom TOC line formatting can lose clickable
% annotations or generate tagpdf TOCI warnings. This wrapper explicitly links
% both the entry text and the page number while suspending tagging only around
% the generated hyperlink text. The visible TOC/list format is unchanged.
% -----------------------------------------------------------------------------
\newcommand\uofm@toclink[2]{%
  \uofmTagSuspend{custom TOC hyperlink}%
  \hyperlink{#1}{#2}%
  \uofmTagResume{custom TOC hyperlink}%
}
\newcommand\uofm@starttoclinked[1]{%
  \begingroup
    \def\contentsline##1##2##3##4{%
      \def\uofm@tocdest{##4}%
      \ifx\uofm@tocdest\@empty
        \csname l@##1\endcsname{##2}{##3}%
      \else
        \csname l@##1\endcsname{\uofm@toclink{##4}{##2}}{\uofm@toclink{##4}{##3}}%
      \fi
    }%
    \@starttoc{#1}%
  \endgroup
}

% -----------------------------------------------------------------------------
% TOC/list formatting from old class: no dotted leaders.
% -----------------------------------------------------------------------------
\def\@dottedtocline#1#2#3#4#5{%
\ifnum #1>\c@tocdepth \else
  \vskip \z@ \@plus .2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
   \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax
   \advance\leftskip \@tempdima \null\hskip -\leftskip
   {#4}\nobreak\hfill\nobreak\hb@xt@\@pnumwidth{\hfil\normalfont\normalcolor #5}\par}%
\fi}

\renewcommand\@pnumwidth{1.55em}
\renewcommand\@tocrmarg{2.55em}
\renewcommand\@dotsep{3}
\renewcommand\contentsname{Table of Contents}
\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
\renewcommand\bibname{References}
\renewcommand\figurename{Figure}
\renewcommand\tablename{Table}

\renewcommand\tableofcontents{%
  \if@proposal\else
    \begin{prelimpage}
      \phantomsection\@uofm@navbookmark{Table of Contents}{uofm-toc}%
      \begingroup
      \begin{center}\bfseries \contentsname\end{center}%
      \singlespacing
      \vspace*{-0.06in}%
      Chapter\hfill Page\par
      % Read .toc with explicit hyperlinks for text and page numbers.
      \uofm@starttoclinked{toc}%
      \endgroup
      \doublespacing
    \end{prelimpage}
  \fi}

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{\@dottedtocline{1}{2.5em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4.8em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{7.1em}{4.1em}}

\renewcommand\listoffigures{%
  \if@proposal\else
    \begin{prelimpage}
      \phantomsection\addcontentsline{toc}{chapter}{\listfigurename}%
      \begingroup
      \begin{center}\bfseries \listfigurename\end{center}%
      \figurename\hfill Page\par
      \doublespacing
      \begingroup\justifying\uofm@starttoclinked{lof}\endgroup
      \endgroup
      \doublespacing
    \end{prelimpage}
  \fi}
\renewcommand*\l@figure[2]{%
  \begingroup
  \def\numberline##1{\textbf{##1}\hspace{1em}}%
  \@dottedtocline{1}{0em}{2.3em}{#1}{#2}%
  \endgroup}

\renewcommand\listoftables{%
  \if@proposal\else
    \begin{prelimpage}
      \phantomsection\addcontentsline{toc}{chapter}{\listtablename}%
      \begingroup
      \begin{center}\bfseries \listtablename\end{center}%
      \tablename\hfill Page\par
      \doublespacing
      \begingroup\justifying\uofm@starttoclinked{lot}\endgroup
      \endgroup
      \doublespacing
    \end{prelimpage}
  \fi}
\renewcommand*\l@table[2]{%
  \begingroup
  \def\numberline##1{\textbf{##1}\hspace{1em}}%
  \@dottedtocline{1}{0em}{2.3em}{#1}{#2}%
  \endgroup}

% -----------------------------------------------------------------------------
% Footnotes: 10 pt, single-spaced, restart each chapter
% -----------------------------------------------------------------------------
\RequirePackage[bottom]{footmisc}
\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}
\@addtoreset{footnote}{chapter}
\renewcommand\footnoterule{%
  \kern-3\p@\hrule\@width .4\columnwidth\kern 2.6\p@}
\renewcommand\@makefntext[1]{%
  \parindent 1em\noindent\hb@xt@1.8em{\hss\@makefnmark}#1}

% -----------------------------------------------------------------------------
% Bibliography: old visual heading, References in TOC, single-spaced entries.
% natbib hook supported.
% -----------------------------------------------------------------------------
\newif\if@uofm@bibintocadded
\@uofm@bibintocaddedfalse
\newcommand\@uofm@addbibtotoc{%
  \if@uofm@bibintocadded\else
    \addcontentsline{toc}{chapter}{\bibname}%
    \global\@uofm@bibintocaddedtrue
  \fi}

\renewenvironment{thebibliography}[1]{%
  \clearpage
  \begin{prelimpage}
  \phantomsection
  \@uofm@addbibtotoc
  \begin{center}\bfseries \bibname\end{center}%
  % Graduate School bibliography format: single-spaced within entries,
  % double-spaced between entries, and hanging indentation.
  \singlespacing
  \setlength{\parskip}{0pt}%
  \setlength{\parsep}{0pt}%
  \@ifundefined{bibhang}{}{\setlength{\bibhang}{0.5in}}%
  \@ifundefined{bibsep}{}{\setlength{\bibsep}{\baselineskip}}%
  \list{}%
       {\setlength{\leftmargin}{0.5in}%
        \setlength{\itemindent}{-0.5in}%
        \setlength{\labelwidth}{0pt}%
        \setlength{\labelsep}{0pt}%
        \setlength{\itemsep}{\baselineskip}%
        \setlength{\parsep}{0pt}%
        \setlength{\topsep}{0pt}%
        \setlength{\partopsep}{0pt}%
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy\clubpenalty4000\widowpenalty4000\sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
  \doublespacing
  \end{prelimpage}%
}

\AtBeginDocument{%
  \@ifundefined{bibsection}{}{%
    \renewcommand{\bibsection}{%
      \clearpage
      \begin{prelimpage}
      \phantomsection
      \@uofm@addbibtotoc
      \begin{center}\bfseries \bibname\end{center}%
      \singlespacing
      \setlength{\parskip}{0pt}%
      \@ifundefined{bibhang}{}{\setlength{\bibhang}{0.5in}}%
      \@ifundefined{bibsep}{}{\setlength{\bibsep}{\baselineskip}}%
    }%
  }%
  \hypersetup{linktoc=all,pdftitle={\@title},pdfauthor={\@author},pdfsubject={University of Memphis dissertation/thesis},pdfcreator={LaTeX with uofm.cls}}%
}

\providecommand\newblock{\hskip .11em\@plus .33em\@minus .07em}

% -----------------------------------------------------------------------------
% Names
% -----------------------------------------------------------------------------
\providecommand\abstractname{Abstract}
\providecommand\dedicationname{Dedication}
\providecommand\acknowledgmentsname{Acknowledgments}
\providecommand\prefacename{Preface}

\makeatother
\endinput
