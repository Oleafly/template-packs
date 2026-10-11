
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dukethesis}[Duke Thesis Style]

% Duke thesis document style, based on report class. Designed
% to conform with current (as of 1 July 2004) Graduate School
% guidelines. Code excerpted from dukethesis.cls and switched
% to load report.cls for defaults. Removed non-required code
% that would better be in a style file (and i'm not sure if 
% anyone uses). As such, it is mostly, but not completely,
% backward compatible.
%
% v1.0 2004 Rajiv Wickremesinghe (rw) @ Duke University
%


% $Id: dukethesis2004.cls,v 1.2 2005/11/27 18:35:16 mrli Exp $

%
% comments from dukethesis.cls follow -rw
%

%  This is the Duke Thesis document style, adapted from the Wisconsin 
%  version brought in by Mark Holliday.  Adapted by Charlie Martin and
%  Russ Tuck, and later adapted by Sean O'Connell and Michael Todd to
%  conform to the most recent graduate school requirements.
%  [subsequently modified by Syam Gadde (gadde@cs.duke.edu), 7/98-11/98]
%  [subsequently modified by Rajiv Wickremesinghe (rajiv@cs.duke.edu). 4/01]
%
%  adapted from:
%     REPORT DOCUMENT STYLE -- version 0.91 - released 27 January 1985
%        for LaTeX version 2.08 Copyright (C) 1985 by Leslie Lamport
%
%  Feb 6 1986 - William K. Kalsow
%
%  Changes by Russ Tuck (Dec. 3-11, 1986):
%       changed bibliography so it is included in the table of contents
%       added \newblock definition and 2 more lines to Bibliography, 
%               from report.sty
%       reworded copyright notice
%       rewrote title page handling entirely; includes AM, MS, and PhD options.
%
%  Modified to (hopefully) be a correct class file  
%   April 2001 - Rajiv Wickremesinghe
%
%  Further changes by Sean O'Connell and Michael Todd (July 8-10, 1996):
%  (1) All page numbers appear at the bottom center of each page, 1'' from
%      the bottom edge
%  (2) The 'abstract' page now starts at page 'iv', assuming that a copyright
%      page is included
%  (3) The 'biography' page is now added in the same way as the 
%      acknowledgements, etc., pages, by using the \biography command
%  (4) Default spacing is now double-spaced everywhere, with appropriate 
%      single-spacing in the table of contents, lists, the biography, etc.,
%      in accordance with all graduate school requirements
%  (5) Run-over lines in the table of contents are properly spaced and 
%      indented
%  (6) The signature lines in the title pages were centered
%  (7) Figure/table labels within the figure/table captions are bold-faced
%  (8) MARGINS: top 1"
%               bottom 1"
%               right 1"
%               left 1.5"
%  (9) Altered "look" of start of chapter:
%      following changes avoid messing with short pages and all the evils
%      associated with them
%      -- Chapter n is at top
%      -- 20pt gap between it and title
%      -- 20pt gap between title and text
% (10) Bibliograpy double-spaced between entries with single-spacing within
%      a given entry.



