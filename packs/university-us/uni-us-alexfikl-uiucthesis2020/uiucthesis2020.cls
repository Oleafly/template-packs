% SPDX-FileCopyrightText: 2022 Alexandru Fikl <alexfikl at gmail.com>
% SPDX-License-Identifier: CC0-1.0

% <<< preamble

\def\fileversion{v2.34}
\def\filedate{2024/11/02}
\def\clsname{uiucthesis2020}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\clsname}[\filedate\ \fileversion\ UIUC Thesis Class]

% >>>

% <<< declare options

% draft features
\newif\if@thesisdraft \@thesisdraftfalse
\DeclareOption{draftthesis}{\@thesisdrafttrue}

% double spacing
\newif\if@doublespacing \@doublespacingfalse
\DeclareOption{doublespacing}{\@doublespacingtrue}

% force 1in bottom margin
\newif\if@forcebottom \@forcebottomfalse
\DeclareOption{forcebottom}{\@forcebottomtrue}

% electronic deposit format
\newif\if@edeposit \@edepositfalse
\DeclareOption{edeposit}{\@edeposittrue}

% grid
\newif\if@layoutgrid \@layoutgridfalse
\DeclareOption{layoutgrid}{\@layoutgridtrue}

% additional options passed to `scrbook` class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\PassOptionsToClass{DIV=12}{scrbook}

% >>>

% <<< process options

\ProcessOptions
\LoadClass{scrbook}

% force serif fonts
\addtokomafont{disposition}{\rmfamily}
% additional options
\KOMAoptions{
    paper=letter,
    chapterentrydots=true,
    chapterprefix=true,
}

% NOTE: support for version of KOMAScript < 3.28 (and TeXLive 2018)
% NOTE: we're not advertising this, but it would be nice to have regardless
\providecommand*{\Ifstr}{\ifstr}

\if@edeposit
    \KOMAoption{twoside}{false}
\else
    \KOMAoption{twoside}{true}
\fi

\if@thesisdraft
    \newcount\timehh\newcount\timemm
    \timehh=\time \divide\timehh by 60
    \timemm=\time \count255=\timehh \multiply\count255 by -60
        \advance\timemm by \count255
    \def\draftheader{
        \slshape Draft of \today\ at
        \ifnum\timehh<10 0\fi\number\timehh
        \,:\,%
        \ifnum\timemm<10 0\fi\number\timemm}%
\else
    \def\draftheader{\empty}
\fi

% hardcode bottom margin
% FIXME: this is a giant hack because KOMA-Script likes setting its own
% margins, so we have to twiddle with it for both single and double spacing
\if@forcebottom
    \usepackage{geometry}
    \typearea{14}
    \AfterCalculatingTypearea{\geometry{margin=1in, footskip=0.5in}}
\fi

% >>>

% <<< required packages

% NOTE: load packages after the class was loaded since they may depend on it

% standard math
\RequirePackage{fixmath}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% used to define colors
\RequirePackage[rgb, table]{xcolor}
% used to set doublesplacing
\RequirePackage{setspace}
% customize the toc
\RequirePackage{tocbasic}
% customize headers and footers
\RequirePackage{scrlayer-scrpage}
% indent first paragraph in a section
\RequirePackage{indentfirst}

% enable this to better check sizing
\if@layoutgrid
    \RequirePackage[
        grid, gridBG,
        gridunit=in,
        gridcolor=gray!70,
        subgridcolor=gray!70,
        texcoord]{eso-pic}
\fi

\AtBeginDocument{
    % customize PDF bookmarks a bit
    \RequirePackage{bookmark}
    \bookmarksetup{numbered}
}

% >>>

% <<< title commands

\def\@mkuptitle#1{\gdef\@Utitle{#1}}
\def\title#1{\gdef\@title{#1}\uppercase{\protect\@mkuptitle{#1}}}

\def\@mkupauthor#1{\gdef\@Uauthor{#1}}
\def\author#1{\gdef\@author{#1}\uppercase{\protect\@mkupauthor{#1}}}

