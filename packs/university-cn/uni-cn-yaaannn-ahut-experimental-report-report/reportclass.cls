\ProvidesClass{reportclass}[2023/03/14 v1.0 Report class]

% \documentclass{ctexart}
\LoadClass{ctexart}
\usepackage{fancyhdr}
\usepackage{graphicx}
\usepackage{titlesec}
\usepackage{titletoc}
\usepackage{listings}
\usepackage{appendix}
\usepackage{bm, amsmath,amsfonts}
\usepackage{multirow}
\usepackage[a4paper,left=3.18cm,right=3.18cm,top=1.65cm,bottom=2.54cm]{geometry}
\usepackage{float}
\usepackage{booktabs}
\usepackage{reportstyle}
\numberwithin{figure}{section}		% 定义引用编号样式
\graphicspath{{picture/}}	% 定义图片存放的路径