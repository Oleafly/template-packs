#import "../template/lib.typ": *

= Cấu Hình Nâng Cao
<cau-hinh-nang-cao>

Chương này trình bày các tính năng nâng cao: bảng rowspan/colspan, lớp tài liệu,
và cách tùy chỉnh component.

== Bảng Với Rowspan & Colspan
<bang-voi-rowspan-colspan>

Typst hỗ trợ `table.cell(rowspan: N)` và `table.cell(colspan: N)` để gộp ô.

#figure(
  table(
    columns: (8%, 25%, 37%, 15%, 15%),
    align: (center, left, left, center, center),
    table.header(
      [*STT*], [*Nhóm Lỗ Hổng*], [*Chi Tiết*], [*CVSS*], [*Mức Độ*],
    ),
    table.cell(rowspan: 3, align: center + horizon)[*Web*],
    [XSS phản chiếu], [Thiếu mã hóa đầu vào trong form tìm kiếm],
      [7.4], [#text(fill: orange)[TB]],
    [SQL Injection], [Query nối chuỗi trực tiếp không dùng prepared statement],
      [9.1], [#text(fill: red)[Cao]],
    [CSRF], [Thiếu token CSRF trên form cập nhật hồ sơ],
      [6.8], [#text(fill: orange)[TB]],
    table.cell(rowspan: 2, align: center + horizon)[*API*],
    [Lộ thông tin], [Stack trace trả về trong response lỗi 500],
      [5.3], [#text(fill: orange)[TB]],
    [Phân quyền sai], [Endpoint `/admin/users` không kiểm tra role],
      [8.2], [#text(fill: red)[Cao]],
    table.cell(rowspan: 2, align: center + horizon)[*Mạng*],
    [Cổng mở không dùng], [Port 3306 (MySQL) mở ra internet],
      [6.5], [#text(fill: orange)[TB]],
    [TLS cũ], [Server vẫn hỗ trợ TLSv1.0 và TLSv1.1],
      [4.0], [#text(fill: green.darken(20%))[Thấp]],
  ),
  caption: [Bảng 5 — Danh Sách Lỗ Hổng Bảo Mật (Rowspan Theo Nhóm)],
)

== So Sánh Lớp Tài Liệu
<so-sanh-lop-tai-lieu>

#figure(
  table(
    columns: (15%, 17%, 17%, 17%, 17%, 17%),
    align: (left, center, center, center, center, center),
    table.header(
      [*Tham Số*], [*article*], [*report*], [*book*], [*thesis*], [*Ghi Chú*],
    ),
    [`paper`],      [a4], [a4], [a4], [a4], [Mặc định],
    [`font-size`],  [11pt], [11pt], [12pt], [12pt], [Theo lớp],
    [`two-sided`],  [false], [false], [true], [true], [Lề đối xứng],
    [`show-toc`],   [false], [true], [true], [true], [Mục lục],
    [`show-lof`],   [false], [false], [true], [true], [Danh sách hình],
    [`show-lot`],   [false], [false], [true], [true], [Danh sách bảng],
    [`show-acronyms`],[false],[true], [true], [true], [Viết tắt],
  ),
  caption: [Bảng 6 — So Sánh Cài Đặt Mặc Định Giữa Các Lớp Tài Liệu],
)

== TODO Component

Mẫu có component `#todo[...]` để đánh dấu việc cần làm trong quá trình soạn thảo.
Danh sách TODO tự động tổng hợp ở phần đầu tài liệu (nếu `show-todos: true`).

#todo[Thêm ảnh chụp màn hình giao diện quản trị để minh họa phần phân quyền.]

#todo[Bổ sung tài liệu tham khảo từ OWASP Top 10 2023.]

== Kết Luận

#co-succ[
  Template đã sẵn sàng cho sử dụng thực tế. Các tính năng chính bao gồm:
  - *Bảng nhiều trang*: tự động xuống trang, tiêu đề lặp lại
  - *Callout đa dạng*: note, info, warn, erro, succ
  - *Code highlighting*: Typst, Python, SQL, Bash
  - *Rowspan/colspan*: gộp ô theo hàng và cột
  - *Lớp tài liệu*: article, report, book, thesis
  - *Đa ngôn ngữ*: vi, en, ms, zh-Hant, zh-Hans
]

Để bắt đầu một bài tập mới, tham khảo `docs/getting-started.md` trong repo.
