\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucsd}

%%%%%%%%%%%%%%%%%%%%%
% Tables rules      %
%%%%%%%%%%%%%%%%%%%%%

\newcommand{\boldarrayrulewidth}{1\p@} 
% Width of bold rule in tabular environment.

\def\bhline{\noalign{\ifnum0=`}\fi\hrule \@height  
\boldarrayrulewidth \futurelet \@tempa\@xhline}

\def\@xhline{\ifx\@tempa\hline\vskip \doublerulesep\fi
      \ifnum0=`{\fi}}

%
% Rules for tables with extra space around
%
\newcommand{\br}{\ms\bhline\ms}
\newcommand{\mr}{\ms\hline\ms}
%
\newcommand{\centre}[2]{\multispan{#1}{\hfill #2\hfill}}
\newcommand{\crule}[1]{\multispan{#1}{\hspace*{\tabcolsep}\hrulefill
  \hspace*{\tabcolsep}}}
\newcommand{\fcrule}[1]{\ifnum\thetabtype=1\multispan{#1}{\hrulefill
  \hspace*{\tabcolsep}}\else\multispan{#1}{\hrulefill}\fi}
%
% Extra spaces for tables and displayed equations
%
\newcommand{\ms}{\noalign{\vspace{3\p@ plus2\p@ minus1\p@}}}
\newcommand{\bs}{\noalign{\vspace{6\p@ plus2\p@ minus2\p@}}}
\newcommand{\ns}{\noalign{\vspace{-3\p@ plus-1\p@ minus-1\p@}}}
\newcommand{\es}{\noalign{\vspace{6\p@ plus2\p@ minus2\p@}}\displaystyle}%
%
\newcommand{\etal}{{\it et al\/}\ }
\newcommand{\dash}{------}
\newcommand{\nonum}{\par\item[]}                %\par added 1/9/93
\newcommand{\mat}[1]{\underline{\underline{#1}}}

%  ****************************************
%  *               FONTS                  *
%  ****************************************
%
 
\lineskip 1pt
\normallineskip 1pt

% Manual says to double space, but that seems excessive
% I used 1.5 in 17-18 and had no issues
% dsp is default for text, ssp is used in certain places
\def\baselinestretch{1.5}
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.5}\large\normalsize}
 
% Sets font sizes
\renewcommand{\normalsize}{\fontsize\@xipt{13.6}\selectfont%
\abovedisplayskip 11\p@ plus3\p@ minus6\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip  \z@ plus3\p@   
\belowdisplayshortskip  6.5\p@ plus3.5\p@ minus3\p@
\let\@listi\@listI}  
 
\newcommand{\small}{\fontsize\@xpt{12}\selectfont%
\abovedisplayskip 10\p@ plus2\p@ minus5\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip  \z@ plus3\p@   
\belowdisplayshortskip  6\p@ plus3\p@ minus3\p@
\def\@listi{\leftmargin\leftmargini 
\topsep 6\p@ plus2\p@ minus2\p@\parsep 3\p@ plus2\p@ minus\p@
\itemsep \parsep}}
 
% footnotes must be at least 10 pt (from 17-18 manual)
\newcommand{\footnotesize}{\fontsize\@xpt{12}\selectfont%
\abovedisplayskip 10\p@ plus2\p@ minus5\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip  \z@ plus3\p@   
\belowdisplayshortskip  6\p@ plus3\p@ minus3\p@
\def\@listi{\leftmargin\leftmargini 
\topsep 6\p@ plus2\p@ minus2\p@\parsep 3\p@ plus2\p@ minus\p@
\itemsep \parsep}}
 
\newcommand{\scriptsize}{\fontsize\@viiipt{9.5pt}\selectfont} 
\newcommand{\tiny}{\fontsize\@vipt{7pt}\selectfont} 
\newcommand{\large}{\fontsize\@xiipt{14pt}\selectfont} 
\newcommand{\Large}{\fontsize\@xivpt{18pt}\selectfont} 
\newcommand{\LARGE}{\fontsize\@xviipt{22pt}\selectfont} 
\newcommand{\huge}{\fontsize\@xxpt{26pt}\selectfont} 
\newcommand{\Huge}{\fontsize\@xxvpt{30pt}\selectfont} 
 
\normalsize  % Choose the normalsize font.

%  ****************************************
%  *            PAGE LAYOUT               *
%  ****************************************

% Horizontal, vertical, and footnotes verified for 17-18

% HORIZONTAL SPACING:
\textwidth 6.48in     % Width of text line.
\oddsidemargin 0in   %   Note that \oddsidemargin = \evensidemargin
\evensidemargin 0in
\hoffset 0.01in
\marginparwidth 0pt
\marginparsep 0pt
\paperwidth 8.5in
  
% VERTICAL SPACING:        
\voffset 0.01in
\topmargin 0in
\headheight 0in
\headsep 0in
\textheight 8.98in
\footskip 0.51in
\paperheight 11in
 
                         % For two-column mode: 
\columnsep 10pt          %    Space between columns 
\columnseprule 0pt       %    Width of rule between columns.
 
 
% FOOTNOTES:
\footnotesep 7pt    % Height of strut placed at the beginning of every
                      % footnote = height of normal \footnotesize strut,
                      % so no extra space between footnotes.
\skip\footins 10pt plus 4pt minus 2pt  % Space between last line of text
                                       % and top of first footnote.
 
% JC: I did not mess with these. worked for 17-18.  I didn't use two-column mode at all, though. 

% FLOATS: 
%
%  FOR FLOATS ON A TEXT PAGE:
%
%    ONE-COLUMN MODE OR SINGLE-COLUMN FLOATS IN TWO-COLUMN MODE:
% \floatsep 12pt plus 2pt minus 2pt        % Space between adjacent floats
%                                          % moved to top or bottom of
%                                          % text page.
% \textfloatsep 20pt plus 2pt minus 4pt    % Space between main text and
%                                          % floats at top or bottom of
%                                          % page.
% \intextsep 12pt plus 2pt minus 2pt       % Space between in-text figures
%                                          % and text.
% %    TWO-COLUMN FLOATS IN TWO-COLUMN MODE:
% \dblfloatsep 12pt plus 2pt minus 2pt     % Same as \floatsep for
%                                          % double-column figures in
%                                          % two-column mode.
% \dbltextfloatsep 20pt plus 2pt minus 4pt % \textfloatsep for
%                                          % double-column floats.
 
% %  FOR FLOATS ON A SEPARATE FLOAT PAGE OR COLUMN:
% %    ONE-COLUMN MODE OR SINGLE-COLUMN FLOATS IN TWO-COLUMN MODE:
% \@fptop 0pt plus 1fil    % Stretch at top of float page/column. (Must
%                          % be 0pt plus ...)
% \@fpsep 8pt plus 2fil    % Space between floats on float page/column.
% \@fpbot 0pt plus 1fil    % Stretch at bottom of float page/column. (Must
%                          % be 0pt plus ... )
 
% %   DOUBLE-COLUMN FLOATS IN TWO-COLUMN MODE.
% \@dblfptop 0pt plus 1fil % Stretch at top of float page. (Must be 0pt
%                          % plus ...)
% \@dblfpsep 8pt plus 2fil % Space between floats on float page.
% \@dblfpbot 0pt plus 1fil % Stretch at bottom of float page. (Must be 
%                          % 0pt plus ... )
% % MARGINAL NOTES:
% %
% \marginparpush 5pt       % Minimum vertical separation between two
%                          % marginal notes.
 

%  ****************************************
%  *           PARAGRAPHING               *
%  ****************************************
%
\parskip 0pt plus 1pt              % Extra vertical space between
                                   % paragraphs.
\parindent 0.5in                     % Width of paragraph indentation.
%\topsep 9pt plus 3pt minus 5pt    % Extra vertical space, in addition
                                   % to \parskip, added above and below
                                   % list and paragraphing environments.
\partopsep 3pt plus 1pt minus 2pt  % Extra vertical space, in addition
                                   % to \parskip and \topsep, added when
                                   % user leaves blank line before
                                   % environment.
%\itemsep 4.5pt plus 2pt minus 1pt % Extra vertical space, in addition
                                   % to \parskip, added between list
                                   % items.
% See \@listI for values of \topsep and \itemsep
% (Change made 9 Jun 87)
 
% The following page-breaking penalties are defined
 
\@lowpenalty   51      % Produced by \nopagebreak[1] or \nolinebreak[1]
\@medpenalty  151      % Produced by \nopagebreak[2] or \nolinebreak[2]
\@highpenalty 301      % Produced by \nopagebreak[3] or \nolinebreak[3]
 
\@beginparpenalty -\@lowpenalty    % Before a list or paragraph
                                   % environment.
\@endparpenalty   -\@lowpenalty    % After a list or paragraph
                                   % environment.
\@itempenalty     -\@lowpenalty    % Between list items.
 
% \clubpenalty         % 'Club line'  at bottom of page.
% \widowpenalty        % 'Widow line' at top of page.
% \displaywidowpenalty % Math display widow line.
% \predisplaypenalty   % Breaking before a math display.
% \postdisplaypenalty  % Breaking after a math display.
% \interlinepenalty    % Breaking at a line within a paragraph.
% \brokenpenalty       % Breaking after a hyphenated line.
 

%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
 
% Indenting: We desire to make every paragraph in the document
% indent.  LaTeX uses the \if@afterindent swtich
% to determine indenting.  We thus make sure this is always true.
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue

% Definition of \part moved to report.doc  19 Jan 88

% \@makechapterhead {TEXT} : Makes the heading for the \chapter
% command.
%
 
% These can be tweaked but worked for 17-18
\def\@makechapterhead#1{%           % Heading for \chapter command
  \vspace*{30\p@}%                  % Space at top of text page.
  {
  \parindent \z@ \raggedright 
    \ifnum \c@secnumdepth >\m@ne    % IF secnumdepth > -1 THEN
      \Huge\bfseries \@chapapp{} \thechapter
      \par
      \vskip 15\p@
    % \else
    %   \Huge\bfseries \thechapter
    %   \hskip 20\p@
    % \fi
      \fi                % Space between number and title.
    \Huge \bfseries                       % Title.
    #1\par 
    \nobreak                        % TeX penalty to prevent page break.
    \vskip 30\p@                    % Space between title and text.
  }}
 
 
\def\@makeschapterhead#1{%          % Heading for \chapter* command
  \vspace*{50\p@}%                  % Space at top of page.
  {\parindent \z@ \raggedright 
    \Huge \bfseries                       % Title.
    #1\par 
    \nobreak                        % TeX penalty to prevent page break.
    \vskip 40\p@                    % Space between title and text.
  }}
 
\def\chapter{\clearpage      % Starts new page.
   \thispagestyle{plain}%    % Page style of chapter page is 'plain'
   \global\@topnum\z@        % Prevents figures from going
                             % at top of page.
   \@afterindenttrue         % Suppresses indent in first paragraph.
   \secdef\@chapter\@schapter}   % Change to \@afterindentfase for no indent.
 
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        %\ifnum \@chapterheadsmark = 1 % RMR- Add \@chapapp to the toc if chapterheads is set
          \addcontentsline{toc}{chapter}{\protect
          \numberline{\@chapapp~\thechapter}#1}
        % \else
        %   \addcontentsline{toc}{chapter}{\protect
        %   \numberline{\thechapter}#1}
        % \fi
   \else
      \addcontentsline{toc}{chapter}{#1}
   \fi
   \chaptermark{#1}%
   \addtocontents{lof}%
       {\protect\addvspace{10\p@}} % Adds between-chapter space
   \addtocontents{lot}%
       {\protect\addvspace{10\p@}} % to lists of figs & tables.
   \if@twocolumn                   % Tests for two-column mode.  
           \@topnewpage[\@makechapterhead{#2}]%
     \else \@makechapterhead{#2}%
           \@afterheading          % Routine called after chapter and
     \fi}                          % section heading.
 
\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]%
        \else \@makeschapterhead{#1}%
              \@afterheading\fi}
 
% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE} 
%            optional * [ALTHEADING]{HEADING}
%    Generic command to start a section.  
%    NAME       : e.g., 'subsection'
%    LEVEL      : a number, denoting depth of section -- e.g.,
%                 chapter=1, section = 2, etc.  A section number will be
%                 printed if and only if LEVEL < or = the value of the
%                 secnumdepth counter.
%    INDENT     : Indentation of heading from left margin
%    BEFORESKIP : Absolute value = skip to leave above the heading.  
%                 If negative, then paragraph indent of text following 
%                 heading is suppressed.
%    AFTERSKIP  : if positive, then skip to leave below heading,
%                       else - skip to leave to right of run-in heading.
%    STYLE      : commands to set style
%  If '*' missing, then increments the counter.  If it is present, then
%  there should be no [ALTHEADING] argument.  A sectioning command
%  is normally defined to \@startsection + its first six arguments.
 
\def\section{\@startsection {section}{1}{\z@}{-3.5ex plus-1ex minus
    -.2ex}{2.3ex plus.2ex}{\reset@font\Large\bfseries}}
\def\subsection{\@startsection{subsection}{2}{\z@}{-3.25ex plus-1ex
    minus-.2ex}{1.5ex plus.2ex}{\reset@font\large\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-3.25ex plus
    -1ex minus-.2ex}{1.5ex plus.2ex}{\reset@font\normalsize\bfseries}}
\def\paragraph{\@startsection
    {paragraph}{4}{\z@}{3.25ex plus1ex minus.2ex}{-1em}{\reset@font
    \normalsize\bfseries}}
\def\subparagraph{\@startsection
     {subparagraph}{4}{\parindent}{3.25ex plus1ex minus
     .2ex}{-1em}{\reset@font\normalsize\bfseries}}
 
% Default initializations of \...mark commands.  (See below for their
% us in defining page styles.
%
 
\def\chaptermark#1{}
% \def\sectionmark#1{}           % Preloaded definitions
% \def\subsectionmark#1{}
% \def\subsubsectionmark#1{}
% \def\paragraphmark#1{}
% \def\subparagraphmark#1{}
 
% The value of the counter secnumdepth gives the depth of the
% highest-level sectioning command that is to produce section numbers.
%
 
\setcounter{secnumdepth}{2}
 
% APPENDIX
%
% The \appendix command must do the following:
%    -- reset the chapter counter to zero
%    -- set \@chapapp to Appendix (for messages)
%    -- redefine the chapter counter to produce appendix numbers
%    -- reset the section counter to zero
%    -- redefine the \chapter command if appendix titles and headings
%       are to look different from chapter titles and headings.
 
\def\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \def\@chapapp{\appendixname}%
  \def\thechapter{\Alph{chapter}}}
 

%    ****************************************
%    *                LISTS                 *
%    ****************************************
%
 
% The following commands are used to set the default values for the list
% environment's parameters. See the LaTeX manual for an explanation of
% the meanings of the parameters.  Defaults for the list environment are
% set as follows.  First, \rightmargin, \listparindent and \itemindent
% are set to 0pt.  Then, for a Kth level list, the command \@listK is
% called, where 'K' denotes 'i', 'ii', ... , 'vi'.  (I.e., \@listiii is
% called for a third-level list.)  By convention, \@listK should set
% \leftmargin to \leftmarginK.
%
% For efficiency, level-one list's values are defined at top level, and
% \@listi is defined to set only \leftmargin.
 
\leftmargini 2.5em
\leftmarginii 2.2em     % > \labelsep + width of '(m)'
\leftmarginiii 1.87em   % > \labelsep + width of 'vii.'
\leftmarginiv 1.7em     % > \labelsep + width of 'M.'
\leftmarginv 1em
\leftmarginvi 1em
 
\leftmargin\leftmargini
\labelsep .5em
\labelwidth\leftmargini\advance\labelwidth-\labelsep
%\parsep 4.5pt plus 2pt minus 1pt  %(Removed 9 Jun 87)
 
% \@listI defines top level and \@listi values of
% \leftmargin, \topsep, \parsep, and \itemsep
% (Added 9 Jun 87)
\def\@listI{\leftmargin\leftmargini \parsep 4.5\p@ plus2\p@ minus\p@
\topsep 9\p@ plus3\p@ minus5\p@
\itemsep 4.5\p@ plus2\p@ minus\p@}
 
\let\@listi\@listI
\@listi 
 
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii\advance\labelwidth-\labelsep
   \topsep 4.5\p@ plus2\p@ minus\p@
   \parsep 2\p@ plus\p@ minus\p@
   \itemsep \parsep}
 
\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
    \topsep 2\p@ plus\p@ minus\p@ 
    \parsep \z@ \partopsep \p@ plus\z@ minus\p@
    \itemsep \topsep}
 
\def\@listiv{\leftmargin\leftmarginiv
     \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}
 
\def\@listv{\leftmargin\leftmarginv
     \labelwidth\leftmarginv\advance\labelwidth-\labelsep}
 
\def\@listvi{\leftmargin\leftmarginvi
     \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}


\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}

% \tableofcontents:
\def\contentsshortname{Contents}
\def\contentslongname{Table of Contents}
%                 ~~~~~~~~~~~~~~~~~
% \listoffigures:
\def\listfigurename{List of Figures}
%                   ~~~~~~~~~~~~~~~
% \listoftables:
\def\listtablename{List of Tables}
%                  ~~~~~~~~~~~~~~
% \thebibliography:
\def\bibname{References}
%            ~~~~~~~~~~~~
% \theindex:
\def\indexname{Index}
%              ~~~~~
% figure environment:
\def\figurename{Figure}
%               ~~~~~~
% table environment:
\def\tablename{Table}
%              ~~~~~
% \chapter:
\def\chaptername{Chapter}
%                ~~~~~~~
% \appendix:
\def\appendixname{Appendix}
%                 ~~~~~~~~
%             ~~~~
% abstract environment:
\def\abstractshortname{Abstract of the Dissertation} % Used for TOC
\def\abstractlongname{Abstract of the Dissertation} % Used for Header
%                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% acknowledge environment:
\def\acknowledgename{Acknowledgements}
%                    ~~~~~~~~~~~~~~~~

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.  

% The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}}

% The name of your committee's cochair, if applicable
\def\cochair#1{\gdef\@cochair{#1}}

% The names of your other committe members, one per line,
% sorted alphabetically by last name.
\def\othermembers#1{\gdef\@othermembers{#1}}

% The number of committee members, which affects both the
% number of lines and the amount of space between lines
% on the approval page. 
\def\@numberofmembers{3}
\def\@approvalspace{.75in}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}
\ifnum \@numberofmembers > 3
\gdef\@approvalspace{.5in}
\fi}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

\def\includefigureindex#1{\gdef\@includefigureindex{#1}}
\def\includetableindex#1{\gdef\@includetableindex{#1}}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros except \campuscap.  It is probably not correct for 
% joint (e.g. UCSD/SDSU) degrees.

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\def\makefrontmatter{  
% TITLE PAGE.   
% This is the first page of the dissertation.  The format 
% is specified by OGS.
%
{\ssp
\newpage
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil
  \begin{center}
    \fmfont
    UNIVERSITY OF CALIFORNIA SAN DIEGO \par
    \vspace{0.5in}
    {\bfseries
     {\@title} \par}
    \vspace{0.5in}
    A dissertation submitted in partial satisfaction of the \par 
	\smallskip
    requirements for the degree 
	%\smallskip
    {\@degree} \par
    \vspace{0.25in}
    in \par
    \vspace{0.25in}
    {\@field}\par
    \vspace{0.25in}
    by \par
    \vspace{0.25in}
    {\@author} \par
  \end{center}
  {
    \vspace{0.875in}
    \fmsmallfont
    Committee in charge:
    \begin{quote}
       {\@chair}, Chair\newline
       {\@othermembers}
    \end{quote}
    \vspace{0.25in}
    \begin{center}
      {\@degreeyear}
    \end{center}
  }
  \vfil\null
\newpage

} 


% COPYRIGHTPAGE
%
% While it's technically optional you probably want a copyright page.
% Note that if you don't have one, you need a completely blank page 
% anyway.

\newpage
\thispagestyle{empty}
\null\vfill\dsp 
\begin{center}
{\fmfont
Copyright \par
\@author, \@degreeyear\par
All rights reserved.}
\end{center}
\newpage


% SIGNATURE PAGE
%
% This requires that the \year, \author, and \campus macros have been
% defined.  It uses lots of tricky spacing that is probably better
% handled with tabular environment code, but I'm too lazy to fix it.
% (EVM, 9/19/94)

\phantomsection
\addcontentsline{toc}{chapter}{Signature Page}
%\addcontentsline{toc}{chapter}{\protect\numberline{}Signature Page}%
\newpage
\null\vfill
\begin{center}
\vspace{.25in}
\vspace{\@approvalspace}
\makebox[4in][l]{\parbox{4in}{\fmfont 
\ssp{The dissertation of {\@author} 
is approved, and it is acceptable in quality and form for publication 
on microfilm and electronically: }
}}\\
\dsp{}
\begin{tabular*}{4in}[t]{r@{\extracolsep{\fill}}r}
& \rule{0pt}{\@approvalspace} \\
\hline
\ifnum \@numberofmembers > 2
& \rule{0pt}{\@approvalspace} \\
\hline
\fi
\ifnum \@numberofmembers > 3
& \rule{0pt}{\@approvalspace} \\
\hline
\fi
\ifnum \@numberofmembers > 4
& \rule{0pt}{\@approvalspace} \\
\hline
\fi
\ifnum \@numberofmembers > 5
& \rule{0pt}{\@approvalspace} \\
\hline
\fi
\ifnum \@numberofmembers > 6
& \rule{0pt}{\@approvalspace} \\
\hline
\fi
&\rule{0pt}{\@approvalspace} \\
\hline

& Chair
\end{tabular*}\\[\@approvalspace]
{\fmfont University of California San Diego} \\
\vspace{-.25in}
\vspace{\@approvalspace}
{\fmfont \@degreeyear}
\end{center}
\vfill\null
\newpage

} % \makefrontmatter

% EPIGRAPH
%
% The epigraph environment just makes sure the epigraph gets its
% own page. The text is formatted relatively high on the page and
% flush to the right.
\newenvironment{epigraph}
{\phantomsection 
%\addcontentsline{toc}{chapter}{\protect\numberline{}Epigraph}%
\addcontentsline{toc}{chapter}{Epigraph}
\newpage
  \centerline{\expandafter\uppercase\expandafter{Epigraph}}%
  \vspace{2in}\hfill\begin{flushright}}
  %\parbox[t]{3in}
{\end{flushright}\newpage}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment creates a page and puts it in the
% TOC.
\newenvironment{acknowledgements}
{\newpage
\phantomsection
%\addcontentsline{toc}{chapter}{\protect\numberline{}\acknowledgename}%
\addcontentsline{toc}{chapter}{\acknowledgename}%
\centerline{\expandafter\uppercase\expandafter{\acknowledgename}}%
\bigskip
}
{\newpage}

% VITA PAGE
%
% In the normal environments, the vitapage environment does nothing
% but start and end a page.  In two-column style it makes a one-column
% page.
%
\def\vitapage{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
     \else \newpage \fi\pagestyle{preliminary}
     \phantomsection
     %\addcontentsline{toc}{chapter}{\protect\numberline{}Vita}}
     \addcontentsline{toc}{chapter}{Vita}}
