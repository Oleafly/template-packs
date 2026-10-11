%% File: wzuthesis.cls
%% Derived from: thuthesis.cls (Tsinghua University Thesis Template)
%%
%% Major Changes:
%%   - Updated cover design for Wenzhou University
%%   - Adjust the format of page header and page footer outside the body and body


\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\ProvidesClass{wzuthesis}
[2025/03/28 7.6.0 Tsinghua University Thesis Template]
\newcommand\wzu@error[1]{%
  \ClassError{wzuthesis}{#1}{}%
}
\newcommand\wzu@warning[1]{%
  \ClassWarning{wzuthesis}{#1}%
}
\newcommand\wzu@debug[1]{%
  \typeout{Package wzuthesis Info: #1}%
}
\newcommand\wzu@patch@error[1]{%
  \wzu@error{Failed to patch command \protect#1}%
}
\newcommand\wzu@deprecate[2]{%
  \def\wzu@@tmp{#2}%
  \wzu@warning{%
    The #1 is deprecated%
    \ifx\wzu@@tmp\@empty\else
      . Use #2 instead%
    \fi
  }%
}
\@ifl@t@r\fmtversion{2017/04/15}{}{
  \wzu@error{%
    TeX Live 2017 or later version is required to compile this document%
  }
}
\RequirePackage{iftex}
\ifXeTeX\else
  \ifLuaTeX\else
    \wzu@error{XeLaTeX or LuaLaTeX is required to compile this document}
  \fi
\fi
\InputIfFileExists{wzuthesis-pdf-test-config.tex}{}{
  \InputIfFileExists{wzuthesis-log-test-config.tex}{}{}
}
\hyphenation{wzu-Thesis}
\def\wzuthesis{wzuthesis}
\def\version{7.6.0}
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=wzu,
  prefix=wzu@,
  setkeys=\kvsetkeys}
\let\wzu@setup@hook\@empty
\newcommand\wzusetup[1]{%
  \let\wzu@setup@hook\@empty
  \kvsetkeys{wzu}{#1}%
  \wzu@setup@hook
}
\newcommand\wzu@define@key[1]{%
  \kvsetkeys{wzu@key}{#1}%
}
\kv@set@family@handler{wzu@key}{%
  \@namedef{wzu@#1@@name}{#1}%
  \def\wzu@@default{}%
  \def\wzu@@choices{}%
  \kv@define@key{wzu@value}{name}{%
    \@namedef{wzu@#1@@name}{##1}%
  }%
  \@namedef{wzu@#1@@check}{}%
  \@namedef{wzu@#1@@code}{}%
  \kv@define@key{wzu@value}{choices}{%
    \def\wzu@@choices{##1}%
    \@namedef{wzu@#1@@reset}{}%
    \@namedef{wzu@#1@@check}{%
      \@ifundefined{%
        ifwzu@\@nameuse{wzu@#1@@name}@\@nameuse{wzu@\@nameuse{wzu@#1@@name}}%
      }{%
        \wzu@error{Invalid value "#1 = \@nameuse{wzu@\@nameuse{wzu@#1@@name}}"}%
      }%
      \@nameuse{wzu@#1@@reset}%
      \@nameuse{wzu@\@nameuse{wzu@#1@@name}@\@nameuse{wzu@\@nameuse{wzu@#1@@name}}true}%
    }%
  }%
  \kv@define@key{wzu@value}{default}{%
    \def\wzu@@default{##1}%
  }%
  \kvsetkeys{wzu@value}{#2}%
  \@namedef{wzu@\@nameuse{wzu@#1@@name}}{}%
  \kv@set@family@handler{wzu@choice}{%
    \ifx\wzu@@default\@empty
      \def\wzu@@default{##1}%
    \fi
    \expandafter\newif\csname ifwzu@\@nameuse{wzu@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname wzu@#1@@reset\endcsname{%
      \@nameuse{wzu@\@nameuse{wzu@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{wzu@choice}{\wzu@@choices}%
  \expandafter\let\csname wzu@\@nameuse{wzu@#1@@name}\endcsname\wzu@@default
  \expandafter\ifx\csname wzu@\@nameuse{wzu@#1@@name}\endcsname\@empty\else
    \@nameuse{wzu@#1@@check}%
  \fi
  \kv@define@key{wzu}{#1}{%
    \@namedef{wzu@\@nameuse{wzu@#1@@name}}{##1}%
    \@nameuse{wzu@#1@@check}%
    \@nameuse{wzu@#1@@code}%
  }%
}
\newcommand\wzu@option@hook[2]{%
  \expandafter\g@addto@macro\csname wzu@#1@@code\endcsname{#2}%
}
\wzu@define@key{
  thesis-type = {
    name = thesis@type,
    choices = {
      thesis,
      proposal,
    },
    default = thesis,
  },
  degree = {
    choices = {
      bachelor,
      master,
      doctor,
      postdoc,
    },
    default = doctor,
  },
  degree-type = {
    choices = {
      academic,
      professional,
    },
    name = degree@type,
  },
  main-language = {
    name = main@language,
    choices = {
      chinese,
      english,
    },
  },
  language = {
    choices = {
      chinese,
      english,
    },
  },
  system = {
    choices = {
      auto,
      mac,
      unix,
      windows,
    },
    default = auto,
  },
  fontset = {
    choices = {
      auto,
      windows,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = auto,
  },
  font = {
    choices = {
      auto,
      times,
      termes,
      stix,
      xits,
      libertinus,
      newcm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  cjk-font = {
    name = cjk@font,
    choices = {
      auto,
      windows,
      windows-local,
      mac,
      mac-word,
      noto,
      fandol,
      none,
    },
    default = auto,
  },
  windows-font-dir = {
    name = windows@font@dir,
    default = {.},
  },
  math-font = {
    name = math@font,
    choices = {
      auto,
      stix,
      xits,
      libertinus,
      newcm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  math-style = {
    name = math@style,
    choices = {
      GB,
      ISO,
      TeX,
    },
  },
  uppercase-greek = {
    name = uppercase@greek,
    choices = {
      italic,
      upright,
    },
  },
  less-than-or-equal = {
    name = leq,
    choices = {
      slanted,
      horizontal,
    },
  },
  integral = {
    choices = {
      upright,
      slanted,
    },
  },
  integral-limits = {
    name = integral@limits,
    choices = {
      true,
      false,
    },
  },
  partial = {
    choices = {
      upright,
      italic,
    },
  },
  math-ellipsis = {
    name = math@ellipsis,
    choices = {
      centered,
      lower,
      AMS,
    },
  },
  real-part = {
    name = real@part,
    choices = {
      roman,
      fraktur,
    },
  },
  output = {
    choices = {
      print,
      electronic,
    },
    default = print,
  },
  eqn-paren-style = {
    name = eqn@paren@style,
    choices = {
      full,
      half,
    }
  },
}
\newif\ifwzu@degree@graduate
\newcommand\wzu@set@graduate{%
  \wzu@degree@graduatefalse
  \ifwzu@degree@doctor
    \wzu@degree@graduatetrue
  \fi
  \ifwzu@degree@master
    \wzu@degree@graduatetrue
  \fi
}
\wzu@set@graduate
\wzu@option@hook{degree}{%
  \wzu@set@graduate
}
\DeclareBoolOption[false]{openright}
\DeclareComplementaryOption{openany}{openright}
\DeclareBoolOption[true]{raggedbottom}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\ifwzu@openright
  \PassOptionsToClass{openright}{book}
\else
  \PassOptionsToClass{openany}{book}
\fi
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[a4paper,UTF8,zihao=-4,scheme=plain,fontset=none]{ctexbook}[2017/04/01]
\RequirePackage{etoolbox}
\RequirePackage{filehook}
\RequirePackage{xparse}
\RequirePackage{geometry}%
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{notoccite}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\AtEndPreamble{
  \ifx\tikzifexternalizing\@undefined\else
    \tikzifexternalizing{
      \renewcommand*\includepdf[2][]{}
    }{}
  \fi
}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\ifwzu@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\ifXeTeX
  \RequirePackage{xeCJKfntef}
\else
  \RequirePackage{ulem}
\fi
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{url}
\AtEndPreamble{
  \@ifpackageloaded{biblatex}{}{
    \@ifpackageloaded{apacite}{}{
      \RequirePackage{natbib}
    }
  }
}
\AtEndOfPackageFile*{natbib}{
  \@ifpackageloaded{apacite}{}{
    \RequirePackage{bibunits}
  }
}
\newcommand\wzu@package@conflict[2]{%
  \AtEndOfPackageFile*{#1}{%
    \AtBeginOfPackageFile*{#2}{%
      \wzu@error{The "#2" package is incompatible with "#1"}%
    }%
  }%
}
\wzu@package@conflict{biblatex}{bibunits}
\wzu@package@conflict{biblatex}{chapterbib}
\wzu@package@conflict{biblatex}{cite}
\wzu@package@conflict{biblatex}{multibib}
\wzu@package@conflict{biblatex}{natbib}

\wzu@package@conflict{bibunits}{biblatex}
\wzu@package@conflict{bibunits}{chapterbib}
\wzu@package@conflict{bibunits}{multibib}

\wzu@package@conflict{unicode-math}{amscd}
\wzu@package@conflict{unicode-math}{amsfonts}
\wzu@package@conflict{unicode-math}{amssymb}
\wzu@package@conflict{unicode-math}{bbm}
\wzu@package@conflict{unicode-math}{bm}
\wzu@package@conflict{unicode-math}{eucal}
\wzu@package@conflict{unicode-math}{eufrak}
\wzu@package@conflict{unicode-math}{mathrsfs}
\wzu@package@conflict{unicode-math}{newtxmath}
\wzu@package@conflict{unicode-math}{upgreek}

\wzu@package@conflict{natbib}{biblatex}
\wzu@package@conflict{natbib}{cite}

\wzu@package@conflict{newtxmath}{amsfonts}
\wzu@package@conflict{newtxmath}{amssymb}
\wzu@package@conflict{newtxmath}{unicode-math}
\wzu@package@conflict{newtxmath}{upgreek}
\AtBeginOfPackageFile*{amsthm}{
  \@ifpackageloaded{newtxmath}{
    \wzu@error{The "amsthm" package should be loaded before setting "newtxmath"}
  }{}
}%
\geometry{
  paper          = a4paper,  % 210 * 297mm
  marginparwidth = 2cm,
  marginparsep   = 0.5cm,
}
\newcommand\wzu@set@geometry{%
  \ifwzu@degree@bachelor
    \geometry{
      margin     = 3cm,
      footskip   = 1.5cm,
    }%
  \else
    \geometry{
      margin     = 3cm,
      headheight = 2.7cm,
      headsep    = 0.3cm,
      footskip   = 0.8cm,
    }%
  \fi
}
\wzu@set@geometry
\wzu@option@hook{degree}{\wzu@set@geometry}
\wzu@option@hook{output}{\wzu@set@geometry}
\wzusetup{main-language=\wzu@language}%
\let\wzu@main@language\wzu@language
\wzu@option@hook{language}{%
  \ifx\@begindocumenthook\@undefined\else
    \wzusetup{main-language=\wzu@language}%
    \let\wzu@main@language\wzu@language
  \fi
}
\newcommand\wzu@reset@main@language{%
  \wzusetup{language = \wzu@main@language}%
  \let\wzu@language\wzu@main@language
}
\newcommand\wzu@set@chapter@names{%
  \ifwzu@degree@bachelor
    \def\wzu@statement@name{声明}%
  \else
    \def\wzu@statement@name{声\hspace{1em}明}%
  \fi
  \ifwzu@main@language@chinese
    \def\listfigurename{插图清单}%
    \def\listtablename{附表清单}%
    \def\wzu@list@figure@table@name{插图和附表清单}%
    \def\wzu@list@algorithm@name{算法清单}%
    \def\wzu@denotation@name{符号和缩略语说明}%
    \def\wzu@comments@name{指导教师评语}%
    \def\bibname{参考文献}%
    \def\appendixname{附录}%
    \def\indexname{索引}%
    \def\wzu@resolution@name{答辩委员会决议书}%
    \ifwzu@degree@bachelor
      \def\contentsname{目录}%
      \def\wzu@acknowledgements@name{致谢}%
      \def\listequationname{公式索引}%
      \def\wzu@resume@name{在学期间参加课题的研究成果}%
    \else
      \def\listequationname{公式清单}%
      \def\wzu@acknowledgements@name{致\quad 谢}%
      \ifwzu@degree@graduate
        \def\contentsname{目\quad 录}%
        \def\wzu@resume@name{个人简历、在学期间完成的相关学术成果}%
      \else  % degree = postdoc
        \def\contentsname{目\qquad 次}%
        \def\wzu@denotation@name{符号表}%
        \def\wzu@resume@name{个人简历、发表的学术论文与科研成果}%
      \fi
    \fi
  \else
    \ifwzu@main@language@english
      \def\wzu@comments@name{Comments from Thesis Supervisor}%
      \def\wzu@resolution@name{Resolution of Thesis Defense Committee}%
      \def\indexname{Index}%
      \ifwzu@degree@bachelor
        \def\contentsname{CONTENTS}%
        \def\listfigurename{FIGURES}%
        \def\listtablename{TABLES}%
        \def\wzu@list@figure@table@name{FIGURES AND TABLES}%
        \def\wzu@list@algorithm@name{ALGORITHMS}%
        \def\listequationname{EQUATIONS}%
        \def\wzu@denotation@name{ABBREVIATIONS}%
        \def\bibname{REFERENCES}%
        \def\appendixname{APPENDIX}%
        \def\wzu@acknowledgements@name{ACKNOWLEDGEMENTS}%
        \def\wzu@resume@name{PUBLICATIONS}%
      \else
        \def\contentsname{Table of Contents}%
        \def\listfigurename{List of Figures}%
        \def\listtablename{List of Tables}%
        \def\wzu@list@figure@table@name{List of Figures and Tables}%
        \def\wzu@list@algorithm@name{List of Algorithms}%
        \def\listequationname{List of Equations}%
        \def\wzu@denotation@name{List of Symbols and Acronyms}%
        \def\bibname{References}%
        \def\appendixname{Appendix}%
        \def\wzu@acknowledgements@name{Acknowledgements}%
        \def\wzu@resume@name{Resume}%
      \fi
    \fi
  \fi
}
\wzu@set@chapter@names
\wzu@option@hook{degree}{\wzu@set@chapter@names}
\wzu@option@hook{main-language}{\wzu@set@chapter@names}
\newcommand\wzu@set@names{%
  \ifwzu@language@chinese
    \ctexset{
      figurename = 图,
      tablename  = 表,
    }%
    \def\wzu@algorithm@name{算法}%
    \def\wzu@equation@name{公式}%
    \def\wzu@assumption@name{假设}%
    \def\wzu@definition@name{定义}%
    \def\wzu@proposition@name{命题}%
    \def\wzu@lemma@name{引理}%
    \def\wzu@theorem@name{定理}%
    \def\wzu@axiom@name{公理}%
    \def\wzu@corollary@name{推论}%
    \def\wzu@exercise@name{练习}%
    \def\wzu@example@name{例}%
    \def\wzu@remark@name{注释}%
    \def\wzu@problem@name{问题}%
    \def\wzu@conjecture@name{猜想}%
    \def\wzu@proof@name{证明}%
    \def\wzu@theorem@separator{：}%
  \else
    \ifwzu@language@english
      \ctexset{
        figurename = {Figure},
        tablename  = {Table},
      }%
      \def\wzu@algorithm@name{Algorithm}%
      \def\wzu@equation@name{Equation}%
      \def\wzu@assumption@name{Assumption}%
      \def\wzu@definition@name{Definition}%
      \def\wzu@proposition@name{Proposition}%
      \def\wzu@lemma@name{Lemma}%
      \def\wzu@theorem@name{Theorem}%
      \def\wzu@axiom@name{Axiom}%
      \def\wzu@corollary@name{Corollary}%
      \def\wzu@exercise@name{Exercise}%
      \def\wzu@example@name{Example}%
      \def\wzu@remark@name{Remark}%
      \def\wzu@problem@name{Problem}%
      \def\wzu@conjecture@name{Conjecture}%
      \def\wzu@proof@name{Proof}%
      \def\wzu@theorem@separator{: }%
    \fi
  \fi
}
\wzu@set@names
\wzu@option@hook{language}{\wzu@set@names}
\ifLuaTeX
  % ctex 将带圈数字 U+2460–U+24FF 归入字符范围 3（ALchar），这里改回范围 6（JAchar）
  \ltjdefcharrange{3}{%
    "2000-"243F, "2500-"27BF, "2900-"29FF, "2B00-"2BFF}
  \ltjdefcharrange{6}{%
    "2460-"24FF, "2E80-"2EFF, "3000-"30FF, "3190-"319F, "31F0-"4DBF,
    "4E00-"9FFF, "F900-"FAFF, "FE10-"FE1F, "FE30-"FE6F, "FF00-"FFEF,
    "1B000-"1B16F, "1F100-"1F2FF, "20000-"3FFFF, "E0100-"E01EF}
\else
  \ifXeTeX
    \xeCJKDeclareCharClass{CJK}{"2460 -> "2473}
    \xeCJKDeclareCharClass{CJK}{"2605}
  \fi
\fi
\newcommand\wzu@set@punctuations{%
  \ifwzu@language@chinese
    \ifLuaTeX
      \ltjsetparameter{jacharrange={+9}}
    \else
      \ifXeTeX
        \xeCJKDeclareCharClass{FullLeft}{"2018, "201C}%
        \xeCJKDeclareCharClass{FullRight}{
          "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
        }%
      \fi
    \fi
  \else
    \ifwzu@language@english
      \ifLuaTeX
        \ltjsetparameter{jacharrange={-9}}
      \else
        \ifXeTeX
          \xeCJKDeclareCharClass{HalfLeft}{"2018, "201C}%
          \xeCJKDeclareCharClass{HalfRight}{
            "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
          }%
        \fi
      \fi
    \fi
  \fi
}
\wzu@set@punctuations
\wzu@option@hook{language}{\wzu@set@punctuations}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 6bp%
  \abovedisplayshortskip 6bp%
  \belowdisplayshortskip 6bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\ifx\MakeRobust\@undefined \else
    \MakeRobust\normalsize
\fi
\def\wzu@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\wzu@def@fontsize{chuhao}{42bp}
\wzu@def@fontsize{xiaochu}{36bp}
\wzu@def@fontsize{yihao}{26bp}
\wzu@def@fontsize{xiaoyi}{24bp}
\wzu@def@fontsize{erhao}{22bp}
\wzu@def@fontsize{xiaoer}{18bp}
\wzu@def@fontsize{sanhao}{16bp}
\wzu@def@fontsize{xiaosan}{15bp}
\wzu@def@fontsize{sihao}{14bp}
\wzu@def@fontsize{xiaosi}{12bp}
\wzu@def@fontsize{wuhao}{10.5bp}
\wzu@def@fontsize{xiaowu}{9bp}
\wzu@def@fontsize{liuhao}{7.5bp}
\wzu@def@fontsize{xiaoliu}{6.5bp}
\wzu@def@fontsize{qihao}{5.5bp}
\wzu@def@fontsize{bahao}{5bp}
\ifwzu@system@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \wzusetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \wzusetup{system = windows}
      }{
        \wzusetup{system = unix}
      }
    }{
      \wzusetup{system = windows}
    }
  }
  \wzu@debug{Detected system: \wzu@system}
\fi
\newcommand\wzu@mac@word@font@dir{%
  /Applications/Microsoft Word.app/Contents/Resources/DFonts%
}
\ifwzu@fontset@auto
  \ifwzu@system@windows
    \wzusetup{fontset = windows}
  \else
    \IfFontExistsTF{SimSun}{
      \wzusetup{fontset = windows}
    }{
      \IfFileExists{\wzu@windows@font@dir/Simsun.ttc}{
        \wzusetup{fontset = windows, cjk-font = windows-local}
      }{
        \IfFileExists{\wzu@mac@word@font@dir/Simsun.ttc}{
          \wzusetup{fontset = windows, cjk-font = mac-word}
        }{
          \ifwzu@system@mac
            \wzusetup{fontset = mac}
          \else
            \IfFontExistsTF{Noto Serif CJK SC}{
              \wzusetup{fontset = ubuntu}
            }{
              \wzusetup{fontset = fandol}
            }
          \fi
        }
      }
    }
  \fi
  \wzu@debug{Detected fontset: \wzu@fontset}
\fi
\newcommand\wzu@set@font{%
  \@nameuse{wzu@set@font@\wzu@font}%
}
\wzu@option@hook{font}{\wzu@set@font}
\newcommand\wzu@set@font@auto{%
  \ifwzu@font@auto
    \ifwzu@fontset@windows
      \wzusetup{font=times}%
    \else
      \ifwzu@fontset@mac
        \wzusetup{font=times}%
      \else
        \wzusetup{font=termes}%
      \fi
    \fi
  \fi
}
\wzu@option@hook{math-font}{\g@addto@macro\wzu@setup@hook{\wzu@set@font@auto}}
\AtBeginOfPackageFile*{siunitx}{\wzu@set@font@auto}
\AtEndPreamble{\wzu@set@font@auto}
\newcommand\wzu@set@font@times{%
  \setmainfont{Times New Roman}%
  \setsansfont{Arial}%
  \ifwzu@fontset@mac
    \setmonofont{Menlo}[Scale = MatchLowercase]%
  \else
    \setmonofont{Courier New}[Scale = MatchLowercase]%
  \fi
}
\newcommand\wzu@set@font@termes{%
  \setmainfont{texgyretermes}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \wzu@set@texgyre@sans@mono
}
\newcommand\wzu@set@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
    Ligatures      = CommonOff,
  ]%
}
\let\wzu@font@family@stix\@empty
\newcommand\wzu@set@stix@names{%
  \ifx\wzu@font@family@stix\@empty
    \IfFontExistsTF{STIXTwoText-Regular.otf}{%
      \gdef\wzu@font@family@stix{STIXTwoText}%
      \gdef\wzu@font@name@stix@math{STIXTwoMath-Regular}%
    }{%
      \gdef\wzu@font@family@stix{STIX2Text}%
      \gdef\wzu@font@name@stix@math{STIX2Math}%
    }%
  \fi
}
\newcommand\wzu@set@font@stix{%
  \wzu@set@stix@names
  \setmainfont{\wzu@font@family@stix}[
    Extension      = .otf,
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Italic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \wzu@set@texgyre@sans@mono
}
\let\wzu@font@family@xits\@empty
\newcommand\wzu@set@xits@names{%
  \ifx\wzu@font@family@xits\@empty
    \IfFontExistsTF{XITSMath-Regular.otf}{%
      \gdef\wzu@font@family@xits{XITS}%
      \gdef\wzu@font@style@xits@rm{Regular}%
      \gdef\wzu@font@style@xits@bf{Bold}%
      \gdef\wzu@font@style@xits@it{Italic}%
      \gdef\wzu@font@style@xits@bfit{BoldItalic}%
      \gdef\wzu@font@name@xits@math{XITSMath-Regular}%
    }{%
      \gdef\wzu@font@family@xits{xits}%
      \gdef\wzu@font@style@xits@rm{regular}%
      \gdef\wzu@font@style@xits@bf{bold}%
      \gdef\wzu@font@style@xits@it{italic}%
      \gdef\wzu@font@style@xits@bfit{bolditalic}%
      \gdef\wzu@font@name@xits@math{xits-math}%
    }%
  \fi
}
\newcommand\wzu@set@font@xits{%
  \wzu@set@xits@names
  \setmainfont{\wzu@font@family@xits}[
    Extension      = .otf,
    UprightFont    = *-\wzu@font@style@xits@rm,
    BoldFont       = *-\wzu@font@style@xits@bf,
    ItalicFont     = *-\wzu@font@style@xits@it,
    BoldItalicFont = *-\wzu@font@style@xits@bfit,
  ]%
  \wzu@set@texgyre@sans@mono
}
\let\wzu@font@family@libertinus\@empty
\newcommand\wzu@set@libertinus@names{%
  \ifx\wzu@font@family@libertinus\@empty
    \IfFontExistsTF{LibertinusSerif-Regular.otf}{%
      \gdef\wzu@font@family@libertinus@serif{LibertinusSerif}%
      \gdef\wzu@font@family@libertinus@sans{LibertinusSans}%
      \gdef\wzu@font@name@libertinus@math{LibertinusMath-Regular}%
      \gdef\wzu@font@style@libertinus@rm{Regular}%
      \gdef\wzu@font@style@libertinus@bf{Bold}%
      \gdef\wzu@font@style@libertinus@it{Italic}%
      \gdef\wzu@font@style@libertinus@bfit{BoldItalic}%
    }{%
      \gdef\wzu@font@family@libertinus@serif{libertinusserif}%
      \gdef\wzu@font@family@libertinus@sans{libertinussans}%
      \gdef\wzu@font@name@libertinus@math{libertinusmath-regular}%
      \gdef\wzu@font@style@libertinus@rm{regular}%
      \gdef\wzu@font@style@libertinus@bf{bold}%
      \gdef\wzu@font@style@libertinus@it{italic}%
      \gdef\wzu@font@style@libertinus@bfit{bolditalic}%
    }%
  \fi
}
\newcommand\wzu@set@font@libertinus{%
  \wzu@set@libertinus@names
  \setmainfont{\wzu@font@family@libertinus@serif}[
    Extension      = .otf,
    UprightFont    = *-\wzu@font@style@libertinus@rm,
    BoldFont       = *-\wzu@font@style@libertinus@bf,
    ItalicFont     = *-\wzu@font@style@libertinus@it,
    BoldItalicFont = *-\wzu@font@style@libertinus@bfit,
  ]%
  \setsansfont{\wzu@font@family@libertinus@sans}[
    Extension      = .otf,
    UprightFont    = *-\wzu@font@style@libertinus@rm,
    BoldFont       = *-\wzu@font@style@libertinus@bf,
    ItalicFont     = *-\wzu@font@style@libertinus@it,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\wzu@set@font@newcm{%
  \setmainfont{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setsansfont{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmonofont{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}
\newcommand\wzu@set@font@lm{%
  \setmainfont{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setsansfont{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\wzu@set@font@newtx{%
  \RequirePackage{newtxtext}%
}
\ifwzu@cjk@font@auto
  \ifwzu@fontset@mac
    \wzusetup{cjk-font = mac}
  \else
    \ifwzu@fontset@windows
      \IfFontExistsTF{SimSun}{
        \wzusetup{cjk-font = windows}
      }{
        \IfFileExists{\wzu@windows@font@dir/Simsun.ttc}{
          \wzusetup{cjk-font = windows-local}
        }{
          \IfFileExists{\wzu@mac@word@font@dir/Simsun.ttc}{
            \wzusetup{cjk-font = mac-word}
          }{
            \wzu@error{Cannot find "SimSun" font}
          }
        }
      }
    \else
      \ifwzu@fontset@ubuntu
        \wzusetup{cjk-font = noto}
      \else
        \wzusetup{cjk-font = fandol}
      \fi
    \fi
  \fi
  \wzu@debug{Detected CJK font: \wzu@cjk@font}
\fi
\newcommand\wzu@set@cjk@font@windows{%
  \setCJKmainfont{SimSun}[
    AutoFakeBold = 3,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimHei}[AutoFakeBold = 3]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold = 3]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold = 3]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\@namedef{wzu@set@cjk@font@windows-local}{%
  \IfFileExists{\wzu@windows@font@dir/Kaiti.ttf}{
    \setCJKmainfont{SimSun}[%
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttc,
      AutoFakeBold = 3,
      ItalicFont   = Kaiti,
      ItalicFeatures = {Extension = .ttf},
    ]%
    \setCJKmonofont{Fangsong}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
    \setCJKfamilyfont{zhkai}{Kaiti}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
    \setCJKfamilyfont{zhfs}{Fangsong}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
  }{
    \setCJKmainfont{SimSun}[%
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttc,
      AutoFakeBold = 3,
      ItalicFont   = Simkai,
      ItalicFeatures = {Extension = .ttf},
    ]%
    \setCJKmonofont{Simfang}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
    \setCJKfamilyfont{zhkai}{Simkai}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
    \setCJKfamilyfont{zhfs}{Simfang}[
      Path         = \wzu@windows@font@dir/,
      Extension    = .ttf,
    ]%
  }
  \setCJKsansfont{SimHei}[%
    Path         = \wzu@windows@font@dir/,
    Extension    = .ttf,
    AutoFakeBold = 3,
  ]%
  \setCJKfamilyfont{zhsong}{SimSun}[%
    Path         = \wzu@windows@font@dir/,
    Extension    = .ttc,
    AutoFakeBold = 3,
  ]%
  \setCJKfamilyfont{zhhei}{SimHei}[%
    Path         = \wzu@windows@font@dir/,
    Extension    = .ttf,
    AutoFakeBold = 3,
  ]%
}
\@namedef{wzu@set@cjk@font@mac-word}{%
  \let\wzu@windows@font@dir\wzu@mac@word@font@dir
  \@nameuse{wzu@set@cjk@font@windows-local}%
}
\newcommand\wzu@set@cjk@font@mac{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC Regular,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[
    UprightFont    = * Regular,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
}
\newcommand\wzu@set@cjk@font@noto{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
    Script         = CJK,
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKmonofont{Noto Sans Mono CJK SC}[
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont    = * Light,
    UprightFont    = * Bold,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
}
\newcommand\wzu@set@cjk@font@fandol{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\ifwzu@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
\fi
\newcommand\wzu@set@cjk@font{%
  \@nameuse{wzu@set@cjk@font@\wzu@cjk@font}%
}
\wzu@set@cjk@font
\wzu@option@hook{cjk-font}{\wzu@set@cjk@font}
\newcommand\wzu@set@math@style{%
  \ifwzu@math@style@TeX
    \wzusetup{
      uppercase-greek    = upright,
      less-than-or-equal = horizontal,
      integral           = slanted,
      integral-limits    = false,
      partial            = italic,
      math-ellipsis      = AMS,
      real-part          = fraktur,
    }%
  \else
    \wzusetup{
      uppercase-greek = italic,
      integral        = upright,
      partial         = upright,
      real-part       = roman,
    }%
    \ifwzu@math@style@ISO
      \wzusetup{
        less-than-or-equal = horizontal,
        integral-limits    = true,
        math-ellipsis      = lower,
      }%
    \else
      \ifwzu@math@style@GB
        \wzusetup{
          less-than-or-equal = slanted,
          integral-limits    = false,
          math-ellipsis      = centered,
        }%
      \fi
    \fi
  \fi
}
\ifwzu@main@language@chinese
  \wzusetup{math-style=GB}%
\else
  \wzusetup{math-style=TeX}%
\fi
\wzu@set@math@style
\wzu@option@hook{math-style}{\wzu@set@math@style}
\wzu@option@hook{main-language}{%
  \ifwzu@main@language@chinese
    \wzusetup{math-style=GB}%
  \else
    \wzusetup{math-style=TeX}%
  \fi
}
\newcommand\wzu@set@unimath@leq{%
  \ifwzu@leq@horizontal
    \ifx\@begindocumenthook\@undefined
      \let\le\wzu@save@leq
      \let\ge\wzu@save@geq
      \let\leq\wzu@save@leq
      \let\geq\wzu@save@geq
    \else
      \AtBeginDocument{%
        \let\le\wzu@save@leq
        \let\ge\wzu@save@geq
        \let\leq\wzu@save@leq
        \let\geq\wzu@save@geq
      }%
    \fi
  \else
    \ifwzu@leq@slanted
      \ifx\@begindocumenthook\@undefined
        \let\le\leqslant
        \let\ge\geqslant
        \let\leq\leqslant
        \let\geq\geqslant
      \else
        \AtBeginDocument{%
          \let\le\leqslant
          \let\ge\geqslant
          \let\leq\leqslant
          \let\geq\geqslant
        }%
      \fi
    \fi
  \fi
}
\newcommand\wzu@set@unimath@integral@limits{%
  \ifwzu@integral@limits@true
    \removenolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \else
    \addnolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \fi
}
\newcommand\wzu@set@unimath@ellipsis{%
  \ifwzu@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodecdots}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodeellipsis}}%
  \fi
}
\newcommand\wzu@set@unimath@real@part{%
  \ifwzu@real@part@roman
    \AtBeginDocument{%
      \def\Re{\operatorname{Re}}%
      \def\Im{\operatorname{Im}}%
    }%
  \else
    \AtBeginDocument{%
      \let\Re\wzu@save@Re
      \let\Im\wzu@save@Im
    }%
  \fi
}
\newcommand\wzu@set@unimath@style{%
  \ifwzu@uppercase@greek@upright
    \unimathsetup{math-style = TeX}%
  \else
    \ifwzu@uppercase@greek@italic
      \unimathsetup{math-style = ISO}%
    \fi
  \fi
  \ifwzu@math@style@TeX
    \unimathsetup{bold-style = TeX}%
  \else
    \unimathsetup{bold-style = ISO}%
  \fi
  \wzu@set@unimath@leq
  \wzu@set@unimath@integral@limits
  \ifwzu@partial@upright
    \unimathsetup{partial = upright}%
  \else
    \ifwzu@partial@italic
      \unimathsetup{partial = italic}%
    \fi
  \fi
  \wzu@set@unimath@ellipsis
  \wzu@set@unimath@real@part
}
\newcommand\wzu@qed{\rule{1ex}{1ex}}
\newcommand\wzu@load@unimath{%
  \@ifpackageloaded{unicode-math}{}{%
    \RequirePackage{unicode-math}%
    \AtBeginDocument{%
      \let\wzu@save@leq\leq
      \let\wzu@save@geq\geq
      \let\wzu@save@Re\Re
      \let\wzu@save@Im\Im
    }%
    \DeclareRobustCommand\bm[1]{{\symbfit{##1}}}%
    \DeclareRobustCommand\boldsymbol[1]{{\symbfit{##1}}}%
    \newcommand\square{\mdlgwhtsquare}%
    \newcommand\blacksquare{\mdlgblksquare}%
    \AtBeginDocument{%
      \renewcommand\checkmark{\ensuremath{\symbol{"2713}}}%
    }%
    \renewcommand\wzu@qed{\ensuremath{\QED}}%
  }%
}
\newcommand\wzu@set@math@font@stix{%
  \wzu@set@stix@names
  \setmathfont{\wzu@font@name@stix@math}[
    Extension    = .otf,
    Scale        = MatchLowercase,
    StylisticSet = \wzu@xits@integral@stylistic@set,
  ]%
  \setmathfont{\wzu@font@name@stix@math}[
    Extension    = .otf,
    Scale        = MatchLowercase,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
}
\newcommand\wzu@xits@integral@stylistic@set{%
  \ifwzu@integral@upright
    8%
  \fi
}
\newcommand\wzu@set@math@font@xits{%
  \wzu@set@xits@names
  \setmathfont{\wzu@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = \wzu@xits@integral@stylistic@set,
  ]%
  \setmathfont{\wzu@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {cal,bfcal},
  ]%
}
\newcommand\wzu@libertinus@integral@stylistic@set{%
  \ifwzu@integral@slanted
    8%
  \fi
}
\newcommand\wzu@set@math@font@libertinus{%
  \wzu@set@libertinus@names
  \setmathfont{\wzu@font@name@libertinus@math}[
    Extension    = .otf,
    StylisticSet = \wzu@libertinus@integral@stylistic@set,
  ]%
}
\newcommand\wzu@newcm@integral@stylistic@set{%
  \ifwzu@integral@upright
    2%
  \fi
}
\newcommand\wzu@set@math@font@newcm{%
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = \wzu@newcm@integral@stylistic@set,
  ]%
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
  \setmathrm{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setmathsf{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmathtt{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}
\newcommand\wzu@set@math@font@lm{%
  \setmathfont{latinmodern-math}[Extension=.otf]%
  \setmathrm{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmathsf{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmathtt{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\wzu@set@math@font@newtx{%
  \ifwzu@font@newtx\else
    \let\wzu@save@encodingdefault\encodingdefault
    \let\wzu@save@rmdefault\rmdefault
    \let\wzu@save@sfdefault\sfdefault
    \let\wzu@save@ttdefault\ttdefault
    \RequirePackage[T1]{fontenc}%
    \renewcommand{\rmdefault}{ntxtlf}%
    \renewcommand{\sfdefault}{qhv}%
    \renewcommand{\ttdefault}{ntxtt}%
  \fi
  \ifwzu@uppercase@greek@italic
    \PassOptionsToPackage{slantedGreek}{newtxmath}%
  \fi
  \ifwzu@integral@upright
    \PassOptionsToPackage{upint}{newtxmath}%
  \fi
  \RequirePackage{newtxmath}
  \let\wzu@save@leq\leq
  \let\wzu@save@geq\geq
  \ifwzu@leq@slanted
    \let\le\leqslant
    \let\ge\geqslant
    \let\leq\leqslant
    \let\geq\geqslant
  \fi
  \ifwzu@integral@limits@true
    \let\ilimits@\displaylimits
  \fi
  \let\wzu@save@partial\partial
  \ifwzu@partial@upright
    \let\partial\uppartial
  \fi
  \ifwzu@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\cdotp\cdotp\cdotp}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\ldotp\ldotp\ldotp}}%
  \fi
  \let\wzu@save@Re\Re
  \let\wzu@save@Im\Im
  \ifwzu@real@part@roman
    \def\Re{\operatorname{Re}}%
    \def\Im{\operatorname{Im}}%
  \fi
  \RequirePackage{bm}%
  \ifwzu@font@newtx\else
    \let\encodingdefault\wzu@save@encodingdefault
    \let\rmdefault\wzu@save@rmdefault
    \let\sfdefault\wzu@save@sfdefault
    \let\ttdefault\wzu@save@ttdefault
  \fi
  \DeclareRobustCommand\symup[1]{{\mathrm{##1}}}%
  \DeclareRobustCommand\symbf[1]{{\bm{##1}}}%
  \DeclareRobustCommand\symbfsf[1]{{\bm{\mathsf{##1}}}}%
  \let\increment\upDelta%
  \renewcommand\wzu@qed{\openbox}%
}
\newcommand\wzu@set@math@font{%
  \ifwzu@math@font@none\else
    \ifwzu@math@font@newtx
      \wzu@set@math@font@newtx
    \else
      \wzu@load@unimath
      \wzu@set@unimath@style
      \@nameuse{wzu@set@math@font@\wzu@math@font}%
    \fi
  \fi
}
\wzu@option@hook{math-font}{\g@addto@macro\wzu@setup@hook{\wzu@set@math@font}}
\newcommand\wzu@set@math@font@auto{%
  \ifwzu@math@font@auto
    \wzusetup{math-font=xits}%
  \fi
}
\AtBeginOfPackageFile*{siunitx}{\wzu@set@math@font@auto}
\AtEndPreamble{\wzu@set@math@font@auto}
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifwzu@output@print
      \ifodd\c@page
      \else
        \thispagestyle{empty}%
        \hbox{}%
        \newpage
        \if@twocolumn
          \hbox{}\newpage
        \fi
      \fi
    \fi
  \fi
}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
}
\renewcommand\backmatter{%
  \clearpage
  \@mainmatterfalse
  \wzusetup{toc-depth = 0}%
}
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand\footrulewidth{0pt}%
  \ifwzu@degree@bachelor
    \renewcommand\headrulewidth{0pt}%
    \fancyfoot[C]{
      \ifwzu@main@language@chinese
        \fontsize{10.5bp}{12.075bp}\selectfont
      \else
        \normalsize
      \fi
      \thepage
    }%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
  \else
    \renewcommand\headrulewidth{0.75bp}%
    \fancyhead[CO]{%
      \wuhao
      \ifwzu@main@language@chinese
        \leftmark
      \else
        \MakeUppercase{\leftmark}%
      \fi
      }% 奇数页
    \fancyhead[CE]{\wuhao 硕士学位论文}% 偶数页
    \fancyfoot[C]{\wuhao\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth{%
        \CTEXifname{%
          \CTEXthechapter
          \ifwzu@main@language@chinese
            \quad
          \else
            \space
          \fi
        }{}##1%
      }{}%
    }%
  \fi
  \let\sectionmark\@gobble
}
% === 自定义页眉页脚样式 ===
\fancypagestyle{frontstyle}{
  \fancyhf{}
  \renewcommand\headrulewidth{0pt}%去掉页眉线
  \renewcommand\footrulewidth{0pt}%去掉页脚线
  \fancyfoot[C]{\wuhao\thepage}  % 页脚
}
\fancypagestyle{mainstyle}{
  \fancyhf{}
  \renewcommand\footrulewidth{0pt}%
  \renewcommand\headrulewidth{0.75bp}%
  \fancyhead[CO]{\wuhao\leftmark}     % 奇数页页眉
  \fancyhead[CE]{\wuhao 温州大学硕士学位论文}   % 偶数页页眉
  \fancyfoot[C]{\wuhao\thepage}      % 页脚
}
\fancypagestyle{backstyle}{
  \fancyhf{}
  \renewcommand\footrulewidth{0pt}%
  \renewcommand\headrulewidth{0.75bp}%
  \fancyfoot[C]{\wuhao\thepage}      % 页脚
}
\pagestyle{plain}
\def\ps@chapter{}
\ctexset{chapter/pagestyle = chapter}
\ctexset{%
  punct=quanjiao,
}
\newcommand\wzu@set@indent{%
  \ifwzu@main@language@chinese
    \ctexset{autoindent=2}%
  \else
    \ifwzu@degree@bachelor
      \ctexset{autoindent=0.8cm}%
    \else
      \ctexset{autoindent=0.74cm}%
    \fi
  \fi
}
\wzu@set@indent
\wzu@option@hook{degree}{\wzu@set@indent}
\wzu@option@hook{main-language}{\wzu@set@indent}
\urlstyle{same}
\g@addto@macro\UrlBreaks{%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M
  \do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m
  \do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z
}
\Urlmuskip=0mu plus 0.1mu
\partopsep=\z@skip
\def\@listi{\leftmargin\leftmargini
            \parsep \z@skip
            \topsep \z@skip
            \itemsep\z@skip}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \itemsep   \z@skip}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \partopsep \z@skip
              \itemsep   \z@skip}
\setlist{nosep}
\interfootnotelinepenalty=10000
\newcommand\wzu@circled[1]{%
  \ifnum#1 >10\relax
    \wzu@warning{%
      Too many footnotes in this page.
      Keep footnote less than 10%
    }%
  \fi
  {\symbol{\the\numexpr#1+"245F\relax}}%
}
\renewcommand{\thefootnote}{\wzu@circled{\c@footnote}}
\renewcommand{\thempfootnote}{\wzu@circled{\c@mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\footnotemargin=13.5bp
\long\def\@makefntext#1{%
  \begingroup
    % 序号取消上标
    \def\@makefnmark{\hbox{\normalfont\@thefnmark}}%
    \xiaowu
    \ifFN@hangfoot
      \bgroup
      \setbox\@tempboxa\hbox{%
        \ifdim\footnotemargin>\z@
          \hb@xt@\footnotemargin{\@makefnmark\hss}%
        \else
          \@makefnmark
        \fi
      }%
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      % \footnotesize
      \xiaowu
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      \parskip\hangfootparskip\relax
      \parindent\hangfootparindent\relax
    \else
      \parindent1em%
      \noindent
      \ifdim\footnotemargin>\z@
        \hb@xt@ \footnotemargin{\hss\@makefnmark}%
      \else
        \ifdim\footnotemargin=\z@
          \llap{\@makefnmark}%
        \else
          \llap{\hb@xt@ -\footnotemargin{\@makefnmark\hss}}%
        \fi
      \fi
    \fi
    \footnotelayout#1%
    \ifFN@hangfoot
      \par\egroup
    \fi
  \endgroup
}
\allowdisplaybreaks[4]
\newcommand\wzu@eqn@left@paren{（}
\newcommand\wzu@eqn@right@paren{）}
\newcommand\wzu@set@eqn@paren@style{%
  \ifwzu@eqn@paren@style@full
    \renewcommand\wzu@eqn@left@paren{（}%
    \renewcommand\wzu@eqn@right@paren{）}%
  \else
    \renewcommand\wzu@eqn@left@paren{(}%
    \renewcommand\wzu@eqn@right@paren{)}%
  \fi
}
\wzu@set@eqn@paren@style
\wzu@option@hook{eqn-paren-style}{\wzu@set@eqn@paren@style}
\newcommand\wzu@put@parentheses[1]{%
  \ifwzu@language@chinese
    \unskip
    \wzu@eqn@left@paren#1\wzu@eqn@right@paren
  \else
    (#1)%
  \fi
}
\def\tagform@#1{\maketag@@@{\wzu@put@parentheses{\ignorespaces#1\unskip\@@italiccorr}}}
\renewcommand{\eqref}[1]{%
  \textup{%
    \normalfont\wzu@put@parentheses{%
      \ignorespaces\ref{#1}\unskip\@@italiccorr
    }%
  }%
}
\def\fps@figure{htbp}
\def\fps@table{htbp}
\setlength{\floatsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\textfloatsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\intextsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\patchcmd{\@addtocurcol}%
  {\vskip \intextsep}%
  {\edef\save@first@penalty{\the\lastpenalty}\unpenalty
   \ifnum \lastpenalty = \@M  % hopefully the OR penalty
     \unpenalty
   \else
     \penalty \save@first@penalty \relax % put it back
   \fi
   \ifnum\outputpenalty <-\@Mii
     \addvspace\intextsep
     \vskip\parskip
   \else
     \addvspace\intextsep
   \fi}%
  {}{\wzu@patch@error{\@addtocurcol}}
\patchcmd{\@addtocurcol}%
  {\vskip\intextsep \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi}%
  {\ifnum\outputpenalty <-\@Mii
     \aftergroup\vskip\aftergroup\intextsep
     \aftergroup\nointerlineskip
   \else
     \vskip\intextsep
   \fi}%
  {}{\wzu@patch@error{\@addtocurcol}}
\patchcmd{\@getpen}{\@M}{\@Mi}
  {}{\wzu@patch@error{\@getpen}}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\wzu@define@key{
  figure-number-separator = {
    name    = figure@number@separator,
    default = {.},
  },
  table-number-separator = {
    name    = table@number@separator,
    default = {.},
  },
  equation-number-separator = {
    name    = equation@number@separator,
    default = {.},
  },
  number-separator = {
    name    = number@separator,
    default = {.},
  },
}
\renewcommand\thefigure{%
  \ifnum\c@chapter>\z@
    \thechapter
    \wzu@figure@number@separator
  \fi
  \@arabic\c@figure
}
\renewcommand\thetable{%
  \ifnum\c@chapter>\z@
    \thechapter
    \wzu@table@number@separator
  \fi
  \@arabic\c@table
}
\renewcommand\theequation{%
  \ifnum\c@chapter>\z@
    \thechapter
    \wzu@equation@number@separator
  \fi
  \@arabic\c@equation
}
\newcommand\wzu@set@number@separator{%
  \let\wzu@figure@number@separator\wzu@number@separator
  \let\wzu@table@number@separator\wzu@number@separator
  \let\wzu@equation@number@separator\wzu@number@separator
}
\wzu@option@hook{number-separator}{\wzu@set@number@separator}
\DeclareCaptionFont{wzu}{%
  \ifwzu@degree@bachelor
    \fontsize{11bp}{15bp}\selectfont
  \else
    \ifwzu@language@chinese
      \fontsize{11bp}{14.3bp}\selectfont
    \else
      \fontsize{11bp}{12.65bp}\selectfont
    \fi
  \fi
}
\captionsetup{
  font           = wzu,
  labelsep       = quad,
  skip           = 6bp,
  figureposition = bottom,
  tableposition  = top,
}
\captionsetup[sub]{font=wzu}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\newcommand\wzu@set@table@font{
  \ifwzu@language@chinese
    \def\wzu@table@font{%
      \fontsize{11bp}{14.3bp}\selectfont
      \renewcommand\arraystretch{1.42}%
    }%
  \else
    \def\wzu@table@font{%
      \fontsize{11bp}{12.65bp}\selectfont
      \renewcommand\arraystretch{1.47}%
    }%
  \fi
}
\wzu@set@table@font
\wzu@option@hook{language}{\wzu@set@table@font}
\patchcmd\@floatboxreset{%
  \normalsize
}{%
  \wzu@table@font
}{}{\wzu@patch@error{\@floatboxreset}}
\AtEndOfPackageFile*{longtable}{
  \AtBeginEnvironment{longtable}{%
    \wzu@table@font
  }
}
\heavyrulewidth=1.5bp
\lightrulewidth=1bp
\AtEndOfPackageFile*{threeparttable}{
  \g@addto@macro\TPT@defaults{\wuhao}
}
\newcommand{\wzu@abstract@name}{摘\quad 要}
\newcommand{\wzu@abstract@name@en}{Abstract}
\ctexset{%
  chapter = {
    nameformat   = {},
    numberformat = {},
    titleformat  = {},
    fixskip      = true,
    afterindent  = true,
    lofskip      = 0pt,
    lotskip      = 0pt,
  },
  section = {
    afterindent  = true,
  },
  subsection = {
    afterindent  = true,
  },
  subsubsection = {
    afterindent  = true,
  },
  paragraph/afterindent = true,
  subparagraph/afterindent = true,
}
\newcommand\wzu@set@section@format{%
  \ifwzu@degree@bachelor
    \ctexset{%
      chapter = {
        format     = \centering\sffamily\fontsize{16bp}{20.8bp}\selectfont,
        titleformat = \wzu@stretch{3em},
        aftername  = \quad,
        beforeskip = 27bp,
        afterskip  = 27bp,
      },
      section = {
        format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
        aftername  = \quad,
        beforeskip = 24bp,
        afterskip  = 6bp,
      },
      subsection = {
        format     = \sffamily\fontsize{13bp}{20bp}\selectfont,
        aftername  = \quad,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
      subsubsection = {
        format     = \sffamily\fontsize{12bp}{20bp}\selectfont,
        aftername  = \quad,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
    }%
    \ifwzu@main@language@chinese
      \ctexset{
        chapter = {
          name   = {第,章},
          number = \thechapter,
        },
      }%
    \else
      \ctexset{
        chapter = {
          name   = \chaptername\space,
          number = \wzu@english@number{chapter},
        },
      }%
    \fi
  \else
    \ctexset{%
      chapter = {
        titleformat = {},
        beforeskip = 27bp,
        afterskip  = 27bp,
        number     = \thechapter,
      },
      section = {
        beforeskip = 24bp,
        afterskip  = 6bp,
      },
      subsection = {
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
      subsubsection = {
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
    }%
    \ifwzu@main@language@chinese
      \ctexset{%
        chapter = {
          format      = \centering\sffamily\sanhao,
          nameformat  = {},
          titleformat = {},
          name        = {第,章},
          aftername   = \quad,
        },
        section = {
          format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
          aftername  = \quad,
        },
        subsection = {
          format     = \sffamily\fontsize{13bp}{20bp}\selectfont,
          aftername  = \quad,
        },
        subsubsection = {
          format     = \sffamily\fontsize{12bp}{20bp}\selectfont,
          aftername  = \quad,
        },
      }%
    \else
      \ctexset{%
        chapter = {
          format      = \centering\sffamily\bfseries\fontsize{16bp}{20bp}\selectfont,
          nameformat  = \MakeUppercase,
          titleformat = \MakeUppercase,
          name        = \chaptername\space,
          aftername   = \space,
        },
        section = {
          format     = \sffamily\bfseries\fontsize{14bp}{20bp}\selectfont,
          aftername  = \space,
        },
        subsection = {
          format     = \sffamily\bfseries\fontsize{13bp}{20bp}\selectfont,
          aftername  = \space,
        },
        subsubsection = {
          format     = \sffamily\bfseries\fontsize{12bp}{20bp}\selectfont,
          aftername  = \space,
        },
      }%
    \fi
  \fi
}
\wzu@set@section@format
\wzu@option@hook{degree}{\wzu@set@section@format}
\wzu@option@hook{main-language}{\wzu@set@section@format}
\newcommand\wzu@english@number[1]{%
  \expandafter\ifcase\csname c@#1\endcsname
    Zero\or
    One\or
    Two\or
    Three\or
    Four\or
    Five\or
    Six\or
    Seven\or
    Eight\or
    Nine\or
    Ten\or
    Eleven\or
    Twelve\or
    Thirteen\or
    Fourteen\or
    Fifteen\or
    Sixteen\or
    Seventeen\or
    Eighteen\or
    Nineteen\or
    Twenty\or
    \wzu@error{You are genius}%
  \fi
}
\newcommand\wzu@pdfbookmark[2]{}
\newcommand\wzu@phantomsection{}
\NewDocumentCommand\wzu@chapter{s o m o}{%
  \IfBooleanF{#1}{%
    \wzu@error{You have to use the star form: \string\wzu@chapter*}%
  }%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \wzu@pdfbookmark{0}{#3}%
    }{%
      \wzu@phantomsection
      \addcontentsline{toc}{chapter}{#2}%
    }%
  }{%
    \wzu@phantomsection
    \addcontentsline{toc}{chapter}{#3}%
  }%
  \chapter*{#3}%
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}{%
      \@mkboth{}{}%
    }{%
      \@mkboth{#4}{#4}%
    }%
  }{%
    \@mkboth{#3}{#3}%
  }%
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
  \ifwzu@degree@graduate
    \wzu@chapter*{\contentsname}%
  \else
    \ifwzu@degree@bachelor
      \ctexset{chapter/titleformat = \wzu@stretch{2.5em}}%
      \wzu@chapter*[]{\contentsname}%
      \ctexset{chapter/titleformat = \wzu@stretch{3em}}%
    \else
      \wzu@chapter*[]{\contentsname}%
    \fi
  \fi
  \@starttoc{toc}%
}
\wzu@define@key{
  toc-chapter-style = {
    name = toc@chapter@style,
    choices = {
      arial,
      times,
    },
    default = arial,
  },
}
\wzu@option@hook{toc-chapter-style}{\wzu@deprecate{"toc-chapter-style" option}{}}
\newcommand\wzu@contents@label@delimiter{%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@chinese
      \space
    \else
      \quad
    \fi
  \else
    \quad
  \fi
}
\newcommand\wzu@leaders{\nobreak\titlerule*[4bp]{.}\nobreak}
\newcommand\wzu@set@toc@format{%
  \contentsmargin{\z@}%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@chinese
      \titlecontents{chapter}
        [0pt]{\sffamily}
        {\contentspush{\thecontentslabel\space}\wzu@stretch{3em}}{\wzu@stretch{3em}}
        {\rmfamily\wzu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\wzu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [2em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\wzu@leaders\thecontentspage}%
    \else
      \ifwzu@main@language@english
        \titlecontents{chapter}
          [\z@]{\addvspace{6bp}\sffamily}
          {\contentspush{\thecontentslabel\quad}}{}
          {\rmfamily\wzu@leaders\thecontentspage}%
        \titlecontents{section}
          [0.5cm]{}
          {\contentspush{\thecontentslabel\quad}}{}
          {\wzu@leaders\thecontentspage}%
        \titlecontents{subsection}
          [1cm]{}
          {\contentspush{\thecontentslabel\quad}}{}
          {\wzu@leaders\thecontentspage}%
      \fi
    \fi
  \else
    \ifwzu@main@language@chinese
      \titlecontents{chapter}
        [\z@]{\sffamily}
        {\contentspush{\thecontentslabel\quad}}{}
        {\rmfamily\wzu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\wzu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [2em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\wzu@leaders\thecontentspage}%
    \else
      \titlecontents{chapter}
        [\z@]{\heiti}
        {\contentspush{\MakeUppercase{\thecontentslabel}\space}\MakeUppercase}{\MakeUppercase}
        {\rmfamily\wzu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\wzu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [2em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\wzu@leaders\thecontentspage}%
    \fi
  \fi
}
\wzu@set@toc@format
\wzu@option@hook{degree}{\wzu@set@toc@format}
\wzu@option@hook{main-language}{\wzu@set@toc@format}
\wzu@define@key{
  secret-level = {
    name = secret@level,
  },
  secret-year = {
    name = secret@year,
  },
  title = {
    default = {标题},
  },
  title* = {
    default = {Title},
    name    = title@en,
  },
  author = {
    default = {姓名},
  },
  author* = {
    default = {Name of author},
    name    = author@en,
  },
  student-id = {
    name = student@id,
  },
  training-type = {
    default = {全曰制统招硕士},
    name = training@type,
  },
  degree-type ={
    default = {学术型},
    name = type@degree,
  },
  major = {
    default = {计算机科学与技术},
  },
  study-field ={
    default = {计算机视觉},
    name = {study@field},
  },
  supervisor = {
    default = {导师姓名},
  },
  supervisor* = {
    default = {Name of supervisor},
    name    = supervisor@en,
  },
  finish-date ={
    default = {2025.06.16},
    name = {finish@date}
  },
  associate-supervisor = {
    name = associate@supervisor,
  },
  associate-supervisor* = {
    name = associate@supervisor@en,
  },
  co-supervisor = {
    name = co@supervisor,
  },
  co-supervisor* = {
    name = co@supervisor@en,
  },
  % Reserved for compatibility
  joint-supervisor = {
    name = co@supervisor,
  },
  joint-supervisor* = {
    name = co@supervisor@en,
  },
  degree-category = {
    default = {工学博士},
    name    = degree@category,
  },
  degree-category* = {
    default = {Doctor of Philosophy},
    name    = degree@category@en,
  },
}
\wzu@define@key{
  department = {
    default = {计算机科学与技术系},
  },
  discipline = {
    % default = {计算机科学与技术},
  },
  discipline* = {
    % default = {Computer Science and Technology},
    name    = discipline@en,
  },
}
\wzu@option@hook{discipline}{%
  \ifwzu@degree@type@professional
    \wzu@warning{`discipline' for professional degree is deprecated. Use `professional-field' instead.}
    \let\wzu@professional@field\wzu@discipline
    \let\wzu@discipline\@empty
  \fi
}
\wzu@option@hook{discipline*}{%
  \ifwzu@degree@type@professional
    \wzu@warning{`discipline*' for professional degree is deprecated. Use `professional-field*' instead.}
    \let\wzu@professional@field@en\wzu@discipline@en
    \let\wzu@discipline@en\@empty
  \fi
}
\wzu@define@key{
  professional-field = {
    name    = professional@field,
  },
  professional-field* = {
    name    = professional@field@en,
  },
  engineering-field = {
    name    = engineering@field,
  },
  engineering-field* = {
    name    = engineering@field@en,
  },
  date = {
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  clc,
  udc,
  id,
  discipline-level-1 = {
    default = {一级学科名称},
    name    = discipline@level@i,
  },
  discipline-level-2 = {
    default = {二级学科名称},
    name    = discipline@level@ii,
  },
  start-date = {
    name    = start@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  end-date = {
    name    = end@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  include-spine = {
    name = include@spine,
    choices = {
      false,
      true,
    },
    default = false,
  },
}
\newcommand\wzu@format@date[2]{%
  \edef\wzu@@date{#2}%
  \def\wzu@@process@date##1-##2-##3\@nil{%
    #1{##1}{##2}{##3}%
  }%
  \expandafter\wzu@@process@date\wzu@@date\@nil
}
\newcommand\wzu@date@zh@digit[3]{#1 年 \number#2 月 \number#3 日}
\newcommand\wzu@date@zh@digit@short[3]{#1 年 \number#2 月}
\newcommand\wzu@date@zh@short[3]{\zhdigits{#1}年\zhnumber{#2}月}
\newcommand\wzu@date@month[1]{%
  \ifcase\number#1\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December%
  \fi
}
\newcommand\wzu@date@en@short[3]{\wzu@date@month{#2}, #1}
\newcommand\wzu@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newcommand\wzu@uline[2][6em]{\uline{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\wzu@fixed@box[2]{%
  \begingroup
    \ifLuaTeX
      \ltjsetparameter{kanjiskip = {0pt plus 2filll minus 1filll}}%
    \else
      \renewcommand\CJKglue{\hspace{0pt plus 2filll minus 1filll}}%
    \fi
    \makebox[#1][l]{#2}%
  \endgroup
}
\newbox\wzu@stretch@box
\newcommand\wzu@stretch[2]{%
  \sbox\wzu@stretch@box{#2}%
  \ifdim \wd\wzu@stretch@box < #1\relax
    \begingroup
      \ifLuaTeX
        \ltjsetparameter{kanjiskip = {0pt plus 2filll}}%
      \else
        \renewcommand\CJKglue{\hspace{0pt plus 2filll}}%
      \fi
      \makebox[#1][l]{#2}%
    \endgroup
  \else
    \box\wzu@stretch@box
  \fi
}
\newbox\wzu@pad@box
\newcommand\wzu@pad[2]{%
  \sbox\wzu@pad@box{#2}%
  \ifdim \wd\wzu@pad@box < #1\relax
    \makebox[#1][l]{\box\wzu@pad@box}%
  \else
    \box\wzu@pad@box
  \fi
}
\newcounter{wzu@csl@count}
\newcommand\wzu@name@title@process[1]{%
  \ifcase\c@wzu@csl@count  % == 0
    \gdef\wzu@@name{#1}%
  \or  % == 1
    \gdef\wzu@@title{#1}%
  \fi
  \stepcounter{wzu@csl@count}%
}
\newcommand\wzu@name@title@format[2]{%
  \wzu@pad{3cm}{\wzu@stretch{4em}{#1}}%
  \wzu@stretch{3em}{#2}%
}
\newcommand\wzu@name@title[1]{%
  \setcounter{wzu@csl@count}{0}%
  \gdef\wzu@@name{}%
  \gdef\wzu@@title{}%
  \expandafter\comma@parse\expandafter{#1}{\wzu@name@title@process}%
  \wzu@name@title@format{\wzu@@name}{\wzu@@title}%
}
\renewcommand\maketitle{%
  \cleardoublepage
  \pagenumbering{Alph}%
  \wzu@pdfbookmark{-1}{\wzu@title}%
  \wzu@titlepage
  \ifwzu@include@spine@true
    \spine
  \fi
  % \ifwzu@degree@graduate
  %   \ifwzu@thesis@type@thesis
  %     \cleardoublepage
  %     \wzu@titlepage@en
  %   \fi
  % \fi
  \clearpage
}
\newcommand\wzu@titlepage{%
  \wzusetup{language = chinese}%
  \ifwzu@degree@graduate
    % 研究生
    \wzu@titlepage@thesis
  \else
    \ifwzu@degree@bachelor
      % 本科生
      \wzu@titlepage@bachelor
    \else
      \ifwzu@degree@postdoc
        % 博后
        \wzu@cover@postdoc
        \cleardoublepage
        \wzu@titlepage@postdoc
      \fi
    \fi
  \fi
  \wzu@reset@main@language
}
\newcommand\wzu@titlepage@thesis{%
  \newgeometry{
    top     = 2cm,
    bottom  = 6cm,
    hmargin = 3.5cm,
  }%
  \thispagestyle{empty}%
  \null\vskip 8.1pt%
  \begingroup
    \centering
    \vskip 8pt
    \parbox[t][1.5cm][t]{\textwidth}{
      分类号: {\wzu@underline[6em]{\wzu@clc}} \hfill%
      % \setlength{\textwidth}{3em}
      UDC: {\wzu@underline[6em]{\wzu@udc}} \par
      % \setlength{\textwidth}{4em}
      学\hspace{1em}号: {\wzu@underline[6em]{\wzu@student@id}} \hfill%
      % \setlength{\textwidth}{13em}
      密级: {\wzu@underline[6em]{\wzu@secret@level}} \par
    }
    \vskip 16pt%
    \includegraphics[width=120bp]{wzu-text-logo.pdf}%
    \vskip 10pt
    \begingroup
      \sffamily\fontsize{26bp}{46.8bp}\selectfont
      硕士学位论文
    \endgroup
    \vskip 10pt%
    % \wzu@title@page@degree@category\par
    \includegraphics[width=70bp]{wzu-fig-logo.pdf}%
    \vskip 10pt%
    \begingroup
      \sffamily\fontsize{26bp}{46.8bp}\selectfont
      \wzu@title\par
    \endgroup
    \vfill
    \ifwzu@degree@type@academic
      \parbox[t][7.25cm][t]{\textwidth}{%
        \fangsong\fontsize{16bp}{31.2bp}\selectfont
        \wzu@titlepage@info
      }\par
    \else
      \parbox[t][5.25cm][b]{\textwidth}{%
        \fangsong\fontsize{16bp}{31.2bp}\selectfont
        \wzu@titlepage@info
      }\par
      \vskip 62pt%
    \fi
    % \parbox[t][1.03cm][t]{\textwidth}{\centering\wzu@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\wzu@set@student@id{%
  \ifwzu@thesis@type@proposal\else
    \ifx\wzu@student@id\@empty\else
      \wzu@warning{`student-id' in "\protect\wzusetup" would be ignored when `thesis-type' is not proposal.}%
    \fi
  \fi
}
\wzu@set@student@id
\wzu@option@hook{thesis-type}{\wzu@set@student@id}
\wzu@option@hook{student-id}{\wzu@set@student@id}
\newcommand\wzu@titlepage@secret{%
  \sffamily\sanhao
  \ifx\wzu@secret@level\@empty
    \phantom{秘密}%
  \else
    \wzu@secret@level\symbol{"2605}\makebox[3em][c]{\wzu@secret@year}年%
  \fi\par
}
\newcommand\wzu@title@page@degree@category{%
  \begingroup
    \fontsize{16bp}{22bp}\selectfont
    \ifLuaTeX
      \fontspec{\CJK@family}%
      \ltjsetparameter{kanjiskip = {1bp}}%
    \else
      \CJKfamily+{}%
      \renewcommand\CJKglue{\hspace{1bp}}%
    \fi
    \ifwzu@thesis@type@thesis
      (申请清华大学\wzu@degree@category
      \ifwzu@degree@type@professional
        专业%
      \fi
      学位论文)%
    \else
      \ifwzu@thesis@type@proposal
        (清华大学%
        \ifwzu@degree@doctor
          博士%
        \else
          \ifwzu@degree@master
            硕士%
          \fi
        \fi
        学位论文选题报告)%
      \fi
    \fi
    \par
  \endgroup
}
% \newcommand{\filluline}[2][6em]{\underline{\makebox[#1][c]{#2}}}
\newcommand\wzu@titlepage@info{%
  \wzu@titlepage@info@tabular{1.5cm}{2.75cm}{2.75cm}{0.5cm}{%
    \ifwzu@thesis@type@proposal
      \ifx\wzu@student@id\@empty
        \wzu@warning{Missing option `student-id' in "\protect\wzusetup", ID will not appear on cover.}%
      \else
        \wzu@info@item{学号}{}{\wzu@student@id}%
      \fi
    \fi
    \wzu@info@item{作者姓名}{\wzu@name@title}{\wzu@underline[12em]{\wzu@author}}%
    \wzu@info@item{培养类型}{\wzu@name@title}{\wzu@underline[12em]{\wzu@training@type}}%
    \wzu@info@item{学位类型}{\wzu@name@title}{\wzu@underline[12em]{\wzu@type@degree}}%
    \wzu@info@item{专业名称}{\wzu@name@title}{\wzu@underline[12em]{\wzu@major}}%
    \wzu@info@item{研究方向}{\wzu@name@title}{\wzu@underline[12em]{\wzu@study@field}}%
    \wzu@info@item{指导教师}{\wzu@name@title}{\wzu@underline[12em]{\wzu@supervisor}}%
    % \wzu@info@item{副指导教师}{\wzu@name@title}{\wzu@underline[12em]{\wzu@associate@supervisor}}%
    \wzu@info@item{完成日期}{\wzu@name@title}{\wzu@underline[12em]{\wzu@finish@date}}%
  }\par
}
\newcommand\wzu@titlepage@info@tabular[5]{%
  \def\wzu@info@item##1##2##3{%
    \ifx##3\@empty\else
      \wzu@pad{#2}{\wzu@fixed@box{#3}{##1}}%
      \wzu@pad{#4}{:}%
      ##2{##3}\\
    \fi
  }%
  \hspace{#1}%
  \begin{tabular}{l}%
    \renewcommand\arraystretch{1}%
    #5%
  \end{tabular}%
}
\newcommand\wzu@titlepage@date{%
  \begingroup
    \sanhao
    \ifLuaTeX
      \ltjsetparameter{kanjiskip = {1bp}}%
    \else
      \renewcommand\CJKglue{\hspace{1bp}}%
    \fi
    \wzu@format@date{\wzu@date@zh@short}{\wzu@date}\par
  \endgroup
}
\newcommand{\wzu@titlepage@en}{%
  \newgeometry{
    top     = 5.5cm,
    bottom  = 5cm,
    hmargin = 3.4cm,
  }%
  \thispagestyle{empty}%
  \wzusetup{language = english}%
  \ifwzu@degree@type@academic
    \wzu@titlepage@en@graduate@academic
  \else
    \wzu@titlepage@en@graduate@professional
  \fi
  \wzu@reset@main@language
  \clearpage
  \restoregeometry
}
\newcommand\wzu@titlepage@en@graduate@academic{%
  \begingroup
    \centering
    \null\vskip -0.31cm%
    \parbox[t][143bp][t]{\textwidth}{%
      \centering\wzu@titlepage@en@title
    }\par
    \sanhao[1.725]%
    \wzu@titlepage@en@degree
    \vskip 3bp%
    in\par
    \vskip 3.5bp%
    {\bfseries\sffamily\wzu@discipline@en\par}
    \vfill
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\wzu@author@en\par}%
    \vskip 0.18cm%
    \parbox[t][3.0cm][t]{\textwidth}{%
      \centering
      \xiaosan[2.1]%
      \wzu@titlepage@en@supervisor
    }\par
    \wzu@titlepage@en@date
    \vskip 0.7cm%
  \endgroup
}
\newcommand\wzu@titlepage@en@graduate@professional{%
  \begingroup
    \centering
    \null\vskip -0.31cm%
    \parbox[t][143bp][t]{\textwidth}{%
      \centering\wzu@titlepage@en@title
    }\par
    \sanhao[1.725]%
    \wzu@titlepage@en@degree
    \vfill
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\wzu@author@en\par}%
    \ifx\wzu@professional@field@en\empty
      \vskip 1.95cm%
    \else
      \vskip -0.1cm%
      {\sffamily\bfseries(\wzu@professional@field@en)\par}%
      \vskip 1.1cm%
    \fi
    \parbox[t][3.37cm][t]{\textwidth}{%
      \centering
      \xiaosan[1.82]%
      \wzu@titlepage@en@supervisor
    }\par
    \wzu@titlepage@en@date
    \vskip 0.3cm%
  \endgroup
}
\newcommand\wzu@titlepage@en@title{%
  \begingroup
    % 对齐到网格，每行 15.6bp
    \sffamily\bfseries\fontsize{20bp}{31.2bp}\selectfont
    \wzu@title@en\par
  \endgroup
}
\newcommand\wzu@thesis@name@en{%
  \ifwzu@degree@master
    Thesis%
  \else
    Dissertation%
  \fi
}
\newcommand\wzu@titlepage@en@degree{%
  \wzu@thesis@name@en{} submitted to\par
  {\bfseries Tsinghua University\par}%
  in partial fulfillment of the requirement\par
  for the
  \ifwzu@degree@type@professional
    professional
  \fi
  degree of\par
  {\sffamily\bfseries\wzu@degree@category@en\par}%
}
\newcommand\wzu@titlepage@en@supervisor{%
  \begin{tabular}{r@{\makebox[20.5bp][l]{\hspace{2bp}:}}l}%
    \renewcommand\arraystretch{1}%
    \wzu@thesis@name@en{} Supervisor & \wzu@supervisor@en \\
    \ifx\wzu@associate@supervisor@en\@empty\else
      Associate Supervisor           & \wzu@associate@supervisor@en \\
    \fi
    \ifx\wzu@co@supervisor@en\@empty\else
      Co-supervisor                  & \wzu@co@supervisor@en \\
    \fi
  \end{tabular}%
}
\newcommand\wzu@titlepage@en@date{%
  \begingroup
    \sffamily\bfseries\sanhao
    \wzu@format@date{\wzu@date@en@short}{\wzu@date}\par
  \endgroup
}
\newcommand\wzu@titlepage@bachelor{%
  \newgeometry{
    top    = 3.8cm,
    bottom = 3.2cm,
    left   = 3.2cm,  % 装订线靠左 0.2 cm
    right  = 3cm,
  }%
  \thispagestyle{empty}%
  \begingroup
    \centering
    \parbox[t][0cm][t]{\textwidth}{%
      \hfill
      \xiaosi
      \ifx\wzu@secret@level\@empty\else
        \wzu@secret@level\space\wzu@secret@year 年\par
      \fi
    }\par
  \endgroup
  \vspace{19bp}%
  \begingroup
    \centering
    \hspace*{-5bp}%
    \includegraphics[width=50.4bp]{wzu-fig-logo.pdf}%
    \hspace{10bp}%
    \raisebox{7bp}{\includegraphics[width=117bp]{wzu-text-logo.pdf}}%
    \par
    \vspace{17bp}%
    \begingroup
      \sffamily\bfseries\xiaochu\ziju{0.3}%
      综合论文训练%
      \ifwzu@thesis@type@proposal
        \\开题报告
      \fi
      \par
    \endgroup
    \vspace{48bp}%
    \parbox[t][136bp]{\linewidth}{%
      \centering
      \heiti\fontsize{26bp}{32.5bp}\selectfont
      \wzu@title\par
      \ifwzu@main@language@english
        \wzusetup{language=english}%
        \wzu@title@en\par
        \wzusetup{language=chinese}%
      \fi
    }\par
  \endgroup
  \begingroup
    \fangsong
    \fontsize{16bp}{30.96bp}\selectfont
    \noindent
    \def\wzu@name@title@format##1##2{%
      \wzu@stretch{4em}{##1}%
      \hspace{1.5em}%
      \wzu@stretch{2.5em}{##2}%
    }%
    \wzu@titlepage@info@tabular{81bp}{2.5cm}{4em}{0.82cm}{%
      \wzu@info@item{系别}{}{\wzu@department}%
      \wzu@info@item{专业}{}{\wzu@discipline}%
      \wzu@info@item{姓名}{\wzu@name@title}{\wzu@author}%
      \wzu@info@item{指导教师}{\wzu@name@title}{\wzu@supervisor}%
      \wzu@info@item{副指导教师}{\wzu@name@title}{\wzu@associate@supervisor}%
      \wzu@info@item{联合指导教师}{\wzu@name@title}{\wzu@co@supervisor}%
    }\par
  \endgroup
  \vfill
  \begingroup
    \centering
    \fontsize{16bp}{24bp}\selectfont
    \ziju{0.03}%
    \wzu@format@date{\wzu@date@zh@short}{\wzu@date}\par
  \endgroup
  \vspace*{60bp}%
  \clearpage
  \restoregeometry
}
\newcommand\wzu@cover@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \renewcommand\ULthickness{0.7pt}%
    \vspace*{0.35cm}%
    {\sihao[2.6]%
      \wzu@stretch{3.1em}{分类号}\wzu@underline[3.7cm]{\wzu@clc}\hfill
      密级\wzu@underline[3.7cm]{\wzu@secret@level}\par
      \wzu@stretch{3.1em}{U D C}\wzu@underline[3.7cm]{\wzu@udc}\hfill
      编号\wzu@underline[3.7cm]{\wzu@id}\par
    }%
    \vskip 3.15cm%
    {\sffamily\bfseries\xiaoer[2.6]%
      {\ziju{1.5}清华大学\par}%
      {\ziju{0.5}博士后研究工作报告\par}%
    }%
    \vskip 0.2cm%
    \parbox[t][4.0cm][c]{\textwidth}{%
      \centering\sihao[3.46]%
      \renewcommand\ULdepth{1em}%
      \expandafter\uline\expandafter{\wzu@title}\par
    }\par
    \vskip 0.4cm%
    {\xiaosi\wzu@author\par}%
    \vskip 1.4cm%
    {\xiaosi[1.58]%
      \renewcommand\ULdepth{0.9em}%
      工作完成日期\quad
      \wzu@uline[5.9cm]{%
        \wzu@format@date{\wzu@date@zh@digit@short}{\wzu@start@date}—%
        \wzu@format@date{\wzu@date@zh@digit@short}{\wzu@end@date}
      }\par
      \vskip 0.55cm%
      报告提交日期\quad
      \wzu@uline[5.9cm]{\wzu@format@date{\wzu@date@zh@digit@short}{\wzu@date}}\par
    }%
    \vskip 0.45cm%
    {\xiaosi[2]{\ziju{1}清华大学}\quad （北京）\par}%
    \vskip 0.25cm%
    {\xiaosi[2]\wzu@format@date{\wzu@date@zh@digit@short}{\wzu@date}\par}%
  \end{center}%
}
\newcommand\wzu@titlepage@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \vspace*{1.5cm}%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sanhao[1.95]\wzu@title\par
    }\par
    \vskip 0.15cm%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sihao[1.36]\wzu@title@en\par
    }\par
    \vskip 0.4cm%
    {\xiaosi[2.6]%
      \begin{tabular}{l@{\quad}l}%
        \renewcommand\arraystretch{1}%
        \wzu@stretch{11em}{博士后姓名}                  & \wzu@author           \\
        \wzu@stretch{11em}{流动站（一级学科）名称}      & \wzu@discipline@level@i  \\
        \wzu@stretch{11em}{专\quad{}业（二级学科）名称} & \wzu@discipline@level@ii \\
      \end{tabular}\par
    }%
    \vskip 2.7cm%
    {\xiaosi[2.6]%
      研究工作起始时间\quad\wzu@format@date{\wzu@date@zh@digit}{\wzu@start@date}\par
      \vskip 0.1cm%
      研究工作期满时间\quad\wzu@format@date{\wzu@date@zh@digit}{\wzu@end@date}\par
    }%
    \vskip 2.1cm%
    {\xiaosi[2.6]清华大学人事处（北京）\par}%
    \vskip 0.6cm%
    {\wuhao\wzu@format@date{\wzu@date@zh@digit@short}{\wzu@date}\par}%
  \end{center}%
}
\def\wzu@committee@name{学位论文指导小组、公开评阅人和答辩委员会名单}
\NewEnviron{committee}[1][]{%
  \ifwzu@degree@graduate
    \cleardoublepage
    \let\wzu@committee@file\@empty
    \kv@define@key{wzu@committee}{name}{\let\wzu@committee@name\kv@value}%
    \kv@define@key{wzu@committee}{file}{\let\wzu@committee@file\kv@value}%
    \kv@set@family@handler{wzu@committee}{%
      \ifx\kv@value\relax
        \let\wzu@committee@file\kv@key
      \else
        \kv@handled@false
      \fi
    }%
    \kvsetkeys{wzu@committee}{#1}%
    \ifx\wzu@committee@file\@empty
      \begingroup
        \ctexset{
          chapter = {
            format    = \centering\sffamily\fontsize{16bp}{20bp}\selectfont,
            afterskip = 49bp,
          },
          section = {
            beforeskip  =  26bp,
            afterskip   =  9.5bp,
            format      += \centering,
            numbering   =  false,
            afterindent =  false,
          },
        }%
        \wzu@chapter*[]{\wzu@committee@name}%
        \thispagestyle{empty}%
        \wzusetup{language=chinese}%
        \BODY\clearpage
        \wzu@reset@main@language
      \endgroup
    \else
      \wzu@pdfbookmark{0}{\wzu@committee@name}%
      \includepdf{\wzu@committee@file}%
    \fi
  \fi
}
\newcommand\copyrightpage[1][]{%
  \ifwzu@degree@postdoc\relax\else
    \cleardoublepage
    \def\wzu@@tmp{#1}
    \ifx\wzu@@tmp\@empty
      \wzusetup{language=chinese}%
      \ifwzu@degree@bachelor
        \wzu@copyright@page@bachelor
      \else
        \wzu@copyright@page@graduate
      \fi
      \clearpage
      \wzu@reset@main@language
    \else
      \thispagestyle{empty}%
      \wzu@pdfbookmark{0}{关于学位论文使用授权的说明}%
      \wzu@phantomsection
      \kv@define@key{wzu@copyright}{file}{\includepdf{\kv@value}}%
      \kv@set@family@handler{wzu@copyright}{%
        \ifx\kv@value\relax
          \includepdf{\kv@key}%
        \else
          \kv@handled@false
        \fi
      }%
      \kvsetkeys{wzu@copyright}{#1}%
    \fi
  \fi
}
\newcommand{\wzu@authorization@frontdate}{%
  日\ifwzu@degree@bachelor\hspace{1em}\else\hspace{2em}\fi 期：}
\newcommand\wzu@copyright@page@graduate{%
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao},
        beforeskip = 40bp,
        afterskip  = 36bp,
      },
    }%
    \wzu@chapter*[]{关于学位论文使用授权的说明}%
  \endgroup
  \thispagestyle{empty}%
  \vskip 13bp%
  \begingroup
    \fontsize{14bp}{26bp}\selectfont
    本人完全了解清华大学有关保留、使用学位论文的规定，即：\par
    清华大学拥有在著作权法规定范围内学位论文的使用权，其中包括：%
    （1）\nobreak 已获学位的研究生必须按学校规定提交学位论文，%
    学校可以采用影印、缩印或其他复制手段保存研究生上交的学位论文；\allowbreak
    （2）\nobreak 为教学和科研目的，学校可以将公开的学位论文作为资料在图书馆、资料室等场所供校内师生阅读，%
    或在校园网上供校内师生浏览部分内容；\allowbreak
    \ifwzu@degree@doctor
      （3）\nobreak 根据《中华人民共和国学位法》及上级教育主管部门具体要求，向国家图书馆报送相应的学位论文。%
    \else
      （3）\nobreak 按照上级教育主管部门督导、抽查等要求，报送相应的学位论文。%
    \fi
    \par
    本人保证遵守上述规定。\par
  \endgroup
  \vskip 33bp%
  \begingroup
    \fontsize{12bp}{23.4bp}\selectfont
    \parindent\z@
    \leftskip 43bp%
    作者签名：\hspace{4bp}\wzu@underline[7em]{}\hspace{47bp}%
    导师签名：\hspace{4bp}\wzu@underline[7em]{}\par
    \vskip 6bp%
    日\hspace{2em}期：\hspace{4bp}\wzu@underline[7em]{}\hspace{47bp}%
    日\hspace{2em}期：\hspace{4bp}\wzu@underline[7em]{}\par
  \endgroup
}
\newcommand\wzu@copyright@page@bachelor{%
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao},
        beforeskip = 40bp,
        afterskip  = 37bp,
      },
    }%
    \wzu@chapter*[]{关于论文使用授权的说明}%
  \endgroup
  \thispagestyle{empty}%
  \vspace*{13bp}%
  \begingroup
    \fontsize{14bp}{26bp}\selectfont
    本人完全了解清华大学有关保留、使用综合论文训练论文的规定，即：%
    学校有权保留论文的复印件，允许论文被查阅和借阅；%
    学校可以公布论文的全部或部分内容，可以采用影印、缩印或其他复制手段保存论文。\par
  \endgroup
  \vspace{71bp}%
  \begingroup
    \setlength{\parindent}{0pt}%
    \fontsize{12bp}{18bp}\selectfont
    \hspace*{42bp}作者签名：\hspace{118bp}导师签名：\par
    \vspace{11bp}%
    \hspace*{42bp}日\hspace{2em}期：\hspace{118bp}日\hspace{2em}期：\par
  \endgroup
}
\wzu@define@key{
  keywords,
  keywords* = {
    name = keywords@en,
  },
}
\newcommand\wzu@clist@use[2]{%
  \def\wzu@@tmp{}%
  \def\wzu@clist@processor##1{%
    \ifx\wzu@@tmp\@empty
      \def\wzu@@tmp{#2}%
    \else
      #2%
    \fi
    ##1%
  }%
  \expandafter\comma@parse\expandafter{#1}{\wzu@clist@processor}%
}
\newenvironment{abstract}{%
  \wzusetup{language = chinese}%
  \ifwzu@degree@graduate
    \begingroup
      \ifwzu@main@language@english
        \ctexset{%
          chapter/format = \centering\sffamily\fontsize{16bp}{20bp}\selectfont,
        }%
      \fi
      \wzu@chapter*{\wzu@abstract@name}%
    \endgroup
  \else
    \wzu@chapter*[]{\wzu@abstract@name}%
  \fi
}{%
  \par
  \null\par
  \ifwzu@degree@postdoc
    \textbf{关键词：}%
  \else
    \noindent
    \textsf{关键词：}%
  \fi
  \wzu@clist@use{\wzu@keywords}{；}\par
  \gdef\wzu@keywords{}%
  \wzu@reset@main@language % switch back to main language
}
\newenvironment{abstract*}{%
  \wzusetup{language = english}%
  \ifwzu@degree@bachelor
    \begingroup
      \ctexset{chapter/afterskip = 30bp}%
      \wzu@chapter*[]{\wzu@abstract@name@en}%
    \endgroup
  \else
    \ifwzu@degree@graduate
      \wzu@chapter*{\wzu@abstract@name@en}%
    \else
      \wzu@chapter*[]{\wzu@abstract@name@en}%
    \fi
  \fi
}{%
  \par
  \null\par
  \ifwzu@degree@postdoc\else
    \noindent
  \fi
  \textbf{Keywords:} \wzu@clist@use{\wzu@keywords@en}{; }\par
  \wzu@reset@main@language % switch back to main language
}
\newenvironment{denotation}[1][2.5cm]{%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@chinese
      \wzu@chapter*[]{\wzu@denotation@name}%
    \else
      \wzu@chapter*{\wzu@denotation@name}%
    \fi
  \else
    \ifwzu@degree@graduate
      \wzu@chapter*{\wzu@denotation@name}%
    \else
      \wzu@chapter*[]{\wzu@denotation@name}%
    \fi
  \fi
  \begin{wzu@denotation}[labelwidth=#1]%
}{%
  \end{wzu@denotation}%
}
\newlist{wzu@denotation}{description}{1}
\setlist[wzu@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\newcommand{\wzu@statement@text@bachelor}{%
  本人郑重声明：所呈交的综合论文训练论文，是本人在导师指导下，独立进行研究工作所取得的成果。%
  尽我所知，除文中已经注明引用的内容外，本论文的研究成果不包含任何他人享有著作权的内容。%
  对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。%
}
\newcommand{\wzu@statement@text@graduate}{%
  本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所取得的成果%
  \ifx\wzu@secret@level\@empty
    ，不包含涉及国家秘密的内容%
  \fi%
  。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人享有著作权的内容。%
  对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。%
}
\newcommand{\wzu@signature}{签\hspace{1em}名：}
\newcommand{\wzu@backdate}{日\hspace{1em}期：}
\newenvironment{acknowledgements}{%
  \@mainmatterfalse
  \wzu@end@appendix@ref@section
  \wzu@chapter*{\wzu@acknowledgements@name}%
}{%
}
\wzu@define@key{
  statement-page-style = {
    name = statement@page@style,
    choices = {
      auto,
      empty,
      plain,
    },
    default = auto,
  }
}
\newcommand\statement[1][]{%
  \@mainmatterfalse
  \wzu@end@appendix@ref@section
  \let\wzu@statement@file\@empty
  \kv@define@key{wzu@statement}{page-style}{\wzusetup{statement-page-style=##1}}%
  \kv@define@key{wzu@statement}{file}{\let\wzu@statement@file\kv@value}%
  \kv@set@family@handler{wzu@statement}{%
    \ifx\kv@value\relax
      \let\wzu@statement@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{wzu@statement}{#1}%
  \ifwzu@statement@page@style@auto
    \ifx\wzu@statement@file\@empty
      \wzusetup{statement-page-style = empty}%
    \else
      \wzusetup{statement-page-style = plain}%
    \fi
  \fi
  \ifx\wzu@statement@file\@empty
    \wzusetup{language=chinese}%
    \begingroup
      \ifwzu@degree@graduate
        \ifwzu@main@language@english
          \ctexset{%
            chapter/format = \centering\sffamily\fontsize{16bp}{20bp}\selectfont,
          }%
        \fi
      \fi
      \wzu@chapter*{\wzu@statement@name}%
    \endgroup
    \thispagestyle{\wzu@statement@page@style}%
    \ifwzu@degree@graduate
      \vspace{12bp}%
      \fontsize{12bp}{21bp}\selectfont
      \wzu@statement@text@graduate\par
      \vspace{79bp}%
      \begingroup
        \noindent\hspace{5.4cm}\fontsize{13bp}{18bp}\selectfont
        \wzu@signature\wzu@underline[2.8cm]{}\hspace{-6bp}%
        \wzu@backdate\wzu@underline[2.3cm]{}\par
      \endgroup
    \else
      \ifwzu@degree@bachelor
        \begingroup
          \renewcommand\CJKglue{\hspace{.1bp}}%
          \wzu@statement@text@bachelor\par
        \endgroup
        \vspace{40bp}%
        \hfill 签\hspace{.5em}名：\wzu@underline[2.75cm]{}\hspace{.5em}%
        日\hspace{.5em}期：\wzu@underline[2.75cm]{}\par
      \fi
    \fi
    \wzu@reset@main@language
  \else
    \includepdf[pagecommand={%
      \markboth{\wzu@statement@name}{}%
      \wzu@phantomsection
      \addcontentsline{toc}{chapter}{\wzu@statement@name}%
      \thispagestyle{\wzu@statement@page@style}%
    }]{\wzu@statement@file}%
  \fi
}
\let\acknowledgement\acknowledgements
\let\endacknowledgement\endacknowledgements
\def\wzu@listof#1{% #1: float type
  \setcounter{tocdepth}{2}%  restore tocdepth in case being modified
  \@ifstar{\wzu@deprecate{starred form of \protect\listof... command}{}}{}%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@chinese
      \wzu@chapter*[]{\csname list#1name\endcsname}%
    \else
      \wzu@chapter*{\csname list#1name\endcsname}%
    \fi
  \else
    \ifwzu@degree@graduate
      \wzu@chapter*{\csname list#1name\endcsname}%
    \else
      \wzu@chapter*[]{\csname list#1name\endcsname}%
    \fi
  \fi
  \@starttoc{\csname ext@#1\endcsname}%
}
\renewcommand\listoffigures{%
  \wzu@listof{figure}%
}
\titlecontents{figure}
  [\z@]{}
  {\contentspush{\figurename~\thecontentslabel\wzu@contents@label@delimiter}}{}
  {\wzu@leaders\thecontentspage}
\renewcommand\listoftables{%
  \wzu@listof{table}%
}
\titlecontents{table}
  [\z@]{}
  {\contentspush{\tablename~\thecontentslabel\wzu@contents@label@delimiter}}{}
  {\wzu@leaders\thecontentspage}
\newcommand\listoffiguresandtables{%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@chinese
      \wzu@chapter*[]{\wzu@list@figure@table@name}%
    \else
      \wzu@chapter*{\wzu@list@figure@table@name}%
    \fi
  \else
    \ifwzu@degree@graduate
      \wzu@chapter*{\wzu@list@figure@table@name}%
    \else
      \wzu@chapter*[]{\wzu@list@figure@table@name}%
    \fi
  \fi
  \@starttoc{lof}%
  \par
  \null\par
  \@starttoc{lot}%
}
\def\ext@equation{loe}
\def\equcaption#1{%
  \wzu@deprecate{"\protect\equcaption" command}{}%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{%
  \wzu@deprecate{"\protect\listofequations" command}{}%
  \wzu@listof{equation}%
}
\titlecontents{equation}
  [0pt]{\addvspace{6bp}}
  {\contentspush{\wzu@equation@name~\thecontentslabel\wzu@contents@label@delimiter}}{}
  {\wzu@leaders\thecontentspage}
\contentsuse{equation}{loe}
\wzu@define@key{
  cite-style = {
    name = cite@style,
    choices = {
      super,
      inline,
      author-year,
    }
  }
}
\def\bibliographystyle#1{%
  \gdef\bu@bibstyle{#1}%
  \ifx\@begindocumenthook\@undefined\else
    \expandafter\AtBeginDocument
  \fi
    {\if@filesw
       \immediate\write\@auxout{\string\bibstyle{#1}}%
       \immediate\write\@auxout{\string\gdef\string\bu@bibstyle{#1}}%
     \fi}%
}
\def\bibliography#1{%
  \if@filesw
    \immediate\write\@auxout{\string\bibdata{\zap@space#1 \@empty}}%
    \immediate\write\@auxout{\string\gdef\string\bu@bibdata{#1}}%
  \fi
  \gdef\bu@bibdata{#1}%
  \@input@{\jobname.bbl}}
\PassOptionsToPackage{compress}{natbib}
\AtEndOfPackageFile*{natbib}{
  \DeclareRobustCommand\inlinecite{\@inlinecite}
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
  \let\onlinecite\inlinecite
  \newcommand\bibstyle@super{%
    \bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
  \newcommand\bibstyle@inline{%
    \bibpunct{[}{]}{,}{n}{,}{,}}
  \@namedef{bibstyle@author-year}{%
    \bibpunct{(}{)}{;}{a}{,}{,}}
  \wzu@option@hook{cite-style}{\@nameuse{bibstyle@\wzu@cite@style}}
  \@namedef{bibstyle@wzuthesis-numeric}{\citestyle{super}}
  \@namedef{bibstyle@wzuthesis-author-year}{\citestyle{author-year}}
  \@namedef{bibstyle@cell}{\citestyle{author-year}}
  \@namedef{bibstyle@wzuthesis-bachelor}{\citestyle{super}}
  \renewcommand\NAT@citesuper[3]{%
    \ifNAT@swa
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close}%
      %  \if*#3*\else\NAT@spacechar#3\fi\else #1\fi\endgroup}
      \unskip\kern\p@
      \textsuperscript{%
        \NAT@@open#1\NAT@@close
        \if*#3*\else#3\fi
      }%
      \kern\p@
    \else
      #1%
    \fi
    \endgroup
  }
  \renewcommand\NAT@citenum[3]{%
    \ifNAT@swa
      \NAT@@open
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close
      #1\NAT@@close
      \if*#3*\else
        \textsuperscript{#3}%
      \fi
    \else
      #1%
    \fi
    \endgroup
  }
  \def\NAT@citexnum[#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\def\NAT@num{-1}\let\NAT@last@yr\relax\let\NAT@nm\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{%
        {\reset@font\bfseries?}
          \NAT@citeundefined\PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}}%
      {\let\NAT@last@num\NAT@num\let\NAT@last@nm\NAT@nm
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
        \ifNAT@full\let\NAT@nm\NAT@all@names\else
          \let\NAT@nm\NAT@name\fi
        \ifNAT@swa
        \@ifnum{\NAT@ctype>\@ne}{%
          \@citea
          \NAT@hyper@{\@ifnum{\NAT@ctype=\tw@}{\NAT@test{\NAT@ctype}}{\NAT@alias}}%
        }{%
          \@ifnum{\NAT@cmprs>\z@}{%
          \NAT@ifcat@num\NAT@num
            {\let\NAT@nm=\NAT@num}%
            {\def\NAT@nm{-2}}%
          \NAT@ifcat@num\NAT@last@num
            {\@tempcnta=\NAT@last@num\relax}%
            {\@tempcnta\m@ne}%
          \@ifnum{\NAT@nm=\@tempcnta}{%
            \@ifnum{\NAT@merge>\@ne}{}{\NAT@last@yr@mbox}%
          }{%
            \advance\@tempcnta by\@ne
            \@ifnum{\NAT@nm=\@tempcnta}{%
              % \ifx\NAT@last@yr\relax
              %   \def@NAT@last@yr{\@citea}%
              % \else
              %   \def@NAT@last@yr{--\NAT@penalty}%
              % \fi
              \def@NAT@last@yr{-\NAT@penalty}%
            }{%
              \NAT@last@yr@mbox
            }%
          }%
          }{%
          \@tempswatrue
          \@ifnum{\NAT@merge>\@ne}{\@ifnum{\NAT@last@num=\NAT@num\relax}{\@tempswafalse}{}}{}%
          \if@tempswa\NAT@citea@mbox\fi
          }%
        }%
        \NAT@def@citea
        \else
          \ifcase\NAT@ctype
            \ifx\NAT@last@nm\NAT@nm \NAT@yrsep\NAT@penalty\NAT@space\else
              \@citea \NAT@test{\@ne}\NAT@spacechar\NAT@mbox{\NAT@super@kern\NAT@@open}%
            \fi
            \if*#1*\else#1\NAT@spacechar\fi
            \NAT@mbox{\NAT@hyper@{{\citenumfont{\NAT@num}}}}%
            \NAT@def@citea@box
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space\NAT@alias
          \fi
        \fi
      }%
      }%
        \@ifnum{\NAT@cmprs>\z@}{\NAT@last@yr}{}%
        \ifNAT@swa\else
          % \@ifnum{\NAT@ctype=\z@}{%
          %   \if*#2*\else\NAT@cmt#2\fi
          % }{}%
          \NAT@mbox{\NAT@@close}%
          \@ifnum{\NAT@ctype=\z@}{%
            \if*#2*\else
              \textsuperscript{#2}%
            \fi
          }{}%
          \NAT@super@kern
        \fi
    }{#1}{#2}%
  }%
  \renewcommand\NAT@cite%
      [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
          % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
          #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
  \def\NAT@citex%
    [#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
        {\reset@font\bfseries ?}\NAT@citeundefined
                  \PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
      {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
      \ifNAT@full\let\NAT@nm\NAT@all@names\else
        \let\NAT@nm\NAT@name\fi
      \ifNAT@swa\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}%
        \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else\unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{%
                \NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb
              }%
              \NAT@date
            }%
          \fi
        \fi
      \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
      \or\@citea\NAT@hyper@{\NAT@date}%
      \or\@citea\NAT@hyper@{\NAT@alias}%
      \fi \NAT@def@citea
      \else
        \ifcase\NAT@ctype
          \if\relax\NAT@date\relax
            \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
          \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else
                \unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
                {\@citeb\@extra@b@citeb}%
              \NAT@date
            }%
          \fi
          \fi
        \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
        \or\@citea\NAT@hyper@{\NAT@date}%
        \or\@citea\NAT@hyper@{\NAT@alias}%
        \fi
        \if\relax\NAT@date\relax
          \NAT@def@citea
        \else
          \NAT@def@citea@close
        \fi
      \fi
      }}\ifNAT@swa\else
        % \if*#2*\else\NAT@cmt#2\fi
        \if\relax\NAT@date\relax\else\NAT@@close\fi
        \if*#2*\else\textsuperscript{#2}\fi
      \fi}{#1}{#2}}
  \renewcommand\bibsection{\wzu@chapter*{\bibname}}
  \newcommand\wzu@set@bibliography@format{%
    \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
    \setlength{\bibsep}{3bp \@plus 3bp \@minus 3bp}%
    \ifwzu@degree@bachelor
      \ifwzu@main@language@chinese
        \setlength{\bibhang}{1cm}%
      \else
        \renewcommand\bibfont{\fontsize{10.5bp}{17bp}\selectfont}%
        \setlength{\bibsep}{6bp \@plus 3bp \@minus 3bp}%
        \setlength{\bibhang}{0.5in}%
      \fi
    \else
      \setlength{\bibhang}{1cm}%
    \fi
  }
  \wzu@set@bibliography@format
  \wzu@option@hook{degree}{\wzu@set@bibliography@format}
  \wzu@option@hook{main-language}{\wzu@set@bibliography@format}
  \patchcmd\thebibliography{%
    \clubpenalty4000%
  }{%
    \interlinepenalty=5000\relax
    \clubpenalty=10000\relax
  }{}{\wzu@patch@error{\thebibliography}}
  \patchcmd\thebibliography{%
    \widowpenalty4000%
  }{%
    \widowpenalty=10000\relax
  }{}{\wzu@patch@error{\thebibliography}}
  \def\@biblabel#1{[#1]\hfill}
  \renewcommand\NAT@bibsetnum[1]{%
    % \settowidth\labelwidth{\@biblabel{#1}}%
    % \setlength{\leftmargin}{\labelwidth}%
    % \addtolength{\leftmargin}{\labelsep}%
    \setlength{\leftmargin}{1cm}%
    \setlength{\itemindent}{\z@}%
    \setlength{\labelsep}{0.1cm}%
    \setlength{\labelwidth}{0.9cm}%
    \setlength{\itemsep}{\bibsep}
    \setlength{\parsep}{\z@}%
    \ifNAT@openbib
      \addtolength{\leftmargin}{\bibindent}%
      \setlength{\itemindent}{-\bibindent}%
      \setlength{\listparindent}{\itemindent}%
      \setlength{\parsep}{0pt}%
    \fi
  }
}
\AtEndOfPackageFile*{biblatex}{
  \AtBeginDocument{
    \ifthenelse{\equal{\blx@bbxfile}{apa}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{apa6}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla}}{\def\bibname{WORKS CITED}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla-new}}{\def\bibname{WORKS CITED}}{}
  }
  \DeclareRobustCommand\inlinecite{\parencite}
  \defbibheading{bibliography}[\bibname]{\wzu@chapter*{\bibname}}
  \newcommand\wzu@set@bibliography@format{%
    \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
    \setlength{\bibitemsep}{3bp \@plus 3bp \@minus 3bp}%
    \ifwzu@degree@bachelor
      \ifwzu@main@language@chinese
        \setlength{\bibhang}{1cm}%
      \else
        \renewcommand\bibfont{\fontsize{10.5bp}{17bp}\selectfont}%
        \setlength{\bibitemsep}{6bp \@plus 3bp \@minus 3bp}%
        \setlength{\bibhang}{0.5in}%
      \fi
    \else
      \setlength{\biblabelsep}{0.1cm}%
      \setlength{\bibhang}{1cm}%
    \fi
  }
  \wzu@set@bibliography@format
  \wzu@option@hook{degree}{\wzu@set@bibliography@format}
  \wzu@option@hook{main-language}{\wzu@set@bibliography@format}
}
\AtEndOfPackageFile*{apacite}{
  \AtBeginDocument{
    \wzu@set@chapter@names
  }
  \renewcommand\bibliographytypesize{\fontsize{10.5bp}{16bp}\selectfont}
  \setlength{\bibitemsep}{3bp \@plus 3bp \@minus 3bp}%
  \ifwzu@degree@bachelor
    \ifwzu@main@language@english
      \renewcommand\bibliographytypesize{\fontsize{10.5bp}{17bp}\selectfont}%
      \setlength{\bibitemsep}{6bp \@plus 3bp \@minus 3bp}%
    \fi
  \fi
  \ifwzu@main@language@chinese
    \setlength{\bibleftmargin}{1cm}
    \setlength{\bibindent}{-\bibleftmargin}
  \else
    \setlength{\bibleftmargin}{0.5in}
    \setlength{\bibindent}{-\bibleftmargin}
  \fi
  \def\st@rtbibchapter{%
    \if@numberedbib%
      \chapter{\bibname}%   e.g.,   6. References
    \else%
      \wzu@chapter*{\bibname}%   e.g.,   References
    \fi%
  }%
}
\g@addto@macro\appendix{%
  \@mainmattertrue
}
\wzu@define@key{
  toc-depth = {
    name = toc@depth,
  },
}
\wzu@option@hook{toc-depth}{%
  \ifx\@begindocumenthook\@undefined
    \protected@write\@auxout{}{%
      \string\ttl@writefile{toc}{%
        \protect\setcounter{tocdepth}{\wzu@toc@depth}%
      }%
    }%
  \else
    \setcounter{tocdepth}{\wzu@toc@depth}%
  \fi
}
\g@addto@macro\appendix{%
  \wzusetup{
    toc-depth = 0,
  }%
}
\wzu@define@key{
  appendix-figure-in-lof = {
    name = appendix@figure@in@lof,
    choices = {
      true,
      false,
    },
    default = false,
  },
}
\wzu@option@hook{appendix-figure-in-lof}{%
  \ifwzu@appendix@figure@in@lof@true
    \addtocontents{lof}{\string\let\string\contentsline\string\ttl@contentsline}%
    \addtocontents{lot}{\string\let\string\contentsline\string\ttl@contentsline}%
    \addtocontents{loe}{\string\let\string\contentsline\string\ttl@contentsline}%
  \else
    \addtocontents{lof}{\string\let\string\contentsline\string\ttl@gobblecontents}%
    \addtocontents{lot}{\string\let\string\contentsline\string\ttl@gobblecontents}%
    \addtocontents{loe}{\string\let\string\contentsline\string\ttl@gobblecontents}%
  \fi
}
\g@addto@macro\appendix{%
  \wzusetup{
    appendix-figure-in-lof = false,
  }%
}
\newcommand\wzu@end@appendix@ref@section{}
\AtBeginOfPackageFile*{bibunits}{
  \def\bibliography#1{%
    \if@filesw
      \immediate\write\@auxout{\string\bibdata{\zap@space#1 \@empty}}%
      \immediate\write\@auxout{\string\gdef\string\bu@bibdata{#1}}%
    \fi
    \@input@{\jobname.bbl}%
    \gdef\bu@bibdata{#1}%
  }
  \def\bibliographystyle#1{%
    \ifx\@begindocumenthook\@undefined\else
      \expandafter\AtBeginDocument
    \fi
      {\if@filesw
        \immediate\write\@auxout{\string\bibstyle{#1}}%
        \immediate\write\@auxout{\string\gdef\string\bu@bibstyle{#1}}%
      \fi}%
      \gdef\bu@bibstyle{#1}%
  }
}
\AtEndOfPackageFile*{bibunits}{
  \def\@startbibunit{%
    \global\let\@startbibunitorrelax\relax
    \global\let\@finishbibunit\@finishstartedbibunit
    \global\advance\@bibunitauxcnt 1
    \if@filesw
      {\endlinechar-1
      \makeatletter
      \@input{\@bibunitname.aux}}%
      \immediate\openout\@bibunitaux\@bibunitname.aux
      \immediate\write\@bibunitaux{\string\bibstyle{\@localbibstyle}}%
    \fi
  }
  \def\bu@bibliography#1{%
    \putbib[#1]%
  }
  \def\bu@bibliographystyle#1{%
    \if@filesw
      \immediate\write\@bibunitaux{\string\gdef\string\@localbibstyle{#1}}%
    \fi
    \gdef\@localbibstyle{#1}%
  }
  \providecommand\printbibliography{\putbib\relax}%
  \g@addto@macro\appendix{%
    \renewcommand\@bibunitname{\jobname-appendix-\@alph\c@chapter}%
    \bibliographyunit[\chapter]%
    \renewcommand\bibsection{%
      \ctexset{section/numbering = false}%
      \section{\bibname}%
      \ctexset{section/numbering = true}%
    }%
    \ifwzu@degree@graduate
      \renewcommand\citenumfont{\@Alph\c@chapter.}%
      \renewcommand\@extra@binfo{@-\@alph\c@chapter}%
      \renewcommand\@extra@b@citeb{@-\@alph\c@chapter}%
      \renewcommand\bibnumfmt[1]{[\@Alph\c@chapter.#1]\hfill}%
    \fi
  }
  \renewcommand\wzu@end@appendix@ref@section{%
    \bibliographyunit\relax
  }
  \AtEndDocument{\wzu@end@appendix@ref@section}
  \renewcommand\wzu@set@survey@bibheading{%
    \renewcommand\bibsection{%
      \begingroup
        \ctexset{
          section = {
            numbering = false,
            format = \centering\normalsize,
            beforeskip = 20pt,
            afterskip = 4pt,
          },
        }%
        \section{\bibname}%
      \endgroup
    }
  }%
  % \let\@xtestdef\@gobbletwo  % This doesn't work
  \def\bibunits@rerun@warning{\relax}
}
\PassOptionsToPackage{defernumbers = true}{biblatex}
\AtEndOfPackageFile*{biblatex}{
  \DeclareRefcontext{appendix}{}
  \g@addto@macro\appendix{%
    \pretocmd\chapter{%
      \newrefsection
      \ifwzu@degree@bachelor\else
        \@tempcnta=\c@chapter
        \advance\@tempcnta\@ne
        \newrefcontext[labelprefix = {\@Alph\@tempcnta.}]{appendix}%
      \fi
    }{}{\wzu@patch@error{\chapter}}%
    \defbibheading{bibliography}[\bibname]{%
      \ctexset{section/numbering = false}%
      \section{#1}%
      \ctexset{section/numbering = true}%
    }%
  }
  \renewcommand\wzu@set@survey@bibheading{%
    \defbibheading{bibliography}[\bibname]{%
      \vspace{20bp}%
      \begingroup
        \ctexset{
          section = {
            numbering = false,
            format = \centering\normalsize,
            beforeskip = 0pt,
            afterskip = 0pt,
          },
        }%
        \section{\bibname}%
      \endgroup
    }%
  }%
  \def\bibliographystyle#1{%
    \wzu@warning{'bibliographystyle' invalid for 'biblatex'.}%
  }
}
\@ifpackagelater{titletoc}{2019/07/14}{
  \newcommand\wzu@print@contents[5]{%
    \printcontents[#1]{#2}{#3}[#4]{}%
  }
}{
  \newcommand\wzu@print@contents[5]{%
    \printcontents[#1]{#2}{#3}{\setcounter{tocdepth}{#4}#5}%
  }
}
\newenvironment{survey}{%
  \chapter{外文资料的调研阅读报告}%
  \wzusetup{language = english}%
  \let\title\wzu@appendix@title
  \let\maketitle\wzu@appendix@maketitle
  \wzu@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{Contents}%
    \wzu@pdfbookmark{1}{Contents}%
    \wzu@print@contents{survey}{l}{1}{2}{}%
    \vskip 20bp%
  }%
  \let\appendix\wzu@appendix@appendix
  \wzu@set@survey@bibheading
  \renewcommand\bibname{参考文献}%
  \startcontents[survey]%
}{%
  \stopcontents[survey]%
  \wzu@reset@main@language % restore language
}
\newcommand\wzu@set@appendix@bib@heading{}
\newenvironment{translation}{%
  \chapter{外文资料的书面翻译}%
  \wzusetup{language = chinese}%
  \let\title\wzu@appendix@title
  \let\maketitle\wzu@appendix@maketitle
  \renewenvironment{abstract}{%
    \ctexset{
      section = {
        format    += \centering,
        numbering  = false,
      },
    }%
    \section{摘要}%
  }{%
    \par
    \ifx\wzu@keywords\@empty\else
      \textbf{关键词：}\wzu@clist@use{\wzu@keywords}{；}\par
    \fi
  }%
  \wzu@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{目录}%
    \wzu@pdfbookmark{1}{目录}%
    \wzu@print@contents{translation}{l}{1}{2}{}%
    \vskip 20bp%
  }%
  \let\appendix\wzu@appendix@appendix
  \wzu@set@survey@bibheading
  \startcontents[translation]%
}{%
  \stopcontents[translation]%
  \wzu@reset@main@language % restore language
}
\newenvironment{translation-index}{}{}
\AtEndOfPackageFile*{bibunits}{
  \newcounter{wzu@translation@index}%
  \renewenvironment{translation-index}{%
    \global\advance\c@wzu@translation@index\@ne
    \begin{bibunit}%
      \renewcommand\@bibunitname{\jobname-index-\arabic{wzu@translation@index}}%
      \renewcommand\bibname{书面翻译对应的原文索引}%
      \wzu@set@survey@bibheading
  }{%
    \end{bibunit}%
  }
}
\AtEndOfPackageFile*{biblatex}{
  \renewenvironment{translation-index}{%
    \endrefsection
    \begin{refsection}%
      \renewcommand\bibname{书面翻译对应的原文索引}%
      \wzu@set@survey@bibheading
  }{%
    \end{refsection}%
  }
}
\DeclareRobustCommand\wzu@appendix@title[1]{\gdef\wzu@appendix@@title{#1}}
\newcommand\wzu@appendix@maketitle{%
  \par
  \begin{center}%
    \xiaosi[1.667]\wzu@appendix@@title
  \end{center}%
  \par
}
\newcommand\wzu@set@partial@toc@format{%
  \titlecontents{section}
    [\z@]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\wzu@leaders\thecontentspage}%
  \titlecontents{subsection}
    [1em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\wzu@leaders\thecontentspage}%
  \titlecontents{subsubsection}
    [2em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\wzu@leaders\thecontentspage}%
}
\newcommand\wzu@appendix@appendix{%
  \def\theHsection{\Hy@AlphNoErr{section}}%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand\thesection{\thechapter.\@Alph\c@section}%
}%
\newcommand\wzu@set@survey@bibheading{}
\newenvironment{resume}{%
  \@mainmatterfalse
  \wzu@end@appendix@ref@section
  \wzu@chapter*{\wzu@resume@name}%
  \ctexset{section/numbering = false}%
  \ifwzu@degree@bachelor
    \ctexset{section/aftertitle = {：\@@par}}%
  \else
    \ctexset{section/format += \centering}%
  \fi
  \ifwzu@language@chinese
    \ctexset{
      subsection = {
        format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
        numbering  = false,
        aftertitle = {：\@@par},
      },
    }%
    \setlist[achievements]{
      topsep     = 6bp,
      itemsep    = 6bp,
      leftmargin = 1cm,
      labelwidth = 1cm,
      labelsep   = 0pt,
      first      = {
        \ifwzu@degree@graduate
          \fontsize{12bp}{16bp}\selectfont
        \fi
      },
      align      = left,
      label      = [\arabic*],
      resume     = achievements,
    }%
  \else
    \ctexset{
      subsection = {
        beforeskip = 0pt,
        afterskip  = 0pt,
        format     = \bfseries\normalsize,
        indent     = \parindent,
        numbering  = false,
      },
    }%
    \ifwzu@degree@bachelor
      % 内容部分用Arial字体，字号15pt，行距采用固定值20pt， 段前后 0pt。
      \sffamily\fontsize{15bp}{20bp}\selectfont
    \fi
    \setlist[achievements]{
      topsep     = 0bp,
      itemsep    = 0bp,
      leftmargin = 1.75cm,
      labelsep   = 0.5cm,
      align      = right,
      label      = [\arabic*],
      resume     = achievements,
    }%
  \fi
}{}
\newcommand\resumeitem[1]{%
  \wzu@error{The "\protect\resumeitem" is obsolete. Please update to the new format}%
}
\newcommand\researchitem[1]{%
  \wzu@error{The "\protect\researchitem" is obsolete. Please update to the new format}%
}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{
  topsep     = 6bp,
  partopsep  = 0bp,
  itemsep    = 6bp,
  parsep     = 0bp,
  leftmargin = 10mm,
  itemindent = 0pt,
  align      = left,
  label      = [\arabic*],
  resume     = achievements,
}
\newenvironment{publications}{%
  \wzu@deprecate{"publications" environment}{"achievements"}%
  \begin{achievements}%
}{%
  \end{achievements}%
}
\newcommand\publicationskip{%
  \wzu@error{The "\protect\publicationskip" is obsolete. Do not use it}%
}
\NewEnviron{comments}[1][]{%
  \wzu@end@appendix@ref@section
  \ifwzu@degree@graduate
    \@mainmatterfalse
    \kv@define@key{wzu@comments}{name}{\let\wzu@comments@name\kv@value}%
    \kv@set@family@handler{wzu@comments}{%
      \ifx\kv@value\relax
        \let\wzu@comments@name\kv@key
      \else
        \kv@handled@false
      \fi
    }%
    \kvsetkeys{wzu@comments}{#1}%
    \chapter{\wzu@comments@name}%
    \BODY\clearpage
  \fi
}
\NewEnviron{resolution}{%
  \wzu@end@appendix@ref@section
  \ifwzu@degree@graduate
    \@mainmatterfalse
    \chapter{\wzu@resolution@name}%
    \BODY\clearpage
  \fi
}
\newcommand{\record}[1]{%
  \ifwzu@degree@bachelor
    \let\wzu@record@file\@empty
    \kv@define@key{wzu@record}{file}{\let\wzu@record@file\kv@value}%
    \kv@set@family@handler{wzu@record}{%
      \ifx\kv@value\relax
        \let\wzu@record@file\kv@key
      \else
        \kv@handled@false
      \fi
    }%
    \kvsetkeys{wzu@record}{#1}%
    \ifx\wzu@record@file\@empty
      \wzu@error{File path of \protect\record\space is required}
    \fi
    \clearpage
    \wzu@pdfbookmark{0}{综合论文训练记录表}%
    \includepdf[pages=-]{\wzu@record@file}%
  \fi
}
\PassOptionsToPackage{
  linktoc            = all,
  bookmarksdepth     = 2,
  bookmarksnumbered  = true,
  bookmarksopen      = true,
  bookmarksopenlevel = 1,
  bookmarksdepth     = 3,
  unicode            = true,
  psdextra           = true,
  breaklinks         = true,
  plainpages         = false,
  pdfdisplaydoctitle = true,
  hidelinks,
}{hyperref}
\AtEndOfPackageFile*{hyperref}{
  \newcounter{wzu@bookmark}
  \renewcommand\wzu@pdfbookmark[2]{%
    \phantomsection
    \stepcounter{wzu@bookmark}%
    \pdfbookmark[#1]{#2}{wzuchapter.\thewzu@bookmark}%
  }
  \renewcommand\wzu@phantomsection{%
    \phantomsection
  }
  \pdfstringdefDisableCommands{%
    \let\\\relax
    \let\quad\relax
    \let\qquad\relax
    \let\hspace\@gobble
  }%
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}
  }%
  \ifwzu@main@language@chinese
    \hypersetup{
      pdflang = zh-CN,
    }%
  \else
    \hypersetup{
      pdflang = en-US,
    }%
  \fi
  \AtBeginDocument{%
    \ifwzu@main@language@chinese
      \hypersetup{
        pdftitle    = \wzu@title,
        pdfauthor   = \wzu@author,
        pdfsubject  = \wzu@degree@category,
        pdfkeywords = \wzu@keywords,
      }%
    \else
      \hypersetup{
        pdftitle    = \wzu@title@en,
        pdfauthor   = \wzu@author@en,
        pdfsubject  = \wzu@degree@category@en,
        pdfkeywords = \wzu@keywords@en,
      }%
    \fi
    \hypersetup{
      pdfcreator={\wzuthesis-v\version}}
  }%
}
\AtEndOfPackageFile*{mathtools}{
  \@ifpackageloaded{unicode-math}{
    \let\underbrace\LaTeXunderbrace
    \let\overbrace\LaTeXoverbrace
  }{}
}
\AtEndOfPackageFile*{nomencl}{
  \let\nomname\wzu@denotation@name
  \def\thenomenclature{\begin{denotation}[\nom@tempdim]}
  \def\endthenomenclature{\end{denotation}}
}
\AtEndOfPackageFile*{siunitx}{%
  \newcommand\wzu@set@siunitx@language{%
    \ifwzu@language@chinese
      \sisetup{
        list-final-separator = {\TextOrMath{\space}{\ }\text{和}\TextOrMath{\space}{\ }},
        list-pair-separator  = {\TextOrMath{\space}{\ }\text{和}\TextOrMath{\space}{\ }},
        range-phrase         = {\text{～}},
      }%
    \else
      \ifwzu@language@english
        \sisetup{
          list-final-separator = {\TextOrMath{\space}{\ }\text{and}\TextOrMath{\space}{\ }},
          list-pair-separator  = {\TextOrMath{\space}{\ }\text{and}\TextOrMath{\space}{\ }},
          range-phrase         = {\TextOrMath{\space}{\ }\text{to}\TextOrMath{\space}{\ }},
        }%
      \fi
    \fi
  }
  \wzu@set@siunitx@language
  \wzu@option@hook{language}{\wzu@set@siunitx@language}
}
\AtEndOfPackageFile*{amsthm}{%
  \newtheoremstyle{wzu}
    {\z@}{\z@}
    {\normalfont}{\z@}
    {\normalfont\sffamily}{\wzu@theorem@separator}
    {0.5em}{}
  \theoremstyle{wzu}
  \newtheorem{assumption}{\wzu@assumption@name}[chapter]%
  \newtheorem{definition}{\wzu@definition@name}[chapter]%
  \newtheorem{proposition}{\wzu@proposition@name}[chapter]%
  \newtheorem{lemma}{\wzu@lemma@name}[chapter]%
  \newtheorem{theorem}{\wzu@theorem@name}[chapter]%
  \newtheorem{axiom}{\wzu@axiom@name}[chapter]%
  \newtheorem{corollary}{\wzu@corollary@name}[chapter]%
  \newtheorem{exercise}{\wzu@exercise@name}[chapter]%
  \newtheorem{example}{\wzu@example@name}[chapter]%
  \newtheorem{remark}{\wzu@remark@name}[chapter]%
  \newtheorem{problem}{\wzu@problem@name}[chapter]%
  \newtheorem{conjecture}{\wzu@conjecture@name}[chapter]%
  \renewenvironment{proof}[1][\wzu@proof@name]{\par
    \pushQED{\qed}%
    % \normalfont \topsep6\p@\@plus6\p@\relax
    \normalfont \topsep\z@\relax
    \trivlist
    \item[\hskip\labelsep
      %     \itshape
      % #1\@addpunct{.}]\ignorespaces
      \sffamily
      #1]\ignorespaces
  }{%
    \popQED\endtrivlist\@endpefalse
  }
  \renewcommand\qedsymbol{\wzu@qed}
}
\AtEndOfPackageFile*{ntheorem}{%
  \theorembodyfont{\normalfont}%
  \theoremheaderfont{\normalfont\sffamily}%
  \theoremsymbol{\wzu@qed}%
  \newtheorem*{proof}{\wzu@proof@name}%
  \theoremstyle{plain}%
  \theoremsymbol{}%
  \theoremseparator{\wzu@theorem@separator}%
  \newtheorem{assumption}{\wzu@assumption@name}[chapter]%
  \newtheorem{definition}{\wzu@definition@name}[chapter]%
  \newtheorem{proposition}{\wzu@proposition@name}[chapter]%
  \newtheorem{lemma}{\wzu@lemma@name}[chapter]%
  \newtheorem{theorem}{\wzu@theorem@name}[chapter]%
  \newtheorem{axiom}{\wzu@axiom@name}[chapter]%
  \newtheorem{corollary}{\wzu@corollary@name}[chapter]%
  \newtheorem{exercise}{\wzu@exercise@name}[chapter]%
  \newtheorem{example}{\wzu@example@name}[chapter]%
  \newtheorem{remark}{\wzu@remark@name}[chapter]%
  \newtheorem{problem}{\wzu@problem@name}[chapter]%
  \newtheorem{conjecture}{\wzu@conjecture@name}[chapter]%
}
\PassOptionsToPackage{chapter}{algorithm}
\AtEndOfPackageFile*{algorithm}{
  \floatname{algorithm}{\wzu@algorithm@name}
  \renewcommand\listofalgorithms{%
    \wzu@listof{algorithm}%
  }
  \renewcommand\listalgorithmname{\wzu@list@algorithm@name}
  \def\ext@algorithm{loa}
  \contentsuse{algorithm}{loa}
  \titlecontents{algorithm}
    [\z@]{}
    {\contentspush{\fname@algorithm~\thecontentslabel\wzu@contents@label@delimiter}}{}
    {\wzu@leaders\thecontentspage}
}
\PassOptionsToPackage{algochapter}{algorithm2e}
\AtEndOfPackageFile*{algorithm2e}{
  \renewcommand\algorithmcfname{\wzu@algorithm@name}
  \SetAlgoCaptionLayout{wzu@caption@font}
  \SetAlCapSty{relax}
  \SetAlgoCaptionSeparator{\hspace*{1em}}
  \SetAlFnt{\fontsize{11bp}{14.3bp}\selectfont}
  \renewcommand\listofalgorithms{%
    \wzu@listof{algorithmcf}%
  }
  \renewcommand\listalgorithmcfname{\wzu@list@algorithm@name}
  \def\ext@algorithmcf{loa}
  \contentsuse{algocf}{loa}
  \titlecontents{algocf}
    [\z@]{}
    {\contentspush{\algorithmcfname~\thecontentslabel\wzu@contents@label@delimiter}}{}
    {\wzu@leaders\thecontentspage}
}
\AtEndOfPackageFile*{minted}{
  \newcommand\wzu@set@listing@language{%
    \ifwzu@language@chinese
      \floatname{listing}{代码}%
    \else
      \floatname{listing}{Listing}%
    \fi
  }
  \wzu@set@listing@language
  \wzu@option@hook{language}{\wzu@set@listing@language}
}
\wzu@define@key{
  spine-font = {
    name = spine@font,
  },
  spine-title = {
    name = spine@title,
  },
  spine-author = {
    name = spine@author,
  },
}
\renewcommand\wzu@spine@font{%
  \ifwzu@degree@doctor
    \fontsize{16bp}{20.8bp}\selectfont
  \else
    \fontsize{15bp}{19.5bp}\selectfont
  \fi
}
\newcommand*\CJKmovesymbol[1]{\raise.3em\hbox{#1}}
\newcommand*\CJKmove{%
  \punctstyle{plain}%
  \let\CJKsymbol\CJKmovesymbol
  \let\CJKpunctsymbol\CJKsymbol
}
\NewDocumentCommand{\spine}{
    O{
      \ifx\wzu@spine@title\@empty
        \wzu@title
      \else
        \wzu@spine@title
      \fi
    }
    O{
      \ifx\wzu@spine@author\@empty
        \wzu@author
      \else
        \wzu@spine@author
      \fi
    }}{%
  \clearpage
  \ifwzu@degree@bachelor
    \newgeometry{
      vmargin = 3cm,
      hmargin = 1cm,
    }%
  \else
    \newgeometry{
      vmargin = 5.5cm,
      hmargin = 1cm,
    }%
  \fi
  \thispagestyle{empty}%
  \ifwzu@main@language@chinese
    \wzu@pdfbookmark{0}{书脊}%
  \else
    \wzu@pdfbookmark{0}{Spine}%
  \fi
  \begingroup
    \noindent\hfill
    \rotatebox[origin=lt]{-90}{%
      \makebox[\textheight]{%
        \fangsong
        \addCJKfontfeatures*{RawFeature={vertical}}%
        \wzu@spine@font
        \CJKmove
        #1\hfill
        \wzu@stretch{4.5em}{#2}%
      }%
    }%
  \endgroup
  \clearpage
  \restoregeometry
}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\sloppy
\endinput
%%
%% End of file `wzuthesis.cls'.
