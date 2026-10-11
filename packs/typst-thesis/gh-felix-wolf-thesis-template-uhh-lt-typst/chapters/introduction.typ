#import "../template/lib.typ": *

= Introduction <cha:Introduction>

This is the introduction! Figures are referenced with \@ref, like @fig:figure_label. I can use the glossary to work with abbreviations, such as @gl:nlp. Once they have been mentioned, only the short version is used: @gl:nlp.

#figure(
  image("../assets/lt-logo.svg"),
  caption: "This is a figure."
) <fig:figure_label>

== Work-in-progress-content

#wip_content([I can have content that is only visible when \#wip_content state variable is set to true])

#todo([Same goes for todos...])


#wip_enabled.update(false)

#wip_content([This is no longer visible, since \#wip_content state variable is set to false])

#todo([Same goes for todos...])