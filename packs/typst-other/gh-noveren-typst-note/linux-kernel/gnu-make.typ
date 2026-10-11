#import "../template.typ": *
#show: conf

#context {
  let is-main-file = state("is-main-file", false).get()
  if not is-main-file {
    outline()
    pagebreak()
  }
}

= GNU Make

#quote()[
  GNU Make is a tool which controls the generation of executables 
  and other non-source files of a program from the program's source
  files
]

#h(2em)#link("https://www.gnu.org/software/make")[GNU Make]是专注于组织
_可执行程序产物_ 和 _基于源文件生成中间文件_ 的工具，其依据包含
_中间文件、编译方式、依赖关系_（编译规则） 的 `Makefile`，实现
_自动化构建_，根据依赖关系调用命令逐步构建，并支持 _增量编译_，不局限于某种编程语言

== 命令行使用

=== `make`

```bash
$ make --help
Usage: make [options] [target] ...       # 不指定则执行第一个 target
Options:
	-f FILE, --file=FILE, --makefile=FILE  # 指定 Makefile 文件
	-j [N], --jobs=[N]                     # 并行任务编译 [默认最大]
	-O[TYPE], --output-sync[=TYPE]         # 同步并行任务输出
	-n, --just-print, --dry-run, --recon   # 只打印将会执行的命令
	-o FILE, --old-file=FILE               # 忽略某文件更新
	-B, --always-make                      # 重新构建所有目标
	-r, --no-builtin-rules                 # 禁用默认隐式规则
	-R, --no-buitlin-variables             # 禁用默认内建变量
$ make [<options>] [<target>] <VAR>=<VALUE>
```

#enum(
	[
		在当前路径下读入 `Makefile`（推荐）、`makefile`、`GNUMakefile`，
		读入 `include` 脚本
	],
	[
		初始化变量，推导隐式规则，分析所有规则，_确定唯一最终目标_ 并创建
		依赖关系链
	],
	[
		计算增量编译对象，执行构建命令
	],
)

=== 编译数据库（C/C++）

#link("https://github.com/nickdiego/compiledb")[`compiledb`] 是基
于 C/C++ `Makefile` 生成 `compile_commands.json`，供如 `clangd` 等工
具解析项目从而提供语言服务的转换工具，其提供了一个 `make` 的 Python 包装
脚本，使用 `compiledb make` 时，等同于使用 `make`，并默认在当前路径下
生成 `compile_commands.json`

```bash
$ python -m pip install compiledb # python >= 3.3
# 解析当前目录下的 Makefile 并生成 compile_commands.json (-n 不构建)
$ compiledb -o ./build/compile_commands.json -n make
```

// ## 2. `Makefile`

// TODO 目标、伪目标（显式声明，默认推导）

// ### 2.1 变量函数

// GNU Make 变量都是 _文本字符_，`var` 在使用处 `$(var) ${var}` 自动展开，等效于宏

// + _备注_：常表示若干 _文件_ 或 _选项_ 列表，其值形式多为 `<sub> <sub>`，以空白符分隔
// + _后缀_：`$(var:<a>=<A>)`；将后缀为 `<a>`为的 `<sub>` 的后缀替换为 `<A>`
// + _模式_：`$(var:[<a>]%[<b>]=[<A>][%][<B>])`；将符合模式的 `<sub>` 做 _对应/全_ 替换

// #### 2.1.1 变量声明

// |       变量声明       |               说明                |
// | :--------------: | :-----------------------------: |
// | `<var> = <val>`  |       `<val>` 中使用的变量可以后声明       |
// | `<var> := <val>` |       `<val>` 中使用的变量必须前声明       |
// | `<var> ?= <val>` |      未声明，则声明并使其值为 `<val>`       |
// | `<var> += <val>` | 未声明，则声明并使其值为 `<val>`，否则追加并以空格分隔 |

// + _备注_：第一个非空字符直到换行符都将作为 `<val>` 的内容，_可使用 `\` 接续换行_；若变量声明后存在注释，则可能将注释前空白符引入到 `<val>` 的内容中（_空格变量_）
// + _备注_：若变量通过命令行设置，则 `Makefile` 中该变量赋值将被忽略，使用 `override` 修饰变量声明以强制使用 `Makefile` 中的变量赋值

