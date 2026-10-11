\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SJSUthesis}[2026/03/16 Custom Thesis Class overriding IEEEtran]

% Pass standard options to IEEEtran. Force 12pt and onecolumn.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{IEEEtran}}
\ProcessOptions\relax
\LoadClass[12pt, onecolumn, journal]{IEEEtran}

% Decimal section numbering (3., 3.1., 3.1.1., …) in headings, refs, and ToC.
% IEEEtran journal (non-compsoc) defaults to Roman / I-A style; override after load.
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}
\renewcommand{\theparagraph}{\thesubsubsection\arabic{paragraph}.}
\renewcommand{\thesectiondis}{\thesection}
\renewcommand{\thesubsectiondis}{\thesubsection}
\renewcommand{\thesubsubsectiondis}{\thesubsubsection}
\renewcommand{\theparagraphdis}{\theparagraph}

% ==========================================
% REQUIRED PACKAGES
% ==========================================
\RequirePackage[left=1.25in, right=1in, top=1.25in, bottom=1.25in]{geometry} % Rule 3
\RequirePackage{setspace} % Rule 5
\RequirePackage[document]{ragged2e} % Rule 3: Left justified without terrible hyphenation gaps
\RequirePackage{titlesec} % Rule 7: Section breaks
\RequirePackage{etoolbox} % Rule 8: Patching environments
\RequirePackage{mathptmx} % Rule 4: Professional 12pt font (Times clone)
\RequirePackage{graphicx} % For figures
\RequirePackage{caption} % Rule 10: Caption formatting
\RequirePackage{tocloft} % Rule 12: ToC styling

% ==========================================
% RULE 3 & 4: TEXT FORMATTING
% ==========================================
\hyphenpenalty=10000
\exhyphenpenalty=10000
\RaggedRight % Enforces left-justification only
\sloppy 
\setlength{\emergencystretch}{3em}

% ==========================================
% RULE 5: SPACING
% ==========================================
\doublespacing

% Patch block quotes to be single-spaced
\AtBeginEnvironment{quote}{\singlespacing}
\AtBeginEnvironment{quotation}{\singlespacing}

% ==========================================
% RULE 6: INDENTATION
% ==========================================
\setlength{\parindent}{0.25in}
\setlength{\RaggedRightParindent}{0.25in}

% ==========================================
% RULE 7: NEW PAGES FOR SECTIONS
% ==========================================
% Since IEEEtran uses \section instead of \chapter for top-level divisions:
\newcommand{\sectionbreak}{\clearpage}

% ==========================================
% RULE 8: BIBLIOGRAPHY SPACING
% ==========================================
% Single-line spaced for each entry, double-spaced between entries.
\patchcmd{\thebibliography}
  {\list}
  {\singlespacing\list}
  {}
  {}
\apptocmd{\thebibliography}{%
  \setlength{\parskip}{1\baselineskip} % Double space between items
  \setlength{\itemsep}{0pt}
}{}{}

% ==========================================
% RULE 10: CAPTIONS AND FLOATS
% ==========================================
% Ensure captions are single spaced. 8pt is permitted inside tables/figures.
\captionsetup{font={singlespacing, small}, parindent=0pt}
\captionsetup[figure]{justification=centering, parindent=0pt, singlelinecheck=true}
\AtBeginEnvironment{table}{%
  \singlespacing\small
  \setlength{\parindent}{0pt}%
  \setlength{\RaggedRightParindent}{0pt}%
} % Sets table text smaller; no paragraph indent inside float
\AtBeginEnvironment{table*}{%
  \singlespacing\small
  \setlength{\parindent}{0pt}%
  \setlength{\RaggedRightParindent}{0pt}%
}
\AtBeginEnvironment{figure}{%
  \singlespacing
  \setlength{\parindent}{0pt}%
  \setlength{\RaggedRightParindent}{0pt}%
}
\AtBeginEnvironment{figure*}{%
  \singlespacing
  \setlength{\parindent}{0pt}%
  \setlength{\RaggedRightParindent}{0pt}%
}
% ==========================================
% RULE 12: TABLE OF CONTENTS DEPTH
% ==========================================
\setcounter{tocdepth}{3} % Up to Level 3 subheadings

% ==========================================
% RULES 13 & 14: FRONTMATTER & NUMBERING
% ==========================================
% IEEEtran lacks native \frontmatter and \mainmatter commands. We build them.

\newcommand{\makefrontmatter}{
    \pagenumbering{roman}
}

