#import "../dnd/dnd.typ"
#import "../dnd/game/game.typ": *

#show: dnd.core.charbook

#setLocale("en")

#let dobrogon = dnd.game.character(
  name: "Dobrogon Magarynich",
  class: "Artificer",
  subclass: "Alchemist",
  race: "Autognome",
  type: "Construct",
  alignment: "Chaotic Neutral",
  story: "Failed Merchant",
  spellcasting: spellcasting(
    focus: "Tools, Infusions",
    ritualCasting: true
  ),
  level: 5
)

#dnd.page.cover(
  dobrogon.name,
  author: "Batya M.",
  title: "User manual",
  caption: [
    Document number: 8001-004-01-e \
    Revision: 3.0B
  ],
  subtitle: "DM1043/S843"
)

#dnd.page.attacks

#dnd.page.charlist(dobrogon)

#dnd.page.inventory

#page(
  header: section[Spellcasting]
)[
  #dnd.page.spellcasting(dobrogon)

  #dnd.page.spellsSection(
    level: cantrip,

    spell(
      "Mending",
      prep: alwaysPrepared,
      school: transmutation,
      castTime: minute(1),
      duration: instant,
      range: touch,
      components: "VSM"
    )[
      *Repair* small tear or *Heal self HD(1d8) + CON* (min 1)
    ],

    spell(
      "Create Bonfire",
      prep: alwaysPrepared,
      school: conjuration,
      castType: concentration,
      duration: minute(1),
      range: cube(5, range: 60),
      components: "VS"
    )[
      Create area, DEX or *Fire 2d8* on enter or stay
    ],

    spell(
      "Fire Bolt",
      prep: alwaysPrepared,
      school: evocation,
      duration: instant,
      range: target(120),
      components: "VS"
    )[
      Ranged, *Frost 2d8, Slow 10ft*
    ],

    spell(
      "Ray of Frost",
      prep: alwaysPrepared,
      school: evocation,
      duration: instant,
      range: target(60),
      components: "VS"
    )[
      Ranged, *Frost 2d8 + Slow 10ft*
    ]
  )

  #dnd.page.spellsSection(
    level: spellLevel(1, slots: 4),

    spell(
      "Healing Word",
      prep: alwaysPrepared,
      school: evocation,
      castTime: bonusAction,
      duration: instant,
      range: target(60),
      components: "V"
    )[
      *Heal 1d4 + Int*
      #atHigherLevels[+1d4]
    ],

    spell(
      "Ray of Sickness",
      prep: alwaysPrepared,
      school: conjuration,
      castTime: action,
      duration: instant,
      range: target(60),
      components: "VS"
    )[
      Ranged, *Poison 2d8*, CON or Poisoned
      #atHigherLevels[+1d8]
    ],

    spell(
      "Tasha's Hideous Laughter",
      prep: freePreparation(alwaysPrepared),
      school: evocation,
      castTime: action,
      castType: concentration,
      duration: minute(1),
      range: target(30),
      components: "VSM"
    )[
      WIS or *Prone and Incapacitated*, works only INT > 4
    ],

    spell(
      "Absorb Elements",
      prep: preparing,
      school: abjuration,
      castTime: reaction,
      duration: round(1),
      range: self,
      components: "S"
    )[
      Element *Resist*, next meele atack gain +1d6
      #atHigherLevels[+1d6]
    ],

    spell(
      "Alarm",
      prep: preparing,
      school: abjuration,
      castTime: minute(1),
      castType: ritual,
      duration: hour(8),
      range: cube(20, range: 30),
      components: "VSM"
    )[
      *Detect* intruder audibly~(60ft) or mentally~(1mile)
    ],
  )
]

