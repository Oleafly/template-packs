// ─── Metadaten der Arbeit ────────────────────────────────────────────────────
// Hier alle Angaben zur eigenen Arbeit anpassen.

#let thesis-author-given-name = "Max"
#let thesis-author-surname    = "Mustermann"
#let thesis-author            = thesis-author-given-name + " " + thesis-author-surname
#let thesis-author-address    = [Musterstr. 42 \ 53123 Bonn]
#let thesis-external-company  = ""

#let thesis-keywords          = "Keywords die diese Arbeit beschreiben"
#let thesis-location          = "Sankt Augustin"
#let _monate = ("Januar", "Februar", "März", "April", "Mai", "Juni",
                 "Juli", "August", "September", "Oktober", "November", "Dezember")
#let _today  = datetime.today()
#let thesis-pub-date = str(_today.day()) + ". " + _monate.at(_today.month() - 1) + " " + str(_today.year())

#let thesis-subject           = "Worum es geht"
#let thesis-study-course      = "Computer Science"
#let thesis-study-course-german = "Informatik"
#let thesis-subject-type      = "Seminararbeit"

#let thesis-supervisor-first    = "Prof. Dr. Erika Mustermann"
#let thesis-supervisor-second   = ""
#let thesis-supervisor-external = ""

#let thesis-title  = "Titel der Arbeit"
#let thesis-type   = "Bachelor"
