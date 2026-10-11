%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To use this class do the following:
%  \documentclass[options]{iitdmdiss} 
%
% Options:
%
%   DD, MTech or BTech -- generates the appropriate title page
%   and loads the report class.
%
% IMPORTANT NOTICE:
% 
%   PLEASE DO NOT MESS WITH THE MARGINS AND GENERAL FORMATTING SETUP
%   IN THIS FILE UNLESS YOU ARE ABSOLUTELY SURE THAT THE FORMAT DOES NOT
%   MATCH WITH THE REPORT GUIDELINES.  FOR EXAMPLE, DO NOT CHANGE THE 
%   MARGINS AND SPACING JUST TO MAKE YOUR REPORT LARGER!
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{iiitdmdiss}[2021/04/13 Class for IIITDM Kancheepuram Project Reports]

\newif\if@PhD
\newif\if@MS
\newif\if@MTech
\newif\if@BTech
\newif\if@DD
\newif\if@Synopsis

\DeclareOption{PhD}{\@PhDtrue}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{MTech}{\@MTechtrue}
\DeclareOption{BTech}{\@BTechtrue}
\DeclareOption{DD}{\@DDtrue}
\DeclareOption{synopsis}{\@Synopsistrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load the correct class.
\if@Synopsis
    \LoadClass[12pt,a4paper]{article}
\else
    \LoadClass[12pt,a4paper]{report}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometry and page layout
\RequirePackage[a4paper,left=1.5in,right=1in,top=1in,bottom=1in]{geometry}[2002/07/08]
\parskip 8pt

\renewcommand{\@pnumwidth}{2.5em}
%\renewcommand{\@tocrmarg}{2.5em}


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
% with the iitm.bst makes things perfect.
%\RequirePackage[authoryear,round]{natbib} 
\RequirePackage[numbers]{natbib} 

%\bibliographystyle{iitm}
%\newcommand{\bibstyle@iitm}{\bibpunct{(}{)}{;}{a}{,}{,}%
%     \gdef\NAT@biblabel##1{##1. }}
%\setlength{\bibhang}{0pt}
%\citestyle{iitm}
\bibliographystyle{IEEEtranN} 
%\citestyle{unsrt_newen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful macros.  Many of these are modifications from newdiss.cls

% \department{department name} -- user macro to declare name of department.
\def\monthyear#1{\gdef\@monthyear{#1}}
\def\department#1{\gdef\@department{#1}}
\def\roll#1{\gdef\@roll{#1}}
\def\guide#1{\gdef\@guide{#1}}
\def\guidedesignation#1{\gdef\@guidedesignation{#1}}
\def\guidedept#1{\gdef\@guidedept{#1}}
%\def\acadyear#1{\gdef\@acadyear{#1}}
%\RequirePackage[dvips]{graphicx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The title page

\def\maketitle{%
  \pagenumbering{roman}
  \thispagestyle{empty}
  \newpage
  \null
  \setcounter{page}{0}
  \parskip=0pt
  \begin{center}%
  \let \footnote \thanks
  \vglue 0in % this makes top margin 2in
  \vskip -5ex%
  \if@Synopsis
    {\large \em SYNOPSIS OF \par}
  \fi
    {\Large \bf \expandafter{\@title} \par}%
    \vskip 10ex%
    {\normalsize
      \if@PhD
         {\em A THESIS }\par
         \vskip 5ex%
         \if@Synopsis
            {\normalsize \em to be submitted by \par}
         \else
            {\normalsize \em submitted by \par}
         \fi
         \vskip 5ex%
         {\bf \large\MakeUppercase{\@author\@roll}\par\par}
         \vskip 5ex%
         {\em for the award of the degree }\par
         \vskip 5ex%
         {\em of} \par
         \vskip 5ex%
         {\bf \large \MakeUppercase{Doctor of Philosophy}} \par
       \else
         \if@MS
            {\em A THESIS }\par
            \vskip 5ex%
            {\normalsize \em submitted by \par}
            \vskip 5ex%
            {\bf \large\MakeUppercase{\@author}\par\par}
            \vskip 5ex%
            {\em for the award of the degree }\par
            \vskip 5ex%
            {\em of} \par
            \vskip 5ex%
            {\bf \large \MakeUppercase{Master Of Science}} \par
            (by Research) \par
         \else
           {\em A Project Report }\par
           \vskip 5ex%
           {\normalsize \em submitted by \par}
           \vskip 5ex%
           {\bf \large\MakeUppercase{\@author\hspace{2mm}(\@roll)}\par\par}
           \vskip 5ex%
           {\normalsize \em in partial fulfilment of requirements\par
             for the award of the \if@DD
             dual
             \fi degree of \par}
           \vskip 5ex%
           \if@MTech
             {\bf MASTER OF TECHNOLOGY}
           \fi
           \if@BTech
              {\bf BACHELOR OF TECHNOLOGY}
           \fi
            \if@DD
            {\bf BACHELOR OF TECHNOLOGY AND MASTER OF TECHNOLOGY}
            \fi
         \fi
      \fi
    }
  \end{center}%

  \vspace*{0.75in}
  \centerline{\includegraphics[scale=0.3]{iiitdm}}
  \vspace*{-0.15in}
  \begin{center}
    {\bf \large Department of \@department\par}
    {\bf \large INDIAN INSTITUTE OF INFORMATION TECHNOLOGY, DESIGN AND MANUFACTURING KANCHEEPURAM}
    \vglue 0.50em
    {\bf \large \@monthyear}\par
  \end{center}
  \parskip 8pt
}

\def\titlepage{\newpage\thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\newpage}

\if@Synopsis
   \renewcommand\refname{REFERENCES}
\else
   % QUOTATIONS
   %
   \def\quotations{\chapter*{\centerline{QUOTATIONS}}
   %\addcontentsline{toc}{chapter}{QUOTATIONS}
   }

   % DEDICATION
   %
   \def\dedication{\chapter*{\centerline{DEDICATION}}
   %\addcontentsline{toc}{chapter}{DEDICATION}
   }
  \def\declaration{%% A preliminary chapter
	\clearpage
	\vspace*{36pt}
	\centerline{\Large \bf DECLARATION OF ORIGINALITY}
	\vskip 25pt
	\thispagestyle{empty}
	\typeout{Certificate}

\noindent I, \textbf{\@author}, with Roll No: \textbf{\@roll} hereby declare that the material presented in the Project Report titled \textbf{\@title} represents original work carried out by me in the \textbf{Department of \@department} at the Indian Institute of Information Technology, Design and Manufacturing, Kancheepuram.\\
\noindent 
With my signature, I certify that:
\begin{singlespace}
	\begin{itemize}
	\item I have not manipulated any of the data or results.\\
	\item I have not committed any plagiarism of intellectual
	property.
	I have clearly indicated and referenced the contributions of
	others.\\
	\item I have explicitly acknowledged all collaborative research
	and discussions.\\
	\item I have understood that any false claim will result in severe
	disciplinary action.\\
	\item I have understood that the work may be screened for any form
	of academic {misconduct}.
	\end{itemize}
\end{singlespace}
	\vspace*{1.5in}
	
	\begin{singlespacing}
		\hspace*{-0.25in}
		\parbox{10in}{
			\noindent {\bf \@author} \\
		} 
		
	\end{singlespacing}
	\vspace*{0.25in}
	
	\noindent Place: Chennai\\
	Date: \@date 
	
	
	\setcounter{page}{0}
}

   \def\certificate{%% A preliminary chapter
     \clearpage
     \vspace*{36pt}
     \centerline{\Large \bf CERTIFICATE}
     \vskip 25pt
     \thispagestyle{empty}
     \typeout{Certificate}
     This is to certify that the report titled {\bf\@title}, submitted by {\bf\@author \hspace{1 mm}(\@roll)}, to the Indian Institute of Information Technology, Design and Manufacturing Kancheepuram, for the award of the \if@DD
     dual
     \fi degree of 
     \if@MTech
     {\bf MASTER OF TECHNOLOGY}
     \fi
     \if@BTech
     {\bf BACHELOR OF TECHNOLOGY}
     \fi
     \if@DD
     {\bf BACHELOR OF TECHNOLOGY AND MASTER OF TECHNOLOGY}
     \fi
    is a bona fide record of the work done by him/her under my supervision.  The contents of this report, in full or in parts, have not been submitted to any other Institute or University for the award of any degree or
     diploma.
     \vspace*{1.5in}
     
     \begin{singlespacing}
     	\hspace*{-0.25in}
     	\parbox{10in}{
     		\noindent {\bf \@guide} \\
     		\noindent Project Guide \\ 
     		\noindent \@guidedesignation \\
     		\noindent Department of \@guidedept \\
     		\noindent IIITDM Kancheepuram, 600 127 \\
     	} 
     	
     \end{singlespacing}
     \vspace*{0.25in}
     
     \noindent Place: Chennai\\
     Date: \@date 
     
     
     \setcounter{page}{0}
   }



   % ACKNOWLEDGEMENTS
   %
   \def\acknowledgements{\chapter*{\centerline{ACKNOWLEDGEMENTS}}
     \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
   }

   % ABSTRACT
   %   - this produces pages suitable for an IIITDM Abstract
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

   % Use the nomencl package for the NOTATION section.
   %
	\def\notation{\chapter*{\centerline{NOTATION}}
	\addcontentsline{toc}{chapter}{NOTATION}
}


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


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Renewed commands to set the titles of various pages correctly.
   \renewcommand\contentsname{\centering TABLE OF CONTENTS}
   \renewcommand\listfigurename{\centering LIST OF FIGURES}
   \renewcommand\listtablename{\centering LIST OF TABLES}
   \renewcommand{\chaptername}{CHAPTER}
   \renewcommand\bibname{\centering REFERENCES}
   \renewcommand\appendixname{APPENDIX}
\fi
