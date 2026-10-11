%%%%%%%%%%%% LaTeX template for IIITDM Kancheepuram thesis/synopsis - 2021%%%%%%%%%%%%%%%%%
%
% This is a class for LaTeX2e that should format a report as per
% the IIITDM Kancheepuram Thesis guidelines.  The page layout is set using the
% geometry package.  The double/singlespacing is setup using
% setspace.  Figure captions are set using the hang option of
% caption2.  natbib is used to do the citation using an
% author-year format. I've made an iiitdm.bst file that formats 
% the references as per the IIITDM guidelines.
%
% To use this class do the following:
%  \documentclass[options]{iiitdm} 
%
% Options:
%
%   PhD, MS, MTech, DD or BTech -- generates the appropriate title page
%   and loads the report class.

%	Adding 'PrntForm' as additonal option to the class 
%	(like \documentclass[PhD,PrntForm]{iiitdm} ) 
%	will generate the pdf that can be printable 
%	(with chapters always starting on the right side and page
%	numbers corrected appropriately)
%
%   synopsis -- Generates the title page for the synopsis.  This also
%   loads the article class instead of the report.
%  
% Example:
%
% \documentclass[PhD,synopsis]{iiitdm}
% \documentclass[PhD,PrntForm]{iiitdm}
% \documentclass[MS]{iiitdm}
%
% IMPORTANT NOTICE:
% 
%   PLEASE DO NOT MESS WITH THE MARGINS AND GENERAL FORMATTING SETUP
%   IN THIS FILE UNLESS YOU ARE ABSOLUTELY SURE THAT THE FORMAT DOES NOT
%   MATCH WITH THE THESIS GUIDELINES.  FOR EXAMPLE, DO NOT CHANGE THE 
%   MARGINS AND SPACING JUST TO MAKE YOUR THESIS SMALLER OR LARGER!
% 
% New Features (2021)
% 	- standardized the template in compliance with the new IIITDM format guidelines released in Feb 2021. Added relevant pages/licensing example wherever required
%	- formatting guidelines included in a separate folder along with other proformas required while submitting your synopsis or thesis for convenience
%	- option to include a visually appealing figure/image from your thesis on the title page of thesis
%	- options for 'Blue' or 'Yellow' tape to represent the draft and approved reports on the title page of respective documents as per the new guidelines. Deafult is 'Black' for the final PhD thesis, along with 'NoColor' option for no color band if required
%	- example code for usage of 'subcaption' package for placing multiple sub-figures
%	- added IEEE bib style (in commented form below the iiidtm bibstyle optionin the present file) required in some departments

