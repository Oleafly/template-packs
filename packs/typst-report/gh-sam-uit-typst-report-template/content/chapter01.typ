#import "../template/lib.typ": *

= Tổng Quan Template
<tong-quan-template>

Tài liệu này là bản trình diễn đầy đủ các thành phần định dạng của mẫu báo cáo Typst
được thiết kế theo phong cách LaTeX chuyên nghiệp. Mọi thành phần đều được minh họa
bằng dữ liệu mẫu thực tế. @technicalwritingapracticalguide[Tham khảo về viết báo cáo kỹ thuật].

Mẫu hỗ trợ bốn lớp tài liệu: `article`, `report`, `book`, và `thesis` -- mỗi lớp có
cài đặt mặc định riêng về lề trang, kích thước chữ, và các thành phần hiển thị.

== Cú Pháp Cơ Bản
<cu-phap-co-ban>

Văn bản thông thường hỗ trợ *in đậm*, _in nghiêng_, và `code nội dòng`. Dấu gạch
ngang kép -- được dùng cho dấu gạch ngang dài (em-dash). Liên kết tự động được tô màu
theo cấu hình đầu ra: #link("https://github.com")[github.com].

=== Danh Sách Có Thứ Tự

+ Cài đặt Typst 0.14 trở lên (hỗ trợ `breakable: true` cùng `clip: true`)
+ Sao chép thư mục `template/` vào dự án
+ Cập nhật `config/metadata.yaml` với thông tin bài tập
+ Biên dịch: `typst compile thesis.typ --font-path template/fonts`

=== Danh Sách Không Thứ Tự

- Hỗ trợ đa ngôn ngữ: tiếng Việt (`vi`), tiếng Anh (`en`), tiếng Mã Lai (`ms`)
- Hai chế độ đầu ra: `digital` (liên kết màu) và `print` (liên kết đen)
- Bốn lớp tài liệu với cài đặt mặc định tối ưu
- Phông chữ nhúng sẵn: Libertinus Serif, Source Sans 3, Fira Code

=== Trích Dẫn Block

#quote[
  Một công cụ tốt không chỉ hoàn thành công việc -- nó còn giúp người dùng
  làm việc tốt hơn. Mẫu này được thiết kế để sinh viên tập trung vào nội dung,
  không phải định dạng.
]
