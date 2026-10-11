#import "../template.typ": *
#show: conf

#context {
  let is-main-file = state("is-main-file", false).get()
  if not is-main-file {
    outline()
    pagebreak()
  }
}

= 文件系统

#quote()[
  _Everything is a file_：UNIX 系统除进程之外的一切皆文件，如文件、目录、
  设备、进程间通信 IPC、网络通信等 _输入输出资源_ 都可用文件模型描述，在统
  一的抽象下，可使用同一套框架或方法来处理大多数资源
]

_文件系统_ File System 是数据存储与组织的核心机制，是一种将原始磁盘空间抽象为有序文件与目录的技术，

对于 Linux 系统，File System 是 Linux 的骨架，组织了系统所有资源

#list(
  [
  ]
)

== 虚拟文件系统

虚拟文件系统 Virtual File System 是 Linux 内核软件层，屏蔽各类具
体文件系统（EXT、NTFS、BTRFS 等）差异，提供统一操作接口

https://www.cnblogs.com/xiaolincoding/p/13499209.html

每个文件都

#grid(align: horizon, columns: (1.2fr, 1fr), gutter: 4pt,
  ```c
  struct dentry {
    struct inode *d_inode;      // 多对一，硬链接
    struct dentry *d_parent;    // 父目录项缓存
    struct list_head d_child;   // 子节点链表头部
    struct list_head d_subdirs; // 父目录链表节点
  /* ... */ };
  ```,
  ```c
  struct inode {
    // [15:12] S_IS*(m) 判断是否为 S_IF*
    // [11: 9] 特殊权限 SUID, SGID, SVTX
    // [ 8: 0] RWX - User, Group, Other
    umode_t i_mode;
  /* ... */ };
  ```,
)

#list(
  [
    *索引节点* `struct inode `：_唯一标识_，记录包括编号、权限、
    _磁盘位置_（普通文件或目录）等元信息，_以多态机制承载所有文件类型_，
    作为中间层概念供 _不同文件系统_ 适配（不能跨文件系统），持久化并
    加载内存
  ],
  [
    *目录实体* `struct dentry`：（目录项）记录文件名称、索引节点指针、
    层级关联关系等，_不关心文件类型_，根据磁盘数据中文件目录结构信息构建，
    缓存在内存中并由内核进行维护，动态形成目录树
  ],
)

#table(align: center + horizon, columns: (auto, auto, auto, 1fr),
  [*文件类型*], [*单字符*], [*后缀*], [*备注*],
  [普通文件], [`-`], [], [
    二进制数据、文本（采用某种编码的数据）
  ],
  [目录 Directory], [`d`], [`/`], [
    二进制映射表，保存目录下文件信息
  ],
  [符号链接 Symbolic Link], [`l`], [`@`], [
    内部使用文本记录路径，权限为 `777`，实际权限取决于目标
  ],
  [字符设备 Character], [`c`], [], [
  ],
  [块设备 Block], [`b`], [], [
  ],
  [套接字 Socket], [`s`], [], [
  ],
  [管道 Pipe], [`p`], [], [
  ],
)

#list(
  [
    *备注*：_硬链接_ Hard Link 即指向同一索引节点的多个目录项，硬链接
    计数（目录项）和引用计数（内核、进程）都归零时，文件数据将被删除；
    _软链接_ Symblic Link 是独立文件，其包含另一个文件的路径，可跨文件系统
    ```bash
    $ ln         SRC DST # 硬：不能跨文件系统（同一挂载点）、不能链接目录
    $ ln -s [-f] SRC DST # 软；SRC 用绝对路径，若相对路径则根据 DST 解析
    ```
  ],
)


```c
struct inode {
	union {
		const struct file_operations	*i_fop;
		void (*free_inode)(struct inode *);
	};
/* ... */ };
```,

初始化时，`i_fop` 将根据索引节点的文件类型绑定相关文件方法


#table(align: center + horizon, 
  columns: (auto, auto, auto, auto, auto, auto, 1fr),
  [*类型*], [*权限*], 
  [*硬链接数*], [*属主名*], [*属组名*], 
  [*修改时间*], 
  [*文件名*],
  [单字符], [`rwx`：属主、属组、其他], [], [], [], [最后一次],
  [软链接将显示链接目标]
)

\
\

== 文件