// _全局变量_：在 `Makefile` 最外层声明，作用于整个 `Makefile`

// _目标变量_：作用于某构建规则，以 _同名/模式 `%`_ `<target>` 指定，并隐藏外部同名变量

// ```make
// target: var := value
// target:
// 	@echo $(var)
// ```

// TODO 多行变量、环境变量

// 环境变量

// ```make
// sources := foo.c bar.c
// ifneq ($(MAKECMDGOALS), clean)
// 	include $(sources:.c=.d)
// endif
// ```

// 自动化变量是在 `<recipes>` 中直接使用的，指向 `<target>` 或 `<prerequisite>` 的别名

// ```make
// $@ => $(firstword <targets>)
// 	$(@D), $(*D) => $(dir $@)
// 	$(@F) => $(notdir $@)
// 	$(*F) => $(basename $@)
// # 同样有 D, F 形式
// $+ => <prerequisties>
// $^ => 自动去重 <prerequisties>
// $< => $(firstword <prerequisites>)

// $*
// $?
// $%
// ```

// + 备注：建议加上扩号，如 `$(<)`
// #### 2.1.2 函数使用

// 函数

// GNU Make 提供了系列函数用于处理变量/字符串，其调用形式 `$(<fn> <args>) ${<fn> <args>}` 与变量的使用方式一直，_函数返回值可当作变量使用_

// |     |                函数                |                说明                |
// | :-: | :------------------------------: | :------------------------------: |
// | 替换  |  `$(subst <from>,<to>,<text>)`   | 替换 `<text>` 中的 `<from>` 为 `<to>` |
// | 替换  | `$(patsubst <pat>,<pat>,<text>)` |   将 `<text>` 中的 `<sub>` 进行模式替换   |
// | 替换  |        `$(strip <text>)`         |              移除前后空格              |
// | 查找  |  `$(findstring <find>,<text>)`   |      返回 `<find>` 或 `<null>`      |
// | 过滤  |   `$(filter <pat> ...,<text>)`   |   过滤出符合 `<pat> ...` 的 `<sub>`    |
// | 过滤  | `$(filter-out <pat> ...,<text>)` |   过滤出不符合 `<pat> ...` 的 `<sub>`   |
// | 排序  |         `$(sort <text>)`         |        对 `<sub>` 按单词升序排序         |
// | 访问  |      `$(firstword <text>)`       |         返回第 1 个 `<sub>`          |
// | 访问  |       `$(word <n>,<text>)`       |   返回第 `<n>` 个 `<sub>`（从 1 开始）    |
// | 切片  |   `$(wordlist <s>,<e>,<text>)`   |    获得 `<s>` 到 `<n>` 的 `<sub>`    |
// | 父路径 |         `$(dir <text>)`          |        处理每个 `<sub>`，获取父路径        |
// | 文件名 |        `$(notdir <text>)`        |        处理每个 `<sub>`，获取文件名        |
// | 基本名 |       `$(basename <text>)`       |       处理每个 `<sub>`，获取文件扩展名       |
// | 后缀名 |        `$(suffix <text>)`        |       处理每个 `<sub>`，获取文件后缀名       |
// | 后缀名 |  `$(addsuffix <suffix>,<text>)`  |       处理每个 `<sub>`，设置文件扩展名       |
// | 前缀名 |  `$(addprefix <prefix>,<text>)`  |       处理每个 `<sub>`，设置前缀路径        |
// | 拼接  |    `$(join <list1>,<list2>)`     |              对应拼接合并              |
// |     |           `$(foreach)`           |                                  |
// |     |             `$(if)`              |                                  |
// |     |            `$(call)`             |                                  |
// |     |           `$(origin)`            |                                  |
// |     |       `$(shell <command>)`       |      执行 Shell 命令并命令结果内容作为值       |
// |     |        `$(error <text>)`         |                                  |
// |     |       `$(warning <text>)`        |                                  |