#page[
  #dnd.page.spellsSection(
    spell(
      "Catapult",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: instant,
      range: straightLine(90, range: 60),
      components: "V"
    )[
      DEX or *Bludg. 3d8*, you need an object 1-5lb to throw
      #atHigherLevels[+1d8,+5lb]
    ],

    spell(
      "Cure Wounds",
      prep: preparing,
      school: evocation,
      castTime: action,
      duration: instant,
      range: touch,
      components: "VS"
    )[
      *Heal 1d8* + INT
      #atHigherLevels[+1d8]
    ],

    spell(
      "Detect Magic",
      prep: preparing,
      school: evocation,
      castTime: action,
      castType: concentration + ritual,
      duration: instant,
      range: sphere(30),
      components: "VS"
    )[
      *Detect presence*, spend 1A to see auraaround object
      that bears magic and detect it's school
    ],

    spell(
      "Disguise Self",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: hour(1),
      range: self,
      components: "VS"
    )[
      *Shapeshift*, #(sym.plus.minus)1ft height. Testing by *Investigation*
    ],

    spell(
      "Expeditious Retreat",
      prep: preparing,
      school: transmutation,
      castTime: bonusAction,
      castType: concentration,
      duration: minute(10),
      range: self,
      components: "VS"
    )[
      You can *Dash*
    ],

    spell(
      "Faerie Fire",
      prep: preparing,
      school: necromancy,
      castTime: action,
      castType: concentration,
      duration: minute(1),
      range: cube(20, range: 60),
      components: "V"
    )[
      DEX or *Advantage againts*, light 10ft, no invisibility
    ],

    spell(
      "False Life",
      prep: preparing,
      school: evocation,
      castTime: action,
      duration: hour(1),
      range: self,
      components: "VSM"
    )[
      Add *Temp. HP 1d4+4*
      #atHigherLevels[+5HP]
    ],

    spell(
      "Feather Fall",
      prep: preparing,
      school: transmutation,
      castTime: reaction,
      duration: minute(1),
      range: target(60),
      components: "VM"
    )[
      *Slow falling speed by 60ft*
    ],

    spell(
      "Grease",
      prep: preparing,
      school: conjuration,
      castTime: action,
      duration: minute(1),
      range: square(10, range: 60),
      components: "VSM"
    )[
      Create area, DEX or *Prone*
    ],

    spell(
      "Identify",
      prep: preparing,
      school: divination,
      castTime: minute(1),
      duration: instant,
      range: square(10, range: 60),
      components: "VSM"
    )[
      *Identify* items and spells.
      #required[pearl 100gp]
    ],

    spell(
      "Jump",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: minute(1),
      range: touch,
      components: "VSM"
    )[
      *Jump* distance #sym.times 3
    ],

    spell(
      "Longstrider",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: hour(1),
      range: touch,
      components: "VSM"
    )[
      *Speed* +10ft
      #atHigherLevels[+1 target]
    ],

    spell(
      "Purify Food and Drink",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: instant,
      range: sphere(5, range: 10),
      components: "VS"
    )[
      *Clean poison and disease* in non-magical food
    ],

    spell(
      "Sanctuary",
      prep: preparing,
      school: abjuration,
      castTime: bonusAction,
      duration: minute(1),
      range: target(30),
      components: "VS"
    )[
      *Protection*, enemy: WIS or change target or skip
    ],

    spell(
      "Snare",
      prep: preparing,
      school: abjuration,
      castTime: minute(1),
      duration: hour(8),
      range: circle(5),
      components: "VSM"
    )[
      *Trap*, INT or *Entangled*
      #required[consume 25ft rope]
    ],

    spell(
      "Tasha's Caustic Brew",
      prep: preparing,
      school: conjuration,
      castTime: action,
      castType: concentration + ritual,
      duration: minute(1),
      range: straightLine([30x5]),
      components: "VSM"
    )[
      DEX or *Acid 2d4* each start,
      target can spend 1A to clean
      #atHigherLevels[+2d4]
    ],
  )
]

