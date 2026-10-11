#import "template/settings.typ": settings
#import "template/components.typ": header

#import "@preview/iconify:0.5.3": icon, provide-icons

#provide-icons(
  json("./assets/grommet-icons.json"),
  json("./assets/material-symbols.json"),
  json("./assets/solar.json"),
  json("./assets/mingcute.json"),
)

// Initial Settings and Config
#let config = (lang: "en", author: "Author")
#show: settings.with(config)

#let data = (
  name: "Whisker",
  last-name-1: "Felix",
  last-name-2: "Monroe",
  phone-number: "+33 123456789",
  email: "whisker.felix@gaming.com",
  // The following lines might be changed to assess several languages differences. See some examples below
  city: if config.lang == "en" { "Madrid" }, // else if config.lang == "es" { "Ciudad" },
  country: if config.lang == "en" { "Spain" }, // else if config.lang == "es" { "País" },
  // You can unable any social urls by setting them to none.
  // They will not appear in the header.
  // Examples: "github: none", "photo: none"
  github: "whiskerfelix",
  linkedin: "whiskerfelix",
  webpage: "whiskerfelix.com",
  photo: image("./assets/photo.jpg"),
)

#header(data: data)

#include "content/" + config.lang + ".typ"