\typeout{-----------------------------------------------------------------}
\typeout{Document Class `dukethesis2004'.}
%\typeout{}
%\typeout{Revisions made in July, 1996, by Sean O'Connell and Michael
%  Todd} \typeout{ from the Dept. of Mechanical Engineering.}
%\typeout{Don't bother reporting problems; however, any praise and }
%\typeout{ adulation may be sent to sto@me1.egr.duke.edu }
%\typeout{Some modifications made by gadde@cs.duke.edu, who doesn't want }
%\typeout{ to spend any more time with .cls files than absolutely necessary. }
%\typeout{Some more hacks made by rajiv@cs.duke.edu to get this to work }
%\typeout{ with other packages. }
\typeout{-----------------------------------------------------------------}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Default is double spaced text
% openup "adds space between lines"
% a "jot" is 3pt
\newcommand{\textspace}{\openup 3\jot\relax}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECLARE OPTIONS
%
% Define three switches: \ifAM, \ifMS, and \ifPhD.  At most one must be
% true when the title page is actually printed.  
% One is normally set true by specifying an optional 
% \documentstyle parameter, one of: AM, MS, PhD. 
% We use a default of PhD below
%
%----------------------------------------------------------------------
\newif\ifAM  \AMfalse
\newif\ifMS  \MSfalse
\newif\ifPhD \PhDfalse
\newif\ifPrelim \Prelimfalse

%----------------------------------------------------------------------
\DeclareOption{prelim}{
        \PhDfalse
        \Prelimtrue
}
\DeclareOption{PhD}{
        \PhDtrue
}
\DeclareOption{MS}{
        \PhDfalse
        \MStrue
}
\DeclareOption{AM}{
        \PhDfalse
        \MStrue
}
\DeclareOption{singlespace}{
        \renewcommand{\textspace}{\relax}
}

\ExecuteOptions{PhD}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
%\ExecuteOptions{12pt}
\ProcessOptions

\LoadClass[12pt]{report}[1994/06/01]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN CODE


%----------------------------------------------------------------------
%  draft option
%
% \overfullrule = 0pt                % Default is don't mark overfull hboxes.
\def\versiontag{}                    % Default is NO tag
\def\ds@draft{
        %%% -- DRAFT is double spaced -- \def\textspace{}  % Single spaced text
        \overfullrule 5pt % Causes overfull hboxes to be marked.
        \def\versiontag{{\normalsize\rm - DRAFT \number\month/\number\day{} -}}
}

%----------------------------------------------------------------------
%
%  ****************************************
%  *               FONTS                  *
%  ****************************************
%
%----------------------------------------------------------------------
\setlength\lineskip{1\p@}           % \lineskip is 1pt for all font sizes.
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{1}

%----------------------------------------------------------------------
% Each size-changing command \SIZE executes the command
% \fontsize{textsize}{baselineskip}
%    (baselineskip will be multiplied by \baselinestretch.)
%
% For reasons of efficiency that needn't concern the designer,
% the document style defines \@normalsize instead of \normalsize .  This is
% done only for \normalsize, not for any other size-changing commands.
% this is wierd -RW
% already done in size12.clo -RW
%----------------------------------------------------------------------

% \newcommand{\@normalsize}{
%   \fontsize{12}{14.5}\selectfont
%   \abovedisplayskip 12pt plus3pt minus7pt%
%   \belowdisplayskip \abovedisplayskip
%   \abovedisplayshortskip  \z@ plus3pt%
%   \belowdisplayshortskip  6.5pt plus3.5pt minus3pt
% }

% \renewcommand{\small}{
%         \fontsize{11}{13.6}\selectfont
%         \abovedisplayskip 11pt plus3pt minus6pt%
%         \belowdisplayskip \abovedisplayskip
%         \abovedisplayshortskip  \z@ plus3pt%
%         \belowdisplayshortskip  6.5pt plus3.5pt minus3pt
%         \def\@listi{
%                 \parsep 4.5pt plus 2pt minus 1pt
%                 \itemsep \parsep
%                 \topsep 9pt plus 3pt minus 5pt
%         }
% }

% \renewcommand{\footnotesize}{
%         \fontsize{10}{12}\selectfont
%         \abovedisplayskip 10pt plus2pt minus5pt%
%         \belowdisplayskip \abovedisplayskip
%         \abovedisplayshortskip  \z@ plus3pt%
%         \belowdisplayshortskip  6pt plus3pt minus3pt
%         \def\@listi{
%                 \topsep 6pt plus 2pt minus 2pt\parsep 3pt plus 2pt minus 1pt
%                 \itemsep \parsep
%         }
% }

% \renewcommand{\scriptsize}{\fontsize{8}{9.5}\selectfont}
% \renewcommand{\tiny}{\fontsize{6}{7}\selectfont}
% \renewcommand{\large}{\fontsize{14}{18}\selectfont}
% \renewcommand{\Large}{\fontsize{17}{22}\selectfont}
% \renewcommand{\LARGE}{\fontsize{20}{25}\selectfont}
% \renewcommand{\huge}{\fontsize{25}{30}\selectfont}
% \renewcommand{\Huge}{\huge}

% \normalsize  % Choose the normalsize font.

%--------------------------------------------------------------------------
%
%  ****************************************
%  *            PAGE LAYOUT               *
%  ****************************************
%
% Margins are 1 inch on all sides, except left, which is 1.5 inches.
%
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% MARGINS:
%--------------------------------------------------------------------------

%----------------------------------------------------------------------
% VERTICAL SPACING: Modified 24 Nov 87 CRM
% \topmargin 0pt vice 20pt
%----------------------------------------------------------------------
                        % Top of page:
\topmargin 0pt          %    Nominal distance from top of page to top of
                        %    box containing running head.
\headheight 0pt        % (12)   Height of box containing running head.
%\headheight 14pt        % (12)   Height of box containing running head.
\headsep 5pt           % (25)   Space between running head and text.
% \topskip = 10pt       %    '\baselineskip' for first line of page.
                        % Bottom of page:

%\footheight 12pt        %    Height of box containing running foot. OBSOLETE
\footskip 25pt %18pt     %    Distance from baseline of box containing foot
                         %    to baseline of last line of text.

%----------------------------------------------------------------------
% DIMENSION OF TEXT:
%
%  8 Sept 87 -- changed the page sizes for new style req't
%  crm@duke.
%----------------------------------------------------------------------
\textheight 620pt       % Height of text (including footnotes and figures,
                        % excluding running head and foot). 635 vice
                        % (588)
\textwidth 432pt        % Width of text line. 400 vice 430
                        % For two-column mode:
\columnsep 10pt         %    Space between columns
\columnseprule 0pt      %    Width of rule between columns.

%----------------------------------------------------------------------
% A \raggedbottom command causes 'ragged bottom' pages: pages set to
% natural height instead of being stretched to exactly \textheight.
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% FOOTNOTES:
%----------------------------------------------------------------------

\footnotesep 14pt    % Height of strut placed at the beginning of every
                     % footnote.
\skip\footins 8pt plus 2pt minus 4pt  % Space between last line of text and
                                      % top of first footnote.

%----------------------------------------------------------------------
%
% FLOATS: (a float is something like a figure or table)
%
%  FOR FLOATS ON A TEXT PAGE:
%
%----------------------------------------------------------------------
\floatsep 14pt plus 2pt minus 4pt        % Space between adjacent floats moved
                                         % to top or bottom of text page.
\textfloatsep 20pt plus 6pt minus 4pt    % Space between main text and floats
                                         % at top or bottom of page.
\intextsep 14pt plus 4pt minus 4pt       % Space between in-text figures and
                                         % text.
%\@maxsep 20pt                            % The maximum of \floatsep,
                                         % \textfloatsep and \intextsep (minus
                                         % the stretch and shrink). OBSOLETE

%----------------------------------------------------------------------
%  FOR FLOATS ON A SEPARATE FLOAT PAGE:
%----------------------------------------------------------------------
\@fptop 0pt plus 1fil   % Stretch at top of float pg. (Must be 0pt plus ...)
\@fpsep 10pt plus 2fil  % Space between floats on float page.
\@fpbot 0pt plus 1fil   % Stretch at bottom of float pg.(Must be 0pt plus ... )

%----------------------------------------------------------------------
%
% MARGINAL NOTES:
%
%----------------------------------------------------------------------
\marginparpush 7pt       % Minimum vertical separation between two marginal
                         % notes.

%----------------------------------------------------------------------
%
%  ****************************************
%  *           PARAGRAPHING               *
%  ****************************************
%
%----------------------------------------------------------------------
\parskip 2pt plus 1pt minus 1pt    % Extra vertical space between paragraphs.
\parindent 1.5em                   % Width of paragraph indentation.
\topsep 10pt plus 4pt minus 6pt    % Extra vertical space, in addition to
                                   % \parskip, added above and below list and
                                   % paragraphing environments.
\partopsep 3pt plus 2pt minus 2pt  % Extra vertical space, in addition to
                                   % \parskip and \topsep, added when user
                                   % leaves blank line before environment.
\itemsep 5pt plus 2.5pt minus 1pt  % Extra vertical space, in addition to
                                   % \parskip, added between list items.

%----------------------------------------------------------------------
% The following page-breaking penalties are defined
%----------------------------------------------------------------------
\@lowpenalty   51      % Produced by \nopagebreak[1] or \nolinebreak[1]
\@medpenalty  151      % Produced by \nopagebreak[2] or \nolinebreak[2]
\@highpenalty 301      % Produced by \nopagebreak[3] or \nolinebreak[3]

\@beginparpenalty -\@lowpenalty    % Before a list or paragraph environment.
\@endparpenalty   -\@lowpenalty    % After a list or paragraph environment.
\@itempenalty     -\@lowpenalty    % Between list items.

% \clubpenalty         % 'Club line'  at bottom of page.
% \widowpenalty        % 'Widow line' at top of page.
% \displaywidowpenalty % Math display widow line.
% \predisplaypenalty   % Breaking before a math display.
% \postdisplaypenalty  % Breaking after a math display.
% \interlinepenalty    % Breaking at a line within a paragraph.
% \brokenpenalty       % Breaking after a hyphenated line.

%----------------------------------------------------------------------
%
%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
% DEFINE COUNTERS:
%
% \newcounter{NEWCTR}[OLDCTR] : Defines NEWCTR to be a counter, which is
%                               reset to zero when counter OLDCTR is stepped.
%                               Counter OLDCTR must already be defined.
%
%----------------------------------------------------------------------
%% \newcounter{chapter} 
%% \newcounter{section}[chapter] 
%% \newcounter{subsection}[section]
%% \newcounter{subsubsection}[subsection]
%% \newcounter{paragraph}[subsubsection]
%% \newcounter{subparagraph}[paragraph]

%----------------------------------------------------------------------
% For any counter CTR, \theCTR is a macro that defines the printed version
% of counter CTR.  It is defined in terms of the following macros:
%
%  \arabic{COUNTER} : The value of COUNTER printed as an arabic numeral.
%  \roman{COUNTER}  : Its value printed as a lower-case roman numberal.
%  \Roman{COUNTER}  : Its value printed as an upper-case roman numberal.
%  \alph{COUNTER}   : Value of COUNTER printed as a lower-case letter:
%                         1 = a, 2 = b, etc.
%  \Alph{COUNTER}   : Value of COUNTER printed as an upper-case letter:
%                           1 = A, 2 = B, etc.
%
%--------------------------------------------------------------------------
% same as book.cls -RW
%% \renewcommand\thechapter       {\arabic{chapter}}
%% \renewcommand\thesection       {\thechapter.\arabic{section}}
%% \renewcommand\thesubsection    {\thesection.\arabic{subsection}}
%% \renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
%% \renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
%% \renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

%----------------------------------------------------------------------
%
% \@chapapp is initially defined to be 'Chapter'.  The \appendix
% command redefines it to be 'Appendix'.
%
%----------------------------------------------------------------------
%\def\@chapapp{Chapter}

%----------------------------------------------------------------------
%
% \@makechapterhead {TEXT} : Makes the heading for the \chapter command.
%
%----------------------------------------------------------------------
%\newlength{\@chapwidth}
%\newlength{\@chaptitlewidth}
\def\@makechapterhead#1{             % Heading for \chapter command
  { \parindent 0pt \raggedright
    \ifnum \c@secnumdepth >\m@ne     % IF secnumdepth > -1 THEN
      \LARGE\bf \@chapapp{} \thechapter % Print 'Chapter' and number.
      \par
      \vskip 20pt \fi                  % Space between number and title.
    \LARGE \bf                        % Title.
    #1\par
    \nobreak                         % TeX penalty to prevent page break.
    \vskip 20pt                      % Space between title and text.
  }
  %\advance\@colht-\footskip          % tell LaTeX to build a shorter page!
  \pagegoal\@colht                   % let TeX in on what's happening
  }

%----------------------------------------------------------------------
%
% \@makeschapterhead {TEXT} : Makes the heading for the \chapter* command.
%
%----------------------------------------------------------------------
\def\@makeschapterhead#1{             % Heading for \chapter* command
  { \parindent 0pt \raggedright
%    \LARGE \bf                        % Title.
    \Large \bf                        % Title.
    #1\par
    \nobreak                         % TeX penalty to prevent page break.
    \vskip 20pt                      % Space between title and text.
  } }

%----------------------------------------------------------------------
%
% \secdef{UNSTARCMDS}{STARCMDS} :
%    When defining a \chapter or \section command without using
%    \@startsection, you can use \secdef as follows:
%       \def\chapter { ... \secdef \CMDA \CMDB }
%       \def\CMDA    [#1]#2{ ...   % Command to define \chapter[...]{...}
%       \def\CMDB    #1{ ...       % Command to define \chapter*{...}
%
%----------------------------------------------------------------------
\renewcommand\chapter{
%        \renewcommand{\currentclassname}{chapter\xspace} % Added by Syam Gadde.
        \clearpage                 % Starts new page.
        \thispagestyle{headings}   % Page style of chapter page is 'headings'
        \global\@topnum\z@         % Prevents figures from going at top of page.
        \@afterindentfalse         % Suppresses indent in first paragraph.
        \secdef\@chapter\@schapter %Change to \@afterindenttrue to have indent.
}

%% \def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
%%         \refstepcounter{chapter}
%%         \typeout{\@chapapp\space\the\c@chapter.}
%%         \addcontentsline{toc}{chapter}{\protect
%%         \numberline{\thechapter}#1}\else
%%         \addcontentsline{toc}{chapter}{#1}\fi
%%    \chaptermark{#1}
%%    \addtocontents{lof}{\protect} % Adds between-chapter space
%%    \addtocontents{lot}{\protect} % to lists of figs & tables.
%%    \@makechapterhead{#2}
%%    \@afterheading                  % Routine called after chapter and
%% }                                  % section heading.

\def\@schapter#1{
        \@makeschapterhead{#1} \@afterheading
}

\def\pchapter#1{%% A preliminary chapter
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}
        \thispagestyle{plain}
        \typeout{#1}
}

%----------------------------------------------------------------------
%
% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
%            optional * [ALTHEADING]{HEADING}
%    Generic command to start a section.
%    NAME       : e.g., 'subsection'
%    LEVEL      : a number, denoting depth of section -- e.g., chapter=1,
%                 section = 2, etc.  A section number will be printed if
%                 and only if LEVEL < or = the value of the secnumdepth
%                 counter.
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
%
%----------------------------------------------------------------------
% same as book.cls, excl \currentclassname refs
%% \renewcommand\section{
%%   \renewcommand{\currentclassname}{section\xspace} % Added by Syam Gadde.
%%   \@startsection {section}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}%
%%   {2.3ex plus .2ex}{\large\bf}
%% }

%% \renewcommand\subsection{
%%   \renewcommand{\currentclassname}{subsection\xspace} % Added by Syam Gadde.
%%   \@startsection{subsection}{2}{\z@}{-3.25ex plus -1ex minus -.2ex}%
%%   {1.5ex plus .2ex}{\normalsize\bf}
%% }

%% \renewcommand\subsubsection{
%%   \renewcommand{\currentclassname}{subsection\xspace} % Added by Syam Gadde.
%%   \@startsection{subsubsection}{3}{\z@}{-3.25ex plus -1ex minus -.2ex}%
%%   {1.5ex plus .2ex}{\normalsize\bf}
%% }

%% \renewcommand\paragraph{
%%   \renewcommand{\currentclassname}{subsection\xspace} % Added by Syam Gadde.
%%   \@startsection{paragraph}{4}{\z@}{3.25ex plus 1ex minus .2ex}%
%%   {-1em}{\normalsize\it}
%% }

%% \renewcommand\subparagraph{
%%   \renewcommand{\currentclassname}{subsection\xspace} % Added by Syam Gadde.
%%   \@startsection{subparagraph}{4}{\parindent}{3.25ex plus 1ex minus .2ex}%
%%   {-1em}{\normalsize\it}
%% }

%----------------------------------------------------------------------
% Default initializations of \...mark commands.  (See below for their
% uses in defining page styles.
%----------------------------------------------------------------------
%\def\chaptermark#1{}
%\newcommand*\chaptermark[1]{}
% \def\sectionmark#1{}           % Preloaded definitions
% \def\subsectionmark#1{}
% \def\subsubsectionmark#1{}
% \def\paragraphmark#1{}
% \def\subparagraphmark#1{}

%--------------------------------------------------------------------------
% The value of the counter secnumdepth gives the depth of the
% highest-level sectioning command that is to produce section numbers.
%--------------------------------------------------------------------------
%\setcounter{secnumdepth}{2}

%--------------------------------------------------------------------------
%
% COPYRIGHT
%
%--------------------------------------------------------------------------
\def\Copyright{
        \CopRtrue               % count the page
        \typeout{Copyright}
        \newpage\thispagestyle{empty}\null\vfil
        \vskip 0.75\textheight
        \begin{center}
                \def\thanks##1{} % temporarily kill any thanks lines
                {\large Copyright \copyright\ \number\year\ by \@author\par}
                {\large All rights reserved \par}
        \end{center}
        \par\vfil\null\newpage
}

\def\PublicDomain{
        \CopRtrue               % count the page
        \newpage\thispagestyle{empty}\null\vfil
        \vskip 0.75\textheight
        \begin{center}
                \def\thanks##1{} % temporarily kill any thanks lines
                {\large This document is in the public domain.\par}
        \end{center}
        \par\vfil\null\newpage
}

%----------------------------------------------------------------------
%
% ABSTRACT
%
%   - this produces pages suitable for a UW-Abstract
%
%----------------------------------------------------------------------
\def\abstract{
        \textspace
        \ifAbstractP
                \ifCopR
                        \setcounter{page}{4}
                \else
                        \setcounter{page}{3}
                \fi
        \else
                \ifCopR
                        \setcounter{page}{3}
                \else
                        \setcounter{page}{2}
                \fi
        \fi
        \pchapter{Abstract}
}

%----------------------------------------------------------------------
%
%  UNIV. Microfilms abstract
%
%----------------------------------------------------------------------
\def\UMIabstract{
        \titlepage\pagestyle{empty}
        \openup 2.75\jot % double spaced
        \begin{center}
                \def\thanks##1{} % temporarily kill any thanks lines
                {\large \expandafter{\@title} \par}
                {\large\lineskip .75em\begin{tabular}[t]{c}{\@author}\end{tabular}\par}
                {\large Under the supervision of Professor \@advisor \par}
                \vskip 1.5em
        \end{center}
}

%----------------------------------------------------------------------
%
% ACKNOWLEDGEMENTS
%
%----------------------------------------------------------------------
\def\acknowledgements{
        \pchapter{Acknowledgements}
}

%----------------------------------------------------------------------
%
% CHAPTERS
%
%----------------------------------------------------------------------
\newcommand{\chapters}
           {\normalbaselines
             \newpage
             \textspace
             \pagenumbering{arabic}}

%----------------------------------------------------------------------
%
% APPENDIX
%
% The \appendix command must do the following:
%    -- reset the chapter counter to zero
%    -- set \@chapapp to Appendix (for messages)
%    -- redefine the chapter counter to produce appendix numbers
%    -- reset the section counter to zero
%    -- redefine the \chapter command if appendix titles and headings are
%       to look different from chapter titles and headings.
%
%----------------------------------------------------------------------
\renewcommand{\appendix}
           {\par
             \setcounter{chapter}{0}
             \setcounter{section}{0}
             \def\@chapapp{Appendix}
             \def\thechapter{\Alph{chapter}}}

%----------------------------------------------------------------------
%
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
%
%----------------------------------------------------------------------
%\leftmargini 2.5em
%\leftmarginii 2.2em     % > \labelsep + width of '(m)'
%\leftmarginiii 1.87em   % > \labelsep + width of 'vii.'
%\leftmarginiv 1.7em     % > \labelsep + width of 'M.'
%\leftmarginv 1em
%\leftmarginvi 1em

%\leftmargin\leftmargini
\labelwidth\leftmargini\advance\labelwidth-\labelsep
%\labelsep .5em
\parsep 5pt plus 2.5pt minus 1pt

\def\@listi{
        \leftmargin\leftmargini
}

\def\@listii{
        \leftmargin\leftmarginii
        \labelwidth\leftmarginii\advance\labelwidth-\labelsep
        \topsep 5pt plus 2.5pt minus 1pt
        \parsep 2.5pt plus 1pt minus 1pt
        \itemsep \parsep
}

\def\@listiii{
        \leftmargin\leftmarginiii
        \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
        \topsep 2.5pt plus 1pt minus 1pt
        \parsep \z@ \partopsep 1pt plus 0pt minus 1pt
        \itemsep \topsep
}

\def\@listiv{
        \leftmargin\leftmarginiv
        \labelwidth\leftmarginiv\advance\labelwidth-\labelsep
}

\def\@listv{
        \leftmargin\leftmarginv
        \labelwidth\leftmarginv\advance\labelwidth-\labelsep
}

\def\@listvi{
        \leftmargin\leftmarginvi
        \labelwidth\leftmarginvi\advance\labelwidth-\labelsep
}

%----------------------------------------------------------------------
%
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
%----------------------------------------------------------------------

% not sure about killing this next part xbegin rw
%
%% \def\labelenumi{\arabic{enumi}.}
%% \def\theenumi{\arabic{enumi}}

%% \def\labelenumii{(\alph{enumii})}
%% \def\theenumii{\alph{enumii}}
%% \def\p@enumii{\theenumi}

%% \def\labelenumiii{\roman{enumiii}.}
%% \def\theenumiii{\roman{enumiii}}
%% \def\p@enumiii{\theenumi(\theenumii)}

%% \def\labelenumiv{\Alph{enumiv}.}
%% \def\theenumiv{\Alph{enumiv}}
%% \def\p@enumiv{\p@enumiii\theenumiii}
% xend rw

%----------------------------------------------------------------------
%
% ITEMIZE
% Itemization is controlled by four commands: \labelitemi, \labelitemii,
% \labelitemiii, and \labelitemiv, which define the labels of the various
% itemization levels.
%
%----------------------------------------------------------------------
%% \def\labelitemi{$\bullet$}
%% \def\labelitemii{\bf --}
%% \def\labelitemiii{$\ast$}
%% \def\labelitemiv{$\cdot$}

%----------------------------------------------------------------------
%
% VERSE
%   The verse environment is defined by making clever use of the
%   list environment's parameters.  The user types \\ to end a line.
%   This is implemented by \let'in \\ equal \@centercr.
%
%----------------------------------------------------------------------
%% \def\verse{
%%         \let\\=\@centercr
%%         \list{}{\itemsep\z@ \itemindent -1.5em\listparindent \itemindent
%%         \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]
%% }
%% \let\endverse\endlist

%----------------------------------------------------------------------
%
% QUOTATION
%   Fills lines
%   Indents paragraph
%
%----------------------------------------------------------------------
%% \renewenvironment{quotation}
%%                {\list{}{\listparindent 1.5em
%%                         \itemindent\listparindent
%%                         \rightmargin\leftmargin
%%                         \parsep 0pt plus 1pt}
%%                 \item\relax}
%%                {\endlist}

%----------------------------------------------------------------------
%
% QUOTE -- same as quotation except no paragraph indentation,
%
%----------------------------------------------------------------------
%% \renewenvironment{quote}
%%                {\list{}{\rightmargin\leftmargin}\item\relax}
%%                {\endlist}

% DESCRIPTION
%
%  To change the formatting of the label, you must redefine
%  \descriptionlabel.
%----------------------------------------------------------------------
%% \renewcommand*{\descriptionlabel}[1]{\hspace\labelsep \bf #1}
%% \renewenvironment{description}
%%                {\list{}{\labelwidth\z@ \itemindent-\leftmargin
%%                    \let\makelabel\descriptionlabel}}
%%                {\endlist}
% not clear if the following is used anywhere -RW
%\newdimen\descriptionmargin
%\setlength\descriptionmargin{3em}

%----------------------------------------------------------------------
%
%    ****************************************
%    *         OTHER ENVIRONMENTS           *
%    ****************************************
%
% THEOREM
% \@begintheorem ... \@endtheorem are the commands executed at the
% beginning and end of a (user-defined) theorem-like environment.
%
%----------------------------------------------------------------------
\def\@begintheorem#1#2{\it \trivlist \item[\hskip \labelsep{\bf #1\ #2}]}

\def\@endtheorem{\endtrivlist}

%----------------------------------------------------------------------
%
% EQUATION and EQNARRAY -- must follow \chapter definition
%
% \newcounter{equation}
%
%----------------------------------------------------------------------
\@addtoreset{equation}{chapter}   % Makes \chapter reset 'equation' counter.

\def\theequation{\thechapter.\arabic{equation}}

% \jot = 3pt      % Extra space added between lines of an eqnarray environment

%----------------------------------------------------------------------
%
% The macro \@eqnnum defines how equation numbers are to appear in equations.
%
% \def\@eqnnum{(\theequation)}
%
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%
% TITLEPAGE
%  In the normal environments, the titlepage environment does nothing but
%  start and end a page, and inhibit page numbers.  It also resets the
%  page number to zero.
%
%----------------------------------------------------------------------
\renewenvironment{titlepage}
               {\newpage\thispagestyle{empty}
                 \setcounter{page}{\z@}} % should it be \@ne ? -RW
               {\newpage}

% defeat the setting to 0 of the page number for abstract pages.
\newenvironment{abstractpage}
               {\newpage}
               {\newpage}

%----------------------------------------------------------------------
%
% CODE
%  The code environment is essentially a 'quote'd verbatim environment.
%     \begin{code} ... \end{code}
%          ==>  {\quote\verbatim ... \endverbatim\endquote}
%  Page breaks are discouraged by \interlinepenalty=150.
%
%----------------------------------------------------------------------
\begingroup \catcode `|=0 \catcode `[=1
\catcode`]=2 \catcode`\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xcode#1\end{code}[#1|end[code]]
|endgroup
\newenvironment{code}
               {\par\list{}
                 {\parskip 0pt plus 1pt\normalbaselines\interlinepenalty=150}
               \item\relax\@verbatim\frenchspacing\@vobeyspaces\@xcode}
               {\endtrivlist\endlist}

%----------------------------------------------------------------------
%
% PROC
%  The proc environment is a 'quoted' tabbing environment with tabs set
%  at fixed distances
%  Page breaks are discouraged by \interlinepenalty=150.
%
%----------------------------------------------------------------------
\def\proctabs{\qquad\=\qquad\=\qquad\=\qquad\=\qquad\=\qquad\=\qquad\=\kill}
\newenvironment{proc}{
        \quote\interlinepenalty=150\relax\tt\tabbing\proctabs}
        {\endtabbing\endquote\leavevmode}

%----------------------------------------------------------------------
%
% ARRAY AND TABULAR
%
%----------------------------------------------------------------------
\arraycolsep 5pt     % Half the space between columns in an array environment.
\tabcolsep 6pt       % Half the space between columns in a tabular environment.
\arrayrulewidth .4pt % Width of rules in array and tabular environment.
\doublerulesep 2pt   % Space between adjacent rules in array or tabular env.

%----------------------------------------------------------------------
%
% TABBING
%
%----------------------------------------------------------------------
\tabbingsep \labelsep   % Space used by the \' command.  (See LaTeX manual.)

%----------------------------------------------------------------------
% MINIPAGE
%  \@minipagerestore is called upon entry to a minipage environment to
%  set up things that are to be handled differently inside a minipage
%  environment. In the current styles, it does nothing.
%
% \skip\@mpfootins : plays same role for footnotes in a minipage as
%                    \skip\footins does for ordinary footnotes
%----------------------------------------------------------------------
\skip\@mpfootins = \skip\footins

%----------------------------------------------------------------------
%
% FRAMEBOX
%
%----------------------------------------------------------------------
\fboxsep = 3pt    % Space left between box and text by \fbox and \framebox.
\fboxrule = .4pt  % Width of rules in box made by \fbox and \framebox.

%----------------------------------------------------------------------
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
% CAPTION is the figure caption.  It works similarly for a 'table' environment.
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
%    INDENT   : The indentation from the outer left margin of the start of
%               the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command.
%
% This command uses the following three parameters, which are set
% with a \def (so em's can be used to make them depend upon the font).
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for multiple line entries.  One
%                 wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be \def'd to
%                 a number like 2 or 1.7
%----------------------------------------------------------------------
\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}

%----------------------------------------------------------------------
%
% TABLEOFCONTENTS
%
%----------------------------------------------------------------------
\renewcommand{\tableofcontents}{
        \pagestyle{plain}
        \normalbaselines
        \chapter*{Contents}     %prevents inclusion in table of contents
        \thispagestyle{plain}
        \typeout{Table of Contents}
        \markboth{CONTENTS}{CONTENTS}
        \@starttoc{toc}
}

%----------------------------------------------------------------------
%  This definition is taken from LATEX.LTX for TEX 3.1415
%  ---> typical location /usr/local/lib/texmf/tex/latex2e/base/latex.ltx
%  ---> modified \@dottedtocline
%       1) added both \bf commands
%       2) replaced ... \@dotsep mu.\mkern... with ... \@dotsep mu \mkern... 
%          a) prevents dots --------------------------------------^
%----------------------------------------------------------------------
\def\@chtocline#1#2#3#4#5{
        \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\bf \leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
                \parindent #2\relax\@afterindenttrue
                \interlinepenalty\@M
                \leavevmode
                \@tempdima #3\relax
                \advance\leftskip \@tempdima \hbox{}\hskip -\leftskip
                {#4}\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu \mkern
                \@dotsep mu$
        }\hfill \nobreak
        \hbox to\@pnumwidth{%
        \hfil\reset@font\rmfamily \bf #5}\par}\fi
}
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%  The addvspace forces the double-spacing effect between entries even though
%  the Table of Contents is a single-spaced environment.
%----------------------------------------------------------------------
\def\l@chapter{{\protect}\@chtocline{0}{0em}{1.3em}}
\def\l@section{{\protect}\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{{\protect}\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{{\protect}\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

%----------------------------------------------------------------------
%
% LIST OF FIGURES
%
%----------------------------------------------------------------------
\renewcommand{\listoffigures}{
        \normalbaselines
        \pchapter{List of Figures}
        \markboth{LIST OF FIGURES}{LIST OF FIGURES}
        \@starttoc{lof}
}

\def\l@figure{{\protect}\@dottedtocline{1}{1.5em}{2.3em}}

%----------------------------------------------------------------------
%
% LIST OF TABLES
%
%----------------------------------------------------------------------
\renewcommand{\listoftables}{
        \normalbaselines
        \pchapter{List of Tables}
        \markboth{LIST OF TABLES}{LIST OF TABLES}
        \@starttoc{lot}
}

\let\l@table\l@figure

%----------------------------------------------------------------------
% BIOGRAPHY
%
% 1) added for ease ... prefer it to single-spaced!
%
%----------------------------------------------------------------------
\newcommand{\biography}{
        %\normalbaselines
        \pchapter{Biography}
}

%----------------------------------------------------------------------
%
% GREMLIN
%
%  \Gremlin{includefile}{width}{height}{F/E}
%     Warning: ignoring the Flyback/End option
%
%----------------------------------------------------------------------
%% \def\Gremlin#1#2#3#4{
%%         \leavevmode\hbox to #2{\vbox to #3{\special{#1}\vfil}\hfil}
%% }

%----------------------------------------------------------------------
%
%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
%  TEMPORARY DEFINITIONS:
%
%----------------------------------------------------------------------
\renewenvironment{thebibliography}[1]
{
        \normalbaselines
%        \def\itemsep{10pt} =====> Cause a lot of error messages. Remove 
        \chapter*{Bibliography\markboth{BIBLIOGRAPHY}{BIBLIOGRAPHY}}
        \list{[\arabic{enumi}]}{
                \settowidth\labelwidth{[#1]}\leftmargin\labelwidth
                \advance\leftmargin\labelsep\usecounter{enumi}
        }
        \addcontentsline{toc}{chapter}{Bibliography}
        \def\newblock{\hskip .11em plus .33em minus -.07em}
        \sloppy
        \sfcode`\.=1000\relax
}{\endlist}
\renewcommand\newblock{x}

