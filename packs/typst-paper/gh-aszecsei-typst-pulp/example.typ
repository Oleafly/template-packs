// ============================================================================
// EXAMPLE DOCUMENT
// Demonstrates the pulp novel template with sample content
// ============================================================================

#import "template/template.typ": *
#import "template/config.typ": default-config
#import "template/page-setup.typ": apply-page-setup, apply-text-setup, apply-paragraph-setup
#import "template/headers.typ": apply-headers
#import "template/content.typ": chapter, part, scene-break, epigraph, chapter-opening
#import "template/front-matter.typ": *
#import "template/back-matter.typ": *

// Configuration
#let config = (
  title: "Death Comes Calling",
  subtitle: "A Jack Stone Mystery",
  author: "Maxwell Steele",
  publisher: "Shadow Press",
  year: "1995",
  isbn: "978-1-23456-789-0",
)

// Apply page setup and styling
#show: apply-page-setup
#show: apply-text-setup
#show: apply-paragraph-setup

// Front Matter
#title-page(
  config.title,
  subtitle: config.subtitle,
  config.author,
  config.publisher,
)

#copyright-page(
  config.title,
  config.author,
  config.publisher,
  config.year,
  config.isbn,
)

#dedication[
  _For Marie—_\
  _who believed when no one else did_
]

#table-of-contents()

// Enable page numbers and headers for main content
#show: apply-headers(config)
#counter(page).update(1)

// --- MAIN CONTENT BEGINS ---

#part("ONE", "The Dead Man's Hand")

#chapter(1, title: "Delaney Street")

#epigraph[
  "I just don't want to be forgotten."
][Anonymous]

#chapter-opening[
#smallcaps[The rain came down] like a punishment from God, hammering the cracked pavement of Delaney Street with the kind of fury that made honest men stay home and sinners think twice. Jack Stone was neither.
]

He stood in the doorway of Sal's Pool Hall, watching the water sheet off the awning, a Lucky Strike burning down to nothing between his fingers. Somewhere in the darkness, a woman screamed. Or maybe it was just a cat. In this neighborhood, it was hard to tell the difference.

#scene-break()

The phone call had come at three in the morning, the way bad news always did. A voice like broken glass, telling him things he didn't want to hear. Telling him that Mickey Dugan was dead, and the cops were calling it suicide.

Mickey Dugan. The toughest SOB to ever come out of Hell's Kitchen. The man who'd taken three bullets at Anzio and walked away laughing. That Mickey Dugan put a gun in his mouth and pulled the trigger?

Not a chance in hell.

"You gonna stand there all night, or you gonna come in and lose some money?"

Jack turned. Sal Benedetto filled the doorway like a side of beef in a bad suit, his fat fingers wrapped around a tumbler of something brown and probably illegal.

"I'm thinking," Jack said.

"That's your problem, Stone. You think too much." Sal's laugh sounded like a garbage disposal eating silverware. "Come on. I got a bottle with your name on it."

#scene-break()

The bottle was cheap rye, the kind that burned going down and kept burning long after. Jack didn't mind. Pain was an old friend, and the rye was just another way of saying hello.

"So what's eating you?" Sal asked, racking the balls with practiced ease. "And don't tell me nothing. You got that look."

"What look?"

"The look that says somebody's gonna get hurt, and it probably ain't gonna be you."

Jack smiled, but there was no warmth in it. Just teeth. "Mickey Dugan's dead."

#chapter(2, title: "The Morgue")

#chapter-opening[
#smallcaps[The morgue smelled] the way morgues always did—like formaldehyde and broken dreams. Jack had been here before, too many times. Each visit left something behind, some small piece of his soul that he'd never get back.
]

The attendant was a kid named Wexler, barely old enough to shave, with the nervous eyes of someone who'd seen too much too soon.

"You family?" Wexler asked.

"Close enough."

The kid shrugged and led him down the corridor, past rows of steel drawers that held the city's forgotten dead. At the end, he stopped and pulled one open.

Mickey Dugan looked smaller in death, the way they all did. The bullet had taken most of his face, but Jack would have known him anywhere. The tattoo on his right forearm—a mermaid with a sailor's cap—was the same one Jack had watched him get in a bar in Naples, forty years and a lifetime ago.

"The police report says suicide," Wexler offered, his voice uncertain.

"The police report is wrong."

#scene-break()

Outside, the rain had stopped, but the city was still wet and gray, like a bruise that wouldn't heal. Jack lit another Lucky and started walking, letting his feet take him where they wanted to go.

They took him to the docks.

The warehouse district was quiet at this hour, nothing moving but rats and shadows. Jack knew both kinds—the four-legged ones and the two-legged variety. He'd done business with both in his time.

The building he wanted was at the end of Pier 17, a crumbling brick monstrosity that had seen better days. A faded sign above the door read "ATLANTIC IMPORTS—EST. 1923." Jack knew what they imported. It wasn't fish.

He tried the door. Locked. He tried it again, this time with his shoulder.

The door gave way, and Jack Stone stepped into the darkness.

#v(1fr)
#align(center)[
  #text(size: 8pt, style: "italic")[
    The story continues...
  ]
]

// Back Matter
#set page(numbering: none)

#also-by(config.author, (
  "Blood on the Bayou",
  "The Shanghai Gambit",
  "Widow's Peak",
  "A Killing in Kansas",
  "The Vermillion Affair",
))

#about-author[
  #set par(first-line-indent: 0pt)
  #text(weight: "bold")[Maxwell Steele] is the pseudonym of a former private investigator who spent fifteen years working the mean streets before trading his .38 for a typewriter. He lives somewhere in the American Southwest with two ex-wives' worth of alimony payments and a dog named Trouble.

  #v(0.5em)

  _Death Comes Calling_ is his ninth novel featuring hard-boiled detective Jack Stone. He is currently at work on his tenth.
]

// Final ad page (common in 90s paperbacks)
#pagebreak()
#set page(header: none)
#v(0.4in)
#align(center)[
  #import "template/config.typ": display-font
  #text(font: display-font, size: 8pt, tracking: 0.1em, weight: "bold")[
    DON'T MISS THE NEXT\
    JACK STONE THRILLER
  ]
  #v(0.6em)
  #text(font: display-font, size: 14pt, weight: "bold")[
    DEAD MAN'S\
    BLUFF
  ]
  #v(0.5em)
  #text(size: 8pt, style: "italic")[
    Coming Soon from #config.publisher
  ]
]
#v(0.6em)
#set text(size: 8pt)
#set par(first-line-indent: 0pt)

When a high-stakes poker game ends in murder, Jack Stone finds himself holding all the wrong cards. The victim: a crooked senator with enough secrets to fill a cemetery. The suspects: a rogues' gallery of gamblers, gangsters, and gorgeous dames—any one of whom had reason to want him dead.

But as Jack digs deeper, he discovers that the real game is just beginning. And in this game, the stakes are his life...

#v(1fr)
#align(center)[
  #text(size: 7pt, tracking: 0.1em)[
    AVAILABLE WHEREVER PAPERBACKS ARE SOLD
  ]
]
