\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hanyang-thesis}[2025/10/27 Hanyang University Thesis Class]

% Pass options to the base class (article)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Packages from package.tex
\RequirePackage[utf8]{inputenc}
\RequirePackage{kotex}
\RequirePackage{geometry}
\RequirePackage{lipsum}
\RequirePackage{setspace}
\RequirePackage{sectsty}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\RequirePackage{pdfpages}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{caption}
\RequirePackage{abstract}

% Settings from main.tex preamble

% 1. 학위논문 작성요령
% - 용지여백 : 위 ∙ 아래 여백 38mm,    머리말 ∙ 꼬리말 15mm,    좌 ∙ 우 여백 35mm
\geometry{ top=38mm, bottom=38mm, left=35mm, right=35mm}
% - 줄 간 격 : 160% ~ 200%
\doublespacing
% - 글씨체 및 크기
% * 큰 제 목 - 16point (명조, 신명조, 바탕체, 굴림체 중 사용), 진하게
\sectionfont{\fontsize{16}{19}\selectfont}
\renewcommand{\abstractnamefont}{\normalfont\bfseries\fontsize{16}{19}\selectfont}
% * 중간제목 - 13point (명조, 신명조, 바탕체, 굴림체 중 사용), 진하게
\subsectionfont{\fontsize{13}{16}\selectfont}

% 표와 그림 접두사를 한글로
\renewcommand{\figurename}{그림}
\renewcommand{\tablename}{표}
\captionsetup{labelsep=period}

% 양식 4) 차례 양식
\renewcommand{\contentsname}{\hspace*{\fill}차례\hspace*{\fill}}
\renewcommand{\listfigurename}{\hspace*{\fill}그림 차례\hspace*{\fill}}
\renewcommand{\listtablename}{\hspace*{\fill}표 차례\hspace*{\fill}}
\titleformat{\section}[block]{\normalfont\Large\bfseries\filcenter}{제\thesection장}{1em}{}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{제\arabic{subsection}절}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecfont}{\bfseries}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftsecpresnum}{제}
\renewcommand{\cftsecaftersnum}{장}
\renewcommand{\cftsecnumwidth}{4em}
\renewcommand{\cftsecindent}{1.5em}
\renewcommand{\cftsubsecnumwidth}{4em}
\renewcommand{\cftsubsecindent}{2.5em}

% 양식 5) 국문 요지
\renewcommand{\abstractname}{}


% 참고 자료
\renewcommand{\refname}{\centering 참고문헌}

\endinput
