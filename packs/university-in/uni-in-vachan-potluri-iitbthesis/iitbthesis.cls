% IITB thesis template according to rules stated at https://www.iitb.ac.in/newacadhome/rules/Dissertation17june09-10.pdf

% Only the absolutely essential requirements are set. Remaining customisations are at the hands of the user
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iitbthesis}[2023/06/01]



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt, a4paper]{book}



\RequirePackage[varg]{newtx} % times fonts
\RequirePackage{emptypage} % prevent page numbering on empty page
\RequirePackage[
    top=30mm,
    bottom=52mm,
    inner=30mm,
    outer=20mm,
    headheight=3mm,
    headsep=12mm,
    footskip=10mm,
]{geometry} % page margins
\RequirePackage{graphicx} % loading iitb logo
\RequirePackage[indent=12mm]{parskip} % setting \parskip and \parindent
\RequirePackage{pgffor} % \foreach loop
\RequirePackage[onehalfspacing]{setspace} % line stretching (spacing)
\RequirePackage{xparse} % declaring commands for front matter



\newcommand{\BlankUnderline}[1]{\underline{\hspace{#1}}} % adds a blank underline of a certain length
\newcommand{\PageTitle}[1]{%
    {\noindent\LARGE\bfseries#1}\\[2em]
} % a stanalone page title for front matter

\NewDocumentCommand{\Abstract}{%
    +m % abstract content (+ allows for \par in the argument, https://tex.stackexchange.com/a/64329/133968)
}{%
    \cleardoublepage
    \PageTitle{Abstract}
    #1
    \cleardoublepage
}

\NewDocumentCommand{\Acknowledgement}{%
    +m % acknowledgement content
}{%
    \cleardoublepage
    \PageTitle{Acknowledgement}
    #1
    \vspace{\VertBlockSpacing}
    \begin{flushright}
        \BlankUnderline{\UnderlineWidth}\\
        \StudentName\\
        Roll \# \StudentRollNo
    \end{flushright}
    \vspace{\VertBlockSpacing}
    Date: \BlankUnderline{0.5\UnderlineWidth}
    \cleardoublepage
}

\NewDocumentCommand{\Approval}{%
    O{3} % number of examiners
    O{2} % number of supervisors
}{%
    \cleardoublepage
    \newlength{\UnderlineWidth}
    \setlength\UnderlineWidth{15em}
    \newlength{\VertBlockSpacing}
    \setlength\VertBlockSpacing{2.5em}
    \newlength{\VertLineSpacing}
    \setlength{\VertLineSpacing}{1em}
    \PageTitle{Thesis Approval Sheet}
    This thesis titled ``\Title'' by \StudentName{} is approved for the degree of \emph{\Degree}.\\
    \begin{flushright}
        {\bfseries Examiners}\\[\VertLineSpacing]
        \foreach \i in {1,2,...,#1} {\BlankUnderline{\UnderlineWidth}\\[\VertLineSpacing]}
        \vspace{\VertBlockSpacing}
        {\bfseries Supervisor(s)}\\[\VertLineSpacing]
        \foreach \i in {1,2,...,#2} {\BlankUnderline{\UnderlineWidth}\\[\VertLineSpacing]}
        \vspace{\VertBlockSpacing}
        {\bfseries Chairperson}\\[\VertLineSpacing]
        \BlankUnderline{\UnderlineWidth}
    \end{flushright}
    \vspace{\VertBlockSpacing}
    Date: \BlankUnderline{0.5\UnderlineWidth}\\
    Place: \BlankUnderline{0.5\UnderlineWidth}
    \cleardoublepage
}

\NewDocumentCommand{\Declaration}{%
}{%
    \cleardoublepage
    \PageTitle{Declaration of Academic Honesty}
    I declare that this written submission represents my ideas in my own words and where others' ideas or words have been included, I have adequately cited and referenced the original sources. I also declare that I have adhered to all principles of academic honesty and integrity and have not misrepresented or fabricated or falsified any idea/data/fact/source in my submission. I understand that any violation of the above will be cause for disciplinary action by the Institute and can also evoke penal action from the sources which have thus not been properly cited or from whom proper permission has not been taken when needed.
    \vspace{\VertBlockSpacing}
    \begin{flushright}
        \BlankUnderline{\UnderlineWidth}\\
        \StudentName\\
        Roll \# \StudentRollNo
    \end{flushright}
    \vspace{\VertBlockSpacing}
    Date: \BlankUnderline{0.5\UnderlineWidth}
    \cleardoublepage
}

\NewDocumentCommand{\Dedication}{%
    m % dedication text
}{%
    \cleardoublepage
    \vspace*{\fill}
    \begin{center}
        #1
    \end{center}
    \vspace*{\fill}
    \cleardoublepage
}

\NewDocumentCommand{\Nomenclature}{%
    m % nomenclature content
}{%
    \cleardoublepage
    \PageTitle{Nomenclature}
    #1
    \cleardoublepage
}

\NewDocumentCommand{\Publications}{%
    m % publications by candidate
}{%
    \cleardoublepage
    \PageTitle{Publications}
    #1
    \cleardoublepage
}

\NewDocumentCommand{\TitleSheet}{%
    m % title
    O{Doctor of Philosophy} % degree
    m % student name
    m % roll number
    m % supervisors, separated by newline
    m % department
    O{2023} % year
}{%
    \cleardoublepage
    \thispagestyle{empty} % no page numbering
    \def\Title{#1}
    \def\Degree{#2}
    \def\StudentName{#3}
    \def\StudentRollNo{#4}
    \begin{center}
        {{\setstretch{1} \Huge \Title \par}}\vspace{1em} % https://tex.stackexchange.com/a/239395/133968 (\par at the end)
        {Submitted in partial fulfillment of the requirements\\of the degree of}\\[1em]
        {\large \Degree}\\[1em]
        {by}\\
        {\large \StudentName}\\
        {\large Roll \# \StudentRollNo}\\[1em]
        {Supervisor(s):}\\
        {\large #5}\\[1em]
        \includegraphics[width=0.3\linewidth]{iitb_logo.pdf}\\[1em]
        {#6}\\[0.5em]
        {\large Indian Institute of Technology Bombay}\\[0.5em]
        {\large #7}
    \end{center}
    \cleardoublepage
    \pagenumbering{gobble} % reset page counter
}
