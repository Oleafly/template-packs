#import "../src/lib.typ": doc

#show: doc(
  font: "HackGen Console NF",
  date: datetime.today(),
  serial: 1,
  client-name: "Example Company 御中",
  client-details: [
    〒000-0000 \
    東京都 Hoge 区 Fuga 1-1
  ],
  vendor-name: "NI57721",
  vendor-details: [
    〒000-0000 \
    東京都 Foo 区 Bar 1丁目 1-1
  ],
  seal: "../sample/assets/seal.png",
  transfer-destination: (
    bank: "Hoge 銀行",
    branch: "Fuga 支店",
    account: "0000000",
    name: "NI57721",
  ),
  comment: [
    備考欄 \
    Service Qux: 金5兆円 / 日
  ],
  items: (
    (
      name: "Service Foo",
      amount: 11,
      price: 100000,
    ),
    (
      name: "Service Bar",
      amount: 4,
      price: 300000,
    ),
    (
      name: "Service Baz",
      amount: 10,
      price: 10000,
    ),
  ),
)

