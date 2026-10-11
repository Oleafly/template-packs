% class file UMassThesis_14.cls
% ----------------------------------------------------------------------------
%
% In what follows, "Standards-UMB" refers to "Standards for the Preparation of
% Theses and Dissertations at the University of Massachusetts Boston,"
% version May 2023. You should be able to download this, as a pdf, in one of the 
% following three ways:
%
% Historically, the most reliable option to find this document is to Google the 
% following search string:
% 
% standards theses site:www.umb.edu
% 
% As of 2025/01/14, the very first result is the standards pdf document.
%
% 2. Alternatively, you can try this direct link:
%
% https://www.umb.edu/media/umassboston/content-assets/admissions/graduate-students/UMass_Boston_Dissertation_Thesis_Submission_Standards_(Revised_May_2023)_1.pdf .
%
% 3. Finally, you can try to navigate there from the UMass Boston home page as follows: 
% Admissions -> Graduate Students -> Graduate Student Resources & Assistantships . 
% On that page, near the bottom of the page, under 'Theses and Dissertations', click 
% on 'Standards for the Preparation of Theses and Dissertations at the UMass Boston'. 
% 
%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{UMassThesis14}[2015/07/25 UMassThesis01; revised 2021/04/27, 2022/11/26, 2025/02/17, 2025/03/06]


% this is for testing purposes only (testing the positioning of front matter material)
\newif\iftestA
\newcommand{\testword}{WTQIENDEOJFPQJENTHDGWOJEIASBRKKDWPOLWQNGDHYEI}
% \testAtrue
\testAfalse


% This LaTeX class is based on the standard LaTeX 'report' class (report.cls), which we will load in a moment, once we process some options.

% To help us handle options, we will be using a particular type of LaTeX conditionals, those introduced by \newif . 
% For an explanation of how they work, see https://en.wikibooks.org/wiki/LaTeX/Plain_TeX#Self_defined_conditionals

% The options themselves are handled by \DeclareOption, \PassOptionsToPackage, \ExecuteOptions, and \ProcessOptions\relax .
% For an explanation of how they work, see https://en.wikibooks.org/wiki/LaTeX/Creating_Packages

\newif\ifamsthm % This conditional will allow us to control whether the package 'amsthm' is loaded.

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% options controlling the loading of the package 'amsthm' %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\DeclareOption{amsthm}{\amsthmtrue} % if this option is invoked, LaTeX will execute \amsthmtrue. That will, in the code below, through \ifamsthm, cause  the 'amsthm' package to be loaded.
\DeclareOption{noamsthm}{\amsthmfalse} % if this option is invoked, LaTeX will execute \amsthmfalse. That will, in the code below, through \ifamsthm, cause  the 'amsthm' package to NOT be loaded.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% options controlling the justification %%%%%%%%%%%%%%%%%%%%
%%%%%%%%% (especially the loading of the package 'ragged2e') %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newif\ifJustified 
\DeclareOption{justified}{\Justifiedtrue} 
\DeclareOption{raggedright}{\Justifiedfalse}
\DeclareOption{flushleft}{\Justifiedfalse} % same as 'raggedright'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% options controlling whether \sloppy %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% is applied to the formating of the names of chapters, %%%%%%%%%%
%%%%%%%%% sections, subsections, and subsubsections in the %%%%%%%%%%%%%%%
%%%%%%%%% Table of Contents, and to the formatting of the names %%%%%%%%%%
%% of figures and tables in the List of Tables and the List of Figures %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newif\ifChapSloppy 
\DeclareOption{ChapSloppy}{\ChapSloppytrue}
\DeclareOption{noChapSloppy}{\ChapSloppyfalse}
\newif\ifSecSloppy 
\DeclareOption{SecSloppy}{\SecSloppytrue}
\DeclareOption{noSecSloppy}{\SecSloppyfalse}
\newif\ifSubSecSloppy 
\DeclareOption{SubSecSloppy}{\SubSecSloppytrue}
\DeclareOption{noSubSecSloppy}{\SubSecSloppyfalse}
\newif\ifSubSubSecSloppy
\DeclareOption{SubSubSecSloppy}{\SubSubSecSloppytrue}
\DeclareOption{noSubSubSecSloppy}{\SubSubSecSloppyfalse}
\newif\ifFigTabSloppy \FigTabSloppyfalse
\DeclareOption{FigTabSloppy}{\FigTabSloppytrue}
\DeclareOption{noFigTabSloppy}{\FigTabSloppyfalse}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% options passed to amsmath %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 'amsmath' is required by 'newtxmath', and the latter is the main package that makes the math font go well with Times New Roman. 
% (Well, with a clone of Times New Roman, which is set as the document font by the 'newtxtext' package. And newtxtext is the recommended package for setting the document in (a clone of) the Times New Roman font.) 
% This is why it would be impractical to try to avoid loading amsmath---we would need to find some other source of math fonts, and newtxmath is the currectly recommended one.
% These are all the options available in amsmath. 
%
\DeclareOption{intlimits}{\PassOptionsToClass{amsmath}{intlimits}}
\DeclareOption{nointlimits}{\PassOptionsToClass{amsmath}{nointlimits}}
\DeclareOption{sumlimits}{\PassOptionsToClass{amsmath}{sumlimits}}
\DeclareOption{nosumlimits}{\PassOptionsToClass{amsmath}{nosumlimits}}
\DeclareOption{namelimits}{\PassOptionsToClass{amsmath}{namelimits}}
\DeclareOption{nonamelimits}{\PassOptionsToClass{amsmath}{nonamelimits}}
\DeclareOption{leqno}{\PassOptionsToClass{amsmath}{leqno}}
\DeclareOption{reqno}{\PassOptionsToClass{amsmath}{reqno}}
\DeclareOption{centertags}{\PassOptionsToClass{amsmath}{centertags}}
\DeclareOption{tbtags}{\PassOptionsToClass{amsmath}{tbtags}}
\DeclareOption{cmex10}{\PassOptionsToClass{amsmath}{cmex10}}
\DeclareOption{fleqn}{\PassOptionsToClass{amsmath}{fleqn}}
\DeclareOption{alignedleftspaceyes}{\PassOptionsToClass{amsmath}{alignedleftspaceyes}}
\DeclareOption{alignedleftspaceno}{\PassOptionsToClass{amsmath}{alignedleftspaceno}}
\DeclareOption{alignedleftspaceyesifneg}{\PassOptionsToClass{amsmath}{alignedleftspaceyesifneg}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifAltSigSpacing
\AltSigSpacingfalse
\DeclareOption{altsigspacing}{\AltSigSpacingtrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} % any other options should be just passed to the 'report' class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% processing the options %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExecuteOptions{justified,amsthm,noChapSloppy,noSecSloppy,noSubSecSloppy,SubSubSecSloppy,noFigTabSloppy} % these options will get executed no matter what. Because of how these are coded, these will serve as default values
\ProcessOptions\relax % executes the options that were actually invoked


\LoadClass[12pt,letterpaper,portrait]{report}

\RequirePackage{amsmath}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% justification: justified or flush left (a.k.a. ragged right) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This block handles the loading (or lack thereof) of the package ragged2e, and also the loading of the package 'footmisc' (because 'ragged2e' loads it).
% If we want the document to be flush left (a.k.a. ragged right), we load the package 'ragged2e'.
% The 'footmisc' package allows us to customize the appearance of footnotes.

% A previous edition of the Standards-UMB had the following guideline (2012 edition, p. 11):
%
%         JUSTIFICATION: Do not justify the right hand margin of the page, because almost all
%         word processors achieve this justification by creating irregular spaces between words.
%         This irregular spacing is not acceptable.
%
% However, this recommendation is gone in the 2019 edition (which, as of Fall 2022, is the current edition). And in any event, LaTeX, especially when used with the 'microtype' package, does an excellent job of evening out these irregular spaces between words. Consequently, the default behavior of this class is to produce a justified document. If, for some reason, you nevertheless want it to be flush left, invoke the class either with the option 'raggedright' or with the option 'flushleft' (they are just aliases).

% In the following block, we will use \ifJustified, which was defined during the processing of options, above.
% When \ifJustified is true (which is the default for our class), then we want the document to be flush left. This is accomplished by loading the package 'ragged2e'. 
%
% It turns out that if the package 'ragged2e' is loaded with option 'document' (as we will do), this will also cause the package 'footmisc' to be loaded, with the option 'ragged'. 
%
% Now, we would also like 'footmisc' to be loaded with the option 'bottom', which forces footnotes (but not the floats) to the bottom of the page. It turns out that we can do that by adding 'bottom' as an option when loading 'ragged2e'; that package then passes that option to 'footmisc' when it calls it.

% The package 'ragged2e' also sets \parindent to 0pt, so that paragraphs would not be
% indented. However, the command "\setlength{\parindent}{\oldparindent}" 
% below, right after "\begin{document}, resets \parindent to its normal 
% value.
%
%

% here we use \ifJustified. If \ifJustified evaluates to 'true' (which will be so by default), then we will not load the package 'ragged2e'. On the other hand, it evaluates to 'false' (which will be so if the class UMassThesis_02 is loaded with the option 'raggedright' or its alias, the option 'flushleft'), we will load the package 'ragged2e' with the appropriate options. In either case, we need to define appropriately the command \JustificationTypeInCaption, which is used in the main document.

\newlength{\oldparindent}
\setlength{\oldparindent}{\parindent}
\ifJustified
    % the document should be justified, so we do not load ragged2e.
   \newcommand{\JustificationTypeInCaption}{justified}
% We didn't load ragged2e (which would, because of the option 'document, also load the package 'footmisc'), but nevertheless, we do want the footnotes to be at the bottom of the page. Thus, we need to load 'footmisc' ourselves, with the option 'bottom'
   \RequirePackage[bottom]{footmisc}
