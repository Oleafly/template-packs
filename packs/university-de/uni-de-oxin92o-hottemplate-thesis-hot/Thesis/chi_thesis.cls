\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chi_thesis}[2017/07/16 LUH CHI Bachelor/Master Arbeit.]

%% OK zu der Klasse, der Veränderung des Schlosses und dem Design des Titelblattes am 15.08.2017 mündlich von Frau Ittmann bekommen.
%% Frau von Münchhausen hat nicht widersprochen, damit dürfte man sie bedenkenlos verwenden können.

\LoadClass[a4paper,oneside,11pt]{book}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[german,english]{babel}
\RequirePackage{listings}
\lstset{captionpos=b,frame=single}
\RequirePackage[absolute]{textpos}
\RequirePackage{color}
\definecolor{LUHBLUE}{RGB}{0,80,155}

\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{booktabs}
\RequirePackage{threeparttable}
\RequirePackage{tikz}
\usetikzlibrary{positioning, shapes, arrows, calc, chains, scopes}
\RequirePackage{notoccite}
\RequirePackage{enumerate}
\RequirePackage{enumitem}
\RequirePackage{float}
\RequirePackage{blindtext}


%% 1.5 facher Zeilenabstand.
\RequirePackage[onehalfspacing]{setspace}

\RequirePackage{geometry}
\geometry{a4paper,left=35mm,right=25mm, top=2.5cm, bottom=2.5cm}

\RequirePackage{amssymb}							% provides mathmatical math symbols such as dots, arrows, etc.
\RequirePackage{amsmath}							% provides align environment

\RequirePackage{wrapfig}

%for figures
\RequirePackage{graphicx}
\RequirePackage{subfigure}
%%%%%%%%%%%%%%%%%%%%%%%%%% Befehle und Variablen zum ausfüllen des Templates %%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\TITLE}{Das Universum und der ganze Rest}
\newcommand{\AUTHOR}{Muster Mustermann}
\newcommand{\KEYWORDS}{Anhalter}
\newcommand{\LOGO}{logo_hot}
\newcommand{\FACULTY}{Faculty of Mechanical Engineering}
\newcommand{\INSTITUTION}{Hannover Centre for Optical Technologies}
\newcommand{\FIRSTPROF}{Prof. Dr. }
\newcommand{\FIRSTPROFNAME}{1st. Examiner}
\newcommand{\SECONDPROF}{Prof. Dr. }
\newcommand{\SECONDPROFNAME}{2nd. Examiner}
\newcommand{\THIRDPROF}{Prof. Dr. }
\newcommand{\THIRDPROFNAME}{3rd. Examiner}
\newcommand{\BETREUER}{Dr. }
\newcommand{\BETREUERNAME}{Supervisor}
\newcommand{\DATE}{\today}
\newcommand{\ART}{Master Thesis}
\newcommand{\STUDIENGANG}{M.Sc.}
\newcommand{\MATNUMM}{1234567}
\newcommand{\TITLETEXT}{\ART \ in Degree Programme  \STUDIENGANG , \\
submitted by \MakeUppercase{\AUTHOR}  on \DATE}
\newcommand{\kws}[1]
{
  \small	
  \textbf{\textit{Keywords: }} #1
}


