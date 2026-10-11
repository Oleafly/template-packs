// MARK: Wrapper function for rounded tables
// A rounded table with bottom lines
#let rounded-table(..args) = {
  block(
    radius: 8pt, // Góc bo tròn
    stroke: 1pt + blue.lighten(90%), // Đường viền ngoài
    clip: true, // Cắt góc vuông
    width: 100%, // Đảm bảo nó vừa với trang
    inset: 0pt, // Không có khoảng trống giữa viền và bảng

    // The inner table
    table(
      ..args,
      stroke: (
        // Only draw bottom lines, and NOT on the last row
        bottom: 0.5pt + blue.lighten(90%),
        top: none,
        left: none,
        right: none,
      ),
    ),
  )
}

// MARK: Rounded border table with grid lines

#let rounded-table-lined(..args) = block(
  // Góc bo tròn
  radius: 8pt,
  // Đường viền ngoài
  stroke: 1pt + blue.lighten(90%),
  clip: true,
  width: 100%,
  inset: 0pt,
  table(
    ..args,
    stroke: (x, y) => (
      top: none,
      // Bottom lines
      bottom: 0.5pt + blue.lighten(90%),
      // Left lines
      left: 0.5pt + blue.lighten(90%),
      right: none,
    )
  ),
)