#page[
  #dnd.page.spellsSection(
    level: spellLevel(2, slots: 2),

    spell(
      "Aid",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: hour(8),
      range: target(30, count: 3),
      components: "VSM"
    )[
      *Max/Cur HP +5*
      #atHigherLevels[+5HP]
    ],

    spell(
      "Aid",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: hour(8),
      range: target(30),
      components: "VSM"
    )[
      *Max/Cur HP +5* for 3 creatures
      #atHigherLevels[+5HP]
    ],

    spell(
      "Air Bubble",
      prep: preparing,
      school: divination,
      castTime: action,
      duration: hour(24),
      range: target(60),
      components: "VSM"
    )[
      Allow 1 creature to *breath*
      #atHigherLevels[+2 target]
    ],

    spell(
      "Alter Self",
      prep: preparing,
      school: transmutation,
      castTime: action,
      castType: concentration,
      duration: hour(1),
      range: self,
      components: "VS"
    )[
      *Shapeshift*,
      - Aquatic - you can breath and sweam fast
      - Appearance - change except size and form
      - Weapon - Grow weapon, magic, *Bludg 1d6*
    ],

    spell(
      "Arcane Lock",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: always,
      range: touch,
      components: "VSM"
    )[
      *Lock* a chest or passage.
      Open for people or password.
      Supressed by Knock. *Break +10DC*
      #required[consume gold dust 25gp]
    ],

    spell(
      "Blur",
      prep: preparing,
      school: evocation,
      castTime: action,
      castType: concentration,
      duration: minute(1),
      range: self,
      components: "V"
    )[
      *Attack disadvantage against*, if relies on eyesight
    ],

    spell(
      "Continual Flame",
      prep: preparing,
      school: necromancy,
      castTime: action,
      duration: always,
      range: touch,
      components: "VSM"
    )[
      *Infinite Light*
      #required[consume ruby dust 50gp]
    ],

    spell(
      "Darkvision",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: minute(1),
      range: touch,
      components: "VSM"
    )[
      *Darkvision* for 60ft
    ],

    spell(
      "Enhance Ability",
      prep: preparing,
      school: conjuration,
      castTime: action,
      duration: hour(1),
      range: touch,
      components: "VSM"
    )[
      *Advantage for check* for selected stat, additionally
      - CON: +2d6 Temp HP.
      - STR: 2#(sym.times)Carrying Capacity
      - DEX: No fall damage  < 20ft
    ],

    spell(
      "Enlarge/Reduce",
      prep: preparing,
      school: divination,
      castTime: action,
      duration: minute(1),
      range: target(30),
      components: "VSM"
    )[
      CON or
      - Enlarge - Size#(sym.times)2, STR Adv., +1d4 attacks
      - Reduce - Size#(sym.times)0.5, STR Dis., -1d4 attacks
    ],

    spell(
      "Heat Metal",
      prep: preparing,
      school: transmutation,
      castTime: action,
      castType: concentration,
      duration: minute(1),
      range: target(60),
      components: "VSM"
    )[
      *On metal object*, any touch - *Fire 2d8*,
      CON to drop or *Disadv.*.
      Use BA to damage again
      #atHigherLevels[+2 targets]
    ],

    spell(
      "Invisibility",
      prep: preparing,
      school: illusion,
      castTime: action,
      castType: concentration,
      duration: hour(1),
      range: touch,
      components: "VSM"
    )[
      Become *Invisible*
    ],
  )
]

