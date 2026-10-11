#import "template.typ": beschlussfaehigkeit, fsr-protokoll, naechstertermin, protokoll, tagesordnung

#show: fsr-protokoll.with(
  datum: datetime(year: 1970, month: 1, day: 1),
  anwesende: "Maxi Muster",
  oeffnung: datetime(hour: 16, minute: 15, second: 00),
  schliessung: datetime(hour: 18, minute: 00, second: 00),
  geste: "Im Rahmen bleiben",
)

#beschlussfaehigkeit(beschlussfaehig: true)

#tagesordnung(genehmigt: true)

#protokoll(datetime(year: 1970, month: 1, day: 1), genehmigt: true, vorbehalt: false)

#naechstertermin(datetime(year: 1970, month: 1, day: 1))

= Verschiedenes