```c
struct file {
  struct path fpath;
  struct inode *f_inode;
	const struct file_operations *f_op;
  void *private_data;  // 可用于在持有任意驱动所需对象
/* ... */ };
```

#list(
  [
    *说明*：当用户使用 `open` 系统调用时，内核将创建 `struct file` 并将
    其存入进程的 `struct file *[]` 指针数组中，将其 _索引_ 作
    为 _文件描述符_ 返回给用户，用户持有以访问该文件
  ],
)

== 操作接口

```c
struct file_operations {
	struct module *owner; // 指向拥有该结构的模块，通常使用 <linux/moudle.h> 中的 THIS_MODULE 宏
/* ... */ };
```

#list(
  [
    *备注*：`file_operations` 组织的方法将被 _系统调用_ 所调用，其可
    _部分初始化_，若被调用的方法未实现，则多数（数据访问）将返
    回 `EINVAL`，对于 `open` 和 `release`，若文件打开或释放时无特殊操作
    ，则可为 `NULL`
  ],
  [
    *备注*：使用 `copy_to_user` 和 `copy_from_user` 访问用户空间内存；
    使用 `u64_to_user_ptr` 得到指针
  ]
)

#table(align: center + horizon, columns: (auto, 5fr),
  table.cell(rowspan: 2)[偏移量修改 \ `lseek`], 
  `loff_t (*llseek) (struct file *, loff_t, int);`, [
    修改偏移（正负）并返回新位置（正）；可用 `SEEK_*` 控制基准
    _头部、当前、末尾_
  ],
  table.cell(rowspan: 2, colspan: 2)[],
  table.cell(rowspan: 2)[读 \ `read`], 
  `ssize_t (*read) (struct file *, char *, size_t, loff_t *);`, [
    `copy_to_user` 读取 `size_t` 字节到 _用户空间_ `char *`，
    `loff_t *` 手动维护偏移
  ],
  table.cell(rowspan: 2, colspan: 2)[],
  table.cell(rowspan: 2)[写 \ `write`], 
  `ssize_t (*write) (struct file *, const char *, size_t, loff_t *);`, [
    从 _用户空间_ `char *` 使用 `copy_from_user` `size_t` 字节，
    `loff_t *` 手动维护偏移
  ],
  table.cell(rowspan: 2, colspan: 2)[],
  table.cell(rowspan: 2)[刷新 \ `flush`], 
  `int (*flush) (struct file *, fl_owner_t id);`, [
    处理缓存数据（根据所有者）；手动 `flush` 或 `close` 文件描述符时调用
  ],
  table.cell(rowspan: 2, colspan: 2)[],
  table.cell(rowspan: 2)[控制 \ `ioctl`], 
  `long (*) (struct file *, unsigned int, unsigned long);`, align(left)[
    #list(
      [
        `unlocked_ioctl` 和 `compat_ioctl`（可选实现） 都不持有大内核
        锁，需要自行处理并发
      ],
      [
        自定义协议，以 `uint` 为 _指令_，以 `ulong` 为  _参数_
        （常转换为 _用户空间指针_）
      ],
    )
  ],
)

#list(
  [
    *备注*：使用 `copy_to_user` 和 `copy_from_user` 访问用户空间内存；
    使用 `u64_to_user_ptr` 得到指针
  ]
)

#table(align: center + horizon, columns: (auto, 5fr),
  table.cell(rowspan: 2)[文件打开 \ `open`], 
  `int (*open) (struct inode *, struct file *)`, [
    打开文件进行 _初始化_
  ],
  table.cell(rowspan: 2)[文件释放 \ `close`], 
  `int (*release) (struct inode *, struct file *);`, [
    释放文件资源，仅在文件描述符引用都关闭 `close` 后才调用一次
  ],
)

#list(
  [
    *备注*：`inode` 通常作为只读来源，`file` 主要用来维护文件状态
  ]
)


#table(align: center + horizon, columns: (auto, 5fr),
  table.cell(rowspan: 2)[内存映射 \ `mmap`], 
  `int (*mmap) (struct file *, struct vm_area_struct * vma);`, [
    将驱动内存直接映射到用户进程的虚拟地址空间
  ],
)

```c
struct inode_operations {
/* ... */};
```

#table(align: center + horizon, columns: (1fr, 2fr),
  table.cell(rowspan: 2)[], 
  ``, [
  ],
  table.cell(rowspan: 2)[], 
  ``, [
  ],
)

== 序列文件接口 `<linux/seq_file.h>`

