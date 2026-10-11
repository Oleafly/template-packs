= Introduction
Welcome to Typst @typst_tutorial_nodate! If you are new to Typst you should probably check out the guides @typst_tutorial_nodate. *NOTE:* If you have used LaTeX before, @typst_guide_nodate can provide a quick start to Typst.

In the original Microsoft Word template the following layout suggestions where given:
#quote(block: true, attribution: "Some guy, I don't remember. Sorry!")[
  #set text(size: 14pt)
  Use the font Garamond 12 pt except in the following cases:
    - For headings, use Cambria in different sizes
    - For program listings use Courier New 9 pt, with a somewhat larger line spacing, 115%, (or another similar, mono-space font),
    - For greek letters, use Symbol.
]
Sadly, most of these fonts are not free. Free alternatives to these fonts have been set in `main.typ`. This *formatting should be handled automatically* in the entire document. If not, consult `main.typ` and the #link("https://typst.app/docs/tutorial/formatting/")[#underline[documentation]] at https://typst.app/docs/tutorial/formatting/. That should give insight on how to fix any potential formatting problems.

== Purpose of study
The purpose of this template was mainly to serve as an introduction project. I wanted to learn Typst and this is how I began. Now that the template is done, it could be useful to any students that don't want to use Microsoft Word (, _very_ understandable).

== Lists in Typst
Sometimes, we might want a list with special formatting. Research questions often use a special format.

/ RQ1\:: Is one way to do something like that.
/ RQ2\:: This will probably work well, because the list is small.

// This creates a block. The `#set` in this block only affects this block.
#[
  #set enum(body-indent: 0.8em, numbering: it => [*RQ#it:*]) // Custom numbering func
  + This is another way to do it
  + Might be less tedious
  + If you have
  + Many, many
  + Items.
  + Since numbering is automatic.
] 

*Limitations*
+ Limitations are often put in a list.
+ You can use the `"+"` syntax to create numbered lists.
+ Remember, the `"+"` is simply syntax sugar for `#enum()`.

#pagebreak()
*Contribution*
- Contributions might also be in a list form.
- To make regular lists you use the `"-"` syntax.
- As with numbered lists, the `"-"` syntax is actually just `#list()`

== Figures, tables, labels and referencing 
Tables can, for example, look like @crazy and @hv-logo. Their numbering is handled automatically in Typst. If you want a chapter format like: 3.1, 3.2, 3.3, and so on for tables in Chapter 3, go to `main.typ` and uncomment. Tables should always have a heading and sometimes a descriptive text as well. All tables should be referred to from somewhere in the text.


#figure(
  caption: figure.caption(position: top)[Example. Remember, table captions go above.],
  table(
    columns: (auto, 20%, 3fr),
    table.header([*Automatic width*], [*20% width*], [*3fr width*]),
    [10], [Is], [My],
    [This], [Table], [Crazy]
  ),
)<crazy>

#figure(
  caption: [Example. Remember, figure captions go below.],
  rect(
    image(width: 75%, "logo.png")
  )
)<hv-logo>

For an examples of how tables can be made, see @crazy.
The beautiful logo can be seen in @hv-logo. That is _crazy_!

The shit I went through can be seen in @apx:a.
Furthermore, for some examples of how code can be shown, see @apx:b.

#pagebreak()
== References and sources
I *strongly* recommend the use of a reference manager. #text(red)[*Zotero*] is an #text(green)[excellent#emoji.star] choice. Zotero is free and open-source and provides some basic cloud functionality. There is no reason not to use it. Typst will automatically use an IEEE reference style. Do still double check. A workflow I recommend is:
+ Create a Zotero account and download the desktop App. https://www.zotero.org/download/
+ Create a new group library and invite collaborators.
+ Add sources automatically, by clicking the magic wand, and using an `ISBN` or `DOI`.
+ Add sources manually or from clipboard (`Ctrl+Shift+Alt+I`).
+ Don't forget, you can add `PDF:s` to Zotero #sym.dash which you can read and annotate.
+ Export your library as `BibLaTeX`, `UTF-8`, (no notes or attachments).
+ Import the `.bib` file in your Typst project. Don't forget to reference it in `main.typ`.
+ You can now reference your sources using the `"@"` -syntax. Zotero typically exports sources in the format: `[Author]_[First word of title]_[Date]`
+ Example reference: `@`