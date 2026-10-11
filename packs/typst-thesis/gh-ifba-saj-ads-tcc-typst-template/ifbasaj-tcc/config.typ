// config.typ — Estado global compartilhado do documento.
#let _config = state("ifba-saj-config", (year: none, author: none, titulo: none, orientador: none, curso: none, cidade: none, versao-impressao: false))
#let set-config(year: none, author: none, titulo: none, orientador: none, curso: none, cidade: none, versao-impressao: false) = {
  _config.update(c => (
    year: if year == none { c.year } else { year },
    author: if author == none { c.author } else { author },
    titulo: if titulo == none { c.at("titulo", default: none) } else { titulo },
    orientador: if orientador == none { c.at("orientador", default: none) } else { orientador },
    curso: if curso == none { c.at("curso", default: none) } else { curso },
    cidade: if cidade == none { c.at("cidade", default: none) } else { cidade },
    versao-impressao: versao-impressao,
  ))
}

// Lê a configuração atual.
#let get-config() = _config.get()
#let get-autor() = context _config.get().author
#let get-titulo() = context _config.get().at("titulo", default: none)
#let get-ano() = context _config.get().year
#let get-orientador() = context _config.get().at("orientador", default: none)
#let get-curso() = context _config.get().at("curso", default: none)
#let get-cidade() = context _config.get().at("cidade", default: none)