#h(2em)在 DebugFS、`/proc` 或其他位置创建 _虚拟文件_，是内核组件向人类用
户提供信息的一种有用方法，_序列文件接口_ `<linux/seq_file.h>` 旨在提供简
化这类虚拟文件的实现；`seq_file` 需在 `file_operations` 的 `open` 中使
用 `seq_open` 关联 `seq_operations` _迭代器接口_：

#table(align: center + horizon, columns: (1fr, 6fr),
  table.cell(rowspan: 2)[`start`],
  `void* (*)(struct seq_file *m, loff_t *pos);`,
  [
    创建自定义会话并返回 `void *v`；
    跨会话可用 `seq_file->private` 保存; \
    当 `pos == 0` 时，可返回 `SEQ_START_TOKEN` 指示 `show` 在输出开头
    打印起始信息
  ],
  table.cell(rowspan: 2)[`stop`],
  `void (*)(struct seq_file *m, void *v);`,
  [
    关闭会话，清理资源
  ],
  table.cell(rowspan: 2)[`next`],
  `void* (*)(struct seq_file *m, void *v, loff_t *pos);`,
  [
    迭代器向前，修改 `pos`，终点返回 `NULL`，否则返回 `void *v`
  ],
  table.cell(rowspan: 2)[`show`],
  `int (*)(struct seq_file *, void *);`,
  [
    将当前指向以 _格式化接口_ 输出，正常返回 `0`，
    返回 `SEQ_SKIP` 表示跳过（丢弃当前格式化）
  ],
)

#list(
  [
    *备注*：`show` 中使用 `seq_printf`、`seq_putc`、`seq_puts` 等
    _格式化接口_ 输出到 `seq_file` 维护的缓冲区
  ]
)

#h(2em)通常，对于 `seq_file`，只需在声明 `struct file_operations` 时，
提供调用 `seq_open` 函数从而关联迭代器 `seq_operations` 的 `open` 实现，
其余可用 `seq_file` 的 `seq_read`、`seq_lseek`、`seq_release` 而无需
自行实现

#list(
  [
    *备注*：简单 `seq_file` 仅需通过 `single_open`提供 `show` 和 `v`，
    专门用于输出固定数据的 _一次性_ 场景，相应需配对使
    用 `single_release` 释放资源
  ]
)

== `ioctl`

```c
int ioctl(int fd, int cmd, ...); // User Space
```


== 字符设备

_字符设备_ 一种以 _无缓冲的_（驱动即时处理）连续字节流形式 _按顺序_
进行数据传输的设备，其驱动结构如下：

#align(center, image("assets/cdev.png"))

#list(
  [
    *驱动加载*：静态创建或动态申请 `cdev_alloc` 设备实例 `cdev`，用
    `cdev_init` 为其绑定 _设备驱动方法实现_，注册设备号并 `cdev_add` 将
    其与设备绑定，最后用 `class_create` 和 `device_create` 注
    册到文件系统
  ],
  [
    *驱动卸载*：用 `device_destory` 和 `class_destory` 从文件系统卸载，
    然后用 `cdev_del` 移除并释放设备
  ],
  [
    *系统调用*：用户空间使用系统调用 `open` 打开与设备对应的文件，使用其
    他系统调用，通过驱动对访问设备
  ],
)

== 设备号

#h(2em)_设备号_ `typedef uint32_t dev_t` 是内核为设备分配的 _唯一标识_，
由 _主设备号_ `MAJOR(dev) [31:20]` 和 _次设备号_ `MINOR(dev) [19:0]`
组成（用 `MKDEV(ma, mi)` 构造），一般来说，主设备号关联 _驱动程序_，
次设备号关联 _具体设备_；设备号需要通常向内核申请分配及释放：

```c
int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count, const char *name);
int register_chrdev_region(dev_t from, unsigned count, const char *name);
void unregister_chrdev_region(dev_t first, unsigned count);
```

#list(
  [
    *动态*：_动态分配 Major_，并以 baseminor 为起始 Minor，分配 count 
    个设备号，起始设备号用 `dev_t *` 返回
  ],
  [
    *静态*：_静态指定 Major_，并以 `dev_t` 的 Minor 为起始，分配 count
    个设备号
    
  ],
)

== 设备节点

`mknod`

动态设备管理 `udev`



注册与销毁

设备节点是 `/dev` 目录下的设备文件，供用户层使用标准 API 进行访问

