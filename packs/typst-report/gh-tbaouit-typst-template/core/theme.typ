// Bảng màu
#let _palette = (
	// Xanh đậm UIT
	navy-900: rgb("#0f2440"),
	navy-800: rgb("#1e3a5f"),
	navy-700: rgb("#2c5282"),
	navy-600: rgb("#2563eb"),
	navy-100: rgb("#dbeafe"),
	navy-50:  rgb("#eff6ff"),

	// Ngữ nghĩa
	green-700: rgb("#059669"),
	green-100: rgb("#dcfce7"),
	amber-700: rgb("#d97706"),
	amber-100: rgb("#fef3c7"),
	red-700:   rgb("#dc2626"),
	red-100:   rgb("#fee2e2"),
	purple-700: rgb("#7c3aed"),
	purple-100: rgb("#ede9fe"),
	teal-700:  rgb("#0891b2"),
	teal-100:  rgb("#cffafe"),

	// Trung tính
	gray-900: rgb("#0f172a"),
	gray-700: rgb("#334155"),
	gray-500: rgb("#64748b"),
	gray-300: rgb("#cbd5e1"),
	gray-200: rgb("#e2e8f0"),
	gray-100: rgb("#f1f5f9"),
	gray-50:  rgb("#f8fafc"),
	white:    rgb("#ffffff"),
)

// Themes

#let _themes = (
  // --- Học thuật, formal — dùng cho report, transcript, letter
	academic: (
		// Màu
		primary:   _palette.navy-800,
		secondary: _palette.navy-600,
		accent:    _palette.navy-700,
		success:   _palette.green-700,
		warning:   _palette.amber-700,
		danger:    _palette.red-700,
		info:      _palette.teal-700,
		muted:     _palette.gray-500,
		surface:   _palette.gray-50,
		border:    _palette.gray-200,
		text:      _palette.gray-900,
		text-inv:  _palette.white,

		// Font
		font-body:    "New Computer Modern",
		font-heading: "New Computer Modern",
		font-mono:    "New Computer Modern",

		// Cỡ chữ
		size-body:  12pt,
		size-small: 9pt,
		size-tiny:  8pt,
		size-h1:    18pt,
		size-h2:    14pt,
		size-h3:    12pt,
		size-title: 26pt,

		// Khoảng cách
		space-xs: 4pt,
		space-sm: 8pt,
		space-md: 12pt,
		space-lg: 20pt,
		space-xl: 32pt,

		// Bo góc
		radius-sm: 2pt,
		radius-md: 4pt,
		radius-lg: 8pt,

		// Trang
		page-margin: (
										left: 2cm, 
										right: 2cm,
										top: 2cm, 
										bottom: 2cm
								 ),
		page-paper:  "a4",
		line-height: 0.75em,
		par-indent:  0.5in,
	),

  // --- Ghi chú, đọc nhanh — dùng cho notes
  	compact: (
		primary:   _palette.navy-800,
		secondary: _palette.navy-600,
		accent:    _palette.purple-700,
		success:   _palette.green-700,
		warning:   _palette.amber-700,
		danger:    _palette.red-700,
		info:      _palette.teal-700,
		muted:     _palette.gray-500,
		surface:   _palette.gray-50,
		border:    _palette.gray-200,
		text:      _palette.gray-900,
		text-inv:  _palette.white,

		font-body:    "New Computer Modern",
		font-heading: "New Computer Modern",
		font-mono:    "New Computer Modern",

		// Nhỏ hơn academic một chút
		size-body:  10.5pt,
		size-small: 8.5pt,
		size-tiny:  7.5pt,
		size-h1:    15pt,
		size-h2:    13pt,
		size-h3:    11pt,
		size-title: 20pt,

		space-xs: 3pt,
		space-sm: 6pt,
		space-md: 10pt,
		space-lg: 16pt,
		space-xl: 24pt,

		radius-sm: 2pt,
		radius-md: 3pt,
		radius-lg: 6pt,

		// Lề hẹp hơn, mật độ cao hơn
		page-margin: (top: 2.5cm, bottom: 2.5cm, right: 3cm, left: 3cm),
		page-paper:  "a4",
		line-height: 0.68em,
		par-indent:  0em,
	),

  	// --- Thuyết trình — dùng cho slides
  	presentation: (
		primary:   _palette.navy-800,
		secondary: _palette.navy-100,
		accent:    _palette.navy-600,
		success:   _palette.green-700,
		warning:   _palette.amber-700,
		danger:    _palette.red-700,
		info:      _palette.teal-700,
		muted:     _palette.gray-500,
		surface:   _palette.white,
		border:    _palette.gray-200,
		text:      _palette.gray-900,
		text-inv:  _palette.white,

		// Sans-serif cho slide dễ nhìn từ xa
		font-body:    "New Computer Modern",
		font-heading: "New Computer Modern",
		font-mono:    "New Computer Modern",

		// To hơn nhiều so với print
		size-body:  18pt,
		size-small: 16pt,
		size-tiny:  13pt,
		size-h1:    32pt,
		size-h2:    26pt,
		size-h3:    22pt,
		size-title: 42pt,

		space-xs: 8pt,
		space-sm: 16pt,
		space-md: 24pt,
		space-lg: 40pt,
		space-xl: 64pt,

		radius-sm: 3pt,
		radius-md: 6pt,
		radius-lg: 12pt,

		// 16:9, không lề
		page-margin: (x: 2cm, y: 1.5cm),
		page-paper:  "presentation-16-9",
		line-height: 0.9em,
		par-indent:  0em,
	),
)

