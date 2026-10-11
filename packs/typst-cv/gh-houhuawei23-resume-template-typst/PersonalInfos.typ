#import "template.typ": *
#import "OuterInfos.typ": *

// Personal Info
#let Name = "Sun Wukong"
#let Name_zh = "孙悟空"

#let PoliticalStatus = "Protector of the Horses"
#let PoliticalStatus_zh = "弼马温"

#let Photograph = "./images/wukong.jpg"

#let Grade = "GPA: 3.90/4 · Rank: 1/108 , CET4 6xx · CET6 5xx"

#let CourseCS1 = "Sweep and Mop (90), Carry wood and water (98)"
#let CourseCS2 = "Talk about the scriptures (91), PLearn to write and burn incense (89)"
#let CourseCS_zh = "洒扫应对 (90)、进退周旋 (98)、讲经论道 (91)、习字焚香 (89)"

#let CourseAI = "Immortality(98), Seventy-two changes (96), Somersault Cloud (91)"
#let CourseAI_zh = "长生不老术 (98)、地煞七十二变 (96)、筋斗云 (91)"

#let University = "Lingtai Fangcun Mountain"
#let University_zh = "灵台方寸山"
#let UniversityShort = "LFM"

#let College = "Oblique moon three star Cave"
#let College_zh = "斜月三星洞"
#let CollegeShort = "OMTSC"

#let Major = "Somersault Cloud"
#let Major_zh = "筋斗云"

#let PhoneNumber = "(+86) 123-456-7890"

#let MailAddress = "sunwukong@tiangong.edu.cn"

#let GithubContent = "github.com/sunwukong"
#let GithubHomePage = "https://github.com/sunwukong"

#let PersonalBlogContent = "sunwukong.github.io"
#let PersonalBlogPage = "https://sunwukong.github.io"

#let Lab1 = "Huaguo Mountain"
#let Lab1_zh = "花果山"

#let Lab2 = "Heaven"
#let Lab2_zh = "天庭"

#let EnrollDay =  datetime(year: 1234, month: 9, day: 1)
#let GraduationDay = datetime(year: 2345, month: 8, day: 1)

// #let Today = datetime(year: 2024, month: 12, day: 1)
#let Today = datetime.today()

#let Intro = [
  I am Sun Wukong, currently studing at #University, majoring in #{Major}. My primary research interests include Immortality, Seventy-two changes and Somersault Cloud, and developed Huo-Yan-Jin-Jing in Ba-Gua Furnace. Currently, I am participating in a national-level project to escort Tang monks to the west to learn scriptures.
]


#let Intro_zh = [
  我是#{Name_zh}，现就读于#{University_zh}、#{College_zh}，专业为#{Major_zh}。感兴趣的研究方向为长生不老术、地煞七十二变与筋斗云，并在八卦炉中练就了火眼金睛。目前正在参与护送唐僧西天取经的国家级项目。
]


// 专业技能
#let ProgrammingLanguages = [
  // C++, Python, Rust
  #CPP, 
  #Python, 
  #Rust
]

#let Skills = [
  // Linux, CMake, PyTorch, LaTex, 
  #Linux,
  #CMake,
  #PyTorch,
  #LaTex,
  #Typst,
  #MPI
]

