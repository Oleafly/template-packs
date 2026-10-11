%% planning Class for LaTeX2e
%% 
%% Provides a LaTeX template for styling the first two pieces
%% of word for the CO3808 Project (Double) module.
%% Adapted from the .docx templates provided by the university.
%%
%% Please use XeTeX to Compile
%%
%% Author: Jacob Sánchez

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{planning}[2022-10-17 UCLan CO3808 Planning Template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper]{article}

\RequirePackage{xltxtra}
\RequirePackage[a4paper, total={7in, 9.5in}]{geometry}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{tabularx}
\RequirePackage{moresize}
\RequirePackage{fancyhdr}
\RequirePackage{ragged2e}


% Custom main font
\IfFontExistsTF{Avenir Next LT Pro}{
    \setmainfont{Avenir Next LT Pro}[
        BoldFont    = {Avenir Next LT Pro Bold}
    ]
}{}


% Page header font
% In order of preference
% Times New Roman > Tex Gyre Termes > cmr10
\IfFontExistsTF{Times New Roman}{
    \newfontfamily\PageHeaderSerif{Times New Roman}
}{
    \IfFontExistsTF{TeX Gyre Termes}{
        \newfontfamily\PageHeaderSerif{TeX Gyre Termes}
    }{
        \newfontfamily\PageHeaderSerif{cmr10}
    }
}

% Headers / Footnotes
\setlength{\headheight}{14.5pt}
\pagestyle{fancy}
\rhead{{\color{lightgray}\PageHeaderSerif\ssmall{CO3808 Honours Degree Project
| Computer Science | University of Central Lancashire}}}
\renewcommand{\headrulewidth}{0pt}

% Section heading style
\titleformat*{\section}{\normalsize\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}


% Extra row height on tables
\setlength{\extrarowheight}{6pt}

% Empty defaults
\newcommand{\tptitle}{\relax}
\newcommand{\tpauthor}{\relax}
\newcommand{\tpcourse}{\relax}
\newcommand{\tpsup}{\relax}

% maketitle parameters
\renewcommand{\title}{\renewcommand{\tptitle}}
\renewcommand{\author}{\renewcommand{\tpauthor}}
\newcommand{\course}{\renewcommand{\tpcourse}}
\newcommand{\supervisory}{\renewcommand{\tpsup}}
