%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Thesis style to be used in conjunction with the companion %
% "thesis_template.tex".  It is intended to format a thesis %
% or dissertation in accordance with the current (2015)     %
% Thesis/Dissertation Guidelines from the Graduate School   %
% at Texas Tech University                                  %
% (http://www.depts.ttu.edu/gradschool/current/thd.php).    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FORMERLY: Report any problems to Robert Byerly, Department% 
% of Mathematics and Statistics, Texas Tech University      %
% (robert.byerly@ttu.edu)                                   %
% CURRENT: Report any problems to Aaron Hill, Department of %
% Geosciences, Texas Tech University                        %
% (aaron.hill@ttu.edu)                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This has been tested but not rigorously on theses that    %
% have actually been approved by the grad school.           %
% If you use it, *please* report any formatting             %
% issues to robert.byerly@ttu.edu or aaron.hill@ttu.edu     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPDATED BY AARON HILL IN JULY 2017 %


\def\filename{ttuthes2015}
\def\fileversion{3.0}
\def\filedate{2015/4/02} 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ttuthes2015}[\filedate\space\fileversion\space%
       LaTeX document class.]

\LoadClass[oneside,openany,12pt]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Margin  settings -- Some may need to be adjusted.     %
% (Tried the geometry package, but it lacked           %
%  flexibility).                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\voffset}{0in}
\setlength{\topmargin}{-0.5in}  %0pt
\setlength{\hoffset}{0.5in}  %0.5in
\setlength{\oddsidemargin}{0pt}
\setlength{\textwidth}{6in}
\setlength{\textheight}{8.6in}  % 8.1in
%END SETTINGS FOR MARGINS

%To get the double spacing or 1.5 spacing the
%grad school wants:
\RequirePackage{setspace}
\doublespacing  %(or use \onehalfspacing in the document preamble.)

%The grad school doesn't like right-justification:
\raggedright
\setlength{\parindent}{0em}  % was {1em}




%To get the header
\headheight15pt %Makes fancyhdr happy
\RequirePackage{fancyhdr}
\lhead{}\chead{}
%\rhead{} should be customized in the document preamble
\pagestyle{fancy}

%%%%%%%%%%%%%%%%%%%%%%%%%
%For the copyright page %
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\copyrightpage}[2]{%
\thispagestyle{empty}

\begin{center}
\vspace*{\fill}
Copyright #1, #2
\vspace*{\fill}
\end{center}
}

%Graduate school doesn't want a colon after
%"Figure n" in figure and table captions.
%How about a period?
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1. #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\box\@tempboxa}%
  \fi
  \vskip\belowcaptionskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some of the stuff from here on is modified from an earlier %
%style file for theses written by an unknown person.        %
%Thanks! whoever you are!                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\frontmatter}{%
   \if@openright
      \cleardoublepage
   \else
      \clearpage
   \fi
   \@mainmatterfalse
   \pagenumbering{roman}            %% Front Matter roman numerals
   \setcounter{page}{2}             %% Start on the second page 
}

%\def\@makechapterhead#1{%
%	\ \vspace*{-18pt}%
%	{\parindent 0pt
%	 \begin{center}
%	 	\baselineskip=18.5pt
%		\ifnum \c@secnumdepth > \m@ne
%			\ifx\@chapapp\appfl@g
%				\large{\em Appendix \thechapter.\ \ #1}
%			\else
%				\large{\em CHAPTER \thechapter.\ \par\nobreak #1}
%			\fi
%		\else
%			\large{\em #1}
%	\end{center}
%	\par \nobreak
%}}


%\def\@makechapterhead#1{%
%	\vspace*{-20 \p@}%
%	{\parindent \z@ \centering \normalfont
%	\ifnum \c@secnumdepth >\m@ne
%		\if\@chapapp\appfl@g
%			\bf
%			\MakeUpperCase
%			\@chapapp\space #1
%			\par\nobreak
%		\else\if@mainmatter
%			\bf
%   		      	\MakeUppercase
%      		   	\@chapapp\space \thechapter
%       	 		\par\nobreak
%%        \vskip 20\p@
%      	\fi\fi\fi
%    	\interlinepenalty\@M
%	\bf
%     	\MakeUppercase{#1} \par\nobreak
%    	\vskip 20\p@
%}}


% Alter the heading displacement for all page titles except LOF and LOT pages (see below)
\def\@makechapterhead#1{%
  \vspace*{-20 \p@}%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
	\bf
         \MakeUppercase
         \@chapapp\space \thechapter
        \par\nobreak
%        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \bf
     \MakeUppercase{#1} \par\nobreak
    \vskip 20\p@
  }}


%%% Alter the heading displacement of "LIst of Figures", "List of Tables", and "Table of Content" pages
\def\@makeschapterhead#1{%
  \vspace*{-10 \p@}%
  {\parindent \z@ \centering
    \normalfont %originally \normalfont
    \interlinepenalty\@M
    \bf
    \MakeUppercase
     #1\par\nobreak
    \vskip 20\p@
  }}


 \renewcommand*\l@part{\@dottedtocline{0}{0em}{1.5em}}
 \renewcommand*\l@chapter{\@dottedtocline{0}{1.5em}{2.75em}}
 \renewcommand*\l@section{\@dottedtocline{1}{4em}{2.75em}}
 \renewcommand*\l@subsection{\@dottedtocline{2}{5.75em}{2.75em}}
 \renewcommand*\l@subsubsection{\@dottedtocline{3}{7.50em}{4em}}

