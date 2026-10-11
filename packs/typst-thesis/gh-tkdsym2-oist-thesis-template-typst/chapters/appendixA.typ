#import "../oist_thesis.typ": appendix, custom_figure

// The letter passed to #appendix() drives the numbering of everything inside:
// sections become A.1, A.1.1, ... and figures/tables become Figure A.1,
// Table A.1, ... The counters restart at 1 for each appendix, so all figures
// and tables of this appendix must live inside this block.
#appendix("A")[
#heading(level: 1, numbering: none, "Appendix A: First Appendix") <appendix-a>

This is the first appendix. Unlike a numbered chapter, its level-1 heading
carries `numbering: none`, so no "Chapter N" prefix is printed.

== A Section Inside an Appendix

Sections inside an appendix are numbered with the appendix letter instead of
the chapter number — this one is Section A.1, and the next would be A.2.

#custom_figure(
  image("../images/chap3/symbol.jpg", width: 40%),
  short: [Appendix figure.],
  caption: [Figures inside an appendix are numbered with the appendix letter,
    so this is Figure A.1 rather than a continuation of the chapter numbering.],
) <fig-appendix-a>

Cross-references work as usual: see @fig-appendix-a.
]
