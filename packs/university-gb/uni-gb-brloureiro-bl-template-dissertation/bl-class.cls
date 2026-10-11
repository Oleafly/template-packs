% I largely benefited from ideas and code from the following templates:
% University of Cambridge Computer Science template: https://github.com/cambridge/thesis/
% Dissertate template: https://github.com/suchow/Dissertate

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bl-class}[2018/01/24 v2.0 My own class]

%%%%%%%%%%%%%%%%%%%
%% Class options %%
%%%%%%%%%%%%%%%%%%%


% Chapter option A
\newif\ifcam@chaptersA\cam@chaptersAfalse
\DeclareOption{chaptersA}{\cam@chaptersAtrue}

% Chapter option B
\newif\ifcam@chaptersB\cam@chaptersAfalse
\DeclareOption{chaptersB}{\cam@chaptersBtrue}

% Title option A
\newif\ifcam@titleA\cam@titleAfalse
\DeclareOption{titleA}{\cam@titleAtrue}

% Title option B
\newif\ifcam@titleB\cam@titleBfalse
\DeclareOption{titleB}{\cam@titleBtrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Use report as base class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\PassOptionsToClass{a4paper,12pt,twoside, openright}{report}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}



%%%%%%%%%%%%%%
%% Packages %%
%%%%%%%%%%%%%%

\RequirePackage{graphicx} % For image on title page
\RequirePackage{xcolor} % For being able to define colours
\RequirePackage{calc} % For calculating margins
\RequirePackage{setspace}  % For setting line space
\RequirePackage{microtype} % Improve text appearance
\RequirePackage{makeidx} % For the index
\RequirePackage{fancyhdr} % This pack makes the fancy headers
\RequirePackage[intoc]{nomencl} % This pack is for the nomeclature page
\RequirePackage{titlesec} % Package for fancy titles
\RequirePackage{etoolbox} % Allows to set chapter pagestyle separately 
\RequirePackage{emptypage} % No header and footer in empty pages

\RequirePackage[
        pdffitwindow=true,
        pdfpagelabels=true,
        colorlinks = true,
        pdfborder={0 0 0},
        pdfusetitle=true
    ]{hyperref} % Hyperreferences without borders


%%%%%%%%%%%%%%%%%%%
%%  Set Colours  %%
%%%%%%%%%%%%%%%%%%%
\definecolor{CamBlue}{RGB}{163, 193, 173} % Cambridge Blue
\definecolor{gray75}{gray}{0.75}

% Choose colour for citations, hyperefs  
\hypersetup{
    colorlinks,
    citecolor=CamBlue,
    filecolor=black,
    linkcolor=black,
    urlcolor=CamBlue,
}

%%%%%%%%%%%%%%%%%%
%%   Set font   %%
%%%%%%%%%%%%%%%%%%
\renewcommand\rmdefault{psb}



%%%%%%%%%%%%%%%%%%%%%
%%   Line Spacing  %%
%%%%%%%%%%%%%%%%%%%%%
\onehalfspacing  % Recomended by BOGS


%%%%%%%%%%%%%%%%%%%%%
%%   Page styles   %%
%%%%%%%%%%%%%%%%%%%%%
% Style for most of pages:
\pagestyle{fancy} % Include the ruler on the header
\fancyhf{} 
\rhead{\thepage} % Page number on upper-right corner
\fancyhead[LE]{\nouppercase\rightmark} % section info on upper-left corner but only on even pages
\lfoot{} 
\rfoot{}
\cfoot{}
\renewcommand{\headwidth}{\textwidth} % Adjust tuler to page layout

% Set special style for chapter pages: page number below, no headers
\fancypagestyle{chapt}{
\renewcommand{\headrulewidth}{0pt}
    \fancyhead[L]{}
    \fancyhead[C]{}
    \fancyhead[R]{}
    \fancyfoot[c]{\thepage}
}
\patchcmd{\chapter}{plain}{chapt}{}{}


%%%%%%%%%%%%%%%%%%%%
%% Fancy Chapters %%
%%%%%%%%%%%%%%%%%%%%
\ifcam@chaptersA
\newcommand{\hsp}{\hspace{20pt}}
\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter\hsp\textcolor{CamBlue}{$|$}\hsp}{0pt}{\Huge\bfseries}

\titleformat{name=\chapter,numberless}[hang]{\centering\Huge\bfseries}{}{0pt}{\Huge\bfseries}
% [\vspace{0.5ex}\titlerule]

\fi

