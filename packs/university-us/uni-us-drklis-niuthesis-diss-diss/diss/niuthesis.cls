% niuthesis.cls --- LaTeX class for NIU theses

% Copyright (C) 2007, 2008, 2010, 2015 Roland Winkler <rwinkler@niu.edu>
%
% This LaTeX class file is free software: you can redistribute it
% and/or modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation, either version 3 of
% the License, or (at your option) any later version.
% 
% niuthesis.cls is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% The GNU General Public License is available at
% <http://www.gnu.org/licenses/>.

% niuthesis.cls uses packages 
%  - geometry (general page layout)
%  - setspace (doublespace)
%  - titlesec (layout of section headers)
%  - titletoc (layout of table of contents)
%  - tocbibind (create entries in the toc for lof, lot, loa, and references)
%  - calc (for calculating dimensions)
%  - ulem (underlining)

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{niuthesis}[2015/03/26]

% options handled by report.cls
\DeclareOption{10pt} {\PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt} {\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt} {\PassOptionsToClass{12pt}{report}}
\DeclareOption{oneside} {\PassOptionsToClass{oneside}{report}}
\DeclareOption{twoside} {\PassOptionsToClass{twoside}{report}}
\DeclareOption{draft} {\PassOptionsToClass{draft}{report}}
\DeclareOption{final} {\PassOptionsToClass{final}{report}}
\DeclareOption{openright} {\PassOptionsToClass{openright}{report}}
\DeclareOption{openany} {\PassOptionsToClass{openany}{report}}
\DeclareOption{leqno} {\PassOptionsToClass{leqno}{report}}
\DeclareOption{fleqn} {\PassOptionsToClass{fleqn}{report}}
\DeclareOption{openbib} {\PassOptionsToClass{openbib}{report}}

% line spacing handled by setspace

\newif\if@doublespacing \@doublespacingtrue % default
\DeclareOption{singlespacing} {\@doublespacingfalse
                               \PassOptionsToPackage{singlespacing}{setspace}}
\DeclareOption{onehalfspacing}{\@doublespacingfalse
                               \PassOptionsToPackage{onehalfspacing}{setspace}}
\DeclareOption{doublespacing} {\@doublespacingtrue
                               \PassOptionsToPackage{doublespacing}{setspace}}

\newif\if@normalem \@normalemtrue % default
\DeclareOption{ULforem} {\@normalemfalse
                         \PassOptionsToPackage{ULforem}{ulem}}
\DeclareOption{UWforbf} {\PassOptionsToPackage{UWforbf}{ulem}}