\renewcommand{\title}[1]{\renewcommand{\TITLE}{#1} \hypersetup{pdftitle={#1}}}
\renewcommand{\author}[1]{\renewcommand{\AUTHOR}{#1} \hypersetup{pdfauthor={#1}}}
\newcommand{\keywords}[1]{\renewcommand{\KEYWORDS}{#1} \hypersetup{pdfsubject={#1}}}
\newcommand{\logo}[1]{\renewcommand{\LOGO}{#1}}
\newcommand{\faculty}[1]{\renewcommand{\FACULTY}{#1}}
\newcommand{\institution}[1]{\renewcommand{\INSTITUTION}{#1}}
\newcommand{\firstprof}[1]{\renewcommand{\FIRSTPROF}{#1}}
\newcommand{\firstprofname}[1]{\renewcommand{\FIRSTPRONAME}{#1}}
\newcommand{\secondprof}[1]{\renewcommand{\SECONDPROF}{#1}}
\newcommand{\secondprofname}[1]{\renewcommand{\SECONDPROFNAME}{#1}}
\newcommand{\thirdprof}[1]{\renewcommand{\THIRDPROF}{#1}}
\newcommand{\thirdprofname}[1]{\renewcommand{\THIRDPROFNAME}{#1}}
\newcommand{\betreuer}[1]{\renewcommand{\BETREUER}{#1}}
\newcommand{\betreuername}[1]{\renewcommand{\BETREUERNAME}{#1}}
\renewcommand{\date}[1]{\renewcommand{\DATE}{#1}}
\newcommand{\art}[1]{\renewcommand{\ART}{#1}}
\newcommand{\studiengang}[1]{\renewcommand{\STUDIENGANG}{#1}}
\newcommand{\titletext}[1]{\renewcommand{\TITLETEXT}{#1}}
\newcommand{\matrikelnummer}[1]{\renewcommand{\MATNUMM}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Formatierung von Chapter und sections %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{\oldmainmatter
\titleformat{\chapter}[display]
{\normalsize \huge \color{black} }%\ThisULCornerWallPaper{}{test}}%chapter\thechapter}}
{\flushright \normalsize \color{LUHBLUE} \MakeUppercase { \chaptertitlename } \hspace{1 ex} %
	{ \color{LUHBLUE} \fontsize{84}{84}\selectfont \thechapter }}
{10 pt}
{\flushright\huge}%\colorbox{LUHBLUE}}
[\vspace*{4pc}%
\startcontents
\small \printcontents{l}{1}{\setcounter{tocdepth}{2}}]
\renewcommand{\headrulewidth}{0.4pt}
\fancyhead[OR]{\fontfamily{phv}\selectfont \rightmark}
\fancyhead[EL]{\fontfamily{phv}\selectfont \leftmark}
}

\titleformat{\section}
{\LARGE\sffamily\slshape}
{\color{LUHBLUE} \thesection}{4mm}{}

\titlespacing{\section}
{-12mm}{3.5ex}{1.5ex}


\titleformat{\subsection}
{\large\sffamily\slshape}
{\color{LUHBLUE} \thesubsection}{4mm}{}

\titlespacing{\subsection}
{0mm}{3ex}{1ex}


\titleformat{\subsubsection}
{\large\sffamily\slshape}
{\color{LUHBLUE} \thesubsubsection}{4mm}{}

\titlespacing{\subsubsubsection}
{0mm}{3ex}{1ex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ende der Formatierung von Chapter und sections %%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%% Fancy reference system %%%%%%%%%%%%
\RequirePackage[english,german]{fancyref}

%% for fancy refereing to listings.
\newcommand*{\fancyreflstlabelprefix}{lst}

\fancyrefaddcaptions{english}{%
  \providecommand*{\freflstname}{listing}%
  \providecommand*{\Freflstname}{Listing}%
}

\fancyrefaddcaptions{english}{%
  \providecommand*{\freflstname}{Codebeispiel}%
  \providecommand*{\Freflstname}{Codebeispiel}%
}

\frefformat{plain}{\fancyreflstlabelprefix}{\freflstname\fancyrefdefaultspacing#1}
\Frefformat{plain}{\fancyreflstlabelprefix}{\Freflstname\fancyrefdefaultspacing#1}

\frefformat{vario}{\fancyreflstlabelprefix}{%
  \freflstname\fancyrefdefaultspacing#1#3%
}
\Frefformat{vario}{\fancyreflstlabelprefix}{%
  \Freflstname\fancyrefdefaultspacing#1#3%
}
%%%%%%%%%%%%% End of fance reference %%%%%%%%%%%%%%

% Metadaten
\RequirePackage[
	colorlinks=true,
	linkcolor=black,						% enable for printing!
	urlcolor=black,						  % enable for printing!
	citecolor=black,						% enable for printing!
	%pdfstartview=Fit,						% fits the page to the window; other options: FitH/FitV (horiz./vert.)...
	%pdfpagelayout=TwoPageLeft,		% the way pages are displayed, options: SinglePage, OneColumn, TwoColumnLeft|Right, TwoPageLeft|Right
	final=true,									% turn on all processing options
	plainpages=false,						% Forces page anchors to be named by the arabic form of the page number, rather than the formatted form.
	pdfpagelabels]							% set PDF page labels
	{hyperref}

\RequirePackage{graphicx}
% sorgt dafür, dass LaTeX in images nach den Bildern sucht und der Ordner "etwas" aufgeräumter ist.
\graphicspath{ {./images/} {./graphics/} }


\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{} % sets both header and footer to nothing
\renewcommand{\headrulewidth}{0pt}
\parindent 0pt

\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
\fontfamily{phv}\selectfont


\setlength{\headheight}{13.6pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TITELSEITE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\Titlepage}{\newgeometry{left=3cm,right=4cm, top=3cm, bottom=3.5cm}
\begin{titlepage}

%
% Logos
%

\begin{textblock*}{176mm}(26mm,9mm)
    \includegraphics[height=17mm]{\LOGO} \hfill{}
    \includegraphics[height=17mm]{logo_luh}
\end{textblock*}


\begin{textblock*}{135mm}(26mm,58mm)
\Large
\FACULTY

\vspace{3mm}

\INSTITUTION
\end{textblock*}


\begin{textblock*}{135mm}(26mm,90mm)
\huge{ \color{LUHBLUE} \bf \TITLE}
\end{textblock*}

\begin{textblock*}{135mm}(26mm,178mm)
\TITLETEXT
\end{textblock*}


\begin{textblock*}{135mm}(24mm,195mm)
\noindent\begin{tabular}{p{30mm}l}
\FIRSTPROFNAME: & \FIRSTPROF\\
\SECONDPROFNAME:  & \SECONDPROF\\
\THIRDPROFNAME:  & \THIRDPROF\\
\BETREUERNAME:     & \BETREUER\\
Matric- Number: & \MATNUMM\\
\end{tabular}
\end{textblock*}

\begin{textblock*}{165mm}(25mm,220mm)
    \includegraphics[width=165mm]{welfenschloss}
\end{textblock*}

\qquad
\end{titlepage}
\restoregeometry
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ende der TITELSEITE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% Erklärung der Selbstständigkeit %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\SELBSTAENDIGKEIT}{
\newgeometry{left=4.5cm,right=3.5cm, top=4cm, bottom=2cm}
\setcounter{page}{1}
\section*{Declaration of Academic Integrity}
Hereby, I declare that I have composed the presented paper independently on my own and without any other resources than the ones indicated. All thoughts taken directly or indirectly from external sources are properly denoted as such.\\
This paper has neither been previously submitted to another authority nor has it been published yet.

\vspace{3cm}


\rule{6cm}{0.4pt} \hfill Hanover, on \DATE\\
\AUTHOR
\vspace{5cm}

\section*{Declaration on the plagiarism check}

I agree to submit my work to external plagiarism checking services to conduct plagiarism check.

\vspace{3cm}


\rule{6cm}{0.4pt} \hfill Hanover, on \DATE\\
\AUTHOR

\restoregeometry
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ende der Erklärung der Selbständigkeit %%%%%%%%%%%%%%%%%%%%%%%%%%%%
