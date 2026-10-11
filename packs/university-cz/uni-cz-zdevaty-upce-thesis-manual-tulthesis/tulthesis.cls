\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tulthesis}[2023/10/29 UPCE thesis class version 0.0]
% Licence: CC BY

\newcommand{\TUL@baseclass}{report}
\DeclareOption{article}{\renewcommand{\TUL@baseclass}{article}}
\DeclareOption{report}{}

\newcommand{\TUL@levelCZ}{Bakal\'{a}\v{r}sk\'{a} pr\'{a}ce}
\newcommand{\TUL@levelEN}{Bachelor thesis}
\newcommand{\TUL@kat}{BP}

% skloňovaný název práce
\newcommand{\TULpraceou}{bakal\'a\v rskou pr\'aci}
\newcommand{\TULpracee}{bakal\'a\v rsk\'e pr\'ace}
% vloží argument podle rodu: #1 pro projekt, #2 pro práce, #3 pro teze
\newcommand{\TULpracerod}[3]{#2}

\DeclareOption{EN}{\PassOptionsToPackage{\CurrentOption}{EN}}
\DeclareOption{BP}{}
\DeclareOption{DP}{
    \renewcommand{\TUL@levelCZ}{Diplomov\'{a} pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Master thesis}
    \renewcommand{\TULpraceou}{diplomovou pr\'aci}
    \renewcommand{\TULpracee}{diplomov\'e pr\'ace}
    \renewcommand{\TULpracerod}[3]{#2}
    \renewcommand{\TUL@kat}{DP}}
\DeclareOption{Dis}{
    \renewcommand{\TUL@levelCZ}{Diserta\v cn\'\i\ pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Dissertation}
    \renewcommand{\TULpraceou}{diserta\v cn\'{\i} pr\'aci}
    \renewcommand{\TULpracee}{diserta\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracerod}[3]{#2}
    \renewcommand{\TUL@kat}{Dis}}
\DeclareOption{Hab}{
    \renewcommand{\TUL@levelCZ}{Habilita\v cn\'\i\ pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Habilitation thesis}
    \renewcommand{\TULpraceou}{habilita\v cn\'{\i} pr\'aci}
    \renewcommand{\TULpracee}{habilita\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracerod}[3]{#2}
    \renewcommand{\TUL@kat}{Hab}}
\DeclareOption{Teze}{
    \renewcommand{\TUL@levelCZ}{Teze diserta\v cn\'\i\ pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Dissertation thesis draft}
    \renewcommand{\TULpraceou}{teze diserta\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracee}{tez\'{\i} diserta\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracerod}[3]{#3}
    \renewcommand{\TUL@kat}{Teze}}
\DeclareOption{Autoref}{
    \renewcommand{\TUL@levelCZ}{Autorefer\'{a}t diserta\v cn\'\i\ pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Dissertation thesis summary}
    \renewcommand{\TULpraceou}{autorefer\'{a}t diserta\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracee}{autorefer\'{a}tu diserta\v cn\'{\i} pr\'ace}
    \renewcommand{\TULpracerod}[3]{#1}
    \renewcommand{\TUL@kat}{Autoref}}
\DeclareOption{Proj}{
    \renewcommand{\TUL@levelCZ}{Projekt}
    \renewcommand{\TUL@levelEN}{Project report}
    \renewcommand{\TULpraceou}{projekt}
    \renewcommand{\TULpracee}{projektu}
    \renewcommand{\TULpracerod}[3]{#1}
    \renewcommand{\TUL@kat}{RP}}
\DeclareOption{SP}{
    \renewcommand{\TUL@levelCZ}{Semestr\'{a}ln\'\i\ pr\'{a}ce}
    \renewcommand{\TUL@levelEN}{Semestral work}
    \renewcommand{\TULpraceou}{semestr\'aln\'{\i} pr\'aci}
    \renewcommand{\TULpracee}{semestr\'aln\'{\i} pr\'ace}
    \renewcommand{\TULpracerod}[3]{#2}
    \renewcommand{\TUL@kat}{SP}}
\DeclareOption{bwtitles}{\PassOptionsToPackage{\CurrentOption}{tul}}
\DeclareOption{bw}{\PassOptionsToPackage{\CurrentOption}{tul}}
\DeclareOption{fonts}{\PassOptionsToPackage{\CurrentOption}{tul}}
\newif\ifTUL@pdf
\TUL@pdftrue
\DeclareOption{nopdf}{\TUL@pdffalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\TUL@baseclass}}
\ProcessOptions\relax

\LoadClass[a4paper,12pt]{\TUL@baseclass}

\RequirePackage[noheader]{tul}
\noTULfooter

\RequirePackage{ifthen}
\RequirePackage{tabularx}
\RequirePackage{pdfpages}

\ifTUL@pdf
 \RequirePackage{hyperref}
 \hypersetup{colorlinks=true, linkcolor=tul, urlcolor=tul, citecolor=tul}
\fi

\newcommand{\TULthesisType}[2]{\renewcommand{\TUL@levelCZ}{#1}%
\renewcommand{\TUL@levelEN}{#2}}

\newcommand{\TUL@nazevCZ}{Chyb\'\i\ \textbackslash TULtitle\{\v{c}esky\}\{anglicky\}}
\newcommand{\TUL@nazevEN}{English title}
\newcommand{\TULtitle}[2]{\renewcommand{\TUL@nazevCZ}{#1}%
\renewcommand{\TUL@nazevEN}{#2}%
\ifTUL@pdf
 \ifthenelse{\equal{\TUL@nguage}{EN}}{\hypersetup{pdftitle={#2}}}{\hypersetup{pdftitle={#1}}}
\fi}

\newcommand{\TUL@autor}{Chyb\'\i\ \textbackslash TULauthor\{jm\'eno\}}
\newcommand{\TULauthor}[1]{\renewcommand{\TUL@autor}{#1}
\ifTUL@pdf
 \hypersetup{pdfauthor={#1}}
\fi}

\newcommand{\TUL@vedouci}{Chyb\'\i\ \textbackslash TULsupervisor\{jm\'eno\}}
\newcommand{\TULsupervisor}[1]{\renewcommand{\TUL@vedouci}{#1}}

\newcounter{TULk@nzult}
\setcounter{TULk@nzult}{0}
%\newcommand{\TULconsultant}[1]{\newcommand{\TUL@konzultant}{#1}}
\newcommand{\TULconsultant}[1]{\stepcounter{TULk@nzult}\@namedef{\roman{TULk@nzult}@TULkonzultant}{#1}}

\newcommand{\TUL@programCZ}{Chyb\'\i\ \textbackslash TULprogramme\{k\'od\}\{\v{c}esky\}\{anglicky\}}
\newcommand{\TUL@programEN}{Study Programme}
\newcommand{\TULprogramme}[3]{\renewcommand{\TUL@programCZ}{#1 -- #2}%
\renewcommand{\TUL@programEN}{#1 -- #3}}

\newcounter{TUL@bor}
\setcounter{TUL@bor}{0}
\newcounter{TULc@unter}
\newcommand{\i@TULoborCZ}{Chyb\'\i\ \textbackslash TULbranch\{k\'od\}\{\v{c}esky\}\{anglicky\}}
\newcommand{\i@TULoborEN}{Study Branches}
\newcommand{\TULbranch}[3]{%
  \stepcounter{TUL@bor}
  \ifthenelse{\equal{#1}{}}{
    \@namedef{\roman{TUL@bor}@TULoborCZ}{#2}%
    \@namedef{\roman{TUL@bor}@TULoborEN}{#3}%
  }{
    \@namedef{\roman{TUL@bor}@TULoborCZ}{#1 -- #2}%
    \@namedef{\roman{TUL@bor}@TULoborEN}{#1 -- #3}%
  }
}

\newcommand{\TUL@rok}{\the\year}
\newcommand{\TULyear}[1]{\renewcommand{\TUL@rok}{#1}}

\newcommand{\TULid}[1]{\newcommand{\TUL@id}{#1}}

% podpurne prikazy
\newcommand{\@ddel}{\hspace{0.5em}\rule[-0.2em]{0.75pt}{1.2em}\hspace{0.5em}}

\newenvironment{uzky@text}{\begin{center}\begin{minipage}{0.80\textwidth}
\setlength{\parskip}{0.5\baselineskip}}{\end{minipage}\end{center}}


% rozmery stranky a styl zapati
\setlength{\oddsidemargin}{10mm}
\setlength{\evensidemargin}{0mm}
\setlength{\textwidth}{150mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\textheight}{230mm}
\setlength{\footskip}{15mm}
\fancyfoot{}
\fancyfootoffset{0pt}
\if@twoside
    \fancyfoot[RO,LE]{\textbf{\thepage}}
\else
    \fancyfoot[R]{\thepage}
\fi
\newlength{\title@line}

\newdimen{\TUL@shift}
\setlength{\TUL@shift}{2.1cm}
\newdimen{\TUL@wide}
\setlength{\TUL@wide}{\linewidth}
\addtolength{\TUL@wide}{\TUL@shift}
\newcommand{\ThesisTitle}[1]{{\thispagestyle{TULheaderonly}\sffamily
\mbox{}

\vfill

\hspace*{-\TUL@shift}\begin{minipage}{\TUL@wide}
{\noindent\large\bfseries
\ifthenelse{\equal{#1}{EN}}{\TUL@levelEN}{\TUL@levelCZ}\\[\bigskipamount]
\raggedright\fontsize{18pt}{22pt}\selectfont\color{\tulcolor}\bfseries
\ifthenelse{\equal{#1}{EN}}{\TUL@nazevEN}{\TUL@nazevCZ}\par}

\bigskip
\bigskip

\newcommand{\t@nd}{&}
\newcommand{\n@dpis}{\itshape}
\noindent\begin{tabularx}{\TUL@wide}{@{}p{6cm}X@{}}
\ifthenelse{\equal{\TUL@kat}{Hab}}{%
  \ifthenelse{\equal{#1}{EN}}{Author}{Autor pr\'ace}: &
  \bfseries\TUL@autor \\
  \ifthenelse{\equal{#1}{EN}}{Field}{Obor}:
   & \ifthenelse{\equal{#1}{EN}}{\i@TULoborEN}{\i@TULoborCZ}
  \\
}{%
  \n@dpis \ifthenelse{\equal{#1}{EN}}{Study programme}{Studijn\'\i\ program}: &
  \ifthenelse{\equal{#1}{EN}}{\TUL@programEN}{\TUL@programCZ} \\
  \ifthenelse{\value{TUL@bor}=0}{}{%
    \n@dpis
    \ifthenelse{\equal{#1}{EN}}
        {Study branch\ifnum\theTUL@bor>1\relax es\fi}%
        {Studijn\'\i\ obor\ifnum\theTUL@bor>1\relax y\fi}:
     & \ifthenelse{\equal{#1}{EN}}{\i@TULoborEN}{\i@TULoborCZ}
    \\
    \setcounter{TULc@unter}{1}%
    \whiledo{\value{TULc@unter} < \value{TUL@bor}}{
        \stepcounter{TULc@unter}\t@nd % zamaskovaný "&"
        \ifthenelse{\equal{#1}{EN}}
            {\@nameuse{\roman{TULc@unter}@TULoborEN}}%
            {\@nameuse{\roman{TULc@unter}@TULoborCZ}}\\
    }%
  }%
  \n@dpis
  \ifthenelse{\equal{#1}{EN}}{Author}{Autor pr\'ace}: &
  \bfseries\TUL@autor \\
  \n@dpis
  \ifthenelse{\equal{#1}{EN}}{Supervisor}{Vedouc\'\i\ pr\'ace}: &
  \TUL@vedouci \\
  \@ifundefined{i@TULkonzultant}{}{\n@dpis
      \ifthenelse{\equal{#1}{EN}}
          {Consultant\@ifundefined{ii@TULkonzultant}{}{s}}
          {Konzultant\@ifundefined{ii@TULkonzultant}{}{i}}:
      & \i@TULkonzultant \\}
  \setcounter{TULc@unter}{1}%
  \whiledo{\value{TULc@unter} < \value{TULk@nzult}}{
      \stepcounter{TULc@unter}\t@nd % zamaskovaný "&"
      \@nameuse{\roman{TULc@unter}@TULkonzultant}\\
  }
}
\rule{0pt}{1cm} & Pardubice \TUL@rok \\
\end{tabularx}

\end{minipage}
\cleardoublepage}}


\newcommand{\Assignment}{
\mbox{}
\vfill

\begin{center}
\LARGE
\ifthenelse{\equal{\TUL@nguage}{EN}}%
{This page has to be replaced\\[0.5em]by original of an assignment.}%
{Tento list nahra\v{d}te\\[0.5em]origin\'alem zad\'an\'\i.}
\thispagestyle{empty}
\end{center}

\vfill
\cleardoublepage
}

% koncovka ženského rodu sloves
\newcommand{\TULfem}[1]{\ifthenelse{\equal{#1}{female}}{a}{}}

\newcommand{\TULpraceCZ}{\lowercase\expandafter{\TUL@levelCZ}}

\newcommand{\DeclarationCZ}[1]{
\section*{Prohla\v{s}uji:}

Tuto \TULpraceou\ jsem vypracoval\TULfem{#1} samostatně. Veškeré literární prameny a~informace, které jsem v~práci využil\TULfem{#1}, jsou uvedeny v~seznamu použité literatury.
Byl\TULfem{#1} jsem seznámen\TULfem{#1} s~tím, že se na moji práci vztahují práva a~povinnosti vyplývající ze zákona č.~121/2000 Sb., o~právu autorském, o~právech souvisejících s~právem autorským a~o~změně některých zákonů (autorský zákon), ve znění pozdějších předpisů, zejména se skutečností, že Univerzita Pardubice má právo na uzavření licenční smlouvy o~užití této práce jako školního díla podle §~60 odst. 1 autorského zákona, a~s~tím, že pokud dojde k~užití této práce mnou nebo bude poskytnuta licence o~užití jinému subjektu, je Univerzita Pardubice oprávněna ode mne požadovat přiměřený příspěvek na úhradu nákladů, které na vytvoření díla vynaložila, a~to podle okolností až do jejich skutečné výše.

Beru na vědomí, že v~souladu s~§~47b zákona č.~111/1998 Sb., o~vysokých školách a~o~změně a~doplnění dalších zákonů (zákon o vysokých školách), ve znění pozdějších předpisů, a~směrnicí Univerzity Pardubice č.~7/2019 Pravidla pro odevzdávání, zveřejňování a~formální úpravu závěrečných prací, ve znění pozdějších dodatků, bude práce zveřejněna prostřednictvím Digitální knihovny Univerzity Pardubice.

\vspace{2cm}
V Pardubicích dne \noindent \the\day. \the\month. \the\year
\hfill
\noindent \TUL@autor
}

\newcommand{\ThesisType@EN}{\lowercase\expandafter{\TUL@levelEN}}

\newcommand{\DeclarationEN}{
\section*{Declaration}

I hereby certify, I, myself, have written my \ThesisType@EN\ as an original and
primary work using the literature listed below%
\ifthenelse{\equal{\TUL@kat}{Hab}}{}{ and consulting it with my thesis
supervisor and my thesis counsellor}.

\ifthenelse{\equal{\TUL@kat}{Hab}}{}{I acknowledge that my \ThesisType@EN\ is
  fully governed by Act No.~121/2000 Coll., the Copyright Act, in particular
  Article~60 -- School Work.

  I acknowledge that the Technical University of Liberec does not infringe my
  copyrights by using my \ThesisType@EN\ for internal purposes of the Technical
  University of Liberec.

  I am aware of my obligation to inform the Technical University of Liberec on
  having used or granted license to use the results of my \ThesisType@EN; in
  such a case the Technical University of Liberec may require reimbursement of
  the costs incurred for creating the result up to their actual amount.

  \ifthenelse{\equal{\TUL@kat}{BP} \OR \equal{\TUL@kat}{DP} \OR
  \equal{\TUL@kat}{Dis}}{At the same time, I honestly declare that the text of
  the printed version of my \ThesisType@EN\ is identical with the text of the
  electronic version uploaded into the IS STAG.}{}}

I acknowledge that the Technical University of Liberec will make my
\ThesisType@EN\ public in accordance with paragraph~47b of Act No.~111/1998
Coll., on Higher Education Institutions and on Amendment to Other Acts (the
Higher Education Act), as amended.

I am aware of the consequences which may under the Higher Education Act result
from a breach of this declaration.

\vspace{2cm}
\noindent \the\day. \the\month. \the\year
\hfill
\noindent \TUL@autor
}


\newcommand{\Declaration}[1]{\vspace*{2cm}
\thispagestyle{empty}
\begin{uzky@text}
\ifthenelse{\equal{\TUL@nguage}{EN}}{\DeclarationEN}{\DeclarationCZ{#1}}
\end{uzky@text}
\cleardoublepage
}


\newcommand{\ThesisStart}[1]{
\ifthenelse{\equal{#1}{female} \OR \equal{#1}{male}}{
    \ifthenelse{\equal{\TUL@nguage}{EN}}{\ThesisTitle{EN}}{\ThesisTitle{CZ}}
    \ifthenelse{\equal{\TUL@kat}{BP}
            \OR \equal{\TUL@kat}{DP}
            \OR \equal{\TUL@kat}{RP}
            \OR \equal{\TUL@kat}{MP}}{\Assignment \Assignment}{}
    \Declaration{#1}}%
{\includepdf[pages=-]{#1}}
}


\newenvironment{abstractCZ}[1][narrow]{\ifthenelse{\equal{#1}{wide}}%
{\renewcommand{\endabstractCZ}{\par}}% široká verze na konci nedělá nic
{\begin{uzky@text}\renewcommand{\endabstractCZ}{\end{uzky@text}}}% úzká verze
\section*{\TUL@nazevCZ}\medskip\section*{Anotace}}{}

\newenvironment{abstractEN}[1][narrow]{\ifthenelse{\equal{#1}{wide}}%
{\renewcommand{\endabstractEN}{\par}}% široká verze na konci nedělá nic
{\begin{uzky@text}\renewcommand{\endabstractEN}{\end{uzky@text}}}% úzká verze
\section*{\TUL@nazevEN}\medskip\section*{Annotation}}{}

\newenvironment{keywordsCZ}[1][narrow]{\ifthenelse{\equal{#1}{wide}}%
{\renewcommand{\endkeywordsCZ}{\par}}% široká verze na konci nedělá nic
{\begin{uzky@text}\renewcommand{\endkeywordsCZ}{\end{uzky@text}}}% úzká verze
\paragraph*{Kl\'\i\v{c}ov\'a slova:}}{}

\newenvironment{keywordsEN}[1][narrow]{\ifthenelse{\equal{#1}{wide}}%
{\renewcommand{\endkeywordsEN}{\par}}% široká verze na konci nedělá nic
{\begin{uzky@text}\renewcommand{\endkeywordsEN}{\end{uzky@text}}}% úzká verze
\paragraph*{Keywords:}}{}

%\newcommand{\keywordsCZ}[2][]{\ifthenelse{\equal{#1}{wide}}{}{\begin{uzky@text}}\noindent
%\textbf{Kl\'\i\v{c}ov\'a slova:} #2\ifthenelse{\equal{#1}{wide}}{}{\end{uzky@text}}}

\newenvironment{acknowledgement}[1][narrow]{\ifthenelse{\equal{#1}{wide}}%
{\renewcommand{\endacknowledgement}{\clearpage}}% široké poděkování na konci jen odstránkuje
{\begin{uzky@text}\renewcommand{\endacknowledgement}{\end{uzky@text}\clearpage}}% úzké
\ifthenelse{\equal{\TUL@nguage}{EN}}%
{\section*{Acknowledgements}}%
{\section*{Pod\v ekov\'an\'{\i}}}}{}

\newenvironment{abbrList}{\ifthenelse{\equal{\TUL@nguage}{EN}}%
{\section*{List of abbreviations}\addcontentsline{toc}{section}{List of abbreviations}}%
{\section*{Seznam zkratek}\addcontentsline{toc}{section}{Seznam zkratek}}
\noindent\tabularx{\linewidth}{@{}lX@{}}}
{\endtabularx
\clearpage}

\titleformat{\chapter}%
{\normalfont\TULmono\LARGE\bfseries\color{\titlecolor}\raggedright}{\thechapter}{1em}{}

