#import "../template.typ": *
#show: conf

#let is-main-file = state("is-main-file", false)
#is-main-file.update(true)
// https://github.com/0voice/linux_kernel_wiki
// https://jyywiki.cn/OS/2023/
// 从内核到可启动镜像：0到1构建你的极简Linux系统 https://juejin.cn/post/7487131921715478555

#outline()
#pagebreak()

#include "compilation.typ"
#include "gnu-make.typ"
// #include "linux-kernel.typ"
#include "filesystem.typ"
