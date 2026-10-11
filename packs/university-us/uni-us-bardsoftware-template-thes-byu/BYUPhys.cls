 \NeedsTeXFormat{LaTeX2e}
 \ProvidesClass{BYUPhys}[2017/03/20 BYU Theses and Dissertations]

% The BYUPhys class is for producing theses and dissertations
% that meet the BYU requirements.
%
% The following class options are available
%
%   senior    : Produces the senior thesis preliminary pages (default)
%   capstone  : Produce the capstone report preliminary pages
%   masters   : Produces the masters thesis preliminary pages
%   phd       : Produces the PhD dissertation preliminary pages
%   honors    : Produces the honors thesis preliminary pages
%   astronomy : Redefines references to auther/year, sets bibliography style to apj, and defines a bunch of astronomy-related macros
%   noacknowledgments : Removes the acknowledgments page
%   etd : Removes blank pages necessary for double-sided printing without a fuss
%
% Revision: June 2011
% Revision History
%   03-20-2017 : Updated honors templates to match new formatting guidelines
%   07-14-2014 : Fixed some spacing issues, switched to acceptance date
%   01-20-2012 : Added Capstone option
%   06-20-2011 : Added formal pages to TOC for honors theses
%   02-14-2011 : Cleaned up some linking issues, allowed more liberal figure placement, and added verbatim file input
%   02-11-2011 : Moved to new BYU style requirements, moved package loading into the cls file
%   07-15-2010 : Cleaned up page definitions
%   12-09-2009 : Updated to new BYU style, without signature pages.



