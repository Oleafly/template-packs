// Third-Party Attributions  
// This project includes modified code from the following MIT-licensed works:  

// - **`great-theorems`** by jbirnick  
//   Source: [https://github.com/jbirnick/typst-great-theorems](https://github.com/jbirnick/typst-great-theorems)  
//   Modifications: Custom styling with `showybox`, layout changes, and theorem numbering adjustments.

#import "@preview/showybox:2.0.4": showybox
#import "@preview/great-theorems:0.1.2": *
#import "@preview/rich-counters:0.2.2": *

#let showythmbox(blocktitle: none, counter: none, numbering: "1.1", prefix: auto, titlix: title => [#title], suffix: none, bodyfmt: body => body, ..global_block_args) = {
  // check if blocktitle was provided
  if blocktitle == none {
    panic("You have created a `mathblock` without a `blocktitle`. Please provide a `blocktitle` like \"Theorem\" or \"Lemma\" or \"Proof\".")
  }

  // set the default prefix
  if prefix == auto {
    if counter == none {
      prefix = [*#blocktitle.*]
    } else {
      prefix = (counter) => [*#blocktitle #counter.*]
    }
  }

  // check consistency of `counter` and `prefix`
  if counter == none and type(prefix) == function {
    panic("You have created a `mathblock` without a `counter` but with a `prefix` that accepts a counter. This is inconsistent. If you want a counter, then provide it with the `counter` argument (see documentation). If you don't want a counter, then you need to set a `prefix` that doesn't depend on a counter (see documentation).")
  } else if counter != none and type(prefix) != function {
    panic("You have created a `mathblock` with a `counter` but with a `prefix` that doesn't depend on a counter. This is inconsistent. If you don't want a counter, then remove the `counter` argument. If you want a counter, then set a prefix that depends on a counter (see documentation).")
  }

  // wrap native counter
  if counter != none and type(counter) != dictionary {
    counter = (
      step: (..args) => { counter.step(..args) },
      get: (..args) => { counter.get(..args) },
      at: (..args) => { counter.at(..args) },
      display: (..args) => { counter.display(..args) },
    )
  }

  // return the environment for the user
  if counter != none {
    return (title: none, numbering: numbering, prefix: prefix, titlix: titlix, suffix: suffix, bodyfmt: bodyfmt, number: auto, ..local_block_args, body) => {
      figure(kind: "great-theorem-counted", supplement: blocktitle, outlined: false)[
        #if number == auto [
          // step and counter
          #(counter.step)()
          #{number = context (counter.display)(numbering)}
          // store counter so reference can get counter value
          // NOTE: alternatively could store result of counter.get(), but then it would take one more layout iteration
          #metadata((loc) => { std.numbering(numbering, ..((counter.at)(loc))) })
          #label("great-theorems:numberfunc")
        ] else [
          // store manual number for reference
          #metadata((loc) => number)
          #label("great-theorems:numberfunc")
        ]

        #showybox(..global_block_args.named(), ..local_block_args.named(),
        title: prefix(number) + if title != none {
          " " + titlix(title)
        } else {
          none
        },
      )[
        // show content
        // Modification: only show the body, since showybox already has the title
        #bodyfmt(body)
        #suffix
        #parbreak()
      ]]
    }
  } else {
    return (title: none, numbering: numbering, prefix: prefix, titlix: titlix, suffix: suffix, bodyfmt: bodyfmt, ..local_block_args, body) => {
      figure(kind: "great-theorem-uncounted", supplement: blocktitle, outlined: false)[#showybox(..global_block_args.named(), ..local_block_args.named(),
        title: prefix + if title != none {
          " " + titlix(title)
         } else {
           none
         },
      )[
        // show content
        // Modification: only show the body, since showybox already has the title
        #bodyfmt(body)
        #suffix
        #parbreak()
      ]]
    }
  }
}

#let metamathbox = (identifier, name, color, counter: none, type: "normal") => {
  showythmbox(
    blocktitle: name, 
    counter: counter,
    // The following params are passed to the showybox function
    title-style: (
      color: color,
      sep-thickness: 0pt,
      align: left
    ),
    frame: (
      title-color: color.lighten(95%),
      border-color: color,
      body-color: color.lighten(95%),
      thickness: (left: 2pt),
      radius: 0pt
    )
  )
}