#page[
  #dnd.page.spellsSection(
    spell(
      "Kinetic Jaunt",
      prep: preparing,
      school: transmutation,
      castTime: bonusAction,
      castType: concentration,
      duration: minute(1),
      range: self,
      components: "VSM"
    )[
      *Speed +10ft*, *No provoking*, *You can go through creatures*,
      if you end up in creature - move away and take Force Field 1d8
    ],

    spell(
      "Lesser Restoration",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: instant,
      range: touch,
      components: "VS"
    )[
      *Clean disease*, blind., deaf., paral. or poisoned
    ],

    spell(
      "Levitate",
      prep: preparing,
      school: transmutation,
      castTime: action,
      castType: concentration,
      duration: minute(10),
      range: [#target(60), \<500lb],
      components: "VSM"
    )[
      CON or *Levitate up to 20ft*, you can use Move
      to change self #(sym.plus.minus)20ft, or Action
      to move others
    ],

    spell(
      "Magic Mouth",
      prep: preparing,
      school: illusion,
      castTime: minute(1),
      castType: ritual,
      duration: always,
      range: point(60),
      components: "VSM"
    )[
      Implant a *voice message*, choose a trigger (max 30ft distance)
      #required[consume jade dust 10gp]
    ],

    spell(
      "Magic Weapon",
      prep: preparing,
      school: transmutation,
      castTime: bonusAction,
      castType: concentration,
      duration: hour(1),
      range: touch,
      components: "VS"
    )[
      Non magical weapon become magical
      *+1 to attack and damage rolls*
      #atHigherLevels[+2 bonus]
    ],

    spell(
      "Melf's Acid Arrow",
      prep: preparing,
      school: evocation,
      castTime: action,
      duration: instant,
      range: target(90),
      components: "VSM"
    )[
      Ranged,
      - on hit - *Acid 4d4* + *Acid 2d4* end of turn
      - on miss - *Acid 4d4* / 2
    ],

    spell(
      "Protection from Poison",
      prep: preparing,
      school: abjuration,
      castTime: action,
      duration: hour(1),
      range: touch,
      components: "VS"
    )[
      *Neutralize poisoning* (known or random)
      Target gain advantage agains being poisoned
    ],

    spell(
      "Pyrotechnichs",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: instant,
      range: square(20, range: 60),
      components: "VS"
    )[
      Choose non-magical fire, distinguish and choose:
      - Smoke - covers 20ft area heavily obscure, lasts 1m, heavy wind ends it
      - Fireworks - 10ft range, CON or *Blinded*
    ],

    spell(
      "Rope Trick",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: hour(1),
      range: touch,
      components: "VSM"
    )[
      Rope rises into the air and creates *extradimentional space*
      for up to 8 Medium creatures to *hide*.
      You can lift rope so it becomes invisible.
      Attacks or spells can't cross this space, but you can
      see what's outside
      #required[rope < 60ft]
    ],

    spell(
      "See Invisible",
      prep: preparing,
      school: illusion,
      castTime: action,
      duration: hour(1),
      range: self,
      components: "VSM"
    )[
      *See Invisible*, *See Ethereal Plane*
    ],

    spell(
      "Skywrite",
      prep: preparing,
      school: transmutation,
      castTime: action,
      castType: concentration + ritual,
      duration: hour(1),
      range: [Sight],
      components: "VS"
    )[
      *Write up to 10 words* in the sky.
      Heavy wind can end this spell early.
    ],

    spell(
      "Spider Climb",
      prep: preparing,
      school: transmutation,
      castTime: action,
      duration: hour(1),
      range: touch,
      components: "VSM"
    )[
      Allow target to *walk on walls and ceilings*
    ],
  )
]

#page[
  #dnd.page.spellsSection(

    spell(
      "Vortex Warp",
      prep: preparing,
      school: conjuration,
      castTime: action,
      duration: instant,
      range: target(90),
      components: "VSM"
    )[
      CON or be *Teleported*
      #atHigherLevels[+30ft]
    ],

    spell(
      "Web",
      prep: preparing,
      school: conjuration,
      castTime: action,
      castType: concentration,
      duration: hour(1),
      range: cube(20, range: 60),
      components: "VSM"
    )[
      Create web, which is *difficult terrain and lightly obscured*,
      Creaters end in web DEX or *Restrained*.
      Web is *flammable*, burn in 1r with *Fire 2d4*
    ],

    spell(
      "Flaming Sphere",
      prep: preparing,
      school: conjuration,
      castTime: action,
      castType: concentration,
      duration: minute(1),
      range: sphere(5, range: 60),
      components: "VSM"
    )[
      Creates sphere, create that ends its turn within 5ft of it
      DEX or *Fire 2d6*
      Bonus Action: Move to 30ft
    ],
  )

  #inputGrid(20)
]

