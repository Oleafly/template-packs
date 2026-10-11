\LoadClass[12pt]{report}% The underlying class is the document class "report".
\usepackage{setspace} % Always before hyperref -- Enable correct footnote link

\usepackage[colorlinks=true]{hyperref}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%     Edits to the base class before loading any packages     %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We need to redefine the \@chapter to kill off the weird injected gaps between
%   and tables in their respective Lists. It's easier to do it this way than to
%   try and retroactively fix it later. 
 
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
%                    \addtocontents{lof}{\protect\addvspace{10\p@}}% <-- Gap in LoF
%                    \addtocontents{lot}{\protect\addvspace{10\p@}}% <-- Gap in LoT
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}


                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%    Support Packages and Commands    %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Generic useful configuration packages, used to configure most of the stuff below.
\RequirePackage{hyperref}% Use this to provide intra-pdf hyperlinking and better toc
\hypersetup{
    colorlinks   = true,    %           Colours links instead of ugly boxes
    urlcolor     = blue,    %           Colour for external hyperlinks
    linkcolor    = blue,    %           Colour of internal links
    citecolor    = blue     %           Colour of citations, could be ``red''
    }

\RequirePackage{etoolbox}
\RequirePackage{tabularx}
\RequirePackage{xcolor}
\RequirePackage{amsthm,amssymb,amsmath}
\RequirePackage[
    format=hang,
    labelsep=period,
    justification=raggedright,
    font=singlespacing,
    singlelinecheck=false]
    {caption}
    \captionsetup[table]{skip=0pt, labelsep= none, name=}
    \captionsetup[figure]{skip=12pt, labelsep= none, name=}
%\RequirePackage{tocloft}%  


% Load the algorithm environment, which we hijack into the "Objects" environment.
% The "plain" option is to remove the special algorithm formatting in the text.
\RequirePackage[plain]{algorithm}
%\RequirePackage[chapter]{algorithm}

% Use this for the actual header styling
% The "largestsep" option forces the gap between chapter and text to be the same as
% the gap between the chapter and section when they occur consecutively.
\RequirePackage[largestsep]{titlesec}

% Use this to manipulate Table of Contents styling
\RequirePackage{titletoc}
\RequirePackage{float}

\RequirePackage[numbers]{natbib}
%\RequirePackage{natbib}


% Check to see if a macro is defined, for the use of detecting 
% which files have been supplied by the user.
\providecommand{\ifExists}[3]{

     \ifcsname#1\endcsname%
     % If it is defined, do this.
         #2
     \else
     %  Otherwise, do this.
         #3
     \fi
     }
    
%  They claim they want single-space, but what they actually want is 
% "as little white space between letters as is visually acceptable".
\providecommand{\realSingleSpace}{\setstretch{1}}

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% New "if" settings %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifdocBody%       This is to decide if we want to display the "chapter #" in the text or not.
    \docBodyfalse%      Initially we don't want "chapter #" displayed until user-content.

\newif\iftitleCapOff%   An option to override the auto-capitalization of title, for the rare time 
%                           when you need to have non-capital letters in the title.
    \titleCapOfffalse%  By default titles are capitalized.

\newif\ifchapterCapOff% An option to override the auto-capitalization of chapters, for the rare time 
%                           when you need to have non-capital letters in your chapters.
    \chapterCapOfffalse% By default chapters are capitalized.

\newif\ifeditMode%      editMode is an option to display extra info/warnings for editing the dissertation.
%                           Also enabled the \authorRemark and \editorRemark commands.
    \editModefalse%         Default to non-edit mode. Use the package option "editMode" to turn it on.
    
%Legacy ``if" command to allow for demonstration of class features.
\newif\ifdemo
    \demofalse
    
    
%  Because of how LaTeX generates and saves counts for ToC
%  We need the author to tell us if there are multiple appendices so we can format correctly.
\newif\ifmultipleAppendix

% We assume there will be only one appendix by default.
\multipleAppendixfalse

%%%%%%%
%%% Decide if we need to include a list of tables and/or a list of figures. Right now we'll do so with a manually set boolean. Would be a good idea to, instead, do some kind of check on the table/figure number and display if that value is bigger than 0.
%%%%%%%

\newif\ifhaveTables
    \haveTablesfalse
    %   By default we assume there are no Tables.
    
\newif\ifhaveFigures
    \haveFiguresfalse 
    %  By default we assume there are no Figures.
    
\newif\ifhaveObjects
    \haveObjectsfalse%  By default we assume there are no Objects.


%%%%%%%%%%%%%%%%
%%% Margins: %%%
%%%%%%%%%%%%%%%%
%%%  They want 1 inch all around margins, which we do with the geometry package.

