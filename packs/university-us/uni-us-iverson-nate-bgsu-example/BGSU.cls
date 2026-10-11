% BGSU class by Nate Iverson
% Complies with BGSU's dissertation policies
% So far the only option is to select runningheaders
% Native options:
%
% runningheader
% thesis
% raggedbottom (default)
% linktocpage (makes the link in the table of contents the page number instead of the text)
%
% options from book.cls (also passed to geometry package):
%
% a4paper
% a5paper
% letterpaper (default)
% legalpaper
% executivepaper
% landscape
% draft
% final
% openright
% openany
% leqno
% fleqn
% openbib
% colorlinks
%    This file is part of BGSU.cls The BGSU (Thesis and Dissertaion LaTeX class)
%
%    BGSU.cls is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    BGSU.cls is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with BGSU.cls  If not, see <http://www.gnu.org/licenses/>.
%
%    Note that this only applies to the example and template files and BGSU.cls 
%    itself. Any actual document content (such as your thesis or dissertation text)
%    belongs solely to you and you can do with it what you please.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BGSU}[6/03/2011 version 1.1.2]
\def\@BGSUv{1.1.2}
% Lets us pick the header type by an option
\def\@hstyle{myheadings}
\def\@rright{false}
\DeclareOption{runningheaders}{
  \let\@hstyle\@empty
  \def\@hstyle{headings}
}
% 
\def\@doctype{Dissertation}
\DeclareOption{thesis}{
  \let\@doctype\empty
  \def\@doctype{Thesis}
}
\def\@colorlinks{false}
\DeclareOption{colorlinks}{
\let\@colorlinks\empty
\def\@colorlinks{true}
}
\DeclareOption{linktocpage}{\PassOptionsToClass{linktocpage}{hyperref}}
% Pass papersize options to book and geometry.
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{book} 
                        \PassOptionsToPackage{a4paper}{geometry}
                        \PassOptionsToPackage{a4paper}{hyperref}
}
\DeclareOption{a5paper}{\PassOptionsToClass{a5paper}{book} 
                        \PassOptionsToPackage{a5paper}{geometry}
                        \PassOptionsToPackage{a5paper}{hyperref}
}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{book} 
                            \PassOptionsToPackage{letterpaper}{geometry}
                            \PassOptionsToPackage{letterpaper}{hyperref}
}
\DeclareOption{legalpaper}{\PassOptionsToClass{legalpaper}{book} 
                           \PassOptionsToPackage{legalpaper}{geometry}
                           \PassOptionsToPackage{legalpaper}{hyperref}
}
\DeclareOption{executivepaper}{\PassOptions{executivepaper}{book} 
                               \PassOptionsToPackage{executivepaper}{geometry}
                               \PassOptionsToPackage{executivepaper}{hyperref}
}
\DeclareOption{landscape}{\PassOptionsToClass{landscape}{book} 
                          \PassOptionsToPackage{landscape}{geometry}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{book}}
\DeclareOption{final}{\PassOptionsToClass{final}{book}}
\DeclareOption{openright}{\PassOptionsToClass{openright}{book}}
\DeclareOption{openany}{\PassOptionsToClass{openany}{book}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{book}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{book}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{book}}
% pass unknown options to book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% pass hyperref options to ensure chapters are converted to
% PDF bookmarks passing it to geometry actually makes sure
% you convert to the correct paper size too!

\DeclareOption{pdftex}{\PassOptionsToPackage{pdftex}{hyperref}
\PassOptionsToPackage{pdftex}{geometry}}

\DeclareOption{dvipdfm}{\PassOptionsToPackage{dvipdfm}{hyperref}
\PassOptionsToPackage{dvipdfm}{geometry}}

\DeclareOption{dvips}{\PassOptionsToPackage{dvips}{hyperref}
\PassOptionsToPackage{dvips}{geometry}
}
\DeclareOption{raggedbottom}{\raggedbottom}
\DeclareOption{flushbottom}{\flushbottom}
\DeclareOption{raggedright}{\def\@rright{true}}

\PassOptionsToClass{12pt}{book}
\PassOptionsToClass{oneside}{book}

