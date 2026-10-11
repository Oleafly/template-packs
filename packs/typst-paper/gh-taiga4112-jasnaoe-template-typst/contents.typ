#import "libs/jasnaoe-conf/jasnaoe-conf_lib.typ": jasnaoe-conf
#show: jasnaoe-conf.with()

#import "libs/jasnaoe-conf/direct_bib_lib.typ": bibliography-list, bib-item, use-bib-item-ref
#show: use-bib-item-ref.with(numbering: "1)") // 番号の書式を指定


= 緒　　言
このテンプレートは、2024年秋季講演会以降の日本船舶海洋工学会の講演会論文作成を想定して、#link("https://typst.app")[Typst]で作成しています。
もちろん♡非公式♡のテンプレートですので、ご使用の際は自己責任でお願いします。


= 執筆のための環境設定

手元のPCでTypst環境を構築する必要があります。基本的には、#link("https://typst.app")[Typst]のマニュアルを参考に構築してください。
不安な方は、README.md に記載されている手順に従ってください。


= 執筆方法

== 基本的な執筆の流れ

2024年秋季講演会から#link("https://www.jasnaoe.or.jp/lecture/2024aut/thesis.html?id=yoryo")[講演論文のテンプレートが大幅に変更]されました。
具体的には、論文タイトル、著者情報、キーワード、要旨は講演論文投稿システムで別に作成し、本文のみを記載したファイルを講演論文投稿システムに投稿することで、システム側でマージして完成するようになりました。
そのため、このテンプレートでは、論文タイトル、著者情報、要旨を `info.yaml` に記載し、本文のみをこのファイルに記載することを想定しています。
`info.yaml` の `cover` を `true` に設定すると表紙を付けてコンパイルされ、`false` に設定すると本文のみがコンパイルされます。
共著者間でのレビュー時には `cover: true` に設定することで、表紙付きの完全な原稿を確認できます。
なお、表紙には `info.yaml` に記載した `title`・`authors`・`abstract` の情報が反映されますので、事前に正しく記入してください。

原稿執筆の際には、このテンプレートファイルに直接打ち込んでいって下さい。
公式フォーマットでは、読点は「，」句点は「．」を使用することとなっています。
このテンプレートでは、Typstの変換機能を利用して、全角の「、」「。」をそれぞれ「，」「．」に自動変換するようにしています。
章は `=`、節は `==`、小節は `===` で始めます。
改段落は LaTeX と同じく改行を 2 つ以上挟みます。
数字つき箇条書きは `+` で、数字なしの箇条書きは `-` を文頭につけて書くことができます。

例えば、数字付きの箇条書きは
+ 1番目
+ 2番目
+ 3番目
のような感じです。

例えば、数字なしの箇条書きは
- 1番目
- 2番目
- 3番目
のような感じです。

文字組等の投稿規定を満たすように作られていますので、フォントの種類の設定や行送り、文字サイズの設定を省略することができます。
ちなみに、本文の文字サイズは9pt、行間隔は1.00emと設定しています。
その他、文法は#link("https://typst.app/docs")[Typst Documentation]をご参照ください。

いまだ、調整中のところも多いので、是非改善点などをGitHubのIssueで教えてください。

== 図

図の入れ方は#link("https://typst.app")[Typst]のドキュメントや、このテンプレートファイルを参考にしてください。
図のタイトルは @fig:fig_example のように図の下部につけてください。
図の表題（caption）は英語で書きます。
また、表題の最後にはピリオドを付けて下さい。
また、図は原則として英語表記としてください。
日本語もしくはその他の言語の表記が必要な場合は、英語との併記としてください。
文字・記号等は十分に判読できる大きさとしてください。
ここで placement 属性は、自動 (`auto`) だけでなく、紙面の上 (`top`) に寄せるか下 (`bottom`) に寄せるかを決められます。言及している文章に近い方に調整してください。また、どうしても対象の文章と図が離れてしまうのが嫌な場合、固定 (`none`) を指定してください。

#figure(
  placement: auto, // top, bottom, auto, none
  image("figs/example.svg", width: 100%),
  caption: [Example of a figure of each simple and easy mathematical equation.],
) <fig:fig_example>


== 表

表の入れ方は#link("https://typst.app")[Typst]のドキュメントや、このテンプレートファイルを参考にしてください。
表は、@tab:table_example のように表形式で記述します。
表題（caption）は表の上に書きます。
表の表題（caption）は英語で書きます。
また、表題の最後にはピリオドを付けて下さい。
また、表も原則として英語表記としてください。
ここで placement 属性は、自動 (`auto`) だけでなく、紙面の上 (`top`) に寄せるか下 (`bottom`) に寄せるかを決められます。また、どうしても対象の文章と表が離れてしまうのが嫌な場合、固定 (`none`) を指定してください。

必要に応じて、言及している文章に近い方に調整してください。

#figure(
  placement: none, // top, bottom, auto, none
  caption: [Example of a table.],
  table(
    columns: 4,
    stroke: (x: none),
    table.header(
      [*Margins*],
      [...],
      [*Left Column*],
      [*Right Column*],
    ),
    row-gutter: (2.2pt, auto),
    [Top], [...], [27 mm], [27 mm],
    [Left], [...], [16 mm], [107.5 mm],
    [Right], [...], [100 mm], [191.5 mm],
    [Bottom], [...], [275 mm], [275 mm],
  ),
  kind: table,
) <tab:table_example>


