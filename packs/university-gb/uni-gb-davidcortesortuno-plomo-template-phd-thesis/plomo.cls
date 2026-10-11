% This template is copyrightes under:
% BSD 2-Clause License
% Copyright (c) 2018, David Ignacio Cortés Ortuño
% All rights reserved.
%

% KOMA script book
\LoadClass[11pt,twoside=true,bibliography=totoc]{scrbook}

% For template demo:
\usepackage{lipsum}

% Extra commands
\usepackage{etoolbox}

% Paragraph spacing:
% \setlength{\parskip}{1em}
% Line spacing
\usepackage[onehalfspacing]{setspace}

% Colors
\usepackage[usenames,dvipsnames]{xcolor}

% This colour appears in the citations (bibliography):
\definecolor{mycolour}{HTML}{003399}
% Colour for tables, citations, references (use the same than mycolour to look better):
\definecolor{fore}{HTML}{003399}
% Grey colour for chapters:
\definecolor{back}{HTML}{595959}

\definecolor{dyellow}{rgb}{0.9976163,0.9990772,0.753402}

% Fixing footnote indentation: align everything to the left
\usepackage[hang,flushmargin]{footmisc} 

% For custom chapters (the black rectangle on top; see at the bottom)
\usepackage{scrlayer}

% Physics!
\usepackage{physics}

% Math and symbols
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{mathrsfs}
\usepackage{mathtools}

% Better bold symbols:
\usepackage{bm}

% To show a FULL citation (see Declaration of Authorship)
\usepackage{bibentry}
\nobibliography*

