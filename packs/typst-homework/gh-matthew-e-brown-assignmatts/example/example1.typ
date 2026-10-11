#import "../src/lib.typ" as assignmatts

#import assignmatts: assignment


#show: assignment.with(
    title: [Example Assignment],
    author: [Matthew Brown],
    course-code: [CODE-1234],
    course-name: [Assignmatts],
    pdf-author: "Matthew Brown",
    pdf-title: "MATH-3630H - Assignment 1",
)

// -------------------------------------------------------------------------------------------------

#lorem(20) #footnote[This is a footnote.]
#lorem(10) #footnote(numbering: "*")[This is a second footnote.]
#lorem(5)

#figure(
    // cspell:disable-next-line
    image("./img/francesco-ungaro-l3tA9-uFhtg-unsplash.jpg", width: 60%),
    caption: [
        A snow-covered mountain with a bright blue sky behind it.

        #set text(size: 0.75em)
        #let author-url = "https://unsplash.com/@francesco_ungaro?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash"
        #let image-url = "https://unsplash.com/photos/a-snow-covered-mountain-with-a-sky-background-l3tA9-uFhtg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash"

        #v(8pt, weak: true)

        // cspell:disable-next-line
        Photo by #link(author-url)[Francesco Ungaro] on #link(image-url)[Unsplash].
    ],
)

#lorem(25)

#lorem(50)