// 获取一个路径下的 `.c` 文件
// ```make
// $(wildcard src/*.c)
// ```

// TODO 路径

// ### 2.2 目标构建

// 通过声明 _构建目标_ Target、_先决条件_ Prerequisite 和 _生成方法_ Recipe 的形式描述一种 _构建规则_；若先决条件已满足，则执行生成方法，产生构建目标，否则寻找并执行实现当前所需先决条件为构建目标的构建规则；本质上，通过若干组构建规则，描述了一棵构建关系树

// ```makefile
// # line comment
// <target> ...: <prerequisites> ; <recipe>  # 仅一行
// <target> ...: [<prerequisites>]
// 	[<recipes>]                       # 若干行；必须以 \t 起始
// ```

// _构建目标_：实体文件、伪目标标签；一般为生成方法的产物，也是该规则的名称

// _先决条件_：实体文件、伪目标标签；执行该构建规则的前提，也是该规则的依赖

// _生成方法_：若干命令；基于先决条件，顺序执行命令，生成构建目标

// ```make
// target:
// 	ls; pwd       # 多个命令使用 ; 分隔以写到一行
// 	mkdir build   # 每个命令执行后将检测返回码，若失败（非零），则终止构建
// 	@echo Hello   # 使用 @ 前缀，避免打印命令
// 	-rm -f *.o    # 使用 - 前缀，表示允许错误
// ```

// ```make
// .PHONY: all
// all: target1
// ```

// 在 Unix 开发中，根据预期功能，为作为最终目标的构建规则（伪目标）约定了固定的名称

// |       名称       |              说明              |
// | :------------: | :--------------------------: |
// |     `all`      |         编译所有需要编译的目标          |
// |    `clean`     |       清理被 `make` 创建的文件       |
// |   `install`    |         将构建产物拷贝到指定位置         |
// |    `print`     |          例出改变过的源文件           |
// |     `tar`      |      将源程序打包为 `tar` 归档文件      |
// |     `dist`     | 将 `tar` 归档文件压缩为 `.z` 或 `.gz` |
// |     `TAGS`     |       更新所有目标，以备完整地重新编译       |
// | `check`、`test` |      测试 `Makefile` 编译流程      |

//  显式规则

// _隐式规则 Builtin Rule_ 是一系列 GNU Make 预定义规则

// + _说明_：隐含规则默认启用，使用选项 `-r` 或 `-no-builtin-rules` 关闭隐含规则 

// ```make
// ```

// _模式规则 Pattern Rule_ 用于自动生成符合模式的构建目标，其构建目标必须含有 `%`

// ```make
// <a>%<b>: <c>%<d>
// 	<recipes>
// ```

// ```shell
// - src/
//   - foo/foo.c
//   - main.c
// - Makefile
// ```

// ### 2.3 指令

// #### 2.3.1 `if`

// _条件判断_ 可使运行时根据不同情况执行不同分支

// ```makefile
// # ifeq (<arg>, <arg>)
// # ifneq (<arg>, <arg>)
// # ifdef <arg>
// # ifndef <arg>
// <conditional-directive>
// 	# if true
// else
// 	# if false
// endif

// DEBUG ?= 1
// ifeq ($(DEBUG),1)
// CFLAGS += -DDEBUG
// endif
// ```

// #### 2.3.2 `include`

// _指令 `include`_ 是控制当前 `Makefile` 包含其他 `Makefile`，与 `#include` 完全一致

// ```makefile
// include <file> <file> ... # 若无法找到则报错
// -include <file>           # 可以不存在
// ```

// + _备注_：通常用于导入子目录中的 `xxx.mk` `Makefile`，或头文件依赖关系 `xxx.d`

// ## 3. C/C++ 项目

// ### 3.x 默认变量与隐式规则

// |   命令变量   |               说明               |
// | :------: | :----------------------------: |
// |  `CPP`   |      预处理命令，默认为 `$(CC) -E`      |
// | `CC CXX` |  C/C++ 编译命令，默认为 `cc` 或 `g++`   |
// |   `AS`   | 汇编命令，默认为 `as`，一般等效为 `$(CC) -s` |
// |   `AR`   |        函数库打包命令，默认为 `ar`        |
// |   `RM`   |          默认为 `rm -f`           |

