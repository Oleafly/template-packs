%%---------------------------------------------------
% The commented out commands are not needed for 
% the 10/08/12 standards. Other commands have been 
% modified to match these standards.  -- Ruth
%%---------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmthesis}

%%---------------------------------------------------
%%-- Load the base class and modify current macros.
%%---------------------------------------------------

\newif\if@usecppsyntax \@usecppsyntaxfalse

\DeclareOption{cpp}{\@usecppsyntaxtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
%\PassOptionsToClass{12pt}{report}
\LoadClass{report}

%%---------------------------------------------------
%%--Set the section number depth.
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{4}
\setcounter{page}{2}

%%---------------------------------------------------
%%--Include some required packages.
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{setspace}
\RequirePackage{float}
\RequirePackage{citesort}

%%---------------------------------------------------
%%--Must change the margin above the Chapter heading to 2 inches
\RequirePackage{wmchapter}


%%---------------------------------------------------
%%--Create a vertical skip for the distance between the title and
%%--the first line of text on the prolog pages.
\newskip\thesisvskip
\thesisvskip 36pt

%%---------------------------------------------------
%%--Set the margins. 
%\headheight6pt \headsep12pt
%\marginparwidth 1in
%\marginparsep 6pt
\oddsidemargin 0.5in%38pt %36pt
%\evensidemargin 38pt %36pt
\topmargin  0.25in
\rightmargin 0.25pt
\textwidth  5.9 in
\textheight 8.4 in
\footskip   24pt  %%check this

%%---------------------------------------------------
%%--Set the pagestyle to headings.
\pagestyle{headings}

%%---------------------------------------------------
%%--Change the marginpar.
%\reversemarginpar
%\let\old@marginpar=\marginpar
%\def\marginpar#1{
%       \old@marginpar{\def\baselinestretch{1}\em\small #1}}

%%---------------------------------------------------
%%--Parameters that can be set by the user.
\def\thesis@listtables{y}
\def\thesis@listfigures{y}

\newcommand{\notablelist}{\gdef\thesis@listtables{n}}
\newcommand{\nofigurelist}{\gdef\thesis@listfigures{n}}

%%--------------------------------------------
%%-- Prolog pages construction.
%%--------------------------------------------

%%--Macros used for the construction of the title page.
\newcommand{\thesisTitle}[1]{\gdef\thesis@title{#1}}
\newcommand{\thesisYear}[1]{\gdef\thesis@year{#1}}
\newcommand{\thesisMonth}[1]{\gdef\thesis@month{#1}}
\newcommand{\thesisAbstract}[1]{\gdef\thesis@abstract{#1}}
\newcommand{\thesisAcknowledge}[1]{\gdef\thesis@ack{#1}}
\newcommand{\thesisDedication}[1]{\gdef\thesis@Dedication{#1}}
\newcommand{\thesisVita}[1]{\gdef\thesis@vita{#1}}
\newcommand{\thesisBib}[1]{\gdef\thesis@bib{#1}}
\newcommand{\thesisAdvisor}[1]{\gdef\ThesisAdvisor{#1}}
%Location and Degrees added -- Ruth
\newcommand{\thesisLocation}[1]{\gdef\ThesisLocation{#1}}
\newcommand{\thesisDegreeOne}[1]{\gdef\ThesisDegreeOne{#1}}
\newcommand{\thesisDegreeTwo}[1]{\gdef\ThesisDegreeTwo{#1}}
\newcommand{\thesisDegreeThree}[1]{\gdef\ThesisDegreeThree{#1}}

%  \thesisAuthor macro
%     defines two TeX variables (only usable in this file)
%  \thesis@author  is assumed to be a "short" version of the author's name
%        used on the title page
%  \thesis@authorx is assumed to be the full name of the author
%        used on the approval, the UMI abstract, and the vita pages
%  For example
%     \thesisAuthor{A. Goode Student}
%        sets both \thesis@author and \ thesis@authorx to
%        "A. Goode Student"
%     \thesisAuthor[Aloysius Goode Student]{A. Goode Student}
%        sets \thesis@author  to "A. Goode Student" and
%             \thesis@authorx to "Aloysius Goode Student"
%
\newcommand{\thesisAuthor}[2][\empty]{
   \gdef\thesis@author{#2}
   \ifx#1\empty \let\thesis@authorx\thesis@author
   \else \gdef\thesis@authorx{#1}\fi}

\def\thesis@abstract{\empty}
\def\thesis@ack{\empty}
\def\thesis@vita{\empty}
\def\thesis@bib{\empty}

%%--Macro used to specify the committee.
\newcounter{thesis@members}
\setcounter{thesis@members}{1}

\newcommand{\thesisCommittee}[2][\mbox{\hspace*{1ex}}]{
   \edef\thesis@ctr{\romannumeral\value{thesis@members}}
   \expandafter\def\csname thesis@member\thesis@ctr\endcsname{#2}
   \expandafter\def\csname thesis@position\thesis@ctr\endcsname{#1}
   \addtocounter{thesis@members}{1}}

%%--The prolog pages.
\newcommand{\makeThesisProlog}{
       \bigskip
       \setcounter{page}{1}
       \renewcommand{\thepage}{\roman{page}}
       \pagestyle{plain}
       \thispagestyle{empty}

%%--------------------------------------------
% Any of these pages can be individually commented
% out for non-final versions if desired -- Ruth
%%--------------------------------------------
%%-- title page
       \maketitlepage
%%--------------------------------------------
%%-- copright page
	\makecopyrightpage
%%--------------------------------------------
%%-- approval page
	\makeapprovalpage
%%--------------------------------------------
%%-- compliance page
	\makecompliancepage
%%--------------------------------------------
%%-- abstract
	\makeabstractpage
%%--------------------------------------------
%-TOC pages
	\newpage
	\pagestyle{plain}\setcounter{page}{1}
	{\large \tableofcontents }
%%--------------------------------------------
%%-- acknowledgements
	\makeacknowledgepage
%%--------------------------------------------
%%-- dedication page
	\makededicationpage
%%--------------------------------------------
%%-- List of tables and/or figures.
	\maketablesfigurespage
%%--------------------------------------------
%%-- half-title page
	\makehalftitlepage
%%--------------------------------------------
%%-- end of prolog, start of thesis
	\newpage
	\pagestyle{plain}
	\renewcommand{\thepage}{\arabic{page}}
}


%%--------------------------------------------
%%-- Prolog related commands.
%%--------------------------------------------

%%--Page titles.
\def\acknowledgeName{ACKNOWLEDGMENTS}
\def\abstractName{ABSTRACT}
\def\complianceName{COMPLIANCE PAGE}

%%--------------------------------------------
%%--The title page.
\newcommand{\maketitlepage}{
 \begin{titlepage}\begin{singlespace}
 \begin{center}{\large
    \thesis@title \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\
       \hspace{.1in}  \\ %8 lines between title and author name -- Ruth
    \thesis@authorx \\ 
        \hspace{.1in}  \\ %1 line between name and hometown -- Ruth
    \ThesisLocation \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 4 lines between hometown and prior degrees -- Ruth
    \ThesisDegreeOne \\
    \ThesisDegreeTwo \\
%   \ThesisDegreeThree  % uncomment if you are more than 2
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 4 lines between prior degrees and purpose statement -- Ruth
    {A Dissertation presented to the Graduate Faculty\\
         of the College of William \& Mary in Candidacy for the Degree of\\
         <Insert Degree Name>}\\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 7 lines between purpose statement and department -- Ruth
    {Department of Computer Science}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 5 lines between department and college -- Ruth
    {College of William \& Mary\\ 
       \thesis@month\ \thesis@year}
    }
 \end{center}\end{singlespace}
 \end{titlepage}
 }

%%--------------------------------------------
%%--The copyright page
\newcommand{\makecopyrightpage}{
	\newpage
	 \begin{titlepage}\begin{singlespace}
	 	\begin{center}
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		\hspace{1in}  \\
		
		
		{\fontsize{12}{5}\selectfont \copyright~Copyright by Student Name 2018}
		
		\end{center}
	\end{singlespace} \end{titlepage}
}


%%--------------------------------------------
%%--The approval page.
\newcommand{\thesisapprovalwidth}{3in}
\newcommand{\makeapprovalpage}{
 \newpage
 \pagestyle{empty} % no page number on approval page -- Ruth
 \begin{singlespace}
 \begin{center}
    {\Large APPROVAL PAGE}\\
       {\large \hspace{.1in} } \\
       {\large \hspace{.1in} } \\
       {\large \hspace{.1in} } \\ % 3 lines between title and statement -- Ruth
    {\large This Dissertation is submitted in partial fulfillment of \\
         the requirements for the degree of}\\
        \hspace{.1in}  \\ % 1 lines between statements
    {\large <Insert Degree Name>}\\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between statement and signature line -- Ruth
    \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small \thesis@author}\\
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signature line and approved -- Ruth
    {\large Approved by the Committee, \thesis@month\ \thesis@year}\\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 2 lines between approved and signature line -- Ruth
    \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small Committee Chair\\
    \thesis@memberi, \thesis@positioni\\
    College of William \& Mary}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
    \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small\thesis@memberii, \thesis@positionii\\
    College of William \& Mary}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
    \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small\thesis@memberiii, \thesis@positioniii\\
    College of William \& Mary}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
 \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small\thesis@memberiv, \thesis@positioniv\\
    College of William \& Mary}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
         \underline{\hspace*{\thesisapprovalwidth}}\\
    {\small\thesis@memberv, \thesis@positioniv\\
    The University of Texas at Dallas}
        \hspace{.1in}  \\
        \hspace{.1in}  \\
        \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
   \end{center}\end{singlespace}

}

%%--------------------------------------------
%%--The Compliance Page
\newcommand{\makecompliancepage}{
	\newpage\pagestyle{empty} % no page number on abstract page -- Ruth
	\begin{center}
		\Large\complianceName
		\vspace{2em}
	\end{center}
	\begin{singlespace}
\begin{large}
\setlength\parindent{32pt}Research approved by
\vspace{1em}
	\begin{center} 
	\underline{Protection of Human Subjects Committee}	
	\end{center}
\vspace{4em}

%-----------------------------------------------------
%----Protocol-Numbers---------------------------------
Protocol number(s):  PHSC-\#\#\#\#-\#\#-\#\#-\#\#\#\#\#-protocol\\
\vspace{-0.5em}


\setlength\parindent{140pt} PHSC-\#\#\#\#-\#\#-\#\#-\#\#\#\#\#-protocol\\
\vspace{1em}



%-----------------------------------------------------
%----Dates-of-Approval---------------------------------
\setlength\parindent{32pt}Date(s) of approval: mm/dd/yyyy\\
\vspace{-0.5em}

\setlength\parindent{141pt} mm/dd/yyyy\\

\end{large}
\end{singlespace}
}


%%--------------------------------------------
%%--The abstract page
\newcommand{\makeabstractpage}{
	\newpage\pagestyle{empty} % no page number on abstract page -- Ruth
	\begin{center}
		\Large\abstractName
	\end{center}
	\begin{singlespace}
		\input{\thesis@abstract}
	\end{singlespace}
}

%%--------------------------------------------
%%--The acknowledgement page
\newcommand{\makeacknowledgepage}{
	\newpage
	\begin{center}
		\addcontentsline{toc}{chapter}{\rm Acknowledgments}
		\Large\acknowledgeName
		\vspace{-0.4in}
	\end{center}
	\begin{singlespace}
		\input{\thesis@ack}
	\end{singlespace}
}

%%--------------------------------------------
%%--The dedication page
% This is to be "whole page" justified, so if your dedication is more than
% one line, the amount of vspace will need to be adjusted. -- Ruth
\newcommand{\makededicationpage}{
	\newpage
	\begin{center}
		\addcontentsline{toc}{chapter}{\rm Dedication} 
		\vspace*{3in}
		{\large \thesis@Dedication}
	\end{center}
}


%%--------------------------------------------
%%--The tables and/or figures pages
\newcommand{\maketablesfigurespage}{
	\newpage
	\setlength{\cftafterlottitleskip}{2em}
	\addcontentsline{toc}{chapter}{\rm List of Tables}
		{\large	\listoftables}
	\newpage
	\setlength{\cftafterloftitleskip}{2em}
	\addcontentsline{toc}{chapter}{\rm List of Figures}
		{\large	\listoffigures	}
}

%%--------------------------------------------
%%--The half-title page
% This page is not necessary. If you do not include it, be sure to 
% still include the setcounter command to get the first page
% numbered as such.
\newcommand{\makehalftitlepage}{
	\newpage
	\setcounter{page}{1}
	\pagestyle{empty}
	\begin{center}
		\vspace*{3in}
		{\Large \thesis@title}
	\end{center}
}
                  
%%--------------------------------------------
%%-- Bibliography related commands.
%%--------------------------------------------


%%--Set the bib style
\def\thesisBibStyle{wmbib}

%%--Define a single command for making the bibliography.
\newcommand{\makeThesisBib}[1]{
  \bibliographystyle{\thesisBibStyle}
  \bibliography{#1}}

%%--Redefine the thebibliography environment
\let\wm@thebibliography\thebibliography
\let\wm@endthebibliography\endthebibliography

\def\thebibliography#1{\begin{spacing}{1}\wm@thebibliography{#1}
       \addcontentsline{toc}{chapter}{Bibliography}}
\def\endthebibliography{\wm@endthebibliography\end{spacing}}

\newcommand{\makeThesisVita}[1]{
         \newpage
         \pagestyle{headings}\markright{}
         \begin{center}
            \addcontentsline{toc}{chapter}{Vita}
           \Large VITA
      \vskip\thesisvskip
      \thesis@authorx
      \vskip\thesisvskip
         \end{center}
         \input{#1}
}

% I did not write this or use this, so I do not know if it is compliant. -- Ruth
\newcommand{\makeUMIAbstract}[1]{
         \newpage
         \pagestyle{empty}
\thispagestyle{empty}
         \begin{center}
     \Large \thesis@title \\
        \parbox{1in}{   ABSTRACT } \vskip\thesisvskip
        \end{center}
         \input{#1}
     \vfill
     \begin{center}
     \large \thesis@authorx \\
     Department of Computer Science \\
     The College of William and Mary in Virginia \\
     Advisor: \ThesisAdvisor  \\
     \thesis@title
     \end{center}
}

%%--------------------------------------------
%%-- Definition and Quotation commands.
%%--------------------------------------------

\newtheorem{define}{Definition}[chapter]
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{notate}{Notation}[chapter]
\newtheorem{axiom}{Axiom}[chapter]

\newenvironment{proof}[1][Proof]
{\noindent {\bf #1: }}{\hfill $\blacksquare$}

%%-----------------------------------------------
%%-- Float related environments and commands.
%%-----------------------------------------------

%%--Modify behavior of the figure and table environment.
\def\fps@figure{hbt}
\def\fnum@figure{{\bf \figurename~\thefigure}}
\def\fps@table{htb}
\def\fnum@table{{\bf \tablename~\thetable}}

\def\mathfigure{\thesisfiguretrue\figure}
\def\endmathfigure{\endfigure\thesisfigurefalse}

%%--Redefine the @makecaption command so \small can be used.
\long\def\@makecaption#1#2{%
 \vskip\abovecaptionskip
 \sbox\@tempboxa{{\small #1: #2}}%
 \def\baselinestretch{1}\small%\@newbaseline
 \ifdim \wd\@tempboxa >\hsize
   #1: #2\par
 \else
   \global \@minipagefalse
   \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
 \fi
 \vskip\belowcaptionskip}



%%--This allows for the correct setting of \arraystrecth in the
%%--math environments when used within a figure.
%\let\old@figure=\figure
%\let\old@endfigure=\endfigure
%\renewenvironment{figure}[1][\empty]{
%  \ifx\empty \begin{old@figure}
%\def\figure{\thesisFiguretrue\old@figure}
%\def\endfigure{\global\thesisFigurefalse\old@endfigure}


%%-----------------------------------------------
%%-- Modify the displayed math environments.
%%-----------------------------------------------

\newif\ifthesisfigure
\thesisfigurefalse

%%--Set the arraystretch for math display.
\everydisplay{
  \abovedisplayskip \baselinestretch\abovedisplayskip %plus 0.0pt minus 10pt%
  \belowdisplayskip \abovedisplayskip%
  \abovedisplayshortskip \abovedisplayshortskip%
  \belowdisplayshortskip \belowdisplayshortskip%
  \ifthesisfigure\def\arraystretch{1}\else\def\arraystretch{0.5}\fi}

\def\@setsize#1#2#3#4{%\@nomath#1%-KPC
  \let\@currsize#1\baselineskip
  #2\baselineskip\baselinestretch\baselineskip
  \parskip\baselinestretch\parskip
  \setbox\strutbox\hbox{\vrule height.7\baselineskip
     depth.3\baselineskip width\z@}%-KPC
  \normalbaselineskip\baselineskip#3#4}



%%--------------------------------------------
%%-- Miscellaneous commands.
%%--------------------------------------------

%%--Commands to simplify font changing.
\newcommand{\sfup}{\sffamily\mdseries\upshape}
\newcommand{\sfsc}{\ttfamily\mdseries\scshape}
\newcommand{\sfit}{\sffamily\mdseries\itshape}
\newcommand{\rmup}{\rmfamily\mdseries\upshape}
\newcommand{\rmbf}{\rmfamily\bfseries\upshape}
\newcommand{\rmit}{\rmfamily\mdseries\itshape}
\newcommand{\ttup}{\ttfamily\mdseries\upshape}

\endinput

%%--The \tableofcontents.
%%%%% code removed REL

%%--The \listoffigures command.
\renewcommand\listoffigures{%
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \oldchapter*{\listfigurename
     \@mkboth{\uppercase{\listfigurename}}{\uppercase{\listfigurename}}\vspace{-4em}}%
   \@starttoc{lof}%
   \if@restonecol\twocolumn\fi}

%%--The \listoftables command.
\renewcommand\listoftables{%
   \if@twocolumn%
     \@restonecoltrue\onecolumn%
   \else%
     \@restonecolfalse%
   \fi%
   \oldchapter*{\listtablename%
     \@mkboth{\uppercase{\listtablename}}{\uppercase{\listtablename}}}%
   \@starttoc{lot}%
   \if@restonecol\twocolumn\fi}

\usepackage{wmchap}
\endinput
