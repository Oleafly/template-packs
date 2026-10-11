% Name: csuthesis class
% Purpose: Try to conform to the current CSU Grad School formatting flavor of
% the semester.
%
% History:
%   2009     -- Ankur Dave's creating your own LaTex class information
%               under CC-GNU GPL version 2.0. Presumably, the taken from
%               http://ankurdave.com/tex/
%   20121101 -- Leif Anderson in the CSU developed a foundation
%               for the csuthesis class.
%   20130101 -- Christopher Slocum greatly modified the work to fix some
%               known problem and to change the class to conform to
%               American Meteorological Standards. The AMS LaTex template
%               provided a starting point. AMS is referred to as ametsoc in the
%               comments to avoid confusion.
%   20131020 -- Christopher Slocum fixed issues related to ToC and added more
%               ametsoc requirements.
%   20131108 -- Christopher Slocum fixed issues with spacing and ToC
%   20170825 -- Christopher Slocum fixed the hyperlink issues
%               Updated chapter, section, subsection, subsubsection format
%               Added font size, font family, and url color options
%               Came up with a better way to do the TOC
%               Updated Appendix formatting so that it matches AMS style
%   20180225 -- Christopher Slocum removed the geometry package, made
%               page number spacing dynamic, fixed headings, and cleaned
%               up the class file so that it is easier to follow
%   20180226 -- Christopher Slocum rewrote chapter headings, changed the LoT
%               and LoF formatting, and changed committee block to new style
%   20180103 -- Chris Slocum removed lineno package and changed subheadings
%   20250323 -- Chris Slocum changed mathdesign with utopia option to 
%               fourier to handle font embedding and encoding issues.
%               Changed uppercase to MakeUppercase and updated hyperref.
%
% Options for the documentclass
% =============================
% masters
% -------
%   including 'masters' will change 'Doctor of Philosophy'
%   to 'Master of Science' for the degree
%
% 10pt, 11pt, 12pt
% ----------------
%   The title page, copyright page, and abstract are fixed at 12pt,
%   but you can change the body to one of three options
%
% times
% -----
%   Adobe Systems Utopia (1989) is the default serif font. Using
%   times will load newtxtext and newtxmath
%
% blue
% ----
%   makes the text for urls and references blue rather than black
%   requires the hyperref option
%
% smallfoot
% ---------
%   makes the page number scriptsize rather than footnotesize
%
% nocopyright
% -----------
%   CSU now requires the copyright page. If this changes, nocopyright
%   restores old format
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csuthesis}[2025-03-23 CSU thesis and disseration class]
%%%%%%%%%%%%%%%%%%%%%%%%
%   Document class options
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifphd \phdtrue
\DeclareOption{masters}{\phdfalse}
\newif\ifmasterofscience \masterofsciencetrue
\DeclareOption{nonscience}{\masterofsciencefalse}
\newif\ifblue \bluefalse
\DeclareOption{blue}{\bluetrue}
\newif\iftimes \timesfalse
\DeclareOption{times}{\timestrue}
\newif\ifsmallfoot \smallfootfalse
\DeclareOption{smallfoot}{\smallfoottrue}
\newif\ifnocopyright \nocopyrightfalse
\DeclareOption{nocopyright}{\nocopyrighttrue}
\def\@@ptsize{12pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax
%%%%%%%%%%%%%%%%%%%%%%%%
%   Load amsbook class
%%%%%%%%%%%%%%%%%%%%%%%%
% amsbook provides the foundation
% for the thesis class. amsbook does
% not play nice with some LaTeX commands :(
\LoadClass[\@@ptsize, oneside, reqno]{amsbook}
%%%%%%%%%%%%%%%%%%%%%%%%
%    parse preamble input
%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\global \let \@author \@empty
\global \let \@date \@empty
\global \let \@title \@empty
\global \let \@departmentname \@empty
\global \let \@gradterm \@empty
\global \let \@gradyear \@empty
\global \let \@advisor \@empty
\newcommand{\committee}[1]{\gdef\@committee{\xandlist{\\ \> }{\\ \>}{\\ \>}{#1}}}
\newcommand{\@committee}{\@latex@warning@no@line{No \noexpand\committee given}}
\def\author#1{\gdef\@author{#1}}
\def\@author{\@latex@warning@no@line{No \noexpand\author given}}
\def\departmentname#1{\gdef\@departmentname{#1}}
\def\gradterm#1{\gdef\@gradterm{#1}}
\def\gradyear#1{\gdef\@gradyear{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\coadvisor#1{\gdef\@coadvisor{#1}}
\makeatother
\RequirePackage{ifthen}
\RequirePackage{iftex}
%%%%%%%%%%%%%%%%%%%%%%%%
%   Page layout/formatting
%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{indentfirst}
\RequirePackage[doublespacing]{setspace}
% getting the page number placement right.
% 0.5 in is 36 pts. We subtract the font size and add some back
% to find the footskip value
\newlength{\footskipamount}
\ifsmallfoot
    \makeatletter
    \setlength{\footskipamount}{33pt minus \@@ptsize \relax}
    \makeatother
\else
    \makeatletter
    \setlength{\footskipamount}{33pt minus \@@ptsize \relax}
    \makeatother
\fi

% Setting the layout parameters
% Creates one inch margins around the edges of the document
\ifluatex
    % LuaTeX no longer supports \pdfpagewidth or \pdfpageheight
    % Create backwards compatibility
    \let\pdfpagewidth\pagewidth
    \let\pdfpageheight\pageheight
\fi
\setlength{\paperheight}{11truein}%
\setlength{\paperwidth}{8.5truein}%
\setlength{\headheight}{0pt}%
\setlength{\headsep}{0pt}%
\setlength{\footskip}{\footskipamount}% puts page number 0.5 in below text (e.g., 0.5in from bottom of page)
\setlength{\marginparwidth}{0pt}%
\setlength{\marginparsep}{0pt}%
\setlength{\oddsidemargin}{\dimexpr 1truein-1truein}
\setlength{\topmargin}{\dimexpr 1truein -1truein}
\setlength{\textwidth}{\dimexpr \pdfpagewidth -2\oddsidemargin -2truein}
\setlength{\textheight}{\dimexpr \pdfpageheight -2\topmargin -2truein}
% Penalties to control the behavior of orphans and widows
% The higher the values, the more important it is for LaTeX
% to follow the penalty. 150 to 500 are pretty high values and
% 10000 is the maximum allowed value for the penalties.
% See https://tex.stackexchange.com/a/51264 for more details
% on penalty options within LaTeX
\clubpenalty=1000  % extra penalty for breaking after first line of a paragraph
\widowpenalty=10000  % extra penalty for breaking before last line of a paragraph
\displaywidowpenalty=10000  % extra penalty for breaking before last line before a display math
\brokenpenalty=10000  % extra penalty for page breaking after a hyphenated line
% Because Word does not fulfill the flush bottom requirement, this
% can be relaxed. However, \raggedbottom negatively impacts the
% footer. Instead, we use footmisc
\RequirePackage[bottom]{footmisc}

% set page heading style (plain) and page numbering size
\makeatletter
\def\ps@plain{\ps@empty
    \def\@evenfoot{%
        \normalfont\ifsmallfoot\scriptsize\else\footnotesize\fi
        \centerline{\thepage}
    }%
    \def\@oddfoot{%
        \normalfont\ifsmallfoot\scriptsize\else\footnotesize\fi
        \centerline{\thepage}}
}
\pagestyle{plain}
\makeatother

% import graphics
\RequirePackage{graphicx}

% math and symbol packages
\DeclareMathAlphabet{\CMcal}{OMS}{cmsy}{m}{n}
\RequirePackage{amsmath,amsfonts,bm}
\iftimes
    \RequirePackage{newtxtext}
    \RequirePackage{newtxmath}
\else
    \RequirePackage{fourier}
\fi


% Citations and in page references
\RequirePackage{natbib}
\bibpunct{(}{)}{;}{a}{}{,}
\RequirePackage{xurl}
\RequirePackage{xcolor}
\RequirePackage{bookmark}
\RequirePackage{hyperref}
\hypersetup{
    breaklinks=true,
    bookmarks=true,
    hyperfigures=true,
    pdfpagelabels,
    pdfborder={0 0 0},
}
\ifblue
    \hypersetup{
        colorlinks,
        linkcolor={black},
        citecolor={blue!80!black},
        urlcolor={blue!80!black}
    }
\else
    \hypersetup{
        colorlinks,
        linkcolor={black},
        citecolor={black},
        urlcolor={black}
    }
\fi
% This turns doi entries in the references to links
\newcommand*{\doi}[1]{\href{http://dx.doi.org/\detokenize{#1}}{doi: \detokenize{#1}}}
\RequirePackage{lscape}
%%%%%%%%
% Chapter "Primary" Headings
%%%%%%%%
\makeatletter
% for \chapter{}
\def\@makechapterhead#1{
    \begin{center}
        \MakeUppercase{\@xp{\chaptername}\enspace\thechapter}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
        \normalsize\normalfont\scshape\bfseries{#1}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
    \end{center}}
% for \chapter*{} -- note really used in a thesis
\def\@makeschapterhead#1{
    \begin{center}
        \normalsize\normalfont\scshape\bfseries{#1}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
    \end{center}}
\makeatother
%%%%%%%%
% Section, subsection, and subsubsection headings
%%%%%%%%
\makeatletter
% section definition
\renewcommand{\section}{%
\renewcommand{\@seccntformat}[1]{
    {\csname the##1\endcsname}.~~}%1
    \@startsection
    {section}%
    {1}% 1 is the level for section
    {0mm}% NO indent, starts immediately
    {0mm}% No skip baseline after end of previous subsection
    {1em}% 1 em baseline skip and the first paragraph starts
    {\normalsize\scshape}%the style, Large and boldface
}
\renewcommand{\thesection}{\arabic{section}} % numbers

% subsection definitions
\renewcommand{\subsection}{%
\renewcommand{\@seccntformat}[1]{
    {\csname the##1\endcsname}.~~}%1
    \@startsection
    {subsection}%
    {2}% 2 is the level for subsection
    {0mm}% NO indent, starts immediately
    {0mm}% No skip baseline after end of previous subsection
    {1em}% 1 em baseline skip and the first paragraph starts
    {\normalfont\scshape}%the style, all italics
}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

% subsubsection
%\titleformat{\subsubsection}{\normalfont\scshape}{\thesubsubsection}{1em}{}
%\titlespacing{\subsubsection}{0pt}{*0}{*0}
\renewcommand{\subsubsection}{%
\renewcommand{\@seccntformat}[1]{
    {\csname the##1\endcsname}.~~}%1
    \@startsection
    {subsubsection}%
    {3}% 3 is the level for subsubsection
    {0mm}% Indent subsubsections
    {0mm}% No skip baseline after end of previous subsection
    {1em}% 1 em baseline skip and the first paragraph starts
    {\normalfont\scshape}%
}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
\makeatother
%%%%%%%%
% Figure and table formatting
%%%%%%%%
\makeatletter
% AMS style for Figures and Tables
\newcommand{\figurenametext}{Fig.}
\newcommand{\tablenametext}{Table}
\renewcommand{\figurename}{\textsc{\figurenametext}}
\renewcommand{\tablename}{\textsc{\tablenametext}}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}
\renewcommand{\appendixname}{Appendix}
%%% Figure and Table caption formatting
\RequirePackage[margin=0.15in]{caption}
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{5\p@}
% section, table, figure, and equation nummbering
\numberwithin{table}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}
\renewcommand\bibsection{\centering\bibname\addcontentsline{toc}{chapter}{References} ~\\ ~\\}{}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%
%  customizing the table of contents appearance excluding the heading
%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand{\gobblefour}[4]{}
\newcommand*{\SkipTocEntry}{\addtocontents{toc}{\gobblefour}}
\makeatletter
% toc, lot, lof heading formatting
\def\@makescsuhead#1{
    \begin{center}
        \normalsize\normalfont
        \MakeUppercase{#1}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
    \end{center}}

\def\@starttoc#1#2{%
    \newpage
    \begingroup
    \setTrue{#1}%
    \let\secdef \chapter
    \let\@secnumber\@empty
    \ifx\contentsname#2%
    \else \@tocwrite{chapter}{#2}\fi
    \typeout{#2}\@xp\chaptermark\@xp{#2}%
    \@makescsuhead{#2}\@afterheading
    \parskip\z@skip
    \makeatletter
    \@input{\jobname.#1}%
    \if@filesw
        \@xp\newwrite\csname tf@#1\endcsname
        \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \global\@nobreakfalse \endgroup
    \newpage
}
% Leader dots in toc
\patchcmd{\@tocline}
{\hfil}
{\leaders\hbox{\,.\,}\hfil}
{}{}
% Insert "Figure" or "Table" in "list of" entries
\newcommand\numberprefix{}
\def\numberline#1{\hb@xt@\@tempdima{\numberprefix #1\hfil}}
%\@tocline{<level>}{<space above>}{<indent from left margin>}{<hang indent>}{<font attributes>}
\def\l@figure#1#2{\@tocline{0}{0pt}{0pt}{4pc}{}%
    {\renewcommand\numberprefix{\figurenametext~}#1}{#2}}
\def\l@table#1#2{\@tocline{0}{0pt}{0pt}{4pc}{}%
    {\renewcommand\numberprefix{\tablenametext~}#1}{#2}}
\def\l@section{\@tocline{1}{0pt}{2pc}{2pc}{}}
\renewcommand{\@pnumwidth}{1.55em}  % default value is 1.55 em
\renewcommand{\@tocrmarg}{2.55em}  % default value is 2.55 em
\makeatother
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{\MakeUppercase{References}}
%%%%%%%%%%%%%
%   Special pages
%%%%%%%%%%%%%
\makeatletter
%%%%%%%%%%%%%
% abstract
%%%%%%%%%%%%%
\renewenvironment{abstract}{%
    \ifx\maketitle\relax
        \ClassWarning{\@classname}{Abstract should precede
            \protect\maketitle\space in CSU Thesis document class; reported}%
    \fi
    \global\setbox\abstractbox=\vtop
    {
        \bgroup
        \begin{center}
            \normalsize\MakeUppercase{Abstract}
            \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
            \MakeUppercase{\@title}
            \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
        \end{center}%blank line below here so the abstract starts indented.
    }
}{%
    \endlist\egroup
    \ifx\@setabstract\relax \@setabstracta \fi
}
%%%%%%%%%%%%%
% acknowledgments
%%%%%%%%%%%%%
\newbox\ackbox
\newenvironment{acknowledgments}{%
    \ifx\maketitle\relax
        \ClassWarning{\@classname}{Acknowledgments should precede
            \protect\maketitle\space in the csuthesis class; reported}%
    \fi
    \global\setbox\ackbox=\vtop
    {
        \bgroup
        \begin{center}
            {\normalsize\MakeUppercase{Acknowledgments}}
        \end{center}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
    }
}{
    \endlist\egroup
}
%%%%%%%%%%%%%
% dedication
%%%%%%%%%%%%%
\newbox\dedbox
\newenvironment{dedication}{%
    \ifx\maketitle\relax
        \ClassWarning{\@classname}{dedication should precede
            \protect\maketitle\space in the csuthesis class; reported}%
    \fi
    \global\setbox\dedbox=\vtop
    {
        \bgroup
        \begin{center}
            {\normalsize\MakeUppercase{Dedication}}
        \end{center}
        \skip@ 3em \advance\skip@-\normalbaselineskip\vskip\skip@
    }
}{%
    \endlist\egroup
}
%%%%%%%%%%%%%
% Title Page
%%%%%%%%%%%%%
\renewcommand{\maketitle}{%
    \begin{titlepage}
        \begin{center}{\normalsize
                \pdfbookmark{\@title}{\@title}
                \ifphd
                    \MakeUppercase{Dissertation}
                \else
                    \MakeUppercase{Thesis}
                \fi
                ~\vfill
                {\MakeUppercase{\@title}}
                ~\vfill
                Submitted by \\
                \ifx @author \@empty
                    \relax% Look, error handling!
                \else
                    \@author \\
                \fi

                \ifx\@empty\@departmentname
                    \MakeUppercase{Department Name not defined}
                \else
                    Department of \@departmentname
                \fi

                ~\vfill
                In partial fulfillment of the requirements \\
                \ifphd
                    For the Degree of Doctor of Philosophy \\
                \else
                    \ifmasterofscience
                        For the Degree of Master of Science \\
                    \else
                        For the Degree of Master of the Arts \\
                    \fi
                \fi
                Colorado State University \\
                Fort Collins, Colorado \\
                \ifx\@gradterm\@empty
                    \MakeUppercase{gradterm not defined}
                \else
                    \ifx\@gradyear\@empty
                        \MakeUppercase{gradyear not defined}
                    \else
                        \@gradterm~\@gradyear
                    \fi
                \fi
                ~\vfill
            }\end{center}
        \begin{singlespace}{\normalsize
                \ifphd
                    Doctoral Committee:\\
                \else
                    Master's Committee:\\
                \fi
                % blank line
                \begin{tabbing}
                    \hspace*{0.5in}\=
                    % Indent, still left:
                    Advisor: \@advisor \\ \>
                    \ifx\@coadvisor\undefined
                        \relax
                    \else
                        Co-Advisor: \@coadvisor \\
                    \fi
                    % blank line
                    ~\\ \> %
                    \@committee
                \end{tabbing}
            }\end{singlespace}
    \end{titlepage}
    %%%%%%%%%%%%%
    % Copyright page
    %%%%%%%%%%%%%
    \ifnocopyright
        \relax
    \else
        % Make a copyright page
        \thispagestyle{empty}
        \pdfbookmark{Copyright}{Copyright}
        \vspace*{\fill}
        \begin{center}
            {\normalsize Copyright by \@author~\@gradyear \\ All Rights Reserved}
        \end{center}
        \vspace*{\fill}
        \clearpage
    \fi
    %%%%%%%%%%%%%
    % Add the Abstract, Acknowledgements, and Dedication pages to the Table of Contents
    %%%%%%%%%%%%%
    \setcounter{page}{2} %the copyright page is not assigned a number nor counted
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\MakeUppercase{Abstract}}
    \unvbox\abstractbox
    \ifvoid\ackbox
    \else
        \clearpage
        \phantomsection
        \unvbox\ackbox
        \addcontentsline{toc}{chapter}{\MakeUppercase{Acknowledgments}}
    \fi
    % Dedication
    \ifvoid\dedbox
    \else
        \clearpage
        \phantomsection
        \unvbox\dedbox
        \addcontentsline{toc}{chapter}{\MakeUppercase{Dedication}}
    \fi
}
\makeatother
%%%%%%%%%%%%
% Appendix formatting
%%%%%%%%%%%%
\newif\iffirstappendix
\renewenvironment{appendix}[1][1]%
{\vskip0em\pagebreak[3]
    \ifthenelse{\equal{#1}{1}}%
    %%%%%%%%%%%%%
    % Single appendix
    %%%%%%%%%%%%%
    {\setcounter{chapter}{0}% reset counter
        \renewcommand\thechapter{A}
        \renewcommand\theequation{\thechapter\arabic{equation}}%
        \setcounter{equation}{0}% reset counter
        \setcounter{figure}{0}% reset counter
        \setcounter{table}{0}% reset counter
        \renewcommand\thefigure{\thechapter\arabic{figure}}
        \renewcommand\thetable{\thechapter\arabic{table}}
        \setcounter{section}{0}% reset counter
        \setcounter{subsection}{0}% reset counter
        \renewcommand\thesection{\thechapter\arabic{section}}
        \renewcommand\thesubsection{\thechapter\arabic{subsection}}
        \begin{center}%
            {\textnormal APPENDIX\vskip1em%
            }
        \end{center}
    }
    %%%%%%%%%%%%%
    % Multiple appendices
    %%%%%%%%%%%%%
    {
        \setcounter{chapter}{0}% reset counter
        \renewcommand\thechapter{#1}
        \setcounter{equation}{0}% reset counter
        \renewcommand\theequation{{\thechapter}\arabic{equation}}%
        \setcounter{section}{0}% reset counter
        \setcounter{subsection}{0}% reset counter
        \renewcommand\thefigure{\thechapter\arabic{figure}}
        \renewcommand\thetable{\thechapter\arabic{table}}
        \renewcommand\thesection{\thechapter\arabic{section}}
        \renewcommand\thesubsection{\thechapter\arabic{subsection}}
        \begin{center}%
            {\textnormal APPENDIX \thechapter\vskip1em}%
        \end{center}
    }
}%
% Appendix title formatting and table of contents entry
\makeatletter
\newcommand{\appendixtitle}[1]{{\centering\bf\scshape {#1}\vskip1em}{\addcontentsline{toc}{chapter}{\appendixname~\thechapter.~~ {#1}}}}
\makeatother
