// Who the letter is from.
//
// This is the one file you edit to make the template yours. Nothing else under
// src/ carries an identity, so a fork stays a fork of the styling only.
//
// Every value below is a placeholder. Replace the values; do not rename the
// keys — the template and both examples read them by name.
//
// Both language forms are kept because a Hebrew letter is signed in Hebrew,
// while an English edition of the same letter is signed in Latin script.
// Keeping them side by side stops the two editions drifting apart on the facts
// they both assert.

#let sender = (
  name: "Full Name",
  name-he: "שם מלא",

  // Whatever number the recipient will file you under — a personal or company
  // identifier, a customer number, a membership number. Written without
  // separators. Set it to "" and the field disappears from the details block
  // and the signature.
  id: "000000000",

  // One number, on every letter. A recipient who files by phone number files
  // consistently only if you never give them a second number to file under; a
  // mobile on one letter and a landline on the next produces two half-records
  // and no way to notice.
  phone: "00-000-0000",

  email: "you@example.com",

  // The postal address you want a reply sent to. It sits under your name in the
  // details block rather than at the top right, which is the arrangement Hebrew
  // letters generally use.
  address: "1 Example Street, Example City",
  address-he: "רחוב הדוגמה 1, עיר הדוגמה",
)