\RequirePackage[
    margin=1.0in,%            All 4 margins need to be one inch.
    paperheight=11in,%      We want 11in tall paper.
    paperwidth=8.5in%       And 8.5in wide paper.
    ]{geometry}%            Geometry package is the easiest way to deal with margins.

%% End Margin Config.

%%%%%%%%%%%%%%%%%%%%%
%%% Font Options: %%%
%%%%%%%%%%%%%%%%%%%%%
%%% They want Times New Roman, or Arial. 
%%% Times New Roman is loaded by default, uncomment the \renewcommand below to switch it to Arial.

\RequirePackage{newtxtext,newtxmath}%  This is required to load and convert to times new roman
\RequirePackage{helvet}%    This is required to load Arial Font
%\renewcommand{\familydefault}{\sfdefault}% Converts default to actual Arial

\raggedright%               They want a ragged right edge.
%% End Font Setting

%%%%%%%%%%%%%%%%%%%%%%
%%% Page Numbering %%%
%%%%%%%%%%%%%%%%%%%%%%
%%%  They want the page number in arabic numerals in the bottom middle of each page.

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand\headrulewidth{0pt}
\lhead{}\chead{}\rhead{}

\cfoot{\thepage}
\setlength{\footskip}{0.5in}%   They want the page number to be half an inch from the bottom. 
%                               This measurement is actually the distance to the text block; 
%                               So 1in margin - 0.5inch from botton = 0.5in footskip value.
%% End page numbering settings

%%%%%%%%%%%%%%%%%%%%
%%% Font Spacing %%%
%%%%%%%%%%%%%%%%%%%%
% This will allow us to set spacing in general.
% The optional argument "nodisplayskipstretch" turns off doublespacing 


%  for math display mode environments.Make everything double spaced by default.
\doublespacing%                                     
\AtBeginEnvironment{longtable}{\realSingleSpace}{}% 
%Pre-append using longtables to make sure that tables are single spaced.
\preto\itemize{\par\realSingleSpace}%
%Pre-append singlespace to itemize to account for single space bullet point lists.
\RequirePackage{indentfirst}% 
%This will make sure the first paragraph of every chapter is indented.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%    Formating Design    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%
%%% Caption Configuration TBD
% NOTE: Make sure long captions don't overlap numbers in ToC :: Done.

\newcounter{figCount}%      This is an internal counter to track how many figures
\setcounter{figCount}{1}%   We will start at 1 due to how stepping it works.

