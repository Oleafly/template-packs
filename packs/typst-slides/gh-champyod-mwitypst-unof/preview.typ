// MWITypst-UNOF Preview — EN + TH
#import "lib.typ": *

#show: mwit-unof-theme.with(
  department: [Mathematics and Computational Science],
  logo: image("assets/mwit-logo.png"),
  progress-bar: true,
  config-info(
    title: [MWITypst-UNOF],
    subtitle: [Unofficial MWIT Presentation Theme],
    author: [Yodsakon Nawalertpanya],
    date: datetime.today(),
    institution: [Mahidol Wittayanusorn School],
    short-title: [MWITypst-UNOF],
  ),
)

#focus-slide[
  MWIT Brand Colors
  #text(size: 0.4em, weight: "regular")[Mahidol Blue + Gold]
  #v(0.8cm)
  #text(size: 0.7em)[สีประจำโรงเรียนมหิดลวิทยานุสรณ์]
  #text(size: 0.4em, weight: "regular")[น้ำเงินมหิดล + ทองมหิดล]
]

#title-slide()

#outline-slide()

= Palette

== Primary

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  block(height: 4em, fill: mwit-primary, radius: 4pt, inset: 0.4em, text(fill: white, weight: "bold", size: 0.5em, align(left + bottom)[Primary] + text(size: 0.35em)[ สีหลัก 0035AD])),
  block(height: 4em, fill: mwit-secondary, radius: 4pt, inset: 0.4em, text(fill: black, weight: "bold", size: 0.5em, align(left + bottom)[Secondary] + text(size: 0.35em)[ สีรอง FEBF3A])),
  block(height: 4em, fill: mwit-tertiary, radius: 4pt, inset: 0.4em, text(fill: white, weight: "bold", size: 0.5em, align(left + bottom)[Tertiary] + text(size: 0.35em)[ สีเสริม 4A8FE4])),
)

== Neutrals

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 1em,
  block(height: 4em, fill: mwit-primary-dark, radius: 4pt, inset: 0.4em, text(fill: white, size: 0.5em, align(left + bottom)[Primary Dark] + text(size: 0.35em)[ สีหลักเข้ม])),
  block(height: 4em, fill: mwit-text, radius: 4pt, inset: 0.4em, text(fill: white, size: 0.5em, align(left + bottom)[Text] + text(size: 0.35em)[ ข้อความ])),
  block(height: 4em, fill: mwit-text-muted, radius: 4pt, inset: 0.4em, text(fill: white, size: 0.5em, align(left + bottom)[Text Muted] + text(size: 0.35em)[ ข้อความอ่อน])),
  block(height: 4em, fill: mwit-surface, radius: 4pt, inset: 0.4em, text(fill: black, size: 0.5em, align(left + bottom)[Surface] + text(size: 0.35em)[ พื้นผิว])),
)

== Blue to Gold Meaning

#quote-block(attribution: [MWIT Vision])[
  Blue symbolizes the king: strength, stability, discipline.\
  Gold symbolizes science: rational imagination, sincerity, morality.
]

== ความหมายของสีน้ำเงินและสีทอง

#quote-block(attribution: [วิสัยทัศน์ MWIT])[
  น้ำเงินแทนพระมหากษัตริย์: ความเข้มแข็ง มั่นคง ระเบียบวินัย\
  ทองแทนวิทยาศาสตร์: จินตนาการอันมีเหตุผล ความจริงใจ ศีลธรรม
]

= Content

== Slide Types

- `#title-slide()` — cover page
- `#slide[..]` — default slide
- `= Section` — section divider
- `#outline-slide()` — table of contents
- `#ending-slide[..]` — closing
- `#focus-slide[..]` — attention
- `#matrix-slide[..][..]` — grid layout

== Content Slide

Normal slide with bullet list.

- Item one
- Item two
  - Nested
  - Items

#slide(title: [Custom Title])[
  Slide with explicit title (overrides heading).
]

= เนื้อหา

== ประเภทสไลด์

- `#title-slide()` — หน้าปก
- `#slide[..]` — สไลด์เริ่มต้น
- `= Section` — หัวข้อแบ่งตอน
- `#outline-slide()` — สารบัญ
- `#ending-slide[..]` — ปิดท้าย
- `#focus-slide[..]` — เน้นย้ำ
- `#matrix-slide[..][..]` — ตาราง

== สไลด์เนื้อหา

สไลด์ปกติพร้อมรายการหัวข้อย่อย

- รายการที่ 1
- รายการที่ 2
  - ซ้อนใน
  - รายการย่อย