#dnd.page.abilities(
  ability("Build For Success", source: "Autognome")[
    You can add a *d4* to one *attack~roll*, *ability~check*,
    or *saving~throw* you make, and you can do so after seeing the d20 roll
    but before the effects of the roll are resolved.
    You can use this trait a number of times equal to your proficiency bonus,
    and you regain all expended uses when you finish a long rest.

    #abilityCharges(3)
  ],

  ability("Healing Machine", source: "Autognome")[
    If the *Mending* spell is cast on you, you can spend a Hit Dice,
    roll it, and regain a number of hit points equal to the roll
    plus your Constitution modifier (minimum of 1 hit point).
    In addition, your creator designed you to benefit from several spells
    that preserve life but that normally don't affect Constructs:
    Cure Wounds, Healing Word, Mass Cure Wounds, Mass Healing Word,
    and Spare the Dying.
  ],

  ability("Mechanical Nature", source: "Autognome")[
    You have *resistance to poison* damage and *immunity to desease*,
    and you have advantage on saving throws agains being *paralyzed*
    or *poisoned*. You don't need to eat, drink, or breathe.
  ],

  ability("Sentry Rest", source: "Autognome")[
    When you take a long rest, you spend at least 6 hours
    in an inactive, motionless state, instead of sleeping.
    In this state, you appear inert, but you remain conscious.
  ],

  ability("Supply Chain", source: "Failed Merchant")[
    From your time as a merchant, you retain connections
    with wholesalers, suppliers, and other merchants
    and enterpreneurs.
    You can call upon these connections when looking
    for item or information.
  ],

  ability("The Right Tool f.t. Job", source: "Artificer")[
    At 3rd level, you've learned how to produce exactly the tool you need:
    with thieves' tools or artisan's tools in hand,
    you can magically create one set of artisan's tools
    in an unoccupied space within 5 feet of you.
    This creation requires 1 hour of uninterrupted work,
    which can coincide with a short or long rest.
    Though the product of magic, the tools are nonmagical,
    and they vanish when you use this feature again.

    #abilitySlot(2)
  ],

  ability("Magic Tinkering", source: "Artificer")[
    To use this ability, you must have thieves's
    tools or artisan's tools in hand.

    + The object sheds *bright light* in 5-foot radius
      and dim light for an additional 5 feet.
    + Object emits a *recorded message* that can be heard
      up to 10 feet away 6 seconds long.
    + The object continuously emits your choice of an
      *odor* or *nonverbal sound* perceivable
      up to 10 feet away
    + A static *visual effect* appears on one
      of the object surface

    #repeated(4, abilitySlot(2))
  ],

  ability("Alchemy Savant", source: "Alchemist")[
    Whenever you cast a spell using your alchemist's supplies
    as the spellcasting focus, you gain a bonus to one roll on the spell.
    That roll must *restore HP* or be a damage roll that deals
    *acid*, *fire*, *necrotic*, or *poison* damage.
    And the bonus equals INT
  ],

  ability("Experimental Elixir", source: "Alchemist")[
    Beginning at 3rd level, whenever you finish a long rest,
    you can magically produce an experimental elixir in an empty
    flask you touch.

    + *Healing.* The drinker regains a number of hit points
      equal to *2d4 + INT*
    + *Swiftness.* The drinker's walking speed increases by 10 feet
      for 1 hour.
    + *Resilience.* The drinker gains a +1 bonus to AC for 10 minutes.
    + *Boldness.* The drinker can roll a *d4* and add the number rolled
      to every *attack row and saving throw* they make for the next minute.
    + *Flight.* The drinker gains a flying speed of 10 feet for 10 minutes.
    + *Transformation.* The drinker's body is transformed as if
      by the Alter Self spell. The drinker determines the transformation
      caused by the spell, the effects of which last for 10 minutes

    #repeated(4, abilitySlot(1))
  ],

  ability("Infuse Item", source: "Artificer")[
    Whenever you finish a long rest, you can touch a nonmagical object
    and imbue it with  one of your artificer infusions,
    turning it into a magic item.
    An infusion works on only certain kinds of objects,
    as specified in the infusion's description.
    If the item requires attunement, you can attune yourself
    to it the instant you infuse the item.
    If you decide to attune to the item later,
    you must do so using the normal process for attunement

    Your infusion remains in an item indefinitely,
    but when you die, the infusion vanishes after
    a number of days equal to your Intelligence modifier
    (minimum of 1 day).
    The infusion also vanishes if you replace your knowledge of
    the infusion

    You can infuse more than one nonmagical object
    at the end of a long rest.
    You must touch each of the objects,
    and each of your infusions can be in only one object at a time.
    Moreover, no object can bear more than one of your
    infusions at a time.
    If you try to exceed your maximum number of infusions,
    the oldest infusion ends, and then the new infusion applies.

    If an infusion ends on an item that contains other things,
    like a bag of holding, its contents  harmlessly appear in and around
    its space.

    #colbreak(weak: true)

    #subsection[Active]
    #repeated(5, spacing: paddings(3), abilitySlot(3))
  ],
)

