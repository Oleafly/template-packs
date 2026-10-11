// Lebenslauf - Component-based Typst toolkit for CVs

#import "utils.typ": (
  custom-list, format-phone, icon, language-level, rating, section-divider, skill-bar, tag, timeline-entry,
  two-column-list,
)
#import "themes/theme.typ": create-theme, load-theme, modern-theme, professional-theme
#import "themes/everforest.typ": everforest-dark, everforest-light
#import "components.typ": *

#let themes = (
  professional: professional-theme,
  modern: modern-theme,
  everforest-light: everforest-light,
  everforest-dark: everforest-dark,
)

#let icon = icon
#let tag = tag
#let timeline-entry = timeline-entry
#let section-divider = section-divider
#let language-level = language-level
#let custom-list = custom-list
#let two-column-list = two-column-list
#let format-phone = format-phone

#let load-theme = load-theme
#let create-theme = create-theme

#let cv-header = cv-header
#let cv-contact-bar = cv-contact-bar
#let cv-section = cv-section
#let cv-section-marker = cv-section-marker
#let cv-entry = cv-entry
#let cv-education = cv-education
#let cv-project = cv-project
#let cv-skills = cv-skills
#let cv-languages = cv-languages
#let cv-contact-list = cv-contact-list
#let cv-sidebar-contact = cv-sidebar-contact
#let cv-photo = cv-photo
#let cv-two-columns = cv-two-columns
#let cv-page = cv-page

// Motivation letter (Anschreiben) components
#let letter-sender = letter-sender
#let letter-date = letter-date
#let letter-recipient = letter-recipient
#let letter-subject = letter-subject
#let letter-body = letter-body
#let letter-signature = letter-signature
