#import "../slide.typ": jump, meanwhile, pause, setup, theme
#import "utils.typ": *

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    // sidebar-ring-style: 2,
    // handout: true,
)

= Overview

== Goals

#feature-table(
    [Frame],
    [Cover, SDU logo, page frame, right sidebar, and decorative ring.],
    [Writing],
    [Use ordinary Typst headings, lists, tables, math, code, and images.],
    [Navigation],
    [Level 1 and level 2 headings form the clickable sidebar outline.],
    [Overlays],
    [`#pause`, `#meanwhile`, and `#jump` provide incremental reveals.],
)

#note-box[Outline rule][
    Keep level 1 headings for chapters and level 2 headings for real slides. Level 3 headings start slides too, but they do not enter the sidebar.
]

== Heading Model

- `= Chapter` creates a major sidebar group.
- `== Slide` creates a sidebar item and is highlighted while active.
- `=== Focus` starts a slide without adding a sidebar item.

=== Level 3 Focus Slide

This slide is created by a level 3 heading. It is useful for a definition, interlude, or emphasis page that should not make the sidebar longer.

= Template

== Minimal Deck

```typ
#import "slide.typ": setup, pause, meanwhile, jump, theme

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    sidebar-ring-style: 2,
    handout: false,
)

= Chapter
== Slide Title

Write slide content here.
```

== Theme & Sidebar

#feature-table(
    [`theme.colors.primary`],
    [Main SDU red used for frame, highlights, and active sidebar rows.],
    [`theme.colors.primary-muted`],
    [Quiet fill used by the sidebar and example tables.],
    [`theme.page.sidebar-width`],
    [Width reserved for the right sidebar.],
    [`sidebar-ring-style: 2`],
    [Final ring layering: active row above the ring, normal fills below it.],
)

#note-box[Helpers][
    `template/utils.typ` contains small example helpers such as `#note-box`, `#feature-table`, `#keydown`, and `#linkto`. They are not required by the core theme.
]

= Overlays

== Reveal Flow

`#pause` advances to the next overlay.

Always visible.

#pause

Visible on overlay 2.

#pause

Visible on overlay 3.

== Parallel Flow

`#meanwhile` restarts following content at overlay 1, which is useful for two independent stories.

#grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    align: (left, left),
    [
        #text(fill: primary, weight: "bold")[Kernel path]

        Interrupt handler runs.

        #pause

        Scheduler chooses the next task.
    ],
    [
        #meanwhile

        #text(fill: primary, weight: "bold")[Device path]

        Device reports completion.

        #pause

        Blocked process returns to ready queue.
    ],
)

= Examples

== OS Concept Slide

#feature-table(
    [Process],
    [An executing program with its own address space and resource ownership.],
    [Thread],
    [A schedulable control flow that shares most process resources.],
    [Context switch],
    [Saving one execution context and restoring another.],
    [Interrupt],
    [An asynchronous event that transfers control to the kernel.],
)

Average turnaround time:
$ T_"avg" = (1 / n) sum_(i=1)^n (C_i - A_i) $

== Scheduling Table

#table(
    columns: (1.2fr, 1fr, 1.2fr, 1.7fr),
    stroke: none,
    inset: (x: 0.5em, y: 0.35em),
    fill: (_, row) => if row == 0 { colors.primary-soft } else { colors.primary-muted },
    row-gutter: 0.1em,
    column-gutter: 0.1em,
    align: (left, center, center, left),
    table.header(
        text(fill: white, weight: "bold")[Policy],
        text(fill: white, weight: "bold")[Preemptive],
        text(fill: white, weight: "bold")[Good at],
        text(fill: white, weight: "bold")[Watch out for],
    ),
    [FCFS], [No], [Throughput], [Convoy effect],
    [SJF], [No], [Average waiting time], [Needs burst prediction],
    [SRTF], [Yes], [Short jobs], [Starvation risk],
    [RR], [Yes], [Responsiveness], [Quantum tuning],
)

== Code and Assets

```typ
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#diagram(cell-size: 15mm, $
	G edge(f, ->) edge("d", pi, ->>) & im(f) \
	G slash ker(f) edge("ur", tilde(f), "hook-->")
$)
```

Press #keydown("Ctrl") + #keydown("S") to save, then compile:

```bash
typst compile --root . template/template.typ template/typst-sdu-os-slide.pdf
```

Useful links: Typst #linkto("https://typst.app/docs/"), CeTZ #linkto("https://github.com/johannes-wolf/cetz"), Touying #linkto("https://github.com/touying-typ/touying").

#align(center, image("../assets/sducs.png", width: 6.8cm))
