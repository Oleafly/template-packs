#import "./lib.typ": invoice
#show: invoice.with(
  due-date: datetime(year: 2026, month: 5, day: 31),
  recipient: (
    name: [◯◯株式会社],
    postal-code: [123-4567],
    address: [◯◯県△△市□□町1-2-3],
  ),
  issuer: (
    name: [田中 太郎],
    postal-code: [321-6543],
    address: [△△県◯◯市□□町3-2-1],
  ),
  account: (
    bank: [◯◯銀行],
    branch: [△△支店],
    type: [普通],
    number: [1234567],
    holder: [タナカ タロウ],
  ),
  items: (
    (
      name: [作業費],
      amount: 10,
      unit: [時間],
      price: 5000,
    ),
    (
      name: [交通費],
      amount: 1,
      price: 1200,
    ),
  )
)

以下空白
