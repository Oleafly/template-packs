%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- thesis.cls ----------------------------------------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
% Title:        Baylor University Thesis/Dissertation LaTeX Class
% Filename:     thesis.cls
% Description:  thesis.cls provides the 'thesis' class options  is a modified version of the LaTeX report class
% Usage:        Ideally, this .cls file IS NOT intended to be modified except by specific 'Contributors' with package/class
%               writing experience. The development objective is to parameterize ALL instances of values & control sequences that
%               affect various formatting guidelines & create control sequence abstractions that provide users with simple
%               control macros they can adjust to satisfy Baylor Grad School formatting guideline changes. This is currently an
%               ongoing development objective.
% Sources:      The primary source of the TeX redefined in this file is from the 'report' class .cls file that this .cls file is
%               derived. Relevant control sequences whose behavior needs to be changed are copied from the source and modified
%               here. Other significant sources include 'latex.ltx', 'tocloft.sty', and 'appendix.sty'. The remainder of TeX
%               in this file is primarily task oriented and not derived from existing TeX control sequences.
% Notes:        Repeated modifications of the .cls file under very near-term deadlines for passing "format review"
%               has resulted in an accumulation of "hacks" that generated the desired output at the time but maintenance of the
%               .cls as formatting guidelines change becaomes painfully challenging and time consuming. Moreover, sometimes
%               conforming to even simple formatting guidelines (e.g. spacing/naming/numbering) involves empirically derived
%               values AND/OR a complex series of control sequences, which don't easily translate to simple "SET X TO Y" type
%               user controls. Significant strides towards an easily maintainable .cls file were made in Dec 2023, but
%               several "hacks" remain & only a portion of the user controls have been created thus far.
%_______________________________________________________________________________________________________________________________%
%* Last Updated in December, 2023 (Blake Schultze: blake@r2labs.org)
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------------- Contributors ---------------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% 'BaylorCS/baylor-cs-thesis' contributors
%-------------------------------------------------------------------------------------------------------------------------------%
% Some code derived from an early template
% created by Jeff Donahoo (2000), with additional
% inspiration from a template by David Jack (2011);
% rewritten and simplified by Jonathan Drake (2013).
% additional stuff by Alvin Jude (2014)
%-------------------------------------------------------------------------------------------------------------------------------%
% 'BaylorICTHUS/LaTeX_BaylorThesis' contributors
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake Schultze (2021): cloned 'BaylorCS/baylor-cs-thesis' repo and ammended
% Blake Schultze (2023): updated to conform to 9/30/2022 version of 'Dissertation and Thesis Guidelines'
% Ha Nguyen (2023): updates made on behalf of and with the help of ECS graduate Ha Nguyen
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------------- File Contents --------------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # The structural organization of this .cls file is INTENDED to be logical & intuitive, but the dependencies between
%     various control sequences impose an order of the dependent control sequence AFTER the control sequences it's dependent on.
%     Furthermore, the order in which packages are loaded can have a direct impact on whetheer package conflicts or "clashes"
%     are created or avoided. Thus, while control sequences of similar use context are grouped together as much as possible,
%     a strict grouping & ordering here is of secondary importance to functional TeX. This 'contents' list is provided to
%     compensate (slightly) for instances where there is a general lack of intuitive or unexpected ordering/grouping
%-------------------------------------------------------------------------------------------------------------------------------%
% #---- Prologue (Frontmatter) page construction definitions %
% ##-------- Prologue (frontmatter) page style/formatting control macros
% ##-------- The Prologue (frontmatter) pages: grouping/ordering, pagination, and style/formatting controls
% ##-------- Abstract page contruction (heading at 2.5")
% ##-------- Title/Signature page contruction
% ##-------- Copyright page contruction
% ##-------- Table of Contents (ToC): settings & configurations
% ##-------- List of Z (LoZ) page constructions: Z = figures (LoF), tables (LoT)
% ##-------- Acknowledgments page construction (heading at 1.5") [optional]
% ##-------- Dedication page construction (heading at 3.0") [optional]
% ##-------- Attributions page construction (heading at 1.5") [if applicable] - Blake added, 2021
% ##-------- Appendix/Appendices title page and content page(s) contruction [if applicable]
% ##-------- Redefine \thebibliography at the beginning of the main \document body (heading at 1.5")
% #---- Primary user input/interface macros appearing in Dissertation-Template.tex and Dissertation-Prologue
% ##-------- Macros defined by the user in the preamble of DissertationTemplate.tex %
% ##-------- Prologue page macros defined by the user in DissertationPrologue.tex %
% ##-------- Footnote construction & control
% ##-------- Additional packages that are useful and commonly used in Package/Class writing
% #---- Register Variable & List Definitions/Configurations %
% #---- Math Control Sequence & Symbol/Operator Definitions %
% #---- 'subappendices' environment: command insertions into environment definition %
% ##-------- Redefine \Xmark sectioning commands to store the current X title for retrieval: X=chapter/section/subsection/ubsubsection
% ##-------- Appendix and Subappendix construction: environments, formatting, and pages
% ##-------- Helper commands simplifying the writing of macro/counter values to .aux file
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Class construction & option declarations/defaults --------------------------------------%
%===============================================================================================================================%
\ProvidesClass{thesis}[2023/12/17]                                              % Provide a specific date to allow for effective version control
\LoadClass[12pt,letterpaper]{report}                                            % Load the parent class 'report' the 'thesis' class is to be derived from
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@makeDraftThesis\@makeDraftThesisfalse                                 % DRAFT, DEFAULT=FALSE: draft heading, no graphics loaded, etc.
\newif\if@makeShortThesis\@makeShortThesisfalse                                 % SHORT, DEFAULT=FALSE: prologue (frontmatter) omitted
\newif\if@isDissertation\@isDissertationtrue
%-------------------------------------------------------------------------------------------------------------------------------%
\DeclareOption{draft}{\@makeDraftThesistrue}                                    % Defines 'draft' option that sets \@makeDraftThesistrue
\DeclareOption{short}{\@makeShortThesistrue}                                    % Defines 'short' option that sets \@makeShortThesistrue & suppresses (frontmatter) prologue
\DeclareOption{dissertation}{\@isDissertationtrue}                              % Defines 'dissertation' option that sets \@isDissertationtrue
\ProcessOptions
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------------ ADMIN level controls (=>) OPAQUE to USER -------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Disallow groups of control sequences directly using \undef
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\ADMIN@disallow@subappendices{%
    \AtBeginDocument{%
        \undef\subappendix
        \undef\subappendices
        \undef\endsubappendices
    }
}%\ADMIN@disallow@subappendices                                                 % immediately EXPAND after DEFINE to add disallowances to \AtBeginDocument stack
%-------------------------------------------------------------------------------------------------------------------------------%
% Disallow CSV list of control sequences
%-------------------------------------------------------------------------------------------------------------------------------%
\def\ADMIN@disallow@thecsvlist{subappendix,subappendices, endsubappendices}
\newcommand\ADMIN@disallow@csvlist{%
    \AtBeginDocument{%
        \@for\@csv@item:=\ADMIN@disallow@thecsvlist%
        \do{%
            \expandafter\csundef\expandafter{\@csv@item}%
        }%
    }
}%\ADMIN@disallow@thecsvlist                                                     % immediately EXPAND after DEFINE to add disallowances to \AtBeginDocument stack
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------------------ Register Variable Allocations ------------------------------------------------%
%===============================================================================================================================%
\newcounter{savedsection}                                                       % Counter used to record \c@section value before \subappendix
\newcounter{numAppendices}                                                      % Counter for passing the knowledge of the # of APPENDIX chapters from the end to the beginning of document via .aux output write
\newlength\lsideWidth
%\selectlanguage{UKenglish}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Basic TeX aliases, definitions, & helper commands --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\global\let\xp\expandafter
%-------------------------------------------------------------------------------------------------------------------------------%
\def\glet{\global\let}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\comment}[1]{}                                                      % ALVIN: Simplifies adding comments
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------ Basic LaTeX page layout control & formatting/settings ------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Basic register variable declaration & initialization
%-------------------------------------------------------------------------------------------------------------------------------%
\newlength\quarterline@space                                                    % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\newlength\halfline@space                                                       % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\newlength\singleline@space                                                     % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\newlength\doubleline@space                                                     % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength\quarterline@space{0.125\baselineskip}                                % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\setlength\halfline@space{0.25\baselineskip}                                    % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\setlength\singleline@space{0.5\baselineskip}                                   % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
\setlength\doubleline@space{\baselineskip}                                      % Height of a single line of text (\baselineskip ~= 24pt ~= 2 x fontsize [12pt]
%-------------------------------------------------------------------------------------------------------------------------------%
% Standard TeX page & line penalty controls & explicitly set values
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: \@m=1000, \@M=10000, \@MM=20000
%-------------------------------------------------------------------------------------------------------------------------------%
\brokenpenalty=\@M                                                              % Eliminates page breaks at hyphens
\clubpenalty=\@M                                                                % Eliminates orphan lines
\widowpenalty=\@M                                                               % Eliminates widowed lines
%-------------------------------------------------------------------------------------------------------------------------------%
\def\intactCitations{\interlinepenalty=\@M}                                     % Prevent page breaks mid citation
\def\ToCtitleBreaks{\interlinepenalty=0}                                        % Allow page breaks mid ToC title entry	
\def\setDocumentILP{\interlinepenalty=\@M}	
%-------------------------------------------------------------------------------------------------------------------------------%
% Set standard LaTeX length parameters to desired values at the beginning of the document
%-------------------------------------------------------------------------------------------------------------------------------%
%   # lengths are set at the beinning of the document to ensure that these length values are used regardless of whether any of
%     these are changed by an included package or explicitly set by a control sequences in this .cls file before the document begins
%   # Blake, 2023: CHANGED <Level> of \<sub, subsub>section to match the BU Formatting Guidelines usage of 'Level', e.g. \section
%     was changed from <Level=1> to <Leavel=3>. Now there is a direct correspondence betweem "Level N" heading formatting
%     guidelines & the corresponding \<sub, subsub>section control sequences.
%   + Blake, 2023: CHANGED 'tocdepth'=4 & 'secnumdepth'=5
%-------------------------------------------------------------------------------------------------------------------------------%
%\AtBeginDocument                                                               % Replaced in favor of "delayed definitions" scheme
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@delayed@setlengths{                                                       % Encapsulate \setlength control sequences for expansion at the beginning of the document (ensuring their precedence over any other package definitions)
    % \voffset = 1in, so all top lengths -> 0.0in
    \setlength{\topmargin}{0.0in}
    \setlength{\headheight}{0.0in}
    \setlength{\headsep}{0.0in}
    \setlength{\topskip}{0.0in}
    \setlength{\voffset}{0.0in}                                                 % Vertical offset added to 1" automatic & unnamed space between top of page and beginning of LaTeX printable area
    \setlength{\hoffset}{0.0in}                                                 % Horizontal offset added to 1" automatic & unnamed space between left edge of page and beginning of LaTeX printable area
	% Blake, 2021: Page num intended to be 0.25in below text, but varies by roman/Arabic numbering.
    % Better to be set individually, some combo of 1ex/em & \baselineskip spacing, but current val is acceptably close globally
    \setlength{\footskip}{0.37in}                                               % Best global compromise.
    \setlength{\textheight}{9.0in}                                              % Yields 1in bottom margin
    \setlength{\textwidth}{6.0in}                                               % Yields 1.25in right margin + marginparwidth
    \setlength{\oddsidemargin}{0.25in}                                          % 0.25in added to 1in leftmargin yielding 1.25in
    \setlength{\evensidemargin}{0.25in}                                         % 0.25in added to 1in leftmargin yielding 1.25in
    \setlength{\parindent}{0.5in}                                               % used in triplespace
    \setlength{\labelsep}{0.5em}
    \setlength{\labelwidth}{1.5em}	
%   + Blake, 2023: MOVED each of these to \AtBeginDocument or FRONTMATTER:ToC/LoF/LoT section of this file
%	\onecolumn
%	\raggedbottom
%   \doublespacing                                                              % "Double spacing" generated by redefining line spacing stretching to \baselinestretch=1.655, yielding \baselineskip=23.997pt~=24pt~=1.655*14.5pt
%	\pagenumbering{arabic}
%   \setcounter{tocdepth}{4}                                                    % Includes ONLY ToC entry items up to <Level=4> (i.e. up to \subsection)
%   \setcounter{secnumdepth}{5}                                                 % Blake, 2023: Sets the <Level=5> at which ToC entry items are to be numbered, suppressing numbering for LevelN>3
%%*******************************************************************************************************************************%
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------- General Document Wide Package Loading --------------------------------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------- Basic + Crucial packages ---------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2021: Switched to IEEEtran bibstyle for IEEE style guide. Retaining "chicago" package requirement yields
%     parenthetical, rather than bracketed, citation numbers, so package was removed.
%   + Blake, 2023: Replaced loading of 'tocloft' package w/ 'titles' option to 'tocloft' with no options. This provides access
%     to many 'tocloft' \cftX_____ control sequences that have NULL effect with the 'titles' package option.
%   + Blake, 2023: ADDED 'calculator' and 'expl3' packages for specific use cases.
%   + Blake, 2023: PROMOTED loading of 'xstring' package from the optional packages (near bottom) to a Basic/Crucial package. It
%     provides a number of indispensable primitives for managing text strings but has minimal impact of existing TeX control
%     sequences, so it is deemed as unlikely to "clash" with other crucial packages (experience suggests this is accurate)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage[%                                                               % Provides extensive color tables, primitive definitions, color controls, & driver-independent tint/shade/etc. additions to 'color' package
    svgnames,table,dvipsnames,usenames,x11names,fixpdftex,hyperref              % [optional] package options & additional color packs
]{xcolor}                                                                       % Called here to prevent subsequent option clashes
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{setspace}                                                       % Provides 'singlespace' & 'doublespace' environments & the ungrouped \singlespacing & \doublespacing control sequences
%-------------------------------------------------------------------------------------------------------------------------------%
%\RequirePackage{chicago}                                                       % REMOVED
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage[titletoc]{appendix}                                             % Fix the ToC style for appendices
\RequirePackage{graphicx}                                                       %\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsmath}                                                        % Provides primary symbols, fonts, and environments for mathematical mode TeX
\RequirePackage{multirow}                                                       % Provides tools for creating tabular cells spanning multiple rows
\RequirePackage{hhline}                                                         % Better tabular/array horizontal lines and vertical line interaction
\RequirePackage{url}                                                            % Provides \url to create web links
\RequirePackage{newclude}                                                       % for newclude bibtex
\RequirePackage{breakcites}                                                     % ensures multiple citations may break at line end
%\RequirePackage[titles]{tocloft}                                               % Blake, 2023: REPLACED: [partial] ToC/LoF/LoT formatting controls
\RequirePackage{tocloft}                                                        % Full ToC/LoF/LoT formatting controls
\RequirePackage{suffix}                                                         % Provides \WithSuffix to create starred versions of \newcommand commands
\RequirePackage{etoolbox}                                                       % Package/class writing tools and primitive frontends especially for use with e-tex
%\RequirePackage{etextools}                                                     % Blake, 2023: Must patch this package before it can be used - Extends 'etoolbox' || *csvloop* clash: package modified with cmds commented out
\RequirePackage{expl3}                                                          % Blake, 2023: ADDED - Added TeX-3 package strictly for access to its range of primitives
\RequirePackage{calculator}                                                     % Blake, 2023: ADDED - Provides support for TeX floating point arithmetic (\DIVIDE,\MULTIPLY), matrices, functions, etc. that are not provided by 'calc'
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: Promoted these packages to a primary package crucial to .cls construction. These packages primarily provide
%     new primitives but DO redefine some fundamental control sequences from 'latex.ltx' and/or the underlying 'report' class.
%     There is a chance that these will overwrite control sequences that were redefined here, which may cause unexpected behavior.
%     Nonetheless, packages like these in common widespread use & having ample experience using them without incident, it was
%     decide that the risk in promoting these was low.
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{enumitem}                                                       % Provides more options/control of enumerate environment numbering/lettering
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: Promoted this package to a primary package crucial to .cls construction. The unique macros & primitive-like
%     control sequences that it provides are unlikely to "clash" with other loaded packages, and ample experience using it within
%     various contexts without issues suggest that the package is safe to be included and used here.
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{xstring}                                                        % Adds macros to manipulate/parse strings of characters/tokens (needs e-TEX)
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%------------ Primary user input/interface macros appearing in Dissertation-Template.tex and Dissertation-Prologue -------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------- Macros defined by the user in the preamble of Dissertation-Template.tex ---------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine standard 'report' class macros
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\title}[1]{\gdef\thesisTitle{#1}}
\renewcommand*{\author}[1]{\gdef\thesisAuthorName{#1}}
\renewcommand*{\date}[1]{\gdef\thesisConfDate{#1}}
%\renewcommand{\abstract}[1]{\gdef\thesisAbstract{#1}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Define unique 'Dissertation' class macros
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\degree}[1]{\gdef\thesisDegree{#1}}
\newcommand*{\supervisor}[1]{\gdef\thesisMentor{#1}}
\newcommand*{\supervisorTitle}[1]{\gdef\thesisMentorTitle{#1}}
\newcommand*{\seeking}[1]{\gdef\thesisSeeking{#1}}
\newcommand*{\holding}[1]{\gdef\thesisHolding{#1}}
\newcommand*{\readerOne}[1]{\gdef\thesisReaderOne{#1}}
\newcommand*{\readerTwo}[1]{\gdef\thesisReaderTwo{#1}}
\newcommand*{\department}[1]{\gdef\thesisDepartment{#1}}
\newcommand*{\departmentChair}[1]{\gdef\thesisDepartmentChair{#1}}
\newcommand*{\graduateDean}[1]{\gdef\thesisDean{#1}}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\readerThree}[1]{\@makeReaderThreetrue\gdef\thesisReaderThree{#1}}
\newcommand*{\readerFour}[1]{\@makeReaderFourtrue\gdef\thesisReaderFour{#1}}
\newcommand*{\readerFive}[1]{\@makeReaderFivetrue\gdef\thesisReaderFive{#1}}
%===============================================================================================================================%
%---------------------------- Prologue page macros defined by the user in Dissertation-Prologue.tex ----------------------------%
%===============================================================================================================================%
\renewcommand{\abstract}[1]{\@makeAbstractPagetrue\gdef\abstractStash{#1}}
\newcommand{\acknowledgements}[1]{\@makeAcknowledgementstrue\gdef\acknowledgementsStash{#1}}
\newcommand{\dedication}[1]{\@makeDedicationtrue\gdef\dedicationStash{#1}}
\newcommand{\attributions}[1]{\@makeAttributionstrue\gdef\attributionsStash{#1}}% Blake added, 2021
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---------------------------------------------- FRONTMATTER/MAINMATTER/BACKMATTER ----------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%--------------------- Frontmatter/backmatter/chapter components: names, titles, headings, font formatting ---------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------- Frontmatter/backmatter and \chapter page heading, text, and ToC label font style & case -------------------%
%===============================================================================================================================%
%   + Blake, 2023: Added conditionals for controlling whether the frontmatter/backmatter (1) headings and (2) ToC labels are
%     printed directly from their name definitions (\X..Xname) or first passed through \MakeUppercase so the names are printed
%     entirely "UPPERCASE". Headings and ToC labels are made distinct, adding flexibility to control these independently (if needed)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\def\listXFontStyle{\normalsize\normalfont}                                     % Default font style for ToC/LoF/LoT headings, labels, and list items/titles
\def\XheadingFontStyle{\normalsize\normalfont}                                  % Default font style for page headings
\def\XtextFontStyle{\normalsize\normalfont}                                     % Default font style for text content
%-------------------------------------------------------------------------------------------------------------------------------%
% Frontmatter/mainmatter/backmatter "page heading" font case control
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@UppercaseHeadings\@UppercaseHeadingstrue                              % Uppercase/Capitalized page heading control, initialized DEFAULT=TRUE (UPPERCASE)
\if@UppercaseHeadings                                                           % IF \if@UppercaseHeadings = TRUE/FALSE
    \global\let\headingFontCase\MakeUppercase                                   % \if@UppercaseHeadings=TRUE
    \else\global\let\headingFontCase\relax                                      % \if@UppercaseHeadings=FALSE
\fi
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setUppercaseHeadings{\@UppercaseHeadingstrue}                       % User control for setting page heading font case to UPPERCASE
\newcommand\setCapitalizedHeadings{\@UppercaseHeadingsfalse}                    % User control for setting page heading font case to standard Capitalization
%-------------------------------------------------------------------------------------------------------------------------------%
% Frontmatter/mainmatter/backmatter "ToC label" font case control
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@UppercaseToClabels\@UppercaseToClabelstrue                            % Uppercase/Capitalized ToC label control, initialized DEFAULT=TRUE (UPPERCASE)
\if@UppercaseToClabels                                                          % IF \if@UppercaseToClabels = TRUE/FALSE
    \global\let\ToClabelFontCase\MakeUppercase                                  % \if@UppercaseToClabels=TRUE
    \else\global\let\ToClabelFontCase\relax                                     % \if@UppercaseToClabels=FALSE
\fi
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setUppercaseToClabels{\@UppercaseToClabelstrue}                     % User control for setting ToC label font case to UPPERCASE
\newcommand\setCapitalizedToClabels{\@UppercaseToClabelsfalse}                  % User control for setting ToC label font case to standard Capitalization
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------------- Frontmatter/backmatter/mainmatter helper control sequences ----------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Lookup the prefix of control sequence names associated with the corresponding argument #1 'X'
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED this lookup table to manage control sequences associated with these document components
%   + Blake, 2023: promoted 'xstring' package to "crucial" to enable access to its \IfStrEqCase control sequence
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\lookup@page@cs@basename[1]{%
    \IfStrEqCase{#1}{
        {Chapter}{\def\@page@cs@basename{chapter}}%
        {Section}{\def\@page@cs@basename{section}}%
        {Subsection}{\def\@page@cs@basename{subsection}}%
        {Subsubsection}{\def\@page@cs@basename{subsubsection}}%
        {Abstract}{\def\@page@cs@basename{abstract}}%
        {Acknowledgements}{\def\@page@cs@basename{acknowledgements}}%
        {Dedication}{\def\@page@cs@basename{dedication}}%
        {Attributions}{\def\@page@cs@basename{attributions}}%
        {Appendix}{\def\@page@cs@basename{appendix}}%
        {Appendices}{\def\@page@cs@basename{appendices}}%
        {LoF}{\def\@page@cs@basename{lof}}%
        {LoT}{\def\@page@cs@basename{lot}}%
    }%
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Access & store \cs_to_str TeX3 primitive as std. TeX macro for extracting the name of a control sequence (i.e. strip esc char '\')
%-------------------------------------------------------------------------------------------------------------------------------%
\ExplSyntaxOn
\newcommand{\nameof@cs}[1]{\cs_to_str:N #1}
\ExplSyntaxOff
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------- Frontmatter/backmatter/mainmatter page names, titles, labels, & headings ---------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Creates an \old@Xname macro to store the original definition of \Xname before its definition is changed via \renewcommand
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\saveAndRenewXname[2]{
    \edef\thecsname{\nameof@cs{#1}}
    \cslet{old@\thecsname}{#1}
    \renewcommand*{#1}{#2}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the (capitalized) names of frontmatter/backmatter and \chapter components
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2021: Modified \Xname names to Capitalized and added \Xheading and \XToClabel commands for independently
%     controlling the appearance of Prologue/Chapter page headings and their corresponding ToC entry titles
%-------------------------------------------------------------------------------------------------------------------------------%
%\renewcommand*{\abstractname}{Abstract}
\newcommand*{\ToCname}{Table of Contents}
\newcommand*{\LoFname}{List of Figures}
\newcommand*{\LoTname}{List of Tables}
\newcommand*{\acknowledgementsname}{Acknowledgments}
\newcommand*{\dedicationname}{Dedication}
\newcommand*{\attributionsname}{Attributions}                                   % Blake added, 2021
\newcommand*{\appendicesname}{Appendix}
\newcommand*{\appendicespluralname}{Appendices}                                 % Plural when more than one appendix chapter
\newcommand*{\bibliographyname}{Bibliography}
\renewcommand*{\chaptername}{Chapter}
%\renewcommand\indexname{Index}
%\renewcommand\figurename{Figure}
%\renewcommand\tablename{Table}
%\renewcommand\partname{Part}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the headings of frontmatter/backmatter and \chapter "pages"
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\abstractHeading}{\headingFontCase{\abstractname}}
\newcommand*{\ToCHeading}{\headingFontCase{\ToCname}}
\newcommand*{\LoFHeading}{\headingFontCase{\LoFname}}
\newcommand*{\LoTHeading}{\headingFontCase{\LoTname}}
\newcommand*{\acknowledgementsHeading}{\headingFontCase{\acknowledgementsname}}
\newcommand*{\dedicationHeading}{\headingFontCase{\dedicationname}}
\newcommand*{\attributionsHeading}{\headingFontCase{\attributionsname}}
\newcommand*{\appendixHeading}{\headingFontCase{\appendicesname}}
\newcommand*{\appendicesHeading}{\headingFontCase{\appendicespluralname}}       % Plural when more than one appendix chapter
\newcommand*{\bibliographyHeading}{\headingFontCase{\bibliographyname}}
\newcommand*{\chapterHeading}{\headingFontCase{\chaptername}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the ToC entry titles of frontmatter/backmatter and \chapter "pages"
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\abstractToCtitle}{\ToClabelFontCase{\abstractname}}
\newcommand*{\cftToClabel}{\ToClabelFontCase{\ToCname}}
\newcommand*{\cftLoFlabel}{\ToClabelFontCase{\LoFname}}
\newcommand*{\cftLoTlabel}{\ToClabelFontCase{\LoTname}}
\newcommand*{\acknowledgementsToClabel}{\ToClabelFontCase{\acknowledgementsname}}
\newcommand*{\dedicationToClabel}{\ToClabelFontCase{\dedicationname}}
\newcommand*{\attributionsToClabel}{\ToClabelFontCase{\attributionsname}}
\newcommand*{\appendixToClabel}{\ToClabelFontCase{\appendicesname}}
\newcommand*{\appendicesToClabel}{\ToClabelFontCase{\appendicespluralname}}     % Plural when more than one appendix chapter
\newcommand*{\bibliographyToClabel}{\ToClabelFontCase{\bibliographyname}}
\newcommand*{\chapterToClabel}{\ToClabelFontCase{\chaptername}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Define these \Xname control sequences to include font style commands (as expected by other packages)
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023:
%   + Added \par (\\ works too) to frontmatter \Xname macros to force \centering of headings to take effect (no effect otherwise)
%   + Added \listXFontStyle to each \Xname, enforcing consistent fontstyle and permitting it to be changed from a single control sequence
%   + Replaced \renewcommand with \saveAndRenewXname so \Xname is saved before being changed & can be restored if necessary
%   # The macros \cftmakeXtitle that use \Xname to print its headings are defined with \cftXtitlefont and \Xname alone in brace groups.
%     The \cftafterXtitle macros are expanded after these brace groups and, thus, the only way to append a \par (or \\) to a
%     heading to activate \centering is to either (1) append \par to the \Xname macro or (2) redefine the \cftmakeXtitle macros.
%     The solution using \par (or \\) was chosen due to its far simpler and succinct changes and conceptual simplicity.
%-------------------------------------------------------------------------------------------------------------------------------%
\saveAndRenewXname\contentsname{\listXFontStyle\ToCHeading\par\nobreak}
\saveAndRenewXname\listfigurename{\listXFontStyle\LoFHeading\par\nobreak}
\saveAndRenewXname\listtablename{\listXFontStyle\LoTHeading\par\nobreak}
\saveAndRenewXname\appendixname{\listXFontStyle\appendixHeading}
\saveAndRenewXname\bibname{\listXFontStyle\bibliographyHeading}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---------------------------------------------- FRONTMATTER/MAINMATTER/BACKMATTER ----------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------------  Document sectioning commands: label numbering style & formatting ------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Set number format of Level 1-4 counter values printed in headings/labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\thechapter}{\arabic{chapter}}
\renewcommand*{\thesection}{\thechapter.\arabic{section}}
\renewcommand*{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand*{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Macro that converts an input number to a corresponding number name and returns other input types unaltered
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023:
%   + renamed \arabicNumName as \ArabicNumName and converted UPPERCASE number names to Capitalized number names.
%   + used \ArabicNumName to define \arabicNumName (lowercase) and \ARABICNumName (UPPERCASE) variations using \MakeLowercase and
%     \MakeUppercase, respectively.
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\ArabicNumName}[1]%
{%
    %\space                                                                     % Blake, 2023: removed "Forced space"
    \ifnum0<0#1                                                                 % Test for number vs letter values
        \ifcase#1                                                               % Input is #: return its Capitalized text name
			Zero \or One \or Two \or Three \or Four \or
			Five \or Six \or Seven \or Eight \or Nine \or Ten \or
			Eleven \or Twelve \or Thirteen \or Fourteen \or
			Fifteen \or Sixteen \or Seventeen \or Eighteen \or
			Nineteen \or Twenty
		\fi%
    \else%                                                                      % Input is non-number:
        #1%                                                                     % Return (i.e. pass-through) non-number inputs unaltered
	\fi%
}
\newcommand{\arabicNumName}[1]{\MakeLowercase{\ArabicNumName{#1}}}              % number to lowercase number name
\newcommand{\ARABICNumName}[1]{\MakeUppercase{\ArabicNumName{#1}}}              % number to UPPERCASE number name
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---------------------------------------------- FRONTMATTER/MAINMATTER/BACKMATTER ----------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%--------------------------------- Itemized, Enumerated, & Other lists: labels and formatting ----------------------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Itemized/Enumerated/@listI labels and formatting ---------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Enumerated list labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\theenumi}{\arabic{enumi}}
\renewcommand*{\theenumii}{\alph{enumii}}
\renewcommand*{\theenumiii}{\roman{enumiii}}
\renewcommand*{\theenumiv}{\alph{enumiv}}
\renewcommand*{\labelenumi}{(\theenumi)}
\renewcommand*{\labelenumii}{(\theenumii)}
\renewcommand*{\labelenumiii}{(\theenumiii)}
\renewcommand*{\labelenumiv}{(\theenumiii.\theenumiv)}
%-------------------------------------------------------------------------------------------------------------------------------%
% Itemized list labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\labelitemi}{\textbullet}
\renewcommand*{\labelitemii}{\textasteriskcentered}
\renewcommand*{\labelitemiii}{\normalfont \bfseries \textendash}
\renewcommand*{\labelitemiv}{\textperiodcentered}
%-------------------------------------------------------------------------------------------------------------------------------%
% Margins for lists
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength{\leftmargini}{3.5em}
\setlength{\leftmarginiii}{2.2em}
\setlength{\leftmarginiv}{2.2em}
\setlength{\leftmarginv}{2.2em}
\setlength{\leftmarginvi}{2.2em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelwidth}{1.5em}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------ Redefinitions of itemize/enumerate/@listI list control sequences -------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Standardize enumerate spacing
%-------------------------------------------------------------------------------------------------------------------------------%
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\parsep}{0pt}	
  \setlength{\parskip}{-1em}
  \setlength{\itemsep}{1em}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Standardize itemize spacing
%-------------------------------------------------------------------------------------------------------------------------------%
\let\olditemize\itemize
\renewcommand{\itemize}{
  \olditemize
  \setlength{\parsep}{-\baselineskip}	
  \setlength{\parskip}{-1em}
  \setlength{\itemsep}{1em}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Removes extra space after the list (itemize) so it will be double space instead of triple
%-------------------------------------------------------------------------------------------------------------------------------%
\let\@oldlistI\@listI
\renewcommand{\@listI}{
	\@oldlistI
	\topsep=0pt
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- MAINMATTER ----------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%----------------------- Document sectioning commands: labeling/formatting controls & (re)defined macros -----------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------------ MAINMATTER formatting controls and macros ------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Shift Page header down a specific distance from the top of the page (vspacing)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\report@cls@parindent{1em}
\def\LaTeX@page@topskip{1in}                                                    % Automatic & unnamed vertical offset from the top of each LaTeX page
\def\LaTeX@page@leftskip{1in}                                                   % Automatic & unnamed horizontal offset from the left edge of a LaTeX page
\def\centering@mainmatter@vshift{16pt}                                          % Vertical shift introduced by inserting headers after \centering macro
\def\centerEnv@mainmatter@vshift{0.09in}                                        % Vertical shift introduced by inserting headers using the 'center' environment
\def\baselinestretch@pts{\baselinestretch\p@}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setMainPageTopMargin[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @topmargin}{\vspace*{\dimexpr #2 - \LaTeX@page@topskip - \centering@mainmatter@vshift\relax}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\WithSuffix\newcommand\setMainPageTopMargin*[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @topmargin@centerEnv}{\vspace*{\dimexpr #2 - \LaTeX@page@topskip - \centerEnv@mainmatter@vshift\relax}}
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
% Redefine \Xmark sectioning commands to store the current X title for retrieval: X=chapter/section/subsection/ubsubsection
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: ADDED TeX procedures for saving the 'title' of the current chapter/section
%   + Blake, 2023: ADDED TeX procedures for subsection & subsubsection
%   + Blake, 2023: MOVED these definitions from near the end of the file to here nearby other MAINMATTER
%   + Blake, 2023: ENCAPSULATED the \Xmark command renewals & delay expansion until beginning of doc; 'fancyhdr' package is now
%     loaded BELOW this point and overwrites \Xmark definitions. Rather than move these back below 'fancyhdr' load, they are
%     encapsulated within a simple \def, which can then be expanded at some point later (e.g. beginning of \Document=\AtBeginDocument)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*\currChapTitle{}                                                    % Stores current chapter title
\newcommand*\currSecTitle{}                                                     % Stores current section title
\newcommand*\currSubsecTitle{}                                                  % Stores current subsection title
\newcommand*\currSubsubsecTitle{}                                               % Stores current subsubsection title
%-------------------------------------------------------------------------------------------------------------------------------%
% Encapsulation of \Xmark definitions: appear here but are ONLY truly defined when \@delayed@Xmark@defs is expanded later
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: The 'fancyhdr' package also redefined \Xmark, so a workarounnd was created to permit these definition to
%       APPEAR here but not be overwritten by 'fancyhdr':
%       + ADDED \Xmark redefinitions for subsection and subsubsection
%       + MOVED these definitions here
%       + ENCAPSULATED these definitions within a control sequence that is expanded \AtBeginDocument so the loading
%         of the 'fancyhdr' package below, which also redefines \Xmark, does not overwrite these definitions as it would if
%         if the definitions were explicitly expanded here instead.
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@delayed@Xmark@defs{                                                       % Encapsulates definitions so they can be delayed until a later point in the file of our choosing
%-------------------------------------------------------------------------------------------------------------------------------%
    \let\old@chaptermark=\chaptermark
    \renewcommand*\chaptermark[1]{%
        \renewcommand*\currChapTitle{##1}%
        \old@chaptermark{##1}%
    }
%-------------------------------------------------------------------------------------------------------------------------------%
    \let\old@sectionmark=\sectionmark
    \renewcommand*\sectionmark[1]{%
        \renewcommand*\currSecTitle{##1}%
        \old@sectionmark{##1}%
    }
%-------------------------------------------------------------------------------------------------------------------------------%
    \let\old@subsectionmark=\subsectionmark
    \renewcommand*\subsectionmark[1]{%
        \renewcommand*\currSubsecTitle{##1}%
        \old@subsectionmark{##1}%
    }
%-------------------------------------------------------------------------------------------------------------------------------%
    \let\old@subsubsectionmark=\subsubsectionmark
    \renewcommand*\subsubsectionmark[1]{%
        \renewcommand*\currSubsubsecTitle{##1}%
        \old@subsubsectionmark{##1}%
    }
%-------------------------------------------------------------------------------------------------------------------------------%
}% END: \@delayed@Xmark@defs
%===============================================================================================================================%
%------------------------------------------- (Level 1/2)  Chapter command & headings -------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Set chapter formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
\setMainPageTopMargin{Chapter}{1.5in}                                           % sets header position to #2 from the top of the page
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine chapter control sequence \chapter
%-------------------------------------------------------------------------------------------------------------------------------%
%   # DEFAULT 'report' class definition is currently being used here
%   # this is intended to support future changes where this definition needs to be changed
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\chapter
{% Chapter command
    \if@openright\cleardoublepage\else\clearpage\fi                             % first page on right
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
    \secdef\@chapter\@schapter                                                  % \@ifstar = FALSE -> \@chapter, \@ifstar = TRUE -> \@schapter
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Chapter control sequence, CASE: (UNSTARRED) \chapter
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023:
%       + Modified to 2-line ToC entries
%       + changed vspacing from 0.43in to 0.41in to better generate heading at 1.5"
%       + changed chapter numbering to (UPPERCASE) number names in the heading/ToC using \ARABICNumName
%   # when \chapter* is used, \@schapter is called instead of \@chapter; \@schapter currently IS NOT redefined in this class
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter[#1]#2%
{%  USAGE: \@chapter[<short ToC title]{<full title>}
    \setcounter{footnoteA}{0}                                                   % the footnotes should start with 1 in each chapter	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
        %\ifnum \c@section >
        \ifnum \value{section} <\@ne
            \addcontentsline{toc}{chapter}{%
                \protect\rm\chapterToClabel\space\ARABICNumName{\thechapter}%
            }%
            %\addcontentsline{toc}{chapter}{\protect\rm\chapterToClabel\space\ARABICNumName{\thechapter}\vspace{-0.5\baselineskip-6pt}}%
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
            \addtocontents{toc}{\protect\addvspace{%                            % Blake, 2023: Required manual ToC V-spacing for 2-line chapter ToC entry items
                    -\cftparskip@factor\doubleline@space%                       % where \doubleline@space is the INITIAL value 14.5pt before being stretched by \baselinestretch=1.655 to ~24pt (23.997pt)
                    %-\mystery@vshift@discrepancy                               % and IF the unknown 1.25pt voffset is being removed for <sub, subsub>sections, remove it here too so their ToC linespacings match
                }%
            }
        \fi
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
        \addcontentsline{toc}{chapter}{%                                        % Blake, 2023: Indent 2nd ToC line and print ONLY the chapter title (no numbering)
                \protect\hskip\cftindent@chapLineTwo\rm#1%
        }%
		%\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	\begingroup
		\centering
        \chapter@topmargin                                                      % Blake, 2023: Replaced explicit \vspace* with vspacing macro
        \chapterHeading\space\ARABICNumName{\thechapter}\\[0.0pt]%              % Blake, 2023: print chapter number as UPPERCASE number name in heading
		\begingroup%
            \centering
            #2\\[\singleline@space]%
        \endgroup
        %\vspace*{0.41in}                                                       % Blake, 2023: Adjusted from 0.43in to 0.41in to better generate heading at 1.5"
        %\chapterHeading\space\ARABICNumName{\thechapter}                       % Blake, 2023: print chapter number as UPPERCASE number name in heading
		%\vspace{-1ex}
		%\singlespacing{#2}\\
        %\vspace{0.13in}
	\endgroup
	\@afterheading
}
%===============================================================================================================================%
%------------------ (COMMON to Level 3+) Document sectioning control: CASE: (UNSTARRED) \<sub, subsub>section ------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: \<sub, subsub>section control sequences originally had 0 arguments but were redefined here to have 2. Hence, the
%     arguments expanded by \<sub, subsub>section[#1]{#2} must be appendeded to their internal \@startsection so \@sect and
%     \@ssect have the expected arguments. The benefits of this approach instead of a parameterless \subsubsection definition are:
%       + \subsubsection arguments can be altered/formatted before appending them back on the stack
%       + \subsubsection*[]{} permits the inclusion of the optional [#1] argument, which it could not do originally, and simply ignores
%       + provides direct and independent control over \subsubsection and \subsubsection* without requiring \@startsection to be redefined
%       # The cost is a considerable amount of additional/replacement TeX code and increased complexity, but this is currently
%         considered not to be costly enough to warrant reverting back to a parameterless \subsubsection and foregoing the
%         aforementioned benefits.
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine \@sect, which is ONLY expanded by \@startsection IF UNSTARRED version of \<sub, subsub>section is used (i.e. \@ifstar = FALSE )
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED redefinition of \@sect for better control over Level 3+ (\section, \subsection, \subsubsection, ...) ToC entries
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@sect#1#2#3#4#5#6[#7]#8%
{%  USAGE: \@sect{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}[<altheading>]{<heading>}
    \ifnum #2>\c@secnumdepth
        \let\@svsec\@empty
    \else
        \refstepcounter{#1}%
        \protected@edef\@svsec{\@seccntformat{#1}\relax}%
    \fi
    \@tempskipa #5\relax
    \ifdim \@tempskipa>\z@
        \begingroup
            #6{%
            \@hangfrom{\hskip #3\relax\@svsec}%
              \interlinepenalty \@M #8\@@par}%
        \endgroup
        \csname #1mark\endcsname{#7}%
        \addcontentsline{toc}{#1}{%
            \ifnum #2>\c@secnumdepth \else
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
                %\protect\numberline{\csname the#1\endcsname}%                  % Blake, 2023: REPLACED this line below
                \protect\numberline{}%\csname the#1\endcsname                   % Blake, 2023: REMOVED \numberline content but retained it & its 'snum' box; may be better to remove entirely, but kept for now for easier reversal in the future
            \fi
            #7%
        }%
    \else
        \def\@svsechd{%                                                         %= Save Section Head macro
            #6{\hskip #3\relax
            \@svsec #8}%
            \csname #1mark\endcsname{#7}%
            \addcontentsline{toc}{#1}{%
                \ifnum #2>\c@secnumdepth \else
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
                    \protect\numberline{}%\csname the#1\endcsname               % Blake, 2023: REMOVED \numberline content but retained it & its 'snum' box; may be better to remove entirely, but kept for now for easier reversal in the future
                \fi
                #7%
            }%
        }%
    \fi
    \@xsect{#5}
}
%===============================================================================================================================%
%-------------------------------------------- (Level 3) Section commands & headings --------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefinition of \section control sequence, CASE: \@ifstar = FALSE (i.e. \section* NOT used)
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: REVERTED the \section command from 1 to 2 parameters, where optional [#1] provides a "short title" ToC entry option
%   + Blake, 2023: ADDED/CHANGED the definition of the \section* variant, which did not function properly
%   + Blake, 2023: CHANGED <level> of \subsection from 1 to 3 to match w/ Baylor Formatting Guidelines concept of "Level"
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\section}[2][]
{%  USAGE: \section[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
    % USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection%
    % USAGE: \@sect{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}[<altheading>]{<heading>}
    {section}{3}%                                                               % expanded immediately by \@startsection and passed directly to \@sect
    {0pt}{1em}{0.001ex}{\centering\normalfont\slshape\normalsize}%              % expanded immediately by \@startsection and passed directly to \@sect
    %[<alt-heading=short ToC title>]{<heading>}                                 <- \section[<alt-heading=short ToC title>]{<heading>}
    [\ToCentry]{#2}%                                                            % unexpanded by \@startsection, only expanded by the \@sect inside \@startsection macro
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Definition of \section* command, CASE: \@ifstar = TRUE (i.e. \section* IS used -> yields no ToC entry)
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: This \section* definition INCLUDES the optional [<short title>] argument; the reposrt.cls \section* DOES NOT
%   + Blake, 2023: ADDED support for usage of \section*[]{} variant command, which expands the optional [<short title>] parameter
%     but CANNOT append it to \@startsection since \@ssect, which DOES NOT have an optional [<>] parameter, is expanded when
%     \@ifstar = TRUE
%   + Blake, 2023: CHANGED <level> of \section from 1 to 3 to match w/ Baylor Formatting Guidelines concept of "Level"
%-------------------------------------------------------------------------------------------------------------------------------%
\WithSuffix\newcommand\section*[2][]
{%  USAGE: \section*[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}                       % Blake, 2023: kept for now, but unnecessary here since ONLY {<heading>} is or can be passed to \@ssect
    %USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection%
    {section}{3}{0pt}%                                                          % expanded immediately by \@startsection but NOT passed to \@ssect
    %USAGE: \@ssect{<indent>}{<beforeskip>}{<afterskip>}{<style>{<heading>}
    {1em}{0.001ex}{\centering\normalfont\slshape\normalsize}*%                  % expanded immediately by \@startsection and passed directly to \@ssect since \@ifstar = true
    %{<heading>}                                                                <- \section*[<alt-heading=short ToC title>]{<heading>}
    {#2}%                                                                       % unexpanded by \@startsection, only expanded by \@ssect inside \@startsection macro
}
%===============================================================================================================================%
%------------------------------------------- (Level 4) Subsection command & headings -------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # UNKNOWN CS CONTRIBUTOR/YEAR:
%       IF there is content text immediately after level 3,
%           THEN distance between Level 3 and Content text = doublespace.
%       IF there is level 4 header immediately after level 3,
%           THEN distance between Level 3 and Level 4 = triplespace.
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefinition of \subsection command, CASE: \@ifstar = FALSE (i.e. \subsection* NOT used)
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: REVERTED the \subsection command from 1 to 2 parameters, where optional [#1] provides a "short title" ToC entry option
%   + Blake, 2023: ADDED/CHANGED the definition of the \subsection* variant, which did not function properly
%   + Blake, 2023: CHANGED <level> of \subsection from 2 to 4 to match w/ Baylor Formatting Guidelines concept of "Level"
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\subsection}[2][]
{%  USAGE: \subsection[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}%
    % USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection%
    % USAGE: \@sect{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}[<altheading>]{<heading>}
    {subsection}{4}{0pt}%                                                       % expanded immediately by \@startsection and passed directly to \@sect
    {0.001ex}{0.001ex}{\vspace{1em}\normalsize\normalfont\slshape}%             % expanded immediately by \@startsection and passed directly to \@sect
    %[<alt-heading=short ToC title>]{<heading>}                                 <- \subsection[<alt-heading=short ToC title>]{<heading>}
    [\ToCentry]{#2}%                                                            % unexpanded by \@startsection, only expanded by the \@sect inside \@startsection macro
    %[\hspace{-\parindent}\ToCentry]{#2}                                        % unexpanded by \@startsection, only expanded by the \@sect inside \@startsection macro
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Definition of \subsection* command, CASE: \@ifstar = TRUE (i.e. \subsection* IS used -> yields no ToC entry)
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: This \subsection* definition INCLUDES the optional [<short title>] argument; the reposrt.cls \subsection* DOES NOT
%   + Blake, 2023: ADDED support for usage of \subsection*[]{} variant command, which expands the optional [<short title>]
%     parameter but CANNOT append it to \@startsection since \@ssect, which DOES NOT have an optional [<>] parameter, is expanded
%     when \@ifstar = TRUE
%   + Blake, 2023: CHANGED <level> of \subsection* from 2 to 4 to match w/ Baylor Formatting Guidelines concept of "Level"
%-------------------------------------------------------------------------------------------------------------------------------%
\WithSuffix\newcommand\subsection*[2][]
{%  USAGE: \subsection*[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}                       % Blake, 2023: kept for now, but unnecessary here since ONLY {<heading>} is or can be passed to \@ssect
    %USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection%
    {subsection}{4}{0pt}%                                                       % expanded immediately by \@startsection but NOT passed to \@ssect
    %USAGE: \@ssect{<indent>}{<beforeskip>}{<afterskip>}{<style>{<heading>}
    {0.001ex}{0.001ex}{\vspace{1em}\normalsize\normalfont\slshape}*%            % expanded immediately by \@startsection and passed directly to \@ssect since \@ifstar = true
    %{<heading>}                                                                <- \subsection*[<alt-heading=short ToC title>]{<heading>}
    {#2}                                                                        % unexpanded by \@startsection, only expanded by \@ssect inside \@startsection macro
}
%===============================================================================================================================%
%----------------------------------------- (Level 5) Subsubsection command & headings ------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefinition of \subsubsection command, CASE: \@ifstar = FALSE (i.e. \subsubsection* NOT used)
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: The current value of \tocdepth = 4 prevents Level 5 items from appearing in the ToC
%   + Blake, 2021: REVERTED the \subsubsection command from 1 to 2 parameters, where optional [#1] provides a "short title" ToC entry option
%   + Blake, 2023: ADDED/CHANGED the definition of the \subsubsection* variant, which did not function properly
%   + Ha, 2023: REVERTED "Level 5" heading indentation BACK to \parindent as it had been before
%   + Blake, 2023: CHANGED <level> of \subsubsection from 3 to 5 to match w/ Baylor Formatting Guidelines concept of "Level"
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\subsubsection}[2][]
{%  USAGE: \subsubsection[<alt-heading=short ToC title>]{<heading>}
    \vspace{1em}%                                                                % Blake, 2023: [is this really needed?]
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}%
    % USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection%
    % USAGE: \@sect{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}[<altheading>]{<heading>}
    {subsubsection}{5}%                                                         % expanded immediately by \@startsection and passed directly to \@sect
    {\parindent}{0.001em}{-1em}{\normalsize\normalfont\slshape}%                % expanded immediately by \@startsection and passed directly to \@sect
    %[<alt-heading=short ToC title>]{<heading>}                                 <- \subsubsection[<alt-heading=short ToC title>]{<heading>}
    [\ToCentry]{#2}%                                                            % unexpanded by \@startsection, only expanded by the \@sect inside \@startsection macro
    {\hspace{-2ex}.}%                                                           % Blake, 2023: [is this really needed?] adds a period/fullstop/dot after the title
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Definition of \subsubsection* command, CASE: \@ifstar = TRUE (i.e. \subsubsection* IS used -> yields no ToC entry)
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: The current value of \tocdepth = 4 prevents Level 5 items from appearing in the ToC
%   # NOTE: This \subsubsection* definition INCLUDES the optional [<short title>] argument; the reposrt.cls \section* DOES NOT
%   + Blake, 2023: ADDED support for usage of \subsubsection*[]{} variant command, which expands the optional [<short title>]
%     parameter but CANNOT append it to \@startsection since \@ssect, which DOES NOT have an optional [<>] parameter, is expanded
%     when \@ifstar = TRUE
%   + Ha, 2023: REVERTED "Level 5" heading indentation BACK to \parindent as it had been before
%   + Blake, 2023: CHANGED <level> of \subsubsection* from 3 to 5 to match w/ Baylor Formatting Guidelines concept of "Level"
%-------------------------------------------------------------------------------------------------------------------------------%
\WithSuffix\newcommand\subsubsection*[2][]
{%  USAGE: \subsubsection*[<alt-heading=short ToC title>]{<heading>}
    \vspace{1em}                                                                % Blake, 2023: [is this really needed?]
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}                       % Blake, 2023: kept for now, but unnecessary here since ONLY {<heading>} is or can be passed to \@ssect
    %USAGE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}<*>
    \@startsection{subsubsection}{5}%                                           % expanded immediately by \@startsection but NOT passed to \@ssect
    %USAGE: \@ssect{<indent>}{<beforeskip>}{<afterskip>}{<style>{<heading>}
    {\parindent}{0.001em}{-1em}{\normalfont\slshape\normalsize}*%               % expanded immediately by \@startsection and passed directly to \@ssect since \@ifstar = true
    %{<heading>}                                                                <- \subsubsection*[<alt-heading=short ToC title>]{<heading>}
    {#2}%                                                                       % unexpanded by \@startsection, only expanded by \@ssect inside \@startsection macro
    {\hspace{-2ex}.}%                                                           % Blake, 2023: [is this really needed?] adds a period/fullstop/dot after the title
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- MAINMATTER ----------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------- Float Environments: placement, labeling/formatting, & LoZ list item control -------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%----------------------------------------------- Float Environments & Formatting -----------------------------------------------%
%===============================================================================================================================%
\RequirePackage{caption}                                                        % Provides many customizations of floating environment (e.g. figure/table) captions
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the global caption label separator and spacing for all floats
%-------------------------------------------------------------------------------------------------------------------------------%
%   # UNKNOWN CS CONTRIBUTOR & YEAR: This is confusing because the caption is at the top. - THERE HAS TO BE A BETTER WAY JIM
%   # aboveskip = distance between caption and float
%   # belowskip = distace between caption and text
%-------------------------------------------------------------------------------------------------------------------------------%
\captionsetup{labelsep=colon,font=singlespacing}                                % Global caption formatting options
%-------------------------------------------------------------------------------------------------------------------------------%
% Figure caption customizations
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2021:  Was > triple spaced between figure and caption (called legend in Guidelines)
%   # Spacing between a Figure & a Table, w/ no intervening text, is doubled up, which helps discern between them but isn't
%     addressed in the guidelines and was not asked to change it.
%-------------------------------------------------------------------------------------------------------------------------------%
%\captionsetup[figure]{belowskip=2em, aboveskip=2em}                            % Previous (replaced) fig skip values
\captionsetup[figure]{                                                          % Blake, 2021: new fig skip values
    labelformat=simple,
    belowskip=-1em,
    aboveskip=1em
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Table caption customizations
%-------------------------------------------------------------------------------------------------------------------------------%
\captionsetup[table]{
    labelformat=simple,
    belowskip=0em,
    aboveskip=1em,
    justification=centering
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Vertical spacing between floats/captions & surrounding text
%-------------------------------------------------------------------------------------------------------------------------------%
%   # UNKNOWN CS CONTRIBUTOR/YEAR: because we set this which determines the distance between the table and the preeceeding / proceeding
%     text, we HAVE to set the belowskip in the thing above to 0
%   # UNKNOWN CS CONTRIBUTOR/YEAR: This is also applicable for the images and pictures. Fortunately, the configuration for both
%     are the same. If they're not, then we're in big barney
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength{\intextsep}{2em}                                                     % Vertical space for floats in the middle of the page
\setlength{\textfloatsep}{3.0em}                                                % Vertical space for floats at the top of the page
\setlength{\abovecaptionskip}{2em}
%\setlength{\belowcaptionskip}{-0.01em}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---- Redefine format of \caption[]{} items written to \listofYs ONLY for specific float environments Y={figure, table,...} ----%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Naming: (X:Y:Z)={fig:figure:F,tab:table:T)<=>(\_X_:\listofYs:LoZ)={\_fig_:\listoffigures:LoF,\_tab_:\listoftables:LoT,...}
%   # NOTE: \_X_ is often \cft_X_ either from 'tocloft' directly OR defined/derived in <this>.cls for use w/ 'tocloft' behaviors
%-------------------------------------------------------------------------------------------------------------------------------%
% LoZ item title = <title> IF USING \caption{<title>} OR title = <short title> IF USING \caption[<short title>]{<title>}
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: EXTENDED 'caption' package such that the \caption[]{} content written to LoZ supports adding the requried
%     prefix labels "Figure " & "Table " before item refnums \theY for SPECIFIC float environments Y={figure, table}.
%     Functionality also includes 'Aligned' & 'Constsep' LoZ item numbering/title separation options && adapts to cases where \theY= C.N (C:=chapter #) for N>=10->N=[nn] yields a 1 digit
%     wider C.nn. NOTE: could be extended to support other float environments e.g. subfigure, subtable, wrapfigure.
%       + ADDED redefintion of 'caption' package control sequence that writes items to \listofYs files
%           + ADDED specific behavior for Y={figure, table} floats; all other floats retain DEFAULT behavior from 'caption'
%           + REDEFINED prefix label names to \p@Y={\Yname\space}
%           + ADDED prefix label names \p@Y={"Figure ", "Table "} before Y={figure,table} refnums in the LoZ={LoF, LoT}
%           + DEFINED new lengths \len@p@Y & set these to width of the \cftXfont\p@Y label added before LoZ item numbering
%           + DEFINED new CONST DEFAULT lengths \default@cftXnumwidth to replace usage of VAR lengths \cftXnumwidth
%           + SUBTRACTED \default@cftXnumwidth from \len@p@Y, yielding \hskip required for \cftXfont\p@Y\numberline{\theY}
%           + ADJUSTED LoZ item indents/numberline widths using \cftsetindents{Y}{<indent>=0.0in}{<width>=\len@p@Y}
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Add SPECIFIC \caption[<short title>]{<title>} behaviors for writing LoZ items to \listofYs when {Y:Z}={figure:F,table:T,...}
%-------------------------------------------------------------------------------------------------------------------------------%
%   # NOTE: DEFAULT \caption[<short title>]{<title>} is retained FOR ALL OTHER float environments NOT(Y)=NOT({figure, table, ...})
%   # This can be extended to define specific \caption[<short title>]{<title>} behaviors for ADDITIONAL float environments Y
%       # Potential ADDITIONAL float environments are Y={subfigure, wrapfigure, longtable, etc.}
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*\caption@@@addcontentsline[4]{%
    \IfStrEqCase{#2}%
    {%
        {figure}{\figcaption@@@addcontentsline{#1}{#2}{#3}{#4}}                 % Use the specific LoZ item writing behavior of \caption[]{} defined for (X:Y:Z)={fig:figure:F}
        {table}{\tabcaption@@@addcontentsline{#1}{#2}{#3}{#4}}                  % Use the specific LoZ item writing behavior of \caption[]{} defined for (X:Y:Z)={tab:table:T}
    }[\addcontentsline{#1}{#2}{\protect\numberline{#3}{#4}}]%                   % DEFAULT: Use the original LoZ item writing behavior of \caption[]{} defined by \newcommand*\caption@@@addcontentsline in 'caption' package
}
%===============================================================================================================================%
%- Add SPECIFIC \caption[<short title>]{<title>} behaviors for writing LoZ items to \listofYs when {Y:Z}={figure:F,table:T,...}-%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine \p@figure to desired prefix label before LoF item refnums C.N & define/init LoF item spacing/indentation parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\p@figure{\figurename\space}                                       % ADD prefix label "Figure " before LoF item refnums C.N -> "Figure C.N"
\newlength\default@cftfignumwidth                                               % DECLARE new FIXED DEFAULT length \default@cftfignumwidth to use instead of UNFIXED \cftfignumwidth (e.g. \cftfignumwidth=<numwidth> <- \setindents{figure}{<indent>}{<numwidth>})
\setlength\default@cftfignumwidth{1.8em}                                        % SET new FIXED DEFAULT length \default@cftfignumwidth (DEFAULT: \cftfignumwidth=2.3em)
\newlength\len@p@figure                                                         % DECLARE new length to store desired "hbox" width w/ additional content \cftfigfont\p@figure preceding 'snum'
\settowidth\len@p@figure{\cftfigfont\p@figure}                                  % SET new length to the width of \cftfigfont\p@figure, where \cftfigfont renders \p@figure w/ the font styling applied to the LoF items
\addtolength\len@p@figure{-\default@cftfignumwidth}                             % ADD width of figure number box, yielding total width = \p@figure + \cftfignumwidth
\newcommand\cftfig@snum@titlesep{\space}                                        % DEFINES the desired separator between the LoF item label/numbering & title (DEFAULT: \space)
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Define the SPECIFIC LoZ item writing behavior of \caption[]{} for (X:Y:Z)={fig:figure:F}
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: MOVED the \addcontentsline{#1}{#2}{\protect\p@figure\numberline{#3} common to nested IFs outside the IF
%     hierarchy so it only appears ONCE & nested IFs ONLY control the content following this common code (MUCH shorter code too)
%   # NOTE: "Figure " refers to the CLASS DEFAULT \p@figure="Figure " & is used instead of \p@figure for demonstration purposes
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*\figcaption@@@addcontentsline[4]{%
    \addcontentsline{#1}{#2}{\protect\p@figure\numberline{#3}%                  % This portion of \addcontentsline call is common in ALL nested IFs
        \if@force@const@LoZ@titlesep                                            % IF \@force@const@LoZ@titleseptrue THEN require constant LoF item refnum/title separation
            \ifnum\value{figure} < 10                                           % IF figure refnum N<10 in current Chapter C (i.e. IF N<10 -> N:=[n] in "Figure C.n"
                \cftfig@snum@titlesep{#4}%                                      % THEN (=>) ADD ONLY the title separator \cftfig@snum@titlesep before LoF item title = <title> OR <short title>
            \else                                                               % ELSE (=>) WHEN(N<10 -> N:=[n])
                {\hskip\DBLdigit@refnum@skip}%                                  % ADD \hskip\DBLdigit@refnum@skip to make room for extra digit n in "Figure C.nn"
                \cftfig@snum@titlesep{#4}%                                      % ADD desired title separator \cftfig@snum@titlesep
            \fi
        \else                                                                   % ELSE (=>) WHEN(\@force@const@LoZ@titlesepfalse <=> align LoF item titles)
            {\hskip\LoZnumline@padskip}%                                        % ADD \hskip\LoZnumline@padskip to shift LoF item title right by approx. width of 1 digit n to make room for "Figure C.nn" WHEN(N>=10 -> N:=[nn])
            \cftfig@snum@titlesep{#4}%                                          % ADD desired title separator \cftfig@snum@titlesep yielding LoF item numbering/title separation -> WHEN( N<10 -> N:=[n] || N>=10 -> N:=[nn]) (=>) (\cftfig@snum@titlesep + \hskip\LoZnumline@padskip || \cftfig@snum@titlesep)
        \fi
    }%                                                                          % CLOSE ON ARG#3 of \addcontentsline (MATCHES unconventional OPEN ON ARG#3 usage hidden before \protect)
}
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine \p@table to desired prefix label before LoT item refnums C.N & define/init LoT item spacing/indentation parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\p@table{\tablename\space}                                         % ADD prefix label "Table " before LoT item refnums C.N -> "Table C.N"
\newlength\default@cfttabnumwidth                                               % DECLARE new FIXED DEFAULT length \default@cfttabnumwidth to use instead of UNFIXED \cfttabnumwidth (e.g. \cfttabnumwidth=<numwidth> <- \setindents{table}{<indent>}{<numwidth>})
\setlength\default@cfttabnumwidth{1.8em}                                        % SET new FIXED DEFAULT length \default@cfttabnumwidth (DEFAULT: \cfttabnumwidth=2.3em)
\newlength\len@p@table                                                          % DECLARE new length to store desired "hbox" width w/ additional content \cfttabfont\p@table preceding 'snum'
\settowidth\len@p@table{\cfttabfont\p@table}                                    % SET new length to the width of \cfttabfont\p@table, where \cfttabfont renders \p@table w/ the font styling applied to the LoT items
\addtolength\len@p@table{-\default@cfttabnumwidth}                              % ADD width of table number box, yielding total width = \p@table + \cfttabnumwidth
\newcommand\cfttab@snum@titlesep{\space}                                        % DEFINES the desired separator between the LoT item label/numbering & title (DEFAULT: \space)
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Define the SPECIFIC LoZ item writing behavior of \caption[]{} for (X:Y:Z)={tab:table:T}
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: MOVED the \addcontentsline{#1}{#2}{\protect\p@table\numberline{#3} common to nested IFs outside the IF
%     hierarchy so it only appears ONCE & nested IFs ONLY control the content following this common code (MUCH shorter code too)
%   # NOTE: "Table " refers to the CLASS DEFAULT \p@table="Table " & is used instead of \p@table for demonstration purposes
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*\tabcaption@@@addcontentsline[4]{% COMMENTS ASSUME (CASE:\p@table="Table ")
    \addcontentsline{#1}{#2}{\protect\p@table\numberline{#3}%                   % This portion of \addcontentsline call is common in ALL nested IFs
        \if@force@const@LoZ@titlesep                                            % IF \@force@const@LoZ@titleseptrue THEN require constant LoT item refnum/title separation
            \ifnum\value{table} < 10                                            % IF table refnum N<10 in current Chapter C (i.e. IF N<10 -> N:=[n] in "Table C.n"
                \cfttab@snum@titlesep{#4}%                                      % THEN (=>) ADD ONLY the title separator \cfttab@snum@titlesep before LoT item title = <title> OR <short title>
            \else                                                               % ELSE (=>) WHEN(N<10 -> N:=[n])
                {\hskip\DBLdigit@refnum@skip}%                                  % ADD \hskip\DBLdigit@refnum@skip to make room for extra digit n in "Table C.nn"
                \cfttab@snum@titlesep{#4}%                                      % ADD desired title separator \cfttab@snum@titlesep
            \fi
        \else                                                                   % ELSE (=>) WHEN(\@force@const@LoZ@titlesepfalse <=> align LoT item titles)
            {\hskip\LoZnumline@padskip}%                                        % ADD \hskip\LoZnumline@padskip to shift LoT item title right by approx. width of 1 digit n to make room for "Table C.nn" WHEN(N>=10 -> N:=[nn])
            \cfttab@snum@titlesep{#4}%                                          % ADD desired title separator \cfttab@snum@titlesep yielding LoT item numbering/title separation -> WHEN( N<10 -> N:=[n] || N>=10 -> N:=[nn]) (=>) (\cfttab@snum@titlesep + \hskip\LoZnumline@padskip || \cfttab@snum@titlesep)
        \fi
    }%                                                                          % CLOSE ON ARG#3 of \addcontentsline (MATCHES unconventional OPEN ON ARG#3 hidden before \protect)
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- FRONTMATTER ---------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%----------------------------------- Frontmatter (Prologue) pages: construction & formatting -----------------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------ Frontmatter (Prologue) page inclusion/exclusion, basic formatting, & controls ------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Create and initializae (conditional) boolean parameter registers controlling inclusion/exclusion of \thesisXPages
%-------------------------------------------------------------------------------------------------------------------------------%
%   # most 'XPage' pages are not included IF empty & automatically included IF NOT empty
%   # 'XPage' pages that are NOT empty can still be excluded using the \excludeXPage user control sequences in Dissertation-Prologue.tex
%   # \excludeXPage simply expands \@makeXpagefalse -> \if@makeXPage=FALSE
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@makeAbstractPage\@makeAbstractPagetrue                                % set DEFAULT=TRUE
\newif\if@makeCopyrightPage\@makeCopyrightPagetrue                              % set DEFAULT=TRUE
\newif\if@makeLoF\@makeLoFfalse                                                 % set DEFAULT=FALSE
\newif\if@makeLoT\@makeLoTfalse                                                 % set DEFAULT=FALSE
\newif\if@makeAcknowledgements\@makeAcknowledgementsfalse                       % set DEFAULT=FALSE
\newif\if@makeDedication\@makeDedicationfalse                                   % set DEFAULT=FALSE
\newif\if@makeAttributions\@makeAttributionsfalse                               % Blake added, 2021: set DEFAULT=FALSE
\newif\if@makeReaderThree\@makeReaderThreefalse                                 % set DEFAULT=FALSE
\newif\if@makeReaderFour\@makeReaderFourfalse                                   % set DEFAULT=FALSE
\newif\if@makeReaderFive\@makeReaderFivefalse                                   % set DEFAULT=FALSE
%-------------------------------------------------------------------------------------------------------------------------------%
% User control sequences for INCLUDING these pages
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\makeCopyrightPage}{\@makeCopyrightPagetrue}
\newcommand*{\makeListOfFigures}{\@makeLoFtrue}
\newcommand*{\makeListOfTables}{\@makeLoTtrue}
%-------------------------------------------------------------------------------------------------------------------------------%
% User control sequences for EXCLUDING these [optional] pages
%-------------------------------------------------------------------------------------------------------------------------------%
\def\excludeAbstractPage{\@makeAbstractPagefalse}                               % exclude Abstract page from document, even if NOT EMPTY
\def\excludeAcknowlegmentsPage{\@makeAcknowledgementsfalse}                     % exclude Acknowledgements page from document, even if NOT EMPTY
\def\excludeDedicationPage{\@makeDedicationfalse}                               % exclude Dedication page from document, even if NOT EMPTY
\def\excludeAttributionsPage{\@makeAttributionsfalse}                           % exclude Attributions page from document, even if NOT EMPTY
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Frontmatter (Prologue) page formatting & controls --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Page formatting controls: indentation, (effective) top margin, heading & text font shape/style
%-------------------------------------------------------------------------------------------------------------------------------%
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Simple TeX definitions for storing relevant length values (without allocating more length registers, which are unnecessary here)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\centering@frontmatter@vshift{0.2in}                                        % Vertical shift introduced by inserting headers after \centering macro
\def\centerEnv@frontmatter@vshift{0.2in}                                        % Vertical shift introduced by inserting headers using the 'center' environment
%-------------------------------------------------------------------------------------------------------------------------------%
% Frontmatter (Prologue) page heading font control
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setXPageFontShape[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @fontshape}{\csname #2\endcsname}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Frontmatter (Prologue) page heading font style control
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setXPageFontStyle[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @fontstyle}{#2}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Frontmatter (Prologue) page text font style control
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setXTextFontStyle[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @text@fontstyle}{#2}
    \csletcs{\@page@cs@basename @stash@fontstyle}{\@page@cs@basename @text@fontstyle}
}
%------------------------------s-------------------------------------------------------------------------------------------------%
% Frontmatter (Prologue) page text indentation control
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setXPageParindent[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @parindent}{\hspace{#2}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Shift Page header down a specific distance from the top of the page (vspacing)
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setXPageTopMargin[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @topmargin}{\vspace*{\dimexpr #2 - \baselinestretch@pts -\LaTeX@page@topskip - \centering@frontmatter@vshift\relax}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\WithSuffix\newcommand\setXPageTopMargin*[2]{%
    \lookup@page@cs@basename{#1}
    \csdef{\@page@cs@basename @topmargin@centerEnv}{\vspace*{\dimexpr #2 - \baselinestretch@pts - \LaTeX@page@topskip - \centerEnv@frontmatter@vshift\relax}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Aliases for selected Frontmatter formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
\let\setXStashFontStyle\setXTextFontStyle                                       % ALIAS for \setXTextFontStyle
\let\shiftPageHeaderDown\setXPageTopMargin                                      % ALIAS for \setXPageTopMargin
\let\setXPageHeaderBeforeskip\setXPageTopMargin                                 % ALIAS for \setXPageTopMargin
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Frontmatter (Prologue) page text stashes & lists ---------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Create empty "stash" for storing the text contents of the Abstract, Acknowledgements, Dedication, & Attributions pages
%-------------------------------------------------------------------------------------------------------------------------------%
%   # the content specified in the argument of \abstract, \acknowledgments, \dedication, & \attributions in Dissertation-Prologue.tex
%   + Blake, 2023: ADDED stash for Abstract control sequence (\abstract)
%-------------------------------------------------------------------------------------------------------------------------------%
\gdef\abstractStash{\relax}
\gdef\acknowledgementsStash{\relax}
\gdef\dedicationStash{\relax}
\gdef\attributionsStash{\relax}
%-------------------------------------------------------------------------------------------------------------------------------%
% Specialized lists constructed & configured for usage
%-------------------------------------------------------------------------------------------------------------------------------%
\newlist{attributionList}{enumerate}{2}                                         % For inserting publication atteributions on Attributions page
\setlist[attributionList]{
    label=(\arabic*),
    ref={\arabic*},
    leftmargin=0.25in,
    topsep=0pt,
    partopsep=0pt,
    parsep=0pt,
    itemsep=0pt
}
%-------------------------------------------------------------------------------------------------------------------------------%
\newlist{authorList}{itemize}{1}                                                % For inserting author contributions to each attribution
\setlist[authorList]{
    label=\textbullet,
    leftmargin={\labelwidth-\labelsep},
    topsep=0pt,
    itemsep=0pt,
    itemindent=0pt
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%----------------- Frontmatter (Prologue) page(s) construction: ordering, pagination/numbering, and page style -----------------%
%===============================================================================================================================%
\newcommand{\thesisPrologue}
{
	% Start COUNTING, but not NUMBERING, pages here (Baylor's first pages are unpaginated, but counted!)
	\pagenumbering{roman}
	\pagestyle{empty}
	
    % Unpaginated frontmatter (preliminary/Prologue) pages
	\thesisAbstractpage
    \thesisTitlePage
	\thesisCopyrightPage
	
	% Start paginating, i.e. NUMBERING pages, here (making ToC page "iv" or so)
	\pagestyle{plain}
	
	% Paginated frontmatter (preliminary/Prologue) pages
    \thesisToCpage
    \thesisLoFpage
    \thesisLoTpage

    % \thesisXpage INCLUDE IF: \X is uncommented in Dissertation-Prologue.tex AND \excludeX is commented out in Dissertation-Template.tex (i.e. if \if@makeXPage=TRUE via \if@makeXPagetrue)
    \thesisAcknowledgementspage
    \thesisDedicationpage                                                       % Blake, 2023: Formally added support and proper formatting of Dedication Page
    \thesisAttributionspage                                                     % Blake, 2021: ADDED
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%----------------------------------------- Abstract page contruction (heading at 2.5") -----------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2021: Replaced "center" environment with grouped \centering justification clause, otherwise interferes with
%     \vspace* generating heading at the 2.5" mark
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAbstractpage}
{%
	\if@makeAbstractPage                                                       % Blake, 2023: Added ability to exclude Abstract, at least temporarily, as it is a REQUIRED page
        \doublespacing
        \thispagestyle{empty}
    	\if@makeDraftThesis
    		\begin{center}
    			\Huge Draft \\
    			\Large \today \normalsize
    		\end{center}
    		\vspace{-8em}
    	\fi
    	\begingroup
            \centering
            \vspace*{1.28in}%                                                   % Blake, 2023: Reduced vspacing from 1.3in to 1.28in to better generate the heading at 2.5"
            \abstractHeading\\
    		\thesisTitle\\
    		\thesisAuthorName, \thesisSeeking\\
            \thesisMentorTitle: \thesisMentor\\[1em]%                           % Blake added, 2021: creates so called "triple space"
        \endgroup
        \par
        \abstractStash                                                       % Blake, 2023: renamed \thesisAbstract to \abstractStash for consistency w/ other Prologue page macros
        %\thesisAbstract
    	\clearpage
    \fi
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------------------------------------- FRONTMATTER ---------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%---------------------------------------- Title/Signature page settings & contruction ----------------------------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Create "special" centered footer for the signature page \thesisCopyrightPage
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: Packages 'fncychap', 'fancyhdr' ('fancyX' in general) have been known to cause "conflicts"/"clashes" with
%     other packages & produce unexpected behavior that is frustratingly difficult to diagnose. 'fancyhdr' was updated in 2022
%     & it appears that some of the clashes it caused, with 'tocloft' in particular, have disappeared yet there is no mention
%     of this in the release notes; it may have been fixed accidentally or this .cls was changed such that in no longer mattered. 
%     Given that this package is used EXCLUSIVELY for this 1 \fancypagestyle (containing \fancyhf{}), behavior that could be 
%     generated by other TeX means, removing this package in favor of any alternative approach should be considered.
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{fancyhdr}
%-------------------------------------------------------------------------------------------------------------------------------%
\fancypagestyle{thesisTitlePageStyle}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\cfoot{\footnotesize \textit{Page bearing signatures is kept on file in the Graduate School.}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Option to insert title/signature page from PDF file; otherwise, page is TeX generated
% Blake, 2021: Added this capability.
% Initially is unsigned PDF form directly from Grad School, but can also be used to insert the signed PDF form
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{pdfpages}                                                       % Provides clean PDF insertion capability (Blake added, 2021)
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@insertSignaturePage\@insertSignaturePagefalse
\newcommand*\signaturePageAddr{}
\newcommand*\insertSignaturePage[1]{%
    %USAGE: \insertSignaturePage{<PDF file location>}
    \@insertSignaturePagetrue
    \renewcommand*\signaturePageAddr{#1}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Internal macro for drawing signature lines
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisSignature}[2]{%
    %USAGE: \thesisSignature{<text>}{<vrule width>}
    \normalsize
    \vspace{0.05in}
    \\
    \vrule width #2 height 0.2mm
    \\
    \vspace{-0.15in}
    #1
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------------------------------- Title page contruction ----------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Title/signature page contruction
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisTitlePage}
{
    \if@insertSignaturePage%
        \includepdf{\signaturePageAddr}
    \else
    	\thispagestyle{thesisTitlePageStyle}
    	
    	
    	\begin{center}
    	   \doublespacing\vspace*{0.1in}
    		\thesisTitle \\
    		by \\
    		\thesisAuthorName, \thesisHolding \\
    		A Thesis \\
    		Approved by the \thesisDepartment
    		\thesisSignature{\thesisDepartmentChair, Chairperson}{97mm}
    	\\
    	\vspace{0.1in}
    	\begingroup\singlespacing
        Submitted to the Graduate Faculty of\\
    	Baylor University in Partial Fulfillment of the \\
    	Requirements for the Degree \\
    	of \\
    	\thesisDegree\par
    	\endgroup
    	\vspace{0.25in}
    	\vfill
    	\begingroup
    	\doublespacing
    		\addtolength{\leftskip}{-2.25in}
         	Approved by the Thesis Committee
         	\thesisSignature{\thesisMentor, Chairperson}{80mm}
         	\thesisSignature{\thesisReaderOne}{80mm}
         	\thesisSignature{\thesisReaderTwo}{80mm}
    		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm} \fi
    		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm} \fi
    		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm} \fi
    		\\
    	\endgroup
    	
    	\vspace{0.25in}
    	\vfill
    	
    	\begingroup
    		\doublespacing\addtolength{\leftskip}{2.6in}
    		Accepted by the Graduate School \\
    		\vspace{-0.075in}
    		\thesisConfDate
    		\thesisSignature{\thesisDean, Dean}{80mm} \\
    	\endgroup%
    	%\singlespacing
        \end{center}
    \fi
        \clearpage
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------------------- Copyright page contruction --------------------------------------------------%
%===============================================================================================================================%
\def\Copyright@topskip{8.19in}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisCopyrightPage}
{
    \if@makeCopyrightPage
        \thispagestyle{empty}
		\vspace*{\Copyright@topskip}
		\begin{center}
            Copyright \copyright{} \the\year\space by  \thesisAuthorName\\
            All rights reserved
		\end{center}
		\clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- FRONTMATTER ---------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------- Table of Contents (ToC), List of Figures (LoF), & List of Tables (LoT) page settings & construction -------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
% General ToC/LoZ list item construction & formatting controls
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% DEFINE/SET general parameters common to ToC/LoZ items
%-------------------------------------------------------------------------------------------------------------------------------%
\def\cftgroupsep@default{8\p@}                                                  % DEFINE the DEFAULT vspacing to be added between ToC/LoZ items from different "groups", e.g. between groups of ToC items from different chapters
\def\cftparskip@factor{0.75}                                                    % DEFINE the scaling factor of \baselineskip used to define the vertical ToC spacing parameter \cftparskip
\MULTIPLY{\cftparskip@factor}{2}{\cftparskip@dblfactor}                         % Calculate double the \cftparskip@factor for use in defining \cftXbeforeskip for X=part/chapter
\DIVIDE{\cftparskip@factor}{0.25}{\num@quarter@cftparskips}                     % Calculate the # of multiple 'x' of 0.25 in \cftparskip@factor (used to determine 'x' in mx + b calculation of \cftparskip@correction
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftparskip{-\cftparskip@factor\baselineskip}                      % vertical skip between paragraphs in ToC, i.e. between ToC entry item "groups"
\renewcommand\cftsetrmarg{2.75em}                                               % ToC global right margin
%\renewcommand\@tocrmarg{2.75em}                                                % ToC global right margin
\renewcommand\cftsetpnumwidth{1.85em}                                           % ToC global page numberline box width
%\renewcommand\@pnumwidth{1.85em}                                               % ToC global page numberline box width
%-------------------------------------------------------------------------------------------------------------------------------%
% Vertical spacing "corrections" that are required for accurate behavior but whose causes are not well understood yet
%-------------------------------------------------------------------------------------------------------------------------------%
\newlength\mystery@vshift@yintercept
\newlength\mystery@vshift@m
\newlength\cftparskip@correction
%-------------------------------------------------------------------------------------------------------------------------------%
\let\mystery@vshift@x\num@quarter@cftparskips                                   % Define alias of \num@quarter@cftparskips matching current \mystery@vshift@X naming associated with mx + b calculation context
\setlength\mystery@vshift@yintercept{-16.325pt}                                 % Sets value of yintercept = 'b' in mx + b calculation of \cftparskip@correction
\setlength\mystery@vshift@m{6.125pt}                                            % Sets value of 'm' in mx + b calculation of \cftparskip@correction
\setlength\cftparskip@correction{                                               % Calculates correction of \mystery@vshift as mx + b (technically xm + b here given TeX <length>*<scale> rule)
    \mystery@vshift@x\mystery@vshift@m + \mystery@vshift@yintercept             % <correction> = x * m + b
}
%\setlength\mystery@vshift@discrepancy{1.25pt}                                  % discrepant vertical shift in some titles/headings from expected locations - CUNKNOWN CAUSE
%-------------------------------------------------------------------------------------------------------------------------------%
% General LoZ item format parameters & control sequences applicable to \listofYs for specific (X:Z)={figure:F, table:T, ...}
%-------------------------------------------------------------------------------------------------------------------------------%
\newskip\DBLdigit@refnum@skip\DBLdigit@refnum@skip=0.5em
\newskip\LoZnumline@padskip\LoZnumline@padskip=\DBLdigit@refnum@skip
\newif\if@force@const@LoZ@titlesep\@force@const@LoZ@titleseptrue
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\setLoZtitlesConstsep{\@force@const@LoZ@titleseptrue}
\newcommand\setLoZtitlesAligned{\@force@const@LoZ@titlesepfalse}
%\setLoZtitlesConstsep
\setLoZtitlesAligned
%-------------------------------------------------------------------------------------------------------------------------------%
% Define new command to add vertical spacing between ToC/LoZ item groups of type G (OFTEN G=chapter}
%-------------------------------------------------------------------------------------------------------------------------------%
%   -/+ Blake, 2023:
%   - Removed this spacing between groups of Figure/Tables in the LoF/LoT, respectively, from different chapters
%   - Removed this spacing between ToC chapters in favor of using \cftbeforechapskip and \cftafterchapskip.
%   + Created this \addListXgroupsep to simplify reintroduction of such spacing to groups of any ListX items
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\addListXgroupsep[2][]{%                                             % Defines global listX applicable control sequence for defining additional ToC item "group" separations (e.g. separation between \chapter ToC list items)
    % USAGE: \addListXgroupsep[<opt.spacing>]{<ListX name = ancillary file extension>}
    \ifstrempty{#1}%
        {\addtocontents{#2}{\protect\addvspace{\cftgroupsep@default}}}          % Add default group separation spacing between groups of ListX items to its ancillary file (e.g. toc, lof, lot)
        {\addtocontents{#2}{\protect\addvspace{#1}}}                            % Add specified group separation spacing between groups of ListX items to its ancillary file (e.g. toc, lof, lot)
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
% ToC/LoF/LoT/LoZ settings & configurations (primarily via \cft__X__ control sequences provided by 'tocloft' package)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Uses the 'tocloft' package
%   # NOTE: overflowing chapter titles MUST be single-spaced
%-------------------------------------------------------------------------------------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Define (X:Y)={part:part,chap:chapter} leaders, page # fonts
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftpartleader{\listXFontStyle\cftdotfill{\cftchapdotsep}}         % Set 'part' leader and leader font formatting DEFAULT: \large\bfseries\cftdotfill{\cftpartdotsep}
\renewcommand\cftchapleader{\listXFontStyle\cftdotfill{\cftchapdotsep}}         % Set 'chap' leader and leader font formatting DEFAULT: \bfseries\cftdotfill{\cftchapdotsep}
\renewcommand\cftpartpagefont{\listXFontStyle}                                  % Set 'part' page number 'pnum' font formatting DEFAULT: \large\bfseries
\renewcommand\cftchappagefont{\listXFontStyle}                                  % Set 'chap' page number 'pnum' font formatting DEFAULT: \bfseries
\renewcommand\cftchapdotsep{\cftsecdotsep}                                      % first define the chap dots to be equal to the section dots
%-------------------------------------------------------------------------------------------------------------------------------%
%  Set \beforeXskip based (indirectly) on the value of \cftparskip=A\baselineskip via the 'factor' A & 2A
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: \cftbeforeXskip values are \cftparskip & 2\cftparskip, but \cftparskip isn't a length register token and
%     cannot simply be scaled in \setlength whereas \baselineskip can, so the multiplier A=\cftparskip@factor & 2A are used instead.
%   + Blake, 2023: ADDED multipliers \cftparskip@factor & \cftparskip@dblfactor so that the \cftbeforeXskip lengths automatically
%     adjust to changes in \cftparskip
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength\cftbeforepartskip{\cftparskip@dblfactor\baselineskip}                % beforeskip for ToC items = LoF, LoT, Acknowledgements, Dedication, Attributions
\setlength\cftbeforechapskip{\cftparskip@dblfactor\baselineskip}                % beforeskip for chapter item groups in the ToC
\setlength\cftbeforesecskip{\cftparskip@factor\baselineskip}                    % beforeskip for section entry items in the ToC
\setlength\cftbeforesubsecskip{\cftparskip@factor\baselineskip}                 % beforeskip for subsection entry items in the ToC
\setlength\cftbeforesubsubsecskip{\cftparskip@factor\baselineskip}              % beforeskip for subsubsection entry items in the ToC
%-------------------------------------------------------------------------------------------------------------------------------%
% ADD hanging indent to lines 2,3,4,... of ANY ToC/LoF/LoT item whose title spills over onto more than 1 ToC/LoZ item line.
%-------------------------------------------------------------------------------------------------------------------------------%
\def\cfthang@indent{0.35in}                                                     % DEFINE the DEFAULT vspacing to be added between ToC/LoZ items from different "groups", e.g. between groups of ToC items from different chapters
\newcommand\setcftHangIndents[1]{\def\cfthang@indent{#1}}                       % DEFINE front-end control for setting VALUE(\cfthang@indent) 
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftpartafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftchapafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftsecafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftsubsecafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftsubsubsecafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftparaafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftsubparaafterpnum{\hangindent\cfthang@indent}
\renewcommand\cftfigafterpnum{\hangindent\cfthang@indent}
\renewcommand\cfttabafterpnum{\hangindent\cfthang@indent}
%-------------------------------------------------------------------------------------------------------------------------------%
% Indentation & vertical spacing controls for ToC list items of <Level=L>
%-------------------------------------------------------------------------------------------------------------------------------%
\def\cftindent@chapLineTwo{0.35in}                                              % DEFINE indentation between 1st and 2nd lines of \chapter ToC 2-line list items
\def\cftindent@nextLevel{0.175in}                                               % DEFINE common relative indentation for all ToC list levels after <Level 2> chapter title line
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Indents for Y={chapter,section,subsection,subsubsection} ToC items
%-------------------------------------------------------------------------------------------------------------------------------%
%   # USAGE: \cftsetindents{<listX name>}{<indent>}{<snumwidth>}
%   # indentations from chapter = 0in begin at \cftindent@chapLineTwo and increase by \cftindent@nextLevel for each subsequent level
%   # chapter & <sub, subsub>sections: currently unnumbered -> their \addcontentsline statements do not include a \numberline -> numberline box width = 0.0in
%-------------------------------------------------------------------------------------------------------------------------------%
\cftsetindents{chapter}{0in}{0in}
\cftsetindents{section}{      \cftindent@chapLineTwo + \cftindent@nextLevel  }{0in}
\cftsetindents{subsection}{   \cftindent@chapLineTwo + \cftindent@nextLevel*2}{0in}
\cftsetindents{subsubsection}{\cftindent@chapLineTwo + \cftindent@nextLevel*3}{0in}
\cftsetindents{paragraph}{    \cftindent@chapLineTwo + \cftindent@nextLevel*4}{0in}
%-------------------------------------------------------------------------------------------------------------------------------%
% Indents for Y={figure,table} LoZ items WHEN(USING \p@Y & SPECIFIC 'caption' behavior)->add "Figure "/"Table " before \theY refnums
%-------------------------------------------------------------------------------------------------------------------------------%
%   # USAGE: \cftsetindents{<listX name>}{<indent>}{<snumwidth>}
%   # figure/table number box width is adjusted by the width of \p@Y for Y={figure,table}
%-------------------------------------------------------------------------------------------------------------------------------%
\cftsetindents{figure}{0in}{\len@p@figure}                                      % Increase the width of the figure number line box to contain "Figure X.XX", but reduce the gap before subsequent title by 1em to ~1 space DEFAULT:{1.5em}{2.3em}
\cftsetindents{table}{0in}{\len@p@table}                                        % Increase the width of the table number line box to contain "Table X.XX", but reduce the gap before subsequent title by 1em to ~1 space DEFAULT:{1.5em}{2.3em}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------ Table of Contents (ToC) page settings & construction -------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Table of Contents (ToC) page settings
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Variation of beforeksip as \cftparksip@factor changes: 0.5in - 16.325pt + \num@quarter@cftparskips * 6.125pt
%   # \baselinestretch = EMPTY here, but is set to \baselinestretch = 1.655 within the document
%   # \baselineskip = 14.5pt here, but is scaled by \baselinestretch = 1.655 within the document to \baselineskip = 23.997pt
%   # \cftparskip@correction = ax + b is a "hack" to account for the variation as x = \cftparksip@factor varies, but the underlying
%       cause is not well understood. The 6pt portion of the variation per 0.25 factor change is 0.25 of \baselineskip = 23.997pt,
%       but the additional ~0.125pt is perplexing.
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\cftaftertoctitle}{}                                              % Control sequence executed after ToC title
\renewcommand{\cfttoctitlefont}{\centering\listXFontStyle}                      % Center the ToC title & apply font style settings
\setlength\cftbeforetoctitleskip{0.5in + \cftparskip@correction}                % Vertical skip before Table of Contents title (IMPLICITLY includes the 1" unnamed vertical offset from the top of each LaTeX page)
\setlength\cftaftertoctitleskip{3\baselineskip}                                 % Vertical skip after Table of Contents title
%-------------------------------------------------------------------------------------------------------------------------------%
\setcounter{tocdepth}{2}                                                        % Includes ONLY ToC entry items up to a 'depth' of 2 corresponding to <Level=4>:=\subsection since
\setcounter{secnumdepth}{5}                                                     % Blake, 2023: Sets the <Level=5> at which sectioning command numbering is permitted, suppressing it for each Level > N=5
%-------------------------------------------------------------------------------------------------------------------------------%
% Table of Contents (ToC) page construction (heading at 1.5")
%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand{\thesisToCpage}{\begingroup\tableofcontents\endgroup\clearpage}
\newcommand{\thesisToCpage}{%
    \begingroup\singlespacing\tableofcontents\endgroup
	\clearpage
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------- List of Figures (LoF) page settings & construction --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Figures (LoF) page settings
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\cftloftitlefont}{\centering\listXFontStyle}
\renewcommand{\cftafterloftitle}{}                                              % Control sequence executed after after LoF title (but outside LoF title brace group)
\setlength\cftbeforeloftitleskip{0.5in + \cftparskip@correction}                % Vertical skip before LoF title (IMPLICITLY includes the 1" unnamed vertical offset from the top of each LaTeX page)
\setlength\cftafterloftitleskip{1.5\baselineskip}                               % Vertical skip after LoF title
\setlength\cftbeforefigskip{1.5\baselineskip}                                   % beforeskip for Figure items in the LoF
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Figures (LoF) page construction (heading at 1.5") [if applicable]
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisLoFpage}
{%
	\if@makeLoF
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\listXFontStyle\cftLoFlabel}
		\begingroup\listoffigures\endgroup
		\clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- List of Tables (LoT) page settings & construction --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Tables (LoT) page settings
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\cftlottitlefont}{\centering\listXFontStyle}
\renewcommand{\cftafterlottitle}{}                                              % Control sequence executed after LoT title (but outside LoT title brace group)
\setlength\cftbeforelottitleskip{0.5in + \cftparskip@correction}                % Vertical skip before LoT title (IMPLICITLY includes the 1" unnamed vertical offset from the top of each LaTeX page)
\setlength\cftafterlottitleskip{1.5\baselineskip}                               % Vertical skip after LoT title
\setlength\cftbeforetabskip{1.5\baselineskip}                                   % beforeskip for Table items in the LoT
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Tables (LoT) page construction (heading at 1.5") [if applicable]
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisLoTpage}{
	\if@makeLoT
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\listXFontStyle\cftLoTlabel}
		\begingroup\listoftables\endgroup
		\clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- FRONTMATTER ---------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------- Acknowledgements, Dedication, & Attributions page construction & formatting -------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---------------------------------- Acknowledgments page settings & construction  [optional] -----------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Acknowledgments page formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
\setXPageTopMargin*{Acknowledgements}{1.5in}                                    % Specify desired distance between the top of the page and beginning of header (sets \acknowledgements@topmargin@centerEnv)
\setXPageParindent{Acknowledgements}{\parindent}                                % Specify desired paragraph indentation (sets \acknowledgements@parindent)
\setXPageFontStyle{Acknowledgements}{\XheadingFontStyle}                        % Specify desired font style for the header text (sets \acknowledgements@fontstyle)
\setXPageFontShape{Acknowledgements}{rm}                                        % Specify desired font shape for the "stash" text (sets \acknowledgements@fontshape)
\setXStashFontStyle{Acknowledgements}{\XtextFontStyle}                          % Specify desired font style for the "stash" text (sets \acknowledgements@text@fontstyle & alias \acknowledgements@stash@fontstyle)
%\setXTextFontStyle{Acknowledgements}{\XtextFontStyle}                          % Specify desired font style for the "stash" text (sets \acknowledgements@text@fontstyle & alias \acknowledgements@stash@fontstyle)
%-------------------------------------------------------------------------------------------------------------------------------%
% Acknowledgments page construction (heading at 1.5") [optional]
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAcknowledgementspage}
{
    \if@makeAcknowledgements
        \thispagestyle{plain}
        \phantomsection                                                         % Anchor the bookmark to this position
        \addcontentsline{toc}{part}{\listXFontStyle\acknowledgementsToClabel}   %
		\begin{center}
            \acknowledgements@topmargin@centerEnv                               % Adjusts vspacing to generate the heading at the desired distance from the top of the page (set by \setXPageTopMargin)
            \acknowledgements@fontstyle                                         % Sets fontstyle of header as specified by \setXPageFontStyle
            \acknowledgementsHeading
        \end{center}
        \begingroup                                                             % Enforce local context for fontstyle
            \acknowledgements@parindent                                         % Applies indentation specified by \setXPageParindent
            \acknowledgements@fontshape%                                        % Applies font shape specified by \setXPageFontShape
            \acknowledgements@stash@fontstyle%                                  % Sets fontstyle of 'stash' content as specified by \setXStashFontStyle
            \acknowledgementsStash                                              % Retrieve the text content that was temporarily stored in the stash
        \endgroup
		\clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------- Dedication page settings & construction [optional] --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Dedication page formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
\setXPageTopMargin*{Dedication}{3.0in}                                          % Specify desired distance between the top of the page and beginning of header (sets \dedication@topmargin@centerEnv)
\setXPageParindent{Dedication}{0\p@}                                            % Specify desired paragraph indentation (sets \dedication@parindent)
\setXPageFontStyle{Dedication}{\XheadingFontStyle}                              % Specify desired font style for the header text (sets \dedication@fontstyle)
\setXPageFontShape{Dedication}{it}                                              % Specify desired font shape for the "stash" text (sets \dedication@fontshape)
\setXStashFontStyle{Dedication}{\XtextFontStyle}                                % Specify desired font style for the "stash" text (sets \dedication@text@fontstyle & alias \dedication@stash@fontstyle)
%\setXTextFontStyle{Dedication}{\XtextFontStyle}                                % Specify desired font style for the "stash" text (sets \dedication@text@fontstyle & alias \dedication@stash@fontstyle)
%-------------------------------------------------------------------------------------------------------------------------------%
% Dedication page construction (heading at 3.0") [optional]
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisDedicationpage}
{
	\if@makeDedication		
		\thispagestyle{plain}
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\listXFontStyle\dedicationToClabel}
        \begin{center}%
            %\vspace*{1.8in}
            \dedication@topmargin@centerEnv                                     % Adjusts vspacing to generate the heading at the desired distance from the top of the page (set by \setXPageTopMargin)
            \dedication@fontstyle                                               % Sets fontstyle of header as specified by \setXPageFontStyle
            \dedicationHeading
        \end{center}
        %\begin{center}\dedicationStash\end{center}                             % Blake, 2023: REPLACED 'center' wrapped stash with unwrapped stash
        \begingroup                                                             % Enforce local context for fontstyle
            \centering                                                          % Center the text in this local context
            \dedication@parindent                                               % Applies indentation specified by \setXPageParindent
            \dedication@fontshape%                                              % Applies font shape specified by \setXPageFontShape
            \dedication@stash@fontstyle                                         % Sets fontstyle of 'stash' content as specified by \setXStashFontStyle
            \dedicationStash%                                                   % Retrieve the text content that was temporarily stored in the stash
            \par                                                                % Force stash into proper paragraph, otherwise \centering has no effect
        \endgroup
        \clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%------------------------------------------ Attributions page settings & construction ------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: ADDED 'Attributions' page & attributions list construction & formatting controls
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Attributions page formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
\setXPageTopMargin{Attributions}{1.5in}                                        % Specify desired distance between the top of the page and beginning of header (sets \attributions@topmargin@centerEnv)
\setXPageParindent{Attributions}{\parindent}                                    % Specify desired paragraph indentation (sets \attributions@parindent)
\setXPageFontStyle{Attributions}{\XheadingFontStyle}                            % Specify desired font style for the header text (sets \attributions@fontstyle)
\setXPageFontShape{Attributions}{rm}                                            % Specify desired font shape for the "stash" text (sets \attributions@fontshape)
\setXStashFontStyle{Attributions}{\XtextFontStyle}                              % Specify desired font style for the "stash" text (sets \attributions@text@fontstyle & alias \attributions@stash@fontstyle)
%\setXTextFontStyle{Attributions}{\XtextFontStyle}                              % Specify desired font style for the "stash" text (sets \attributions@text@fontstyle & alias \attributions@stash@fontstyle)
%-------------------------------------------------------------------------------------------------------------------------------%
% Create basic 'attribution' item environment based on the 'singlespace' environment
%-------------------------------------------------------------------------------------------------------------------------------%
\newenvironment{attribution}{%
    \begin{singlespace}%
}{%
    \end{singlespace}%
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Attributions page construction (heading at 1.5") [if applicable]
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAttributionspage}
{%
	\if@makeAttributions
		\thispagestyle{plain}
        \phantomsection%                                                        % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\listXFontStyle\attributionsToClabel}%
		\begingroup
            %\vspace*{0.3in}                                                    % Blake, 2023: REPLACED with \attributions@topmargin
            \centering%                                                         % Center the content (REQUIRES \\ OR \par before \endgroup to apply \centering paragraph formatting)
            \attributions@topmargin%                                            % Adjusts vspacing to generate the heading at the desired distance from the top of the page (set by \setXPageTopMargin)
            \attributions@fontstyle%                                            % Sets fontstyle of header as specified by \setXPageFontStyle
            \attributionsHeading\\[-0.5\baselineskip]%                          % Blake, 2023: Replaced the \vspace after this group w/ this newline + voffset
        \endgroup
        %\vspace{-0.5\baselineskip}                                             % Blake, 2023: Moved/replaced with \\[-0.5\baselineskip
        \begingroup                                                             % Enforce local context for fontstyle
            \attributions@parindent%                                            % Applies indentation specified by \setXPageParindent
            \attributions@fontshape%                                            % Applies font shape specified by \setXPageFontShape
            \attributions@stash@fontstyle%                                      % Sets fontstyle of 'stash' content as specified by \setXStashFontStyle
            \attributionsStash%                                                 % Retrieve the text content that was temporarily stored in the stash
        \endgroup
		\clearpage
	\fi
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------------------------------------- BACKMATTER ----------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------ Appendix/Appendices: title page & content page(s) contruction [if applicable] ------------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Appendix chapter construction: CASE = 2+ appendix chapters (APPENDICES)
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED for defining chapter behavior for multiple 'APPENDICES' (replaces \@chapter)
%   + Blake, 2023: ADDED 2-line chapter ToC entry items:
%       + since chapter items are separated by doublespace and the 2-line entry should be separated by a singlespace, a manual
%         insertion of negative \addvspace is inserted between the two items in the ToC.
%       + similarly, manual hspacing was added to the 2nd chapter ToC line to generate 2 consecutive chapter entry items with
%         different indentations.
%-------------------------------------------------------------------------------------------------------------------------------%
\setMainPageTopMargin{Appendix}{1.5in}
%-------------------------------------------------------------------------------------------------------------------------------%
% Encapsulation of the 2-line ToC item entries for \chapter[]{}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\cft@twoline@chapter@item[4]{%
    \ifnum \value{section} <\@ne
        \addcontentsline{toc}{chapter}{\protect#1}%                             % Blake, 2023: 1st \chapter ToC line - adds appendix 'alph' numbering to "APPENDIX" (auto preprended as per redef of \addcontentsline in \appendix@redotocentry@pp)
        \addtocontents{toc}{\protect\addvspace{#2}}                             % Blake, 2023: Required manual ToC V-spacing for 2-line chapter ToC entry items
    \fi
    \addcontentsline{toc}{chapter}{\protect#3\rm#4}%                            % Blake, 2023: Indent 2nd ToC line and print ONLY the APPENDIX chapter title (no numbering)
    %\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}   % Blake, 2023: REPLACED- removed chapter numbering from ToC entry
}
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter@multiple@appendices[#1]#2
{%  USAGE: \@chapter@multiple@appendices[<alt-heading=short ToC title]{<full title>}
    \setcounter{footnoteA}{0}                                                   % the footnotes should start with 1 in each chapter
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
%        \cft@twoline@chapter@item{\rm\thechapter}%
%                        {-\halfline@space-\mystery@vshift@discrepancy}%
%                        {\hskip\cftindent@chapLineTwo}{#1}
        \ifnum \value{section} <\@ne
            \addcontentsline{toc}{chapter}{\protect\rm\appendixname\space\thechapter}%             % Blake, 2023: 1st \chapter ToC line - adds appendix 'alph' numbering to "APPENDIX" (auto preprended as per redef of \addcontentsline in \appendix@redotocentry@pp)
            \addtocontents{toc}{\protect\addvspace{%                            % Blake, 2023: Required manual ToC V-spacing for 2-line chapter ToC entry items
                    -\cftparskip@factor\doubleline@space%                       % where \doubleline@space is the INITIAL value 14.5pt before being stretched by \baselinestretch=1.655 to ~24pt (23.997pt)
                    %-\mystery@vshift@discrepancy                               % and IF the unknown 1.25pt voffset is being removed for <sub, subsub>sections, remove it here too so their ToC linespacings match
                }%
            }
        \fi
        \addcontentsline{toc}{chapter}{%                                        % Blake, 2023: Indent 2nd ToC line and print ONLY the APPENDIX chapter title (no numbering)
                \protect\unskip\hskip\cftindent@chapLineTwo\rm#1%
        }%
		%\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}% Blake, 2023: REPLACED- removed chapter numbering from ToC entry
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	\begingroup
		\centering
        %\vspace*{0.41in}                                                       % Blake, 2023: Adjusted from 0.43in to 0.41in to generate heading at 1.5"
        \appendix@topmargin                                                     % Blake, 2023: Replaced explicit \vspace* with vspacing macro
        %\old@appendixname%                                                     % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
        %\@chapapp{}                                                            % Blake, 2023: this may need to be changed, but will be left intact for now
        \appendixHeading\space\thechapter\\[0.0pt]%                             % Blake, 2023: print chapter number as UPPERCASE number name in heading
        %\appendixHeading\space\ARABICNumName{\thechapter}\\[0.0pt]%            % Blake, 2023: print chapter number as UPPERCASE number name in heading
		\begingroup%
            \centering
            #2\\[\singleline@space]%
        \endgroup
        %\appendixHeading%                                                      % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
        %\space\thechapter                                                      % Blake, 2023: print 'alph' chapter number after text heading
        %\vspace{-1ex}
		%\singlespacing{#2}\\
		%\vspace{0.13in}
        %\old@appendixname%                                                     % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
	\endgroup
	\@afterheading
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Appendix chapter construction: CASE = 1 appendix chapter (APPENDIX)
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: ADDED for defining chapter behavior for a single 'APPENDIX' (replaces \@chapter)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter@singular@appendix[#1]#2
{%  USAGE: \@chapter@singular@appendix[<alt-heading=short ToC title]{<full title>}
	% the footnotes should start with 1 in each chapter
	\setcounter{footnoteA}{0}
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
        \ifnum \value{section} <\@ne
            \addcontentsline{toc}{chapter}{\protect\rm}%                        % Blake, 2023: ONLY applies fontstyle, "APPENDIX" heading auto prepended to \addcontentsline as it's redefined for APPENDIX context
            \addtocontents{toc}{\protect\addvspace{%                            % Blake, 2023: Required manual ToC V-spacing for 2-line chapter ToC entry items
                    -\cftparskip@factor\doubleline@space%                       % where \doubleline@space is the INITIAL value 14.5pt before being stretched by \baselinestretch=1.655 to ~24pt (23.997pt)
                    %-\mystery@vshift@discrepancy                               % and IF the unknown 1.25pt voffset is being removed for <sub, subsub>sections, remove it here too so their ToC linespacings match
                }%
            }
        \fi
        \addcontentsline{toc}{chapter}{%                                        % Blake, 2023: Indent 2nd ToC line and print ONLY the APPENDIX chapter title (no numbering)
                \protect\hskip\cftindent@chapLineTwo\rm#1%
		}
        %\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}% Blake, 2023: REPLACED- removed chapter numbering from ToC entry
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	\begingroup
		\centering
        %\vspace*{0.41in}                                                       % Blake, 2023: Adjusted from 0.43in to 0.41in to generate heading at 1.5"
        \appendix@topmargin                                                     % Blake, 2023: Replaced explicit \vspace* with vspacing macro
        %\old@appendixname%                                                     % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
        \appendixHeading\\[0.0pt]%                                              % Blake, 2023: print chapter number as UPPERCASE number name in heading
        %\appendixHeading\space\ARABICNumName{\thechapter}\\[0.0pt]%            % Blake, 2023: print chapter number as UPPERCASE number name in heading
		\begingroup%
            \centering
            #2\\[\singleline@space]%
        \endgroup
%        \appendixHeading%                                                      % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
%        \hspace{-0.25em}                                                       % for the chapter text to look pretty.
%        %\ARABICNumName{\thechapter}                                           % Blake, 2023: Removed APPENDIX numbering when there is only a single appendix (numAppendices=1)
%        \vspace{-1ex}
%        \singlespacing{#2}\\
%        \vspace{0.13in}
	\endgroup
	\@afterheading
}
%-------------------------------------------------------------------------------------------------------------------------------%
% ALTERNATIVE Appendix \<sub, subsub>section definition renewal scheme
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: REPLACED explicit redefinitions of \section, \subsection, \subsubsection within the numAppendices=1 branch of
%     \thesisAppendixPage with \let\Xsection\Xsection@singular@appendix statements using the following variant sectioning commands
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\section@singular@appendix}[2][]                                    % move down 1 level, use optional \section parameter to fix ToC num/title gap by -3ex
{%  USAGE: \section@singular@appendix[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
    \@startsection{subsection}{3}{0pt}{1em}{0.001ex}                            % skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
	{\centering\normalfont\slshape\normalsize}[\ToCentry]{##2}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\subsection@singular@appendix}[2][]                                 % move down 1 level
{%  USAGE: \subsection@singular@appendix[<alt-heading=short ToC title>]{<heading>}
    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
	\@startsection{subsubsection}{4}{0pt}{0.001ex}{0.001ex}
	{\vspace{1em}\normalfont\slshape\normalsize}[\ToCentry]{##2}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\subsubsection@singular@appendix}[2][]                              % move down 1 level
{%  USAGE: \subsubsection@singular@appendix[<alt-heading=short ToC title>]{<heading>}
    \vspace{1em}                                                                % Blake, 2023: [is this really needed?]
    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
	\@startsection{paragraph}{5}{0\p@}{0.001em}{-1em}%
	{\normalfont\slshape\normalsize}%
    [\ToCentry]{##2}%
    {.}                                                                         % Blake, 2023: [is this really needed?] adds a period/fullstop/dot after the title
}
%-------------------------------------------------------------------------------------------------------------------------------%
% CURRENT Appendix \<sub, subsub>section definition renewal scheme (ALTERNATIVE ABOVE)
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDDED potential scheme for redefining \<sub, subsub>section control sequences for the APPENDIX which would
%     significantly reduce the length/complexity of \thesisAppendixPage.
%   # Blake, 2023: this solution scheme went through several iterations in a relatively short span of time. This scheme is
%     currently the most promising, but it may exhibit pitfalls that another does not, so no solution has beeen removed, only
%     commented out for easy retrieval & replacement if the need should arise
%   # Blake, 2023: this renewal scheme COULD ALSO provide useful elsewhere & for other purposes (SEE CHANGELOG for more detail)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\appendix@sectioning@renewals{
    \global\let\old@section\section                                             % save the definition of \section before redefining it
    \global\let\old@subsection\subsection                                       % save the definition of \subsection before redefining it
    \global\let\old@subsubsection\subsubsection                                 % save the definition of \subsubsection before redefining it
    \renewcommand{\section}[2][]{%                                              % move down 1 level, use optional \section parameter to fix ToC num/title gap by -3ex
        \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}%
        \@startsection{section}{3}{0pt}{1em}{0.001ex}%                           % skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
    	{\centering\normalfont\slshape\normalsize}[\ToCentry]{##2}%
    }
    \renewcommand{\subsection}[2][]{%                                            % move down 1 level
        \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}%
    	\@startsection{subsection}{4}{0pt}{0.001ex}{0.001ex}%
    	{\vspace{1em}\normalfont\slshape\normalsize}[\ToCentry]{##2}%
    }
    \renewcommand{\subsubsection}[2][]{%                                        % move down 1 level
        \vspace{1em}%                                                            % Blake, 2023: [is this really needed?]
        \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}%
    	\@startsection{subsubsection}{5}%
            {0\p@}{0.001em}{-1em}{\normalfont\slshape\normalsize}%
            [\ToCentry]%                                           % ToC list item entry
            {##2}%                                                 % heading text/formatting
            {.}%                                                                 % Blake, 2023: [is this really needed?] adds a period/fullstop/dot after the title
    }
}
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED variant of \@redotocentry@ppto control the ToC labels of sectioning commands in the Appendix independent
%     from sectioning commands in the main body of the document. *denotes lines that differ from (i.e. were added to)
%     \@redotocentry@pp.
%       # NOTE: this (& the original) command redefines \addcontentsline in the Appendix context to automatically include
%         \appendixname\space, so subsequent \addcontentsline only dictate what is APPENDED to \appendixname\space.
%-------------------------------------------------------------------------------------------------------------------------------%
%\global\let\old@appendixname\appendixname                                       % Save the \appendixname so it can be restored elsewhere
\newcommand{\appendix@redotocentry@pp}[1]{%
    \let\oldacl@pp=\addcontentsline%
    \def\addcontentsline##1##2##3{%
        \def\@pptempa{##1}\def\@pptempb{toc}%
        \ifx\@pptempa\@pptempb                                                  % if( ##1 = toc )
            \def\@pptempa{##2}\def\@pptempb{#1}%
            \ifx\@pptempa\@pptempb                                              % if( ##2 = #1 )
                \oldacl@pp{##1}{##2}{##3}%                   % Prepends \appendixname\space to ToC entry for all Appendix
                %\renewcommand\appendixname{}%                                   %*Remove APPENDIX/Appendix from ToC labels below Chapter level
            \else
                %\global\let\appendixname\old@appendixname%                      %*Restore APPENDIX/Appendix as ToC labels for next Chapter level
                \oldacl@pp{##1}{##2}{##3}%
            \fi
        \else
            \oldacl@pp{##1}{##2}{##3}%
        \fi
    }
}
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Appendix/Appendices page construction (heading at center page) [if applicable]
%-------------------------------------------------------------------------------------------------------------------------------%
%   # If singular Appendix detected (via .aux, so change detected on 2nd compile, then 3rd compile for .toc changes to take effect):
%       # Changes "APPENDICES" to "APPENDIX" on appendix page
%       # Adjusts
%       # Renews \section and uses optional ToC title parameter to effectively set \cftsecnumwidth.
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2021: ADDED automatic Appendix vs. Appendices detection & defines the \thesisAppendixPage heading to 'APPENDIX' or
%     'APPENDICES' depending on the # of appendix chapters in the document (recorded and written to .aux for retrieval on next
%     compilation): heading depends on whether there is 1 "Appendix" or 2+ "Appendices". Also fixes vertical centering of \thesisAppendixPage heading
%   + Blake, 2023: CHANGED sectioning commands to remove "A" from heading/ToC and REMOVED "APPENDIX" from \chapter ToC label
%-------------------------------------------------------------------------------------------------------------------------------%
\BeforeBeginEnvironment{appendices}{\thesisAppendixPage}                        % Prepend "APPENDIX"/"APPENDICES" page \thesisAppendixPage before beginning 'appendices' environment on next page
\AtEndEnvironment{appendices}{\auxwrite@regset{numAppendices}{\the\value{chapter}}}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAppendixPage}{

        \thispagestyle{plain}
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
        \phantomsection                                                         % Anchor the bookmark to this position
        %\appendixtitletocoff                                                   % remove "APPENDIX" from ToC chapter title
        \global\let\@redotocentry@pp\appendix@redotocentry@pp
        \ifnumcomp{\value{numAppendices}}{=}{1}{                                % If there is only 1 Appendix chapter
            \glet\old@chapter\@chapter                                          % save \@chapter JIC
            \glet\@chapter\@chapter@singular@appendix
            \glet\thisAppendixHeading\appendixHeading                           % set heading to Appendix
            \renewcommand{\thesection}{\arabic{section}}                        % remove "A" from section numbers
            \renewcommand{\thesubsection}{\arabic{subsection}}                  % remove "A" from subsection numbers
            % Blake, 2023: Save \Xsection definitions in \old@Xsection macros, then redefine \Xsection for use in singular Appendix
%            \global\let\old@section\section                                     % save the definition of \section before redefining it
%            \global\let\old@subsection\subsection                               % save the definition of \subsection before redefining it
%            \global\let\old@subsubsection\subsubsection                         % save the definition of \subsubsection before redefining it
%            \let\section\section@singular@appendix                              % redefine \section for use in singular Appendix
%            \let\subsection\subsection@singular@appendix                        % redefine \subsection for use in singular Appendix
%            \let\subsubsection\subsubsection@singular@appendix                  % redefine \subsubsection for use in singular Appendix
            \appendix@sectioning@renewals
            \addcontentsline{toc}{part}{\listXFontStyle\appendixToClabel}% set ToC label to Appendix
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
            \addtocontents{toc}{\protect\vspace{-\baselineskip}}                % reduce to \section sized skip
        }{
            \glet\old@chapter\@chapter                                          % save \@chapter JIC
            \glet\@chapter\@chapter@multiple@appendices
            \glet\thisAppendixHeading\appendicesHeading                         % set appendix page heading to APPENDICES/Appendices
            \addcontentsline{toc}{part}{%                                       % set ToC label to APPENDICES/Appendices
                \listXFontStyle\appendicesToClabel%
            }
        }
        \vspace*{\fill}
		\begingroup%
            \centering\XheadingFontStyle\thisAppendixHeading\\              % Place APPENDIX heading mid page using surrounding \fill vspacing
        \endgroup
        \vspace*{\fill}
		\clearpage
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%----------------------------------------------------- CHAPTER BACKMATTER ------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%--------------------------- Subappendix/Subappendices: content page(s) contruction [if applicable] ----------------------------% 
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---------------------- Subappendix settings & page(s) construction: environments, formatting, and pages -----------------------% 
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Subappendix wrapper control sequence
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\subappendix}[2]{%
%-------------------------------------------------------------------------------------------------------------------------------%
    \ifstrempty{#1}{
        \def\subappendixTitle{\currChapTitle:~\capitalisewords{Supplemental Information}}
    }{
        \def\subappendixTitle{\capitalisewords{#1}}
    }
    \begin{subappendices}%
        #2
    \end{subappendices}
    % Temp workaround for "subappendices" environment usage independent from \subappendix w/o issue
    %\gundef{\subappendixTitle}
    %\let\sectionname\old@sectionname
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Define local variant of \@redotocentry@pp that controls formatting of subappendix ToC list items
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED to provide formatting control of 'subappendices' environments distinct from 'appendices' controls
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\subappendix@redotocentry@pp}[1]{%
    \let\oldacl@pp=\addcontentsline
    \def\addcontentsline##1##2##3{%
        \def\@pptempa{##1}\def\@pptempb{toc}%
        \ifx\@pptempa\@pptempb                                                  % if( ##1 = toc )
            \def\@pptempa{##2}\def\@pptempb{#1}%
            \ifx\@pptempa\@pptempb                                              % if( ##2 = #1 )
                \oldacl@pp{##1}{##2}{%
                    \hskip\cftindent@nextLevel##3%                              % Adds manual \hskip to indent subappendix section ToC list item titles (w/ no preceding word or section number)
                }%                                                              % Prepends NOTHING to ToC entry for all Appendix
            \else
                \oldacl@pp{##1}{##2}{##3}%
            \fi
        \else
            \oldacl@pp{##1}{##2}{##3}%
        \fi
    }
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine 'subappendices' environment to use \subappendix@redotocentry@pp to define ToC list item formatting
%-------------------------------------------------------------------------------------------------------------------------------%
%   + Blake, 2023: ADDED explicit redefinition of 'subappendices' environment
%-------------------------------------------------------------------------------------------------------------------------------%
\renewenvironment{subappendices}{%
    \@resets@ppsub
    \if@chapter@pp
        \if@dotitletoc@pp \subappendix@redotocentry@pp{section} \fi             % Uses locally defined \subappendix@redotocentry@pp instead of (DEFAULT) \@redotocentry@pp to control ToC list item formatting
        \if@dotitle@pp
            \def\sectionname{\appendixname}
            \def\@seccntformat##1{%
                \@ifundefined{##1name}{}{\csname ##1name\endcsname\ }%
                \csname the##1\endcsname\quad%
            }
        \fi
    \else
        \if@dotitletoc@pp \subappendix@redotocentry@pp{subsection} \fi          % Uses locally defined \subappendix@redotocentry@pp instead of (DEFAULT) \@redotocentry@pp to control ToC list item formatting
        \if@dotitle@pp
            \def\subsectionname{\appendixname}
            \def\@seccntformat##1{%
                \@ifundefined{##1name}{}{\csname ##1name\endcsname\ }%
                \csname the##1\endcsname\quad%
            }
        \fi
    \fi%
}{}
%-------------------------------------------------------------------------------------------------------------------------------%
% Prepending/appending control sequence(s) patching of 'subappendix' environment
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: With the addition of redefinition of 'subappendices' environment, these environment patching commands
%     COULD be removed in favor of inserting their contents directly in the redefinition. Doing so, however, would make the
%     redefinition significantly longer & more complicated whereas the current patching if far easier to visualize
%-------------------------------------------------------------------------------------------------------------------------------%
\BeforeBeginEnvironment{subappendices}{%
    \setcounter{savedsection}{\value{section}}
    \setcounter{section}{0}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\AtBeginEnvironment{subappendices}{%
    \renewcommand{\thechapter}{\arabic{chapter}}
    \renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
    \renewcommand{\thesubsection}{\arabic{chapter}.\Alph{section}.\arabic{subsection}}
	\renewcommand{\thesubsubsection}{\arabic{chapter}.\Alph{section}.\arabic{subsection}.\Roman{subsubsection}}
	{
		\centering
		\vspace*{0.41in}
		{\appendixname}
        \hspace{-0.25em}                                                        % for the chapter text to look pretty.
		\ARABICNumName{\thechapter}
	}
    \@afterheading
    {
    	\centering\normalfont
		\vspace{-1ex}
		\@ifundefined{subappendixTitle}{
            \currChapTitle\singlespacing{\currChapTitle:~\capitalisewords{Supplemental Information}}\\
        }{
            \singlespacing{\subappendixTitle}\\
		}
        \vspace{0.13in}
	}
    \addcontentsline{toc}{section}{\appendicesToClabel}
    %\addcontentsline{toc}{section}{\appendicesHeading~\ARABICNumName{\thechapter}\numberline{\nowtitle:~\capitalisewords{Supplemental Information}}}
    \counterwithin{figure}{section}
    \counterwithin{table}{section}
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%--------------------------------------------------------- BACKMATTER ----------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%-------------------------------------- Glossary/Index page(s) construction & formatting ---------------------------------------% 
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Specialized list constructed for inclusion of lists in Backmatter page(s), e.g. glossary, list of symbols, or notation list
%-------------------------------------------------------------------------------------------------------------------------------%
\newlist{backmatterList}{itemize}{1}                                            % Generates more closely spaced lists for notation/glossary lists
\setlist[backmatterList]{label=\textbullet, itemsep=-6pt}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- BACKMATTER ----------------------------------------------------------%  
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------- Bibliography page(s) heading, ToC label, & list item formatting a& controls -------------------------% 
%===============================================================================================================================%
%*******************************************************************************************************************************%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------- Bibliography page construction (heading at 1.5") ---------------------------------------%   
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefinition of \thebibliography w/ appropriate header spacing, non-page-breaking citations, & text/list formatting
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2021: Prevent page breaks mid-citation. There are other ways to do this, e.g. modify .bst file, bib environment, etc. 
%     This is easiest & works for citations of any # of lines, which Grad School requested in format review.
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@delayed@thebib@def{
%-------------------------------------------------------------------------------------------------------------------------------%
    \def\thebibliography##1{
		\clearpage
		\addcontentsline{toc}{chapter}{\bibname}
        \vspace*{0.41in}                                                        % Blake, 2023: Adjusted from 0.42in to 0.41in to better generate heading at 1.5"
		\centering\XheadingFontStyle\bibname
		\vspace{2ex}
        \intactCitations                                                        % prevents page breaks mid-citation
        %\singlespacing
		\list{[\arabic{enumi}]}
		{
	 		\singlespacing
            \settowidth\labelwidth{[##1]}\leftmargin\labelwidth
	 		\advance\leftmargin\labelsep
	 		\advance\leftmargin\bibindent
			\itemindent -\bibindent
			\listparindent \itemindent
			\usecounter{enumi}
		}
		\def\newblock{\hskip .11em plus .33em minus -.07em}
		\sloppy
	 	\sfcode`\.=1000\relax
	}
%-------------------------------------------------------------------------------------------------------------------------------%
}
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%-------------------------------------------------------- MAIN DOCUMENT --------------------------------------------------------% 
%-------------------------------------------------------------------------------------------------------------------------------%
%--------------------------------------- Final document body preparations & construction ---------------------------------------% 
%===============================================================================================================================%
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
% Expand the delayed definition(s) control sequences so the definitions they contain are expanded and take effect \AtBeginDocument
%-------------------------------------------------------------------------------------------------------------------------------%
\AtBeginDocument{
    \@delayed@Xmark@defs                                                        % Expand delayed redefinitions of \Xmark
    \@delayed@thebib@def                                                        % Expand delayed redefinition of \thebibliography
    \@delayed@setlengths
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Intercept and prepend Page & formatting macros to the main document
%-------------------------------------------------------------------------------------------------------------------------------%
\let\interceptedDocument\document
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\document}{
	\interceptedDocument
	\onecolumn
	\raggedbottom
	
	% Front matter
	\if@makeShortThesis
		\thesisAbstractpage
	\else
		\thesisPrologue
	\fi
	
	% Main document body follows
    \doublespacing
	\pagenumbering{arabic}
}
%===============================================================================================================================%
%----------------------------------------------- Footnote construction & control -----------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Rysavy: footnotes must have the same indent as paragraph
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{manyfoot}
\RequirePackage[bottom]{footmisc}                                               % Blake added 2021: ensures bottom page footnotes in main body text
\SetFootnoteHook{\singlespace\hspace{\dimexpr 0.5in-3ex \relax}}                % the footnote indent should be 0.5in, which is \parindent
\DeclareNewFootnote{A}
\renewcommand{\footnote}[1]{\footnoteA{#1}}                                     % the footnotes need to start with 1 at the beginning of each chapter
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%----------------------- Additional packages that are useful and commonly used in Package/Class writing ------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Added packages that are commonly useful for writing Packages (.sty) & Classes (.cls).
% NOTES:
%   # package provided commands are only accessible AFTER the point in the file where \RequirePackage is inserted.
%   # packages often "conflict" or "clash" with one another; this can manifest as compile errors or, more often and, the inclusion of
%   conflicting packages can cause unexpected behavior from 1 or more macros. Packages used here have NOT been thoroughly tested
%   for potential conflicts. Hence, an approach to reduce the likelihood of consequential clashes is as follows:
%   + the further down in the file a package is loaded, the less likely it is to affect the behavior of the TeX code preceding it
%   + load ONLY the most vital packages toward the top of this file
%   + delay loading additional packages until the point in the file where its macros are used for the 1st time
%   + avoid moving the below packages up in the file; if a package macro is needed further up in the file, it is better to move
%   this TeX code to below where the package is loaded than to move the package inclusion upward. Before breaking with this
%   approach and moving a package deemed crucial higher in the file, check online for any known conflicts and thoroughly compare
%   the observed behavior before and after the move to detect any behavioral changes.
%   + packages that simply provide tools or provide a very narrow/specific set of macros are typically safer.
%   + packages that change the definitions of existing macros, particularly common macros like \chapter, are the least safe.
%   + packages that use/modify the same macros or expect the original macro definition will likely clash, which can lead to
%   immediately recognizable compilation errors, but often yield unexpected behavior that depends on the order in which the
%   conflicting packages were loaded. Such compilable clashes can be difficult to detect, hence the abundant caution here
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{indentfirst}                    % if you start a chapter without a section, you need this to have the paragraph indented
\RequirePackage{xparse}                         % Provides \<New,Renew,Provide,Declare><Document,ExpandableDocument><Command,Environment> w/ extensive parameter options
\RequirePackage{siunitx}                        % Provides SI unit symbols/commands
\RequirePackage{xfrac}                          % Provides \sfrac: solidus alternative to virgule \nicefrac & \tfrac
\RequirePackage{cancel}                         % Provides \cancel, \cancelto: cancel "slash" math terms or w/ arrow to value (e.g. 0 or inf)
\RequirePackage{calc}                           % Provides internal TeX calculation capabilities & commands
\RequirePackage{mathtools}                      % Provides many improvements/additions to 'amsmath'
%\RequirePackage{fixltx2e}
%\RequirePackage{dblfloatfix}
\RequirePackage{algpseudocode}                  % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithmicx}                   % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithm}                      % Adds titledauto numbered environment enclosing 'algorithmic' environment content
%\algsetup{linenodelimiter=)}
%\RequirePackage{enumitem}                       % Provides more options/control of enumerate environment numbering/lettering
\RequirePackage{scalerel}                       % relative scale/stretch delimiters
\RequirePackage{stackengine}                    % Add ability to stack text, math, symbols/glyphs, images, etc
%\RequirePackage{isodate}
\RequirePackage{datetime2}
\RequirePackage{mfirstuc}                       % Provides \capitalisewords to capitlize 1st letter of text, incl. modifiable list of words to ignore (e.g. of, or, etc.)
\RequirePackage[normalem]{ulem}                 % Provides text underlining/strikethrough commands and customizations
\RequirePackage{txfonts}
\RequirePackage{amsfonts}
\RequirePackage{bbm}                            % Blackboard bold font package (e.g. creating symbols for reals (R), integers (Z), etc.)
%\RequirePackage{bickham}                       % Script font style package
%\RequirePackage{pifont}                        % access to dingbat symbols
%\RequirePackage{pxfonts}                       % pxfont font package
%\RequirePackage{bibentry}
%    \nobibliography*                           % Read in .bbl file entries for in text \bibentry citations, but also create back matter Bibliography
%\RequirePackage[printwatermark]{xwatermark}    % Potential alternative package for watermarking pages
%\RequirePackage{draftwatermark}                % Provides watermarking commands \SetWatermarkX
%\SetWatermarkText{PREPRINT}                    % Set the watermark text to "PREPRINT"
%\SetWatermarkScale{0.65}                       % Sets the scale factor for the watermark text
%\SetWatermarkLightness{0.925}                  % Set the opacity of the watermark text
%\RequirePackage{cite}
\RequirePackage{comment}
\RequirePackage{pgf}                            % Implementation of "portable graphics format"=basic layer underlying "Tikz"
\RequirePackage{tikz}                           % Provides extensive set of graphics/drawing commands
\RequirePackage{printlen}                       % Provides length printing and unit control commands
%_______________________________________________________________________________________________________________________________%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%------------------------------------- Math Control Sequence & Symbol/Operator Definitions -------------------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
\global\let\biconditional\Leftrightarrow
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\superscript}[1]{\ensuremath{^{\textrm{#1}}}}
\newcommand{\subscript}[1]{\ensuremath{_{\textrm{#1}}}}
\newcommand*{\defeq}{\mathrel{\vcenter{\baselineskip0.5ex \lineskiplimit0pt
                     \hbox{\scriptsize.}\hbox{\scriptsize.}}}%
                     =}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\vect}[1]{\vbox{\m@th \ialign {##\crcr\vectfill\crcr\noalign{\kern-2.95\p@ \nointerlineskip}$#1$\crcr}}\kern-2.1pt}
\newcommand{\setdef}[2]{\left\{\,#1\setor #2\,\right\}}                         % Defines set { #1 | #2 }
\newcommand{\setpad}{\;}                                                        % Defines set definition open/close/mid padding space
\newcommand{\seqopen}{\left\lbrace}                                             % Defines sequence definition open (left) bracing
\newcommand{\seqclose}{\right\rbrace}                                           % Defines sequence definition close (right) bracing
\newcommand{\setopen}{\left\lbrace\setpad}                                      % Defines set definition open (left) bracing + padding
\newcommand{\setclose}{\right\rbrace\setpad}                                    % Defines set definition close (right) bracing + padding
\newcommand{\setwhere}{\setpad\middle\vert\setpad}                              % Defines set definition where/such that vert separator + padding
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\alignedbox}[3][white]{
    % #1 = color (optional, defaults to yellow)
    % #2 = before alignment
    % #3 = after alignment
    &
    \begingroup
    \settowidth\lsideWidth{$\displaystyle #2$}
    \addtolength\lsideWidth{\fboxsep+\fboxrule}
    \hspace{-\lsideWidth}
    \fcolorbox{black}{#1}{$\displaystyle #2 #3$}
    \endgroup
}
%-------------------------------------------------------------------------------------------------------------------------------%
\DeclareMathOperator{\degreesF}{\si{\degree} \mathsf{F}}                        % degrees Fahrenheit symbol
\DeclareMathOperator{\degrees}{\si{\degree}}                                    % degrees symbol
\DeclareMathOperator*{\diag}{diag}                                              % diagonal matrix label 'diag'
\DeclareMathOperator*{\rand}{rand}                                              % diagonal matrix label 'diag'
%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand\attrref{}
\newcommand{\fsection}[3]{\section{#1}\label{#2}\input{#3}}
\newcommand{\fsubsection}[3]{\subsection{#1}\label{#2}\input{#3}}
\newcommand{\fsubsubsection}[3]{\subsubsection{#1}\label{#2}\input{#3}}
\newcommand{\subsubsubsection}[1]{\par\noindent\newline\textbf{#1}\hspace*{\fill}\\}
%*******************************************************************************************************************************%
%===============================================================================================================================%
%------------------------ Helper commands simplifying the writing of macro/counter values to .aux file -------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Info written to aux file can be read back on next compile, making info from later in the document available at the beginning
%     of the document after the next compile. e.g. count of appendix chapters to control whether there is an Appendix or Appendices
%===============================================================================================================================%
\DeclareDocumentCommand\auxwrite@macro{O{xdef} m m}
{
        \protected@write\@auxout{}%
        {%
                \xp\xp\xp\string%
                \xp\csname\xp#1\xp\endcsname%\newcommand%
                \xp\string%
                \xp#2%
                \xp{#3}%
        }%
}
%-------------------------------------------------------------------------------------------------------------------------------%
\DeclareDocumentCommand\auxwrite@regset{O{setcounter} m m}
%\newcommand\auxwrite@regset[3][setcounter]%
{%
        \protected@write\@auxout{}%
        {%
                \xp\xp\xp\string%
                \xp\csname #1\endcsname%
                \xp{\xp\string#2}%
                \xp{#3}%
        }%
}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%*******************************************************************************************************************************%
%******************************************************* END: thesis.cls *******************************************************%
%*******************************************************************************************************************************%
%===============================================================================================================================%
\endinput                                                                       % ENSURES following code is not included in .cls expansion
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%********************************************************* DEPRECATED **********************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%===============================================================================================================================%
% Handy table spacing macros: \abovespace, \belowspace
% Alvin's Note: Obsolete. Do not use
\def\abovestrut#1{}
\def\belowstrut#1{}
\def\abovespace{}
\def\aroundspace{}
\def\belowspace{}
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%***************************************************** UNDER CONSTRUCTION ******************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%************************************************** BEGIN UNDER CONSTRUCTION ***************************************************%
% Blake, 2021: In progress with title page.
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisSignature}[2]
{%  USAGE: \thesisSignature{<text>}{<vrule width>}
    normalsize
   %\vspace{0.05in}
   %\\
   \vrule width #2 height 0.1mm\\[0.1mm-2ex]
   %[-0.5\baselineskip]
   %\vspace{0.5em}
   #1
}
%_______________________________________________________________________________________________________________________________%
%*************************************************** END UNDER CONSTRUCTION ****************************************************%
%_______________________________________________________________________________________________________________________________%
%************************************************** BEGIN UNDER CONSTRUCTION ***************************************************%
% Blake 2021, in progress: correcting margins and positioning/spacing of lines.
% # Attempting to match Grad School provided "4 Line Signature Page", though it extends into the 1" top and bottom margins and
%   has inconsistent spacing.
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisTitlePage}
{
    \if@insertSignaturePage%
        %\include{\signaturePageAddr}
        %\include{./Forms/SignaturesPage.pdf}
        \includepdf{\signaturePageAddr}
    \else
    	\thispagestyle{thesisTitlePageStyle}
    	\doublespacing	
        {
            \vspace*{0.5ex -\baselineskip}
            \centering
        %\begin{center}
    	%\vspace*{0.1in}
    		\thesisTitle \\[0.5\baselineskip-1.5ex]
    		by \\[0.5\baselineskip-1.5ex-0.3mm]
    		%by \\[0.5\baselineskip-0.5em - 0.2mm]
    		\thesisAuthorName, \thesisHolding \\[-1.5ex - 0.2mm + 0.5\baselineskip]
    		A Dissertation \\[-1.em + 0.3mm + 0.5\baselineskip]
    		Approved by the \thesisDepartment\\[-0.5em +0.2mm + 0.5\baselineskip]
    		\thesisSignature{\thesisDepartmentChair, Chairperson}{4.0in}\\[0.5\baselineskip - 0.2mm]
    	%\vspace{0.1in}
        	\singlespacing
            	Submitted to the Graduate Faculty of\\
        	Baylor University in Partial Fulfillment of the \\
        	Requirements for the Degree \\
        	of \\[-0.5ex + 0.2mm + 0.5\baselineskip]
        	\thesisDegree\\[\baselineskip]
        }
    	\vspace{2\baselineskip}
    	%\vfill
    	\doublespacing
    	%\hspace{0.25in}
    	%\setlength\leftskip{0.5in}
        {   %
            	\centering
                %\addtolength{\leftskip}{-2.5in}
                Approved by the Dissertation Committee\\
         		\thesisSignature{\thesisMentor, Chairperson}{80mm}\\
         		\thesisSignature{\thesisReaderOne}{80mm}\\
         		\thesisSignature{\thesisReaderTwo}{80mm}\\
    		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm}\\ \fi
    		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm}\\ \fi
    		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm}\\ \fi
    		%\\
    	}
    	
    	\vspace{0.25in}
    	\vfill	
    	%\addtolength{\leftskip}{-1.0in}
        %\setlength\leftskip{-1.25in}
        {
    		%\centering
    		\begin{flushleft}
                \centering
                Accepted by the Graduate School \\
        		\vspace{-0.075in}
        		\thesisConfDate
        		\thesisSignature{\thesisDean, Dean}{80mm} \\
            \end{flushleft}
    	}	
    	%\end{center}
    \fi
    \clearpage
}
%_______________________________________________________________________________________________________________________________%
%*************************************************** END UNDER CONSTRUCTION ****************************************************%
%_______________________________________________________________________________________________________________________________%
%************************************************** BEGIN UNDER CONSTRUCTION ***************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
% Define a single control sequence that automatically constructs & inserts a new 'attribution' \item w/ its corresponding
% 'attribution' and 'authorList' environments
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\addAttribution[3][]{
    \begin{attributionList}
    \item\begin{attribution}
    %Schultze, B. E., M. Witt, Y. Censor, K. E. Schubert, and R. W. Schulte (2015). Performance of hull-detection algorithms for proton computed tomography reconstruction. In S. Reich and A. Zaslavski (Eds.), \textit{Infinite Products of Operators and Their Applications}, Volume 636 of \textit{Contemporary Mathematics}, pp. 211–224. American Mathematical Society.
     B. E. Schultze, M. Witt, Y. Censor, K. E. Schubert, and R. W. Schulte, “Performance of hull-detection algorithms for proton computed tomography reconstruction,” in \textit{Infinite Products of Operators and Their Applications}, ser. Contemporary Mathematics, S. Reich and A. Zaslavski, Eds., vol. 636. American Mathematical Society, 2015, pp. 211–224.
    \end{attribution}%
    \ifx#1\@empty\else\label{#1}\fi%

}
%_______________________________________________________________________________________________________________________________%
%*************************************************** END UNDER CONSTRUCTION ****************************************************%
%_______________________________________________________________________________________________________________________________%
%************************************************** BEGIN UNDER CONSTRUCTION ***************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
\def\footnoterule{\vspace*{0.1em}\kern-3\p@
  \hrule \@width 2in \kern 2.6\p@} % the \hrule is .4pt high
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width \textwidth height 1pt
  \kern 2pt
}
%_______________________________________________________________________________________________________________________________%
%*************************************************** END UNDER CONSTRUCTION ****************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%********************************************** ALTERNATIVE IMPLEMENTATIONS & DEV **********************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%===============================================================================================================================%
% ALTERNATIVE IMPLEMENTATION: Add prefix label before LoZ item refnums directly through 'tocloft' package instead of current
%       implementation extending 'caption' package functionality
%_______________________________________________________________________________________________________________________________%
%********************************************** ALTERNATIVE:={status=INCOMPLETE) ***********************************************%
%_______________________________________________________________________________________________________________________________%
%*************************************************** status<INCOMPLETE:list> ***************************************************%
%*INCOMPLETE:list.MISSING_FEATURES:
%   (1) LoZ numbering/title separation options={Aligned,Constsep} & corresponding \set__Aligned & \set__Constsep controls
%   (2) LoZ item spacing adjustments when N>=10 -> N=[nn] in refnum C.N -> C.nn is wider by 1 digit n
%_______________________________________________________________________________________________________________________________%
%===============================================================================================================================%
%---- Redefine format of \caption[]{} items written to \listofYs ONLY for specific float environments Y={figure, table,...} ----%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Naming: (X:Y:Z)={fig:figure:F,tab:table:T)<=>(\_X_:\listofYs:LoZ)={\_fig_:\listoffigures:LoF,\_tab_:\listoftables:LoT,...}
%   # NOTE: \_X_ is often \cft_X_ either from 'tocloft' directly OR defined/derived in <this>.cls for use w/ 'tocloft' behaviors
%-------------------------------------------------------------------------------------------------------------------------------%
% LoZ item title = <title> IF USING \caption{<title>} OR title = <short title> IF USING \caption[<short title>]{<title>}
%-------------------------------------------------------------------------------------------------------------------------------%
%   # Blake, 2023: This is an ALTERNATIVE approach for adding "Figure "/"Table " before LoZ item refnums \theY in the \listofYs
%     for Y={figure, table} exclusively using 'tocloft' package functionalities. This could be extended to other floats,
%     partiularly e.g. Y={subfigure,subtable} w/ existing 'tocloft' functionality; other float environments would be less trivial.
%       + ADDED "Figure " & "Table " before Y={figure,table} refnums \theY in the LoF/LoT by redefining \cftXpresnum {}->{\Yname\space}
%       + DEFINED new length \len@cftXpresnum & set it to width of the content \cftXfont\cftXpresnum that was added before 'snum'
%       + ADDED original width of 'snum' box \cftXnumwidth to \len@cftXpresnum, yielding total width of \cftXpresnum\numberline{\theX}
%       + SET \cftsetindents{Y}{0in}{\len@cftXpresnum - 1em}, where [optional] 1em reduces distance between LoZ item 'snum' & title
%       + SET LoZ item indents & numberline widths using \cftsetindents{Y}{<indent>=0.0in}{<width>=\len@cftXpresnum - 1em}
%         where [optional] 1em reduces distance between LoZ item 'snum' & title to ~1 \space
%===============================================================================================================================%
%_______________________________________________________________________________________________________________________________%
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine \cftfigpresnum to desired prefix label before LoF item refnums C.N & define/init LoF item spacing/indentation parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftfigpresnum{\figurename\space}                                 % ADD "Figure " before figure #s in LoF entries
\newlength\len@cftfigpresnum                                                    % Width of content preceding 'snum', i.e. \cftfigpresnum
\settowidth\len@cftfigpresnum{\cftfigfont\cftfigpresnum}                        % SET to the width of \cftfigpresnum
\addtolength\len@cftfigpresnum{\cftfignumwidth}                                 % ADD width of figure number box, yielding total width = \p@figure + \cftfignumwidth
%-------------------------------------------------------------------------------------------------------------------------------%
% Redefine \cfttabpresnum to desired prefix label before LoT item refnums C.N & define/init LoT item spacing/indentation parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cfttabpresnum{\tablename\space}                                  % ADD "Table " before table #s in LoT entries
\newlength\len@cfttabpresnum                                                    % Width of content preceding 'snum', i.e. \cfttabpresnum
\settowidth\len@cfttabpresnum{\cfttabfont\cfttabpresnum}                        % SET to the width of \cfttabpresnum
\addtolength\len@cfttabpresnum{\cfttabnumwidth}                                 % ADD width of table number box, yielding total width = \p@table + \cfttabnumwidth
%-------------------------------------------------------------------------------------------------------------------------------%
% Set Indents for figure/table when using \cft<fig,tab>presnum to add "Figure " and "Table " before number line box width
%-------------------------------------------------------------------------------------------------------------------------------%
\cftsetindents{figure}{0in}{\len@cftfigpresnum - 2em}                           % Increase the width of the figure number line box to contain "Figure X.XX", but reduce the gap before subsequent title by 1em to ~1 space DEFAULT:{1.5em}{2.3em}
\cftsetindents{table}{0in}{\len@cfttabpresnum - 2em}                            % Increase the width of the table number line box to contain "Table X.XX", but reduce the gap before subsequent title by 1em to ~1 space DEFAULT:{1.5em}{2.3em}
%-------------------------------------------------------------------------------------------------------------------------------%
%\cftsetindents{figure}{0in}{\len@cftfigpresnum+0.25in}                          % Simplest way to adjust for the addition of the word "Figure " to LoF entries
%%\cftsetindents{figure}{-\len@cftfigpresnum+0.5in}{\len@cftfigpresnum+0.25in}   % More complicated but more logical and also works to adjust for the added word "Figure "
%\cftsetindents{table}{0in}{\len@cfttabpresnum+0.25in}                           % Simplest way to adjust for the addition of the word "Table " to LoT entries
%%\cftsetindents{table}{-\len@cfttabpresnum+0.5in}{\len@cfttabpresnum+0.25in}    % More complicated but more logical and also works to adjust for the added word "Table "
%_______________________________________________________________________________________________________________________________%
%****************************************************** END: ALTERNATIVE *******************************************************%