% Special label for the vita list
%
\def\vitalabel#1{#1\hfill}
\def\vita{\begin{center}VITA\end{center}
     \list{}{\ssp \leftmargin 1.35in \labelwidth 1in \let\makelabel\vitalabel
           \labelsep 0.3in}}
\let\endvita\endlist

% For making "bibliographic-like" entries on the Vita page
%
\def\publications{\medskip\begin{center}PUBLICATIONS\end{center}
     \list{}{\ssp \leftmargin\z@}}
\let\endpublications\endlist

% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with UC rules, is numbered separately from the rest
% of the rest of the dissertation in Arabic.  It requires definition
% of the \title, \author, \degree, \field, \campus, and \chair macros.
% The page numbering is in the usual sequence for UCSD OGS--WBB.

% addcontentsline line moved to fix TOC bug.  (JRB, 5-5-08)

% ??? Abstract Spacing
% (1) page break at (ii)

% \def\abstract{ 
% \phantomsection
% \clearpage
% \begin{center}
% \vspace*{1.2in} % use if 2.5 inches to header
% %\vspace*{0.55in} % use if 2.5 inches to title
% {\fmfont
% {\expandafter\uppercase\expandafter{\abstractlongname}}\par
% %\vspace{.4in} % use if 2.5 inches to title
% \vspace{.15in} % use if 2.5 inches to header
%     {\bfseries
%      {\@title} \par}
% by\par
% \@author\par
% \vspace{.1in}
% {\@degree} in \@field\par
% %
% University of California San Diego, \@degreeyear \par
% {\@chair}, Chair}
% \vspace{.1in}
% \end{center}
% \addcontentsline{toc}{chapter}{\abstractshortname}%
% }

