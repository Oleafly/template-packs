#import "../lib.typ": render-resume

#render-resume(
  date: datetime(year: 2026, month: 4, day: 5),
  name: (
    family-name: (base: "山田", ruby: "やまだ"),
    first-name: (base: "花子", ruby: "はなこ"),
  ),
  birth-year: "2001",
  birth-month: "4",
  birth-day: "12",
  age: "24",
  sex: "",
  furigana-address: "とうきょうと ぶんきょうく ほんごう",
  address: [
    113-0033 東京都文京区本郷 1-2-3 \
    本郷コーポ 203
  ],
  phone-current: "03-1234-5678",
  furigana-contact: "",
  contact: [同上],
  phone-contact: "",
  history-left: (
    (year: "", month: "", body: "学歴"),
    (year: "2020", month: "3", body: "東京都立青葉高等学校 卒業"),
    (year: "2020", month: "4", body: "緑川大学 文学部 日本語日本文学科 入学"),
    (year: "2024", month: "3", body: "緑川大学 文学部 日本語日本文学科 卒業"),
    (year: "", month: "", body: "職歴"),
    (year: "2024", month: "4", body: "青葉事務サービス株式会社 入社"),
    (year: "", month: "", body: "現在に至る"),
    (year: "", month: "", body: "以上"),
  ),
  history-right: (),
  licenses: (
    (year: "2019", month: "11", body: "日本漢字能力検定 2級 取得"),
    (year: "2020", month: "8", body: "実用英語技能検定 準2級 取得"),
  ),
  motivation: [
    事務職としての基礎を着実に身につけ、正確さと丁寧さを大切にしながら業務に取り組んできました。
    社内外のやり取りでも、相手に伝わりやすい言葉を選ぶことを心掛けています。
  ],
  hope: [
    東京23区内での勤務を希望します。
    勤務開始日はご相談のうえ調整可能です。
  ],
)
