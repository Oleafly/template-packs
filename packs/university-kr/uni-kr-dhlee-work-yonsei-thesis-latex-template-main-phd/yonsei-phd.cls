\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yonsei-phd}[2026/09/10 Yonsei University Graduate School PhD thesis template]

% English doctoral-thesis form based on the 2026 Graduate School MS Word guide.
% Compile with XeLaTeX (recommended) or LuaLaTeX.
\LoadClass[10pt,a4paper,oneside,openany]{report}

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{yonsei-phd}{This template requires XeLaTeX or LuaLaTeX}{Use XeLaTeX in Overleaf or your local editor.}
\fi

\RequirePackage{fontspec}
\RequirePackage{kotex}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{amsmath,amssymb}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{natbib}
\RequirePackage[hidelinks]{hyperref}

% --------------------------------------------------------------------------
% Page and font settings from the 2026 Yonsei Graduate School form
% --------------------------------------------------------------------------
\geometry{
  a4paper,
  left=3.5cm,
  right=3.5cm,
  top=5.3cm,
  bottom=5.3cm,
  headheight=0pt,
  headsep=0pt,
  footskip=2.1cm
}

% The form specifies Times New Roman. Tinos is a metrically compatible fallback
% for systems (e.g. some Linux/Overleaf environments) without Times New Roman.
\IfFontExistsTF{Times New Roman}{
  \setmainfont{Times New Roman}
}{
  \setmainfont{Tinos}
}

% Korean abstract fallback font. This only affects Hangul glyphs.
\IfFontExistsTF{Noto Serif CJK KR}{
  \setmainhangulfont{Noto Serif CJK KR}
}{
  \IfFontExistsTF{NanumMyeongjo}{\setmainhangulfont{NanumMyeongjo}}{}
}

\onehalfspacing
\setlength{\parindent}{1em} % approximately two ordinary spaces
\setlength{\parskip}{0pt}
\frenchspacing

% 9 pt footnotes as required by the guide.
\renewcommand{\footnotesize}{\fontsize{9pt}{11pt}\selectfont}

% Page numbers: centered at bottom, no running headers.
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% --------------------------------------------------------------------------
% Heading styles: chapter 16 pt, section 13 pt, body 10 pt.
% --------------------------------------------------------------------------
\titleformat{\chapter}[hang]
  {\bfseries\fontsize{16pt}{19.2pt}\selectfont}
  {\thechapter.}{0.5em}{}
\titlespacing*{\chapter}{0pt}{0pt}{1.5\baselineskip}

\titleformat{\section}[hang]
  {\bfseries\fontsize{13pt}{15.6pt}\selectfont}
  {\thesection}{0.5em}{}
\titlespacing*{\section}{0pt}{1.5\baselineskip}{0.75\baselineskip}

\titleformat{\subsection}[hang]
  {\bfseries\fontsize{11pt}{13.2pt}\selectfont}
  {\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{1.25\baselineskip}{0.5\baselineskip}

% Avoid automatic "Chapter" labels in marks.
\renewcommand{\chaptername}{}

% --------------------------------------------------------------------------
% TOC / lists
% --------------------------------------------------------------------------
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}

\renewcommand{\cfttoctitlefont}{\hfill\bfseries\fontsize{16pt}{19.2pt}\selectfont}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{1.5\baselineskip}

\renewcommand{\cftloftitlefont}{\bfseries\fontsize{13pt}{15.6pt}\selectfont}
\renewcommand{\cftlottitlefont}{\bfseries\fontsize{13pt}{15.6pt}\selectfont}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterloftitleskip}{1.2\baselineskip}
\setlength{\cftafterlottitleskip}{1.2\baselineskip}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftchapaftersnum}{.}
\setcounter{tocdepth}{2}