#dnd.page.abilities(
  title: [Known Infusions],

  ability("Enhanced Weapon")[
    #abilityRequirement[
      A simple or martial weapon
    ]

    This magic weapon grants a +1 bonus to attack
    and damage rolls made with it.
  ],

  ability("Returning Weapon")[
    #abilityRequirement[
      A simple or martial weapon with throwin property
    ]

    This magic weapon grants a +1 bonus to attack
    and damage rolls made with it,
    and it returns to the wielder’s hand immediately
    after it is used to make a ranged attack.
  ],

  ability("Replicate Item:\nAlchemy Jug")[
    Once a day using their action,
    the person holding the jug may name one liquid from the below table,
    and the jug will produce up to the maximum amount listed for that liquid,
    after which that liquid can be poured out at a rate of up to 2 gallons per minute.

    #simpleTable(
      ("Substance",   "Max Amount"),
      "Acid",         "8 ounces",
      "Basic poison", "1/2 ounce",
      "Beer",         "4 gallons",
      "Honey",        "1 gallon",
      "Mayonnaise",   "2 gallons",
      "Oil",          "1 quart",
      "Vinegar",      "2 gallons",
      "Fresh water",  "8 gallons",
      "Salt water",   "12 gallons",
      "Wine",         "1 gallon"
    )
  ],

  ability("Replicate Item:\nBag of Holding")[
    This bag has an interior space considerably larger
    than its outside dimensions,
    roughly 2 feet in diameter at the mouth and 4 feet deep.
    The bag can hold up to 500 pounds,
    not exceeding a volume of 64 cubic feet.
    The bag weighs 15 pounds, regardless of its contents.
    Retrieving an item from the bag requires an action.

    If the bag is overloaded, pierced, or torn,
    it ruptures and is destroyed,
    and its contents are scattered in the Astral Plane.
    If the bag is turned inside out, its contents spill forth, unharmed.
    Breathing creatures inside the bag can survive
    up to a number of minutes equal to 10 divided
    by the number of creatures (minimum 1 minute),
    after which time they begin to suffocate.

    Placing a bag of holding inside an extra-dimensional space
    created by a handy haversack, portable hole, or similar item
    instantly destroys both items and opens a gate to the Astral Plane.
    The gate originates where the one item was placed inside the other.
    Any creature within 10 feet of the gate is sucked through it
    to a random location on the Astral Plane.
    The gate then closes.
    The gate is one-way only and can't be reopened.
  ]
)

