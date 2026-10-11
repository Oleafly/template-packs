#import "../theme/template.typ": *

#let thesis(title, prelude, main, app, ack) = {
  set text(lang: "ja", font: "Hiragino Mincho ProN", size: 11pt)
  { title }
  // abstruct + outline
  {
    show: outline-header
    prelude
    pagebreak(weak: true)
    outline(
      depth: 3,
      indent: auto,
      title: [#text(1.5em)[目次#v(1em)]],
    )
    show outline: it => {
      in-outline.update(true)
      it
      in-outline.update(false)
    }

    pagebreak(weak: true)
    outline(
      indent: auto,
      title: [#text(1.5em)[図目次]#v(1em)],
      target: figure.where(kind: image),
    )

    pagebreak(weak: true)
    outline(
      indent: auto,
      title: [#text(1.5em)[表目次]#v(1em)],
      target: figure.where(kind: table),
    )
  }
  pagebreak(weak: true, to: "odd")
  counter(page).update(1)
  // main-text
  {
    show: main-template
    main
  }
  // appendix
  {
    show: appendix-template
    app
  }
  // acknowledgement+references
  {
    show: acbib-template.with([謝辞])
    show heading.where(level: 1): set text(1.5em)
    heading(level: 1, [謝辞], numbering: none)
    ack

    pagebreak(weak: true)
    import "@preview/blinky:0.2.0": link-bib-urls
    import "@preview/enja-bib:0.1.0": *
    show: acbib-template.with([参考文献])
    // ------------- キリトリ線 ------------- //
    mymemo()[
      (説明用。使用時はstate.typのmymemoブロックを消してください)

      参考文献は普通に.bibとか.yamlとかにまとめてから`#bibliography`で呼び出せばよい。styleについてはいろいろあるだろうが、自分は"american-physics-society"でやった。どんなのが選べるかはドキュメント参照のこと。

      あとここだけは英語設定にしないとうまいこといかない。日本語設定のままにすると例えば"S. Abe and T. Donald"が"S. Abe と T. Donald"って感じに出力されてまう。
    ]
    // ------------- キリトリ線 ------------- //
    import bib-setting-plain: *
    show: bib-init
    set text(lang: "En")
    link-bib-urls(link-fill: blue)[
      #bibliography("../references.bib", title: "参考文献", full: true, style: "american-physics-society")
    ]
  }
}
