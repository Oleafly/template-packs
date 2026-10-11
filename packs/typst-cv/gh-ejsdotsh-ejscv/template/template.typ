// SPDX-FileCopyrightText: 2025-present git@ejs.sh

// import the Typst template
// #import "@preview/ejscv:0.1.0": *
// for local development, uncomment/use an absolute path
#import "../ejscv.typ": *

// import the CV data from the YAML source
#let cvdata = yaml("template.yaml")

// render the template with the imported YAML
#show: ejscv.with(cvdata)
