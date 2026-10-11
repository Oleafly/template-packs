\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my_bthesis}[2025/12/27 Oita Univ Thesis Class]


% pdfLaTeX用に標準reportクラスを基底にする
\LoadClass[12pt]{report}

% --- 1. 大学指定の余白設定 (左30, 右20, 上25, 下30) ---
% ドライバはエンジン別に指定
\RequirePackage{iftex}
\ifPDFTeX
  % pdfLaTeX
  \RequirePackage[left=30mm, right=20mm, top=25mm, bottom=30mm]{geometry}
\else
  \ifLuaTeX
    % LuaLaTeX（ドライバ指定なしでPDF出力）
    \RequirePackage[left=30mm, right=20mm, top=25mm, bottom=30mm]{geometry}
  \else
    % pLaTeX/uplatex（dvipdfmx経由）
    \RequirePackage[dvipdfmx, left=30mm, right=20mm, top=25mm, bottom=30mm]{geometry}
  \fi
\fi

% --- 2. パッケージ  ---
% platex/uplatex で zxjafont が自動ロードされても XeTeX 強制を抑止
\makeatletter
\@namedef{ver@zxjafont.sty}{avoided}
\makeatother

\ifPDFTeX
  \RequirePackage{graphicx}
\else
  \ifLuaTeX
    \RequirePackage{graphicx}
  \else
    % pTeX/uplatex系: dvipdfmx を明示して BoundingBox エラーを回避
    \RequirePackage[dvipdfmx]{graphicx}
  \fi
\fi
\RequirePackage{amsmath, amssymb}
\RequirePackage{cite}
\RequirePackage{setspace}
\RequirePackage{enumitem}
\ifPDFTeX
  \RequirePackage[hidelinks]{hyperref}
\else
  \ifLuaTeX
    \RequirePackage[hidelinks]{hyperref}
  \else
    \RequirePackage[dvipdfmx,hidelinks]{hyperref}
    \RequirePackage{pxjahyper} % 和文しおりを正しく扱う
  \fi
\fi
\renewcommand{\bibname}{参考文献}

% エンジン判定：pTeX系なら \zw が既に定義済み。なければ簡易定義。
\ifdefined\zw
  % 既定の \zw を利用
\else
  \newlength\zw
  \setlength\zw{1em}
\fi


% --- 3. 大学指定の「30文字/行、30行/ページ」の設定 ---
\setstretch{1.7} % 30行/ページにするための行間調整
% pLaTeX固有の和文パラメータは使用しない（pdfLaTeX向け簡易設定）

% --- 4. 表紙 ---
\makeatletter
\newcommand{\etitle}[1]{\def\@etitle{#1}} % 英語タイトル用のコマンドを定義
\renewcommand{\maketitle}{
  \begin{titlepage}
    \begin{center}
      % --- 上部：論文の種類 ---
      \vspace*{10mm}
      {\Large 学士論文 \par}
      
      % --- 中央：題目（ここがページの上寄りに配置されます） ---
      \vspace*{20mm}
      {\Large \@title \par}

      \vspace*{5mm}
      {\large \@etitle \par}
      
      % --- 空白調整（ここから下の項目をページ下部へ押し下げる） ---
      \vfill 
      
      % --- 下部：所属・氏名・指導教員（ここにまとまります） ---
      {\large 大規模ネットワークサイエンス研究室 \par}
      
      \vspace*{1mm}
      {\large \@author \par}
      
      \vspace*{1mm}
      {\large 指導教員 大知 正直 准教授 \par}

      \vspace*{1mm}
      {\large \@date \par}

      % --- 所属 ---
      {\large 大分大学 理工学部 共創理工学科 知能情報システムコース \par}
      
      \vspace*{15mm} % ページの一番下からの距離
    \end{center}
  \end{titlepage}
}
\makeatother
\pagestyle{plain}


% --- 5. 目次のカスタマイズ ---
\RequirePackage{tocloft}

% 「目次」という見出しを左寄せ・大きく・太字にする
\renewcommand{\contentsname}{\huge \textbf{目 次}} % サイズを \huge に変更
\renewcommand{\listfigurename}{\huge \textbf{図 目 次}} % 図目次の見出し
\renewcommand{\listtablename}{\huge \textbf{表 目 次}}  % 表目次の見出し
\renewcommand{\cftaftertoctitle}{} % 後ろの \hfill を消して左寄せにする
\renewcommand{\cftafterloftitle}{}
\renewcommand{\cftafterlottitle}{}
\setlength{\cftaftertoctitleskip}{20pt} % 見出しと中身の間の余白を調整
\setlength{\cftafterloftitleskip}{20pt}
\setlength{\cftafterlottitleskip}{20pt}

% 章（Chapter）の前に「第」、後に「章」を付ける
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % 章にもドット線を引く
\renewcommand{\cftfigleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttableader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchappresnum}{}
\renewcommand{\cftchapaftersnum}{}
\setlength{\cftchapnumwidth}{4em} % 「第X章」の幅を確保

% 章のフォントを太字にする（画像に合わせる）
\renewcommand{\cftchapfont}{\normalfont\bfseries}
\renewcommand{\cftchappagefont}{\normalfont\bfseries}

% --- 6. 章見出し（Chapter）のレイアウト変更 ---
\RequirePackage{titlesec}

% 「第1章」と「タイトル」を1行に並べる設定
\titleformat{\chapter}[hang]
  {\huge\bfseries} % フォントの設定
  {第\thechapter 章\hspace{1em}} % 「第」と「章」を直接書き込みます
  {0pt}
  {}

% 章見出し前後の余白調整（お好みに合わせて）
\titlespacing{\chapter}{0pt}{0pt}{20pt}


% --- 7. レイアウト計算用の内部命令 ---
\makeatletter
% 文字数指定（日本語n文字 ＝ 英語2n文字 分の幅に調整）
\def\mojiparline#1{
    \@tempdima=\linewidth
    \advance\@tempdima by -#1\zw
    \divide\@tempdima by #1
    \ifdefined\kanjiskip
      % 和文間隔に微小な伸縮性を持たせ右端を揃えやすくする
      \advance\@tempdima by 0.25pt
      \kanjiskip=\@tempdima plus 0.25pt minus 0.15pt
      \xkanjiskip=0pt plus 0.1pt minus 0.05pt
    \fi
    \setlength{\parindent}{1\zw}
}

% 行数指定
\def\linesparpage#1{
    \@tempdima=\textheight
    \divide\@tempdima by #1
    \baselineskip=\@tempdima
}
\makeatother

% --- 8. 要旨・Abstract用 (和40/英80文字, 45行) ---
\newcommand{\startabstractpage}{
  \clearpage
  % 45行入れるために上下の余白を少し調整
  \newgeometry{left=30mm, right=20mm, top=20mm, bottom=25mm, footskip=10mm}
  \selectfont
  \mojiparline{40}  % 和文40字 = 英文80字
  \linesparpage{45} % 45行
}

% --- 9. 本文用 (30文字, 30行) ---
\newcommand{\startmaintext}{
  \clearpage
  % 大学指定の標準余白を再適用
  \newgeometry{left=30mm, right=20mm, top=25mm, bottom=30mm, footskip=10mm}
  \selectfont
  \mojiparline{30}  % 30文字
  \linesparpage{30} % 30行
}