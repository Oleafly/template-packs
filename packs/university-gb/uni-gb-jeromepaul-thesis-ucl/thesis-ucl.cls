%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "THE BEER-WARE LICENSE" (Revision 42):
% <jerome.paul@uclouvain.be> wrote this file.  As long as you retain this
% notice you can do whatever you want with this stuff. If we meet some day, and
% you think this stuff is worth it, you can buy me a beer in return.
% Jérôme PAUL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Simple thesis format for UCL theses
% compliant with http://www.ciaco.com/impression-theses.html
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Class needed :
%     book
% Packages needed :
%     inputenc
%     babel
%     graphicx
%     emptypage
%     nonumonpart
%     makeidx
%     geometry
%     titlesec
%     regexpatch
%     gitinfo (when passing 'gitversion' option)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ****************************** class declaration *****************************
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis-ucl}[2016/01/13 simple style for a UCL thesis book]
% ******************************************************************************

% *********************************** options **********************************
% show git revision hash on title page
% read doc of gitinfo package :
%     you need to add post-commit script in ./.git/hooks/
\makeatletter
\DeclareOption{gitversion}{
    \AtEndOfPackage{\RequirePackage{gitinfo}}
    \renewcommand\@gitrev{
        \small \vspace{1em} version of \today{} --- git:\gitAbbrevHash
    }
}
% show current version date on the title page
\DeclareOption{version}{
    \renewcommand\@gitrev{\small \vspace{1em} version of \today{}}
}
\newcommand\@gitrev{}
\makeatother
% e.g. to pass the "draft" option to the book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
% ******************************************************************************

% ******************************** document type *******************************
% paper format and font size according to ucl thesis format (ciaco print)
\LoadClass[a4paper,11pt]{book}
% ******************************************************************************

% ********************************** encoding **********************************
\RequirePackage[utf8]{inputenc} % file encoding
\RequirePackage[english]{babel} % word hyphenation. Change according to language
% ******************************************************************************

% ******************************** misc packages *******************************
\RequirePackage[final]{graphicx}    % include images
\RequirePackage{emptypage}          % to clear page number in empty pages
\RequirePackage{nonumonpart}        % no page number on part pages
\RequirePackage{makeidx} \makeindex % to create an index : \index{words}
% ******************************************************************************

% ********************************** formating *********************************
% Adjust margin for ciaco printed theses
\RequirePackage[top=4.8cm, bottom=4.8cm, left=4.5cm, right=4.5cm]{geometry}
\renewcommand{\emph}{\textbf}

% change the chapter title design to
%
% Chapter #42
% -----------------------------------------
%           Centered chapter name
% -----------------------------------------
%
% or any other chapter number :-)
\RequirePackage{titlesec}
\titleformat{\chapter}       % command
    [display]                % shape
    {\bfseries\huge\itshape} % format
    {Chapter \thechapter}  % label
    {0px}                    % sep
    {
        \thispagestyle{empty}    % no page number
        \rule{\textwidth}{1pt}   % upper rule 
        \centering               % title centered
    }                        % before-code
    [
        \vspace{-.5em}           % hack to put lower rule at same distance
        \rule{\textwidth}{1pt}   % lower rule
    ]                        % after-code

% Lower case in chaptermark and section mark
% (remove \MakeUppercase from macro definition)
\RequirePackage{regexpatch}
\makeatletter
% \*patchcmd{<cmd>}{<search>}{<replace>}{<success>}{<failure>}
\xpatchcmd{\chaptermark}{\MakeUppercase}{}{}{}%
\xpatchcmd{\sectionmark}{\MakeUppercase}{}{}{}%
\xpatchcmd*{\tableofcontents}{\MakeUppercase}{}{}{}%
\makeatother

% ******************************************************************************

% ********************************* title page *********************************
\makeatletter
% \subtitle{text} command to define the thesis' subtitle
\newcommand\subtitle[1]{\renewcommand\@subtitle{#1}}
\newcommand\@subtitle{}

% \jury{text} command to define jury members on title page
\newcommand\jury[1]{\renewcommand\@jury{#1}}
\newcommand\@jury{}

% \uniflogo{path/to/picture} to choose the university's logo
\newcommand\uniflogo[1]{\renewcommand\@uniflogo{#1}}
\newcommand\@uniflogo{}

% \unifname{text} to define the university's name
\newcommand\unifname[1]{\renewcommand\@unifname{#1}}
\newcommand\@unifname{}

% \institutename{text} to define the institute's name
\newcommand\institutename[1]{\renewcommand\@institutename{#1}}
\newcommand\@institutename{}

% \groupname{text} to define the name of the research group
\newcommand\groupname[1]{\renewcommand\@groupname{#1}}
\newcommand\@groupname{}

% \degree{text} to specify the Ph.D. degree
\newcommand\degree[1]{\renewcommand\@degree{#1}}
\newcommand\@degree{}

\renewcommand{\maketitle}{
    \begin{titlepage}
        \parindent0pt % no indentation on this page
        \makeatletter
            \begin{minipage}{.15\textwidth}
                \includegraphics[width=\textwidth]{\@uniflogo}
            \end{minipage}
            \hfill
            \begin{minipage}{.75\textwidth}
                \large
                \@unifname\\
                \@institutename\\
                \@groupname
            \end{minipage}
            
            \vfill
            
            \rule{\linewidth}{0.5mm}
            \begin{center}
                \huge \textbf{\@title}\\
                \Large
                ---\\
                \@subtitle
            \end{center}
            \rule{\linewidth}{0.5mm}

            \vspace{1cm}
            \begin{center}
                \Large \@author        
            \end{center}
            
            \vspace{1cm}
            \begin{flushright}
            Thesis presented for the Ph.D. degree\\
            in \@degree
            \end{flushright}
            
            \vfill
            
            Thesis jury :\\
            \@jury
            
            \vfill        
            
            \begin{center}
                \@date\\
                \@gitrev
            \end{center}
            
            
        \makeatother
    \end{titlepage}
    \cleardoublepage
}
\makeatother
% ******************************************************************************

% ********************************* quote page *********************************
% usage \quotepage[personal bottom note]{citation}{reference}
\newcommand{\quotepage}[3][~]{
    \thispagestyle{empty}
    
    \vspace*{\fill}
    
    \begin{flushright}
        \large
        \textit{`#2'}\\
        ~\\
        #3
    \end{flushright}
    
    \vspace*{\fill}
    
    \begin{flushright}
        #1
    \end{flushright}
    
    \newpage
    \cleardoublepage
}
% ******************************************************************************