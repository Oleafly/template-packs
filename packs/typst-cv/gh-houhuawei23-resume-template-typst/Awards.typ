#import "template.typ": *
#import "PersonalInfos.typ": *

#let Scholarship_duration = display_duration(d1: EnrollDay, d2: Today, date_format: false)
#let OutstandingStudent_date = datetime(year: 1234, month: 9, day: 1)
#let Heaven_Modeling_Contest_date = datetime(year: 1234, month: 12, day: 1)

#let Awards = [
  #item(
    [ *Heaven Scholarship* ], [ *First* ],
    Scholarship_duration
  )
  #item(
    [ *The 1345th Heaven Modeling Contest* ], [ *Second Prize* ],
    display_date(d: Heaven_Modeling_Contest_date, date_format: false)
  )
]

#let Awards_zh = [
  #item(
    [ *天庭学业优异奖学金* ], [ *一等奖* ],
    Scholarship_duration
  )
  #item(
    [ *第一千三百四十五届天庭建模竞赛* ], [ *二等奖* ],
    display_date(d: Heaven_Modeling_Contest_date, date_format: false)
  )
]