% New Features (2020)
% 	- removed obsolete options (compat2, hypertex) and to work with Tex 2019
%	- added Dual Degree option for project report 
%		(can be edited to use it for any course based degree like M.Sc., M.A., M.B.A)
%	- added the option 'PrntForm' to produce thesis with the necessary blank pages for printing
%	- added clean.sh bash file (works with Linux systems which uses bash) to clean the latex files for a fresh compilation
%	- separation of main tex file from its chapter/sections (using \include{file} option) along with proper grouping and labeling of files for easier sorting and debugging
%		(A01_title, B01_abstract, C01_chap1, D01_app1 and E01_lop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	- added sample pages for quotations, dedication, glossary, abbreviations and notation
%	- cleaned up few parts where page numbers aren't required (quotes/dedication pages)
%	- added 'tabular' method for glossary/notation/abbreviations to avoid text overflow in long phrases that results from the usage of 'tabbing'
%	- corrected and added sample content to certificate; useful for co-guides and sponsored candidates
%	- corrected and added the necessary headings for 'List of Publications' chapter at the end
%	- added the sample CV and Committee pages at the end
%
% 	- added opensource licensing to the file for unambiguity in free usage and distribution
% 	- moved packages, commands, preamble and postamble of the thesis to 0_settings folder for simpler look
%   	- fixed various bugs in iiitdm.bst and added doi/arxiv link support for references


%%%%%%%%%%%%%%%%%%%%     Licensing	  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License. 
%% To view a copy of this license, visit: https://creativecommons.org/licenses/by-nc/4.0/

%% So like any other piece of freely distributable code, this template and other files within this folder are provided "as is." There is no guarantee of any kind from the author
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{iiitdm}[2021/07/30 Class for IIITDM-Kancheepuram Dissertations]

\newif\if@PhD
\newif\if@MS
\newif\if@MTech
\newif\if@DD
\newif\if@MBA
\newif\if@MSc
\newif\if@BTech
\newif\if@Synopsis
\newif\if@PrntForm
\newif\if@NoColor
\newif\if@BlueTape
\newif\if@YellowTape


\DeclareOption{PhD}{\@PhDtrue}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{MTech}{\@MTechtrue}
\DeclareOption{DD}{\@DDtrue}
\DeclareOption{MBA}{\@MBAtrue}
\DeclareOption{MSc}{\@MSctrue}
\DeclareOption{BTech}{\@BTechtrue}
\DeclareOption{synopsis}{\@Synopsistrue}
\DeclareOption{PrntForm}{\@PrntFormtrue}
\DeclareOption{NoColor}{\@NoColortrue}
\DeclareOption{BlueTape}{\@BlueTapetrue}
\DeclareOption{YellowTape}{\@YellowTapetrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load the correct class.
\if@Synopsis
    \LoadClass[12pt,a4paper]{article}
\else
	\if@PrntForm
		\LoadClass[12pt,a4paper,twoside,openright]{report}
	\else
    	\LoadClass[12pt,a4paper]{report}
    \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometry and page layout
\RequirePackage[a4paper,left=1.25in,right=1.25in,top=1in,bottom=0.67in,
nohead,includefoot,footskip=0.67in]{geometry}[2018/05/13]
%\RequirePackage[compat2,a4paper,left=1.5in,right=1in,top=1in,bottom=0.667in,
%                nohead]{geometry}[2002/07/08] %% compat2 is obsolete
\parskip 8pt
%\setlength{\footskip}{10pt}  % Added for page number adjustment without compat2

\renewcommand{\@pnumwidth}{2.5em}
%\renewcommand{\@tocrmarg}{2.5em}

%% For adding the color bands on the title page
\RequirePackage{eso-pic}
\definecolor{nocolor}{RGB}{255,255,255}
\definecolor{blutape}{RGB}{0,176,240}
\definecolor{ylwtape}{RGB}{255,255,0}
\definecolor{msfnl}{RGB}{0,176,240}
\definecolor{phdfnl}{RGB}{0,0,0}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using setspace to do the single/double spacing.  Setspace also
%% makes all tables and figures have single spacing automatically.
\RequirePackage{setspace} 
\RequirePackage{atbeginend} % used to redefine the list environs
\setstretch{1.5}

\BeforeBegin{itemize}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{itemize}{\end{singlespace}}

\BeforeBegin{enumerate}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{enumerate}{\end{singlespace}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The figure captioning is done correctly via the hang option.
%%\RequirePackage[hang]{caption2}  -> TeX generates error
\RequirePackage[hang]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography
% 
% natbib allows easy switching of citation style and using it along
% with the iiitdm.bst makes things perfect.
\RequirePackage[authoryear,round]{natbib} 
%\RequirePackage[numbers,square]{natbib} 
\bibliographystyle{iiitdm}

\newcommand{\bibstyle@iiitdm}{\bibpunct{(}{)}{;}{a}{,}{,}%
     \gdef\NAT@biblabel##1{##1. }}
%
\setlength{\bibhang}{0pt}
\citestyle{iiitdm}
%\citestyle{unsrt_newen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful macros.  Many of these are modifications from newdiss.cls

% \department{department name} -- user macro to declare name of department.
\def\department#1{\gdef\@department{#1}}

%\RequirePackage[dvips]{graphicx}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The title page

\def\maketitle{%
  \pagenumbering{roman}
  \thispagestyle{empty}
  \newpage
  \null
  \setcounter{page}{1}
  \parskip=0pt
  
  %%%  New format to include color band on the left margin  %%%%
%  \if@MS
%  	\if@NoColor
%  		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
%  		\color{nocolor}\rule{1.25in}{\paperheight}}}
%  	\else
%  	\AddToShipoutPictureBG*{\AtPageLowerLeft{%
%  	\color{msfnl}\rule{1.25in}{\paperheight}}}
%  	\fi
%  \fi
  \if@PhD
  	\if@NoColor
  		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  		\color{nocolor}\rule{1.25in}{\paperheight}}}
  	\else
  	\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  	\color{phdfnl}\rule{1.25in}{\paperheight}}}
  	\fi
  \fi
  \if@Synopsis
  	\if@NoColor
    	\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  		\color{nocolor}\rule{1.25in}{\paperheight}}}
  	\else
  		\if@BlueTape
    		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
			\color{blutape}\rule{1.25in}{\paperheight}}}
		\fi
		\if@YellowTape
	    	\AddToShipoutPictureBG*{\AtPageLowerLeft{%
			\color{ylwtape}\rule{1.25in}{\paperheight}}}
		\fi
	\fi
  \else
   \if@NoColor
   		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
   		\color{nocolor}\rule{1.25in}{\paperheight}}}
   \else
   		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
   		\color{phdfnl}\rule{1.25in}{\paperheight}}}
   \fi
  \fi
  \if@MS
  	\if@NoColor
  		\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  		\color{nocolor}\rule{1.25in}{\paperheight}}}
  	\else
  		\if@YellowTape
  			\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  			\color{ylwtape}\rule{1.25in}{\paperheight}}}
  		\else
  			\AddToShipoutPictureBG*{\AtPageLowerLeft{%
  			\color{msfnl}\rule{1.25in}{\paperheight}}}
  		\fi
  	\fi
  \fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   The title page content starts here   %%%%%%%%%%%
