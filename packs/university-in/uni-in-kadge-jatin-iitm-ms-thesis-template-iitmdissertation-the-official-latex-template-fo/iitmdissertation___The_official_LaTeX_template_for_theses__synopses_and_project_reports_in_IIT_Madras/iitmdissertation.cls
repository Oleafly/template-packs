%
%
% documentclass:   iitmdissertation
% version:         2022
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iitmdissertation}[2022]

\newif\ifdiss@phd
\newif\ifdiss@ms
\newif\ifdiss@mtech
\newif\ifdiss@btech
\newif\ifdiss@synopsis
\newif\ifdiss@dev
\newif\ifdiss@devx
\newif\ifdiss@zdraft
\newif\ifdiss@smplmath
\newif\ifdiss@yellowtape
\newif\ifdiss@indenttoc
\newif\ifdississynopsis

\newtoks\dissertationDepartment
\newtoks\dissertationAuthorName
\newtoks\dissertationDateOfBirth
\newtoks\dissertationDegree
\newtoks\dissertationTitle
\newtoks\dissertationMonth
\newtoks\dissertationYear
\newtoks\dissertationCertificateDate
\newtoks\dissertationType
\newtoks\dissertationGuides
\newtoks\dissertationCommitteeName
\newtoks\dissertationImage

\DeclareOption {phd}        {\diss@phdtrue    \dissertationDegree{Doctor of Philosophy}   \dissertationCommitteeName{Doctoral Committee}     \dissertationType{Thesis}         }
\DeclareOption {ms}         {\diss@mstrue     \dissertationDegree{Master of Science}      \dissertationCommitteeName{General Test Committee} \dissertationType{Thesis}         }
\DeclareOption {mtech}      {\diss@mtechtrue  \dissertationDegree{Master of Technology}                                                      \dissertationType{Project Report} }
\DeclareOption {btech}      {\diss@btechtrue  \dissertationDegree{Bachelor of Technology}                                                    \dissertationType{Project Report} }
\DeclareOption {synopsis}   {\diss@synopsistrue                                                                                                                                }
\DeclareOption {dev}        {\diss@devtrue    \diss@zdrafttrue                                                                                                                 }
\DeclareOption {devx}       {\diss@devxtrue                                                                                                                                    }
\DeclareOption {zdraft}     {\diss@zdrafttrue                                                                                                                                  }
\DeclareOption {smplmath}   {\diss@smplmathtrue                                                                                                                                }
\DeclareOption {yellowtape} {\diss@yellowtapetrue                                                                                                                              }
\DeclareOption {indenttoc}  {\diss@indenttoctrue}
\ProcessOptions\relax

\ifdiss@phd
    \ifdiss@synopsis
        \def\dissertationTitleTapeColor{DodgerBlue}
    \else
        \def\dissertationTitleTapeColor{Black}
    \fi
\else
    \ifdiss@dev
        \def\dissertationTitleTapeColor{Red}
    \else
        \def\dissertationTitleTapeColor{DodgerBlue}
    \fi
\fi

%
%
% Page geometry
%
%
\ifdiss@synopsis
\LoadClass
    [12pt]
    {scrartcl}
    \dississynopsistrue
\else
\LoadClass
    [12pt]
    {scrbook}
\fi
\RequirePackage{geometry}

\KOMAoptions{%
    twoside       = semi,
    numbers       = noendperiod,
    listof        = totoc,
    bibliography  = totoc,
}
\setparsizes{0pt}{0.5cm}{0pt plus 1fil}
\ifdiss@synopsis\else
    \KOMAoptions{
        chapterprefix = yes,
        open          = right,
    }
\fi

\AfterCalculatingTypearea{%
    \geometry{%
        left       = 1.25in,
        right      = 1.25in,
        top        = 1in,
        headheight = 1in,
        headsep    = 0in,
        bottom     = 34mm,
        footskip   = 17mm,
    }%
}
\recalctypearea
% \setlength{\footheight}{17mm}
\RequirePackage[automark,singlespacing=true]{scrlayer-scrpage}
\clearpairofpagestyles
\cfoot*{\pagemark}

%
%
% The rules mandate that hyphenation be avoided, or at best, be kept to a bare minimum
%
%
       \tolerance=1
\emergencystretch=\maxdimen
   \hyphenpenalty=10000
        \hbadness=10000

