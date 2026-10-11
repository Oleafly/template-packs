%  This is a modification of the 
%
%     easychithesis.cls   Version 1.5   April 5, 1999
%  
%  I (Brad Holden, bph herein) used this for my thesis.  I encountered a
%  few problems when dealing with the Office of Academic
%  Publications so I fixed those in this version.  In the future, 
%  new policies will be enacted so this version will no doubt become
%  obselete as well.
%
%     easyuvathesis.cls   March 13, 2000
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     easyuvathesis.cls    15 January 2001
%   
%    I (Chris Palma) downloaded this file from the web and 
%    edited it to conform to Virginia standards.
%
%    I changed all instances of 'myeasychithesis' to 'easyuvathesis'
%
%    Many of the comments aren't mine.  My comments are marked (cp)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Instructions And Hints
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This file provides the LaTeX2e style easyuvathesis for formating
% graduate theses at the University of Virginia.  The original
% Chicago version was written by
% Bryan Clair and Nathan Dunfield.  For an example of its use see the
% file: template.tex, and the instructions below.
%
% Comments or problems should be sent to cp4v@virginia.edu
%
%
% Invoking this style:  Start you document with (this is 1.5 spaced)
%
%   \documentclass{easyuvathesis}
%
% You maybe asked to submit a double-spaced thesis.  If you so, start with
%
%   \documentclass[truedoublespace]{easyuvathesis}
%
% When printing drafts, you may not want your thesis doublespaced.
% If you use instead:
%
%   \documentclass[singlespace]{easyuvathesis}
%
% or
%
%   \documentclass[onehalfspace]{easyuvathesis}
%
% your thesis will come out single or 3/2 spaced respectively.
% easyuvathesis also understands all options understood by report.
% Also the ``double spacing'' provided by this style is not ``true''
% doublespacing as defined by setspace.sty.  Instead, it is the same
% as in the old LaTeX 2.09 thesis style ``chithesis''.  If you want
% ``true'' double spacing, give the option truedoublespace
%
% Title Page Information Commands
%    Example Usage:
%    \title{Lots of Good Stuff}
%    \author{Joseph Paterno}
%    \hometown{Mytown, Mystate}
%    \department{Department of Astronomy}
%    \degreename{Doctor of Philosophy}
%    \bach{B.S., Pennsylvania State University, 1994}
%    \mast{M.A., University of Virginia, 1997}
%    \degreedate{May, 2001}  % Convocation date
%    \commone{Someone}
%    \commtwo{Yet Another Person}
%    \commthree{Person Three}
%    \commfour{Someone Else}
%    \commfive{Last N. Least}
%    \maketitle
%
% \dedication : Use for a dedication, copyright, or epigraph.
%               Produces a page with no number for the text which follows
%               If you want centering, do it yourself with
%               \begin{center} and \end{center}.
%        Usage:
%           \dedication
%           To blah.
%
% \topmatter : Things like Abstract, Acknowledgements.
%    Usage:
%       \topmatter{Title Of Matter}
%
%       Use like \chapter, once for each page of matter you want.  Don't
%       use numbered sections within these.  Use \section* instead.
%
% The abstract environment has been changed to invoke \topmatter.
%
% \mainmatter : Signals the start of the document's body.
%    Usage:
%       \mainmatter
%
%       Use once before the first numbered \chapter.
%
%  HINTS:
%
%  1.  To get appendices, you don't do anything different from a normal
%     report document.  That means, put the command \appendix before
%     you begin your first appendix, then do each appendix with a
%     \chapter command.  Note that if you have only one appendix, it is
%     customary to leave it unnumbered.  Do this with \chapter*.
%
%  KNOWN PROBLEMS
%
%  1.  No support for multi-volume theses.
%
%  2.  Doesn't work with older versions of setspace.sty
%
%  3.  Problems with math formulas in chapter headings:
%
%         a.  Any lowercase letters in the formula are converted to
%         uppercase, e.g. f(x) becomes F(X).   If you really need
%         lowercase math letters in your chapter titles, use the
%         option plainchapterheads (and, if you want, type your
%         chapter titles in ALL CAPS so that the appearance doesn't
%         change).  Note there is no problem
%         for section or subsection headings in either case.
%
%         b.  Some perfectly reasonable math commands when used in
%         \chapter give the error
%          ``LATEX ERROR: \command  ALLOWED ONLY IN MATH MODE.''
%         The solution to this is to do
%
%              \newcommand{\mymath}{problem math goes here}
%
%         and then
%
%              \chapter{All about \protect\mymath}
%
%         also, the option plainchapterheads will fix this too.
%
%  Improvements over older versions:
%
%  Added in 1.4: Name of the bibliograpy is now References, to please the
%  thesis office.  If you want to change it back, put
%
%   \renewcommand{\bibname}{Bibliograpy}
%
%  in your TeX file prior to \begin{document}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{easyuvathesis}[2001/01/15 Virginia Thesis Class For LaTex2e]

