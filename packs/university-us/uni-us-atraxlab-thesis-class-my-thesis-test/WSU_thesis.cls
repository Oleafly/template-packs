% Thesis class file for Wright State University graduate school requirements.
% Author: Adrienne Traxler, adrienne.traxler@gmail.com

% Status 3/14/22: Update centering on signatures page.
% 2/2/20: Update graduate dean information (Barry Milligan is interim). 
% 5/30/18: Add \phantomsection to references environment so hyperref will link to correct page from TOC. Add \approvtitle definition to hack line break into the approval page.
% 1/17: Adjusted \vspace between lines flanking "By" on title page.
% 1/16: Fixed: \LoadClass needs to go after \ProcessOptions, otherwise it ignores them
% 1/14/17: Rearrange/cleanup a bit, add \relax after \ProcessOptions, comment \DeclareOption* back in to handle options not otherwise specified.
% 12/8: Update abstract section to use setspace commands (\doublespacing, etc.) rather than \linespread.
% 11/22: Added RequirePackage{setspace} to make spacing easier; add \doublespacing in thesis document right after frontmatter.
% 5/31-6/1/16: Set up abstract page, still need to fix bottom margins/page numbers.
%
%
% Details on requirements here: https://www.wright.edu/graduate-school/graduate-thesis-and-dissertation-handbook-sections-of-the-thesis
% Sections marked with an asterisk are optional.

% Working:
%title page
%*copyright page
%approval sheet
%abstract  
%table of contents
%*list of figures or illustrations
%*list of tables

% In progress:
%*preface
%*acknowledgment
%*dedication

% Issues remaining:
% Approval page needs the ugly \approvtitle hack to properly wrap with underline
% Currently set up for MS theses, would need slightly different approval page for PhD

% All class files should start with a version of these two lines
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WSU_thesis}[2020/02/20 v0.7-my-thesis Wright State University Thesis Class]


%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%% Declare options the new class may want to use
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
% What to do with options not defined in the list above:
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%% Load the basic class, starting from a report
\LoadClass{report}
\RequirePackage{titlesec}  % for modifying section header formats
\RequirePackage{setspace}  % for modifying line spacing
\RequirePackage[normalem]{ulem}  % for line-breaking underlines
% Page margins: 1.5 on left, 1 on top (2 on top for frontmatter and chapter starts), 1 on left and bottom
\RequirePackage[letterpaper,top=1in,bottom=1in,left=1.5in,right=1in]{geometry}
\RequirePackage{times}  % Default font Times New Roman

%% More declarations
% If I need to modify chapter header formats (right now no, see \titlespacing below)
% titleformat command: \titleformat{<command>}[<hshape>]{<format>}{<label>}{<sep>}{<before>}[<after>]
\titleformat{\chapter}[display]         	% Customise the \chapter command, which uses ``display'' as its default shape
{\normalfont\huge\bfseries}		% default format: {\normalfont\huge\bfseries}
{\chaptertitlename\ \thechapter}		% default label: {\chaptertitlename\ \thechapter}
{20pt}					% default pre-separation: 20pt
{\Huge}

% Set different margins (2 inch top) for chapter headings
% titlespacing command: \titlespacing*{<command>}{<left>}{<beforesep>}{<aftersep>}[<right>]
\titlespacing*{\chapter}
{0pt}		% increases left margin, default 0pt
{1in}		% vertical space before title, default 50pt
{40pt}	% separation between title and text, default 40pt


%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************

% DECLARATIONS
%
% These macros are used to declare arguments needed for the construction of the front matter.

% The fullname in Last, First Middle format (abstract needs, easier to input than construct
\def\namelastfirst#1{\gdef\@namelastfirst{#1}}

% The year, month (March, June,...), and day of the month (1, 2, 3,...) the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeday#1{\gdef\@degreeday{#1}}

% The title with line breaks as needed to make the approval page not overrun its margins (this otherwise appears to be impossible with underlining)
\def\approvtitle#1{\gdef\@approvtitle{#1}}

% The full (unabbreviated) name of the degree and its appreviation
\def\degree#1{\gdef\@degree{#1}}
\def\degreeabv#1{\gdef\@degreeabv{#1}}

% All previous degrees: one per line in chronological order
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}}

% The name of your department chair
\def\deptchair#1{\gdef\@deptchair{#1}}

