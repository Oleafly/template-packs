#import "../fretboard.typ"

= Simple Guitar Fretboard

A simple fretboard for a 24 fret 6 string guitar. Note the lack of any parameters in the code:

```typc
#fretboard.draw_fretboard()
```
#fretboard.draw_fretboard()

= Simple Bass-Guitar Fretboard

A simple fretboard for a 19 fret 4 string bass guitar.

```typc
#fretboard.draw_fretboard(strings: 4, frets: 19)
```
#fretboard.draw_fretboard(strings: 4, frets: 19)

= Complex Weird Guitar Fretboard

An a bit more complex fretboard for a 7 fret 2 string guitar with changed width and height for better visualization

```typc
#fretboard.draw_fretboard(strings: 2, frets: 7, width: 8cm, height: 2cm)
```
#fretboard.draw_fretboard(strings: 2, frets: 7, width: 8cm, height: 2cm)

#pagebreak()

= Fretboard with tuning

It will be possible to provide a tuple for individual note names as the `tuning` parameter. This will also offset the fretboard by a bit to make room for the note names.

```typc
#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
)
```

#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
)



For comparision, here's the same fretboard without note names:
#fretboard.draw_fretboard()

#pagebreak()

= Fretboard with highlighted notes

Now comes the fun part. The `body` parameter accepts another code part in which additional functions called. This will be used to highlight certain notes, chords, or scales on the fretboard, and also for some additional highlighting, too. For this to work, the `tuning` parameter must be given, since otherwise no reference point is set.

```typc
#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
  body: {
    fretboard.highlight("E", blue)
    fretboard.highlight("G", orange)
  }
)
```

#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
  body: {
    fretboard.highlight("E", blue)
    fretboard.highlight("G", orange)
  }
)

= Fretboard with Piano-like highlighting

Something that I always found interesting: Highlight natural notes white and flat/sharp notes black, just as it is on a piano. Black note patterns correspond to the pentatonic scale.

```typc
#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
  body: {
    fretboard.highlight("A", white)
    fretboard.highlight("B", white)
    fretboard.highlight("C", white)
    fretboard.highlight("D", white)
    fretboard.highlight("E", white)
    fretboard.highlight("F", white)
    fretboard.highlight("G", white)
    fretboard.highlight("A#", black)
    fretboard.highlight("C#", black)
    fretboard.highlight("D#", black)
    fretboard.highlight("F#", black)
    fretboard.highlight("G#", black)
  }
)
```

#fretboard.draw_fretboard(
  tuning: ("E", "A", "D", "G", "B", "E"), 
  body: {
    fretboard.highlight("A", white)
    fretboard.highlight("B", white)
    fretboard.highlight("C", white)
    fretboard.highlight("D", white)
    fretboard.highlight("E", white)
    fretboard.highlight("F", white)
    fretboard.highlight("G", white)
    fretboard.highlight("A#", black)
    fretboard.highlight("C#", black)
    fretboard.highlight("D#", black)
    fretboard.highlight("F#", black)
    fretboard.highlight("G#", black)
  }
)