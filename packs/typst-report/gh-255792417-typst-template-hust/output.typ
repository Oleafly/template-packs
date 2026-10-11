#import "@preview/pointless-size:0.1.2": zh
#import "modules/page_settings.typ": page-setup
#import "modules/figure_setup.typ": figure_setup
#import "modules/code_setup.typ": code_setup
#import "config.typ": apply_cover, apply_outline, apply_references

// 应用页面设置
#show: page-setup
#show: figure_setup
#show: code_setup

// 封面
#apply_cover()

// 目录
#apply_outline()

// 正文内容
#include "content.typ"

// 参考文献
#apply_references()
