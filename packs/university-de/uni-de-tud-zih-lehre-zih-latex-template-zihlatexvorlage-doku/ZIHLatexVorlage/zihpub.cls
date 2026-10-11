%%
%% ZIH Style-File fuer ZIH Publikationen
%%
%% Autor: Guido Juckeland (guido.juckeland@tu-dresden.de)
%%        Robert Schöne (robert.schoene@tu-dresden.de)
%%        An LLM model hosted by Scads.AI
%% Datum: Aug 14, 2012
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zihpub}

%% Before you edit this document, make sure that using the TU Dresdens
%% TeX Layout "tudscr" is not better suited for your case
%%  https://ftp.tu-chemnitz.de/pub/tex/macros/latex/contrib/tudscr/doc/tudscr.pdf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load packages

% Font-Codierung setzen
\RequirePackage[T1]{fontenc}

% Schriftart setzen
\RequirePackage[sf,sfdefault]{noto}

% Bilder einbinden
\RequirePackage{graphicx}

% Einseitige Aufgabenstellungen als PDF einbinden
\RequirePackage{pdfpages}

% URL's zulassen
\RequirePackage{url}

% schoene Listings
\RequirePackage{fancyvrb}

% Mathe-krempel laden
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% farbe fuer correctme
\RequirePackage{color}

% TU Dresden CMYK color scheme from 20260107_TUD_Farben_CMYK.ase
\definecolor{TUDBrilliantBlue}{cmyk}{1,0.8,0.05,0}
\definecolor{TUDDarkBlue}{cmyk}{1,0.7,0.1,0.6}
\definecolor{TUDBlue1}{cmyk}{0.9,0.5,0,0}
\definecolor{TUDBlue2}{cmyk}{0.43,0.15,0,0}
\definecolor{TUDViolet1}{cmyk}{0.64,0.62,0,0}
\definecolor{TUDViolet2}{cmyk}{0.2,0.2,0,0}
\definecolor{TUDMagenta1}{cmyk}{0.3,0.96,0,0}
\definecolor{TUDMagenta2}{cmyk}{0,0.3,0,0}
\definecolor{TUDRed1}{cmyk}{0,1,0.6,0}
\definecolor{TUDRed2}{cmyk}{0,0.44,0.27,0}
\definecolor{TUDOrange1}{cmyk}{0,0.9,1,0.2}
\definecolor{TUDOrange2}{cmyk}{0,0.3,0.55,0}
\definecolor{TUDYellow1}{cmyk}{0,0.25,1,0}
\definecolor{TUDYellow2}{cmyk}{0,0.05,0.5,0}
\definecolor{TUDOlive1}{cmyk}{0.5,0.35,1,0.22}
\definecolor{TUDOlive2}{cmyk}{0.25,0,0.81,0}
\definecolor{TUDGreen1}{cmyk}{0.9,0,0.8,0.15}
\definecolor{TUDGreen2}{cmyk}{0.45,0,0.45,0}
\definecolor{TUDTurquoise1}{cmyk}{1,0.1,0.3,0.4}
\definecolor{TUDTurquoise2}{cmyk}{0.45,0,0.2,0}
\definecolor{TUDBlack}{cmyk}{0,0,0,1}
\definecolor{TUDGray100}{cmyk}{0.45,0.2,0.05,0.8}
\definecolor{TUDGray80}{cmyk}{0.36,0.16,0.04,0.64}
\definecolor{TUDGray60}{cmyk}{0.27,0.12,0.03,0.48}
\definecolor{TUDGray40}{cmyk}{0.18,0.08,0.02,0.32}
\definecolor{TUDGray20}{cmyk}{0.09,0.04,0.01,0.16}
\definecolor{TUDGray10}{cmyk}{0.05,0.02,0.01,0.08}
\definecolor{TUDWhite}{cmyk}{0,0,0,0}

% enumerates mit benutzerdefinierten labels
\RequirePackage{enumerate}

