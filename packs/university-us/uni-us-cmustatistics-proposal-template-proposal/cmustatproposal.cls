% CMU Statistics & Data Science proposal and ADA report template, building on
% article
% Alex Reinhart, 2022

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cmustatproposal}[2022/09/03 cmustatproposal]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions

\LoadClass[11pt,letterpaper,twoside]{article}

% Math packages
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}

% define theorem, corollary, lemma, and definition environments
\theoremstyle{plain}
\newtheorem*{theorem*}{Theorem}
\newtheorem{theorem}{Theorem}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}

% Fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern} % default to Latin Modern for better character support

% Typesetting options
\RequirePackage{microtype}
\RequirePackage[hyphens,obeyspaces]{url}
\RequirePackage{booktabs}

% Headers and footers
\RequirePackage{fancyhdr}

% Figure caption styles: sans-serif, with label "Figure N" italicized
\RequirePackage[font=sf,labelfont=it]{caption}

% Provide a shorttitle command for page headings, in case their title is too
% long
\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}

% Note: Change to \RequirePackage[hidelinks,final]{hyperref} for printing in
% B&W, to avoid unsightly boxes
\RequirePackage[final]{hyperref}

\RequirePackage[final]{graphicx}
\graphicspath{ {figures/} } % specify the path where figures are located

% Bibliography
\RequirePackage{natbib}
\bibliographystyle{apalike} % bibliography style - recommend using apalike-doi
% as it hyperlinks DOIs

% PDF metadata
\AtBeginDocument{%
  \hypersetup{%
    bookmarksnumbered=true,
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={Department of Statistics and Data Science, Carnegie Mellon University},
    pdfpagelayout=SinglePage
  }

    % Page headers
  \pagestyle{fancy}
  \fancyhead{}

  \ifdefined\@shorttitle
    \fancyhead[CO]{\textit{\@shorttitle}}
  \else
    \fancyhead[CO]{\textit{\@title}}
  \fi

  \fancyhead[CE]{\textit{\@author}}

  \fancyhead[LE,RO]{\thepage}

  \renewcommand{\headrulewidth}{0pt}

  \ifdraft{
    \newcommand{\draftmark}{{\sffamily Draft as of \today}}
    \fancyfoot[CE,CO]{\draftmark}
  }{
    \fancyfoot{}
  }

  \thispagestyle{plain}
}

% Fancypants logic
\RequirePackage{pgffor}
\RequirePackage{ifdraft}

\def\theadvisors{}
\newcommand{\advisor}[1]{%
  \g@addto@macro\theadvisors{{#1},}
}
\def\thecommittee{}
\newcommand{\committee}[1]{%
  \g@addto@macro\thecommittee{{#1},}
}

\newcommand{\documenttype}[1]{\def\thedocumenttype{#1}}

\renewcommand{\maketitle}{%
  {
    \raggedright
    \begin{center}
      \includegraphics[width=3.5in,alt={Carnegie Mellon wordmark}]{cmu-wordmark-horizontal-r.pdf} \\
      {\Large Department of Statistics \& Data Science}\\[4ex]
      {\Large \thedocumenttype}\\[4ex]
      \ifdraft{\draftmark\\}{}

      \vspace{1cm}

      {\large \@title}\\[4ex]
      {\large  \@author}\\[4ex]
      \@date\\[8ex]
    \end{center}
    \vspace{1cm}

    \textbf{Committee:}\\
    % Advisor(s) first
    \foreach \advisor in \theadvisors {
      \ifx\advisor\empty
      \else
        \advisor, Advisor\\
      \fi
    }

    % Committee members
    \foreach \member in \thecommittee {
      \ifx\member\empty
      \else
        \member\\
      \fi
    }
    \clearpage
  }
}

% Support large landscape tables
\RequirePackage[pass]{geometry} % pass tells it not to mess with the layout
\RequirePackage{pdflscape}
\newenvironment{landscapepage}[1][1in]{%
  \newgeometry{margin=#1}%
  \begin{landscape}}{%
  \end{landscape}%
  \aftergroup\restoregeometry}
