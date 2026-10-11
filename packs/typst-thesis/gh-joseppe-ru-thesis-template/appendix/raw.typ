= Logs
<appendix:logs>

#[
  #show raw: set text(size: 8pt)

  #let log-text = read("files/log.txt")

  #let wrapped-text = log-text.clusters().join(sym.zws)

  #raw(wrapped-text, lang: "txt")
]
