#!/usr/bin/env bash
# Biên dịch và sao chép PDF vào thư mục môn học

REPO="$HOME/UIT/typst-report-template"
COURSE="IE105"
ASSIGN="TH6B"
DEST="$HOME/UIT/LT.K2025.2-CNTT/uit/courses/$COURSE/assignments/$ASSIGN"

cd "$REPO" || exit 1

# Biên dịch
typst compile thesis.typ \
  --font-path template/fonts \
  --output thesis.pdf

# Kiểm tra kết quả
if [[ $? -eq 0 ]]; then
  cp thesis.pdf "$DEST/thesis.pdf"
  echo "✓ Đã sao chép thesis.pdf → $DEST"
else
  echo "✗ Biên dịch thất bại" >&2
  exit 1
fi