#dnd.page.proficiencies(
  toolsProficiency(
    "Alchemist's Supplies",
    source: "Alchemist",
    items: (
      [glass beaker #(sym.times) 2],
      "metal frame for holding",
      "glass stirring rod",
      "small pestle and mortar",
      "a porch of common ingredients (salt, iron powder, purified water)"
    ),
    actions: (
      toolsAction("Make a Smoke Cloud", dc: 10),
      toolsAction("Identify a Poison", dc: 10),
      toolsAction("Identify a Substance", dc: 15),
      toolsAction("Make a Fire", dc: 15),
      toolsAction("Neutralize an Acid", dc: 20),
      toolsAction("Craft a Substance")[
        During a long rest you can create one of a listed substances.
        To make it you need to *spend raw materials for a half of price of substance*
        #simpleTable(
          ("Substance", "Price"),
          "Acid",             "25g / vial",
          "Alchemist's fire", "50g / flask",
          "Antitoxin",        "50g / dose",
          "Oil",              "1s / flask",
          "Perfume",          "5g / vial",
          "Soap",             "2c / item"
        )
      ]
    ),
    skillsEffects: (
      skillEffect(arcana)[
        You can get more information about potions and other substances.
      ],
      skillEffect(investigation)[
        You can understand what chemicals was used in area.
      ]
    )
  ),

  colbreak(),

  toolsProficiency(
    "Thieve's Tools",
    source: "Artificer",
    items: (
      "small file",
      "set of lockpicks",
      "small mirror on a little handle",
      "set of narrow-bladed scissors",
      "pair of pliers"
    ),
    actions: (
      toolsAction("Pick a Lock", dc: "target"),
      toolsAction("Disarm a Trap", dc: "target"),
      toolsAction("Set a Trap")[
        As a part of short rest, you can create a trap
        using improvised means.
      ]
    ),
    skillsEffects: (
      skillEffect(history)[
        You can get more information about places that famous for their traps.
      ],
      skillEffect(investigation, perception)[
        You get more Information about traps.
      ]
    )
  ),

  toolsProficiency(
    "Brewer's Tools",
    source: "Autognome",
    items: (
      "large glass jug",
      "quantity of hops",
      "siphon",
      "several feet of tubing"
    ),
    actions: (
      toolsAction("Detect potion in drinks", dc: 10),
      toolsAction("Detect alcohol", dc: 15),
      toolsAction("Ignore alcohol effect", dc: 20)
    ),
    skillsEffects: (
      skillEffect(history)[
        Additional info for events abount alcohol.
      ],
      skillEffect(medicine)[
        You can help with alcohol poisoning and use.
        it as pain dull
      ],
      skillEffect(perception)[
        You can use alco to improve mood of a person.
      ]
    )
  ),

  colbreak(),

  toolsProficiency(
    "Tinker's Tools",
    source: "Artificer",
    items: (
      "thread",
      "needles",
      "wet-stone",
      "scarp of cloth and leather",
      "small pot of glue"
    ),
    actions: (
      toolsAction("Temporary fix a mech", dc: 10),
      toolsAction("Fix twice as fast", dc: 15),
      toolsAction("Make item out of junk", dc: 20),
      toolsAction("Repair")[
        You can restore 10 hp per hour of work.
        You need materials.
      ]
    ),
    skillsEffects: (
      skillEffect(history)[
        You can determine age and origin of an item,
        even if you have only few pieces of it.
      ],
      skillEffect(investigation)[
        You can learn how long ago item was broken.
      ]
    )
  ),

  toolsProficiency(
    "Smith's Tools",
    source: "Artificer",
    items: (
      "hammers",
      "tongs",
      "chracoal",
      "rags",
      "small pot of glue"
    ),
    actions: (
      toolsAction("Sharpen a dull blade", dc: 10),
      toolsAction("Fix an armor", dc: 15),
      toolsAction("Dismantle non magical item", dc: 15),
      toolsAction("Repair")[
        You can restore 10 hp per hour of work.
        You need materials.
      ]
    ),
    skillsEffects: (
      skillEffect(arcana, history)[
        You have additional insight for metal objects.
      ],
      skillEffect(investigation)[
        You can spot slues about weapon, armor and other metalwork.
      ]
    )
  ),

  toolsProficiency(
    "Carpenter's Tools",
    source: "Artificer",
    items: (
      "saw",
      "hammer and nails",
      "square, ruler and adze",
      "plain and chisel"
    ),
    actions: (
      toolsAction("Build a simple construct", dc: 10),
      toolsAction("Build a complex construct", dc: 15),
      toolsAction("Find weak spot in door", dc: 15),
      toolsAction("Dismantle a door", dc: 20),
      toolsAction("Reinforce window/door")[
        For 1 min. with materials you increase its DC by 5.
      ],
      toolsAction("Build a shelter")[
        For long rest you can build a shelter. It will break after 1d3
        days after building.
      ]
    ),
    skillsEffects: (
      skillEffect(history, investigation, perception)[
        You can learn more about wooden items
      ],
    )
  ),

  toolsProficiency(
    "Painter's Supplies",
    source: "Failed merchant",
    items: (
      "easel, chracoal",
      "canvas",
      "brushes, palette"
    ),
    actions: (
      toolsAction("Make a portrait", dc: 10),
      toolsAction("Make a picture with a hidden message", dc: 20),
      toolsAction("Painting and drawing")[
        At a short or long rest you can produce simple work of art
      ]
    ),
    skillsEffects: (
      skillEffect(arcana, history, religion)[
        You have additional insights about art
      ],
      skillEffect(investigation, perception)[
        You can spot clues about paintings
      ]
    )
  )
)

