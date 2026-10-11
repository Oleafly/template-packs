%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                            %%
%% Class ``PhD Thesis PSnPDF''                                                %%
%%                                                                            %%
%% A PhD thesis LaTeX template for Cambridge University Engineering Department%%
%%                                                                            %%
%% Version: v2.4                                                              %%
%% Authors: Krishna Kumar                                                     %%
%% License: MIT License (c) 2016-2018 Krishna Kumar                           %%
%% GitHub Repo: https://github.com/kks32/phd-thesis-template/                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************************** Class Identification ******************************
\newcommand\fileversion{2.4}
\newcommand\filedate{2018/04/12}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PhDThesisPSnPDF}[\filedate\space A PhD thesis class file by Krishna Kumar (v\fileversion)]
\typeout{https://github.com/kks32/phd-thesis-template/}
% *************************** Class Definition **********************************
% ************************ Define a Print/Online Version ************************
\newif\if@print\@printfalse
\DeclareOption{print}{\@printtrue}
% **************************** Define index *************************************
\newif\ifPHD@index\PHD@indexfalse
\DeclareOption{index}{\PHD@indextrue}
% ***************************** Font Option *************************************
\newif\ifsetFont\setFontfalse
\newif\ifPHD@times\PHD@timesfalse
\DeclareOption{times}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was already specified.}
  \else
    \PHD@timestrue
    \setFonttrue
  \fi
}
\newif\ifPHD@fourier\PHD@fourierfalse
\DeclareOption{fourier}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was already specified.}
  \else
    \PHD@fouriertrue
    \setFonttrue
  \fi
}
\newif\ifsetCustomFont\setCustomFontfalse
\DeclareOption{customfont}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was already specified.}
  \else
    \setCustomFonttrue
    \setFonttrue
  \fi
}
% **************************** Bibliography *************************************
\newif\ifsetBib\setBibfalse
\newif\ifsetBiBLaTeX\setBiBLaTeXfalse
\newif\ifPHD@biblatex\PHD@biblatexfalse
\DeclareOption{biblatex}{
  \ifsetBib
    \ClassWarning{PhDThesisPSnPDF}{Bibliography selection conflict.}
  \else
    \PHD@biblatextrue
  \fi
}
\newif\ifPHD@authoryear\PHD@authoryearfalse
\DeclareOption{authoryear}{
  \ifsetBib
    \ClassWarning{PhDThesisPSnPDF}{Bibliography selection conflict.}
  \else
    \PHD@authoryeartrue
    \setBibtrue
  \fi
}
\newif\ifPHD@numbered\PHD@numberedfalse
\DeclareOption{numbered}{
  \ifsetBib
    \ClassWarning{PhDThesisPSnPDF}{Bibliography selection conflict.}
  \else
    \PHD@numberedtrue
    \setBibtrue
  \fi
}
\newif\ifuseCustomBib\useCustomBibfalse
\DeclareOption{custombib}{
  \ifsetBib
    \ClassWarning{PhDThesisPSnPDF}{Bibliography selection conflict.}
  \else
    \ifPHD@biblatex
      \ClassWarning{PhDThesisPSnPDF}{Bibliography selection conflict.}
    \else
      \useCustomBibtrue
      \setBibtrue
    \fi
  \fi
}
% ************************* Header / Footer Styling ****************************
\newif\ifPHD@textJustify\PHD@textJustifytrue
\DeclareOption{flushleft}{\PHD@textJustifyfalse}
\newif\ifPHD@pageStyleI\PHD@pageStyleIfalse
\DeclareOption{PageStyleI}{\PHD@pageStyleItrue}
\newif\ifPHD@pageStyleII\PHD@pageStyleIIfalse
\DeclareOption{PageStyleII}{\PHD@pageStyleIItrue}
% ************************** Custom Margins *************************************
\newif\ifsetCustomMargin\setCustomMarginfalse
\newif\ifsetMargin\setMarginfalse
\DeclareOption{custommargin}{\setCustomMargintrue}
% ************************** Separate Abstract **********************************
\newif \ifdefineAbstract\defineAbstractfalse
\newif\ifPHD@abstract\PHD@abstractfalse
\DeclareOption{abstract}{
  \PHD@abstracttrue
  \ClassWarning{PhDThesisPSnPDF}{You have chosen an option that generates only the Title page and an abstract.}
  \PassOptionsToClass{oneside}{book}
}
% ****************** Chapter Mode - To print only selected chapters ************
\newif \ifdefineChapter\defineChapterfalse
\newif\ifPHD@chapter\PHD@chapterfalse
\DeclareOption{chapter}{
  \PHD@chaptertrue
  \ClassWarning{PhDThesisPSnPDF}{You have chosen an option that generates only selected chapters.}
}
% ************************** Pre-defined Options ********************************
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}
\newcommand\PHD@papersize{a4paper}
\DeclareOption{a4paper}{\renewcommand\PHD@papersize{a4paper}}
\DeclareOption{a5paper}{\renewcommand\PHD@papersize{a5paper}}
\DeclareOption{letterpaper}{\renewcommand\PHD@papersize{letterpaper}}
\PassOptionsToClass{\PHD@papersize}{book}
\newif\if@oneside\@onesidefalse
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{book}\@onesidetrue}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{book}}
% **************************** Draft Option ************************************
\newif\ifsetDraft\setDraftfalse
\newif\ifsetDraftClassic\setDraftClassicfalse
\DeclareOption{draftclassic}{\PassOptionsToClass{draft}{book}\setDraftClassictrue}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}\setDrafttrue}
\newif\ifPHD@lineno\PHD@linenotrue
\DeclareOption{lineno}{\PHD@linenotrue}
\DeclareOption{nolineno}{\PHD@linenofalse}
\DeclareOption*{
  \ClassWarning{PhDThesisPSnPDF}{Unknown or non-standard option '\CurrentOption'.}
  \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessOptions\relax
\LoadClass{book}
% ************************** Packages ******************************************
% ************************ Layout and Formatting *******************************
\RequirePackage{lscape}
\RequirePackage{setspace}
\RequirePackage{calc}
% ************************* Conditional Statements *****************************
\RequirePackage{ifthen}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
% ********************* Table of Contents & Appendices ************************
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[title,titletoc]{appendix}
\renewcommand{\contentsname}{Table of contents}
\renewcommand{\listfigurename}{List of figures}
\renewcommand{\listtablename}{List of tables}
\let\temptableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
  \cleardoublepage
  \pdfbookmark[0]{\contentsname}{Contents}
  \temptableofcontents
}
% *************************** Graphics and Figures *****************************
\RequirePackage[usenames, dvipsnames]{color}
\ifpdf
  \RequirePackage{epstopdf}
  \RequirePackage[pdftex]{graphicx}
  \DeclareGraphicsExtensions{.png, .jpg, .pdf}
  \pdfcompresslevel=9
  \graphicspath{{Figs/Raster/}{Figs/}}
