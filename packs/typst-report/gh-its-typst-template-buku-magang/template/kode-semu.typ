// ============================================================
// AUTO — Figure wrapper untuk kode semu (pseudocode/algoritma)
// ============================================================
// Berbeda dari kode-sumber: tidak pakai syntax highlight,
// tampilan kotak plain (putih), dan masuk ke Daftar Kode Semu.
//
// Penggunaan — gunakan raw block (tanpa bahasa) agar newline terjaga:
//   #kode-semu(caption: "Algoritma Pembersihan Teks")[
//     ```
//     1. INPUT: Raw Text (String)
//     2. OUTPUT: Cleaned Text (String)
//     3. IF input_text IS NOT string: CONVERT input_text TO string
//     4. NORMALIZE multiple spaces USING regex '\s+'
//     5. RETURN cleaned_text
//     ```
//   ]

#let kode-semu(caption: "", body) = figure(
  kind: "kode-semu",
  supplement: [Kode Semu],
  caption: caption,
  block(
    fill: white,
    stroke: 0.5pt + luma(160),
    radius: 3pt,
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    align(left, text(font: "Courier New", size: 10pt, body)),
  ),
)
