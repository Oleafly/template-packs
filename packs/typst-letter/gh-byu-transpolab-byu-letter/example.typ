#import "byu-letter.typ": business-letter

#show: business-letter.with(
  // Replace with any PNG, JPG, SVG, or PDF logo path. Use `none` for no logo.
  logo: "civilengineer_parent_gray.png",
  sender-name: "Cosmo Cougar, PhD PE",
  sender-role: "Professor",
  contact-lines: (
    [Brigham Young University • 430 Engineering Building • Provo, UT 84602],
    [(801) 422-8505 • gregmacfarlane\@byu.edu],
  ),
  date: [August 7, 2026],
  recipient: [Dear Name,],
  closing: [Regards,],
  signature-name: [Cosmo Cougar],
)

Begin writing your message here. This template keeps the distinctive narrow
letter column and left-side information rail from the original Word letterhead.

Replace these sample paragraphs with the body of your letter. Normal Typst
markup works here, including *emphasis*, links, and lists. The footer contact
information repeats automatically if the letter runs to more than one page.

Add as much additional text as needed. The body remains within the source
document's 4.25-inch writing column, with the logo, sender block, date, and
footer placed independently from the letter text.
