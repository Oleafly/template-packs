\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}

%% ========================== Default Values ========================== %%

\newcommand*{\@university}{École Polytechnique Fédérale de Lausanne (EPFL)}
\newcommand*{\@lab}{Laboratory for Information and Inference Systems (LIONS)}
\newcommand*{\@college}{}
\newcommand*{\@department}{}
\newcommand*{\@field}{}
\newcommand*{\@degree}{}
\newcommand*{\@diploma}{}
\newcommand*{\@supervisor}{}
\newcommand*{\@adviser}{}
\newcommand*{\@supervisortwo}{}
\newcommand*{\@expert}{}
\newcommand*{\@typethesis}{}


%% ========================== User Variables ========================== %%

\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\lab}[1]{\gdef\@lab{#1}}
\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\field}[1]{\gdef\@field{#1}}
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\adviser}[1]{\gdef\@adviser{#1}}
\newcommand*{\supervisortwo}[1]{\gdef\@supervisortwo{#1}}
\newcommand*{\expert}[1]{\gdef\@expert{#1}}
\newcommand*{\typethesis}[1]{\gdef\@typethesis{#1}}

%% ========================== Class declarations ========================== %%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions
\LoadClass{memoir}

%% =========================== Packages used ============================== %%
\RequirePackage[left=4.2cm,right=4.2cm,top=2.97cm,bottom=5.94cm]{geometry}
\RequirePackage{ucs}
%\RequirePackage[utf8x]{inputenc}
\RequirePackage[british]{babel}                % To use English hyphenation.
%\usepackage{multicol,multirow}
%\usepackage{microtype}
%\usepackage{type1cm}                    % Scale Computer Modern fonts properly
%\usepackage{tocloft}
\usepackage{xcolor}
\RequirePackage[pdftex]{graphicx}
\RequirePackage[pdftex,unicode,pagebackref=true,
 % citecolor=Black,linkcolor=Black,
 colorlinks=true,
 pdffitwindow=true,
 pdfpagemode=UseNone,pdfpagelabels,
 plainpages=false,breaklinks=true] { hyperref}
%\fixpdflayout
%\usepackage{memhfixc}
\usepackage{chngcntr}
	
%% ============================ Page geometry ============================= %%

\setstocksize          {297mm}{210mm}         % A4 page size
\settrimmedsize{\stockheight}{\stockwidth}{*} % page same size as stock (no trim)
\setlrmarginsandblock{27mm}{26mm}{*}          % inner / outer margin
\setulmarginsandblock{40mm}{40mm}{*}          % top / bottom margin
\setheadfoot           {5mm}{15mm}            % Head height / foot skip
\setheaderspaces       {*}{5mm}{*}            % Head drop / head sep
%\setlength{\parindent} {2em}
%\setlength{\parskip}   {0.5\baselineskip}
\checkandfixthelayout                         % make sure everything adds up


% numbering of chapter, section, table, figure, and equation:
\renewcommand{\thechapter}      {\arabic{chapter}}
\renewcommand{\thesection}      {\arabic{section}}
\renewcommand{\thesubsection}   {\thesection.\arabic{subsection}}
%\renewcommand{\thetable}        {\arabic{table}}
%\renewcommand{\thefigure}       {\arabic{figure}}
\renewcommand{\theequation}     {\arabic{equation}}

% redefine some standard LaTeX words
\def\captionsenglish{
        \def\chaptername    {Chapter}
        \def\contentsname   {Contents}
        \def\appendixname   {Appendix}
        \def\bibname        {Bibliography}
}

%% =========================== General options ============================ %%

%\sloppy                                % suppress hyphenation
%\trimFrame                             % To use full lines for trimming
%\trimXmarks                             % To use corners for trimming
%\leavespergathering{8}					% If specific # of pages required by publisher

\maxsecnumdepth{subsection}             % Section numbering depth
%\maxtocdepth{section}                   % Table of contents depth

\newcommand {\halfendline}  {\\[5pt]}   % Endlines
\newcommand {\fullendline}  {\\[11pt]}

\newcommand {\ptext}[1]     {\small #1} % text in figures slightly smaller
\def\pshlabel#1{\small #1}
\def\psvlabel#1{\small #1}

\newcommand{\tablesettings}{            % settings for a table
\renewcommand{\arraystretch}{1.3}
\renewcommand{\baselinestretch}{1.5}
\setlength\doublerulesep{0pt}
\doublerulesepcolor{black}\center
}

%% Ensure no bad boxes if page count reaches three figures
\renewcommand{\@pnumwidth}{2em}
\renewcommand{\@tocrmarg}{3em}


%% ============================= Page Style =============================== %%

\makeatletter
\setlength\midchapskip{10pt}


\makepagestyle{TUDelft}
\makerunningwidth{TUDelft}{\textwidth}
\makeheadposition{TUDelft}{}{}{}{}
\makeheadrule{TUDelft}{\textwidth}{\normalrulethickness}
\makepsmarks{TUDelft}{\@ruledmarks}
\makeevenhead{TUDelft}{\normalfont\slshape\leftmark}{}{}
\makeoddhead{TUDelft}{}{}{\normalfont\slshape\rightmark}
\makeevenfoot{TUDelft}{\slshape\thepage}{}{}
\makeoddfoot{TUDelft}{}{}{\slshape\thepage}



%% ============================== Formatting ============================== %%

\let\thesis@frontmatter=\frontmatter
\def\frontmatter{
  \thesis@frontmatter
  \setlength{\parindent}{0em}             % Set indentation in frontmatter
  \setlength{\parskip}{0\baselineskip}
  \pagestyle{empty}
  \aliaspagestyle{chapter}{TUDelft}
  \aliaspagestyle{cleared}{TUDelft}
}


\let\thesis@mainmatter=\mainmatter
\def\mainmatter{
  \thesis@mainmatter
  \setlength{\parindent}{1em}             % Set indentation in main
  \setlength{\parskip}{0.5\baselineskip}
%  \setlength{\parskip}{0.6ex}
%  \widowpenalty=7000
%  \clubpenalty=5000
  \chapterstyle{madsen}
  \pagestyle{TUDelft}                   % Change to the pagestyle
  \aliaspagestyle{chapter}{TUDchapter}
  \aliaspagestyle{cleared}{TUDelft}
}

\let\thesis@backmatter=\backmatter
\def\backmatter{
  \thesis@backmatter
  \setlength{\parindent}{1em}             % Set indentation in backmatter
  \setlength{\parskip}{0.5\baselineskip}
  \chapterstyle{reparticle}
  \aliaspagestyle{cleared}{TUDelft}
}

%% ============================ Title Page ================================ %%

\newcommand{\titlepage}{
%\begin{titlepage}
 \par
 \clearpage
% \thispagestyle{\titlepagestyle}
 \thispagestyle{empty}

 \null\vfill
 \begin{center}
    \includegraphics[width=1.5in]{figures/Logo_EPFL.pdf}
  \vskip 3em
  {\huge\textbf \@title\par}
  {\Large \lineskip 0.35em
  \begin{tabular}[t]{c}
   \@author
  \end{tabular}\par}
  \vskip 1.5em
  {\large \@date \par}
  \vskip \z@ %\@plus3fill
  \ifx\@typethesis\@empty \else {\large \@typethesis}\\[1\baselineskip]\fi \vskip \z@ \@plus2fill
%
{Approved by the Examining Committee:}\par
\vspace{1.5\baselineskip}
\@supervisor, Thesis Supervisor\\[1\baselineskip]
\ifx\@supervisortwo\@empty \else \@supervisortwo, Thesis Supervisor\\[1\baselineskip]\fi
\@adviser, Thesis Advisor \\[1\baselineskip]
\@expert, External Reviewer\par
%
  \vskip 3em
 \end{center}\par
 \noindent\begin{minipage}[t]{\textwidth}
  \centering\large
  \ifx\@university\@empty \else \@university\par\fi
  \@college
  \ifx\@department\@empty \else \par Department of \@department\fi
  \ifx\@lab\@empty \else \@lab\par\fi
 \end{minipage}
 \noindent\begin{minipage}[b]{\textwidth}
  \centering
  %This thesis describes my own research.  % % You can uncomment this line to emphasize further that this is a product of your own work.

 \end{minipage}
 \clearpage
}


%% ======================================================================== %%
