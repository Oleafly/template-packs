#import "../template/lib.typ": *

= Bảng Biểu
<bang-bieu>

Mẫu cung cấp ba kiểu bảng: bảng tiêu chuẩn (có viền đầy đủ), bảng chỉ đường ngang
(`rounded-table`), và bảng nhiều trang (tự động khi nội dung dài).

== Bảng Tiêu Chuẩn
<bang-tieu-chuan>

Bảng tiêu chuẩn sử dụng `table()` được bọc trong `#figure(...)`. Hàng tiêu đề
tự động nhận màu nền xanh nhạt và đường viền đậm hơn so với phần thân.

#figure(
  table(
    columns: (5%, 30%, 40%, 15%, 10%),
    align: (center, left, left, center, center),
    table.header(
      [*STT*], [*Thành Phần*], [*Mô Tả*], [*Phiên Bản*], [*Trạng Thái*],
    ),
    [1], [Typst Compiler],   [Công cụ biên dịch chính],           [0.14+], [#text(fill: green.darken(20%))[✓ OK]],
    [2], [Libertinus Serif], [Phông chữ chính cho nội dung],      [7.040], [#text(fill: green.darken(20%))[✓ OK]],
    [3], [Source Sans 3],    [Phông chữ tiêu đề và giao diện],    [3.046], [#text(fill: green.darken(20%))[✓ OK]],
    [4], [Fira Code],        [Phông chữ code và đoạn lệnh],       [6.2],   [#text(fill: green.darken(20%))[✓ OK]],
    [5], [Pandoc],           [Chuyển đổi `.md` → `.typ` (tùy chọn)], [3.0+], [#text(fill: orange)[⚠ Tùy chọn]],
  ),
  caption: [Bảng 1 — Các Thành Phần Phụ Thuộc Của Template],
)

== Bảng Chỉ Đường Ngang (Rounded Table)
<bang-chi-duong-ngang>

`rounded-table` là component tùy chỉnh không có đường viền dọc -- phù hợp
cho danh sách định nghĩa hoặc bảng so sánh đơn giản.

#figure(
  rounded-table(
    columns: (25%, 75%),
    align: (left, left),
    table.header([*Tham Số*], [*Ý Nghĩa*]),
    [`doc-class`],  [Lớp tài liệu: `"article"` \| `"report"` \| `"book"` \| `"thesis"`],
    [`paper`],      [Khổ giấy: `"a4"` \| `"a5"` \| `"letter"` (mặc định theo lớp)],
    [`font-size`],  [Kích thước chữ: ví dụ `11pt`, `12pt` (mặc định theo lớp)],
    [`two-sided`],  [Lề đối xứng cho in hai mặt: `true` \| `false`],
    [`output`],     [Chế độ đầu ra: `"digital"` (màu) \| `"print"` (đen trắng)],
    [`lang`],       [Ngôn ngữ i18n: `"vi"` \| `"en"` \| `"ms"` \| `"zh-Hant"`],
    [`acronyms`],   [Dữ liệu viết tắt từ file CSV, dùng `csv("content/acronyms.csv")`],
  ),
  caption: [Bảng 2 — Tham Số API Của Hàm `document()`],
)

== Bảng Phân Loại Rủi Ro (Màu Sắc)
<bang-phan-loai-rui-ro>

Màu trong ô bảng sử dụng `#text(fill: ...)`. Quy ước màu: đỏ = cao,
cam = trung bình, xanh lá = thấp.

#figure(
  table(
    columns: (5%, 30%, 20%, 20%, 15%, 10%),
    align: (center, left, center, center, center, center),
    table.header(
      [*STT*], [*Rủi Ro*], [*Khả Năng*], [*Tác Động*], [*Mức Độ*], [*Ưu Tiên*],
    ),
    [1], [SQL Injection vào API đăng nhập],
          [#text(fill: red)[Cao]],
          [#text(fill: red)[Cao]],
          [#text(fill: red)[*Cao*]],
          [P1],
    [2], [Rò rỉ thông tin qua log hệ thống],
          [#text(fill: orange)[TB]],
          [#text(fill: red)[Cao]],
          [#text(fill: red)[*Cao*]],
          [P2],
    [3], [Tấn công brute-force tài khoản],
          [#text(fill: orange)[TB]],
          [#text(fill: orange)[TB]],
          [#text(fill: orange)[*TB*]],
          [P3],
    [4], [Lỗi phân quyền module báo cáo],
          [#text(fill: green.darken(20%))[Thấp]],
          [#text(fill: orange)[TB]],
          [#text(fill: green.darken(20%))[*Thấp*]],
          [P4],
    [5], [Session không hết hạn tự động],
          [#text(fill: green.darken(20%))[Thấp]],
          [#text(fill: green.darken(20%))[Thấp]],
          [#text(fill: green.darken(20%))[*Thấp*]],
          [P5],
  ),
  caption: [Bảng 3 — Ma Trận Đánh Giá Rủi Ro Bảo Mật],
)

== Bảng Nhiều Trang (Multi-Page Table)
<bang-nhieu-trang>

Kể từ Typst 0.14, bảng có thể tự động xuống trang tiếp theo khi nội dung dài.
Thuộc tính `breakable: true` được áp dụng qua `show table: it => block(breakable: true, ...)`.
Hàng tiêu đề (`table.header`) tự động lặp lại ở đầu mỗi trang.

#co-info[
  Ví dụ dưới đây chứa 20 hàng dữ liệu để minh họa khả năng xuống trang.
  Trong tài liệu thực tế, đây có thể là danh sách tài sản, log sự kiện, hoặc
  bảng thống kê dài.
]

#figure(
  table(
    columns: (5%, 30%, 20%, 30%, 15%),
    align: (center, left, center, left, center),
    table.header(
      [*ID*], [*Tài Sản*], [*Loại*], [*Mô Tả*], [*Giá Trị*],
    ),
    [A01], [Máy chủ Web],         [Hardware],  [Nginx 1.25, Ubuntu 22.04],         [#text(fill: red)[Cao]],
    [A02], [Cơ sở dữ liệu chính], [Hardware],  [PostgreSQL 16, SSD 2TB],            [#text(fill: red)[Cao]],
    [A03], [Hệ thống backup],     [Hardware],  [Backup server, off-site],           [#text(fill: red)[Cao]],
    [A04], [Firewall vành đai],   [Hardware],  [FortiGate 100F],                    [#text(fill: red)[Cao]],
    [A05], [Source code],         [Software],  [Git repo, private, CI/CD pipeline], [#text(fill: red)[Cao]],
    [A06], [Hệ điều hành server], [Software],  [Ubuntu 22.04 LTS, patched monthly], [#text(fill: orange)[TB]],
    [A07], [Phần mềm diệt virus], [Software],  [CrowdStrike Falcon],                [#text(fill: orange)[TB]],
    [A08], [Chứng chỉ SSL/TLS],   [Software],  [Let's Encrypt, auto-renew],         [#text(fill: orange)[TB]],
    [A09], [API keys bên thứ ba], [Data],      [Stripe, SendGrid, AWS],             [#text(fill: red)[Cao]],
    [A10], [Dữ liệu người dùng],  [Data],      [PII: email, địa chỉ, lịch sử mua], [#text(fill: red)[Cao]],
    [A11], [Logs hệ thống],       [Data],      [Nginx, App, DB logs, 90 ngày],      [#text(fill: orange)[TB]],
    [A12], [Backup database],     [Data],      [Daily dump, mã hóa AES-256],        [#text(fill: red)[Cao]],
    [A13], [Tài khoản admin],     [People],    [2 admin, xác thực 2 bước],          [#text(fill: red)[Cao]],
    [A14], [Đội ngũ DevOps],      [People],    [3 kỹ sư, truy cập SSH có giới hạn], [#text(fill: orange)[TB]],
    [A15], [Nhân viên kế toán],   [People],    [5 người, truy cập ERP],             [#text(fill: orange)[TB]],
    [A16], [Băng thông mạng],     [Service],   [1 Gbps, ISP dự phòng],              [#text(fill: orange)[TB]],
    [A17], [CDN / DDoS protection],[Service],  [Cloudflare Pro],                    [#text(fill: orange)[TB]],
    [A18], [Dịch vụ email],       [Service],   [SendGrid, SPF/DKIM/DMARC],          [#text(fill: green.darken(20%))[Thấp]],
    [A19], [Giám sát hệ thống],   [Service],   [Grafana + Prometheus, cảnh báo 24/7],[#text(fill: green.darken(20%))[Thấp]],
    [A20], [Tên miền & DNS],      [Service],   [Cloudflare DNS, auto-renew],        [#text(fill: green.darken(20%))[Thấp]],
  ),
  caption: [Bảng 4 — Danh Sách Tài Sản Thông Tin (Minh Họa Bảng Nhiều Trang)],
)
