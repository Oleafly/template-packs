#import "../template/lib.typ": *

= Phụ Lục
<phu-luc>

== Mã Nguồn Template
<ma-nguon-template>

Toàn bộ mã nguồn template được lưu trữ công khai trên GitHub:

- *Repository*: #link("https://github.com/samdinh-uit/typst-report-template")[github.com/samdinh-uit/typst-report-template]
- *Nhánh demo này*: `refactor-demo` (tách từ `refactor-docs-structure`)
- *Giấy phép*: MIT License

== Công Cụ Sử Dụng
<cong-cu-su-dung>

#figure(
  rounded-table(
    columns: (25%, 15%, 60%),
    align: (left, center, left),
    table.header([*Công Cụ*], [*Phiên Bản*], [*Mục Đích*]),
    [Typst],          [0.14+],  [Biên dịch `.typ` → PDF],
    [Cowork / Claude],[Sonnet 4.6], [Hỗ trợ soạn thảo và tự động hóa workflow],
    [Git],            [2.x],    [Quản lý phiên bản và nhánh],
    [Pandoc],         [3.0+],   [Chuyển đổi Markdown → Typst (tùy chọn)],
    [GNU Make],       [4.x],    [Tự động hóa biên dịch qua Makefile],
  ),
  caption: [Công Cụ Hỗ Trợ],
  kind: table,
  outlined: false,
  numbering: none,
)

== Hướng Dẫn Nhanh
<huong-dan-nhanh>

=== Cài Đặt

```bash
# Clone repository
git clone https://github.com/samdinh-uit/typst-report-template.git
cd typst-report-template

# Tạo nhánh mới cho bài tập
git checkout -b IE105-TH7A
```

=== Biên Dịch

```bash
# Qua Makefile (khuyến nghị)
make thesis.pdf

# Thủ công
typst compile thesis.typ --font-path template/fonts
```

=== Cấu Trúc Thư Mục

```
typst-report-template/
├── template/           ← API template (lib.typ, components/, ...)
├── content/            ← Nội dung bài tập (.typ + .md)
├── config/
│   ├── metadata.yaml   ← Thông tin bài tập, sinh viên, môn học
│   └── config.yaml     ← Cấu hình font, màu, theme
├── docs/               ← Tài liệu tham khảo (getting-started.md, ...)
├── thesis.typ          ← Entry point chính
└── Makefile            ← Build automation
```

#co-note[
  File `.md` trong `content/` là bản dự phòng tương thích Obsidian và
  là đầu vào cho quy trình `make typ` (pandoc). File `.typ` là file
  thực sự được biên dịch bởi Typst.
]