% (2) page break at (i)

\def\abstract{ 
\phantomsection
\clearpage
\begin{center}
\vspace*{1.2in} % use if 2.5 inches to header
%\vspace*{0.55in} % use if 2.5 inches to title
{\fmfont
{\expandafter\uppercase\expandafter{\abstractlongname}}\par
\vspace{0.3in}
    {\bfseries
     {\@title} \par}
\vspace{0.1in}
by\par
\vspace{0.1in}
\@author\par
\vspace{.2in}
{\@degree} in Electrical Engineering \\[-0.25em]
(Medical Devices\& Systems)\par
\vspace{.2in}
%
University of California San Diego, \@degreeyear \par
\vspace{.2in}
{\@chair}, Chair}
\vspace{.3in}
\end{center}
\addcontentsline{toc}{chapter}{\abstractshortname}%
}

\def\endabstract{\par\vfil\null\newpage
}


% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 3) for the front matter
% that follows the abstract.  It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).
% (WBB) At UCSD: put everything, including \titlepage,\copyrightpage,  
% \approvalpage in frontmatter.  
% Changed def. WBB to go with change in use of frontmatter.

\newenvironment{frontmatter}
{\pagestyle{preliminary}\pagenumbering{roman}}%
{\pagestyle{thesis}\pagenumbering{arabic}}


