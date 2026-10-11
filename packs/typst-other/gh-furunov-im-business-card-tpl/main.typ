#import "lib.typ": business-card

#business-card(
  is-print-ready: false,
  show-guides: false,
  
  producer-name: [NAME],
  producer-id: "00000000",
  sns-id: "@your_sns_id",
  idol-name: [Idol Name],
  
  history: (
    (year: "202X-XX", title: "活動開始"),
    (year: "202X-XX", title: "担当アイドルプロデュース"),
    (year: "202X-XX", title: "イベント参加・活動実績"),
    (year: "202X-XX", title: "実績タイトル A"),
    (year: "202X-XX", title: "実績タイトル B"),
  ),
  
  qr-image-path: "figs/qr-code.png",
  qr-label: [SNS],
  bg-image-path: "figs/background.jpg"
)