\noindent
\hskip 4ex
\begin{minipage}[t]{0.25\textwidth}
	 \centering\raisebox{\dimexpr \topskip-\height+2ex}{%
		\includegraphics[width=\textwidth]{iiitdmlogo.png}}
\end{minipage} \hfill
\begin{minipage}[t]{0.55\textwidth}
	\begin{singlespace}
		\raggedright
		\nohyphens{\normalsize DEPARTMENT OF \@department\par
		INDIAN INSTITUTE OF INFORMATION TECHNOLOGY, DESIGN AND MANUFACTURING KANCHEEPURAM\\ 
		CHENNAI - 600127}
	\end{singlespace}
\end{minipage}

%%%  Solid line after the letter head 
\vskip 2ex%
\noindent
\rule{17.7cm}{0.8mm}
  
  \vspace{0.3cm}

  \begin{center}%
  \let \footnote \thanks
  \vglue 0in % this makes top margin 2in
  \vskip 1ex%
    \if@Synopsis
    {\em Synopsis Of \par}
    \vskip 10ex%
  \fi
%	\parbox[s]{0.8\textwidth}{ \centering
%	\Large \bf \expandafter{\@title} \par \vskip 2ex}
	\begin{tcolorbox}[sharp corners,
		colback=white,
		width=12cm,
		%boxsep=1pt,
		boxrule=1pt,
		left=1pt,
		right=1pt,
		top=2pt,]
		\centering \nohyphens{\Large \bf \expandafter{\@title}}
	\end{tcolorbox}
	\vskip 2ex
  	\if@Synopsis
		\par
	\else
		\IfFileExists{titleImage.png}{\centerline{\includegraphics[height=7cm]{titleImage}}}{\par}
	\fi
    \if@Synopsis
		\vskip 15ex%
	\else
		\IfFileExists{titleImage.png}{\vskip 4ex}{\vskip 15ex}%
	\fi
    {\normalsize
      \if@PhD
         {\em A Thesis }\par
         \if@Synopsis
            {\normalsize \em To be submitted by \par}
         \else
            {\normalsize \em Submitted by \par}
         \fi
         {\bf \normalsize \MakeUppercase{\@author}\par\par}
         \if@Synopsis
         	\vskip 15ex%
         \else
         	\IfFileExists{titleImage.png}{\vskip 7ex}{\vskip 15ex}%
         \fi
         {\em For the award of the degree }\par
         {\em Of} \par
         {\bf \normalsize \MakeUppercase{Doctor of Philosophy}} \par
       \else
         \if@MS
         {\em A Thesis }\par
			\if@Synopsis
				{\normalsize \em To be submitted by \par}
			\else
				{\normalsize \em Submitted by \par}
			\fi
		 {\bf \normalsize \MakeUppercase{\@author}\par\par}
         \if@Synopsis
         	\vskip 15ex%
         \else
         	\IfFileExists{titleImage.png}{\vskip 7ex}{\vskip 15ex}%
         \fi
		 {\em For the award of the degree }\par
		 {\em Of} \par
         {\bf \normalsize \MakeUppercase{Master of Science} \par
            (by Research) \par}
       \else
       	 \if@DD
       		{\em A Project Report }\par
       		{\normalsize \em Submitted by \par}
       		{\bf \normalsize \MakeUppercase{\@author}\par\par}
       		\IfFileExists{titleImage.png}{\vskip 7ex}{\vskip 15ex}%
       		{\normalsize \em In the partial fulfilment of requirements\par
       			For the award of the \par}
       		{\bf \normalsize \MakeUppercase{Dual Degree} (B.Tech. and M.Tech.)} \par
		% Uncomment below lines for specialization
                {\normalsize \em with specialization in \par}
			{\bf \normalsize Applied Mechanics with Biomedical Engineering \par\par}
       	\else
           {\em A Project Report }\par
           {\normalsize \em Submitted by \par}
           {\bf \normalsize \MakeUppercase{\@author}\par\par}
           \IfFileExists{titleImage.png}{\vskip 4ex}{\vskip 15ex}%
           {\normalsize \em In the partial fulfilment of requirements\par
             For the award of the degree \par}
           {\em Of} \par
           \if@MTech
              {\bf \normalsize \MakeUppercase{Master of Technology}} \par
           \fi
           \if@MBA
           	  {\bf \normalsize \MakeUppercase{Master of Business Administration}} \par
           \fi
           \if@MSc
              {\bf \normalsize \MakeUppercase{Master of Science}} \par
           \fi
           \if@BTech
              {\bf \normalsize \MakeUppercase{Bachelor of Technology}} \par
           \fi
          \fi
         \fi
      \fi
    }
	\if@Synopsis
		\par
  	\else 
  		{\normalsize \@date}
  	\fi
  \end{center}%
}
%%%%%%%%%%%%%%%   Title page content ends here   %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\titlepage{\newpage\thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\newpage}


