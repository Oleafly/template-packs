// ============================================================
//  config.typ
//  Configuration and localization for the thesis template
// ============================================================

// ---------------------- User configuration ----------------------
//
// Every value below can be overridden at compile time from the command line
// WITHOUT editing this file, e.g.:
//
//   typst compile --root . \
//     --input thesis_type=master \
//     --input language=ro \
//     --input department=acse \
//     thesis/main.typ build/thesis.pdf
//
// This is what `scripts/check-matrix.sh` uses to test all combinations while
// leaving config.typ untouched. The defaults here apply for a normal build.

// Small helper: read an override from `sys.inputs`, otherwise use a default.
#let _opt(key, default) = sys.inputs.at(key, default: default)

// Thesis type: "bachelor" | "master" | "phd"
#let thesis_type = _opt("thesis_type", "bachelor")

// Department: "cti" | "acse" | "aii"
#let department  = _opt("department", "cti")

// Document language: "ro" | "en"
#let language    = _opt("language", "en")

// Basic metadata
#let thesis_title = _opt("thesis_title", "Titlu lucrare")
#let supervisor   = _opt("supervisor", "Ștefan-Dan Ciocîrlan")
#let student      = _opt("student", "El Studento")
#let year         = _opt("year", "2026")

// Backwards-compatible aliases (for existing main.typ usage)
#let title       = thesis_title
#let coordonator = supervisor
#let absolvent   = student
#let an          = year


// ---------------------- Department data ----------------------

// Adjust logo paths to your real file structure if needed.
#let departments = (
  cti: (
    name_ro: "Departamentul Calculatoare și Tehnologia Informației",
    name_en: "Department of Computer Science and Engineering",
    logo_ro: "../logos/fac_acs/cti/cti_en_text.svg",
    logo_en: "../logos/fac_acs/cti/cti_en_text.svg",
  ),
  acse: (
    name_ro: "Departamentul Automatică și Ingineria Sistemelor",
    name_en: "Department of Automatic Control and Systems Engineering",
    logo_ro: "../logos/fac_acs/acse/acse_en_text.png",
    logo_en: "../logos/fac_acs/acse/acse_en_text.png",
  ),
  aii: (
    name_ro: "Departamentul Automatică și Informatică Industrială",
    name_en: "Department of Automatic Control and Industrial Informatics",
    logo_ro: "../logos/fac_acs/aii/aii_ro_text.svg",
    logo_en: "../logos/fac_acs/aii/aii_ro_text.svg",
  ),
)

#let current_department = departments.at(department)


// ---------------------- Thesis type data ----------------------

#let thesis_types = (
  bachelor: (
    doc_kind_ro: "Lucrare de diplomă",
    doc_kind_en: "Bachelor Thesis",
  ),
  master: (
    doc_kind_ro: "Disertație",
    doc_kind_en: "Master Thesis",
  ),
  phd: (
    doc_kind_ro: "Teză de doctorat",
    doc_kind_en: "PhD Thesis",
  ),
)

#let current_thesis_type = thesis_types.at(thesis_type)


// ---------------------- Localization (i18n) ----------------------

#let i18n = (
  ro: (
    logo_university: "../logos/nustpb/PB_logo_ro.svg",
    label_department: current_department.name_ro,
    label_faculty: "Facultatea de Automatică și Calculatoare",
    label_university: "Universitatea Națională de Știință și Tehnologie",
    label_university_short: "POLITEHNICA București",
    label_supervisor: "Coordonator",
    label_supervisor_title: "ȘL. dr. ing.",
    label_student: "Absolvent",

    label_toc: "Cuprins",
    label_abstract: "Abstract",
    label_bibliography: "Bibliografie",
    label_appendices: "Anexe",

    ch_intro: "Introducere",
    ch_theory: "Fundament teoretic",
    ch_arch: "Arhitectură",
    ch_impl: "Implementare",
    ch_eval: "Evaluare",
    ch_discussion: "Discuții",
    ch_conclusions: "Concluzii",

    placeholder_fill_chapter: "Completați conținutul acestui capitol.",
    placeholder_fill_section: "Completați conținutul acestei secțiuni.",
    placeholder_appendix_note: "Cu fragmente de cod software și/sau diagrame sau alte elemente, dacă este cazul.",

    figure_prefix: "Figura",
    table_prefix: "Tabel",
  ),

  en: (
    logo_university: "../logos/nustpb/PB_logo_en.svg",
    label_department: current_department.name_en,
    label_faculty: "Faculty of Automatic Control and Computer Science",
    label_university: "National University of Science and Technology",
    label_university_short: "POLITEHNICA Bucharest",
    label_supervisor: "Supervisor",
    label_supervisor_title: "Assist. Prof. PhD Eng.",
    label_student: "Student",

    label_toc: "Contents",
    label_abstract: "Abstract",
    label_bibliography: "References",
    label_appendices: "Appendices",

    ch_intro: "Introduction",
    ch_theory: "Background",
    ch_arch: "Architecture",
    ch_impl: "Implementation",
    ch_eval: "Evaluation",
    ch_discussion: "Discussion",
    ch_conclusions: "Conclusions",

    placeholder_fill_chapter: "Fill in the content of this chapter.",
    placeholder_fill_section: "Fill in the content of this section.",
    placeholder_appendix_note: "Include software code snippets and/or diagrams or other elements, if applicable.",

    figure_prefix: "Figure",
    table_prefix: "Table",
  ),
)

#let current_i18n = i18n.at(language)


// ---------------------- Helper functions ----------------------

// Translation helper: t("key") -> localized string
#let t(key) = current_i18n.at(key)

// Document kind: Lucrare de diplomă / Bachelor Thesis / etc.
#let doc_kind() = if language == "ro" {
  current_thesis_type.doc_kind_ro
} else {
  current_thesis_type.doc_kind_en
}

// Department name in current language
#let department_name() = t("label_department")

// Department logo path in current language
#let department_logo_path() = if language == "ro" {
  current_department.logo_ro
} else {
  current_department.logo_en
}

// University logo path in current language
#let university_logo_path() = t("logo_university")