\ifcam@chaptersB
%CHAPTER
\titleformat{\chapter}[display] %shape
        {\usefont{T1}{lmss}{l}{n}\huge\bfseries}    %format
        {\makebox[\linewidth][l]{\raisebox{110pt}[0pt][0pt]{\textcolor{CamBlue!25}{\usefont{T1}{lmss}{b}{n}\fontsize{80pt}{95pt}\selectfont\thechapter}}}
        {}  %default would be huge
        }   %label
        {-14ex} %sep before was -14
        {}  %before-code
        [\vspace{0.5ex}\titlerule]


\titleformat{name=\chapter,numberless}[display]
{\usefont{T1}{lmss}{b}{n}\huge\bfseries}    %format
        %{\makebox[25pt][l]{\raisebox{100pt}[0pt][0pt]{\textcolor{gray!25}{\usefont{T1}{lmss}{b}{n}\fontsize{80pt}{80pt}\selectfont\thechapter}}}
        {\makebox[10pt][l]{\raisebox{10pt}[0pt][0pt]{\textcolor{gray!25}{\usefont{T1}{lmss}{b}{n}\fontsize{10pt}{12pt}\selectfont}}}
        {}  %default would be huge
        }   %label
        {-16.8ex}   %sep
        {}  %before-code
        [\vspace{1ex}\titlerule]

\titlespacing{\chapter}
             {0pc}{*30}{*5}[0pc] %Abstand zum linken Rand |Abstand zum oberen Text | Abstand zum unteren Text | Abstand zum rechten Rand 

%SECTION
\titleformat{\section}
        {\usefont{T1}{lmss}{b}{n}\filright\Large}
        {\thesection}{1em}{}

\titlespacing{\section}
             {0pc}{*2}{*1}[0pc]

\setcounter{secnumdepth}{3}

%SUBSECTION 
\titleformat{\subsection}
        {\usefont{T1}{lmss}{b}{n}\large}
        {\thesubsection}{1em}{}

    \titlespacing{\subsection}
             {0pc}{*2}{*1}[0pc]
\fi

    
%% Page margins, taken from CS template (suitable for J.S. Wilson & Son).
%% The code below calculates the margins properly. See their template for explanations.

\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1in}

\newlength{\cam@topmargin}
\newlength{\cam@bottommargin}