\else
  \RequirePackage{graphicx}
  \DeclareGraphicsExtensions{.eps, .ps}
  \graphicspath{{Figs/Vector/}{Figs/}}
\fi
% ******************************* Time Stamp ***********************************
\RequirePackage{datetime}
\newcount\PHD@hour \newcount\PHD@minute
\PHD@hour=\time
\divide \PHD@hour by 60
\PHD@minute=\time
\count@=\PHD@hour \multiply \count@ by -60 \advance \PHD@minute by \count@
\newcommand{\PHD@daytime}{%
  \today\space--\space%
  \ifnum\PHD@hour=0 00\else\ifnum\PHD@hour<10 0\fi%
  \number\PHD@hour\fi:\ifnum\PHD@minute<10 0\fi\number\PHD@minute
}
% ******************************* Draft Mode ***********************************
\newcommand\SetDraftText[1]{}
\newcommand\SetDraftVersion[1]{}
\newcommand\SetDraftWMPosition[1]{}
\newcommand\SetDraftGrayScale[1]{}
\ifsetDraftClassic
  \setkeys{Gin}{draft=true}
\fi
\ifsetDraft
  \setkeys{Gin}{draft=false}
  \ifPHD@lineno
    \RequirePackage[switch,pagewise,mathlines]{lineno}
    \renewcommand{\frontmatter}{%
      \cleardoublepage\@mainmatterfalse\pagenumbering{roman}\nolinenumbers}
    \renewcommand{\mainmatter}{%
      \cleardoublepage\@mainmattertrue\pagenumbering{arabic}\linenumbers}
    \renewcommand{\backmatter}{%
      \if@openright\cleardoublepage\else\clearpage\fi\@mainmatterfalse\linenumbers}
    \newcommand*\patchAmsMathEnvironmentForLineno[1]{%
      \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
      \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
      \renewenvironment{#1}{\linenomath\csname old#1\endcsname}{%
        \csname oldend#1\endcsname\endlinenomath}}
    \newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
      \patchAmsMathEnvironmentForLineno{#1}%
      \patchAmsMathEnvironmentForLineno{#1*}}
    \AtBeginDocument{%
      \patchBothAmsMathEnvironmentsForLineno{equation}%
      \patchBothAmsMathEnvironmentsForLineno{align}%
      \patchBothAmsMathEnvironmentsForLineno{flalign}%
      \patchBothAmsMathEnvironmentsForLineno{alignat}%
      \patchBothAmsMathEnvironmentsForLineno{gather}%
      \patchBothAmsMathEnvironmentsForLineno{multline}}
  \fi
  \newcommand\drafttext{Draft}
  \renewcommand\SetDraftText[1]{\renewcommand\drafttext{#1}}
  \newcommand\draftVersion{v1.0}
  \renewcommand\SetDraftVersion[1]{\renewcommand\draftVersion{#1}}
  \newcommand\draftGrayScale{0.75}
  \renewcommand\SetDraftGrayScale[1]{\renewcommand\draftGrayScale{#1}}
  \newcommand\DraftContent{%
    \hspace*{\fill}\Large\textcolor[gray]{\draftGrayScale}{%
      {\drafttext}\space-\space{\draftVersion}\hspace{\stretch{1}}{\PHD@daytime}\hspace*{\fill}}}
  \RequirePackage{everypage}
  \RequirePackage[absolute]{textpos}
  \newcommand\draftposition{top}
  \newcommand\draftnodeanchor{1in+\voffset-\topmargin}
  \AddEverypageHook{%
    \begin{textblock*}{\paperwidth}[0.,2.5](0\paperwidth,\draftnodeanchor)
    \DraftContent
    \end{textblock*}}
  \renewcommand\SetDraftWMPosition[1]{%
    \renewcommand\draftposition{#1}
    \ifthenelse{\equal{\draftposition}{bottom}}
      {\renewcommand\draftnodeanchor{\paperheight-\voffset}}
      {\ifthenelse{\equal{\draftposition}{top}}
        {\renewcommand\draftnodeanchor{1in+\voffset-\topmargin}}
        {\ClassWarning{PDThesisPSnPDF}{Unrecognised draft position}
          \renewcommand\draftnodeanchor{1in+\voffset-\topmargin}}}
    \AddEverypageHook{%
      \begin{textblock*}{\paperwidth}[0.,2.5](0\paperwidth,\draftnodeanchor)
      \DraftContent
      \end{textblock*}}}
\else
  \renewcommand\SetDraftText[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is inactive.}}
  \renewcommand\SetDraftVersion[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is inactive.}}
  \renewcommand\SetDraftWMPosition[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is inactive.}}
  \renewcommand\SetDraftGrayScale[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is inactive.}}
\fi
% ******************************* Bibliography *********************************
\ifPHD@authoryear
  \ifPHD@biblatex
    \RequirePackage[backend=biber, style=authoryear, citestyle=alphabetic, sorting=nty, natbib=true]{biblatex}
    \setBiBLaTeXtrue
  \else
    \RequirePackage[round, sort, numbers, authoryear]{natbib}
  \fi
\else
  \ifPHD@numbered
    \ifPHD@biblatex
      \RequirePackage[backend=biber, style=numeric-comp, citestyle=numeric, sorting=none, natbib=true]{biblatex}
      \setBiBLaTeXtrue
    \else
      \RequirePackage[numbers,compress]{natbib}
    \fi
  \else
    \ifuseCustomBib
      \AtBeginDocument{
        \@ifpackageloaded{natbib}{}{
          \@ifpackageloaded{biblatex}{}{
            \ClassWarning{PhDThesisPSnPDF}{You chose custom bibliography, but no corresponding package has been loaded.}
          }
        }
      }
    \else
      \ifPHD@biblatex
        \RequirePackage[backend=biber, style=numeric-comp, citestyle=numeric, sorting=none, natbib=true]{biblatex}
        \setBiBLaTeXfalse
      \else
        \RequirePackage[numbers,compress]{natbib}
      \fi
      \setBibfalse
    \fi
  \fi
\fi
\ifsetBib
\else
  \ClassWarning{PhDThesisPSnPDF}{No bibliography style was specified. Default numbered style is used.}
\fi
% ********************************** Fonts *************************************
\RequirePackage{textcomp}
\ifPHD@times
  \ifxetex
  \else
    \RequirePackage{mathptmx}
  \fi
  \setFonttrue
  \message{PhDThesisPSnPDF: Using Times Roman font}
\else
  \ifPHD@fourier
    \RequirePackage{fourier}
    \setFonttrue
    \message{PhDThesisPSnPDF: Using Fourier font}
  \else
    \ifsetCustomFont
      \setFonttrue
      \message{PhDThesisPSnPDF: Using custom font}
    \else
      \setFontfalse
      \message{PhDThesisPSnPDF: No font is set}
    \fi
  \fi
\fi
\ifsetFont
\else
  \ClassWarning{PhDThesisPSnPDF}{Using default font Latin Modern.}
  \RequirePackage{lmodern}
\fi
\ifxetex
  \usepackage{amsmath}
  \usepackage{fontspec}
  \usepackage[]{unicode-math}
  \setmainfont[
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-Italic,
    BoldItalicFont = *-BoldItalic,
  ]{XITS}
  \setmathfont[
    Extension = .otf,
    BoldFont = XITSMath-Bold,
  ]{XITSMath-Regular}
\else
  % default: pdfLaTeX
  % FIX for TeX Live 2025: defer inputenc/fontenc/microtype loading
  % to after the class group closes using \AtEndOfClass
  % inputenc, fontenc, microtype loaded from preamble.tex (TeX Live 2025 fix)
  \input{glyphtounicode}
  \pdfglyphtounicode{f_f}{FB00}
  \pdfglyphtounicode{f_i}{FB01}
  \pdfglyphtounicode{f_l}{FB02}
  \pdfglyphtounicode{f_f_i}{FB03}
  \pdfglyphtounicode{f_f_l}{FB04}
  \pdfgentounicode=1
  \RequirePackage{amsfonts}
  \RequirePackage{amsmath}
  \RequirePackage{amssymb}
\fi
\clubpenalty=10000
\widowpenalty=10000
% *************************** Print / Online ***********************************
\RequirePackage[unicode=true]{hyperref}
\if@print
  \hypersetup{
    final=true, plainpages=false, pdfstartview=FitV,
    pdftoolbar=true, pdfmenubar=true, bookmarksopen=true,
    bookmarksnumbered=true, breaklinks=true, linktocpage,
    colorlinks=true, linkcolor=black, urlcolor=black,
    citecolor=black, anchorcolor=black
  }
  \ifsetCustomMargin
  \else
    \RequirePackage[paper=\PHD@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75,bindingoffset=5mm]{geometry}
  \fi
  \if@twoside
    \hypersetup{pdfpagelayout=TwoPageRight}
  \else
    \hypersetup{pdfpagelayout=OneColumn}
  \fi
\else
  \hypersetup{
    final=true, plainpages=false, pdfstartview=FitV,
    pdftoolbar=true, pdfmenubar=true, bookmarksopen=true,
    bookmarksnumbered=true, breaklinks=true, linktocpage,
    colorlinks=true, linkcolor=blue, urlcolor=blue,
    citecolor=blue, anchorcolor=green
  }
  \ifsetCustomMargin
  \else
    \RequirePackage[paper=\PHD@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75]{geometry}
  \fi
  \hypersetup{pdfpagelayout=OneColumn}
\fi
% ************************** URL Package and Definition ************************
\RequirePackage{url}
\newcommand{\url@leostyle}{%
  \@ifundefined{selectfont}{\renewcommand{\UrlFont}{\sffamily}}
  {\renewcommand{\UrlFont}{\normalsize}}}
\urlstyle{leo}
\ifpdf
\else
  \ifxetex
  \else
    \RequirePackage{breakurl}
  \fi
\fi
% ************************** Pre-defined Settings ******************************
% ************************** Setting PDF Meta-Data *****************************
\ifpdf
  \AtBeginDocument{
    \hypersetup{
      pdftitle = {\@title},
      pdfauthor = {\@author},
      pdfsubject={\@subject},
      pdfkeywords={\@keywords}
    }
  }
\fi
% ******************************* Line Spacing *********************************
\renewcommand\baselinestretch{1.2}
% ******************************** Justification *******************************
\ifPHD@textJustify
  \message{PhDThesisPSnPDF: The University identity guidelines recommend using left aligned text.}
\else
  \AtBeginDocument{\raggedright}
\fi
% ************************** TOC and Hide Sections *****************************
\newcommand{\nocontentsline}[3]{}
\newcommand{\tochide}[2]{\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup}
\addtocontents{toc}{\protect\thispagestyle{empty}}
% ************************** Header Formatting *********************************
\RequirePackage{fancyhdr}
\fancypagestyle{PageStyleI}{
  \renewcommand{\chaptermark}[1]{\markboth{##1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1\ }}
  \fancyhf{}
  \fancyhead[RO]{\nouppercase \rightmark\hspace{0.25em} | \hspace{0.25em} \bfseries{\thepage}}
  \fancyhead[LE]{{\bfseries\thepage} \hspace{0.25em} | \hspace{0.25em} \nouppercase \leftmark}
}
\fancypagestyle{PageStyleII}{
  \renewcommand{\chaptermark}[1]{\markboth{##1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
  \fancyhf{}
  \fancyhead[RO]{\bfseries\nouppercase \rightmark}
  \fancyhead[LE]{\bfseries \nouppercase \leftmark}
  \fancyfoot[C]{\thepage}
}
\newcommand{\setFancyHdr}{
  \pagestyle{fancy}
  \ifPHD@pageStyleI
    \pagestyle{PageStyleI}
  \else
    \ifPHD@pageStyleII
      \pagestyle{PageStyleII}
    \else
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}
      \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
      \fancyhf{}
      \fancyhead[LO]{\nouppercase \rightmark}
      \fancyhead[LE,RO]{\bfseries\thepage}
      \fancyhead[RE]{\nouppercase \leftmark}
    \fi
  \fi
}
\setlength{\headheight}{14.5pt}
\fancypagestyle{plain}{
  \fancyhead{}
  \renewcommand{\headrulewidth}{0pt}
}
\ifsetCustomMargin
  \AtBeginDocument{
    \@ifpackageloaded{geometry}{}{\ClassWarning{PhDThesisPSnPDF}{Custom margin is chosen, but geometry package is not loaded.}}
  }
\else
  \setFancyHdr
\fi
% **************** Clear Header Style on the Last Empty Odd pages **************
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else%
  \hbox{}%
  \thispagestyle{empty}
  \newpage%
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}
% **************************** Macro Definitions *******************************
% Subtitle (optional)
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
% The year and term the degree will be officially conferred
\newcommand{\@degreedate}{\monthname[\the\month]\space\the\year}
\newcommand{\degreedate}[1]{\renewcommand{\@degreedate}{#1}}
% The full (unabbreviated) name of the degree
\newcommand{\@degreetitle}{}
\newcommand{\degreetitle}[1]{\renewcommand{\@degreetitle}{#1}}
% The name of your department
\newcommand{\@dept}{}
\newcommand{\dept}[1]{\renewcommand{\@dept}{#1}}
% The name of your college
\newcommand{\@college}{}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
% The name of your University
\newcommand{\@university}{}
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}
% Defining the crest
\newcommand{\@crest}{}
\newcommand{\crest}[1]{\renewcommand{\@crest}{#1}}
% Defining the college crest
\newif\ifPHD@collegeshield\PHD@collegeshieldfalse
\newcommand{\@collegeshield}{}
\newcommand{\collegeshield}[1]{\renewcommand{\@collegeshield}{#1}\PHD@collegeshieldtrue}
% Supervisor
\newif\ifPHD@supervisor\PHD@supervisorfalse
\newcommand{\@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}\PHD@supervisortrue}
\newcommand{\@supervisorrole}{Supervisor: }
\newcommand{\supervisorrole}[1]{\renewcommand{\@supervisorrole}{#1}}
\newcommand{\@supervisorlinewidth}{0.35\textwidth}
\newcommand{\supervisorlinewidth}[1]{\renewcommand{\@supervisorlinewidth}{#1}}
% Advisor
\newif\ifPHD@advisor\PHD@advisorfalse
\newcommand{\@advisor}{}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}\PHD@advisortrue}
\newcommand{\@advisorrole}{Advisor: }
\newcommand{\advisorrole}[1]{\renewcommand{\@advisorrole}{#1}}
\newcommand{\@advisorlinewidth}{0.25\textwidth}
\newcommand{\advisorlinewidth}[1]{\renewcommand{\@advisorlinewidth}{#1}}
% Submission Text
\newcommand{\submissiontext}{This dissertation is submitted for the degree of }
% keywords
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}
% subjectline
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}
% Declaration title text
\newcommand{\@declarationtitle}{Declaration}
\newcommand{\@acknowledgementstitle}{Acknowledgements}
\newcommand{\@abstracttitle}{Abstract}
% Names for the nomenclature groups
\newcommand{\@nomenclatureromans}{Roman Symbols}
\newcommand{\@nomenclaturegreeks}{Greek Symbols}
\newcommand{\@nomenclatureacronyms}{Acronyms / Abbreviations}
\newcommand{\@nomenclaturesuperscripts}{Superscripts}
\newcommand{\@nomenclaturesubscripts}{Subscripts}
\newcommand{\@nomenclatureothers}{Other Symbols}
% Single column environment
\newenvironment{alwayssingle}{%
  \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \else\newpage\fi}
  {\if@restonecol\twocolumn\else\newpage\fi}
\newcommand{\setsinglecolumn}{
  \if@twocolumn
    \onecolumn
  \else
  \fi
}
% **************************** Front Matter Layout *****************************
% ******************************** Title Page **********************************
\renewcommand{\maketitle}{
  \computeTitlePageSpacing
  \thispagestyle{empty}
  \begin{singlespace}
  \begin{center}
    \ifPHD@collegeshield%
      {\usebox{\PHD@crest}}
      \vspace{.15\PHD@titlepagespacing}
    \fi
    {\usebox{\PHD@Title}}
    \ifPHD@collegeshield%
      \vspace{.15\PHD@titlepagespacing}
      {\usebox{\PHD@collegecrest}}
      \vspace{.1\PHD@titlepagespacing}
    \else
      \vspace{.25\PHD@titlepagespacing}
      {\usebox{\PHD@crest}}
      \vspace{.15\PHD@titlepagespacing}
    \fi
    {\usebox{\PHD@author}}
    \vspace*{1em}
    \ifPHD@supervisor%
      {\usebox{\PHD@supervisor}}
      \vspace*{0.5em}
    \fi
    \ifPHD@advisor%
      {\usebox{\PHD@advisor}}
      \vspace*{0.5em}
    \fi
    {\usebox{\PHD@dept}}
    \vspace{.2\PHD@titlepagespacing}
    {\usebox{\PHD@submission}}
    \vfill
    {\usebox{\PHD@collegedate}}
  \end{center}
  \end{singlespace}
}
% ******************************** Dedication **********************************
\newenvironment{dedication}
{
  \cleardoublepage
  \setsinglecolumn
  \vspace*{0.2\textheight}
  \thispagestyle{empty}
  \centering
}{}
% ******************************* Declaration **********************************
\newenvironment{declaration}{
  \cleardoublepage
  \setsinglecolumn
  \chapter*{\centering \Large \@declarationtitle}
  \thispagestyle{empty}
}{
  \flushright
  \@author{}\\\
  \@degreedate{}
  \vfill
}
% ***************************** Acknowledgements *******************************
\newenvironment{acknowledgements}{
  \cleardoublepage
  \setsinglecolumn
  \chapter*{\centering \Large \@acknowledgementstitle}
  \thispagestyle{empty}
}{}
% ******************************* Nomenclature *********************************
\RequirePackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nomgroup}[1]{%
  \ifthenelse{\equal{#1}{A}}{\item[\textbf{\@nomenclatureromans}]}{%
  \ifthenelse{\equal{#1}{G}}{\item[\textbf{\@nomenclaturegreeks}]}{%
  \ifthenelse{\equal{#1}{Z}}{\item[\textbf{\@nomenclatureacronyms}]}{%
  \ifthenelse{\equal{#1}{R}}{\item[\textbf{\@nomenclaturesuperscripts}]}{%
  \ifthenelse{\equal{#1}{S}}{\item[\textbf{\@nomenclaturesubscripts}]}{%
  \ifthenelse{\equal{#1}{X}}{\item[\textbf{\@nomenclatureothers}]}
    {}}}}}}}
\renewcommand{\nompreamble}{\markboth{\nomname}{\nomname}}
\newcommand{\printnomencl}[1][]{
  \ifthenelse{\equal{#1}{}}
  {\printnomenclature}
  {\printnomenclature[#1]}
}
% ******************************* Create the index *****************************
\ifPHD@index
  \RequirePackage{makeidx}
  \makeindex
  \newcommand{\printthesisindex}{
    \cleardoublepage
    \phantomsection
    \printindex}
\else
  \newcommand{\printthesisindex}{}
\fi
% ******************************* Chapter Mode *********************************
\ifPHD@chapter
  \defineChaptertrue
  \renewcommand{\maketitle}{}
  \renewcommand{\tableofcontents}{}
  \renewcommand{\listoffigures}{}
  \renewcommand{\listoftables}{}
  \renewcommand{\printnomencl}{}
  \renewcommand{\printthesisindex}{}
\else
  \defineChapterfalse
\fi
% ********************************** Abstract **********************************
\ifPHD@abstract
  \defineAbstracttrue
  \renewcommand{\tableofcontents}{}
  \renewcommand{\listoffigures}{}
  \renewcommand{\listoftables}{}
  \renewcommand{\printnomencl}{}
  \renewcommand{\printnomencl}[1][2]{}
  \renewcommand{\printthesisindex}{}
  \renewcommand{\bibname}{}
  \renewcommand{\bibliography}[1]{\thispagestyle{empty}}
\else
  \defineAbstractfalse
\fi
\newenvironment{abstract}
{
  \ifPHD@abstract
    \thispagestyle{empty}
    \setsinglecolumn
    \begin{center}
      {\Large {\bfseries {\@title}} \par}
      {{\large \vspace*{1em} \@author} \par}
    \end{center}
  \else
    \cleardoublepage
    \setsinglecolumn
    \chapter*{\centering \Large \@abstracttitle}
    \thispagestyle{empty}
  \fi
}{}
% ********************* To compute empty space in title page ******************
\newcommand{\computeTitlePageSpacing}{
% Title Box
\newsavebox{\PHD@Title}
\begin{lrbox}{\PHD@Title}
  \begin{minipage}[c]{0.98\textwidth}
    \centering \Huge \bfseries{\@title}
    \ifthenelse{\equal{\@subtitle}{}}{}{
      \\ \centering \Large {\@subtitle}
    }
  \end{minipage}
\end{lrbox}
% University Crest Box
\newsavebox{\PHD@crest}
\begin{lrbox}{\PHD@crest}
  {\@crest \par}
\end{lrbox}
\newsavebox{\PHD@collegecrest}
\begin{lrbox}{\PHD@collegecrest}
  \ifPHD@collegeshield%
    {\@collegeshield}
  \else
  \fi
\end{lrbox}
% Author Box
\newsavebox{\PHD@author}
\begin{lrbox}{\PHD@author}
  \begin{minipage}[c]{\textwidth}
    \centering \Large \bfseries{\@author}
    \vspace{0.5em}
  \end{minipage}
\end{lrbox}
% Supervisor Box
\newsavebox{\PHD@supervisor}
\begin{lrbox}{\PHD@supervisor}
  \begin{minipage}[c]{\textwidth}
    \ifthenelse{\equal{\@supervisor}{}}{}{
      \begin{center}
        \makebox[\widthof{supervisorrole} + \@supervisorlinewidth][c]{
          \Large \@supervisorrole \parbox[t]{\@supervisorlinewidth}{\@supervisor}
        }
      \end{center}
      \vspace{0.5em}
    }
  \end{minipage}
\end{lrbox}
% Advisor Box
\newsavebox{\PHD@advisor}
\begin{lrbox}{\PHD@advisor}
  \begin{minipage}[c]{\textwidth}
    \ifthenelse{\equal{\@advisor}{}}{}{
      \begin{center}
        \makebox[\widthof{advisorrole} + \@advisorlinewidth][c]{
          \Large \@advisorrole \parbox[t]{\@advisorlinewidth}{\@advisor}
        }
      \end{center}
      \vspace{0.5em}
    }
  \end{minipage}
\end{lrbox}
% Department Box
\newsavebox{\PHD@dept}
\begin{lrbox}{\PHD@dept}
  \begin{minipage}[c]{\textwidth}
    \centering {\large \@dept \par} {\large \@university \par}
  \end{minipage}
\end{lrbox}
% Submission Box
\newsavebox{\PHD@submission}
\begin{lrbox}{\PHD@submission}
  \begin{minipage}[c]{0.98\textwidth}
    \begin{center}
      \large \submissiontext \par
      \large \textit {\@degreetitle} \par
    \end{center}
  \end{minipage}
\end{lrbox}
% College and Date Box
\newsavebox{\PHD@collegedate}
\begin{lrbox}{\PHD@collegedate}
  \begin{minipage}[c]{\textwidth}
    \centering \large {\@college} \par
    \large {\@degreedate}
  \end{minipage}
\end{lrbox}
%  Now to compute the free vertical space
\newlength{\PHD@titlepagespacing}
\setlength{\PHD@titlepagespacing}{ \textheight %
  - \totalheightof{\PHD@Title} %
  - \totalheightof{\PHD@crest} %
  - \totalheightof{\PHD@collegecrest} %
  - \totalheightof{\PHD@author} %
  - \totalheightof{\PHD@supervisor} %
  - \totalheightof{\PHD@advisor} %
  - \totalheightof{\PHD@dept} %
  - \totalheightof{\PHD@submission} %
  - \totalheightof{\PHD@collegedate}%
}
}