%
%
% Section headings and TOC entries
%
%
\newcommand\textupper[1]{\MakeUppercase{#1}}
\setkomafont {disposition} {\rmfamily\bfseries}
\setkomafont {section}     {\rmfamily\normalsize\bfseries\textupper}
\setkomafont {subsection}  {\rmfamily\normalsize\bfseries}

\setcounter {secnumdepth} {\subsectionnumdepth}
\setcounter {tocdepth}    {\subsectionnumdepth}

\ifdiss@synopsis\else
\setkomafont {chapter}     {\Large}
\providecaptionname{english}{\chaptername}{Chapter}
\let\originaladdchaptertocentry\addchaptertocentry
\renewcommand*{\addchaptertocentry}[2]{%
  \IfArgIsEmpty{#1}{% chapter TOC entry without number
    \originaladdchaptertocentry{#1}{\textupper{#2}}%
  }{% chapter TOC entry with number
    \originaladdchaptertocentry{\textupper{\chapapp~#1}}{\textupper{#2}}%
  }%
}
\let\raggedchapter\centering
\renewcommand\chapterlineswithprefixformat[3]{%
  \setstretch{1.2}\textupper{#2#3}%
}
\renewcommand\chapterlinesformat[3]{%
  \@hangfrom{#2}{\textupper{#3}}%
}
\RedeclareSectionCommand[
    beforeskip   = -1sp,
    afterskip    = 0.5cm,
%     innerskip    = 0.75cm,
    tocnumwidth  = 8em,
]{chapter}
\fi

% \renewcommand\sectionlinesformat[4]{%
%   \@hangfrom{\hskip #2#3}{\MakeUppercase{#4}}%
% }
% \renewcommand{\sectioncatchphraseformat}[4]{%
%   \hskip #2#3\MakeUppercase{#4}%
% }
\RedeclareSectionCommand[
    runin                 = false,
    afterskip             = \ifdiss@synopsis 0ex \else -0.5cm \fi,
    tocindent             = 0em,
    tocnumwidth           = 4em,
    toconstarthigherlevel = \vspace{0.5\baselineskip},
]{section}

\RedeclareSectionCommand[
    runin       = false,
    beforeskip  = -1sp,
    afterskip   = -0.5cm,
    tocindent   = \ifdiss@indenttoc 4em\else 0em \fi,
    tocnumwidth = 4em,
]{subsection}

\RedeclareSectionCommand[
    runin       = false,
    beforeskip  = -1sp,
    afterskip   = -0.5cm,
    tocindent   = \ifdiss@indenttoc 8em\else 0em \fi,,
    tocnumwidth = 4em,
]{subsubsection}

%
%
% Page numbering
%
%
\ifdiss@synopsis\else
\renewcommand\mainmatter{%
    \@mainmattertrue\cleardoublepage\renewcommand\thepage{\arabic{page}}%
}
\fi


%
%
% For developers
%
%
\RequirePackage[usenames,svgnames]{xcolor}
\ifdiss@dev
    \RequirePackage{soul}
    \colorlet{dissHLcolor}{Khaki!40!white}
    \newcommand\diss@hl[1]{\sethlcolor{dissHLcolor}\hl{#1}}
    \def\@TBS{\textbackslash}
    \newcommand\TTb[1]{\texttt{\diss@hl{#1}}}
    \newcommand\TTc[1]{\texttt{\diss@hl{\@TBS#1}}}
    \newcommand\cautn[1]{\textcolor{Red}{{\bfseries #1}}}
\fi

%
%
% Load the accompanying package
%
%
\RequirePackage{iitmdissertation}

%
%
% Draft mode
%
%
\ifdiss@zdraft
    \AtBeginDocument{\RequirePackage[colorlinks]{hyperref}

    \hypersetup{
        urlcolor  = DodgerBlue,
        linkcolor = Chocolate,
        citecolor = FireBrick,
    }
    \renewcommand\textupper[1]{\texorpdfstring{\MakeUppercase{#1}}{#1}}}
\fi

%
%
% Ugly and unnecessary; but the guidelines mandate a column header on lists
%
%
\AtBeginDocument{%
    \addtocontents {toc} {~                                             \hfill {\bfseries Page}\par}
    \addtocontents {lof} {{\bfseries Figure} \hfill {\bfseries Caption} \hfill {\bfseries Page}\par}
    \addtocontents {lot} {{\bfseries Table}  \hfill {\bfseries Caption} \hfill {\bfseries Page}\par}
    \graphicspath{{images/}}
}

%
%
% spacing
%
%
\setlength{\abovecaptionskip}{0.5cm}
\setlength{\belowcaptionskip}{0.5cm}
%
%
% Override tape-color defaults : yellowtape
%
%
\ifdiss@yellowtape
    \def\dissertationTitleTapeColor{Yellow}
\fi
