#import "../template/lib.typ": *

= Lời Nói Đầu
<loi-noi-dau>

#co-info(title: [#link("https://maps.app.goo.gl/HkeHUT6AEJRQPRjG8")[Wifong Alex] #text(fill: gray)[posted (2 months ago)] #text(fill: orange)[#sym.star #sym.star #sym.star #sym.star #sym.star]:])[
#emph[I am quite satisfied with this hotel.

Although it is not available on the "Booking" app, this is a reasonable accommodation when you travel to Vietnam.

...

This will be the place to stay that I recommend to you when coming to Vietnam.
]]
#emph[Đây là phần mở đầu, dẫn nhập nội dung, miêu tả ngắn gọn vấn đề và động lực của đề tài.]

Phần trích dẫn ở trên được code như sau:

```typst
#co-info(title: [#link("https://maps.app.goo.gl/HkeHUT6AEJRQPRjG8")[Wifong Alex] #text(fill: gray)[posted (2 months ago)] #text(fill: orange)[#sym.star #sym.star #sym.star #sym.star #sym.star]:])[
#emph[I am quite satisfied with this hotel.

Although it is not available on the "Booking" app, this is a reasonable accommodation when you travel to Vietnam.

...

This will be the place to stay that I recommend to you when coming to Vietnam.
]]
```

Hoàn toàn có thể dùng `for` loop cho đoạn 5 chiếc sao đánh giá thay vì copy&paste.

Lưu ý:

- `co` có nghĩa là Call-Out, một chức năng tương tự Github Markdown chuẩn.
- Có nghiều loại Call-Out, và được định nghĩa trong
  - `template/components/callout.typ`.
- Tham khảo ví dụ tại: `template/callout-examples.typ`.
