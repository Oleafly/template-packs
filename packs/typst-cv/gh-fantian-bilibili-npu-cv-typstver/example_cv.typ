/*
  PLEASE READ BEFORE USE

  Typst 作为一门较新的可编程编标记语言，网上的教程在数量上和质量上还有很大的提升空间。如果想要对Typst进行比较深入的学习了解，推荐大家参考Typst官网的文档进行学习：
    EN Docs:https://typst.app/docs/
    CN-Simplified Docs(unofficial):https://typst.dev/docs/chinese/
  需要注意的是，CN-Simplified Docs为非官方维护的社区文档，时效性和准确性有限。

  关于如何配置Typst环境，笔者推荐参考：https://zhuanlan.zhihu.com/p/644816041 

  这个项目参考自叁叁学长的Latex版本NPU-CV：https://github.com/CSW33/NPU-CV 在此感谢叁叁学长对广大瓜大学子的无私帮助 :)
  Typst版本对比Latex版本，在修改的快捷性和环境的轻量化上有着显著的提升，无需大量引入宏包，无需纠结于复杂语法，特别是在数学公式方面。

  这个项目已经预留了对CV进行丰富的魔改/自定义的接口，如果你对此很感兴趣，可以参考项目根目录下的 usage_guidence.md 文件。
  如果你是一个对于自定义不太感兴趣，只想要快速方便地制作一份CV的同学，可以参考以下的范例代码进行实现，只需要简单地修改文字内容即可，其中一些必须知道的语法也会在第一次出现时给予详细说明。


*/

#import "template.typ":*

//页眉页脚内容部分

#show: npu-cv.with(
  school: [电子信息学院 | School of Electronics And Information],
  latin-font: "Arial",//西文字体设置，可以改成自己喜欢的字体，但是需要注意两点：1.修改只会在页眉页脚部分生效 2.需要提前查证好字体名字，Typst找不到字体会导致修改失败/无法正常编译预览的情况；
  cjk-font: "Microsoft YaHei",//中文字体，注意事项同上；
  body-size: 11pt,//字体大小，也就是字号
  contacts: [
    #contact("envelope", [sansuan.yu\@gmail.com])//在正文输入@符号的时候需要加上反斜杠，这点需要额外注意，第一个参数是选择icon的参数，维持不变即可
    #h(4em)
    #contact("chat-bubble-left-right", [my_wechat_number])
    #h(4em)
    #contact("phone", [12345678900])
    #h(4em)
    #contact("code-bracket", [https://github.com/fantian-bilibili])
  ],
)
//正文内容部分

#v(0.5cm)//控制空白间距的函数，谨慎修改，调整其中的数字会改变这行函数下面部分的内容和上面部分的内容之间的空白距离。下同，不再叙述；

#grid(
  columns: (82.5%, 15%),//第一个参数调整个人信息下面那条蓝线的长度，第二个参数调整右侧图片的大小
  column-gutter: 2.5%,//调整图片左边缘到蓝线右边缘的距离
  align: (top, top),
  [
    #cv-section([个人信息], icon: "user")//大title 1
    #v(1.2em)
    #grid(
      columns: (auto, 1fr, auto, 1fr),
      column-gutter: 0.8em,//“姓名：”和“名字”之间的距离
      row-gutter: 0.8em,//两行之间的行间距
      
      [姓名:], [叁酸], [性别:], [男],
      [出生日期:], [2006年05月26日], [政治面貌:], [共青团员],//如果想要添加内容，直接按照[xxx], [xxx],的格式填写进去即可，默认一行可以有四个内容块[xxx]，注意每个中括号后的逗号，包括最后一个！！！！！！！！！！！！！！！！！！
    )
  ],
  [
    #image("images/example_pic_sansuan.jpg", width: 100%)//你的证件照or生活照，这里的路径是.typ文件和图片的相对路径，width参数调整的是图片大小
  ],
)

#v(-0.8cm)

#cv-section([教育背景], icon: "academic-cap")//大title 2

#v(1.2em)