```c
struct device *device_create(
  struct class *class, 
  struct device *parent, dev_t, void *drvdata, const char *fmt, ...);
void device_destroy(struct class *class, dev_t devt);
```

https://doc.embedfire.com/linux/imx6/driver/zh/latest/linux_driver/character_device.html

https://github.com/0voice/linux_kernel_wiki/blob/main/%E6%96%87%E7%AB%A0/%E8%AE%BE%E5%A4%87%E9%A9%B1%E5%8A%A8/Linux%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E5%AD%A6%E4%B9%A0%E4%B9%8B%E5%AD%97%E7%AC%A6%E8%AE%BE%E5%A4%87.md

== 设备驱动模型

https://doc.embedfire.com/linux/imx6/driver/zh/latest/linux_driver/linux_device_model.html#



// + **参考**：[Linux 修炼全景指南：四 - Linux 文件系统揭秘：为什么“一切皆文件”？](https://zeeklog.com/linux-xiu-lian-quan-jing-zhi-nan-si-linux-wen-jian-xi-tong-jie-mi-wei-shi-yao-yi-qie-jie-wen-jian-2/)

// ## 文件系统

// ## 目录结构

// **形式上**：文件系统表现为层次化的 **目录结构**； Linux 目录结构起始于 **根目录** `/`，向下延伸出复杂而有序的目录树；在实践中，用户和开发者根据经验总结出 [Filesystem Hierachy Standard](https://refspecs.linuxfoundation.org/fhs.shtml)，规定文件系统的标准目录结构，典型的目录结构及其功能如下：

// ```shell
// - /
//   - boot\   # 启动引导
  
//   - etc\    # 系统配置
//   - bin\    # 基础命令；包括 sh 或 bash; ls, ln, mv, mkdir, rm ...
//   - sbin\   # 系统管理命令
//   - lib\    # 系统共享库
  
//   - var\    # 可变数据，如日志、缓存、临时文件；需要定期清理
//   - tmp\    # 临时文件；任何用户都可写入，系统自动清理或手动清理
  
//   - proc\   # 内核：内核与进程信息的虚拟文件系统，由内核动态生成
//   - sys\    # 内核：内核对象的层次化视图，提供更结构化的硬件接口信息
//   - run\    # 存放系统启动后生成的运行时数据，如 PID 文件、锁文件、套接字等
  
//   - dev\    # 设备：硬件设备（不实际存储数据，是内核动态创建的虚拟设备接口）
//   - media\  # 设备：系统自动挂载的设备，如 U 盘
//   - mnt\    # 设备：手动临时挂载的设备
  
//   - usr\
//     - bin\         # 用户命令
//     - sbin\        # 用户管理命令
//     - include\     # 用户头文件
// 	- lib\         # 用户共享库
// 	- share\       # 
//     - local\       # 本地编译安装的软件（所有用户）

//   - root\          # 超级用户 HOME
//   - home/<user>\   # 普通用户 HOME
//   - srv            # 存放由系统服务提供的数据，如 Web, FTP, NFS
// ```

// + **备注**：FHS 仅仅是目录结构上的非强制性约定，随着现代系统硬件性能的发展和方便系统维护的需求，一些发行版（如 Arch Linux）将 `/bin`、`/sbin`、`/lib` 等，全部 **软链接** 到 `/usr` 对应目录下，并将 `bin` 和 `sbin` 进行合并；一些发行版上可使用 `usrmerge` 工具自行合并

// ## 常用命令

// ### 基本命令

