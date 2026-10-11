
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
% based on umich-thesis.cls
\ProvidesClass{cmu-thesis}[2007/12/03 v1.0 Carnegie Mellon University thesis class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
                \typeout{Unknown option, passing ``\CurrentOption"
                         option on to the standard LaTeX2e book class.}}
\ProcessOptions

\LoadClass[11pt,oneside,openany]{book}

\RequirePackage[left=1.5in,body={6in,9in}]{geometry}% page layout
\RequirePackage{setspace}% for \doublespacing and \singlespacing
\RequirePackage{placeins}% clear floats before starting new sections

% new logical variables
\newif\if@appendix \@appendixfalse
\newif\if@backmatter \@backmatterfalse

% define new fields (similar to the standard \author, \title, \date, etc.}:
\def\degree#1{\gdef\@degree{#1}}
\def\department#1{\gdef\@department{#1}}
\def\chairperson#1{\gdef\@chairperson{#1}}
\def\committee#1{\gdef\@committee{#1}}
\def\time#1{\gdef\@time{#1}}
\def\place#1{\gdef\@place{#1}}
\def\degreedate#1{\gdef\@degreedate{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\previousdegrees#1{\gdef\@previousdegrees{#1}}
% use \long definitions for the following since their contents
% may be more than a single paragraph:
\long\def\frontispiece#1{\gdef\@frontispiece{#1}}
\long\def\dedication#1{\gdef\@dedication{#1}}
\long\def\acknowledgements#1{\gdef\@acknowledgements{#1}}
\long\def\preface#1{\gdef\@preface{#1}}
\long\def\abstract#1{\gdef\@abstract{#1}}
\long\def\afterword#1{\gdef\@afterword{#1}}
\long\def\notationlist#1{\gdef\@notationlist{#1}}

% warn if fields are empty:
\def\@degree{\@latex@warning@no@line{No \noexpand\degree given}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\def\@chairperson{\@latex@warning@no@line{No \noexpand\chairperson given}}
\def\@committee{\@latex@warning@no@line{No \noexpand\committee given}}
\def\@frontispiece{\@latex@warning@no@line{No [optional]
    \noexpand\frontispiece defined}}
\def\@dedication{\@latex@warning@no@line{No [optional]
    \noexpand\dedication provided}}
\def\@acknowledgements{\@latex@warning@no@line{No [optional]
    \noexpand\acknowledgements given}}
\def\@preface{\@latex@warning@no@line{No [optional]
    \noexpand\preface given}}
\def\@notationlist{\@latex@warning@no@line{No [optional]
    \noexpand\notationlist given}}
\def\@abstract{\@latex@warning@no@line{No \noexpand\abstract given}}
\def\@vita{\@latex@warning@no@line{No [optional]
    \noexpand\vita given}}
\def\@afterword{\@latex@warning@no@line{No [optional]
    \noexpand\afterword given}}

% change/add some names:
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\chaptername}{Chapter}
\renewcommand{\appendixname}{Appendix}
\newcommand{\appendicesname}{Appendices}
\newcommand{\listappendicesname}{List of Appendices}

% change the chapter numbers to roman numerals
\renewcommand{\thechapter}{\Roman{chapter}}
% but use arabic for sections, etc.
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
\renewcommand\theequation{\@arabic\c@chapter.\@arabic\c@equation}
\renewcommand\thefigure{\@arabic\c@chapter.\@arabic\c@figure}
\renewcommand\thetable{\@arabic\c@chapter.\@arabic\c@table}

% tweak \tableofcontents, \listoffigures, \listoftables
% and add \listofappendices:
\renewcommand\tableofcontents{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\contentsname}
    {\singlespace\@starttoc{toc}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand\listoffigures{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listfigurename}
    \addcontentsline{toc}{chapter}{\listfigurename}%
    {\singlespacing\@starttoc{lof}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.8em}}
\renewcommand\listoftables{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listtablename}
    \addcontentsline{toc}{chapter}{\listtablename}%
    {\singlespacing\@starttoc{lot}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand*\l@table{\@dottedtocline{1}{1.5em}{2.8em}}
\def\ext@appendix{loa}
\newcommand\listofappendices{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listappendicesname}
    \addcontentsline{toc}{chapter}{\listappendicesname}%
    {\singlespacing\@starttoc{loa}}%
   \if@restonecol\twocolumn\fi
   }
\newcommand*\l@appendix{\@dottedtocline{1}{1.5em}{2.3em}}

% modify \mainmatter to add an entry to table of contents
% that introduces the chapters and to reset the page numbering:
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}%
%  \addtocontents{toc}{%
%    \vspace{1em}\vspace{1pt}%
%    \hbox{\bfseries \chaptername}%
%    \vspace{10pt}}%
  }

