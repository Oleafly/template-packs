% Open Universiteit Thesis Class
%
% Based on the NMBU Thesis Class by Leonardo Rydin Gorjão (2026).
%% This class can be redistributed and/or modified freely.

\NeedsTeXFormat{LaTeX2e}[2020-10-01]
\ProvidesClass{OU}
  [2026/08/25 v0.1.1 Open Universiteit Master's thesis class]

% List of all options available:
% - a4paper: A4 paper (fixed for the Master's thesis template)
% - en: English writing
% - nl: Dutch writing
% - book: Use chapters as the highest division (default)
% - article: Use sections as the highest division for legacy documents
% - departmentcolour=<xcolor name>: Colour used for structural headings and
%   chapter transition pages (default: OUred). Examples include OUred
%   (standard) and OUES (Env. Sci. in Green). For a custom colour, define it and
%   then use \departmentcolour{<name>} in the thesis preamble.
% - redheadings / blackheadings: Compatibility aliases for OUred / black
% - APA: Use APA 7th citation style (default is numeric)
% - listoffigures: Add a list of figures to the thesis
% - listoftables: Add a list of tables to the thesis
% - acronyms: Add the acronym list supplied with \acronyms{...}
% - forewordfirst: Place the foreword before the abstracts

% Word of advice: When you are done with your thesis, change the compiler in 
% Overleaf to XeLaTeX! This will make your fonts and title page look much nicer 
% than in pdfLaTeX. Just go to "Menu", in the "Settings", find "Compiler" and 
% change to XeLaTeX.

% This documentclass also comes with a "main.tex" file to help you understand 
% the use of the different commands and how to best write an academic thesis, as
% well as an exemplary bibliography file with a few explanations therein.

% The OU class is designed to help you write your thesis, while printing the
% cover and back page automatically, and managing the metadata of your thesis.
% Make sure to include the information below to generate your title. You can set
% the language you are writing in with "en" for English or "nl" for Dutch.

% A table of contents is automatically included. If you have more than one 
% figure, you need a list of figures by adding "listoffigures" to the 
% documentclass parameters. If you have more than one table, you need a list of
% tables by adding "listoftables" to the documentclass parameters.

% There are two primary styles of references/bibliography used: "numeric" and 
% "APA" reference styles (APA 7th). "numeric" style uses numbers in your 
% citation, e.g., [1,2]. "APA", following the American Psychological 
% and will organise the authors differently in the reference list at the end of 
% your document. Add "APA" in the document class if you want to use this style. 
% Confer with your supervisor(s) on which style is preferable. To print the 
% references, use "\references" at the end of your document, but before your 
% appendices!

% Your appendix or appendices should come after your references. To start your 
% appendix section, use "\appendices"

% Compile the thesis with XeLaTeX. This gives consistent Unicode handling and
% portable sans-serif typography for the OU cover and contents pages.

% In your .tex file, you need to include the following information to produce 
% the first page of your thesis


% \title{}
% \shorttitle{} % Optional compact form used on even main-matter footers
% \subtitle{}
% \author{}
% \studentnumber{}
% \submissiondate{} % Month and year only, for example August 2026
% \thesisyear{}
% \credits{30}
% \faculty{Faculty of Science}
% \studyprogramme{Master Environmental Sciences}
% \alttitle{} % Title in the language other than the class language
% \altsubtitle{} % Subtitle in the language other than the class language
% \supervisor{} % One supervisor: full title, name, and affiliation(s)
% \supervisor[Supervisors]{} % Use the optional label for multiple supervisors
% \examiner{} % Full title, name, and affiliation(s)
% \assessor{} % Full title, name, and affiliation(s)
% \externalsupervisors{} % Optional; multiple entries may be separated with \\
% \abstract{}
% \samenvatting{}
% \website{ou.nl} % Optional override
% \universityaddress{} % Optional override

% The study programme and faculty are retained as PDF metadata and are printed
% in the appropriate cover and running-matter positions.

\newif\ifOU@book
\newif\ifOU@article
\newif\ifOU@apa
\newif\ifOU@listoffigures
\newif\ifOU@listoftables
\newif\ifOU@acronyms
\newif\ifOU@forewordfirst
\newif\ifOU@namedauthorsalias
\newif\ifOU@redheadings

\def\OU@language{en}
\def\OU@fontsize{}
\def\OU@baseoptions{}
\def\OU@departmentcolour{OUred}

\def\OU@addbaseoption#1{%
  \ifx\OU@baseoptions\@empty
    \edef\OU@baseoptions{#1}%
  \else
    \edef\OU@baseoptions{\OU@baseoptions,#1}%
  \fi
}

\DeclareOption{article}{%
  \OU@bookfalse
}
\DeclareOption{book}{\OU@booktrue}

\DeclareOption{10pt}{\def\OU@fontsize{10pt}}
\DeclareOption{11pt}{\def\OU@fontsize{11pt}}
\DeclareOption{12pt}{\def\OU@fontsize{12pt}}

\DeclareOption{en}{\def\OU@language{en}}
\DeclareOption{nl}{\def\OU@language{nl}}

\DeclareOption{masters}{}
\DeclareOption{a4paper}{}
\DeclareOption{redheadings}{%
  \OU@redheadingstrue
  \def\OU@departmentcolour{OUred}%
}
\DeclareOption{blackheadings}{%
  \OU@redheadingsfalse
  \def\OU@departmentcolour{black}%
}

\DeclareOption{APA}{\OU@apatrue}
\DeclareOption{apa}{\OU@apatrue}
\DeclareOption{namedauthors}{%
  \OU@apatrue
  \OU@namedauthorsaliastrue
}
\DeclareOption{listoffigures}{\OU@listoffigurestrue}
\DeclareOption{listoftables}{\OU@listoftablestrue}
\DeclareOption{acronyms}{\OU@acronymstrue}
\DeclareOption{forewordfirst}{\OU@forewordfirsttrue}

% Accept departmentcolour=<xcolor name> as a genuine class option while still
% forwarding unrelated options to the base book/article class.
\def\OU@departmentcolourkey{departmentcolour}
\def\OU@departmentcolorkey{departmentcolor}
\def\OU@parseclassoption#1=#2=#3\@nil{%
  \def\OU@optionkey{#1}%
  \ifx\OU@optionkey\OU@departmentcolourkey
    \def\OU@departmentcolour{#2}%
  \else
    \ifx\OU@optionkey\OU@departmentcolorkey
      \def\OU@departmentcolour{#2}%
    \else
      \expandafter\OU@addbaseoption\expandafter{\CurrentOption}%
    \fi
  \fi
}
\DeclareOption*{%
  \expandafter\OU@parseclassoption\CurrentOption==\@nil
}

\ExecuteOptions{en,book,redheadings}
\ProcessOptions*\relax

% Master's theses may use 10 pt, 11 pt, or 12 pt body text; 11 pt is default.
\ifx\OU@fontsize\@empty
  \def\OU@fontsize{11pt}%
\fi

\ifOU@book
  \OU@articlefalse
  \def\OU@baseclass{book}%
\else
  \OU@articletrue
  \def\OU@baseclass{article}%
\fi

\ifx\OU@baseoptions\@empty\else
  \expandafter\PassOptionsToClass\expandafter{\OU@baseoptions}{\OU@baseclass}%
\fi
\ifOU@book
  % Chapter dividers sit directly beside their chapters, without inserted
  % recto-only blank pages.
  \LoadClass[\OU@fontsize,a4paper,oneside,openany]{book}%
\else
  \LoadClass[\OU@fontsize,a4paper]{article}%
\fi

\let\ifBook\ifOU@book
\let\Booktrue\OU@booktrue
\let\Bookfalse\OU@bookfalse
\let\ifArticle\ifOU@article
\let\Articletrue\OU@articletrue
\let\Articlefalse\OU@articlefalse

\ifOU@book
  \renewcommand{\cleardoublepage}{%
    \clearpage
    \if@twoside
      \ifodd\c@page\else
        \hbox{}%
        \thispagestyle{empty}%
        \newpage
        \if@twocolumn
          \hbox{}%
          \newpage
        \fi
      \fi
    \fi
  }
\fi

\RequirePackage{iftex}
\RequirePackage{mathtools,amssymb,amsfonts}
\RequirePackage{graphicx}
\RequirePackage[table,dvipsnames]{xcolor}
\definecolor{OUred}{RGB}{226,0,26}

% Environmental Sciences department colour
\definecolor{OUES}{RGB}{53,153,69}



% Primary
\definecolor{OUred}{RGB}{226,0,26}
\definecolor{OUyellow}{RGB}{247,221,0}
\definecolor{OUgreen}{RGB}{53,153,69}
\definecolor{OUmagenta}{RGB}{198,30,116}
\definecolor{OUviolet}{RGB}{95,70,138}
\definecolor{OUblue}{RGB}{75,166,223}
\definecolor{OUteal}{RGB}{76,174,169}
% \definecolor{OUcharcoal}{RGB}{85,87,91}
\definecolor{OUgrey}{RGB}{245,245,245}

% Secondary
\definecolor{OUdarkred}{RGB}{134,29,25}
\definecolor{OUolive}{RGB}{169,152,41}
\definecolor{OUdarkgreen}{RGB}{61,112,57}
\definecolor{OUdarkmagenta}{RGB}{139,25,94}
\definecolor{OUdarkviolet}{RGB}{70,45,100}
\definecolor{OUdarkblue}{RGB}{67,114,156}
\definecolor{OUdarkteal}{RGB}{66,118,111}
\definecolor{OUdarksilver}{RGB}{48,48,49}

% Others
\definecolor{OUcharcoal}{RGB}{35,35,35}
\definecolor{OUvisualgrey}{RGB}{91,91,91}
\definecolor{OUvisualgreyLight}{RGB}{180,180,180}
\colorlet{OUdepartment}{\OU@departmentcolour}

% This command is useful when the desired xcolor colour is defined in the
% thesis preamble rather than supplied directly as a class option.
\newcommand{\departmentcolour}[1]{\colorlet{OUdepartment}{#1}}
\let\departmentcolor\departmentcolour
\RequirePackage{geometry}
\geometry{a4paper,left=3.5cm,right=3.5cm,top=3.5cm,bottom=3cm}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable,skins}

\frenchspacing
\linespread{1.15}

% Body text retains the standard Computer Modern/Latin Modern serif family.
% Covers, running heads, and every document heading use a separate sans-serif
% family so the typographic roles remain explicit.
% Covers, running heads, and headings use Arial when available.
% Metrically similar open fonts are selected as fallbacks.
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage{helvet}
  \newcommand*\OU@coverfont{\sffamily}
\else
  \RequirePackage{fontspec}
  \IfFontExistsTF{Arial}{%
    \newfontfamily\OU@coverfont{Arial}[Ligatures=TeX]%
  }{%
    \IfFontExistsTF{Liberation Sans}{%
      \newfontfamily\OU@coverfont{Liberation Sans}[Ligatures=TeX]%
      \ClassWarningNoLine{OU}{%
        Arial not found; using Liberation Sans%
      }%
    }{%
      \IfFontExistsTF{TeX Gyre Heros}{%
        \newfontfamily\OU@coverfont{TeX Gyre Heros}[Ligatures=TeX]%
        \ClassWarningNoLine{OU}{%
          Arial not found; using TeX Gyre Heros%
        }%
      }{%
        \newfontfamily\OU@coverfont{Latin Modern Sans}[Ligatures=TeX]%
        \ClassWarningNoLine{OU}{%
          Arial not found; using Latin Modern Sans%
        }%
      }%
    }%
  }%
\fi

% Keep the body text serif.
\renewcommand{\familydefault}{\rmdefault}

% Compatibility and semantic aliases.
\providecommand*\arial{\OU@coverfont}
\newcommand*\OU@headingfont{\OU@coverfont}

\newcommand*\OU@headingcolour{%
  \color{OUdepartment}%
}

% --------------------------------------------------------------------------
% Heading typography
% --------------------------------------------------------------------------
% The body remains serif. Structural headings are sans serif and optionally
% use OU red through the `redheadings' class option.
\ifOU@book
  \def\@makechapterhead#1{%
    \vspace*{28\p@}%
    {\parindent\z@\raggedright\normalfont\OU@headingfont\OU@headingcolour
      \ifnum\c@secnumdepth>\m@ne
        \if@mainmatter
          \bfseries\fontsize{72pt}{72pt}\selectfont\thechapter
          \par\nobreak
          \vskip 16\p@
        \fi
      \fi
      \interlinepenalty\@M
      \Huge\bfseries #1\par\nobreak
      \vskip 40\p@
    }%
  }%
  \def\@makeschapterhead#1{%
    \vspace*{50\p@}%
    {\parindent\z@\raggedright\normalfont\OU@headingfont\OU@headingcolour
      \interlinepenalty\@M
      \Huge\bfseries #1\par\nobreak
      \vskip 40\p@
    }%
  }%
\fi
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus .2ex}%
  {\normalfont\OU@headingfont\OU@headingcolour\Large\bfseries}}%
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\OU@headingfont\OU@headingcolour\large\bfseries}}%
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\OU@headingfont\OU@headingcolour\normalsize\bfseries}}%
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus 1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\OU@headingfont\OU@headingcolour\normalsize\bfseries}}%
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus 1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\OU@headingfont\OU@headingcolour\normalsize\bfseries}}%

\newif\ifEnglish
\def\OU@en{en}
\def\OU@nl{nl}

\ifx\OU@language\OU@en
  \Englishtrue
  \RequirePackage[english]{babel}
  \def\OU@creditslabel{ECTS}%
  \def\OU@abstractname{Abstract}%
  \def\OU@summaryname{Samenvatting}%
  \def\OU@acknowledgementsname{Acknowledgements}%
  \def\OU@forewordname{Foreword}%
  \def\OU@figureslabel{FIGURES}%
  \def\OU@tableslabel{TABLES}%
  \def\OU@acronymsname{ACRONYMS}%
  \def\OU@contentslabel{CONTENT}%
  \def\OU@thesislabel{Master's Thesis}%
\else
  \Englishfalse
  \RequirePackage[provide=*,dutch]{babel}
  \def\OU@creditslabel{ECTS}%
  \def\OU@abstractname{Abstract}%
  \def\OU@summaryname{Samenvatting}%
  \def\OU@acknowledgementsname{Dankwoord}%
  \def\OU@forewordname{Voorwoord}%
  \def\OU@figureslabel{FIGUREN}%
  \def\OU@tableslabel{TABELLEN}%
  \def\OU@acronymsname{AFKORTINGEN}%
  \def\OU@contentslabel{INHOUD}%
  \def\OU@thesislabel{Masterscriptie}%
\fi
\RequirePackage{csquotes}

% Keep the standard LaTeX names consistent with the visible OU list headings.
% The delayed assignment prevents babel from restoring mixed-case defaults at
% the start of the document.
\AtBeginDocument{%
  \renewcommand{\contentsname}{\OU@contentslabel}%
  \renewcommand{\listfigurename}{\OU@figureslabel}%
  \renewcommand{\listtablename}{\OU@tableslabel}%
}

\newcommand*\MT{\OU@thesislabel}
\newcommand*\ECTS{\OU@creditslabel}

\let\ifAPA\ifOU@apa
\let\ifListoffigures\ifOU@listoffigures
\let\ifListoftables\ifOU@listoftables
\let\ifAcronyms\ifOU@acronyms
\let\ifForewordfirst\ifOU@forewordfirst

\ifOU@namedauthorsalias
  \ClassWarningNoLine{OU}{Option `namedauthors' is deprecated; use `APA'}%
\fi

\RequirePackage{url}
\newif\ifOU@biblatexavailable
\IfFileExists{biblatex.sty}{%
  \OU@biblatexavailabletrue
  \ifOU@apa
    \RequirePackage[
      style=apa,
      giveninits=true,
      doi=true,
      isbn=true,
      url=true,
      maxbibnames=19,
      backend=biber
    ]{biblatex}
  \else
    \RequirePackage[
      style=numeric,
      giveninits=true,
      doi=true,
      isbn=true,
      url=true,
      maxbibnames=19,
      sorting=none,
      sortcites=true,
      backend=biber
    ]{biblatex}
  \fi
}{%
  \OU@biblatexavailablefalse
  \ClassWarningNoLine{OU}{Package `biblatex' not found; bibliography commands
  are unavailable in this installation}%
}
\urlstyle{same}

\RequirePackage[
  unicode=true,
  pdfencoding=auto,
  psdextra,
  colorlinks=true,
  linkcolor=OUred,
  urlcolor=OUred,
  citecolor=OUred,
  filecolor=OUred,
  anchorcolor=OUred,
  breaklinks=true,
  bookmarksnumbered=true,
  pdfdisplaydoctitle=true
]{hyperref}

\ifOU@biblatexavailable
  \newcommand{\references}{%
    \begingroup
      \sloppy
      \setlength\bibitemsep{0pt}%
      \printbibliography[heading=bibintoc]%
    \endgroup
  }
\else
  \newcommand{\references}{%
    \ClassError{OU}{Bibliography support requires the `biblatex' package}{%
      Install biblatex and Biber, then compile the thesis again.}%
  }
\fi

\providecommand\@title{}
\providecommand\@author{}
\def\OU@subtitle{}
\def\OU@studentnumber{}
\def\OU@submissiondate{}
\def\OU@studyprogramme{}
\def\OU@thesisyear{}
\def\OU@credits{}
\def\OU@faculty{}
\def\OU@alttitle{}
\def\OU@altsubtitle{}
\def\OU@supervisor{}
\def\OU@supervisorlabel{Supervisor}
\def\OU@examiner{}
\def\OU@assessor{}
\def\OU@externalsupervisors{}

\newcommand{\subtitle}[1]{\gdef\OU@subtitle{#1}}
\newcommand{\studentnumber}[1]{\gdef\OU@studentnumber{#1}}
\newcommand{\submissiondate}[1]{\gdef\OU@submissiondate{#1}}
\let\thesisdate\submissiondate
\newcommand{\studyprogramme}[1]{\gdef\OU@studyprogramme{#1}}
\newcommand{\thesisyear}[1]{\gdef\OU@thesisyear{#1}}
\newcommand{\credits}[1]{\gdef\OU@credits{#1}}
\newcommand{\faculty}[1]{\gdef\OU@faculty{#1}}
\newcommand{\alttitle}[1]{\gdef\OU@alttitle{#1}}
\newcommand{\altsubtitle}[1]{\gdef\OU@altsubtitle{#1}}

\newcommand{\englishtitle}[1]{%
  \ClassWarningNoLine{OU}{Command \string\englishtitle\space is deprecated;
  use \string\title\space or \string\alttitle\space according to the class language}%
  \ifEnglish\title{#1}\else\alttitle{#1}\fi
}
\let\engtitle\englishtitle
\newcommand{\englishsubtitle}[1]{%
  \ClassWarningNoLine{OU}{Command \string\englishsubtitle\space is deprecated;
  use \string\subtitle\space or \string\altsubtitle\space according to the class language}%
  \ifEnglish\subtitle{#1}\else\altsubtitle{#1}\fi
}
\let\engsubtitle\englishsubtitle
\newcommand{\dutchtitle}[1]{%
  \ClassWarningNoLine{OU}{Command \string\dutchtitle\space is deprecated;
  use \string\title\space or \string\alttitle\space according to the class language}%
  \ifEnglish\alttitle{#1}\else\title{#1}\fi
}
\let\nltitle\dutchtitle
\newcommand{\dutchsubtitle}[1]{%
  \ClassWarningNoLine{OU}{Command \string\dutchsubtitle\space is deprecated;
  use \string\subtitle\space or \string\altsubtitle\space according to the class language}%
  \ifEnglish\altsubtitle{#1}\else\subtitle{#1}\fi
}
\let\nlsubtitle\dutchsubtitle
\NewDocumentCommand{\supervisor}{O{Supervisor} m}{%
  \gdef\OU@supervisorlabel{#1}%
  \gdef\OU@supervisor{#2}%
}
\newcommand{\examiner}[1]{\gdef\OU@examiner{#1}}
\newcommand{\assessor}[1]{\gdef\OU@assessor{#1}}
\newcommand{\externalsupervisors}[1]{\gdef\OU@externalsupervisors{#1}}

\newcommand{\printtitle}{%
  \ifx\@title\@empty Insert Thesis Title\else\@title\fi
}
\newcommand{\printsubtitle}{%
  \ifx\OU@subtitle\@empty Insert Thesis Subtitle\else\OU@subtitle\fi
}
\newcommand{\printauthor}{%
  \ifx\@author\@empty Your name\else\@author\fi
}
\newcommand{\printstudentnumber}{%
  \ifx\OU@studentnumber\@empty Student number\else\OU@studentnumber\fi
}
\newcommand{\printsubmissiondate}{%
  \ifx\OU@submissiondate\@empty Month Year\else\OU@submissiondate\fi
}
\newcommand{\printstudyprogramme}{\OU@studyprogramme}
\newcommand{\printyear}{%
  \ifx\OU@thesisyear\@empty 20XX\else\OU@thesisyear\fi
}
\newcommand{\printthesisyear}{%
  \MT~\printyear
}
\newcommand{\printcredits}{%
  \ifx\OU@credits\@empty XX\else\OU@credits\fi~\ECTS
}
\newcommand{\printfaculty}{%
  \ifx\OU@faculty\@empty
    Insert Name of the Faculty where the Thesis has been completed%
  \else
    \OU@faculty
  \fi
}
\newcommand{\printengtitle}{%
  \ifEnglish
    \printtitle
  \else
    \ifx\OU@alttitle\@empty Insert English Thesis Title\else\OU@alttitle\fi
  \fi
}
\newcommand{\printengsubtitle}{%
  \ifEnglish
    \printsubtitle
  \else
    \ifx\OU@altsubtitle\@empty Insert English Thesis Subtitle\else\OU@altsubtitle\fi
  \fi
}
\newcommand{\printnltitle}{%
  \ifEnglish
    \ifx\OU@alttitle\@empty Insert Dutch Thesis Title\else\OU@alttitle\fi
  \else
    \printtitle
  \fi
}
\newcommand{\printnlsubtitle}{%
  \ifEnglish
    \ifx\OU@altsubtitle\@empty Insert Dutch Thesis Subtitle\else\OU@altsubtitle\fi
  \else
    \printsubtitle
  \fi
}
\newcommand{\printsupervisorlabel}{\OU@supervisorlabel}
\newcommand{\printsupervisor}{%
  \ifx\OU@supervisor\@empty Full title, name, and affiliation(s)\else\OU@supervisor\fi
}
\newcommand{\printexaminer}{%
  \ifx\OU@examiner\@empty Full title, name, and affiliation(s)\else\OU@examiner\fi
}
\newcommand{\printassessor}{%
  \ifx\OU@assessor\@empty Full title, name, and affiliation(s)\else\OU@assessor\fi
}
\newcommand{\printexternalsupervisors}{%
  \ifx\OU@externalsupervisors\@empty If applicable\else\OU@externalsupervisors\fi
}

\newif\ifOU@metadatavalidated
\newcommand{\OU@validatemetadata}{%
  \ifOU@metadatavalidated\else
    \ifx\@title\@empty
      \ClassWarningNoLine{OU}{No \string\title\space given}%
    \fi
    \ifx\@author\@empty
      \ClassWarningNoLine{OU}{No \string\author\space given}%
    \fi
    \ifx\OU@subtitle\@empty
      \ClassWarningNoLine{OU}{No \string\subtitle\space given}%
    \fi
    \ifx\OU@studentnumber\@empty
      \ClassWarningNoLine{OU}{No \string\studentnumber\space given}%
    \fi
    \ifx\OU@submissiondate\@empty
      \ClassWarningNoLine{OU}{No \string\submissiondate\space given}%
    \fi
    \ifx\OU@studyprogramme\@empty
      \ClassWarningNoLine{OU}{No \string\studyprogramme\space given}%
    \fi
    \ifx\OU@thesisyear\@empty
      \ClassWarningNoLine{OU}{No \string\thesisyear\space given}%
    \fi
    \ifx\OU@credits\@empty
      \ClassWarningNoLine{OU}{No \string\credits\space given}%
    \fi
    \ifx\OU@faculty\@empty
      \ClassWarningNoLine{OU}{No \string\faculty\space given}%
    \fi
    \ifx\OU@supervisor\@empty
      \ClassWarningNoLine{OU}{No \string\supervisor\space given}%
    \fi
    \ifx\OU@examiner\@empty
      \ClassWarningNoLine{OU}{No \string\examiner\space given}%
    \fi
    \ifx\OU@assessor\@empty
      \ClassWarningNoLine{OU}{No \string\assessor\space given}%
    \fi
    \ifx\OU@alttitle\@empty
      \ClassWarningNoLine{OU}{No alternate-language title given with \string\alttitle}%
    \fi
    \ifx\OU@altsubtitle\@empty
      \ClassWarningNoLine{OU}{No alternate-language subtitle given with \string\altsubtitle}%
    \fi
    \global\OU@metadatavalidatedtrue
  \fi
}

\pdfstringdefDisableCommands{%
  \def\\{ }%
  \def\and{, }%
}
\newcommand{\OU@setmetadata}{%
  \hypersetup{%
    pdftitle={\@title},%
    pdfauthor={\@author},%
    pdfsubject={\OU@thesislabel\space\OU@thesisyear, \OU@credits\space\OU@creditslabel},%
    pdfkeywords={Open Universiteit, \OU@faculty, \OU@studyprogramme},%
    pdfcreator={LaTeX with the OU thesis class}%
  }%
}
\newcommand{\setmetadata}{\OU@setmetadata}

\def\OU@abstract{}
\def\OU@samenvatting{}
\def\OU@acknowledgements{}
\def\OU@foreword{}
\def\OU@acronymcontent{}

\@ifundefined{abstract}{%
  \newcommand{\abstract}[1]{\gdef\OU@abstract{#1}}%
}{%
  \renewcommand{\abstract}[1]{\gdef\OU@abstract{#1}}%
}
\newcommand{\samenvatting}[1]{\gdef\OU@samenvatting{#1}}
\newcommand{\acknowledgements}[1]{\gdef\OU@acknowledgements{#1}}
\newcommand{\foreword}[1]{\gdef\OU@foreword{#1}}
\newcommand{\acronyms}[1]{\gdef\OU@acronymcontent{#1}}

\newcommand{\OU@printfronttext}[2]{%
  \clearpage
  \thispagestyle{plain}%
  \begin{center}
    \normalfont\OU@headingfont\OU@headingcolour\LARGE\textbf{#1}%
  \end{center}
  \begin{quotation}
    \sloppy
    #2%
  \end{quotation}
}

\newcommand{\printabstract}{%
  \ifx\OU@abstract\@empty\else
    \OU@printfronttext{\OU@abstractname}{\OU@abstract}%
  \fi
}
\newcommand{\printsamenvatting}{%
  \ifx\OU@samenvatting\@empty\else
    \OU@printfronttext{\OU@summaryname}{\OU@samenvatting}%
  \fi
}
\newcommand{\printacknowledgements}{%
  \ifx\OU@acknowledgements\@empty\else
    \OU@printfronttext{\OU@acknowledgementsname}{\OU@acknowledgements}%
  \fi
}
\newcommand{\printforeword}{%
  \ifx\OU@foreword\@empty\else
    \OU@printfronttext{\OU@forewordname}{\OU@foreword}%
  \fi
}
\newcommand{\printacronyms}{%
  \ifx\OU@acronymcontent\@empty\else
    \OU@acronymspage
  \fi
}

\newcommand{\OU@validatefrontmatter}{%
  \ifx\OU@abstract\@empty
    \ClassWarningNoLine{OU}{No abstract given with \string\abstract}%
  \fi
  \ifx\OU@samenvatting\@empty
    \ClassWarningNoLine{OU}{No Dutch summary given with \string\samenvatting}%
  \fi
  \ifOU@acronyms
    \ifx\OU@acronymcontent\@empty
      \ClassWarningNoLine{OU}{Option `acronyms' selected but no 
      \string\acronyms\space content given}%
    \fi
  \fi
}

\ifOU@article
  \renewcommand\section{\@startsection{section}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus .2ex}%
    {\normalfont\OU@headingfont\OU@headingcolour\LARGE\bfseries}}
  \renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\OU@headingfont\OU@headingcolour\Large\bfseries}}
  \renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\OU@headingfont\OU@headingcolour\large\bfseries}}
\fi

\newcommand{\appendices}{%
  \appendix
  \ifOU@article
    \counterwithin{table}{section}%
    \counterwithin{figure}{section}%
  \fi
}

\newif\ifOU@mainmatterstarted
\newcommand{\startthesis}{%
  \ifOU@mainmatterstarted
    \ClassWarningNoLine{OU}{\string\startthesis\space called more than once; 
    later call ignored}%
  \else
    \clearpage
    \ifOU@book
      % The first chapter transition supplies the separator between front matter
      % and thesis text.
      \mainmatter
    \else
      \null
      \thispagestyle{empty}%
      \clearpage
      \pagenumbering{arabic}%
    \fi
    \global\OU@mainmatterstartedtrue
  \fi
}

\newcommand{\orderofabstract}{%
  \printabstract
  \printsamenvatting
}
\let\orderofabstractforewordfirsttrue\orderofabstract

% --------------------------------------------------------------------------
% Open Universiteit Master's thesis design
% --------------------------------------------------------------------------
% The OU visual language below is deliberately built from elementary TikZ
% geometry. It reproduces the measured composition of the supplied corporate
% publication without depending on its photographic backgrounds or external
% logo files.

\def\OU@shorttitle{}
\def\OU@website{ou.nl}
\def\OU@address{Valkenburgerweg 177, 6419 AT Heerlen}

\newcommand{\shorttitle}[1]{\gdef\OU@shorttitle{#1}}
\newcommand{\website}[1]{\gdef\OU@website{#1}}
\newcommand{\universityaddress}[1]{\gdef\OU@address{#1}}

\newcommand{\printshorttitle}{%
  \ifx\OU@shorttitle\@empty\printtitle\else\OU@shorttitle\fi
}

\setlength\headheight{24pt}%

  % Front matter carries only a centred red folio and no running metadata.
  % Main matter adds the faculty to the running head. Even (left-hand) pages
  % carry the short title with an outer-left folio; odd (right-hand) pages carry
  % the student's name with an outer-right folio.
  \newcommand{\OU@mastersfrontfooter}{%
    \hfil
    {\color{\OU@departmentcolour}\OU@coverfont\fontsize{10pt}{12pt}\selectfont\thepage}%
    \hfil
  }

  % Places the OU mark at a fixed physical-page position.
  \newcommand{\OU@fixedfooterlogo}{%
    \smash{\makebox[0pt][l]{%
      \begin{tikzpicture}[remember picture,overlay]
        \ifodd\c@page
          % Right-hand page
          \node[anchor=south east] at
            ($(current page.south east)+(-12mm,10mm)$)
            {\OUmark[0.5][white]};
        \else
          % Left-hand page
          \node[anchor=south west] at
            ($(current page.south west)+(12mm,10mm)$)
            {\OUmark[0.5][white]};
        \fi
      \end{tikzpicture}%
    }}%
  }

  \newcommand{\OU@mastersmainfooter}{%
    \OU@fixedfooterlogo
    \OU@coverfont\fontsize{8.5pt}{10pt}\selectfont
    \ifodd\c@page
      \hbox to \textwidth{%
        \parbox[b]{0.78\textwidth}{%
          \raggedright\strut\printauthor
        }%
        \hfil
        {%
          \color{\OU@departmentcolour}%
          \fontsize{10pt}{12pt}\selectfont
          \thepage
        }%
      }%
    \else
      \hbox to \textwidth{%
        {%
          \color{\OU@departmentcolour}%
          \fontsize{10pt}{12pt}\selectfont
          \thepage
        }%
        \hfil
        \parbox[b]{0.78\textwidth}{%
          \raggedleft\strut\printshorttitle
        }%
      }%
    \fi
  }

  \newcommand{\OU@mastersfooter}{%
    \ifOU@book
      \if@mainmatter
        \OU@mastersmainfooter
      \else
        \OU@mastersfrontfooter
      \fi
    \else
      \ifOU@mainmatterstarted
        \OU@mastersmainfooter
      \else
        \OU@mastersfrontfooter
      \fi
    \fi
  }

  \newcommand{\OU@mastersheader}{%
    \ifOU@book
      \if@mainmatter
        \OU@coverfont\fontsize{8.5pt}{10pt}\selectfont
        \hbox to \textwidth{%
          \hfil
          \parbox[b]{0.47\textwidth}{\raggedleft\bfseries\strut\printfaculty}%
        }%
      \fi
    \else
      \ifOU@mainmatterstarted
        \OU@coverfont\fontsize{8.5pt}{10pt}\selectfont
        \hbox to \textwidth{%
          \hfil
          \parbox[b]{0.47\textwidth}{\raggedleft\bfseries\strut\printfaculty}%
        }%
      \fi
    \fi
  }

  \def\ps@OUmasters{%
    \let\@mkboth\@gobbletwo
    \def\@oddhead{\OU@mastersheader}%
    \let\@evenhead\@oddhead
    \def\@oddfoot{\OU@mastersfooter}%
    \let\@evenfoot\@oddfoot
  }%
  \let\ps@plain\ps@OUmasters
  \pagestyle{OUmasters}

  % The outer cover follows the reference cover's white header, full-width
  % visual field, right-hand rounded red banner, lower title block, and white
  % website strip. The grey field intentionally replaces the source photograph.
  \newcommand{\frontpage}{%
    \thispagestyle{empty}%
    \begingroup
      \noindent
      \begin{tikzpicture}[
          remember picture,
          overlay,
          every node/.append style={inner sep=0pt,outer sep=0pt}
        ]
        \path[fill=white] (current page.south west) rectangle (current page.north east);

        \node[anchor=west] at
          ($(current page.north west)+(13mm,-45mm)$)
          {\OUlogo[0.95]};
        \node[anchor=north east,align=right,text width=83mm] at
          ($(current page.north east)+(-13mm,-12mm)$)
          {\OU@coverfont\bfseries\fontsize{10pt}{12pt}\selectfont\printfaculty};

        \path[fill=OUvisualgrey]
          ($(current page.north west)+(5mm,-62mm)$)
          rectangle
          ($(current page.south east)+(0mm,26mm)$);
        \begin{scope}
          \clip
            ($(current page.north west)+(5mm,-62mm)$)
            rectangle
            ($(current page.south east)+(0mm,26mm)$);
          \path[fill=OUvisualgreyLight,opacity=0.10]
            ($(current page.north west)+(32mm,-156mm)$)
            circle[x radius=58mm,y radius=95mm];
          \path[fill=black,opacity=0.08]
            ($(current page.north east)+(-23mm,-228mm)$)
            circle[x radius=72mm,y radius=46mm];
        \end{scope}

        % A rectangle joined to a circle gives the characteristic OU banner.
        \path[fill=OUred]
          ($(current page.north west)+(151mm,-158mm)$)
          circle[radius=47mm];
        \path[fill=OUred]
          ($(current page.north west)+(151mm,-111mm)$)
          rectangle
          ($(current page.north east)+(0mm,-205mm)$);
        \node[anchor=east,align=right,text width=90mm,inner sep=0pt,outer sep=0pt] at ($(current page.north east)+(-13mm,-158mm)$)
          {\OU@coverfont\bfseries\fontsize{20pt}{22.5pt}\selectfont
           \hyphenpenalty=10000\exhyphenpenalty=10000\color{white}
           \printtitle\par\vspace{3mm}\mdseries\fontsize{11pt}{14pt}\selectfont
           \raggedleft\pretolerance=10000\hyphenpenalty=10000\exhyphenpenalty=10000
           \hyphenchar\font=-1
           \printsubtitle};
        \node[anchor=south west,align=left,text width=182mm] at
          ($(current page.north west)+(13mm,-244mm)$)
          {\OU@coverfont\fontsize{20pt}{24pt}\selectfont
           \color{white}\printauthor\quad\textperiodcentered\quad\printstudentnumber};
        \node[anchor=north west,align=left,text width=182mm] at
          ($(current page.north west)+(13mm,-251mm)$)
          {\OU@coverfont\fontsize{11pt}{14pt}\selectfont
           \color{white}\printsubmissiondate};
        \node[anchor=north west,align=left,text width=182mm] at
          ($(current page.north west)+(13mm,-263mm)$)
          {\OU@coverfont\fontsize{9.5pt}{12pt}\selectfont
           \color{white}\printstudyprogramme};

        \node[anchor=west] at
          ($(current page.south west)+(13mm,13mm)$)
          {\OU@coverfont\bfseries\fontsize{13pt}{14pt}\selectfont
           \color{OUcharcoal}\OU@website};
      \end{tikzpicture}%
    \endgroup
  }

  \newcommand{\OU@committeeentry}[2]{%
    {\fontsize{8.5pt}{10pt}\selectfont\bfseries\MakeUppercase{#1}\par}%
    \vspace{1mm}%
    {\fontsize{9.5pt}{11.5pt}\selectfont #2\par}%
    \vspace{2.5mm}%
  }

  % Page two remains an inset university-red field. It holds both language
  % titles and a committee block whose entries wrap naturally when affiliations
  % or lists of external supervisors are lengthy.
  \newcommand{\OU@redpage}{%
    \thispagestyle{empty}%
    \begingroup
      \noindent
      \begin{tikzpicture}[
          remember picture,
          overlay,
          every node/.append style={inner sep=0pt,outer sep=0pt}
        ]
        \path[fill=white] (current page.south west) rectangle (current page.north east);
        \path[fill=OUred]
          ($(current page.south west)+(10mm,10mm)$)
          rectangle
          ($(current page.north east)+(-10mm,-10mm)$);
        \node[anchor=north west,align=left,text width=148mm] at
          ($(current page.north west)+(33mm,-48mm)$)
          {\OU@coverfont\color{white}%
           {\bfseries\fontsize{18pt}{22pt}\selectfont\hyphenchar\font=-1\printengtitle\par}%
           \vspace{2mm}%
           {\mdseries\fontsize{11pt}{14pt}\selectfont\printengsubtitle\par}%
           \vspace{6mm}%
           {\bfseries\fontsize{15pt}{18pt}\selectfont\hyphenchar\font=-1\printnltitle\par}%
           \vspace{2mm}%
           {\mdseries\fontsize{10.5pt}{13pt}\selectfont\printnlsubtitle\par}%
           \vspace{18mm}%
           {\fontsize{12pt}{14pt}\selectfont\bfseries THESIS COMMITTEE\par}%
           \vspace{3mm}%
           \OU@committeeentry{\printsupervisorlabel}{\printsupervisor}%
           \OU@committeeentry{Examiner}{\printexaminer}%
           \OU@committeeentry{Assessor}{\printassessor}%
           \OU@committeeentry{External supervisor(s)}{\printexternalsupervisors}};
        \node[anchor=west,text width=148mm] at
          ($(current page.south west)+(33mm,49mm)$)
          {\OU@coverfont\bfseries\fontsize{10pt}{12pt}\selectfont
           \color{white}\printauthor\quad\textperiodcentered\quad\printstudentnumber
           \quad\textperiodcentered\quad\printsubmissiondate};
        \node[anchor=south east] at
          ($(current page.south east)+(-19mm,19mm)$)
          {\OUmark[0.78][white]};
      \end{tikzpicture}%
    \endgroup
  }

  % Each front-matter list uses the same measured heading and horizontal rule.
  % A short list is pushed to the foot of the page; as entries are added, the
  % complete composition grows upwards.
  \newcommand{\OU@listheading}[2]{%
    \phantomsection
    \pdfbookmark[0]{#1}{#2}%
    \noindent
    \begin{tikzpicture}[
        every node/.append style={inner sep=0pt,outer sep=0pt}
      ]
      \path[use as bounding box]
        (0,0) rectangle (\textwidth,28mm);
      \node[anchor=west] at (1mm,15mm)
        {\OUmark[0.5][OUdepartment]};
      \node[anchor=west] at (17mm,15mm)
        {\OU@coverfont\OU@headingcolour\bfseries\fontsize{34pt}{36pt}\selectfont #1};
      \draw[black,line width=0.65pt]
        (16.5mm,0) -- (\textwidth,0);
    \end{tikzpicture}%
    \par\nobreak
    \vspace{6mm}%
  }

  % The box itself has no visible frame or background. Its four overlay rules
  % draw only the internal west rule, at the same horizontal position as in
  % the reference design. tcolorbox redraws the rule for every page segment,
  % so it always follows the actual height of the entries on that page.
  \tcbset{OUcontentsbox/.style={%
    enhanced jigsaw,
    breakable,
    blanker,
    width=\textwidth,
    left=0pt,
    right=0pt,
    top=0pt,
    bottom=0pt,
    boxsep=0pt,
    before skip=0pt,
    after skip=0pt,
    parbox=false,
    overlay unbroken={%
      \draw[black,line width=0.65pt]
        ([xshift=16.5mm]frame.south west) --
        ([xshift=16.5mm]frame.north west);},
    overlay first={%
      \draw[black,line width=0.65pt]
        ([xshift=16.5mm]frame.south west) --
        ([xshift=16.5mm]frame.north west);},
    overlay middle={%
      \draw[black,line width=0.65pt]
        ([xshift=16.5mm]frame.south west) --
        ([xshift=16.5mm]frame.north west);},
    overlay last={%
      \draw[black,line width=0.65pt]
        ([xshift=16.5mm]frame.south west) --
        ([xshift=16.5mm]frame.north west);}
  }}

  % Page numbers precede the entry text, as in the source publication. The
  % leading and indents deliberately remain compact for long front-matter
  % lists.
  \newcommand{\OU@tocentry}[7]{%
    \ifnum#1>\c@tocdepth\else
      \vskip #2\relax
      \begingroup
        \parindent=0pt
        \parskip=0pt
        \rightskip=0pt plus 1fil
        \leftskip=\dimexpr#3+20mm\relax
        \OU@coverfont\linespread{1}#4\relax
        \def\numberline##1{\makebox[9mm][l]{##1}}%
        \noindent
        \llap{\makebox[13mm][r]{\color{#5}#7}\hspace{7mm}}%
        #6\par
      \endgroup
    \fi
  }

  \ifOU@book
    \renewcommand*\l@chapter[2]{%
      \OU@tocentry{0}{7pt}{0mm}{\fontsize{11pt}{14pt}\selectfont\bfseries}{OUdepartment}{#1}{#2}}
    \renewcommand*\l@section[2]{%
      \OU@tocentry{1}{3pt}{0mm}{\fontsize{9.5pt}{12pt}\selectfont}{OUdepartment}{#1}{#2}}
    \renewcommand*\l@subsection[2]{%
      \OU@tocentry{2}{2pt}{9mm}{\fontsize{9pt}{11pt}\selectfont}{OUdepartment}{#1}{#2}}
  \else
    \renewcommand*\l@section[2]{%
      \OU@tocentry{1}{7pt}{0mm}{\fontsize{11pt}{14pt}\selectfont\bfseries}{OUdepartment}{#1}{#2}}
    \renewcommand*\l@subsection[2]{%
      \OU@tocentry{2}{3pt}{0mm}{\fontsize{9.5pt}{12pt}\selectfont}{OUdepartment}{#1}{#2}}
    \renewcommand*\l@subsubsection[2]{%
      \OU@tocentry{3}{2pt}{9mm}{\fontsize{9pt}{11pt}\selectfont}{OUdepartment}{#1}{#2}}
  \fi

  \renewcommand*\l@figure[2]{%
    \OU@tocentry{0}{3pt}{0mm}{\fontsize{9.5pt}{12pt}\selectfont}{OUdepartment}{#1}{#2}}
  \renewcommand*\l@table[2]{%
    \OU@tocentry{0}{3pt}{0mm}{\fontsize{9.5pt}{12pt}\selectfont}{OUdepartment}{#1}{#2}}

  \newcommand{\OU@styledlist}[3]{%
    \vspace*{\fill}%
    \OU@listheading{#1}{#2}%
    \begin{tcolorbox}[OUcontentsbox]
      #3%
    \end{tcolorbox}%
  }

  \renewcommand{\tableofcontents}{%
    \OU@styledlist{\OU@contentslabel}{ou.contents}{\@starttoc{toc}}%
  }
  \renewcommand{\listoffigures}{%
    \OU@styledlist{\OU@figureslabel}{ou.figures}{\@starttoc{lof}}%
  }
  \renewcommand{\listoftables}{%
    \OU@styledlist{\OU@tableslabel}{ou.tables}{\@starttoc{lot}}%
  }
  \newcommand{\OU@acronymentries}{%
    \begingroup
      \OU@coverfont\fontsize{9.5pt}{12pt}\selectfont
      \begin{list}{}{%
        \setlength\leftmargin{20mm}%
        \setlength\rightmargin{0pt}%
        \setlength\labelwidth{0pt}%
        % Retain a normal label separation so nested description lists keep a
        % readable gap between an acronym and its expanded term.
        \setlength\labelsep{0.5em}%
        \setlength\itemindent{0pt}%
        \setlength\itemsep{0pt}%
        \setlength\parsep{3pt}%
        \setlength\topsep{0pt}%
      }%
        \item[]\OU@acronymcontent
      \end{list}%
    \endgroup
  }
  \newcommand{\OU@acronymspage}{%
    \OU@styledlist{\OU@acronymsname}{ou.acronyms}{\OU@acronymentries}%
  }

  % Chapter transitions use a white page with department-coloured title and
  % arrow. The university-red cover and title-information page are unaffected.
  \newcommand{\OU@chapterarrow}{%
    \begin{tikzpicture}[baseline=-0.68ex, scale=0.9]
      \draw[OUdepartment,line width=3.5pt,line cap=round,line join=round]
        (0,0) -- (11mm,0)
        (7.2mm,3.8mm) -- (11mm,0) -- (7.2mm,-3.8mm);
    \end{tikzpicture}%
  }

  \newcommand{\OU@chapterdivider}[1]{%
    \clearpage
    \thispagestyle{empty}%
    \begingroup
      \noindent
      \begin{tikzpicture}[
          remember picture,
          overlay,
          every node/.append style={inner sep=0pt,outer sep=0pt}
        ]
        \path[fill=white]
          (current page.south west) rectangle (current page.north east);
        \node[anchor=south west,align=right,text width=168mm] at
          ($(current page.south west)+(24mm,42mm)$)
          {\OU@coverfont\bfseries\fontsize{31pt}{35pt}\selectfont
           \color{OUdepartment}\MakeUppercase{#1}\hspace{5mm}\OU@chapterarrow};
      \end{tikzpicture}%
      \null
    \endgroup
    \clearpage
  }

  \ifOU@book
    \let\OU@standardchapter\chapter
    \RenewDocumentCommand{\chapter}{s o m}{%
      \IfBooleanTF{#1}{%
        \OU@standardchapter*{#3}%
      }{%
        \ifOU@mainmatterstarted
          \IfNoValueTF{#2}{%
            \OU@chapterdivider{#3}%
          }{%
            \OU@chapterdivider{#2}%
          }%
        \fi
        \IfNoValueTF{#2}{%
          \OU@standardchapter{#3}%
        }{%
          \OU@standardchapter[#2]{#3}%
        }%
      }%
    }
  \fi

  \newcommand{\OU@contentspage}[1]{%
    \clearpage
    \newgeometry{left=22mm,right=22mm,top=18mm,bottom=18mm,headheight=24pt,headsep=7mm,footskip=11mm}%
    \thispagestyle{OUmasters}%
    \begingroup
      \hypersetup{linkcolor=black}%
      #1%
    \endgroup
    \clearpage
    \restoregeometry
  }

  % The text front matter precedes the contents and auxiliary lists. The order
  % is fixed in both language modes: Abstract, Samenvatting, Acknowledgements,
  % Content, Figures, Tables, and Acronyms. An optional foreword appears before
  % this sequence with `forewordfirst' and after it otherwise. Optional pages
  % are omitted when the corresponding content or class option is absent.
  \newcommand{\OU@makefrontmatter}{%
    \OU@validatemetadata
    \OU@validatefrontmatter
    \OU@setmetadata
    \hypersetup{pageanchor=false}%
    \thispagestyle{empty}%
    \frontpage
    \null
    \clearpage
    \OU@redpage
    \null
    \clearpage
    \ifOU@book
      \frontmatter
    \else
      \pagenumbering{roman}%
    \fi
    \hypersetup{pageanchor=true}%
    \pagestyle{OUmasters}%
    \ifOU@forewordfirst
      \printforeword
    \fi
    \orderofabstract
    \printacknowledgements
    \OU@contentspage{\tableofcontents}%
    \ifOU@listoffigures
      \OU@contentspage{\listoffigures}%
    \fi
    \ifOU@listoftables
      \OU@contentspage{\listoftables}%
    \fi
    \ifOU@acronyms
      \OU@contentspage{\printacronyms}%
    \fi
    \ifOU@forewordfirst\else
      \printforeword
    \fi
    \clearpage
  }

  % The back cover mirrors the reference's left-hand red semicircular block and
  % compact institutional footer. No photographic or external artwork is used.
  \newcommand{\backpage}{%
    \thispagestyle{empty}%
    \begingroup
      \noindent
      \begin{tikzpicture}[
          remember picture,
          overlay,
          every node/.append style={inner sep=0pt,outer sep=0pt}
        ]
        \path[fill=white] (current page.south west) rectangle (current page.north east);
        \path[fill=OUred]
          ($(current page.north west)+(0mm,-153mm)$)
          rectangle
          ($(current page.north west)+(59mm,-236mm)$);
        \path[fill=OUred]
          ($(current page.north west)+(59mm,-194.5mm)$)
          circle[radius=41.5mm];

        \node[anchor=north,align=center,text width=172mm] at
          ($(current page.south)+(0mm,42mm)$)
          {\OU@coverfont\fontsize{8.5pt}{11pt}\selectfont
           \textbf{\printfaculty}\quad Open Universiteit\par
           \OU@address\quad \textcolor{OUred}{\OU@website}\par
           \vspace{8mm}%
           \textbf{\printauthor}\quad \printstudyprogramme};
      \end{tikzpicture}%
    \endgroup
  }

\AddToHook{begindocument/end}{\OU@makefrontmatter}

\AtEndDocument{%
  \ifOU@mainmatterstarted\else
    \ClassWarningNoLine{OU}{\string\startthesis\space was not called}%
  \fi
  \clearpage
  % Deliberately retain a blank page before the back cover.
  \null
  \thispagestyle{empty}%
  \clearpage
  \backpage
  \null
}

% --------------------------------------------------------------------------
% Official Open Universiteit vector logo
% --------------------------------------------------------------------------
% Supplied OU artwork, retained as TikZ paths so the class is self-contained.
% The first optional argument scales the complete logo or mark. The mark also
% accepts an optional colour so it can be reversed out on solid backgrounds.
\newcommand{\OUlogo}[1][1]{%
\scalebox{#1}{\resizebox{62mm}{!}{%
\begin{tikzpicture}[scale=0.33, inner sep=0pt, outer sep=0pt]
  \path[fill=OUred] (2.1201, -0.7501).. controls (1.3634, -0.7501) and (0.7501, -1.3147) .. (0.7501, -2.0116) -- (0.7501, -4.6516).. controls (0.7501, -5.3483) and (1.3634, -5.9132) .. (2.1201, -5.9132).. controls (2.8768, -5.9132) and (3.4901, -5.3483) .. (3.4901, -4.6516) -- (3.4901, -2.0116).. controls (3.4901, -1.3147) and (2.8766, -0.7501) .. (2.1201, -0.7501) -- cycle(2.8855, -4.7591).. controls (2.8855, -5.1041) and (2.5429, -5.384) .. (2.1201, -5.384).. controls (1.697, -5.384) and (1.3547, -5.1043) .. (1.3547, -4.7591) -- (1.3547, -3.5211) -- (1.8539, -3.5211) -- (1.8539, -4.7591).. controls (1.8539, -4.8768) and (1.973, -4.9723) .. (2.1201, -4.9723).. controls (2.2672, -4.9723) and (2.3863, -4.8768) .. (2.3863, -4.7591) -- (2.3863, -3.5211) -- (2.8855, -3.5211) -- (2.8855, -4.7591) -- cycle(2.1201, -3.0795).. controls (1.6187, -3.0795) and (1.2126, -2.6734) .. (1.2126, -2.172).. controls (1.2126, -1.6708) and (1.6187, -1.2644) .. (2.1201, -1.2644).. controls (2.6212, -1.2644) and (3.0276, -1.6706) .. (3.0276, -2.172).. controls (3.0274, -2.6734) and (2.6212, -3.0795) .. (2.1201, -3.0795) -- cycle;
  \path[fill] (5.0551, -3.3113).. controls (5.0551, -3.6227) and (4.8665, -3.8113) .. (4.5889, -3.8113).. controls (4.3072, -3.8113) and (4.1423, -3.5986) .. (4.1423, -3.3282).. controls (4.1423, -3.0438) and (4.3241, -2.831) .. (4.6043, -2.831).. controls (4.8959, -2.831) and (5.0551, -3.0493) .. (5.0551, -3.3113) -- cycle(4.3693, -3.324).. controls (4.3693, -3.51) and (4.4566, -3.6409) .. (4.6003, -3.6409).. controls (4.7453, -3.6409) and (4.8284, -3.5028) .. (4.8284, -3.3184).. controls (4.8284, -3.148) and (4.7466, -3.0014) .. (4.5987, -3.0014).. controls (4.4537, -3.0014) and (4.3693, -3.1395) .. (4.3693, -3.324) -- cycle;
  \path[fill] (5.2369, -3.338).. controls (5.2369, -3.2478) and (5.234, -3.1705) .. (5.2313, -3.107) -- (5.4173, -3.107) -- (5.4271, -3.2028) -- (5.43, -3.2028).. controls (5.4808, -3.1295) and (5.5597, -3.0917) .. (5.6597, -3.0917).. controls (5.8103, -3.0917) and (5.9457, -3.2226) .. (5.9457, -3.4425).. controls (5.9457, -3.6931) and (5.7867, -3.8113) .. (5.633, -3.8113).. controls (5.5499, -3.8113) and (5.4851, -3.7775) .. (5.4541, -3.7325) -- (5.4512, -3.7325) -- (5.4512, -4.0748) -- (5.2372, -4.0748) -- (5.2372, -3.338) -- cycle(5.4509, -3.5002).. controls (5.4509, -3.5171) and (5.4523, -3.5327) .. (5.4552, -3.5452).. controls (5.4692, -3.6028) and (5.5187, -3.6465) .. (5.5806, -3.6465).. controls (5.6735, -3.6465) and (5.7285, -3.569) .. (5.7285, -3.452).. controls (5.7285, -3.3422) and (5.6793, -3.2591) .. (5.5835, -3.2591).. controls (5.5229, -3.2591) and (5.4695, -3.3041) .. (5.4552, -3.3676).. controls (5.4525, -3.379) and (5.4509, -3.393) .. (5.4509, -3.4057) -- (5.4509, -3.5002) -- cycle;
  \path[fill] (6.2907, -3.5198).. controls (6.2979, -3.6084) and (6.3852, -3.6507) .. (6.4852, -3.6507).. controls (6.5585, -3.6507) and (6.6175, -3.6409) .. (6.6754, -3.6227) -- (6.7035, -3.7677).. controls (6.6331, -3.7957) and (6.5471, -3.8113) .. (6.4542, -3.8113).. controls (6.2204, -3.8113) and (6.0867, -3.6748) .. (6.0867, -3.4592).. controls (6.0867, -3.2845) and (6.1952, -3.0914) .. (6.4347, -3.0914).. controls (6.6572, -3.0914) and (6.7416, -3.2647) .. (6.7416, -3.4351).. controls (6.7416, -3.4716) and (6.7374, -3.5041) .. (6.7344, -3.5195) -- (6.2907, -3.5195) -- cycle(6.5426, -3.3734).. controls (6.5426, -3.3213) and (6.5201, -3.234) .. (6.4214, -3.234).. controls (6.3312, -3.234) and (6.2947, -3.3158) .. (6.2889, -3.3734) -- (6.5426, -3.3734) -- cycle;
  \path[fill] (6.912, -3.3269).. controls (6.912, -3.2409) and (6.9091, -3.1679) .. (6.9064, -3.1073) -- (7.0924, -3.1073) -- (7.1022, -3.2017) -- (7.1064, -3.2017).. controls (7.1345, -3.1581) and (7.2051, -3.0919) .. (7.3192, -3.0919).. controls (7.4599, -3.0919) and (7.5655, -3.1848) .. (7.5655, -3.3877) -- (7.5655, -3.7962) -- (7.3514, -3.7962) -- (7.3514, -3.4147).. controls (7.3514, -3.3261) and (7.3205, -3.2652) .. (7.243, -3.2652).. controls (7.184, -3.2652) and (7.1485, -3.3062) .. (7.1345, -3.3457).. controls (7.1289, -3.3597) and (7.126, -3.3795) .. (7.126, -3.3991) -- (7.126, -3.7962) -- (6.912, -3.7962) -- (6.912, -3.3269) -- cycle;
  \path[fill] (8.2995, -2.8467) -- (8.2995, -3.393).. controls (8.2995, -3.5563) and (8.3614, -3.6396) .. (8.4712, -3.6396).. controls (8.5839, -3.6396) and (8.6458, -3.5608) .. (8.6458, -3.393) -- (8.6458, -2.8467) -- (8.8598, -2.8467) -- (8.8598, -3.379).. controls (8.8598, -3.6719) and (8.7119, -3.8113) .. (8.464, -3.8113).. controls (8.2246, -3.8113) and (8.0838, -3.679) .. (8.0838, -3.3761) -- (8.0838, -2.8464) -- (8.2995, -2.8464) -- cycle;
  \path[fill] (9.0813, -3.3269).. controls (9.0813, -3.2409) and (9.0784, -3.1679) .. (9.0757, -3.1073) -- (9.2617, -3.1073) -- (9.2715, -3.2017) -- (9.2758, -3.2017).. controls (9.3038, -3.1581) and (9.3745, -3.0919) .. (9.4885, -3.0919).. controls (9.6292, -3.0919) and (9.7351, -3.1848) .. (9.7351, -3.3877) -- (9.7351, -3.7962) -- (9.521, -3.7962) -- (9.521, -3.4147).. controls (9.521, -3.3261) and (9.4901, -3.2652) .. (9.4126, -3.2652).. controls (9.3533, -3.2652) and (9.3181, -3.3062) .. (9.3041, -3.3457).. controls (9.2985, -3.3597) and (9.2956, -3.3795) .. (9.2956, -3.3991) -- (9.2956, -3.7962) -- (9.0816, -3.7962) -- (9.0816, -3.3269) -- cycle;
  \path[fill] (10.1703, -2.9154).. controls (10.1703, -2.9747) and (10.1253, -3.0226) .. (10.0547, -3.0226).. controls (9.987, -3.0226) and (9.942, -2.9747) .. (9.9436, -2.9154).. controls (9.9422, -2.8535) and (9.9872, -2.807) .. (10.0563, -2.807).. controls (10.1251, -2.8072) and (10.1687, -2.8535) .. (10.1703, -2.9154) -- cycle(9.9491, -3.796) -- (9.9491, -3.1073) -- (10.1632, -3.1073) -- (10.1632, -3.796) -- (9.9491, -3.796) -- cycle;
  \path[fill] (10.5365, -3.107) -- (10.6294, -3.4269).. controls (10.6463, -3.4846) and (10.659, -3.5396) .. (10.6688, -3.5946) -- (10.673, -3.5946).. controls (10.6844, -3.5383) and (10.6955, -3.4862) .. (10.7111, -3.4269) -- (10.7998, -3.107) -- (11.0252, -3.107) -- (10.7688, -3.7957) -- (10.5548, -3.7957) -- (10.3039, -3.107) -- (10.5365, -3.107) -- cycle;
  \path[fill] (11.3099, -3.5198).. controls (11.3168, -3.6084) and (11.4043, -3.6507) .. (11.5041, -3.6507).. controls (11.5774, -3.6507) and (11.6364, -3.6409) .. (11.6943, -3.6227) -- (11.7224, -3.7677).. controls (11.652, -3.7957) and (11.566, -3.8113) .. (11.4731, -3.8113).. controls (11.2392, -3.8113) and (11.1054, -3.6748) .. (11.1054, -3.4592).. controls (11.1054, -3.2845) and (11.2138, -3.0914) .. (11.4533, -3.0914).. controls (11.6758, -3.0914) and (11.7602, -3.2647) .. (11.7602, -3.4351).. controls (11.7602, -3.4716) and (11.756, -3.5041) .. (11.7533, -3.5195) -- (11.3099, -3.5195) -- cycle(11.562, -3.3734).. controls (11.562, -3.3213) and (11.5395, -3.234) .. (11.4408, -3.234).. controls (11.3506, -3.234) and (11.3141, -3.3158) .. (11.3086, -3.3734) -- (11.562, -3.3734) -- cycle;
  \path[fill] (11.9311, -3.334).. controls (11.9311, -3.2327) and (11.9285, -3.1665) .. (11.9256, -3.1073) -- (12.11, -3.1073) -- (12.1169, -3.234) -- (12.1224, -3.234).. controls (12.1576, -3.134) and (12.2423, -3.0917) .. (12.3084, -3.0917).. controls (12.3283, -3.0917) and (12.3381, -3.0917) .. (12.3534, -3.0946) -- (12.3534, -3.2975).. controls (12.3381, -3.2933) and (12.3195, -3.2906) .. (12.2957, -3.2906).. controls (12.2169, -3.2906) and (12.1634, -3.3327) .. (12.1491, -3.3991).. controls (12.1462, -3.4131) and (12.1449, -3.4301) .. (12.1449, -3.447) -- (12.1449, -3.7962) -- (11.9309, -3.7962) -- (11.9309, -3.334) -- cycle;
  \path[fill] (12.5071, -3.6084).. controls (12.5465, -3.6325) and (12.6283, -3.6605) .. (12.6915, -3.6605).. controls (12.7564, -3.6605) and (12.7831, -3.638) .. (12.7831, -3.6028).. controls (12.7831, -3.5676) and (12.7619, -3.5507) .. (12.6817, -3.524).. controls (12.5394, -3.4761) and (12.4846, -3.3986) .. (12.486, -3.3184).. controls (12.486, -3.1888) and (12.5958, -3.0917) .. (12.7661, -3.0917).. controls (12.8466, -3.0917) and (12.9183, -3.1099) .. (12.9606, -3.1311) -- (12.9225, -3.279).. controls (12.8916, -3.262) and (12.8323, -3.2396) .. (12.7733, -3.2396).. controls (12.7212, -3.2396) and (12.6915, -3.2607) .. (12.6915, -3.2959).. controls (12.6915, -3.3282) and (12.7183, -3.3451) .. (12.8029, -3.3748).. controls (12.9339, -3.4197) and (12.9889, -3.4859) .. (12.9902, -3.5875).. controls (12.9902, -3.7155) and (12.8889, -3.8113) .. (12.6915, -3.8113).. controls (12.6013, -3.8113) and (12.5211, -3.7902) .. (12.469, -3.7621) -- (12.5071, -3.6084) -- cycle;
  \path[fill] (13.3834, -2.9154).. controls (13.3834, -2.9747) and (13.3384, -3.0226) .. (13.2681, -3.0226).. controls (13.2003, -3.0226) and (13.1553, -2.9747) .. (13.1567, -2.9154).. controls (13.1553, -2.8535) and (13.2003, -2.807) .. (13.2694, -2.807).. controls (13.3382, -2.8072) and (13.3818, -2.8535) .. (13.3834, -2.9154) -- cycle(13.1622, -3.796) -- (13.1622, -3.1073) -- (13.3763, -3.1073) -- (13.3763, -3.796) -- (13.1622, -3.796) -- cycle;
  \path[fill] (13.8298, -2.9199) -- (13.8298, -3.1073) -- (13.9832, -3.1073) -- (13.9832, -3.265) -- (13.8298, -3.265) -- (13.8298, -3.5142).. controls (13.8298, -3.5973) and (13.8496, -3.6354) .. (13.9142, -3.6354).. controls (13.9438, -3.6354) and (13.9565, -3.6341) .. (13.9777, -3.6298) -- (13.979, -3.7917).. controls (13.951, -3.8031) and (13.9002, -3.8113) .. (13.8396, -3.8113).. controls (13.7705, -3.8113) and (13.7128, -3.7859) .. (13.679, -3.7507).. controls (13.6395, -3.7097) and (13.6197, -3.6436) .. (13.6197, -3.5465) -- (13.6197, -3.265) -- (13.5281, -3.265) -- (13.5281, -3.1073) -- (13.6197, -3.1073) -- (13.6197, -2.9776) -- (13.8298, -2.9199) -- cycle;
  \path[fill] (14.3076, -3.5198).. controls (14.3148, -3.6084) and (14.4021, -3.6507) .. (14.5021, -3.6507).. controls (14.5754, -3.6507) and (14.6344, -3.6409) .. (14.6923, -3.6227) -- (14.7204, -3.7677).. controls (14.65, -3.7957) and (14.564, -3.8113) .. (14.4711, -3.8113).. controls (14.2372, -3.8113) and (14.1036, -3.6748) .. (14.1036, -3.4592).. controls (14.1036, -3.2845) and (14.2121, -3.0914) .. (14.4515, -3.0914).. controls (14.6741, -3.0914) and (14.7585, -3.2647) .. (14.7585, -3.4351).. controls (14.7585, -3.4716) and (14.7542, -3.5041) .. (14.7513, -3.5195) -- (14.3076, -3.5195) -- cycle(14.5595, -3.3734).. controls (14.5595, -3.3213) and (14.537, -3.234) .. (14.4383, -3.234).. controls (14.3481, -3.234) and (14.3116, -3.3158) .. (14.3058, -3.3734) -- (14.5595, -3.3734) -- cycle;
  \path[fill] (15.15, -2.9154).. controls (15.15, -2.9747) and (15.1051, -3.0226) .. (15.0344, -3.0226).. controls (14.9667, -3.0226) and (14.9217, -2.9747) .. (14.9233, -2.9154).. controls (14.922, -2.8535) and (14.967, -2.807) .. (15.036, -2.807).. controls (15.1048, -2.8072) and (15.1485, -2.8535) .. (15.15, -2.9154) -- cycle(14.9289, -3.796) -- (14.9289, -3.1073) -- (15.1429, -3.1073) -- (15.1429, -3.796) -- (14.9289, -3.796) -- cycle;
  \path[fill] (15.5964, -2.9199) -- (15.5964, -3.1073) -- (15.7446, -3.1073) -- (15.7446, -3.265) -- (15.5964, -3.265) -- (15.5964, -3.5142).. controls (15.5964, -3.5973) and (15.616, -3.6354) .. (15.6808, -3.6354).. controls (15.7104, -3.6354) and (15.7229, -3.6341) .. (15.744, -3.6298) -- (15.7454, -3.7917).. controls (15.7173, -3.8031) and (15.6665, -3.8113) .. (15.6059, -3.8113).. controls (15.5369, -3.8113) and (15.4792, -3.7859) .. (15.4453, -3.7507).. controls (15.4059, -3.7097) and (15.3861, -3.6436) .. (15.3861, -3.5465) -- (15.3861, -3.265) -- (15.2945, -3.265) -- (15.2945, -3.1073) -- (15.3861, -3.1073) -- (15.3861, -2.9776) -- (15.5964, -2.9199) -- cycle;

\end{tikzpicture}%
}}}

\NewDocumentCommand{\OUmark}{O{1} O{OUred}}{%
\scalebox{#1}{\resizebox{!}{18mm}{%
\begin{tikzpicture}[scale=0.14, inner sep=0pt, outer sep=0pt]
  \path[fill=#2] (2.1201, -0.7501).. controls (1.3634, -0.7501) and (0.7501, -1.3147) .. (0.7501, -2.0116) -- (0.7501, -4.6516).. controls (0.7501, -5.3483) and (1.3634, -5.9132) .. (2.1201, -5.9132).. controls (2.8768, -5.9132) and (3.4901, -5.3483) .. (3.4901, -4.6516) -- (3.4901, -2.0116).. controls (3.4901, -1.3147) and (2.8766, -0.7501) .. (2.1201, -0.7501) -- cycle(2.8855, -4.7591).. controls (2.8855, -5.1041) and (2.5429, -5.384) .. (2.1201, -5.384).. controls (1.697, -5.384) and (1.3547, -5.1043) .. (1.3547, -4.7591) -- (1.3547, -3.5211) -- (1.8539, -3.5211) -- (1.8539, -4.7591).. controls (1.8539, -4.8768) and (1.973, -4.9723) .. (2.1201, -4.9723).. controls (2.2672, -4.9723) and (2.3863, -4.8768) .. (2.3863, -4.7591) -- (2.3863, -3.5211) -- (2.8855, -3.5211) -- (2.8855, -4.7591) -- cycle(2.1201, -3.0795).. controls (1.6187, -3.0795) and (1.2126, -2.6734) .. (1.2126, -2.172).. controls (1.2126, -1.6708) and (1.6187, -1.2644) .. (2.1201, -1.2644).. controls (2.6212, -1.2644) and (3.0276, -1.6706) .. (3.0276, -2.172).. controls (3.0274, -2.6734) and (2.6212, -3.0795) .. (2.1201, -3.0795) -- cycle;

\end{tikzpicture}%
}}}

\endinput
%%
%% End of file `OU.cls'.
