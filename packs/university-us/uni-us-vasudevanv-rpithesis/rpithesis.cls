%% This is the file `rpithesis.cls', for use at Rensselaer Polytechnic Institute.
%% It provides additional functionality over the standard LaTeX report class.
%% In some cases, it overrides the LaTeX report class. 
%% Originally written by Harriet Borton (ITS), April 1996.
%% Modified to conform to Office of Graduate Education Requirements as of May 2013

%  Note that the setspace package is built in (code included near the end of
%  this file) to provide "line-and-a half spacing" (1.4 by default) and also
%  the singlespace environment.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rpithesis}[2009/01/06 Rensselaer Polytechnic Institute]

% RPI Chapter option
\newif\ifchap  
  \chapfalse   
\DeclareOption{chap}{\chaptrue} 

% Options for font sizes
\newcommand\docsize{}  
\DeclareOption{10pt}{\renewcommand\docsize{10pt}}
\DeclareOption{11pt}{\renewcommand\docsize{11pt}}
\DeclareOption{12pt}{\renewcommand\docsize{12pt}}

% Set default options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{11pt}         
\ProcessOptions

% Load the report class with 11pt default fontsize
\LoadClass[\docsize]{report}  

% Page Layout
% Side margins
\if@twoside                 % Values for two-sided printing:
   \oddsidemargin .55in     %   Left margin on odd-numbered pages.
   \evensidemargin .05in    %   Left margin on even-numbered pages.
   \marginparwidth 40pt     %   Width of marginal notes.
\else                       % Values for one-sided printing:
   \oddsidemargin 0.55in    %   Note that \oddsidemargin = \evensidemargin
   \evensidemargin 0.55in
   \marginparwidth 40pt
\fi
\marginparsep 10pt          % Horizontal space between outer margin and marginal note
\textwidth 5.9in            % Width of text

% Vertical spacing
\topmargin -.5in            % Distance from top of page to running head
\headheight 14pt            % Height of box containing running head.
\headsep .4in               % Space between running head and text.
\textheight 8.8in           % Space for text
\footskip 30pt              % Distance from baseline of box containing foot
                            % to baseline of last line of text.

% Spacing - Code from setspace.sty
\def\setspace@size{
  \ifx \@currsize \normalsize
    \@normalsize
  \else
    \@currsize
  \fi
}

\def\doublespacing{
  \ifcase \@ptsize \relax 
    \def \baselinestretch {1.667} % For 10pt
  \or 
    \def \baselinestretch {1.618} % For 11pt
  \or 
    \def \baselinestretch {1.655} % For 12pt
  \fi
  \setspace@size
}

\def\onehalfspacing{
  \ifcase \@ptsize \relax 
    \def \baselinestretch {1.250} % For 10pt
  \or 
    \def \baselinestretch {1.213} % For 11pt
  \or 
    \def \baselinestretch {1.241} % For 12pt
  \fi
  \setspace@size
}

\def\singlespacing{
  \def \baselinestretch {1}
  \setspace@size
  \vskip \baselineskip  
}

\def\setstretch#1{
  \renewcommand{\baselinestretch}{#1}
}

% Stretch the baseline BEFORE calculating the strut size. This improves
% spacing below tabular environments etc., probably...
\def\@setsize#1#2#3#4{
  \@nomath#1
  \let\@currsize#1
  \baselineskip #2
  \baselineskip \baselinestretch\baselineskip
  \parskip \baselinestretch\parskip
  \setbox\strutbox \hbox{
    \vrule height.7\baselineskip depth.3\baselineskip width\z@}
  \skip\footins \baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}

% Increase the space between last line of text and footnote rule.
%\skip\footins 20pt plus4pt minus4pt

% Reset baselinestretch within floats and footnotes.
\let\latex@xfloat=\@xfloat
\def\@xfloat #1[#2]{
  \latex@xfloat #1[#2]
  \def \baselinestretch {1}\@normalsize  
  \normalsize
}

\long\def\@footnotetext#1{
  \insert\footins{
    \def\baselinestretch {1}
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{
      \csname p@footnote\endcsname\@thefnmark}
    \color@begingroup
      \@makefntext{
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}
    \color@endgroup}}

\long\def\@mpfootnotetext#1{
  \global\setbox\@mpfootins\vbox{
    \unvbox \@mpfootins
    \def\baselinestretch {1}
    \reset@font\footnotesize
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{
      \csname p@mpfootnote\endcsname\@thefnmark}
    \color@begingroup
      \@makefntext{
       \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}
   \color@endgroup}}

% A single spaced quote (say) is done by surrounding singlespace with quote.
\def\singlespace{
  \vskip \baselineskip
  \def\baselinestretch {1}
  \setspace@size
  \vskip -\baselineskip
}

\def\endsinglespace{\par}

%  spacing, doublespace and onehalfspace all are meant to INCREASE the
%  spacing (i.e. calling onehalfspace from within doublespace will not
%  produce a graceful transition between spacings)
% Next two definitions fixed for consistency with TeX 3.x

\def\spacing#1{
  \par
  \begingroup             
    \def\baselinestretch {#1}
    \setspace@size
}

\def\endspacing{
    \par
    \vskip \parskip
    \vskip \baselineskip
  \endgroup
  \vskip -\parskip
  \vskip -\baselineskip
}

% one and a half spacing is 1.5 x pt size
\def\onehalfspace{
  \ifcase \@ptsize \relax  
    \spacing{1.250} % For 10pt
  \or 
    \spacing{1.213} % For 11pt
  \or 
    \spacing{1.241} % For 12pt 
  \fi
}

\let\endonehalfspace=\endspacing

% double spacing is 2 x pt size
\def\doublespace{%
  \ifcase \@ptsize \relax % 10pt
    \spacing{1.667}%
  \or % 11pt
    \spacing{1.618}%
  \or % 12pt
    \spacing{1.655}%
  \fi
}

\let\enddoublespace=\endspacing

\everydisplay\expandafter{%
  \the\everydisplay
  \abovedisplayskip \baselinestretch\abovedisplayskip
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip \baselinestretch\abovedisplayshortskip
  \belowdisplayshortskip \baselinestretch\belowdisplayshortskip
}
% End of code from setspace.sty 


% Section headings
\newcommand\chaptersize{\Large}
\newcommand\sectionsize{\large}
\newcommand\subsectionsize{\normalsize}
\newcommand\subsubsectionsize{\normalsize}
\newcounter{firstchapter}
\setcounter{firstchapter}{0}

\setcounter{secnumdepth}{3}    % Number subsubsections in the chapters
\setcounter{tocdepth}{3}       % Put subsubsections in the table of contents

% Print "CHAPTER" if chap option is specified:
\ifchap
  \renewcommand\@chapapp{\chaptername}
\else
  \renewcommand\@chapapp{}
\fi

% General heading for un-numbered chapters (eg. References, Appendix etc.)
\def\specialhead#1{
     \ifx\phantomsection\undefined
     \else
        \clearpage\phantomsection
     \fi
     \addcontentsline{toc}{chapter}{#1}
     \chapter*{\centering #1 \@mkboth{#1}{#1}}}


\def\@chapter[#1]#2{\ifnum\c@firstchapter=0    % start of rpi added stuff
                      \if@twoside\cleardoublepage\suppressfloats[t]\fi
                      \pagenumbering{arabic}
                      \setcounter{firstchapter}{1}
                    \fi
                    \renewcommand{\thepage}{\arabic{page}}
                    \thispagestyle{plain}
                    \pagestyle{myheadings}      % end of rpi added stuff
                    \ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter.}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
%                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
%                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{0\p@}%
  {\parindent \z@ \raggedright \centering \normalfont \chaptersize
    \ifnum \c@secnumdepth >\m@ne
      \ifchap
         \bfseries \@chapapp{} \thechapter    % print "Chapter" and number
         \vskip -3pt           %\par\nobreak (original)
       \else
         \bfseries \thechapter.
       \fi
    \fi
    \interlinepenalty\@M
    \vskip 10\p@
    \bfseries #1\par\nobreak
    \vskip 15\p@
  }}

\def\@makeschapterhead#1{%    heading for chapter* command (no numbering)
  \vspace*{0\p@}%
  {\parindent \z@ \raggedright \centering
    \normalfont  \chaptersize
    \interlinepenalty\@M
    \vskip 10\p@
    \bfseries  #1\par\nobreak
    \vskip 15\p@
  }}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {3.5ex \@plus 1ex \@minus .2ex}%
                                   {.5ex \@plus .3ex}%{1.4ex \@plus.2ex}%
                                   {\normalfont\sectionsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.3ex \@plus .2ex}%{1.2ex \@plus .2ex}%
                                     {\normalfont\subsectionsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.2ex \@plus .1ex}%{1ex \@plus .2ex}%
                                     {\normalfont\subsubsectionsize\bfseries}}

% \paragraph and \subparagraph headings unchanged from report.cls.


% Footnotes - make them continuously numbered throughout document
% define a command that can undo having footnotes reset with each chapter
% code taken from removefr.sty by Donald Arseneau
\def\@removefromreset#1#2{\let\@tempb\@elt
   \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
   \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
         \noexpand\@elt{##1}\fi}%
   \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
   \let\@elt\@tempb}
   
% use the command \@removefromreset to undo the \@addtoreset in report.cls:
\@removefromreset{footnote}{chapter}

% define command to allow people to reset footnote counter at will
 % definition to reset footnote
\def\resetfootnote{\setcounter{footnote}{0}} 

% Appendix
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \chaptrue
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}}

% Figures and tables 
% Control float placement:
\setcounter{topnumber}{2}
\renewcommand\topfraction{.8}
\setcounter{bottomnumber}{2}
\renewcommand\bottomfraction{.8}
\setcounter{totalnumber}{4}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.8}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.8}
\renewcommand\dblfloatpagefraction{.8}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\bfseries#1:~~#2}%   Make caption bold
  \ifdim \wd\@tempboxa >\hsize
   {\bfseries #1:~~#2}\par%            Make caption bold
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% Table of contents, list of figures, list of tables
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \vskip -1em \begin{singlespace}      % singlespacing
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }

\renewcommand*\l@chapter{\pagebreak[3]\vskip 10pt plus 1pt minus 1pt
                         \@dottedtocline{0}{0em}{1.4em}}
\renewcommand*\l@section{\vskip 6pt plus 1pt minus 1pt
                         \@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\ifnum\c@tocdepth>1\vskip 4pt minus 1pt \fi
                         \@dottedtocline{2}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{\ifnum\c@tocdepth>2 \vskip 3pt minus 1pt \fi
                         \@dottedtocline{3}{7.0em}{4.1em}}

\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \ifx\phantomsection\undefined
      \else
        \clearpage\phantomsection
      \fi
    \chapter*{\centering\listfigurename  % center it
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \addcontentsline{toc}{chapter}{\listfigurename}  % add lof to toc
    \vskip -1em \begin{singlespace}  % singlespacing
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }

\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \ifx\phantomsection\undefined
      \else
        \clearpage\phantomsection
      \fi
    \chapter*{\centering\listtablename  % center it
      \@mkboth{\MakeUppercase\listtablename}%
              {\MakeUppercase\listtablename}}%
    \addcontentsline{toc}{chapter}{\listtablename}  % add lot to toc
        \vskip -1em \begin{singlespace}  % singlespacing
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }

\renewcommand*\l@figure{\vskip 10pt plus 1pt minus 1pt
                       \@dottedtocline{1}{0em}{2.8em}}
\let\l@table\l@figure

\let\rpicaption\caption
\let\lrpicaption\caption


% Bibliography
% For use in making an unnumbered bibliography with hanging indents
\def\bibentry{\vskip10pt\par\noindent\hangindent=40pt\frenchspacing}

% Report definition modified for no automatic heading and use ragged right
\newcommand{\bibalign}{\raggedright}

\renewenvironment{thebibliography}[1]
     {\bibalign\frenchspacing
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}


% Titlepage and Copyright page
% Some variable definitions for use in the titlepage
\def\thesistitle#1{\gdef\@thesistitle{#1}}
\def\thesissubtitle#1{\gdef\@thesissubtitle{#1}}
\def\author#1{\gdef\@author{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\department#1{\gdef\@department{#1}}
\newcount\numcomm \numcomm=1
\def\signaturelines#1{\numcomm=#1}
\def\thadviser#1{\gdef\@thadviser{#1}}
\def\projadviser#1{\gdef\@projadviser{#1}} \projadviser{*}
\def\cothadviser#1{\gdef\@cothadviser{#1}} \cothadviser{*}
\def\coprojadviser#1{\gdef\@coprojadviser{#1}} \coprojadviser{*}
\def\cocothadviser#1{\gdef\@cocothadviser{#1}} \cocothadviser{*}
\def\cocoprojadviser#1{\gdef\@cocoprojadviser{#1}} \cocoprojadviser{*}
\def\maindoctype{\if \@projadviser \ifnum\numcomm < 4 *Thesis \else *Dissertation \fi \else Project \fi}
\def\doctype{\if \@projadviser  *Thesis \else Project \fi}
\def\adviser{\if \@projadviser *\@thadviser \else \@projadviser\fi}
\def\coadviser{\if \@coprojadviser *\@cothadviser\else \@coprojadviser\fi}
\def\cocoadviser{\if \@cocoprojadviser *\@cocothadviser\else \@cocoprojadviser\fi}
\def\memberone#1{\gdef\@memberone{#1}}
\def\membertwo#1{\gdef\@membertwo{#1}}
\def\memberthree#1{\gdef\@memberthree{#1}}
\def\memberfour#1{\gdef\@memberfour{#1}}
\def\memberfive#1{\gdef\@memberfive{#1}}
\def\membersix#1{\gdef\@membersix{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} \copyrightyear{\the\year}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\dedication#1{\gdef\@dedication{#1}}

% Signature blocks
\newcount\numcount
\def\sigblock{
   \ifnum\numcomm < 4  % master's thesis or project
     \vskip .8in plus 24pt minus 24pt
     \leftline{Approved: \hfil}\vskip 48pt plus 2pt minus 10pt
     \hrule width 2.6in\hfil \vskip -6pt
     \leftline{\adviser, \doctype Adviser\hfil}
     \if \coadviser * % no co-adviser
       \else \vskip 36pt plus 6pt minus 2pt \hrule width 2.6in\hfil \vskip -6pt
       \leftline{\coadviser, \doctype Adviser\hfil}
     \fi
     \if \cocoadviser * % no coco-adviser
       \else \vskip 36pt plus 6pt minus 2pt \hrule width 2.6in\hfil \vskip -6pt
      \leftline{\cocoadviser, \doctype Adviser\hfil}
     \fi
     \vskip 6pt
   \else  % PhD thesis
      \numcount=\numcomm
      \leftline{Approved by the\hfil}
      \leftline{Examining Committee:\hfil}
      \vskip 28pt \vfil
      \hrule width 2.8in \hfil \vskip -3pt
      \leftline{\adviser, \doctype Adviser\hfil}
      \advance \numcount by -1
      \if \coadviser * \else % there's a co-adviser
        \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
        \leftline{\coadviser, \doctype Adviser\hfil}
        \advance \numcount by -1
      \fi
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberone, Member\hfil}
      \advance \numcount by -1
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@membertwo, Member\hfil}
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberthree, Member\hfil}  \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberfour, Member\hfil}   \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberfive, Member\hfil}  \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@membersix, Member\hfil} \fi
      \fi}

 \def\sigblockabs{%
   \ifnum\numcomm < 4  % master's thesis or project
     \vskip 1.8in plus 24pt minus 24pt
     \leftline{Approved: \hfil}\vskip 24pt plus 2pt minus 10pt
     \leftline{\adviser, \doctype Adviser\hfil}
     \if \coadviser * % no co-adviser
       \else \vskip 8pt plus 6pt minus 2pt
       \leftline{\coadviser, \doctype Adviser\hfil}
     \fi
     \if \cocoadviser * % no coco-adviser
       \else \vskip 8pt plus 6pt minus 2pt
      \leftline{\cocoadviser, \doctype Adviser\hfil}
     \fi
 %    \vglue 24pt
  \else  % PhD thesis
    \numcount=\numcomm
    \leftline{Examining Committee: \hfil}
    \begin{quote}
      \adviser, \doctype Adviser\\[4pt]  \advance \numcount by -1
      \if \coadviser * \else
        \coadviser, \doctype Adviser\\[4pt]    \advance\numcount by -1
      \fi
      \@memberone, Member\\[4pt] \advance \numcount by -1
      \ifnum\numcount > 0
      \@membertwo, Member\\[4pt] \advance \numcount by -1 \fi
      \ifnum\numcount > 0
      \@memberthree, Member\\[4pt] \advance \numcount by -1 \fi
      \ifnum\numcount > 0
      \@memberfour, Member\\[4pt] \advance \numcount by -1  \fi
      \ifnum\numcount > 0
      \@memberfive, Member\\[4pt]\advance \numcount by -1  \fi
      \ifnum\numcount > 0
      \@membersix, Member\\[4pt] \advance \numcount by -1\fi
    \end{quote}
  \fi
 }

% Titlepage layout
 \def\titlepage{%
     \pagenumbering{roman}
     \thispagestyle{empty}
     \ifnum\numcomm<4 \vglue .5in\vfil \fi  % masters
     \ifnum\numcomm>5 \hbox{ } \vspace{-24pt}\fi % make more space on page
     \begin{singlespace}
     \begin{center}
         \parindent=0pt
         {\def\baselinestretch{1.2}\large\bf\uppercase \expandafter{\@thesistitle} \par\smallskip}
         {\def\baselinestretch{1.2}\normalsize\bf\uppercase \expandafter{\@thesissubtitle} \par\bigskip\bigskip} 
         By \par\bigskip
         {\def\baselinestretch{1.2}\large \expandafter{\@author} \par\bigskip\bigskip} 
         {\def\baselineskip{1.25}A \maindoctype Submitted to the Graduate \par\medskip Faculty of Rensselaer Polytechnic Institute \par\medskip in Partial Fulfillment of the \par\medskip Requirements for the Degree of \par\bigskip}
         {\uppercase\expandafter{\@degree} \par\bigskip}
         Major Subject:~~\uppercase\expandafter{\@department}\\
         \ifnum\numcomm < 7 \vskip 32pt \else \vskip 24pt \fi
         \sigblock
         \ifnum \numcomm < 7 \vskip 32pt \else \vskip 24pt \fi
         Rensselaer Polytechnic Institute\\
         Troy, New York\\ [14pt]
         \ifnum\numcomm>6 \vskip -8pt \fi
         \@submitdate
     \end{center}
     \end{singlespace}
     \newpage
     \pagestyle{plain}
%    \pagenumbering{roman}
%    \setcounter{page}{2}
}

% Abstract title page
 \def\abstitlepage{%
     \if@twoside\thispagestyle{empty}\cleardoublepage\fi
     \pagenumbering{roman}
     \thispagestyle{empty}
     \ifnum\numcomm<4 \vglue .5in \fi  % masters
     \begin{singlespace}
     \begin{center}
         \parindent=0pt
         \vglue 24pt plus 24pt minus 12pt
         {\def\baselinestretch{1.2}\large\bf\uppercase \expandafter{\@thesistitle} \par\smallskip}
         {\def\baselinestretch{1.2}\normalsize\bf\uppercase \expandafter{\@thesissubtitle} \par\bigskip\bigskip} 
         By \par\bigskip
         {\def\baselinestretch{1.2}\large \expandafter{\@author} \par\bigskip\bigskip} 
         {\def\baselineskip{1.25}A \maindoctype Submitted to the Graduate \par\medskip Faculty of Rensselaer Polytechnic Institute \par\medskip in Partial Fulfillment of the \par\medskip Requirements for the Degree of \par\bigskip}
         {\uppercase\expandafter{\@degree} \par\bigskip}
         Major Subject:~~\uppercase\expandafter{\@department}\par\bigskip\bigskip
         {\def\baselineskip{1.25} The original of the complete thesis is on file in the \par\medskip 
         Rensselaer Polytechnic Institute Library }
       \vfill
       \sigblockabs
       \vskip 36pt plus 2pt minus 12pt
        Rensselaer Polytechnic Institute\\
        Troy, New York\\ [12pt]
         \@submitdate
     \end{center}
     \end{singlespace}
     \newpage
     \pagestyle{plain}
%    \pagenumbering{roman}
%    \setcounter{page}{2}
}

\def\copyrightpage{
    \hbox{ }
    \vfill
    \begin{center}
    \copyright\ Copyright \@copyrightyear \\
    by \\
    \@author \\
    All Rights Reserved \\ [12pt]
    \end{center}
    \clearpage}
    
\def\dedicationpage{
    \pagenumbering{roman}
    \thispagestyle{empty}
    \par\vspace*{.25\textheight}
    \begin{center}
    \LARGE \@dedication \\
    \end{center}
    \clearpage}

% Some variable definitions
% make the following names uppercase:
\renewcommand\contentsname{CONTENTS}
\renewcommand\listfigurename{LIST OF FIGURES}
\renewcommand\listtablename{LIST OF TABLES}
\renewcommand\bibname{BIBLIOGRAPHY}
\renewcommand\indexname{INDEX}
\renewcommand\partname{PART}
\renewcommand\chaptername{CHAPTER}
\renewcommand\appendixname{APPENDIX}
\renewcommand\abstractname{ABSTRACT}

\renewcommand\chaptersize{\Large}
\renewcommand\sectionsize{\large}
\renewcommand\subsectionsize{\normalsize}
\renewcommand\subsubsectionsize{\normalsize}

\raggedbottom

\setstretch{1.4}        % at 11 or 12pt this is line-and-a-half spacing
\parindent .3in         % Width of paragraph indentation

\markboth{}{}           % Do not include chapter titles in headers;
\pagestyle{myheadings}  % include just page numbers in upper right

% For a bibliography that is ragged right
%\renewcommand{\bibalign}{\raggedright}  

% For a fully justified bibliography
\renewcommand{\bibalign}{}

\endinput

% End of file `thesis.cls'.
