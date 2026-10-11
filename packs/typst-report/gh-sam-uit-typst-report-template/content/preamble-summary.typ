#import "/template/lib.typ": *
#let data = yaml("/config/metadata.yaml")

= BÁO CÁO TÓM TẮT

== 1. Tiêu đề báo cáo: #upper[#data.assignment.subtitle]

== 2. Danh sách thành viên

#figure(
  table(
    columns: (10%, 20%, 40%, 30%),
    align: (center, center, left, left),
    table.header([*No*], [*MSSV*], [*Họ và Tên*], [*Ghi Chú*]),
    [01], [25410000], [Trần Thị Sinh Viên],   [Nhóm trưởng],
    [02], [25410001], [Lê Văn Thành Viên],    [Thành viên],
  ),
  kind: table,
  caption: [Danh Sách Thành Viên],
  outlined: false,
  numbering: none,
)

== 3. Nội dung chi tiết

=== Chương 1 — Tổng Quan Template

Giới thiệu cú pháp cơ bản: văn bản có định dạng, danh sách, trích dẫn và
cách sử dụng tham số của hàm `document()`.

=== Chương 2 — Callout Boxes

Trình bày năm kiểu callout (`note`, `info`, `warn`, `erro`, `succ`) với
ví dụ cụ thể và hướng dẫn tùy chỉnh tiêu đề.

=== Chương 3 — Bảng Biểu

Minh họa bảng tiêu chuẩn, bảng chỉ đường ngang, bảng màu sắc, và bảng
nhiều trang với 20 hàng dữ liệu.

=== Chương 4 — Khối Code

Ví dụ code block với Typst, Python, SQL và Bash -- syntax highlighting
và kích thước chữ tự động.

=== Chương 5 — Cấu Hình Nâng Cao

Bảng rowspan/colspan, so sánh các lớp tài liệu, và component `#todo[...]`.

== 4. Phân công công việc

#figure(
  table(
    columns: (10%, 20%, 40%, 30%),
    align: (center, center, left, left),
    table.header([*No*], [*MSSV*], [*Họ và Tên*], [*Phụ Trách*]),
    [01], [25410000], [Trần Thị Sinh Viên], [Chương 1, 2, 3],
    [02], [25410001], [Lê Văn Thành Viên],  [Chương 4, 5, Phụ lục],
  ),
  kind: table,
  caption: [Phân Công Công Việc],
  outlined: false,
  numbering: none,
)