% The names of your other committe members, one per line
\def\committeememberone#1{\gdef\@committeememberone{#1}}
\def\committeemembertwo#1{\gdef\@committeemembertwo{#1}}
\def\committeememberthree#1{\gdef\@committeememberthree{#1}}
\def\committeememberfour#1{\gdef\@committeememberfour{#1}}
\def\committeememberfive#1{\gdef\@committeememberfive{#1}}

% The name of the dean and dean's title(s)
\def\deanlineone#1{\gdef\@deanlineone{#1}}
\def\deanlinetwo#1{\gdef\@deanlinetwo{#1}}
\def\deanlinethree#1{\gdef\@deanlinethree{#1}}

% The number of committee members, which affects both the number of lines and
% the amount of space between lines on the approval page.
\def\@numberofmembers{5}
\def\@approvalspace{.75in}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}
	\ifnum \@numberofmembers > 3
	\gdef\@approvalspace{.5in}
	\fi}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set correctly
% (roman, lower-case, starting at 3) for the front matter that follows the
% abstract.  It also resets page-numbering for the remainder of the dissertation
% (arabic, starting at 1).

\newenvironment{frontmatter}
%{\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}


% TITLE PAGE
%
% The title page does...

\def\maketitle{
	{\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
	\thispagestyle{empty}
	
	% extend down to the page number area (UCSC), which is 1.25in from the bottom
	%	\enlargethispage{\footskip}
	%\newgeometry{top=2in}
	\newgeometry{top=2in,bottom=1in,left=1.5in,right=1in}
	\savegeometry{L2}
	\begin{center}
		%\fmfont
		\bigskip
		{\bfseries {\expandafter\uppercase\expandafter{\@title}} \par}
		\vfill
		A thesis submitted in partial fulfillment of the \par
		requirements for the degree of \par
		{\expandafter\expandafter{\@degree}} \par
		%\bigskip   % Changed this to better visually match sample
		\vspace{0.6in}
		By \par
		%\bigskip
		\vspace{0.6in}
		%    {\bfseries \@author} \par
		{\expandafter\uppercase\expandafter{\@author}} \par
		{\expandafter\expandafter{\@prevdegrees}} \par
		\vfill
		{\@degreeyear} \par
		Wright State University \par
	\end{center}
	\restoregeometry
	\setcounter{footnote}{0}
}  % Added but it wasn't here, see note below approval page

% COPYRIGHT PAGE
%
% This page is optional.
\def\copyrightpage{
	\thispagestyle{empty}
	\begin{center}
		{%\fmfont
			\ \ \ \
			\vfill
			Copyright \copyright\ by\par
			\@author \par
			\@degreeyear \par}
		\vfill
		\ \ \ \ \
	\end{center}
	\newpage
}


% APPROVAL PAGE
%
% In the UCSC class, this was part of the title page. For Wright State, it's separate.
% This counts as page ii (see setcounter command), but is never visibly numbered.
\def\approvalpage{
	{\setcounter{page}{2}\renewcommand{\thepage}{\roman{page}}}
	\thispagestyle{empty}
	% extend down to the page number area (UCSC), which is 1.25in from the bottom
	\enlargethispage{\footskip}
	%    \null\vfil
	%\vfill
	%\newgeometry{top=2in}
	\loadgeometry{L2}
	\begin{center}
		WRIGHT STATE UNIVERSITY \par
		\bigskip
		GRADUATE SCHOOL \par
		\bigskip
	\end{center}
	
	\hfill\uline{\@degreemonth\ \@degreeday, \@degreeyear} \par
	%% Can't get the underline working, move on for now
	\begin{flushleft}
		\noindent I HEREBY RECOMMEND THAT THE THESIS PREPARED UNDER MY SUPERVISION BY
		\uline{\@author} ENTITLED \uline{\@approvtitle}\ %\expandafter\uline\@title\
		BE ACCEPTED IN PARTIAL FULFILLMENT OF THE REQUIREMENTS FOR THE DEGREE OF
		\uline{\@degree}.
	\end{flushleft}
	
	\begin{center}
		%\hfill \parbox{3in}{The Dissertation of {\@author}\\ is approved:} \\
		\bigskip \bigskip
		\hfill\rule{2.6in}{0.5pt}\\
		\hfill\makebox[2.6in][c]{\@chair}\\
		\hfill\makebox[2.6in][c]{Thesis Director}\\
		\bigskip \medskip
		\hfill\rule{2.6in}{0.5pt}\\
		\hfill\makebox[2.6in][c]{\@deptchair}\\
		\hfill\makebox[2.6in][c]{Chair, Department of \@field}\\
	\end{center}
	
	\vfill
	\noindent Committee on \\
	Final Examination \par
	\bigskip
	\noindent\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@chair}\\
	\medskip
	
	\noindent\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@committeememberone}\\
	\medskip
	
	\noindent\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@committeemembertwo}\\
	\medskip
	
	\ifnum \@numberofmembers > 3
	\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@committeememberthree}\\
	\medskip
	\fi
	
	\ifnum \@numberofmembers > 4
	\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@committeememberfour}\\
	\medskip
	\fi
	
	\ifnum \@numberofmembers > 5
	\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@committeememberfive}\\
	\medskip
	\fi
	
	\noindent\noindent
	\rule{2.6in}{0.5pt}\\
	\makebox[2.6in][c]{\@deanlineone}\\
	\makebox[2.6in][c]{\@deanlinetwo}\\
	\makebox[2.6in][c]{\@deanlinethree}\\
	\restoregeometry
	\newpage
}%}

