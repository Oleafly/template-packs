% ----------------------------------------------------------------------------
% FIM thesis
% ----------------------------------------------------------------------------
% převzato z VUT FIT šablony https://cs.overleaf.com/latex/templates/fit-but-thesis-template-2019/mmphstqxpwpg
% Autoři / Authors: Michal Dobrovolný
% ----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fim-uhk-thesis}[2020/10/01 Sablona pro BP/DP/DIS]

%Vychozi hodnoty parametru / Default values for parameters
\newif\ifczech \let\ifczech\iftrue
\newif\ifslovak \let\ifslovak\iffalse
\newif\ifenslovak \let\ifenslovak\iffalse
\newif\ifenglish \let\ifenglish\iffalse
\newif\ifczechslovak \let\ifczechslovak\iftrue

\newif\ifzadani   \let\ifzadani\iffalse
\newif\iftwoside   \let\iftwoside\iffalse
\newif\ifoneside   \let\ifoneside\iftrue

%-----------------------------------------------------------------------------
% Parametry tridy (odkomentovani zakomentovanych na vlastni nebezpeci)
% Class parameters (uncommenting of commented one is only on your own risk)
%-----------------------------------------------------------------------------
\DeclareOption{english}{\let\ifenglish\iftrue\let\ifczech\iffalse\let\ifczechslovak\iffalse}
\DeclareOption{slovak}{\let\ifslovak\iftrue\let\ifczech\iffalse}
\DeclareOption{enslovak}{\let\ifenslovak\iftrue}
\DeclareOption{print}{\let\ifWis\iffalse \let\ifPrint\iftrue}
\DeclareOption{zadani}{\let\ifzadani\iftrue}
\DeclareOption{twoside}{\let\ifoneside\iffalse \let\iftwoside\iftrue}

\DeclareOption*{}
\ProcessOptions\relax
%Jako vychozi pouzijeme tridu REPORT / We will use REPORT class as a base
\iftwoside
    \LoadClass[a4paper,twoside,onecolumn,11pt]{article}
\fi
\ifoneside
    \LoadClass[a4paper,oneside,onecolumn,11pt]{article}
\fi

%-----------------------------------------------------------------------------
% Balicky / Packages
%-----------------------------------------------------------------------------
\ifenglish
  \PassOptionsToPackage{main=english}{babel}
\fi
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage[czech,slovak,english]{babel}
\usepackage[utf8]{inputenc} %kodovani / encoding
\usepackage{cmap}
\usepackage[T1]{fontenc}
\usepackage{url}
\usepackage{ragged2e}
\usepackage{color}
\usepackage{etoolbox}
\usepackage{enumitem}
\usepackage{pdfpages}
\addto\captionsczech{\renewcommand{\refname}{Literatura}}
\addto\captionsslovak{\renewcommand{\refname}{Literatúra}}

\usepackage{titlesec}
\newcommand{\sectionbreak}{\clearpage}

\usepackage{setspace}
\setstretch{1.5}

\ifczech
  \main@language{czech}
\else
  \ifslovak
    \main@language{slovak}
  \else
    \main@language{english}
  \fi
\fi
% \ifx\pdfoutput\undefined  % nejedeme pod pdftexem / we are not using pdftex
  \usepackage{graphics}
  \usepackage{epsfig}
% \else % je to pdftex ! / it is pdftex !
    % \usepackage[]{graphicx}
% \fi

\newtoggle{slovak_used}
\togglefalse{slovak_used}

\ifslovak
  \toggletrue{slovak_used}
\fi

\newtoggle{english_used}
\togglefalse{english_used}

\ifenglish
  \toggletrue{english_used}
\fi

\newtoggle{enslovak_used}
\togglefalse{enslovak_used}

\ifenslovak
  \toggletrue{enslovak_used}
\fi

\newtoggle{czech_used}
\togglefalse{czech_used}

\ifczech
  \toggletrue{czech_used}
\fi

\newtoggle{czechslovak}
\togglefalse{czechslovak}
\ifczech
  \toggletrue{czechslovak}
\fi
\ifslovak
  \toggletrue{czechslovak}
\fi

\newtoggle{zadaniTwop}
\togglefalse{zadaniTwop}
\iftwoside
  \toggletrue{zadaniTwop}
\fi
\iftoggle{zadaniTwop}{
  \ifzadani
    \toggletrue{zadaniTwop}
  \else
    \togglefalse{zadaniTwop}
  \fi
}{}


%-----------------------------------------------------------------------------
% Sazebni obrazec / Page layout
%-----------------------------------------------------------------------------
\iftwoside
%  \usepackage[left=3.46cm, text={15.2cm,23.47cm}, top=2.5cm, marginparwidth=50pt]{geometry}
  \usepackage[a4paper]{geometry}
  \newgeometry{left=3.46cm, text={15.2cm,23.47cm}, top=2.5cm, marginparwidth=50pt}
