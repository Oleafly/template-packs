
// --------------------------------
// Custom functions for Utility
// Accompanies "template_KDP_6x9in_en_v1.typ"
// 
// Demis D. John, 2026


/*********************************/
//  Functions
/*********************************/

// return top-level Chapter number.
//  For use in Chapter headings.
#let chapter_number() = context counter(heading).at(here()).first()


// Add short/long captions to List of Figures:
#let in-outline = state("in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }
// #show rule is in main "template...typ" file, in the `book()` definition.


// Figure with No caption on the page, but still shows up on List of Figs:
#let fig-no-caption(content, cap) = {
  figure(
    content,
    caption: cap,
    kind: "nocaption",
    supplement: [Figure]
  ) 
}
// show rule is in main_KDP:book()...


#let reference-figure(target) = context {
  // Example usage:
  // #reference-figure(<my-image>)
  
  let matches = query(target)
  
  if matches.len() > 0 {
    let el = matches.first()
    
    // Get the correct number based on the figure's specific kind (image, table, etc.)
    let num = numbering(
      el.numbering, 
      ..counter(figure.where(kind: el.kind)).at(el.location())
    )
    
    // Get the page number
    let pg = el.location().page()
    
    // Return the formatted link
    link(target)[Fig #num on page #pg]
  } else {
    [\<label not found\>]
  }
}