% relevant only with option openright:
% if a chapter ends with an odd page number, suppress header with page number
% on the following empty even page
\DeclareOption{emptyblank}{\def\cleardoublepage{%
  \clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \vspace*{\fill}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the report class with certain options by default.
% It will process any other options specified.
\ProcessOptions
\LoadClass[letterpaper,onecolumn]{report}[1996/10/31]

%%%%%%%% DEFINE UNDERLINING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use ulem for section headers (but this package can do more if desired)
\if@normalem
  \RequirePackage[normalem]{ulem} % our default
\else
  \RequirePackage[ULforem]{ulem}  % ulem's default
\fi

%%%%%%% DEFINE DOUBLE-SPACING (THE DEFAULT) AND OTHER SPACING:
% setspace defines commands \singlespacing, \onehalfspacing, \doublespacing
% and environments singlespace, onehalfspace, doublespace.
% The spacing environment takes one argument which is the larger
% baselinestretch to use, e.g., \begin{spacing}{2.5}.
% Figure and table captions aer set single space.
\if@doublespacing
  \RequirePackage[doublespacing]{setspace} % our default
\else
  \RequirePackage[singlespacing]{setspace} % setspace's default
\fi

%%%%% SET THE OVERALL DOCUMENT PROPERTIES, such as page numbering,
% textwidth = 8.5in - 1.0in - 1.0in = 6.5in
\RequirePackage[letterpaper, lmargin=1.0in, rmargin=1.0in, tmargin=1.0in,%
                bmargin=1.0in, ignorefoot, includehead, dvips %, showframe
                ]{geometry}
\RequirePackage{calc}

% These flags control whether we generate a list of figures (lof)
% and a list of tables (lot).
\newif\ifth@lof \th@loffalse
\newif\ifth@lot \th@lotfalse

\AtBeginDocument{
  \@ifundefined{th@loacount}{\gdef\th@loacount{0}}{}
  %
  \let\th@figure\figure
  \def\figure{%
    \ifth@lof\else
      \global\th@loftrue
      \immediate\write\@mainaux{\string\gdef\string\th@lofflag{}}
    \fi
    \th@figure}
  %
  \let\th@table\table
  \def\table{%
    \ifth@lot\else
      \global\th@lottrue
      \immediate\write\@mainaux{\string\gdef\string\th@lotflag{}}
    \fi
    \th@table}
  % hyperref compatibility
  \@ifpackageloaded{hyperref}{%
    \let\thMakeUppercase\relax
    \def\tocpdfbookmark{%
      \if@openright
       \cleardoublepage
      \else
       \clearpage
      \fi
      \pdfbookmark[0]{Table of Contents}{foo bar baz}}}
   {\let\thMakeUppercase\MakeUppercase
    \let\tocpdfbookmark\relax}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use titlesec for formatting all the headlines

\RequirePackage[newlinetospace]{titlesec}
\titleformat{\chapter}[display] % top level 1
 {\thispagestyle{empty}%
  \filcenter\large\bfseries}%
 {\MakeUppercase{\@chapapp}\ \thechapter}{0pt}{\MakeUppercase}
\titleformat{\section} % level 2
 {\filcenter\large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection} % level 3
 {\filcenter\large\bfseries}{\thesubsection}{1em}{\uline}
\titleformat{\subsubsection}[hang] % level 4
 {\bfseries}{\thesubsubsection}{1em}{\uline}
\titleformat{\paragraph}[runin] % level 5
 {\bfseries}{\theparagraph}{1em}{\uline}[.]
\titleformat{\subparagraph}[runin] % level 6
 {\bfseries}{\thesubparagraph}{1em}{}[.]

\titlespacing{\chapter}{0pt}{1in-\headsep-\headheight
 -1.15\baselineskip}{*5} % top level 1
\titlespacing{\section}{0pt}{*5}{*5} % level 2
\titlespacing{\subsection}{0pt}{*5}{*5} % level 3
\titlespacing{\subsubsection}{0pt}{*5}{*5} % level 4
\titlespacing{\paragraph}{\parindent}{*2}{*1} % level 5
\titlespacing{\subparagraph}{\parindent}{*2}{*1} % level 6

% Use titletoc for formatting the table of contents, the lists of
% tables, figures, and appendices
\RequirePackage{titletoc}

\contentsmargin[0.6pc]{2.5em} % set right margin
\titlecontents
  {chapter} [1.5em] {}                  % {<section>} [left] {<above>}
  {\contentslabel{1.5em}\thMakeUppercase} % {<before with lablel>}
  {\hspace*{-1.5em}\thMakeUppercase}      % {<before without label>}
  {\titlerule*[0.6pc]{.}\contentspage}  % {<filler and page>}
% \dottedcontents{section}[<left>]{<above>}{<label width>}{<leader width>}
% The difference (<left> - <label width>) is <left> for the next-upper level
\dottedcontents{section}[3.8em]{}{2.3em}{0.6pc}
\dottedcontents{subsection}[7.0em]{}{3.2em}{0.6pc}
\dottedcontents{subsubsection}[11.1em]{}{4.1em}{0.6pc}
\dottedcontents{figure}[3.8em]{}{2.3em}{0.6pc}
\dottedcontents{table}[3.8em]{}{2.3em}{0.6pc}

\contentsuse{chapter}{loa} % needed by titletoc

% Use tocbibind to create entries in the toc for lof, lot, loa, and references.
% Suppress entry `toc' in toc.
\RequirePackage[nottoc]{tocbibind}
% \tocfile is command in tocbibind for new listings
\newcommand{\listofappend}{\tocfile{List of Appendices}{loa}}

% extend the definition of \appendix in report.cls
\def\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
  %
  \newpage
  % Only if there are several appendices, we make here
  % a generic entry "Appendices" in toc. Otherwise, we let
  % the redefined chapter command do this, so that it inserts
  % also the title.
  \ifnum\th@loacount>1
   \addcontentsline{toc}{chapter}{Appendices}%
  \fi
  %
  % header for appendices are vertically centered
  \ifnum\th@loacount>1%
    \titleformat{\chapter}[display]%
      {\vspace*{\fill}\thispagestyle{empty}%
       \singlespacing\filcenter\large\bfseries}%
      {\MakeUppercase{\@chapapp}\ \thechapter}{1em}{\MakeUppercase}%
      [\vspace*{\fill}\vspace*{8ex}\newpage]%
  \else
    \titleformat{\chapter}[display]%
      {\vspace*{\fill}\thispagestyle{empty}%
       \singlespacing\filcenter\large\bfseries}%
      {\MakeUppercase{\@chapapp}}{1em}{\MakeUppercase}%
      [\vspace*{\fill}\vspace*{8ex}\newpage]%
  \fi
  \titlespacing*{\chapter}{0pt}{*0}{*0}%
  %
  % If we have more than one appendix, they do not appear in the regular
  % table of contents, but in a separate list of appendices. So we
  % redefine \@chapter such that it writes into file loa instead of toc.
  % Code adapted from report.cls
  \def\@chapter[##1]##2{%
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \ifnum\th@loacount>1%
      \addcontentsline{loa}{chapter}%
                      {\protect\numberline{\thechapter}##1}%
    \else
      \addcontentsline{toc}{chapter}{Appendix: ##1}
    \fi
    \chaptermark{##1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    % Generate list of appendices only if we have at least two appendices.
    % Use \th@loacount for that.
    \immediate\write\@mainaux{\string\gdef\string\th@loacount{\arabic{chapter}}}%
    \@makechapterhead{##2}%
    \@afterheading}%
  %
  % adapted from titlesec.sty
  \def\ttl@addcontentsline##1##2{\ifnum\th@loacount>1%
   \addcontentsline{loa}{##1}{\ifttl@toclabel\ttl@a\fi##2}\fi}}

%%%%%%%%%%% ADDITIONAL FORMATTING STUFF:
\pagenumbering{arabic}
\pagestyle{myheadings} % no page headings
\onecolumn
\raggedbottom

% Suppress widows and orphans
\clubpenalty = 10000 
\widowpenalty = 10000 
\displaywidowpenalty = 10000 

\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3} % no numbering of subsubsections

% Set up some titles on the table of contents page.
\renewcommand*{\contentsname}{Table of Contents}
\renewcommand*{\bibname}{References}
\newcommand*{\listofappendname}{List of Appendices}

%%%%%%%%%% COMMANDS CHANGED FOR THIS CLASS
% Unavailable commands
\renewcommand*{\theindex}{\ClassWarning{niuthesis}
  {Indexing not available in this class.}}
\renewcommand*{\twocolumn}{\ClassWarning{niuthesis}
  {Twocolumn not available in this class.}}
\renewcommand*{\thepart}{\ClassWarning{niuthesis}
  {``thepart'' not available in this class.}}
\renewcommand*{\part}{\ClassWarning{niuthesis}
  {``part'' not available in this class.}}

%%%%%%%%%%% THESIS PROLOGUE PAGES:
% Default values of storage variables.  Emits an error message.
\newcommand*{\th@university}{Northern Illinois University}
\newcommand*{\th@address}{De Kalb, Illinois}
\newcommand*{\th@degreemonth}{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi}
\newcommand*{\th@degreeyear}{\number\year}

\newcommand*{\th@title}{
  \ClassError{niuthesis}{
    You must specify a thesis title!}
  {Use the \protect\title{} command in the preamble.}}

\newcommand*{\th@author}{
  \ClassError{niuthesis}{
    You must specify your name!}
  {Use the \protect\author{}{} command in the \MessageBreak
    preamble. The first arg is your first name and \MessageBreak
    middle initial.  The second arg is your last name.}}

\newcommand*{\th@department}{
  \ClassError{niuthesis}{
    You must specify the name of the department \MessageBreak
    granting your degree.}
  {Use the \protect\department{} command in the \MessageBreak
    preamble.}}

\newcommand*{\th@degree}{
  \ClassError{niuthesis}{
    You must specify the type of degree you are receiving.}
  {Use the \protect\degree{}{}{}{} command in the preamble.\MessageBreak  
   The first arg is the thesis type, e.g., dissertation.\MessageBreak
   The second arg is the abbreviated degree, e.g., Ph.D.,\MessageBreak
   The third arg is the unabbreviated degree,\MessageBreak
   e.g. 'Doctor of Philosophy'.}}
\let\th@degree\th@abbrevdegree
\let\th@degree\th@thesis

\newcommand*{\th@major}{
  \ClassError{niuthesis}{
    You must specify the major.}
  {Use the \protect\major{} command in the preamble.\MessageBreak
   The arg is the unabbreviated major.}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The base commands that make all of the prologue pages.

\newcommand{\th@Abstractpage}{%
  {\setlength{\hsize}{\linewidth}
   % no head line for abstract
   \addtolength{\textheight}{\headheight + \headsep}
   \setlength{\headheight}{0pt}
   \setlength{\headsep}{0pt}
   \pagestyle{empty}%
   \begin{singlespace}
     % \vspace is strange:
     % On this page, we want the top margin to be 1.5in.
     % But we only add 0.25in to the default 1.0in to get exactly
     % what we want.
     \vspace*{0.25in}
     \centerline{\bfseries ABSTRACT}
     \vspace*{0.5in}
     {\bfseries\begin{center}
        \uppercase\expandafter{\th@title}
      \end{center}}
     \vspace{1ex}
     \begin{center}
       \th@author, \th@abbrevdegree\\
       \th@department\\
       \th@university, \th@degreeyear\\
       \th@director, Director
     \end{center}
     \vspace*{0.5in}
     \begin{doublespace}
       \unvbox\absbox
     \end{doublespace}
   \end{singlespace}
   \if@openright
    \cleardoublepage
   \else
    \clearpage
   \fi}%
 \pagestyle{myheadings}} % no page headings
  
\newcommand*{\th@Titlepage}{
  \thispagestyle{empty}%
  % The setspace package is not too good with aligning text vertically.
  % The following should work.
  \begin{singlespace}
    \noindent
    \raisebox{0.25in}[\textheight]{\begin{minipage}[b]
       [\textheight + \headheight + \headsep - 0.5in]{6.5in}
       \centerline{\MakeUppercase{\th@university}}
       \centerline{\MakeUppercase{\th@address}}
       \vspace{4ex}
       \centerline{\MakeUppercase{\th@degreemonth\space\th@degreeyear}}
       \vfill
       \begin{doublespace}
         {\bfseries\begin{center}
           \uppercase\expandafter{\th@title}
         \end{center}}
         \vfill 
         \centerline{\uppercase{by}}
         \begin{singlespace}
           \centerline{\MakeUppercase{\th@author}}
           \centerline{\copyright\space\th@degreeyear\space\th@author}
         \end{singlespace}
         \vfill
         \begin{center}
           \MakeUppercase{A \th@thesis\ submitted to the graduate school}\\
           \MakeUppercase{in partial fulfillment of the requirements}\\
           \MakeUppercase{for the Degree}\\
           \MakeUppercase{\th@degree}
         \end{center}
         \vfill 
         \centerline{\MakeUppercase{\th@department}} 
       \end{doublespace}
       \vfill
       \hspace*{0in}\th@thesis\ Director: \\
       \hspace*{0.3in} \th@director
     \end{minipage}}
  \end{singlespace}
  \if@openright
   \cleardoublepage
  \else
   \clearpage
  \fi}

\newcommand{\th@Dedicationpage}{
  \ifhbox\dedibox
   \thispagestyle{empty}
   % centered
   \noindent
   \begin{minipage}{6.5in}
     \vspace*{\topskip}
     \chapter*{Dedication}
     \begin{center}
       \unhbox\dedibox
     \end{center}
   \end{minipage}
   \if@openright
    \cleardoublepage
   \else
    \clearpage
   \fi
   \fi}

\newcommand{\th@Acknowledgementpage}{
  \ifvbox\acknbox
   \thispagestyle{empty}
   \chapter*{Acknowledgements}
   \unvbox\acknbox
   \if@openright
    \cleardoublepage
   \else
    \clearpage
   \fi
  \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\th@renewlox#1#2#3#4{%
  \renewcommand*{#1}{%
    \chapter*{#2}
    % All lox except toc get an entry in toc.
    \ifx#1\tableofcontents\else
      \addcontentsline{toc}{chapter}{#2}%
    \fi
    \begin{singlespace}%
      % Hack: we add the `Page' header line by extending
      % the material that goes into the \output routine
      % (inspired by afterpage.sty).
      \newtoks\th@output
      \th@output\expandafter{\the\output}
      \output{\the\th@output
       \leftskip=0pt \noindent\hbox to\textwidth{#4\hfil Page}\par}%
      \vspace{-0.70\baselineskip}%
      \parskip 0.70\baselineskip
      \@starttoc{#3}%
    \end{singlespace}}}

% Redefinition of the \listofxxx commands
\th@renewlox{\tableofcontents}{\contentsname}{toc}{Chapter}
\th@renewlox{\listoftables}{\listtablename}{lot}{Table}
\th@renewlox{\listoffigures}{\listfigurename}{lof}{Figure}
\th@renewlox{\listofappend}{\listofappendname}{loa}{Appendix}

\def\th@loxheader#1#2{%
 \par\penalty-100
 \addtocontents{#1}{\addpenalty{\@secpenalty}\noindent #2\hfill Page\par
  \penalty1000}}

% Use these commands for the appropriate headers on the second /
% third etc. page of a table of contents / list of figures etc.
\newcommand*{\tocheader}{\th@loxheader{toc}{Chapter}}
\newcommand*{\lotheader}{\th@loxheader{lot}{Table}}
\newcommand*{\lofheader}{\th@loxheader{lof}{Figure}}
\newcommand*{\loaheader}{\th@loxheader{loa}{Appendix}}

%%%%%%%%% USER COMMANDS FOR CONTROLLING THE PROLOGUE:
\renewcommand*{\title}[1]{\gdef\th@title{#1}}
\newcommand*{\degreedate}[2]{%
 \gdef\th@degreemonth{#1}
 \gdef\th@degreeyear{#2}}
\newcommand*{\major}[1]{\gdef\th@major{#1}}
\renewcommand*{\author}[1]{%
  \gdef\th@author{#1}}
\newcommand*{\degree}[3]{%
  \gdef\th@thesis{#1}%
  \gdef\th@abbrevdegree{#2}%
  \gdef\th@degree{#3}}
\newcommand*{\director}[1]{%
  \gdef\th@director{#1}}
\newcommand*{\department}[1]{%
  \gdef\th@department{#1}}

\newbox\absbox
\renewenvironment{abstract}{%
  \setlength{\hsize}{6.5in}
  \global\setbox\absbox\vbox\bgroup
  \color@begingroup}%
 {\par\unskip
  \color@endgroup
  \egroup}

\newbox\dedibox
\newenvironment{dedication}{%
 % dedication goes centered
  \global\setbox\dedibox\hbox\bgroup
  \color@begingroup}%
 {\par\unskip
  \color@endgroup
  \egroup}

\newbox\acknbox
\newenvironment{acknowledgements}{%
  \global\setbox\acknbox\vbox\bgroup
  \color@begingroup}%
 {\par\unskip
  \color@endgroup
  \egroup}
% Which spelling is correct?
\let\acknowledgments\acknowledgements
\let\endacknowledgments\endacknowledgements

\def\lox@header#1#2{%
 \par\addtocontents{#1}{\noindent #2\hfill Page\par}}

% Here we put everything together to generate the prologue
\newcommand{\MakeThesisPrologue}{
  \th@Abstractpage
  \pagenumbering{roman}
  \th@Titlepage
  \th@Acknowledgementpage
  \th@Dedicationpage
  %
  \newif\ifth@loxheaderflag \th@loxheaderflagfalse
  \@ifundefined{th@lotflag}{}{\th@loxheaderflagtrue}
  \@ifundefined{th@lofflag}{}{\th@loxheaderflagtrue}
  \ifnum\th@loacount>1 \th@loxheaderflagtrue\fi
  %
  \ifth@loxheaderflag
    \addtocontents{toc}{\hspace*{\fill}Page\par}
    \lox@header{lot}{Table}
    \lox@header{lof}{Figure}
    \lox@header{loa}{Appendix}
  \else
    \lox@header{toc}{Chapter}
  \fi
  % ToC Page
  \tocpdfbookmark
  \tableofcontents
  % LoT Page
  \@ifundefined{th@lotflag}{}{\listoftables}
  % LoF Page
  \@ifundefined{th@lofflag}{}{\listoffigures}
  % LoA Page
  \ifnum\th@loacount>1 \listofappend\fi
  %
  % \listofXXX is a hook dummy to add more stuff such as a List of Symbols
  % Enable it by using something like \newcommand{\listofXXX}{\input{symbols}}
  \@ifundefined{listofXXX}{}{\listofXXX}
  %
  \ifth@loxheaderflag 
    \addtocontents{toc}{\noindent Chapter\par} 
  \fi
  %
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \pagenumbering{arabic}}

\endinput
%%
%%%%%%%%%%%%%%%% End of file ``niuthesis.cls''

%%% Local Variables: 
%%% TeX-master: "~/tex/inputs/packages/niuthesis/example/mythesis"
%%% End: 
