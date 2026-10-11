%% gachon-thesis-en.cls
%% Gachon University Graduate School Thesis (English) LaTeX document class
%% Reference: Thesis / Dissertation Guidelines (English), Graduate School of Gachon University

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gachon-thesis-en}[2026/04/12 Gachon University English Thesis Class]

\LoadClass[11pt,twoside,openany]{book}

% ---------------------------------------------------------------
% Paper and margins — B5 (190 mm x 260 mm)
% Top 30 / Bottom 30 / Left 25 / Right 25 / Header 10 / Footer 10 / Gutter 0
% ---------------------------------------------------------------
\RequirePackage[
  paperwidth=190mm,
  paperheight=260mm,
  top=30mm,
  bottom=30mm,
  left=25mm,
  right=25mm,
  headheight=10mm,
  headsep=4mm,
  footskip=10mm,
  bindingoffset=0mm
]{geometry}

% ---------------------------------------------------------------
% Fonts — Times New Roman (or TeX Gyre Termes fallback)
% kotex is loaded for the Korean abstract at the back.
% ---------------------------------------------------------------
\RequirePackage{fontspec}
\RequirePackage[hangul]{kotex}

% Actual font selection happens in config/fonts.tex so users can
% swap easily depending on the environment.

% ---------------------------------------------------------------
% Math, graphics, tables, captions
% ---------------------------------------------------------------
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{caption}
\captionsetup{font={small},labelfont={bf},labelsep=period}

% ---------------------------------------------------------------
% Line spacing — 1.5 default (spec allows 1.5 or 2.0)
% ---------------------------------------------------------------
\RequirePackage{setspace}
\setstretch{1.5}

% ---------------------------------------------------------------
% Paragraph indentation — 2 characters (approx. 2 em)
% indentfirst applies to first paragraph after a heading too
% ---------------------------------------------------------------
\RequirePackage{indentfirst}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}

% ---------------------------------------------------------------
% Body / footnote font sizes
% ---------------------------------------------------------------
\renewcommand{\normalsize}{\fontsize{11pt}{17pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize{9pt}{11pt}\selectfont}

% ---------------------------------------------------------------
% Chapter / section / subsection heading formats
%   Main text headings: "1. Introduction" / "1.1 ..." / "1.1.1 ..."
%   (TOC uses a different format — see titlecontents below.)
% ---------------------------------------------------------------
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{etoolbox}

% Degree helper — the metadata file switches behaviour from the
% official degree label rather than requiring manual edits in
% multiple places.
\newcommand{\IfDoctoralTF}[2]{%
  \ifdefstrequal{\DegreeType}{Doctoral Dissertation}{#1}{#2}%
}

% Numbered chapter: "1. Title" 16pt bold, centered
\titleformat{\chapter}[block]
  {\filcenter\normalfont\fontsize{16pt}{20pt}\selectfont\bfseries}
  {\thechapter.}
  {0.6em}
  {}
\titlespacing*{\chapter}{0pt}{30pt}{24pt}

% Numberless chapter: used for TOC, References, Appendix, Korean abstract
\titleformat{name=\chapter,numberless}[block]
  {\filcenter\normalfont\fontsize{16pt}{20pt}\selectfont\bfseries}
  {}{0pt}{}
\titlespacing*{name=\chapter,numberless}{0pt}{30pt}{24pt}

% Section: "1.1 Title" 14pt bold
\titleformat{\section}
  {\normalfont\fontsize{14pt}{18pt}\selectfont\bfseries}
  {\thesection}
  {0.75em}
  {}
\titlespacing*{\section}{0pt}{16pt}{8pt}

% Subsection: "1.1.1 Title" 12pt bold
\titleformat{\subsection}
  {\normalfont\fontsize{12pt}{16pt}\selectfont\bfseries}
  {\thesubsection}
  {0.5em}
  {}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}

% The English spec allows only 3 numbering levels.
% subsubsection / paragraph are kept available (unnumbered) but
% authors are advised not to use deeper headings.

% ---------------------------------------------------------------
% Table of contents / List of tables / List of figures formats
% ---------------------------------------------------------------
% Chapter (numbered): "CHAPTER 1. Title ........ page" 13pt bold
\titlecontents{chapter}
  [0pt]
  {\addvspace{1.2em}\normalfont\fontsize{13pt}{16pt}\selectfont\bfseries}
  {\makebox[7em][l]{CHAPTER~\thecontentslabel.}}
  {}
  {\titlerule*[0.5pc]{.}\contentspage}

% Numberless chapter entry — used for TOC, References, Appendix,
% Korean abstract. Authors should use \addstarchaptertoc{Title} instead of
% \addcontentsline{toc}{chapter}{Title} to get the proper format
% (no "CHAPTER" prefix, 13pt bold, leader dots + page number).
\newcommand{\addstarchaptertoc}[1]{%
  \addcontentsline{toc}{chapstar}{#1}%
}
\titlecontents{chapstar}
  [0pt]
  {\addvspace{1.2em}\normalfont\fontsize{13pt}{16pt}\selectfont\bfseries}
  {}
  {}
  {\titlerule*[0.5pc]{.}\contentspage}

% Section: "1.1 Title ........ page" 11pt
\titlecontents{section}
  [4em]
  {\addvspace{0.3em}\normalfont\fontsize{11pt}{14pt}\selectfont}
  {\contentslabel{3em}}
  {\hspace*{-3em}}
  {\titlerule*[0.5pc]{.}\contentspage}

% Subsection: "1.1.1 Title ........ page" 11pt
\titlecontents{subsection}
  [7em]
  {\normalfont\fontsize{11pt}{14pt}\selectfont}
  {\contentslabel{3.2em}}
  {\hspace*{-3.2em}}
  {\titlerule*[0.5pc]{.}\contentspage}

% ---------------------------------------------------------------
% Header / footer
% ---------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{plain}  % page number centered at bottom only

% ---------------------------------------------------------------
% Hyperlinks (PDF bookmarks; hidden for print)
% ---------------------------------------------------------------
\RequirePackage[hidelinks,bookmarks=true,unicode=true]{hyperref}

% ---------------------------------------------------------------
% English localization
% ---------------------------------------------------------------
\AtBeginDocument{%
  \renewcommand{\contentsname}{Table of Contents}%
  \renewcommand{\listtablename}{List of Table}%
  \renewcommand{\listfigurename}{List of Figures}%
  \renewcommand{\bibname}{References}%
  \renewcommand{\appendixname}{Appendix}%
  \renewcommand{\figurename}{Figure}%
  \renewcommand{\tablename}{Table}%
}

% ---------------------------------------------------------------
% Table / figure numbering — "chapter.number" with dot separator
% (e.g. Table 2.1, Figure 2.1)
% ---------------------------------------------------------------
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}

\endinput
