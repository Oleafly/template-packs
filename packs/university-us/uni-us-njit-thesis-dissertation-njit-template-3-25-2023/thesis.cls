% Version of March 2023.

% The original file was obtained from GSO website, and is the result of previous efforts done by NJIT students and members.

% A most recent version was updated by Keven Alkhoury and Ludvik Alkhoury on 03/16/2023, following a PhD thesis review.

% Prospective NJIT students are encouraged to maintain/update this template, as per GSO guidelines.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2000/03/22 NJIT Dissertation LaTeX class]

\LoadClass[12pt]{report}
\RequirePackage{lscape}
\bibliographystyle{IEEEtran}
%\bibliographystyle{acm}

\DeclareOption*{%
      \PassOptionsToClass{\CurrentOption}{report}%
}

\ProcessOptions


%%%% FIGURE CAPTION PROBLEM :  March 12 fix %%%%%%%%%%
\lefthyphenmin=5
\righthyphenmin=6
%%%% FIGURE CAPTION PROBLEM : March 12 fix %%%%%%%%%%

% ACNJ 28/01/2001  : TABLE OF CONTENTS PAGE
%\renewcommand\tableofcontents{%
%    \chapter*{\contentsname}
%    \vskip 10pt
%	\usebox{\toctopbox}\par
%	\gdef\@texttop{\toc1}
%    \@starttoc{toc}
%	\newpage
%	\gdef\@texttop{}
%}
% ACNJ 28/01/2001  : TABLE OF CONTENTS PAGE

% ACNJ 28/01/2001  : LIST OF FIGURES PAGE
%\renewcommand\listoffigures{%
%    \chapter*{\listfigurename}
%    \vskip 10pt
%	\usebox{\loftopbox}\par
%	\gdef\@texttop{\lof1}
%    \@starttoc{lof}
%	\newpage
%	\gdef\@texttop{}
%}
% ACNJ 28/01/2001  : LIST OF FIGURES PAGE

% ACNJ 28/01/2001  : LIST OF TABLES PAGE
%\renewcommand\listoftables{%
%    \chapter*{\listtablename}
%    \vskip 10pt
%	\usebox{\lottopbox}\par
%	\gdef\@texttop{\lot1}
%    \@starttoc{lot}
%	\newpage
%	\gdef\@texttop{}
%}
% ACNJ 28/01/2001  : LIST OF TABLES PAGE

% MARCH 12 FIX for TOC
\renewcommand\tableofcontents{%
    \chapter*{\contentsname}
    \vskip 10pt
    \usebox{\toctopbox}\par \vspace{2ex}   %% vert. spacing between Chapter and next line
    \gdef\@texttop{\toc1}
    {\msp \@starttoc{toc}}  %% changes spacing in TOC
    \newpage
    \gdef\@texttop{}
}
% MARCH 12 FIX for TOC

% MARCH 12 FIX for LOF 
\renewcommand\listoffigures{%
    \chapter*{\listfigurename}
    \vskip 10pt
    \usebox{\loftopbox}\par \vspace{2ex}
    \gdef\@texttop{\lof1}
    {\msp \@starttoc{lof}}
    \newpage
    \gdef\@texttop{}
}
% MARCH 12 FIX for LOF

% MARCH 12 FIX for LOT
\renewcommand\listoftables{%
    \chapter*{\listtablename}
    \vskip 10pt
        \usebox{\lottopbox}\par \vspace{2ex}
        \gdef\@texttop{\lot1}
    {\msp \@starttoc{lot}}
        \newpage
        \gdef\@texttop{}
}
% MARCH 12 FIX for LOT

