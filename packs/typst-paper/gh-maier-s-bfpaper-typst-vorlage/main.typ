#import "lib.typ" : BFPaper


#show: BFPaper.with(
  title: "Hier geht es um irgendeine krasse Arbeit mit krassem Inhalt",
  work_type: "Bachelorarbeit",
  left_image: "assets/zf_lifetec_logo.jpeg",
  right_image:"assets/DHBW_CAS_LOGO.png",
  image_height: 2cm,
  author: "Stefan Maier",
  matrikelnummer: "12345678",
  dualer_partner: "ZF-Lifetec",
  betreuer: "Prof. Dr. Mustermann",
  pruefer: "Prof. Dr. Musterfrau",
  bearbeitungszeitraum: "01.01.2023 - 01.02.2023"
)

#include "chapter/Chap1.typ"
#include "chapter/Chap2.typ"