\else
% the document should be flush left, so we load ragged2e
   \RequirePackage[document,bottom]{ragged2e}
   \newcommand{\JustificationTypeInCaption}{RaggedRight}
\fi
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the package 'setspace'. We will use it to regulate which parts of the 
% document are double-spaced (most of it), and which use some other spacing
%
\RequirePackage{setspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% The default behavior is that the first paragraph after the section header is
% NOT indented (whereas the subsequent paragraphs are). This package makes 
% it so that all paragraphs are indented, including the first.
%
\RequirePackage{indentfirst}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% the purpose of the package "fontenc" is explained here:
%
% http://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
%
\RequirePackage[T1]{fontenc}
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% setting the document font to be (a clone of) Times New Roman %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% handling the packages 'amsthm' and 'amssymb' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% the LaTeX default font is Knuth's 'Computer Modern' font. But Standards-UMB
% requires that the document be typeset in the Times New Roman font. 

% As of 2021, the recommended way to change the text font to (a free clone of)
% Times New Roman is to use the 'newtx' package. 

% if you want to use the package 'amsthm', you need to use load it before 'newtxtext', here:

\ifamsthm\RequirePackage{amsthm}\fi

% (see the documentation for newtx, http://mirrors.ctan.org/fonts/newtx/doc/newtxdoc.pdf ;
% search for 'amsthm').

% Here we load newtx. It consists of newtxtext (for setting the text font) and 
% newtxmath (for setting the math font). In principle, you can load one of them 
% and not the other, if you want a different combination of text and 
% math fonts. But these two are designed to work well together. Read newtxdoc.pdf 
% for other options. However, keep in mind that Standards-UMB requires Times New Roman
% for the text font. The package newtxtext selects the font 'TeXGyre Termes', 
% a free (near) clone of Times New Roman.




\newcommand\hmmax{0} % (sometimes) needed if using newtx, especially if the package 'bm' is used  
\newcommand\bmmax{0} % (sometimes) needed if using newtx, especially if the package 'bm' is used 
\RequirePackage[scaled=1.03]{newtxtext} % part of newtx; needs \newcommand\hmmax{0} and \newcommand\bmmax{0},above
\RequirePackage[scaled=1.03]{newtxmath} % part of newtx; needs \newcommand\hmmax{0} and \newcommand\bmmax{0},above

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% dealing with 'amssymb'  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% (given that we are using 'newtxtext' and  'newtxmath') %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The package 'newtxmath', which we've just loaded, has an unusual relationship to the package 'amssymb'. 
% Namely, 'newtxmath' defines every symbol that 'amssymb' does.
% The reason is that the glyphs in 'amssymb' are designed to go with Computer Modern font, whereas the corresponding symbols in 'newtxmath' are designed to match Times New Roman. Since we are using 'newtxtext' and 'newtxmath' precisely for making the document font be (a clone of) Times New Roman, it makes sense to use the 'newtxmath' version of these symbol fonts. Moreover, if you try to load 'amssymb' after loading 'newtxmath', LaTeX will report an error.
%
% At first glance, it seems that it is simple to handle all this: just don't load 'amssymb' if you're going to use newtxtmath!
%
% However, the problem is that there are some other packages that require 'amssymb', in the sense that they execute the command \RequirePackage{amssymb}. (Examples of such packages include 'dynkin-diagrams','phfqit', and some others.) An attempt to load 'amssymb' like that (after loading 'newtxmath') will result in an error, as we've already noted. 
%
% So how can we use these packages that attempt to load 'amssymb'? One solution is to make LaTeX 'think' that the 'amssymb' package has already been loaded even though it actually hasn't been. (This should be safe since all the symbols in 'amssymb' will be defined anyway.) Then any subsequent calls of \RequirePackage{amssymb} and \usepackage{amssymb} won't do anything.
%
% This is exaclty what the command \dontusepackage will do. First, we define it here (from https://tex.stackexchange.com/a/39418/192504 ):

\newcommand{\dontusepackage}[2][]{%
  \@namedef{ver@#2.sty}{9999/12/31}%
  \@namedef{opt@#2.sty}{#1}}

% And now we use it on 'amssymb':

\dontusepackage{amssymb}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
\RequirePackage{calc}
%


%%%%%%%%%%%%%%%%%%%%%%%%%% setting up the layout of the pages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% using the 'geometry' package %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This loading of the package "geometry," together with the options given,
% sets the basic layout of the pages of the document---the document margins
% and some other stuff---so that it conforms to the Standards-UMB.
%
%
%  On p. 11 of the Standards-UMB, section "PAGINATION," it is stated that
% "[a]ll page numbers must be at least 1.25'' from the bottom of the page
% (measured from the bottom of the page number to the bottom of the 
% page)..."
% Moreover, on p. 12, it is stated that the bottom margin should be 1.25 in.
%

\newlength{\ExpectedBaselineSkip}
\setlength{\ExpectedBaselineSkip}{24pt}


% Remember that footnotes, despite their name, don't go into the footer. Footnotes go to the bottom of the page, but in such a way that the space occupied by a footnote would be occupied by regular text if the footnote was absent.
%
% In contrast, if the main text has a footer, it is by default present on every page (except possibly some special pages such as the first page of a chapter, the page announcing a different 'part', and so on). A footer may contain items such as the page number, or a 'running foot' containing some unchanging text or graphics. The footer appears below the text, and so below any footnotes.
%
% In the 'geometry' package, 'footskip' is the distance between the baseline of any text in the footer (e.g. the page number) and the baseline of the last line of the text on the same page. 



\RequirePackage[paper=letterpaper,includefoot=true,left=1.25in,right=1in,top=1in,bottom=1.25in,footskip=1.5\ExpectedBaselineSkip,portrait]{geometry}



% if the page number needs to be typeset in a special way:
% \patchcmd{\ps@plain}{\thepage}{\textcolor{red}{\thepage}}{}{} % makes the page numbers red
% \patchcmd{\ps@plain}{\thepage}{page~\raisebox{0.1\ExpectedBaselineSkip}{\thepage}}{}{} % typesets 'page' and then the page number, slightly raised.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we will use the textpos package for the positioning of the
% various items in the 'front matter' of the thesis (i.e. in the
% Title Page, Copyright Page, Signatory Page, and Abstract.
\usepackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1bp}%
\setlength{\TPVertModule}{1bp}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following commands are defined the same way that standard LaTeX defines the \author command, which is
%  \DeclareRobustCommand*\author[1]{\gdef\@author{#1}}
% The name of the author is thus stored in the variable \@author .
% Similarly, the standard LaTeX definition for \title is
% \DeclareRobustCommand\title[1]{\gdef\@title{#1}}

\DeclareRobustCommand*\AuthorDegrees[1]{\gdef\@AuthorDegrees{#1}}
\DeclareRobustCommand*\DirectedBy[1]{\gdef\@DirectedBy{#1}}
\DeclareRobustCommand*\ProgramName[1]{\gdef\@ProgramName{#1}}
\DeclareRobustCommand*\ThesisOrDissertation[1]{\gdef\@ThesisOrDissertation{#1}}
\DeclareRobustCommand*\DegreeName[1]{\gdef\@DegreeName{#1}}
\DeclareRobustCommand*\ProgramDirector[1]{\gdef\@ProgramDirector{#1}}
\DeclareRobustCommand*\DeptChairperson[1]{\gdef\@DeptChairperson{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% from the documentation for the package 'textcase': The textcase package offers commands \MakeTextUppercase and \MakeTextLowercase, which are similar to the standard \MakeUppercase and \MakeLowercase, but they do not change the case of any sections of mathematics, or the arguments of \cite, \label and \ref commands within the argument.
% Starting with the LaTeX distribution of June, 2022, the LaTeX commands MakeUppercase and \MakeLowercase been updated and they are identical to \MakeTextUppercase and \MakeTextLowercase
\usepackage{textcase}
%
%

% The following is experimental. It would be used if thesis/dissertation were in the 'multi-monograph (alternative) format'. This class currently assumes that the thesis/dissertation is in the 'traditional format'
% \usepackage{multibib}
% \newcites{citations}{CITATIONS}
% \newcites{references}{LIST OF REFERENCES}
% \let\oldcite\cite
% \renewcommand{\cite}[1]{\citecitations{#1}\nocitereferences{#1}}

% We need to change the name of the bibliography section to "CITATIONS", as
% required by Standards-UMB
%
% \renewcommand{\bibname}{CITATIONS}
%

% The following will include the bibliography (i.e. CITATIONS) in the Table of Contents.
% The option 'nottoc' is needed to prevent the inclusion of the Table of Contents 
% itself into the Table of Contents. 
% \usepackage[nottoc]{tocbibind} 
%
%
\newenvironment{UMBbibliography}[1]{
\addcontentsline{toc}{chapter}{CITATIONS}
\titleformat{\chapter}[display]{\normalfont\center}{}{0in}{}
\titlespacing*{\chapter}{0in}{-1.8\baselineskip}{3\baselineskip}
\begin{thebibliography}{#1}}
{\end{thebibliography}}
%
% We need to modify the default appearance of chapter headings in the body
% matter so that they conform to the Standards-UMB (i.e. so that they are 2 in
% from the top edge of the page, they say CHAPTER so-and-so, then skip
% doublespace, then the chapter name, and then some further skipping before
% the first paragraph). We use the package "titlesec" to accomplish this. 
%
\RequirePackage[newparttoc]{titlesec}
% \titleformat{\chapter}[display]{\center}{CHAPTER \thechapter}{0.5\baselineskip}{\MakeTextUppercase}
\titleformat{\chapter}[display]{\center}{\Chapterls{CHAPTER \thechapter}}{0.5\baselineskip}{}
\titlespacing{\chapter}{0in}{0.45in}{1.5\baselineskip}


\titleformat{\part}[display]
{\thispagestyle{empty}\huge\centering}
{\MakeTextUppercase{\partname}\nobreakspace\thepart.}
{0pt}
{\huge}


%\titleformat{\chapter}[display]{\rm\center}{CHAPTER \thechapter}{0.3in}{}

%\titlespacing*{\chapter}{0in}{0.52in}{0.3in}

\titleformat{\section}{}{\thesection}{0.17in}{}

\titleformat{\subsection}{\itshape}{\thesubsection}{0.17in}{}

\titleformat{\subsubsection}{\bfseries}{}{0.17in}{}
% \titleformat{\subsubsection}{\normalfont}{}{0.17in}{}
%
% We define a new chapter-like section, namely "topmatter". In this thesis,
% we use it only for the acknowledgment section. Most of the code concerns the
% appearance in the table of contents (the \addtocontents{toc} and
% \addcontentsline{toc} commands.) The \cftchapdotsep and \cftchapafterpnum
% are used by the "tocloft" package, which is the package we will use to
% fine-tune the formatting of the table of contents and the table of
% figures.
%
\titleformat{name=\chapter, numberless}[block]
{\normalfont\filright}
{}
{0ex}
{}%[\raisebox{1cm}{}]
\titlespacing{name=\chapter, numberless}{0pt}{-\baselineskip}{26.9pt}


% \newcommand{\oldcftchapdotsep}{}


\newcommand{\topmatter}[1]{
% \renewcommand{\oldcftchapdotsep}{\cftchapdotsep}
\clearpage
\pagestyle{plain}
\begin{center}
% \textls[500]{\MakeUppercase{#1}}
\MakeUppercase{#1}
\end{center}
% \addtocontents{toc}{\protect\renewcommand{\protect\cftchapafterpnum}{}}


% \titlecontents{chapter}[0bp]{\normalfont}%
%     {\contentslabel{0bp}\MakeTextUppercase}%
%     {\hspace*{-0bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}

% Current:
\titlecontents{chapter}[0bp]{\normalfont}%
    {\contentslabel{0bp}}%
    {\hspace*{-0bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
%


\addcontentsline{toc}{chapter}{#1}
\addtocontents{toc}{\protect\addvspace{12bp}}
% \addtocontents{toc}{\protect\renewcommand{\protect\cftchapafterpnum}{
% \hbox{\hspace{\ToCPageNumToRightMargin}}
% }}
}
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% setting the table of contents (ToC), the list of figures (LoF),
%%%%%%%% and the list of tables (LoT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% \RequirePackage{hanging} % for hanging parapgraphs for entries in ToC, LoF, and LoT (command \hangpara)

% \RequirePackage{tocloft} % this package *can* be used, but it not recommended to be used at the same time as 'titlesec'. 
\RequirePackage{titletoc} % given that we are using 'titlesec', it is recommended we use this companion package.
%
%
\def\ToCName{Table of Contents}
\def\LoFName{List of Figures}
\def\LoTName{List of Tables}
\def\LoFandTName{List of Figures and Tables}
\def\RefName{List of References}

\iftestA
\renewcommand{\contentsname}{\mbox{}\hfill\testword\hfill\mbox{}}


\renewcommand{\listfigurename}{\mbox{}\hfill\testword\hfill\mbox{}}
\renewcommand{\listtablename}{\mbox{}\hfill\testword\hfill\mbox{}}
\else
\renewcommand{\contentsname}{\mbox{}\hfill \ToCListls{\MakeUppercase{\ToCName}}\hfill\mbox{}}
\renewcommand{\listfigurename}{\mbox{}\hfill\ToCListls{\MakeUppercase{\LoFName}}\hfill\mbox{}}
\renewcommand{\listtablename}{\mbox{}\hfill\ToCListls{\MakeUppercase{\LoTName}}\hfill\mbox{}}
\fi

% According to the Standards-UMB, the TOC should look e.g. like this:
%
% ACKNOWLEDGMENTS ......................................     v
%
% LIST OF FIGURES ......................................     x
%
% LIST OF ABBREVIATIONS.................................  xiii
%
% CHAPTER                                                 Page
%
%    1. INTRODUCTION ...................................    1
%           Goals of the Study..........................    3
%
%
% Note that the page numbers v, x, xiii, and "Page" are all
% right-justified, but the page numbers 1 and 3 are indented
% a bit from the right. Here this is presented so that they
% are vertically aligned with the "g" of "Page", rather than
% with the "e". In fact, in the sample TOC in the Standards-UMB
% document itself, they are vertically aligned with a point
% in between the letters "g" and "e". In other words, with
% page numbers below 'Page', there is a little gap between the 
% page number and the right margin.
%
% Let's store the length of that gap into a new length,
% which we'll call \ToCPageNumToRightMargin :

\newlength{\ToCPageNumToRightMargin}
\setlength{\ToCPageNumToRightMargin}{\widthof{e}}

% The length \ToCDottedLineRightMargin is regulates how far the dotted line
% goes to the right; it is the distance between the last dot
% and the right margin.
\newlength{\ToCDottedLineRightMargin}
\setlength{\ToCDottedLineRightMargin}{\widthof{Page}}


\newlength{\ToCTextRightMarginRelativeToRightEndOfDots}
% \setlength{\ToCTextRightMarginRelativeToRightEndOfDots}{70bp}
\setlength{\ToCTextRightMarginRelativeToRightEndOfDots}{74bp}
\contentsmargin[\ToCTextRightMarginRelativeToRightEndOfDots]{\ToCDottedLineRightMargin}





% These two are auxilliary lengths that help us make the section labels (like '2.1') flush right. By default, they are flush left.
\newlength{\WidthA}\newlength{\WidthB}

% These length regulate various marging and indentations. Their names should give a pretty good idea of what they do, but the best way to see what each does is to change it slightly and see the effect
\newlength{\ToCTextOverhang}
\newlength{\ToCIndentChapterText}
\newlength{\ToCFurtherIndentSection}
\newlength{\ToCFurtherIndentSubSection}
\newlength{\ToCFurtherIndentSubSubSection}
\newlength{\ToCLabelShift}
\newlength{\ToCLabelShiftChExtra}

\setlength{\ToCTextOverhang}{12pt}
\setlength{\ToCIndentChapterText}{43bp}
\setlength{\ToCFurtherIndentSection}{4em}
\setlength{\ToCFurtherIndentSubSection}{4.5em}
\setlength{\ToCFurtherIndentSubSubSection}{4em}
\setlength{\ToCLabelShift}{8bp}
\setlength{\ToCLabelShiftChExtra}{1.5bp}

\titlecontents{section}[\ToCIndentChapterText+\ToCFurtherIndentSection]{\hangindent\ToCTextOverhang\noindent\ifSecSloppy\sloppy\fi\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\mbox{}\hspace{-\WidthA}\thecontentslabel%
    ]{\ToCLabelShift}}%
    {\hspace*{-\ToCLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}



\titlecontents{subsection}[\ToCIndentChapterText+\ToCFurtherIndentSection+\ToCFurtherIndentSubSection]{\hangindent\ToCTextOverhang\noindent\ifSubSecSloppy\sloppy\fi\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\mbox{}\hspace{-\WidthA}\thecontentslabel%
    ]{\ToCLabelShift}}%
    {\hspace*{-\ToCLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}
    
\titlecontents{subsubsection}[\ToCIndentChapterText+\ToCFurtherIndentSection+\ToCFurtherIndentSubSection+\ToCFurtherIndentSubSubSection]%
% {\mbox{}\hspace{0in}\normalfont}%
{\hangindent\ToCTextOverhang\noindent\ifSubSubSecSloppy\sloppy\fi\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\mbox{}\hspace{-\WidthA}\thecontentslabel%
    ]{\ToCLabelShift}}%
    {\hspace*{-\ToCLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


    
\titlecontents{part}[1in]{\normalfont\mbox{}\hspace{0.8in}\mbox{}\hfill}%
{\contentslabel[%
% \setlength{\WidthA}{\widthof{\thecontentslabel}}\setlength{\WidthB}{\WidthA+1in}\mbox{}\hspace{-\WidthB}
PART~\thecontentslabel.%
]{43bp}}%
{\hspace*{-43bp}}%
{\hfill\mbox{}}

    




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following commands make it so that in the figure 
% captions, we have correct left-justification of the figure and subfigure 
% labels (in other words, of "Figure" for the main caption, and of the "(a)", % "(b)", etc. labels for the subcaptions). Namely, without intervention, 
% "Figure" and "(a)" etc. appear indented in the captions. The commands 
% "\hspace{-3ex}" and "\hspace{-4ex}" correct for that.
%
% Unless the 'justified' option was invoked when loading the class package, \JustificationTypeInCaption will be equal to 'RaggedRight'. This type of justification is provided by the ragged2e package, which the UMassThesis_01 class has already loaded (again, unless the 'justified' option was invoked).
% On the other hand, if  'justified' option was invoked, then \JustificationTypeInCaption will be equal to 'justified'.



% \RequirePackage{caption}
\RequirePackage{subcaption} % This package allows us to format the captions of figures and subfigures. It loads the package 'captions', too.

\DeclareCaptionFormat{MyPlain}{#1#2#3\par\addtocontents{lof}{\protect\addvspace{10pt}}\addtocontents{lot}{\protect\addvspace{10pt}}}

\captionsetup{margin=0.25in,format=MyPlain,labelformat=simple,justification=justified,font={singlespacing,small}}

% \captionsetup{margin=0.25in,format=plain,labelformat=simple,justification=\JustificationTypeInCaption,font={singlespacing,small}}
%
% \renewcommand{\figurename}{\normalfont \mbox{}\hspace{-3ex}Figure}
\renewcommand{\figurename}{\normalfont Figure}
%
\DeclareCaptionLabelFormat{left-justify_label}{\mbox{}\hspace{-4ex}(#2)} 
%


\newlength{\FigMainIndent}\setlength{\FigMainIndent}{\ToCIndentChapterText}
\newlength{\TablMainIndent}\setlength{\TablMainIndent}{\ToCIndentChapterText}
% \setlength{\FigMainIndent}{1in}
% \setlength{\FigMainIndent}{49.3bp+10pt}
\newlength{\FigPullIndent}\setlength{\FigPullIndent}{2em}
\newlength{\TablPullIndent}\setlength{\TablPullIndent}{2em}
\newlength{\FigLabelShift}\setlength{\FigLabelShift}{8bp}
% \setlength{\FigLabelShift}{23bp}
% \setlength{\FigLabelShift}{33bp}
\newlength{\TablLabelShift}\setlength{\TablLabelShift}{8bp}
\newlength{\LoFExtraPageNumToRightMargin}\setlength{\LoFExtraPageNumToRightMargin}{0bp}
% \setlength{\LoFExtraPageNumToRightMargin}{25.96bp}
\newlength{\LoTExtraPageNumToRightMargin}\setlength{\LoTExtraPageNumToRightMargin}{0bp}
\newlength{\LoFPageNumToRightMargin}\setlength{\LoFPageNumToRightMargin}{\ToCPageNumToRightMargin+\LoFExtraPageNumToRightMargin}
\newlength{\LoTPageNumToRightMargin}\setlength{\LoTPageNumToRightMargin}{\ToCPageNumToRightMargin+\LoTExtraPageNumToRightMargin}
\newlength{\LoFExtraRightMargin}\setlength{\LoFExtraRightMargin}{1in}
\newlength{\LoTExtraRightMargin}\setlength{\LoTExtraRightMargin}{1in}
% \newlength{\LoFDottedLineRightMargin}\setlength{\LoFDottedLineRightMargin}{\ToCPageNumToRightMargin+\LoFExtraRightMargin-\LoFExtraPageNumToRightMargin+\widthof{Page}-\widthof{P}*\real{0.5}}
% \newlength{\LoTDottedLineRightMargin}\setlength{\LoTDottedLineRightMargin}{\ToCPageNumToRightMargin+\LoTExtraRightMargin-\LoTExtraPageNumToRightMargin+\widthof{Page}-\widthof{P}*\real{0.5}}




\setlength{\LoFPageNumToRightMargin}{\LoFExtraPageNumToRightMargin+\ToCPageNumToRightMargin*\real{0.75}}
\setlength{\LoTPageNumToRightMargin}{\LoTExtraPageNumToRightMargin+\ToCPageNumToRightMargin*\real{0.75}}

\titlecontents{figure}[\FigMainIndent]{\contentsmargin[\ToCTextRightMarginRelativeToRightEndOfDots]{\dimexpr \ToCDottedLineRightMargin+\LoFExtraPageNumToRightMargin}%
\hangindent\FigPullIndent\noindent\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \mbox{}\hspace{-\WidthA}%
    \thecontentslabel]{\FigLabelShift}}%
    {\hspace*{-\FigLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hspace{\LoFPageNumToRightMargin}]}

\titlecontents{table}[\TablMainIndent]{\contentsmargin[\ToCTextRightMarginRelativeToRightEndOfDots]{\dimexpr \ToCDottedLineRightMargin+\LoTExtraPageNumToRightMargin}%
\hangindent\TablPullIndent\noindent\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \mbox{}\hspace{-\WidthA}%
    \thecontentslabel]{\TablLabelShift}}%
    {\hspace*{-\TablLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hspace{\LoTPageNumToRightMargin}]}


% this is, in effect, a change in the command \chapter, made to prevent extra vertical
% spaces appearing in the list of figures between chapters
%
% \newcommand{\UMBchapter}[1]{\chapter{\protect\MakeTextUppercase{#1}}\addtocontents{lof}{\protect\addvspace{-10pt}}}
% \newcommand{\UMBchapter}[1]{\chapter{\MakeTextUppercase{#1}}\addtocontents{lof}{\protect\addvspace{-10pt}}}


% \newcommand{\UMBchapter}[1]{\addtocontents{toc}{\protect\addvspace{12.3bp}}\chapter{#1}}
% Current:

% The reason for \hspace{0pt} in \UMBchapter, below is to
% help compliance with right entry margin in ToC
% (it's difficult; see e.g. https://tex.stackexchange.com/questions/256526/enforce-strict-margin-boundaries )
% The trick with \hspace{0pt} I discovered by accident. It doesn't always help, but often it does, and there's no harm.

\newlength{\ToCBaseLineSkip}
\setlength{\ToCBaseLineSkip}{12.3bp}
\newcommand{\AddBlankLineToToC}{%
\addtocontents{toc}{\protect\addvspace{\ToCBaseLineSkip}}%
}
\newcommand{\ChapterBefore}{\AddBlankLineToToC}

\newcommand{\ChapterExtraAtEnd}{\nolinebreak\hspace{0pt}}
% \newcommand{\ChapterExtraAtEnd}{}
\newcommand{\UMBchapter}[2][]{\ChapterBefore%
\if\relax\detokenize{#1}\relax\chapter{\Chapterls{\MakeUppercase{#2}}\ChapterExtraAtEnd}\else\chapter[\Chapterls{\MakeUppercase{#1}}\ChapterExtraAtEnd]{\Chapterls{\MakeUppercase{#2}}\ChapterExtraAtEnd}\fi%
% \chapter{\MakeTextUppercase{#1}\hspace{0pt}}%
}
% \let\UMBchapter\chapter
%
% You may wonder why we didn't just redefine the command \chapter, like this:
%
% \let\oldchapter\chapter (this makes a clone of \chapter as it is at that moment)
% \renewcommand{\chapter}[1]{the same code as in the definition of \UMBchapter above, 
% but instead of \chapter we use \oldchapter}
%
% The reason we don't do that is that the command \chapter is a workhorse that is used
% by other commands, and redefining it may have unwanted effects on those other 
% commands. For example, in report.cls (which we are in fact using, see above), the
% following commands are all defined in terms of \chapter: \listoffigures,
% \listoftables, and the environment 'thebibliography'. Of course, we could just copy
% their definitions here and replace all occurrences of \chapter in them by \oldchapter.
% But what happens if someone tries to use a package that also uses \chapter in a 
% nontrivial way? We would have to fix the commands in that package, too. Clearly, that
% way madness lies. We don't want to mess with a workhorse command such as \chapter.
% Instead, we define a new customized version of it, \UMBchapter.
% However, we won't have similar compunctions about \section, \subsection, and \subsubsection.


\let\UMBpart\part
% \newcommand{\UMBpart}[1]{%
% \part{\MakeTextUppercase{#1}}
% }
% \addtocontents{toc}{\protect\contentsline{chapter}{CHAPTER}{Page}{}}
% \addtocontents{toc}{\protect\mbox{}\protect\hfill \protect\partname~\protect\thepart \protect\hfill\protect\mbox{}}
% \addcontentsline{toc}{chapter}{\protect\numberline{}Preface}
% \addcontentsline{toc}{chapter}{\protect Preface}
% }

% \addtocontents{toc}{\protect\contentsline{chapter}{CHAPTER}{Page}{}}

%

%
%%%%

%
% The following code is useful when one needs to intervene in LaTeX's
% formatting of paragraphs, say by forcing linebreaks: any text enclosed
% between "\startsquarepar" and "\stopsquarepar" will be formatted as if the
% paragraph doesn't end with whatever text is right before "\stopsquarepar,"
% even if it does. 
% It's also useful when one is setting the positions of floats (e.g. figures
% and tables) by hand, using the command [H] from the float package. Namely,
% sometimes one wants to put the float right in the middle of a paragraph.
% Normally this will result in LaTeX dividing that paragraph into two---the
% part before the float, and the part after, with the corresponding formatting.
% The solution is to put the text before the float in between
% "\startsquarepar" and "\stopsquarepar", and start the text after the
% float with "\noindent".
%
\newcommand{\startsquarepar}{%
    \par\begingroup \parfillskip 0pt \relax}
%
\newcommand{\stopsquarepar}{%
    \par\endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters for formatting the signatory page: the location and look of the signature lines, people names, ranks, and (for external members) affiliations.

\newlength{\SignaturePersonLineThickness}
\setlength{\SignaturePersonLineThickness}{0.4pt}
\newlength{\SignaturePersonLineRaiseHeight}
\setlength{\SignaturePersonLineRaiseHeight}{-2pt}
% \newcommand{\SignaturePersonLineToNameVertDist}{7.5}
% \newcommand{\AnOffs}{1.6}
% \newcommand{\SignaturePersonLineToNameVertDist}{\mymath 7.5 pt - \AnOffs pt}
\newcommand{\SignaturePersonLineToNameVertDist}{5.9}
\newcommand{\SignaturePersonSpacing}{1.15}
\newcommand{\SigVertDistInternal}{}

\newlength{\SignaturePersonLineLength}
\setlength{\SignaturePersonLineLength}{290pt}

\newcommand{\SignaturePersonText}[1]{%
\begin{spacing}{\SignaturePersonSpacing}
\setlength{\parindent}{0pt}
#1
\end{spacing}
}




\newcommand{\SignaturePerson}[1]{%
\renewcommand{\SigVertDistInternal}{\CurrentSignaturePersonVerticalPosition}
\begin{textblock}{\SignaturePersonTextwidthInBp}(\SignaturePersonLeftMarginInBp,\SigVertDistInternal)
% \setlength{\parindent}{0pt}
\noindent
% \rule[\SignaturePersonLineRaiseHeight]{\SignaturePersonLineLength}{\SignaturePersonLineThickness}
\rule{\SignaturePersonLineLength}{\SignaturePersonLineThickness}
\end{textblock}
\begin{textblock}{\SignaturePersonTextwidthInBp}(\SignaturePersonLeftMarginInBp,{\mymath \SigVertDistInternal pt+ \SignaturePersonLineToNameVertDist pt})
\begin{spacing}{\SignaturePersonSpacing}
\setlength{\parindent}{0pt}
#1
\end{spacing}
\end{textblock}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we need the following to handle cases where the ToC and/or LoF and/or LoT go across more than one page. For the TOC, in that case we need to repeat the line that  "CHAPTER" at far left and "Page" at far right (and similarly for the LoF and LoT). In those cases, \MyShipoutHook will be redefined at an appropriate point.
\usepackage{atbegshi}
\newcommand\MyShipoutHook{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The following command, \mymath, strips off the unit of a length, converting it to a string (which looks like a real number or integer).
% It can be used to do simple arithmetic. 
%
% An example: suppose \FirstNumber and \SecondNumber are strings that look like real numbers or integers. We might define them like this:
% \newcommand{\FirstNumber}{35.141}
% \newcommand{\SecondNumber}{-2.615}
% Then, to get a string that is equal to, e.g., (3.7\FirstNumber -5.86\SecondNumber)*8, we write 
% \mymath ((\FirstNumber pt)*37/10-(\SecondNumber pt)*586/100)*8
% The output is '1162.76526'; the correct result is 1162.7648. 
%
% Note that multiplication and division must be by integers, and these operations must come after the variables. So the following would not work: 
% '\mymath 2*(\FirstNumber pt)'. Instead, the multiplication by 2 must come at the end: '\mymath (\FirstNumber pt)*2' .
%
% The idea behind this is the following. The package 'calc' (which we've already loaded) can do arithmetic with lengths. So we first convert our numbers (which are actually strings) to lengths (by simply adding 'pt' to the strings). Then we do the arithmetic, which returns a length as the result. Finally, we use \mymath to convert this resulting length to a string.
%
% \makeatletter
\newcommand{\mymath}{\strip@pt\dimexpr}
% \makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Here we will define the macro \RoundInt, which will enable us to round a decimal number to an integer
% To do that, we will need to define a few other macros first
%
% from https://tex.stackexchange.com/a/387399/192504 (https://tex.stackexchange.com/questions/387215/how-to-extract-integer-part-and-fractional-part-of-a-decimal-number)
\newcommand{\intpart}[1]{\expandafter\int@part#1..\@nil}
\def\int@part#1.#2.#3\@nil{\if\relax#1\relax0\else#1\fi}
%
\newcommand{\fracpart}[1]{\expandafter\frac@part#1..\@nil}
\def\frac@part#1.#2.#3\@nil{\if\relax#2\relax0\else#2\fi}
%
% from https://tex.stackexchange.com/a/724738/192504 (https://tex.stackexchange.com/questions/724494/get-the-first-character-of-a-string-or-macro)
\def\firstcharacter#1{\expandafter\firstcharacterA#1{}\end}
\def\firstcharacterA#1#2\end{#1}
%
% based on the above (for completeness; we won't be using it)
\def\restcharacters#1{\expandafter\restcharactersA#1\end}
\def\restcharactersA#1#2\end{#2}
%
% \def\MinusZero{-0}
% \RoundInt takes as argument a string that is a number (decimal or integer), rounds it, and sets the macro \RoundIntVal equal to the rounded value (via \edef, so its definition is fully expnaded immediatly, at definition time. Had we used \def, it would be expanded later, at call time).
\newcount\RoundCount
%
\newcommand{\RoundInt}[1]{%
\edef\IntPart{\intpart{#1}}
\edef\FracPart{\fracpart{#1}}
\edef\LeadDec{\firstcharacter{\FracPart0}}
\edef\IntSign{\firstcharacter{\IntPart}}
\RoundCount\IntPart\relax
\def\NegSign{-}
\ifx\IntSign\NegSign
   \ifnum \LeadDec>4
%      \edef\IntPart{\mymath \IntPart pt - 1pt}
    \advance\RoundCount by -1\relax
%     \else
%       \ifx\IntPart\MinusZero
%           \def\IntPart{0}
%       \fi
   \fi
\else
   \ifnum \LeadDec>4
%       \edef\IntPart{\mymath \IntPart pt + 1pt}
    \advance\RoundCount by 1\relax
   \fi
\fi
% \edef\RoundIntVal{\IntPart}
\edef\RoundIntVal{\number\RoundCount}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% this stores the month in \DegreeMonth and the year in \DegreeYear
\newcommand{\DegreeMonthYear}[2]{\def\DegreeMonth{#1}\def\DegreeYear{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\HeightBoxOne}
\newlength{\HeightBoxTwo}
\newlength{\HeightBoxThree}
\newlength{\HeightBoxFour}
\newlength{\HeightBoxFive}
\newlength{\HeightBoxSix}
\newlength{\HeightProgDir}
\newlength{\HeightDeptChair}
\newlength{\HeightBox}

\newlength{\CummulativeHeightOfBoxes}
\newlength{\CummulativeHeightOfMemberBoxes}
\newlength{\TotalHeightLength}
\newlength{\DepthLength}
\newsavebox{\boxToBeMeasured}
\setlength{\CummulativeHeightOfMemberBoxes}{0pt}
\setlength{\TotalHeightLength}{0pt}
\setlength{\HeightBoxOne}{0pt}
\setlength{\HeightBoxTwo}{0pt}
\setlength{\HeightBoxThree}{0pt}
\setlength{\HeightBoxFour}{0pt}
\setlength{\HeightBoxFive}{0pt}
\setlength{\HeightBoxSix}{0pt}
\setlength{\HeightProgDir}{0pt}
\setlength{\HeightDeptChair}{0pt}


\newcommand{\MeasureBox}[1]{%
\savebox{\boxToBeMeasured}{\noindent%
\begin{minipage}[b]{\textwidth}
% \color{red}
#1
\end{minipage}
}
\setlength{\TotalHeightLength}{\totalheightof{\usebox{\boxToBeMeasured}}}
\setlength{\DepthLength}{\depthof{\usebox{\boxToBeMeasured}}}
\global\TotalHeightLength=\TotalHeightLength
\global\DepthLength=\DepthLength
% \global\boxToBeMeasured=\boxToBeMeasured
}


\newcount\numCommMembr % Define a counter
\numCommMembr=0 % Initialize the counter to 0


\newlength{\auxlength}
\def\CommitteeMember#1{%
  \advance\numCommMembr by 1 % Increment the counter
  \expandafter\def\csname CommitteeMember\the\numCommMembr\endcsname{#1}%
  \begin{spacing}{\SignaturePersonSpacing}
  \MeasureBox{\csname CommitteeMember\the\numCommMembr\endcsname}
  \end{spacing}
  \setlength{\auxlength}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
  \expandafter\xdef\csname HeightBox\the\numCommMembr\endcsname{\mymath \auxlength}
  \setlength{\CummulativeHeightOfBoxes}{\CummulativeHeightOfBoxes+\auxlength}
  \global\CummulativeHeightOfBoxes=\CummulativeHeightOfBoxes
%   \expandafter\newlength{\csname HeightBox\the\numCommMembr\endcsname}
%   \setlength{\HeightBox}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
% %   \setlength{\CummulativeHeightOfMemberBoxes}{\CummulativeHeightOfMemberBoxes+\HeightBox}
%   \expandafter\global{\csname HeightBox\the\numCommMembr\endcsname}=\HeightBox
%   \expandafter\global\expandafter\setlength\csname HeightBox\the\numCommMembr\endcsname{\dimexpr\TotalHeightLength + \SignaturePersonLineToNameVertDist bp\relax}
}


% The following command increases \CurrentSignaturePersonVerticalPosition by \CommitteLinesVertDist
\newcommand{\advanceVericalPosition}{%
\edef\CurrentSignaturePersonVerticalPosition{\mymath \CurrentSignaturePersonVerticalPosition pt + \CommitteLinesVertDist pt}
}


%define the command \verythinspace (with a width equal to 0.3 times the width of \, )
\protected\def\verythinspace{%
  \ifmmode
    \mskip0.3\thinmuskip
  \else
    \ifhmode
      \kern0.050004em
    \fi
  \fi
}

\protected\def\mvthspace{%
  \ifmmode
    \mskip0.6\thinmuskip
  \else
    \ifhmode
      \kern0.1em
    \fi
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the command \convertto is used to express a length in terms of some specified unit. It returns a pure string, not a length.
% For example, \convertto{bp}{1.25in} will return the string '90.00104' (should be just '90', because 1 in = 72 bp and 1.25 x 72 = 90; but the 'LaTeX calculator' is only precise to about four significant figures in these sorts of calculations)

% \makeatletter % it is not clear to me why this is necessary given that we are in a class file. But without it, we get an error in the main document.
\def\convertto#1#2{\strip@pt\dimexpr #2*65536/\number\dimexpr 1#1}
% \makeatother % Apparently, using \makeatother in a class file is bad (luckily, we don't need it). See https://tex.stackexchange.com/questions/62583/is-it-really-bad-to-use-makeatletter-and-makeatother-in-a-package-or-class-fil 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\edef\LeftMarginInBp{\convertto{bp}{1.25in}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The title page
% \edef\TitlePageTextWidthInBp{\convertto{bp}{6.5in}}
\edef\TitlePageTextWidthInBp{450}
% \edef\TitlePageLeftMarginInBp{\convertto{bp}{1in}}
\edef\TitlePageLeftMarginInBp{81}

\newcommand{\PrintTitlePage}{%
\thispagestyle{empty}

% We will need the following width:
\edef\textwidthInBp{\convertto{bp}{\textwidth}}


% print the title
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,133.2)
\centering
\begin{spacing}{1.15}
% \begin{doublespace}
 \titlels{\MakeUppercase{\@title}}
%  \end{doublespace}
\end{spacing}
\end{textblock}

\newlength{\AuthorNameByVOffset}\setlength{\AuthorNameByVOffset}{-0.95bp}

% print 'Dissertation presented by ...' or 'Thesis presented by ...'
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,215.9)
\centering
\begin{spacing}{1.15}
%  \setlength{\AuthorNameByVOffset}{\@AuthorNameByVOffset\baselineskip-\baselineskip}
%  \setlength{\AuthorNameByVOffset}{\@AuthorNameByVOffset bp}
 A \@ThesisOrDissertation\ Presented \\
 by\\
%  \mbox{}\vskip\AuthorNameByVOffset\authorls{\MakeUppercase{\@author}}   % YOUR NAME is in CAPITALS
\raisebox{\AuthorNameByVOffset}{\authorls{\MakeUppercase{\@author}}}
\end{spacing}
\end{textblock}

\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,314.73)
\centering
\begin{spacing}{1.15}
Submitted to the Office of Graduate Studies, \\
University of Massachusetts Boston, \\
in partial fulfillment of the requirements for the degree of
\end{spacing}
\end{textblock}

% print the name of degree; 'doctor or philosophy', or 'master of science', etc.
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,430.3)
\centering
\titlels{\MakeUppercase{\@DegreeName}}
\end{textblock}

% print month and year
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,463.5)
\centering
% \DegreeMonth\xspace\DegreeYear
\DegreeMonth\ \DegreeYear
\end{textblock}

% print the name of your program, e.g. 'Applied Physics Program', 'Computational Sciences Program', etc.
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,546.0)
\centering
\makeatletter
\@ProgramName
\makeatother
\end{textblock}
\mbox{}\newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the copyright page
\newcommand{\PrintCopyrightPage}{%
\thispagestyle{empty}
\edef\textwidthInBp{\convertto{bp}{\textwidth}}
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,210.6)
\centering
\begin{spacing}{1.15}
% \noindent \copyright~\DegreeYear\xspace by \@author \\% Your Name *not* all caps
\noindent \copyright~\DegreeYear\ by \@author \\% Your Name *not* all caps
 All rights reserved
\end{spacing}
\end{textblock}
\mbox{}\newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the signature page

% adapted from https://tex.stackexchange.com/a/184997/192504
\newcommand{\providelength}[2]{%
  \@ifundefined{\expandafter\@gobble\string#1}
   {% if #1 is undefined, do \newlength
    \newlength{#1}\setlength{#1}{#2}%
   }
   {}%
}

\newlength{\SigPagePresentedByAndApprovedByOffset}\setlength{\SigPagePresentedByAndApprovedByOffset}{0bp}
\newlength{\SigPageApprovedByAdditionalOffset}\setlength{\SigPageApprovedByAdditionalOffset}{0bp}

\newlength{\DeptChairVOffset}
\newlength{\ProgDirVOffset}
\newlength{\MemberOneVOffset}
\newlength{\MemberTwoVOffset}
\newlength{\MemberThreeVOffset}
\newlength{\MemberFourVOffset}
\newlength{\MemberFiveVOffset}
\newlength{\MemberSixVOffset}
\newlength{\TopRefSigLineVOffset}
\newlength{\BottomRefSigLineVOffset}


\setlength{\DeptChairVOffset}{0pt}
\setlength{\ProgDirVOffset}{0pt}
\setlength{\MemberOneVOffset}{0pt}
\setlength{\MemberTwoVOffset}{0pt}
\setlength{\MemberThreeVOffset}{0pt}
\setlength{\MemberFourVOffset}{0pt}
\setlength{\MemberFiveVOffset}{0pt}
\setlength{\MemberSixVOffset}{0pt}
\setlength{\TopRefSigLineVOffset}{0pt}
\setlength{\BottomRefSigLineVOffset}{0pt}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand*\SignaturesSpacingInterp[1]{\gdef\@SignaturesSpacingInterp{#1}}
\SignaturesSpacingInterp{0}

\newcommand{\PrintSignaturetPage}{%
\thispagestyle{empty}
%
\edef\textwidthInBp{\convertto{bp}{\textwidth}}



\newlength{\HeightOfTitle}
\newlength{\DepthOfTitle}
\newlength{\InternalBaselineskip}

\def\SizingTitle{%
\begin{minipage}[b]{\textwidthInBp bp}
\centering
\begin{spacing}{1.15}
% \begin{doublespace}
\strut%
\titlels{\MakeUppercase{\@title}}%
\strut%
% \end{doublespace}
\global\InternalBaselineskip=\baselineskip
\vskip -\baselineskip
\end{spacing}
\end{minipage}%
}

{\setlength\lineskip{0pt}
\setlength{\HeightOfTitle}{\heightof{\SizingTitle}}
\global\HeightOfTitle=\HeightOfTitle
\setlength{\DepthOfTitle}{\depthof{\SizingTitle}}
\global\DepthOfTitle=\DepthOfTitle
}

\newlength{\AuxRoundLength}\setlength{\AuxRoundLength}{1pt*\ratio{\HeightOfTitle}{\InternalBaselineskip} - 2pt}
\RoundInt{\mymath \AuxRoundLength}
\edef\TitleNumLines{\RoundIntVal}
\ifnum\TitleNumLines<0
   \edef\TitleNumLines{0}
\fi


\begin{textblock}{\textwidthInBp}(\LeftMarginInBp,\mymath 74.5 pt)
\centering
% \begin{spacing}{1.1}
\begin{spacing}{1.15}
% \begin{doublespace}
\titlels{\MakeUppercase{\@title}}
% \end{doublespace}
\end{spacing}
\end{textblock}

\def\LenVAdjA{13.42}

% print 'Dissertation presented by ...' or 'Thesis presented by ...'
\begin{textblock}{\textwidthInBp}(\LeftMarginInBp,\mymath 74.5 pt + 46.323 pt - 8.48 pt -\LenVAdjA pt + 25.09 pt + \InternalBaselineskip*\TitleNumLines + \SigPagePresentedByAndApprovedByOffset)
\centering
\begin{spacing}{1.15}
%  \setlength{\AuthorNameByVOffset}{\@AuthorNameByVOffset\baselineskip-\baselineskip}
%  \setlength{\AuthorNameByVOffset}{\@AuthorNameByVOffset bp}
A \@ThesisOrDissertation\ Presented \\
 by\\
%  \mbox{}\vskip\AuthorNameByVOffset\authorls{\MakeUppercase{\@author}}   % YOUR NAME is in CAPITALS
\raisebox{\AuthorNameByVOffset}{\authorls{\MakeUppercase{\@author}}}
\end{spacing}
\end{textblock}

\begin{textblock}{\textwidthInBp}(\LeftMarginInBp,\mymath 74.5 pt + 114.16 pt - 8.48 pt -0.95 pt -0.56 pt -\LenVAdjA pt + 25.09 pt + \InternalBaselineskip*\TitleNumLines + \SigPagePresentedByAndApprovedByOffset+\SigPageApprovedByAdditionalOffset)
{\centering
Approved as to style and content by:\par}
\end{textblock}


\newcommand{\CommitteeChairLineVertDistRef}{\mymath 300.1 pt + \TopRefSigLineVOffset -\AutVertOffset}
\newcommand{\DeptChairLineVertDistRef}{\mymath 646.6 pt + \BottomRefSigLineVOffset + \AutVertOffset}




% \ifAltSigSpacing
\begin{spacing}{\SignaturePersonSpacing}
%
% \makeatletter
\ifdefined\@ProgramDirector
\MeasureBox{\@ProgramDirector}
\setlength{\HeightProgDir}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightProgDir=\HeightProgDir
\fi
% \makeatother
%
%
\end{spacing}
% \fi


\ifAltSigSpacing
  \def\@SignaturesSpacingInterp{1}
\fi
% \def\@SignaturesSpacingInterp{1}
\setlength{\CummulativeHeightOfBoxes}{\CummulativeHeightOfBoxes+\HeightProgDir}
\setlength{\CummulativeHeightOfBoxes}{\@SignaturesSpacingInterp\CummulativeHeightOfBoxes}




\newcommand{\ProgDirCount}{0}
\ifdefined\@ProgramDirector
\renewcommand{\ProgDirCount}{1}
\fi

\newcommand{\ChairCount}{0}
\ifdefined\@DeptChairperson
\renewcommand{\ChairCount}{1}
\fi


% \numCommMembr=16381
\newcommand{\CommitteLinesVertDist}{\mymath(\DeptChairLineVertDistRef pt - \CommitteeChairLineVertDistRef pt - \convertto{pt}{\CummulativeHeightOfBoxes} pt)/(\mymath(\numCommMembr pt +\ProgDirCount pt + \ChairCount pt - 1 pt))}
% \mbox{}\vskip 1in \noindent a=\CommitteLinesVertDist\\
% \the\numCommMembr
% \numCommMembr=7\\
% \noindent b=\CommitteLinesVertDist



\newcommand{\SignaturePersonTextwidthInBp}{\textwidthInBp}
\newcommand{\SignaturePersonLeftMarginInBp}{\LeftMarginInBp}

\newcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + \convertto{pt}{\MemberOneVOffset} pt}

\newlength{\AutVertOffset}\setlength{\AutVertOffset}{0pt}
\ifnum\numCommMembr>4
  \ifnum\numCommMembr>5
    \setlength{\AutVertOffset}{50pt}
  \else
    \setlength{\AutVertOffset}{25pt}
  \fi
\fi

% \mbox{}\vskip 0.5in
\newlength{\UpdatedCummulativeHeightBox}
\setlength{\UpdatedCummulativeHeightBox}{0pt}
\newcommand{\UpperLimit}{\mymath \the\numCommMembr pt + 1 pt}
\newcount\CurrentMember
\CurrentMember=1
\loop
  \ifnum\CurrentMember<\UpperLimit
   \SignaturePerson{\csname CommitteeMember\the\CurrentMember\endcsname}
%    \ifAltSigSpacing
      \setlength{\UpdatedCummulativeHeightBox}{\UpdatedCummulativeHeightBox + \csname HeightBox\the\CurrentMember\endcsname pt}
%    \fi   
   \edef\CurrentSignaturePersonVerticalPosition{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*\the\CurrentMember + \@SignaturesSpacingInterp\UpdatedCummulativeHeightBox + \MemberTwoVOffset}
   \advance \CurrentMember 1
\repeat
% 



% For the last two signature persons, shift the entries to the right
% We also change the length of their signature line just a bit, to better match what's in Standards-UMB
\setlength{\SignaturePersonLineLength}{247.5pt}
\renewcommand{\SignaturePersonLeftMarginInBp}{288.0}



\ifdefined\@ProgramDirector
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*\numCommMembr + \@SignaturesSpacingInterp\UpdatedCummulativeHeightBox + \convertto{pt}{\ProgDirVOffset} pt}
\SignaturePerson{\@ProgramDirector}
\fi

\ifdefined\@DeptChairperson
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \DeptChairLineVertDistRef pt + \convertto{pt}{\DeptChairVOffset} pt}
\SignaturePerson{\@DeptChairperson}
\fi
\mbox{}\newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the abstract
\newlength{\AbstractVerticalOffset}
\setlength{\AbstractVerticalOffset}{0pt}

% \edef\textwidthInBp{\convertto{bp}{\textwidth}}

\newenvironment{UMBAbstract}%
{%
% \begin{textblock}{\mymath (8.5 pt-2 pt)*72}(72,75) % this is how it is in the Standards-UMB, but it is probably a mistake
\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,75.7)
\centering
\noindent 
\iftestA
\mbox{}\kern0.002em{}\testword
\else
\titlels{ABSTRACT}
\fi
\end{textblock}


\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,141)
\setlength{\parindent}{0pt}
\centering
\begin{spacing}{2.5}
% \begin{doublespace}
\titlels{\MakeUppercase{\@title}}
% \end{doublespace}
\end{spacing}
\end{textblock}



% \newcommand{\AdjustAbstractVerticalD}{\mymath -36 pt + \convertto{pt}{\AbstractVerticalOffset} pt }

\newcommand{\AdjustAbstractVerticalD}{\mymath -36 pt + \AbstractVerticalOffset }


\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 261 pt + \AdjustAbstractVerticalD pt + \InternalBaselineskip*\TitleNumLines*2)
\centering
\noindent 
% \DegreeMonth\xspace\DegreeYear
\DegreeMonth\ \DegreeYear
\end{textblock}

\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 309.9 pt + \AdjustAbstractVerticalD pt + \InternalBaselineskip*\TitleNumLines*2)
\setlength{\parindent}{0pt}
\centering 
\begin{spacing}{1.15}
 \noindent \@author, \@AuthorDegrees 
\end{spacing}
\end{textblock}

\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 392.5 pt + \AdjustAbstractVerticalD pt + \InternalBaselineskip*\TitleNumLines*2)
\centering
\noindent 
Directed by \@DirectedBy
\end{textblock}

\newcommand{\absB}{\mymath 308 pt + \AdjustAbstractVerticalD pt + \InternalBaselineskip*\TitleNumLines*2} 
\newlength{\absLength}
\setlength{\absLength}{\absB pt}
\mbox{}\vskip \absLength\mbox{}
% \mbox{}\vskip 308bp\mbox{}
\begin{doublespace}

}{\end{doublespace}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% https://tex.stackexchange.com/questions/33193/how-to-determine-whether-a-list-of-figures-is-empty-then-not-show-it-at-all

\newif\ifThereAreFigures\ThereAreFiguresfalse
\AtEndEnvironment{figure}{\gdef\there@is@a@figure{}} 
\AtEndDocument{\ifdefined\there@is@a@figure\label{fig:was:used:in:doc}\fi} 
\newcommand{\CheckIfThereAreFigures}{\@ifundefined{r@fig:was:used:in:doc}{}{\ThereAreFigurestrue}}%


\newif\ifThereAreTables\ThereAreTablesfalse
\AtEndEnvironment{table}{\gdef\there@is@a@table{}} 
\AtEndDocument{\ifdefined\there@is@a@table\label{tab:was:used:in:doc}\fi} 
\newcommand{\CheckIfThereAreTables}{\@ifundefined{r@tab:was:used:in:doc}{}{\ThereAreTablestrue}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\PrintToCLoFLoT}{%
% \renewcommand{\oldcftchapdotsep}{\cftchapdotsep}
\begin{singlespace}
% It is required that, on each new page of the ToC (except the very first one), at the top of the page we have 'CHAPTER' flush left and 'Page' flush right.
% Making this happen requires LaTeX programming that goes beyond the basics, and is accomplished using the package 'atbegshi' (loaded by our class) and its command \AtBeginShipout.
\iftestA
\renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -2\baselineskip}}}
\else
\renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\Chapterls{CHAPTER}\hfill Page\protect{\vskip -2\baselineskip}}}
\fi
\AtBeginShipout{\MyShipoutHook}
\tableofcontents
\clearpage
\renewcommand\MyShipoutHook{}
\end{singlespace}





\CheckIfThereAreFigures
\ifThereAreFigures
    % Umass formatting for List of Figures
    \newpage
    \newlength{\FigExtraShift}\setlength{\FigExtraShift}{\widthof{re}/2}
    \newlength{\FigHeadIndent}\setlength{\FigHeadIndent}{\FigMainIndent-\widthof{Figure}-\FigLabelShift+\FigExtraShift}
%     \setlength{\FigHeadIndent}{\FigMainIndent-\FigLabelShift-25bp-\widthof{gu}/2}
% Current:
    \titlecontents{chapter}[0pt]{\ifFigTabSloppy\sloppy\fi\normalfont}%
       {}%
        {\hspace*{-0bp}}%
        {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
    \addcontentsline{toc}{chapter}{\ToCListls{\MakeUppercase{\LoFName}}}
    \addtocontents{toc}{\protect\addvspace{12.7bp}}
    \addtocontents{lof}{\vspace{-16.84bp}}
    \addtocontents{lof}{\noindent \hskip \FigHeadIndent Figure\hfill Page\hspace{\LoFExtraPageNumToRightMargin}\mbox{}\par}
%     \addtocontents{lof}{\noindent \hskip \FigHeadIndent Figure\hfill Page\hspace{0.25in}\mbox{}\par}
%     \addtocontents{lof}{\vspace{0bp}}
    \begin{singlespace}
\iftestA
    \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -45.57bp}}}
\else
    \renewcommand\MyShipoutHook{\chapter*{\noindent \mbox{}\protect{\vskip -\baselineskip}\hskip \FigHeadIndent Figure\hfill Page\hspace{\LoFExtraPageNumToRightMargin}\mbox{}\protect{\vskip -45.57bp}}}
%     \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}Figure\hfill Page\protect{\vskip -45.57bp}}}
\fi
    % \AtBeginShipout{\MyShipoutHook} % the previous invocation of this command is still in force. If we try to execute it again, it results in an error
    \listoffigures
    \clearpage
    \renewcommand\MyShipoutHook{}
    \end{singlespace}
\fi


\CheckIfThereAreTables
\ifThereAreTables
    % Umass formatting for List of Tables
    \newpage
    \newlength{\TablExtraShift}\setlength{\TablExtraShift}{\widthof{re}/2}
    \newlength{\TablHeadIndent}\setlength{\TablHeadIndent}{\FigMainIndent-\widthof{Table}-\FigLabelShift+\TablExtraShift}
% Current:
    \titlecontents{chapter}[0pt]{\ifFigTabSloppy\sloppy\fi\normalfont}%
        {}%
        {\hspace*{-0bp}}%
        {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
    \addcontentsline{toc}{chapter}{\ToCListls{\MakeUppercase{\LoTName}}}
    \addtocontents{toc}{\protect\addvspace{12.3bp}}
   \addtocontents{lot}{\vspace{-16.84bp}}
    \addtocontents{lot}{\noindent \hskip \TablHeadIndent Table\hfill Page\hspace{\LoTExtraPageNumToRightMargin}\mbox{}\par}
%     \addtocontents{lot}{\vspace{5pt}}
    \begin{singlespace}
\iftestA
   \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -45.57bp}}}
\else
   \renewcommand\MyShipoutHook{\chapter*{\noindent\mbox{}\protect{\vskip -\baselineskip}\hskip \TablHeadIndent Table\hfill Page\hspace{\LoTExtraPageNumToRightMargin}\mbox{}\protect{\vskip -45.57bp}}}
%    \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}Table\hfill Page\protect{\vskip -45.57bp}}}
\fi
    % \AtBeginShipout{\MyShipoutHook} % the previous invocation of this command is still in force. If we try to execute it again, it results in an error
    \listoftables
    \clearpage
    \renewcommand\MyShipoutHook{}
    \end{singlespace}
\fi

%Umass formatting for Table of Contents
\dottedcontents{chapter}[0in]{\normalfont}
{0in}{3.3pt}


\titlecontents{chapter}[0in]{\normalfont}{}{}{\hfill\contentspage}
\addtocontents{toc}{\protect\contentsline{chapter}{\Chapterls{CHAPTER}}{Page}{}}




\titlecontents{chapter}[\ToCIndentChapterText]{\hangindent\ToCTextOverhang\noindent\ifChapSloppy\sloppy\fi\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \mbox{}\hspace{-\WidthA}\thecontentslabel.]{\dimexpr \ToCLabelShift-\ToCLabelShiftChExtra}}%
    {\hspace*{-\ToCLabelShift+\ToCLabelShiftChExtra}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


}



% \renewcommand\bibname{\mbox{}\vskip -14.4bp{}\mbox{}\hfill LIST OF FIGURES\hfill\mbox{}}
\renewcommand\bibname{\mbox{}\vskip -14.4bp{}\mbox{}\hfill\ToCListls{\MakeUppercase{\RefName}}\hfill\mbox{}}


% \makeatletter
% The following fix is from https://tex.stackexchange.com/a/737361/192504 
\def\ttl@row@i[#1]#2{%
  \ifvmode\expandafter\titleline\fi
  {\sbox\z@{#2}%
   \nolinebreak
   \hspace{-#1}%
   \nolinebreak\hskip\wd\z@
   \mbox{}\nolinebreak\ttl@leaders\hb@xt@#1{\hss\box\z@}%
   \hskip 1\ToCTextRightMarginRelativeToRightEndOfDots plus 1fill\kern\z@}}
% \makeatother


% we append \hspace{0pt} to chapter, section. etc. names, because it turns out to help with the formatting of the ToC. See e.g. 
% https://tex.stackexchange.com/questions/737315/titletoc-problem-with-leading-dots-and-margin-violation
\let\oldsection\section
\renewcommand{\section}[2][]{%
\if\relax\detokenize{#1}\relax% check if the optional argument to \section is empty
    \oldsection{#2\nolinebreak\hspace{0pt}}% if it is, call \oldsection without the optional argument
\else%
    \oldsection[#1\nolinebreak\hspace{0pt}]{#2\nolinebreak\hspace{0pt}}% otherwise, call it with the optional argument
\fi%
}

\let\oldsubsection\subsection
\renewcommand{\subsection}[2][]{%
\if\relax\detokenize{#1}\relax\oldsubsection{#2\nolinebreak\hspace{0pt}}\else\oldsubsection[#1\nolinebreak\hspace{0pt}]{#2\nolinebreak\hspace{0pt}}\fi%
}
\let\oldsubsubsection\subsubsection
\renewcommand{\subsubsection}[2][]{%
\if\relax\detokenize{#1}\relax\oldsubsubsection{#2\nolinebreak\hspace{0pt}}\else\oldsubsubsection[#1\nolinebreak\hspace{0pt}]{#2\nolinebreak\hspace{0pt}}\fi%
}



\newcommand{\SetUpMainText}{%
\newpage
\pagestyle{plain}
\pagenumbering{arabic}
\setcounter{page}{1}
\normalsize
}

\newcommand{\SetUpBibliography}{%
\singlespacing
\clearpage
\addtocontents{toc}{\protect\addvspace{10pt}}
\titlecontents{chapter}[0in]{\normalfont}{}{}{\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}
\addcontentsline{toc}{chapter}{\ToCListls{\MakeUppercase{\RefName}}}%
}



\AtBeginDocument{%

%%%%%%%%%%%%%%%%%%%%%%%%%% setting tracking %%%%%%%%%%%%%%%%%%%%%%%%%%


% It is good typographic practice to apply tracking (a.k.a. letterspacing, i.e. uniform addition or subtraction of space between all the characters) to pieces of text that are in all capitales, especially in titles and headings. For us, this applies to several items on the title page (the thesis/dissertation title, the author name, and the degree name), the signature page (the title and the author name), and the names of chapters and other chapter-level material (e.g. ABSTRACT, ACKNOWLEDGMENTS, LIST OF FIGURES, LIST OF TABLES, LIST OF REFERENCES, APPENDIX, and possibly others).
% In LaTeX, tracking can be done with the command \textls from the microtype package.
% (In principle, the soul package also provides this functionality. But since basically everyone will use microtype, we may as well use its functionality and not load soul as well.)
% The class file, therefore, already incorporates the command \textls; namely it enters the definitions of \titlels, \authorls, \ToCListls, and \Chapterls (see below; these commands, in turn, are used elsewhere in this class file). However, it would be nice if the usage of the microtype package were optional. Thus, we need to make sure \textls (and the commands defined in terms of it) is defined---to do nothng---if the microtype package is not loaded.
%
% The '\providecommand{\textls}[2][]{#2}' below is there in case one decided not to use microtype. As we said, '\textls' must be defined one way or another, because it is used in the class file. The way \providecommand works is, it is executed if the command it defines has not been defined up to this point, but it is ignored if the command has been defined already. So, if the microtype package is used, then it will define the command '\textls', and the '\providecommand' will be ignored. On the other hand, if the microtype package is not used, then the '\providecommand' defines '\textls'. Namely, it will define it to do nothing. 


\providecommand{\textls}[2][]{#2}

% Here we define the tracking amounts for the all-caps title and the all-caps author name. Of course, if microtype wasn't used, then, since \textls in that case does nothing (see above), these will also do nothing, since they are defined in terms of \textls.

\def\TitleTracking{75}
\def\AuthorTracking{50}
\def\ToCListTracking{50}
\def\ChapterTracking{45}

\newcommand{\titlels}[1]{\textls[\TitleTracking]{#1}} 
% \newcommand{\titlels}[1]{\textls[-20]{#1}}
\newcommand{\authorls}[1]{\textls[\AuthorTracking]{#1}} 
\newcommand{\ToCListls}[1]{\textls[\ToCListTracking]{#1}}
\newcommand{\Chapterls}[1]{\textls[\ChapterTracking]{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\let\oldcaption\caption
\renewcommand{\caption}[2][]{%
\if\relax\detokenize{#1}\relax\oldcaption{#2\nolinebreak\hspace{0pt}}\else\oldcaption[#1\nolinebreak\hspace{0pt}]{#2\nolinebreak\hspace{0pt}}\fi%
}
\doublespacing
\setlength{\parindent}{0.5in}
\pagenumbering{roman}
% \mbox{}\newpage
\setcounter{page}{1}
\pagestyle{plain}
}
\endinput
