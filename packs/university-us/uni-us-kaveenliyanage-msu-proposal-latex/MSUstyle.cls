%% Updated and maintained by Prof. Mark Owkes mark.owkes@montana.edu
%% 
%% ---------------------- Origional Header ----------------------------
%% 
%% MSUstyle.cls was created and edited by Seth Humphries in Jun-2007 and
%% last update 21-Nov-2009
%% Copyright (c) 2007,2008, 2009 Seth HD. umphries
%% This work is licensed under the Creative Commons
%% Attribution-Noncommercial-Share Alike 3.0 License. To view a copy
%% of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/;
%% or, (b) send a letter to Creative Commons, 171 2nd Street, Suite
%% 300, San Francisco, California, 94105, USA.
%% 
%% The above copyright notice and this permission notice shall be incuded 
%%	in all copies or substantial portions of the Software.
%% 
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
%%	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
%%	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
%%	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
%%	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
%%	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
%%	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

%%%%%%%%%%%% IDENTIFICATION        %%%%%%%%%%%%
\newcommand{\MSUstyleversion}{2.0}% current version number
\newcommand{\MSUstyleupdated}{2017/6/30}% date of last change(s)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MSUstyle}
[\MSUstyleupdated\space\MSUstyleversion\space(Montana State Graduate School)]%
\RequirePackage{calc}% part of LaTeX tools bundle   
\RequirePackage[plain]{algorithm}
\RequirePackage{algorithmic}

\RequirePackage{ccicons}

%%%%%%%%%%%% INITIAL CODE         %%%%%%%%%%%%
\widowpenalty=500 % Try to avoid widows at bottom of page 
\clubpenalty=1000 % No orphans at top of page 
\brokenpenalty=999 %no hyphenations at page breaks
\hyphenpenalty=1000 %no hyphenation at end of lines
\tolerance=1000 %adjust to make the above penalties tighter or looser 
\raggedbottom



%% Switch for testing draft mode (toggled by ``draft'' option).
\newif\if@draft
\@draftfalse % initially false by default

%% Switch for testing current page style.
\newif\if@tcpage
% no default value (set by \pagestyle)
% indicates that page numbers are in the upper corners

%% Switch for alternative chapter headings (toggled by ``altchapter'' option).
\newif\if@altchapter
\@altchapterfalse % initially false by default

%% Switch for big inner margins (toggled by ``bigmargin'' option).
\newif\if@bigmargin
\@bigmarginfalse % initially false by default

%% Switches for appendices
\newif\ifAppendmultiple
\Appendmultiplefalse % initially false by default
\newif\ifAppendsingle
\Appendsinglefalse % initially false by default

%% Switches for Creative Commons copyright
\newif\ifCopyrightcc
\Copyrightccfalse % initially false


%% Because of the draft option, and to allow users to override
%% defaults, we don't want to be passing conflicting options back to
%% the report class, so we define our own temporary toggles holding
%% the most recent setting for each of four basic options: point size,
%% number of page sides, whether new chapters open on right-hand pages
%% or on any page, and line spacing.  These toggles will be set from
%% the corresponding options below.
% 
\newcommand{\@thesisptsz}{}
\newcommand{\@thesisside}{}
\newcommand{\@thesisopen}{}
\newcommand{\@thesislnsp}{}

%% the next couple commands are used to switch between 
%% differences in theses and dissertations
\newcommand{\perm}{}
\newcommand{\degree}{}
\newcommand{\degreetype}{}

% \setlength{\intextsep}{14pt}

%%%%%%%%%%%% OPTION DECLARATION      %%%%%%%%%%%%

%% ``draft'' option: change default document settings.
\DeclareOption{draft}{\@drafttrue
  \typeout{MyThesis Class Option: ``draft''}
  \ExecuteOptions{11pt,oneside,openany,doublespaced,normalmargins}
  \PassOptionsToClass{draft}{report}
  %% Macros for printing "DRAFT" at the corners of a page.
  \newcommand{\tlDRAFT}%
  {\raisebox{ 3ex}[0pt][0pt]{\sffamily\scriptsize \llap{DRAFT\ V}ersion \@draftver}}
  \newcommand{\trDRAFT}%
  {\raisebox{ 3ex}[0pt][0pt]{\sffamily\scriptsize DRAFT\ V\rlap{ersion \@draftver}}}
  \newcommand{\blDRAFT}%
  {\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize \llap{DRAFT\ V}ersion \@draftver}}
  \newcommand{\brDRAFT}%
  {\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize DRAFT\ V\rlap{ersion \@draftver}}}
}%DeclareOption{draft}

%% ``altchapter'' option: use alternative chapter headings
\DeclareOption{altchapter}{\@altchaptertrue}
\DeclareOption{numberedsections}{\@altchaptertrue}

%% ``bigMargin'' options: use 1.5" inner margins
\DeclareOption{bigmargin}{\@bigmargintrue}


%% Point Size options: change current setting.
\DeclareOption{10pt}{\renewcommand{\@thesisptsz}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@thesisptsz}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@thesisptsz}{12pt}}
\DeclareOption{13pt}{\renewcommand{\@thesisptsz}{13pt}}

%% Number of Page Sides options: change current setting.
\newif\if@twoside
\@twosidefalse % initially false by default
\DeclareOption{twoside}{\renewcommand{\@thesisside}{twoside} \@twosidetrue}
\DeclareOption{oneside}{\renewcommand{\@thesisside}{oneside}}

%% New Chapter Openings options: change current setting.
\DeclareOption{openany}{\renewcommand{\@thesisopen}{openany}}
\DeclareOption{openright}{\renewcommand{\@thesisopen}{openright}}

%% Line Spacing options: change current setting.
\DeclareOption{singlespaced}{\renewcommand{\@thesislnsp}{1}}
\DeclareOption{oneandahalfspaced}{\renewcommand{\@thesislnsp}{1.25}}
\DeclareOption{doublespaced}{\renewcommand{\@thesislnsp}{1.66}}

\DeclareOption{thesis}{\renewcommand{\perm}{\@thesisPermission}%
  \renewcommand{\degree}{\@thesisD}%
  \renewcommand{\degreetype}{\@thesisDT}%
}
\DeclareOption{dissertation}{\renewcommand{\perm}{\@dissertationPermission}%
  \renewcommand{\degree}{\@dissertationD}%
  \renewcommand{\degreetype}{\@dissertationDT}%
}
\DeclareOption{compexam}{\renewcommand{\degree}{\@dissertationD}%
  \renewcommand{\degreetype}{\@compexam}%
}

% Appendix option
\DeclareOption{appendsingle}{\Appendsingletrue}
\DeclareOption{appendmultiple}{\Appendmultipletrue}

%% Copyright options
\DeclareOption{copyrightcc}{\Copyrightcctrue}


%% All other options are passed to the base class directly.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}


%%%%%%%%%%%% OPTION EXECUTION       %%%%%%%%%%%%
%% Default settings.
\ExecuteOptions{12pt,letterpaper,oneside,%
  openright,doublespaced,normalmargins,dissertation,final}
% 
\ProcessOptions


%%%%%%%%%%%% PACKAGE  LOADING       %%%%%%%%%%%%
%% Load base class using current setting for basic options.
\LoadClass[\@thesisptsz,\@thesisside,\@thesisopen]{report}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%% MAIN  CODE          %%%%%%%%%%%%


