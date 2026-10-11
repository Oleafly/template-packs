% Revised by Zhuoran Zhang (andyzzr809@gmail.com) on May 2022 for a CMU CEE dissertation.
%====Originally from the CMU ECE dissertation template========
% https://github.com/RS1999ent/cmu_ece_dissertation_template/tree/master
% This is a template for a CMU ECE dissertation.  It conforms to the
% requirements from ECE as of May 2013.  Most importantly, the title
% page is formatted as per ECE standards and does not contain the list
% of committee members.  This template was modified from cmuthesis.cls,
% published by David Koes (www.cs.cmu.edu/~dkoes).  The next comment
% block is from the original cmuthesis.cls file.

%This is a template for a CMU thesis.  It is 18 pages without any content :-)
% The source for this is pulled from a variety of sources and people.
% Here's a partial list of people who may or may have not contributed:
%
%        bnoble   = Brian Noble
%        caruana  = Rich Caruana
%        colohan  = Chris Colohan
%        jab      = Justin Boyan
%        josullvn = Joseph O'Sullivan
%        jrs      = Jonathan Shewchuk
%        kosak    = Corey Kosak
%        mjz      = Matt Zekauskas (mattz@cs)
%        pdinda   = Peter Dinda
%        pfr      = Patrick Riley
%        dkoes = David Koes
%        rajas = Raja Sambasivan

% David Koes's mmain contribution was putting everything into a single
% class files and small template.  Raja Sambasivan updated the
% template and also changed it so as to conform to ECE standards.

\LoadClassWithOptions{book}


%% dkoes - Here's a bunch of stuff taken from mjz-titlepage.sty that makes
% a pretty CMU techreport acceptable title page

%% titlepage parameters
%%   required: title, author, date, Year, trnumber, committee
%%   optional: permission, support, disclaimer, keywords

\def\title#1{\gdef\@title{#1}}
\def\author#1{\gdef\@author{#1}}
\def\date#1{\gdef\@date{#1}}
\def\Year#1{\gdef\@Year{#1}}
% \def\trnumber#1{\gdef\@trnumber{#1}}
\def\degrees#1{\gdef\@degrees{#1}}
\def\permission#1{\gdef\@permission{#1}}
\def\support#1{\gdef\@support{#1}}
\def\disclaimer#1{\gdef\@disclaimer{#1}}
% \def\keywords#1{\gdef\@keywords{#1}}