\else
  \setlength{\hoffset}{-0.7cm}
  \setlength{\voffset}{-1.5cm}
  \setlength{\textheight}{23.0cm}
  \setlength{\textwidth}{15.2cm}
\fi

\setlength\parindent{17\p@}
\setlength{\parskip}{0pt}


%-----------------------------------------------------------------------------
% Texty / Texts
%-----------------------------------------------------------------------------
\def\@uhk@CS{Univerzita Hradec~Králové}
\def\@uhk@SK{Univerzita Hradec~Králové}
\def\@uhk@EN{University of Hradec~Králové}
\def\@author@CS{Autor práce}
\def\@author@SK{Autor práce}
\def\@author@EN{Author}
\def\@authorfield@CS{Studijní obor}
\def\@authorfield@SK{Študijný odbor}
\def\@authorfield@EN{Field of study}
\def\@annotation@CS{Anotace}
\def\@annotation@SK{Anotace}
\def\@annotation@EN{Anotation}
\def\@keywords@CS{Klíčová slova}
\def\@keywords@SK{Kľúčové slová}
\def\@keywords@EN{Keywords}
\def\@cite@CS{Citace}
\def\@cite@SK{Citácia}
\def\@cite@EN{Reference}
\def\@tdecl@CS{Prohlášení}
\def\@tdecl@SK{Prehlásenie}
\def\@tdecl@EN{Declaration}
\def\@tackn@CS{Poděkování}
\def\@tackn@SK{Poďakovanie}
\def\@tackn@EN{Acknowledgements}
\def\@titletitle@EN{Title}

\newif\ifnasel
\def\ifEqString#1#2#3#4{\def\testa{#1}\def\testb{#2}%
  \ifx\testa\testb \def#4{#3} \naseltrue \fi%
}

