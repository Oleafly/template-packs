%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Unofficial Latex class for a thesis 
%% Department of Mechanical and System Engineering,
%% Kyoto Institute of Technology
%%
%% by Motoaki Hiraga (ver.1.0, Oct. 22nd, 2024)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kit_mech_thesis}
[2024/10/22 v1.0 Unofficial Latex class for a thesis at KIT]

% 英語化オプション "english" が渡されたか判定するためのフラグ
\newif\ifenglishoption
\DeclareOption{english}{\englishoptiontrue}

% クラスのオプションを取得し，bxjsarticleに渡す
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bxjsarticle}}
\ProcessOptions\relax
\LoadClass[ja=standard,a4paper,base=11pt,jbase=11pt,nomag*]{bxjsarticle}

% LaTeX コンパイラを判別するためのパッケージ
% \RequirePackage{iftex} % BXJSクラスで読み込んでいるので不要．
\ifpTeX
    % platex の設定
    \RequirePackage{plautopatch} % pLaTeX/upLaTeX 間のパッケージの競合を防ぐパッケージ
    \RequirePackage[dvipdfmx,hiresbb]{graphicx}
    \RequirePackage[dvipdfmx,hidelinks]{hyperref}
\else
    \ifupTeX
        % uplatex の設定
        \RequirePackage{plautopatch} % pLaTeX/upLaTeX 間のパッケージの競合を防ぐパッケージ
        \RequirePackage[dvipdfmx,hiresbb]{graphicx}
        \RequirePackage[dvipdfmx,hidelinks]{hyperref}
    \else
        % 他のLaTeX設定（DVIを経由しない）
        \RequirePackage{graphicx}
        \RequirePackage[hidelinks]{hyperref}
    \fi
\fi

% 余白の設定（上 25 mm, 下 20 mm, 左 30 mm, 右 10 mm, ヘッダを使用しない）
\setpagelayout{nohead,top=25truemm,left=30truemm,textwidth=\paperwidth-40truemm,textheight=\paperheight-45truemm}

% 行間隔の設定（18ポイント）
\AtBeginDocument{\setlength{\baselineskip}{18truept}}

% 英語化オプション "english" が渡されたときの処理
\ifenglishoption
    % "参考文献" を "References"に変更
    \renewcommand{\refname}{References}
    % 付録を "A" から "Appendix A" に変更
    \renewcommand{\appendixname}{Appendix~}
    % 付録の表記 \appendixname の幅を取得し，\appendixnamewidth として定義
    \newlength{\appendixnamewidth}
    \settowidth{\appendixnamewidth}{\appendixname}
\else
    \newlength{\appendixnamewidth}
    \settowidth{\appendixnamewidth}{2em} % "付録" の2文字分の幅
\fi

% 目次を調整するためのパッケージ
\RequirePackage{tocloft}

% 目次の設定
\setcounter{tocdepth}{3}    % subsubsection までを目次に表示
\renewcommand{\cftsecfont}{\bfseries\sffamily}  % section を太字ゴシック体
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}    % section からページ数まで点で繋ぐ
\renewcommand{\cftsecdotsep}{\cftdotsep}
\setlength{\cftsecnumwidth}{2.4em}  % 章の番号から見出しまでのスペースを設定
\setlength{\cftsubsecnumwidth}{\cftsecnumwidth} % subsection の numwidth を section と揃える
\setlength{\cftsubsecindent}{\cftsecindent} % subsection の indent を section と揃える
\setlength{\cftsubsubsecindent}{2.4em}  % subsubsection の indent を設定
\renewcommand{\cftsecaftersnum}{.}  % 目次の章番号の後に点を追加

% 章の数字の後に点 "." を追加 ("1. ", "2. ", "3. ")
\newcommand{\adddot@section}{.}
\makeatletter
\renewcommand*{\@seccntformat}[1]{%
    \csname the#1\endcsname
    \csname adddot@#1\endcsname\quad
}
\makeatother

% 章・節・項の番号と見出しを太字ゴシック体に変更
\RequirePackage[bf,sf]{titlesec}

% ページ番号などの通し番号の処理のため \frontmatter, \mainmatter, \backmatter を定義
\newcommand{\frontmatter}{%
    \pagestyle{empty}       % ページ番号を非表示
}%
\newcommand{\mainmatter}{%
    \pagestyle{plain}       % ページ番号を表示
    \setcounter{page}{1}    % ページ番号をリセット
    \pagenumbering{arabic}  % アラビア数字のページ番号を出力
    \setcounter{section}{0} % 章の通し番号をリセット
}%
\newcommand{\backmatter}{%
    \setcounter{section}{0} % 章の通し番号をリセット
    \setcounter{figure}{0}  % 図の通し番号をリセット
    \setcounter{table}{0}   % 表のの通し番号をリセット

    % 目次中の付録番号と見出しの間のスペースを調整
    \addtocontents{toc}{\protect\setlength{\cftsecnumwidth}{\the\appendixnamewidth+2.4em}}
}%

% 目次のページ番号を除去（\frontmatterの\pagestyle{empty}をなぜかスルーしたため）
\addtocontents{toc}{\protect\thispagestyle{empty}}

% タイトルページ番号をRomanに，その後romanに変更（PDFビューアのページ番号のための処理）
\newcommand{\titlepagestyle}{
    \pagestyle{empty}
    \pagenumbering{Roman}
}
\newcommand{\cleartitlepagestyle}{
    \clearpage
    \pagenumbering{roman}
}

% 参考文献の引用スタイルを [#] から ^{(#)} に変更
\RequirePackage[numbers,round,super,sort]{natbib}
\bibpunct{(}{)}{),\,(}{s}{}{,} % 複数引用時の区切りの変更

% 参考文献のフォーマットを [#] から (#) に変更
\makeatletter
% \renewcommand\@biblabel[1]{(#1)}
\renewcommand\@biblabel[1]{(#1)\hfill}
\makeatother

% キャプションの設定
\RequirePackage[style=base,format=hang,labelsep=space,font=sf]{caption}
\renewcommand{\figurename}{Fig.~} % 図を Fig. に変更
\renewcommand{\tablename}{Table~} % 表を Table に変更
\RequirePackage[labelformat=simple,subrefformat=simple]{subcaption}
\renewcommand\thesubfigure{(\alph{subfigure})} % 図を並べたときの番号を (a), (b), ... に変更

% 章の見出しより前にフロート環境が入らないようにする
\RequirePackage[section]{placeins}

% 脚注がページ下部に入るようにする
\RequirePackage[bottom]{footmisc}

% 卒論・修論の判別に使用
\RequirePackage{ifthen}

% 文字に輪郭を追加することで太字明朝体を実装
\RequirePackage{contour}
\contourlength{0.25pt}

% 卒論・修論の判別不能時のエラー文
\newcommand{\ThesisTypeError}{ERROR: Unknown thesis type}