#grid(
  columns: (1fr, 1fr, auto),
  column-gutter: 0.8em,//列间距
  row-gutter: 0.8em,//行间距
  [西北工业大学电子信息学院], [通信工程专业], [2024年 -- 预计2028年7月毕业],
  [*GPA: 4.1/4.1*], [*GPA排名: 1/∞*], [*综测排名: 1/∞*],
  //需要注意，在Typst里如果你需要加粗文字，需要把需要加粗的文字用英文**框起来，例如*xxx*
)

#v(0.8em)

#cv-small[
  已修课程：计算方法，机器视觉与人工智能，计算机视觉技术，语音信号处理，智能人机交互与视觉感知综合设计，遥感信息获取与处理导论，通信原理，高频电子线路
]//小字函数，能够帮助你快速写出小字（9.2pt）

#v(0.8em)

#cv-section([项目经历], icon: "beaker")//大title 3

#v(0.2em)
//cv-entry是项目经历函数，如果你想多写俩论文可以把cv-entry函数换成下面的cv-paper论文函数
#cv-entry(
  [基于博弈论的FPS-ECO局起枪逻辑],//左上角项目名字
  tail: [国家级大创-优秀结题],//项目基本情况
  role: [第一负责人],//个人扮演角色
  date: [2024年7月-2025年7月],//起止日期
)[
  主要负责在*西埃斯兔*和*蛙落兰特*两个多人在线测试平台验证完成建模分析的起枪逻辑，通过段位升降和队友红温程度判断当前逻辑是否可靠。*截至目前已无分可掉，示例图可见*<fig-example-1>//项目具体内容部分，<fig-example-1>是和后面图片部分链接的，此处会被自动替换成图1，但是预览的时候不一定生效，如果不需要直接删除就可以。
]

#v(1.2em)

//论文函数
#cv-paper(
  [Improving Multi-Modal Brain Tumor Detection with Contrastive Learning and CLIP Prompt Fine-Tuning],//左上角论文名字
  venue: [EI会议-在投],//会议/期刊名字
  role: [学生独作],//个人扮演角色
  date: [2024年1月-2023年12月],//起止日期
  title-style: "italic",//是否把论文标题设置为斜体，可以填入"normal", "italic", or "oblique"三个参数，normal就是设定为无斜体，后二者都是设定为斜体
)[
  *（标题与内容由GPT乱编的，现实中应该没有这论文吧。。大概。）独自进行前期研究，实验验证和论文写作*。重点探索了将*多模态医学影像*（如MRI和CT）与*自然语言模型*相结合的方法，以提高脑肿瘤检测的准确性。成功将对比学习和Prompt Fine-Tuning技术应用于医学影像分析中，将模型在脑肿瘤检测任务中的性能提升到了*超越SOTA的水平*，特别是在 one-shot 场景下取得了显著的改进。<fig-example-2>//论文具体内容部分
]

#v(1.2em)
//论文也可以使用cv-entry函数，本质上entry只是比paper少了title style参数
#cv-entry(
  [基于阴间蓝牙通信系统的高速运转机器设计],
  tail: [SCI期刊-二区在投],
  role: [一作],
  date: [2023年12月-2024年1月],
)[
  你有这么*高速运转的机械*进入中国，进入我给出的原理，小时候。就是*研发人*，就是研发这个东西的原理是*阴间政权*管。你知道为什么有圣灵给它*运转仙位*？还有专门饲养这个？为什么地下产这种东西？他管的他是五世同堂旗下子孙。你以为我跟你闹着玩儿呢？你不警察吗？黄龙江一带全都*带蓝牙*。黄龙江我告诉你在阴间是是那个化名，化名我小舅，亲小舅，张学兰的那个嫡子、嫡孙。产品渲染图见<fig-example-3>
  ], 

#v(1.2em)

#cv-entry(
  [大国工匠-论锤子是怎么炼成的],
  tail: [工程项目-已完结],
  role: [主要技术负责人],
  date: [忘了日期],
)[
  对古代中国工匠制作锤子的历史、工艺和技术进行深入研究，包括原材料的选择、工具的制作、锤子的设计和锻造工艺等方面。结合现代工艺技术和设计理念，探索如何将古代工匠的技艺与现代制造工艺相结合，以提高锤子的性能、品质和设计。通过实际制作锤子的过程，验证理论和技术的可行性，并对制作过程中的关键环节进行深入分析和总结，成品见。
]