\DeclareRobustCommand{\cam@calcpaperdims}[4]{%

\setlength{\oddsidemargin}{#1}        % inner margin
\setlength{\evensidemargin}{#2}       % outer margin
\setlength{\cam@topmargin}{#3}        % top margin        
\setlength{\cam@bottommargin}{#4}     % bottom margin   
\setlength{\textwidth}{\paperwidth-#1-#2}     % text takes the remaining width (210 - inner - outer)

\setlength{\marginparwidth}{\evensidemargin-8mm} 
\setlength{\marginparsep}{3mm}

% Vertical spacing
\setlength{\headheight}{5mm}      
\setlength{\headsep}{5mm}        
\setlength{\topmargin}{#3-\headheight-\headsep}

\setlength{\textheight}{\paperheight-#3-1.7\cam@bottommargin}
\setlength{\footskip}{.7\cam@bottommargin}
}

\cam@calcpaperdims{30mm}{20mm}{20mm}{20mm}


% Command to create the index page
\makeindex
\newcommand{\printthesisindex}{%
	\cleardoublepage%
	\phantomsection%
	\addcontentsline{toc}{chapter}{Index}%
	\printindex}

% Commands with data from student (college, etc)

% College
\newcommand{\@college}{}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}

% Supervisors
\newif\ifcam@supervisor\cam@supervisorfalse
\newcommand{\@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}\cam@supervisortrue}

\newif\ifcam@secondsupervisor\cam@secondsupervisorfalse
\newcommand{\@secondsupervisor}{}
\newcommand{\secondsupervisor}[1]{\renewcommand{\@secondsupervisor}{#1}\cam@secondsupervisortrue}

% Meta-data for PDF (keywords and subject)
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

\newcommand{\@subjectline}{}
\newcommand{\subjectline}[1]{\renewcommand{\@subjectline}{#1}}

% PhD submission notice (note submission date is optional)
\newcommand{\@submissionnotice}{%
This dissertation is submitted for the degree of Doctor of Philosophy%
}
\newcommand{\submissionnotice}[1]{\renewcommand{\@submissionnotice}{#1}}

% College shield
\newif\ifcam@collegeshield\cam@collegeshieldfalse
\newcommand{\@collegeshield}{}
\newcommand{\collegeshield}[1]{\renewcommand{\@collegeshield}{#1}\cam@collegeshieldtrue}


% Chapter and section ordering. 
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Here we define the title page %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Title A
\ifcam@titleA
\renewcommand{\titlepage}{
\thispagestyle{empty}

%% Here we define the different pieces of the title page %%

%% LOGO box
\newlength{\cam@logorightnudge}
\setlength{\cam@logorightnudge}{-0.5\paperwidth+12mm}
\newsavebox{\cam@logo}
\begin{lrbox}{\cam@logo}
\hspace*{\cam@logorightnudge}\includegraphics[width=73mm]{CollegeShields/CUni}
\end{lrbox}

%% THESIS TITLE box
\newsavebox{\cam@title}
\begin{lrbox}{\cam@title}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
			\Huge%
				\bfseries%
			{\@title{}}%
		\end{center}
    \end{minipage}
\end{lrbox}

%% COLLEGESHIELD box (optional):
\ifcam@collegeshield%
    \newsavebox{\cam@collegeshieldbox}
    \begin{lrbox}{\cam@collegeshieldbox}
    \includegraphics[height=20mm]{\@collegeshield}
    \end{lrbox}
\fi


%% AUTHOR&COLLEGE box
\newsavebox{\cam@authorcollege}
\begin{lrbox}{\cam@authorcollege}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
        {\large\@author{}~\\[1ex]}
        \ifcam@collegeshield%
            \vspace{2mm}{\usebox{\cam@collegeshieldbox}}\\
        \fi
        \@college{}
        \end{center}
    \end{minipage}
\end{lrbox}

%% Supervisor box
\newsavebox{\cam@supervisor}
\begin{lrbox}{\cam@supervisor}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center} 
        \ifcam@secondsupervisor%
        	\begin{tabular}{l l}
        		Supervisors: & \@supervisor{} \\
        		& \@secondsupervisor{}
        	\end{tabular}\\[1ex]
        \else\ifcam@supervisor
        Supervisor:~\@supervisor{}\\[1ex]
        \fi\fi
        \end{center}
    \end{minipage}
\end{lrbox}


%% SUBMISSION NOTICE box
\newsavebox{\cam@submitnotice}
\begin{lrbox}{\cam@submitnotice}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
            \@submissionnotice{}
        \end{center}
    \end{minipage}
\end{lrbox}

% Now calculate the exact free vertical space
\newlength{\cam@titlepagevspace}
\setlength{\cam@titlepagevspace}{\textheight%
	-\totalheightof{\usebox{\cam@logo}}%
	-\totalheightof{\usebox{\cam@submitnotice}}%
	-\totalheightof{\usebox{\cam@authorcollege}}%
	-\totalheightof{\usebox{\cam@supervisor}}%
	-\totalheightof{\usebox{\cam@title}}}


%% Fit all pieces defined above
\begin{center}
~\vspace{.02\cam@titlepagevspace}\\
{\usebox{\cam@logo}}\\
\vspace{.28\cam@titlepagevspace}
{\usebox{\cam@title}}\\
\vspace{.23\cam@titlepagevspace}
{\usebox{\cam@authorcollege}}\\
\vspace{.23\cam@titlepagevspace}
{\usebox{\cam@supervisor}}\\
\null\vfill
{\usebox{\cam@submitnotice}}
\end{center}
\hypersetup{pdfsubject={\@subjectline},pdfkeywords={\@keywords}}

\pagebreak
}
\fi

% Title B
\ifcam@titleB
\renewcommand{\titlepage}{
\thispagestyle{empty}

%% Here we define the different pieces of the title page %%

%% THESIS TITLE box
\newsavebox{\cam@title}
\begin{lrbox}{\cam@title}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
			\Huge%
				\bfseries%
			{\@title{}}%
		\end{center}
    \end{minipage}
\end{lrbox}

%% University crest box:
\newsavebox{\cam@unicrest}
\begin{lrbox}{\cam@unicrest}
    \includegraphics[height=50mm]{CollegeShields/University_Crest}
\end{lrbox}


%% AUTHOR&COLLEGE box
\newsavebox{\cam@authorcollege}
\begin{lrbox}{\cam@authorcollege}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
        {\Large\@author{}~\\[1ex]}
        %University of Cambridge\\
        \@college{}
        \end{center}
    \end{minipage}
\end{lrbox}

%% Supervisor box
\newsavebox{\cam@supervisor}
\begin{lrbox}{\cam@supervisor}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center} 
        \ifcam@secondsupervisor%
        	\begin{tabular}{l l}
        		Supervisors: & \@supervisor{} \\
        		& \@secondsupervisor{}
        	\end{tabular}\\[1ex]
        \else\ifcam@supervisor
        Supervisor:~\@supervisor{}\\[1ex]
        \fi\fi
        \end{center}
    \end{minipage}
\end{lrbox}

%% SUBMISSION NOTICE box
\newsavebox{\cam@submitnotice}
\begin{lrbox}{\cam@submitnotice}
    \begin{minipage}[c][\height][c]{.98\textwidth}
        \begin{center}
            \@submissionnotice{}
        \end{center}
    \end{minipage}
\end{lrbox}

% Now calculate the exact free vertical space
\newlength{\cam@titlepagevspace}
\setlength{\cam@titlepagevspace}{\textheight%
	-\totalheightof{\usebox{\cam@unicrest}}%
	-\totalheightof{\usebox{\cam@submitnotice}}%
	-\totalheightof{\usebox{\cam@authorcollege}}%
	-\totalheightof{\usebox{\cam@supervisor}}%
	-\totalheightof{\usebox{\cam@title}}}


%% Fit all pieces defined above
\begin{center}
~\vspace{.07\cam@titlepagevspace}\\
{\usebox{\cam@title}}\\
\vspace{.30\cam@titlepagevspace}
{\usebox{\cam@unicrest}}\\
\vspace{.20\cam@titlepagevspace}
{\usebox{\cam@authorcollege}}\\
\vspace{.25\cam@titlepagevspace}
{\usebox{\cam@supervisor}}\\
\null\vfill
{\usebox{\cam@submitnotice}}
\end{center}
\hypersetup{pdfsubject={\@subjectline},pdfkeywords={\@keywords}}

\pagebreak
}
\fi


%%%%%%%%%%%%%%%%%%%%%%
%% Dedication Page  %%
%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\dedicationpage}{
    \cleardoublepage
    \pdfbookmark{Dedication}{Dedication}
	\newpage \thispagestyle{empty} \vspace*{\fill}
	\scshape \noindent \input{frontmatter/dedication}
	\vspace*{\fill} \newpage \rm
    \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%
%% Declaration Page %%
%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\declaration}{
	\chapter*{\centering Declaration}
	\thispagestyle{empty}
	\noindent
    	\input{frontmatter/declaration}
% Leaving some space for the signature:
	\vspace{15mm}
	\begin{flushright}
		\@author{}\\
		\@date{}\\
	\end{flushright}
	\vfill
	\vspace*{\fill} \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Acknowledgement Page %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\acknowledgments}{
	\thispagestyle{empty}
	\chapter*{\centering Acknowledgments}
	\noindent
    \input{frontmatter/thanks}
	\vspace*{\fill} \newpage
}

%%%%%%%%%%%%%%%%%%
%% Summary Page %%
%%%%%%%%%%%%%%%%%%

\newcommand{\summary}{
	\thispagestyle{empty}
	\chapter*{\centering Summary}
	\noindent
    \input{frontmatter/summary}
	\vspace*{\fill} \newpage
}


%%%%%%%%%%%%%%%%%%%
%% Contents Page %%
%%%%%%%%%%%%%%%%%%%

\newcommand{\contentspage}{
    \pdfbookmark{\contentsname}{Contents}
    \tableofcontents
}
%%%%%%%%%%%%%%%%%%%%%%
%% Nomeclature Page %%
%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\insertnomenclature}{
    \input{frontmatter/nomeclature}
    \printnomenclature
    \thispagestyle{empty}
}
\makenomenclature


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&
%% List of Illustrations Page %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&

\newcommand\listofillustrations{%
    \chapter*{List of Illustrations}%
    \thispagestyle{empty}
    \phantomsection
    \addcontentsline{toc}{chapter}{List of Illustrations}%
    \section*{Tables}%
    \phantomsection
    \addcontentsline{toc}{section}{\protect\numberline{}Tables}%
    \@starttoc{lot}%
    \bigskip
    \section*{Figures}%
    \phantomsection
    \addcontentsline{toc}{section}{\protect\numberline{}Figures}%
    \@starttoc{lof}}


\newcommand{\frontmatter}{
	%\input{frontmatter/personalize}
	\titlepage
	\dedicationpage
	\declaration
	\acknowledgments
	\summary
    \contentspage
	\listofillustrations
    \insertnomenclature
}

  


