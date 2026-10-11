#import "../template.typ": *
#show: conf

#context {
  let is-main-file = state("is-main-file", false).get()
  if not is-main-file {
    outline()
    pagebreak()
  }
}

= 编译与使用

== 内核编译

```bash
$ sudo apt install libncurses-dev pkg-config
$ sudo apt install flex bison
```

使用 `make menuconfig` 进入 TUI 界面进行编译配置，完成后保存生成 `.config` 文件

== 内核模块

=== Quick Start

#grid(align: horizon, columns: (1fr, 4fr), gutter: 4pt,
  ```bash
  ├── README.md
  ├── Makefile
  └── src
      ├── Kbuild
      └── main.c
  ```,
  ```makefile
  # Kbuild: obj-m += demo.o demo-y += main.o
  default: 
    $(MAKE) -C $(KDIR) M=$(SRC) MO=$(OUT) CC=$(CC) modules
  clean:
    $(MAKE) -C $(KDIR) M=$(SRC) MO=$(OUT) clean
  ```,
  grid.cell(colspan: 2)[
  ```c
  #include <linux/module.h>

  static int __init _init_module(void) { // $ sudo insmod <path/to/name.ko>
      pr_info("init Hello, World.\n");   // $ lsmod # 已加载内核模块
      return 0;
  }

  static void __exit _exit_module(void) { // $ sudo rmmod <name>
      pr_info("exit Hello, World.\n");
  }

  module_init(_init_module);
  module_exit(_exit_module);
  MODULE_LICENSE("GPL2");
  MODULE_DESCRIPTION("learn linux kernel module development.");
  ```
  ]
)


内核构建 Makefile 参数

#table(align: center + horizon, columns: (auto, 1fr),
  [*参数*], [*说明*],
  [`ARCH=<arch>`], [
    指定目标架构（交叉编译）并应用 `arch/<arch>` 及相关内容，如 `arm64`
  ],
  [`CROSS_COMPILE=`], [
    指定交叉编译 _工具链_ 前缀，如 `aarch64-linux-`
  ],
  [`CC=<CC>`], [
    编译命令；交叉编译时缺省推导为 `$(CROSS_COMPILE)gcc`，
    本地编译也可指定
  ],
  [`M=<path/to/src>`], [
    内核模块源码目录，根目录通常有 `Kbuild`
  ],
  [`MO=<path/to/build>`], [
    内核模块源码编译时中间产物的输出目录，默认直接输出在源码目录
  ],
  [`V=`], [
    构建信息输出；`0` 静默 `1` 显示完整命令，`2` 显示重编译原因
  ]
)

#list(
  [
    *备注*：编译器及工具链指定，需 _环境变量_ 存在，内核和内核模块，除配置
    相同外，使用的编译工具也要相同
  ],
  [
    *备注*：内核 `make` 在
  ],
)