// + _其他_：链接命令 `LD`

// _参数变量_：`CPPFLAGS`、`CFLAGS`、`CXXFLAGS`、`ASFLAGS`、`LDFLAGS`、`ARFLAGS`

// ```makefile
// %.o: %.c
// 	$(CC) -c $< $(CPPFLAGS) $(CFLAGS)
// %.o: %.s
// 	$(AS) $< $(ASFLAGS)
// %.s: %.S
// 	$(CPP) $< $(CPPFLAGS)
// %.o: %.cpp
// 	$(CXX) -c $< $(CXXFLAGS)
// %.o: %.cc
// 	$(CXX) -c $< $(CXXFLAGS)
// ```

// ### 3.x 自动生成头文件依赖

// 多数 C/C++ 编译器支持 `-M` 自动寻找源文件依赖的头文件，并生成 `Makefile` 依赖格式

// ```shell
// -M, -MM    # 进行预处理，生成 Makefile 头文件依赖到 stdin；后者排除系统头文件
// -MF FILE   # 将 Makefile 头文件依赖输出到指定文件中，一般以 .d 作为拓展名
// -MD, -MMD  # 在编译的同时，生成 Makefile 头文件依赖到同路径下；后者排除系统头文件
// # =================
// -MG        # 把缺失的头文件按存在对待,并且假定他们和源程序文件在同一目录下
// -MP        # 为 .h 依赖生成空的伪目标，避免头文件缺失而报错
// -MT TARGET # 在生成的依赖文件中,指定依赖规则中的目标
// ```

// ```makefile
// $(build)/%.o:%.c
// 	@$(CC) $(CFLAGS) -MMD -MP -c $< -o $(@)
	
// -include $(OBJS:.o=.d)
// ```

// 在将 `.c` 编译为 `.o` 的过程中，使用 `-MMD -MP` 参数，自动在 `.o` 文件同目录下生成对应的 `.d` 依赖文件，使用 `-include` 导入依赖文件并允许其不存在

// ### 3.x 创建构建产物镜像路径

// ```makefile
// build := build
// # path/to/file 的目标文件均生成在 build/path/to/file
// OBJ += $(addprefix $(build)/,$(filter %.o,$(SRC:%.c=%.o)))
// OBJ += $(addprefix $(build)/,$(filter %.o,$(SRC:%.S=%.o)))
// # 模式匹配目标文件，提取其输出路径，并使用 mkdir -p 递归创建
// $(build)/%.o:%.c
// 	@mkdir -p $(dir $(@))
// 	@$(CC) $(CFLAGS) -MMD -MP -c $< -o $(@)
// ```

// ```
// - project\
//   - src/main.c
//   - examples/example.c
// ```

// + _实现_：使用 `TARGET ?= main` 支持从通过参数选择构建目标
// + _实现_：使用 `SRC_MAIN` 选定主目标源文件；使用 `SRC_EXAMPLES` 选定每个示例对应源文件
// + _实现_：有 `SRC_MAIN SRC_EXAMPLES` 产生 `IMAGES`，产物放置于 `BUILD_DIR` 根目录
// + _实现_：使用 `build: $(filter %/$(TARGET).elf,$(IMAGES))` 实现指定构建目标
// + _实现_：使用 `$(filter %/$(TARGET).rel,$(OBJ_BIN))` 过滤出 `elf` 的 `main` 目标文件

// ## 4. pkg-config

// [`pkg-config`](https://www.freedesktop.org/wiki/Software/pkg-config/) 是一个在 Linux 开发中管理 C/C++ 库的 `-I -L -l` 参数的工具，

// 能自动生成正确的头文件路径（`-I`）、库路径（`-L`）和链接库名称（`-l`）等标志


// ## 5. Kconfig

// [`kconfiglib`](https://github.com/ulfalizer/Kconfiglib) 