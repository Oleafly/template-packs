#let translations = (
	"es": (
		"toc": "Tabla de contenidos",
		"chapter": "Capítulo",
		"annex": "Anexo",
		"annex-pl": "Anexos",
		"acknowledgements": "Agradecimientos",
		"author": "Autor(a)",
		"tutor": "Tutor(a)",
		"studies": (studies, name) => [#studies en #name],
		"thesis_kind": (studies) => [Trabajo de Fin de #studies],
		"title": "Título"
	),
	"en": (
		"toc": "Table of contents",
		"chapter": "Chapter",
		"annex": "Appendix",
		"annex-pl": "Appendices",
		"acknowledgements": "Acknowledgements",
		"author": "Author",
		"tutor": "Tutor",
		"studies": (kind, name) => [#kind Degree in #name],
		"thesis_kind": (studies) => [#studies Thesis],
		"title": "Title"
	)
)

#let get-i8n(code, ..extra) = context{
	let x = translations.at(text.lang).at(code)
	if type(x) == function {
		x(..extra)
	}else{
		x
	}
} 