% --------------------------------------------------------------------------
% User metadata
% --------------------------------------------------------------------------
\newcommand{\thesistitle}[1]{\gdef\YS@title{#1}}
\newcommand{\thesisauthor}[1]{\gdef\YS@author{#1}}
\newcommand{\department}[1]{\gdef\YS@department{#1}}
\newcommand{\advisor}[1]{\gdef\YS@advisor{#1}}
\newcommand{\degree}[1]{\gdef\YS@degree{#1}}
\newcommand{\submissiondate}[1]{\gdef\YS@submissiondate{#1}}
\newcommand{\approvaldate}[1]{\gdef\YS@approvaldate{#1}}
\newcommand{\committeechair}[1]{\gdef\YS@chair{#1}}
\newcommand{\committeememberA}[1]{\gdef\YS@memberA{#1}}
\newcommand{\committeememberB}[1]{\gdef\YS@memberB{#1}}
\newcommand{\committeememberC}[1]{\gdef\YS@memberC{#1}}
\newcommand{\committeememberD}[1]{\gdef\YS@memberD{#1}}

\newcommand{\YS@title}{Your Dissertation Title}
\newcommand{\YS@author}{Hong, Gildong}
\newcommand{\YS@department}{Department of XXX}
\newcommand{\YS@advisor}{Prof. Advisor Name}
\newcommand{\YS@degree}{Doctor of Philosophy}
\newcommand{\YS@submissiondate}{February 2027}
\newcommand{\YS@approvaldate}{February 2027}
\newcommand{\YS@chair}{Prof. Committee Chair}
\newcommand{\YS@memberA}{Prof. Committee Member 1}
\newcommand{\YS@memberB}{Prof. Committee Member 2}
\newcommand{\YS@memberC}{Prof. Committee Member 3}
\newcommand{\YS@memberD}{Prof. Committee Member 4}

% Internal helper: fixed-height block matching the Word form's table rows.
\newcommand{\YSblock}[3][c]{%
  \noindent\parbox[#1][#2][#1]{\textwidth}{#3}\par\nointerlineskip
}

\newcommand{\YScenter}[1]{\centering #1\par}

% --------------------------------------------------------------------------
% Cover page (Appendix 1 in the source form)
% Row heights reproduce the original fixed-height Word table.
% --------------------------------------------------------------------------
\newcommand{\makecoverpage}{%
  \clearpage
  \thispagestyle{empty}
  \begingroup
  \setlength{\parindent}{0pt}
  \noindent\begin{minipage}[t][\textheight][t]{\textwidth}
  \YSblock[c]{1.50cm}{}%
  \YSblock[t]{4.75cm}{%
    \YScenter{\bfseries\fontsize{18pt}{20.7pt}\selectfont \YS@title}%
  }%
  \YSblock[b]{3.85cm}{%
    \YScenter{\bfseries\fontsize{18pt}{18pt}\selectfont \YS@author}%
  }%
  \YSblock[b]{8.90cm}{%
    \YScenter{\bfseries\fontsize{18pt}{27pt}\selectfont
      \YS@department\\
      Graduate School\\
      Yonsei University}%
  }%
  \end{minipage}
  \endgroup
  \clearpage
}

% --------------------------------------------------------------------------
% Title page (Appendix 2)
% --------------------------------------------------------------------------
\newcommand{\makeyonseititlepage}{%
  \thispagestyle{empty}
  \begingroup
  \setlength{\parindent}{0pt}
  \noindent\begin{minipage}[t][\textheight][t]{\textwidth}
  \YSblock[c]{0.80cm}{}%
  \YSblock[t]{3.40cm}{%
    \YScenter{\bfseries\fontsize{16pt}{20pt}\selectfont \YS@title}%
  }%
  \YSblock[c]{1.20cm}{%
    \YScenter{\bfseries\fontsize{16pt}{16pt}\selectfont Advisor : \YS@advisor}%
  }%
  \YSblock[c]{1.00cm}{}%
  \YSblock[t]{6.00cm}{%
    \YScenter{\bfseries\fontsize{16pt}{20.8pt}\selectfont
      A Dissertation Submitted\\
      to the \YS@department\\
      and the Committee of the Graduate School\\
      of Yonsei University in Partial Fulfillment of the\\
      Requirements for the Degree of\\
      \YS@degree}%
  }%
  \YSblock[b]{1.70cm}{%
    \YScenter{\bfseries\fontsize{16pt}{16pt}\selectfont \YS@author}%
  }%
  \YSblock[c]{3.70cm}{}%
  \YSblock[b]{1.00cm}{%
    \YScenter{\bfseries\fontsize{16pt}{16pt}\selectfont \YS@submissiondate}%
  }%
  \end{minipage}
  \endgroup
  \clearpage
}

% --------------------------------------------------------------------------
% Signature page (Appendix 3)
% --------------------------------------------------------------------------
\newcommand{\YSsignatureline}[2]{%
  \noindent\makebox[4.35cm][l]{\bfseries #1}%
  \makebox[9.55cm][l]{\rule{9.55cm}{0.4pt}}\\[-0.15cm]
  \noindent\makebox[4.35cm][l]{}%
  \makebox[9.55cm][l]{\bfseries #2}%
}

\newcommand{\makesignaturepage}{%
  \thispagestyle{empty}
  \begingroup
  \setlength{\parindent}{0pt}
  \noindent\begin{minipage}[t][\textheight][t]{\textwidth}
  \YSblock[t]{2.43cm}{%
    \YScenter{\bfseries\fontsize{13pt}{15pt}\selectfont \YS@title}%
  }%
  \YSblock[t]{1.95cm}{%
    \YScenter{\bfseries\fontsize{13pt}{13pt}\selectfont
      This certifies that the dissertation\\
      of \YS@author\ is approved.}%
  }%
  \YSblock[c]{2.00cm}{\fontsize{13pt}{13pt}\selectfont\YSsignatureline{Committee Chair}{\YS@chair}}%
  \YSblock[c]{2.00cm}{\fontsize{13pt}{13pt}\selectfont\YSsignatureline{Committee Member}{\YS@memberA}}%
  \YSblock[c]{2.00cm}{\fontsize{13pt}{13pt}\selectfont\YSsignatureline{Committee Member}{\YS@memberB}}%
  \YSblock[c]{2.00cm}{\fontsize{13pt}{13pt}\selectfont\YSsignatureline{Committee Member}{\YS@memberC}}%
  \YSblock[c]{2.00cm}{\fontsize{13pt}{13pt}\selectfont\YSsignatureline{Committee Member}{\YS@memberD}}%
  \YSblock[c]{1.58cm}{}%
  \YSblock[b]{3.04cm}{%
    \YScenter{\bfseries\fontsize{13pt}{15pt}\selectfont
      \YS@department\\
      Graduate School\\
      Yonsei University\\[0.35cm]
      \YS@approvaldate}%
  }%
  \end{minipage}
  \endgroup
  \clearpage
}

% --------------------------------------------------------------------------
% Front matter numbering and abstract environments
% --------------------------------------------------------------------------
\newcommand{\yonseifrontmatter}{%
  \clearpage
  \pagenumbering{roman}
  \setcounter{page}{1}% TOC begins at i, matching the sample.
}

\newcommand{\yonseimainmatter}{%
  \clearpage
  \pagenumbering{arabic}
  \setcounter{page}{1}
}

\newenvironment{yonseiabstract}[1][Abstract]{%
  \clearpage
  \thispagestyle{fancy}
  {\bfseries\fontsize{13pt}{15.6pt}\selectfont #1\par}
  \vspace{1.5\baselineskip}
  \begin{center}
    \bfseries\fontsize{13pt}{15.6pt}\selectfont \YS@title
  \end{center}
  \vspace{1.2\baselineskip}
  \fontsize{10pt}{15pt}\selectfont
}{%
  \par
}

\newcommand{\abstractkeywords}[1]{%
  \vspace{1.5\baselineskip}
  \noindent\textbf{Keywords :} #1\par
}

\newenvironment{yonseikoreanabstract}{%
  \clearpage
  \thispagestyle{fancy}
  {\bfseries\fontsize{13pt}{15.6pt}\selectfont Abstract in Korean\par}
  \vspace{1.5\baselineskip}
  \begin{center}
    \bfseries\fontsize{13pt}{15.6pt}\selectfont \YS@title
  \end{center}
  \vspace{1.2\baselineskip}
  \fontsize{10pt}{15pt}\selectfont
}{%
  \par
}

\newcommand{\koreanabstractkeywords}[1]{%
  \vspace{1.5\baselineskip}
  \noindent\rule{\textwidth}{0.4pt}\par
  \vspace{0.4\baselineskip}
  \noindent\textbf{핵심되는 말 :} #1\par
}

% Acknowledgements are optional and are placed before the TOC.
\newenvironment{acknowledgements}{%
  \clearpage\thispagestyle{empty}
  {\bfseries\fontsize{13pt}{15.6pt}\selectfont Acknowledgements\par}
  \vspace{1.5\baselineskip}
}{\clearpage}

% References use a 13 pt heading, as shown in the sample form.
\renewcommand{\bibname}{References}
\renewcommand{\bibsection}{%
  \clearpage
  {\bfseries\fontsize{13pt}{15.6pt}\selectfont References\par}
  \vspace{1.2\baselineskip}
  \addcontentsline{toc}{chapter}{References}%
}

% Figure/table captions remain compact and readable.
\captionsetup{font=small,labelfont=bf,justification=centering}

% Slight protection against widows/orphans.
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
