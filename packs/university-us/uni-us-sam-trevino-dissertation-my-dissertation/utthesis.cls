%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 																	  %
% |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT| %
% |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT| %
% |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT| %
% |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT| %
% |UT.UT.UT.UT.UT.UT."".UT.UT.UT.UT.UT.UT.UT.UT."".UT.UT.UT.UT.UT.UT| %
% |UT.UT.UT.UT."'  	       ".UT.UT.UT.UT."		      '".UT.UT.UT.UT| %
% |UT.UT.UT." 	 		    |UT.UT.UT.UT|			      ".UT.UT.UT| %
% |UT.UT.UT|				|UT.UT.UT.UT|				   |UT.UT.UT| %
% 							|UT.UT.UT.UT|				      		  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%							|UT.UT.UT.UT|							  %
%						  ,".UT.UT.UT.UT.",							  %
%						,.UT.UT.UT.UT.UT.UT.,						  %
%					,,.UT.UT.UT.UT.UT.UT.UT.UT.,,					  %
%			 |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT|			  %
%			 |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT|			  %
%			 |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT|			  %
%			 |UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT.UT|			  %
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%	 T H E S I S   &   D I S S E R T A T I O N    T E M P L A T E  	  %
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
% This template is distributed with ABSOLUTELY NO WARRANTY. It serves 
% as a guideline and constitutes a basic structure for a
% thesis/dissertation. The user assumes full responsibility for 
% formatting and typesetting their document and for verifying that all
% the thesis requirements set by the University of Tennessee are met. 
% Please refer to the most recent UT thesis guide 
% (http://gradschool.utk.edu/thesesdissertations/formatting/) or
% contact the thesis consultant 
% (http://gradschool.utk.edu/thesesdissertations/).
% Please report any bugs to the thesis consultant.
\NeedsTeXFormat{LaTeX2e}%
\def\filename{utthesis.cls}%
\def\fileversion{ver 2.1.0}%
\def\filedate{April 19, 2017}%
\def\contributors{Darrin Weber}%
\typeout{\filename}%
\typeout{\fileversion}%
\typeout{Updated by Darrin Weber}%
\typeout{\filedate}%
\typeout{Many parts and settings of this class are based on the template provided by David L. Page and updated by Tony Saad.}
%------------------------------------------------------------------------%
\ProvidesClass{utthesis}
% some internal variables
\def\thesisID{1}%
\def\dissertationID{2}%
\def\theDocumentType#1{\gdef\@theDocumentType{#1}}%
\def\documentID#1{\gdef\@documentID{#1}}% documentID is either 1 (for thesis) or 2 (for dissertation)
% declare package options
\DeclareOption{thesis}{%
    \def\@theDocumentType{thesis}%
    \def\@documentID{\thesisID}}%
\DeclareOption{dissertation}{%
    \def\@theDocumentType{dissertation}%
    \def\@documentID{\dissertationID}}%
\DeclareOption{linespacing}{\@lnspacing}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{color}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}%
\ExecuteOptions{dissertation,letterpaper,12pt}% execute default options
\ProcessOptions%
\LoadClass{report} % single-sided
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	Main Definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\copyrightYear#1{\gdef\@copyrightYear{#1}}%
\def\graduationMonth#1{\gdef\@graduationMonth{#1}}%
\def\degree#1{\gdef\@degree{#1}}%
\def\university#1{\gdef\@university{#1}}%
% initialize macros
\def\@title{My Title}
\def\@author{My Name}
\def\@graduationMonth{May}
\def\@copyrightYear{2017}
\def\@degree{Doctor of Philosophy}	% degree type
\def\@university{The University  of Tennessee, Knoxville}	% school
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	LOAD PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsmath,amsthm,amssymb}     % AMS math, AMS theorem, AMS fonts
\RequirePackage{setspace}                   % line spacing
\RequirePackage[vcentering,dvips]{geometry}	% help with margins
\RequirePackage[pdftex,plainpages=false,pdfpagelabels=true,breaklinks=true,pagebackref]{hyperref} % for pdf bookmarks
\RequirePackage{color}
%-------------------------------------------------------------------------%
% define theorem, corollary, lemma, proposition, and definition environments
\theoremstyle{plain}
\newtheorem*{theorem*}{Theorem}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{definition}[theorem]{Definition}
%-------------------------------------------------------------------------%
% allow empty pages before chapters (i.e. no page numbers)
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage
%-------------------------------------------------------------------------%
\hypersetup{%
	bookmarksnumbered = true,
	pdftitle={\@title},
	pdfauthor={\@author},
	pdfpagelayout=SinglePage,
    bookmarksopen=False,
	%pdfview=FitV,
	pdfborder=0 0 0, 		% make all links invisible, so the pdf looks good when printed	
    pdffitwindow=true,      % window fit to page when opened
    %pdfstartview={FitV},   % fits the width of the page to the window
    pdfcreator={\@author},  % creator of the document
    pdfnewwindow=true,      % links in new window
    colorlinks=true,        % false: boxed links; true: colored links
    linkcolor=blue,         % color of internal links
    citecolor=magenta,      % color of links to bibliography
    filecolor=magenta,      % color of file links
    urlcolor=cyan           % color of external links
}
%-------------------------------------------------------------------------%
\geometry{
    letterpaper,
    left = 1.0in,
    right = 1.0in,
    top = 1.0in,
    bottom = 1.0in
}
%\hyphenation{example, pa-ra-me-ter} % Over-ride Latex hyphenation, define hyphenated words
\hyphenpenalty=5000	% reduce hyphenation as much as possible
\tolerance=1000     % goes with the previous command
% Widow/orphan protection
\clubpenalty=10000    % Minimize orphans orphans(eliminate 10000)
\widowpenalty=10000   % Minimize widows
\brokenpenalty=10000  % Do not allow hyphen across pages
% Use cool footnotes
\renewcommand{\thefootnote}{\arabic{footnote}}
\raggedbottom
\pagestyle{plain}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	Define Title Page Format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeTitlePage} {
	\thispagestyle{empty}
    \begin{spacing}{1.5}
	\vspace*{0.3in}
	\begin{center}
		\huge
		\bf
		\@title
        \vfill
		\Large \rm
        \ifnum\@documentID=\thesisID {
            A Thesis Presented for the

            \@degree
        } \else {
            A Dissertation Presented for the

            \@degree
        } \fi
		
		Degree
		
		\@university
		
		\vspace*{1.0in}%
		
		\@author %
		\\%
		\@graduationMonth\ \@copyrightYear
	\end{center}
    \end{spacing}
    \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand*\contentsname{Table of Contents} %Changes the heading of the Table of Contents from the default "Contents" to "Table of Contents"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	Define Appendix Page Format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeAppendixPage}[1]{
    \newpage
    \renewcommand{\thesection}{\Alph{section}}
    \ifnum#1=1
    	\addToTOC{Appendix}
    	\vspace*{2.0in}
    	\begin{center}
    		\Huge \bf{Appendix} 
    	\end{center}
	\else
	    \addToTOC{Appendices}
	    \vspace*{2.0in}
	    \begin{center}
	    	\Huge \bf{Appendices}
	    \end{center}
	\fi
    \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	Define Bibliography Page Format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeBibliographyPage}{
    \newpage % create a new page for the bibliography title
    \addToTOC{Bibliography} % add bibliography to table of contents
    \vspace*{2.0in} % move down the page 2.0 inches
    \begin{center}\Huge\bf{Bibliography}\end{center} % make the bibliography title
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% addToTOC: macro that adds an entry to the table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand {\addToTOC}[1] {
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{#1}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Define bibliography command that will be called in dissertation file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand {\utbiblio}[3] {
        \begingroup
        \def\chapter*#1{}
        \bibliographystyle{#2}
        \bibliography{#3}
        \endgroup
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% addToPDFBookmarks: macro that adds a bookmark to the PDF file
%                   without including it in the table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand {\addToPDFBookmarks}[3] {
	\cleardoublepage
	\phantomsection
	\pdfbookmark[#1]{#2}{#3}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% makeCopyrightPage: this macro will make the copyright page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand {\makeCopyrightPage} {
    \vspace*{4in}
    \begin{center}
        \copyright\ by \@author, \@copyrightYear \\
        All Rights Reserved.
    \end{center}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput 
