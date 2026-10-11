#import "template.typ": *

// Take a look at the file `template.typ` in the file panel to customize this template and discover how it works.
#show: project.with(
  title: "Very Cool Project",
  tag1: "Confirmation Report",
  PAdvisor: "Principal Advisor: Cool Advisor",
  Advisor1: "Associate Advisor: Amazing Advisor",
  Advisor2: "Associate Advisor: Awesome Advisor",
  tag2: "School of Mechanical and Mining Engineering",
  tag3: "Faculty of Engineering, Architecture and Information Technology",
  
  authors: (
    (name: "John Doe", affiliation: "School of Mechanical and Mining Engineering"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: [This template can be used to create a confirmation report for a PhD project. It includes sections for the introduction, motivation, research question, aims, methodology, and background. The template is designed to be easy to customize and use for various projects.]
)


// Main titles are created with `=`, and sub-titles with `==`.
// Additional Tip: You can create sections and subsections by adding more `=` signs.
= Introduction

Add a brief introduction to your project here. This could include the context of your research, the problem you are addressing, and the significance of your work.


== Motivation 
#lorem(20) // This is a placeholder text generator. 
#lorem(20)

#lorem(50)
// In typst, if you want something to go to the next paragraph or line, you will have to leave a blank line in between the text. Otherwise, it will be considered as a single paragraph.
          


== Research Questions
*Why in bold?* // Enclosed asterisk for bold text.
_Why in italic?_ // Enclosed underscore for italic text.
#emph("Why in emphasis?") // Emphasized text.

#{ set text(style: "italic")  // Set text style to italic. (can be useful for longer sets of text)
  [Why in italic?]
}

#strong("Why in bold(strong)?") // Strong (or bold text) text.
#strong([Why in bold(strong)?]) // What is the difference between this and the previous one?
// We use '#' to call a function. If we use "" inside the brackets, we can enter strings and sentences into the function.'[]'- square brackets enable to have functions inside of other functions.

#emph([#strong("Why in bold emphasis?")]) // Emphasized bold text.

#text(style: "italic", red)[
  Read the .typ file comments to understand the difference between the functions and other tips and tricks.] // This is a function that sets the text style to italic and color to red. read documentation for more information.

== Aims
Use the '-' to create a bullet point list.
- Bullet point 1
- Bullet point 2 
- Bullet point 3

== Methodology

Use the '+' to create a numbered list.

+ Numbered point 1
+ Numbered point 2
+ Numbered point 3

#pagebreak() // This ensures that the next part is on a new page.

= Background <background> 
// If you want to add a label to a section, you can use the '<label>' syntax. This is useful for referencing the section later in your document.

This chapter is the background chapter and in the future it can be referenced by using '_#"@background"_' in the code and will be visibile in the document as @background. 
This will also work for equations and tables.

Equations in typst can be quickly created using '#"$"', 
$a+b=c$.
If you want the equation to be outside of the text, you can use '#"$ $"' and ensure there is space between the dollar signs and the equation.
$ a-c=b $
This will automatically number the equations.
// Refer to the typst website for all the different variables in equations.
$ F=J times B,"  " F_(t h r u s t)=F_("thrust")= alpha+sigma^omega-Sigma Omega  $ <exampleeq> 
// Remember to always leave a space between variables in math mode. Otherwise typst will think you are using a symbol name
Use this link to see all the different symbols in typst, betyond what is shown in @exampleeq.

https://typst.app/docs/reference/symbols/sym/ 
// You can just copy paste links to create hyperlinks.


You can just copy paste images and typst should automatically upload the image into the folder and display it wherever you pasted it into.
#image("FDC_Willard_-_lapa.svg.png", width: 27%)
Use the '#"#figure"' function to create a figure with a caption.
#figure(
image("FDC_Willard_-_lapa.svg.png", width: 27%),
  caption: [FDC Willard's signature],
) // Notice how image is a function inside the figure function inside '()' brackets, so it is not necessary to use the '#' sign for the image function. If '[]' brackets are used, it is not necessary to use the '#' sign for the function inside the brackets.

Create a table using the '#"#table"' function.

#table(align:left, columns: 2,
  [*Heading 1*], [*Heading 2*],
  [1], [2],
  [3], [4],
)
Nest it in a figure using the '#"#figure"' function.
#figure(
  table(align: center, columns: (auto, auto),
    [*Heading 1*], [*Heading 2*],
    [1], [2],
    [3], [4],
  ),
  caption: [This is a table inside a figure with auto columns.]
) // Notice how the table function is inside the figure function.
#figure(
  table(align: center, columns: (100pt, 100pt),
    [*Heading 1*], [*Heading 2*],
    [1], [2],
    [3], [4],
  ),
  caption: [This is a table with specific column lengths]
) //There are different ways to set length in typst. 'pt' is one of them. You can also use 'cm', 'em', '%',....

//There is a specific line in the template file that sets the caption position to the top of the table. You can comment it out if you want the caption to be at the bottom of the table.

Now  this paragraph is immediately after the table.
#v(1em)
You can use the '#"#v"' function to create vertical space between elements.
#v(3cm)  
Try different units and values (even negative values!). Images can be sized with specific measurements or % .

#pagebreak()

= Literature Review
#{set text(style: "italic")
[
There once was a cat, \
Who a physicist liked. \
Beloved was he,\
His initials are now etched to cite.
]}
// You can also use '\' to create a new line in the text.
#v(1cm) // This is a function that creates vertical space between elements.
Interesting paper. Ceowler author. @hetherington1975two
/*

Just upload a regular .bib file and typst will automatically create the bibliography for you.
You can use '@' to reference a citation. This will automatically create a bibliography at the end of the document.

*/
#pagebreak()
= Progress
 
You should now know the basics to start writing your report. There is a small learning curve, but the best way to learn is to get started and play around with the different functions. All the best #emoji.fingers
// Yes, you can also add emojis in typst. 