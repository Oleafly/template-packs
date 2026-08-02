#import "@preview/fontawesome:0.6.0": *

// Renders a single contact item with an icon and optional link.
#let contact-item(icon, label, url: none, brand: false) = {
  let i = if brand {
    fa-icon(icon, font: "Font Awesome 7 Brands")
  } else {
    fa-icon(icon)
  }
  if url != none {
    link(url)[ #i #h(0.3em) #label ]
  } else {
    [ #i #h(0.3em) #label ]
  }
}

// Full contact row generated from profile.yaml.
#let contact-row(profile) = [
  #contact-item("envelope", profile.email, url: "mailto:" + profile.email)
  #h(1em)
  #contact-item("phone", profile.phone)
  #h(1em)
  #contact-item("location-dot", profile.location)
  #h(1em)
  #contact-item("linkedin", profile.linkedin.label, url: profile.linkedin.url, brand: true)
  #h(1em)
  #contact-item("github", profile.github.label, url: profile.github.url, brand: true)
  #h(1em)
  #contact-item("globe", profile.website.label, url: profile.website.url)
]