\newcommand{\startbibliography}{
  \newpage
  \normalbaselines
  \addcontentsline{toc}{chapter}{Bibliography}}

% \def\@biblabel#1{[#1]\hfill}  % Produces the label for a \bibitem[...]
                                % command.
% \def\@cite#1{[#1]}            % Produces the output of the \cite command.

%----------------------------------------------------------------------
%
%    ****************************************
%    *              THE INDEX               *
%    ****************************************
%
% THE INDEX ENVIRONMENT
% Produces double column format, with each paragraph a separate entry.
% The user commands \item, \subitem and \subsubitem are used to
% produce the entries, and \indexspace adds an extra vertical space
% that's the right size to put above the first entry with a new letter
% of the alphabet.
%
%----------------------------------------------------------------------
\def\theindex{
\columnseprule \z@
\columnsep 35pt\twocolumn[\@makeschapterhead{Index}]
    \markboth{INDEX}{INDEX}\thispagestyle{plain}\parindent\z@
    \parskip\z@ plus .3pt\relax\let\item\@idxitem}

\def\@idxitem{\par\hangindent 40pt}

\def\subitem{\par\hangindent 40pt \hspace*{20pt}}

\def\subsubitem{\par\hangindent 40pt \hspace*{30pt}}

\def\endtheindex{\onecolumn}