%    ****************************************
%    *                LISTS                 *
%    ****************************************
%

% ENUMERATE
%  Enumeration is done with four counters: enumi, enumii, enumiii
%  and enumiv, where enumN controls the numbering of the Nth level
%  enumeration.  The label is generated by the commands \labelenumi
%  ... \labelenumiv.  The expansion of \p@enumN\theenumN defines the
%  output of a \ref command.
%
% 16 Mar 88 -- changed defs of \labelenum... to use \theenum...

\def\labelenumi{\theenumi.}
\def\theenumi{\arabic{enumi}}

\def\labelenumii{(\theenumii)}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}

\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}

\def\labelenumiv{\theenumiv.}
\def\theenumiv{\Alph{enumiv}}
\def\p@enumiv{\p@enumiii\theenumiii}

% ITEMIZE
% Itemization is controlled by four commands: \labelitemi, \labelitemii,
% \labelitemiii, and \labelitemiv, which define the labels of the
% various itemization levels.

\def\labelitemi{$\m@th\bullet$}
\def\labelitemii{\bfseries --}
\def\labelitemiii{$\m@th\ast$}
\def\labelitemiv{$\m@th\cdot$}


% VERSE
%   The verse environment is defined by making clever use of the
%   list environment's parameters.  The user types \\ to end a line.
%   This is implemented by \let'in \\ equal \@centercr.
%
\def\verse{\par\let\\=\@centercr
  \list{}{\ssp\itemsep\z@ \itemindent -1.5em\listparindent \itemindent
          \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist

% QUOTATION
%   Fills lines
%   Indents paragraph
%
\def\quotation{\par\list{}{\ssp\listparindent 1.5em
    \itemindent\listparindent
    \rightmargin\leftmargin\parsep \z@ plus\p@}\item[]}
\let\endquotation=\endlist

% QUOTE -- same as quotation except no paragraph indentation,
%
\def\quote{\par\list{}{\ssp\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist

% DESCRIPTION
%
%  To change the formatting of the label, you must redefine
%  \descriptionlabel.

\def\descriptionlabel#1{\hspace\labelsep \bfseries #1}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
       \let\makelabel\descriptionlabel}}

\let\enddescription\endlist

\newdimen\descriptionmargin
\descriptionmargin=3em


%    ****************************************
%    *         OTHER ENVIRONMENTS           *
%    ****************************************
%
%
% VERBATIM
%
% standard verbatim mode driver macro is modified to use
% single-spacing.  There appears to be a small problem with extra
% vertical space (1 or 2 points worth) after this environment.
% Probably, this results from returning to double-spacing before
% issuing a \parskip, but I'm not enough of TeX hacker to figure out
% the source of the problem. (EVM, 9/25/94)
% 94/11/03 BBF converted \tt to \ttfamily

\def\@verbatim{\trivlist\ssp \item[]\if@minipage\else\vskip\parskip\fi
\leftskip\@totalleftmargin\rightskip\z@
\parindent\z@\parfillskip\@flushglue\parskip\z@
%%RmS 91/08/26 Added \@@par to clear possible \parshape definition
%%from a surrounding list (the verbatim guru says)
\@@par
\@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par
\penalty\interlinepenalty}%
\obeylines \ttfamily \catcode``=13 \@noligs \let\do\@makeother \dospecials}

% ARRAY AND TABULAR
%

\arraycolsep 5pt     % Half the space between columns in an array
                     % environment.
\tabcolsep 6pt       % Half the space between columns in a tabular
                     % environment.
\arrayrulewidth .4pt % Width of rules in array and tabular environment.
\doublerulesep 2pt   % Space between adjacent rules in array or tabular
                     % environment.

% We have to redefine array here in order to make it single-spaced.
% (Not sure if this is really necessary.)
\def\array{\let\@acol\@arrayacol \let\@classz\@arrayclassz
 \let\@classiv\@arrayclassiv \let\\\@arraycr\let\@halignto\@empty\@tabarray}

% TABBING
%
\tabbingsep \labelsep   % Space used by the \' command.
                        %  (See LaTeX manual.)

% We have to redefine tabular here in order to make it single-spaced.
\def\tabular{\par\ssp\let\@halignto\@empty\@tabular}
\expandafter \def\csname tabular*\endcsname #1%
{\par\ssp\def\@halignto{to#1}\@tabular}

% \smalltabular and \smalltabular* are alternative tabular styles
% in the \small font.  They are required because single-spacing implies a 
% change of font to a particular size.
% EVM, 7/20/93 
\def\smalltabular{\par\smallssp\let\@halignto\@empty\@tabular}
\def\endsmalltabular{\endtabular}
\expandafter \def\csname smalltabular*\endcsname #1%
{\par\smallssp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endsmalltabular*\endcsname = \endtabular

% \scriptsizetabular and \scriptsizetabular* are analogs of \smalltabular
\def\scriptsizetabular{\par\scriptsizessp\let\@halignto\@empty\@tabular}
\def\endscriptsizetabular{\endtabular}
\expandafter \def\csname scriptsizetabular*\endcsname #1%
{\par\scriptsizessp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endscriptsizetabular*\endcsname = \endtabular

% MINIPAGE
%  \@minipagerestore is called upon entry to a minipage environment to
%  set up things that are to be handled differently inside a minipage
%  environment. In the current styles, it does nothing.
%
% \skip\@mpfootins : plays same role for footnotes in a minipage as
%                    \skip\footins does for ordinary footnotes

\skip\@mpfootins = \skip\footins

% FRAMEBOX
%
\fboxsep = 3pt    % Space left between box and text by \fbox and
                  % \framebox.
\fboxrule = .4pt  % Width of rules in box made by \fbox and \framebox.


%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
% DEFINE COUNTERS:
%
% \newcounter{NEWCTR}[OLDCTR] : Defines NEWCTR to be a counter, which is
%                               reset to zero when counter OLDCTR is
%                               stepped.
%                               Counter OLDCTR must already be defined.

% Must redefine @startsection so that we always get indentation.
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \@afterindenttrue
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \relax\fi
   \if@nobreak \everypar{}\else
     \addpenalty{\@secpenalty}\addvspace{\@tempskipa}\fi \@ifstar
     {\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

% For any counter CTR, \theCTR is a macro that defines the printed
% version of counter CTR.  It is defined in terms of the following
% macros:
%
%  \arabic{COUNTER} : The value of COUNTER printed as an arabic numeral.
%  \roman{COUNTER}  : Its value printed as a lower-case roman numberal.
%  \Roman{COUNTER}  : Its value printed as an upper-case roman numberal.
%  \alph{COUNTER}   : Value of COUNTER printed as a lower-case letter:
%                         1 = a, 2 = b, etc.
%  \Alph{COUNTER}   : Value of COUNTER printed as an upper-case letter:
%                           1 = A, 2 = B, etc.
%

\def\thechapter       {\arabic{chapter}}
\def\thesection       {\thechapter.\arabic{section}}
\def\thesubsection    {\thesection.\arabic{subsection}}
\def\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\def\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

% \@chapapp is initially defined to be '\chaptername'.  The \appendix
% command redefines it to be '\appendixname'.
%
\def\@chapapp{\chaptername}


%
%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************
%
% A \subsection command writes a
%       \contentsline{subsection}{TITLE}{PAGE}
% command on the .toc file, where TITLE contains the contents of the
% entry and PAGE is the page number.  If subsections are being numbered,
% then TITLE will be of the form
%       \numberline{NUM}{HEADING}
% where NUM is the number produced by \thesubsection.  Other sectioning
% commands work similarly.
%
% A \caption command in a 'figure' environment writes
%    \contentsline{figure}{\numberline{NUM}{CAPTION}}{PAGE}
% on the .lof file, where NUM is the number produced by \thefigure and
% CAPTION is the figure caption.  It works similarly for a 'table'
% environment.
%
% The command \contentsline{NAME} expands to \l@NAME.  So, to specify
% the table of contents, we must define \l@chapter, \l@section,
% \l@subsection, ... ; to specify the list of figures, we must define
% \l@figure; and so on.  Most of these can be defined with the
% \@dottedtocline command, which works as follows.
%
% \@dottedtocline{LEVEL}{INDENT}{NUMWIDTH}{TITLE}{PAGE}
%    LEVEL    : An entry is produced only if LEVEL < or = value of
%               'tocdepth' counter.  Note, \chapter is level 0, \section
%               is level 1, etc.
%    INDENT   : The indentation from the outer left margin of the start
%               of the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command.
%
% This command uses the following three parameters, which are set
% with a \def (so em's can be used to make them depend upon the font).
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for multiple line entries.  One
%                 wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be
%                 \def'd to a number like 2 or 1.7

\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{3}
\setcounter{tocdepth}{2}

% TABLEOFCONTENTS
%  In ucsd-thesis style, \tableofcontents, \listoffigures, etc. are always
%  set in single-column style.  @restonecol
%  We also change ``Contents'' to ``TABLE OF CONTENTS'' --(WBB)

\def\tableofcontents{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi%
% From ucsd-thesis.sty (WBB), modified 
  \newpage
  \phantomsection
  %\addcontentsline{toc}{chapter}{\protect\numberline{}\contentslongname}%
  \addcontentsline{toc}{chapter}{\contentslongname}%
  \centerline{\expandafter\uppercase\expandafter{\contentslongname}}%
  \bigskip%
%  \chapter*{\contentsname
%        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}}%
  {\ssp\@starttoc{toc}}\if@restonecol\twocolumn\fi}


\newlength{\@chapterlength} % Original Magic Value - RMR
\setlength{\@chapterlength}{1.5em} % This code adds space for \@chapapp for toc entries
%\ifnum \@chapterheadsmark = 1
\settowidth{\@chapterlength}{\@chapapp}
\addtolength{\@chapterlength}{2em} % Space between toc labels and values
%\fi

\def\l@chapter{\pagebreak[3]\vskip 0.70em plus 1pt \@dottedtocline{0}{0em}{\@chapterlength}}
% ??? Chapter spacing in TOC

\def\l@section{\pagebreak[3]\vskip 0.3em plus 0.5pt \@dottedtocline{1}{\@chapterlength}{2.3em}}

\newlength{\@subsectionlength}
\setlength{\@subsectionlength}{\@chapterlength}
\addtolength{\@subsectionlength}{2.3em}
\def\l@subsection{\pagebreak[3]\vskip 0.175em plus 0.25pt \@dottedtocline{2}{\@subsectionlength}{3.2em}}

\newlength{\@subsubsectionlength}
\setlength{\@subsubsectionlength}{\@chapterlength}
\addtolength{\@subsubsectionlength}{5.5em}
\def\l@subsubsection{\@dottedtocline{3}{\@subsubsectionlength}{4.1em}}

\newlength{\@paragraphlength}
\setlength{\@paragraphlength}{\@chapterlength}
\addtolength{\@paragraphlength}{8.5em}
\def\l@paragraph{\@dottedtocline{4}{\@paragraphlength}{5em}}

\newlength{\@subparagraphlength}
\setlength{\@subparagraphlength}{\@chapterlength}
\addtolength{\@subparagraphlength}{10.5em}
\def\l@subparagraph{\@dottedtocline{5}{\@subparagraph}{6em}}

% LIST OF FIGURES
%
% Single-space list of figures, add it to the table of contents.
\def\listoffigures{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
%  \chapter*{\listfigurename\@mkboth{\uppercase{\listfigurename}}%
% {\uppercase{\listfigurename}}}
% WBB
  \newpage
  \centerline{\expandafter\uppercase\expandafter{\listfigurename}}%
  \bigskip%
  \phantomsection
  % \addcontentsline{toc}{chapter}{\protect\numberline{}\listfigurename }%
  \addcontentsline{toc}{chapter}{\listfigurename }%
  \begingroup  % This group overloads \numberline to output ``Figure 1.3'' instead of ``1.3''
  \let\ORIG@numberline\numberline
  \renewcommand*{\numberline}[1]{
  \ORIG@numberline{\figurename~##1:}}

   {\ssp\@starttoc{lof}}\if@restonecol
    \twocolumn\fi
  \endgroup  
  }

%\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newlength{\@figurelength}
\settowidth{\@figurelength}{\figurename }
\addtolength{\@figurelength}{2.8em} % Magic value, but consistent with the standard figure length
\def\l@figure{\pagebreak[3]\vskip 0.3em plus 0.5pt \@dottedtocline{1}{0em}{\@figurelength}}

% LIST OF TABLES
%
%\def\listoftables{\@restonecolfalse
%  \if@twocolumn\@restonecoltrue\onecolumn\fi
%  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
%   {\uppercase{\listtablename}}}\@starttoc{lot}\if@restonecol
%  \twocolumn\fi}
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
% WBB
  \newpage
  \centerline{\expandafter\uppercase\expandafter{\listtablename}}%
  \bigskip%
  \phantomsection
  %\addcontentsline{toc}{chapter}{\protect\numberline{}\listtablename }%
  \addcontentsline{toc}{chapter}{\listtablename }%
  % RMR 2007 
  \begingroup  % This group overloads \numberline to output ``Table 1.3'' instead of ``1.3''
  \let\ORIG@numberline\numberline
  \renewcommand*{\numberline}[1]{\ORIG@numberline{\tablename~##1:}}
%  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
%{\uppercase{\listtablename}}}
%   \addcontentsline{toc}{chapter}{\listtablename}
   {\ssp\@starttoc{lot}}\if@restonecol
  \twocolumn\fi
  \endgroup  
  }


%\let\l@table\l@figure
\newlength{\@tablelength}
\settowidth{\@tablelength}{\tablename }
\addtolength{\@tablelength}{2.8em} % Magic value, but consistent with the standard table length
\def\l@table{\@dottedtocline{1}{0em}{\@tablelength}}


%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
% The thebibliography environment executes the following commands:
%
%  \def\newblock{\hskip .11em plus .33em minus .07em} --
%      Defines the `closed' format, where the blocks (major units of
%      information) of an entry run together.
%
%  \sloppy  -- Used because it's rather hard to do line breaks in
%      bibliographies,
%
%  \sfcode`\.=1000\relax --
%      Causes a `.' (period) not to produce an end-of-sentence space.

%% RmS 91/10/27 [ .. ] replaced by \@biblabel{ .. }
%% RmS 91/11/13: Changed counter enumi to enumiv,
%%               as it says in the comment in latex.tex
%% RmS 92/01/14: Set \p@enumiv to {} and \theenumiv to \arabic{enumiv}
%%               to get correct references
\def\thebibliography#1{\section*{\bibname\@mkboth
  {\expandafter\uppercase\expandafter{\bibname}}{\expandafter\uppercase\expandafter{\bibname}}}
  \addcontentsline{toc}{section}{\bibname}
  \ssp %WBB re OGSR style, 6.11.97
  \list{\@biblabel{\arabic{enumiv}}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m}


%% 91/08/26 FMI & RmS: introduced warning instead of error

\def\endthebibliography{%
  \def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
  \endlist}


% \def\@biblabel#1{[#1]\hfill}  % Produces the label for a \bibitem[...]
                                % command.
% \def\@cite#1{[#1]}            % Produces the output of the \cite
                                % command.



%    ****************************************
%    *              THE INDEX               *
%    ****************************************
%
% THE THEINDEX ENVIRONMENT
% Produces double column format, with each paragraph a separate entry.
% The user commands \item, \subitem and \subsubitem are used to
% produce the entries, and \indexspace adds an extra vertical space
% that's the right size to put above the first entry with a new letter
% of the alphabet.

\newif\if@restonecol

\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@
\columnsep 35\p@\twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\uppercase{\indexname}}{\uppercase{\indexname}}%
    \thispagestyle{plain}\parindent\z@
    \parskip\z@ plus .3\p@\relax\let\item\@idxitem
\phantomsection
\addcontentsline{toc}{chapter}{\indexname} 
}

\def\@idxitem{\par\hangindent 40\p@}

\def\subitem{\par\hangindent 40\p@ \hspace*{20\p@}}

\def\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}

\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}

\def\indexspace{\par \vskip 10\p@ plus5\p@ minus3\p@\relax}


%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
% \footnoterule is a macro to draw the rule separating the footnotes
% from the text.  It should take zero vertical space, so it needs a
% negative skip to compensate for any positive space taken by the rule.
% (See PLAIN.TEX.)

\def\footnoterule{\kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}                 % The \hrule has default height of .4pt.

% \newcounter{footnote}
\@addtoreset{footnote}{chapter}  % Numbers footnotes within chapters

%   \@makefntext{NOTE} :
%        Must produce the actual footnote, using \@thefnmark as the mark
%        of the footnote and NOTE as the text.  It is called when
%        effectively inside a \parbox of width \columnwidth (i.e., with
%        \hsize = \columnwidth).
%
%        The following macro indents all lines of the footnote by 10pt,
%        and indents the first line of a new paragraph by 1em.  To
%        change these dimensions, just substitute the desired value for
%        '10pt' [in both places] or '1em'.  The mark is flushright
%        against the footnote.
%          \long\def\@makefntext#1{\@setpar{\@@par\@tempdima \hsize
%             \advance\@tempdima-10pt\parshape \@ne 10pt \@tempdima}\par
%             \parindent 1em\noindent
%             \hbox to \z@{\hss$\m@th^{\@thefnmark}$}#1}
%
%        A simpler macro is used, in which the footnote text is
%        set like an ordinary text paragraph, with no indentation except
%        on the first line of a paragraph, and the first line of the
%        footnote.  Thus, all the macro must do is set \parindent
%        to the appropriate value for succeeding paragraphs and put the
%        proper indentation before mark.

\long\def\@makefntext#1{\parindent 1em\noindent
            \hbox to 1.8em{\hss$\m@th^{\@thefnmark}$}#1}

% \@makefnmark : A macro to generate the footnote marker that goes
%    in the text.  Default used.
%


% Single-space footnotes.
\long\def\@footnotetext#1{\insert\footins{\ssp\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

%    ****************************************
%    *         FIGURES AND TABLES           *
%    ****************************************
%
% Float placement parameters.  See LaTeX manual for their definition.
%
\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.
%      NUMBER : Figure or table number--e.g., 'Figure 3.2'
%      TEXT   : The caption text.
%  Macro should be called inside a \parbox of right width, with
%  \normalsize.
% changed 25 Jun 86 to fix according to Howard Trickey:
% instead of \unhbox\@tempboxa\par we do #1: #2\par

% 15 Nov 93: further changes to support captions BEFORE the figure
% or table.  Changes suggested by Donald Arseneau, installed by Ethan
% Munson.  Detailed reasons are:
%	The \unhbox allows \vadjust material (\vspace) to get out;
%	the \vbox to\topskip{} is for captions at the top of top-floats;
%	the \ifdim is for captions above the figure or table;
%	the strut is for tables below the caption.

\long\def\@makecaption#1#2{% Add space only if something is ...
   \par\ifdim\prevdepth>-\p@ \vskip 10\p@\relax \fi % above the caption
   \setbox\@tempboxa\hbox{\vbox to\topskip{}#1: #2\unskip\strut}% 
   \ifdim \wd\@tempboxa >\hsize      % IF longer than one line:
       {\ssp#1: #2\unskip\strut\par} %   THEN set as ordinary paragraph.
     \else                           %   ELSE  center.
       \hbox to\hsize{\hfil\unhbox\@tempboxa\hfil}%
   \fi}

% To define a float of type TYPE (e.g., TYPE = figure), the document
% style must define the following.
%
%  \fps@TYPE   : The default placement specifier for floats of type
%                TYPE.
%
% \ftype@TYPE : The type number for floats of type TYPE.  Each TYPE
%                has associated a unique positive TYPE NUMBER, which
%                is a power of two.  E.g., figures might have type
%                number 1, tables type number 2, programs type number
%                4, etc.
%
% \ext@TYPE : The file extension indicating the file on which the
%                contents list for float type TYPE is stored.  For
%                example, \ext@figure = 'lof'.
%
%  \fnum@TYPE  : A macro to generate the figure number for a caption.
%                For example, \fnum@TYPE == Figure \thefigure.
%
%  The actual float-making environment commands--e.g., the commands
%  \figure and \endfigure--are defined in terms of the macros \@float
%  and \end@float, which are described below.
%
% \@float{TYPE}[PLACEMENT] : Macro to begin a float environment for a
%     single-column float of type TYPE with PLACEMENT as the placement
%     specifier.  The default value of PLACEMENT is defined by
%     \fps@TYPE.  The environment is ended by \end@float.  E.g.,
%     \figure == \@float{figure}, \endfigure == \end@float.


% FIGURE

\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}

\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\def\figure{\@float{figure}}
\let\endfigure\end@float
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}

% TABLE
%
\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\def\table{\@float{table}}
\let\endtable\end@float
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}


%    ****************************************
%    *            PAGE STYLES               *
%    ****************************************
%
% The page style 'foo' is defined by defining the command \ps@foo.  This
% command should make only local definitions.  There should be no stray
% spaces in the definition, since they could lead to mysterious extra
% spaces in the output.
%
% The \ps@... command defines the macros \@oddhead, \@oddfoot,
% \@evenhead, and \@evenfoot to define the running heads and
% feet---e.g., \@oddhead is the macro to produce the contents of the
% heading box for odd-numbered pages.  It is called inside an \hbox of
% width \textwidth.
%
% To make headings determined by the sectioning commands, the page style
% defines the commands \chaptermark, \sectionmark, ... , where
% \chaptermark{TEXT} is called by \chapter to set a mark, and so on.
% The \...mark commands and the \...head macros are defined with the
% help of the following macros.  (All the \...mark commands should be
% initialized to no-ops.)
%
% MARKING CONVENTIONS:
% LaTeX extends TeX's \mark facility by producing two kinds of marks
% a 'left' and a 'right' mark, using the following commands:
%     \markboth{LEFT}{RIGHT} : Adds both marks.
%     \markright{RIGHT}      : Adds a 'right' mark.
%     \leftmark  : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'left' mark.
%                  Works like TeX's \botmark command.
%     \rightmark : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'right' mark.
%                  Works like TeX's \firstmark command.
% The marking commands work reasonably well for right marks 'numbered
% within' left marks--e.g., the left mark is changed by a \chapter
% command and the right mark is changed by a \section command.  However,
% it does produce somewhat anomalous results if two \bothmark's occur on
% the same page.
%
%
% Commands like \tableofcontents that should set the marks in some
% page styles use a \@mkboth command, which is \let by the pagestyle
% command (\ps@...)  to \markboth for setting the heading or
% \@gobbletwo to do nothing.

\mark{{}{}}   % Initializes TeX's marks

% \ps@empty defined in LATEX.TEX

% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%
% 91/03/26 FMi: Added extra set of braces arround |\sl| in |\@oddhead|
% to support NFSS (|\sl| is a shape |\rm| a family). Also remove
% unnecessary |\hbox{}| commands.
%
% 94/11/3 BBF: Eliminated two letter font selection commands \rm and \sl
% in favor of \rmfamily and \slshape.
%


\def\ps@headings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}%     No feet.
%\def\@oddhead{{\slshape \rightmark}\hfil \rmfamily\thepage}% Heading.
\def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
  \@chapapp\ \thechapter. \ \fi ##1}}}}

% Definition of 'myheadings' page style.
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
 %\def\@oddhead{{\slshape\rightmark}\hfil \rmfamily\thepage}%
 %\def\@oddfoot{}\def\@evenhead{\rmfamily \thepage\hfil\slshape\leftmark}%
 \def\@evenfoot{}\def\chaptermark##1{}\def\sectionmark##1{}%
 \def\subsectionmark##1{}}

% Definition of 'plain' page style.
%
\def\ps@plain{\let\@mkboth\markboth%
\def\@oddfoot{\hbox{}\hfil\rmfamily\thepage\hfil\hbox{}}% Pgno bot center
\def\@evenfoot{\hbox{}\hfil\rmfamily\thepage\hfil\hbox{}}% 
\def\@oddhead{}% heading (right)
\def\@evenhead{}% heading (left)
%\pagenumbering{arabic}}					% (WBB)
}

% Definition of 'thesis' page style.
%
\def\ps@thesis{\let\@mkboth\markboth
\def\@oddfoot{\hbox{}\hfil\rmfamily\thepage\hfil\hbox{}}% Pgno bot center
\def\@evenfoot{\hbox{}\hfil\rmfamily\thepage\hfil\hbox{}}% 
\def\@oddhead{}		% heading (right)
\def\@evenhead{}}		% heading (left)
%\pagenumbering{arabic}}					% (WBB)

% Definition of 'preliminary' page style.
%
\def\ps@preliminary{\let\@mkboth\@gobbletwo
     \def\@oddhead{}\def\@oddfoot{\rmfamily\hfil\thepage
     \hfil}\def\@evenhead{}\let\@evenfoot\@oddfoot
%     \pagenumbering{roman}
}


% Definition of 'facing caption' page style
% This is a left-hand page, and so everything is mirror-imaged:
% page numbering and margins
%

\def\ps@facingcap{\let\@mkboth\@gobbletwo
     \def\@oddhead{\rmfamily\thepage\hfil} \def\oddfoot{}
     \let\@evenhead\@oddhead \def\@evenfoot{}
     \oddsidemargin 0in \let\evensidemargin\oddsidemargin
}


%    ****************************************
%    *            MISCELLANEOUS             *
%    ****************************************
%
% DATE
%
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

% EQUATION and EQNARRAY -- put here because it must follow \chapter
% definition
%
% \newcounter{equation}
%
\@addtoreset{equation}{chapter}   % Makes \chapter reset 'equation'
                                  % counter.

\def\theequation{\thechapter.\arabic{equation}}

% \jot = 3pt      % Extra space added between lines of an eqnarray
                  % environment

% The macro \@eqnnum defines how equation numbers are to appear in
% equations.
%
% \def\@eqnnum{(\theequation)}
%


%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

\ps@thesis                   % 'thesis' page style
\pagenumbering{arabic}      % Arabic page numbers
\raggedbottom % Ragged bottom unless twoside
                                 % option.
\if@twocolumn
 \@@input twocolum.sty\relax
\else
 \onecolumn                 % Single-column.
\fi

\endinput

