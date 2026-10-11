%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DMSE-Thesis.cls 
%----------------------------------------------------------------------%
% Frank Ernst
% Department of Materials Science and Engineering
% Case Western Reserve University
%
% Based on:
%
% (i) amsbook.cls.
%
% (ii) nuthesis.cls by Miguel A. Lerma for writing doctoral
% dissertations at the Mathematics Department of Northwestern University
% (version of 06-05-09).
%
% (iii) Edits by Roger French et al.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\typeout{}
\ProvidesClass{DMSE-Thesis}[2018-06-22 v2.0 Frank Ernst]
\RequirePackage{ifthen}
\newboolean{help}
\setboolean{help}{false}
\DeclareOption{help}{\setboolean{help}{true}}
\PassOptionsToClass{oneside}{amsbook}
  \typeout{}
\DeclareOption*{
  \typeout{Pass to amsbook.cls: \CurrentOption}
  \PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax
\ifthenelse{\boolean{help}}
  {\typeout{}
   \typeout{*** Change linespacing with \protect\setstretch{real number}.}
   \typeout{*** Option reqno puts equation numbers on the right.}}
\typeout{}
\LoadClassWithOptions{amsbook}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{color}
% Default colors for hyperlinks, citations, headlines.
\definecolor{linkcol}{rgb}{0.,0.,0.}
\definecolor{citecol}{rgb}{0.,0.,0.}
\definecolor{headcol}{rgb}{0.4,0.4,0.4}

\RequirePackage[bookmarks, bookmarksopen=true, plainpages=false,
pdfpagelabels, pdfpagelayout=SinglePage, colorlinks=true,
citecolor=citecol, linkcolor=linkcol]{hyperref}

% Set line spacing commands.
\RequirePackage{setspace}                        
\renewcommand{\onehalfspacing}{\setstretch{1.4}} 
\renewcommand{\doublespacing}{\setstretch{1.8}}  


%----------------------------------------------------------------------%
% Page Layout
%----------------------------------------------------------------------%

% % Define page layout A.
% \setlength{\textheight}{8.0in}
% \setlength{\topmargin}{0in}
% \setlength{\headsep}{0.5in}
% \setlength{\footskip}{0.5in}
% \setlength{\headheight}{12pt}
% \setlength{\textwidth}{6.3in}
% \setlength{\oddsidemargin}{0.1in}
% \setlength{\evensidemargin}{0.1in}

% Define page layout B.
\voffset=-0.07in
\setlength{\textheight}{8.35in}
\setlength{\topmargin}{0in}
\setlength{\headsep}{0.5in}
\setlength{\footskip}{0.5in}
\setlength{\headheight}{12pt}
\setlength{\textwidth}{6in}
\setlength{\oddsidemargin}{0.5in}
\setlength{\evensidemargin}{0.5in}


%----------------------------------------------------------------------%
% Headline Formatting
%----------------------------------------------------------------------%

\renewcommand\thesection{\thechapter.\@arabic\c@section}
\renewcommand\thefigure {\thechapter.\arabic{figure}}
\renewcommand\thetable {\thechapter.\arabic{table}}

% Define layout of section headings.
\renewcommand{\section} {\@startsection{section}{1}
  {\z@}{-5ex\@plus -3ex}{.5\baselineskip}%
  {\normalfont\bfseries\large\fontfamily{phv}\selectfont\color{headcol}}}
\renewcommand{\subsection} {\@startsection{subsection}{2}%
  {\z@}{-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
  {\normalfont\bfseries\fontfamily{phv}\selectfont\color{headcol}}}
\renewcommand{\subsubsection} {\@startsection{subsubsection}{3}%
  {\z@}{-\z@}{-.5em}%
  {\normalfont\itshape\bfseries\small%
    \fontfamily{phv}\selectfont\color{headcol}}}


%----------------------------------------------------------------------%
% Page Styles
%----------------------------------------------------------------------%
% Do not allow pagestyle "plain."
\def\ps@plain{\ps@headings}

% Redefine the headings pagestyle: amsbook.cls yields scriptsize and
% distinugishes odd from even pages, but we want normal size and the
% pagenumber always on the right (corresponding to odd pages).
\def\ps@headings{\ps@empty
  \def\@evenhead{\@oddhead}%
%     \setTrue{runhead}%
%     % Changed from scriptsize.
%     \normalfont\normalsize        
%     \rlap{\thepage}\hfil \leftmark{}{}\hfil}%
  \def\@oddhead{%
    \setTrue{runhead}%
    % Changed from scriptsize.
    \normalfont\normalsize \hfil
    \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\chaptermark{%
    \@secmark\markboth\chapterrunhead{}}%
  \def\sectionmark{%
    \@secmark\markright\sectionrunhead\sectionname} }

% Page style for pages starting a new chapter. We also use this for the
% roman-numbered front matter. Different from regular pages, the page
% number appears centered at the bottom and the chapter title does not
% appear as a column title on the left.
\def\ps@newchapter{\ps@empty
  \def\@evenhead{\@oddhead}%
  \def\@oddhead{}%
  \def\@evenfoot{\@oddfoot}%
  \def\@oddfoot{%
    % Changed from scriptsize.
    \normalfont\normalsize \hfil\thepage\hfil}
  \let\@mkboth\markboth
  \def\partmark{}%
  \def\chaptermark{}%
  \def\sectionmark{}}

% Page style for frontmatter.
\def\ps@front{\ps@empty
  \def\@evenhead{\@oddhead}%
  \def\@oddhead{}%
  \def\@evenfoot{\@oddfoot}%
  \def\@oddfoot{%
    % Changed from scriptsize.
    \normalfont\normalsize\hfil\thepage\hfil}}


%----------------------------------------------------------------------%
% Define Thesis Prarameters
% ----------------------------------------------------------------------%

\def\@title{Title of dissertation required}
\def\degree#1{\def\d@gree{#1}}
\def\d@gree{Doctor of Philosophy} 
\def\advisor#1{\def\advis@r{Thesis Advisor:\ #1}}
\def\advis@r{}
\def\department#1{\def\dep@rtment{#1}}
\def\dep@rtment{Department Missing}
\def\campus#1{\def\c@mpus{#1}}
\def\c@mpus{Case Western Reserve University}

% Automatically determine graduation date.
\def\graduation@month{\ifcase\month\or
    January\or May\or May\or May\or May\or August\or August\or
    August\or January\or January\or January\or January\fi}
\def\graduation@year{\number\year}
\def\graduationmonth#1{\def\graduation@month{#1}}
\def\graduationyear#1{\def\graduation@year{#1}}
\def\@date{\graduation@month \graduation@year}


%----------------------------------------------------------------------%
% Settings for Thesis Sections
%----------------------------------------------------------------------%

\def\frontmatter{%
  \def\ps@plain{\ps@front}
  \clearpage
  \pagestyle{front}
  \pagenumbering{roman}}
\def\mainmatter{%
  \pagestyle{myheadings}
  \def\ps@plain{\ps@headings}} 
\def\backmatter{\clearpage}
\def\titlepage{%
  \clearpage
  \thispagestyle{empty}\setcounter{page}{1}}
\def\endtitlepage{\newpage}
\def\copyrightpage{%
  \clearpage
  \thispagestyle{empty}
  \begin{center}
    \mbox{} 
    \vfill
    Copyright \copyright\ \graduation@year\ by \authors{}.\\
    All Rights Reserved.
  \end{center}
  \newpage
  \copyrightsignaturepage
  \thispagestyle{empty}}
\def\endcopyrightpage{\newpage}
\def\copyrightsignaturepage{%
  \thispagestyle{empty}
  \mbox{} 
  \begin{center}
    \vspace{3cm}
    \parbox{\hsize}{I grant to Case Western Reserve University the
      right to use this work, irrespective of any copyright, for the
      University's own purposes without cost to the University or to
      its students, agents, and employees. I further agree that the
      University may reproduce and provide single copies of the work,
      in any format other than in or from microforms, to the public
      for the cost of reproduction.}
    \vspace{1.5cm}
    \mbox{}
    \rule{\hsize}{0.5pt}
    \authors
  \end{center}}

\newcommand{\dedication}[1]{%
  \newpage
  \thispagestyle{empty}
  \renewcommand{\baselinestretch}{1}
  \begin{tabular}{p{\hsize}}
    \raggedleft
    \large
    \textit{#1}
  \end{tabular}
  \vfil}

%----------------------------------------------------------------------%
% Title Page
%----------------------------------------------------------------------%

\def\maketitle{%
  \par
  % This prevents figures from falling at the top of page 1.
  \@topnum\z@ 
  \begin{titlepage}
    \sf
    \begin{center}
      \edef\uppercasetitle{\uppercase{\@title}}
      {\Large\bfseries\@title}
      \vfill
      \vspace{0.5cm}
      \ifx\@empty\authors
      Author Name Required\par
      \else
      {\large\sc\authors}\par
      \fi
      \vfill\vfill
      \vspace{0.5cm}
      {\large Thesis}\\[1ex]
      {\small Submitted in Partial Fulfillment of the Requirements for the Degree of}\\[1ex]
      {\large\d@gree{}}\par
      \vfill
      \advis@r\par
      \vfill
      \dep@rtment\par
      \vspace*{6pt}
      {\sc Case Western Reserve University}
      \vfill
      \vspace{0.5cm}
      {\small \graduation@month{}, \graduation@year{}}
    \end{center}
  \end{titlepage}}


%----------------------------------------------------------------------%
% Signature Page
%----------------------------------------------------------------------%

\newcommand{\signaturepage}{%
  \setstretch{1}
  \thispagestyle{empty}
  \begin{center}
    \sf
    {{\large\textbf{\@title}}\\[12pt]
      Case Western Reserve University\\
      Case School of Graduate Studies\\[12pt]}
    We hereby approve the thesis\footnote{We certify that written approval has been obtained for any proprietary material contained therein.} of\\[12pt]
    \textbf{\authors}\\[12pt]
    for the degree of\\[12pt]
    \textbf{\d@gree}\\[24pt]
  \end{center}}

% Enter committee member signatures.
% Call: \sign[opt. Function, e.g. Advisor]{Name}{Chair or Member}{Department}
\newcommand{\sign}[4][]{
  \vspace{36pt}
  \noindent\textbf{\sf#2}\\
  \rule{\hsize}{0.25pt}\\
  {\sf Committee #3\ifx#1\empty\else,\fi~#1\hfill Date\\
  #4\par}}


%----------------------------------------------------------------------%
% Abstract Formating
%----------------------------------------------------------------------%

\renewcommand{\abstract}{%
  \thispagestyle{newchapter}
  \chapter*{\abstractname}
  \begin{center}
    {\large\@title{}}\par
    \medskip
    \authors{}\par
  \end{center}
  \bigskip}
\def\abstractname{ABSTRACT} 

% Format acknowledgements.
\newcommand{\acknowledgements}{\chapter*{\acknowledgementsname}}
\def\acknowledgementsname{Acknowledgements}

% Format preface.
\newcommand{\preface}{\chapter*{\prefacename}}
\def\prefacename{Preface}

% Format table of contents.
\renewcommand\contentsname{Table of Contents}

\newcommand{\vita}{\chapter*{\vitaname}}
\def\vitaname{Vita}


%----------------------------------------------------------------------%
% Bibliography Formatting
%----------------------------------------------------------------------%

% Normal size font, single line spacing, and
% double space between items.
%\def\bibname{References\\[-12pt]{\small\normalfont\textit{\ch@ptertitle}}}
\def\bibname{References}
\renewenvironment{thebibliography}[1]{%
  \@xp\chapter\@xp*\@xp{\bibname}%
  % \normalfont\footnotesize 
  \labelsep .5em\relax
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{%
    \settowidth\itemsep\@mainsize
    \begin{singlespace}
      \settowidth\labelwidth{\@biblabel{#1}}%
      \leftmargin\labelwidth \advance\leftmargin\labelsep
      \usecounter{enumiv}}%
    \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
    \sfcode`\.=\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \end{singlespace}
  \endlist}


%----------------------------------------------------------------------%
% Appendices Formatting
%----------------------------------------------------------------------%

\def\appendix{%
  \par
  \c@chapter\z@ \c@section\z@
  \def\thechapter{\@Alph\c@chapter}
  \def\appendixname{Appendix}
  \let\chaptername\appendixname
  %\def\thechapter{{}}
  \renewcommand\thesection{\@arabic\c@section}
  \def\@makechapterhead##1{\global\topskip 0pc\relax
    \begingroup
    \fontsize{\@xivpt}{18}\fontfamily{pag}\selectfont\bfseries\centering
    \chaptername\ \thechapter\\[6pt] ##1\par \endgroup
    \skip@34\p@ \advance\skip@-\normalbaselineskip
    \vskip\skip@ }
  \markboth{\textit{Appendix}}{\textit{Appendix}}}

\def\appendices{\par
  \c@chapter\z@ \c@section\z@
  \let\chaptername\appendixname
  \def\thechapter{\@Alph\c@chapter}}


%----------------------------------------------------------------------%
% Chapter Start Formatting
%----------------------------------------------------------------------%

% Set afterindentfalse to suppress indentation of first line in
% parargraph after chapter headline?

\def\chapter{%
  \clearpage\thispagestyle{plain}
  \global\@topnum\z@
  \@afterindenttrue \secdef\@chapter\@schapter}

\def\@makechapterhead#1{\global\topskip 5pc\relax%
  \def\ch@ptertitle{#1}
  \markright{\textit{\ch@ptertitle}\hfill}
  \thispagestyle{newchapter}
  \begingroup%
  \fontsize{\@xivpt}{18}\noindent%
  \Huge{\fontfamily{phv}\selectfont%
    \textcolor{headcol}{\thechapter\hspace{1ex}#1}}\par%
  \endgroup%
  \skip@120\p@\advance\skip@-\normalbaselineskip%
  \vskip\skip@\par}

\def\@makeschapterhead#1{\global\topskip 0pc\relax
  \thispagestyle{newchapter}
  \begingroup
  \fontsize{\@xivpt}{10}\fontfamily{pag}\selectfont\bfseries\centering
  #1\par \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2<\c@secnumdepth\let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
  \@tempskipa #5\relax
  \ifnum #2>\c@secnumdepth
  \let\@svsec\@empty
  \else
  \refstepcounter{#1}%
  \edef\@secnumpunct{%
    \ifdim\@tempskipa>\z@ % not a run-in section heading
    \@ifnotempty{#8}{\@nx\enspace}%
    \else
    \@ifempty{#8}{.}{\@nx\enspace}%
    \fi}
  \protected@edef\@svsec{%
    \ifnum#2<\@m
    \@ifundefined{#1name}{}{%
      \ignorespaces\csname #1name\endcsname\space}%
    \fi
    \@seccntformat{#1}}%
  \fi
  \ifdim \@tempskipa>\z@ 
  % This is not a run-in section heading.
  \begingroup #6\relax
  \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
  \endgroup
  \csname #1mark\endcsname{#7}%
  \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  \else
  \def\@svsechd{%
    #6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip
      \@addpunct.}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi}%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

\def\@seccntformat#1{%
  \protect\textup{\protect\@secnumfont
    \csname the#1\endcsname\ 
    \protect\@secnumpunct}}

% Arabic chapter number.
\renewcommand\thechapter{\arabic{chapter}}

%----------------------------------------------------------------------%
% Limit Depth of Headline Numbering
%----------------------------------------------------------------------%

% Recommended: 2
\setcounter{secnumdepth}{2}

%----------------------------------------------------------------------%
% For Mathemathicians
%----------------------------------------------------------------------%

\def\th@plain{%
  \thm@headfont{\bfseries}
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
  \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \itshape}

\def\th@definition{%
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
  \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape}

\def\th@remark{%
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
  \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape}


%----------------------------------------------------------------------%
% Miscellaneous
%----------------------------------------------------------------------%

% Redefine font for proofname.
\renewcommand{\proofname}{\bfseries{Proof}}

\numberwithin{equation}{chapter}

\def\l@figure{\@tocline{0}{3pt plus2pt}{0pt}{}{}}

\let\l@table=\l@figure

% Redefine caption font (\scshape in amsbook.cls).
\def\@captionheadfont{\normalfont}  

\endinput

% End of file `DMSE-Thesis.cls'.
