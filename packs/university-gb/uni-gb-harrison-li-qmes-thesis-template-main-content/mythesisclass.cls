% mythesisclass.cls
% A custom LaTeX class based on the report class with specific formatting
% requirements from the original preamble.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesisclass}[2023/10/27 v1.0 My Thesis Class]

% Define options and load the base class
% Process standard paper size and font size options
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{letterpaper}{\PassOptionsToClass{\CurrentOption}{report}} % Example: Add support for other paper sizes
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{report}}
% Pass any other options unknown to this class directly to report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions* % Apply the options declared above

% Load the base class (report) with the processed options
\LoadClass{report}

% --- Require Packages (equivalent of \usepackage) ---
\RequirePackage{tocloft}
\RequirePackage{amssymb}
% Geometry options loaded here directly
\RequirePackage[left=25mm, right=25mm, top=25mm, bottom=25mm]{geometry}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{floatrow}
\RequirePackage{subfig} % For \subfloat
\RequirePackage[table,xcdraw]{xcolor}
\RequirePackage{titling}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage[super]{natbib}
\RequirePackage{amsmath}
\RequirePackage{tcolorbox}
\tcbuselibrary{listingsutf8} % Library used even if tcolorbox isn't explicitly called in the class
\RequirePackage[UTF8]{ctex}
\RequirePackage{booktabs}
\RequirePackage{float}
\RequirePackage{indentfirst}

% Font settings - Times New Roman (Requires XeLaTeX or LuaLaTeX)
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% Define color scheme
\definecolor{darkblue}{RGB}{0, 102, 204}
\definecolor{highlight}{RGB}{255, 255, 204}

% Hyperref settings (load late, before cleveref if used)
\RequirePackage[colorlinks=true,bookmarksopen=true,bookmarksnumbered=true,
citecolor=blue,linkcolor=blue,urlcolor=blue]{hyperref}

% Reference settings
\renewcommand{\bibname}{References}

% Float settings
\floatstyle{plaintop}
\restylefloat{table}
\floatsetup[figure]{style=plain,subcapbesideposition=top} % Figure caption above (applies to main figure caption by default for "plain" style)

% Header and footer settings
% This is typically set in the document preamble or after \begin{document}
% if you want it to apply only to certain pages.
% However, defining the style here makes it available.
% We can set the initial pagestyle here.
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{1pt} % Change from 0pt to 1pt to add a line
% Placeholder header text - this might be better placed in the main document's preamble
% if you want it to vary, but it's from the original preamble so we put it here.
\fancyhead[C]{\fontsize{10}{12}\selectfont Undergraduate Graduation Design (Thesis) of QMUL Engineering School, NPU}
\fancyfoot[C]{\thepage} % Page number centered at bottom

% Set default citation style (if natbib is loaded)
\setcitestyle{comma} % Change separator to comma


% --- Heading Formatting ---
% Need \makeatletter to use @ in command names
\makeatletter

% Chapter heading format (Major heading)
\def\@makechapterhead#1{%
	\vspace*{10\p@}% % Vertical space above heading (adjust as needed)
	{\parindent \z@ \centering \normalfont
		\bfseries % Apply bold to the entire line
		\@chapapp\space \thechapter% % "Chapter X"
		\quad % Add horizontal space between number and title (you can use \space, \quad, \qquad, or a specific length like 1em)
		#1% % The Chapter Title
		\par\nobreak % End the line/paragraph here
		\vspace{40\p@}% % Vertical space below heading (adjust as needed)
}}

\def\@makeschapterhead#1{% % For unnumbered chapters like TOC, List of Figures, etc.
	\vspace*{10\p@}%
	{\parindent \z@ \centering
		\normalfont
		\interlinepenalty\@M
		\bfseries #1\par\nobreak
		\vspace{1\p@}
}}

% Section heading format (Subheading 1)
\renewcommand\section{\@startsection{section}{1}{0.5\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\normalfont\bfseries\raggedright}}

% Subsection heading format (Subheading 2)
\renewcommand\subsection{\@startsection{subsection}{2}{0.5em}%
	{-0.5ex\@plus -1ex \@minus -.2ex}%  <--- This line, specifically -3.25ex
	{1.5ex \@plus .2ex}%
	{\normalfont\bfseries\itshape}}

% Command to ensure subsection titles end with period if they don't already
% Use \@addpunct from LaTeX kernel for more robust punctuation handling
\let\oldsubsection\subsection
\renewcommand{\subsection}[1]{%
	\oldsubsection{#1\ifnum\pdfstrcmp{\pdffilesize{\detokenize{#1}}}{.}=0\else.\fi}%
}


% Need \makeatother to go back to normal
\makeatother


% --- Spacing Settings ---
% Double spacing throughout the document by default
\doublespacing % Use doublespace command from setspace package

% Exception for References and Tables spacing
% These are executed *after* \begin{document} when the environment starts
% Exception for References and Tables spacing
\AtBeginEnvironment{thebibliography}{\singlespacing}
% Note: \begin{table}...\end{table} is the table environment,
% applying singlespacing here makes the *content* of the table environment single-spaced.
% If you want the *entire* float (caption, table, spacing around it) to be single-spaced,
% it's more complex, but this matches the original preamble's intent.
\AtBeginEnvironment{table}{\singlespacing}


% End of mythesisclass.cls