\def\numberlinetwo#1{\advance\hangindent\@tempdima
  \hbox to\@tempdima{\hfil #1\enspace}}



\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
%                         \addcontentsline{toc}{chapter}%
%                         {\protect\numberlinetwo{\Roman{chapter}}#1}%
%                         \addcontentsline{toc}{chapter}{\arabic{chapter}. #1}%
                         \addcontentsline{toc}{chapter}%
%                         {\@chapapp\space\thechapter. #1}%
                         {\thechapter. #1}%	
                       \else
                         \addcontentsline{toc}{chapter}{#2}%

                       \fi
                    \chaptermark{#1}%
                    %\addtocontents{lof}{\protect\addvspace{2ex}}%
                    %\addtocontents{lot}{\protect\addvspace{2ex}}%
                    %\addtocontents{toc}{\protect\addvspace{2ex}}

                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi
                    }

%                    \if@twocolumn
%                      \@topnewpage[\@makechapterhead{#2}]%
%                    \else
%                      \@makechapterhead{#2}%
%                      \@afterheading
%                    \fi
%                    }

\renewcommand\contentsname{Table of Contents}
\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
%\renewcommand\bibname{Bibliography}
 \renewcommand\indexname{Index}
% \renewcommand\figurename{Figure}
% \renewcommand\tablename{Table}
% \renewcommand\partname{PART}
% \renewcommand\chaptername{CHAPTER}
 \renewcommand\appendixname{Appendix}
% \renewcommand\today{}

\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                     \global\@topnum\z@
                    \@afterindenttrue
                    \secdef\@chapter\@schapter
                    }
                    
\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {3.5ex \@plus 1ex \@minus .2ex}%
                                   {.3ex \@plus.2ex}%
                                   {\normalfont\normalsize\bf
                                   }}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.2ex \@plus .2ex}%
                                     {\normalfont\normalsize
                                     \raggedright\noindent
                                     }}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.2ex \@plus .2ex}%
                                     {\normalfont\normalsize\bf\noindent
                                     \raggedright
                                     }}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize
                                    }}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize
                                      }}

\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \addcontentsline{toc}{chapter}{\listfigurename}
      \@mkboth{%
              \MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%    
    \if@restonecol\twocolumn\fi
    
    }


\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \addcontentsline{toc}{chapter}{\listtablename}
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }

%\renewcommand\@biblabel[2]{}%
%\renewenvironment{thebibliography}[2]
%{\chapter*{\bibname}%
%  \addcontentsline{toc}{chapter}{\bibname}
%  \singlespacing
%      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
%      \list{\@biblabel{\@arabic\c@enumiv}}%
%           {\settowidth\labelwidth{\@biblabel{#1}\bibindent}%
%            \leftmargin\labelwidth
%            \advance\leftmargin\labelsep
%            \@openbib@code
%            \usecounter{enumiv}%
%            \let\p@enumiv\@empty
%            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%      \sloppy
%      \clubpenalty4000
%      \@clubpenalty \clubpenalty
%      \widowpenalty4000%
%      \sfcode`\.\@m}
%     {\def\@noitemerr
%       {\@latex@warning{Empty `thebibliography' environment}}%
%      \endlist}

    

    \renewcommand\floatpagefraction{.9}
    \renewcommand\textfraction{.1} %originally .1
    \setcounter{secnumdepth}{3}
    \setcounter{tocdepth}{3}



\endinput



