% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "IISERB.cls",
%     version         = "1.0",
%     date            = "16 January 2020",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, IISERB thesis format",
%     supported       = "Send email to sandeepaashish@hotmail.com",
%     docstring       = "Class for IISERB PhD thesis (Physics and Mathematics)."
% --------------------------------------------------------------------
% Credit to Arghya Chattopadhyay for the hard work of putting together the format. This organizes different styles/formats into a class file.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IISERB}[2020/01/16 v1.0 IISERB Class]
\LoadClass[12pt, a4paper]{book}

%========FORMAT======================================
\RequirePackage[T1]{fontenc}
\RequirePackage{times}
\RequirePackage{t1enc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage{nomencl}
\RequirePackage[toc,page]{appendix} 
\RequirePackage{glossaries}
\renewcommand{\nomname}{List of Symbols}

%====================Index Generation=============================
%Not required for IISERB format. 

%\usepackage{makeidx}




%====================== page layout (Begin)===========================
\usepackage{fancyhdr}
\usepackage{setspace}
\usepackage{emptypage}


%\usepackage[capitalize]{cleveref}
\usepackage{sectsty}  
%\chapterfont{\centering}{\large}  %{8pt}{\huge} %to make the chapter title at the centre
%\sectionfont{\large}
\usepackage[compact]{titlesec}
\titlespacing*{\chapter}{0pt}{0pt}{10pt} 
\usepackage{etoolbox}
\renewcommand{\contentsname}{Table of Contents}
%\usepackage{bm}
%\usepackage{dcolumn}% Align table columns on decimal point
\usepackage{tabularx}




%\usepackage[pdftex]{graphicx}
%usepackage{epstopdf}
\usepackage{graphicx}
%\usepackage{wrapfig}

%\renewcommand{\baselinestretch}{1.5}
\usepackage[font=normalsize,labelfont=bf]{caption}
          
\usepackage[left=1.0in,right=1.0in,top=1.0in,bottom=1.0in,%
            footskip=.25in]{geometry}        
             
%\renewcommand{\baselinestretch}{1.5}  % put 1.5 inch gap btn lines          
%\setlength{\arrayrulewidth}{0.5mm}
%\setlength{\tabcolsep}{15pt}
%\renewcommand{\arraystretch}{2.0}
%\pagenumbering{roman} 
\usepackage[x11names]{xcolor}


\usepackage[pdftitle={Title of your thesis},%
pdfauthor={Your name},%
pdfsubject={Mathematics}%
]{hyperref} %for hyperlinks and pdf's digital Data
\hypersetup{
	colorlinks=true,% Change the colours as per your wish. Keeping black and white printing in mind this particular colours are set by default.
	linkcolor=blue,
	citecolor=red,
	filecolor=black,      
	urlcolor=black,
}
\urlstyle{same}

\pagestyle{plain}
\fancyhf{}
\cfoot{\thepage}
\fancyhead[EL]{\nouppercase\leftmark}
\fancyhead[OR]{\nouppercase\rightmark}

%====================== page layout (End)===========================


%=======Extra package list for Mathematics============================

\usepackage{amssymb}
\usepackage[all]{xy}
\usepackage{nicefrac,mathtools,amsmath}
\usepackage[inline,shortlabels]{enumitem} %uncomment the next commands to change the style of list numbering.
% \setlist[enumerate,1]{label=\textup{(\arabic*)}}
% \setlist[enumerate,2]{label=\textup{(\alph*)}}
\usepackage{microtype}
\usepackage{graphicx}%for importing images and pdf

\usepackage{tikz-cd}%this package has some readymade commutative digrams
\usepackage{tikz}%for drawing diagrams

\usepackage[lite]{amsrefs}

\usepackage{amsthm}
\numberwithin{equation}{section}
\theoremstyle{plain}


%===============================================================


% ------------------------------
% Title page
% ------------------------------

\def\maketitle{
	\begin{titlepage}
		\begin{center}
		%	\begin{doublespace}
				%	\doublespacing
				{\fontfamily{qpl}\selectfont
                                 \LARGE{\textbf{\thesistitle}}}\\
				\ \\
				\ \\
			{\fontfamily{phv}\selectfont
                          \large{A thesis submitted in partial fulfilment of the requirements \\
                                 \vspace{0.2cm}
				for the award of the degree of} }\\ \vspace{1cm}
				{\fontfamily{phv}\selectfont
                                  \large{\textbf{DOCTOR OF PHILOSOPHY}}
                                  }
				\vspace{1.2cm}
				
			\large{{by}}

			\vspace{0.8cm}

				{\fontfamily{phv}\selectfont
                                \large{\textbf{\MakeUppercase{ \studentname}}} }\\
                                \vspace{0.3cm}
				{\fontfamily{bodoni-mt-condensed}\selectfont
				\bf{\studentrollno} }\\
				%\normalsize{\textit{Under the guidance of}} \\
				%\large{\textbf{\MakeUppercase{\advisorname}}}
		%	\end{doublespace}
			%\vfill
                         \vspace{1.8cm}
			\centerline{\includegraphics[width=4cm]{iiserb_logo.png}}
			\bigskip
			
			
			
			\large{to the}\\ \vspace{0.5cm}
			{\fontfamily{phv}\selectfont
                            \large{DEPARTMENT OF \MakeUppercase{\subject} }\\ 
                                  \vspace{0.5cm}
                              {\fontfamily{Bodoni-MT-Condensed}\selectfont
			       \bf{\large{{\mbox{\bfseries  INDIAN INSTITUTE OF SCIENCE EDUCATION AND} \\RESEARCH BHOPAL}}}\\ %Flows onto two lines
				\normalsize{Bhopal -- 462066}}} \\ 
			\ \\
                        {\fontfamily{Bodoni-MT-Condensed}\selectfont  
			{\thesisdate}}
		\end{center}
	\end{titlepage}
}


%=========================================================================


%%%% toc %%%%
\usepackage{tocloft}
\setlength{\cftchapnumwidth}{2.25cm}
\renewcommand{\cftchappresnum}{Chapter~}
\renewcommand{\cftchapaftersnum}{:~~}
\renewcommand{\cftchapaftersnumb}{}

%%%%% Chapter titles  %%%%%%%%%%%%

\newcommand*{\justifyheading}{\center}%
\titleformat{\chapter}[display]{\normalfont\large\bfseries\justifyheading}{CHAPTER~\large\thechapter}%
{10pt}{\normalfont \bfseries \Large \MakeUppercase}%
  \titlespacing*{\chapter}{0pt}{-50pt}{40pt}

 
