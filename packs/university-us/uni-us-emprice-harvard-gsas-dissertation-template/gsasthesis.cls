% gsasthesis.cls
% An unofficial template for Harvard GSAS thesis for CfA students
% 2021-Jan-18 Ellen M Price

% --- Class structure: identification part
% ---
\ProvidesClass{gsasthesis}[2021/01/18 version 1.00 Unofficial Harvard GSAS thesis template]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{memoir}%
}

% --- Class structure: execution of options part
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options part
% ---
\LoadClass{memoir}

% Page layout
\RequirePackage[left=1in,right=1in,top=1in,bottom=1in,headheight=0.5in]{geometry}
\RequirePackage[english]{babel}
\RequirePackage{ragged2e}
\setlength\RaggedRightParindent{0.5in}

% Name and other demographic info
\def\@author{None}
\newcommand{\setauthor}[1]{\def\@author{#1}}
\newcommand{\show@author}{\@author}

\def\@title{None}
\newcommand{\settitle}[1]{\def\@title{#1}}
\newcommand{\show@title}{\@title}

\def\@advisor{None}
\newcommand{\setadvisor}[1]{\def\@advisor{#1}}
\newcommand{\show@advisor}{\@advisor}

\def\@month{None}
\newcommand{\setmonth}[1]{\def\@month{#1}}
\newcommand{\show@month}{\@month}

\def\@year{None}
\newcommand{\setyear}[1]{\def\@year{#1}}
\newcommand{\show@year}{\@year}

% Check required fields for header.
\AtBeginDocument{%
    \@ifundefined{@author}{%
        \ClassError{gsasthesis}{You must define an author name}{Use \backslash setauthor}%
    }{}%
    \@ifundefined{@title}{%
        \ClassError{gsasthesis}{You have not specified a title}{Use \backslash settitle}%
    }{}%
    \@ifundefined{@month}{%
        \ClassError{gsasthesis}{You have not specified a month}{Use \backslash setmonth}%
    }{}%
    \@ifundefined{@year}{%
        \ClassError{gsasthesis}{You have not specified a copyright year}{Use \backslash setyear}%
    }{}%
}

\def\@abs{None}
\newcommand{\setabs}[1]{\def\@abs{#1}}
\newcommand{\show@abs}{\@abs}

\def\@ack{None}
\newcommand{\setack}[1]{\def\@ack{#1}}
\newcommand{\show@ack}{\@ack}

\def\@ded{None}
\newcommand{\setded}[1]{\def\@ded{#1}}
\newcommand{\show@ded}{\@ded}

% Headers and footers
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}

%% This is page i, the title page
\fancypagestyle{titlepage}{
   \fancyhf{}%
}

%% This is page ii, the copyright page
\fancypagestyle{copyright}{
   \fancyhf{}%
}

%% This is page iii, start of abstract
\fancypagestyle{abstract}{
   \fancyhf{}%
   \fancyhead[R]{\show@author}%
   \fancyhead[L]{Dissertation Advisor: \show@advisor}
   \fancyfoot[C]{\thepage}%
}

\fancypagestyle{frontmatter}{
   \fancyhf{}%
   \fancyfoot[C]{\thepage}%
}

\AtBeginDocument{%
    \pagenumbering{roman}%
    % TITLE PAGE
    \thispagestyle{titlepage}%
    \addcontentsline{toc}{chapter}{\protect Title page}%
    \begin{center}
        \vspace*{0.25in}%
        \DoubleSpacing%
        \huge\scshape\show@title \\%
        \normalfont\normalsize A dissertation presented \\ by \\%
        \LARGE\show@author \\%
        \normalfont\normalsize to \\%
        \Large The Department of Astronomy \\%
        \normalfont\normalsize in partial fulfillment of the requirements \\%
        for the degree of \\%
        \Large Doctor of Philosophy \\%
        \normalfont\normalsize in the subject of \\%
        \Large Astronomy \& Astrophysics \\%
        \vspace{1in}%
        \normalfont\normalsize Harvard University \\%
        Cambridge, Massachusetts \\%
        \show@month\ \show@year%
    \end{center}%
    \clearpage%
    % COPYRIGHT PAGE
    \thispagestyle{copyright}%
    \addcontentsline{toc}{chapter}{\protect Copyright}%
    \begin{vplace}[0.7]%
    \begin{center}%
        \copyright\ \show@year\ \show@author \\ All rights reserved.%
    \end{center}%
    \end{vplace}%
    \clearpage%
    % ABSTRACT PAGE
    \thispagestyle{abstract}%
    \vspace{0.5in}\begin{center}\show@title\end{center}\vspace{0.5in}\par%
    \DoubleSpacing\RaggedRight%
    \addcontentsline{toc}{chapter}{\protect Abstract}%
    \input{\show@abs}%
    \clearpage%
    % TABLE OF CONTENTS PAGE
    \pagestyle{frontmatter}%
    \SingleSpacing%
    \addcontentsline{toc}{chapter}{\protect Table of contents}%
    \tableofcontents%
    \clearpage%
    % ACKNOWLEDGEMENTS
    \DoubleSpacing\RaggedRight%
    \addcontentsline{toc}{chapter}{\protect Front matter}%
    \addcontentsline{toc}{chapter}{\protect Acknowledgements}%
    \input{\show@ack}%
    \clearpage%
    % DEDICATION
    \DoubleSpacing\RaggedRight%
    \addcontentsline{toc}{chapter}{\protect Dedication}%
    \input{\show@ded}%
    \clearpage%
    % LIST OF FIGURES
    \listoffigures%
    \clearpage%
    % LIST OF TABLES
    \listoftables%
    \clearpage%
}

% vim: set ft=tex:
