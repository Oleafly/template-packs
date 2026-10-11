# WUST-PhD-Thesis-Latex — 日本語

WUSTThesis.cls 2025/05/15 version V1.0

[中文](README_ZH.md) | **日本語** | [English](README_EN.md)

---

**武漢科技大学（WUST）** の博士・修士論文用非公式 LaTeX テンプレートです。

---

## 動作環境

- **TeX ディストリビューション:** TeX Live 2024+ / MiKTeX
- **コンパイラ:** XeLaTeX（必須）
- **参考文献:** BibTeX

## クイックスタート

### latexmk を使用する場合（推奨）

```bash
# コンパイル
latexmk -xelatex main.tex

# 中間ファイルの削除
latexmk -c main.tex

# 全削除（PDF 含む）
latexmk -C main.tex
```

### 手動コンパイル

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

### Overleaf

プロジェクト全体を Overleaf にアップロードし、コンパイラに **XeLaTeX** を選択してください。

## プロジェクト構成

```
├── main.tex          # メインエントリファイル
├── WUSTthesis.cls    # ドキュメントクラス
├── WUSTThesis.bst    # 参考文献スタイル
├── WUSTtils.sty      # 補助マクロパッケージ
├── .latexmkrc        # latexmk 設定ファイル
├── body/             # 全章 .tex ファイル
│   ├── cover.tex     # 表紙情報（題目・著者など）
│   ├── chap01.tex ~ chap04.tex  # 各章（必要に応じて追加・削除）
│   ├── conclusion.tex
│   ├── ack.tex       # 謝辞
│   ├── publications.tex   # 付録：発表論文
│   └── project.tex   # 付録：参加プロジェクト
├── figures/          # 画像ファイル
├── font/             # 中国語フォント（Overleaf 等で使用）
└── ref/
    └── refs.bib      # 参考文献データベース
```

## 使い方

1. `main.tex` でモードを選択します：
   - `draftformat` — 草稿（ページヘッダーに大学名を表示）
   - `finalformat` — ブラインド審査用（大学名を非表示）
2. `body/cover.tex` に論文情報（題目・著者・指導教員・要旨など）を記入します
3. `body/` フォルダ以下に章ファイルを追加・削除し、`main.tex` 内の `\include` も対応して修正します
4. 参考文献は `ref/refs.bib` に記入します

---

## 謝辞

[HUST-PhD-Thesis-Latex](https://github.com/XinzeZhang/HUST-PhD-Thesis-Latex) (V3.1) を基に改変・作成されました。

貢献者に感謝します：Lianghao Li, Jianqing Lin (2021 V3.1), Xinze Zhang (2020 V3.0), Huikan Liu (2006 V2.0), Feng Jiang (2005 V1.0).

貢献者：Wancheng Zhang (zhangwancheng@wust.edu.cn)

---

+ 武漢科技大学公式「博士論文編排様式（理工類）.doc」の様式をできる限り再現しています
+ 英語目次の生成は未実装であり、さらに最適化が必要な箇所があります
+ 現行バージョンは実用に耐えるものです（著者自身が本テンプレートで学位論文を完成させました）
+ 本テンプレートの継続的な改善に、より多くの方の参加を期待しています
