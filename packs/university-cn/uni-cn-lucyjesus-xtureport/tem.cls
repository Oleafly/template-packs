\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tem}[2026/04/23 XTU LaTeX template class]

% 说明:
% - 本类以 ctexart 为基础, 适合中文论文/实验报告.
% - 这里加载模板强依赖的基础宏包, 以减少用户文档重复声明.

% 将所有未知选项转交给基础类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

% 基础类: ctex(中文排版)
\LoadClass{ctexart}

% 基础宏包依赖
% 图形
\RequirePackage{graphicx}

% 行距控制: 使用 setspace 的 \setstretch 来统一调整 \baselineskip
% 说明: \linespread 也能工作, 但 setspace 在局部/全局控制上更直观,
%      且便于按 Word 的"倍数行距"思路调整。
\RequirePackage{setspace}

% 数字分组(千分位/小数分组): 使用 siunitx
% 需求: 123456789.987654 -> 123␠456␠789.987␠654
% 这里用 0.25\ccwd 作为分组间距(约 1/4 中文字符宽度)。
\RequirePackage{siunitx}
\newdimen\tem@NumGroupSepWidth
\tem@NumGroupSepWidth=.25em
\AtBeginDocument{%
	\tem@NumGroupSepWidth=.25\ccwd
}
\sisetup{%
	mode = text,
	detect-all,
	group-digits = all,
	group-separator = {\kern\tem@NumGroupSepWidth},
	group-minimum-digits = 4,
	output-decimal-marker = {.}
}
\newcommand\XtuNum[1]{%
	\begingroup
	\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
	\sisetup{%
		mode = text,
		group-digits = all,
		group-separator = {\kern\tem@NumGroupSepWidth},
		group-minimum-digits = 4,
		output-decimal-marker = {.}%
	}%
	\num{#1}%
	\endgroup
}

% 版式
\RequirePackage{geometry}
\geometry{%
	top=3.2cm,
	bottom=2.5cm,
	left=2.0cm,
	right=2.0cm,
	columnsep=0.78cm,
	headheight=12pt,
	headsep=1.2cm,
	footskip=0pt
}

% 避免为了"齐底"拉伸段间空白, 导致页面中间出现大空行
\raggedbottom

% 字体: 优先使用项目 fonts/ 目录, 否则回退到系统字体
\RequirePackage{iftex}
\newcommand\temSetFontDir[1]{\def\tem@fontdir{#1}}
\temSetFontDir{fonts/}
\newif\iftem@unicodeengine
\tem@unicodeenginefalse
\ifXeTeX
\tem@unicodeenginetrue
\RequirePackage{fontspec}
\fi
\ifLuaTeX
\tem@unicodeenginetrue
\RequirePackage{fontspec}
\fi

% 说明:
% - localFile: 放在 \tem@fontdir 下的字体文件名(建议包含扩展名, 如 SimSun.ttf)
% - systemName: 系统中可识别的字体名(如 SimSun)
% - 仅在 XeTeX/LuaTeX 下生效(tectonic 通常为 XeTeX).
\iftem@unicodeengine
	\newcommand\temSetMainFontWithFallback[3][]{%
		\IfFileExists{\tem@fontdir#2}{%
			\setmainfont[#1,Path=\tem@fontdir]{#2}%
		}{%
			\setmainfont[#1]{#3}%
		}%
	}
	\newcommand\temSetSansFontWithFallback[3][]{%
		\IfFileExists{\tem@fontdir#2}{%
			\setsansfont[#1,Path=\tem@fontdir]{#2}%
		}{%
			\setsansfont[#1]{#3}%
		}%
	}
	\newcommand\temSetMonoFontWithFallback[3][]{%
		\IfFileExists{\tem@fontdir#2}{%
			\setmonofont[#1,Path=\tem@fontdir]{#2}%
		}{%
			\setmonofont[#1]{#3}%
		}%
	}
\else
	% pdfTeX 下没有 fontspec, 这些命令给出清晰报错
	\newcommand\temSetMainFontWithFallback[3][]{%
		\ClassError{tem}{Font fallback requires XeTeX/LuaTeX}{}
	}
	\newcommand\temSetSansFontWithFallback[3][]{%
		\ClassError{tem}{Font fallback requires XeTeX/LuaTeX}{}
	}
	\newcommand\temSetMonoFontWithFallback[3][]{%
		\ClassError{tem}{Font fallback requires XeTeX/LuaTeX}{}
	}
\fi

% 总则: 42 行/页, 每行字数控制
% 说明:
% - 这里用 \ccwd(中文字符宽度)估算"每行字数". 实际效果会受字体与标点影响.
% - 单栏按 45 字/行设置版心宽度.
% - 双栏按每栏 21 字设置版心宽度(总宽度=2*21*\ccwd+栏间距).
\newcommand\temSetLinesPerPage[1]{\def\tem@linesperpage{#1}}
\newcommand\temSetCharsPerLineOneColumn[1]{\def\tem@charsonecol{#1}}
\newcommand\temSetCharsPerColumnTwoColumn[1]{\def\tem@charstwocol{#1}}
\temSetLinesPerPage{42}
\temSetCharsPerLineOneColumn{45}
\temSetCharsPerColumnTwoColumn{21}

% 页眉: 小五号宋体, 英文 Times New Roman
\RequirePackage{fancyhdr}
\newdimen\tem@headtabcenter
\newdimen\tem@headtabright
\tem@headtabcenter=8.5cm\relax
\tem@headtabright=16.8cm\relax

\def\tem@headerreport{实验报告}
\def\tem@headerschool{}
\def\tem@headerfirstauthor{}
\newcommand\temSetFirstAuthor[1]{\def\tem@headerfirstauthor{#1}}
\newcommand\temSetHeaderContent[3]{%
	\def\tem@headerreport{#1}%
	\def\tem@headerschool{#2}%
}
\newcommand\temSetHeaderTabStops[2]{%
	\tem@headtabcenter=#1\relax
	\tem@headtabright=#2\relax
}

% 字体族: 优先 fonts/ 下的字体文件, 否则使用系统字体名
\iftem@unicodeengine
	\newcommand\temSetupHeaderFonts[4]{%
		% #1 CJK local file, #2 CJK system name, #3 Latin local file, #4 Latin system name
		\ifdefined\newCJKfontfamily
			\IfFileExists{\tem@fontdir#1}{%
				\newCJKfontfamily\tem@HeaderCJK[Path=\tem@fontdir]{#1}%
			}{%
				\IfFontExistsTF{#2}{%
					\newCJKfontfamily\tem@HeaderCJK{#2}%
				}{%
					\let\tem@HeaderCJK\relax
				}%
			}%
		\else
			\let\tem@HeaderCJK\relax
		\fi
		\IfFileExists{\tem@fontdir#3}{%
			\newfontfamily\tem@HeaderLatin[Path=\tem@fontdir]{#3}%
		}{%
			\IfFontExistsTF{#4}{%
				\newfontfamily\tem@HeaderLatin{#4}%
			}{%
				\let\tem@HeaderLatin\relax
			}%
		}%
	}
\else
	\newcommand\temSetupHeaderFonts[4]{}%
\fi

% 默认页眉字体: 宋体 + Times New Roman(优先 fonts/)
% - 宋体: Windows 常见为 simsun.ttc
% - Times New Roman: Windows 常见为 times.ttf
\temSetupHeaderFonts{simsun.ttc}{SimSun}{times.ttf}{Times New Roman}

\newcommand\tem@headerfont{%
	\zihao{-5}% 小五
	\ifdefined\tem@HeaderLatin\tem@HeaderLatin\fi
	\ifdefined\tem@HeaderCJK\tem@HeaderCJK\fi
}

\newcommand\tem@makeheaderline{%
	\begingroup
	\tem@headerfont
	\ifnum\value{page}=1\relax
		\makebox[0pt][l]{\tem@headerreport}%
		\hspace*{\tem@headtabcenter}\makebox[0pt][c]{\tem@headerschool}%
		\hspace*{\dimexpr\tem@headtabright-\tem@headtabcenter\relax}\makebox[0pt][r]{第\thepage 页}%
	\else
		\makebox[0pt][l]{\tem@headerreport}%
		\hspace*{\tem@headtabcenter}\makebox[0pt][c]{\tem@headerfirstauthor;第\thesection 节}%
		\hspace*{\dimexpr\tem@headtabright-\tem@headtabcenter\relax}\makebox[0pt][r]{第\thepage 页}%
	\fi
	\endgroup
}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\tem@makeheaderline}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% 进入文档后再计算版心, 保证 baselineskip/\ccwd 已就绪
\AtBeginDocument{%
	% 中文断行/标点与数学公式混排优化(仅在 xeCJK 可用时生效)
	\ifdefined\xeCJKsetup
		\xeCJKsetup{CheckSingle=true, PunctStyle=kaiming, CJKmath=true}%
	\fi

	\newdimen\tem@textwidth
	\newdimen\tem@textheight

	% 版心按"正文默认字号/行距"估算, 这样 42 行/页 与每行字数的设定更稳定。
	% 这里取正文常用的"五号 + 单倍行距(\setstretch{1})"。
	\begingroup
		\zihao{5}% 五号
		\setstretch{1}% 单倍行距
		% 42 行/页
		\global\tem@textheight=\dimexpr \tem@linesperpage\baselineskip + \topskip\relax
		% 45 字/行(单栏) 或 每栏 21 字(双栏)
		\if@twocolumn
			\global\tem@textwidth=\dimexpr 2\tem@charstwocol\ccwd + \columnsep\relax
		\else
			\global\tem@textwidth=\dimexpr \tem@charsonecol\ccwd\relax
		\fi
	\endgroup

	\geometry{textwidth=\tem@textwidth,textheight=\tem@textheight}%
}

% 标题块(跨栏): \Zhtitle 后紧跟 \Zhauthor/\Zhaddress/\Entitle/\Enauthor/\Enaddress
% 规范:
% - \Zhtitle: 二号黑体, 英文字体 Arial, 段前 12pt, 居中
% - \Zhauthor: 四号仿宋
% - \Zhaddress: 五号楷体
% - \Entitle: 小四 Times New Roman 加粗
% - \Enauthor: 五号 Times New Roman
% - \Enaddress: 小五 Times New Roman
% 字体来源: 优先 fonts/ 目录的字体文件, 否则回退系统字体名; 都找不到则用 ctex/默认字体, 不报错.

% --- 字体族辅助: Latin/CJK 优先本地文件, 否则系统字体 ---
\iftem@unicodeengine
	\newcommand\temNewLatinFamilyWithFallback[3]{%
		% #1 control sequence, #2 local file, #3 system name
		\IfFileExists{\tem@fontdir#2}{%
			\newfontfamily#1[Path=\tem@fontdir]{#2}%
		}{%
			\IfFontExistsTF{#3}{%
				\newfontfamily#1{#3}%
			}{%
				\let#1\relax
			}%
		}%
	}
	\newcommand\temNewCJKFamilyWithFallback[3]{%
		% #1 control sequence, #2 local file, #3 system name
		\ifdefined\newCJKfontfamily
			\IfFileExists{\tem@fontdir#2}{%
				\newCJKfontfamily#1[Path=\tem@fontdir]{#2}%
			}{%
				\IfFontExistsTF{#3}{%
					\newCJKfontfamily#1{#3}%
				}{%
					\let#1\relax
				}%
			}%
		\else
			\let#1\relax
		\fi
	}
\else
	\newcommand\temNewLatinFamilyWithFallback[3]{\let#1\relax}
	\newcommand\temNewCJKFamilyWithFallback[3]{\let#1\relax}
\fi

% 预设字体族(找不到就 \relax)
% 英文字体文件名按 Windows 常见: times.ttf / arial.ttf
\temNewLatinFamilyWithFallback\tem@ArialLatin{arial.ttf}{Arial}
\temNewLatinFamilyWithFallback\tem@TimesLatin{times.ttf}{Times New Roman}

% 中文字体文件名按 Windows 常见: simsun.ttc / simhei.ttf / simkai.ttf
% 宋体使用 ttc: 优先 fonts/simsun.ttc, 否则回退系统 SimSun
\ifdefined\newCJKfontfamily
	\IfFileExists{\tem@fontdir simsun.ttc}{%
		\newCJKfontfamily\tem@SongCJK[Path=\tem@fontdir,FontIndex=0]{simsun.ttc}%
	}{%
		\IfFontExistsTF{SimSun}{%
			\newCJKfontfamily\tem@SongCJK{SimSun}%
		}{%
			\let\tem@SongCJK\relax
		}%
	}%
\else
	\let\tem@SongCJK\relax
\fi

% 将 ctex 的常用字体族直接绑定到本地字体文件(若存在)
% 这样 \songti/\heiti/\kaishu 等也会优先使用 fonts/ 字体.
\ifdefined\setCJKmainfont
	\IfFileExists{\tem@fontdir simsun.ttc}{%
		\setCJKmainfont[Path=\tem@fontdir,FontIndex=0]{simsun.ttc}%
	}{}%
\fi
\ifdefined\setCJKfamilyfont
	\IfFileExists{\tem@fontdir simhei.ttf}{%
		\setCJKfamilyfont{hei}[Path=\tem@fontdir]{simhei.ttf}%
	}{}%
	\IfFileExists{\tem@fontdir simkai.ttf}{%
		\setCJKfamilyfont{kai}[Path=\tem@fontdir]{simkai.ttf}%
	}{}%
\fi

% 明确覆盖常用中文字体命令, 优先使用 fonts/ 下字体, 避免作者等位置回退到系统字体导致乱码。
\ifdefined\setCJKfamilyfont
	\IfFileExists{\tem@fontdir simsun.ttc}{%
		\setCJKfamilyfont{temsong}[Path=\tem@fontdir,FontIndex=0]{simsun.ttc}%
		\renewcommand\songti{\CJKfamily{temsong}}%
	}{}%
	\IfFileExists{\tem@fontdir simhei.ttf}{%
		\setCJKfamilyfont{temhei}[Path=\tem@fontdir]{simhei.ttf}%
		\renewcommand\heiti{\CJKfamily{temhei}}%
	}{}%
	\IfFileExists{\tem@fontdir simkai.ttf}{%
		\setCJKfamilyfont{temkai}[Path=\tem@fontdir]{simkai.ttf}%
		\renewcommand\kaishu{\CJKfamily{temkai}}%
	}{}%
	\IfFileExists{\tem@fontdir simfang.ttf}{%
		\setCJKfamilyfont{temfang}[Path=\tem@fontdir]{simfang.ttf}%
		\renewcommand\fangsong{\CJKfamily{temfang}}%
	}{}%
\fi

\temNewCJKFamilyWithFallback\tem@HeiCJK{simhei.ttf}{SimHei}
% Windows 常见文件名: simfang.ttf/simkai.ttf (仿宋可后续补)
\temNewCJKFamilyWithFallback\tem@FangSongCJK{simfang.ttf}{FangSong}
\temNewCJKFamilyWithFallback\tem@KaiTiCJK{simkai.ttf}{KaiTi}

% --- 字段存储 ---
\def\tem@Zhtitle{}
\def\tem@Zhauthor{}
\def\tem@Zhaddress{}
\def\tem@Entitle{}
\def\tem@Enauthor{}
\def\tem@Enaddress{}

% 统一接口: 一次性输出"中英文标题/作者/地址"标题块
% 用法: \XtuTitleAuthorAddress{中标题}{中作者}{中文地址}{英标题}{英作者}{英地址}
% 约定: 任一参数为空则忽略该行; 标题块整体单倍行距
\newcommand\tem@titleblockcontentargs[6]{%
	\ifstrempty{#1#2#3#4#5#6}{}{%
		\par\vspace{12pt}% 段前 12pt
		\begingroup
			\setstretch{1}% 标题块整体单倍行距
			\centering
			% 中文标题: 二号黑体 + 英文 Arial
			\ifstrempty{#1}{}{%
				{\zihao{2}\heiti\ifx\tem@ArialLatin\relax\else\tem@ArialLatin\fi #1\par}%
			}%
			% 中文作者: 四号仿宋
			\ifstrempty{#2}{}{%
				{\zihao{4}\ifx\tem@FangSongCJK\relax\fangsong\else\tem@FangSongCJK\fi #2\par}%
			}%
			% 中文单位/地址: 五号楷体
			\ifstrempty{#3}{}{%
				{\zihao{5}\ifx\tem@KaiTiCJK\relax\kaishu\else\tem@KaiTiCJK\fi #3\par}%
			}%
			% 英文标题: 小四 Times New Roman 加粗
			\ifstrempty{#4}{}{%
				{\zihao{-4}\bfseries\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi #4\par}%
			}%
			% 英文作者: 五号 Times New Roman
			\ifstrempty{#5}{}{%
				{\zihao{5}\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi #5\par}%
			}%
			% 英文单位/地址: 小五 Times New Roman
			\ifstrempty{#6}{}{%
				{\zihao{-5}\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi #6\par}%
			}%
		\endgroup
		\par\vspace{12pt}% 标题块后留空, 避免正文紧贴
	}%
}

\newcommand\temMakeTitleBlockFromArgs[6]{%
	\if@twocolumn
		\twocolumn[\tem@titleblockcontentargs{#1}{#2}{#3}{#4}{#5}{#6}]%
	\else
		\tem@titleblockcontentargs{#1}{#2}{#3}{#4}{#5}{#6}%
	\fi
}

\newcommand\XtuTitleAuthorAddress[6]{%
	\ifstrempty{#2}{}{\gdef\tem@headerfirstauthor{#2}}%
	\temMakeTitleBlockFromArgs{#1}{#2}{#3}{#4}{#5}{#6}%
}

\newcommand\Zhtitle[1]{\gdef\tem@Zhtitle{#1}}
\newcommand\Zhauthor[1]{\gdef\tem@Zhauthor{#1}\gdef\tem@headerfirstauthor{#1}}
\newcommand\Zhaddress[1]{\gdef\tem@Zhaddress{#1}}
\newcommand\Entitle[1]{\gdef\tem@Entitle{#1}}
\newcommand\Enauthor[1]{\gdef\tem@Enauthor{#1}}

% 输出标题块: 旧接口复用新实现
\newcommand\temMakeTitleBlock{%
	\temMakeTitleBlockFromArgs
		{\tem@Zhtitle}{\tem@Zhauthor}{\tem@Zhaddress}{\tem@Entitle}{\tem@Enauthor}{\tem@Enaddress}%
}

% 最后一个命令调用时自动输出标题块
\newcommand\Enaddress[1]{%
	\gdef\tem@Enaddress{#1}%
	\temMakeTitleBlock
}

% 兼容传统 \maketitle: 若使用了本模板字段则输出标题块, 否则退回只打印 \@title
\newcommand\tem@fallbackPrintSimpleTitle{%
	\par\vspace{12pt}%
	\noindent
	\begingroup\centering{\zihao{2}\heiti \@title\par}\endgroup
	\par\vspace{12pt}%
}
\renewcommand\maketitle{%
	\ifx\tem@Zhtitle\@empty
		\tem@fallbackPrintSimpleTitle
	\else
		\temMakeTitleBlock
	\fi
}

% 摘要/关键词
% 约定:
% - 小五字号按 9pt 处理, 行距固定 14pt
% - 英文使用 Times New Roman; 中文使用宋体
% - 关键词段首空 6pt
\newcommand\tem@EnSmallFiveFont{%
	\setstretch{1}% 固定行距(不随全局倍数缩放)
	\fontsize{9}{14}\selectfont
	\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
}
\newcommand\tem@ZhSmallFiveFont{%
	\setstretch{1}% 固定行距(不随全局倍数缩放)
	\fontsize{9}{14}\selectfont
	\ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
}

\newcommand\Enabstract[1]{%
	\par
	\begingroup
		\tem@EnSmallFiveFont
		\noindent\textbf{ABSTRACT:}~#1\par
	\endgroup
}

\newcommand\Enkeyword[1]{%
	\par
	\begingroup
		\tem@EnSmallFiveFont
		\noindent\textbf{KEY WORDS:}~#1\par
	\endgroup
}
% 关键词段首空 6pt: \hspace*{6pt},放在 \noindent 后面.

\newcommand\Zhabstract[1]{%
	\par
	\begingroup
		\tem@ZhSmallFiveFont
		\noindent\textbf{摘要:}#1\par
	\endgroup
}

\newcommand\Zhkeyword[1]{%
	\par
	\begingroup
		\tem@ZhSmallFiveFont
		\noindent\textbf{关键词:}#1\par
	\endgroup
}

% 主标题节: \Mainsection{} 代替 \section{}
% 规范:
% - 标题(二级标题): 小四黑, 英文 Arial, 上下间距各 6pt
% - 标题后的正文直到"下一个命令"出现前: 五号宋体/Times New Roman, 首行缩进 0.74cm,
%   单倍行距; 尽量改善中文断行与公式导致的溢出
\RequirePackage{etoolbox}
\newif\iftem@maintextactive
\newif\iftem@appendixmode
\newif\iftem@appendixfirstsection
\newif\iftem@tocwasdoublecol
\tem@appendixmodefalse
\tem@appendixfirstsectionfalse
\newtoks\tem@MainSavedEverypar

% 目录页优先占满整页: 在双栏文档中临时切到单栏, 目录后恢复双栏。
\let\tem@OldTableofcontents\tableofcontents
\renewcommand\tableofcontents{%
\clearpage
\tem@tocwasdoublecolfalse
\if@twocolumn
\tem@tocwasdoublecoltrue
\onecolumn
\fi
\tem@OldTableofcontents
\clearpage
\iftem@tocwasdoublecol
\twocolumn
\fi
}

% 附录统一行为:
% - 进入附录时自动新开页
% - 附录整体使用单栏(与正文双栏区分)
\let\tem@OldAppendix\appendix
\renewcommand\appendix{%
\clearpage
\if@twocolumn
\onecolumn
\fi
\tem@appendixmodetrue
\tem@appendixfirstsectiontrue
\tem@OldAppendix
}

\newcommand\tem@MainTextParaSetup{%
	\zihao{5}% 五号
	\ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
	\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
	\setstretch{1}% 单倍行距
	\parindent=0.74cm\relax
	\emergencystretch=1em\relax
	\tolerance=2000\relax
}

\newcommand\temMainTextDeactivate{%
	\iftem@maintextactive
		\tem@maintextactivefalse
		\everypar\expandafter{\the\tem@MainSavedEverypar}%
	\fi
}

\newcommand\temMainTextActivate{%
	\temMainTextDeactivate
	\tem@maintextactivetrue
	\tem@MainSavedEverypar=\everypar
	\everypar{\tem@MainTextParaSetup\the\tem@MainSavedEverypar}%
}

% 常见结构命令出现时, 自动结束 Mainsection 正文样式
\pretocmd{\subsection}{\temMainTextDeactivate}{}{}
\pretocmd{\subsubsection}{\temMainTextDeactivate}{}{}
\pretocmd{\paragraph}{\temMainTextDeactivate}{}{}
\pretocmd{\subparagraph}{\temMainTextDeactivate}{}{}
\pretocmd{\begin}{\temMainTextDeactivate}{}{}
\pretocmd{\end}{\temMainTextDeactivate}{}{}
\pretocmd{\item}{\temMainTextDeactivate}{}{}

\newcommand\tem@MainsectionTitle[1]{%
	\par\vspace{6pt}%
	\noindent
	{\zihao{-4}\heiti\ifx\tem@ArialLatin\relax\else\tem@ArialLatin\fi #1\par}%
	\vspace{6pt}%
}

\newcommand\Mainsection{\@ifstar\tem@MainsectionStar\tem@Mainsection}

\newcommand\tem@Mainsection[1]{%
	\par
	\iftem@appendixmode
\iftem@appendixfirstsection
\global\tem@appendixfirstsectionfalse
\else
\clearpage
\fi
	\fi
	\temMainTextDeactivate
	\refstepcounter{section}%
	\setcounter{subsection}{0}%
	\setcounter{subsubsection}{0}%
	\addcontentsline{toc}{section}{\protect\numberline{\thesection}#1}%
	\tem@MainsectionTitle{\thesection\quad #1}%
	\temMainTextActivate
}

\newcommand\tem@MainsectionStar[1]{%
	\par
	\iftem@appendixmode
\clearpage
	\fi
	\temMainTextDeactivate
	\tem@MainsectionTitle{#1}%
	\temMainTextActivate
}

% 二级标题: \Secondsection{} 代替 \subsection{}
% 约定:
% - 编号: 跟随 \Mainsection 的阿拉伯数字, 形如 1.1, 1.2, 3.4 ...
% - 标题字体: 五号黑体(中文) + Arial(英文)
% - 标题后的正文直到"下一个结构命令"前: 使用 Mainsection 同款正文样式
\newcommand\tem@SecondsectionTitle[1]{%
	\par
	\noindent
	{\zihao{5}\heiti\ifx\tem@ArialLatin\relax\else\tem@ArialLatin\fi \thesection.\arabic{subsection}\quad #1\par}%
}

\newcommand\Secondsection[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{subsection}%
	\setcounter{subsubsection}{0}%
	\addcontentsline{toc}{subsection}{\protect\numberline{\thesection.\arabic{subsection}}#1}%
	\tem@SecondsectionTitle{#1}%
	\temMainTextActivate
}

% 三级标题: \Thirdsection{} 代替 \subsubsection{}
% 约定:
% - 编号: 跟随 \Mainsection/\Secondsection, 形如 1.1.1, 1.2.1, 3.1.4 ...
% - 标题字体: 五号宋体(中文) + Times New Roman(英文)
% - 与正文段落紧贴: 不额外增加段前/段后间距
% - 标题后的正文直到"下一个结构命令"前: 使用 Mainsection 同款正文样式
\newcommand\tem@ThirdsectionTitle[1]{%
	\par
	\noindent
	{\zihao{5}%
	\ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
	\ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
	\thesection.\arabic{subsection}.\arabic{subsubsection}\quad #1\par}%
}

\newcommand\Thirdsection[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{subsubsection}%
	\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesection.\arabic{subsection}.\arabic{subsubsection}}#1}%
	\tem@ThirdsectionTitle{#1}%
	\temMainTextActivate
}

% 数学语句块: \Def/\Thm/\Axiom/\Lithem/\Proof
% 约定:
% - 调用后先输出一行"顶格五号黑体"标题(可含中英文), 然后切换到正文样式
% - 正文样式持续到下一个常见结构命令出现(由 temMainTextDeactivate 的钩子负责)
% - Def/Thm/Axiom/Lithem 各自独立编号: 1,2,3...
\newcounter{tem@def}
\newcounter{tem@thm}
\newcounter{tem@axiom}
\newcounter{tem@lemma}

\newcommand\tem@StmtHeadingNoNum[2]{%
	\par
	\noindent
	{\zihao{5}\heiti\ifx\tem@ArialLatin\relax\else\tem@ArialLatin\fi #1\ifstrempty{#2}{}{：#2}\par}%
}

\newcommand\tem@StmtHeadingWithNum[3]{%
	\par
	\noindent
	{\zihao{5}\heiti\ifx\tem@ArialLatin\relax\else\tem@ArialLatin\fi #1\arabic{#2}\ifstrempty{#3}{}{：#3}\par}%
}

\newcommand\Def[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{tem@def}%
	\tem@StmtHeadingWithNum{定义}{tem@def}{#1}%
	\temMainTextActivate
}

\newcommand\Thm[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{tem@thm}%
	\tem@StmtHeadingWithNum{定理}{tem@thm}{#1}%
	\temMainTextActivate
}

\newcommand\Axiom[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{tem@axiom}%
	\tem@StmtHeadingWithNum{公理}{tem@axiom}{#1}%
	\temMainTextActivate
}

\newcommand\Lithem[1]{%
	\par
	\temMainTextDeactivate
	\refstepcounter{tem@lemma}%
	\tem@StmtHeadingWithNum{引理}{tem@lemma}{#1}%
	\temMainTextActivate
}

\newcommand\Proof[1]{%
	\par
	\temMainTextDeactivate
	\tem@StmtHeadingNoNum{证明}{#1}%
	\temMainTextActivate
}

% 算法(如需其他算法样式, 后续可在此扩展)
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
% \RequirePackage[ruled,vlined]{algorithm2e}

% 参考文献标题: 左对齐顶格, 小四黑体
\AtBeginDocument{%
	\@ifundefined{bibsection}{}{%
		\renewcommand{\bibsection}{%
			\par
			\noindent
			{\zihao{-4}\heiti 参考文献\par}%
		}%
	}%
}

% 代码
\RequirePackage{xcolor}
\RequirePackage{listings}

% 这里先不强行定义 listings 风格, 避免与用户/学校规范冲突.

%% ============================================================
%% 封面页
%% 用法示例:
%%   \XtuAddMember{姓名}{班级}{学号}{联系电话}{E-mail}
%%   \XtuAddMember{...}  % 重复调用添加更多成员
%%   \XtuMakeCover[subject={题目}, course={课程}, teacher={教师},
%%                 score={}, date={2026年5月}]
%%
%% \XtuMakeCover 支持的 key (均有默认值, 可省略):
%%   title   = {湘潭大学}
%%   school  = {数学与计算科学学院}
%%   type    = {课程报告}
%%   subject, course, teacher, score, date
%% ============================================================

\RequirePackage{pgfkeys}

%% --- 内部存储 ---
\def\tem@cv@title{湘潭大学}
\def\tem@cv@school{数学与计算科学学院}
\def\tem@cv@type{课程报告}
\def\tem@cv@subject{}
\def\tem@cv@course{}
\def\tem@cv@teacher{}
\def\tem@cv@score{}
\def\tem@cv@date{}
\newif\iftem@cv@wastwocol
\newcount\tem@cv@membercount
\tem@cv@membercount=0

%% --- pgfkeys ---
\pgfkeys{
  /XtuCover/.is family,
  /XtuCover,
  title/.store   in = \tem@cv@title,
  school/.store  in = \tem@cv@school,
  type/.store    in = \tem@cv@type,
  subject/.store in = \tem@cv@subject,
  course/.store  in = \tem@cv@course,
  teacher/.store in = \tem@cv@teacher,
  score/.store   in = \tem@cv@score,
  date/.store    in = \tem@cv@date,
}

%% --- 添加成员命令(在 \XtuMakeCover 之前重复调用) ---
%% \XtuAddMember{姓名}{班级}{学号}{联系电话}{E-mail}
\newcommand\XtuAddMember[5]{%
  \global\advance\tem@cv@membercount by 1\relax
  \expandafter\gdef\csname tem@cv@m\the\tem@cv@membercount @name\endcsname{#1}%
  \expandafter\gdef\csname tem@cv@m\the\tem@cv@membercount @class\endcsname{#2}%
  \expandafter\gdef\csname tem@cv@m\the\tem@cv@membercount @id\endcsname{#3}%
  \expandafter\gdef\csname tem@cv@m\the\tem@cv@membercount @phone\endcsname{#4}%
  \expandafter\gdef\csname tem@cv@m\the\tem@cv@membercount @email\endcsname{#5}%
}

%% --- 信息字段行: label + 下划线填满 ---
\newcommand\tem@cv@inforow[2]{%
  \par\vspace{6pt}%
  \noindent
  \begingroup
    \zihao{-4}%
    \ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi
    \makebox[5em][l]{#1：}%
    \underline{%
      \hbox to \dimexpr\textwidth-5em\relax{%
        \hspace{4pt}%
        \ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
        \ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
        #2\hfill
      }%
    }%
  \endgroup\par
}

%% --- 输出一行成员数据(遍历1..membercount) ---
\newcommand\tem@cv@rowdata[1]{%
  \newcount\tem@cv@i
  \tem@cv@i=1\relax
  \loop\ifnum\tem@cv@i>\tem@cv@membercount\else
    & \csname tem@cv@m\the\tem@cv@i @#1\endcsname
    \advance\tem@cv@i by 1\relax
  \repeat
}

%% --- 成员表格 ---
\newcommand\tem@cv@membertable{%
  \def\tem@cv@colspec{|l|}%
  \newcount\tem@cv@j
  \tem@cv@j=1\relax
  \loop\ifnum\tem@cv@j>\tem@cv@membercount\else
    \g@addto@macro\tem@cv@colspec{c|}%
    \advance\tem@cv@j by 1\relax
  \repeat
  \begingroup
    \zihao{5}%
    \ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
    \ifx\tem@TimesLatin\relax\else\tem@TimesLatin\fi
    \renewcommand\arraystretch{1.5}%
    \noindent
    \expandafter\begin\expandafter{tabular}\expandafter{\tem@cv@colspec}%
    \hline
    {\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi 组员姓名}\tem@cv@rowdata{name}\\  \hline
    {\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi 班\quad 级}\tem@cv@rowdata{class}\\ \hline
    {\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi 学\quad 号}\tem@cv@rowdata{id}\\   \hline
    {\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi 联系电话}\tem@cv@rowdata{phone}\\  \hline
    {\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi E-mail}\tem@cv@rowdata{email}\\    \hline
    \end{tabular}%
  \endgroup
}

%% --- 主命令 ---
\newcommand\XtuMakeCover[1][]{%
  \pgfkeys{/XtuCover, #1}%
  \tem@cv@wastwocolfalse
  \if@twocolumn\tem@cv@wastwocoltrue\onecolumn\fi
  \clearpage
  \thispagestyle{empty}%
  \setcounter{page}{0}%
  \noindent\begin{minipage}[t][\textheight][s]{\textwidth}
    \begingroup
      \centering\setstretch{1.8}%
      {\zihao{0}\bfseries\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi\tem@cv@title\par}%
      {\zihao{2}\bfseries\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi\tem@cv@school\par}%
      {\zihao{2}\bfseries\ifx\tem@HeiCJK\relax\heiti\else\tem@HeiCJK\fi\tem@cv@type\par}%
    \endgroup
    \vspace{2.5cm}%
    \tem@cv@inforow{题\quad 目}{\tem@cv@subject}%
    \tem@cv@inforow{课\quad 程}{\tem@cv@course}%
    \tem@cv@inforow{指导教师}{\tem@cv@teacher}%
    \tem@cv@inforow{成\quad 绩}{\tem@cv@score}%
    \vspace{1cm}%
    \ifnum\tem@cv@membercount>0\relax
      \tem@cv@membertable
    \fi
    \vfill
    \begin{center}
      \zihao{-4}%
      \ifx\tem@SongCJK\relax\songti\else\tem@SongCJK\fi
      完成日期：\tem@cv@date
    \end{center}
  \end{minipage}%
  \clearpage
  \iftem@cv@wastwocol\twocolumn\fi
  \global\tem@cv@membercount=0\relax
}

\endinput