% Declare some variables to hold the text fields for the preliminary pages

    \newcommand{\Title}[1]{\gdef\BYUField@Title{#1}}
    \newcommand{\Author}[1]{\gdef\BYUField@Author{#1}}
    \newcommand{\docname}[1]{\gdef\BYUField@DocName{#1}}
    \newcommand{\degree}[1]{\gdef\BYUField@Degree{#1}}
    \newcommand{\Advisor}[1]{\gdef\BYUField@Advisor{#1}}
    \newcommand{\AdvisorTitle}[1]{\gdef\BYUField@AdvisorTitle{#1}}
    \newcommand{\MemberA}[1]{\gdef\BYUField@MemberA{#1}}
    \newcommand{\MemberB}[1]{\gdef\BYUField@MemberB{#1}}
    \newcommand{\MemberC}[1]{\gdef\BYUField@MemberC{#1}}
    \newcommand{\MemberD}[1]{\gdef\BYUField@MemberD{#1}}
    \newcommand{\Month}[1]{\gdef\BYUField@Month{#1}}
    \newcommand{\Year}[1]{\gdef\BYUField@Year{#1}}
    \newcommand{\Abstract}[1]{\gdef\BYUField@Abstract{#1}}
    \newcommand{\Keywords}[1]{\gdef\BYUField@Keywords{#1}}
    \newcommand{\Acknowledgments}[1]{\gdef\BYUField@Acknowledgments{#1}}
    \newcommand{\HonorsRepresentative}[1]{\gdef\BYUField@HonorsRep{#1}}

% Initialize the variables to their default values

    \Title{[Title: Titles Must Be in Mixed Case and May Not Exceed Six Inches on One Line\\
           and Must Be in the Inverted Pyramid Format When\\
           Additional Lines Are Needed]}
    \Author{[Student Name]}
    \docname{senior thesis}
    \degree{Bachelor of Science}
    \Advisor{[Advisor]}
    \AdvisorTitle{Advisor}
    \MemberA{}
    \MemberB{}
    \MemberC{}
    \MemberD{}
    \Month{[Graduation Month]}
    \Year{[Year]}
    \Abstract{[The abstract is a summary of the thesis/dissertation with emphasis on the findings
              of the study. The abstract must not exceed 350 words in length and fit on one page,
              single spaced.]}
    \Keywords{[A comma-separated list of descriptive words for search purposes]}
    \Acknowledgments{[Acknowledgements should be simple, in good taste, and fit on one page]}
    \HonorsRepresentative{[Honors Representative]}

% Define the preliminary page layouts using the variables

    \newcommand{\BYUtitlepage}{
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Title Page}{bm:Title}
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{2} \small\normalsize
            \centering\BYUField@Title\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \vfill
        \BYUField@Author\\[\baselineskip]
        \vfill
        A \BYUField@DocName~submitted to the faculty of\\
        Brigham Young University\\
        in partial fulfillment of the requirements for the degree of\\[\baselineskip]
        \BYUField@Degree \\
        \vfill
        \BYUField@Advisor, \BYUField@AdvisorTitle\\
        \if \BYUField@MemberA \relax \relax \else \mbox{\BYUField@MemberA}\\ \fi
        \if \BYUField@MemberB \relax \relax \else \mbox{\BYUField@MemberB}\\ \fi
        \if \BYUField@MemberC \relax \relax \else \mbox{\BYUField@MemberC}\\ \fi
        \if \BYUField@MemberD \relax \relax \else \mbox{\BYUField@MemberD}\\ \fi
        \vfill
        Department of Physics and Astronomy\\[\baselineskip]
        Brigham Young University\\[\baselineskip]
        \mbox{\BYUField@Month~\BYUField@Year} \\[\baselineskip]
        \vfill
        Copyright \copyright\ \BYUField@Year~\BYUField@Author\\[\baselineskip]
        All Rights Reserved\par
        }
        \clearemptydoublepage
      }

    \newcommand{\abstractpage}{
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Abstract}{bm:Abstract}
        ABSTRACT\\[1\baselineskip]\par
        \renewcommand{\baselinestretch}{1} \small\normalsize
        \parbox{\textwidth}{\centering\BYUField@Title}\\[1\baselineskip]\par
        \mbox{\BYUField@Author}\\
        Department of Physics and Astronomy, BYU\\
        \mbox{\BYUField@Degree}\par
        }

        \addtolength{\parskip}{\baselineskip}
        \singlespace
        \BYUField@Abstract\par

        \vfill
        \addtolength{\parskip}{-\baselineskip}
        \noindent Keywords:~\BYUField@Keywords

        \clearemptydoublepage
    }

    \newcommand{\acknowledgmentspage}{
        \singlespace
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Acknowledgments}{bm:Acknowledge}
        ACKNOWLEDGMENTS\\[0.5\baselineskip]
        \par}\par
        \renewcommand{\baselinestretch}{1.66} \small\normalsize%
        \BYUField@Acknowledgments
        \par\renewcommand{\baselinestretch}{1} \small\normalsize%
        \clearemptydoublepage
        }

    % Honors wants this in the TOC
    \newcommand{\honorsacknowledgmentspage}{
        \providecommand\phantomsection{} \phantomsection
        \addcontentsline{toc}{chapter}{Acknowledgments}
        \singlespace
        \thispagestyle{empty}
        {\centering
        ACKNOWLEDGMENTS\\[2\baselineskip]
        \par}\par
        \renewcommand{\baselinestretch}{1.66} \small\normalsize%
        \BYUField@Acknowledgments
        \par\renewcommand{\baselinestretch}{1} \small\normalsize%
        \clearemptydoublepage
    }

% Allow opt-out on acknowledgments
    \DeclareOption{noacknowlegments}{
      \renewcommand{\acknowledgmentspage}{}
      \renewcommand{\honorsacknowledgmentspage}{}
    }



% Define the macro for making preliminary pages
    \newcommand{\makepreliminarypages}{
        \singlespace
        \changepage{0.5in}{}{}{}{}{}{-0.2in}{-0.3in}{}
        \BYUtitlepage
        \abstractpage
        \acknowledgmentspage
        \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
        \changepage{-0.5in}{}{}{}{}{}{0.2in}{0.3in}{}
        \doublespace
    }


    \DeclareOption{senior}{
        % Don't need anything here because default values
        % were set when we initialized variables
    }

    \DeclareOption{capstone}{
      \degree{Bachelor of Science}
      \docname{capstone report}
      \AdvisorTitle{Advisor}
    }

    \DeclareOption{masters}{
      \degree{Master of Science}
      \docname{thesis}
      \AdvisorTitle{Chair}
    }

    \DeclareOption{phd}{
      \degree{Doctor of Philosophy}
      \docname{dissertation}
      \AdvisorTitle{Chair}
    }

% Reference style change for astronomy option
    \newif\ifAstroThesis
    \DeclareOption{astronomy}{
        \AstroThesistrue
    }

% Honors does their own thing...

    \DeclareOption{honors}{
      \renewcommand{\makepreliminarypages}{
        \changepage{0.5in}{-0.5in}{}{0.5in}{}{}{-0.2in}{-0.3in}{}
        \providecommand\phantomsection{} \phantomsection
        \addcontentsline{toc}{chapter}{Title and signature page}
        \honorstitlepage
        \providecommand\phantomsection{} \phantomsection
        \addcontentsline{toc}{chapter}{Abstract}
        \honorsabstractpage
        \honorsacknowledgmentspage
        \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
        \changepage{-0.5in}{}{}{}{}{}{0.2in}{0.3in}{}
        \fancyheadoffset{0in}
        \doublespace
      }
    }

    \newcommand{\honorstitlepage}{
        \thispagestyle{empty}
        \singlespace
        \begin{center}
        Honors Thesis\par
        \vspace*{5\baselineskip}
        \parbox[t]{5.5in}{
            \renewcommand{\baselinestretch}{2} \small\normalsize
            \centering\BYUField@Title\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }
        \vfill
        by\\
        \BYUField@Author
        \vfill
        Submitted to Brigham Young University in partial fulfillment\\
        of graduation requirements for University Honors
        \vfill
        Department of Physics and Astronomy\\
        Brigham Young University\\
        \BYUField@Month~\BYUField@Year
        \vfill
        Advisor: \BYUField@Advisor \\[\baselineskip]
        Honors Coordinator: \BYUField@HonorsRep
        \vspace{0.75in}
        \end{center}
        \clearemptydoublepage
        \doublespace
      }

    \newcommand{\honorsabstractpage}{
        \thispagestyle{empty}
        {\centering
        ABSTRACT\\[2\baselineskip]\par
        \renewcommand{\baselinestretch}{1} \small\normalsize
        \parbox{5.5in}{\centering\BYUField@Title}\\[2\baselineskip]\par
        \renewcommand{\baselinestretch}{2} \small\normalsize
        \mbox{\BYUField@Author}\\
        Department of Physics and Astronomy\\
        \mbox{\BYUField@Degree}\\[1\baselineskip]\par
        }

        \renewcommand{\baselinestretch}{1.66} \small\normalsize
        \BYUField@Abstract

        \clearemptydoublepage
    }

% A command to handle single sided preliminary pages in a double sided environment

    % Define the '\clearemptydoublepage' command to clear pages but not number any blank pages inserted.
    \let\cle@rdoublep@ge\cleardoublepage
    \newcommand{\cle@remptydoublep@ge}{
      \clearpage
      \if@twoside
      \ifodd\c@page\else
      \fi\fi
      {\pagestyle{empty}\cle@rdoublep@ge}}
    \newcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}

\DeclareOption{etd}{
    \renewcommand{\clearemptydoublepage}{\clearpage}
    }


% Load the class and needed packages
    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions
    \relax
    \LoadClass[letterpaper,12pt]{book}

    \RequirePackage{changepage}

% A couple of useful macros for line spacing

    % The \singlespace macro switches to single spaced lines
    \newcommand{\singlespace}{\par\renewcommand{\baselinestretch}{1}\small\normalsize\par}

    % The \doublespace macro switches to double spaced lines
    \newcommand{\doublespace}{\par\renewcommand{\baselinestretch}{1.66}\small\normalsize\par}


% Set the margins to BYU specifications

    \setlength{\marginparwidth}{0pt}
    \setlength{\marginparsep}{0pt}
    \setlength{\oddsidemargin}{0in}
    \setlength{\evensidemargin}{0in}
    \setlength{\textwidth}{6.5in}
    \setlength{\topmargin}{0in}
    \setlength{\headheight}{0.2in}
    \setlength{\headsep}{0.3in}
    \setlength{\textheight}{8.4in}
    \setlength{\footskip}{0.25in}
    \raggedbottom

% Allow more liberal figure placement
    \renewcommand{\topfraction}{0.9}
    \renewcommand{\bottomfraction}{0.8}
    \setcounter{topnumber}{2}
    \setcounter{bottomnumber}{2}
    \setcounter{totalnumber}{4}
    \renewcommand{\textfraction}{0.07}

% Redefine the Table of Contents to deal with some blank page
% and bookmarking issues relating to ETD submission
    \let\TEMPtableofcontents\tableofcontents
    \renewcommand{\tableofcontents}{
      \clearemptydoublepage
      \singlespace
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Table of Contents}
      \TEMPtableofcontents
      \clearemptydoublepage
      \doublespace
    }

% Redefine the List of Figures to deal with some blank page
% and bookmarking issues
    \let\TEMPlistoffigures\listoffigures
    \renewcommand{\listoffigures}{
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{List of Figures}
      \TEMPlistoffigures
    }

% Redefine the Bibliography to deal with a bookmarking issues
    \let\TEMPbibliography\bibliography
    \renewcommand{\bibliography}{\clearemptydoublepage
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Bibliography}
      \TEMPbibliography
    }

% The makeidx package makes your index for you.  To make an index entry,
% go to the place in the book that should be referenced and type
%  \index{key}
% An index entry labeled "key" (or whatever you type) will then
% be included and point to the correct page.
\usepackage{makeidx}
\makeindex

% Redefine the Index to deal with a bookmarking issues
    \let\TEMPprintindex\printindex
    \renewcommand{\printindex}{\clearemptydoublepage
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Index}
      \singlespace
      \TEMPprintindex
      \doublespace
    }

% These packages typeset the thesis with Times Roman font
\usepackage[T1]{fontenc}
\usepackage{mathptmx}

% Allow the inclusion of graphics
\usepackage{graphicx}

% The fancyhdr package allows you to easily customize the page header.
% The settings below produce a nice, well separated header.
\usepackage{fancyhdr}
  \fancyhead{}
  \fancyhead[LO]{\slshape \rightmark}
  \fancyhead[RO,LE]{\textbf{\thepage}}
  \fancyhead[RE]{\slshape \leftmark}
  \fancyfoot{}
  \pagestyle{fancy}
  \renewcommand{\chaptermark}[1]{\markboth{\chaptername \ \thechapter \ \ #1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection \ \ #1}}

\usepackage[titletoc]{appendix}

% Some useful packages
    \usepackage{amsmath}

    % This package makes straight single quotes in the Verbatim environment
    \usepackage{upquote}

    % This package lets us use custom Verbatim environments
    \usepackage{fancyvrb}
    \RecustomVerbatimEnvironment
      {Verbatim}{Verbatim}{xleftmargin=0.25in}

% Set the bibliography style

\ifAstroThesis
    \usepackage[round,sort]{natbib}
    \setcitestyle{round,aysep={},yysep={;}}
    \renewcommand{\cite}[1]{\citep{#1}}
    \bibliographystyle{apj}
    \usepackage{deluxetable}
    % Define a bunch of astronomy macros
    \let\jnl@style=\rmfamily
    \def\ref@jnl#1{{\jnl@style#1}}%
    \newcommand\aj{\ref@jnl{AJ}}%
              % Astronomical Journal
    \newcommand\actaa{\ref@jnl{Acta Astron.}}%
              % Acta Astronomica
    \newcommand\araa{\ref@jnl{ARA\&A}}%
              % Annual Review of Astron and Astrophys
    \newcommand\apj{\ref@jnl{ApJ}}%
              % Astrophysical Journal
    \newcommand\apjl{\ref@jnl{ApJ}}%
              % Astrophysical Journal, Letters
    \newcommand\apjs{\ref@jnl{ApJS}}%
              % Astrophysical Journal, Supplement
    \newcommand\ao{\ref@jnl{Appl.~Opt.}}%
              % Applied Optics
    \newcommand\apss{\ref@jnl{Ap\&SS}}%
              % Astrophysics and Space Science
    \newcommand\aap{\ref@jnl{A\&A}}%
              % Astronomy and Astrophysics
    \newcommand\aapr{\ref@jnl{A\&A~Rev.}}%
              % Astronomy and Astrophysics Reviews
    \newcommand\aaps{\ref@jnl{A\&AS}}%
              % Astronomy and Astrophysics, Supplement
    \newcommand\aspc{\ref@jnl{ASPC}}%
              % ASP Conference Proceedings
    \newcommand\azh{\ref@jnl{AZh}}%
              % Astronomicheskii Zhurnal
    \newcommand\baas{\ref@jnl{BAAS}}%
              % Bulletin of the AAS
    \newcommand\caa{\ref@jnl{Chinese Astron. Astrophys.}}%
      % Chinese Astronomy and Astrophysics
    \newcommand\cjaa{\ref@jnl{Chinese J. Astron. Astrophys.}}%
      % Chinese Journal of Astronomy and Astrophysics
    \newcommand\icarus{\ref@jnl{Icarus}}%
      % Icarus
    \newcommand\jcap{\ref@jnl{J. Cosmology Astropart. Phys.}}%
      % Journal of Cosmology and Astroparticle Physics
    \newcommand\jrasc{\ref@jnl{JRASC}}%
              % Journal of the RAS of Canada
    \newcommand\memras{\ref@jnl{MmRAS}}%
              % Memoirs of the RAS
    \newcommand\mnras{\ref@jnl{MNRAS}}%
              % Monthly Notices of the RAS
    \newcommand\na{\ref@jnl{New A}}%
      % New Astronomy
    \newcommand\nar{\ref@jnl{New A Rev.}}%
      % New Astronomy Review
    \newcommand\pra{\ref@jnl{Phys.~Rev.~A}}%
              % Physical Review A: General Physics
    \newcommand\prb{\ref@jnl{Phys.~Rev.~B}}%
              % Physical Review B: Solid State
    \newcommand\prc{\ref@jnl{Phys.~Rev.~C}}%
              % Physical Review C
    \newcommand\prd{\ref@jnl{Phys.~Rev.~D}}%
              % Physical Review D
    \newcommand\pre{\ref@jnl{Phys.~Rev.~E}}%
              % Physical Review E
    \newcommand\prl{\ref@jnl{Phys.~Rev.~Lett.}}%
              % Physical Review Letters
    \newcommand\pasa{\ref@jnl{PASA}}%
      % Publications of the Astron. Soc. of Australia
    \newcommand\pasp{\ref@jnl{PASP}}%
              % Publications of the ASP
    \newcommand\pasj{\ref@jnl{PASJ}}%
              % Publications of the ASJ
    \newcommand\pusno{\ref@jnl{PUSNO}}%
              % Publications of the U.S. Naval Observatory
    \newcommand\qjras{\ref@jnl{QJRAS}}%
              % Quarterly Journal of the RAS
    \newcommand\rmxaa{\ref@jnl{Rev. Mexicana Astron. Astrofis.}}%
      % Revista Mexicana de Astronomia y Astrofisica
    \newcommand\skytel{\ref@jnl{S\&T}}%
              % Sky and Telescope
    \newcommand\solphys{\ref@jnl{Sol.~Phys.}}%
              % Solar Physics
    \newcommand\sovast{\ref@jnl{Soviet~Ast.}}%
              % Soviet Astronomy
    \newcommand\ssr{\ref@jnl{Space~Sci.~Rev.}}%
              % Space Science Reviews
    \newcommand\zap{\ref@jnl{ZAp}}%
              % Zeitschrift fuer Astrophysik
    \newcommand\nat{\ref@jnl{Nature}}%
              % Nature
    \newcommand\iaucirc{\ref@jnl{IAU~Circ.}}%
              % IAU Cirulars
    \newcommand\aplett{\ref@jnl{Astrophys.~Lett.}}%
              % Astrophysics Letters and Communications
    \newcommand\apspr{\ref@jnl{Astrophys.~Space~Phys.~Res.}}%
              % Astrophysics Space Physics Research
    \newcommand\bain{\ref@jnl{Bull.~Astron.~Inst.~Netherlands}}%
              % Bulletin Astronomical Institute of the Netherlands
    \newcommand\fcp{\ref@jnl{Fund.~Cosmic~Phys.}}%
              % Fundamental Cosmic Physics
    \newcommand\gca{\ref@jnl{Geochim.~Cosmochim.~Acta}}%
              % Geochimica Cosmochimica Acta
    \newcommand\grl{\ref@jnl{Geophys.~Res.~Lett.}}%
              % Geophysics Research Letters
    \newcommand\jcp{\ref@jnl{J.~Chem.~Phys.}}%
              % Journal of Chemical Physics
    \newcommand\jgr{\ref@jnl{J.~Geophys.~Res.}}%
              % Journal of Geophysical Research
    \newcommand\jqsrt{\ref@jnl{J.~Quant.~Spec.~Radiat.~Transf.}}%
              % Journal of Quantitiative Spectroscopy and Radiative Trasfer
    \newcommand\memsai{\ref@jnl{Mem.~Soc.~Astron.~Italiana}}%
              % Mem. Societa Astronomica Italiana
    \newcommand\nphysa{\ref@jnl{Nucl.~Phys.~A}}%
              % Nuclear Physics A
    \newcommand\physrep{\ref@jnl{Phys.~Rep.}}%
              % Physics Reports
    \newcommand\physscr{\ref@jnl{Phys.~Scr}}%
              % Physica Scripta
    \newcommand\planss{\ref@jnl{Planet.~Space~Sci.}}%
              % Planetary Space Science
    \newcommand\procspie{\ref@jnl{Proc.~SPIE}}%
              % Proceedings of the SPIE
    \let\astap=\aap %
    \let\apjlett=\apjl %
    \let\apjsupp=\apjs %
    \let\applopt=\ao %

    \newcommand\phn{\phantom{0}}%
    \newcommand\phd{\phantom{.}}%
    \newcommand\phs{\phantom{$-$}}%
    \newcommand\phm[1]{\phantom{#1}}%
    \newcommand\sq{\mbox{\rlap{$\sqcap$}$\sqcup$}}%
    \newcommand\arcdeg{\mbox{$^\circ$}}%
    \newcommand\arcmin{\mbox{$^\prime$}}%
    \newcommand\arcsec{\mbox{$^{\prime\prime}$}}%
    \newcommand\fd{\mbox{$.\!\!^{\mathrm d}$}}%
    \newcommand\fh{\mbox{$.\!\!^{\mathrm h}$}}%
    \newcommand\fm{\mbox{$.\!\!^{\mathrm m}$}}%
    \newcommand\fs{\mbox{$.\!\!^{\mathrm s}$}}%
    \newcommand\fdg{\mbox{$.\!\!^\circ$}}%
    \newcommand\farcm@mss{\mbox{$.\mkern-4mu^\prime$}}%
    \let\farcm\farcm@mss
    \newcommand\farcs@mss{\mbox{$.\!\!^{\prime\prime}$}}%
    \let\farcs\farcs@mss
    \newcommand\fp{\mbox{$.\!\!^{\scriptscriptstyle\mathrm p}$}}%
    \newcommand\micron{\mbox{$\mu$m}}%
    \def\farcm@apj{%
     \mbox{.\kern -0.7ex\raisebox{.9ex}{\scriptsize$\prime$}}%
    }%
    \def\farcs@apj{%
     \mbox{%
      \kern  0.13ex.%
      \kern -0.95ex\raisebox{.9ex}{\scriptsize$\prime\prime$}%
      \kern -0.1ex%
     }%
    }%
    \newcommand\case[2]{\mbox{$\frac{#1}{#2}$}}%
    \newcommand\slantfrac{\case}%
    \newcommand\onehalf{\slantfrac{1}{2}}%
    \newcommand\onethird{\slantfrac{1}{3}}%
    \newcommand\twothirds{\slantfrac{2}{3}}%
    \newcommand\onequarter{\slantfrac{1}{4}}%
    \newcommand\threequarters{\slantfrac{3}{4}}%
    \newcommand\ubvr{\mbox{$U\!BV\!R$}}%% UBVR system
    \newcommand\bvr{\mbox{$BV\!R$}}%% BVR system
    \newcommand\vri{\mbox{$V\!RI$}}
    \newcommand\bvri{\mbox{$BV\!RI$}}%%
    \newcommand\ubvri{\mbox{$U\!BV\!RI$}}%%
    \newcommand\ub{\mbox{$U\!-\!B$}}%   % U-B
    \newcommand\bv{\mbox{$B\!-\!V$}}%   % B-V
    \newcommand\vr{\mbox{$V\!-\!R$}}%   % V-R
    \newcommand\ri{\mbox{$R\!-\!I$}}%   % R-I
    \newcommand\ur{\mbox{$U\!-\!R$}}%   % U-R
    \newcommand\ion[2]{#1$\;${\small\rmfamily\@Roman{#2}}\relax}%
    \newcommand\diameter{\ooalign{\hfil/\hfil\crcr\mathhexbox20D}}%
    \newcommand\degr{\arcdeg}%
    \newcommand\Sun{\sun}% Sun symbol, "S"
    \newcommand\Sol{\sun}%
    \newcommand\sun{\odot}%
    \newcommand\Earth{\earth}% Earth symbol, "3"
    \newcommand\Terra{\earth}%
    \newcommand\earth{\oplus}%
    \newcommand\Luna{\Moon}%
\else
    \usepackage{cite}
    \bibliographystyle{phBYU}
\fi

% The caption package allows you to change the formatting of figure captions.
% The commands here change to the suggested caption format:
% single spaced and a bold tag
\usepackage[margin=0.3in,labelfont=bf,labelsep=none]{caption}
 \DeclareCaptionFormat{suggested}{\singlespace#1#2 #3\par\doublespace}
 \captionsetup{format=suggested}


% The hyperref package provides automatic linking and bookmarking for the table
% of contents, index, equation references, and figure references.  It must be
% included for the BYU Physics class to make a properly functioning electronic
% thesis.  It should be the last package loaded if possible.
%
% To include a link in your pdf use \href{URL}{Text to be displayed}.  If your
% display text is the URL, you probably should use the \url{} command discussed
% above.
%
% To add a bookmark in the pdf you can use \pdfbookmark.  You can look up its usage
% in the hyperref package documentation
\usepackage[bookmarksnumbered,pdfpagelabels=true,plainpages=false,colorlinks=true,
            linkcolor=black,citecolor=black,urlcolor=blue]{hyperref}
\urlstyle{rm}

\doublespace
