#import "@preview/touying:0.6.1": *
#import "theme/theme.typ": *
#show: custom-theme.with(aspect-ratio: "16-9")


// Custom title slide
#title-slide(title: [Introduction to Aiken], author: [Robertino Martinez], date: datetime.today())

// Every Level 1 heading is a new slide
= First Slide

Hello, IOG!


= Aiken Code

// Custom syntax highlighting for `aiken`
something ```aiken fn(x){ x + 1 }``` something

// "#pause" allows us to reveal the slide in steps
#pause

```aiken
use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction}

validator my_script {
  mint(redeemer: MyRedeemer, policy_id: PolicyId, self: Transaction) {
    todo @"validator logic goes"
  }
}
```

#pause

And *another* _thing_!

// Custom focus slide to be used as section headers
#focus-slide(
  [

    Something!

  ],
)

= Aiken Code
