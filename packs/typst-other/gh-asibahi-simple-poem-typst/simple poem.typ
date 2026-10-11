#set text(dir: rtl, font: "Noto Naskh Arabic")

#let ahmed_shawqi =" ريمٌ على القاع بين البان والعلم
أحل سفك دمي في الأشهر الحرم
رمى القضاء بعيني جؤذر أسدا
يا ساكن القاع أدرك ساكن الأجم
لما رنا حدثتني النفس قائلة
يا ويح جنبك بالسهم المصيب رمي
جحدتها وكتمت السهم في كبدي
جرح الأحبة عندي غير ذي ألم
رزقت أصفح ما في الناس من خلق
إذا رزقت التماس الغدر في الشيم
يا لائمي في هواه والهوى قدر
لو شفك الوجد لم تعذل ولم تلم
لقد أنلتك أذنا غير واعية
ورب منتصت والقلب في صمم

كتبه أحمد شوقي غفر الله له ولوالديه

"


#let set_poetry(my_lines) = {
  set align(center)
  let jb = linebreak(justify: true)
  let lines = my_lines.trim("\n")
                      .split("\n")
                      .map(line => line.trim(" "))
                      .filter(body => body.len() != 0)
  context [
    #block(above: 1em, {
      let max_size = lines
        .map(body => measure(body).width)
        .sorted().last()
      layout(page_size => {
              if page_size.width > max_size * 2 + 20pt { 
          for (index, line) in lines.enumerate() {        
            if calc.rem(index, 2) == 0 [
              #box(width: max_size , line + jb) 
            ] else [
              #box(width:20pt, ) #box(width: max_size , line + jb) \ 
            ]
          }          
        } else {        
          block(width: max_size + 50pt,
            for (index, line) in lines.enumerate() {   
              if calc.rem(lines.len(), 2) == 1 and index == lines.len() - 1 [
                #box(width: max_size , line + jb) 
              ] else if calc.rem(index, 2) == 0 [
                #set align(start)
                #box(width: max_size , line + jb) 
              ] else [
                #set align(end)
                #box(width: max_size , line + jb) \
              ] 
            }
          ) // block
        } // else
      }) // layout
    }) // block
  ] // context
} // let


#set_poetry(ahmed_shawqi)

= نديم الباذنجان

#set_poetry("
كان لسلطان نديم وافي
يعيد ما قال بلا اختلاف
وقد يزيد في الثنا عليه
إذا رأى شيئا حلا لديه
وكان مولاه يرى ويعلم
ويسمع التنميق لكن يكتم
فجلسا يوما على الخوان
وجيء في الكل بباذنجان
فأكل السلطان منه ما أكل
وقال هذا في المذاق كالعسل

قال النديم صدق السلطان
لا يستوي شهد وباذنجان

")

#set text(dir: ltr, font: "IBM Plex Serif")

= LTR Usage

#set_poetry("
Shall I compare thee to a summer’s day?
Thou art more lovely and more temperate.
Rough winds do shake the darling buds of May,
And summer’s lease hath all too short a date.
Sometime too hot the eye of heaven shines,
And often is his gold complexion dimmed;
And every fair from fair sometime declines,
By chance, or nature’s changing course, untrimmed;
But thy eternal summer shall not fade,
Nor lose possession of that fair thou ow’st,
Nor shall death brag thou wand'rest in his shade,
When in eternal lines to Time thou grow'st.
So long as men can breathe, or eyes can see,
So long lives this, and this gives life to thee.

")