%}  Was this mismatched with title page, above?


% ABSTRACT
%
% MS thesis abstracts ``should not exceed 150 words,'' according to the grad school guidelines.
% Visible page numbering (small Roman numerals) starts here.

\def\abstract{
	%\addcontentsline{toc}{chapter}{Abstract}		% WSU theses I've seen don't include this in the TOC.
	%\newgeometry{top=2in}
	\loadgeometry{L2}
	\begin{center}
		ABSTRACT \par
		\vspace{3\baselineskip}  % Is this actually specified? The one below (before actual abstract text) is.
	\end{center}
	%Lastname, Firstname Middlename.
	{\@namelastfirst}. \@degreeabv\ Department of \@field, Wright State University, \@degreeyear. \@title. \par
	\vspace{3\baselineskip}
	\doublespacing
}

\def\endabstract{\restoregeometry}
%\def\endabstract{\linespread{1.0}\restoregeometry}%\par\vfil\null}

%{\tableofcontents \let\cleardoublepage\clearpage}


% DEDICATION
%
% The dedication environment just makes sure the dedication gets its own page.
\newenvironment{dedication}
%{\addcontentsline{toc}{chapter}{Dedication}}	% WSU theses I've seen don't include this in the TOC.
{}
%\newpage

% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}
{%\addcontentsline{toc}{chapter}{Acknowledgments}	% WSU theses I've seen don't include this in the TOC.
	%\newgeometry{top=2in}
	\loadgeometry{L2}
	\begin{center}
		{\large \bfseries Acknowledgments}
\end{center}}
{\restoregeometry\newpage}


% BIBLIOGRAPHY
%
% The references environment adds the appropriate item to the TOC and corrects
% the page number.

\newenvironment{references}
{\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{Bibliography}
	%\loadgeometry{L2}
}
{\restoregeometry\newpage}


%\titleformat{\section}         % Customise the \section command
%  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
%                               % small capitals (\scshape) and left aligned (\raggedright)
%  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
%  {}                           % Can be used to insert code before the heading
%  [\titlerule]                 % Inserts a horizontal line after the heading	
%
%\titleformat{\subsection}
%  {\large\scshape\raggedright}
%  {}{0em}
%  {}
%
%% Add date space to sections
%\newcommand{\datedsection}[2]{%
%  \section[#1]{#1 \hfill #2}%
%}
%\newcommand{\datedsubsection}[2]{%
%  \subsection[#1]{#1 \hfill #2}%
%}
%
%
%% Header information
%\newcommand{\name}[1]{
%  \centerline{\Huge{#1}}
%}
%
%\newcommand{\contact}[5]{
%    #1 {\large\textperiodcentered} #2 {\large\textperiodcentered} #3
%    {\Large} #4 \ {\Large} #5
%}
%
%\newcommand{\longcontact}[5]{
%    \center{#1 \hfill {\large\textperiodcentered} \hfill #2 \hfill {\large\textperiodcentered} \hfill #3}
%    \center{ {\Large} #4 \hfill {\Large} #5}
%}
%
%
%% Add bulleted list of work items
%\newcommand{\workitems}[3]{
%    \begin{itemize}
%    \item #1
%    \item #2
%    \item #3
%    \end{itemize}
%}