\NewDocumentCommand \advisor { m } {\def\@uiucadviser{#1}}
\NewDocumentCommand \adviser { m } {\def\@uiucadviser{#1}}

\NewDocumentCommand \department { m } {\def\@uiucdepartment{#1}}
\NewDocumentCommand \concentration { m } {\def\@uiucconcentration{#1}}
\NewDocumentCommand \college { m } {\def\@uiuccollege{#1}}

\NewDocumentCommand \degree { m } {\def\@uiucdegree{#1}}
\NewDocumentCommand \degreeyear { m } {\def\@uiucdegreeyear{#1}}
\NewDocumentCommand \thesisname { m } {\def\@uiucthesisname{\uppercase{\protect#1}}}

\NewDocumentCommand \committeename { m } {\def\@uiuccommitteename{#1}}
\NewDocumentCommand \committee { m } {\def\@uiuccommittee{#1}}
\NewDocumentCommand \volume { m } {\def\@uiucvolume{VOLUME~#1}}

\NewDocumentCommand \phdthesis {} {
    \degree{Doctor of Philosophy}
    \thesisname{Dissertation}
    \committeename{Doctoral Committee}
}
\NewDocumentCommand \msthesis {} {
    \degree{Master of Science}
    \thesisname{Thesis}
    \committeename{Adviser}
}

\NewDocumentCommand \otherdoctorate { m } {
    \degree{#1}
    \thesisname{Dissertation}
    \committeename{Doctoral Committee}
}

\NewDocumentCommand \othermasters { m } {
    \degree{#1}
    \thesisname{Thesis}
    \committeename{Adviser}
}

% set default values
\college{Graduate College}
\degreeyear{\number\year}
\def\@uiucvolume{}

\if@edeposit
    \gdef\@committee{%
        \ClassError{\clsname}{A committee must be specified for e-deposit dissertations.}%
        {Use \protect\committee\space with members separated by \protect\\'s.}}
\fi

% >>>

% <<< title pages

% define copyright page
\newif\if@thesiscrpage \@thesiscrpagetrue
\def\copyrightnotice{\copyright\, Copyright~\@uiucdegreeyear~\@author.}
\let\nocopyrightpage\@thesiscrpagefalse
\if@thesisdraft
    \nocopyrightpage
\fi

\renewcommand{\maketitle}{
% <<< copyright

\if@thesiscrpage
    \newpage
    \thispagestyle{empty}
    \null\vfill
    \centerline{\copyrightnotice}%
    \vskip 3ex % skip to visually center copyright notice
    \vfill
\fi

% >>>

\newpage

% <<< title

\thispagestyle{empty}

% set font sizes
\begingroup
\def\baselinestretch{1}
\large

% reset top margins so that our offsets work as expected
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\topmargin}{0in}

% make odd/even margins the same
\@tempdima=\paperwidth
\advance\@tempdima by -\textwidth
\divide\@tempdima by 2
\advance\@tempdima by -1in
\oddsidemargin=\@tempdima
\let\evensidemargin=\oddsidemargin

\begin{center}
% see https://grad.illinois.edu/files/pdfs/thesis-doctoral-titlepage-example.pdf
% for details about some of these numbers, but note that they are eyeballed
\newlength{\offset@fromtop}
\setlength{\offset@fromtop}{1.08in}

\newlength{\offset@fromtitle}
\setlength{\offset@fromtitle}{1.5in}

\newlength{\offset@fromauthor}
\setlength{\offset@fromauthor}{1.5in}

\newlength{\offset@fromvolume}
\setlength{\offset@fromvolume}{0.5in}

\newlength{\offset@fromsubmission}
\setlength{\offset@fromsubmission}{2.0in}

\newlength{\offset@fromaddress}
\setlength{\offset@fromaddress}{0.25in}

% set an offset at the top
\vbox to \offset@fromtop {}
% title
\vbox to \offset@fromtitle {%
    {\@Utitle}
    \if@thesisdraft
    \\[11pt]
    \draftheader
    \fi
    \vfil}
% author
\vbox to \offset@fromauthor {%
    {BY} \\[11pt]
    {\@Uauthor} \\[11pt]
    \vfil}%
% statement
\vbox to \offset@fromvolume {\@uiucvolume\vfil}
\vbox to \offset@fromsubmission {%
    {\@uiucthesisname} \\[11pt]
    Submitted in partial fulfillment of the requirements \\
    for the degree of \@uiucdegree\ in \@uiucdepartment \\
    \@ifundefined{@uiucconcentration}{}{with a concentration in \@uiucconcentration \\}
    in the \@uiuccollege\ of the \\
    University of Illinois Urbana-Champaign, \@uiucdegreeyear\vfil}
% location
\vbox to \offset@fromaddress {Urbana, Illinois}
\end{center}

% offset for `Doctoral Committee` line
\newlength{\dim@tpcommitteename}
\setlength{\dim@tpcommitteename}{\oddsidemargin}
\advance\dim@tpcommitteename by -0.3125in
% offset for lines with committee members
\newlength{\dim@tpcommittee}
\setlength{\dim@tpcommittee}{\oddsidemargin}
\advance\dim@tpcommittee by -0.6875in

% committee
\begin{flushleft}
    \vbox to 0.3in {
    \hspace{-\dim@tpcommitteename}\@uiuccommitteename: \\}
    \hspace{-\dim@tpcommittee}\begin{tabular}{l}\@uiuccommittee\end{tabular}\vfil
\end{flushleft}

\endgroup

% >>>

\newpage
}

% add a nice dedication environment
\renewenvironment{dedication}{
    \newpage\leavevmode\vfill
    \begin{center}
        \itshape
}{
    \end{center}
    \vskip 3ex
    \vfill
    \newpage
}

% >>>

% <<< commands

% https://marketing.illinois.edu/visual-identity/color
\definecolor{IlliniOrange}{RGB}{255, 95, 5}
\definecolor{IlliniBlue}{RGB}{19, 41, 75}
\definecolor{IlliniAltgeld}{RGB}{200, 65, 19}

\definecolor{IlliniStorm1}{RGB}{112, 115, 114}
\definecolor{IlliniStorm2}{RGB}{156, 154, 157}
\definecolor{IlliniStorm3}{RGB}{200, 198, 199}
\definecolor{IlliniStorm4}{RGB}{255, 255, 255}
\definecolor{IlliniStorm5}{RGB}{0, 0, 0}

\definecolor{IlliniIndustrial}{RGB}{29, 88, 167}
\definecolor{IlliniArches}{RGB}{0, 159, 212}
\definecolor{IlliniHarvest}{RGB}{252, 179, 22}
\definecolor{IlliniPrairie}{RGB}{0, 98, 48}
\definecolor{IlliniPatina}{RGB}{0, 126, 142}
\definecolor{IlliniBerry}{RGB}{92, 14, 65}
\definecolor{IlliniEarth}{RGB}{125, 62, 19}

% >>>

% <<< front matter

% NOTE: https://grad.illinois.edu/thesis/format-abstract
% says that `ii` should be the page number on abstract page for the manuscript
\let\thesis@frontmatter=\frontmatter
\def\frontmatter{%
    \thesis@frontmatter
    \if@edeposit
        \setcounter{page}{2}
    \else
        \if@thesiscrpage
            \setcounter{page}{3}
        \else
            \setcounter{page}{2}
        \fi%
    \fi%
}

% >>>

% <<< main matter

% add line numbers if in draft mode
\if@thesisdraft
    \RequirePackage[mathlines]{lineno}
    \renewcommand{\linenumberfont}{
        \normalfont\footnotesize\textcolor{black!50}
    }

    \let\thesis@mainmatter=\mainmatter
    \def\mainmatter{\linenumbers\thesis@mainmatter}

    % The \linenumbers command does not play nice with amsmath, so we
    % have added some patches to fix it. See
    % http://phaseportrait.blogspot.com/2007/08/lineno-and-amsmath-compatibility.html
    \newcommand*{\patchAmsMathEnvironmentForLineno}[1]{%
        \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
        \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
        \renewenvironment{#1}%
            {\linenomath\csname old#1\endcsname}%
            {\csname oldend#1\endcsname\endlinenomath}}%

    \newcommand*{\patchBothAmsMathEnvironmentsForLineno}[1]{%
        \patchAmsMathEnvironmentForLineno{#1}%
        \patchAmsMathEnvironmentForLineno{#1*}}%

    \AtBeginDocument{%
        \patchBothAmsMathEnvironmentsForLineno{equation}%
        \patchBothAmsMathEnvironmentsForLineno{align}%
        \patchBothAmsMathEnvironmentsForLineno{flalign}%
        \patchBothAmsMathEnvironmentsForLineno{alignat}%
        \patchBothAmsMathEnvironmentsForLineno{gather}%
        \patchBothAmsMathEnvironmentsForLineno{multline}%
    }
\fi

% >>>

% <<< table of contents

\newcommand{\thesis@makeup}[1]{\texorpdfstring{\protect\MakeUppercase{\expandafter #1}}{#1}}

% change name
\AtBeginDocument{
    \renewcommand{\contentsname}{Table of Contents}
}

% make sure its single spaced
\let\thesis@tableofcontents=\tableofcontents
\def\tableofcontents{%
    \pdfbookmark{\contentsname}{toc}
    \phantomsection
    {\singlespacing\thesis@tableofcontents}
    \newpage}

% add some more spacing to sections
\DeclareTOCStyleEntry[beforeskip=0.5em]{section}{section}

% >>>

% <<< lists of tables and figures and such

\let\thesis@listoftables=\listoftables
\def\listoftables{%
    \phantomsection
    \addcontentsline{toc}{chapter}{\thesis@makeup{\listtablename}}
    {\singlespacing\thesis@listoftables}%
    \newpage
}

\let\thesis@listoffigures=\listoffigures
\def\listoffigures{%
    \phantomsection
    \addcontentsline{toc}{chapter}{\thesis@makeup{\listfigurename}}
    {\singlespacing\thesis@listoffigures}%
    \newpage
}

\newenvironment*{symbollist}[1][1in]{
\begin{list}{}{\singlespacing
    \setlength{\leftmargin}{#1}
    \setlength{\labelwidth}{#1}
    \addtolength{\labelwidth}{-\labelsep}
    \setlength{\topsep}{0in}}%
    \def\makelabel##1{\hfil##1\hfil}%
}{
    \end{list}
}

\newenvironment*{symbollist*}[1][1in]{
    \begin{symbollist}[#1]
    \def\makelabel##1{##1\hfil}
}{
    \end{symbollist}
}

% >>>

% <<< abstract

\def\abstractname{Abstract}
\newenvironment{abstract}{\chapter*{\abstractname}}{}

% >>>

% <<< chapter / section styling

% set font sizes
\addtokomafont{chapter}{\Huge\bfseries}
\addtokomafont{section}{\Large\bfseries}
\addtokomafont{subsection}{\large\bfseries}
\addtokomafont{subsubsection}{\normalsize\bfseries}

% add a `Chapter ...` in front of toc entries
\DeclareTOCStyleEntry[
    dynnumwidth,
    ]{chapter}{chapter}
\let\thesis@addchaptertocentry=\addchaptertocentry
\def\addchaptertocentry#1#2{
    \Ifstr{#1}{}{
        \thesis@addchaptertocentry{#1}{\thesis@makeup{#2}}
    }{%
        \thesis@addchaptertocentry{\thesis@makeup{\chapapp{} #1}}{\thesis@makeup{#2}}
    }%
}

% uppercase chapters
\renewcommand*{\chapterformat}{\chapapp~\thechapter}
\renewcommand{\chapterlineswithprefixformat}[3]{%
  \thesis@makeup{#2#3}%
}

% more spacing after chapters
\RedeclareSectionCommand[
    beforeskip=0pt,
    afterskip=1in,
    ]{chapter}

% >>>

% <<< appendix

\let\thesis@appendix=\appendix
\if@thesisdraft
    \renewcommand{\appendix}{\linenumbers\thesis@appendix\@ifstar{\gdef\thechapter{}}{}}
\else
    \renewcommand{\appendix}{\thesis@appendix\@ifstar{\gdef\thechapter{}}{}}
\fi

% >>>

% <<< bibliography

\renewcommand{\bibname}{References}

\AtBeginDocument{
\let\thesis@thebib\thebibliography
\let\thesis@endbib\endthebibliography

\def\thebibliography{
    \begingroup%
    \chapter{\bibname}%
    \let\chapter\@gobbletwo%
    \singlespacing%
    \thesis@thebib%
    }
\def\endthebibliography{
    \thesis@endbib%
    \endgroup%
    }
}

% >>>

% <<< index

\let\thesis@theindex=\theindex
\def\theindex{
    \addcontentsline{toc}{chapter}{\indexname}%
    \begingroup\singlespacing\thesis@theindex
}

\let\thesis@endtheindex=\endtheindex
\def\endtheindex{\thesis@endtheindex\endgroup}

% >>>

% <<< page header/footer styles

\pagestyle{plain}
\clearpairofpagestyles

\cofoot[\pagemark]{\pagemark}
\lohead[\draftheader]{\draftheader}
\if@edeposit \else
    \cefoot[\pagemark]{\pagemark}
    \rehead[\draftheader]{\draftheader}
\fi

% >>>

% <<< spacing

\pagenumbering{roman}
\if@doublespacing
    \doublespacing
\else
    \onehalfspacing
\fi

% >>>

\recalctypearea

\endinput

%% vim: nospell:filetype=tex
