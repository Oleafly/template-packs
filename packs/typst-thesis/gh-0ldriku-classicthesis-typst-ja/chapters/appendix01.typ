#import "../lib.typ": *




= 引用スタイル検証


@apa スタイルの引用フォーマットを検証するため、引用例を示す。全ての文献は架空のものである。文中の引用では、英語文献、日本語文献両方とも全角括弧を使かう。最後の文献リストでは、英語文献は半角記号、日本語は全角記号を使う。
If you find a bug please contact me.



== 基本的な引用形式

=== Article（雑誌論文）


*英語論文（3人著者）*

#citet(<ArticleEN>, <ArticleENsamename>)は、機械学習アルゴリズムについて包括的な研究を行った。

*英語論文（単著）*



#citet(<ArticleENSingle>)の研究によると、心理学における重要な知見が示されている。

心理学における重要な知見が示されている#citep(<ArticleENSingle>)。


*英語論文（2人著者）*

#citet(<ArticleENTwoAuthors>)は認知科学分野で共同研究を行った。

*日本語論文（3人著者）*

#citet(<ArticleJA>)によれば、日本語論文の引用形式が確認できる。


*日本語論文（単著）*

#citet(<ArticleJASingle>)の研究では、発達心理学に関する知見が報告されている。

*日本語論文（2人著者）*

#citet(<ArticleJATwoAuthors>)は教育心理学研究において重要な成果を挙げた。

*DOIなし*

#citet(<ArticleNoDoi>)は古典的な研究例である。



=== Book（書籍）

*英語書籍*

#citet(<BookEN>)は認知心理学の入門書として広く使われている。

*英語書籍（単著）*

#citet(<BookENSingle>)は行動科学の基礎を解説している。

*英語書籍（日本語訳あり）*

#citet(<BookENTranslated>)は社会的学習理論の古典である。


#citep(<BookENTranslated>)

*日本語書籍*

#citet(<BookJA>)は心理学の概論書である。

*日本語書籍（単著）*

#citet(<BookJASingle>)は臨床心理学の入門書として知られている。



=== Incollection（書籍内章）

*英語（編者あり）*

#citet(<IncollectionEN>)は学習における記憶プロセスについて論じている。

*英語（編者なし）*

#citet(<IncollectionENNoEditor>)は注意と知覚に関する章である。

*英語（巻号あり）*

#citet(<IncollectionENVolume>)は社会認知について解説している。

*英語（版のみ、ページなし）*

#citet(<IncollectionEditionOnly>)は意識研究について述べている。

*日本語（編者あり）*

#citet(<IncollectionJA>)は発達心理学の基礎を解説している。

*日本語（編者なし）*

#citet(<IncollectionJANoEditor>)は臨床心理学の概論である。



=== Inproceedings/Conference（学会発表）

*英語（Inproceedings）*

#citet(<InproceedingsEN>)はニューラルネットワークの応用について発表した。

*日本語（Inproceedings）*

#citet(<InproceedingsJA>)は認知発達に関する縦断研究を報告した。

*英語（Conference）*

#citet(<ConferenceEN>)は感情の文化差について発表した。

*日本語（Conference）*

#citet(<ConferenceJA>)は感情制御の文化差について報告した。



=== 学位論文

*英語（博士論文）*

#citet(<PhdthesisEN>)は言語処理における作動記憶の役割を研究した。

*日本語（博士論文）*

#citet(<PhdthesisJA>)は言語処理に関する博士論文を執筆した。

*英語（修士論文）*

#citet(<MastersthesisEN>)は不安と学業成績の関連を研究した。

*日本語（修士論文）*

#citet(<MastersthesisJA>)は修士論文で不安と学業成績を研究した。



=== Techreport（技術報告書）

*英語*

#citet(<TechreportEN>)は精神保健統計の年次報告を発行した。

*日本語*

#citet(<TechreportJA>)は精神保健福祉に関する白書を発行した。



=== Misc（その他）

*英語*

#citet(<MiscEN>)は人間行動に関する心理学的視点を述べた。

*日本語*

#citet(<MiscJA>)は心理学の基礎知識についてウェブ記事を執筆した。



=== Online（オンライン資料）

*英語*

#citet(<OnlineEN>)はAPAスタイルのガイドラインを公開している。

*日本語*

#citet(<OnlineJA>)は研究倫理ガイドラインを公開している。



=== Unpublished（未発表論文）

*英語*

#citet(<UnpublishedEN>)は認知的加齢に関する予備的知見を報告した。

*日本語*

#citet(<UnpublishedJA>)は高齢者の認知機能に関する予備的研究を行った。



=== Booklet（小冊子）

*英語*

#citet(<BookletEN>)は精神保健啓発ガイドを発行した。

*日本語*

#citet(<BookletJA>)は心の健康啓発パンフレットを発行した。



=== Manual（マニュアル）

*英語*

#citet(<ManualEN>)はMMPI-2の実施マニュアルである。

*日本語*

#citet(<ManualJA>)はWAIS-IVの日本版実施マニュアルである。



=== Proceedings（学会論文集）

*英語*

#citet(<ProceedingsEN>)は認知科学学会の論文集を編集した。

*日本語*

#citet(<ProceedingsJA>)は日本心理学会大会の論文集である。



=== Inbook（書籍内セクション）

*英語*

#citet(<InbookEN>)は心理学研究のための統計手法を解説している。

*日本語*

#citet(<InbookJA>)は心理統計の基礎を解説している。



== 特殊ケース

=== 同一著者・同一年（Year Doubling）

同一著者が同一年に発表した複数の論文がある場合、年の後にa, b, c...が付く：

#citet(<YearDouble2023a>)と#citet(<YearDouble2023b>)は同一年に発表された。

#citet(<YamadaT11>)と#citet(<YamadaT12>)は同一年に発表された。



=== 多著者論文（et al. / 他）

3人以上の著者がいる場合、本文中では省略形式で表示される：

*英語（5人著者 → et al.）*

#citet(<ManyAuthorsEN5>)の研究によると...

#citet(<ThirtyAuthorsTest>)の研究によると...

*日本語（5人著者 → 他）*

#citet(<ManyAuthorsJA>)の研究によると...

#citet(<ThirtyAuthorsJA>)の研究によると...



== 著者名曖昧性解消テスト



=== 日本語同姓著者（規則1）

山田における研究では，#citet(<YamadaT2020>)と#citet(<YamadaY2020>)が異なるアプローチを示している。両者の見解には相違がある#citep(<YamadaT2020>, <YamadaY2020>)。
#citep(<ManyAuthorsJA>, <ManyAuthorsJA2>)

=== 英語同姓著者（規則1）

Hayashiらの研究として，#citet(<HayashiT2020>)と#citet(<HayashiY2020>)がある。両研究は独自の貢献をしている#citep(<HayashiT2020>, <HayashiY2020>)。

=== 日本語「他」の曖昧解消（規則2）

井上らの研究として，#citet(<InoueA2020>)と#citet(<InoueB2020>)がある。これらは異なる第三著者を持つ#citep(<InoueA2020>, <InoueB2020>,<InoueF2020>, <InoueG2020>)。

=== 最後の著者のみ異なる場合（規則3）




#citet(<InoueC2020>)と#citet(<InoueD2020>)の研究では，最後の著者のみが異なる。#citet(<ManyAuthorsEN4>,<ManyAuthorsEN3>)