\newcommand{\addFigure}[3][\Alph{figCount}]{%   Command to manually add a figure
    \parbox{#2\textwidth}{\centering #1 \\ \includegraphics[width=#2\textwidth]{#3}}
    \stepcounter{figCount}
    }

\newenvironment{multiFigure}% Environment that mimicks figure type environment,
%                               Except it doesn't float around and it resets figCount.
    {% Begin Environment Code
        \setcounter{figCount}{1}
        \minipage\textwidth
    }
    {% End Environment Co
        \endminipage
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Theorem environment definitions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newtheorem{theorem}{Theorem}[chapter]
    \renewcommand{\thetheorem}{\thechapter-\arabic{theorem}}
\newtheorem{claim}{Claim}[chapter]
    \renewcommand{\theclaim}{\thechapter-\arabic{claim}}
\newtheorem{lemma}{Lemma}[chapter]
    \renewcommand{\thelemma}{\thechapter-\arabic{lemma}}


%%%%%%%%%%%%%%%%%%%%%%%%
%%% Table Formatting %%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%% They want tables configured a certain way that makes the package "longtables" a more desirable option.
%   More specifically, from their website on text-flow:
%        Text must be continuous throughout the chapter. 
%        It is best to place all tables and figures at the end of the appropriate chapter. 
%        Avoid inserting them into the text of the chapter, unless you are able to do so 
%        without leaving blank gaps at the bottom of text pages.
%%%%%%%

\RequirePackage{longtable}

% This package stops tables from floating backward up the text. 
% This stops weirdness like tables appearing before the section they are in within the source.
\RequirePackage{flafter}

%%% Tables need to have their captions "sit" on the table, but figures shouldn't.

\RequirePackage{threeparttable}

%% End table configure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Title Page Formating %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Maketitle needs to be redefined to make the titlepage look how they want. 
%       Actual parameters for the title page would be nice.
%%%%%%%


%   Use this command to force uppercase titles, 
%   but provide an option to over ride this; using overrideTitles.
\providecommand{\@docTitle}{\MakeUppercase{\@title}}
\renewcommand{\maketitle}{%
    \begin{center}
        \thispagestyle{empty}%
        \vspace*{-0.4in}\realSingleSpace{\@docTitle}%
        \vfill%
        By \\*[\baselineskip]%
        \MakeUppercase{\@author}%
        \vfill%
        A \MakeUppercase{\@ThesisType} PRESENTED TO THE GRADUATE SCHOOL \\%
        OF THE UNIVERSITY OF FLORIDA IN PARTIAL FULFILLMENT \\%
        OF THE REQUIREMENTS FOR THE DEGREE OF \\%
        \MakeUppercase{\@DegreeType} \\*[\baselineskip]%
        UNIVERSITY OF FLORIDA \\*[\baselineskip]%
        \@DegreeYear%
    \end{center}
    \newpage
    }

%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header Formatting %%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%  Some headers by default have a huge margin between the top of the chapter text and the top margin, 
%       which the grad school doesn't like. So we use the titlesec package and the \titleformat command to 
%       directly access all aspects of chapters and parts to fix spacing, formating, and style.
\titlelabel{\thetitle . \quad}

%% Define chapter's style based on if we want chapters to auto-upper-case or not.

\titleformat{\chapter}[hang]
    {\uppercase}
    {}
    {0pt}
    {\centering\realSingleSpace\ifdocBody CHAPTER \thechapter\ \fi}
    [\raggedright\doublespacing]
    % Look into a gap between Chapter name and text (only when it's immediately text, gap between chapter name and section header is fine. See default chapter one for example. :: Fixed via the 'largestsep' package option for titlesec.
\titleformat{\part}[hang]
    {}
    {}
    {.0pt}
    {\centering\realSingleSpace\MakeUppercase}
    {\raggedright\doublespacing}


\titlespacing{\part}{0pt}{-.7in}{0.5\baselineskip}

\titlespacing{\chapter}{0pt}{-.3in}{0\baselineskip}

%%% Setup the formating for the actual section, subsection, and subsubsections in the text. We use the titlesec package here as it allows us to directly access the formating without having to renew the command and deal with all the code happening in the background for things like "table of contents" and pagebreaking.

\setcounter{secnumdepth}{5}
\titleformat{\section}%
    %  We want \section to be bold (\bfseries), centered (\center), and single spaced (\realSingleSpace)
    {%
        \bfseries\center\realSingleSpace
    }
    % The section number is held in \thesection
    {\thesection
    }%
    %The space between section number and text is the standard 1em
    {1em}
    {}%

\titleformat{\subsection}%
    {\bfseries\raggedright\realSingleSpace}%
    {\thesubsection}%
    {1em}{}%
    
 % We want \subsubsection to be bold (\bfseries),
 % left-justified (\filright), and single spaced (\realSingleSpace)  
\titleformat{\subsubsection}
    {\bfseries\filright\realSingleSpace 
    }
    %  The section number is held in \thesubsubsection    
    {\thesubsubsection%
    }
    %The space between section number and text is the standard 1em
    {1em}%
    {}

\titlespacing{\section}{0pt}{10pt}{0pt}
\titlespacing{\subsection}{0pt}{10pt}{0pt}
\titlespacing{\subsubsection}{0pt}{10pt}{0pt}
%% End of Header formatting



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Table of Contents, List of Figures, and List of Tables fixes: They wanted hyperlinked dotted lines between the chapter name and the page number. They also want all uppercase "TABLE OF CONTENTS".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setcounter{tocdepth}{4}
%% Fix the formatting of the various numbers.
%Change the dot to a hyphen for list of figures.
\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}

% Change the equation to chapter - equation#
\renewcommand*{\theequation}{\thechapter-\arabic{equation}}

% Change the dot to a hyphen for list of tables.
\renewcommand*{\thetable}{\thechapter-\arabic{table}}
\renewcommand*{\thealgorithm}{\thechapter-\arabic{algorithm}}

\usepackage{caption}
\captionsetup[figure]{name=Figure,labelsep=period}
\captionsetup[table]{name=Table,labelsep=period}

%%% Fix the titles of the "List Of ...", complete with adding the page/title at the top where applicable.
\renewcommand*\listfigurename{LIST OF FIGURES
    
    \hspace*{0pt}\hfill \underline{\smash{page}}
    
    \vspace*{-0.3\baselineskip}
    }%

\renewcommand*\listtablename{LIST OF TABLES
    
    \hspace*{0pt}\hfill \underline{\smash{page}}
    
    \vspace*{-.3\baselineskip}
    }%

\renewcommand{\contentsname}{TABLE OF CONTENTS
    
    \hspace*{0pt}\hfill \underline{\smash{page}}
    
    \vspace*{-.3\baselineskip}
    }%
    
%The Editors want the word "Table" and Figure to appear in the List of Tables/Figures followed by a period, so we do that here and adjust space accordingly
\titlecontents{figure}[0pt]
  {} % above code
  {\hyper@linkstart{link}{\Hy@tocdestname}%
   \hbox{Figure~\thecontentslabel.}% tight box for word + number + period
  \hyper@linkend\ } 
  {} 
  {\hyper@linkstart{link}{\Hy@tocdestname}\titlerule*[5pt]{.}\thecontentspage\hyper@linkend\\*\addvspace{8pt}}

% Tables
\titlecontents{table}[0pt]
  {}
  {\hyper@linkstart{link}{\Hy@tocdestname}%
   \hbox{Table~\thecontentslabel.}%
  \hyper@linkend\ } 
  {}
  {\hyper@linkstart{link}{\Hy@tocdestname}\titlerule*[5pt]{.}\thecontentspage\hyper@linkend\\*\addvspace{8pt}}

    
%%%%%%%%%%%%%%%%%%%%%%%%
% An attempt to do everything with titlesec and titletoc packages instead of using toclof package, to avoid package clashes.
%%%%%%%%%%%%%%%%%%%%%%%

\contentsmargin[20pt]{0pt}
% This is the right-margin for the table of contents, list of figures, list of tables, and list of objects.
% The optional argument is the correction; the amount you shift multiline entries so that
% they don't overlap the page number section.
% The required argument is the offset from the normal right margin.

%%%%%%%
%%Below is the formatting for all the Table of Contents hyperlinks, dotted lines, and horizontal alignment.

\titlecontents{part}[0em]
    {\mdseries}
    {\hyper@linkstart{link}{\Hy@tocdestname}{\contentslabel{2.3em}}\hyper@linkend}
    {}
    {}

\titlecontents{chapter}[0em]
    {}
    {\contentslabel{2em}}
    {}
    {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*\addvspace{8pt}}

\titlecontents{section}[4.1em]
    {}
    {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{2em}{\contentslabel{2em}}\hyper@linkend}
    {}
    {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}

\titlecontents{subsection}[6.4em]
    {}
    {\hspace*{-2.5em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{2.5em}{\contentslabel{2.8em}}\hyper@linkend}
    {}
    {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}

\titlecontents{subsubsection}[6.7em]
    {}
    {\hspace*{-3em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{3.8em}{\contentslabel{3em}}\hyper@linkend}
    {}
    {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}


%%%%%% Next is the creation of the List of Objects code.  %%%%%% 
%   Note: By default LaTeX only supports table of contents, List of tables and List of figures. The primary package to use to create a custom list is the tocloft package; but that has been depreciated and thus creates all kinds of cascading formatting problems with the other packages we use here. 

%   However, we can hijack another well maintained package that generates (among other things) a custom "List of ...". Specifically, we hijack the "algorithms" package, which gives a "list of algorithms" and an "algorithm" environment that takes captions and, in general, does everything we want. We will hijack this, then retool it to format it how we want, and finally reskin the words a little bit to make it say "object" instead of "algorithm" where needed, in the output. Since this could be a bit confusing for the author (using an 'algorithm' environment to insert an object') we conclude by defining an "addObject" command that will allow the author to add an object via the sensible "addObject" command, and that command will do all the weird formating and call all the weird environments/factors/etc to make it work, all behind the scenes.

%   Currently I don't have a good enough idea of what the formating or nature of "Objects" are, in order to actually write the "addObjects" command fully, but I have the shell defined and correct until I get additional parameters.


%%% Hijack "list of algorithms" from the already-in-use caption package, but reskin it to be a "list of objects" instead.

%%%%%%  Now setup everything to be formatted correctly as 'algorithms'.%%%%%% 

\contentsuse{algorithm}{loa}
%   Switches the definitions of things like \contentslabel to algorithms for the
%   titlecontents command that comes next.

\titlecontents{algorithm}[0pt]
  {}
  {\hyper@linkstart{link}{\Hy@tocdestname}%
   \hbox{Object~\thecontentslabel.}%
  \hyper@linkend\ } % small space after period
  {}
  {\hyper@linkstart{link}{\Hy@tocdestname}\titlerule*[5pt]{.}\thecontentspage\hyper@linkend\\*\addvspace{8pt}}

  
% Now we copy the existing "list of tables" command and patch it to work as a "list of Objects" command.
\let\listofObjects\listoftables   %  Copy command
\patchcmd{\listofObjects}{\listtablename}{\listalgorithmname}{}{} %Patch the three instances of \listtablename
\patchcmd{\listofObjects}{\listtablename}{\listalgorithmname}{}{}% to all be converted to the
\patchcmd{\listofObjects}{\listtablename}{\listalgorithmname}{}{}% \listalgorithmname.
\patchcmd{\listofObjects}{lot}{loa}{}{}%            Get the list of objects from the .loa file.
\renewcommand*{\thealgorithm}{Object \thechapter-\arabic{object}. }

%%% Now we do the reskin process; converting the default "algorithm" content to be "object" content.

% Rename the "algorithms" name in the \listofObjects to be "Objects".
% Also include the other typesetting stuff
% like the "Object" and "page" above the list of actual objects.

\renewcommand{\listalgorithmname}{LIST OF OBJECTS
    
     \hfill \underline{\smash{page}}
    
    \vspace*{-0.7\baselineskip}
    }%
        
\floatname{algorithm}{Object}% Change the word "Algorithm" in the in-line text to be "Object".
\renewcommand*{\thealgorithm}{Object \thechapter-\arabic{algorithm}. }
%% NOTE ABOUT THE FOLLOWING \addObject COMMAND::
%   I am still unclear about what exactly objects are, or how they are to be treated in the text. 
%   This command is a temporary formating command, which can be adjusted to format the "object" input by an author, without the author actually needing to do much of anything, or knowing much of anything in the background.
%   At a minimum, I suspect there will need to be another required argument, where the author will supply a hyperlink. As I understand it, the in-text object will be the caption, but clicking the caption/text should launch a url?

\newcommand{\addObject}[2][H]{
%   This command is for the user to add an 'object' to their dissertation,
%   this command is intended to do all the formating for them, hiding the fact that we
%   hijacked the 'algorithms' list and environments to do so.
%   SYNTAX:: \addObject[#1]{#2}
%   #1 Is an optional parameter that handles placement. We use `H` by default to force LaTeX to place it inline where the command is used, as best it can.
%   #2 Is the required argument, which is the caption (ie text) of the object.
    \begin{algorithm}[#1]
        \captionof{algorithm}{#2}
    \end{algorithm}
    }%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%   User Configuration Commands    %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sets the file name for the copyright file and saves it in the macro 
% \copyrightFile
\providecommand{\setCopyrightFile}[2][tex]{
    \edef\copyrightFile{#2.#1}
    }
    
    
% Sets the file name for the dedication file and saves it in the macro 
% \dedicationFile
\providecommand{\setDedicationFile}[2][tex]{
    \edef\dedicationFile{#2.#1}
    }
    

% Sets the file name for the acknowledgements file and 
% saves it in the macro \acknowledgementsFile
\providecommand{\setAcknowledgementsFile}[2][tex]{
    \edef\acknowledgementsFile{#2.#1}
    }
    
    
% Sets the file name for the abbreviations file and 
% saves it in the macro \abbreviationsFile
\providecommand{\setAbbreviationsFile}[2][tex]{
    \edef\abbreviationsFile{#2.#1}
    }
    

% Sets the file name for the abstract file and 
% saves it in the macro \abstractFile    
\providecommand{\setAbstractFile}[2][tex]{
    \edef\abstractFile{#2.#1}
    }


%  Sets the file name for the appendix file and 
%  saves it in the macro \appendixFile
\providecommand{\setAppendixFile}[2][tex]{
    \edef\appendixFile{#2.#1}
    }
  

%  Sets the file name for the reference file and 
%  saves it in the macro \referenceFile. 
%  We assume anyone using LaTeX will use BibTeX unless they specify otherwise. 
%  The second argument sets the .bst file that should hold the bibtex style file.
\providecommand{\setReferenceFile}[2]{
    \edef\referenceFile{#1}
    \edef\referenceStyle{#2}
    }
    

% Sets the file name for the biographical file and 
% saves it in the macro \biographicalFile
\providecommand{\setBiographicalFile}[2][tex]{ 
    \edef\biographicalFile{#2.#1}
    }

%%%%%%%%%  End Input Page Order %%%%%%%%%%%%


%%%%%%%%% Commands to hold basic information like name, degree type, graduation time, etc.

% Dissertation or Thesis would be the expected values
\providecommand{\thesisType}[1]{
    \providecommand{\@ThesisType}{#1}
    }
    
% Masters of (blah) or Doctorate of Philosophy etc would be the expected text here.
\providecommand{\degreeType}[1]{ 
    \providecommand{\@DegreeType}{#1}
    }
    
% Almost certainly this would be the current year.
\providecommand{\degreeYear}[1]{
    \providecommand{\@DegreeYear}{#1}
    }
    
% This is the chair and takes an optional argument (default blank) for the cochair.
\providecommand{\chair}[2][]{ 
    \providecommand{\@Chair}{#2}
    \if\relax\detokenize{#1}\relax
    % Test if the optional argument is given.
    \else
    %  If it wasn't given we do nothing. 
    %  If it is given, then we will define a "cochair" command to hold the cochair name.
        \providecommand{\@CoChair}{#1}%
    \fi
    }


%  Record and store the intended month of graduation. 
%  Do it this way so we can test it later and warn if no month was given.
\providecommand{\degreeMonth}[1]{ 
    \providecommand{\@DegreeMonth}{#1}
    }%
    
    
%            Provide the "Major" for the abstract.
\providecommand{\major}[1]{
    \providecommand{\@Major}{#1}
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%   Automated Document Building    %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Automatic input of pages and lists in the correct order, omitting the chapters which must be individually input in the main document.

%%%%%%%
%%% Desired Input Page Order:
% Title page, 
% copyright page, 
% dedication (if any), 
% acknowledgments, 
% table of contents, 
% list of tables (if any), 
% list of figures (if any), 
% list of abbreviations (if any), 
% academic abstract, 
% chapters, 
% appendices (if any), 
% list of references, 
% biographical sketch
%%%%%%%
%  This should do most of the pre-user-content formatting... hopefully.
\AtBeginDocument{
\interlinepenalty=150

%  I don't trust people to put stuff into the document in the correct order.
%  So the \setFile type commands above will allow us to automate most of the build order.

% Titlepage comes first
    \maketitle
   
    \newpage
    \vspace*{\fill}
    \begin{center}
        \textcopyright{} \@DegreeYear{} \@author
    \end{center}
    \vspace*{\fill}
    \newpage

% We don't want chapter numbers until later, 
% So let's kill off the table of contents depth detector until we want to start counting.
    \setcounter{secnumdepth}{-1}

    % Dedication comes second
    % If we have defined a dedication file, import it.
    \ifExists{dedicationFile}
      {%% We want the dedication to be centered. So we use \vspace*{\fill} above and below.
            \vspace*{\fill}
       % We also want to center the dedication horizontally.
            \begin{center}
            
            \realSingleSpace
                \input{\dedicationFile}
            \end{center}
       % Note that the * in \vspace* is necessary, as otherwise latex will ignore it here.
            \vspace*{\fill}%
        }
        {
            \@latex@warning{You haven't specified a dedication file using the command \setDedicationFile. Hopefully this is intentional!}
        }    
\phantomsection

    % Acknowledgements come third.
    % If we have defined a acknowledgements file, import it.
    \ifExists{acknowledgementsFile} 
        {
        \chapter{ACKNOWLEDGEMENTS}
        
        \input{\acknowledgementsFile}
        }
        {
            \@latex@warning{You haven't specified a acknowledgements file using the command \setAcknowledgementsFile. Hopefully this is intentional!}
        }


    % Table of Contents comes fourth.
    {\realSingleSpace\tableofcontents}
    
    % List of tables comes next, if you have one.    
    \ifhaveTables
        {\realSingleSpace\listoftables}  
        \addcontentsline{toc}{chapter}{LIST OF TABLES}
    \fi
    
    %List of figures comes next, if you have one.
    \ifhaveFigures
        {\realSingleSpace\listoffigures} 
        \addcontentsline{toc}{chapter}{LIST OF FIGURES}
    \fi
    
    %{List of Objects}}% List of Objects is last, if you have one
    \ifhaveObjects
        {\realSingleSpace \listofObjects}
        \addcontentsline{toc}{chapter}{LIST OF OBJECTS}
    \fi
    \clearpage
    % If we have defined a abbreviations file, import it.
    % Abbreviations come after our lists.
    \ifExists{abbreviationsFile}
        { \phantomsection
            \chapter{LIST OF ABBREVIATIONS}
            \label{abbreviations}
            \input{\abbreviationsFile}
        }
        {
            \@latex@warning{You haven't specified a abbreviations file using the command \setAbbreviationsFile. Hopefully this is intentional!}
        }
        
% Since the abstract needs to be a phantom chapter, we need to force a newpage.   
% Abstract page comes next.
% If we have defined a abstract file, import it.
    \newpage
    \ifExists{abstractFile}%
        {% 
            \phantomsection
            \addcontentsline{toc}{chapter}{ABSTRACT}
            \label{abstract}
            \begin{center}\realSingleSpace
                Abstract of \@ThesisType{} Presented to the Graduate School \\
                of the University of Florida in Partial Fulfillment of the \\
                Requirements for the Degree of \@DegreeType\\[\baselineskip]
            
                \bgroup\@docTitle\egroup\\[\baselineskip]

                By\\[\baselineskip]
                
                \@author \\[\baselineskip]
                
                \@DegreeMonth{} \@DegreeYear
            \end{center}
            \bgroup\realSingleSpace\vspace*{\smallskipamount}
            \ifExists{@Chair}{%
                \noindent Chair: \@Chair \\}%   If we have a chair recorded, display it.
                {%                              If we don't toss a warning out, but proceed.
                    \@latex@warning{You haven't specified a committee chair using the command \chair. Hopefully this is intentional!}
                }
            \ifExists{@CoChair}{%
                \noindent Cochair: \@CoChair \\% If there is a Co-Chair provided, then list it.
                }{%                             Else, toss a warning, even though this is probably normal.
                    \@latex@warning{You haven't specified a committee co-chair using the optional argument of the command \chair. Hopefully this is intentional!}
                }
            \noindent Major: \@Major \\
            \egroup
            
            \input{\abstractFile}
        }
        {
            \@latex@warning{You haven't specified a abstract file using the command \setAbstractFile. Hopefully this is intentional!}
        }
        
 \setcounter{secnumdepth}{5}
	\docBodytrue
        
        \titlecontents{chapter}[2em]
            {\addvspace{8pt}}
            {%
            {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}CHAPTER \ \hspace*{.5em} {\contentslabel{1em}}\hyper@linkend}%
            \ifchapterCapOff\else\color{blue}\uppercase\fi
            }%
            % Decide if we auto capitalize the chapter in TOC or not
            % Based on if overrideChapters option is present. 
            {}
            {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*\addvspace{8pt}}
        
    }%

\AtEndDocument{%   Use this to display the end-content files.
    \docBodyfalse

        \titlecontents{chapter}[2em]
            {\addvspace{8pt}}
            {%
            {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}APPENDIX \hspace*{2em}{\contentslabel{2em}\hspace*{-0.8em}}\hyper@linkend}%
            \ifchapterCapOff\else\color{blue}\uppercase\fi% Decide if we auto capitalize the chapter in TOC or not
%    Based on if overrideChapters option is present.
            }%
            {}
            {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}
            
            
%  Appendix file comes first after user content.
%  If we have defined an appendix file, import it.
    \ifExists{appendixFile}
        {
        %NOTE: If there is only one Appendix, it should be of the form: Appendix  "Appendix title". Otherwise it should use Alpha headers A, B, C, etc. :: Done, see below.
        
        
        
       \ifmultipleAppendix
            
            
        \titleformat{\chapter}[hang]
            {\uppercase}
            {}
            {0pt}
            {\centering\realSingleSpace APPENDIX \thechapter\ }
            [\raggedright\doublespacing]

                
%   We don't want the Appendix to have a number, but it should be linked.        
            \setcounter{secnumdepth}{-1}
            
%  We use a phantom section under the assumption that the appendices will each individually be named via a \chapter command in the file.            
            \phantomsection 
            
            
            
            % %\addcontentsline{toc}{chapter}{APPENDIX}
            %
            \addtocontents{toc}{\vspace{2 mm}}
            
            \setcounter{secnumdepth}{4}
            
            %  Use an entirely different counter for Appendices to avoid
            % hyperref misdirections to other already existing chapters.
            \newcounter{appendixVal}
            
            % Start counter at 0,
            % Since the counter is stepped before the label is made.
            \setcounter{appendixVal}{0} 
            
           % Save the normal \chapter command so we can temporarily hijack it.
            \let\appendixChapter\chapter 
            
            % Append a step counter to the 
            %   Appendix counter to the normal chapter command.
            \renewcommand{\chapter}[1]{\stepcounter{appendixVal}\appendixChapter{#1}}
            
            
            % Force the ToC to display and link using the new counter.
            % Input the appendix file, since we already checked that it exists.
            \renewcommand{\thechapter}{\Alph{appendixVal}}
            \input{\appendixFile} 
            
            % Reset the chapter command back to normal now that appendix is done.
            \let\chapter\appendixChapter 
            
           %  Reset chapter titling to normal now that Appendix are done. 
            \titleformat{\chapter}[hang] 
                {\uppercase}
                {}
                {0pt}
                {\centering\realSingleSpace\ifdocBody CHAPTER \thechapter \\[-5pt] \fi}
                [\raggedright\doublespacing]
                
                
%   If there is only one Appendix, we should do it this way:
        \else

               \titlecontents{chapter}[0em]
                {\addvspace{8pt}}
                {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{2em}{APPENDIX  \expandafter\contentslabel{2em}}\hyper@linkend%
                \ifchapterCapOff\else\color{blue}\uppercase\fi}
                {}
                {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}
                \renewcommand{\thechapter}{}% Remove the number in front of the appendix chapter name.
                
                \titlecontents{chapter}[0em]
                {\addvspace{8pt}}
                {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{2em}{APPENDIX }\hyper@linkend%
                \ifchapterCapOff\else\color{blue}\uppercase\fi}
                {}
                {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}
                \renewcommand{\thechapter}{}% Remove the number in front of the appendix chapter name.
                
                
               \titleformat{\chapter}[hang]
                {\uppercase}
                {}
                {0pt}
                {\centering\realSingleSpace Appendix\\[-5pt]}
                [\raggedright\doublespacing]
                 %%%%%%%%%%%%%%
                 

             \setcounter{secnumdepth}{4}
      %  Use an entirely different counter for Appendicies to avoid
      %  hyperref misdirections to other already existing chapters.
                \newcounter{appendixVal}
                
      % Start counter at 0,
      % Since the counter is stepped before the label is made.    
                \setcounter{appendixVal}{0} 
                
      %  Save the normal \chapter command so we can temporarily hijack it.         
                \let\appendixChapter\chapter
                
      % Append a stepcounter to the Appendix          
                 \renewcommand{\chapter}[1]{\stepcounter{appendixVal}\appendixChapter{#1}}
               \renewcommand{\thechapter}{\Alph{appendixVal}}%
               
                \input{\appendixFile}
                
                 \let\chapter\appendixChapter% 
                
                %%%%%%%%%%%%%%
                \titleformat{\chapter}[hang]%               
                {\uppercase}
                {}
                {0pt}
                {\centering\realSingleSpace\ifdocBody CHAPTER \thechapter \\[-5pt] \fi}
                [\raggedright\doublespacing]
                            
        \fi
        
        }
        {
            \@latex@warning{You haven't specified an appendix file using the command \setAppendixFile. Hopefully this is intentional!}
        }
        
        
%  Fix the spacing and formatting for the references and biographical sketch.
% For some reason LaTeX messes with the spacing when the `end of document' processes,
% so we reset it here.
    \titlecontents{chapter}[0em]
        {\addvspace{8pt}}
        {\hspace*{-2em}\hyper@linkstart{link}{\Hy@tocdestname}\hspace*{2em}{\contentslabel{2em}}\hyper@linkend}
        {}
        {\hyper@linkstart{link}{\Hy@tocdestname}{\titlerule*[5pt]{.}\thecontentspage}\hyper@linkend \\*}
        
    \titlespacing{\chapter}{0pt}{-0.3in}{0.5\baselineskip}
    
    \cleardoublepage
% Reference file comes next.
% If we have defined a reference file, import it.
    \ifExists{referenceFile}
        {
        % And we don't want to number our chapters anymore.
            \setcounter{secnumdepth}{-1}
            
        % We want our heading to be "LIST OF REFERENCES" not "Bibliography".    
            \renewcommand{\bibname}{LIST OF REFERENCES} 
            \phantomsection
            \clearpage 
            \addcontentsline{toc}{chapter}{LIST OF REFERENCES}
            \label{references}
            \bibliographystyle{\referenceStyle}
            \interlinepenalty=10000
            {\singlespacing
            \bibliography{\referenceFile}}
        }
        {
            \@latex@warning{You haven't specified a reference file using the command \setReferenceFile. Hopefully this is intentional!}
        }\clearpage
        \phantomsection
%Biographical Sketch comes next (and last).
% If we have defined a biography file, import it.
    \ifExists{biographicalFile}
        {
            \chapter{BIOGRAPHICAL SKETCH}
            \label{biography}
            
       % Offset the double spacing between title and paragraph.     
            \vspace*{-0.5\baselineskip}
            \interlinepenalty=150
            \input{\biographicalFile}
        }
        {
            \@latex@warning{You haven't specified a biography file using the command \setBiographicalFile. Hopefully this is intentional!}
        }
    }
% End of End-Document processing.


%%% End of automatic input of documents and lists.

\setlength\parindent{1cm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%      Class Options     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This option will override auto-capitalization of titles.
\DeclareOption{overrideTitles}{
    \renewcommand{\@docTitle}{\@title}
    \@latex@warning{You disabled uppercase titles. If you didn't need to, remove `overrideTitles' from \noexpand\documentclass command to fix this.}
    }
    
% This option will override auto-capitalization of chapters.
\DeclareOption{overrideChapters}{

  %% First; auto capitalize the in-line chapter display.
    \titleformat{\chapter}[hang]
        {}
        {}
        {0pt}
        {\centering\realSingleSpace\ifdocBody CHAPTER \thechapter \\ \fi}
        {\raggedright\doublespacing}
    \@latex@warning{You disabled uppercase chapters. If you didn't need to, remove `overrideChapters' from \noexpand\documentclass command to fix this.}
    
 % Also turn off auto capitalization in the TOC.   
    \chapterCapOfftrue 
    }


% This option will override auto-capitalization of titles.
\DeclareOption{editMode}{
    \editModetrue
    \@latex@warning{You enabled editMode. blue text is author remarks, red is editor remarks.}
    \@latex@warning{Remove `editMode' from \noexpand\documentclass command to suppress remarks.}
    }


% May want to Process Options at the end in order to renew commands at the end.
\ProcessOptions\relax 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Editing Mode Options     %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is a way to insert author remarks for the author.
% It will be suppressed unless "editMode" class option is enabled.
% To distinguish it, the author remark will be colored and bolded.
\newcommand{\authorRemark}[1]{
    \ifeditMode
        {\color{blue}\bfseries #1}
    \fi
    }
% End of authorRemark


% This is a way to insert editor remarks for the author.
%  It will be suppressed unless "editMode" class option is enabled.
% To distinguish it, the editor remark will be colored 
% (different than author remarks) and bolded.
\newcommand{\editorRemark}[1]{
    \ifeditMode
        {\color{red}\bfseries #1}
    \fi
    }
% End of authorRemark







