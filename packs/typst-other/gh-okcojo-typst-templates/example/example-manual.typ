#import "../manual.typ": configure, warn

#set document(
  title: [マニュアル向け Typst テンプレート manual],
  author: "Author is me",
  description: [マニュアル向けのテンプレートの使用例です],
)
#metadata((appVersion: "1.0.0", docVersion: "1.0.2")) <metadata>

#show: configure.with(
  title: context document.title,
  appVersion: context query(<metadata>).first().value.appVersion,
  docVersion: context query(<metadata>).first().value.docVersion
)