\newsavebox{\@copyrightbox}
%\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifthenelse{\lengthtest{\wd\@copyrightbox > \linewidth}}{\noindent #1 \par}{\begin{center} #1 \end{center}}}}
\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifdim\wd\@copyrightbox>\linewidth \noindent #1 \par\else\begin{center} #1 \end{center}\fi}}

\def\maketitle{
\thispagestyle{empty}

% calculate skip needed to ensure that title appears in the cut-out
\newlength{\@cutoutvskip}
\setlength{\@cutoutvskip}{2.1875 true in}       % position of cut-out
\addtolength{\@cutoutvskip}{-1 true in}         % printer margin
\addtolength{\@cutoutvskip}{-\topmargin}
\addtolength{\@cutoutvskip}{-\headheight}
\addtolength{\@cutoutvskip}{-\headsep}

%% Centered things on the title page must be *physically* centered
%% on the page, so they line up with the cut-out window. So we hardwire
%% the margins for the title page so that left margin = right margin:
%%         left margin = (8.5in - textwidth)/2
\oddsidemargin=8.5in
\advance\oddsidemargin by -\textwidth
\oddsidemargin=.5\oddsidemargin
\advance\oddsidemargin by -1in % TeX sux
%
\let\footnoterule\relax
\vglue\@cutoutvskip
\begin{center}
%\begin{minipage}[t]{4.875in}   % must be a minipage due to \thanks
\begin{minipage}[t]{4.8in}      % hackery
\vbox to 3in{
\vfill
\begin{center}
{\Large \strut \@title\par}
\vfill
% {\sc \@trnumber\par}
% \vfill
Submitted in partial fulfillment for the requirements for\\
the degreee of\\
Doctor of Philosophy\\
in\\
Civil and Environmental Engineering\\
\end{center}
\vfill}
\end{minipage}
\end{center}

\vskip 3em

\begin{center}
{\large \begin{tabular}[t]{c}\@author\end{tabular}\par}
\end{center}
\begin{center}
    \@degrees
\end{center}
\vskip 10em
\begin{center}
    Carnegie Mellon University\\
    Pittsburgh, PA\\
\vskip 1em
\@date \hspace{1pt} \@Year\par
\end{center}


\vfill

\clearpage
\thispagestyle{empty}
\vspace*{\stretch{1}}
\begin{center}
\@ifundefined{@permission}{\@copyrightnotice{ \copyright\ \@Year\ \@author \@disclaimer }}{\@copyrightnotice{ \copyright\ \@Year\ \@author. \@permission}}
\@ifundefined{@support}{}{{\medskip\footnotesize\noindent\@support\par}}
\@ifundefined{@disclaimer}{}{{\medskip\footnotesize\noindent\@disclaimer All Rights Reserved\par}}
\end{center}
\vspace*{\stretch{3}}
\cleardoublepage
}

\newenvironment{dedication}
  {\clearpage \thispagestyle{empty} \vspace*{\stretch{1}} \begin{center} \em}
  {\end{center} \vspace*{\stretch{3}} \clearpage}

% keywords go at the rear of the dedication
% if keywords are omitted, this page is blank
% \newenvironment*{keywordspage}
% {\clearpage
% \thispagestyle{empty}
% \@ifundefined{@keywords}{}{\vspace*{\fill} {\bf Keywords:} \@keywords}
% \cleardoublepage}

\newenvironment{psuedochapter}[1]
  {\clearpage
%   \thispagestyle{empty}
   \vspace*{\stretch{1}} 
   \begin{center} \large {\bf #1} \end{center}
   \phantomsection
  \addcontentsline{toc}{chapter}{\numberline{}#1} % --not yet mjz 
   \begin{quotation}}
  {\end{quotation} 
   \vspace*{\stretch{3}}
   \clearpage}

\newenvironment{psuedochapternotitle}[1]
  {
    % \clearpage
%   \thispagestyle{empty}
   \vspace*{\stretch{1}} 
  %  \begin{center} \large {\bf #1} \end{center}
  \phantomsection
  \addcontentsline{toc}{chapter}{\numberline{}#1} % --not yet mjz 
   \begin{quotation}}
  {\end{quotation} 
   \vspace*{\stretch{3}}
  %  \clearpage
   }

\newenvironment{abstract}
	{\begin{psuedochapter}{\textbf{\textsf{Abstract}}}}{\end{psuedochapter}}

\newenvironment{acknowledgments}
	{\begin{psuedochapter}{\textsf{Acknowledgments}}}{\end{psuedochapter}}

\newenvironment{listoffiguresenv}
	{\begin{psuedochapternotitle}{\textsf{List of figures}}}{\end{psuedochapternotitle}}

\newenvironment{listoftablesenv}
	{\begin{psuedochapternotitle}{\textsf{List of tables}}}{\end{psuedochapternotitle}}

\newenvironment{glossaryoftermsenv}
{\begin{psuedochapternotitle}{\textsf{Glossary}}}{\end{psuedochapternotitle}}





%% dkoes - what follows is just a result of my personal style preferences
% most things are shamelessly ripped from various conference class files

%                       Utilities
%                       ---------


\newcommand{\centeroncapheight}[1]{%
  {\setbox\@tempboxa = \hbox{#1}%
   \@measurecapheight{\@tempdima}%         % Calculate ht(CAP) - ht(text)
   \advance \@tempdima by -\ht\@tempboxa   %           ------------------
   \divide \@tempdima by 2                 %                   2
   \raise \@tempdima \box\@tempboxa}}

\newbox{\@measbox}

\def \@measurecapheight #1{%                            {\dimen}
  \setbox\@measbox = \hbox{ABCDEFGHIJKLMNOPQRSTUVWXYZ}%
  #1 = \ht\@measbox}

\long\def \@titlefootnote #1#2{%
  \insert\footins{%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
%%%    \protected@edef\@currentlabel{%
%%%       \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \def \@makefnmark {$^{#1}$}%
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#2\@finalstrut\strutbox}%
    \color@endgroup}}

%                       Lists
%                       -----

\setlength{\topsep}{1pt}
 \setlength{\itemsep}{1pt}
\setlength{\parsep}{3pt}

\renewcommand{\labelitemi}{{\small \centeroncapheight{\textbullet}}}
\renewcommand{\labelitemii}{\centeroncapheight{\rule{2.5pt}{2.5pt}}}
\renewcommand{\labelitemiii}{$-$}
\renewcommand{\labelitemiv}{{\Large \textperiodcentered}}

\renewcommand{\@listi}{%
  \leftmargin = \leftmargini
  \listparindent = 0pt}

\let \@listI = \@listi

\renewcommand{\@listii}{%
  \leftmargin = \leftmarginii
  \topsep = 1pt
  \labelwidth = \leftmarginii
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}

\renewcommand{\@listiii}{%
  \leftmargin = \leftmarginiii
  \labelwidth = \leftmarginiii
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}

\renewcommand{\@listiv}{%
  \leftmargin = \leftmarginiv
  \labelwidth = \leftmarginiv
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}


% A simple style file to provide a draft marking in the background of
% a file
% Thank you to Will Uther who provided the base code that I rolled
% into this package
% ChangeLog
% 1.1: shrunk and shifted the stamp so that it avoid the unprintable
% area at the top of the page
% 1.2 dkoes - made it big and rotated and light
% 1.3 dkoes - made it small, and unrotated since Jonathan Aldrich complained
\RequirePackage[pdftex]{graphicx}
\RequirePackage{eso-pic}
\RequirePackage{color}

%Got this from Will (will@cs.cmu.edu)
%usage: \draftstamp{date}{label}
\newcommand{\draftstamp}[2]{\definecolor{DraftGrey}{gray}{0.7}
  \ClearShipoutPicture\AddToShipoutPicture{
    \begin{minipage}[b][\paperheight][t]{\paperwidth}     
    \centering
    	\vspace{.4in}
            \textcolor{DraftGrey}{\renewcommand{\baselinestretch}{1.0}\normalsize
            \begin{tabular}{c}
                    #1 \\
                    #2
             \end{tabular}            
        }
        
    \end{minipage}
}}

% mainmatter is ignoring openany, fix
\renewcommand\mainmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmattertrue
  \pagenumbering{arabic}}