#pagebreak()//换页函数，当前页会在换页函数处直接结束，换到下一页，当前页的剩余分则会被全部设置为空白

//图片部分
#grid(
  columns: (1fr, 1fr, 1fr),//设置的是一行展示多少张图片，如果要设置一行四张图则columns: (1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.8em,//列间距，也就是图片间距
  align: bottom,//对齐方式，这里是下对齐，上对齐则是top
  [
    #set text(size: 8pt)//图下文字大小
    #figure(
      image("images/example_image_1.png", width: 100%),//你需要添加的图片，这里的路径是.typ文件和图片的相对路径，width参数调整的是图片大小
      caption: [效果图。],//只需要输入图下问题，图X:会自动添加进去
    ) <fig-example-1>//和前文链接的部分，详见第一个cv-entry函数
  ],
  [
    #set text(size: 8pt)
    #figure(
      image("images/example_image_2.png", width: 100%),
      caption: [机器渲染图。],
    ) <fig-example-2>
  ],
  [
    #set text(size: 8pt)
    #figure(
      image("images/example_image_3.png", width: 100%),
      caption: [你看个锤子看。],
    ) <fig-example-3>
  ],
)

#v(0.8em)

#cv-section([竞赛经历], icon: "trophy")//大title 4

#v(0.8em)
// 第一种写法：无简介写法
#grid(
  columns: (1fr, auto, auto, auto),
  column-gutter: 1.5em,//列间距
  row-gutter: 0.8em,//行间距
  [*2023年全国大学生无聊透顶比赛*], [第一负责人], [国家级-第10名], [2023年4月],
  [*2023年优质肛门大赛*], [个人参赛], [国家级-一等奖], [2023年8月],
  [*2022年全国大学生提肛大赛*], [个人参赛], [省级-一等奖], [2022年12月],
)

#cv-red-large[或者你可以]
//快速帮你写出红色大字的函数（18pt）

#grid(
  columns: (1fr, auto, auto, auto),
  column-gutter: 1.5em,
  row-gutter: 0.8em,
  [*2022年全国大学生交流大赛*], [技术负责人], [省级-三等奖], [2023年8月],
)

#v(0.3em)

("鸡同鸭讲"系统--一款全新的乱套翻译软件)主要负责了*移动端(安卓&IOS)软件开发*，*数据库建立与部署*，实现了低达*0.01%的翻译准确率*。//这里直接填写上述竞赛经历的具体内容即可

#v(1em)

#grid(
  columns: (1fr, auto, auto, auto),
  column-gutter: 1.5em,
  row-gutter: 0.8em,
  [*2022年全国大学生睡觉大赛*], [技术负责人], [省级-一等奖], [2023年4月],
)

#v(0.3em)

(基于躺姿的标准8小时睡眠理论研究)主要负责了*躺姿的设计*，枕头和床褥的选购。在队友的助眠协助下成功睡眠*8小时*。

#v(0.8em)

#cv-section([技能特长], icon: "wrench-screwdriver")//大title 5

#v(0.8em)
//列举函数，可以列举多个内容，cols函数用来设定列数，内容优先从最左列从左到右填充，填充完一行后换行
#cv-items((
  [熟练提肛技巧],
  [在游戏中熟练使用C语言],
  [熟悉安卓环境下的游戏安装],
  [遇到困难会睡大觉],
  [饿了会吃饭],
  [尿急会上厕所],
  [没钱了会让你发工资],
), cols: 1)



#v(0.5cm)

#cv-section([所获荣誉], icon: "sparkles")

#v(0.8em)
//这里就是典型的多列列举函数，可以和前面的单列列举函数对比
#cv-items((
  [某年学业先进个人],
  [某年某奖学金某等奖],
  [某大使],
  [某年某奖学金某等奖],
  [某年优秀团员称号],
  [某年某称号],
), cols: 2)

#v(0.8em)

#pagebreak()

#v(0.5cm)

#cv-section([其他], icon: "information-circle")

#v(0.8em)
#cv-items((
  [英语水平-CET6级xxx分],
  [计算机几级证书],
  [xx几级证书],
  [技术博客: 某网址],
  [教师资格证：xxx],
  [普通话证书：几级几等],
  [文字排版：Typst],
), cols: 1)
