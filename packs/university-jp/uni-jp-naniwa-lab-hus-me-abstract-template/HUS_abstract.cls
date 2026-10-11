%%====================================================================
%% HUS_abstract.cls
%% 北海道科学大学 機械工学科 卒業論文 梗概用クラス
%%
%% Based on jsmepaper.cls (JSME)
%% This class is NOT an official JSME template.
%%
%% ver 0.3  2025-12-15
%%   - 1ページ目のトップに図が出ないよう制御
%%   - keywords 再定義エラー回避
%%====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HUS_abstract}[2025/12/15 HUS Bachelor Thesis Abstract v0.3]

%--------------------------------------------------------------------
% ベースクラス（JSME）
%--------------------------------------------------------------------
\LoadClass[a4jsme,fleqn]{jsmepaper}

%--------------------------------------------------------------------
% 1ページ目トップへの図の侵入を禁止
%--------------------------------------------------------------------
\AtBeginDocument{%
  \setcounter{topnumber}{0}%
}

%--------------------------------------------------------------------
% ページスタイル
%--------------------------------------------------------------------
\pagestyle{empty}
\thispagestyle{empty}

%--------------------------------------------------------------------
% 必要パッケージ
%--------------------------------------------------------------------

\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}

%--------------------------------------------------------------------
% 図キャプション表記を「図 <番号>」に変更（jsmepaper対策）
%--------------------------------------------------------------------
\AtBeginDocument{%
  \renewcommand{\figurename}{図}%
}
%--------------------------------------------------------------------
% jsmepaper.cls 対策：図番号表記を強制上書き
%--------------------------------------------------------------------
\AtBeginDocument{%
  \makeatletter
  \def\fnum@figure{図~\thefigure}%
  \makeatother
}

%--------------------------------------------------------------------
% セクション番号体裁
%   1. 緒言
%   2・1 実験方法
%--------------------------------------------------------------------
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{%
  \arabic{section}\textperiodcentered\arabic{subsection}
}
\renewcommand{\thesubsubsection}{%
  \thesubsection\textperiodcentered\arabic{subsubsection}
}

%--------------------------------------------------------------------
% ====== 情報入力用コマンド（学生が使う） ======
%--------------------------------------------------------------------
\newcommand{\titleja}[1]{\def\HUS@titleja{#1}}
\newcommand{\titleen}[1]{\def\HUS@titleen{#1}}

\newcommand{\studentid}[1]{\def\HUS@studentid{#1}}
\newcommand{\authorja}[1]{\def\HUS@authorja{#1}}
\newcommand{\advisor}[1]{\def\HUS@advisor{#1}}

\newcommand{\authoren}[1]{\def\HUS@authoren{#1}}

\renewcommand{\keywords}[1]{\def\HUS@keywords{#1}}


% 初期値（未定義防止）
\def\HUS@titleja{}
\def\HUS@titleen{}
\def\HUS@studentid{}
\def\HUS@authorja{}
\def\HUS@advisor{}
\def\HUS@authoren{}
\def\HUS@keywords{}

%--------------------------------------------------------------------
% ====== タイトル生成部（学生は触らない） ======
%--------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \begin{center}

  % 和文タイトル
  {\Large\bfseries \HUS@titleja \par}
  \vspace{1.0ex}

  % 英文タイトル
  {\large \HUS@titleen \par}
  \vspace{2.0ex}

  % 学籍番号・氏名
  {\normalsize
    \HUS@studentid\quad
    \HUS@authorja \par
  }
  \vspace{0.5ex}

  % 指導教員
  {\normalsize
    ［指導教員］\HUS@advisor \par
  }
  \vspace{1.5ex}

  % 英文著者名
  {\normalsize
    \HUS@authoren \par
  }
  \vspace{1.5ex}

  % Key Words
  {\normalsize
    \textit{\textbf{Key Words :}}\HUS@keywords
  }

  \end{center}

  % タイトルブロック後の余白
  \vspace{3ex}
}

%--------------------------------------------------------------------
% abstract 環境は禁止
%--------------------------------------------------------------------
\renewenvironment{abstract}{%
  \ClassWarning{HUS_abstract}{Abstract environment is not used in this template}%
}{}

%--------------------------------------------------------------------
% 文献見出し
%--------------------------------------------------------------------
\renewcommand{\refname}{文 献}

%--------------------------------------------------------------------
% 本文中の引用番号を（1）形式にする
%--------------------------------------------------------------------
\AtBeginDocument{%
  \makeatletter
  \def\@cite#1#2{\textsuperscript{(#1)}}%
  \makeatother
}

%--------------------------------------------------------------------
% thebibliography を番号付きリストとして再定義（jsmepaper対策）
%--------------------------------------------------------------------
\AtBeginDocument{%
  \makeatletter
  \renewenvironment{thebibliography}[1]{%
    \section*{\refname}%
    \list{[\arabic{enumi}]}{%
      \usecounter{enumi}%
      \setlength{\leftmargin}{2em}%
      \setlength{\labelsep}{0.5em}%
      \setlength{\itemindent}{0pt}%
    }%
  }{%
    \endlist
  }%
  \makeatother
}
%%====================================================================
%% End of HUS_abstract.cls
%%====================================================================