#slide(title: [หัวข้อที่กำหนดเอง])[
  สไลด์ที่มีหัวข้อชัดเจน (แทนที่หัวเรื่อง)
]

= Blocks

== Styled Blocks

#mwit-theorem[
  For any integer $n > 2$, there are no positive integers $a, b, c$ satisfying $a^n + b^n = c^n$.
]

#mwit-definition[
  A *group* is a set $G$ with operation $G times G -> G$ satisfying closure, associativity, identity, invertibility.
]

#mwit-example[
  The integers $ZZ$ under addition form a group.
]

#alert-box[
  Alert box for warnings or important notes.
]

#highlight-box[
  Highlight box for key takeaways.
]

#quote-block(attribution: [Albert Einstein])[
  Imagination is more important than knowledge.
]

Inline #mwit-emphasis[emphasis] works like this.

= บล็อก

== บล็อกรูปแบบ

#mwit-theorem[
  สำหรับจำนวนเต็ม $n > 2$ ใดๆ ไม่มีจำนวนเต็มบวก $a, b, c$ ที่ทำให้ $a^n + b^n = c^n$
]

#mwit-definition[
  *กรุป* คือเซต $G$ พร้อมการดำเนินการ $G times G -> G$ ที่สมบัติการปิด การเปลี่ยนหมู่ เอกลักษณ์ และตัวผกผัน
]

#mwit-example[
  จำนวนเต็ม $ZZ$ ภายใต้การบวกเป็นกรุป
]

#alert-box[
  กล่องแจ้งเตือนสำหรับคำเตือนหรือข้อความสำคัญ
]

#highlight-box[
  กล่องเน้นข้อความสำหรับประเด็นสำคัญ
]

#quote-block(attribution: [อัลเบิร์ต ไอน์สไตน์])[
  จินตนาการสำคัญกว่าความรู้
]

การเน้นแบบ #mwit-emphasis[อินไลน์] ทำงานเช่นนี้

= Cite & Ref

== Citations (APA 7th)

Use #cite(<touying2024package>) for parenthetical.

Or use #cite(<touying2024package>, form: "prose") for narrative.

#cite(<typst2023compiler>, form: "prose") is the foundation of this project.

This theme forks #cite(<cerpac2024cleartub>) and builds on Touying.

The GOaT project #cite(<nawalertpanya2025goat>) hosts this theme as a submodule.

#slide-ref[Source: MWIT Brand Guidelines, 2026]

== Footnotes

Footnote via #slide-cite[Inline citation style]#slide-cite[Source: Touying docs].

Or with a direct footnote.footnote[Mahidol Wittayanusorn School, Brand Guidelines, 2026.]

Lorem ipsum dolor sit amet.footnote[TH Sarabun New — standard formal Thai academic typeface.]

= การอ้างอิง

== การอ้างอิง (APA ครั้งที่ 7)

ใช้ #cite(<touying2024package>) สำหรับอ้างอิงในวงเล็บ

หรือใช้ #cite(<touying2024package>, form: "prose") สำหรับอ้างอิงแบบเนื้อความ

#cite(<typst2023compiler>, form: "prose") เป็นรากฐานของโครงการนี้

ธีมนี้แตกกิ่งจาก #cite(<cerpac2024cleartub>) และสร้างบน Touying

โครงการ GOaT #cite(<nawalertpanya2025goat>) เป็นที่เก็บธีมนี้เป็นโมดูลย่อย

== เชิงอรรถ

เชิงอรรถด้วย #slide-cite[รูปแบบอ้างอิงในเนื้อหา]#slide-cite[ที่มา: เอกสาร Touying].

หรือเชิงอรรถโดยตรง.footnote[โรงเรียนมหิดลวิทยานุสรณ์, คู่มือเอกลักษณ์, 2026.]

#slide-ref[แหล่งที่มา: คู่มือเอกลักษณ์ MWIT, 2026]

= Advanced

#focus-slide[
  Focus Slide
  #text(size: 0.5em)[Full-color attention slide]
]

#focus-slide[
  สไลด์เน้นย้ำ
  #text(size: 0.5em)[สไลด์เน้นความสนใจแบบเต็มสี]
]

#ending-slide(title: [Thank You])[
  #text(size: 0.8em)[ Questions? ]
]

#ending-slide(title: [ขอบคุณ])[
  #text(size: 0.8em)[ มีคำถาม? ]
]

== Matrix

#matrix-slide[A][B][C][D]

== เมทริกซ์

#matrix-slide[ก][ข][ค][ง]

== Bibliography

#bibliography-slide[
  #bibliography("ref.bib", title: none)
]
