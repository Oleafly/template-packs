#import "../template/lib.typ": *

= Callout Boxes
<callout-boxes>

Callout boxes được dùng để làm nổi bật thông tin quan trọng. Có năm kiểu callout
với màu sắc và ý nghĩa khác nhau.

== Các Kiểu Callout
<cac-kieu-callout>

#co-note[
  *Note* -- Ghi chú thông thường, dùng cho thông tin bổ sung không quan trọng.
  Ví dụ: nhắc nhở về cú pháp hoặc quy ước đặt tên.
]

#co-info[
  *Info* -- Thông tin hữu ích, dùng để giải thích khái niệm hoặc cung cấp
  ngữ cảnh bổ sung cho người đọc.
]

#co-warn(title: "Lưu Ý Quan Trọng")[
  *Warning* -- Cảnh báo, dùng khi người dùng cần thực hiện thêm bước
  hoặc có nguy cơ mắc lỗi. Tiêu đề có thể tùy chỉnh qua tham số `title:`.
]

#co-erro[
  *Error* -- Lỗi nghiêm trọng hoặc điều không được phép làm. Dùng để
  đánh dấu các hành động có thể gây mất dữ liệu hoặc lỗi hệ thống.
]

#co-succ[
  *Success* -- Thành công hoặc kết quả tích cực. Dùng để xác nhận một bước
  đã hoàn thành đúng cách, hoặc highlight điểm mạnh của một giải pháp.
]

== Callout Lồng Nhau Với Nội Dung Phong Phú

#co-note(title: "Cú Pháp Sử Dụng")[
  Tất cả callout hỗ trợ tham số `title:` tùy chọn và nội dung Typst đầy đủ:

  ```typst
  #co-note(title: "Tiêu Đề Tùy Chỉnh")[Nội dung callout...]
  #co-warn[Nội dung không cần tiêu đề]
  ```

  Danh sách bên trong callout cũng hoạt động bình thường:
  - Mục 1: kiểm tra API
  - Mục 2: kiểm tra hiệu năng
  - Mục 3: kiểm tra bảo mật
]
