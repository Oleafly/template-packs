\LoadClass[twoside,11pt, openright, a4paper]{book}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[]

\usepackage{wrapfig}
\usepackage{mathtools}
\usepackage{makecell}
\usepackage{float} %H
\usepackage[total={15cm,21cm},top=4.85cm,includefoot]{geometry}
\usepackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{microtype}
\usepackage{palatino,eulervm}
\usepackage[dvipsnames]{xcolor}
\usepackage{graphicx}
\usepackage{amsfonts}
\usepackage{amsmath}
\usepackage{csquotes}
\usepackage{epigraph}
\setlength\epigraphwidth{.8\textwidth}
\setlength\beforeepigraphskip{-20pt}
\renewcommand{\textflush}{flushright}
\renewcommand{\epigraphsize}{\large}
\setlength\epigraphrule{0pt}

\usepackage{breakcites}
\usepackage[final]{listings}
\usepackage[printonlyused]{acronym} % Acronyms with \ac
\usepackage{changepage}
\usepackage{titlesec}
\usepackage{pdfpages}
\usepackage{booktabs}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{placeins}
\usepackage{enumerate}
\usepackage{subcaption}
% For comments
\usepackage{verbatim}

\usepackage[labelfont=bf]{caption}
%\parindent0em
\emergencystretch=1em
\usepackage{natbib}
\bibliographystyle{plainnat}
\usepackage{etoolbox}
\preto\chapter\acresetall
\usepackage[symbol]{footmisc}

\renewcommand{\thefootnote}{\fnsymbol{footnote}}%footnote *
\setcitestyle{authoryear,open={(},close={)}} %Citation-related commands

\usepackage{fancyhdr}
% See https://www.overleaf.com/learn/latex/headers_and_footers
\fancyhf{}
\fancyhead[EL]{\slshape\nouppercase{\leftmark}}
\fancyhead[OR]{\slshape\nouppercase{\rightmark}}
\fancyfoot[EL,OR]{\slshape{\thepage}}


%first page of a chapter uses plain style
\fancypagestyle{plain}{%
\fancyhf{}% clears all header and footer fields
\fancyhead[]{}%
\fancyfoot[EL,OR]{\slshape{\thepage}}
\renewcommand{\headrulewidth}{0pt}%
\setlength{\headheight}{14pt}

}

\usepackage{graphbox} %align figures at top

\pagestyle{fancy}
\setlength{\headheight}{14pt}% ...at least 51.60004pt


% Specify that only pages with more than 80% of floats, will become pure float-only pages. Thedefault is 0.6 so if a figure consumes 60% of the page it will get its own float-page. This was pretty annoying.
\renewcommand{\floatpagefraction}{.8}

%\definecolor{dkfzgray}{rgb}{0.6,0.6,0.6}
\colorlet{dkfzgray}{gray!10}
\definecolor{dkfzgray2}{rgb}{0.6,0.6,0.6}
%\definecolor{dkfzgray}{gray!30}
\newcolumntype{a}{>{\columncolor{dkfzgray}}m{0.27\textwidth}}
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}} %table centering


% #################################
%   CHAPTER
% #################################
%%Options: Sonny, Lenny, Glenn, Conny, Rejne, Bjarne, Bjornstrup
\usepackage[Lenny]{fncychap}

%decrease space before chapter
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\vspace*{-50\p@}}{}{}
%\patchcmd{\DOTIs}{\vskip 80\p@}{\vskip -10\p@}{}{}

\usepackage{textcomp}
\usepackage{xurl}
\usepackage[hidelinks]{hyperref} % add [hidelinks] in the end to suppress the ugly boxes :)
%\usepackage[onehalfspacing]{setspace}
\usepackage{setspace}
\setstretch{1,1}


\usepackage{gensymb} %degree

\usepackage{colortbl}

% #################################
%   DISCLOSURE
% #################################

\usepackage[skins,breakable]{tcolorbox}
\newcommand{\disclosure}[2]{
    \tcbset{width=\textwidth,boxrule=0pt,colback=dkfzgray,arc=0pt,auto outer arc,left=5pt,right=5pt,boxsep=5pt,colframe=dkfzgray}
    \begin{center}
        \begin{minipage}{\textwidth}
            \begin{tcolorbox}
                \textbf{#1}\vspace{0.25em}
                \begin{center}
                    \begin{minipage}{0.95\textwidth}
                        #2
                    \end{minipage}
                \end{center}
            \end{tcolorbox}
        \end{minipage}
    \end{center}
}

% #################################
%   Research question
% #################################

\usepackage[skins,breakable]{tcolorbox}
\newcommand{\researchquestion}[2]{
    \tcbset{width=\textwidth,boxrule=0pt,colback=dkfzgray,arc=0pt,auto outer arc,left=5pt,right=5pt,boxsep=5pt,colframe=dkfzgray}
    \begin{center}
        \begin{minipage}{\textwidth}
            \begin{tcolorbox}
                \textbf{Research question #1:} #2
            \end{tcolorbox}
        \end{minipage}
    \end{center}
}

\usepackage[skins,breakable]{tcolorbox}
\newcommand{\researchquestionsmall}[2]{
    \tcbset{\textwidth,boxrule=0pt,colback=dkfzgray,arc=0pt,auto outer arc,left=5pt,right=5pt,boxsep=5pt,colframe=dkfzgray}
    \begin{minipage}{0.77\textwidth}
        \begin{tcolorbox}
            \textbf{RQ #1:} #2
        \end{tcolorbox}
    \end{minipage}
}