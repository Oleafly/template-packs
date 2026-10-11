%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%Dissertation Guidelines 
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%Version 4.5
%%Date: 07 October 2016
%%Address: CVR Lab, Department of CSE, NIT Rourkela, 769008, Odisha, India.
%%http://nitrkl.ac.in
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%===Description===
%%It has a LaTeX template to write dissertation 
%%for any academic degree at National Institute of Technology Rourkela.
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%===File Organization===
%%Download the zipped file from (Academic -> Dissertation Template)
%%	at the URL http://nitris.nitrkl.ac.in 
%%	
%%Unzip and store in any folder of your convenience; 
%%you will find the following files/folder in it ---
%%.	NITRdissertationTemplateV4_5
%%		DissertationGuidelinesV4_5.tex
%%		FrontPages.tex
%%		NITR.cls
%%		README.txt
%%		DissertationGuidelinesV4_5.pdf
%%.		Chap00
%%			Dedication.tex
%%			Acknowledge.tex
%%			Abstract.tex
%%			NITlogo.eps
%%.		Chap01
%%			Guidelines.tex
%%.		Chap02
%%			Unstructured.tex
%%.		Chap03
%%			Conclusion.tex
%%.		Ref
%%			SampleReferences.bib
%%			IEEEtran.bst
%%			asme.bst
%%			achemso.bst
%%			bmes.bst
%%			naturemag.bst
%%			osajnl.bst
%%			rsc.bst
%%			SampleDissemination.tex
%%			
%%Read the pdf file "DissertationGuidelinesV4_5.pdf" for a detailed guidelines.
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%===Use of MikTeX/TeXLive===
%%Use latest MikTeX or TeXLive as some features of the template may not be compatible with older versions. 
%%MiKTeX 2.9.5840 can be downloaded from Academic -> Dissertation Template at NITRIS. 
%%Uninstall the older version of MikTeX from your computer and install the latest version.
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
%%===How to use it===
%%(1) Enter your details in file "FrontPages.tex".
%%(2) Write your chapters and put in appropriate folders.
%%(3) Call each file from "DissertationGuidelinesV4_5.tex"
%%(4) You can add as many folders you require.
%%(5) If you use command prompt the use the following four commands
%%		>xelatex DissertationGuidelinesV4_5.tex
%%		>bibtex DissertationGuidelinesV4_5
%%		>xelatex DissertationGuidelinesV4_5.tex
%%		>xelatex DissertationGuidelinesV4_5.tex
%%   If you prefer to use any integrated development environment (IDE) like TexStudio, LEd etc
%%   then press appropriate button that would execute xelatex command.
%%(6) Your pdf file is now ready.
%%(7) Print it 
%%	(a) by setting A4 paper in printer properties
%%	and
%%	(b) by selecting the "Actual Size" in "Page Sizing & Handling"
%%~~~~~~~~~~~~~~~~~~~~~~~
%%~~~~~~~~~~~~~~~~~~~~~~~
\NeedsTeXFormat{LaTeX2e} %[2016/04/20]
\ProvidesClass{NITR}[2016/10/07 v4.5  NIT Rourkela Dissertation LaTeX document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{12pt}         % define 12pt as the default doc size
\ProcessOptions
\LoadClass{report}  % load report.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAGE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\hoffset 0mm
\voffset 0mm
\topmargin -10.4mm  %    distance from top of page to running head
\headheight 5mm
\headsep 5mm      % Space between running head and text.
\textheight 247mm % Space for text.
\textwidth 154mm  % Width of text.
\footskip 10mm    % Distance from baseline of box containing foot to baseline of last line of text.
\oddsidemargin 5.6mm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% OTHER PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{latexsym}
\RequirePackage{fancyhdr}
% % % % % % %
\RequirePackage{textcomp}
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{\paperwidth}
\setlength{\TPVertModule}{\paperheight}
% % % % % % %
\RequirePackage[utf8]{inputenc}
\RequirePackage{array}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}m{#1}}
%%%\RequirePackage[square,numbers,sort&compress,comma]{natbib}
\RequirePackage[authoryear]{natbib}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CHAPTER TITLE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\titleformat{\chapter}[display]{\bfseries\Huge}{\LARGE{Chapter \thechapter}}{0.5ex}
{
%\rule{\textwidth}{2pt}
\centering
}
[\vspace{-1ex} %\rule{\textwidth}{2pt}
]
%%%%%%%%%
\def\SpecialTitle#1{%   GENERAL HEADING WITHOUT A NUMBER (for abstract, etc.)
     \ifx\phantomsection\undefined
     \else
        \clearpage\phantomsection
     \fi
     \addcontentsline{toc}{chapter}{#1}
     \chapter*{\centering #1 \@mkboth{#1}{#1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TITLE PAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@nitr{National Institute of Technology Rourkela}
\def\docTitle#1{\gdef\@docTitle{#1}}
\def\author#1{\gdef\@author{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\department#1{\gdef\@department{#1}}
\def\degreeIn#1{\gdef\@degreeIn{#1}}
\def\specialization#1{\gdef\@specialization{#1}}
\def\docType#1{\gdef\@docType{#1}}
\def\rollNumber#1{\gdef\@rollNumber{#1}}
\def\numOfSupervisors#1{\gdef\@numOfSupervisors{#1}}
\def\titlePageLineSpacing#1{\gdef\@titlePageLineSpacing{#1}}
\def\principalSupervisor#1{\gdef\@principalSupervisor{#1}}
\def\coSupervisor#1{\gdef\@coSupervisor{#1}}
\def\firstMemberDSC#1{\gdef\@firstMemberDSC{#1}}
\def\secondMemberDSC#1{\gdef\@secondMemberDSC{#1}}
\def\thirdMemberDSC#1{\gdef\@thirdMemberDSC{#1}}
\def\externalExaminer#1{\gdef\@externalExaminer{#1}}
\def\chairperson#1{\gdef\@chairperson{#1}}
\def\hod#1{\gdef\@hod{#1}}
\def\principalSupervisorDesignation#1{\gdef\@principalSupervisorDesignation{#1}}
\def\coSupervisorDesignation#1{\gdef\@coSupervisorDesignation{#1}}
\def\authorGender#1{\gdef\@authorGender{#1}}
\def\studentType#1{\gdef\@studentType{#1}}
\def\setDate#1{\gdef\@setDate{#1}}
\def\setMonth#1{\gdef\@setMonth{#1}}
\def\setYear#1{\gdef\@setYear{#1}}
\def\Font#1{\gdef\@Font{#1}}
\def\indexColumns#1{\gdef\@indexColumns{#1}}
\def\titleWidth#1{\gdef\@titleWidth{#1}}
\def\titleCoordinateX#1{\gdef\@titleCoordinateX{#1}}
\def\titleCoordinateY#1{\gdef\@titleCoordinateY{#1}}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\coverPage{%
	\thispagestyle{empty}
	\begin{tabular}{l}
	\end{tabular}
	\begin{textblock}{\@titleWidth}[0,0](0.16,0.12) 
		\begin{flushleft}
			\begin{spacing}{2}
				{\huge {\textbf{\@docTitle}}} 
			\end{spacing}
		\end{flushleft}
% %		(Version 4.4) % comment this line
	\end{textblock}
	\begin{textblock}{.75}[0,0](0.16,0.4) 
		\noindent
		{\Large {\textbf{\@author}}}
	\end{textblock}
	\begin{textblock}{.3}[0,0](0.16,0.82) 
		\hspace*{-.6cm}\includegraphics[height=25mm]{Chap00/NITlogo}
	\end{textblock}
	\begin{textblock}{.7}[0,0](0.25,0.867) 
		%\hspace{1mm}
		\begin{minipage}{.9\linewidth}
			{\linespread{1}
			\large {\@department}\\
			\Large {\bf\@nitr}
			}
		\end{minipage}
	\end{textblock}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\renewcommand{\baselinestretch}{1.5} 
\def\titlePage{%
	\pagenumbering{roman}
	\thispagestyle{empty}
	\begin{textblock}{\@titleWidth}[0,0](\@titleCoordinateX,\@titleCoordinateY) 
		\begin{center}
			\begin{table}[h]
				\begin{tabular}{C{\textwidth}}
					\begin{spacing}{2}
						{\huge {\textbf{\@docTitle}}} 
					\end{spacing}
				\end{tabular}
			\end{table}
		\end{center}
	\end{textblock}
	
	\begin{textblock}{.75}[0,0](0.16,0.26) 
		\begin{center}
					\begin{spacing}{1.5}
						{\textit{
							\ifthenelse{\@docType=1}{Dissertation submitted in partial fulfillment}
							{\ifthenelse{\@docType=2}{Thesis submitted in partial fulfillment}
							{\ifthenelse{\@docType=3}{Project report submitted in partial fulfillment}{E R R O R}}}}}
							\\
						{\textit{of the requirements for the degree of}}\\
						\vspace{5mm}
						{\large\textit{\textbf{\@degree}}}\\ %
						{\textit{in}}\\
						{\large\textit{\textbf{\@degreeIn}}} %
						\ifthenelse{\equal{\@studentType}{postgraduate}}{
							\begin{spacing}{1.1}
								\normalsize\textbf{(\textit{Specialization}: \textit{\@specialization})}
							\end{spacing}
							}{}
					\end{spacing}
					\begin{spacing}{2.2}
					\end{spacing}
					\begin{spacing}{1.8}
						{\textit{by}}\\
						{\Large\textit{\textbf{\@author}}}\\ %
						{\footnotesize{(Roll Number: \@rollNumber)}}
					\end{spacing}
					\begin{spacing}{2.2}
					\end{spacing}
					\begin{spacing}{1.8}
						{\textit{based on research carried out}}\\
						{\textit{under the supervision of}}\\
						{\textit{\textbf{Prof.~\@principalSupervisor}}}
						\ifthenelse{\@numOfSupervisors = 1}{}{\\\textit{and}\\}
						\ifthenelse{\@numOfSupervisors = 1}{}{\textit{\textbf{Prof.~\@coSupervisor}}}
					\end{spacing}
		\end{center}
	\end{textblock}

	\begin{textblock}{.75}[0,0](.16,0.76) 
		\begin{center}
			\noindent
			\includegraphics[height=25mm]{Chap00/NITlogo}\\
			\normalsize {\@setMonth, \@setYear}
		\end{center}
		\begin{center}
			{\linespread{1}
			\large {\@department}\\
			\Large {\bf\@nitr}
			}
		\end{center}
	\end{textblock}
	\begin{center}
	\end{center}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\certificateOfExamination{%
	\addcontentsline{toc}{chapter}{Certificate of Examination}
	\thispagestyle{empty}
	\begin{textblock}{.3}[0,0](0.16,0.05) 
		\hspace*{-10mm}
		\includegraphics[height=25mm]{Chap00/NITlogo}
	\end{textblock}
	\begin{textblock}{.7}[0,0](0.24,0.099) 
	\begin{minipage}{.9\linewidth}
		{\linespread{1}
			\large{\@department}\\ 
			\Large{\textbf{\@nitr}}
		}
	\end{minipage}
	\end{textblock}
	\begin{textblock}{1}[0,0](0.1,0.14) 
	\rule{.74\textwidth}{2pt}
	\end{textblock}
	\begin{center}
	\end{center}
	\begin{center}
	\end{center}
	\begin{flushright}
	\@setMonth~\@setDate,~\@setYear
	\end{flushright}
	\begin{center}
		\Large{\bf Certificate of Examination}
	\end{center}
	\noindent Roll Number: {\textit{\@rollNumber}}\\
	Name: {\textit{\@author}}\\
	Title of Dissertation: {\textit{\@docTitle}}\\

	\noindent We the below signed, after checking the
	\ifthenelse{\@docType=1}{dissertation}
		{\ifthenelse{\@docType=2}{thesis}
			{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	mentioned above and the official record book~(s) of the student, hereby state our approval of the
	\ifthenelse{\@docType=1}{dissertation}
		{\ifthenelse{\@docType=2}{thesis}
			{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	submitted in partial fulfillment of the requirements of the degree of \textit{\@degree} in \textit{\@degreeIn} at \textit{\@nitr}. We are satisfied with the volume, quality, correctness, and originality of the work.
	
	\vspace*{15mm}
	\ifthenelse{\@numOfSupervisors = 2}
	{
	\linespread{1}
	\begin{table}[h!]
	\centering
	\begin{tabular}{C{1mm}C{56mm}C{16mm}C{56mm}C{1mm}}
	\cline{2-2} \cline{4-4}
	&\@coSupervisor && \@principalSupervisor&\\
	& {\small Co-Supervisor} && {\small Principal Supervisor} &\\
	&&&&\\
	&&&&\\
	&&&&\\
	\cline{2-2} \cline{4-4}
	&\@firstMemberDSC && \@secondMemberDSC&\\
	&{\small Member, DSC}&& {\small Member, DSC}&\\
	&&&&\\
	&&&&\\
	&&&&\\
	\cline{2-2} \cline{4-4}
	& \@thirdMemberDSC && \@externalExaminer &\\
	&{\small Member, DSC}&& {\small External Examiner}&\\
	&&&&\\
	&&&&\\
	&&&&\\
	\cline{2-2} \cline{4-4}
	& \@chairperson && \@hod &\\
	& {\small Chairperson, DSC}&& {\small Head of the Department}&
	\end{tabular}
	\end{table}
	}
	{
	\linespread{1}
	\begin{table}[h!]
	\centering
	\begin{tabular}{C{1mm}C{16mm}C{16mm}C{16mm}C{16mm}C{16mm}C{16mm}C{16mm}C{1mm}}
	\cline{2-4} \cline{6-8}
	& \multicolumn{3}{c}{\@principalSupervisor} &&  \multicolumn{3}{c}{\@firstMemberDSC} &\\
	& \multicolumn{3}{c}{\small Principal Supervisor} && \multicolumn{3}{c}{\small Member, DSC} &\\
	&&&&&&&& \\
	&&&&&&&&\\
	&&&&&&&&\\
	\cline{2-4} \cline{6-8}
	& \multicolumn{3}{c}{\@secondMemberDSC} && \multicolumn{3}{c}{\@thirdMemberDSC} &\\
	& \multicolumn{3}{c}{\small Member, DSC} && \multicolumn{3}{c}{\small Member, DSC}&\\
	&&&&&&&&\\
	&&&&&&&&\\
	&&&&&&&&\\
	\cline{2-4} \cline{6-8}
	& \multicolumn{3}{c}{\@externalExaminer} && \multicolumn{3}{c}{\@chairperson} &\\
	& \multicolumn{3}{c}{\small External Examiner} && \multicolumn{3}{c}{\small Chairperson, DSC}&\\
	&&&&&&&&\\
	&&&&&&&&\\
	&&&&&&&&\\
	\cline{4-6}
	&&& \multicolumn{3}{c}{\@hod} &&&\\
	&&& \multicolumn{3}{c}{\small Head of the Department}&&&
	\end{tabular}
	\end{table}
	}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\certificateOneSupervisor{%
	\addcontentsline{toc}{chapter}{Supervisor's Certificate}
	\thispagestyle{empty}
	\begin{textblock}{.3}[0,0](0.16,0.05) 
		\hspace*{-10mm}
		\includegraphics[height=25mm]{Chap00/NITlogo}
	\end{textblock}
	\begin{textblock}{.7}[0,0](0.24,0.099) 
	\begin{minipage}{.9\linewidth}
		{\linespread{1}
			\large{\@department}\\ 
			\Large{\textbf{\@nitr}}
		}
	\end{minipage}
	\end{textblock}
	\begin{textblock}{1}[0,0](0.1,0.14) 
	\rule{.74\textwidth}{2pt}
	\end{textblock}
	\begin{center}
	\end{center}
	\begin{center}
	\end{center}
	{
	\linespread{1}
	\begin{table}[h!]
		\begin{tabular}{l}
			\textbf{Prof.~\@principalSupervisor}\\
			\small{\@principalSupervisorDesignation}
		\end{tabular}
	\end{table}
	}
	\begin{flushright}
		\@setMonth~\@setDate,~\@setYear
	\end{flushright}
	\vspace{25mm}
	\begin{center}
		\Large{\bf Supervisor's Certificate}
	\end{center}
	\vspace{1cm}
	\noindent This is to certify that the work presented in the
		\ifthenelse{\@docType=1}{dissertation}
			{\ifthenelse{\@docType=2}{thesis}
				{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	entitled {\it\@docTitle} submitted by {\it\@author}, Roll Number~\@rollNumber, is a record of original research carried out by \ifthenelse{\equal{\@authorGender}{male}}{him}{\ifthenelse{\equal{\@authorGender}{female}}{her}{E R R O R}} under my supervision and guidance in partial fulfillment of the requirements of the degree of \textit{\@degree} in \textit{\@degreeIn}. Neither this
	\ifthenelse{\@docType=1}{dissertation}
		{\ifthenelse{\@docType=2}{thesis}
			{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	nor any part of it has been submitted earlier for any degree or diploma to any institute or university in India or abroad.
	\vspace*{0.5in}
	{
	\linespread{1}
	\begin{table}[h!]
	\centering
		\begin{tabular}{C{1mm}C{56mm}C{16mm}C{1mm}C{56mm}}
			\cline{5-5}
			&&&&\@principalSupervisor
		\end{tabular}
	\end{table}
	}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\certificateTwoSupervisors{%
	\addcontentsline{toc}{chapter}{Supervisors' Certificate}
	\thispagestyle{empty}
	\begin{textblock}{.3}[0,0](0.16,0.05) 
		\hspace*{-10mm}
		\includegraphics[height=25mm]{Chap00/NITlogo}
	\end{textblock}
	\begin{textblock}{.7}[0,0](0.24,0.099) 
	\begin{minipage}{.9\linewidth}
		{\linespread{1}
			\large{\@department}\\ 
			\Large{\textbf{\@nitr}}
		}
	\end{minipage}
	\end{textblock}
	\begin{textblock}{1}[0,0](0.1,0.14) 
	\rule{.74\textwidth}{2pt}
	\end{textblock}
	\begin{center}
	\end{center}
	\begin{center}
	\end{center}
	{
	\linespread{1}
	\begin{table}[h!]
		\begin{tabular}{l}
			\textbf{Prof.~\@principalSupervisor}\\
			\small{\@principalSupervisorDesignation}\\
			\\
			\textbf{Prof.~\@coSupervisor}\\
			\small{\@coSupervisorDesignation}
		\end{tabular}
	\end{table}
	}
	\begin{flushright}
		\@setMonth~\@setDate,~\@setYear
	\end{flushright}
	\vspace{5mm}
	\begin{center}
		\Large{\bf Supervisors' Certificate}
	\end{center}
	\vspace{1cm}
	\noindent This is to certify that the work presented in the
	\ifthenelse{\@docType=1}{dissertation}
		{\ifthenelse{\@docType=2}{thesis}
			{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	entitled {\it\@docTitle} submitted by {\it\@author}, Roll Number~\@rollNumber, is a record of original research carried out by \ifthenelse{\equal{\@authorGender}{male}}{him}{\ifthenelse{\equal{\@authorGender}{female}}{her}{E R R O R}} under our supervision and guidance in partial fulfillment of the requirements of the degree of \textit{\@degree} in \textit{\@degreeIn}. Neither this 
	\ifthenelse{\@docType=1}{dissertation}
		{\ifthenelse{\@docType=2}{thesis}
			{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	nor any part of it has been submitted earlier for any degree or diploma to any institute or university in India or abroad.
	\vspace*{0.5in}
	{
	\linespread{1}
	\begin{table}[h!]
	\centering
		\begin{tabular}{C{1mm}C{56mm}C{16mm}C{56mm}C{1mm}}
			\cline{2-2}\cline{4-4}
			&\@coSupervisor&&\@principalSupervisor&\\
			&{\small \@coSupervisorDesignation}&&{\small \@principalSupervisorDesignation}&
		\end{tabular}
	\end{table}
	}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\dedication{%
	\input{Chap00/Dedication}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\declaration{%
	\thispagestyle{empty} 
	\SpecialTitle{Declaration of Originality}
	\par\noindent I, \textit{\@author}, Roll Number \textit{\@rollNumber} hereby declare that this
		\ifthenelse{\@docType=1}{dissertation}
			{\ifthenelse{\@docType=2}{thesis}
				{\ifthenelse{\@docType=3}{project report}{E R R O R}}}
	entitled \textit{\@docTitle} presents my original work carried out as a {\@studentType} student of NIT Rourkela and, to the best of my knowledge, contains no material previously published or written by another person, nor any material presented by me for the award of any degree or diploma of NIT Rourkela or any other institution. Any contribution made to this research by others, with whom I have worked at NIT Rourkela or elsewhere, is explicitly acknowledged in the dissertation. Works of other authors cited in this dissertation have been duly acknowledged under the sections ``Reference'' or ``Bibliography''. I have also submitted my original research records to the scrutiny committee for evaluation of my dissertation.
	\vspace{5mm}
	\par I am fully aware that in case of any non-compliance detected in future, the Senate of NIT Rourkela may withdraw the degree awarded to me on the basis of the present dissertation.
	
	\vspace{15mm}
	{
	\linespread{1}
	\begin{minipage}{.45\textwidth}
		\begin{flushleft}
			\@setMonth~\@setDate,~\@setYear\\
			NIT Rourkela
		\end{flushleft}
	\end{minipage}
	\begin{minipage}{.45\textwidth}
		\begin{flushright}
			\textit{\@author}
		\end{flushright}
	\end{minipage}
	}
	\thispagestyle{empty} 
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\acknowledgment{%
	\input{Chap00/Acknowledge}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
\def\abstract{%
	\input{Chap00/Abstract}
	\thispagestyle{empty}
	\cleardoublepage
}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% INDEX PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{imakeidx}
\makeindex[columns=\@indexColumns, title=Index, intoc]
\def\indexPage{%
	{\fontsize{11}{10}
	\selectfont
	\printindex
	}
	\thispagestyle{empty}
	\cleardoublepage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% SET FONT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fontspec}
\def\setFont{
\ifthenelse{\@Font=2}
{\setmainfont[Renderer=Basic,Ligatures=TeX]{Arial}}
{\setmainfont[Renderer=Basic,Ligatures=TeX]{Times New Roman}}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% SYNOPSIS COVER PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\coverPageSynReg{%
\renewcommand\thesection{\arabic{section}}
%\renewcommand\thesubsection{\thesection.\arabic{subsection}}
	\thispagestyle{empty}
	\begin{tabular}{l}
	\end{tabular}
	\begin{textblock}{\@titleWidth}[0,0](0.16,0.12) 
		\begin{flushleft}
			\begin{spacing}{2}
				{\huge {\textbf{\@docTitle}}} 
			\end{spacing}
		\end{flushleft}
% %		(Version 4.4) % comment this line
	\end{textblock}
	\begin{textblock}{.75}[0,0](0.16,0.22) 
%		\begin{flushleft}
					\begin{spacing}{1.8}
						{\textit{
						\ifthenelse{\@docType=4}
						{
							\ifthenelse{\@docType=4 \and \equal{\@degree}{Doctor of Philosophy}}
							{
								\begin{flushleft}Synopsis of Ph.D. Dissertation\end{flushleft}
							}
							{
								\ifthenelse{\@docType=4 \and \equal{\@degree}{Master of Arts}}
								{
									\begin{flushleft}Synopsis of M.A. Thesis\end{flushleft}
								}
								{
									\ifthenelse{\@docType=4 \and \equal{\@degree}{Master of Technology}}
									{
										\begin{flushleft}Synopsis of M.Tech. Thesis\end{flushleft}
									}
									{
										\ifthenelse{\@docType=4 \and \equal{\@degree}{Bachelor of Technology}}
										{
											\begin{flushleft}Synopsis of B.Tech. Project Report\end{flushleft}
										}
										{
											\ifthenelse{\@docType=4 \and \equal{\@degree}{Master of Business Administration}}
											{
												\begin{flushleft}Synopsis of MBA Thesis\end{flushleft}
											}
											{
												\begin{flushleft}E R R O R\end{flushleft}
											}
										}
									}								
								}
							}
						}
						{
						\ifthenelse{\@docType=5}
						{
							\ifthenelse{\@docType=5 \and \equal{\@degree}{Doctor of Philosophy}}
							{
								\begin{flushleft}Ph.D. Registration Report\end{flushleft}
							}
							{
								\ifthenelse{\@docType=5 \and \equal{\@degree}{Master of Technology}}
								{
									\begin{flushleft}M.Tech. Registration Report\end{flushleft}
								}
								{
									\begin{flushleft}E R R O R\end{flushleft}
								}
							}
						}
						{}
						}
						}}
					\end{spacing}
	\end{textblock}
	\begin{textblock}{.75}[0,0](0.16,0.4) 
		\noindent
		{\normalsize {\textbf{\@author}}}\\
		{\footnotesize{(Roll Number \@rollNumber)}}
		\vskip 15pt
		\noindent{\textit{under the supervision of}}\\
		{\textbf{Prof.~\@principalSupervisor}}
		\ifthenelse{\@numOfSupervisors = 1}{}{\\\textit{and}\\}
		\ifthenelse{\@numOfSupervisors = 1}{}{\textbf{Prof.~\@coSupervisor}}
	\end{textblock}
	\begin{textblock}{.3}[0,0](0.16,0.82) 
		\hspace*{-.6cm}\includegraphics[height=25mm]{Chap00/NITlogo}
	\end{textblock}
	\begin{textblock}{.7}[0,0](0.25,0.867) 
		%\hspace{1mm}
		\begin{minipage}{.9\linewidth}
			{\linespread{1}
			\large {\@department}\\
			\Large {\bf\@nitr}
			}
		\end{minipage}
	\end{textblock}
	\thispagestyle{empty}
	\cleardoublepage
	\textheight 247mm % Space for text.
	\textwidth 160mm  % Width of text.
	\footskip 10mm    % Distance from baseline of box containing foot to baseline of last line of text.
	\oddsidemargin 0mm
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
%%
%% End of file `NITR.cls'.