% besseres 1.5 zeilig
\RequirePackage{setspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Provide Options

% Proseminar-Vorlage
\newif\if@proseminar
\@proseminarfalse
\DeclareOption{proseminar}{%
  \@proseminartrue
}

% Hauptseminar-Vorlage
\newif\if@hauptseminar
\@hauptseminarfalse
\DeclareOption{hauptseminar}{%
  \@hauptseminartrue
}

% Seminar Mathematik Vorlage
\newif\if@mathseminar
\@mathseminarfalse
\DeclareOption{mathseminar}{%
  \@mathseminartrue
}

% Belegseminar-Vorlage
\newif\if@belegseminar
\@belegseminarfalse
\DeclareOption{belegseminar}{%
	\@belegseminartrue
}
\DeclareOption{projectseminar}{%
	\@belegseminartrue
}

% Bachelorseminar-Vorlage
\newif\if@bachelorseminar
\@bachelorseminarfalse
\DeclareOption{bachelorseminar}{%
	\@bachelorseminartrue
}

% Grosser Beleg-Vorlage
\newif\if@belegsonst
\@belegsonstfalse
\DeclareOption{belegsonst}{%
  \@belegsonsttrue
}
\DeclareOption{otherproject}{%
	\@belegsonsttrue
}

% Grosser Beleg-Vorlage
\newif\if@beleg
\@belegfalse
\DeclareOption{beleg}{%
  \@belegtrue
}
\DeclareOption{largeproject}{%
	\@belegtrue
}

% Research project based on the large project/report layout
\newif\if@researchproject
\@researchprojectfalse
\DeclareOption{researchproject}{%
	\@researchprojecttrue
}
\DeclareOption{forschungsprojekt}{%
	\@researchprojecttrue
}
\DeclareOption{forschungsproject}{%
	\@researchprojecttrue
}

% Diplom Inf-Vorlage
\newif\if@diplominf
\@diplominffalse
\DeclareOption{diplominf}{%
  \@diplominftrue
}
\DeclareOption{diplomainformatics}{%
	\@diplominftrue
}

% Bachelor Inf-Vorlage
\newif\if@bachinf
\@bachinffalse
\DeclareOption{bachinf}{%
  \@bachinftrue
}
\DeclareOption{bachelorinformatics}{%
	\@bachinftrue
}
\newif\if@bachelorappliedinformatics
\@bachelorappliedinformaticsfalse
\DeclareOption{bachelorappliedinformatics}{%
	\@bachinftrue
	\@bachelorappliedinformaticstrue
}
\DeclareOption{bachelorappliedcomputerscience}{%
	\@bachinftrue
	\@bachelorappliedinformaticstrue
}

% Master Inf-Vorlage
\newif\if@mastinf
\@mastinffalse
\DeclareOption{mastinf}{%
  \@mastinftrue
}
\DeclareOption{masterinformatics}{%
	\@mastinftrue
}
\DeclareOption{mastercomputerscience}{%
	\@mastinftrue
}
\DeclareOption{mastercs}{%
	\@mastinftrue
}
\newif\if@masterappliedinformatics
\@masterappliedinformaticsfalse
\DeclareOption{masterappliedinformatics}{%
	\@mastinftrue
	\@masterappliedinformaticstrue
}
\DeclareOption{masterappliedcomputerscience}{%
	\@mastinftrue
	\@masterappliedinformaticstrue
}

% Diplom IST-Vorlage
\newif\if@diplomist
\@diplomistfalse
\DeclareOption{diplomist}{%
  \@diplomisttrue
}
\DeclareOption{diplomainformationsystems}{%
	\@diplomisttrue
}

% Diplom TechMath-Vorlage
\newif\if@diplomtmath
\@diplomtmathfalse
\DeclareOption{diplomtmath}{%
  \@diplomtmathtrue
}
\DeclareOption{diplomatechnomathematics}{%
	\@diplomtmathtrue
}

% Diss rer nat
\newif\if@dissrernat
\@dissrernatfalse
\DeclareOption{dissrernat}{%
  \@dissrernattrue
}
\DeclareOption{dissertationrerumnaturalium}{%
	\@dissrernattrue
}

% Diss ing
\newif\if@dissing
\@dissingfalse
\DeclareOption{dissing}{%
  \@dissingtrue
}
\DeclareOption{dissertationengineering}{%
	\@dissingtrue
}

% Generic Ph.D. dissertation
\newif\if@phd
\@phdfalse
\DeclareOption{phd}{%
	\@phdtrue
}
%
\newif\if@selbststaendigkeit
\@selbststaendigkeitfalse
\DeclareOption{selbststaendigkeit}{%
  \@selbststaendigkeittrue
}
\DeclareOption{independence}{%
	\@selbststaendigkeittrue
}


% keine Aufgabenstellung
\newif\if@kurz
\@kurzfalse
\DeclareOption{kurz}{%
  \@kurztrue%
}%
\DeclareOption{short}{%
	\@kurztrue%
}%

% fuer Frauen das "in" am Titel
\newif\if@female
\@femalefalse
\DeclareOption{female}{%
  \@femaletrue
}

% plain-vorlage article
\newif\if@plainarticle
\@plainarticlefalse
\DeclareOption{plainarticle}{%
  \@plainarticletrue
}

% plain-vorlage article
\newif\if@plainreport
\@plainreportfalse
\DeclareOption{plainreport}{%
  \@plainreporttrue
}

% ZIH auf Titelseite nicht RA
\newif\if@zihtitle
\@zihtitlefalse
\DeclareOption{zihtitle}{%
  \@zihtitletrue
}
\DeclareOption{zih}{%
	\@zihtitletrue
}

% References numbered not alpha
\newif\if@bibnum
\@bibnumfalse
\DeclareOption{bibnum}{\@bibnumtrue}

% Abbildungsverzeichnis
\newif\if@lof
\@loffalse
\DeclareOption{lof}{\@loftrue}

% Tabellenverzeichnis
\newif\if@lot
\@lotfalse
\DeclareOption{lot}{\@lottrue}


% Hyperref
\newif\if@hyperref
\@hyperreffalse
\DeclareOption{hyperref}{%
  \@hyperreftrue
}

% PDF conformance
\newif\if@pdfa
\@pdfafalse
\DeclareOption{pdfa}{%
	\@pdfatrue
}
\newif\if@pdfua
\@pdfuafalse
\DeclareOption{pdfua}{%
	\@pdfuatrue
}

% Nomenclature
\newif\if@nomencl
\@nomenclfalse
\DeclareOption{nomencl}{%
  \@nomencltrue
}

%utf8-Zeichenkodierung
\newif\if@utf
\@utffalse
\DeclareOption{utf8}{
  \@utftrue
}


%german-Option verarbeiten
\newif\if@german
\@germanfalse
\DeclareOption{german}{%
  \@germantrue%
}%

% formatierung fuer zih-report
\newif\if@final
\@finalfalse
\DeclareOption{final}{%
  \@finaltrue%
}%

% kein Inhaltsverzeichnis
\newif\if@notoc
\@notocfalse
\DeclareOption{notoc}{%
  \@notoctrue%
}%

% keine Aufgabenstellung
\newif\if@noproblem
\@noproblemfalse
\DeclareOption{noproblem}{%
  \@noproblemtrue%
}%

% keine Titelseite
\newif\if@notitlepage
\@notitlepagefalse
\DeclareOption{notitlepage}{%
  \@notitlepagetrue%
}%

% Zus"atzliche TU-Dresden-Umschlagseite
\newif\if@wrapper
\@wrapperfalse
\DeclareOption{wrapper}{%
	\@wrappertrue
}%


% zweiseitig wenn nicht 'final'
\newif\if@twoside
\@twosidefalse
\DeclareOption{twoside}{%
  \@twosidetrue%
}%
\ProcessOptions

\if@pdfa
	\if@pdfua
		\ClassError{zihpub}{Options pdfa and pdfua cannot be used together}
			{Choose either pdfa (PDF/A-2b) or pdfua (PDF/UA-1).}
	\fi
\fi


% jetzt zweckentfremden wir ein paar variablen fuer eigene zwecke
\newcommand\studentid[1]{\def\@matno{#1}}
\newcommand\supervisor[1]{\def\@betreuer{#1}}
\newcommand\examinerone[1]{\def\@examinerone{#1}}
\newcommand\examinertwo[1]{\def\@examinertwo{#1}}
\newcommand\hsl[1]{\examinerone{#1}}
\newcommand\copyrightstatement[1]{\def\@copyrighterklaerung{#1}}
\newcommand\bibfiles[1]{\def\@bibfiles{#1}}
\newcommand\reviewer[1]{\def\@gutachter{#1}}
\newcommand\birthdate[1]{\def\@birthdate{#1}}
\newcommand\birthplace[1]{\def\@birthplace{#1}}
\newcommand\acknowledgments[1]{\def\@acknowledgments{#1}}
\newcommand\matno[1]{\studentid{#1}}
\newcommand\betreuer[1]{\supervisor{#1}}
\newcommand\chair[1]{\examinerone{#1}}
\newcommand\copyrighterklaerung[1]{\copyrightstatement{#1}}
\newcommand\gutachter[1]{\reviewer{#1}}
\newcommand\birthday[1]{\birthdate{#1}}
\newcommand\placeofbirth[1]{\birthplace{#1}}
\newcommand\acknowledgements[1]{\acknowledgments{#1}}
\newcommand\examregulation[1]{\def\@examregulation{#1}}
\newcommand\assignmentpdf[1]{\def\@assignmentpdf{#1}}
\newcommand\aufgabenstellung[1]{\assignmentpdf{#1}}
\newcommand\gutachterone[1]{\def\@gutachterone{#1}}
\newcommand\gutachtertwo[1]{\def\@gutachtertwo{#1}}
\newcommand\submissiondate[1]{\def\@submissiondate{#1}}
\newcommand\defensedate[1]{\def\@defensedate{#1}}
\newcommand\institution[1]{\def\@institution{#1}}
\newcommand\doctype[1]{\renewcommand{\titleheader}[0]{#1}}

\newcommand{\@wrapperpage}{%
	\clearpage
	\pagecolor{TUDDarkBlue}%
	\color{TUDWhite}%
	\thispagestyle{empty}%
	\begin{titlepage}
		\centering
		\vspace*{1.5cm}
		\if@german
			\includegraphics[width=0.72\textwidth]{TUD_Logo_de.pdf}%
		\else
			\includegraphics[width=0.72\textwidth]{TUD_Logo_en.pdf}%
		\fi
		\vfill
		{\Large \titleheader\par}
		\vspace{1.2cm}
		{\huge\bfseries \@title\par}
		\vspace{1.5cm}
		{\Large \@author\par}
		\vspace{0.5cm}
		{\large \@date\par}
		\vfill
	\end{titlepage}
	\clearpage
	\pagecolor{white}%
	\color{black}%
		\thispagestyle{empty}%
		\null
		\clearpage
}

\newcommand{\@startonrightpage}{%
	\clearpage
	\thispagestyle{empty}
	\null
	\clearpage
	\cleardoublepage
}

%\newif\if@isreport \@isreportfalse \DeclareOption{isreport}{\@isreporttrue}
\def\@acknowledgments{}
\def\@isreport{}
\def\@isplain{}
\def\@isdiploma{}
\def\@isdiss{}
\def\@bibfiles{}
\def\@copyrighterklaerung{}
\def\@abstractde{}
\def\@abstracten{}
\def\@examinerone{}
\def\@examinertwo{}
\def\@examregulation{}
\def\@assignmentpdf{}
\def\@gutachterone{}
\def\@gutachtertwo{}
\def\@submissiondate{}
\def\@defensedate{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set document type

\if@belegsonst
  \def\@isreport{1}
\fi
\if@beleg
  \def\@isreport{1}
\fi
\if@researchproject
	\def\@isreport{1}
\fi
\if@diplominf
  \def\@isreport{1}
  \def\@isdiploma{1}
\fi
\if@mastinf
  \def\@isreport{1}
  \def\@isdiploma{1}
\fi
\if@bachinf
  \def\@isreport{1}
	\def\@isdiploma{1}
\fi
\if@diplomist
  \def\@isreport{1}
  \def\@isdiploma{1}
\fi
\if@diplomtmath
  \def\@isreport{1}
  \def\@isdiploma{1}
\fi
\if@dissrernat
  \if@kurz
  \else
  \def\@isreport{1}
  \fi
  \def\@isdiss{1}
\fi
\if@dissing
  \if@kurz
  \else
  \def\@isreport{1}
  \fi
  \def\@isdiss{1}
\fi
\if@phd
	\if@kurz
	\else
		\def\@isreport{1}
	\fi
	\def\@isdiss{1}
\fi
\if@plainreport
  \def\@isreport{1}
  \def\@isplain{1}
\fi
\if@plainarticle
  \def\@isplain{1}
\fi

\ifx\@empty\@isreport
  \if@final
    \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, twoside,titlepage,headings=normal]{scrartcl}%
  \else
    \if@twoside
      \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, twoside,titlepage,headings=normal]{scrartcl}%
    \else
      \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, oneside,titlepage,headings=normal]{scrartcl}%
    \fi
  \fi
\else
  \if@final
    \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, twoside,titlepage,openright,headings=normal]{scrreprt}%
  \else
    \if@twoside
      \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, twoside,titlepage,openright,headings=normal]{scrreprt}%
    \else
      \LoadClass[cleardoublepage=empty, listof=totoc, bibliography=totoc, index=totoc, 11pt, abstracton, numbers=noenddot, oneside,titlepage,openright,headings=normal]{scrreprt}%
    \fi
  \fi
\fi

% deckblatttitel, je nachdem, was fuer ein dokument erstellt werden soll

\newcommand{\titleheader}[0]{$\quad$}
\newcommand{\copyrightinfo}[0]{ }
\newcommand{\supervisorlabel}[0]{ }
\newcommand{\examineronelabel}[0]{ }
\newcommand{\examinertwolabel}[0]{ }
\newcommand{\betreuerlabel}[0]{\supervisorlabel}
\newcommand{\hsllabel}[0]{\examineronelabel}
\newcommand{\matnolabel}[0]{ }
\newcommand{\matnoclosing}[0]{ }
\newcommand{\birthstart}[0]{ }
\newcommand{\birthmiddle}[0]{ }
\newcommand{\birthclosing}[0]{ }
\newcommand{\examregulationlabel}[0]{ }
\newcommand{\assignmentplaceholder}[0]{ }

\if@proseminar%
\renewcommand{\titleheader}[0]{Proseminar ``Rechnerarchitektur''}
\fi

\if@hauptseminar%
\renewcommand{\titleheader}[0]{Hauptseminar\\ ``Rechnerarchitektur und Programmierung''}
\fi

\if@mathseminar%
\renewcommand{\titleheader}[0]{Seminar ``Programmier- und Compilertechniken im
Wissenschaftlichen Hochleistungsrechnen''}
\fi

\if@belegseminar%
\renewcommand{\titleheader}[0]{Belegseminar}
\fi

\if@bachelorseminar%
\renewcommand{\titleheader}[0]{Bachelorseminar}
\fi

\if@belegsonst%
\renewcommand{\titleheader}[0]{Belegarbeit}
\fi

\if@beleg%
\renewcommand{\titleheader}[0]{Gro{\ss}er Beleg}
\fi

\if@researchproject%
	\if@german
		\renewcommand{\titleheader}[0]{Forschungsprojekt}
	\else
		\renewcommand{\titleheader}[0]{Research Project}
	\fi
\fi

\if@female
 \def\@female{in}
\else
 \def\@female{}
\fi

\ifx\@empty\@isdiploma
\else
  \@selbststaendigkeittrue%
\fi

\if@diplominf%
\renewcommand{\titleheader}[0]{Diplomarbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Diplom-Informatiker\@female}
\def\@faculty{Informatik}
\fi

\if@bachinf%
\renewcommand{\titleheader}[0]{Bachelor-Arbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Bachelor of Science}
\def\@faculty{Informatik}
\fi

\if@bachelorappliedinformatics%
\renewcommand{\titleheader}[0]{Bachelor-Arbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Bachelor of Science in Applied Computer Science}
\def\@faculty{Applied Computer Science}
\fi

\if@mastinf%
\renewcommand{\titleheader}[0]{Master-Arbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Master of Science in Computer Science}
\def\@faculty{Computer Science}
\fi

\if@masterappliedinformatics%
\renewcommand{\titleheader}[0]{Master-Arbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Master of Science in Applied Computer Science}
\def\@faculty{Applied Computer Science}
\fi

\if@diplomist%
\renewcommand{\titleheader}[0]{Diplomarbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Diplomingenieur\@female~f\"{u}r Informationssystemtechnik}
\def\@faculty{Elektrotechnik und Informationstechnik}
\fi

\if@diplomtmath%
\renewcommand{\titleheader}[0]{Diplomarbeit \\[1cm]\large zur Erlangung des akademischen Grades\\ Diplom-Mathematiker\@female~(Technomathematik)}
\def\@faculty{Mathematik und Naturwissenschaften, Fachrichtung Mathematik}
\fi



\if@dissrernat%
\if@kurz
\renewcommand{\titleheader}[0]{\begin{large}\textbf{Kurzfassung}\\[1cm]zur Erlangung des akademischen Grades Doktor rerum naturalium (Dr.\ rer.\ nat.)\end{large}}
\else
\renewcommand{\titleheader}[0]{\begin{large}\textbf{Dissertation}\\[1cm]zur Erlangung des akademischen Grades Doktor rerum naturalium (Dr.\ rer.\ nat.)\end{large}}
\fi
\def\@faculty{Informatik}
\fi

\if@dissing%
\if@kurz
\renewcommand{\titleheader}[0]{\begin{large}\textbf{Kurzfassung}\\[1cm]zur Erlangung des akademischen Grades Doktoringenieur (Dr.-Ing.)\end{large}}
\else
\renewcommand{\titleheader}[0]{\begin{large}\textbf{Dissertation}\\[1cm]zur Erlangung des akademischen Grades Doktoringenieur (Dr.-Ing.)\end{large}}
\fi
\def\@faculty{Informatik}
\fi

\if@phd%
	\if@kurz
		\if@german
			\renewcommand{\titleheader}[0]{\begin{large}\textbf{Kurzfassung}\end{large}}
		\else
			\renewcommand{\titleheader}[0]{\begin{large}\textbf{Abstract}\end{large}}
		\fi
	\else
		\if@german
			\renewcommand{\titleheader}[0]{\begin{large}\textbf{Dissertation}\end{large}}
		\else
			\renewcommand{\titleheader}[0]{\begin{large}\textbf{Ph.D. Thesis}\end{large}}
		\fi
	\fi
	\if@german
		\def\@faculty{Informatik}
	\else
		\def\@faculty{Computer Science}
	\fi
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set page-layout

% Definition der Seitenraender
%\setlength{\hoffset}{-1in}
%\addtolength{\hoffset}{2cm}
%\setlength{\voffset}{-1in}
%\addtolength{\voffset}{2cm}
%\addtolength{\voffset}{-\baselineskip}
%\setlength{\topmargin}{0mm}
%\setlength{\headheight}{2.0\baselineskip}
%\setlength{\headsep}{\baselineskip}
\setlength{\textheight}{24.5cm}
\setlength{\textwidth}{16cm}
\setlength{\evensidemargin}{0mm}
\setlength{\oddsidemargin}{0mm}
%\setlength{\marginparsep}{0mm}
%\setlength{\marginparwidth}{0mm}
%\setlength{\marginparpush}{0mm}
%\setlength{\footskip}{\baselineskip}
\setlength{\parindent}{0mm}
%\setlength{\parskip}{2mm}
%\setlength{\partopsep}{0mm}
\renewcommand{\cleardoublepage}{\cleardoublestandardpage}
\def\@chapapp{}
% enhanced tables
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{booktabs}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Option "german" bearbeiten

% Sprach-Dateien
\if@german%
  \RequirePackage[american,main=ngerman]{babel}
\else
  \RequirePackage[main=american,ngerman]{babel}
\fi


\if@german%
  \def\@copyrightlabel{Erkl\"{a}rungen zum Urheberrecht}
  \renewcommand\copyrightinfo[0]{%
    \cleardoublepage
    \ifx\@empty\@isreport
      \section*{\@copyrightlabel}
    \else
      \chapter*{\@copyrightlabel}
    \fi
    \@copyrighterklaerung}
  \ifx\@empty\@isplain
	\renewcommand{\supervisorlabel}[0]{Betreuer: }
	\renewcommand{\examineronelabel}[0]{Pr\"ufer 1: }
	\renewcommand{\examinertwolabel}[0]{Pr\"ufer 2: }
	\renewcommand{\examregulationlabel}[0]{Pr\"ufungsordnung: }
    \renewcommand{\matnolabel}[0]{(Mat.-Nr.: }
    \renewcommand{\matnoclosing}[0]{)}
    \renewcommand{\birthstart}[0]{(Geboren am }
    \renewcommand{\birthmiddle}[0]{ in }
    \renewcommand{\birthclosing}[0]{)}
	\renewcommand{\assignmentplaceholder}[0]{\textbf{\Large Hier Aufgabenstellung einf\"{u}gen!}}
  \fi
\else
  \def\@copyrightlabel{Copyright Information}
  \renewcommand\copyrightinfo[0]{%
    \cleardoublepage
    \ifx\@empty\@isreport
    \section*{\@copyrightlabel}
  \else
    \chapter*{\@copyrightlabel}
  \fi
  \@copyrighterklaerung}
  \ifx\@empty\@isplain
	\renewcommand{\supervisorlabel}[0]{Supervisor: }
	\renewcommand{\examineronelabel}[0]{Examiner 1: }
	\renewcommand{\examinertwolabel}[0]{Examiner 2: }
	\renewcommand{\examregulationlabel}[0]{Examination Regulations: }
    \renewcommand{\matnolabel}[0]{(Mat.-No.: }
    \renewcommand{\matnoclosing}[0]{)}
    \renewcommand{\birthstart}[0]{(Born }
    \renewcommand{\birthmiddle}[0]{ in }
    \renewcommand{\birthclosing}[0]{)}
	\renewcommand{\assignmentplaceholder}[0]{\textbf{\Large Insert assignment here!}}
  \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Format der Eingabedateien; Standard: latin1
\if@utf
\RequirePackage[utf8]{inputenc}
\else
\RequirePackage[latin1]{inputenc}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hyperref laden, wenn gewuenscht
\if@pdfa
\RequirePackage[a-2b]{pdfx}
\fi
\if@pdfua
\RequirePackage[a-2a,ua-1]{pdfx}
\ifcsname pdfmanagement_if_active_p:\endcsname
	\ExplSyntaxOn
	\bool_if:nTF { \pdfmanagement_if_active_p: }
		{
			\RequirePackage{tagpdf}
			\tagpdfsetup{activate-all}
		}
		{\ClassWarningNoLine{zihpub}{For fully tagged PDF/UA output, add
			\\RequirePackage{pdfmanagement-testphase} and
			\\DocumentMetadata{testphase=tagpdf} before \\documentclass}}
	\ExplSyntaxOff
\else
	\ClassWarningNoLine{zihpub}{For fully tagged PDF/UA output, add
		\\RequirePackage{pdfmanagement-testphase} and
		\\DocumentMetadata{testphase=tagpdf} before \\documentclass}
\fi
\fi
\if@hyperref
\RequirePackage{hyperref}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nomenclature laden
\if@nomencl
  \if@german
    \RequirePackage[german,intoc]{nomencl}
  \else
    \RequirePackage[intoc]{nomencl}
  \fi

  % Randbreite definieren
  \def\@nomenclmargin{3cm}
  \newcommand\setnomenclmargin[1]{\def\@nomenclmargin{#1}}

  % index erstellen
  \makenomenclature

\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Abstracts zusammenbauen
\newcommand{\abstractde}[1]{\def\@abstractde{#1}}
\newcommand{\abstracten}[1]{\def\@abstracten{#1}}
\newcommand{\abstractgerman}[1]{\abstractde{#1}}
\newcommand{\abstractenglish}[1]{\abstracten{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gliederung und Numerierung
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kopfzeile auch bei chapters
\ifx\@empty\@isreport
\else
\renewcommand*{\chapterpagestyle}{fancy}
\fi

% kopfzeile auch bei abstract
\let\@altab=\abstract
\let\end@altab=\endabstract
\renewenvironment{abstract}{%
\fancyfoot{}
\fancyhead{}
\if@final
  \fancyhead[LE,RO]{\thepage}
\else
  \if@twoside
    \fancyhead[LE,RO]{\thepage}
  \else
    \fancyhead[R]{\thepage}
  \fi
\fi
\begin{@altab}%
\thispagestyle{fancy}}{\end{@altab}%
\cleardoublepage
\ifx\@empty\@isreport
  \if@final
    \fancyhead[LO]{\@author}
    \fancyhead[RE]{\@title}
  \else
    \if@twoside
      \fancyhead[LO]{\@author}
      \fancyhead[RE]{\@title}
    \else
      \fancyhead[L]{\@author -- \@title}
    \fi
  \fi
\else
  \if@final
    \fancyhead[LO]{\rightmark}
    \fancyhead[RE]{\leftmark}
  \else
    \if@twoside
      \fancyhead[LO]{\rightmark}
      \fancyhead[RE]{\leftmark}
    \else
      \fancyhead[L]{\rightmark}
    \fi
  \fi
\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Institution fuer Titelseite: Chair of Computer Architecture by default;
% use the zih/zihtitle option for the ZIH institution.
\if@zihtitle
  \if@german
  \def\@institution{
    \begin{center}
    %Institution an der die Arbeit geschrieben wurde
    \huge
    \textsc{Technische Universit\"{a}t Dresden}

    \bigskip
    \Large
    \textsc{Zentrum f\"{u}r Informationsdienste\\ und Hochleistungsrechnen\\
    Prof. Dr. Wolfgang E. Nagel\\
    $\quad$\\
    $\quad$}
    \end{center}
  }
  \else
  \def\@institution{
    \begin{center}
    %Institution an der die Arbeit geschrieben wurde
    \huge
    \textsc{Technische Universit\"{a}t Dresden}

    \bigskip
    \Large
    \textsc{Center for Information Services\\ \& High Performance Computing\\
    Prof. Dr. Wolfgang E. Nagel\\
    $\quad$\\
    $\quad$}
    \end{center}
  }
  \fi
\else
  \if@mathseminar
    % Seminare nur in Deutsch
	  \def\@institution{
	    \begin{center}
	    %Institution an der die Arbeit geschrieben wurde
	    \huge
	    \textsc{Technische Universit\{"a}t Dresden}

	    \bigskip
	    \Large
	    \textsc{Fakult\"{a}t Mathematik und Naturwissenschaften\\
	    Fachrichtung Mathematik\\
	    Institut f\"{u}r Wissenschaftliches Rechnen\\
	    Professur f\"{u}r Angewandte Diskrete Mathematik\\
	    Prof. Dr. Wolfgang V. Walter}
	    \end{center}
	  }
  \else
	  \if@german
	  \def\@institution{
	    \begin{center}
	    %Institution an der die Arbeit geschrieben wurde
	    \huge
	    \textsc{Technische Universit\"{a}t Dresden}

	    \bigskip
	    \Large
	    \textsc{Fakult\"{a}t Informatik\\
	    Institut f\"{u}r Technische Informatik\\
	    Professur f\"{u}r Rechnerarchitektur\\
	    Prof. Dr. Wolfgang E. Nagel}
	    \end{center}
	  }
	  \else
	  \def\@institution{
	    \begin{center}
	    %Institution an der die Arbeit geschrieben wurde
	    \huge
	    \textsc{Technische Universit\"{a}t Dresden}

	    \bigskip
	    \Large
	    \textsc{Department of Computer Science\\
	    Institute of Computer Engineering\\
	    Chair of Computer Architecture\\
	    Prof. Dr. Wolfgang E. Nagel}
	    \end{center}
	  }
	  \fi
  \fi
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Style fuer Bibliography
\if@bibnum
  \if@german
    \bibliographystyle{plaindin}
  \else
    \bibliographystyle{plain}
  \fi
\else
  \if@german
    \bibliographystyle{alphadin}
  \else
    \bibliographystyle{alpha}
  \fi
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of tables/figures hinzu falls gewuenscht
\if@lof
  \newcommand{\printlof}{\listoffigures}
\else
  \newcommand{\printlof}{ }
\fi
\if@lot
  \newcommand{\printlot}{\listoftables}
\else
  \newcommand{\printlot}{ }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zeile unter dem autor zusammenstellen
\ifx\@empty\@isdiss
  \ifx\@empty\@isdiploma
    \ifx\@empty\@isplain
      \def\@subauthor{\matnolabel\@matno\matnoclosing}
    \else
      \def\@subauthor{$\quad$}
    \fi
  \else
    \def\@subauthor{\birthstart\@birthdate \birthmiddle\@birthplace\birthclosing}
  \fi
  \else
  \def\@subauthor{geboren am \@birthdate in \@birthplace}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Literatur-, Abbildungs- und Tabellenverzeichnis vor dem Anhang
\def\@haveapp{}
\let\@altapp=\appendix
\renewcommand{\appendix}[0]{\cleardoublestandardpage
\ifx\@empty\@bibfiles
\else
  \bibliography{\@bibfiles}
\fi
\cleardoublestandardpage
\printlof
\cleardoublestandardpage
\printlot
\cleardoublestandardpage
\@altapp
\def\@haveapp{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kopfzeile
\RequirePackage{fancyhdr}

% Automatische Generierung des Dokumentgrundgeruests
\ifx\@empty\@isdiss
	\AtBeginDocument{

\if@hyperref
\hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author}
}
\fi

	%\thispagestyle{empty}
	%\pagestyle{empty}
	\ifx\@empty\@isplain
	\else
	  \def\@publishers{$\quad$}
	  \def\@subject{$\quad$}
	\fi
	\if@notitlepage
	\else
		\if@wrapper
		  \@wrapperpage
		\fi
		\begin{titlepage}
		  \enlargethispage{1cm}
		
		  \@institution
		  \vspace{2cm}
		
		  \begin{center}
		  % Titel der Arbeit
		  \huge
		  \titleheader\\[1.5cm]
		  \huge
		  \@title
		  \vspace{2cm}
		
		  % Zweck der Arbeit
		  \Large
		  {\Large \@author }\\\@subauthor\\[2cm]
		
		  \end{center}
		  \vfill
		
		\begin{flushleft}
		 \Large
		\ifx\@empty\@isplain
		\ifx\@empty\@examinerone
	            \examineronelabel Prof. Dr. Wolfgang E. Nagel
		    \\
		 \else
		   \examineronelabel \@examinerone
		   \\
		 \fi
	 	 \ifx\@empty\@examinertwo
	 	 \else
	 	   \examinertwolabel \@examinertwo
	 	   \\
	 	 \fi
	 	 \supervisorlabel \@betreuer
	 	 \ifx\@empty\@examregulation
	 	 \else
	 	   \\
	 	   \examregulationlabel \@examregulation
	 	 \fi
	         \\[1cm]
		\else
		 $\quad$\\[1cm]
		\fi
		        Dresden, \@date\\[2cm]
		\end{flushleft}
		\end{titlepage}
	    \pagestyle{empty}
	    \@startonrightpage
	\fi
	
	% Seitenstil festlegen
	\fancyfoot{}
	\fancyhead{}
	\pagestyle{fancy}
	\thispagestyle{fancy}
	% Aufgabenstellung
	\ifx\@empty\@isdiploma
	\else
	  \if@noproblem
	  \else
	    \ifx\@empty\@assignmentpdf
	      \assignmentplaceholder
	    \else
	      \includepdf[pages=1,pagecommand={}]{\@assignmentpdf}
	    \fi
	  \fi
	\fi
	\cleardoublestandardpage
	%Selbst‰ndigkeitserklaerung
	\if@selbststaendigkeit
	\if@german
	  \section*{Selbstst\"{a}ndigkeitserkl\"{a}rung}
	  	  Hiermit erkl\"are ich, dass ich diese Ausarbeitung zum Thema:
	\else
	  \chapter*{Declaration of Independent Work}
	  I hereby declare that I have written this work on the subject:
	\fi
	
	     \begin{center}
	     \textit{\@title}
	     \end{center}
	
	\if@german
	     vollkommen selbstst\"{a}ndig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt sowie Zitate kenntlich gemacht habe.\\[2cm]
	\else
	     completely independently and have used no sources or aids other than those listed, with all quotations identified as such.\\[2cm]
	\fi
	
	\if@german
	    Dresden, den \@date\\[3cm]
	\else
	    Dresden, \@date\\[3cm]
	\fi
	    \@author
	\fi
	\cleardoublestandardpage
	%Zusammenfassung
	\ifx\@empty\@isdiploma
	\else
          \if@german
	  {\vspace*{2cm}
	  \minisec{Kurzfassung}
	  \@abstractde
	  \vspace{2cm}
 	  \selectlanguage{american}
	  \minisec{Abstract}
	  \@abstracten
	  \selectlanguage{ngerman}
	  }
          \else
	  {\vspace*{2cm}
  	  \selectlanguage{ngerman}
	  \minisec{Kurzfassung}
	  \@abstractde
	  \selectlanguage{american}
	  \vspace{2cm}
	  \minisec{Abstract}
	  \@abstracten
	  }
          \fi
	\fi
	% zeilenabstand ja nach variante
	\if@final
	  %\singlespacing
	\else
	  \onehalfspacing
	\fi
	\normalsize
	\cleardoublestandardpage
	%Inhaltsverzeichnis
	\pagenumbering{arabic}
	\if@final
	  \fancyhead[LE,RO]{\thepage}
	\else
	  \if@twoside
	    \fancyhead[LE,RO]{\thepage}
	  \else
	    \fancyhead[R]{\thepage}
	  \fi
	\fi
	\if@notoc
	\else
	  \tableofcontents
	  \cleardoublestandardpage
	\fi
	%Nomenclature
	\if@nomencl
	%  \if@german
	%    \addcontentsline{toc}{chapter}{Symbolverzeichnis}
	%  \else
	%    \addcontentsline{toc}{chapter}{Nomenclature}
	%  \fi
	%  \label{sec:Nomenclature}
	  \printnomenclature[\@nomenclmargin]
	\fi
	%Kopfzeile basteln
	\markboth{}{}
	\ifx\@empty\@isreport
	  \if@final
	    \fancyhead[LO]{\@author}
	    \fancyhead[RE]{\@title}
	  \else
	    \if@twoside
	      \fancyhead[LO]{\@author}
	      \fancyhead[RE]{\@title}
	    \else
	      \fancyhead[L]{\@author -- \@title}
	    \fi
	  \fi
	\else
	  \if@final
	    \fancyhead[LO]{\rightmark}
	    \fancyhead[RE]{\leftmark}
	  \else
	    \if@twoside
	      \fancyhead[LO]{\rightmark}
	      \fancyhead[RE]{\leftmark}
	    \else
	      \fancyhead[L]{\leftmark}
	    \fi
	  \fi
	\fi
	}%
    \AtEndDocument{
	% Literatur-, Abbildungs- und Tabellenverzeichnis, wenn nicht schon bei
	% \appendix automatisch davor eingefuegt
	\ifx\@empty\@haveapp
	  \cleardoublestandardpage
	  \ifx\@empty\@bibfiles
	  \else
	    \bibliography{\@bibfiles}
	  \fi
	  \cleardoublestandardpage
	  \printlof
	  \cleardoublestandardpage
	  \printlot
	\fi
	\cleardoublestandardpage
	%Danksagung
	\ifx\@empty\@acknowledgments
	\else
	  \if@german
	    \@mkboth{Danksagung}{}
	  \else
	    \@mkboth{Acknowledgments}
	  \fi
	  \ifx\@empty\@isreport
	    \if@german
	      \section*{Danksagung}
	    \else
	      \section*{Acknowledgments}
	    \fi
	  \else
	    \if@german
	      \chapter*{Danksagung}
	    \else
	      \chapter*{Acknowledgments}
	    \fi
	  \fi
	  \@acknowledgments
	\fi
	% Copyright-Kram
	\cleardoublestandardpage
	\ifx\@empty\@copyrighterklaerung
	\else
	  \@mkboth{\@copyrightlabel}{}
	  \copyrightinfo
	\fi
	\cleardoublestandardpage
    }
\else
	    \AtBeginDocument{


\if@hyperref
\hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author}
}
\fi

		%\thispagestyle{empty}
		%\pagestyle{empty}
		\if@notitlepage
		\else
			\if@wrapper
			  \@wrapperpage
			\fi
			\begin{titlepage}
				\enlargethispage{1cm}
				\begin{center}
					\sffamily
					\vspace*{25mm}
					\begin{Large}
						\textbf{\@title}
					\end{Large}
					
					\vspace{20mm}
						  \titleheader\\[1.5cm]
					\begin{large}
						 \vspace{18mm}
						 vorgelegt an der\\
						 Technischen Universit\"at Dresden\\
						 Fakult\"{a}t \@faculty
						
						 \vspace{12mm}
						
						 eingereicht von
						
						 \vspace{6mm}
					
						  {\textbf{\@author}}\\\@subauthor\\[2cm]
						  \vfill
						%\vspace{18mm}
							\if@german
								Gutachter 1: \@gutachterone\\
								Gutachter 2: \@gutachtertwo\\[2cm]
								Tag der Einreichung: \@submissiondate\\
								\ifx\@empty\@defensedate
								\else
								  Tag der Verteidigung: \@defensedate\\
								\fi
							\else
								Examiner 1: \@gutachterone\\
								Examiner 2: \@gutachtertwo\\[2cm]
								Submission date: \@submissiondate\\
								\ifx\@empty\@defensedate
								\else
								  Defense date: \@defensedate\\
								\fi
							\fi
							\ifx\@empty\@examregulation
							\else
							  \examregulationlabel \@examregulation\\[2cm]
							\fi
							\bigskip
							 Dresden, \@date\\[2cm]
					\end{large}
				\end{center}
			\end{titlepage}
			\@startonrightpage
		\fi
		\ifx\@dedication\@empty \else
		  \next@tpage\null\vfill
		  {\centering \em \@dedication \par}%
		  \vskip \z@ \@plus3fill
		  \if@twoside \next@tpage\cleardoubleemptypage \fi
		\fi
	% Seitenstil festlegen
		\fancyfoot{}
		\fancyhead{}
		\pagestyle{fancy}
		\thispagestyle{fancy}			
			% zeilenabstand ja nach variante
		\if@final
		  %\singlespacing
		\else
			\onehalfspacing
		\fi
		\normalsize
		\cleardoublestandardpage
		\if@kurz
		\else
		%Zusammenfassung
           \if@german
	  {\vspace*{2cm}
	  \minisec{Kurzfassung}
	  \@abstractde
	  \vspace{2cm}
 	  \selectlanguage{american}
	  \minisec{Abstract}
	  \@abstracten
	  \selectlanguage{ngerman}
	  }
          \else
	  {\vspace*{2cm}
  	  \selectlanguage{ngerman}
	  \minisec{Kurzfassung}
	  \@abstractde
	  \selectlanguage{american}
	  \vspace{2cm}
	  \minisec{Abstract}
	  \@abstracten
	  }
          \fi
                \cleardoublestandardpage
		\fi
	%Inhaltsverzeichnis
		\pagenumbering{arabic}
		\if@final
		  \fancyhead[LE,RO]{\thepage}
		\else
		  \if@twoside
		    \fancyhead[LE,RO]{\thepage}
		  \else
		    \fancyhead[R]{\thepage}
		  \fi
		\fi
		\if@notoc
		\else
		  \tableofcontents
		  \cleardoublestandardpage
		\fi
		%Nomenclature
		\if@nomencl
		%  \if@german
		%    \addcontentsline{toc}{chapter}{Symbolverzeichnis}
		%  \else
		%    \addcontentsline{toc}{chapter}{Nomenclature}
		%  \fi
		%  \label{sec:Nomenclature}
		  \printnomenclature[\@nomenclmargin]
		\fi
		%Kopfzeile basteln
		\markboth{}{}
		\ifx\@empty\@isreport
		  \if@final
		    \fancyhead[LO]{\@author}
		    \fancyhead[RE]{\@title}
		  \else
		    \if@twoside
		      \fancyhead[LO]{\@author}
		      \fancyhead[RE]{\@title}
		    \else
		      \fancyhead[L]{\@author -- \@title}
		    \fi
		  \fi
		\else
		  \if@final
		    \fancyhead[LO]{\rightmark}
		    \fancyhead[RE]{\leftmark}
		  \else
		    \if@twoside
		      \fancyhead[LO]{\rightmark}
		      \fancyhead[RE]{\leftmark}
		    \else
		      \fancyhead[L]{\leftmark}
		    \fi
		  \fi
		\fi
	}%
	\AtEndDocument{%
		% Literatur-, Abbildungs- und Tabellenverzeichnis, wenn nicht schon bei
		% \appendix automatisch davor eingefuegt
		\ifx\@empty\@haveapp
		  \cleardoublestandardpage
		  \ifx\@empty\@bibfiles
		  \else
		    \bibliography{\@bibfiles}
		  \fi
		  \cleardoublestandardpage
		  \printlof
		  \cleardoublestandardpage
		  \printlot
		\fi
		\cleardoublestandardpage
		%Danksagung
		\ifx\@empty\@acknowledgments
		\else
		  \if@german
		    \@mkboth{Danksagung}{}
		  \else
		    \@mkboth{Acknowledgments}
		  \fi
		  \ifx\@empty\@isreport
		    \if@german
		      \section*{Danksagung}
		    \else
		      \section*{Acknowledgments}
		    \fi
		  \else
		    \if@german
		      \chapter*{Danksagung}
		    \else
		      \chapter*{Acknowledgments}
		    \fi
		  \fi
		  \@acknowledgments
		\fi
		% Copyright-Kram
		\cleardoublestandardpage
		\ifx\@empty\@copyrighterklaerung
		\else
		  \@mkboth{\@copyrightlabel}{}
		  \copyrightinfo
		\fi
		\cleardoublestandardpage
	}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nuetzliche Zusatzkommandos

\newcommand\longcite[2]{(vgl.~\cite{#1}, S.~#2)}

\newcommand\shortcite[2]{(\cite{#1}, S.~#2)}

%% itemize ohne abstand zw. den items
%\let\@altitemize=\itemize
%\let\end@altitemize=\enditemize
%\renewenvironment{itemize}{%
%\begin{@altitemize}%
%\ifnum \@itemdepth = 1
%  \vspace{-10pt}
%  \setlength{\itemsep}{-1pt}
%\else
%  \ifnum \@itemdepth = 2
%    \vspace{-6pt}
%    \setlength{\itemsep}{0pt}
%  \else
%    \ifnum \@itemdepth = 3
%      \vspace{-2pt}
%      \setlength{\itemsep}{1pt}
%    \else
%      \vspace{0pt}
%      \setlength{\itemsep}{2pt}
%    \fi
%  \fi
%\fi
%  \setlength{\parsep}{0pt}
%\setlength{\labelsep}{12pt}
%}%
%{\end{@altitemize}\vspace{-2pt}}

%% enumerate ohne abstand zw. den items
%\def\enumerate{%
%  \ifnum \@enumdepth >3 \@toodeep\else
%	\ifnum \@enumdepth = 0
%	  \vspace{-10pt}
%	  \setlength{\itemsep}{-1pt}
%	\else
%	  \ifnum \@enumdepth = 1
%	    \vspace{-6pt}
%	    \setlength{\itemsep}{0pt}
%	  \else
%	    \ifnum \@enumdepth = 2
%	      \vspace{-2pt}
%	      \setlength{\itemsep}{1pt}
%	    \else
%	      \vspace{0pt}
%	      \setlength{\itemsep}{2pt}
%	    \fi
%	  \fi
%	\fi
%	\setlength{\parsep}{0pt}
%	\setlength{\labelsep}{12pt}
%      \advance\@enumdepth \@ne
%      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\fi
%  \@ifnextchar[{\@@enum@}{\@enum@}}
%\def\@@enum@[#1]{%
%  \@enLab{}\let\@enThe\@enQmark
%  \@enloop#1\@enum@
%  \ifx\@enThe\@enQmark\@warning{The counter will not be printed.%
%   ^^J\space\@spaces\@spaces\@spaces The label is: \the\@enLab}\fi
%  \expandafter\edef\csname label\@enumctr\endcsname{\the\@enLab}%
%  \expandafter\let\csname the\@enumctr\endcsname\@enThe
%  \csname c@\@enumctr\endcsname7
%  \expandafter\settowidth
%            \csname leftmargin\romannumeral\@enumdepth\endcsname
%            {\the\@enLab\hspace{\labelsep}}%
%  \@enum@}
%\def\@enum@{\list{\csname label\@enumctr\endcsname}%
%           {\usecounter{\@enumctr}\def\makelabel##1{\hss\llap{##1}}}}

% paragraph mit Zeilenumbruch nach der Ueberschrift
\newcommand\Paragraph[1]{\minisec{#1}}

% im text korrekturen anzeigen
\newcommand{\correctme}[1]{\textcolor{red}{#1}}

% korrekturen ueber mehrere absaetze
\newenvironment{correctmore}{\color{red}}{\color{black}}