\if@Synopsis
%   \renewcommand\refname{REFERENCES}
\else
   % QUOTATIONS
   %
   \def\quotations{\chapter*{\centerline{QUOTATIONS}}
   	 \thispagestyle{empty}
   %\addcontentsline{toc}{chapter}{QUOTATIONS}
   }

   % DEDICATION
   %
   \def\dedication{\chapter*{\centerline{DEDICATION}}
   	 \thispagestyle{empty}
   %\addcontentsline{toc}{chapter}{DEDICATION}
   }

   % CERTIFICATE
   %
   %   - this produces a certificate page as per IIITDM Regulations
   %     comment the following lines out to get it working.
   %
   \if@PhD
   \def\certificate{\chapter*{\centerline{THESIS CERTIFICATE}}%% A preliminary chapter
     %\vspace*{36pt}
     %\centerline{\Large \bf THESIS CERTIFICATE}
     \vskip 10pt
     \thispagestyle{empty}
     %\typeout{Certificate}
     %\setcounter{page}{-1}
   }
   \else
   \if@MS
	\def\certificate{\chapter*{\centerline{THESIS CERTIFICATE}}%% A preliminary chapter
	\vskip 10pt
	\thispagestyle{empty}
	}
   \else
   \def\certificate{\chapter*{\centerline{CERTIFICATE}}%% A preliminary chapter
	\vskip 10pt
	\thispagestyle{empty}
	}
	\fi
	\fi
	

	%%%  LIST OF PAPERS
	\def\listofpapers{
	%\normalbaselines
	\chapter*{\centerline{LIST OF PUBLICATIONS}}
	%\markboth{LIST OF PUBLICATIONS}{LIST OF PUBLICATIONS}
	%\addcontentsline{toc}{chapter}{LIST OF PUBLICATIONS}
	\vskip 10pt
	\thispagestyle{empty}
	}


   % ACKNOWLEDGEMENTS
   %
   \def\acknowledgements{\chapter*{\centerline{ACKNOWLEDGEMENTS}}
     \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
     \setcounter{page}{1}
   }

   % ABSTRACT
   %   - this produces pages suitable for an iiitdm Abstract
   \def\abstract{\chapter*{\centerline{ABSTRACT}}
   \addcontentsline{toc}{chapter}{ABSTRACT}
   }

   % GLOSSARY
   %
   \def\glossary{\chapter*{\centerline{GLOSSARY}}
   \addcontentsline{toc}{chapter}{GLOSSARY}
   }

   % ABBREVIATIONS
   %
   \def\abbreviations{\chapter*{\centerline{ABBREVIATIONS}}
   \addcontentsline{toc}{chapter}{ABBREVIATIONS}
   }

   % NOTATION
	%
	\def\notation{\chapter*{\centerline{NOTATION}}
	\addcontentsline{toc}{chapter}{NOTATION}
	}

   % Use the nomencl package for the NOTATION section.

   % Makes the chapter heading
   \def\@makechapterhead#1{%
     {\parindent \z@ \raggedright \normalfont
       \ifnum \c@secnumdepth >\m@ne
       \begin{center}
         \Large\bfseries \@chapapp\space \thechapter
       \end{center}
       \par\nobreak
       \vskip 20\p@
       \fi
       \interlinepenalty\@M
       \Large \bf
       \begin{center}
         #1\par\nobreak      
       \end{center}
       \vskip 20\p@
       \thispagestyle{empty}
     }}

   % Makes the chapter heading for \chapter* commands
   \def\@makeschapterhead#1{%
     \vspace*{25\p@}%
     {\parindent \z@ \raggedright
       \normalfont
       \interlinepenalty\@M
       \Large \bfseries #1\par\nobreak
       \vskip 20\p@
     }}

   
   % CV
   \def\CV{\chapter*{\centerline{CURRICULUM VITAE}}}

   % Comittee
   \if@PhD
       \def\committee{\chapter*{\centerline{DOCTORAL COMMITTEE}}}
   \else
       \if@MS
          \def\committee{\chapter*{\centerline{GENERAL TEST COMMITTEE}}}
        \fi
   \fi


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Renewed commands to set the titles of various pages correctly.
   \renewcommand\contentsname{\centering TABLE OF CONTENTS}
   \renewcommand\listfigurename{\centering LIST OF FIGURES}
   \renewcommand\listtablename{\centering LIST OF TABLES}
   \renewcommand{\chaptername}{CHAPTER}
   \renewcommand\bibname{\centering REFERENCES}

   \renewcommand\appendixname{APPENDIX}
   \renewcommand{\fnum@figure}{Fig. \thefigure}
\fi


