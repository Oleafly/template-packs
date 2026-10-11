% baylorThesis.sty
% This LaTeX document class is to conform with The Baylor University
% Honors Program's undergraduate thesis format.
% It is based on the report style

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{baylor}

\LoadClass{report}

% Page Geometry
\RequirePackage[twoside, letterpaper, left = 1.375in, right = 1.0in, top = 1.0in, bottom = 1.0in]{geometry}
\linespread{1.6}

% This package is used to get the exact measurements for the abstract, signature,
% and title pages
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{1in}
\setlength{\TPVertModule}{1in}

%The following variables are elements that are used to create the abstract, signature, and title page
\newcommand{\studentName}{Bobby Baylor}
\newcommand{\directorDegree}{PhD.}
\newcommand{\directorName}{First Last}
\newcommand{\directorTitle}{Dr. }
\newcommand{\directorDepartment}{Department of Something}
\newcommand{\gradDate}{Month Year}
\newcommand{\thesisTitle}{This Is A Sample Title. It's Not As Good As Yours}
\newcommand{\thesisAbstract}{This is a sample abstract. You should write your own. This is a sample abstract. You should write your own. This is a sample abstract. You should write your own.}

% Creates a function to write out the chapter numbers
\newcommand*{\spellNum}[1]{
 \ifcase#1 \or {One} \or {Two} \or {Three} \or {Four} \or {Five} \or {Six} \or {Seven} \else \fi
}

% The following counter is used for the table of contents for chapter numbers
\newcounter{chapterNum}

% Automatically indents that first line after a heading and sets the indent size
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue
\setlength \parindent{12pt}

% Changes top margin of chapter
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

% Changes the way that the table of contents entry is created
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
 \refstepcounter{chapter}%
 \typeout{\@chapapp\space\thechapter.}%
 \addcontentsline{toc}{chapter}%
 {#1}%
 \else
 \addcontentsline{toc}{\protect\MakeUppercase{\thechapter} chapter}{#1}%
 \fi
 \chaptermark{#1}%
 \addtocontents{lof}{\protect\addvspace{10\p@}}%
 \addtocontents{lot}{\protect\addvspace{10\p@}}%
 \if@twocolumn
 \@topnewpage[\@makechapterhead{#2}]%
 \else
 \@makechapterhead{#2}%
 \@afterheading
 \fi}

 %creates beginning of appendix pages
 \newcommand{\makeAppendix}{%
        \newpage%
        \vspace*{\fill}%
        \begin{center}%
                APPENDIX%
        \end{center}%
        \vspace*{\fill}%
        \newpage%
        \addcontentsline{toc}{part}{Appendix}%
}

 %creates beginning of Acknowledgments page
 \newcommand{\makeAcknowledgments}{%
        \newpage%
        \vspace{1.5in}%
        \begin{center}%
                ACKNOWLEDGEMENTS%
        \end{center}%

        \addcontentsline{toc}{part}{Acknowledgements}%
}
\newif\ifchapterBeginning
\chapterBeginningfalse
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \chapterBeginningtrue 
		    \@afterindentfalse
                    \secdef\@chapter\@schapter}
		  

% This changes the chapter headers to conform to standards
\def\@makechapterhead#1{%
 {\centering \normalfont
  \ifnum \c@secnumdepth >\m@ne
	\ifchapterBeginning
	\vspace*{.5in}
	\chapterBeginningfalse
	\fi
  \MakeUppercase{\@chapapp}\space \MakeUppercase{\spellNum{\thechapter}} \\
  \par\nobreak
  \fi
  #1 \par \hfill \\
}}

% This edits the other heading styles
\renewcommand\section{\@startsection {section}{1}{\z@}%
 {-3.5ex \@plus -1ex \@minus -.2ex}%
 {.2 em}%
 {\normalfont\centering\textit}}
\newcommand\heading{\@startsection {section}{1}{\z@}%
 {-3.5ex \@plus -1ex \@minus -.2ex}%
 {.2 em}%
 {\normalfont\centering}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
 {-3.25ex\@plus -1ex \@minus -.2ex}%
 {.2 em}%
 {\normalfont\flushleft\textit}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
 {3.25ex\@plus 1ex \@minus .2ex}%
 {-1 em}%
 {\normalfont\flushleft\normalsize\textit}}

% This changes the list of figures to match the requirements
 \renewcommand*\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \newpage
    \heading*{\MakeUppercase{\listfigurename}}%
    \addcontentsline{toc}{part}{List of Figures}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
}

 % This changes the list of tables to match the requirements
 \renewcommand*\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \newpage
    \heading*{\MakeUppercase{\listtablename}}%
    \addcontentsline{toc}{part}{List of Tables}%
      \@mkboth{\MakeUppercase\listtablename}%
              {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
}


% This changes the table of contents to match the requirements
\setcounter{tocdepth}{0}
\renewcommand*\tableofcontents{
 \if@twocolumn%
   \@restonecoltrue\onecolumn%
 \else%
   \@restonecolfalse%
 \fi%
 \heading*{\MakeUppercase{\contentsname}}%
 \@starttoc{toc}%
 \if@restonecol\twocolumn\fi%
}

\renewcommand\contentsname{Table of Contents}

\renewcommand*\l@chapter[2]{%
 \ifnum \c@tocdepth >\m@ne
 \addpenalty{-\@highpenalty}%
 \vskip 1.0em \@plus\p@
 \setlength\@tempdima{1.5em}%
 \begingroup
 \parindent \z@ \rightskip \@pnumwidth
 \parfillskip -\@pnumwidth
 \leavevmode
\leavevmode  
  \@dottedtocline{0}{0em}{1.5em}{%
  \refstepcounter{chapterNum}
 \hspace*{.25in} Chapter \hspace*{-.7em} \spellNum{\thechapterNum} \hspace*{-.65em}:   #1}{\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}}\par
 %\advance\leftskip\@tempdima
 %\hskip -\leftskip
 %Chapter \hspace*{-.7em} \spellNum{\thechapterNum} \hspace*{-.65em}: #1 \nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
 \penalty\@highpenalty
 \endgroup
 \fi}

\renewcommand*\l@part[2]{%
 \ifnum \c@tocdepth >\m@ne
 \addpenalty{-\@highpenalty}%
 \vskip 1.0em \@plus\p@
 \setlength\@tempdima{1.5em}%
 \begingroup
 \parindent \z@ \rightskip \@pnumwidth
 \parfillskip -\@pnumwidth
 \leavevmode
\leavevmode  
  \@dottedtocline{0}{0em}{1.5em}{%
  \hspace*{.30in} #1}{\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}}\par
 %\advance\leftskip\@tempdima
 %\hskip -\leftskip
 %Chapter \hspace*{-.7em} \spellNum{\thechapterNum} \hspace*{-.65em}: #1 \nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
 \penalty\@highpenalty
 \endgroup
 \fi}

 \renewenvironment{thebibliography}[1]
      {\chapter*{\thesisTitle}%
       \@mkboth{\MakeUppercase{test}}{\MakeUppercase{test}}%
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
       \endlist}
% This function creates the title abstract page
\newcommand{\makeAbstractPage}{
     % suppresses the page number
     \pagestyle{empty}%
     %creates the space at the top
     \vspace*{1in}%
     \begin{center}%
          ABSTRACT%

          \thesisTitle%

          \studentName%

          Director: \directorName , \directorDegree
     \end{center}%

     \thesisAbstract%
     \newpage%
}

% This function creates the signature page
\newcommand{\makeSignaturePage}{
% creates the space at the top and left side
\vspace*{1in}%
\hspace*{1in}APPROVED BY DIRECTOR OF HONORS THESIS: \\%

\vspace*{.25in}
\hspace*{1.5in}%
\rule{4in}{.4pt} \\%

\hspace*{1.5in}%
\directorTitle %
\directorName, %
\directorDepartment %

\begin{textblock}{8.5}(2, 6)
 APPROVED BY THE HONORS PROGRAM: \\%

 \rule{4in}{.4pt}%

 Dr. Elizabeth Corey, Director.%
\end{textblock}

\begin{textblock}{8.5}(1.5, 9.5)
 DATE: \rule{2in}{.4pt}%
\end{textblock}
\newpage%
}

% Creates the title page
\newcommand{\makeTitlePage}{
    \begin{textblock}{8.5}(0, 2) \centering%
     \MakeUppercase{\thesisTitle}%
    \end{textblock}%

    \begin{textblock}{8.5}(0, 4.5) \centering %
     A Thesis Submitted to the Faculty of \\%
     Baylor University \\%
     In Partial Fulfillment of the Requirements for the \\%
     Honors Program  %
    \end{textblock}%

    \begin{textblock}{8.5}(0, 7.5) \centering %
     By \\%
     \studentName%
    \end{textblock}%

    \begin{textblock}{8.5}(0, 9.25) \centering %
     Waco, Texas \\%
     \gradDate%
    \end{textblock}
   \null\newpage%
}
