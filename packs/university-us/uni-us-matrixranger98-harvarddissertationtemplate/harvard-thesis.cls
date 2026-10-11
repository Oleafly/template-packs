% -------------------------------------------------------------------
% % updated by Tianle Liu, 2025
%  @LaTeX-class-file{
%     filename        = "harvard-thesis.cls",
%     version         = "1.0",
%     date            = "22 April 2025",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, harvard-thesis",
%     supported       = "send email to tylerliuthu@gmail.com",
%     docstring       = "A thesis class for a Harvard dissertation."
%  }
% --------------------------------------------------------------------
% -------------------------------------------------------------------
% % previous version, 2012
%  @LaTeX-class-file{
%     filename        = "harvard-thesis.cls",
%     version         = "0.4",
%     date            = "4 April 2012",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, harvard-thesis",
%     supported       = "send email to suchow@fas.harvard.edu",
%     docstring       = "A thesis class for a Harvard dissertation."
%  }
% --------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{harvard-thesis}[2025/04/22 v1.0 Harvard University Thesis Class]
\LoadClass[12pt, oneside, letterpaper]{book}

\RequirePackage{graphicx}

% cross referencing
\RequirePackage{hyperref}
\hypersetup{
	linktocpage,
    colorlinks,
    citecolor=Crimson,
    filecolor=black,
    linkcolor=black,
    urlcolor=Crimson,
}
\RequirePackage{url}

% basics
\RequirePackage[centertags]{amsmath}
\RequirePackage{amssymb}
\RequirePackage[tight,nice]{units}
\RequirePackage{verbatim}
\RequirePackage{ragged2e}

% colors
\RequirePackage{color,xcolor}
\definecolor{Crimson}{rgb}{0.6471, 0.1098, 0.1882}


\justifying

\RequirePackage{pdfsync} %do pdf synchronization [andy]

\synctex=1 % turn synctex on automatically to sync between pdf viewer [andy]

% page layouts; minimum 1in
\RequirePackage[margin=1.1in,letterpaper]{geometry}

% page styles
\RequirePackage{setspace} 
\doublespacing
\addtolength{\footnotesep}{\footnotesep}
\setlength{\parindent}{2em}
\RequirePackage[small,md,sc]{titlesec}
\RequirePackage{fancyhdr} 
\pagestyle{plain} % options: empty , plain , fancy
\RequirePackage{quotchap}
% % change font style for chapter numbers
% \renewcommand{\chapnumfont}{\normalfont\huge\bfseries}
% Adjust chapter title styles
\titleformat{\chapter}[display]
  {\Huge\setstretch{1.5}} % Title font and spacing
  {\chapnumfont\raggedleft\thechapter} % Use quotchap's chapter number font
  {20pt}
  {\raggedleft}
\definecolor{chaptergrey}{rgb}{0.6471, 0.1098, 0.1882}
\RequirePackage{lettrine} % big letter at start of chapter
\RequirePackage{titling}
% \usepackage[closeFloats, noSeparatorLine]{fltpage} %use the custom modified fltpage package
\RequirePackage{afterpage} 


% tables
\RequirePackage{booktabs} % for much better looking tables
\RequirePackage[labelfont={sf,bf,small},textfont={sf,small},justification=RaggedRight,margin=0pt, figurewithin=section, tablewithin=section]{caption}






% %  customizing fonts, usually not required
% \RequirePackage[T1]{fontenc}
% \usepackage{mathptmx}
% \RequirePackage{mathspec}
% \setmathsfont(Digits,Latin,Greek)[
%     Path = fonts/,
%     Extension = .otf,
%     BoldFont=ArnoPro-Bold,
%     ItalicFont=ArnoPro-Italic,
%     BoldItalicFont=ArnoPro-BoldItalic,
%     Numbers={OldStyle,Proportional}
% ]{ArnoPro-Regular}
% \setmathrm[
%     Path = fonts/,
%     Extension = .otf,
%     BoldFont=ArnoPro-Bold,
%     ItalicFont=ArnoPro-Italic,
%     BoldItalicFont=ArnoPro-BoldItalic,
% ]{ArnoPro-Regular}
% \RequirePackage{fontspec,xltxtra,xunicode}
% \defaultfontfeatures{Mapping=tex-text, Numbers=OldStyle}
% \setromanfont[  
% 		Path = fonts/,
% 		Extension = .otf,
% 		UprightFont=ArnoPro-Regular,
% 		BoldFont=ArnoPro-Bold,
% 		ItalicFont=ArnoPro-Italic,
% 		BoldItalicFont=ArnoPro-BoldItalic,
% 		Mapping=tex-text, 
% 		Numbers=OldStyle, 
% 		Ligatures={Common}, 
% 		SizeFeatures={%
% 				{Size={-10}, Font=ArnoPro-Caption, BoldFont=ArnoPro-BoldCaption, ItalicFont=ArnoPro-ItalicCaption, BoldItalicFont=ArnoPro-BoldItalicCaption},
% 				{Size={10-13.0}, Font=ArnoPro-Regular, BoldFont=ArnoPro-Bold, ItalicFont=ArnoPro-Italic, BoldItalicFont=ArnoPro-BoldItalic},
% 				{Size={13.01-19.9}, Font=ArnoPro-Subhead, BoldFont=ArnoPro-BoldSubhead, ItalicFont=ArnoPro-ItalicSubhead, BoldItalicFont=ArnoPro-BoldItalicSubhead, Ligatures=Rare},
% 				{Size={19.91-},Font=ArnoPro-Display, BoldFont=ArnoPro-BoldDisplay, ItalicFont=ArnoPro-ItalicDisplay, BoldItalicFont=ArnoPro-BoldItalicDisplay, Ligatures=Rare}
% 				}%
% 		]%
% 		{ArnoPro-Regular} %