% Most Book Options are passed on

\ExecuteOptions{pdftex,letterpaper,raggedbottom}
\ProcessOptions

\RequirePackage{ifthen}
\RequirePackage{calc}
\ifthenelse{\equal{\@rright}{true}}{
\RequirePackage{ragged2e}
}{}

% oneside puts all pagenumbers on right hand side
% 12pt is required 

\LoadClass{book}
\usepackage[noTeX]{mmap}
\pagestyle{\@hstyle}

% Below used to set margins
% 1 inch margins pagenumbers only in 3/4 inch, footnotes included as part
% of text
\usepackage{geometry}
\geometry{margin=1.0in, nofoot, headsep=6pt}% options appended.
% double spacing
\RequirePackage{setspace}
\doublespacing

\pagestyle{\@hstyle}

\bibliographystyle{plain}



% define some variable for the BGSU maketitle.
% gfr is Graduate Faculty Advisor
% Committee is the remainder of the committee with 
% a \\ \\ after each name.
% Degree is the degree sought

\def\author#1{\def\@author{#1}}
\def\advisor#1{\def\@advisor{#1}}
\def\@coadvisor{None}
\def\coadvisor#1{
\let\@coadvisor\empty
\def\@coadvisor{#1}
}
\def\gfr#1{\def\@gfr{#1}}
\def\committee#1{\def\@committee{#1}}
\def\degree#1{\def\@degree{#1}}
\def\@keywords{\@author ; \@title}
\def\keywords#1{
\let\@keywords\empty
\def\@keywords{#1}}
\def\@subject{Mathematics}
\def\subject#1{
\let\@subject\empty
\def\@subject{#1}}
\def\@linktotop{No}
\def\linktotop{
\let\@linktotop\empty
\def\@linktotop{Yes}}
% make sure to include pdftex in all relevent packages
% as it will automatically put bookmarks in pdf files generated
\RequirePackage{hyperref} 
\hypersetup{%
  bookmarkstype=none,
  bookmarksnumbered=true,
  plainpages=false,
  unicode=true,
  pdfstartview={FitH 800},
  colorlinks=false,
  linktocpage,
}
\RequirePackage{bookmark} 
\bookmarksetup{
numbered,
}
\renewcommand{\maketitle}{
\bookmark[named=FirstPage,level=0]{TITLEPAGE}
% The below needs to be in the actual document aka after \@author
% have been defined. That is why here.
\hypersetup{%
  pdfauthor=\@author,
  pdftitle=\@title,
  pdfsubject=\@subject,
  pdfkeywords=\@keywords, 
  pdfcreator={LaTeX BGSU.cls v\@BGSUv \ by Nate Iverson},
} 

\begin{titlepage}%
   \singlespacing
   \thispagestyle{empty}
   
   \begin{center}
    \vspace*\fill

    \textbf{\MakeUppercase{\@title}}
    \vspace{1.25in}
    % Adjusts spacing for masters thesis 
    \ifthenelse{\equal{\@doctype}{Dissertation}}{}
    {\vspace*{0.8in}}


    \@author 
    \vspace{1.25in}

    A \@doctype\\[.2in]

    Submitted to the Graduate College 
    of Bowling Green \\ State University
    in partial fulfillment of \\ the requirements 
    for the degree of\\[.35in]

    \MakeUppercase{\@degree} \\[.2in]

    \@date \\[.2in]

    \end{center}
    \begin{flushright}
    \parbox{3.25in}{
    \noindent Committee: \\

    \noindent \@advisor , Advisor\\
    
    \ifthenelse{\equal{\@coadvisor}{None}}
    {}
    {
    \noindent \@coadvisor , Co-Advisor\\
    }

    % only a doctoral dissertation needs a GFR
    \ifthenelse{\equal{\@doctype}{Dissertation}}{
    \noindent \@gfr ,\\
     Graduate Faculty Representative\\

     }
    { %No GFR if not a doctoral dissertation.
    }
    \noindent \@committee
    }\end{flushright}
  
  % Adjusts spacing for masters thesis 
  \ifthenelse{\equal{\@doctype}{Dissertation}}{}
  {\vspace*{0.8in}}
\end{titlepage}

  \clearpage
  \doublespacing
  \setcounter{page}{2}
  \ifthenelse{\equal{\@rright}{true}}{
  \RaggedRight}{}
}

\newenvironment{abstract}{\clearpage
\bookmark[page=\value{page},view={FitH 800},level=0]{ABSTRACT}
\label{abstract}
\thispagestyle{myheadings}
\begin{center}\textbf{ABSTRACT}\\ \end{center}
  \begin{flushleft}{\@advisor , Advisor\\} \end{flushleft}

}{\clearpage
}

\newcommand{\copyrightpage}{  
  \thispagestyle{empty}
  \vspace*\fill
  \begin{center} 
 \begin{minipage}[!b]{\linewidth} 
  \bookmark[page=\value{page},view={FitH 800},level=0]{COPYRIGHT}
    \begin{center}
       Copyright \copyright \@date\\
       \@author \\
       All rights reserved
    \end{center}
  \end{minipage}
  \end{center}
  \clearpage
  \doublespace
}
\newenvironment{acknowledgments}{\clearpage
\phantomsection
\bookmark[page=\value{page},view={FitH 800},level=0]{ACKNOWLEDGMENTS}
\thispagestyle{myheadings}
  \begin{center} \textbf{ACKNOWLEDGMENTS}
  \end{center}

}{\clearpage
}
\newenvironment{acknowledgements}{\clearpage
\phantomsection
\bookmark[page=\value{page},view={FitH 800},level=0]{ACKNOWLEDGEMENTS}
\thispagestyle{myheadings}
  \begin{center} \textbf{ACKNOWLEDGEMENTS}
  \end{center}

}{\clearpage
}
\newenvironment{dedication}{\thispagestyle{myheadings}
\bookmark[page=\value{page},view={FitH 800},level=0]{DEDICATION}

\begin{center}
\vspace*{2.5in}

}{\end{center}\clearpage
}

\newenvironment{preface}{\clearpage

\thispagestyle{myheadings}
\bookmark[page=\value{page},view={FitH 800},level=0]{PREFACE}

\begin{center} \textbf{PREFACE}
\end{center}

}{\clearpage
}


% This should fix a problem with the chapters changing the
% pagestyle
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{\@hstyle}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}


% This lets me define the chapter command as defined by book.cls
% into a new name, so that I can change the actual chapter command.

% \let\Oldchapter\chapter
% \renewcommand{\chapter}[3]{
%   \Oldchapter{#1}{#2}{#3} \thispagestyle{empty}
%}

% For some reason the above does not work, gone back to old method
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\tableofcontents}{\clearpage
  \bookmark[page=\value{page},view={FitH 800},level=0]{\contentsname}
  \@makechapterhead{\contentsname}
  \@starttoc{toc}
}

\renewcommand{\listoffigures}{\clearpage
\bookmark[page=\value{page},view={FitH 800},level=0]{\listfigurename}
\@makechapterhead{\listfigurename}
\@starttoc{lof}
}


\renewcommand{\listoftables}{\clearpage
\bookmark[page=\value{page},view={FitH 800},level=0]{\listtablename}
\@makechapterhead{
\listtablename}
\@starttoc{lot}
}
% Need to define offset to get links right

\renewcommand\mainmatter{%
  \newcounter{offset}\setcounter{offset}{\value{page}}
  \newcounter{trupage}
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  }

% This is to ensure that Chapter appears before the chapter number in
% the toc and fixes pdfbookmarks to point higher on the page 
\renewcommand{\chaptername}{CHAPTER}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
            \addcontentsline{toc}{chapter}{\chaptername\space\protect\numberline{\thechapter:}#1}%
            \setcounter{trupage}{\value{page}+\value{offset}}
            \bookmark[page=\value{trupage},view={FitH 800},level=0]{\chaptername\space\thechapter: #1}
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
%           \bookmark[dest=page.\thepage,view={FitH 800},level=0]{#1}
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
%          \bookmark[dest=page.\thepage,view={FitH 800},level=0]{#1}
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
% Below adds pdf bookmarks (manually) to sections
               
       
\newcommand{\addtocbookmark}[2]%
{
\ifthenelse{\equal{#1}{part}}
	{       \addcontentsline{toc}{#1}{#2}%
        	\setcounter{trupage}{\value{page}+\value{offset}}
        	\bookmark[page=\value{trupage},view={FitH 800},level=0]{#2}
        	}
{
\ifthenelse{\equal{#1}{chapter}}
	{       \addcontentsline{toc}{#1}{#2}%
        	\setcounter{trupage}{\value{page}+\value{offset}}
        	\bookmark[page=\value{trupage},view={FitH 800},level=0]{#2}
        	}
{
\ifthenelse{\equal{#1}{section}}
	{       \addcontentsline{toc}{#1}{#2}%
            \pdfbookmark[1]{#2}{#2}}
{
\ifthenelse{\equal{#1}{subsection}}
    {       \addcontentsline{toc}{#1}{#2}%
            \pdfbookmark[2]{#2}{#2}}
{
\ifthenelse{\equal{#1}{subsubsection}}
	{       \addcontentsline{toc}{#1}{#2}%
            \pdfbookmark[3]{#2}{#2}}
{
\ifthenelse{\equal{#1}{paragraph}}
	{       \addcontentsline{toc}{#1}{#2}%
            \pdfbookmark[4]{#2}{#2}}
{
\ifthenelse{\equal{#1}{subparagraph}}
	{       \addcontentsline{toc}{#1}{#2}%
            \pdfbookmark[5]{#2}{#2}}
{
}}}}}}}}

% The following puts the bibliography in the table of contents.

\renewcommand{\bibname}{BIBLIOGRAPHY} 
\renewenvironment{thebibliography}[1]
     {\clearpage
      \phantomsection
      \addcontentsline{toc}{chapter}{\bibname}
      \setcounter{trupage}{\value{page}+\value{offset}}
      \bookmark[page=\value{trupage},view={FitH 800},level=0]{\bibname}
%\bookmark[page=\value{page}+5,view={FitH 800},level=0]{\bibname}
       \chapter*{\bibname}%
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
     {
     \def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
% Makes enumerate environment single spaced doublespace provides way to much 
% space.
\let\orig@Itemize =\itemize         
\let\orig@Enumerate =\enumerate
\renewenvironment{itemize}
                 {\itemsep=0pt\topsep=0pt\partopsep=0pt\orig@Itemize}
                 {\endlist}
\renewenvironment{enumerate}
                 {\itemsep=0pt\topsep=0pt\partopsep=0pt\orig@Enumerate}
                 {\endlist}
                 
% Adds pdfbookmarks for sections
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}
  \ifthenelse{\equal{\@linktotop}{Yes}}
  {
  % I don't know why the page is always the previous when a section is at the top of a page.
  % That is why I add 1 to the page counter here. 
 	\setcounter{trupage}{\value{page}+1}
%  	\bookmark[page=\value{trupage},view={FitH 800},level=#2]{{\csname the#1\endcsname}: #7}
	\bookmark[dest=page.\thetrupage,view={FitH 800},level=#2]{{\csname the#1\endcsname}: #7}
  	\let\@linktotop\empty
	\def\@linktotop{No}
  }
  {
%	  \pdfbookmark[#2]{{\csname the#1\endcsname}: #7}{#7}
      \bookmark[dest=#1.\csname the#1\endcsname,view={FitH 800},level=#2]{{\csname the#1\endcsname}: #7}
  }
}
  
\ifthenelse{\equal{\@colorlinks}{true}}
{
\def\@linkbordercolor{1 0 0}
\def\@urlbordercolor{0 1 1}
\def\@menubordercolor{1 0 0}
\def\@filebordercolor{0 .5 .5}
\def\@runbordercolor{0 .7 .7}
\def\@citebordercolor{0 1 0}
}
{
	\def\@linkbordercolor{1 1 1}
	\def\@urlbordercolor{1 1 1}
	\def\@menubordercolor{1 1 1}
	\def\@filebordercolor{1 1 1}
	\def\@runbordercolor{1 1 1}
	\def\@citebordercolor{1 1 1}
}