== 数式

数式番号をつけるような中央揃えの数式は、最初の`$` と閉じの`$`の中に記載してください。
数式の書き方はTypstのドキュメントを参照してください。
例えば、@eq:mmg_example のように記述してください。

$
m(dot(u)-v r) &=-m_x dot(u)+m_y v r+X_H+X_P+X_R \
m(dot(v)+u r) &=-m_y dot(v)+m_x u r+Y_H+Y_R \
I_(z G) dot(r) &=-J_Z dot(r)+N_H+N_R
$ <eq:mmg_example>

また、文中に書く数式は、例えば、$n_i = sum_(i=1)^(N)(f(r_(i j)))$のように記述してください。


== 特殊な章
謝辞と参考文献は他の章とは異なり、章番号が自動でつかないように設定しています。


== 参考文献
参考文献は このファイルの`#bibliography-list` に直接記載してください。
参考文献の書き方は、このテンプレートファイルを参考にしてください。
参考文献は英語表記としてください。
英語等(フランス語、ドイツ語その他アルファベットで表される言語) 以外の文献の場合、文献に英語等のタイトルがある場合はそれを記載し、無い場合は英訳と原語の併記としてください。
併記の場合は、改行コードである 「`\`」 を使ってください。
著者名：論文タイトル、掲載論文名、巻・号番号、ページ番号、発行年を書き、最後にピリオドを付けます。
引用の方法については後述します。
引用されていない論文を参考文献に記載するのは、推奨されていません。
提出前に引用されているかを必ず確認してください。


== 引用
参考文献に記載したものを引用する際には この #super[@ichinose_method_2022] ように表示されます。
参考文献は連続して引用すると #super[@ichinose_method_2022 @ichinose_sustainable_2022 @okuboStudyPracticalApplication2023] となります。
引用の際には、`@` の後に参考文献のキーを記載してください。

現時点では、#link("https://typst.app/docs/reference/model/bibliography/")[TypstのBibliography機能]を使って、	MendeleyやZoteroなどの文献管理ソフトから.bibファイルをエクスポートして、そのファイルを利用して参考文献リストを作る方法を標準として定義しています。
ただし、日本語英語併記には対応していません。日本語英語併記に対応する場合は、参考文献を直接定義する方法を採用してください。
このファイルの末尾に直接定義する方法の例を記載しています。

= おわりに

論文の最後には結論を書きます。
箇条書きスタイルを使うなどして、分かり易く、コンパクトに書いて下さい。
結論を先に読むという読者も居ますので、分かり易く、何が研究されて、新しく何が分かったのかなどを書きます。

最終ページの２段組の高さを揃える場合、#link("https://typst.app/docs/reference/layout/colbreak/")[`colbreak()`]関数を使って手動で調整してください。


= 謝　　辞

謝辞が必要なときは、結論の次に書きます。章番号は付けませんが、「謝辞」の表題はセンタリングをして下さい。


// --------------------------------------------------
// 参考文献
// --------------------------------------------------
// 他の.bibファイルを読み込む場合はこの行を使ってください
// ただし、現時点では公式フォーマットで定められている英語日本語の併記には対応できていません
#bibliography("references.bib",
 title: "参　考　文　献",
 style: "libs/jasnaoe-conf/jasnaoe-reference.csl",
 )
// --------------------------------------------------
// // 直接定義する場合はこのコードを編集してください
// #bibliography-list(
//   title: "参　考　文　献", // 参考文献の章のタイトル
// )[
//   #bib-item(<format-en-journal>)[
//     Family names and initials of all authors: Title of the paper, _abbreviated title of the journal (or conference proceedings),_ number of the volume, number of the issue, numbers of the first and last pages, and year of publication.
//   ]
//   #bib-item(<MakiStochastic2023>)[
//     Maki, A., Hoshino, K., Dostal, L. et al.: Stochastic stabilization and destabilization of ship maneuvering motion by multiplicative noise, _Journal of Marine Science and Technology_, 28, 704–718, 2023.
//   ]
//   #bib-item(<OkuboProduction2023>)[
//     Okubo. Y., Mitsuyuki. T.: Study of the practical application of production planning method using shipbuilding process simulation, _Journal of the Japan Society of Naval Architects and Ocean Engineers_, 37, 115-123, 2023 (in Japanese). \
//     大久保友結、満行泰河：船舶建造工程シミュレーションを用いた生産計画立案手法の現場適用に関する研究, _日本船舶海洋工学会論文集_, 37, 115-123, 2023.
//   ]
//   #bib-item(<YamamotoStructure1986>)[
//     Yamamoto, Y., Otsubo, H., Sumi, Y., and Fujino, M.: Ship Structural Mechanics, Seizando-Shoten Publishing Co., Ltd., 1986 (in Japanese). \
//     山本善之、大坪英臣, 角洋一、藤野正隆：船体構造力学、_成山堂書店_、1986。
//   ]
// ]
// --------------------------------------------------