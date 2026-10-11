%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% `bsu-cs.cls'
%%
%% LaTeX2e document class for Boise State University master's thesis and
%% project reports and doctoral dissertation.
%%
%% This file is based on the standard LaTeX 'report' document class
%% (which can be found in /usr/share/texmf/tex/latex/base/report.cls)
%% with major modifications made by Amit Jain, Alex Feldman, and Mike
%% Stark.  Some ideas from Nelson Beebe's "uuthesis.sty" have been
%% incorporated; other University of Utah students have also contributed
%% to that style.
%%
%% The purpose of this class file is to make it easier for students to
%% format thesis, dissertation and project reports to conform (as closely
%% as is reasonably possible) to the formatting requirements set forth in the
%% document "Standards for the preparation of dissertations, theses, and projects"
%% compiled by the Graduate College.  The primary variations are
%%
%%   - Vertical and horizontal spacing is handled by the TeX software; there
%%     is no specific notion of "single" or "double" spacing.  This
%%     document class uses the \doublespacing command in the 'setspace'
%%     package, which stretches the baseline by a factor of 1.655 (which is
%%     a carefully constructed standard value).  For "single spaced" text,
%%     the default baselineskip is used.
%%
%%   - Vertical spacing around headings varies with the formatting as done
%%     by TeX.  The "raggedbottom" option is in effect, which allows for
%%     some extra space at the bottom of pages; however, heading space and
%%     space around floating elements remains variable.
%%
%%   - Running text is justified.  The first line of paragraphs is indented
%%     by 1.5 em (about 18 points), but this indentation is not applied
%%     to the first paragraph following a heading (paragraph and subparagraph
%%     headings are followed on the same line by running text).
%%
%%   - Chapter headings (and names) are set in 17 point bold font;
%%     chapters are numbered (sequentially) with Arabic numbers.  Chapters
%%     are indexed by number in the table of contents.
%%
%%   - Section headings (first-level subheadings) are set at the left margin,
%%     in 14 point bold font; they are numbered with the chapter number and
%%     section number separated by a period.
%%
%%   - Subsection headings (second-level subheadings) are also set at the
%%     left margin, but in 12 point bold font; they are numbered with the
%%     chapter number, section number, and subsection number, also separated
%%     by a period.
%%
%%   - Subsubsubsection headings (third-level subheadings) are set at the
%%     left margin, in 12 point bold font, but are unnumbered, and do not
%%     appear in the table of contents
%%
%%   - Paragraph headings (fourth-level subheadings) are set at the left
%%     margin, in 12 point bold font, and are unnumbered.
%%
%%   - Subparagraph headings (fifth-level subheadings) are indented as
%%     paragraphs are indentated.
%%
%%   - The bibliography is the standard LaTeX "plain" style, in which
%%     entries are alphabetized by first letter of the (first) author's
%%     last name, and are indexed by Arabic numbers starting from 1.
%%     An entry is formatted with its index enclosed in brackets set at
%%     the left margin, followed by approximately an en space, followed
%%     by the entry.  The text for multiline entries is left-aligned
%%     with the text of the first line of the entry.
%%
%%   - Bibliography entries vary by the type of the reference.  Generally
%%     the order of the entries is: author(s), title, venue, volume/number,
%%     year, publisher.  Book titles are set in italic, with all but minor
%%     words capitalized.  For journal and conference articles, the journal
%%     name or conference venue is set in italic, with the article title
%%     set in Roman and normally has only the first title word capitalized.
%%     The ordinal "th" in such things as edition numbers is not raised
%%     as a superscript.
%%
%% Otherwise, the format closely matches the standards.  This class was
%% was developed with computer science students in mind, but should be
%% equally useful for students in any department.
%%
%% NOTE: students should not need to make any changes to this file.
%% See "bsu-thesis-dissertation-template.tex" for an example of how to use
%% this document class in LaTeX.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Some design decisions for the file are:
%%
%%   * There is no LaTeX 2.09 compatibility mode.
%%
%%   * This is intended to be a standalone file, with minimal dependence
%%     on other packages.
%%
%%   * Options that would result in an unacceptable format, such as font size,
%%     paper size, and two-column options are not available.
%%
%%   * Rather than include "size12.clo" and "report.cls" via \include,
%%     the contents have been pasted into this file and modified.
%%
%%   * The "monolithic pastes" are kept as close as possible to the
%%     originals.  Whenever possible (and reasonable), customizations are
%%     done using macros defined in a separate section.
%%
%% Incidentally, first-person references in this document refer to Mike Stark (or Amit Jain).
%% (With regards to the uuthesis.sty, Mike alone updated it to work with LaTeX2e.)
%%
%%
%% What's left to do:
%%
%%   * I'd like to standardize how filenames, Linux commands, and the like,
%%     as well as how code is formatted.
%%
%%   * The vertical spacing is a bit loose.  We might consider changing the
%%     glue around headings, especially chapter headings, to tighten it up.
%%
%%   * A thought about a class option for truly ragged bottom, which would
%%     essentially eliminate any vertical rubber space.  But I didn't actually
%%     implement it.  I put this in because the wide spacing in short pages
%%     bothers some people.
%%
%%   * I know there are standards for documenting LaTeX class files. This
%%     file should conform.
%%
%%   * As it stands, sectioning in the list List of Abbreviations and the
%%     List of Figures doesn't work well: it just inserts a centered section-
%%     style line with some glue.
%%
%%   * The standards allow for a "List of Pictures/Maps" in the front matter. It
%%     seems unlikely that CS students would need them, but it might be worthwhile
%%     including them.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\typeout{Boise State University thesis/dissertation class 2nd December, 2022}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsu-cs}[2022/12/02 LaTeX class for Boise State University]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Included Packages

%% The "setspace" package replaces the older "doublespace" package.
%% In addition to defining sensible spacing parameters, it provides the
%% commands \singlespacing and \doublespacing (and also \onehalfspacing)
%% that can be used to locally change the spacing in the document.
\def\@ptsize{2}  %% (required by the 'setspace' package)
\RequirePackage{setspace}[6.7]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Class Options

%% To keep things simple, most of the options that don't apply to the
%% standards document for a project/thesis at Boise State are removed.
%% Keeping them in might lead to confusion, and any student who wants
%% to use more extensive options (say, for a "personal" version) of
%% his/her thesis can always switch to a different class file.
%%
%% There is no paper size option.  The requirement is U.S. letter
%% (8.5-by-11 inch paper), and this is unlikely to change due to binding
%% and shelf size issues.  I suppose a student from Europe might want to
%% print the work on A4 paper or something, but as it stands it will fit
%% on A4, with a shorter right margin and longer bottom margin.
%%
%% The thesis standard requires 12 point font, so there is no point in
%% making the font size an option.   The formatting stuff is a lot simpler
%% if we stick to one font size.  Likewise, two-column formatting is not
%% allowed, so there is no reason to provide the option for it.

%% Set the paper size for standard U.S. "letter" paper
\setlength\paperheight{11in}
\setlength\paperwidth{8.5in}

%% The "openright" option causes new chapters to start (be opened) on an
%% odd-numbered page.  I set this to the default in two-sided mode, but in
%% single-sided mode it is probably not a good idea.  So it's not an option.
\newif\if@openright
\@openrightfalse

%% The "twoside" option might be useful: a student might want to print
%% two-sided personal copies to save paper.
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue \@openrighttrue}

%% The "draft" option just changes the fussiness about overfull boxes,
%% which simplifies and maybe even speeds up formatting.  This can be
%% useful when one is making frequent changes and recompiling.
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

%% These options control the position of displayed math equations and
%% their numbering. I'm going to just comment them out for now.
%%\DeclareOption{leqno}{\input{leqno.clo}}
%%\DeclareOption{fleqn}{\input{fleqn.clo}}

%% The "openbib" options produces a bibliography in "open" style,
%% rather than the "condensed" style.  It probably shouldn't be used,
%% but I'll leave it in.
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}

%% The "dissertation" option causes the document to be formatted as a dissertation
%% rather than a thesis.
%% The "project" option causes the document to be formatted as a project
%% report rather than a thesis.
%% At the moment there isn't much difference, but in future versions there might be.

\newif\if@dissertation
\@dissertationfalse
\DeclareOption{dissertation}{%
  \@dissertationtrue%
}
\newif\if@project
\@projectfalse
\DeclareOption{project}{%
  \@projecttrue%
}
\newif\if@proposal
\@proposalfalse
\DeclareOption{proposal}{%
  \@proposaltrue%
}

%% The "flushtop" option basically eliminates any vertical rubber space,
%% which has the effect of keeping all the vertical spacing the same, but
%% at the cost of making the bottom very ragged.
%% (Well, maybe someday...)

%\newif\if@flushtop
%\@flushtopfalse
%\DeclareOption{flushtop}{%
%  \@flushtoptrue%
%}

%% The "Amit" option provides some particular formatting specifications,
%% e.g., "Chapter" instead of "CHAPTER", that Amit prefers.

\newif\if@Amit
\@Amitfalse
\DeclareOption{Amit}{%
  \@Amittrue%
}


%% The "Mike" option provides some particular formatting specifications,
%% and includes some packages, that Mike prefers.

\newif\if@Mike
\@Mikefalse
\DeclareOption{Mike}{%
  \@Miketrue%
}

%% Even though 'twocolumn' is not supported here, I left most of the code
%% for it in for easy reference to where this differs from 'report.cls'
%% (and removing it really doesn't save enough space to bother with)
%% These ifs are used in that code.
\newif\if@twocolumn \@twocolumnfalse
\newif\if@restonecol

%% Set the default options, and process them

\ExecuteOptions{final}
\ProcessOptions\relax

% (end of "Class Options")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% ``size12.clo'' paste

%% This section contains definitions that depend on the font size.
%% Most of it comes from the existing "size12.clo" (in an earlier version
%% it used that file outright) but I want this to be a standalone file,
%% and be as independent as possible on future LaTeX releases.  I removed
%% all the two-column stuff as well as the compatability stuff.
%% The basic margin definitions get reset below.

%% Note that \p@ is 1 point; \z@ is zero.

%% Basic sizes
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xiipt{14.5}%
   \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\newcommand\small{%
   \@setfontsize\small\@xipt{13.6}%
   \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 9\p@ \@plus3\p@ \@minus5\p@
               \parsep 4.5\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\footnotesize{%
   \@setfontsize\footnotesize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 6\p@ \@plus2\p@ \@minus2\p@
               \parsep 3\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}
\newcommand\tiny{\@setfontsize\tiny\@vipt\@viipt}
\newcommand\large{\@setfontsize\large\@xivpt{18}}  %! specific point size
\newcommand\Large{\@setfontsize\Large\@xviipt{22}} %! could be changed here
\newcommand\LARGE{\@setfontsize\LARGE\@xxpt{25}}
\newcommand\huge{\@setfontsize\huge\@xxvpt{30}}
\let\Huge=\huge
  \setlength\parindent{1.5em}
\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\headheight{12\p@}
\setlength\headsep   {25\p@}
\setlength\topskip   {12\p@}
\setlength\footskip  {30\p@}
\setlength\maxdepth{.5\topskip}
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
  \setlength\@tempdimb{390\p@}
    \ifdim\@tempdima>\@tempdimb\relax
      \setlength\textwidth{\@tempdimb}
    \else
      \setlength\textwidth{\@tempdima}
    \fi
  \@settopoint\textwidth
  \setlength\@tempdima{\paperheight}
  \addtolength\@tempdima{-2in}
  \addtolength\@tempdima{-1.5in}
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
\addtolength\textheight{\topskip}
  \setlength\marginparsep{10\p@}
\setlength\marginparpush{7\p@}
  \if@twoside
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.4\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.6\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
  \else
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.5\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.5\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
    \addtolength\marginparwidth {-.4in}
  \fi
  \ifdim \marginparwidth >2in
     \setlength\marginparwidth{2in}
  \fi
  \@settopoint\oddsidemargin
  \@settopoint\marginparwidth
  \setlength\evensidemargin  {\paperwidth}
  \addtolength\evensidemargin{-2in}
  \addtolength\evensidemargin{-\textwidth}
  \addtolength\evensidemargin{-\oddsidemargin}
  \@settopoint\evensidemargin

  \setlength\topmargin{\paperheight}
  \addtolength\topmargin{-2in}
  \addtolength\topmargin{-\headheight}
  \addtolength\topmargin{-\headsep}
  \addtolength\topmargin{-\textheight}
  \addtolength\topmargin{-\footskip}     % this might be wrong!
  \addtolength\topmargin{-.5\topmargin}
  \@settopoint\topmargin

\setlength\footnotesep{8.4\p@}
\setlength{\skip\footins}{10.8\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {14\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\dblfloatsep    {14\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{10\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{10\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{3\p@ \@plus 2\p@ \@minus 2\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 5\p@  \@plus2.5\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@   \@minus6\p@
            \itemsep5\p@  \@plus2.5\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    5\p@   \@plus2.5\p@ \@minus\p@
              \parsep    2.5\p@ \@plus\p@    \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2.5\p@\@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
%%
%% (End of "size12.clo Paste")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% report.cls stuff
%%
%% This is a monolithic paste from report.cls.

%% The paste starts just after the \input{size\@ptsize.clo} line
%% Most of the customization stuff has been moved to the end

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\setlength\parindent{1.5em}
\setlength\partopsep{3\p@ \@plus 2\p@ \@minus 2\p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

%! The topnumber, \topfrac, etc. (which control float placement) have
%! been moved below.

%! The definitions of \ps@headings (which format page headers and footers)
%! have also been moved below.  (They have also been simplified significantly.)

%! \@maketitle has been replaced by our custom title page generation code
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
%! "parts" are not included
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
		    \chaptermark{#1}%
		    %? shouldn't the spacing added to the list of tables
		    %? between chapters be dependent on the font size?
		    %! I think so; I changed it to 12 pt (from 10 pt)
                    \addtocontents{lof}{\protect\addvspace{12\p@}}%
                    \addtocontents{lot}{\protect\addvspace{12\p@}}%
                    \@makechapterhead{#2}%
                    \@afterheading
                    }
%! Appendix format required by graduate school:
%!   Line 1: "APPENDIX A" (normal chapter heading style)
%!   Line 2: appendix title underneath (centered, bold)
%!   Next page: appendix body text starts
\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \centering
      \if@appendix
        \@chapterHeadStrut\@chapterHeadingStyle \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@  % match gap
        {\large\bfseries #1}\par\nobreak
        \vskip 40\p@
        \clearpage  % chapter body begins on the next page
      \else
        %! This I did change a bit, to get 2 inch margins
        %! also I added macros for chapter heading styles
        %! Normal (non-appendix) chapter heading
        \@chapterHeadStrut\@chapterHeadingStyle \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
        \interlinepenalty\@M
        \@chapterNameStyle \@chapterNameCase{#1}\par\nobreak
        \vskip 40\p@
      \fi
    \fi
  }}
% \def\@makechapterhead#1{%
%   %! This I did change a bit, to get 2 inch margins
%   %! also I added macros for chapter heading styles
%   {\parindent \z@ \raggedright \normalfont
%     \ifnum \c@secnumdepth >\m@ne
%       \centering
%         %! This is where \chapter creates the chapter name heading
%       \@chapterHeadStrut\@chapterHeadingStyle \@chapapp\space \thechapter
%       \par\nobreak
%         \vskip 20\p@
%     \fi
%     \interlinepenalty\@M
%     \@chapterNameStyle \@chapterNameCase{#1}\par\nobreak
%     \vskip 40\p@
%   }}
  
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  %! The front matter pages use \chapter* for the heading, so I made
  %! similar changes here
  {\parindent \z@ \raggedright
    \centering
    \normalfont
    \interlinepenalty\@M
    %! This is where \chapter* creates the chapter heading
    \@chapterHeadStrut\@chapterHeadingStyle \@chapterNameCase{#1}\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\@sectionNameStyle}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\@subsectionNameStyle}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

%! The 'abstract' construction is moved below

\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
%! Our \@maketitle command uses this environment
%! (I removed the compatibility version)
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\newcommand\appendix{\par
  %! These help deal with chapter numbering
  \@appendixtrue
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
  \gdef\apppagebreak{1}}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tp*}  %! try to keep figures at the top of the page
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tp*}  %! try to keep tables at the top of the page
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
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
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{\@pagenumwidth}  %! for approximate number of pages
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{\@TOCdotsep}  %! dot leader separation
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      %! The 'report' class doesn't include dotted lines for chapter
      %! entries in the table of contents.  That looks weird in our
      %! format, largely because the abstract, list of tables, and
      %! list of figures appear in the contents.
      {#1}\nobreak
      \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak
      \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #2}%
      \par
      %! (it was just this)
      % #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    %! include it in the table of contents
    \addcontentsline{toc}{chapter}{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
  \chapter*{\listtablename}%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    %! include it in the table of contents
    \addcontentsline{toc}{chapter}{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      %! the standards require single-spaced bibliography
      \singlespacing
      %! again, the place-in-document stuff
      \@appendixfalse
      %! include it in the table of contents
      \addcontentsline{toc}{chapter}{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist\normalspacing}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\@restonecoltrue
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{TABLE OF CONTENTS}
\newcommand\listfigurename{LIST OF FIGURES}
\newcommand\listtablename{LIST OF TABLES}
\newcommand\bibname{REFERENCES}
\newcommand\indexname{INDEX}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{PART}
\newcommand\chaptername{CHAPTER}
\newcommand\appendixname{APPENDIX}
\newcommand\abstractname{ABSTRACT}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

%
% (end of "report.cls Stuff")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%                           CUSTOMIZED STUFF
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Most of the code above is copied straight from either 'size12.clo' or
%% 'report.cls'.  The bulk of the customizations we've made start here.
%%
%% The first part of this contains mostly parameter and style settings;
%% the commands for formatting front matter pages is toward the end

%% Here is a macro from the TeXbook that Alex likes
%% (it's used for some error checking below)
\def\ifundefined#1{\expandafter\ifx\csname#1\endcsname\relax}

%% Another convenient macro
\def\normalspacing{\doublespacing}

%% Set the font and spacing (this is necessary for setting up some spacing)
\normalsize
\normalspacing  %% use double spacing throughout, by default

%% Some extra where-am-I-in-the-document ifs
\newif\if@frontmatter\@frontmatterfalse  % true only in the front matter
\newif\if@mainmatter\@mainmatterfalse    % true only in the main body text
\newif\if@backmatter\@backmatterfalse    % true only in the back matter
\newif\if@appendix\@appendixfalse        % true only in appendices


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Margin Stuff
%%
%% The thesis standards manual specifies 1 inch top, bottom, and right
%% margins, and a 1.5 inch left margin.  Unfortunately, it is not clear
%% how the header and footer (which contain only page numbers) fit into this.
%% I am taking it literally, to mean that all text on the page, including the
%% page numbers, are to be placed inside the margins.
%%
%% TeX margins are a little weird: text on a page is offset 1 inch from the
%% top and 1 inch from the left, the "device margins" (my understanding is
%% those are hard-coded into TeX and never change).  But in this case it
%% does simplify things, because the top margin matches the requirement.

%% The distance from the top of the page to the top of the header is
%% \topmargin plus 1 inch
\setlength{\topmargin}{0in}

%% \headheight is the height of the header.  We want it just large enough
%% to contain the page number, which I'm taking to be the height of the
%% number "1"  (Another, probably better option would be to use the em
%% height of the page number font, but that makes the top margin look
%% slightly larger.)
\settoheight{\headheight}{1}

%% \headskip is the spacing between the base of the header and the top of
%% the body text.  It looks like the style has been to have that be the same
%% as the ordinary line spacing, so I will leave it at that.
\setlength{\headsep}{\baselineskip}

%% \[odd|even]sidemargin is the margin next to the binding, which already has
%% the device margin of 1 inch. The standards require the total left margin
%% to be 1.5 inch.
\setlength{\oddsidemargin}{0.5in}
\setlength{\evensidemargin}{\oddsidemargin}

%% The right margin is controlled by \textwidth: the right margin is the
%% page width minus \textwidth, minus the (total) left margin.
\setlength{\textwidth}{6.0in}

%% Similarly, the bottom margin is determined by \textheight, which is the
%% height of the text body.  For a 1 inch bottom margin this would normally
%% by 9 inches, but we have to subtract the height and spacing of the header.
\setlength{\textheight}{9in}
\advance\textheight by -\headsep
\advance\textheight by -\headheight

%% The base of the footer is \footskip below the base of the body.
%% The only place we need footers is for the page numbers in the front
%% matter (which are miniscule Roman numerals).  Unfortunately, the
%% standards require that these page numbers are one inch above the
%% bottom of the page, and therefore the collide with the body text.
%% My solution is to cut back \textwidth enough for the page number at
%% the bottom of the header pages, then add it back for the main text.
%% (this is a little dangerous I know, but hopefully it won't cause
%% any trouble).

\advance\textheight by -\baselineskip
\setlength{\footskip}{\baselineskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Other Spacing Stuff


%% hyphenation penalties (from uuthesis)
\hyphenpenalty=400
\exhyphenpenalty=400

%% club/widow penalties (also from uuthesis)
\clubpenalty=4000               %% try harder to eliminate club lines
\widowpenalty=4000              %% try harder to eliminate widow lines
\displaywidowpenalty=3000       %% for math display widow line
\predisplaypenalty=3000         %% breaking before a math display
\postdisplaypenalty=2000        %% breaking after a math display

%% The thesis style guide at Utah insisted that a page could not be
%% broken before a displayed math equation.  Setting the penalty to
%% 10000 (the maximum) makes such a break impossible.  I'll leave it
%% commented out for now.
%\predisplaypenalty=10000


%% The thesis style guide at Utah was also picky about figure placement.
%% The numbers here are standard; the ones I used are in the second column

%% float placement parameters             (what I used in 'myuuthesis.cls')
\setcounter{topnumber}{2}                 %% 10
\renewcommand\topfraction{.7}		  %%  1
\setcounter{bottomnumber}{1}		  %% 10
\renewcommand\bottomfraction{.3}	  %%  1
\setcounter{totalnumber}{3}		  %% 20
\renewcommand\textfraction{.2}		  %%  0
\renewcommand\floatpagefraction{.5}	  %% .5
\setcounter{dbltopnumber}{2}		  %% 10
\renewcommand\dbltopfraction{.7}	  %%  1
\renewcommand\dblfloatpagefraction{.5}	  %% .5

%% Glue (rubber space), in some of the paragraph stuff, causes trouble.
%% It might be necessary to use these definitions in some situations.

%\topsep=10pt
%\partopsep=3pt
%\itemsep=5pt
%\parsep=5pt
%\parskip=0pt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Page Headers/Footers
%%
%% All the front matter pages have \pagestyle{empty} or \pagestyle{plain};
%% the latter centers a page number in the footer and leaves the header empty.
%% The commands for \pagestyle{headings} can be empty, because they are
%% never used.

\if@twoside
  \def\ps@headings{%
    \def\@evenhead{}%
    \def\@oddhead{}
  }
\else
  \def\ps@headings{%
    \def\@oddhead{}
  }
\fi

%% \pagestyle{myheadings} is used for the body text.  The footer is empty,
%% the header contains a single Arabic page number.

\if@twoside
  \def\ps@myheadings{\let\@mkboth\@gobbletwo
  \def\@oddhead{\hbox{} \hfil\rmfamily\thepage}
  \def\@oddfoot{}
  \def\@evenhead{\rmfamily\thepage \hfil\hbox{}}
  \def\@evenfoot{}
  \def\chaptermark##1{}
  \def\sectionmark##1{}
  \def\subsectionmark##1{}
}
\else
  \def\ps@myheadings{\let\@mkboth\@gobbletwo
  \def\@oddhead{\hbox{} \hfil\rmfamily\thepage}
  \def\@oddfoot{}
  \def\@evenhead{\rmfamily\thepage \hfil\hbox{}}
  \def\@evenfoot{}
  \def\chaptermark##1{}
  \def\sectionmark##1{}%
  \def\subsectionmark##1{}}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Chapter/Section Heading Styles
%%
%% These are used in several places, but most importantly in the commands
%% defined above that actually format the headings.  It's convenient to
%% have them in one place, whenever that is possible.

\def\@chapterHeadingStyle{\large\bfseries}
\def\@chapterNameStyle{\large\bfseries}
\def\@sectionNameStyle{\large\bfseries}
\def\@subsectionNameStyle{\bfseries}

\def\@partHeadingStyle{\Large\bfseries}
\def\@partNameStyle{\Large\bfseries}
\def\@subpartHeadingStyle{\Large\bfseries}

%% For chapter names in the heading, and table of contents
\def\@chapterHeadCase{\expandafter\uppercase}
%\def\@chapterNameCase{\expandafter\uppercase}
\def\@chapterNameCase{\expandafter\uppercase}

%% For the dot spacing in the table of contents leaders
\def\@TOCdotsep{2.5}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Some Potentially Useful Commands and Environments
%%

%% Some day we should decide on a style for these

%% For filenames
\newcommand{\file}[1]{\texttt{#1}}

%% For Linux commands
\newcommand{\cmd}[1]{\texttt{#1}}

%% For verbatim code (unfortunately, we can't include 'verbatim')
\newenvironment{vcode}%
  {\small\singlespacing}%
  {\normalspacing\normalsize}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Front Matter Macros
%%
%% The content of the front matter pages are controlled through macros,
%% which are (presumably) set in the document.

%% \title is the title of the dissertation or thesis or project
\renewcommand{\title}[1]{\gdef\@title{#1}\gdef\@upcasetitle{\uppercase{#1}}}

%% Sometimes line breaking of the title on the title page needs manual
%% adjustment.  The \titleBreak command breaks the title on the title
%% page, but not on the approval page.
\newcommand{\titleBreak}{\\}  %% it gets redefined in \maketitle

% \defenseDate is the date of the defense
\newcommand{\defenseDate}[1]{\gdef\@defenseDate{#1}}
%% \graduationMonth and \graduationYear are the day, month and year, respectively,
%% of graduation.
\newcommand{\graduationYear}[1]{\gdef\@graduationYear{#1}}
\newcommand{\graduationMonth}[1]{\gdef\@graduationMonth{#1}}

%% \degree is the name of the degree, normally "Master of Science"
\newcommand{\degree}[1]{\gdef\@degree{#1}}

%% \advisor is the name of the advisor or chair
\newcommand{\advisor}[2][Chair, Supervisory Committee]{\gdef\@advisor{#2}\gdef\@advisorTitle{#1}}

%% \committee[A-E] are the names of the committee member, in the order
%% they appear on the signature (approval) page
\newif\if@committeeC \@committeeCfalse
\newif\if@committeeD \@committeeDfalse

\newcommand{\committeeA}[2][Member, Supervisory Committee]{%
  \gdef\@committeeA{#2}\gdef\@titleA{#1}}
\newcommand{\committeeB}[2][Member, Supervisory Committee]{%
  \gdef\@committeeB{#2}\gdef\@titleB{#1}}
\newcommand{\committeeC}[2][Member, Supervisory Committee]{%
  \gdef\@committeeC{#2}\gdef\@titleC{#1}\@committeeCtrue}
\newcommand{\committeeD}[2][Member, Supervisory Committee]{%
  \gdef\@committeeD{#2}\gdef\@titleD{#1}\@committeeDtrue}
\newcommand{\gradCoordinator}[2][Graduate Coordinator]{%
  \gdef\@gradCoordinator{#2}\gdef\@titleGC{#1}}

%% I suppose some of these could be made optional, with reasonable
%% defaults, but somehow it seems better to require them to be specified
%% explicitly.

%% \major is the student's major field of study, e.g. "Computer Science"
\newcommand{\major}[1]{\gdef\@major{#1}}

%% \deptartment is the department granting the degree
%? (should there be more than one?)
\newcommand{\department}[1]{\gdef\@department{#1}}

%% \deptartmentchair is the name of the chairperson of the department
%% (it is not currently used)
\newcommand{\departmentChair}[2][\expandafter\@department~Chair]{%
  \gdef\@departmentChair{#2}\gdef\@departmentChairTitle{#1}}

%% \college is the name of the college, e.g., "Engineering"
\newcommand{\college}[1]{\gdef\@college{#1}}

%% \@masterstype is either "thesis" (default) or "dissertation" or "project" if the
%% appropriate class option is given
\gdef\@masterstype{\if@project{project}\else\if@dissertation{dissertation}\else{thesis}\fi\fi}
\gdef\@Masterstype{\if@project{Project}\else\if@dissertation{Dissertation}\else{Thesis}\fi\fi}

\gdef\@proposaltype{\if@proposal{proposal}\else{}\fi}
\gdef\@Proposaltype{\if@proposal{Proposal}\else{}\fi}

\gdef\@docname{\if@project{PROJECT REPORT}\else{THESIS}\fi}
\gdef\@docname{\if@proposal{\if@project{PROPOSAL}\else{THESIS}\fi}\fi}
\gdef\@docname{\if@dissertation{DISSERTATION}\else{THESIS}\fi}

\newcommand{\masterstype}{\@masterstype}
\newcommand{\Masterstype}{\@Masterstype}
\newcommand{\proposaltype}{\@proposaltype}
\newcommand{\Proposaltype}{\@Proposaltype}

%% The names of the front matter pages are pretty much fixed,
%% but just in case, let's put them in macros
%% (\abstractname, \listfigurename, \contentsname, \listtablename are
%% are already defined.)

\newcommand{\committeeapproval}{DEFENSE COMMITTEE AND FINAL READING APPROVALS}
\newcommand{\proposalacceptance}{PROPOSAL ACCEPTANCE}
\newcommand{\acknowledgmentsname}{ACKNOWLEDGMENTS}
\newcommand{\dedicationame}{DEDICATION}
\newcommand{\biosketchname}{AUTOBIOGRAPHICAL SKETCH}
\newcommand{\listabbrevname}{LIST OF ABBREVIATIONS}
\newcommand{\listsymbolname}{LIST OF SYMBOLS}

%% According to the standards, the bibliography is entitled "References"
%% or "Works Cited" if all the bibliography elements are cited in the
%% document; otherwise it is called "Bibliography".  Rather than setting
%% the name directly, it's better to define a macro to change the name,
%% to preserve consistent capitalizations

\if@Amit
  \newcommand{\bibliographyName}[1]{\renewcommand{\bibname}{#1}}
\else
  \newcommand{\bibliographyName}[1]{\renewcommand{\bibname}{\uppercase{#1}}}
\fi

%% The name \copyright is already used (for the copyright symbol);
%% this \includeCopyright macro instructs the \frontmatter command to include
%% the copyright page; the optional argument is a copyright year, in case
%% there is some reason it is different from \graduationYear

\newcommand{\includeCopyright}[1][\expandafter\@graduationYear]{
  \@copyrighttrue \gdef\@copyrightyear{#1}}

%% \numPages sets the approximate number of pages, to help format the
%% table of contents
\newlength{\@pagenumwidth}
\settowidth{\@pagenumwidth}{\normalsize\normalfont 99}
\newcommand{\maxPage}[1]{%
  \settowidth{\@pagenumwidth}{\normalsize\normalfont #1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Title Page
%%
%% The title and other front matter pages have the requirement that
%% the page titles are set two inches from the top of the page.  I'm
%% taking that to mean the cap-height of the title is two inches from
%% the top.  I'm effecting this by using a zero-width rule (a strut)

%% To get the top of the text close to the 2 inch requirement we need the
%% actual em-height of the title font (although I daresay it would be better
%% to have text start at 2 inches plus the point size of the font).
\newlength{\@chapterHeadingEM}
\settoheight{\@chapterHeadingEM}{\@chapterHeadingStyle M}

\newlength{\@toTwoInches}
\setlength{\@toTwoInches}{1in}  % 2 inches minus the 1 inch device margin
\advance\@toTwoInches by -\topmargin
\advance\@toTwoInches by -\headheight
\advance\@toTwoInches by -\headsep

%% for front matter headings
\advance\@toTwoInches by \@chapterHeadingEM
\def\@fmHeadStrut{\rule{0in}{\@toTwoInches}}

%% for chapter headings
\def\@chapterHeadStrut{\rule{0in}{\@toTwoInches}}


%% Title Page command

\def\@maketitle{%
  \begin{titlepage}
  	%remove leading empty page
    %\null\newpage\setcounter{page}{1}  %% not that it really matters...
    \null\setcounter{page}{1}  %% not that it really matters...
    %% To satisfy the annoying requirement that the date be one inch
    %% above the bottom of the page, I'm putting the date in the footer.
    \renewcommand{\thepage}{\@graduationMonth~\@graduationYear}%
    \thispagestyle{plain}%
    %%
    %% This is tricky, because the author's name is supposed to be vertically
    %% centered at the middle of the page.  I'm handling this by putting the
    %% title in a vbox that extends all the way to the top of the "by"
    %% (the start of the author's byline).  This also allows for a multiline
    %% title without adjusting the formatting.  (I stole this idea straight
    %% from Nelson Beebe's uuthesis.sty)
    %%
    \begin{center}
      %% the \@toTwoInches strut doesn't work here, because the 'center'
      %% environment adds \topskip.  So that length has to be subtracted
      %% from \@toTwoInches
      \newlength{\@top}
      \setlength{\@top}{\@toTwoInches}
      \advance\@top by -\topskip
      \rule{0pt}{\@top}
      %% put the title in a 'minipage' to allow for multiline titles
      \begin{minipage}[t]{\textwidth}
	\centering
	\vbox to 204pt {  % this is approximate
          \begin{doublespace}
	    \large\bfseries \@upcasetitle
        \end{doublespace}}%
      \end{minipage}\hfill
      %% the by-line
      by\\
      \@author\mbox{}\\
      \mbox{}\vfill
      %% the bit at the bottom
      A \@masterstype\ \proposaltype\\
      submitted in partial fulfillment\\
      of the requirements for the degree of\\
      {\@degree} in {\@major} \\
      Boise State University\\
    \end{center}
  \end{titlepage} %
  \renewcommand{\titleBreak}{ }%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Copyright Page

\newif\if@copyright\@copyrightfalse


\def\@makecopyright{\begin{titlepage}
  %% Another hack, this time to put the copyright in the footer
  %% (for that the infernal 1-inch bottom margin business!)
  %% This seems a bit convoluted, but it was the only thing I could
  %% figure out to get the copyright notice to extend above the footer
  %% into the body text--LaTeX works surprisingly hard to ensure that
  %% the baseline of the top element in the footer vbox goes at the
  %% footer baseline.
  \setcounter{page}{2}
  \newsavebox{\@copyrightbox}
  \savebox{\@copyrightbox}{\begin{minipage}[b]{3in}
      \singlespacing
      \center
      $\copyright$ \@copyrightyear\\
      \@author\mbox{}\\
      ALL RIGHTS RESERVED
  \end{minipage}}
  \renewcommand{\thepage}{\vphantom{ALL}\smash{\usebox{\@copyrightbox}}}
  \thispagestyle{plain}
  \mbox{}
  %% this is probably not necessary, but what the heck
  \let\maketitle\relax\let\makecopyright\relax
  \end{titlepage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Defense Committee and Final Reading Approvals Page


\def\@makecmteapproval{
  \newpage

  \begin{center}
  {BOISE STATE UNIVERSITY GRADUATE COLLEGE}\\[12pt]

  \textbf{\committeeapproval}
  \end{center}

  %% reset the page counter
  \if@copyright\setcounter{page}{3}\else\setcounter{page}{2}\fi
  %% (although this page is not numbered)
  \thispagestyle{empty}
  \begin{center}
   of the {\@masterstype} submitted by
 	\vspace{12pt}\\
   {\@author}
 	\vspace{12pt}
  \end{center}
  \singlespacing
%! Title: prevent hyphenation, keep additional lines of title aligned 
%% with each other, all to the right of “Dissertation Title:”
  \noindent
  \makebox[\textwidth][l]{%
    \parbox[t]{0.25\textwidth}{\@Masterstype\ Title:}%
    \hspace{0.02\textwidth}%
    \parbox[t]{0.73\textwidth}{%
      \raggedright
      \hyphenpenalty=10000
      \exhyphenpenalty=10000
      \@title
    }%
  }\\[12pt]
  \noindent Date of Final Oral Examination: {\@defenseDate}\\[12pt]
  \noindent The following individuals read and discussed the {\@masterstype}
  submitted by student {\@author},  and they evaluated the presentation
  and response to questions during the final oral examination. They found
  that the student passed the final oral examination.

  \label{CommitteeApproval}
  \begin{flushleft}
    \begin{minipage}{5.50in}
  		{\@advisor} \hfill \makebox[2.5in][l]{\@advisorTitle}\\[12pt]
  		{\@committeeA} \hfill \makebox[2.5in][l]{\@titleA}\\[12pt]
  		{\@committeeB} \hfill \makebox[2.5in][l]{\@titleB}\\[12pt]
  		\if@committeeC{\@committeeC} \hfill \makebox[2.5in][l]{\@titleC}\\[12pt]\fi
  		%? I don't think there is enough space for a fifth member
  		\if@committeeD{\@committeeD} \hfill \makebox[2.5in][l]{\@titleD}\\[12pt]\fi
	\end{minipage}
  \end{flushleft}

  \begin{singlespace}
  \noindent The final reading approval of the {\@masterstype} was granted by {\@advisor}, Chair of
  the Supervisory Committee.  The {\@masterstype} was approved by the Graduate College.
  \end{singlespace}

  \normalspacing
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Proposal Acceptance page


\def\@makepropapproval{
  \newpage

  \begin{center}
  {BOISE STATE UNIVERSITY}\\
  {Department of Computer Science }\\[12pt]

  {\bf \proposalacceptance}
  \end{center}

  %% reset the page counter
  \if@copyright\setcounter{page}{3}\else\setcounter{page}{2}\fi
  %% (although this page is not numbered)
  \thispagestyle{empty}
  \singlespacing

  \noindent Proposal type: \underline{\@Masterstype}\\[12pt]
  \noindent Name: \underline{\@author}\\[12pt]
  \noindent Date: \underline{\@defenseDate}\\[12pt]
  \noindent Proposal Title: \underline{\@title}\\[12pt]

  \noindent The above proposal has been accepted by the committee below.

  \label{CommitteeApproval}
  \begin{flushleft}
    \begin{minipage}{6.50in}
      {\@advisorTitle}:~\hrulefill~ \makebox[2in][l]{\@advisor}\\[12pt]
      {\@titleA}:~\hrulefill~ \makebox[2in][l]{\@committeeA}\\[12pt]
      {\@titleB}:~\hrulefill~ \makebox[2in][l]{\@committeeB}\\[12pt]
      \if@committeeC{\@titleC}:~\hrulefill~ \makebox[2in][l]{\@committeeC}\\[12pt]\fi
      \if@committeeD{\@titleD}:~\hrulefill~ \makebox[2in][l]{\@committeeD}\\[12pt]\fi
      {\@titleGC}:~\hrulefill~ \makebox[2in][l]{\@gradCoordinator}\\[12pt]
    \end{minipage}
  \end{flushleft}
  \vfill{}
  \newpage{}
  \normalspacing
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Final Reading Approval Page

%% macro to construct the labeled signature line for the committee members
%\long\def\@readerPerson#1#2{%
%  %% the example page in the standards document has a 3/4 inch vertical
%  %% space for the signature, which seems reasonable.
%  \rule{0pt}{0.75in}%
%  \mbox{}\hrulefill\\
%  #1\hfill\makebox[0.75in][l]{Date}\\
%  \mbox{#2}\\}
%
%\def\@makefinalapproval{
%  \chapter*{\finalapproval}
%  %% reset the page counter
%  \if@copyright\setcounter{page}{4}\else\setcounter{page}{3}\fi
%  %% (although this page is not numbered)
%  \thispagestyle{empty}
%  \begin{center}
%   of the  {\@masterstype} submitted by
% 	\vspace{12pt}\\
%   {\@author}
% 	\vspace{12pt}
%  \end{center}
%  \noindent To the Graduate College of Boise State University:
%
%  \singlespacing
%  \noindent I have read the thesis of {\@author} in its final form and
%  have found that (1) the modifications required by the defense committee
%  are complete; (2) the format, citations, and bibliographic style are
%  consistent and acceptable; (3) the illustrative materials including
%  figures, tables, and charts are in place; and (4) the final manuscript
%  is ready for submission to the Graduate College.
%
%  \label{finalApproval}
%  \begin{flushright}
%    \begin{minipage}{3.75in}
%  		\singlespacing
%  		\@readerPerson{\@advisor}{\@advisorTitle}
%    \end{minipage}
%  \end{flushright}
%  \normalspacing
%}
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Autobiographical Sketch

\newif\if@biosketch \@biosketchfalse
\newcommand{\biosketch}[1]{\@biosketchtrue\long\gdef\@biosketch{#1}}

\def\@makebiosketch{\newpage
  \chapter*{\biosketchname}
  \hspace*{\parindent}\@biosketch
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Abstract

\newcommand{\abstract}[1]{\long\gdef\@abstract{#1}}
\def\@makeabstract{%
  \newpage
  \chapter*{\abstractname}
  \addcontentsline{toc}{chapter}{\abstractname}
  %%\addcontentsline{toc}{chapter}%
  \hspace*{\parindent}\@abstract
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Dedication

\newif\if@dedication \@dedicationfalse
\newcommand{\dedication}[1]{\@dedicationtrue\long\gdef\@dedication{#1}}

\def\@makededication{%
  % \newpage
  \chapter*{\dedicationame}
  \hspace*{\parindent}\@dedication
%  \mbox{}\vfill\centerline{\@dedication}\vfill
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Acknowledgments

\newif\if@acknowledgments \@acknowledgmentsfalse
\newcommand{\acknowledgments}[1]{\@acknowledgmentstrue%
  \long\gdef\@acknowledgments{#1}}

\def\@makeacknowledgments{\newpage
  \chapter*{\acknowledgmentsname}
  \hspace*{\parindent}\@acknowledgments
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% List of Abbreviations
%%
%% This, and the List of Symbols, is probably too complicated to be defined
%% in the preamble, so I am creating a separate environment for it.

\newif\if@abbrevlist\@abbrevlistfalse

\newcommand{\@listsec}[1]{%
\centerline{\textbf{\@sectionNameStyle #1}}\vspace*{2em \@plus.2ex}}

\newenvironment{listAbbreviations}{\newpage
  \if@symbollist\ClassError{bsu-cs}{list of abbreviations must preceed%
    list of symbols}{}\fi%
  \chapter*{\listabbrevname} %
  \addcontentsline{toc}{chapter}{\listabbrevname}%
  \@abbrevlisttrue
  \let\section=\@listsec%
  \list{}{\singlespacing \labelwidth\z@ \itemindent-\leftmargin%
    \itemsep\baselineskip \parsep\z@ \listparindent\z@%
    \labelsep\z@
    \let\makelabel\abbrevlabel}}
  {\endlist\normalspacing}
\newcommand*\abbrevlabel[1]{\hspace\labelsep\normalfont\textbf{#1} -- }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% List of Symbols
%%
%% This, and the List of Symbols, is probably too complicated to be defined
%% in the preamble, so I am creating a separate environment for it.

\newif\if@symbollist\@symbollistfalse

\newenvironment{listSymbols}{\newpage
  \if@abbrevlist\ClassError{bsu-cs}{list of symbols must follow%
    list of abbreviations}{}\fi%
  \chapter*{\listsymbolname} %
  \addcontentsline{toc}{chapter}{\listsymbolname}%
  \@symbollisttrue
  \let\section=\@listsec%
  \list{}{\singlespacing \labelwidth\z@ \itemindent-\leftmargin%
    \itemsep\baselineskip \parsep\z@ \listparindent\z@%
    \labelsep\z@
    \let\makelabel\symbollabel}}
  {\endlist\normalspacing}
\newcommand*\symbollabel[1]% I'm sure there is a better way...
{\hspace\labelsep\normalfont\makebox[\leftmargin][l]{\textbf{#1}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Front Matter Production

%% Error message stuff: \missing{name} calls \ClassError (standard LaTeX2e)
%% informing the user that the name has not been defined.
\def\@missing#1{\ClassError{bsu-cs}{missing #1^^J^^J%
  \@spaces(did you forget the #1command?)}%
  {The \noexpand\buildFrontPages command, which generates all the front matter
   pages,^^Jneeds a #1command prior to its execution.}}


%% \buildFrontPages builds all the front matter pages, and prepares for the
%% main text.  It also checks for the required definitions and reports an
%% error for any that are missing.

\newcommand{\buildFrontPages}{
  %% Make sure all the required elements are defined
  \ifundefined{@title}\@missing{\noexpand\title}\fi
  \ifundefined{@graduationMonth}\@missing{\noexpand\graduationMonth}\fi
  \ifundefined{@graduationYear}\@missing{\noexpand\graduationYear}\fi
  \ifundefined{@advisor}\@missing{\noexpand\advisor}\fi
  \ifundefined{@committeeA}\@missing{\noexpand\committeeA}\fi
  \ifundefined{@committeeB}\@missing{\noexpand\committeeB}\fi
  \ifundefined{@degree}\@missing{\noexpand\degree}\fi
  \ifundefined{@major}\@missing{\noexpand\major}\fi
  \ifundefined{@department}\@missing{\noexpand\department}\fi
  \ifundefined{@college}\@missing{\noexpand\college}\fi
  \ifundefined{@abstract}\@missing{\noexpand\abstract}\fi

  %% Create the title page
  \@maketitle
  %% Create the copyright page, if there is one
  \if@copyright \@makecopyright\fi
  %% Create the defense committee or proposal approval page
  \if@proposal{\@makepropapproval}\else{\@makecmteapproval}\fi
  %% Create the dedication page, if there is one
  \if@dedication \@makededication\fi
  %% Create the ackowledgments page, if there is one
  \if@acknowledgments \@makeacknowledgments \fi
  %% Create the autobiographical sketch, if there is one
  \if@biosketch \@makebiosketch\fi
  %% Create the abstract page
  \if@proposal{}\else{\@makeabstract}\fi

  %% Put in the table of contents, the list of tables, and list of figures
  \tableofcontents
  \if@proposal{}\else{\listoftables}\fi
  \if@proposal{}\else{\listoffigures}\fi

  %% render accidental repeated calls harmless
  %\let\frontPages\relax
}


%% \finish adds the required extra blank page at the end
\newcommand{\finish}{
  \newpage
  \thispagestyle{empty}
  \mbox{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Main Matter and Back Matter

%% The "book" class has a \frontmatter command to start doing front matter
%% stuff, a \mainmatter command for the main text, and a \backmatter command
\newcommand{\frontmatter}{\@frontmattertrue}

\newcommand{\mainmatter}{
  %% Start the main text
  \clearpage              %% finish off the current page (list of figures)
  \normalspacing          %% back to double space, just in case
  \pagestyle{myheadings}  %% put the page number at the upper right
  \pagenumbering{arabic}  %% switch to Arabic numbers (resets the page counter)
  \@frontmatterfalse      %% end front matter
  \@mainmattertrue        %% start main matter
}

\newcommand{\backmatter}{
  \@mainmatterfalse
  \@backmattertrue
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Specific Styles

\if@Amit
  %% Amit doesn't like title headings in all capitals
  \renewcommand{\chaptername}{Chapter}    %% rather than CHAPTER
  \renewcommand{\appendixname}{Appendix}  %% rather than APPENDIX
\fi

\if@Mike
  %% I can't stand the look of the Computer Modern fonts
  \usepackage{mathptmx}
  \usepackage[scaled=0.92]{helvet}
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Get Things Started (for the front matter stuff)

\normalspacing
\pagestyle{plain}     %% page number centered in the footer
\pagenumbering{roman} %% use miniscule Roman numerals for page numbering


\endinput