% Nomenclature
\usepackage{ifthen}
\usepackage{nomencl}
\setlength{\nomitemsep}{-\parsep}
\renewcommand{\nomgroup}[1]{%
    \ifthenelse{\equal{#1}{A}}{\item[\textbf{Atomistic variables}]}{%
        \ifthenelse{\equal{#1}{M}}{\item[\textbf{Micromagnetic Variables}]}{%
            \ifthenelse{\equal{#1}{N}}{\item[\textbf{NEBM variables}]}{}{%
                \ifthenelse{\equal{#1}{C}}{\item[\textbf{Constants}]}{}{%
                    \ifthenelse{\equal{#1}{V}}{\item[\textbf{Vectors}]}{}
                }%
            }%
        }%
    }%
}%
\makenomenclature

% DEFINITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\bohrmu}{\mu_{\text{B}}}
\newcommand{\ie}{\emph{i.e.}}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For the math fonts (sans serif style):
\usepackage{cmbright}
% \DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

% Use Lato font (Fira Sans is also an alternative)
\usepackage[default]{lato}
\usepackage[T1]{fontenc}
% switch default weight to light:
\renewcommand{\mddefault}{l}
% \usepackage[italic]{mathastext}

% Mathcal fonts will be from computer modern to get bold calligraphic letters:
\DeclareMathAlphabet\mathbfcal{OMS}{cmsy}{b}{n}

% Declare Lato font for numbers in math mode
% {T1}{fla}{l}{n}  --> encoding - family - series - shape 
% We use the light series {l}
\DeclareSymbolFont{numbers}{T1}{fla}{l}{n}
    % \SetSymbolFont{numbers}{bold}{T1}{fla}{b}{n}
    \DeclareMathSymbol{0}\mathalpha{numbers}{"30}
    \DeclareMathSymbol{1}\mathalpha{numbers}{"31}
    \DeclareMathSymbol{2}\mathalpha{numbers}{"32}
    \DeclareMathSymbol{3}\mathalpha{numbers}{"33}
    \DeclareMathSymbol{4}\mathalpha{numbers}{"34}
    \DeclareMathSymbol{5}\mathalpha{numbers}{"35}
    \DeclareMathSymbol{6}\mathalpha{numbers}{"36}
    \DeclareMathSymbol{7}\mathalpha{numbers}{"37}
    \DeclareMathSymbol{8}\mathalpha{numbers}{"38}
    \DeclareMathSymbol{9}\mathalpha{numbers}{"39}

% \usepackage{mathspec,fontspec,unicode-math}
% \setmathsfont(Digits)[Numbers={Lining,Proportional}]{Lato Light}

% In case we want to use XeLatex or Lualatex to compile the document:

% Xelatex:
% \usepackage{lato}
% \usepackage{fontspec}
% \usepackage{unicode-math}
% \setmainfont{Lato Light}

% Lualatex:
% \setmathfont{Lato Light}
% % \setmathfont[range=\mathup]  {Lato Light}
% % \setmathfont[range=\mathbfup]{Lato Bold}
% % \setmathfont[range=\mathbfit]{Lato Bold Italic}
% \setmathfont[range=\mathit]  {Lato Light Italic}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Table of Contents for KOMA using tocbasic

% Spacing in TOC title
\BeforeTOCHead[toc]{%
  \RedeclareSectionCommand[
    beforeskip=5em,% at least 1sp
    afterskip=2em,% at least 1sp
  ]{chapter}%
}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

\DeclareTOCStyleEntry[%
    ,beforeskip=15pt%
    ,numsep=15pt% changing this to e.g. -5pt doesn't change anything
    ,entryformat=\large\flafamily\fontseries{bx}\selectfont%
    ,level=0%
    ,pagenumberbox=\relax%
]{tocline}{chapter}

\BeforeStartingTOC[toc]{%
\DeclareTOCStyleEntry[%
    ,beforeskip=5pt%
    ,numsep=15pt% changing this to e.g. -5pt doesn't change anything
]{tocline}{section}
}

\DeclareTOCStyleEntry[%
    ,numsep=12pt% changing this to e.g. -5pt doesn't change anything
    ,entryformat=\itshape%
]{tocline}{subsection}

% Add bibliography to TOC (already in koma book options)
% \usepackage[nottoc,notlot,notlof]{tocbibind}

% Remove indentation for List of Figures and Tables
\DeclareTOCStyleEntry[indent=0pt]{tocline}{table}
\DeclareTOCStyleEntry[indent=0pt]{tocline}{figure}


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mini TOC for Chapters

\usepackage[nohints]{minitoc}
\RedeclareSectionCommand[tocbeforeskip=2pt]{section}

%% partial TOCs after chapter title
% \setcounter{secnumdepth}{4} % number subsections
% \setcounter{tocdepth}{4} % list subsections
\mtcsetdepth{minitoc}{1}% ~ \setcounter{minitocdepth}{2}
%\renewcommand{\mtcfont}{\small\color{white}}
\mtcsetfont{minitoc}{*}{\flafamily\footnotesize\color{back}}
\mtcsetfont{minitoc}{section}{\hypersetup{linkcolor=back}\flafamily\fontseries{m}\footnotesize\color{back}}
% \mtcsetfont{minitoc}{subsection}{\usekomafont{chapterentry}}

\mtcsettitle{minitoc}{\relax}% remove “Contents”
\mtcsetfeature{minitoc}{before}{\vspace{0cm}}
\mtcsetfeature{minitoc}{after}{\vspace{0cm}}
\mtcsetrules{*}{off}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hyperlinks
\usepackage[%
        pdfauthor={David Ignacio Cort\'es Ortu\~no},
        bookmarks,%
        linkbordercolor=white,%
	    urlbordercolor=white,%
	    colorlinks=true,%
	    linkcolor=black,%
        linktoc=all,
	    urlcolor=fore,%
	    citecolor=fore]{hyperref}

\usepackage{url}

% Plots
\usepackage{cite}
\usepackage{caption}
\usepackage{array}
% \captionsetup[figure]{box=colorbox, boxcolor=black!7, slc=off}
\usepackage{pgf}

% Better tables
% For make cell, look at:
% http://tex.stackexchange.com/questions/2441/
% how-to-add-a-forced-line-break-inside-a-table-cell/176780#176780
\usepackage{colortbl}
\usepackage{makecell}
\renewcommand\theadalign{c}
\renewcommand\theadgape{\Gape[4pt]}
\renewcommand\cellgape{\Gape[4pt]}
\renewcommand\theadfont{\normalsize\flafamily\fontseries{m}\selectfont}

\newcommand{\tableheadnormal}{\color{white}\normalsize\flafamily\fontseries{m}\selectfont}
\newcommand{\tableheadsmall}{\color{white}\small\flafamily\fontseries{m}\selectfont}
\newcommand{\tableheadfnsize}{\color{white}\footnotesize\flafamily\fontseries{m}\selectfont}

% Larger padding for table cells (default is 1)
\renewcommand{\arraystretch}{1.2}
% \def\arraystretch{1.2}%
% \setlength{\extrarowheight}{2pt}

% Short Command for some plots
\newcommand{\Insertfig}[5][1]{%
    % The first argument #1 is optional, with
    % default value '1'
    \begin{figure}[t!]
        \centering
        \includegraphics[scale=#1]{#2}
        \caption{#4}{#5}
        \label{#3}
    \end{figure}%
}

% To import pgf with embedded png pictures in a separate file
% \usepackage{import}
% \usepackage{subcaption}

% Margins
\usepackage[top=3cm, bottom=3cm, left=4cm, right=3cm]{geometry}

% For TexLive 2014 - Remove warnings
%\pdfsuppresswarningpagegroup=1

\usepackage{epstopdf}

% Code snippets
% \usepackage{minted}


% To make the custom chapters and captions
\usepackage{tikz}
\usetikzlibrary{positioning, backgrounds}
\usepackage{tikzpagenodes}


% To import the PDF for the extra cover page
\usepackage{pdfpages}


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CAPTIONS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{changepage}
\strictpagecheck

% To use tikz regions as south, west, etc
% calc is for summing coordinates
\usetikzlibrary{positioning,calc}

% We define a new caption format (see doc)
\DeclareCaptionFormat{sidewise}{%
    % A small negative space to have the caption behind the left margin
    % This approach produces a lot of hbox warnings!

    \checkoddpage
    \ifoddpage
        \hspace{-0.5cm}
        \begin{tikzpicture}
            % The space for the caption text (figure description)
            % with the width of the main text
            \node (caption text) [align=left] {%
            \begin{tabular}{p{\textwidth}}
                \small #3
            \end{tabular}};
            % The label, for example: Figure 2
            % in a rotated rectangle, next to the caption text
            % (north east of the caption box)
            \node [yshift=-.6em] (caption label) [rotate=-90, inner xsep=0pt,%
                right=5mm of caption text.north east] {#1};
            % A vertical black line (back color) whose height adapts
            % to the caption text height
            \draw [line width=0.25cm, fore!20] ([yshift=-.6em]caption text.north east) -- ($(caption text.south east)+(0, 0.85)$);
            % An orange (fore) vertical line next to the black one
            % (we use xshift for this)
            % we also use calc to get the line upper (yshift does not seem to work)
            % \draw [line width=1pt, fore]%
            %     ([xshift=.35em,yshift=-.6em]caption text.north east) -- ($(caption text.south east) + (.35em, 0.85)$);
        \end{tikzpicture}
    \else
        \hspace{-1.3cm}
        \begin{tikzpicture}
            % The space for the caption text (figure description)
            % with the width of the main text
            \node (caption text) [align=left] {%
            \begin{tabular}{p{\textwidth}}
                \small #3
            \end{tabular}};
            % The label, for example: Figure 2
            % in a rotated rectangle, next to the caption text
            % (north west of the caption box)
            \node [yshift=-.6em] (caption label) [rotate=90, inner xsep=0pt,%
                left=5mm of caption text.north west] {#1};
            % A vertical black line (back color) whose height adapts
            % to the caption text height
            \draw [line width=0.25cm, fore!20] ([yshift=-.6em]caption text.north west) -- ($(caption text.south west)+(0, 0.85)$);
            % An orange (fore) vertical line next to the black one
            % (we use xshift for this)
            % we also use calc to get the line upper (yshift does not seem to work)
            % \draw [line width=1pt, fore]%
            %     ([xshift=.35em, yshift=-.6em]caption text.north west) -- ($(caption text.south west) + (.35em, 0.85)$);
        \end{tikzpicture}
    \fi
}

% Set the caption style:

% Update the caption labels manually (I cannot update it directly in Tikz)
\makeatletter
\renewcommand{\fnum@figure}{\flafamily Figure\hspace{1em}\thefigure}
\renewcommand{\fnum@table}{\flafamily Table\hspace{1em}\thetable}
\makeatother

\captionsetup{format=sidewise}

% Set an option for \caption to use a title in bold
\let\oldcaption\caption
\renewcommand{\caption}[2]{
    \oldcaption[#1]{\textbf{#1.} #2}
}


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHAPTERS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\chapterimageheight{.235\paperheight}% height of the chapter images

% Black background at the top of the page using scrlayer
% (works for chapter and chapter*)
\DeclareNewLayer[
  background,
  voffset=0pt,
  contents={%
      \begin{tikzpicture}[remember picture, overlay]
        \fill[back]
        ([yshift=-2.2cm,xshift=0.5cm] current page.north west)
        rectangle ([yshift=-1.2cm,xshift=-3.0cm] current page.north east);%
        %
      \end{tikzpicture}%
  }
  ]{chapterbackground}
\DeclareNewPageStyleByLayers{chapterpage}{chapterbackground}
\renewcommand\chapterpagestyle{chapterpage}

% The chapter formatting
\renewcommand\chapterformat{%
  \begin{tikzpicture}[remember picture, overlay]
       \ifdef{\chapapp}{%
       \fill[back]
       ([yshift=-5.15cm,xshift=20.2cm] current page.north west)
       rectangle ([yshift=-1.2cm,xshift=-0.5cm] current page.north east);%
       }{}%
        % Chapter name: chapter, appendix, etc; at the top right
        \node[anchor=center] at ([yshift=-1.8cm, xshift=-1.9cm] current page.north east) %
        {\color{back}\flafamily\fontsize{12}{12}\selectfont\chapapp};
%
        % The chapter number with handwritten font
        \node[anchor=center] at ([yshift=-4.1cm, xshift=-1.9cm] current page.north east) %
            {\color{back} {\fontsize{80}{80}%
             \selectfont\thechapter}};
%
    % Minitoc shifted from the top centre part of the page
    \node[anchor=north west] at ([yshift=-1.5cm, xshift=-8.05cm] current page.north) {%
        \begin{minipage}{13cm}%
            \minitoc
        \end{minipage}
        };
  \end{tikzpicture}
}


% This will make the chapter title go upwards
\appto\chapterheadstartvskip{\vspace*{-3.65cm}}
\appto\chapterheadstartvskip{\hspace*{-0.6cm}}
% This will make enough space after the chapter, where the content starts
\appto\chapterheadendvskip{\vspace*{5.0cm}}
% color of chapter title
\addtokomafont{chapter}{\flafamily\color{white}}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In case we want to add code snippets: [compile with --shell-escape option]
% \definecolor{mintedbg}{rgb}{0.96,0.96,0.96}
% \usepackage{minted}
% \usemintedstyle{tango}
