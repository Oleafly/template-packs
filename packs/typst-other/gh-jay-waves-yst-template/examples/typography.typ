#import "../lib.typ": template, theorem
#show: template
= 标题 Heading
正文 Latin，中文。 *加粗 Bold* _强调 Italic_

#strong[加粗 #emph[强调 Both 中文]]

#emph[强调 #strong[加粗 Both 中文]]

#table(columns: 2, table.header([表头 Header], [值 Value]), [中文 Text], [450])

`code 中文`

```cpp
// 中文 comment
int value = 1;
```

#theorem[中文 theorem *加粗 Bold*]
