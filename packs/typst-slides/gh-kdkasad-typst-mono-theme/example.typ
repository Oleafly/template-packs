//
// A monospaced theme for Typst documents.
// Copyright (C) 2025 Kian Kasad (@kdkasad) <kian@kasad.com>
// This project is licensed under the MIT License.
// See the provided LICENSE file for details.
//

#import "theme.typ": theme, title
#show: theme.with(
  copyright: [Copyright #sym.copyright 2025 Kian Kasad]
)
#set document(
  // title will be set by #title[]
  author: "Kian Kasad",
)

#title[Tree-sitter is awesome and you should use it]

= This is a first-level heading

#lorem(50)

== This is a second-level heading
#lorem(50)

=== This is a third-level heading
#lorem(50)

#lorem(50)

