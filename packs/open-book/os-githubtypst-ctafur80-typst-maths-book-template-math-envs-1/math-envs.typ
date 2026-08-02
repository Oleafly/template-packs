

/* Some math environments. */




// TODO Crear diccionario asociando los idiomas y los distintos nombres: en:
// proposition, es: proposición, etc.



#let reset_thm_counters = {
  counter("proposition").update(0)
  counter("theorem").update(0)
  counter("example").update(0)
  counter("lemma").update(0)
  counter("corollary").update(0)
  counter("exercise").update(0)
  counter("axiom").update(0)
  counter("deffinition").update(0)
}


// Updating the counters by sections
#show heading.where(level: 1): it => {
  // pagebreak()
  reset_thm_counters
  it
}






// Proposition
#let proposition(title, it) = {
  counter("proposition").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let prop_number = context counter("proposition").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Proposición #heading_number#prop_number#the_title.]
    #text[#it]
  ]
}



// Theorem
#let theorem(title, it) = {
  counter("theorem").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let thm_number = context counter("theorem").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Teorema #heading_number#thm_number#the_title.]
    #text[#it]
  ]
}




// Axiom
#let axiom(title, it) = {
  counter("axiom").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let ax_number = context counter("axiom").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Axioma #heading_number#ax_number#the_title.]
    #text[#it]
  ]
}



// Euclid axiom
#let euclid_ax(title, it) = {
  counter("euclid").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let number = context counter("euclid").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("3d2c33"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Axioma P#number de Euclides#the_title.]
    #text[#it]
  ]
}





// Deffinition
#let deffinition(title, it) = {
  counter("deffinition").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let deff_number = context counter("deffinition").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Definición #heading_number#deff_number#the_title.]
    #text[#it]
  ]
}




// Lemma
#let lemma(title, it) = {
  counter("lemma").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let lem_number = context counter("lemma").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Lema #heading_number#lem_number#the_title.]
    #text[#it]
  ]
}





// Corollary
#let corollary(title, it) = {
  counter("corollary").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let cor_number = context counter("corollary").display()

  set enum(numbering: "(i)")

  block(
    // breakable: false,
    width: 100%,
    fill: gradient.linear(rgb("2c2c3d"), rgb("3b3b30")),
    inset: 8pt,
    radius: 4pt,
  )[
    #text(weight: "bold"
    )[Corolario #heading_number#cor_number#the_title.]
    #text[#it]
  ]
}







// Example
#let example(title, it) = {
  counter("example").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let exampl_number = context counter("example").display()

  block[
    #text(weight: "bold"
    )[Ejemplo #heading_number#exampl_number#the_title.]
    #text[#it]
    #h(1fr)
    $triangle.filled.br$
  ]
}




// Exercise
#let exercise(title, it) = {
  counter("exercise").step()

  let the_title = title
  if the_title != [] {
    the_title = [ (#the_title)]
  }

  let heading_number = context counter(heading.where(level: 1)).display()

  let exerc_number = context counter("exercise").display()

  block[
    #text(weight: "bold"
    )[Ejercicio #heading_number#exerc_number#the_title.]
    #text[#it]
    #h(1fr)
    $triangle.filled.br$
  ]
}





// Remark.
#let remark(it) = {
  block[
    #text(weight: "bold"
    )[Observación. ]
    #text[#it]
    #h(1fr)
    $triangle.filled.br$
  ]
}



// Remark about notation.
#let remark_notat(it) = {
  block[
    #text(weight: "bold"
    )[Notación. ]
    #text[#it]
    #h(1fr)
    $triangle.filled.br$
  ]
}

// Remark about terminology.
#let remark_term(it) = {
  block[
    #text(weight: "bold"
    )[Terminología. ]
    #text[#it]
    #h(1fr)
    $triangle.filled.br$
  ]
}






// TODO Put a reference to a math environment such as a theorem,
// proposition, etc.
// Proof.
#let proof(it) = {
  block[
    #text(weight: "bold")[Demostración~---]
    #it
    #h(1fr)
    $qed$
  ]
}