%%%%%%%%%%%%%% INDENTS LINES AFTER FIRST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MARCH 12 FIX for TOC
\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip \z@ plus .2pt
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima 
   \advance\leftskip 1em \hbox{}\hskip 
  -\leftskip 
   #4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill \nobreak 
           \hbox to\@pnumwidth{\hfil\rm #5}\par\vskip 1.8ex}\fi}
%%%%%%%%%%%%%% INDENTS LINES AFTER FIRST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\def\l@chapter#1#2{
%  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
%    \vskip 1.0em \@plus\p@
%    \setlength\@tempdima{1.5em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode
%      \advance\leftskip\@tempdima
%      \hskip -\leftskip
%      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%      \penalty\@highpenalty
%    \endgroup
%  \fi}

% copied from Jerry's style file
\def\thedots{\cleaders\hbox{$\m@th \mkern4.5mu . \mkern4.5mu$}\hfill}
\def\l@chapter{\@dottedtocline{1}{0.000001mm}{1.4em}}
\def\l@section{\@dottedtocline{1}{1.4em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.7em}{3em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}  

% MARCH 12 FIX FOR TOC,LOF,LOT
\def\l@figure{\@dottedtocline{1}{0.001em}{2.5em}}
\let\l@table\l@figure

% MY OLD MARGIN SETTINGS
%\topmargin		+.55in
%\oddsidemargin		.35in
%\evensidemargin 	.15in
%\textheight		9.0in
\textwidth		6.0in
%\parindent		35pt


% JERRY's STYLE FILE SETTINGS
%\topmargin=.2in
\topmargin=-.375in
\oddsidemargin=0.505in          % was 0.495 - annette asked for a little more
\evensidemargin=0in
\textheight=9.0in
%\textwidth=5.95in
\parindent=0.4in
\headsep=0.3in              % Distance between page nums and text
\itemindent=0.8in
%\footheight 0.2in
\footskip=0.5in            % default is 0.5 in and page numbers come out too low
%\marginparsep=10pt
%\marginparwidth=40pt
%\topmargin=-0.375in            % Put the pagenumber in the correct place

% Use 1.65 times the normal baseline-to-baseline skip
% for the appearance of double spacing
\renewcommand{\baselinestretch}{1.65}



% USE UOD STYLE FILE
%\setlength{\oddsidemargin}{.54in}
%\setlength{\evensidemargin}{0in}
%\setlength{\topmargin}{-.24in}
%\setlength{\headsep}{20pt}
%\setlength{\parindent}{3em}
%\setlength{\textheight}{8.25in}
%\setlength{\textwidth}{5.9in}

% Disallow all widows and orphans (clubs)
\widowpenalty=10000
\clubpenalty=10000

\setlength\belowdisplayskip{20pt}
\setlength\belowdisplayshortskip{20pt}

\setlength\abovecaptionskip{5pt}

\let\footnotesize\small

\newif\if@appendix
\@appendixfalse

\renewcommand{\baselinestretch}{2}

% to change figure caption font if needed
\newcommand{\normalsizeADIE}{\fontsize{12}{12}\selectfont}

\renewcommand{\normalsize}{\fontsize{12}{12}\selectfont}
\renewcommand{\large}{\fontsize{12}{12}\selectfont}
\renewcommand{\Large}{\fontsize{12}{12}\selectfont}
\renewcommand{\LARGE}{\fontsize{12}{12}\selectfont}
\renewcommand{\huge}{\fontsize{12}{12}\selectfont}
\renewcommand{\Huge}{\fontsize{12}{12}\selectfont}

\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\bibname}{BIBLIOGRAPHY}
\renewcommand{\indexname}{INDEX}
%\renewcommand{\thefootnote}{\fnsymbol{footnote}}
%\renewcommand{\thempfootnote}{\arabic{mpfootnote}}

% define different line spacings
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\msp{\def\baselinestretch{1.2}\large\normalsize}
\def\dsp{\def\baselinestretch{1.65}\large\normalsize}

\def\@roman#1{{\bf\romannumeral #1}}

% in plain pagestyle, page numbering is in footers at bottom centre of page
\def\ps@plain{%
      \let\@oddhead\@empty
      \def\@oddfoot{\normalfont\hfil{\bf\thepage}\hfil}%
      \def\@evenfoot{\normalfont\hfil{\bf\thepage}\hfil}
}

\def\bm#1{\mbox{\boldmath $#1$}}
\def\trademark{$^{\tt TM}$ }

% on chapter pages, page style is plain and so page numbering
% goes at the bottom of the page
\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
\@afterindentfalse \secdef\@chapter\@schapter} 

