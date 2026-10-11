%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	    		 iiscthes.sty                                 %
%			 ------------				      %
% Indian Institute of Science thesis style            		      %
%    -- modifications to the report style			      %
% For LaTeX version 2.09					      %
%								      %
% By Sanjay R. Chitnis, CSA					      %
%                                                                     %
% Based on the Stanford University and MIT thesis styles.	      %
% Send any bugs / suggestions for modifications to		      %
% csa!chitnis@vigyan.ernet.in                  			      %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                     %
% Version 1.21 Thu Apr 23 04:56:37 1992                               %
%   markboth added for prefacesections                                %
%   definition of comment modified                                    %
% Version 1.2 Mar. 30, 1992					      %
%   Page sizes now in cm                                              %
% Version 1.1 Nov. 19, 1991					      %
%   New fonts for title page                                          %
% Version 1.0 April 14,1991					      %
%   iisclogo added	                                              %
% Version 0.0 Sept 14,1990                                            %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                     %
% You are free to copy and modify this style; however if you modify,  %
% you should change the name to something other than iiscthes.sty.    %
% If you do not  have any  of the  used style files / fonts etc., you %
% will have to modify this style.				      %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\typeout{Document Style `iiscthes' Ver 1.2 <30 Mar 1992>.}
\input{report.cls}

\long\def\begincomment#1\endcomment{}

\begincomment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Contents:
---------
1. Example of use :removed to thessamp.tex
2. Documentation  :removed to thessamp.tex
3. Error checking
4. Page layout
5. Line spacings
6. Macros,fonts for title page
7. Some additional macros
8. Modifications of some predefined macros
\endcomment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3. Error Checking
%-----------------

% First thing we do is make sure that report has been loaded.  A
% common error is to try to use iiscthesis as a documentstyle.
%\@ifundefined{chapter}{\@latexerr{The `iiscthesis' option should be used
%with the `report' document style}{You should probably read the
%iiscthesis documentation.}}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4. Page layout
%--------------

% We need 1" margins except on the binding edge, where it is 1 1/2"
% Theses are single-sided, so we don't care about \evensidemargin
\oddsidemargin 0.46cm \evensidemargin 0.46cm % + 1inch= 3cm
\marginparwidth 40pt \marginparsep 10pt
\topmargin 0pt \headsep 30pt
\textheight 22.5cm \textwidth 16cm

% Disallow page breaks at hyphens (this will give some underfull vbox's,
% so an alternative is to use \brokenpenalty=100 and manually search
% for and fix such page breaks)
\brokenpenalty=10000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%5. Line spacing
%---------------

% from doublespace.sty
% Lifted from LaTeX style archive at Clarkson university.
%
% Note: This version sets a baselinestretch of 1.5. If this is too much,
%    put  \setstretch{1.3}  (or some appropriate value) before the
%    \begin{document} command. To print the document with single spacing
%    again, without removing "singlespace" environments, just put a
%    \setstretch{1} at the top of the document.
%
% PLEASE REPORT ANY BUGS
%
% Modified by: Jean-Francois Lamy
%                          lamy@ai.toronto.edu
%                          lamy@utai.uucp
%
% Author: Stephen Page  -- sdpage@prg.oxford.ac.uk
%                          sdpage%prg.oxford.ac.uk@cs.ucl.ac.uk
%
% Release date: 6 July 1986 - September 3, 1986
%
% Known bugs:
%    . It might be nice if spacing before the footnote rule (\footins)
%      were provided in a tidier way.
%    . Increasing struts may possibly cause some other obscure part of
%      formatting to fall over.
%    . \begin{singlespace}\begin{quote} produces the wrong spacing before
%      the quote (extra glue is inserted).
%    . shouldn't @setsize stretch parskip as well?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---Set up 1.5 spacing

\def\baselinestretch{1.5}


%---New command "\setstretch" (slightly more mnemonic... and easier to type)

\def\setstretch#1{\renewcommand{\baselinestretch}{#1}}

%---Stretch the baseline BEFORE calculating the strut size. This improves
%   spacing below tabular environments etc., probably...
%   Comments are welcomed.

\def\@setsize#1#2#3#4{\@nomath#1%
   \let\@currsize#1\baselineskip
   #2\baselineskip\baselinestretch\baselineskip
   \parskip\baselinestretch\parskip
   \setbox\strutbox\hbox{\vrule height.7\baselineskip
      depth.3\baselineskip width\z@}%
   \normalbaselineskip\baselineskip#3#4}


%---Increase the space between last line of text and footnote rule.
%   This is a very untidy way to do it!

\skip\footins 20pt plus4pt minus4pt


%---Reset baselinestretch within footnotes and floats. Originally stolen
%   from Stanford thesis style.

% Redefine the macro used for floats (including figures and tables)
% so that single spacing is used.
% (Note \def\figure{\@float{figure}set single spacing} doesn't work
%  because figure has an optional argument)

%  %This section commented out because it was giving an error while compiling  %Shashank
% \def\@xfloat#1[#2]{\ifhmode \@bsphack\@floatpenalty -\@Mii\else
%    \@floatpenalty-\@Miii\fi\def\@captype{#1}\ifinner
%       \@parmoderr\@floatpenalty\z@
%     \else\@next\@currbox\@freelist{\@tempcnta\csname ftype@#1\endcsname
%        \multiply\@tempcnta\@xxxii\advance\@tempcnta\sixt@@n
%        \@tfor \@tempa :=#2\do
%                         {\if\@tempa h\advance\@tempcnta \@ne\fi
%                          \if\@tempa t\advance\@tempcnta \tw@\fi
%                          \if\@tempa b\advance\@tempcnta 4\relax\fi
%                          \if\@tempa p\advance\@tempcnta 8\relax\fi
%          }\global\count\@currbox\@tempcnta}\@fltovf\fi
%     \global\setbox\@currbox\vbox\bgroup 
%     \def\baselinestretch{1}\small\normalsize
%     \boxmaxdepth\z@
%     \hsize\columnwidth \@parboxrestore}

% Redefine the macro used for footnotes to use single spacing
\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

% Stolen from MIT.
%
% A single spaced quote (say) is done by surrounding singlespace with quote.
%
\def\singlespace{%
\vskip\parskip%
\vskip\baselineskip%
\def\baselinestretch{1}%
\ifx\@currsize\normalsize\@normalsize\else\@currsize\fi%
\vskip-\parskip%
\vskip-\baselineskip%
}

\def\endsinglespace{\par}

%  spacing, doublespace and onehalfspace all are meant to INCREASE the
%  spacing (i.e. calling onehalfspace from within doublespace will not
%  produce a graceful transition between spacings)
%
\def\spacing#1{\par%
 \def\baselinestretch{#1}%
 \ifx\@currsize\normalsize\@normalsize\else\@currsize\fi}

\def\endspacing{\par%
 \vskip \parskip%
 \vskip \baselineskip%
 \endgroup%
 \vskip -\parskip%
 \vskip -\baselineskip%
 \begingroup}

\def\onehalfspace{\spacing{1.5}}
\let\endonehalfspace=\endspacing

\def\doublespace{\spacing{2}}
\let\doublespace=\endspacing

% Fix up spacing before and after displayed math
% (arraystretch seems to do a fine job for inside LaTeX displayed math,
% since array and eqnarray seem to be affected as expected)
% Changing \baselinestretch and doing a font change also works if done here,
% but then you have to change @setsize to remove the call to @nomath)
%
\everydisplay{
   \abovedisplayskip \baselinestretch\abovedisplayskip%
   \belowdisplayskip \abovedisplayskip%
   \abovedisplayshortskip \baselinestretch\abovedisplayshortskip%
   \belowdisplayshortskip  \baselinestretch\belowdisplayshortskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%6. Macros and fonts for title page
%------------------------

\newenvironment{frontmatter}{\pagenumbering{roman}}{\newpage \pagenumbering{arabic}}

% \author, \title are defined in report; here are the rest of the
% front matter defining macros
\def\dept#1{\gdef\@dept{#1}}
\def\advisers#1{\gdef\@advisers{#1}}                                   %added by Chandra
\def\enggfaculty{\gdef\@faculty{Faculty of Engineering}}
%\def\enggfaculty{\gdef\@faculty{Electrical Communication Engineering}}
\def\sciencefaculty{\gdef\@faculty{Faculty of Science}}
\def\degreein#1{\gdef\@faculty{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\phd{\gdef\@degree{Doctor of Philosophy}}
\def\mscengg{\gdef\@degree{Master of Science (Engineering)}}
\def\me{\gdef\@degree{Master of Engineering}\metrue}
\def\bibtitle#1{\gdef\@bibtitle{#1}}
\def\faculty#1{\gdef\@faculty{#1}}

% defaults for title, author, faculty and department etc.
\def\@title{I have not decided my title yet!}
\def\@author{Lord Kaliyuga Krishna}
\def\@advisers{Jay and Veeru}
\def\@dept{Department of Computer Science and Automation}
\def\@faculty{Faculty of Engineering}
\def\@degree{Doctor of Philosophy}
\def\@bibtitle{Bibliography}
\def\@submitdate{\ifcase\the\month\or
  JANUARY\or FEBRUARY\or MARCH\or APRIL\or MAY\or JUNE\or
  JULY\or AUGUST\or SEPTEMBER\or OCTOBER\or NOVEMBER\or DECEMBER\fi
  \space \number\the\year}

\newif\iffigurespage \newif\iftablespage 
\newif\ifiisclogo 
\newif\ifme % To print project report in the title page

\figurespagetrue \tablespagefalse 
\iisclogofalse \mefalse

\def\iisclogo#1{
	% For first  call,   load the  file  iisclogo.sty  which  will
	% redefine this macro!
	\makeatletter\input{iisclogo.sty}\makeatother
	\iisclogo{#1}
	}
	
% Font to print the name of the degree on the title page
% Use any other font of your choice if this is not available.

\nonstopmode % Do not stop if the font is not available
% boldface
\newfont{\degfntbf}{eufb10 scaled\magstep3} 
% Bigger
\newfont{\degfnt}{eufm10 scaled\magstep3} 
\errorstopmode % revert back to stop on error

% Font to print title on the cover page
% Use any other font of your choice if this is not available.
% Use \titlefnt if you want smaller font

\nonstopmode % Do not stop if the font is not available
\newfont{\titlefnt}{cmssdc10 scaled\magstep3} 
\newfont{\Titlefnt}{cmssdc10 scaled\magstep4} 
\newfont{\twelvessf}{lcmss8 scaled\magstep2}
\errorstopmode % revert back to stop on error

% From titlepage.sty  27 Jan 85
\def\maketitle{%
\begin{titlepage}\begin{singlespace}
\setcounter{page}{0}
%\null

\vskip -1.0in
	%{\baselineskip 1cm
	{\huge %\baselinestretch{4}
	\begin{center}
		%\Huge\uppercase\expandafter{\@title} 
		{\Titlefnt \@title} 
	\end{center} \par} % The spacing between second and  third line
			   % is not proper
\vfill
\begin{center}
	%\sc 
	\Large \twelvessf 
	A \ifme Project Report \else Thesis \fi \\
	Submitted \ifme in partial fulfilment of the \\
	requirements for \else for \fi the Degree of\\
	{\degfntbf \@degree} \\
	%\sc
	\Large \twelvessf 
	in \ifme \\ \else the \fi {\degfntbf \@faculty} 
\end{center}
\vfill
	{\lineskip .75em
	\begin{center}
	\twelvessf 
	by \\[0.75em]
	{\large \bf \@author}
	\end{center}\par} 
\vfill
	{\lineskip .75em             %added by Chandra
	\begin{center}
	\twelvessf 
	under the Guidance of  \\[0.75em]
	{\large \bf \@advisers}
	\end{center}\par} 
\vfill
\ifiisclogo
	\vfill
	\begin{center}
	%\iisclogo{950} % Laser printer gives error 21 for lower sizes
	\includegraphics[width=3cm]{iisclogo.jpg}
	\end{center}
\fi
\vfill
\begin{center}
 	\large \twelvessf 
	\@dept \\
 	Indian Institute of Science   \\
 	Bangalore -- 560 012, INDIA\\[0.75em]
	\@submitdate\\
\end{center}
\vskip -0.5in
\null

%YNS
% \newpage{\thispagestyle{origempty}} %%THIS LINE WAS CAUSING AN ERROR SO CHANGED OPTION TO empty %Shashank
\newpage{\thispagestyle{empty}}
\ \ \ \ \ \ 
\vspace{3in}
\begin{center}
{\large\bf \copyright \@author \\ \@submitdate\\All rights reserved}
\end{center}

\end{singlespace}\end{titlepage}
%\pagenumbering{roman} % Already in frotmater env!
} %maketitle

\renewenvironment{abstract}{\setcounter{page}{0}\null\vfil\prefacesection{Abstract}}{\par\vfill\null}

\def\prefacesection#1{%
	\chapter*{#1}
	\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Added by Y.N. Srikant
\def\keywords{\prefacesection{Keywords}}
\def\notations{\prefacesection{Notation}}
\def\abbreviations{\prefacesection{Abbreviations}}
\def\acknowledgements{\prefacesection{Acknowledgments}}
\def\vita{\prefacesection{Vita}}
\def\statementoforiginality{\prefacesection{Statement of Originality}}  %Added by Shashank: Not needed in IISc thesis and can be commented out
\def\publications{\prefacesection{Publications based on this Thesis}}
\def\preface{\prefacesection{Preface}} %Added by Shashank
\def\contentspage{\prefacesection{Contents}}  %Added by Shashank
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\makecontents{
%         \newpage     %Commented by Shashank
	\begin{singlespace}
	\tableofcontents
	\newpage
	\iftablespage
		\listoftables
		\newpage
	\fi
	\iffigurespage
		\listoffigures
		\newpage
	\fi
	\end{singlespace}
	}
\def\chapters{%
	\pagenumbering{arabic}
	\pagestyle{headings}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%7. Some additional macros
%-------------------------

% dedication environment
\newenvironment{dedication}{\thispagestyle{plain}\setcounter{page}{0}\null\vfill}{\par\vfill\null}

% New pagestyle for boldface headings instead of default uppercase slanted.
% It underlines the headings as well as in the latex book
%
% Usage: \pagestyle{bfheadings}


\if@twoside \def\ps@bfheadings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}\def\@evenhead{\rm \thepage\hfill \bf
\leftmark}\def\@oddhead{\hbox{}\bf \rightmark \hfill
\rm\thepage}\def\chaptermark##1{\markboth {\ifnum \c@secnumdepth
>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}{}}\def\sectionmark##1{\markright
{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}
\else \def\ps@bfheadings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}\def\@oddhead{\underline{\makebox[\textwidth]{\hbox {} \rightmark \hfill
\rm\thepage}}}\def\chaptermark##1{\markright {\ifnum \c@secnumdepth
>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%7. Modifications of some predefined macros
%------------------------------------------

% Redefine \thebibliography to go to a�M0,15e and put an entry in the
% table of contents

\def\nobiblabels{\gdef\@thesbiblabel{}\gdef\bibspace{\hskip -\labelwidth \hskip -\labelsep}}
\gdef\@thesbiblabel{[\arabic{enumi}]}
\gdef\bibspace{\relax}

\def\thebibliography#1{%
 \addcontentsline{toc}{chapter}{\@bibtitle}
 \chapter*{\@bibtitle\@mkboth
 {\uppercase\expandafter{\@bibtitle}}
 {\uppercase\expandafter{\@bibtitle}}}\list
 {\@thesbiblabel}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
% {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
 \advance\leftmargin\labelsep
 \usecounter{enumi}}
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist

% Redefine \theindex to go to a new page and put an entry in the
% table of contents
\newif\if@restonecol
\def\theindex{%
\addcontentsline{toc}{chapter}{Index}
\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@
\columnsep 35pt\twocolumn[\@makeschapterhead{Index}]
 \@mkboth{INDEX}{INDEX}\thispagestyle{plain}\parindent\z@
 \parskip\z@ plus .3pt\relax\let\item\@idxitem}
\def\@idxitem{\par\hangindent 40pt}
\def\subitem{\par\hangindent 40pt \hspace*{20pt}}
\def\subsubitem{\par\hangindent 40pt \hspace*{30pt}}
\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}
\def\indexspace{\par \vskip 10pt plus 5pt minus 3pt\relax}

%Redefine \enddocument to print the index

\let\@enddocument=\enddocument
\def\enddocument{\@input{\jobname.ind}\@enddocument}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Misc.
% From makeidx.sty 20-Jan-87
\def\see#1#2{{\em see\/} #1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start out normal
\pagestyle{headings}
\makeindex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
