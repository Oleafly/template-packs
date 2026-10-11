%
% Vorlage für Bachelor-Thesis an der Hochschule Fulda
% Created: 2013-12-04
% Author: Florian Schleich <florian.schleich@gmail.com>
%

\def\fileversion{1.0}
\def\filedate{2013/12/04}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hsfuldabook}
 [\filedate\space\fileversion\space 
   Florian Schleich HS-Fulda-Design package]
   
\LoadClassWithOptions{scrbook}

\RequirePackage{color}
\RequirePackage{tikz}
\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\RequirePackage[nouppercase,headsepline]{scrlayer-scrpage}

\RequirePackage{hsfulda_colors}
\RequirePackage{hsfulda_fonts}
\RequirePackage{hsfulda_infobox}

\def\logo{images/HSFuldaLogo.pdf}
\def\watermark{images/HSFuldaLeaf.pdf}

\newcommand{\setlogo}[1] {
    \def\logo{#1}
}

\newcommand{\setwatermark}[1] {
    \def\watermark{#1}
}

\pagestyle{scrheadings}
\clearscrheadfoot
\automark[section]{chapter}
\ohead{\headmark}
\ihead{\@subject}
\ofoot[\pagemark]{\pagemark}

\newcommand\BackgroundImLeaf{
    \put(90,100){
    \parbox[b][\paperheight]{\paperwidth}{%
    \vfill
    \centering
    \includegraphics[width=10cm,keepaspectratio]{\watermark}%
    \vfill
}}}

\def\@part[#1]#2{
    \thispagestyle{empty} %Keine Seitennummer
    \pagecolor{fulda_partback}
    \refstepcounter{part}
    \addcontentsline{toc}{part}{\protect\numberline{\thepart}#1}%
    \chaptermark{}
    \begin{tikzpicture}[remember picture,overlay]
        \node[yshift=-2cm, xshift=2cm] at (current page.north west) {
            \begin{tikzpicture}[remember picture,overlay]
                \color{fulda_partnumber}
                \node[draw=none,align=right,text width=\paperwidth] at (7cm,-7cm) {\scalebox{15}{\Huge \itshape{\arabic{part}}}};
            \end{tikzpicture}
        };
        \node[yshift=-8cm, xshift=2cm] at (current page.north west) {
            \begin{tikzpicture}[remember picture,overlay]
                \color{fulda_part}
                \node[draw=none,align=right,text width=\paperwidth] at (5cm,-7cm) {\scalebox{1.5}{\Huge #1}};
            \end{tikzpicture}
        };
    \end{tikzpicture}
    \clearpage
    \pagecolor{white}
    \setcounter{chapter}{0}
}

\renewcommand{\maketitle}{
    \begin{titlepage}
    \begin{tikzpicture}[remember picture,overlay]
        \node[yshift=-2cm, xshift=2cm] at (current page.north west) {
            \begin{tikzpicture}[remember picture,overlay]
                \fill[fill=fulda_green] (0,0) rectangle (\paperwidth-4cm,3mm);
                \fill[fill=black] (0,-2mm) rectangle (\paperwidth-4cm,-2.4mm);
            \end{tikzpicture}
        };
    \end{tikzpicture}
    \noindent
    \parbox{\textwidth}{
        %\hspace{-0.6cm}
        \fontsize{24.88pt}{35pt}\selectfont
        \color{fulda_title}
        \@title
    }
    \parbox{\textwidth}{
        \vspace{1cm}
        \hspace{0.3cm}
        \fontsize{20.74pt}{10pt}\selectfont
        \color{fulda_subtitle}
        \@subtitle
    }
    
    \AddToShipoutPicture*{\BackgroundImLeaf}
    
    \parbox{\textwidth}{
        \vspace{2.5cm}
        \hspace{0.4cm}
        \fontsize{14pt}{16pt}\selectfont
        
        \@author\\
        \\
        \textbf{\@date}
    }
    
    \begin{tikzpicture}[remember picture,overlay]
        \node[yshift=-15cm, xshift=2cm] at (current page.north west) {
            \begin{tikzpicture}[remember picture,overlay]
                \fill[fill=fulda_lightgreen] (0,0) rectangle (\paperwidth-4cm,-12cm);
            \end{tikzpicture}
        };
    \end{tikzpicture}
    
    \parbox{\textwidth}{
        \vspace{6cm}
        \raggedleft
        \includegraphics[width=10cm,height=3cm,keepaspectratio]{\logo}
    }
    \clearpage
    \@uppertitleback
    \end{titlepage}
}
