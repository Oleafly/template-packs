#import "simple_maketitle/0.1.0/lib.typ":*
// 代わりにsimple_maketitleのフォルダをtypst/packages/localにコピーして、#import "@local/simple_maketitle/0.1.0":* としても同様のことができます。その時には代わりに以下の通りにインポートしてください。
//#import "@local/simple_maketitle/0.1.0":*

#import "@preview/theorion:0.6.0": * //定理環境

#import cosmos.simple: * //シンプルなスタイルのパッケージ
// #import cosmos.fancy: * //少し装飾的なスタイルのパッケージ
// #import cosmos.rainbow: * //カラフルなスタイルのパッケージ
// #import cosmos.clouds: * //雲のようなスタイルのパッケージ
// 
// 
#show: show-theorion //定理環境を表示するためのコマンド

#show: article.with(
  title:"A Simple Document Template for Typst",
  author:"Eito Kubota",
  //date: datetime.today()
)

#lorem(300)