\def\indexspace{\par \vskip 10pt plus 5pt minus 3pt\relax}

%----------------------------------------------------------------------
%
%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
% \footnoterule is a macro to draw the rule separating the footnotes from
% the text.  It should take zero vertical space, so it needs a negative
% skip to compensate for any positive space taken by the rule.  (See
% PLAIN.TEX.)
%
%----------------------------------------------------------------------
\def\footnoterule{
        \kern-1\p@
        \hrule width .4\columnwidth
        \kern .6\p@
}                 % The \hrule has default height of .4pt .

% \newcounter{footnote}
\@addtoreset{footnote}{chapter}  % Numbers footnotes within chapters

%----------------------------------------------------------------------
%
%   \@makefntext{NOTE} :
%        Must produce the actual footnote, using \@thefnmark as the mark
%        of the footnote and NOTE as the text.  It is called when effectively
%        inside a \parbox of width \columnwidth (i.e., with \hsize =
%        \columnwidth).  The following macro indents
%        all lines of the footnote by 10pt, and indents the first line of
%        a new paragraph by 1em.  To change these dimensions, just substitute
%        the desired value for '10pt' [in both places] or '1em'.
%        The mark is flushright against the footnote.
%
%        It is much easier to write a macro in which the footnote text is
%        set like an ordinary text paragraph, with no indentation except
%        on the first line of a paragraph, and the first line of the
%        footnote.  In that case, all the macro must do is set \parindent
%        to the appropriate value for succeeding paragraphs and put the
%        proper indentation before mark.
%
%----------------------------------------------------------------------
\long\def\@makefntext#1{\@setpar{\@@par\@tempdima \hsize
  \advance\@tempdima-10pt\parshape \@ne 10pt \@tempdima}\par
  \parindent 1em\noindent \hbox to \z@{\hss$^{\@thefnmark}$}#1}

