% mtu.thesis class file
%
% This class file is an independently developed class file for theses and
% dissertations at Michigan Technological University. The class file is designed
% to meet the bare minimum of style guidelines as specified in the Graduate
% School's "Guide to Preparing a Dissertation, Thesis, or Report at Michigan
% Technological University (2015)". It is the responsibility of the user to
% ensure that their dissertation, thesis, or report is in accordance with the
% requirements specified by the graduate school.
%
% The class is presented as an extension of the default report class, and is
% designed in as non-invasive of a method possible in order to maintain the
% expectations and flexibility of that class.
%
% Wherever possible, citations to the aforementioned guide are provided as a
% description for changes.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mtu.thesis}[2015/09/22 Michigan Technological University Thesis]

\newif\if@draft

\DeclareOption{oneside}{
\PassOptionsToPackage{includeheadfoot,margin=1in,left=1.25in,right=1.25in}{geometry}
\PassOptionsToClass{oneside,openany,letterpaper}{report}
}
\DeclareOption{twoside}{
\PassOptionsToPackage{includeheadfoot,margin=1in,left=1.5in}{geometry}
\PassOptionsToClass{twoside,openright,letterpaper}{report}
}
\DeclareOption{draft}{\@drafttrue}
\DeclareOption{showframe}{\PassOptionsToPackage{showframe}{geometry}}
\ExecuteOptions{twoside}
\ProcessOptions\relax

%%%
%%% using the report class as a basis
\LoadClass[letterpaper,notitlepage]{report}

\RequirePackage{enumitem}
\setlist[description]{font={\normalfont\scshape}}

%%%
%%% document information
\def\@title     {\rule[.3em]{5in}{1pt}}
\def\@author    {\rule[.3em]{1in}{1pt}}
\def\@date      {\the\year}
%\title, \author, \data already defined