% key definitions
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\department#1{\gdef\@department{#1}}
\def\field#1{\gdef\@field{#1}}
\def\university#1{\gdef\@university{#1}}
\def\universitycity#1{\gdef\@universitycity{#1}}
\def\universitystate#1{\gdef\@universitystate{#1}}

% for adding dac forms
\RequirePackage{pdfpages}

% define title page style; adding the page number to toc
\renewcommand{\maketitle}{ 
	\clearpage
	\thispagestyle{empty}
	\pagenumbering{roman}
	\setcounter{page}{1}
	\phantomsection
	\addcontentsline{toc}{chapter}{Title Page}
	\vspace*{\fill} 
	\begin{center}
	\begin{onehalfspace}
	\Huge \textcolor{Crimson}{\thetitle}
	\end{onehalfspace}
	\vspace{100pt}
	\begin{singlespace}
	\normalsize \sc 
	a dissertation presented \\ by\\
	\theauthor\\ to\\ The \@department\\ 
	\vspace{20pt}
	in partial fulfillment of the requirements\\ 
	for the degree of\\ \@degree\\ 
	in the subject of\\ \@field\\
	\vspace{100pt}
	\@university\\ \@universitycity, \@universitystate\\ 
	\@degreemonth\ \@degreeyear
	\end{singlespace}
	\end{center} 
	\vspace*{\fill}
}

% define copyright page style; adding the page number to toc
\newcommand{\copyrightpage}{
	\clearpage 
	\thispagestyle{empty} 
	\vspace*{\fill}
	\pagenumbering{roman}
	\setcounter{page}{2}
	\phantomsection
	\addcontentsline{toc}{chapter}{Copyright}
	{\sc \noindent \copyright~\textit{\@degreeyear \hspace{3pt}~- \theauthor} \\
	\noindent All rights reserved.}
	\vspace*{\fill}
}

% define abstract page style; adding the page number to toc
\newcommand{\abstractpage}{
	\clearpage
	\pagenumbering{roman}
	\setcounter{page}{3}
	\phantomsection
	\addcontentsline{toc}{chapter}{Abstract}
	\pagestyle{fancy}
	\lhead{Dissertation Advisor: \@advisor} \rhead{\@author}
	\renewcommand{\headrulewidth}{0.0pt} 
	\begin{center}
	\vspace*{20pt}
	\begin{onehalfspace}
	\Huge \textcolor{Crimson}{\@title}
	\end{onehalfspace}
	\vspace*{30pt}
	{\sc \large Abstract}
	\end{center}
	\vspace*{15pt}
	\begin{doublespace}
	\normalsize
	\input{frontmatter/abstract}
	\end{doublespace}
	\cfoot{\thepage}
}

% change toc page style; adding the page number to toc
\RequirePackage{etoolbox} % Add this in your preamble if not already used
\RequirePackage[titles]{tocloft}
\setcounter{tocdepth}{1}
\renewcommand{\cftchapfont}{\normalsize \scshape}
\renewcommand{\contentsname}{Table of Contents} % Change the TOC title

% Redefine \tableofcontents to add itself to TOC with proper linking
\pretocmd{\tableofcontents}{
  \clearpage
	\lhead{} \rhead{}
  \phantomsection
  \addcontentsline{toc}{chapter}{Table of Contents}
}{}{}


% define dedication page style; adding the page number to toc
\newcommand{\dedicationpage}{
	\clearpage
	\phantomsection
  \addcontentsline{toc}{chapter}{Dedication}
	\pagestyle{fancy}
	\thispagestyle{fancy} \vspace*{\fill}
	{\sc \noindent \input{frontmatter/dedication}}
	\vspace*{\fill}
	}

% define list of authors page style; adding the page number to toc
\newcommand{\authorlist}{
	\clearpage
	\pagestyle{fancy}
	\thispagestyle{fancy} 
	\phantomsection
	\chapter*{Author List}
	\addcontentsline{toc}{chapter}{Author List}
	\noindent \input{frontmatter/authorlist}
	}

% define acknowledgment style; adding the page number to toc
% ``acknowledgment'' is american style (without e)
\newcommand{\acknowledgments}{
	\clearpage
	\phantomsection
	\chapter*{Acknowledgments}
	\addcontentsline{toc}{chapter}{Acknowledgments}
	\noindent
	\begin{doublespace}
		\input{frontmatter/thanks}
	\end{doublespace}
	\vspace*{\fill} 
	\clearpage
	\setcounter{page}{1}
	\pagenumbering{arabic}
}

% change lof and lot page style; adding the page numbers to toc
\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}

% Ensure TOC entries and hyperlinks for LoF and LoT
\pretocmd{\listoffigures}{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
}{}{}

\pretocmd{\listoftables}{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}
}{}{}


% % providing an environment for paragraph-style section
% \providecommand\newthought[1]{%
%    \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
%    \noindent\textsc{#1}}


% for adding appendices
\RequirePackage{appendix}

\RequirePackage[numbers, comma, sort&compress]{natbib}
% change reference page title
\renewcommand\bibname{References}
% % list an entire bibliography entry inline. Useful for acknowledging when my paper was previously published
% \RequirePackage{bibentry} 
% \nobibliography*