\newcommand{\makemainmatter}{
    \clearpage
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

% ==========================================
% MANDATORY UNNUMBERED PRELIMINARY PAGES
% ==========================================
% All preliminary pages follow SJSU Graduate Studies formatting:
%   - 12pt Times (inherited from class options)
%   - Titles: ALL CAPS, centered, NOT bold, single-spaced if multi-line
%   - No page numbers on the three mandatory pages

% ---- Shared Metadata ----
% The university name is set from the .tex file (not hardcoded here) so this
% class can be reused across campuses. Call \universityname{...} in your
% document's frontmatter BEFORE \thesistitlepage / \signaturepage. The title
% page uses the name as-is; the signature page uppercases it automatically.
\newcommand{\@universityname}{%
    \ClassError{SJSUthesis}{University name not set}%
        {Call \string\universityname{<Name>} in the document before using the preliminary pages.}%
}
\newcommand{\universityname}[1]{\renewcommand{\@universityname}{#1}}

% ---- Title Page ----
% Usage:
%   \thesistitlepage
%     {FULL TITLE IN ALL CAPS}   % #1
%     {Thesis}                   % #2  Thesis | Dissertation
%     {Kinesiology}              % #3  Department name (no "Department of" prefix)
%     {Master of Arts}           % #4  Degree
%     {Peter Maravitch}          % #5  Author full name
%     {December 2017}            % #6  Graduation month + year
\newcommand{\thesistitlepage}[6]{%
    \clearpage
    \thispagestyle{empty}
    \begin{center}
        \vspace*{1in}
        % Title: ALL CAPS, 12pt, not bold, single-spaced even if multi-line.
        {\singlespacing\normalsize #1\par}
        \vspace{0.5in}

        % Everything below is double-spaced per SJSU rules.
        \begin{doublespace}
        A #2\\
        Presented to\\
        The Faculty of the Department of #3\\
        \@universityname

        \vspace{0.25in}
        In Partial Fulfillment\\
        of the Requirements for the Degree

        \vspace{0.4in}
        #4

        \vspace{0.4in}
        by\\
        #5

        \vspace{0.4in}
        #6
        \end{doublespace}
    \end{center}
    \clearpage
}

% ---- Copyright Page ----
% Usage:
%   \copyrightpage{2017}{Nicklas Lidstr\"om}
\newcommand{\copyrightpage}[2]{%
    \clearpage
    \thispagestyle{empty}
    \vspace*{\fill}
    \begin{singlespace}
    \vspace{3in}
    \begin{center}
        \textcopyright\ #1\\
        #2\\
        ALL RIGHTS RESERVED
    \end{center}
    \end{singlespace}
    \vspace*{\fill}
    \clearpage
}

% ---- Signature Page ----
% A committee member entry: name on the left, affiliation on the right.
% Use inside the final argument of \signaturepage.
\newcommand{\committeemember}[2]{%
    \noindent\begin{minipage}[t]{0.55\textwidth}\raggedright #1\end{minipage}%
    \hfill
    \begin{minipage}[t]{0.40\textwidth}\raggedright #2\end{minipage}\par
    \vspace{0.35in}
}

% Usage:
%   \signaturepage
%     {FULL TITLE IN ALL CAPS}    % #1
%     {Thesis}                    % #2  Thesis | Dissertation
%     {Richard Shermer}           % #3  Author
%     {PHILOSOPHY}                % #4  Approving department (ALL CAPS)
%     {August 2017}               % #5  Approval date
%     {\committeemember{...}{...} % #6  Committee list
%      \committeemember{...}{...}}
\newcommand{\signaturepage}[6]{%
    \clearpage
    \thispagestyle{empty}
    \begin{singlespace}
    \begin{center}
        \vspace*{0.75in}
        The Designated #2 Committee Approves the #2 Titled\\
        \vspace{0.25in}
        #1\\
        \vspace{0.25in}
        by\\
        #3\\
        \vspace{0.5in}
        APPROVED FOR THE DEPARTMENT OF #4\\
        \MakeUppercase{\@universityname}\\
        \vspace{0.25in}
        #5
    \end{center}
    \vspace{0.5in}
    #6
    \end{singlespace}
    \clearpage
}

% ---- Abstract Page ----
\newcommand{\abstractpage}[1]{
    \clearpage
    \thispagestyle{empty}
    \begin{center}
        \textbf{ABSTRACT}
    \end{center}
    \doublespacing
    #1
    \clearpage
}

% Trigger for page v numbering
\newcommand{\startprelimnumbering}{
    \setcounter{page}{5} % First numbered page must be v
}