#dnd.page.backstory[
    Dobrogon was created by an old gnome in an unnamed
    deserted village as a moonshine apparatus.
    He spent most of his life in the basement, producing
    alcohol for an old alcoholic, unaware of the outside world.

    The basement was a dim and musty space,
    filled with worn shelves, cobwebs, and aging bottles.
    Sunlight peered through a cracked window, revealing a glimpse
    of the forgotten alchemist's sanctuary.

    At some point, while producing another batch,
    the old man adjusted something, causing Dobrogon to black out.
    When he woke up, he saw a swollen green headless body
    on the floor and a large hole in the wall.
    The old man was nowhere to be found.

    Dobrogon waited for a while, but the old man never showed up.
    So, Dobrogon decided to embark on a search.
    He left his home and wandered until he reached
    a roadside tavern after a few days.
    There, he met the owner who suggested he wait
    for the old man, claiming he would be there soon.
    In the meantime, Dobrogon crafted a variety of exquisite alcoholic.

    After a year of waiting, exhausted, Dobrogon set off to
    search for the old man elsewhere.
    During his journey, he traded alcohol and various
    beverages and substances derived from it.

    During this period, he became interested in alchemy
    as a means of creating more powerful and complex
    substances and compositions.

    Over time, due to active and careless use and lack of repairs
    (none of the encountered artificers could figure out its ridiculous construction),
    the built-in distillation cube in his body stopped producing alcohol properly.
    Occasionally, it would short-circuit, causing a small amount of high-proof alcohol
    to spray onto the ground or his organic parts
    (unclear whether it was humans, animals, or worse).

    Now, Dobrogon actively searches for the old man
    not just because he misses him, but also because
    he might be the only person who can fix him.
]

#dnd.page.personality[
  #biographySection("Personal Traits")[
    #biographySubsection("Naivety")[
      I often seeing the word with childlike wonder and a lack of cynicism.
    ]
    #biographySubsection("Curiosity")[
      I possess an strong thirst for knowledge
      and an insatiable desire to explore the unknown.
    ]
  ]

  #biographySection("Bonds")[
    #biographySubsection("Father")[
      I don't know his actual name.
      But he made me and care about me.
    ]
  ]

  #biographySection("Ideals")[
    #biographySubsection("Freedom")[
      After getting first taste of freedom
      I liked it and won't give it away.
    ]
  ]

  #colbreak()

  #biographySection("Goals")[
    #biographySubsection("Find father")[
      Father missing for a very long time.
      I'm not even sure if he's alive, but I still have to try find him.
    ]
    #biographySubsection("Repair myself")[
      My systems in a very bad condition.
      I need to find somebody skillfull enough to repair me.
    ]
  ]

  #biographySection("Flaws")[
    #biographySubsection("Cheap Machine Oil")[
      My father did not have access to good materials,
      so the cheapest machine oil was poured into me.

      *I have weakness for frost and cold.*
    ]
    #biographySubsection("Poorly Insulated Tubes")[
      After a while of bad exploitation
      my alcohol producing systems got leaks.

      *I can randomly get drunk or make a little puddle of strong alcohol*
    ]
  ]
]

#dnd.page.quests
#dnd.page.quests