%%% phantomsection, texorpdfstring, and pdfbookmark are needed if you do
%%% not compile via pdflatex. !!!!!!!!!
% \newcommand{\phantomsection}{}% helps with hyperref.  \phantomsection
% is provided by pdflatex, but not latex.
% \newcommand{\texorpdfstring}[2]{#1}%
% \def\pdfbookmark[#1]#2#3{}%
%%%%%% 

\newcommand{\ignore}{} %used to comment out parts of latex
\newcommand{\comment}{} %used to comment out parts of latex




%%%%%% Line Spacing
% 
%% \linespacing is used to define the default line spacing. 
%% for the entire document. If the argument is less than 
%% 1.25 (for 1.5-spaced) a warning message is displayed
%% when not in draft mode.
%% 
%% Don't use this command for temporary, localized changes.
%% Instead, use the ``spacing environments'':
%% \begin{singlespaced}      ...\end{singlespaced}
%% \begin{oneandahalfspaced}...\end{oneandahalfspaced}
%% \begin{doublespaed}      ...\end{doublespaced}
%% \begin{longquote}        ...\end{longquote}
%% \begin{longquotation}    ...\end{longquotation}
%% \begin{newspacing}{x.xx} ...\end{newspacing}
\newcommand{\linespacing}[1]{%
  \gdef\@spacing{#1}
  \newlinestretch{#1}\if@draft\else\ifdim #1pt < 1.25pt\typeout
  {MyThesis Class Warning: line spacing less than 1 1/2}\fi\fi
}

% 
%% ``longquote'' and ``longquotation'' produce single-spaced quotes, while
%% ``newspacing'' encloses paragraphs with a different line spacing,
%% such as ``singlespaced'', ``oneandahalfspaced'', or ``doublespaced''.
\newenvironment{longquote}%
{\begin{quote}\newlinestretch{1}}{\end{quote}}
\newenvironment{longquotation}%
{\begin{quotation}\newlinestretch{1}}{\end{quotation}}
\newenvironment{singlespaced}%
{\begin{newspacing}{1}}{\end{newspacing}}
\newenvironment{oneandahalfspaced}%
{\begin{newspacing}{1.5}}{\end{newspacing}}
\newenvironment{doublespaced}%
{\begin{newspacing}{2}}{\end{newspacing}}
\newenvironment{newspacing}[1]%
{\par\begingroup\newlinestretch{#1}}%
{\par\vskip\parskip\vskip\baselineskip\endgroup
  \vskip-\parskip\vskip-\baselineskip}

% 
%% To change the actual line spacing.
\newcommand{\newlinestretch}[1]%
{\renewcommand{\baselinestretch}{#1}\currenttextsize}

% 
%% To keep track of the current text size.
\let\currenttextsize=\normalsize
% 
%% Redefine size-changing commands to update \currenttextsize.
\let\tmp@tiny=\tiny
\renewcommand{\tiny}%
{\let\currenttextsize=\tmp@tiny\tmp@tiny}
\let\tmp@scriptsize=\scriptsize
\renewcommand{\scriptsize}%
{\let\currenttextsize=\tmp@scriptsize\tmp@scriptsize}
\let\tmp@footnotesize=\footnotesize
\renewcommand{\footnotesize}%
{\let\currenttextsize=\tmp@footnotesize\tmp@footnotesize}
\let\tmp@small=\small
\renewcommand{\small}%
{\let\currenttextsize=\tmp@small\tmp@small}
\let\tmp@normalsize=\normalsize
\renewcommand{\normalsize}%
{\let\currenttextsize=\tmp@normalsize\tmp@normalsize}
\let\tmp@large=\large
\renewcommand{\large}%
{\let\currenttextsize=\tmp@large\tmp@large}
\let\tmp@Large=\Large
\renewcommand{\Large}%
{\let\currenttextsize=\tmp@Large\tmp@Large}
\let\tmp@LARGE=\LARGE
\renewcommand{\LARGE}%
{\let\currenttextsize=\tmp@LARGE\tmp@LARGE}
\let\tmp@huge=\huge
\renewcommand{\huge}%
{\let\currenttextsize=\tmp@huge\tmp@huge}
\let\tmp@Huge=\Huge
\renewcommand{\Huge}%
{\let\currenttextsize=\tmp@Huge\tmp@Huge}
% 

%%%%%% Front Matter Parameters
% 
%% The following commands set the respective field values so we
%% can generate the title page, copyright page, permissions page 
%% and signature page automatically
% 
\renewcommand{\author}[1]%
{\ifx\empty#1\empty\else\gdef\@author{#1}\fi}

\renewcommand{\title}[1]%
{\ifx\empty#1\empty\else\gdef\@title{#1}\fi}

\newcommand{\departmentchair}[1]%
{\ifx\empty#1\empty\else\gdef\@departmentchair{#1}\fi}

\newcommand{\committeechair}[1]%
{\ifx\empty#1\empty\else\gdef\@committeechair{#1}\fi}

\newcommand{\graduatedean}[1]%
{\ifx\empty#1\empty\else\gdef\@graduatedean{#1}\fi}

\newcommand{\department}[1]%
{\ifx\empty#1\empty\else\gdef\@department{#1}\fi}

\newcommand{\degreetitle}[1]%
{\ifx\empty#1\empty\else\gdef\@degreetitle{#1}\fi}

\newcommand{\copyrightyear}[1]%
{\ifx\empty#1\empty\else\gdef\@copyrightyear{#1}\fi}

\newcommand{\submitdate}[1]%
{\ifx\empty#1\empty\else\gdef\@submitdate{#1}\fi}

\newcommand{\thesisPermission}[1]%
{\ifx\empty#1\empty\else\gdef\@thesisPermission{#1}\fi}

\newcommand{\dissertationPermission}[1]%
{\ifx\empty#1\empty\else\gdef\@dissertationPermission{#1}\fi}

\newcommand{\thesisD}[1]%
{\ifx\empty#1\empty\else\gdef\@thesisD{#1}\fi}

\newcommand{\dissertationD}[1]%
{\ifx\empty#1\empty\else\gdef\@dissertationD{#1}\fi}

\newcommand{\thesisDT}[1]%
{\ifx\empty#1\empty\else\gdef\@thesisDT{#1}\fi}

\newcommand{\dissertationDT}[1]%
{\ifx\empty#1\empty\else\gdef\@dissertationDT{#1}\fi}

\newcommand{\draftver}[1]%
{\ifx\empty#1\empty\else\gdef\@draftver{#1}\fi} %draft version 

\newcommand{\name}[1]%
{\ifx\empty#1\empty\else\gdef\name{#1}\fi} %name

\newcommand{\keys}[1]%
{\ifx\empty#1\empty\else\gdef\keys{#1}\fi} %name

\newcommand{\DocTitle}[1]%
{\ifx\empty#1\empty\else\gdef\DocTitle{#1}\fi} %name

\newcommand{\OWNwebpage}[1]%
{\ifx\empty#1\empty\else\gdef\OWNwebpage{#1}\fi} %name
% 
%% bibliography databases
% 
\newcommand{\bibfiles}[1]%
{\ifx\empty#1\empty\else\gdef\@bibfiles{#1}\fi}

% 
%% default values of private functions
% 
\def\@title{\DocTitle}
\def\@author{\name}
\def\@bibfiles{}
\def\@committeechair{}
\def\@departmentchair{}
\def\@department{}
\def\@degreetitle{}
\def\@graduatedean{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\def\@gradyear{2008}  
\def\@copyrightyear{\number\the\year}
\def\@bibfiles{}
\def\@draftver{}


\def\@thesisDT{thesis} %degree type
\def\@thesisD{Master of Science} %degree
\def\@dissertationDT{dissertation} %degree type
\def\@dissertationD{Doctor of Philosophy} %degree
\def\@compexam{comprehensive exam}

\def\@dissertationPermission{In presenting this dissertation in partial fulfillment of the requirements for a doctoral degree at Montana State University, I agree that the Library shall make it available to borrowers under rules of the Library. I further agree that copying of this dissertation is allowable only for scholarly purposes, consistent with ``fair use'' as prescribed in the U.S. Copyright Law. Requests for extensive copying or reproduction of this dissertation should be referred to ProQuest Information and Learning, 300 North Zeeb Road, Ann Arbor, Michigan 48106, to whom I have granted ``the exclusive right to reproduce and distribute my dissertation in and from microform along with the non-exclusive right to reproduce and distribute my abstract in any format in whole or in part.''}

\def\@thesisPermission{In presenting this thesis in partial fulfullment of the requirements for a master's degree at Montana State University, I agree that the Library shall make it available to borrowers under rules of the Library. \newline \indent If I have indicated my intention to copyright this thesis by including a copyright notice page, copying is allowable only for scholarly purposes, consistent with ``fair use'' as prescribed in the U.S. Copyright Law.  Requests for permission for extended quotation from or reproduction of this thesis in whole or in parts may be granted only by the copyright holder.}

%% Switch for printing copyright notice on titlepage
% 
\newif\ifcopyright
\copyrightfalse % initially false by default

%% Switch for generating a title page
% 
\newif\iftitlepage
\titlepagetrue % initially true by default

%% Switch for generating a signature page
% 
\newif\ifsignaturepage
\signaturepagefalse % initially false by default

%% Switch for generating a list of figures
% 
\newif\iffigurespage
\figurespagetrue % initially true by default

%% Switch for generating a list of tables
% 
\newif\iftablespage
\tablespagetrue % initially true by default

%% Switch for generating a list of tables
% 
\newif\ifalgorithmspage
\algorithmspagetrue % initially true by default

%% Switch for generating a table of contents
% 
\newif\ifcontentspage
\contentspagetrue % initially true by default

%% Switch for generating a bibliography
% 
\newif\ifbibpage
\bibpagetrue % initially true by default

\newif\ifAppend %if there is no appendix the ref page has different look
\Appendfalse % initially false by default
\ifAppendsingle \Appendtrue \fi
\ifAppendmultiple \Appendtrue \fi

%% \settocdepth - use this to change how "deep" to number 
%% in the table of contents for different sections; e.g.
%% subsubsections for chapters, then switch to chapter-only
%% for appendices.
%% tocdepth is reset to the value in \setchaptertocdepth
%% at each \chapter{}, or to the value in \setappendixtocdepth
%% at each \chapter{} after the \appendix command.  So, if 
%% you want to change the defaults, use \setchaptertocdepth and 
%% \setappendixtocdepth.  To temporarily change depth for the 
%% current section, use a different function: \settocdepth[x].  
%% You should never need to call \setcounter{tocdepth}{..} 
%% directly.
%% 
%% 0 = chapter only
%% 1 = chapter + sections
%% 2 = chapter, section, subsection
%% 3 = chapter, section, subsection, subsubsection
% 
\newcommand{\settocdepth}[1]{%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{#1}}}
\newcommand{\setlotdepth}{%
  \addtocontents{lot}{\protect\setcounter{tocdepth}{1}}}
\newcommand{\setlofdepth}{%
  \addtocontents{lof}{\protect\setcounter{tocdepth}{1}}}

\newcommand{\setappendixtocdepth}[1]{%
  \def\appendix@tocdepth{#1}}

\newcommand{\setchaptertocdepth}[1]{%
  \def\chapter@tocdepth{#1}} 
\setchaptertocdepth{3} %call above function and set it
\setcounter{secnumdepth}{0}

\newcommand{\setfrontpagestyle}[1]{%
  \gdef\front@pagestyle{#1}}
\newcommand{\setbodypagestyle}[1]{%
  \gdef\body@pagestyle{#1}}
\newcommand{\setbackpagestyle}[1]{%
  \gdef\back@pagestyle{#1}}




% note that MT is the postal abreviation for Montana. go MSU!
% dummy commands to prevent recursion errors...
\newcommand{\MTcontentsname}{}
\newcommand{\toccontentlinestring}{}
\newcommand{\tocpdfbookmarkstring}{}
\newcommand{\MTlistfigurename}{}
\newcommand{\lofcontentlinestring}{}
\newcommand{\lofpdfbookmarkstring}{}
\newcommand{\MTlisttablename}{}
\newcommand{\lotcontentlinestring}{}
\newcommand{\lotpdfbookmarkstring}{}
\newcommand{\MTlistalgorithmname}{}
\newcommand{\loacontentlinestring}{}
\newcommand{\loapdfbookmarkstring}{}

\newcommand{\settocstring}[1]{%
  \renewcommand{\MTcontentsname}{#1}
  \renewcommand{\contentsname}{\MakeUppercase{#1}}
  \renewcommand{\toccontentlinestring}{%
    \texorpdfstring{\MakeUppercase{#1}}{#1}
  }
  \renewcommand{\tocpdfbookmarkstring}{#1}
}
\newcommand{\setlofstring}[1]{%
  \renewcommand{\MTlistfigurename}{#1}
  \renewcommand{\listfigurename}{\MakeUppercase{#1}}
  \renewcommand{\lofcontentlinestring}{%
    \texorpdfstring{\MakeUppercase{#1}}{#1}
  }
  \renewcommand{\lofpdfbookmarkstring}{#1}
}
\newcommand{\setlotstring}[1]{%
  \renewcommand{\MTlisttablename}{#1}
  \renewcommand{\listtablename}{\MakeUppercase{#1}}
  \renewcommand{\lotcontentlinestring}{%
    \texorpdfstring{\MakeUppercase{#1}}{#1}
  }
  \renewcommand{\lotpdfbookmarkstring}{#1}
}

\newcommand{\setloastring}[1]{%
  \renewcommand{\MTlistalgorithmname}{#1}
  \renewcommand{\listalgorithmname}{\MakeUppercase{#1}}
  \renewcommand{\loacontentlinestring}{%
    \texorpdfstring{\MakeUppercase{#1}}{#1}
  }
  \renewcommand{\loapdfbookmarkstring}{#1}
}

%% bookmark names
\settocstring{Table of Contents}
\setlotstring{List of Tables}
\setlofstring{List of Figures}
\setloastring{List of Algorithms}


%%%%%% Page Styles
% 
% redefinition of tcplain to meet MSU requirements (top center page numbering)
\if@twoside % if two-sided printing
\newcommand{\ps@tcplain}{%
  \@tcpagetrue%
  \let\@mkboth\markboth%
  \def\@oddfoot{%
    \if@draft%
    \blDRAFT\hfil%
    {\slshape\small\today}\hfil\brDRAFT%
    \fi%
  }%
  \let\@evenfoot\@oddfoot%
  \def\@oddhead{%
    \if@draft\tlDRAFT\fi%
    \hfil\thepage\hfil%
    \if@draft\trDRAFT\fi%
  }%
  \def\@evenhead{%
    \if@draft\tlDRAFT\fi%
    \hfil\thepage\hfil%
    \if@draft\trDRAFT\fi%
  }%
}%ps@tcplain
\else % if one-sided printing
\newcommand{\ps@tcplain}{%
  \@tcpagetrue%
  \let\@mkboth\markboth%
  \def\@oddfoot{%
    \if@draft%
    \blDRAFT\hfil%
    {\slshape\small\today}\hfil\brDRAFT%
    \fi%
  }%
  \def\@oddhead{%
    \if@draft\tlDRAFT\fi%
    \hfil\thepage\hfil%
    \if@draft\trDRAFT\fi%
  }%
}%ps@tcplain
\fi % @twoside 

  

% ========================= %
%       Document Layout     %
% ========================= %
%% Set margins
\setlength{\headsep}{\baselineskip}
\newlength\newtop \newtop=1in
% Top of number should be at 1 in (add height of 1 line)
\addtolength{\newtop}{\baselineskip} 
% Top header also includes headsep (distance between number and top of text
\addtolength{\newtop}{\headsep}      
% Define all margins
\if@bigmargin%
\def\margingeom{inner=1.5in,outer=1.0in,top=\newtop,bottom=1.0in,headsep=\headsep}
\else%
\def\margingeom{inner=1.0in,outer=1.0in,top=\newtop,bottom=1.0in,headsep=\headsep}
\fi%
% Set margins using geometry package (showframe for debugging)
%\RequirePackage[\margingeom,showframe]{geometry}
\RequirePackage[\margingeom]{geometry}

% Margins used for preliminary pages
\newlength\prelheadsep \prelheadsep=\headsep
\newlength\preltop     \preltop=\newtop
\addtolength{\prelheadsep}{3\baselineskip}
\addtolength{\preltop}{3\baselineskip}
\if@bigmargin%
\def\marginprel{inner=1.5in,outer=1.0in,top=\preltop,bottom=1.0in,headsep=\prelheadsep}
\else%
\def\marginprel{inner=1.0in,outer=1.0in,top=\preltop,bottom=1.0in,headsep=\prelheadsep}
\fi%

% Margins used for LOF, LOT, and LOA (extra line for headings)
\newlength\listheadsep \listheadsep=\headsep
\newlength\listtop     \listtop=\newtop
\addtolength{\listheadsep}{5\baselineskip}
\addtolength{\listtop}{5\baselineskip}
\if@bigmargin%
\def\marginlist{inner=1.5in,outer=1.0in,top=\listtop,bottom=1.0in,headsep=\listheadsep}
\else%
\def\marginlist{inner=1.0in,outer=1.0in,top=\listtop,bottom=1.0in,headsep=\listheadsep}
\fi%

% Default line spacing: use current setting from options.
\linespacing{\@thesislnsp}

%% Default indent
\setlength\parindent{5ex}

 
%% Adjust the vertical spacing between the main text and the notes,
%% and between successive notes if they are not single-spaced.
\setlength{\skip\footins}{.75\baselineskip}
% 
%% \flushbottom looks silly with lots of extra space between paragraphs
%% better to put the "extra" space at the bottom of the page!
\raggedbottom
% 
%% Default page style.
\pagestyle{tcplain}
\setfrontpagestyle{tcplain}
\setbodypagestyle{tcplain}
\setbackpagestyle{tcplain}

\if@altchapter
  \AtBeginDocument{\protect{\setcounter{secnumdepth}{4}}}
\else
  \AtBeginDocument{\protect{\setcounter{secnumdepth}{0}}}
\fi

\RequirePackage{setspace}
\renewenvironment{table}
{\setlength\abovecaptionskip{6\p@}%
  \setlength\belowcaptionskip{2\p@}%
  \@float{table}}
{\end@float}

\renewenvironment{figure}
{\setlength\abovecaptionskip{2\p@}%
  \setlength\belowcaptionskip{6\p@}%
  \@float{figure}}
{\end@float}

\renewenvironment{algorithm}
{\setlength\abovecaptionskip{2\p@}%
  \setlength\belowcaptionskip{6\p@}%
  \@float{algorithm}}
{\end@float}

% ========================= %
%       Contents Pages      %
% ========================= %
% 
%% All this junk is for handling the spacing in the TOC, LOF, and LOT.
% 
\newlength{\MT@tocentryskip@value}
\newlength{\MT@beforepartskip@value}
\newlength{\MT@beforechapskip@value}
\newlength{\MT@beforesecskip@value}
\newlength{\MT@beforesubsecskip@value}
\newlength{\MT@beforesubsubsecskip@value}
\newlength{\MT@beforeparaskip@value}
\newlength{\MT@beforesubparaskip@value}
\newlength{\MT@beforefigskip@value}
\newlength{\MT@beforetableskip@value}

\def\set@MTtocskip#1{%
  \setlength{\MT@tocentryskip@value}{#1}
  % set base lengths
  \setlength{\MT@beforepartskip@value}{2\MT@tocentryskip@value}
  \setlength{\MT@beforechapskip@value}{1.5\MT@tocentryskip@value}
  \setlength{\MT@beforesecskip@value}{0in}
  \setlength{\MT@beforesubsecskip@value}{0in}
  \setlength{\MT@beforesubsubsecskip@value}{0in}
  \setlength{\MT@beforeparaskip@value}{0in}
  \setlength{\MT@beforesubparaskip@value}{0in}
  \setlength{\MT@beforefigskip@value}{\MT@tocentryskip@value}
  \setlength{\MT@beforetableskip@value}{\MT@tocentryskip@value}
  % add glue
  \addtolength{\MT@beforepartskip@value}{\z@ \@plus\p@}
  \addtolength{\MT@beforechapskip@value}{\z@ \@plus\p@}
  \addtolength{\MT@beforesecskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforesubsecskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforesubsubsecskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforeparaskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforesubparaskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforefigskip@value}{\z@ \@plus.2\p@}
  \addtolength{\MT@beforetableskip@value}{\z@ \@plus.2\p@}
}
\set@MTtocskip{10pt}

\renewcommand{\appendix}{%
  \ifAppendmultiple % Appendices page if multiple appendices
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \quad \vspace{2.5in}\par
  \begin{center}
    \MakeUppercase{APPENDICES}
  \end{center}
  \thispagestyle{\back@pagestyle}
  \phantomsection
  \protect{\addcontentsline{toc}{chapter}{APPENDICES}}
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \fi
  \renewcommand{\@chapapp}{\MakeUppercase{\appendixname}}
  \thispagestyle{tcplain}%    Do NOT use the \back@pagestyle macro here
  \settocdepth{\appendix@tocdepth}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \def\thechapter{\@Alph\c@chapter}
  \def\chapapp@tocdepth{\expandafter\appendix@tocdepth}
  \def\chapapp@chapter{\app@chapter}
  \def\chapapp@schapter{\app@schapter}
  \renewcommand{\thesection}{\thechapter.\@arabic\c@section}
  \phantomsection%
}

% Define TOC Appendix Headings
\ifAppendmultiple
\def\app@chapter[#1]#2{%
  \ifnum \c@secnumdepth > \m@ne
  \refstepcounter{chapter}%
  \protect{\addcontentsline{toc}{section}{\texorpdfstring%
      {\MakeUppercase{\@chapapp}\space\protect\numberline{\thechapter}\hspace{-0.18in} : \space#1}%
      {APPENDIX\space\thechapter : \space#1}}% end addcontentsline
  } %end protect
  \else
  \addcontentsline{toc}{section}{\MakeUppercase{#1}}%
  \fi
  \protect{\chaptermark{#1}}%
  \if@twocolumn
  \@topnewpage[\@makeapphead{#2}]%
  \else
  \@makeapphead{#2}%
  \@afterheading
  \fi
  %\vfill \quad
  %\clearpage
}
\else % Only 1 appendix -> no indent in TOC
\def\app@chapter[#1]#2{%
  \ifnum \c@secnumdepth > \m@ne
  \refstepcounter{chapter}%
  \protect{\addcontentsline{toc}{chapter}{\texorpdfstring%
      {\MakeUppercase{\@chapapp}: \space#1}%
      {APPENDIX: \space#1}}% end addcontentsline
  } %end protect
  \else
  \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}%
  \fi
  \protect{\chaptermark{#1}}%
  \if@twocolumn
  \@topnewpage[\@makeapphead{#2}]%
  \else
  \@makeapphead{#2}%
  \@afterheading
  \fi
  %\vfill \quad
  %\clearpage
}
\fi

% Define Appendix heading pages
\ifAppendmultiple
\def\@makeapphead#1{%
  { \parindent \z@ \raggedright \normalfont
    \quad \vspace{2.5in}\par
    \begin{center}
      \underline{\MakeUppercase{\appendixname}\space \thechapter}
    \end{center}
    \par\nobreak
    \vskip 0\p@
    \interlinepenalty\@M
    \begin{doublespaced}
      \centering \MakeUppercaseWithNewline{#1}\par\nobreak
    \end{doublespaced}
    \clearpage
  }
}
\else
\def\@makeapphead#1{%
  { %\parindent \z@ \raggedright \normalfont
    \begin{doublespaced}
      \centering \MakeUppercase{\appendixname}: \MakeUppercaseWithNewline{#1}
    \end{doublespaced}
    \vskip 30\p@  %\vskip 0.3in
  }
}
\fi

\setappendixtocdepth{3}
\renewcommand\@dotsep{0.2} %%dot separation in TOC, LOT, LOF and LOA

\renewcommand*\l@chapter[2]{% this changes spacings in the TOC
  \ifnum \c@tocdepth >\m@ne
  \addpenalty{-\@highpenalty}%
  \addvspace{\MT@beforechapskip@value}%
  \setlength\@tempdima{1.5em}% was 1.5em is just right
  \begingroup
  \parindent \z@ \rightskip \@pnumwidth
  \parfillskip -\@pnumwidth
  \leavevmode 
  \advance\leftskip\@tempdima
  \hskip -\leftskip
  #1\nobreak\normalfont\normalcolor
  \leaders\hbox{$\m@th
    \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
    mu$}\hfill
  \nobreak
  % \hb@xt@\@pnumwidth{\hss #2} %this extends dots to pg#width away from pg #
  \hfil #2 %extend all way to pge # per dge desires.
  \par
  \penalty\@highpenalty
  \endgroup 
  \addvspace{\MT@beforechapskip@value}%
  \fi}

% Maximum width of a TOC/LOC/LOF entry before a linebreak occurs (actually the min cline width)
\renewcommand{\@pnumwidth}{1in} 
\renewcommand{\@tocrmarg}{1.5in}

\newcommand*{\MT@dottedtocline}[5]{%
  \ifnum #1>\c@tocdepth \else
  \addvspace{\MT@@toclineskip}
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@tempdima #3\relax
    \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
    {#4}\nobreak
    \leaders\hbox{$\m@th 
      \mkern \@dotsep mu\hbox{.} \mkern \@dotsep
      mu$}\hfill
    \nobreak
    \hfil\normalfont \normalcolor #5%
    % \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
    \par
  }%
  \fi}

% TOC spacing before (and after number if it exists)
\if@altchapter % Alt tiltes (with numbers)
  \renewcommand*\l@section{%
  \let\MT@@toclineskip=\MT@beforesecskip@value
  \MT@dottedtocline{1}{1em}{2.1em}}

  \renewcommand*\l@subsection{%
    \let\MT@@toclineskip=\MT@beforesubsecskip@value
    \MT@dottedtocline{2}{2.7em}{2.8em}}

  \renewcommand*\l@subsubsection{%
  \let\MT@@toclineskip=\MT@beforesubsubsecskip@value
  \MT@dottedtocline{3}{4.9em}{3.0em}}

\else % Standard titles (no numbers)
  \renewcommand*\l@section{%
  \let\MT@@toclineskip=\MT@beforesecskip@value
  \MT@dottedtocline{1}{1.6em}{1.8em}}

  \renewcommand*\l@subsection{%
  \let\MT@@toclineskip=\MT@beforesubsecskip@value
  \MT@dottedtocline{2}{3.8em}{2.0em}}

  \renewcommand*\l@subsubsection{%
  \let\MT@@toclineskip=\MT@beforesubsubsecskip@value
  \MT@dottedtocline{3}{6.0em}{3.0em}}
\fi

\renewcommand*\l@paragraph{%
  \let\MT@@toclineskip=\MT@beforeparaskip@value
  \MT@dottedtocline{4}{10.5em}{5em}}
\renewcommand*\l@subparagraph{%
  \let\MT@@toclineskip=\MT@beforesubparaskip@value
  \MT@dottedtocline{5}{12.5em}{6em}}

% LOF, LOT, LOA spacing before and after number
\renewcommand*\l@figure{%
  \let\MT@@toclineskip=\MT@beforefigskip@value
  \MT@dottedtocline{1}{0.5in}{2.0em}}
\let\l@table\l@figure % Same for table and algorithm
\let\l@algorithm\l@figure
\newlength{\MT@tmpa}


%\RequirePackage{geometry}
\newcommand{\do@tablespage}{%
  \iftablespage
  \if@openright\cleardoublepage\else\clearpage\fi 
  % must clear page here, so that phantomsection\addcontentsline is on the correct page
  \phantomsection%
  \pdfbookmark[0]{\lotpdfbookmarkstring}{Tables}%
  \settoheight{\MT@tmpa}{A}
  \set@MTtocskip{\MT@tmpa}
  {\newlinestretch{1}
    % Define headers
    \def\conheadmark{\listhead{List of Tables -- Continued}{Table}}
    \def\firheadmark{\listhead{List of Tables}{Table}}

    % Set pagestyle to continued
    \pagestyle{continued}

    % Setup header spacing
    \expandafter\newgeometry\expandafter{\marginlist}
    
    % Header on first page
    \thispagestyle{firstpage}

    % List of Tables
    \newlinestretch{1.0}%
    \@starttoc{lot}

    % End of list
    \clearpage
    
    % Remove header spacing & reset pagestyle
    \restoregeometry
    \pagestyle{\front@pagestyle}
  }
  \newpage
  \fi
}


\newcommand{\do@figurespage}{%
  \iffigurespage
  \if@openright\cleardoublepage\else\clearpage\fi 
  % must clear page here, so that phantomsection\addcontentsline is on the correct page
  \phantomsection%
  \pdfbookmark[0]{\lofpdfbookmarkstring}{Figures}%
  \settoheight{\MT@tmpa}{A}
  \set@MTtocskip{\MT@tmpa}
  {\newlinestretch{1}
    % Define headers
    \def\conheadmark{\listhead{List of Figures -- Continued}{Figure}}
    \def\firheadmark{\listhead{List of Figures}{Figure}}

    % Set pagestyle to continued
    \pagestyle{continued}

    % Setup header spacing
    \expandafter\newgeometry\expandafter{\marginlist}
    
    % Header on first page
    \thispagestyle{firstpage}

    % List of Figures
    \newlinestretch{1.0}%
    \@starttoc{lof}

    % End of list
    \clearpage
    
    % Remove header spacing & reset pagestyle
    \restoregeometry
    \pagestyle{\front@pagestyle}

  }
  \newpage
  \fi
}

\newcommand{\do@algorithmspage}{%
  \ifalgorithmspage
  \if@openright\cleardoublepage\else\clearpage\fi 

  % must clear page here, so that phantomsection\addcontentsline is on the correct page
  \phantomsection%
  \pdfbookmark[0]{\loapdfbookmarkstring}{Algorithms}%
  \settoheight{\MT@tmpa}{A}
  \set@MTtocskip{\MT@tmpa}
 % {\newlinestretch{1}
    % Define headers
    \def\conheadmark{\listhead{List of Algorithms -- Continued}{Algorithm}}
    \def\firheadmark{\listhead{List of Algorithms}{Algorithm}}

    % Set pagestyle to continued
    \pagestyle{continued}

    % Setup header spacing
    \expandafter\newgeometry\expandafter{\marginlist}
    
    % Header on first page
    \thispagestyle{firstpage}

    % List of Algorithms
    \newlinestretch{1.0}%
    \@starttoc{loa}

    % End of list
    \clearpage
    
    % Remove header spacing & reset pagestyle
    \restoregeometry
    \pagestyle{\front@pagestyle}

  %}
  \newpage
  \fi
}

\newcommand{\do@contentspage}{%
  \ifcontentspage
  \if@openright\cleardoublepage\else\clearpage\fi 
  % must clear page here, so that phantomsection\addcontentsline is on the correct page
  \phantomsection%
  \pdfbookmark[0]{\tocpdfbookmarkstring}{toc}%
  \settoheight{\MT@tmpa}{A}
  \set@MTtocskip{\MT@tmpa}
  {\newlinestretch{1}
    % Define headers
    \def\firheadmark{\tochead{Table of Contents}}
    \def\conheadmark{\tochead{Table of Contents -- Continued}}

    % Set pagestyle to continued
    \pagestyle{continued}

    % Setup header spacing
    \expandafter\newgeometry\expandafter{\marginprel}
    
    % Header on first page
    \newlinestretch{1.0}%
    \thispagestyle{firstpage}

    % Table of Contents
    \@starttoc{toc}

    % End of list
    \clearpage
    
    % Remove header spacing & reset pagestyle
    \restoregeometry
    \pagestyle{\front@pagestyle}
  }
  \newpage
  \fi
}

% Preamble headings
\newcommand\tochead[1]{%
  \normalfont\centering\uppercase{#1}%
}%

% LOT, LOF, LOA
\newcommand\listhead[2]{%
  \normalfont\centering\uppercase{#1}\\[0.5\baselineskip]%
  #2\hfill Page
}%


% First page - pagestyle
\def\ps@firstpage{%
  \def\@oddhead{
    \parbox[t]{0.99\linewidth}{%
      \begin{doublespaced}%
        \hfil\thepage\hfil\\%
        \firheadmark%
      \end{doublespaced}%
    }%
  }
  \let\@evenhead\@oddhead
}%

% Continued pages - pagestyle
\def\ps@continued{%
  \def\@oddhead{
    \parbox[t]{0.99\linewidth}{%
      \begin{doublespaced}%
        \hfil\thepage\hfil\\%
        \conheadmark%
      \end{doublespaced}%
    }%
  }
  \let\@evenhead\@oddhead
}%

% Call \contents to get all the lists and tables done. 
\newcommand{\contents}{%
  \typeout{***************** Contents ******************}
  \newpage
  % Set contents title spacing
  \newlinestretch{\@spacing}
  \setlotdepth
  \setlofdepth  %these tell listof table and figures to print output despite what appears in TOC.
  % Make contents pages
  \do@contentspage
  \do@tablespage
  \do@figurespage
  \do@algorithmspage
}



%%%% for numbering figures and tables in sequential order not beginning again at the start of each chapter.
\def\thefigure{\thechapter.\@arabic\c@figure}
\def\thetable{\thechapter.\@arabic\c@table}
\def\theequation{\thechapter.\arabic{equation}}
\def\thealgorithm{\thechapter.\arabic{algorithm}}

%% Redefine the macro used for floats (including figures and tables)
%% so that single spacing is used.
%% (Note \def\figure{\@float{figure}set single spacing} doesn't work
%% because figure has an optional argument)
%% 
%% This code was copied directly from latex.ltx, but with the
%% \newlinespacing{} macro added to it.
% 
\def\@xfloat #1[#2]{%
  \@nodocument
  \def \@captype {#1}%
  \def \@fps {#2}%
  \@onelevel@sanitize \@fps
  \def \reserved@b {!}%
  \ifx \reserved@b \@fps
  \@fpsadddefault
  \else
  \ifx \@fps \@empty
  \@fpsadddefault
  \fi
  \fi
  \ifhmode
  \@bsphack
  \@floatpenalty -\@Mii
  \else
  \@floatpenalty-\@Miii
  \fi
  \ifinner
  \@parmoderr\@floatpenalty\z@
  \else
  \@next\@currbox\@freelist
  {%
    \@tempcnta \sixt@@n
    \expandafter \@tfor \expandafter \reserved@a
    \expandafter :\expandafter =\@fps
    \do
    {%
      \if \reserved@a h%
      \ifodd \@tempcnta
      \else
      \advance \@tempcnta \@ne
      \fi
      \fi
      \if \reserved@a t%
      \@setfpsbit \tw@
      \fi
      \if \reserved@a b%
      \@setfpsbit 4%
      \fi
      \if \reserved@a p%
      \@setfpsbit 8%
      \fi
      \if \reserved@a !%
      \ifnum \@tempcnta>15
      \advance\@tempcnta -\sixt@@n\relax
      \fi
      \fi
    }%
    \@tempcntb \csname ftype@\@captype \endcsname
    \multiply \@tempcntb \@xxxii
    \advance \@tempcnta \@tempcntb
    \global \count\@currbox \@tempcnta
  }%
  \@fltovf
  \fi
  \global \setbox\@currbox
  \color@vbox
  \normalcolor
  \vbox \bgroup
  \vspace{16pt}			%Space above figures
  % \newlinestretch{1.0}
  \hsize\columnwidth
  \@parboxrestore
  \@floatboxreset
}


%% RW Triple space under figure captions
% \addtolength{\belowcaptionskip}{14pt}


% Do standard figure captions.
% 
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
  #1: #2\par
  \else
  \global \@minipagefalse
  \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}



% 
%% Chapter headings - centered, all caps, chapter number - roman numeral
% 
% 
\def\chapapp@tocdepth{\expandafter\chapter@tocdepth}
% 
%% The following two def's provide the Indirection needed to work 
%% with hyperref package, since hyperref redefines @chapter and
%% @schapter
% 
\def\chapapp@chapter{\chap@chapter}
\def\chapapp@schapter{\chap@schapter}




% 
%% Make @chapter and @schapter wrappers for (chap@chapter or app@chapter)
%% and (chap@schapter or app@schapter).  This indirection is necessary to
%% work well with the hyperref package.
% 
\def\my@empty{}
\def\@chapter[#1]#2{%
  \def\my@temp{#1}%
  \ifx\my@temp\my@empty
  \chapapp@chapter{#2}
  \else
  \chapapp@chapter[#1]{#2}
  \fi
}
\def\@schapter#1{%
  \chapapp@schapter{#1}
}
% 
%% The actual guts of the chapter heading routines

\renewcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \if@tcpage% DO NOT use the \front@pagestyle macro here.
  {\thispagestyle{tcplain}}
  \else
  {\thispagestyle{plain}} %
  \fi 
  \settocdepth{\chapapp@tocdepth}
  \global\@topnum\z@
  \@afterindenttrue
  \secdef\@chapter\@schapter
}

%% TOC chapter headings
\def\chap@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
  \refstepcounter{chapter}%
  \typeout{***************** \space\@chapapp\space\thechapter.\space\texorpdfstring{#1}\space\space\space *****************}%
  \addcontentsline{toc}{chapter}%
  {\texorpdfstring%
    {\protect\numberline{\thechapter.}\MakeUppercase{#1}}%  period after the chapter number before the chapter name
    {Chapter \thechapter\space\textemdash\space#1}}%
  \else
  \addcontentsline{toc}{chapter}%
  {\texorpdfstring{\MakeUppercase{#1}}{#1}}%
  \fi
  \protect{\chaptermark{#1}}%
  \if@twocolumn
  \@topnewpage[\@makechapterhead{#2}]%
  \else
  \@makechapterhead{#2}%
  \@afterheading
  \fi
}

\def\@makechapterhead#1{%
  { \parindent \z@ \raggedright \normalfont
    \interlinepenalty\@M
    \centering  \MakeUppercase{#1}\par\nobreak
    % \vskip 20\p@
    \vskip 18\p@
  }
}

\def\chap@schapter#1{%
  \if@twocolumn
  \@topnewpage[\@makeschapterhead{#1}]%
  \else
  \@makeschapterhead{#1}%
  \@afterheading
  \fi
}

\def\@makeschapterhead#1{%
  { \parindent \z@ \raggedright \normalfont
    \interlinepenalty\@M
    \centering  #1\par\nobreak
    \vskip 10\p@
  }
}

% ================================= %
% Section titles format and spacing %
% ================================= %
\RequirePackage{titlesec}
\RequirePackage[normalem]{ulem}
\RequirePackage{fmtcount}
% \titlespacing{<command>}{left}{before-sep}{after-sep}
% \titleformat{command}[shape]{format}{label}{sep}{before}[after]

\if@altchapter % Alternative titles
  \typeout{Using Alternative Titles}

  \titlespacing{\chapter}{0pt}{-24pt}{*3}
  \titlespacing{\section}{0pt}{*3}{*3}
  \titlespacing{\subsection}{0pt}{*3}{0pt}
  \titlespacing{\subsubsection}{0pt}{*3}{1ex}
  \titleformat{\chapter}[display]{\centering}{CHAPTER \NUMBERstringnum{\thechapter}}{3.5ex}{\uppercase}
  \titleformat{\section}[hang]{\centering}{\uline{\thesection\hspace*{0.5em}}}{0em}{\uline}
  \titleformat{\subsection}[hang]{}{\uline{\thesubsection\hspace*{0.5em}}}{0em}{\uline}
  \titleformat{\subsubsection}[runin]{}{\indent{\uline{\thesubsubsection\hspace*{0.5em}}}}{0em}{\uline}

  % Long subsection title command
  \newcommand{\longsubsection}[3][]{%
    \addtocounter{subsection}{1}%
    \ifthenelse{\equal{#1}{}}%
      {\addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}#2\\ #3}}
      {\addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}#1}}
    \begin{singlespace}
      ~\\
      \noindent\thesubsection\hspace*{0.5em}#2\\\uline{#3}\par%
    \end{singlespace}
  }%

  % Long subsubsection title command
  \newcommand{\longsubsubsection}[3][]{%
    \addtocounter{subsubsection}{1}%
    \ifthenelse{\equal{#1}{}}%
      {\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesubsubsection}#2\\ #3}}
      {\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesubsubsection}#1}}
      ~\\
    \begin{singlespace}
      \noindent\thesubsubsection\hspace*{0.5em}#2\\\uline{#3}\par%
    \end{singlespace}
  }%

\else % Standard titles

  \titlespacing*{\chapter}{0pt}{-24pt}{*3}
  \titlespacing{\section}{0pt}{*3}{*3}
  \titlespacing{\subsection}{0pt}{*3}{0pt}
  \titlespacing{\subsubsection}{0pt}{*3}{1ex}
  \titleformat{\chapter}{\centering\uppercase}{}{0pt}{}
  \titleformat{\section}[hang]{\centering}{}{0em}{\uline}
  \titleformat{\subsection}[hang]{}{}{0em}{\uline}[]
  \titleformat{\subsubsection}[runin]{}{}{0em}{\indent\uline}

  % Long subsection title command
  \newcommand{\longsubsection}[3][]{%
    \addtocounter{subsection}{1}%
    \ifthenelse{\equal{#1}{}}%
      {\addcontentsline{toc}{subsection}{#2\\ #3}}
      {\addcontentsline{toc}{subsection}{#1}} 
    \begin{singlespace}
      ~\\
      \noindent#2\\\uline{#3}\par%
    \end{singlespace}
  }%

  % Long subsubsection title command
  \newcommand{\longsubsubsection}[3][]{%
    \addtocounter{subsubsection}{1}%
    \ifthenelse{\equal{#1}{}}%
     {\addcontentsline{toc}{subsubsection}{#2\\ #3}}
     {\addcontentsline{toc}{subsubsection}{#1}} 
    \begin{singlespace}
      ~\\
      \noindent#2\\\uline{#3}\par%
    \end{singlespace}
  }%
\fi

% Indent after titles
\RequirePackage{indentfirst}

%% formatting of items before main body of text
\newenvironment{preliminary}%
{  
  \newlinestretch{1.0}%
  %\pagenumbering{alph}%
  \pagenumbering{roman} 
  \pagestyle{\front@pagestyle}%
  \iftitlepage%
  \maketitle%
  \fi%

  \makecopyright

  \ifsignaturepage%
  \makesignature%
  \fi%

  % \makepermission

  \newlinestretch{\@spacing}%
}%
{%
  \if@draft%
  \else%
  \if@twoside%
  \if@openright%
  \cleardoublepage%
  \fi%
  \fi%
  \fi%
  \newpage%
  \pagenumbering{arabic}%
  \pagestyle{\body@pagestyle}%
  \newlinestretch{\@spacing}%
}%


\renewcommand{\maketitle}{%
  \normalfont
  % \pagenumbering{alph} %change numbering to alph from roman so that duplicate page# not created
  \begingroup
  \newlinestretch{1}%
  \begin{titlepage}%
    \phantomsection%
    \pdfbookmark[0]{Titlepage}{title}%
    % Make titlepage with boxes
    \begin{center}
      % Title
      \mbox{\parbox[t][8em][b]{\textwidth}{%
          \begin{doublespaced}
            \centering 
            \MakeUppercaseWithNewline\@title 
          \end{doublespaced} }
      }\\
      \vspace{2em}
      % Author
      \mbox{\parbox[t][4em][t]{\textwidth}{%
          \begin{doublespaced}
            \centering 
            by \\ 
            \@author 
          \end{doublespaced} }
      }\\
      \vspace{6em}
      % Degree
      \mbox{\parbox[t][16em][c]{\textwidth}{%
          \begin{singlespaced}
            \centering 
            A {\degreetype} submitted in partial fulfillment \\
            of the requirements for the degree \\
            \quad \\ 
            \quad \\ 
            of \\
            \quad \\ 
            {\degree}\\
            \quad \\ 
            in \\ 
            \quad \\
            {\@degreetitle}
          \end{singlespaced} }
      }\\
      \vspace{0em}
      % University
      \mbox{\parbox[t][8em][b]{\textwidth}{%
          \begin{singlespaced}
            \centering
            MONTANA STATE UNIVERSITY \\
            Bozeman, Montana \\ \vspace*{.3in}
            {\@submitdate}%
          \end{singlespaced} }
      }\\
    \end{center}
  \end{titlepage}% this has a \newpage
  \endgroup%
}%maketitle

\newcommand{\MakeUppercaseWithNewline}[1]{%
  \begingroup
    \let\SavedOrgNewline\\%
    \DeclareRobustCommand{\\}{\SavedOrgNewline}%
    \MakeUppercase{#1}%
  \endgroup
}

% Make an MSU approved copyright page
\usepackage{emptypage} % Avoid page numbers on empty pages
\newcommand{\makecopyright}{%
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Copyright}{copyright}%
  % Make copyright with boxes (matches spacing on title page)
    \begin{center}
      % Title
      \mbox{\parbox[t][10em][b]{\textwidth}{%  10em = 8em (title) + 2em (space) used above
          \begin{doublespaced}
            \centering 
            \copyright COPYRIGHT 
          \end{doublespaced} }
      }\\
      % Author
      \mbox{\parbox[t][4em][t]{\textwidth}{%
          \begin{doublespaced}
            \centering 
            by \\ 
            \@author \\
            {\@copyrightyear} \\
            \ifCopyrightcc
            \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons Attribution 4.0 International License} \ccby
            \else
            All Rights Reserved
            \fi
          \end{doublespaced} }
      }\\
    \end{center}
    \thispagestyle{empty} % No number on copyright page
    \clearpage
    % Set numbering so next page is ii for ETD 
    \if@twoside {} \else \setcounter{page}{2} \fi
  }

\newcommand{\makesignature}{%
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Approval}{approval}%
  \begin{center}
    APPROVAL \\ \quad \\
    of a {\degreetype} submitted by \\ \quad \\ 
    {\@author}\\ 
  \end{center}

  \vspace*{.5in}

  \begin{singlespaced}
    This {\degreetype} has been read by each member of the {\degreetype} committee
    and has been found to be satisfactory regarding content, English
    usage, format, citations, bibliographic style, and consistency,
    and is ready for submission to The Graduate School.
  \end{singlespaced}
  
  \vspace*{.75in}
  \begin{center}
    {\@committeechair}
  \end{center}
  \vspace*{.3in}

  \begin{center}
    Approved for the Department of {\@department}
  \end{center}

  \begin{center}
    {\@departmentchair}
  \end{center}

  \vspace*{.3in}


  \begin{center}
    Approved for The Graduate School
  \end{center}
  
  \begin{center}
    {\@graduatedean}
  \end{center}

  % \vfill \quad %to center on page
  \thispagestyle{tcplain} 
}


\newcommand{\makepermission}{ %
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Permission}{permission}%
  \begin{center}
    STATEMENT OF PERMISSION TO USE \\ \quad 
  \end{center}
  \begin{doublespaced}
    % {\perm}  \\ $~$
    {\perm}  \\ $~$									%My fix for a bad box
  \end{doublespaced}
  % \vspace*{1.2in}
  % {\@author} \\ \\ \quad 
  {\@author} \\ $~$  \\ \quad      %My fix for another bad box
  {\@submitdate}
  \thispagestyle{tcplain} 
}




%% dedication formatting
\newenvironment{dedication}{%
  \typeout{*****************    Dedication    ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Dedication}{dedication}
  % Define headers
  \def\firheadmark{\tochead{Dedication}}
  \def\conheadmark{\tochead{Dedication -- Continued}}

  % Set pagestyle to continued
  \pagestyle{continued}

  % Setup header spacing
  \expandafter\newgeometry\expandafter{\marginprel}
  
  % Header on first page
  \thispagestyle{firstpage}

  \begingroup
  \begin{singlespaced}
}{
  \par
  \end{singlespaced}
  \endgroup 
  % End of Dedication
  \clearpage
  
  % Remove header spacing & reset pagestyle
  \restoregeometry
  \pagestyle{\front@pagestyle}
}% end dedication


% 
%% \begin{acknowledgements}...\end{acknowledgements} formats an
%% acknowledgements section
\newenvironment{acknowledgements}{%
  \typeout{***************** Acknowledgements ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Acknowledgements}{acknowledgements}

  % Define headers
  \def\firheadmark{\tochead{Acknowledgements}}
  \def\conheadmark{\tochead{Acknowledgements -- Continued}}

  % Set pagestyle to continued
  \pagestyle{continued}

  % Setup header spacing
  \expandafter\newgeometry\expandafter{\marginprel}
  
  % Header on first page
  \thispagestyle{firstpage}

  \begingroup
  \begin{doublespaced}
}{
  \par
  \end{doublespaced}
  \endgroup 
  % End of Acknowlegements
  \clearpage
  
  % Remove header spacing & reset pagestyle
  \restoregeometry
  \pagestyle{\front@pagestyle}
}% end acknowledgements


%% \begin{vita}...\end{vita} formats a
%% vita section
\newenvironment{vita}{%
  \typeout{*****************        Vita       ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Cirriculum Vitae}{vita}
  % Define headers
  \def\firheadmark{\tochead{Vita}}
  \def\conheadmark{\tochead{Vita -- Continued}}

  % Set pagestyle to continued
  \pagestyle{continued}

  % Setup header spacing
  \expandafter\newgeometry\expandafter{\marginprel}
  
  % Header on first page
  \thispagestyle{firstpage}

  \begingroup
  \begin{singlespaced}
}{
  \par
  \end{singlespaced}
  \endgroup 
  % End of Vita
  \clearpage
  
  % Remove header spacing & reset pagestyle
  \restoregeometry
  \pagestyle{\front@pagestyle}
} % end Vita

%% \begin{nomenclature}...\end{nomenclature} formats a
%% nomenclature section
\newenvironment{nomen}{%
  \typeout{*****************        Nomenclature       ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[1]{Nomenclature}{nomenclature}
  % Define headers
  \def\firheadmark{\tochead{Nomenclature}}
  \def\conheadmark{\tochead{Nomenclature -- Continued}}

  % Set pagestyle to continued
  \pagestyle{continued}

  % Setup header spacing
  \expandafter\newgeometry\expandafter{\marginprel}
  
  % Header on first page
  \thispagestyle{firstpage}

  \begingroup
  \begin{singlespaced}
}{
  \par
  \end{singlespaced}
  \endgroup 
  % End of Vita
  \clearpage
  
  % Remove header spacing & reset pagestyle
  \restoregeometry
  \pagestyle{\front@pagestyle}
} % end Vita


%% Change \begin{abstract}...\end{abstract} to follow guidelines
%% and put the abstract on a separate page (checking @openright).
\renewenvironment{abstract}{%
  \typeout{*****************      Abstract     ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \phantomsection%
  \pdfbookmark[0]{Abstract}{abstract}
  % Define headers
  \def\firheadmark{\tochead{Abstract}}
  \def\conheadmark{\tochead{Abstract -- Continued}}

  % Set pagestyle to continued
  \pagestyle{continued}

  % Setup header spacing
  \expandafter\newgeometry\expandafter{\marginprel}
  
  % Header on first page
  \thispagestyle{firstpage}

  \begingroup
  \begin{singlespaced}
}{
  \par
  \end{singlespaced}
  \endgroup 
  % End of Dedication
  \clearpage
  
  % Remove header spacing & reset pagestyle
  \restoregeometry
  \pagestyle{\front@pagestyle}
}%abstract


%% formatting for stuff after the main body of text
\newenvironment{postliminary}%
{\pagestyle{\back@pagestyle}}%
{\settocdepth{\chapter@tocdepth}%
  \pagestyle{\body@pagestyle}}


%% setup reference page title and TOC entry
\newcommand{\refname}{References Cited}
\newcommand{\references}{%
  \ifbibpage
  \typeout{*****************     \refname    ******************}
  \newlinestretch{1.0}
  \if@openright\cleardoublepage\else\clearpage\fi 
  % must clear page here, so that phantomsection\addcontentsline is on the correct page
  \phantomsection
  \addcontentsline{toc}{chapter}%
  {\texorpdfstring{\MakeUppercase{\refname}}{\refname}}
  % \bibliography{\@bibfiles}

  \ifAppend
  \ifAppendmultiple
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \quad \vspace{2.5in}\par
  \begin{center}
    
    \MakeUppercase{\refname}
  \end{center}
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \else %there is only one appendix so put \refname on same page
  
  \begin{center}
    \MakeUppercase{\refname}
  \end{center}
  \vskip 30\p@  %\vskip 0.3in
  \fi %end ifAppendmultiple
  \else  %there is no appendix so put \refname on same page
  
  \begin{center}
    \MakeUppercase{\refname}
  \end{center}
  \vskip 30\p@  %\vskip 0.3in
  \fi %end ifAppend

  % Remove title from bibliography
  \renewcommand{\bibsection}{}
  
  \fi %end if bibpage
}


% Force float only pages to align at the top of the page
\makeatletter
\setlength{\@fptop}{0pt}
\setlength{\@fpbot}{0pt plus 1fil}
\makeatother


