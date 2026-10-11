/*
 * Tested with typst 0.14.2 (latest as of 2026-02-01).
 */

#import "@preview/chronos:0.2.1"

#let GLOBAL_BLOCK_FILL  = rgb(50, 50, 50)
#let GLOBAL_BLOCK_INSET = 8pt
#let GLOBAL_TEXT = rgb(230, 230, 230)
#let GLOBAL_PAGE_FILL = rgb(20, 20, 20)

#set document(
  title: [Username-less Passkey Auth]
)
#set page(fill: GLOBAL_PAGE_FILL)
#set text(fill: GLOBAL_TEXT)
#set heading(numbering: "1.1")

#title()

= Overview

#table(
  columns: 4,
  [*component*],
  [*name*],
  [*version*],
  [*notes*],

  [server library],
  [_webauthn-rs_],
  [`0.5.4`#footnote[
    https://docs.rs/webauthn-rs/0.5.4/webauthn_rs/index.html
    (accessed 2026-02-01)
  ]],
  [Latest as of 2026-02-01.],

  [client web browser],
  [_Brave_],
  [`1.86.146`],
  [Latest as of 2026-02-01.],

  [client OS],
  [_Windows 11_],
  [`25H2`#footnote[
    Edition Windows 11 Home,
    Version 25H2,
    OS build 26200.7623,
    Experience Windows Feature Experience Pack 1000.26100.275.0
  ]],
  [],
)

@fig-passkey-create-and-register-overview approximates passkey creation process
steps on a high level. @fig-passkey-create-and-register-detailed depicts the
process in more detail.

#block(breakable: false)[
  #figure(
      chronos.diagram({
        chronos._par("os", display-name: "OS Passkey Store", color: GLOBAL_BLOCK_FILL)
        chronos._par("browser", display-name: "Web Browser Client", color: GLOBAL_BLOCK_FILL)
        chronos._par("server", display-name: "Server", color: GLOBAL_BLOCK_FILL)

        chronos._seq("browser", "server", comment: [
          *\#1*\
          Client requests parameters for\
          creating a passkey from server.
        ])

        chronos._note("over", [
          *\#2*\
          Server determines what parameters\
          to use and stores a corresponding\
          transaction in its state to be\
          finalized later.
        ], pos: "server", color: GLOBAL_PAGE_FILL)

        chronos._seq("server", "browser", comment: [
          *\#3*\
          Passkey creation parameters and\
          a reference to the transaction in\
          progress.
        ])

        chronos._note("over", [
          *\#4*\
          Call the OS's passkey store for\
          creating a passkey.
        ], pos: "browser", color: GLOBAL_PAGE_FILL)

        chronos._seq("browser", "os", comment: [
          *\#5*\
        ])
      }),
    caption: [Overview of creating a passkey.],
  ) <fig-passkey-create-and-register-overview>
]

#block(breakable: false)[
  #figure(
      chronos.diagram({
        chronos._par("os", display-name: "OS Passkey Store", color: GLOBAL_BLOCK_FILL)
        chronos._par("browser", display-name: "Web Browser Client", color: GLOBAL_BLOCK_FILL)
        chronos._par("server", display-name: "Server", color: GLOBAL_BLOCK_FILL)

        chronos._seq("browser", "server", comment: [
          *\#1*\
          Client requests parameters for\
          creating a passkey from server.
          ```http
          POST /api/v1/key/create/init
          ```
        ])

        chronos._note("over", [
          *\#2*\
          Server determines what parameters\
          to use and stores a corresponding\
          transaction in its state to be\
          finalized later.#footnote[
            https://docs.rs/webauthn-rs/0.5.4/webauthn_rs/struct.Webauthn.html#method.start_passkey_registration
            (accessed 2026-02-01)
          ]
          ```rust
          // webauthn-rs
          start_passkey_registration();
          ```
        ], pos: "server", color: GLOBAL_PAGE_FILL)

        chronos._seq("server", "browser", comment: [
          *\#3*\
          Passkey creation parameters and\
          a reference to the transaction in\
          progress.
          ```http
          200 OK
          Content-Type: application/json

          {
            "transaction_id": "abcd1234",
            "params": { }
          }
          ```
        ])

        chronos._note("over", [
          *\#4*\
          Call the OS's passkey store for\
          creating a passkey.#footnote[
            https://developer.mozilla.org/en-US/docs/Web/API/CredentialsContainer/create
            (accessed 2026-02-01)
          ]
          ```javascript
          await navigator
            .credentials
            .create();
          ```
        ], pos: "browser", color: GLOBAL_PAGE_FILL)

        chronos._seq("browser", "os", comment: [
          *\#5*\
        ])
      }),
    caption: [Creating a passkey.],
  ) <fig-passkey-create-and-register-detailed>
]