% change sections to not add info to toc if in appendix:
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
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
    \if@appendix%
      \relax%
    \else %
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}%
    \fi%
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
  \@xsect{#5}}

% set default pagestyle (Note: \chapter and other things may override this.)
\pagestyle{plain}

% define a new verion of LaTeX's raggedright to allow some hyphenation
% per Edward Tufte's book layout:
%\def\um@raggedright{%
%  \let\\\@centercr\@rightskip\z@ plus .1\hsize
%  \rightskip\@rightskip\leftskip\z@skip}

\def\um@raggedright{%
  \let\\\@centercr\@rightskip\z@ plus .0\hsize
  \rightskip\@rightskip\leftskip\z@skip}


% change LaTeX's footnotes to get vertical spacing correct
\skip\footins \baselinestretch2\skip\footins
\long\def\@footnotetext#1{%
  \insert\footins{%
    \def\baselinestretch {\setspace@singlespace}%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \vskip 1.2\baselineskip
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

% Set captions in smaller font
\newcommand{\captionsize}{\footnotesize\raggedright}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\captionsize #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\captionsize #1: #2\par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% here, we define the public oral announcement page 
\newcommand{\makedefenseannouncement}%
  {\begin{titlepage}%
   \null\vfil
   \begin{spacing}{1}
     \begin{center}%
       {\LARGE\bfseries Carnegie Mellon\\ Pittsburgh, Pennsylvania \par}%
       \vfil%
       {\Large\bfseries FINAL PUBLIC ORAL ANNOUNCEMENT \par}%          
       \vskip .75em
       {\Large\bfseries For the Degree of \par}%          
       \vskip .75em
       {\Large\bfseries Doctor of Philosophy \par}%
     \end{center}          
     \vfil%
    \begin{tabbing}
     Title of Dissertation: \qquad\qquad\qquad  \= xxxxxxxxxxxxxxxxxxxxxxxx \kill
     \textbf{Candidate:} \qquad\qquad \> \@author\ \\
     \>\\
     \textbf{Title of Dissertation:} \>\parbox[t]{4in}{\@title}\\
     \>\\
     \textbf{Department:} \>\@department\ \\
     \>\\
     \textbf{Time:} \>\@time\ \\
     \>\\
     \textbf{Place:} \>\@place\ \\
     \>\\
     \textbf{Examiners:} \>\@chairperson\ \\
     \>\parbox{4in}{\@committee}%
    \end{tabbing}
    \vfil%
     \begin{center}
     {\bfseries PLEASE POST \par}%
     \end{center}
    \end{spacing}
    \vfil\null%
  \end{titlepage}%
   \setcounter{footnote}{0}%
   \setcounter{page}{1}%
}

% here, we define the public overview announcement page 
\newcommand{\makeoverviewannouncement}%
  {\begin{titlepage}%
   \null\vfil
   \begin{spacing}{1}
     \begin{center}%
       {\LARGE\bfseries Carnegie Mellon\\ Pittsburgh, Pennsylvania \par}%
       \vfil%
       {\Large\bfseries PhD THESIS OVERVIEW ANNOUNCEMENT \par}%          
     \end{center}          
     \vfil%
    \begin{tabbing}
     Title of Dissertation: \qquad\qquad\qquad  \= xxxxxxxxxxxxxxxxxxxxxxxx \kill
     \textbf{Candidate:} \qquad\qquad \> \@author\ \\
     \>\\
     \textbf{Advisor:} \qquad\qquad \> \@advisor\ \\
     \>\\
     \textbf{Title of Dissertation:} \>\parbox[t]{4in}{\@title}\\
     \>\\
     \textbf{Department:} \>\@department\ \\
     \>\\
     \textbf{Time:} \>\@time\ \\
     \>\\
     \textbf{Place:} \>\@place\ \\
     \>\\
     \textbf{Examiners:} \>\@chairperson\ \\
     \>\parbox{4in}{\@committee}%
    \end{tabbing}
    \vfil%
     \begin{center}
     {\bfseries PLEASE POST \par}%
     \end{center}
    \end{spacing}
    \vfil\null%
  \end{titlepage}%
   \setcounter{footnote}{0}%
   \setcounter{page}{1}%
}

% re-define the \maketitle command to do the thesis title page:
\renewcommand{\maketitle}%
  {\begin{titlepage}%
   \null\vfil
   \begin{spacing}{1}
     \begin{center}%
     \renewcommand{\baselinestretch}{2.0}
       {\Large\bfseries\@title\par}%
       \vfil%
       {Submitted in partial fulfillment of the requirements for\\[0.15in]
        the degree of \\[0.15in]
        \@degree \\[0.15in]
	in\\[0.15in]
        \@department\\
        \vfil
        \@author\\
        \vspace*{1em}
        \@previousdegrees\\
        \vfil
        Carnegie Mellon University \\
        Pittsburgh, PA\\
        \vspace*{1em}
        \@degreedate\par}
      \end{center}\par
    \end{spacing}
    \null%
     \renewcommand{\baselinestretch}{1.0}
  \end{titlepage}%
   \setcounter{footnote}{0}%
   \setcounter{page}{1}%
%   \global\let\thanks\relax
%   \global\let\maketitle\relax
%   \global\let\@thanks\@empty
%   \global\let\@degree\@empty
%   \global\let\@department\@empty
%   \global\let\@author\@empty
%   \global\let\@committee\@empty
%   \global\let\@previousdegrees\@empty
%   \global\let\and\relax
%   \global\let\degree\relax
%   \global\let\author\relax
%   \global\let\department\relax
%   \global\let\committee\relax
}


% the frontispiece
\newcommand{\makefrontispiece}%
  {\cleardoublepage%
   \thispagestyle{empty}
   \null\vskip 1in%
   \@frontispiece \par%
   \setcounter{page}{1}%
   \global\let\makefrontispiece\relax
   \global\let\frontispiece\relax
   \global\let\@frontispiece\@empty
  }

% the copyright:
\newcommand{\makecopyright}%
  {\cleardoublepage%
   \thispagestyle{empty}
   \null\vfil%
   \newdimen\@tempdimt%
   \newdimen\@tempdimb%
   \settowidth{\@tempdimt}{\@author}%
   \settowidth{\@tempdimb}{All rights reserved.}%
   \ifdim \@tempdimt<\@tempdimb%
     \@tempdimt \@tempdimb%
   \fi%
   \begin{center}
     \renewcommand{\arraystretch}{0.1}%
     \begin{tabular}{rcl}
                  & \@author                      &        \\
       \copyright & \rule[2pt]{\@tempdimt}{0.2pt} & \@date \\
                  & All rights reserved.          &
     \end{tabular}
   \end{center}%
   \vfil\null%
   \setcounter{page}{1}%
   \global\let\makecopyright\relax
  }

% the dedication:
\newcommand{\makededication}%
  {\thispagestyle{empty}\null\vfil%
   \begin{flushright}\mdseries\slshape\@dedication \par\end{flushright}%
   \vfil\null%
   \newpage
   \global\let\makededication\relax
   \global\let\dedication\relax
   \global\let\@dedication\@empty
  }

% the acknowledgements:
\newcommand{\makeacknowledgements}%
  {\chapter*{Acknowledgements}
   \@acknowledgements \par%
   \newpage%
   \global\let\makeacknowledgements\relax
   \global\let\acknowledgements\relax
   \global\let\@acknowledgements\@empty
}

% the list of notation
\newcommand{\makenotationlist}%
  {\chapter*{List of Symbols}
   \@notationlist \par%
   \newpage%
   \global\let\makenotationlist\relasx
   \global\let\notationlist\relax
   \global\let\@notationlist\@empty
}

% the preface:
\newcommand{\makepreface}
  {\chapter*{Preface}
   \@preface \par%
   \global\let\makepreface\relax
   \global\let\preface\relax
   \global\let\@preface\@empty
}

% the vita:
\newcommand{\makevita}
  {\chapter*{Vita}
   \@vita \par%
   \global\let\makevita\relax
   \global\let\vita\relax
   \global\let\@vita\@empty
}

% the afterword:
\newcommand{\makeafterword}
  {\chapter*{Afterword}
   \@afterword \par%
   \global\let\makeafterword\relax
   \global\let\afterword\relax
   \global\let\@afterword\@empty
}

%% the abstract:
%\newcommand{\makeabstract}%
%  {\begin{titlepage}%
%     \null
%     \begin{center}%
%       {\Large\bfseries\MakeUppercase{Abstract}}
%       \vskip \baselineskip
%       {\bfseries\MakeUppercase\@title}
%       \vskip 7\p@
%        by \vskip 2\p@
%        \@author
%     \end{center}
%     \vskip 10\p@
%     \noindent Advisor: \@advisor
%     \vskip 6\p@
%     \noindent \@abstract \par
%   \end{titlepage}%
%   \global\let\makeabstract\relax
%   \global\let\abstract\relax
%   \global\let\title\relax
%   \global\let\author\relax
%   \global\let\@abstract\@empty
%   \global\let\@title\@empty
%   \global\let\@author\@empty
%}

% change the format of the Table of Contents by
% add dotted lines to chapter-level toc entires
\renewcommand*\l@chapter[2]{%
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
      #1\nobreak%
         \leaders\hbox{$\m@th \mkern \@dotsep% \hfil -> core of latex.ltx's
           mu.\mkern \@dotsep mu$}\hfill%
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

%% change \chapter command [book.cls] to allow indentation of first paragraph
%\renewcommand\chapter{%
%  \if@openright\cleardoublepage\else\clearpage\fi%
%%  \if@backmatter\thispagestyle{empty}\else\thispagestyle{plain}\fi%
%  \thispagestyle{plain}
%  \def\baselinestretch{1}%
%  \global\@topnum\z@
%  \@afterindenttrue%
%  \secdef\@chapter\@schapter}

% change toc behavior of chapter entries [book.cls] to
% indent them from the left
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \if@appendix%
                           \addcontentsline{loa}{chap}%
                             {\protect\numberline{%
                                 \hbox{ }\hfill%
                                 \thechapter.\hspace{1em}}%
                              #1}%
                         \else%
                           \addcontentsline{toc}{chap}%
                             {\protect\numberline{\bfseries%
                                 \hbox{ }\hfill%
                                 \thechapter.\hspace{1em}}%
                             \bfseries {#1}}%
                         \fi%
                       \else
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                           \addcontentsline{toc}{chap}%
                             {\protect\numberline{\bfseries%
                                 \hbox{ }\hfill%
                                 \thechapter.\hspace{1em}}%
                             \bfseries {#1}}%
                        \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]
                    \else
%                       \if@mainmatter
                          \@makechapterhead{#2}
                          \@afterheading
 %                      \else%
  %                        \@makeschapterhead{#1}
   %                       \@afterheading
    %                   \fi
                    \fi}
\def\@schapter#1{\@makeschapterhead{#1}\@afterheading}

% add chap entry for table of contents
\newcommand*\l@chap{\@dottedtocline{1}{0.5em}{3.5em}}
% modify indentation of the rest:
\renewcommand*\l@section{\@dottedtocline{2}{5.0em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{3}{8.3em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{4}{12.5em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{5}{15.7em}{5em}}
\setcounter{tocdepth}{3}% default is 2

% change \@makechapterhead to center chapter 
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
%      \if@mainmatter
        \centering%
        \large\bfseries\MakeUppercase\@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
 %     \fi
    \fi
    \interlinepenalty\@M
    \centering%
    \Large \bfseries #1\par\nobreak
    \vskip 40\p@
  }}

% similar for chapter*'s:
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \centering%
    \Large \bfseries\MakeUppercase{#1}\par\nobreak
    \vskip 40\p@
  }}

% redefine \appendix command to produce title page, change counter
% styles, and add entries to table of contents 
\renewcommand{\appendix}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
%  \bgroup%
%    \null\vfil
%    \centering
%    \Large \bfseries \MakeUppercase\appendicesname\par
%    \addcontentsline{toc}{chapter}{\appendicesname}%
%    \vfil\newpage
%  \egroup%
  \if@twoside\null\thispagestyle{plain}\newpage\fi
  \if@tempswa\twocolumn\fi
  \setcounter{chapter}{0}%
  \@appendixtrue
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand\thesection{\thechapter.\@arabic\c@section}
  \renewcommand\theequation{\thechapter.\@arabic\c@equation}
  \renewcommand\thefigure{\thechapter.\@arabic\c@figure}
  \renewcommand\thetable{\thechapter.\@arabic\c@table}
  \renewcommand\thefootnote{\thechapter\@arabic\c@footnote}
}

% change section command to revert to single spacing and to include
% the \FloatBarrier command from the placeins package so figures at
% least stay near the section they are referenced.
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\FloatBarrier%
                                    \def\baselinestretch{1}%
                                    \reset@font\Large\bfseries}}

% change the rest to have single spacing
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                       {-3.25ex\@plus -1ex \@minus -.2ex}%
                                       {1.5ex \@plus .2ex}%
                                       {\def\baselinestretch{1}%
                                        \normalfont\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                          {-3.25ex\@plus -1ex \@minus -.2ex}%
                                          {1.5ex \@plus .2ex}%
                                          {\def\baselinestretch{1}%
                                           \normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                      {3.25ex \@plus1ex \@minus.2ex}%
                                      {-1em}%
                                      {\def\baselinestretch{1}%
                                       \normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                         {3.25ex \@plus1ex \@minus .2ex}%
                                         {-1em}%
                                         {\def\baselinestretch{1}%
                                          \normalfont\normalsize\bfseries}}

% add a contents line for the bibliography and
% single-spaced entries
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}
      \addcontentsline{toc}{chapter}{\bibname}%
      \begin{singlespace}
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
      \endlist\end{singlespace}}

% turn off page numbering for backmatter
\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \@backmattertrue
%  \pagestyle{empty}
  }

% turn on `doublespacing' [setspace]
\AtBeginDocument{\doublespacing\um@raggedright}

% be sure to end with an even number of pages:
\AtEndDocument{\if@openright\cleardoublepage\else\clearpage\fi}
