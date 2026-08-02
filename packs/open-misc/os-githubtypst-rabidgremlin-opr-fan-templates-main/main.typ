#import "@preview/hydra:0.6.0": hydra

#set page(
  paper: "a4",
  margin: (left: 1.2cm, right: 1.2cm, top: 1.75cm, bottom: 1cm),
  header: context {[    
    #set align(left)
    #set text(20pt, weight: "bold",font: "FelinaT26")
    #v(0.75cm)
    #block(upper(hydra(1, skip-starting: false)))    
    #v(0.1cm)
    ]
  },    
  footer: context [
    #align(center)[
    #set text(9pt, weight: "bold",font: "Source Sans 3")  
    #counter(page).display("1",)
  ] ] 
       
)

#set text(
  font: "Source Sans 3",
  //weight: "light",  
  size: 9pt,
  //stroke: 0.1pt + black,
  //fill: black,
  //stroke: 0.2pt +black,
)

#set par(
  justify: false,  
  spacing: 1.45em, 
)

#set list(body-indent: 1.8em)

#show heading.where(
  level: 1
): it => [
  #pagebreak(weak: true)
  // don't show heading it will be in header    
]

#show heading.where(
  level: 2
): it => [
  #set align(left)
  #set text(12pt, weight: "bold",font: "FelinaT26")
  #block(upper(it.body))
  #v(0.5em)
]

#set page(columns: 2)

= General Principles

== The Most Important Rule
When playing a complex game there are going to be occasions where a situation is not covered by the rules, or a rule does not seem quite right. When that is the case use common sense and personal preference to resolve the situation. 

If you and your opponent cannot agree on how to solve a situation, use the following method in the interest of time. 

Roll one die. On a result of 1-3 player A decides, and on a result of 4-6 player B decides. This decision then applies for the rest of the match, and once the game is over you can continue to discuss the finer details of the rules. 

Note that whenever possible, players should agree on any rules and unusual situations (such as weirdly shaped models) before the game begins, to avoid issues later.

== Scale Conventions
This game was written to be played with 32mm scale models in mind, which are mounted on round bases. These bases come in various sizes, and we recommend that you always mount miniatures on the bases they come with. 

Here are some rough guidelines for model and base sizes: 

#set list(indent: 0em)
-	*Infantry*: 32mm tall on 20mm/32mm round bases
-	*Large Infantry:* 50mm tall on 40mm/50mm round bases
-	*Bikes:* 40mm tall on 60mm oval bases
-	*Monsters:* 70mm tall on 60mm round bases
-	*Large Walkers:* 100mm tall on 120mm oval bases
-	*Vehicles:* Various sizes and not mounted on a base

#colbreak()

== Dice
To play the game you are going to need some six-sided dice, which we will refer to as D6. Depending on how many models you are playing with, we recommend having at least 10 to 20 dice to keep things fast. 

Additionally, we recommend having dice of multiple colors so that you can combine them for faster rolling. Whenever a unit is using multiple weapons, you can use different colors for each weapon, and then roll them all at once. 

Sometimes the rules will refer to different types of dice, for example D3, 2D6 and D6+1. There are many types of dice, but the notation remains the same, so just apply the following explanations to all types of weird dice you come across. 

#set list(indent: 2.5em)
-	*D3:* To use these dice, simply roll a D6 and halve the result, rounding up. 
-	*2D6:* To use these dice, simply roll two D6 and sum the results of both dice.
-	*D6+1:* To use these dice, simply roll a D6 and add 1 to the result. 

== Something else
#lorem(300)

#pagebreak()
== Modifiers
Throughout the game there are going to be rules that apply modifiers to your die rolls. These will usually raise or lower the value of a unit’s roll results by either +1 or -1, but the exact number may vary.

Whenever a modifier applies to one of your rolls, simply add or subtract the value from the roll and the new value counts as the final result, however a roll of 6 always counts as a success and a roll of 1 always counts as a fail, regardless of how much it is being modified by.

_Example: A model with Quality 4+ must take three Quality tests with a -1 modifier. The player rolls three dice and scores a 3, 4 and 5, but because of the modifier the final result is a 2, a 3 and a 4._Example

== Weapons
All weapons in the game are separated into two categories: ranged weapons and melee weapons. Ranged weapons have a range value and can be used for shooting, whilst melee weapons don’t have a range value and can be used in melee.

Weapons profiles are represented like this:

#set list(indent: 2.5em)
- Name (Range, Attacks, Special Rules)

_Example: Heavy Rifle (24”, A1, AP(1))_


= Preparation

== Preparing the Battlefield
You are going to need a flat 6’x4’ area to play on, which is usually referred to as “the battlefield” or “the table”. Note that the game can be also played on smaller areas, as long as armies deploy at least 24" apart.

Whilst we recommend playing on a table, you can of course play on the floor, on a bed, or wherever else you have space.

Once you have found a space to play, you are going to have to place at least 15 pieces of terrain on it, though we recommend using 20 or more to keep things interesting. Whilst it’s always nice to play with great looking pieces of terrain, you can simply use household items such as books or cups as terrain.

There are no specific rules on how you should place terrain, but we have provided some general guidelines in the terrain section of this book to help you get started.