#import "template.typ": *
#import "PersonalInfos.typ": *

#let YH_date = datetime(year: 1234, month: 7, day: 1)
#let TianheCup_date = datetime(year: 1234, month: 9, day: 1)
#let StrongArmyCup_date = datetime(year: 1234, month: 9, day: 1)

#let Extracurriculars = [
  #item(
    [ Served as QiTian DaSheng, Bi Ma Wen and so on. ], [],
    display_duration(d1: EnrollDay, d2: Today)
  )
  #item(
    [ The main organizer and participant of the "Havoc in Heaven" event ], [],
    display_date(d: YH_date)
  )
  #item(
    [ Heaven Court Games Somersault Cloud First Place ], [],
    display_date(d: TianheCup_date)
  )
]

#let Extracurriculars_zh = [
  #item(
    [ *历任花果山山主、齐天大圣、弼马温等职务* ], [],
    display_duration(d1: EnrollDay, d2: Today)
  )
  #item(
    [ *“大闹天宫”事件的主要组织者与参与者* ], [],
    display_date(d: YH_date)
  )
  #item(
    [ *天庭运动会筋斗云第一名* ], [],
    display_date(d: TianheCup_date)
  )
]