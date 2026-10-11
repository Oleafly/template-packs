
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is unhthesis.sty file.
% This style file has been created to satisfy the requirements
% of the graduate school of the University of New Hampshire.
%
% I took the U. Mass umthesis.cls and unhthesis.cls file created by
% Kelly Black and modified them to create this file.
%
%
% Created by: Kourosh Zarringhalam
%
% 05/13/2006.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Identification part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unhthesis}[2006/05/10 23:45:51 1.25
                         University of New Hampshire dissertation class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdouble@space
\newif\ifcondensed@frontmatter
\newif\ifnicer@draft


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Declaration of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\def\@mysize{10pt}}
\DeclareOption{11pt}{\def\@mysize{11pt}}
\DeclareOption{12pt}{\def\@mysize{12pt}}
\DeclareOption{singlespace}{\double@spacefalse}
\DeclareOption{doublespace}{\double@spacetrue}
\DeclareOption{nolisthyphenation}{\def\unhthesis@listhyphenpenalty{10000}}
\DeclareOption{allowlisthyphenation}{\def\unhthesis@listhyphenpenalty{50}}
\DeclareOption{nicerdraft}{\nicer@drafttrue}
\DeclareOption{nonicerdraft}{\nicer@draftfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Execution of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{12pt,doublespace,nolisthyphenation,nicerdraft}
%\ExecuteOptions{12pt,doublespace,nolisthyphenation,nonicerdraft}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[\@mysize]{report}[1996/01/02]
\RequirePackage{textcase}
\RequirePackage{etoolbox}

\newenvironment{singlespace}{\baselineskip=0.0em}{\ifdouble@space\doublespacenormalsize\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Post-package-loading fixups.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{unhth\@mysize.clo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\toc@section}{Chapter}

\newcounter{count@FrontMatter}
\newcounter{count@Chapter}
\newcounter{count@Appendix}
\newcounter{count@BackMatter}

\AtEndDocument{
  \immediate\write\@mainaux{\string\setcounter{count@FrontMatter}
    {\arabic{count@FrontMatter}}}
  \immediate\write\@mainaux{\string\setcounter{count@Chapter}
    {\arabic{count@Chapter}}}
  \immediate\write\@mainaux{\string\setcounter{count@Appendix}
    {\arabic{count@Appendix}}}
  \immediate\write\@mainaux{\string\setcounter{count@BackMatter}
    {\arabic{count@BackMatter}}}
  }


%% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %% %% Major document structure, \frontmatter, \mainmatter, \appendix, \backmatter
%% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\frontmatter}{
  \setcounter{secnumdepth}{-1}
  \renewcommand{\toc@section}{FrontMatter}
  \setcounter{count@FrontMatter}{0}
  \ifdouble@space\doublespacenormalsize\fi
  }

\pagenumbering{roman}                   % Set page numbering to small roman num.
\pagestyle{plain}                  % Put only page numbers in the header. default myheadings
%\@ifundefined{thechapter}               % If chapter counter undefined;
%    {}                                  %   then do nothing;
%    {\def\thefigure                     %   else define \thefigure format.
%        {\thechapter-\arabic{figure}}}  %
%
%\@ifundefined{thechapter}               % If chapter counter undefined;
%    {}                                  %   then do nothing;
%    {\def\thetable                     %   else define \thetable format. Faraz Feb 13, 2012
%        {\thechapter-\arabic{table}}}



\newcommand{\mainmatter}{
  \setcounter{secnumdepth}{5}
  \clearpage
  \pagenumbering{arabic}          % Arabic numbers from here on
  \raggedbottom
    %\flushbottom
  \ifdouble@space\doublespacenormalsize\fi
  \renewcommand{\toc@section}{Chapter}
  \setcounter{count@Chapter}{0}
  }

\renewcommand{\appendix}{
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \renewcommand\@chapapp{\appendixname}
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand{\toc@section}{Appendix}
  \ifnum\value{count@Appendix}<2
    \let\@chapter\@onlyappendix
  \fi
  \setcounter{count@Appendix}{0}
  }

\newcommand{\backmatter}{
  \setcounter{secnumdepth}{5}
  \renewcommand{\@chapapp}{\chaptername}
  \renewcommand{\toc@section}{BackMatter}
  \let\@chapter\normal@chapter
  \setcounter{count@BackMatter}{0}
  \normalsize
  }

\def\@onlyappendix[#1]#2{
  \refstepcounter{chapter}
  \typeout{\@chapapp.}
  \addcontentsline{toc}{OnlyAppendix}{\MakeUppercase{#1}}
  \chaptermark{#1}
  \if@twocolumn
    \@topnewpage[\@makeonlyappendixhead{#2}]
  \else
    \@makeonlyappendixhead{#2}
    \@afterheading
  \fi
  \renewcommand{\thesection}{A.\@arabic\c@section}
  \stepcounter{count@\toc@section}
 }

\def\@makeonlyappendixhead#1{
  { \def\thechapter{} \@makechapterhead{#1} } }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter/Appendix related stuff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Disable uppercase when making PDF strings...this breaks hyperref
\AtEndPreamble{%
  \@ifpackageloaded{hyperref}%
    {\pdfstringdefDisableCommands{%
      \let\MakeTextUppercase\relax%
      \let\MakeUppercase\relax%
      \let\uppercase\relax}%
     \typeout{Disabled uppercase in PDF strings}}%
    {\typeout{Did not detect hyperref package}}%
}


\newcommand{\unnumberedchapter}[2][]{
  \def\@tempa{#1}
  \def\@tempb{}
  \ifx\@tempa\@tempb
    \def\@tempc{#2}
  \else
    \def\@tempc{#1}
  \fi
  \chapter*{#2}
  \addcontentsline{toc}{\toc@section}{\MakeUppercase{\@tempc}}
}

%% redefine @chapter to change toc entries
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{\toc@section}
                         {\protect\numberline{\thechapter.}\MakeUppercase{#1}}%
  \else
    \addcontentsline{toc}{\toc@section}{\MakeUppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi
  \stepcounter{count@\toc@section}
  }

\newif\ifrenew@chapter
\ifdouble@space
  \renew@chaptertrue
\else
  \ifnicer@draft
    \renew@chapterfalse
  \else
    \renew@chaptertrue
  \fi
\fi
\ifrenew@chapter
  \renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi%
    \thispagestyle{plain}%
    \@afterindenttrue%
    \global\@topnum\z@%
    \secdef\@chapter\@schapter%
  }%
\fi

\renewcommand{\@makechapterhead}[1]{    % Heading for \chapter command
%  \vspace*{-10\p@}                      % Space at top of text page. default 30
    \vspace*{0.25in}
  \begin{center}\large\bfseries
    \ifnum \c@secnumdepth >\m@ne
      \MakeUppercase\@chapapp\ \thechapter % 'CHAPTER' and number.
      \par\nobreak
    \fi
  \addvspace{\topskip}
  \MakeUppercase{#1}
  \end{center}
  \par\nobreak                          % TeX penalty to prevent page break.
  \vskip 24\p@                          % Space between title and text.
}

\let\base@schapter\@schapter
\def\@schapter#1{
  \base@schapter{#1}
  \stepcounter{count@\toc@section}
}

\renewcommand{\@makeschapterhead}[1]{   % Heading for \chapter* command
%  \vspace*{0\p@}                       % Space at top of page.default 30
    \vspace*{0.25in}
  \begin{center}
    \large\bfseries                     % Title.
    \MakeUppercase{#1}\par
  \end{center}
 % \nobreak                              % TeX penalty to prevent page break.
  \vskip 24\p@                          % Space between title and text.
  }

\let\normal@chapter\@chapter %% save the chapter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\clubpenalty=10000              % 'Club line'  at bottom of page.
\widowpenalty=10000             % 'Widow line' at top of page.
\displaywidowpenalty=3000       % Math display widow line.
\predisplaypenalty=3000         % Breaking before a math display.
\postdisplaypenalty=2000        % Breaking after a math display.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\tableofcontents}{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \normalsize
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    {\hfill \textbf{Page}\par}%
    {\hyphenpenalty=\unhthesis@listhyphenpenalty\@starttoc{toc}}%
    \if@restonecol\twocolumn\fi
    }


\renewcommand{\contentsname}{Table of Contents}

\def\thetocindent{-1}
\newif\if@seenChapter
\newif\if@seenAppendix
\newif\if@seenBackMatter
\@seenAppendixfalse
\@seenBackMatterfalse

\renewcommand{\@dotsep}{2}

\newlength{\unhthesis@contentshangindent}
\setlength{\unhthesis@contentshangindent}{1.55em}

\renewcommand{\@dottedtocline}[5]{%
  \ifnum #1>\c@tocdepth \else
    \ifnum \thetocindent = #1 \else
      \def\thetocindent{#1}
      \ifdouble@space\addvspace{\topskip}\fi
    \fi
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \advance\rightskip by 0pt plus 1fil\relax% ragged-right contents...
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     \hangindent\unhthesis@contentshangindent
     {#4}\nobreak%
     \leaders\hbox{$\m@th\mkern \@dotsep mu \hbox{.}\mkern \@dotsep mu$}%
             \hskip3em plus1fill\relax%
       \normalfont \normalcolor #5%
     \par}%
  \fi}


\newcommand{\l@FrontMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }

\newcommand{\l@Chapter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenChapter\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \MakeUppercase{\chaptername}} \par
    \addvspace{\baselineskip}
    \@seenChaptertrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries#1}{\bfseries#2}
  }


\newcommand{\appendicesname}{APPENDICES}

\newcommand{\l@Appendix}[2]{
  \addpenalty{-\@highpenalty}
  \if@seenAppendix\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \appendicesname} \par
    \addvspace{\baselineskip}
    \@seenAppendixtrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }



\newcommand{\l@OnlyAppendix}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{2\baselineskip}
  \parindent\z@
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries
    \MakeUppercase{\appendixname}: #1}{\bfseries #2}
  }

\newcommand{\l@BackMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenBackMatter\else
    \addvspace{2\baselineskip}
    \@seenBackMattertrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tweak lists of tables and figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\tablenumberwidth}
\setlength{\tablenumberwidth}{2.3em}
\ifcondensed@frontmatter
  \renewcommand{\listoffigures}{}
\else
  \renewcommand{\listoffigures}{%
    \normalsize
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    {\normalsize\parindent\z@\textbf{Figure \hfill Page}\par}%
    {\hyphenpenalty=\unhthesis@listhyphenpenalty\@starttoc{lof}}%
    \if@restonecol\twocolumn\fi
    }
\fi
\renewcommand{\l@figure}[2]{
  \addvspace{\baselineskip}
  \@dottedtocline{1}{1.5em}{\tablenumberwidth}{#1}{#2}
  }


\renewcommand{\listoftables}{%
  \normalsize
  \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
  \fi
  \chapter{\listtablename
     \@mkboth{%
         \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
   {\normalsize\parindent\z@\textbf{Table \hfill Page}\par}%
   {\hyphenpenalty=\unhthesis@listhyphenpenalty\@starttoc{lot}}%
   \if@restonecol\twocolumn\fi
   }



\let\l@table\l@figure

\let\unhthesis@base@starttoc\@starttoc
\renewcommand{\@starttoc}{\tolerance10000\unhthesis@base@starttoc}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Page layout -- as required
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\oddsidemargin}{0.0truein}  % binding margin at least 1.5in INITIALLY 0.5
\setlength{\evensidemargin}{0.0truein} % same as odd side INITIALLY 0.5
\setlength{\textwidth}{6.5in}      % 6in wide typing area INITIALLY 6.5
\setlength{\topmargin}{-0.5truein} % page numbers at top of page 0.5in from top
\setlength{\headheight}{0.2truein} % room for header
\setlength{\headsep}{0.3truein}    % header 0.3in from body, body 1in from top
\setlength{\textheight}{9.0truein} % 9in high typing area %default 8.75truein
\setlength{\footskip}{0.5truein}   % footer 0.5in from body, 0.5in from bottom


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Added commands and environments for front matter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\DOCUMENTtype#1{\gdef\@DOCUMENTtype{#1}}    % Define \DOCUMENTtype{}
    \def\@DOCUMENTtype{DISSERTATION}                        % This is the ALL CAPS version.
                                                %
\def\Documenttype#1{\gdef\@Documenttype{#1}}    % Define \Documenttype{}
    \def\@Documenttype{}                        % This is the mixed case version

\def\documenttype#1{\gdef\@documenttype{#1}}    % Define \documenttype{}
    \def\@documenttype{}                        % This is the lower case version
                                                %
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}      % Define \predegrees{}
\def\@prevdegrees{}                             %
                                                %
\def\major#1{\gdef\@major{#1}}                  % Define \major{}
                                                %
\def\degree#1{\setbox0\hbox{#1}                 % Define @degreeword depending
  \gdef\@degree{#1}}                            % upon how many degrees are
\def\and{\gdef\@degreeword{degrees}             % being earned.  That way
    \par and \par}                              % we can correctly say either
\def\@degreeword{Degree}                        % 'degree' or 'degrees'.
                                                %
\def\thesisdate#1{\gdef\@thesisdate{#1}}        % Define \thesisdate{}
                                                %
\def\degreemonth#1{\gdef\@degreemonth{#1}}      % Define \degreemonth{}
                                                %
\def\degreeyear#1{\gdef\@degreeyear{#1}}        % Define \degreeyear{}

\def\signatureblank#1                           % Define a signature blank.
   {\hfill                                      % Rubber space pushes this
    \parbox{4in}                                % paragraph box to the right.
      {\rule{-0.05in}{0.75in}%                      % Build a strut,
\vspace{-0.15in}
       \hrulefill\null\\*                       %  Make a signature blank
         {\small                               %  Get a larger font. /switched to normal
          #1                                    %  Put name/title under line.
         }                                      %
      }                                         %
   }                                            %
                                                %
\def\dateblank                                  % Define a date blank.
   {\hfill                                      % As signature blank above...
    \parbox{2.5in}                              %
      {\rule{0in}{0.75in}%                      %
       \hrulefill\null\\*                       %
         {\normalsize Date                           %
         }                                      %
      }                                         %
   }                                            %
                                                %
                                                %
\newbox\@titlecommittee                         % Build box to hold several
                                                % committee member signatures.
                                                %
\def\committee#1#2                              % Define \committee{}{}
   {\setbox\@titlecommittee\vbox                %
      {\unvbox\@titlecommittee                  % unwrap the vbox
       %\par                                     % skip down
       \begin{singlespace}                      % Get single space environment.
       %\signatureblank{ #2}                %  Do a signature line.

       %\signatureblank{#1 \\ #2}                %  Do a signature line.
       \end{singlespace}                        %
      }                                         %
   }                                            %
                                                %
\def\supervisor#1#2                             % Define \supervisor{}{}
   {\gdef\@supervisorname{#1}                   % This is easier since there
    \gdef\@supervisortitle{#2}                  % is only one supervisor.
   }                                            %
                                                %
\def\UNH{UNIVERSITY OF NEW HAMPSHIRE}           % Short cuts for use in the
\def\Unh{University of New Hampshire}           % title page.
                                                %


\def\titlepage{                         % Define start of title page.
    \newpage\centering                  %  Start a new page, center the text.
    \thispagestyle{empty}               %  Don't do headers or footers.
    \parindent 0pt                      %  Don't indent 'paragraphs'.
	%\parskip 10pt plus 5pt minus 5pt
    \parskip 10pt plus 1fil minus 1fil  %  Set spacing between 'paragraphs'.
    \def\baselinestretch{1}             %  Set spacing between lines.
    \@normalsize\vbox to                %
    \vsize\bgroup\vbox to 9in\bgroup    %
    }                                   %

\def\endtitlepage{                      % Define end of title page
    \par\kern 0pt                       %   \kern0pt pushes any depth into
    \egroup\vss\egroup                  %   the height.  (Thanks to MITTHESIS
    }                           %   author and Richard Stone.) JB: removed \newpage


\def\maketitle{\begin{titlepage}
\normalsize
                                \vspace*{0.375in}
               {\def\baselinestretch{1.2}\normalsize\normalsize
                        \MakeTextUppercase{\textbf{\@title}} \par}
                                \vspace*{\fill}\par
                                      BY
                                \vspace*{\fill}\par
                               {\MakeUppercase{\@author}}
                                     \par
                                 \@prevdegrees
                                \vspace*{\fill}\par
                                  \@DOCUMENTtype
                                \vspace*{\fill}\par
                           Submitted to the \Unh \\
                         in Partial Fulfillment of \\
                   the Requirements for the \@degreeword\ of
                                \vspace*{\fill}\par
                                   \@degree
                                     \par
                                      in
                                     \par
                                    \@major
                                \vspace*{\fill}\par
                          \@degreemonth\, \@degreeyear
                                \vspace*{\fill}
   \vskip \baselineskip
\end{titlepage}}



\def\copyrightyear#1                    % Define \copyrightyear{}
   {\gdef\@copyrightyear{#1}
   }

\newcommand{\makecopyright}
    {
      \newpage
      \thispagestyle{empty}
      \vspace*{\fill}
      \begin{center}
                             ALL RIGHTS RESERVED\\
                           \copyright \@copyrightyear\\
                                   \@author
      \end{center}

    }


\def\approvalpage{
    \newpage                                        % Start a new page.
%    \thispagestyle{empty}               % Don't do headers or footers.
    \parindent 0pt                      % Don't indent 'paragraphs'.
    \parskip 10pt plus 1fil minus 1fil  % Set spacing between 'paragraphs'.
    \@normalsize\vbox to
    \vsize\bgroup\vbox to 9in\bgroup
   }

\def\endapprovalpage
   {\par\kern 0pt                       % As in title page.
    \egroup\vss\egroup
   }

\def\makeapproval
   {\begin{approvalpage}
       \normalsize
       \begin{singlespace}
        \small{ This thesis has been examined and approved in partial fulfillment of the requirements for the degree of Doctor of Philosophy in Mechanical Engineering by:}
         \noindent
         %\par
         %\par
         \unvbox\@titlecommittee
         %\par
         \vspace{1 in}
        \hspace{2.532 in}
         On 11/19/2014\\

         \vspace{1 in}
         \small{Original approval signatures are on file with the University of New Hampshire Graduate School.}
         %\dateblank
       \end{singlespace}
       \vspace*{\fill}
            \thispagestyle{empty}
    \end{approvalpage}
   }


%\def\approvalpage{
%    \newpage                                        % Start a new page.
%%    \thispagestyle{empty}               % Don't do headers or footers.
%    \parindent 0pt                      % Don't indent 'paragraphs'.
%    \parskip 10pt plus 1fil minus 1fil  % Set spacing between 'paragraphs'.
%    \@normalsize\vbox to
%    \vsize\bgroup\vbox to 9in\bgroup
%   }
%
%\def\endapprovalpage
%   {\par\kern 0pt                       % As in title page.
%    \egroup\vss\egroup
%   }
%
%\def\makeapproval
%   {\begin{approvalpage}
%       \large
%       \begin{singlespace}
%         This thesis has been examined and approved.
%         \noindent
%         \par
%         \par
%         \unvbox\@titlecommittee
%         \par
%         \dateblank
%       \end{singlespace}
%       \vspace*{\fill}
%            \thispagestyle{empty}
%    \end{approvalpage}
%   }



\def\Dedication{
        \vspace*{0.5in}             % Major sections have 1.5in top margins.
    \chapter*{}       % Don't change section counter or display it.
    \thispagestyle{plain}       % Put the page number on the bottom.
%        \addcontentsline{toc}       % But *do* put an entry for this page into
%       {FrontMatter}{Dedication}    % the table of contents.
    \@normalsize                %
   }                            %
\def\endDedication{\par}

\def\Extra{
        \vspace*{0.5in}             % Major sections have 1.5in top margins.
    \chapter*{Ode to The Laser}       % Don't change section counter or display it.
    \thispagestyle{plain}       % Put the page number on the bottom.
        %\addcontentsline{toc}       % But *do* put an entry for this page into
       %{FrontMatter}{Ode to The Laser}    % the table of contents.
    \@normalsize                %
   }                            %
\def\endExtra{\par}



\def\Acknowledgments{
        \vspace*{0.5in}
    \chapter*{Acknowledgments}
    \thispagestyle{plain}
        \addcontentsline{toc}{FrontMatter}{\MakeTextUppercase{Acknowledgments}}
    \@normalsize
   }
\def\endAcknowledgments{\par}



\def\listofnomenclature{
    \newpage
    \phantomsection
    \addcontentsline{toc}{FrontMatter}{\MakeTextUppercase{Nomenclature}}
    \printnomenclature[1in]
}



\def\foreword
   {\thispagestyle{plain}
    \vspace*{0.5in}
    \chapter*{Foreword}
    \addcontentsline{toc}{FrontMatter}{Foreword}
    \@normalsize
   }
\def\endforeword{\par}



%\def\Abstract
%   {\small
%    \addcontentsline{toc}{FrontMatter}{Abstract}
%    \@normalsize
%   }

\def\Abstract{
        %s\vspace*{0.5in}
    %\chapter*{Abstract}
    \thispagestyle{plain}
        \addcontentsline{toc}{FrontMatter}{\MakeTextUppercase{Abstract}}
    \@normalsize
   }
\def\endAbstract{\par}

\def\Abstractpage
   {%\newpage
    \phantomsection
    \thispagestyle{plain}
    \vspace*{0.5in}
    \begin{center}
       {\def
             %\baselinestretch{1.2}
             \baselinestretch{1.2}
                         \Large\bf ABSTRACT \par\par}
                            {\large{\bf \@title} \\
                                     by \\
                                  \@author \\
                            }
                      \def\baselinestretch{1}\@normalsize
                      \Unh, \@degreemonth, \@degreeyear \\

    \end{center}
    \par
    \begin{Abstract}
   }

\def\endAbstractpage
   {\end{Abstract}
    \newpage
   }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak chapter headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% Text heading tweaks
%%

\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{3}


\ifdouble@space
\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
                {4.5ex \@plus 1ex \@minus .2ex}
                {0.001ex \@plus .2ex}
                {\normalfont\doublespacelarge\bfseries}}

\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\paragraph}{
  \@startsection{paragraph}{4}{\z@}%
                {2.5ex \@plus 1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{
  \@startsection{subparagraph}{5}{\parindent}%
                {0.0ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}
\else\ifnicer@draft\else
\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
                {3.5ex \@plus 1ex \@minus .2ex}
                {2.3ex \@plus .2ex}
                {\normalfont\large\bfseries}}

\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\paragraph}{
  \@startsection{paragraph}{4}{\z@}%
                {3.25ex \@plus1ex \@minus.2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{
  \@startsection{subparagraph}{5}{\parindent}%
                {3.25ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}
\fi\fi
%%
%% Fix captions
%%

\setlength\abovecaptionskip{\topskip}
\setlength\belowcaptionskip{\topskip}

\long\def\@makecaption#1#2{%
  \addvspace{\abovecaptionskip}
  \sbox\@tempboxa{\textbf{#1.} #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textbf{#1.} #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \par
  \vskip\belowcaptionskip
  \par
  }


%%
%% Default spacing of tabular environment to single
%%
\let\base@tabular\tabular
\renewcommand{\tabular}[2][]{\base@tabular[#1]{#2}}

%%
%% Fix quote and quotation environments
%%
\renewenvironment{quotation}{%
  \list{}{%
    \listparindent 1.5em%
    \itemindent    \listparindent%
    \rightmargin   \leftmargin%
    \parsep        \z@ \@plus\p@%
    }%
  \normalsize%
  \item[]%
  }%
{\endlist}
\renewenvironment{quote}{\list{}{\rightmargin\leftmargin}\item[]}
                        {\endlist}


%%
%% Fix footnotes -- double spacing between footnotes, single spacing within
%%     footnotes is what is required.

\newlength{\unhthesis@basefootnotesep}
\newlength{\unhthesis@baseskipfootins}

\setlength{\unhthesis@basefootnotesep}{\footnotesep}
\setlength{\unhthesis@baseskipfootins}{\skip\footins}

\ifdouble@space
  \setlength{\footnotesep}{2\unhthesis@basefootnotesep}
  \setlength{\skip\footins}{2\unhthesis@baseskipfootins}
\fi

\let\base@footnotetext\@footnotetext
\long\def\@footnotetext{%
  \renewcommand{\baselinestretch}{1}%
  \base@footnotetext%
}

%%
%% Fix the bibliography

\AtBeginDocument{%
  \let\base@thebibliography\thebibliography%
  \let\endbase@thebibliography\endthebibliography%
  %
  \renewenvironment{thebibliography}[1]{%
    \begin{base@thebibliography}{#1}%
      \addcontentsline{toc}{\toc@section}{\MakeUppercase{\bibname}}%
    }{\end{base@thebibliography}}}

\newcommand{\doublespace}{\doublespacenormalsize}

% Silence hyperref warning about bookmark level
\providecommand*{\toclevel@FrontMatter}{0}
\providecommand*{\toclevel@Chapter}{0}
\providecommand*{\toclevel@BackMatter}{0}
\providecommand*{\toclevel@Appendix}{0}
