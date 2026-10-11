#import "templates/report.typ": *
#import "@preview/jastylest-zh:0.1.1": *

#show: report.with(
  title: "数字电路与逻辑设计实验报告",
  lab_number: "实验一",
  lab_name: "把大象装进冰箱",
  name: "农哥",
  stdid: "114514",
  create_time: "2025.09.09",
  banner: "../images/sysu-scst.png",
)

#set page(numbering: numbly("{1}", "第{1}页/共{2}页"))

#title(content: "实验一：把大象装进冰箱")

#counter(page).update(1)

= 实验内容摘要

我们采取切割大象、放入冰箱、合上冰箱门的三步法，把大象成功装进了冰箱。

= 具体实验内容

（附Proteus、block design电路图、实验箱拍照等图，或Verilog代码(注意排版美观)，并加上说明，通过读说明即可清楚实验结果）

== 切割大象

=== 实验步骤

1. 找到一只大象。

#figure(
  image("figures/elephant.png", width: 50%),
  caption: "大象"
)



2. 用锯子把大象切成小块。

=== 实验结果

成功把大象切成了小块。

== 放入冰箱

=== 实验步骤

1. 打开冰箱门。

2. 把切好的大象块放进冰箱。

=== 实验结果

成功把大象块放进了冰箱。

== 合上冰箱门

=== 实验步骤

1. 确保所有大象块都已放入冰箱内。

2. 合上门时要用力均匀，避免损坏冰箱。

== 编写代码自动化

=== 实验步骤

1. 使用编程语言编写代码，实现自动化切割、放入冰箱和合上冰箱门的过程。

```verilog
module counter10(
        //端口定义
        input                   rstn,   //复位端，低有效
        input                   clk,    //输入时钟
        output [3:0]    cnt,    //计数输出
        output                  cout);  //溢出位

        reg [3:0]               cnt_temp ;      //计数器寄存器
        always@(posedge clk or negedge rstn) begin
                if(! rstn)begin         //复位时，计时归0
                        cnt_temp        <= 4'b0 ;
                end
                else if (cnt_temp==4'd9) begin  //计时10个cycle时，计时归0
                        cnt_temp        <=4'b000;
                end
                else begin                                      //计时加1
                        cnt_temp        <= cnt_temp + 1'b1 ; 
                end
        end

        assign  cout = (cnt_temp==4'd9) ;       //输出周期位
        assign  cnt  = cnt_temp ;                       //输出实时计时器

endmodule
```

=== 实验结果

成功合上了冰箱门。

= 思考与总结

通过本次实验，我们掌握了如何将大象装进冰箱的技巧，理解了分步骤处理复杂问题的重要性。

// 可总结记录一些自己在实验中的发现，心得或技巧，方便以后复习，使自己在期末实验考察中更加胸有成竹。