// =============================================================
// make-theme() — hàm công khai duy nhất
// =============================================================

/// Trả về một theme hoàn chỉnh.
///

/// - preset (str): "academic" | "compact" | "presentation" | "minimal"
/// 
/// - overrides (dictionary): Các trường muốn ghi đè, ví dụ (primary: red)
/// 
/// -> dictionary
#let make-theme(preset: "academic", overrides: (:)) = {
	assert(
	preset in _themes, // check xem preset truyền vào có nằm trong _themes đã định nghĩa không

    message: "Preset '" + preset + "' không tồn tại. Chọn một trong: "
      + _themes.keys().join(", "),
  )

	// chọn base là giá trị của preset truyền vào: academic/compact/presentation
  	let base = _themes.at(preset) 
                                // 
	// Ghi đè từng trường — không đệ quy vì theme phẳng một tầng
	// hàm .pair: base.pair() chuyển từng giá trị [key, value] thành cặp
	// hàm .fold()
  	base.pairs().fold(
		// accumulator function
		// (:): nghĩa là dictionary rỗng, tức giá trị khởi tạo
		// (acc, (k, v)): giá trị hiện tại và cặp [key, value] hiện tại
		(:), (acc, (k, v)) => 
		(
			..acc, // .. là spread operator: giữ lại tất cả các key-value đã gom trước
			// Trong Typst, if-else là hàm trả về giá trị
			(k):	if k in overrides // điều kiện kiểm trả if
							{ overrides.at(k) } // thực thi nếu điều kiện đúng, trong ngữ cảnh này là lấy giá trị mà người dùng override tại khoá k, được truy cập bằng cách lấy giá trị tương ứng với khoá k trong từ điển override
						else
							{ v }, // thực thi khi điều kiện sai, trong ngữ cảnh này là khi không có giá trị cần override thì giữ nguyên giá trị (v) cũ
		// ^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        
		// k là khoá | còn đây là giá trị
		  // 
		/*
			let k = "primary"
			let dict = (k: "blue") 
			// Kết quả: (k: "blue") -> Khóa thực sự tên là chữ "k", biến k bị phớt lờ!
		*/

		/*
			let k = "primary"
			let dict = ((k): "blue") 
			// Kết quả: (primary: "blue") -> Lấy giá trị chuỗi "primary" làm tên khóa
		*/
		)
	)
}