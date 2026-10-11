#import "../lib.typ": *

#show: futtest.with(
  title: "Test title",
  subtitle: "subtitle",
)

=== A note about randomization

In looking at the answer key produced, it may seem that there are duplicate, or even at times patterns in the answers. This is to be expected with randomization - however, note that _students_ are not aware of the answers and still need to consider options.


#SectionHeading(
  "Multiple Choice",
  instructions: "this is a long list of instructions for something that should be interesting.",
)


Syntax:

```typst
// one solution as str, or multiple solutions as an array
// distractors as an array
#MultipleChoice("one solution", ("A", "B", 58))

// Nest within a question:
#Question("Some question text."
  #MultipleChoice("one solution", ("A", "B", 58))
)
```

Some examples of how to use `MultipleChoice`


+ #[Usually one solution is provided as a string, integer, or text (context) type:
    ```typst
        #MultipleChoice("one solution", ("A", "B", 58))
    ```
    #MultipleChoice("one solution", ("A", "B", 58))
  ]

+ #[Multiple solutions are possible with an array:
    ```typst
        #MultipleChoice(("A", "B", "C"), ("D", "E", "F"))
    ```
    #MultipleChoice(("A", "B", "C"), ("D", "E", "F"))
  ]

+ #[Multiple solutions but randomly use only one of them (or any limit):
    ```typst
        #MultipleChoice(("A", "B", "C"), ("D", "E", "F"), solution_limit: 1)
    ```
    #MultipleChoice(("A", "B", "C"), ("D", "E", "F"), solution_limit: 1)
    Note: multiple distractors can be provided and also limited.
  ]

+ #[`text` items (either solutions or distractors) allow for formatting items. `vertical: true` can also be provided to change the orientation. The default is horizontal spread.

    ```typst
        #let formatted_text = [There was a *bold* thing.]

        #MultipleChoice(formatted_text, ("D", "E", "G", 56), vertical: true)
    ```
    #let formatted_text = [*bold* thing.]

    #MultipleChoice(formatted_text, ("D", "E", "G", 56), vertical: true)
  ]




#pagebreak()
#SectionHeading("Match")

Match will take a dictionary and produce a left hand list of questions (with an empty box to fill in) and a right side list of options, including any distractors. Both the left and right side order are randomized. distractors can be an array.

*Note*: the keyword `#blank` can be included in left or right side items to insert a blank line. This is shown below.

*Note*: it may be necessary to resize the left and right size. This can be done with `col_size: (1fr, 1fr)`

```typst
// Match(pairs, limit: none, distractors: none, distractor_limit: none, style: "A", col_size: (1fr, 1fr))

#Match(
  (
    "color": "green",
    "fruit": "banana",
    "vegetable": "carrot",
    "furniture": "chair",
    "A #blank is a flower": "rose",
  ),
  limit: 3,
  distractors: "a single distractor",
)
```

#Match(
  (
    "color": "green",
    "fruit": "banana",
    "vegetable": "carrot",
    "furniture": "chair",
    "A #blank is a flower": "rose",
  ),
  limit: 3,
  distractors: "a single distractor",
)

#Match(
  (
    "color": "green",
    "fruit": "banana",
    "vegetable": "carrot",
    "furniture": "chair",
    "A #blank is a flower": "rose",
  ),
  limit: 3,
)


`OptionSelect` is meant to be used with audio that can't be randomized (i.e. the options are presented in audio)

Here is some text #OptionSelect("ABC", "B")


What about T/F?

#[this thing #True]
#[this thing #False]



Hello #ClozeBlank[this] is a clozeblank