%----------------------------------------------------------------------
% \@makefnmark : A macro to generate the footnote marker that goes
%    in the text.  Default used.
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%
%    ****************************************
%    *         FIGURES AND TABLES           *
%    ****************************************
%
% Float placement parameters.  See LaTeX manual for their definition.
%
%----------------------------------------------------------------------
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%----------------------------------------------------------------------
%
% fix a BUG? in latex.tex
%
%----------------------------------------------------------------------

% still needed?? -RW
%\let\@@addtocurcol\@addtocurcol
%\def\@addtocurcol{{\@floatplacement\@@addtocurcol}}

%----------------------------------------------------------------------
% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.
%      NUMBER : Figure or table number--e.g., 'Figure 3.2'
%      TEXT   : The caption text.
%  Macro should be called inside a \parbox of right width, with \normalsize.
%----------------------------------------------------------------------
\long\def\@makecaption#1#2{
   \vskip 10pt
   \setbox\@tempboxa\hbox{#1: #2}
   \ifdim \wd\@tempboxa >\hsize   % IF longer than one line:
       \unhbox\@tempboxa\par      %   THEN set as ordinary paragraph.
     \else                        %   ELSE  center.
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}
   \fi}

%----------------------------------------------------------------------
%
% To define a float of type TYPE (e.g., TYPE = figure), the document style
% must define the following.
%
%  \fps@TYPE   : The default placement specifier for floats of type TYPE.
%
%  \ftype@TYPE : The type number for floats of type TYPE.  Each TYPE has
%                associated a unique positive TYPE NUMBER, which is a power
%                of two.  E.g., figures might have type number 1, tables type
%                number 2, programs type number 4, etc.
%
%  \ext@TYPE   : The file extension indicating the file on which the
%                contents list for float type TYPE is stored.  For example,
%                \ext@figure = 'lof'.
%
%  \fnum@TYPE  : A macro to generate the figure number for a caption.
%                For example, \fnum@TYPE == Figure \thefigure.
%
%  The actual float-making environment commands--e.g., the commands
%  \figure and \endfigure--are defined in terms of the macros \@float
%  and \end@float, which are described below.
%
%  \@float{TYPE}[PLACEMENT] : Macro to begin a float environment for a
%     single-column float of type TYPE with PLACEMENT as the placement
%     specifier.  The default value of PLACEMENT is defined by \fps@TYPE.
%     The environment is ended by \end@float.
%     E.g., \figure == \@float{figure}, \endfigure == \end@float.
%
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% FIGURE
%----------------------------------------------------------------------
%\newcounter{figure}[chapter]
\renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{{\bf Figure~\thefigure}}
\renewenvironment{figure}
               {\@float{figure}}
               {\end@float}
\renewenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}

%----------------------------------------------------------------------
% TABLE
%----------------------------------------------------------------------
%\newcounter{table}[chapter]
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{{\bf Table~\thetable}}
\renewenvironment{table}
               {\@float{table}}
               {\end@float}
\renewenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

%----------------------------------------------------------------------
%
%    ****************************************
%    *         TITLE AND ABSTRACT           *
%    ****************************************
%
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%  Add to handle copyright pagecount in PHD (or MS) theses
%----------------------------------------------------------------------
\newif\ifCopR \CopRfalse

%----------------------------------------------------------------------
%  Add to handle Abstract pagecount in PHD (or MS) theses
%----------------------------------------------------------------------
\newif\ifAbstractP \AbstractPfalse % abstract title page [gadde]

% \department{department name} -- user macro to declare name of department.
\newcommand{\department}[1]{\gdef\@department{#1}}

% \subject{subject name} -- user macro to declare subject (should come from specific list)
%\newcommand{\subject}[1]{\gdef\@subject{#1}}

% \advisor{advisor name} -- user macro to declare name of advisor/supervisor.
\newcommand{\advisor}[1]{\gdef\@advisor{#1}}

% Set default values for department name, advisor name, and current year.
\department{??DEPARTMENT??}
\advisor{??ADVISOR??}
\date{\number\year}

% The macros and counters between here and the definition of \maketitle help 
% \maketitle handle the signature lines.

% \@member{member name} -- internal macro to print a line to sign on, and the
%       name of a committee member (sole argument) below the line.
\newcommand{\@member}[1]{
  \raisebox{0pt}[0pt][0pt]{}\par  % Print a blank line to make alignment work.
  \raisebox{-8pt}[0pt][17pt]{\rule{2.8in}{.5pt}}\par    % Print line.
  \raisebox{0pt}[0pt][0pt]{#1}\par      % Print member name below.
}

\newcounter{@members}           % Number of member macros defined so far.
\newcommand{\@membera}{\@member{\@advisor, Advisor}}
\setcounter{@members}{1}        % Advisor is always 1st member

% @minmembers -- holds mimumum number of member macros needed.  It is set in
% \maketitle.
\newcounter{@minmembers}

% \member{member name} -- user macro to declare the name of a committee member.
%       May be used up to 7 times.  Should not be used for advisor.
\newcommand{\member}[1]{
  \addtocounter{@members}{1}    % Inc. num of members to include this new one.
  \ifcase\value{@members} 
    \typeout{Thesis format internal error.  Too few committee members.} \or
    \typeout{Thesis format internal error.  Advisor left off committee.} \or
    \newcommand{\@memberb}{\@member{#1}} \or
    \newcommand{\@memberc}{\@member{#1}} \or
    \newcommand{\@memberd}{\@member{#1}} \or
    \newcommand{\@membere}{\@member{#1}} \or
    \newcommand{\@memberf}{\@member{#1}} \or
    \newcommand{\@memberg}{\@member{#1}} \or
    \newcommand{\@memberh}{\@member{#1}} 
  \else
    \typeout{Error using thesis format.  Too many committee members.}
  \fi
}


%----------------------------------------------------------------------
%% -- Changed for the new style info 31 August 87 by CRM
%% 
%% Define an abstract macro to provide an abstract page that exactly
%% duplicates the title page, EXCEPT for the words ``an abstract'' vice
%% ``a dissertation.''
%%
%----------------------------------------------------------------------

\newcounter{@membersprinted}


\def\maketitle{         % Define macro to print title page.
  \typeout{Title page}
  \begin{titlepage}
    \let\footnotesize\small % Local definitions to make \thanks produce
    \let\footnoterule\relax % \normalsize footnotes with no separating rule.
    \setcounter{page}{0}
    \null
    \parskip=0pt
    \begin{center}
      \vglue -.25in   % this makes top margin 2in
      {\Large \expandafter{\@title} \par}
      \vglue 2ex
      {\normalsize by \par}
      \vglue 2ex
      {\large\@author\par\par}
      \vglue 3ex
      {\normalsize Department of \@department\par}
      {\normalsize Duke University\par}
    \end{center}

    \ifPrelim
    \else
      \vglue 3ex plus 1fill  % fill to keep bottom of page from creeping up
      \ifPhD
        \setcounter{@minmembers}{4} % PhD committees have at least 4 members
      \else
        \setcounter{@minmembers}{3} % Masters committees have at least 3 members
      \fi
      \begin{center}
      \parbox{2.8in}{
        Date:\hfill\rule[-.4ex]{2.35in}{.5pt}\par
        Approved:
        \vspace*{0.2in}
        { \centering\normalsize
          % @membersprinted counts the number of committee members printed so far
          \setcounter{@membersprinted}{0}
          % Print the committee members defined by the user.
          \loop
          \ifnum \value{@membersprinted} < \value{@members} 
            \addtocounter{@membersprinted}{1}
            \ifcase\value{@membersprinted}
              \typeout{Thesis style--internal error printing members.} \or
              \@membera \or
              \@memberb \or
              \@memberc \or
              \@memberd \or
              \@membere \or
              \@memberf \or
              \@memberg \or
              \@memberh
            \else \typeout{Thesis style--internal error printing members.}
            \fi
          \repeat
          % If the minimum number of signature lines haven't been printed,
          % print some more.
          \loop
          \ifnum \value{@membersprinted} < \value{@minmembers}
            \addtocounter{@membersprinted}{1}
            \@member{}
          \repeat
        }
      }\hfill
      \end{center}
      \vglue 3ex plus 1fill
    \fi % \ifPrelim \else

    \begin{center}
      {\normalsize 
        \ifPrelim
          Preliminary exam document
        \else % \ifPrelim
          \ifPhD
            Dissertation submitted in partial fulfillment of the \par
            requirements for the degree of Doctor of Philosophy \par
          \else
            A thesis submitted in partial fulfillment of the \par
            \ifMS
              requirements for the degree of Master of Science \par
            \else
              requirements for the degree of Master of Arts \par
            \fi
          \fi
          in the Department of \@department \par
          in the Graduate School of \par
          Duke University \par
          \vglue 0.75em
          \@date \par
        \fi % \ifPrelim \else
      }
    \end{center}
    \par\vglue 1ex\@thanks\null
  \end{titlepage}
  \setcounter{footnote}{0} % Footnotes start at zero again.
  \let\thanks\relax
%%% SAVE THESE \gdef\@thanks{}\gdef\@department{}\gdef\@author{}\gdef\@title{}
  \let\maketitle\relax % only ONCE!?
}

%% Makeabstract command
\def\makeabstract{              % Define macro to print title page.
\ifPrelim
\else
  \AbstractPtrue                % [gadde]
  \typeout{Abstract page}
  \begin{abstractpage}
    \let\footnotesize\small % Local definitions to make \thanks produce
    \let\footnoterule\relax % \normalsize footnotes with no separating rule.
    \setcounter{page}{0}
    \null
    \parskip=0pt
    \begin{center}
      \vglue -.25in   % this makes top margin 2in
      {\Large \underline{ABSTRACT}}
      \vglue 2ex
      %{\large (\@subject)}
      %\vglue 2ex
      {\Large \expandafter{\@title} \par}
      \vglue 2ex
      {\normalsize by \par}
      \vglue 2ex
      {\large\@author\par\par}
      \vglue 3ex
      {\normalsize Department of \@department\par}
      {\normalsize Duke University\par}
    \end{center}

    \vglue 3ex plus 1fill  % fill to keep bottom of page from creeping up
    \ifPhD
      \setcounter{@minmembers}{4} % PhD committees have at least 5 members
    \else
      \setcounter{@minmembers}{3} % Masters committees have at least 3 members
    \fi
        \begin{center}
    \parbox{2.8in}{
      Date:\hfill\rule[-.4ex]{2.35in}{.5pt}\par
      Approved:
\vspace*{0.2in}
      { \centering\normalsize
        % @membersprinted counts the number of committee members printed so far
        \setcounter{@membersprinted}{0}
        % Print the committee members defined by the user.
        \loop
        \ifnum \value{@membersprinted} < \value{@members} 
          \addtocounter{@membersprinted}{1}
          \ifcase\value{@membersprinted}
            \typeout{Thesis style--internal error printing members.} \or
            \@membera \or
            \@memberb \or
            \@memberc \or
            \@memberd \or
            \@membere \or
            \@memberf \or
            \@memberg \or
            \@memberh
          \else \typeout{Thesis style--internal error printing members.}
          \fi
        \repeat
        % If the minimum number of signature lines haven't been printed,
        % print some more.
        \loop
        \ifnum \value{@membersprinted} < \value{@minmembers}
          \addtocounter{@membersprinted}{1}
          \@member{}
        \repeat
      }
    }\hfill
        \end{center}
    \vglue 2ex

    \begin{center}
      {\normalsize
        An abstract of a
        \ifPhD
          dissertation submitted in partial fulfillment of the \par
          requirements for the degree of Doctor of Philosophy \par
        \else
          thesis submitted in partial fulfillment of the \par
          \ifMS
            requirements for the degree of Master of Science \par
          \else
            requirements for the degree of Master of Arts \par
          \fi
        \fi
        in the Department of \@department \par
        in the Graduate School of \par
        Duke University \par
        \vglue 0.75em
        \@date \par
      }
    \end{center}
%    \begin{center}
%      {\normalsize 
%       An abstract of a dissertation submitted in partial\par
%        fulfillment of the requirements for the degree \par
%        of Doctor of Philosophy in the Department of \par
%        \@department\ in the Graduate School of \par
%       Duke University \par
%       \vglue 0.75em
%       \@date \par
%      }
%    \end{center}
    \par\vglue 1ex\@thanks\null
  \end{abstractpage}
  \setcounter{footnote}{0} % Footnotes start at zero again.
  \let\thanks\relax
%%% SAVE THESE \gdef\@thanks{}\gdef\@department{}\gdef\@author{}\gdef\@title{}
  \let\makeabstract\relax % only ONCE!?
\fi %\ifPrelim \else
}
%% End of the make abstract
  \setcounter{page}{4}
% Old junk; probably should be deleted.
%\def\Type#1{\gdef\@Type{#1}}
%\Type{Dissertation}

%----------------------------------------------------------------------
%
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
%     \leftmark  : Used in the \@oddhead, \@oddfoot, \@evenhead or \@evenfoot
%                  macro, gets the current 'left'  mark.  Works like TeX's
%                  \botmark command.
%     \rightmark : Used in the \@oddhead, \@oddfoot, \@evenhead or \@evenfoot
%                  macro, gets the current 'right'  mark.  Works like TeX's
%                  \firstmark command.
% The marking commands work reasonably well for right marks 'numbered
% within' left marks--e.g., the left mark is changed by a \chapter command and
% the right mark is changed by a \section command.  However, it does
% produce somewhat anomalous results if two \bothmark's occur on the same page.
%
%----------------------------------------------------------------------
\mark{{}{}}   % Initializes TeX's marks

\def\ps@empty{\def\@oddhead{\versiontag\hfil} \def\@oddfoot{}%
\def\@evenhead{\versiontag\hfil}\def\@evenfoot{}}

%----------------------------------------------------------------------
% Definiton of 'plain' page style.
%   This page style is used on 2nd and subsequent pages of a chapter
%----------------------------------------------------------------------
\def\ps@plain{%
  \def\@oddhead{\versiontag}
  \def\@oddfoot{\hfil\rm\thepage\hfil}
  \let\@evenhead\@oddhead
  \let\@evenfoot\@oddfoot}

%----------------------------------------------------------------------
% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%----------------------------------------------------------------------

%%% \newdimen\shortpage % text height of a chapter page
%%% \newbox\mybox
%%% \shortpage\textheight \advance\shortpage -\footskip% find page length
%%% \advance\textheight-\footskip%
%%% \setbox\@tempboxa=\vsplit255 to \shortpage%   chop off any extra lines
%%% \setbox\mybox=\box255 \setbox255=\box\@tempboxa%
%%% \newpage \unvbox\mybox%
%%% \unvbox255 \setbox255=\box\@tempboxa%          and return them to the input
%%% \advance\textheight by -\footskip%  leave room for the footer

\def\ps@headings{%
  \def\@oddfoot{\hfil\rm\thepage\hfil}%  centered page number
  \let\@evenfoot\@oddfoot
  \def\@oddhead{\versiontag\hfil}
  \let\@evenhead\@oddhead
  \def\chaptermark##1{\markright {{\ifnum \c@secnumdepth >\m@ne
        \@chapapp\ \thechapter. \ \fi ##1}}}}

%----------------------------------------------------------------------
% Definition of 'myheadings' page style.  The user's \head command
% changes the definition of \@lhead and/or \@rhead.
%----------------------------------------------------------------------
\def\ps@myheadings{\def\@oddhead{\hbox{}\sl\@rhead \hfil \rm\thepage}%
  \def\@oddfoot{}\def\@evenhead{\rm \thepage\hfil\sl\@lhead\hbox {}}%
  \def\@evenfoot{}\def\chaptermark##1{}\def\sectionmark##1{}}

% FOR VERSION 2.08
%\def\ps@myheadings{\ps@headings\def\chaptermark##1{}\def\sectionmark##1{}}

%----------------------------------------------------------------------
%
%    ****************************************
%    *            MISCELLANEOUS             *
%    ****************************************
%
% DATE
%
%----------------------------------------------------------------------
% \def\today{\ifcase\month\or
%   January\or February\or March\or April\or May\or June\or
%   July\or August\or September\or October\or November\or December\fi
%   \space\number\day, \number\year}

%----------------------------------------------------------------------
%
%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations
%
%----------------------------------------------------------------------
%\ps@plain                   % 'plain' page style
\pagenumbering{roman}       % roman page numbers
%\onecolumn                  % Single-column.
%\raggedbottom               % Ragged bottom
%----------------------------------------------------------------------





%
% spacing commands from cornell.cls -rw
%
%% \newcommand{\singlespacing}{%
%%   \let\CS=\@currsize\renewcommand{\baselinestretch}{1.0}\tiny\CS}
%% \newcommand{\singlespacingplus}{%
%%   \let\CS=\@currsize\renewcommand{\baselinestretch}{1.25}\tiny\CS}
%% \newcommand{\doublespacing}{%
%%   \let\CS=\@currsize\renewcommand{\baselinestretch}{1.75}\tiny\CS}
%% \newcommand{\realdoublespacing}{%
%%   \let\CS=\@currsize\renewcommand{\baselinestretch}{2}\tiny\CS}
%% \newcommand{\normalspacing}{\doublespacing}
%% \newcommand{\footnotespacing}{\singlespacing}
%% \newcommand{\changespacing}[2]{%
%%   \renewcommand{#1}{%
%%     \let\CS=\@currsize\renewcommand{\baselinestretch}{#2}\tiny\CS}%
%% }

%% \doublespacing


\typeout{end of dukethesis2004.cls}

\endinput
%%
