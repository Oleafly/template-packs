%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
%   LaTeX File for B.D thesis of Fujian Normal University               %
%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
%   Copyright 2024  by  Huang Bingyuan    (bingyuango@gmail.com)        %
%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -*- coding=utf-8 -*-

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{FJNUthesis}[2024/03/29 v1.0 Standard LaTeX documentclass]
\LoadClass[a4paper,UTF8,openany,oneside,12pt,AutoFakeBold]{ctexart}

% 检查是否由xelatex编译
\RequirePackage{ifxetex}
\ifxetex 
\else
\ClassError{FJNUthesis}{You must have to use the 'xelatex' \MessageBreak Please choose `xelatex'}{%
	Only choose `xelatex', no `pdflatex' or `latex' and so on.}
\fi


% 页面设置：版心为297×210mm
% 页边距要求：每一面的上方（T）2 cm，下方（B）2cm，左（L）2.0 cm，右（R）2cm，装订线（T）0.5 cm
% 装订线位置（T）左，页脚1cm，页眉1cm 

\RequirePackage{geometry}
\geometry{
	total={297mm,210mm},
	left=2.0cm, right=2.0cm,
	top=2cm, bottom=2cm,
	bindingoffset=0.5cm,
}

% 字体设置
\RequirePackage{xeCJK}
% 论文标题字体：小二号(18pt)黑体，加粗，居中 \fontsize{18pt}{22pt}\heiti{}
% 学院、专业、学号、作者姓名、指导教师姓名、（小四号楷体 12pt，加粗），依次排印在论文题目下（上空一行，居中）  \textbf{\fontsize{12pt}{15pt}\kaishu{}
% 摘要：小五号黑体，加粗
% \textbf{\fontsize{9pt}{12pt}\heiti{}}
% 摘要内容：小五号楷体，加粗
% \textbf{\fontsize{9pt}{12pt}\kaishu{}}
% byd没说明摘要页格式，标题要怎么排
\CTEXsetup[format={\Large\bfseries}]{section}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\lfoot{}

% 封面
\RequirePackage{enumerate}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{tabularx}
\RequirePackage{ctex}
\newcommand{\makeCover}{
	% 封面页无字号
	\thispagestyle{empty}
	% 学校logo
	\begin{figure}[H]
		\centering
		\includegraphics[width=3.2cm, height=3.2cm]{pics/logo}
		\\
		\includegraphics[width=8.27cm]{pics/Fujian Normal University}
	\end{figure}
	\leavevmode \\
	% 论文信息
	\begin{center}
		{\textbf{\fontsize{18pt}{22pt}\heiti{福建师范大学 \\ {\large \kaishu{\nowYear}}  届本科毕业论文}}} 
		\\[3em]
		{
			\textbf{\fontsize{12pt}{15pt}
			\kaishu{
				\begin{tabularx}{0.5\textwidth}{X c}
					\rule{0pt}{16pt}
					学~~~~~~~~院 & \college \\
					\cline{2-2} 
					\rule{0pt}{16pt}
					专~~~~~~~~业 & \major \\
					\cline{2-2} 
					\rule{0pt}{16pt}
					学~~~~~~~~号 & \serialnumber \\
					\cline{2-2} 
					\rule{0pt}{16pt}
					姓~~~~~~~~名 & \yourName \\ 
					\cline{2-2} 
					\rule{0pt}{16pt}
					指~导~老~师 & \teacher \\
					\cline{2-2} 
				\end{tabularx}
				}
			}
		}
	\end{center}
}

\RequirePackage{indentfirst} 
\newcommand{\myAbstract}{
	% 摘要页编号为1，目录页编号为2
	\setcounter{page}{1}
	% 标题小二号黑体，加粗,居中
	\begin{center}
		{\textbf{\fontsize{18pt}{22pt}\heiti{\yourTitle}}} 
		\\[2em]
		{
			\kaishu
			\fontsize{12pt}{14pt}
			\college ~~~ \major 
			\\
			\serialnumber ~~~ \yourName ~~~指导老师：\teacher
		}
	\end{center}
	% 设置首行缩进
	\setlength{\parindent}{2em}
	\textbf{\fontsize{10pt}{12pt}\heiti{【摘要】}} \textbf{\fontsize{11pt}{12pt}\kaishu{\yourAbstract}}
	\\
	\textbf{\fontsize{10pt}{12pt}\heiti{【关键字】}} \textbf{\fontsize{11pt}{12pt}\kaishu{\keyword}}
}

\RequirePackage{fontspec}
\newcommand{\eAbstract}{
	\fancypagestyle{plain}{
		\fancyhead{} % 页眉清空
		\fancyfoot{} % 页脚清空
	}
	\pagestyle{plain}
	\newpage
	\setmainfont{Times New Roman}
	\begin{center}
		{
			\textbf{\large{\eTitle}}} 
			\\[2em]
			\textbf{
				\fontsize{12pt}{14pt}
				\eCollege ~~~ \eMajor 
				\\
			\serialnumber ~~~ \eName ~~~Advisior: \eTeacher
		}
	\end{center}
	
	\setlength{\parindent}{0em}
	\textbf{\fontsize{10pt}{12pt}【Abstract】}
	\textbf{\fontsize{10pt}{12pt} \myEAbstract}
	\\
	\textbf{\fontsize{10pt}{12pt}【keywords】}
	\textbf{\fontsize{10pt}{12pt} \eKeyword}
}

% 公式

\RequirePackage{amsmath}

% 算法（伪代码）

\RequirePackage{algorithm}
\RequirePackage{algorithmic}

% 代码

\RequirePackage{listings}

% 表格

\RequirePackage{makecell}
\RequirePackage{longtable}

% 章节编号控制

\RequirePackage{hyperref}
\RequirePackage{bookmark}
\RequirePackage{tocbibind}
\hypersetup{
	colorlinks=true,
	linkcolor=black
}