\def\@copyright {\rule[.3em]{1in}{1pt}}
\renewcommand{\copyright}[1]{\def\@copyright{#1}}

\def\@type      {\rule[.3em]{1in}{1pt}}
\def\@degree    {\rule[.3em]{1in}{1pt}}
\def\@prog      {\rule[.3em]{1in}{1pt}}
\newcommand{\dissertation}[2]{\def\@type{Dissertation}\def\@degree{#1}\def\@prog{#2}}
\newcommand{\thesis}[2]{\def\@type{Thesis}\def\@degree{#1}\def\@prog{#2}}
\newcommand{\report}[2]{\def\@type{Report}\def\@degree{#1}\def\@prog{#2}}

\def\@university{\rule{1in}{1pt}}
\def\@affiliation{\rule{1in}{1pt}}
\newcommand{\affiliation}[2][Michigan Technological University]
{\def\@university{#1}\def\@affiliation{#2}}

%%%
%%% [3.01] typefaces
\RequirePackage{helvet}

%%%
%%% [3.02] margins
%%% [3.03] paper size
\RequirePackage[letterpaper,includehead,includefoot]{geometry}
\raggedbottom

%%%
%%% [3.04] page numbers
%%% [????] headers and footers
\newcommand\frontmatter{\cleardoublepage\pagenumbering{roman}}
\newcommand\mainmatter{\cleardoublepage\pagenumbering{arabic}}
\usepackage{fancyhdr}
\pagestyle{fancy}\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[CE,CO]{\thepage}

%%%
%%% [3.05] double-sided printing
\RequirePackage{emptypage}

%%%
%%% [3.06] line spacing
\RequirePackage{setspace}

%%% [3.07] figures
%%% [3.08] tables
\RequirePackage{caption}
\captionsetup[figure]{skip=1em}
\captionsetup[table]{skip=1em}

%%%
%%% [3.09] including oversize pages or media
%%% [3.10] use of color
% Support for these options are not included by default and are the responsibility of the student.

%%%
%%% [4.01, Appendix A] title page
\RequirePackage{comment}
\renewcommand{\maketitle}{
\cleardoublepage
\begin{titlepage}
\begin{center}
\vspace*{\fill}\textsc\@title\\[1em]
\vspace*{\fill}By\\[1em]\@author\\[1em]
\vspace*{\fill}A \textsc\@type\\[1em]Submitted in partial fulfillment of the requirements for the degree of\\[1em]\textsc\@degree\\[1em]In \@prog\\[1em]
\vspace*{\fill}\textsc\@university\\[1em]\@date\\[1em]
\vspace*{\fill}\@copyright
\vspace*{\fill}
\end{center}
\end{titlepage}
\cleardoublepage
}

%%%
%%% [4.02, Appendix A] approval page
\if@draft
\excludecomment{approval}
\else
\newenvironment{approval}[1][1in]
{\cleardoublepage\thispagestyle{empty}
\noindent\begin{flushleft}This \MakeLowercase{\@type} has been approved in partial fulfillment of the requirements for the Degree of \textsc{\@degree} in \@prog.\end{flushleft}
\begin{flushright}\@affiliation\end{flushright}%
\vspace*{\fill}%
\halign\bgroup%
\begin{minipage}[b][#1]{0.7\textwidth}\vspace*{\fill}%
\raggedleft\textsc{##\unskip:}\hspace*{5mm}%
\end{minipage}&%
\begin{minipage}[b][#1]{0.3\textwidth}\vspace*{\fill}%
\raggedright\emph{##}%
\end{minipage}\cr%
}
{\egroup\cleardoublepage}
\fi

%%%
%%% [4.03, Appendix A] dedication page
\if@draft
\excludecomment{dedication}
\else
\newenvironment{dedication}
{\cleardoublepage\thispagestyle{empty}%
\begin{minipage}[c][\textheight]{\textwidth}\centering\topskip0pt\vspace*{\fill}%
}
{\vspace*{\fill}\end{minipage}\cleardoublepage}
\fi

%%%
%%% [4.04] table of contents
%%% [4.05] list of figures
%%% [4.06] list of tables
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[titles]{tocloft}
\RequirePackage{titlesec}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\large\scshape}
\renewcommand{\cftchappagefont}{\large\scshape}
\renewcommand{\cftbeforesecskip}{1em}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecfont}{\scshape}
\renewcommand{\cftsecpagefont}{\scshape}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsecfont}{\scshape}
\renewcommand{\cftsubsecpagefont}{\scshape}
\renewcommand{\cftfigfont}{\scshape}
\renewcommand{\cfttabfont}{\scshape}

%%%
%%% [4.07] preface
\if@draft
\excludecomment{preface}
\else
\newcommand{\prefacename}{Preface}
\newenvironment{preface}
{\chapter*{\prefacename}\addcontentsline{toc}{chapter}{\prefacename}}{}
\fi

%%%
%%% [4.08] acknowledgements
\if@draft
\excludecomment{acknowledgements}
\excludecomment{acknowledgments}
\else
\newenvironment{acknowledgements}
{\chapter*{Acknowledgements}\addcontentsline{toc}{chapter}{Acknowledgements}}{}
\newenvironment{acknowledgments}
{\chapter*{Acknowledgments}\addcontentsline{toc}{chapter}{Acknowledgments}}{}
\fi

%%%
%%% [4.09] definitions
%%% [4.10] list of abbreviations
% Support for these options currently not available due to lack of knowledge in practice in their application

%%%
%%% [4.11] abstract
\renewenvironment{abstract}
{\chapter*{\abstractname}\markboth{\scshape\MakeUppercase\abstractname}{}\addcontentsline{toc}{chapter}{\abstractname}}{}

%%%
%%% [4.12] main body
\newcommand{\hsp}{\hspace{20pt}}
\titleformat{\chapter}[display]
{\Huge\scshape\onehalfspacing}{\filleft\Large{\@chapapp~\thechapter}}{0ex}{\titlerule\vspace{0em}}
\titleformat{\section}[hang]
{\Large\scshape\onehalfspacing\filright}{\thesection\hsp}{0pt}{\Large\scshape}
\titleformat{\subsection}[hang]
{\large\scshape\onehalfspacing\filright}{\thesubsection\hsp}{0pt}{\large\scshape}
\titleformat{\subsubsection}[hang]
{\large\scshape\onehalfspacing\filright}{\thesubsubsection\hsp}{0pt}{\normalsize\scshape}
\titlespacing*{\chapter}{0pt}{0em}{4em}

%%%
%%% [4.13] reference list/bibliography
% Support is already sufficiently available as part of the latex framework.

%%%
%%% [4.14] appendices
% Support is already sufficiently available as part of the latex framework.