// |           命令（常用形式）            |       类别        |               备注               |
// | :---------------------------: | :-------------: | :----------------------------: |
// |  `ls [-l] [-a] [-F] [PATH]`   |     `/bin`      |        目录下文件；为文件名添加类型后缀        |
// |       `ls [-la] -d */`        |                 |          当前目录下的所有子目录           |
// | `ls -laF \| grep [-v] "SUF$"` |                 |      根据后缀过滤 **目录、软链接、其他**      |
// |          `stat PATH`          |   `/usr/bin`    |         文件 `inode` 信息          |
// |    `tree [-l LEVEL] [DIR]`    |   `/usr/bin`    |          目录树；默认不限制深度           |
// |      `du [-s] -h [PATH]`      |   `/usr/bin`    |              文件大小              |
// |          `cd [DIR]`           |     `shell`     |         改变 SHELL 工作路径          |
// |             `pwd`             |  `shell /bin`   |            打印当前工作路径            |
// |       `ln [-s] FROM TO`       |     `/bin`      |     创建 **硬链接** 或 **符号链接**      |
// |         `mv FROM TO`          |     `/bin`      |             重命名、移动             |
// |       `cp [-r] FROM TO`       |     `/bin`      |        拷贝；对于目录需要使用 `-r`        |
// |           `rm PATH`           |     `/bin`      |              移除文件              |
// |        `touch [FILE]`         | `/usr/bin /bin` |       更新时间；**不存在则默认创建**        |
// |      `mkdir [-p] [DIR]`       |     `/bin`      |       创建目录；默认若父目录不存在则报错        |
// |          `cat FILE`           |     `/bin`      |       将文件内容输出到 `stdout`        |
// |          `more FILE`          |     `/bin`      |             TUI 阅读             |
// |          `head FILE`          |   `/usr/bin`    | 前 `-c` 字节或前 `-n` 行输出到 `stdout` |
// |          `tail FILE`          |   `/usr/bin`    | 后 `-c` 字节或前 `-n` 行输出到 `stdout` |
// |        `echo [STRING]`        |  `shell /bin`   |        将内容输出到 `stdout`         |

// + **备注**：`rm -rf` 删除 **目录软链接** 会使得原目录内容被删除
// + **备注**：`ls -l` 以 **列表形式** 列出目录下文件相关属性，依次内容为 `类型、权限、目录子目录数量/文件硬链接数量、所有者、所属组、大小、修改时间、文件名`
// + **备注**：`cd -` 回到上一次路径

// TODO：按照指定大小和个数的数据块来复制文件的内容。当然如果愿意的话，还可以在复制过程中转换其中的数据。Linux 系统中有一个名为/dev/zero 的设备文件，每次在课堂上解释它时都充满哲学理论的色彩。因为这个文件不会占用系统存储空间，但却可以提供无穷无尽的数据，因此可以使用它作为 dd 命令的输入文件，来生成一个指定大小的文件

// ```shell
// $ dd
// ```

// ### 过滤搜索

// ```shell
// $ find
// ```

// ```shell
// $ grep [OPTION] PATTERN FILE
// $ "^hello$" # 开头、结尾
// $ gcc --help | grep "\-print"     # 特殊字符转义
// ```

// + TODO 正则表达式

// ```shell
// $ watch
// ```
// ## XDG Base Directory

// [XDG Base Directory](https://specifications.freedesktop.org/basedir/latest/) 由 [FreeDesktop.org](https://www.freedesktop.org/wiki/) 提出，是为 Unix-like 系统定义的一套 **用户数据** `~ $HOME` 目录标准，旨在避免应用程序硬编码路径导致的环境差异问题

// |       环境变量        |              默认值              |      类比      | 用途  |
// | :---------------: | :---------------------------: | :----------: | :-: |
// |  `XDG_DATA_HOME`  |       `~/.local/share`        | `/usr/share` | 数据  |
// | `XDG_CONFIG_HOME` |          `~/.config`          |    `/etc`    | 配置  |
// | `XDG_STATE_HOME`  |       `~/.local/state`        |  `/var/lib`  | 状态  |
// | `XDG_CACHE_HOME`  |          `~/.cache`           | `/var/cache` | 缓存  |
// | `XDG_RUNTIME_DIR` |            用户自行设置             |              | 临时  |
// |  `XDG_DATA_DIRS`  | `/usr/local/share:/usr/share` |    `PATH`    |     |
// | `XDG_CONFIG_DIRS` |          `/etc/xdg`           |    `PATH`    |     |

// + **备注**：若 XDG 环境变量为 **未设置、空值**，则认为其无效，并使用默认值
// + **参考**：[请使用 XDG 基本目录规范！](https://blog.tauyoung.top/article/XDG-Base-Directory-Specification/)

// ## 归档

// `tar`，名称来源于 `tape archive` 磁带归档，是 Unix-like 系统中用于 **归档文件和目标** 的工具，广泛用于在文件系统中打包和压缩文件

// ```shell
// # -x 解压 | -t 查看

// # -J 使用 xz; 自动识别压缩文件类型，可以省略
// # -v verbose
// # -f file
// # -C DIR; DIR 不会自动创建
// $ tar -xJvf archive.tar.xz -C ./archive
// ```