%Vyber typu projektu / project type selection
\newcommand{\set@project}[1]{%
 \naselfalse
 \ifEqString{#1}{BP}{Bakalářská práce}{\@projecttype@CS}%
\ifEqString{#1}{BP}{Bakalárska práca}{\@projecttype@SK}%
%  \ifEqString{#1}{BP}{Bakalářská práce}{\@projecttype@SK}%
 \ifEqString{#1}{BP}{Bachelor's thesis}{\@projecttype@EN}%
 \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{BP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{BP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{SP}{Semestrální projekt}{\@projecttype@CS}%
\ifEqString{#1}{SP}{Semestrálny projekt}{\@projecttype@SK}%
%  \ifEqString{#1}{SP}{Semestrální projekt}{\@projecttype@SK}%
 \ifEqString{#1}{SP}{Term project}{\@projecttype@EN}%
 \ifEqString{#1}{SP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{SP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{SP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DP}{Diplomová práce}{\@projecttype@CS}%
\ifEqString{#1}{DP}{Diplomová práca}{\@projecttype@SK}%
%  \ifEqString{#1}{DP}{Diplomová práce}{\@projecttype@SK}%
 \ifEqString{#1}{DP}{Master's thesis}{\@projecttype@EN}%
 \ifEqString{#1}{DP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{DP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{DP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{DP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DR}{Disertační práce}{\@projecttype@CS}%
\ifEqString{#1}{DR}{Dizertačná práca}{\@projecttype@SK}%
%  \ifEqString{#1}{DR}{Disertační práce}{\@projecttype@SK}%
 \ifEqString{#1}{DR}{PhD thesis}{\@projecttype@EN}%
 \ifEqString{#1}{DR}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DR}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DR}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DR}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DA}{Teze disertační práce -- autoreferát}{\@projecttype@CS}%
\ifEqString{#1}{DA}{Tézy dizertačnej práce -- autoreferát}{\@projecttype@SK}%
%  \ifEqString{#1}{DA}{Teze disertační práce -- autoreferát}{\@projecttype@SK}%
 \ifEqString{#1}{DA}{PhD thesis summary}{\@projecttype@EN}%
 \ifEqString{#1}{DA}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DA}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DA}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DA}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DT}{Pojednání k tématu disertační práce}{\@projecttype@CS}%
% \ifEqString{#1}{DT}{Teze disertační práce}{\@projecttype@CS}%
\ifEqString{#1}{DT}{Pojednanie k téme dizertačnej práce}{\@projecttype@SK}%
%  \ifEqString{#1}{DT}{Pojednání k tématu disertační práce}{\@projecttype@SK}%
 \ifEqString{#1}{DT}{PhD thesis proposal}{\@projecttype@EN}%
 \ifEqString{#1}{DT}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DT}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DT}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DT}{Supervisor}{\@supervisor@EN}%
 \ifnasel
 \else
   \typeout{Spatny typ projektu! Moznosti: BP, SP, DP, DR, DT, DA}\set@project{BP}
 \fi
}

%Vyber fakulty / faculty selection TODO
\newcommand{\set@faculty}[3]{%
 \naselfalse
 \ifEqString{#1}{FIM}{Fakulta informatiky a managementu}{\@fim@CS}%
 \ifEqString{#1}{FIM}{Fakulta informatiky a managementu}{\@fim@SK}%
 \ifEqString{#1}{FIM}{Faculty of Informatics and Management}{\@fim@EN}%
 \ifEqString{#1}{DEF}{#2}{\@fim@CS}%
 \ifEqString{#1}{DEF}{#2}{\@fim@SK}%
 \ifEqString{#1}{DEF}{#3}{\@fim@EN}%
 \ifnasel
 \else
   \typeout{Spatna fakulta! Moznosti: FIM, DEF}\set@faculty{FIM}
 \fi
}

%Vyber ustavu / department selection
\newcommand{\set@department}[3]{%
 \naselfalse
 \ifEqString{#1}{KIT}{Katedra Informačních Technologií}{\@department@CS}
 \ifEqString{#1}{KIT}{Katedra Informačních Technologií}{\@department@SK}
 \ifEqString{#1}{KIT}{Department of Information Technology}{\@department@EN}
 \ifEqString{#1}{DEF}{#2}{\@department@CS}
 \ifEqString{#1}{DEF}{#2}{\@department@SK}
 \ifEqString{#1}{DEF}{#3}{\@department@EN}
 \ifnasel
 \else
   \typeout{Spatny ustav! Moznosti: KIT, DEF}\set@department{KIT}
 \fi
}

%Nazev ustavu (CS, SK, EN) / name of the department
\def\@departmentname@CS{\@department@CS}
\def\@departmentname@SK{\@department@SK}
\def\@departmentname@EN{\@department@EN}

%Nazev prace (v jazyce prace) / thesis title (in the language of the thesis)
\iftoggle{slovak_used}{
  \def\@title{\@title@CS}
}{
  \def\@title{\ifczech\@title@CS\else\@title@EN\fi}
}

%Jmeno, prijmeni, tituly autora / name surname and the titles of the author
\def\get@author{\ifx\undefined\@author@tp\else%
\@author@tp~\fi\@author\ifx\undefined\@author@ta\else,~\@author@ta\fi}
\def\getlc@author{\ifx\undefined\@author@tp\else%
\@author@tp~\fi\@author\ifx\undefined\@author@ta\else,~\@author@ta\fi}
%Jmeno, prijmeni, tituly vedouciho / name surname and the titles of the supervisor
\def\get@supervisor{\ifx\undefined\@supervisor@tp\else%
\@supervisor@tp~\fi\@supervisor\ifx\undefined\@supervisor@ta\else,~\@supervisor@ta\fi}

%-----------------------------------------------------------------------------
% Projectinfo - parametrizace sablony / template parameters
%-----------------------------------------------------------------------------
%Parametry 
\define@key{projinfo}{title.cs}{\global\def\@title@CS{#1}}
\define@key{projinfo}{title.en}{\global\def\@title@EN{#1}}
\define@key{projinfo}{faculty.cs}{\def\@faculty@CS{#1}}
\define@key{projinfo}{faculty.en}{\def\@faculty@EN{#1}}
\define@key{projinfo}{faculty}{\set@faculty{#1}{\@faculty@CS}{\@faculty@EN}}
\define@key{projinfo}{department.cs}{\def\@departmentn@CS{#1}}
\define@key{projinfo}{department.en}{\def\@departmentn@EN{#1}}
\define@key{projinfo}{department}{\set@department{#1}{\@departmentn@CS}{\@departmentn@EN}}
\define@key{projinfo}{project}{\set@project{#1}}
\define@key{projinfo}{year}{\def\@year{#1}}
\define@key{projinfo}{date}{\def\@date{#1}}
% \define@key{projinfo}{author}{\def\@author{#1}}
\define@key{projinfo}{author.name}{\def\@author@n{#1}}
\define@key{projinfo}{author.surname}{\def\@author@s{#1}}
\define@key{projinfo}{author.field}{\def\@author@field{#1}}
\define@key{projinfo}{author.title.a}{\def\@author@ta{#1}}
\define@key{projinfo}{author.title.p}{\def\@author@tp{#1}}
\define@key{projinfo}{supervisor.name}{\def\@supervisor@n{#1}}
\define@key{projinfo}{supervisor.surname}{\def\@supervisor@s{#1}}
\define@key{projinfo}{supervisor.title.a}{\def\@supervisor@ta{#1}}
\define@key{projinfo}{supervisor.title.p}{\def\@supervisor@tp{#1}}
\define@key{projinfo}{keywords.cs}{\def\@tkeywords@CS{#1}}
\define@key{projinfo}{keywords.en}{\def\@tkeywords@EN{#1}}
\define@key{projinfo}{annotation.cs}{\def\@tannotation@CS{#1}}
\define@key{projinfo}{annotation.en}{\def\@tannotation@EN{#1}}
\define@key{projinfo}{declaration}{\def\@declaration{#1}}
\define@key{projinfo}{acknowledgment}{\def\@acknowledgment{#1}}
\define@key{projinfo}{title.length}{\def\@titlelen{#1}}
\define@key{projinfo}{sectitle.length}{\def\@sectitlelen{#1}}

%Vychozi hodnoty / Default values
\setkeys{projinfo}{
  title.cs=Název práce (česky),
  title.en=Název práce (anglicky), 
  project=BP, 
  department=KIT, 
  declaration=, 
  annotation.cs=, 
  annotation.en=, 
  keywords.cs=, 
  keywords.en=,
  author.name=Jméno, 
  author.surname=Příjmení, 
  author.field=, 
  supervisor.name=Jméno,
  supervisor.surname=Příjmení, 
  department.cs=,
  department.en=,
  title.length=,
  sectitle.length=,
  faculty.cs=,
  faculty.en=,
  faculty=FIM
}%projinfo

\def\projectinfo{\setkeys{projinfo}}

\def\@author{\@author@n\ \@author@s}
\def\@supervisor{\@supervisor@n\ \@supervisor@s}

%Prohlaseni / Declarationf
\newcommand{\declaration}[1]{\def\@declaration{#1}}

%Podekovani / Acknowledgement
\newcommand{\acknowledgment}[1]{\def\@acknowledgment{#1}}

%Anotace / annotation
\newcommand{\annotation}[2][cs]{%
 \ifEqString{#1}{cs}{#2}{\@tannotation@CS}%
 \ifEqString{#1}{sk}{#2}{\@tannotation@SK}%
 \ifEqString{#1}{en}{#2}{\@tannotation@EN}%
}

%Klicova slova / Keywords
\newcommand{\keywords}[2][cs]{%
 \ifEqString{#1}{cs}{#2}{\@tkeywords@CS}%
 \ifEqString{#1}{sk}{#2}{\@tkeywords@SK}%
 \ifEqString{#1}{en}{#2}{\@tkeywords@EN}%
}

%Délka titulku / Title length
\newcommand{\titlelength}[1]{%
 \def\@titlelen{#1}%
}

%Délka druhého titulku / Second title length
\newcommand{\sectitlelength}[1]{%
 \def\@sectitlelen{#1}%
}

\newlength{\mkspc}
\setlength{\mkspc}{2pt}

\def\setfontsize#1{\renewcommand{\baselinestretch}{1.5}\fontsize{#1}{\f@baselineskip}\selectfont}
%text
\newcommand{\mktxt}[2]{\vbox{\setfontsize{#1}\noindent#2}\vspace\mkspc}
%text pro titulní list / text for title page
\newcommand{\mktxtt}[2]{\vbox{\setfontsize{#1}\fosfamily\bfseries\noindent#2}\vspace\mkspc}
%text pro desky / text for cover
\newcommand{\mktxtc}[2]{\vbox{\setfontsize{#1}\fosfamily\bfseries\noindent#2}\vspace\mkspc}
\newcommand{\mktxtcn}[2]{\vbox{\setfontsize{#1}\fosfamily\noindent#2}\vspace\mkspc}
%všechna velká / uppercase
\newcommand{\mkuctxt}[2]{\vbox{\setfontsize{#1}\noindent\MakeUppercase{#2}}\vspace\mkspc}
\newcommand{\mkuctxtt}[2]{\vbox{\setfontsize{#1}\fosfamily\bfseries\noindent\MakeUppercase{#2}}\vspace\mkspc}
% Pro název práce na 2 řádky / For the 2-line thesis title
\newcommand{\mkuctxttl}[3]{\vbox to 1.2cm{\noindent\parbox{#2}{\setfontsize{#1}\fosfamily\bfseries\noindent\MakeUppercase{#3}}}\vspace\mkspc}
% Pro 2. název práce na 2 řádky / For the 2-line second thesis title
\newcommand{\mkuctxttls}[3]{\vbox to 1.0cm{\noindent\parbox{#2}{\setfontsize{#1}\fosfamily\bfseries\noindent\baselineskip=13pt\MakeUppercase{#3}}}\vspace\mkspc}
\newcommand{\mkuctxtc}[2]{\vbox{\setfontsize{#1}\fosfamily\bfseries\noindent\MakeUppercase{#2}}\vspace\mkspc}
%bold
\newcommand{\mktxt@b}[2]{\vbox{\setfontsize{#1}\noindent\bf#2}\vspace\mkspc}
%bold pro titulní list / bold for title page
\newcommand{\mktxtt@b}[2]{\vbox{\setfontsize{#1}\fosfamily\bfseries\noindent\bf#2}\vspace\mkspc}

%-----------------------------------------------------------------------------
% Anotace, klicova slova \makeannotation
% annotation, keywords \makeannotation
%-----------------------------------------------------------------------------
\newcommand\makeannotation{%
\thispagestyle{empty}\null%

\ifczech
\mktxt@b{16}{\@annotation@CS}\noindent\@tannotation@CS
\else
  \ifslovak
    \mktxt@b{16}{\@annotation@SK}\noindent\@tannotation@CS
  \else
    \mktxt@b{16}{\@annotation@EN}\noindent\@tannotation@EN
  \fi
\fi

\vspace{5cm}

\iftoggle{czech_used}{
    \mktxt@b{16}{\@annotation@EN}
    \vspace{5mm}
        \mktxtc{14}{\@titletitle@EN: \@title@EN}
    \vspace{5mm}
    \noindent\@tannotation@EN
}{
  \ifslovak
    \mktxt@b{16}{\@annotation@EN}
        \noindent\mktxtc{14}{\@title@EN}
        \mbox{}
    \noindent\@tannotation@EN
  \else
    \ifenslovak
      \mktxt@b{16}{\@annotation@SK}
        \noindent\mktxtc{14}{\@title@EN}
        \mbox{}
      \noindent\@tannotation@CS
    \else
      \mktxt@b{16}{\@annotation@CS}
        \noindent\mktxtc{14}{\@title@EN}
        \mbox{}
      \noindent\@tannotation@CS
    \fi
  \fi
}

\vfill

% \ifczech
% \mktxt@b{16}{\@keywords@CS}\noindent\@tkeywords@CS
% \else
%   \ifslovak
%     \mktxt@b{16}{\@keywords@SK}\noindent\@tkeywords@CS
%   \else
%     \mktxt@b{16}{\@keywords@EN}\noindent\@tkeywords@EN
%   \fi
% \fi

% \vfill

% \iftoggle{czech_used}{
% \mktxt@b{16}{\@keywords@EN}\noindent\@tkeywords@EN
% }{
%   \ifslovak
%     \mktxt@b{16}{\@keywords@EN}\noindent\@tkeywords@EN
%   \else
%     \ifenslovak
%       \mktxt@b{16}{\@keywords@SK}\noindent\@tkeywords@CS
%     \else
%       \mktxt@b{16}{\@keywords@CS}\noindent\@tkeywords@CS
%     \fi
%   \fi
% }

% \vfill

% \mktxt@b{16}{\ifslovak\@cite@SK\else\ifczech\@cite@CS\else\@cite@EN\fi\fi}
% \iftoggle{slovak_used}{
%   \noindent\MakeUppercase{\@author@s}, \@author@n. \it\@title\rm. Hradec Králové, \@year. \@projecttype@SK. \@uhk@SK, \@fim@SK. {\@supervisor@SK} {\ifx\undefined\@supervisor@tp\else\@supervisor@tp ~\fi}{\@supervisor@n} {\@supervisor@s}{\ifx\undefined\@supervisor@ta\else,~\@supervisor@ta\fi}
% }{
%   \noindent\MakeUppercase{\@author@s}, \@author@n. \it\@title\rm. Hradec Králové, \@year. \ifczech\@projecttype@CS\else\@projecttype@EN\fi. \ifczech\@uhk@CS\else\@uhk@EN\fi, \ifczech\@fim@CS\else\@fim@EN\fi. {\ifczech\@supervisor@CS\else\@supervisor@EN\fi} {\ifx\undefined\@supervisor@tp\else\@supervisor@tp ~\fi}{\@supervisor@n} {\@supervisor@s}{\ifx\undefined\@supervisor@ta\else,~\@supervisor@ta\fi}
% }
%===================================================
\newpage

}

%-----------------------------------------------------------------------------
% Prohlaseni, podekovani \makedeclaration
% Declaration, acknowledgement \makedeclaration
%-----------------------------------------------------------------------------
\newcommand\makedeclaration{
\thispagestyle{empty}%

\mbox{}
\vfill

% \vspace{10mm}
\ifslovak
  \mktxt@b{16}{\@tdecl@SK}
\else
  \mktxt@b{16}{\ifczech\@tdecl@CS\else\@tdecl@EN\fi}
\fi

\noindent\@declaration

  \begin{flushright}
      \makebox[4cm]{\dotfill} \\
      \@author\\
      \@date
  \end{flushright}

\newpage
\thispagestyle{empty}%

\mbox{}
\vfill

\ifx\undefined\@acknowledgment
\else
\vspace{20mm}
\ifslovak
  \mktxt@b{16}{\@tackn@SK}
\else
  \mktxt@b{16}{\ifczech\@tackn@CS\else\@tackn@EN\fi}
\fi
\noindent\@acknowledgment
\fi

%===================================================

\newpage
\thispagestyle{empty}%
\mbox{}

\newpage

}

%-----------------------------------------------------------------------------
% Uvodni stranky \maketitle
% Introductory pages \maketitle
%-----------------------------------------------------------------------------
\renewcommand\maketitle{%
\thispagestyle{empty}\null%
\iftwoside
  \pagestyle{empty}\null%
\fi

\setlength\parindent{17\p@}
\setlength{\parskip}{0pt}

%=====================================================
\fontfamily{qhv}\selectfont%


  
\begin{center}
    \ifczech
        \noindent\hspace{-34.0pt}\mktxtc{14}{\@uhk@CS}
    \fi
    \ifslovak
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@uhk@SK}
    \fi
    \ifenglish
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@uhk@EN}
    \fi
    
    \vspace{5.6mm}
    
    \ifczech
        \noindent\hspace{-34.0pt}\mktxtc{14}{\@fim@CS}
    \fi
    \ifslovak
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@fim@SK}
    \fi
    \ifenglish
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@fim@EN}
    \fi
    
    \vspace{5.6mm}
    
    \ifczech
        \noindent\hspace{-34.0pt}\mktxtc{14}{\@departmentname@CS}
    \fi
    \ifslovak
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@departmentname@SK}
    \fi
    \ifenglish
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@departmentname@EN}
    \fi
    
    \vspace{6.3cm}
    
    \ifczech
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@title@CS}
    \fi
    \ifslovak
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@title@SK}
    \fi
    \ifenglish
      \noindent\hspace{-34.0pt}\mktxtc{14}{\@title@EN}
    \fi
    
    \ifczech
      \noindent\hspace{-34.0pt}\mktxtcn{14}{\@projecttype@CS}
    \fi
    \ifslovak
      \noindent\hspace{-34.0pt}\mktxtcn{14}{\@projecttype@SK}
    \fi
    \ifenglish
      \noindent\hspace{-34.0pt}\mktxtcn{14}{\@projecttype@EN}
    \fi
    
    \enlargethispage{5.1\baselineskip}
\end{center}

\vspace{4.5cm}

\mktxtcn{12}{\ifslovak\@author@SK\else\ifczech\@author@CS\else\@author@EN\fi\fi: \get@author}
\mktxtcn{12}{\ifslovak\@authorfield@SK\else\ifczech\@authorfield@CS\else\@authorfield@EN\fi\fi: \@author@field}

\vspace{2cm}

\mktxtcn{12}{\ifslovak\@supervisor@SK\else\ifczech\@supervisor@CS\else\@supervisor@EN\fi\fi: \get@supervisor}
  
\vfill
\noindent\mktxtcn{12}{Hradec Králové \hfill \@year\hspace{5.0pt}~}

\iftwoside
  \newgeometry{left=3.46cm, text={15.2cm,23.0cm}, top=2.96cm}
\fi


%zadani / assignment
\iftoggle{zadaniTwop}{
  \cleardoublepage
  \includepdf[pages=-,offset=0.6cm -1.7cm]{zadani.pdf}
  %\ifzadani\includepdf[pages=-,offset=0.6cm -1.7cm]{assignment.pdf}\fi
}{
  \ifzadani
    \includepdf[pages=-,offset=0.6cm -1.7cm]{zadani.pdf}
    %\ifzadani\includepdf[pages=-,offset=0.6cm -1.7cm]{assignment.pdf}\fi
  \fi
}


\setlength\parindent{17\p@}
\setlength{\parskip}{0pt}


\iftwoside
  \cleardoublepage
  \pagestyle{plain}
\else
  \newpage
\fi
\fontfamily{\familydefault}\selectfont%

%=================================================================================

\makedeclaration

\makeannotation
\clearpage
\setcounter{tocdepth}{2}\setcounter{page}{1}
}

%-----------------------------------------------------------------------------
\def\uv#1{\iflanguage{english}{``#1''}%
                              {\quotedblbase #1\textquotedblleft}}%
%\catcode`\"=\active
%\def"{\bgroup
%    \iflanguage{english}%
%        {``\def"{''\egroup}}%
%        {\quotedblbase\def"{\textquotedblleft\egroup}}}

% Now, switch on what is appropriate for czech:

% czech quotation marks
% \bq - begin quotation, \eq - end quotation
\def\bq{\mbox{\kern.1ex\protect\raisebox{-1.3ex}[0pt][0pt]{''}\kern-.1ex}}
\def\eq{\mbox{\kern-.1ex``\kern.1ex}}
%\setlanguage{\czech}

{%                                      % Begin a group for which " is active
\catcode`\"=\active                     % Make " an active character
\catcode`\@=11                          % Make @ an active character
%
%  \csdoublequoteson
%
%       This macro makes " an active character, resets the control sequence
%       \dblqu@te to L (left), and defines \dq as a replacement for ".
%
\gdef\csdoublequoteson{%                % \csdoublequoteson enables "
    \gdef"{\czechquotes}%               % Define " as \czechquotes
    \global\catcode`\"=\active%         % Make " an active character
    \global\chardef\dq=`\"%             % Double-quote char. via \dq
    \global\let\dblqu@te=L%             % Always start with a left double-quote
    }                                   % End of macro
%
%  \bq, \eq
%
%      These macros define default characters for czech left and right
%      double quotes. Czech opening quote is created from two commas with
%      kerning depending on fontdimen four parameter of current font.
%      Better solution should be specially designed character with
%      proper kernings; if you have such characters in fonts
%      (e.g. in DC-fonts), use it instead. (e.g. define
%      macros \bq and \eq e.g. \def\bq{\char"130 }
%      in your document/style file-- not in csquote.sty!)
%      Similar solution is used for czech right quote.
%
%      \cs existence test, stolen from TeXbook exercise 7.7
\def\ifundefined#1{\expandafter\ifx\csname#1\endcsname\relax }%
%
%      another macro to be more efficient in time and space
\global\chardef\f@@r=4
%
\ifundefined{bq}%
\gdef\bq{\kern-.25\fontdimen\f@@r\font,\kern-.8\fontdimen\f@@r\font,%
                \kern-.35\fontdimen\f@@r\font}%
\fi
\ifundefined{eq}%
\gdef\eq{\kern-.35\fontdimen\f@@r\font`\kern-.8\fontdimen\f@@r\font`%
                \kern-.25\fontdimen\f@@r\font}
\fi
%
% Macro \uv for other usage of \bq and \eq.
%
\ifundefined{uv}\iflanguage{czech}%
        \gdef\uv#1{\bq #1\eq}
\fi
%
% \testquotes macro gives warning if citation span this place
%
\gdef\testquotes{\if R\dblqu@te
        \message{Warning: You forgot right double quote!}%
        \let\dblqu@te=L\fi}
%
%  Define the macro that will be executed whenever " is encountered.
%
\gdef\czechquotes{\protect\czechqu@tes}
\gdef\czechqu@tes{%
        %  If the double-quote is the first character in a new paragraph,
        %  make sure it becomes a left double-quote.  This case can be
        %  detected by checking to see if TeX is currently in vertical mode.
        %  If so, the double-quote is at the beginning of the paragraph
        %  (since " hasn't actually generated any horizontal mode tokens
        %  yet, TeX is still in vertical mode).  If the mode is vertical,
        %  set \dblqu@te equal to L.
        %
        \ifinner\else\ifvmode\testquotes\fi\fi%
        %
        %  Now insert the appropriate left or right double-quote.
        %
        %  If \dblqu@te is L, insert an opening quote and set \dblqu@te to R.
        %
        \if L\dblqu@te\bq\global\let\dblqu@te=R%
        %
        %  Otherwise, save the current \spacefactor, insert '', set \dblqu@te
        %  to L, and reset the original \spacefactor.
        %
        \else%
           \let\xxx=\spacefactor%               % Save the \spacefactor
           \eq%                                 % Insert ending quote
           \global\let\dblqu@te=L%              % and reset \dblqu@te
           \spacefactor\xxx%                    % Reset the \spacefactor
        \fi%                                    % End of \if L\dblqu@te...
        }                                       % End of " macro
}                                               % End of group

\gdef\csdoublequotesoff{%
        \catcode`\"=12%                         % Set " back to other
        }
%
% Czech quotes are default
%
\csdoublequoteson

% Zarovnání v seznamu typu description 
% Alignment in description list
% http://tex.stackexchange.com/questions/7008/change-hanging-indent-in-description-list
\makeatletter
\newcommand{\DESCRIPTION@original@item}{}
\let\DESCRIPTION@original@item\item
\newcommand*{\DESCRIPTION@envir}{DESCRIPTION}
\newlength{\DESCRIPTION@totalleftmargin}
\newlength{\DESCRIPTION@linewidth}
\newcommand{\DESCRIPTION@makelabel}[1]{\llap{#1}}%
\newcommand{\DESCRIPTION@item}[1][]{%
  \setlength{\@totalleftmargin}%
       {\DESCRIPTION@totalleftmargin+\widthof{\textbf{#1 }}-\leftmargin}%
  \setlength{\linewidth}
       {\DESCRIPTION@linewidth-\widthof{\textbf{#1 }}+\leftmargin}%
  \par\parshape \@ne \@totalleftmargin \linewidth
  \DESCRIPTION@original@item[\textbf{#1}]%
}
\newenvironment{DESCRIPTION}
  {\list{}{\setlength{\labelwidth}{0cm}%
           \let\makelabel\DESCRIPTION@makelabel}%
   \setlength{\DESCRIPTION@totalleftmargin}{\@totalleftmargin}%
   \setlength{\DESCRIPTION@linewidth}{\linewidth}%
   \renewcommand{\item}{\ifx\@currenvir\DESCRIPTION@envir
                           \expandafter\DESCRIPTION@item
                        \else
                           \expandafter\DESCRIPTION@original@item
                        \fi}}
  {\endlist}
\makeatother


% Balíčky
% Packages
\usepackage[czech,slovak,english]{babel}
\usepackage[]{opensans}
\usepackage{float}
\usepackage{calc}
\usepackage{longtable,booktabs}
\usepackage{xcolor,colortbl}
\usepackage{multirow}
\usepackage{tabularx}
\usepackage{graphicx}
\usepackage{acro}
\usepackage{url}
\DeclareUrlCommand\url{\def\UrlLeft{<}\def\UrlRight{>} \urlstyle{tt}}
\def\UrlBreaks{\do\/\do-}

\usepackage{blindtext}
\usepackage{listings}
\usepackage[toc,page,header]{appendix}
\RequirePackage{titletoc}
\ifczech
  \usepackage{ae}
\fi

%--------------------------------------------------------
% Oprava pro Čechy a Slováky -- vyžaduje aktuální balíčky!
% Fix for CZECH and SLOVAK -- needs up to date packages!
% http://tex.stackexchange.com/questions/111999/slovak-and-czech-babel-gives-problems-with-cmidrule-and-cline
%--------------------------------------------------------
\usepackage{regexpatch}
%\ifczechslovak
  \makeatletter
  % Change the `-` delimiter to an active character
  \xpatchparametertext\@@@cmidrule{-}{\cA-}{}{}
  \xpatchparametertext\@cline{-}{\cA-}{}{}
  \makeatother
%\fi

\ifczechslovak
  \renewcommand{\lstlistingname}{Výpis} %Výpis místo Listing
\fi


% BEGIN Jan Pluskal (ipluskal) listings

\definecolor{bluekeywords}{rgb}{0.13,0.13,1}
\definecolor{greencomments}{rgb}{0,0.5,0}
\definecolor{redstrings}{rgb}{0.9,0,0}

\definecolor{gray}{rgb}{0.4,0.4,0.4}
\definecolor{darkblue}{rgb}{0.0,0.0,0.6}
\definecolor{cyan}{rgb}{0.0,0.6,0.6}

\lstset{
  basicstyle=\ttfamily,
  columns=fullflexible,
  showstringspaces=false,
  commentstyle=\color{gray}\upshape,
  captionpos=b
}

\lstdefinestyle{csh}{language=[Sharp]C,
  showspaces=false,
  showtabs=false,
  breaklines=false,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
}

\lstdefinelanguage{XML}
{
  morestring=[b]",
  morestring=[s]{>}{<},
  morecomment=[s]{<?}{?>},
  stringstyle=\color{black},
  identifierstyle=\color{darkblue},
  keywordstyle=\color{cyan},
  morekeywords={xmlns,version,type} % list your attributes here
}

\lstdefinestyle{npl}{language=c,
  showspaces=false,
  showtabs=false,
  breaklines=true,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
  morekeywords={UINT8, UINT16, UINT32, INT8, INT16, INT32, Post, Properties, Protocol, AsciiString, String, StringTerm, BLOB, FormatString, this},
}


\lstdefinestyle{c++}{language=c,
  showspaces=false,
  showtabs=false,
  breaklines=true,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
  morekeywords={UINT8, UINT16, UINT32, INT8, INT16, INT32, Post, Properties, Protocol, AsciiString, String, StringTerm, BLOB, FormatString, this},
}

%END Jan Pluskal (ipluskal) listings


% Příkazy pro TODO (3 alternativy - lze zvolit preferovanou)
% commands for TODO (3 alternatives - preferred one can be selected)
\newcommand{\todo}[1]{\textcolor{red}{\textbf{[[#1]]}}}
%\usepackage[colorinlistoftodos,prependcaption,textsize=tiny, disable]{todonotes}
%\usepackage[colorinlistoftodos,prependcaption,textsize=tiny]{todonotes}

\newcommand{\phony}[1]{\textcolor{gray}{#1}}
\newcommand{\blind}[1]{\textcolor{gray}{\Blindtext[#1]}}


% Sloupec zarovnaný vlevo s pevnou šířkou
% Left aligned column with a fixed width
\newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}}p{#1}}

\endinput
%%
%% End of file `fitthesis.cls'.