\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]
	\else \@makeschapterhead{#1} 
	\@afterheading\fi}

% HKT 06/30/2003: Add \MakeUppercase to capitalize the chapter.
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
	\refstepcounter{chapter}
	\typeout{\@chapapp \space\thechapter.}
	\if@appendix{\addcontentsline{toc}{chapter}%
		{\protect\numberline{\appendixname~\thechapter}\hspace*{0.95in}\MakeUppercase{#1}}}%
	\else{\addcontentsline{toc}{chapter}%
             	{\protect\numberline{\thechapter}\MakeUppercase{#1}}}
	\fi
\else
	\addcontentsline{toc}{chapter}{\MakeUppercase{#1}}
\fi
	\chaptermark{#1}
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}] 
	\else \@makechapterhead{#2}
 		\@afterheading 
	\fi} 

\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \center \bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 5\p@
    \fi
    \interlinepenalty\@M
    \center \bfseries \MakeUppercase{#1}\par\nobreak
    % HKT 07/01/2003: fix the space between chapter name and body text.
    \vskip 35\p@
  }}

\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \center \bfseries \MakeUppercase{#1}\par\nobreak }}




\def\section{\@startsection {section}{1}{\z@}
            {-4ex}{0.01ex plus 0.01ex}
            {\bf\center}}
\def\subsection{\@startsection{subsection}{2}{\z@}
            {-3ex}{0.01ex plus 0.01ex}
            {\bf}}
% HKT 07/16/2003: fixed the spacing problem after subsubsection heading
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
%            {-4ex}{-0.01em}
            {+3.25ex \@plus1ex \@minus.2ex}%
            {-1em}%
            {\bf}}

\def\@starttoc#1{%
  {\begingroup
   	\topskip .7in
%	\topskip .2in
    \makeatletter
    \@input{\jobname.#1}%
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \@nobreakfalse
  \endgroup}}

% ACNJ 28/01/2001  : definition of box within the TOC page
\newsavebox{\toctopbox}
\savebox{\toctopbox}[\textwidth]{\bf Chapter \hfill Page}
\def\toc1{%
\gdef\@texttop{
\parindent 0pt \raggedleft 
{\msp
\begin{center}
	\bf \contentsname
	\vskip -1pt(Continued)
%	\vskip -10pt(Continued)
	\usebox{\toctopbox}
\end{center}
}
\vskip -.5in \par}}
% ACNJ 28/01/2001  : definition of box within the TOC page

% ACNJ 28/01/2001  : definition of box within the LOF page
\newsavebox{\loftopbox}
\savebox{\loftopbox}[\textwidth]{\bf Figure \hfill Page}
\def\lof1{%
\gdef\@texttop{
\parindent 0pt \raggedleft 
{\msp
\begin{center}
	\bf \listfigurename
	\vskip -1pt(Continued)
%	\vskip -10pt(Continued)
	\usebox{\loftopbox}
\end{center}
}
\vskip -.5in \par}}
% ACNJ 28/01/2001  : definition of box within the LOF page

% ACNJ 28/01/2001  : definition of box within the LOT page
\newsavebox{\lottopbox}
\savebox{\lottopbox}[\textwidth]{\bf Table \hfill Page}
\def\lot1{%
\gdef\@texttop{
\parindent 0pt \raggedleft 
{\msp
\begin{center}
	\bf \listtablename
	\vskip -1pt(Continued)
%	\vskip -10pt(Continued)
	\usebox{\lottopbox}
\end{center}
}
\vskip -.5in \par}}
% ACNJ 28/01/2001  : definition of box within the LOT page

% ACNJ 28/01/2001  : FORMAT FOR APPENDICES
\renewcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
  \@appendixtrue}
% ACNJ 28/01/2001  : FORMAT FOR APPENDICES
% ACNJ 28/01/20

% USE THIS COMMAND \defensedate{Month}{Day}{Year} % 
\newcommand{\defensedate}[3]{%
	\def\defensemonth{#1}
	\def\defenseday{#2}
	\def\defenseyear{#3}
}

\def\department#1{\gdef\@department{#1}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}

% ACNJ 28/01/2001  : TITLE PAGE FOR NJIT STYLE FILE FORMAT
\renewcommand{\maketitle}{%
	\newpage
	\thispagestyle{empty}
	\pagenumbering{roman}
	\begin{center}
		\bfseries \singlespace\MakeUppercase{\@title}
		\vskip 3.0in by
		\par \@author
		\vfill
		A Dissertation
		\par Submitted to the Faculty of
		\par New Jersey Institute of Technology
		\par in Fulfillment of the Requirements for the Degree of
		\par Doctor of Philosophy in Electrical Engineering
		\vskip 20pt
		\par Helen and John C. Hartmann \\ Department of Electrical and Computer Engineering
		%\par Department of \@department
		\vskip 20pt
		\par \defensemonth~\defenseyear
	\end{center}
}
% ACNJ 28/01/2001  : TITLE PAGE FOR NJIT STYLE FILE FORMAT

\def\abstract#1{\gdef\@abstract{#1}}
\def\@abstract{\@latex@warning@no@line{No \noexpand\abstract given}}

% ACNJ 28/01/2001  : ABSTRACT PAGE FOR NJIT THESIS FORMATTING STYLE
\newcommand{\makeabstract}
        % HKT 06/30/2003: change \thispagestyle to \pagestyle for the case when the abstract is longer than one page.
	{\newpage\pagestyle{empty}
	%\pagenumbering{roman}
	\begin{center}%
		\bfseries \singlespace ABSTRACT
		\vskip 15pt
		\MakeUppercase{\@title}
		\vskip 15pt
		by \par \@author
		\vskip 5pt
	\end{center}
	\@abstract
	% HKT 06/30/2003: append below line to fix the case when the abstract is longer than one page.
        \newpage\pagestyle{plain}}
% ACNJ 28/01/2001  : ABSTRACT PAGE FOR NJIT THESIS FORMATTING STYLE

% ACNJ 28/01/2001  : COPYRIGHT PAGE FOR NJIT THESIS FORMATTING STYLE
\newcommand{\makecopyright}{%
	\newpage\thispagestyle{empty}
	\begin{center}
		\topskip 3.5in
		Copyright \copyright ~\defenseyear~ by \@author
		\par ALL RIGHTS RESERVED
	\end{center}
	\newpage
}
% ACNJ 28/01/2001  : COPYRIGHT PAGE FOR NJIT THESIS FORMATTING STYLE

\def\advisor#1#2{\gdef\@advisorname{#1}\gdef\@advisortitle{#2}}
\def\@advisorname{\@latex@warning@no@line{No \noexpand\advisorname given}}
\def\@advisortitle{\@latex@warning@no@line{No \noexpand\advisortitle given}}

\newif\if@members
\@membersfalse

% ACNJ 28/01/2001  : formatting for members of committee, within approval page
\def\member#1#2{
	\if@members
		\edef\@committee{
			\@committee, 
			{#1, Committee Member \hfill Date \par #2}
		}
	\else
		\def\@committee{
			{#1, Committee Member \hfill Date \par #2}
		}
		\@memberstrue
	\fi
}	
% ACNJ 28/01/2001  : formatting for members of committee, within approval page

% ACNJ 28/01/2001  : APPROVAL PAGE FOR NJIT THESIS FORMATTING STYLE
\newcommand{\makeapproval}{%
	\newpage\thispagestyle{empty}
	\begin{center}
		\bfseries \singlespace APPROVAL PAGE
		\vskip 15pt
		\MakeUppercase{\@title}
		\vskip 15pt \@author
	\end{center}
	{\singlespace 
	\vskip .5in 
	\flushleft{}
% ESA 12/2001    : made the line thicker as request of Graduate Studies
%                  Office
% HKT 02/02/2002 : used \rule to draw thicker line
%        \hrule \vskip 0.1pt %%To make a line thicker	
%        \hrule \vskip 0.1pt %%To make a line thicker
%	 \hrule \vskip 2pt
	\rule{\textwidth}{1.0pt}
	\@advisorname, Dissertation Advisor \hfill Date
	\par \@advisortitle
	{\@for \committee:=\@committee \do{
			\vfill
			\flushleft{}
                        % \hrule \vskip 0.1pt %%To make a line thicker	
			% \hrule \vskip 0.1pt %%To make a line thicker
			% \hrule \vskip 2pt
			\rule{\textwidth}{1.0pt}
			\committee
	}}
        %% change this vspace below and you change how close the committee member
        %% signature lines are to one another.
        %% it automatically does this because of the \vfill above.
        \vskip 1.3in  %% controls spacing to bottom of page
	\newpage
	\endsinglespace}
}
% ACNJ 28/01/2001  : APPROVAL PAGE FOR NJIT THESIS FORMATTING STYLE

\def\major#1{\gdef\@major{#1}}
\def\@major{\@latex@warning@no@line{No \noexpand\major given}}
\def\birthdate#1{\gdef\@birthdate{#1}}
\def\@birthdate{\@latex@warning@no@line{No \noexpand\birthdate given}}
\def\birthplace#1{\gdef\@birthplace{#1}}
\def\@birthplace{\@latex@warning@no@line{No \noexpand\birthplace given}}

\newif\if@degrees
\@degreesfalse

% ACNJ 28/01/2001  : formatting for degrees, within biography page 
\def\degree#1#2{
	\if@degrees
		\edef\@degrees{
			\@degrees, 
			{#1\vskip -2.5pt #2}
		}
	\else
		\def\@degrees{
			{#1\vskip -2.5pt #2}
		}
		\@degreestrue
	\fi
}	
% ACNJ 28/01/2001  : formatting for degrees, within biography page 

% ACNJ 28/01/2001  : BIOGRAPHY PAGES FOR NJIT THESIS FORMATTING STYLE
\newcommand{\makebiography}{%
	\newpage
	\begin{center}
		\bfseries BIOGRAPHICAL SKETCH
	\end{center}
	\begin{tabbing}
		\hskip 1.5in \= \kill
		\par\noindent {\bf Author:} \> \@author \\
		\par\noindent {\bf Degree:} \> Doctor of Philosophy \\
%%%%%		\par\noindent {\bf Degree:} \> Doctor of Philosophy in \@major \\
		\par\noindent {\bf Date:} \> \defensemonth~\defenseyear 
		%\par\noindent {\bf Date of Birth:} \> \@birthdate \\
		%\par\noindent {\bf Place of Birth:} \> \@birthplace
	\end{tabbing}
	\par\noindent {\bf Undergraduate and Graduate Education:}
	%  ACNJ 28/01/2001  : \printdegree command definitely elsewhere
	\vskip -20pt\printdegrees 
	\begin{tabbing}
		\hskip 1.5in \= \kill
		\par\noindent {\bf Major:} \> \@major
	\end{tabbing}
	\par\noindent {\bf Presentations and Publications:}
	%  ACNJ 28/01/2001  : \printpublications command definitely elsewhere
	\printpublications
	\newpage
}
% ACNJ 28/01/2001  : BIOGRAPHY PAGES FOR NJIT THESIS FORMATTING STYLE

% ACNJ 28/01/2001  : ACKNOWLEDGEMENT PAGE FOR NJIT THESIS FORMATTING STYLE
\def\acknowledgment#1{\gdef\@acknowledgment{#1}}
\def\@acknowledgment{\@latex@warning@no@line{No \noexpand\acknowledgment given}}

\newcommand{\makeacknowledgment}
	{\newpage
	\begin{center}%
		\bfseries ACKNOWLEDGMENT
		% HKT 07/02/2003: fix the gap between heading and body text
		\vskip 20\p@
	\end{center}
	\@acknowledgment}
% ACNJ 28/01/2001  : ACKNOWLEDGEMENT PAGE FOR NJIT THESIS FORMATTING STYLE

% ACNJ 19/03/2001  : LIST OF SYMBOLS PAGE FOR NJIT THESIS FORMATTING STYLE
\def\listofsymbols#1{\gdef\@listofsymbols{#1}}
\def\@listofsymbols{\@latex@warning@no@line{No \noexpand\listofsymbols given}}

%\newsavebox{\lostopbox}
%\savebox{\lostopbox}[\textwidth]{\bf Symbol \hfill  Description}
\def\los1{%
\gdef\@texttop{
\parindent 0pt \raggedleft 
%%%%%%%% March 12 Naire fix%%%%%%%%%
{\msp \begin{center}
        \bf  %LIST OF SYMBOLS 
        \vskip -20pt %(Continued)
%\        \usebox{\lostopbox}
\end{center}}
%%%%%%%%%%%%%%%%%
\vskip 0pt \par}}

\newcommand{\makelistofsymbols}
{%
%       \newpage
%       \begin{center}%
%               \bfseries LIST OF SYMBOLS
%       \end{center}
        \chapter*{LIST OF SYMBOLS}
        \vskip 10pt
%        \usebox{\lostopbox}\par \vspace{1ex}
        \gdef\@texttop{\los1} 
        {\msp \@listofsymbols}             
        \newpage
        \gdef\@texttop{}
}












% ========================================================
% LIST OF Greek Symbols -- Ludvik ALkhoury Feb 12, 2023
% ========================================================

\def\listofGsymbols#1{\gdef\@listofGsymbols{#1}}
\def\@listofGsymbols{\@latex@warning@no@line{No \noexpand\listofGsymbols given}}

%\newsavebox{\lostopbox}
%\savebox{\lostopbox}[\textwidth]{\bf Symbol \hfill  Description}
\def\logs1{%
	\gdef\@texttop{
		\parindent 0pt \raggedleft 
		%%%%%%%% March 12 Naire fix%%%%%%%%%
		{\msp \begin{center}
				\bf  LIST OF G SYMBOLS 
				\vskip -1pt (Continued)
				%\        \usebox{\lostopbox}
		\end{center}}
		%%%%%%%%%%%%%%%%%
		\vskip 10pt \par}}

\newcommand{\makelistofGsymbols}
{%
	%       \newpage
	%       \begin{center}%
		%               \bfseries LIST OF SYMBOLS
		%       \end{center}
	\chapter*{LIST OF G SYMBOLS}
	\vskip 10pt
	%        \usebox{\lostopbox}\par \vspace{1ex}
	\gdef\@texttop{\logs1} 
	{\msp \@listofGsymbols}             
	\newpage
	\gdef\@texttop{}
}

% ========================================================
% END -- Ludvik ALkhoury Feb 12, 2023
% ========================================================






% ACNJ 22/03/2001  : GLOSSARY OF BIOLOGICAL SYMBOLS 
\def\glossaryofterms#1{\gdef\@glossaryofterms{#1}}
\def\@glossaryofterms{\@latex@warning@no@line{No \noexpand\glossaryofterms given}}

\def\gloss1{%
\gdef\@texttop{
\parindent 0pt \raggedleft 
{\msp \begin{center}
        \bf  %LIST OF ABBREVIATIONS
        \vskip -20pt% (Continued)
%\        \usebox{\glosstopbox}
\end{center}}
%%%%%%%%%%%%%%%%%
\vskip 0pt \par}}

\newcommand{\makeglossaryofterms}
{%
%       \newpage
%       \begin{center}%
%               \bfseries LIST OF SYMBOLS
%       \end{center}
        \chapter*{LIST OF ABBREVIATIONS}
        \vskip 10pt
%        \usebox{\lostopbox}\par \vspace{1ex}
        \gdef\@texttop{\gloss1} 
        {\msp \@glossaryofterms}             
        \newpage
        \gdef\@texttop{}
}


% DEDICATION FORMAT altered, 6 Mar 2001 ACNJ
\def\dedication#1{\gdef\@dedication{#1}}
\def\@dedication{\@latex@warning@no@line{No \noexpand\dedication given}}

% ACNJ 28/01/2001  : DEDICATION PAGE FORMATTING
\newcommand{\makededication}
        {\newpage
        \begin{center}
                \topskip 3.5in
                \@dedication
        \end{center}
}
% ACNJ 28/01/2001  : DEDICATION PAGE FORMATTING


% ACNJ 28/01/2001  : formatting for printing degree list, within biography page 
\def\printdegrees{
	%{DEGREE\\SCHOOL}
	\begin{itemize}
		{\@for \onedegree:=\@degrees \do{
			\singlespace
			\item \onedegree 
			\vskip -10pt
		}}
		%\vskip -10pt
	\end{itemize}
}
% ACNJ 28/01/2001  : formatting for printing degree list, within biography page 

\def\publications#1{\gdef\@publications{#1}}
\def\@publications{\@latex@warning@no@line{No \noexpand\publications given}}

% ACNJ 28/01/2001  : SPECIAL BIOGRAPHY FORMAT FOR PUBLICATIONS, within biography page
\newenvironment{biobibliography}[1]
     { \vskip -20pt\singlespace
       \list{}
	   % {\@biblabel{\@arabic\c@enumiv}}%  %% 02/01 commenting out removes numbering
             {\settowidth\labelwidth{\@biblabel{#1}}%
	     \setlength{\leftmargin}{0pt}   %% added 02/01, no indentation due to list
           % \leftmargin\labelwidth   %% commented out 02/01, problem in biographical sketch with bibliography listing
           % \advance\leftmargin\labelsep  %% commented out 02/01, problem in biographical sketch with bibliography listing 
%%%%%%%%%%%%%%%%%%%%%%  02/01/2001 new section added to give indentation after first line of biblio refs
             \newlength{\bibhang}
             \setlength{\bibhang}{0.5in}
             \setlength{\itemindent}{-\bibhang}              %  is undefined.
             \setlength{\leftmargin}{\bibhang}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  02/01/2001 new section added to give indentation after first line of biblio refs
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m\endsinglespace}
     {\def\@noitemerr
       {\@latex@warning{Empty `biobibliography' environment}}%
      \endlist}
% ACNJ 28/01/2001  : SPECIAL BIOGRAPHY FORMAT FOR PUBLICATIONS, within biography page

% ACNJ 28/01/2001  : formatting for printing publications list, within biography page 
\newcounter{biobib}
\def\printpublications{
	%{AUTHOR\\TITLE\\JOURNAL\\VOLUME\\YEAR}
	\begin{biobibliography}{0}
	{\@for \publication:=\@publications \do{
			\bibitem{\thebiobib} \publication
			\addtocounter{biobib}{1}
	}}
	\end{biobibliography}
}
% ACNJ 28/01/2001  : formatting for printing publications list, within biography page 

\renewenvironment{thebibliography}[1]
	 {\chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
		\singlespace
		% HKT 07/02/2003: fix the gap between heading and bib entries
		\vskip 33\p@
		\addcontentsline{toc}{chapter}{\bibname}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
       %%%%     \leftmargin\labelwidth
       %%%%     \advance\leftmargin\labelsep
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  02/01/2001 new section added to give indentation after first line of biblio refs
             \newlength{\bibhangADIE}
             \setlength{\bibhangADIE}{0.5in}
             \setlength{\itemindent}{-\bibhangADIE}              %  is undefined.
             \setlength{\leftmargin}{\bibhangADIE}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  02/01/2001 new section added to give indentation after first line of biblio refs
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m
	  \endsinglespace}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% ACNJ 28/01/2001  : INTRODUCTORY PAGES FOR NJIT THESIS FORMATTING STYLE
\def\initthesis{
	\makeabstract
	\maketitle
	\makecopyright
	\makeapproval
	\makebiography
	\makededication
	\makeacknowledgment
} 
% ACNJ 28/01/2001  : INTRODUCTORY PAGES FOR NJIT THESIS FORMATTING STYLE

% ACNJ 28/01/2001  : START MAIN BODY OF TEXT/CHAPTERS OF THESIS
% in main text body, page numbering is at top right of page.
% we are in report style.
\def\startbody{
	\newpage
	\pagestyle{plain}
	\pagenumbering{arabic}
	\def\@evenhead{{\bf\thepage}\hfil\slshape\leftmark}%
	%\def\@oddhead{{\slshape\rightmark}\hfil{\bf\thepage}}%
}
% ACNJ 28/01/2001  : START MAIN BODY OF TEXT/CHAPTERS OF THESIS

% CAPTION FORMATTING  - note Figure is placed in bold font
% edited 31/01/2001

 \long\def\@makecaption#1#2{%
 \singlespace
 \vskip\abovecaptionskip
 % SAK 29/03/2002: Remove colon ":" after caption number
 \setbox\@tempboxa\hbox{{\bfseries#1\enspace}{\normalsizeADIE#2}}	%% ***different
 \ifdim \wd\@tempboxa >\hsize
         {\bfseries#1\enspace} {\normalsizeADIE#2}\par
 \else 
         \global \@minipagefalse
          \hb@xt@\hsize{\box\@tempboxa\hfil}% 
%          \hb@xt@\hsize{\box\@tempboxa}% 
 \fi
 \vskip\belowcaptionskip
 \endsinglespace}
% CAPTION FORMATTING 


\renewcommand\footnoterule{%
  \kern-3\p@
  \vskip 10pt
  \hrule\@width.4\columnwidth
  \kern2.6\p@}

\renewcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@0.4em{\hss\@makefnmark}#1}

\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
	\edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

\def\@verbatim{%
	\trivlist%
	\vskip\topskip%
	\def\baselinestretch{1}%
	\ifx\@currsize\normalsize\@normalsize\else\@currsize\fi%
	\vskip-\topskip%
	\item[]\if@minipage\else\vskip\parskip\fi
	\leftskip\@totalleftmargin\rightskip\z@
	\parindent\z@\parfillskip\@flushglue\parskip\z@
	\@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par}
	\obeylines \tt \catcode``=13 \@noligs \let\do\@makeother \dospecials}

\def\verbatim{\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}
\let\endverbatim=\endtrivlist

\def\singlespace{%
	\vskip\parskip%
	\vskip\baselineskip%
	\def\baselinestretch{1}%
	\ifx\@currsize\normalsize\@normalsize\else\@currsize\fi%
	%\tiny\normalsize%
	\vskip-\parskip%
	\vskip-\baselineskip%
}

\def\endsinglespace{\par}

% ACNJ 28/01/2001  : Giorgio created an index environment but this
% was not supported by Graduate Studies
\renewenvironment{theindex}
	{\newpage\if@twocolumn
		\@restonecolfalse
	\else
		\@restonecoltrue
	\fi
	\columnseprule \z@
	\columnsep 35\p@
	\twocolumn[\@makeschapterhead{\indexname}\vskip 20pt]%
	\addcontentsline{toc}{chapter}{\indexname}
	\singlespace
   	\@mkboth{\MakeUppercase\indexname}%
		{\MakeUppercase\indexname}%
   	\thispagestyle{plain}\parindent\z@
   	\parskip\z@ \@plus .3\p@\relax
   	\let\item\@idxitem}
   	{\if@restonecol\onecolumn\else\clearpage\fi}
% ACNJ 28/01/2001  : Giorgio created an index environment but this
% was not supported by Graduate Studies

%% copied from UD style file
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsizeADIE
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup
}

% FOR PREFACE
\def\preface{
    \pagestyle{plain}
    \newpage
%    \addcontentsline{toc}{chapter}{\protect \numberline{PREFACE}}
    \addcontentsline{toc}{chapter}{PREFACE}
    {\bf \centerline {PREFACE}}
    \vskip 1em
    \noindent
    \hspace{-0.7em}
    }

\def\endpreface{
    \newpage
    }

% Single space tabular environment - cdp
%\def\tabular{\ssp \def\@halignto{}\@tabular}