\RequirePackage{setspace}[1998/04/8]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\usepackage[breaklinks,ps2pdf]{hyperref}
\usepackage{fancyhdr}
\RequirePackage{latexsym}%  The following bits are added by bph
\RequirePackage{graphicx}%  I added them so I can include figures 
\RequirePackage{amssymb} %  and have more symbols.

\RequirePackage{verbatim}%
\def\@to{to}%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\etptsize}{12pt}

\DeclareOption{10pt}{\renewcommand{\etptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\etptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\etptsize}{12pt}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{report}}

% The following options set the global amount of spacing

\newcommand{\etspacing}{\setstretch{1.37}}
\DeclareOption{truedoublespace}{\renewcommand{\etspacing}{\doublespacing}}
\DeclareOption{doublespace}{\renewcommand{\etspacing}{\setstretch{1.37}}}
\DeclareOption{onehalfspace}{\renewcommand{\etspacing}{\onehalfspacing}}
\DeclareOption{singlespace}{\renewcommand{\etspacing}{\singlespacing}}

% Normally, the chapter heads are all uppercase, but sometimes
% this cause problems.  The following option fixes changes
% the chapter heads to small caps instead

%\newcommand{\etchapterheadstyle}[1]{{#1}}
%\DeclareOption{plainchapterheads}{\renewcommand{\etchapterheadstyle}[1]{#1}}

% Pass all other options to report.cls.
\DeclareOption*{%
 \PassOptionsToClass{\CurrentOption}{report}
}

% It would be better to have the following line next,
% rather than setting the defaults manually, but
% this would break early version of LaTeX2e
%
%\ExecuteOptions{12pt,letterpaper,doublespace}
\ProcessOptions\relax
\LoadClass[\etptsize]{report}

% Adjust spacing of document

\etspacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Commands Defined For Use By Thesis Author
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% \dedication : Use for a dedication, copyright, or epigraph.
%               Produces a page with no number for the text which follows
%               If you want centering, do it yourself with
%               \begin{center} and \end{center}.
%
\newcommand{\dedication}{
        \chapter*{}
        \thispagestyle{empty}
}

%
% \topmatter : Things like Abstract, Acknowledgements.
%    Usage:
%       \topmatter{Title Of Matter}
%
%       Use like \chapter, once for each page of matter you want.  Don't
%       use numbered sections within these.  Use \section* instead.
%
\newcommand{\topmatter}[1]{ 
        \clearpage
        \begin{center}
        \large{\textbf{{#1}}}
        \end{center}
        \addcontentsline{toc}{chapter}{#1}
}

%
% redefinition of abstract environment
%

\renewenvironment{abstract}{\topmatter{Abstract}}{}

%
% \mainmatter : Signals the start of the document's body.
%    Usage:
%       \mainmatter
%
%       Use once before the first numbered \chapter.
%
\newcommand{\mainmatter}{
        \clearpage
        \pagenumbering{arabic}
}

\renewcommand{\appendix}{
        \let \oldsec = \thesection
        \let \oldeq = \theequation
        \setcounter{section}{0}
        \setcounter{equation}{0}
        \renewcommand{\thesection}{Appendix \Alph{section}}
        \renewcommand{\theequation}{\Alph{section}.\arabic{equation}}
}

\newcommand{\resapp}{
        \renewcommand{\thesection}{\oldsec}
        \renewcommand{\theequation}{\oldeq}
}


%
% Title Page Information Commands
%    Example Usage:  (see above (cp))
%
\renewcommand{\title}[1]{\gdef\@title{#1}}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\renewcommand{\date}[1]{\gdef\@date{#1}}
\newcommand{\bach}[1]{\gdef\@bach{#1}}
\newcommand{\mast}[1]{\gdef\@mast{#1}}
\newcommand{\masttwo}[1]{\gdef\@masttwo{#1}}
\newcommand{\hometown}[1]{\gdef\@hometown{#1}}
\newcommand{\degreedate}[1]{\gdef\@degreedate{#1}}
\newcommand{\degreename}[1]{\gdef\@degreename{#1}}
\newcommand{\commone}[1]{\gdef\@commone{#1}}
\newcommand{\commtwo}[1]{\gdef\@commtwo{#1}}
\newcommand{\commthree}[1]{\gdef\@commthree{#1}}
\newcommand{\commfour}[1]{\gdef\@commfour{#1}}
\newcommand{\commfive}[1]{\gdef\@commfive{#1}}

%
% \maketitle :  Makes the U. of Virginia dissertation title page.
%
\renewcommand{\maketitle}{
   \begin{titlepage}

\singlespace

   \begin{center}
      \MakeUppercase{\@title}\\
      \vskip 32pt
      \@author 
      \vskip 0pt
      \@hometown
      \vskip 32pt
      \@bach
      \vskip 12pt
      \@mast
      \vskip 12pt
      \@masttwo
      \vskip 24pt
      A Dissertation Presented to the Graduate 
      \vskip 0pt
      Faculty of the University of Virginia
      \vskip 0pt
      in Candidacy for the Degree of
      \vskip 0pt
      \@degreename
      \vskip 24pt
      \@department
      \vskip 12pt
      University of Virginia
      \vskip 0pt
      \@degreedate
      \vskip 32pt
      \hspace{3.75truein}\hrulefill \\
      \vskip 0pt
      \hspace{3.75truein}\@commone
      \vskip 20pt
      \hspace{3.75truein}\hrulefill \\
      \vskip 0pt
      \hspace{3.75truein}\@commtwo
      \vskip 20pt
      \hspace{3.75truein}\hrulefill \\
      \vskip 0pt
      \hspace{3.75truein}\@commthree
      \vskip 20pt
      \hspace{3.75truein}\hrulefill \\
      \vskip 0pt
      \hspace{3.75truein}\@commfour
      \vskip 20pt
      \hspace{3.75truein}\hrulefill \\
      \vskip 0pt
      \hspace{3.75truein}\@commfive
      
      \newpage
      \thispagestyle{empty}
      \null
      \vfill
      \copyright Copyright by
      \vskip 10pt
      \@author
      \vskip 10pt
      All rights reserved
      \vskip 10pt
      \@degreedate
      
      
      

   \end{center}
   \end{titlepage}
   \pagenumbering{roman}
   \addtocounter{page}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Internal Formatting Commands For This Thesis Style
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\oldmakechapterhead = \@makechapterhead
\renewcommand{\@makechapterhead}{
   \thispagestyle{myheadings}
   \oldmakechapterhead}

%
% Change name of table of contents

\renewcommand{\contentsname}{Table of contents}

% Change name of bibliography

\renewcommand{\bibname}{References}

% Change the margins to fit requirements

\setlength{\oddsidemargin}{0.5in}  % really 1.5in
\setlength{\evensidemargin}{0.5in}  % really 1.5in
\setlength{\textwidth}{6in}
\setlength{\topmargin}{0in}   % really 1in
\setlength{\headheight}{0.20in}
\setlength{\headsep}{0.20in}
\setlength{\textheight}{8.45in}
\setlength{\footskip}{0.25in}

% Changing where the page numbers go on pages that aren't the first
% page of a chapter.

\pagestyle{myheadings}
\markright{}

% Make the table of contents, etc.,  single spaced

\let\oldtableofcontents = \tableofcontents
\renewcommand{\tableofcontents}{
	\begin{singlespace} 
	\oldtableofcontents 
	\end{singlespace}
}

\let\oldlistoftables = \listoftables
\renewcommand{\listoftables}{
	\begin{singlespace} 
	\oldlistoftables 
	\end{singlespace}
	\addcontentsline{toc}{chapter}{List of Tables} % modification
						       % by bph, the
						       % list needs to
						       % be added in
						       % the toc
}

\let\oldlistoffigures = \listoffigures
\renewcommand{\listoffigures}{
	\begin{singlespace} 
	\oldlistoffigures 
	\end{singlespace}
	\addcontentsline{toc}{chapter}{List of Figures}  % modification
						       % by bph, the
						       % list needs to
						       % be added in
						       % the toc
}

