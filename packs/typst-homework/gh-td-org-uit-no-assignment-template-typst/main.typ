#import "template.typ": *
#show: template.with(
  title: [Assignment template],
  abstract: [
    This document presents a number of guidelines to use when writing a report for assignments at UiT and may serve as a template for how to write it using Typst for typesetting. The template is meant to give some general tips on what you should and should not be writing in your report. You may move or cut sections and/or subsections depending on the given assignment or your needs.

    While writing this report template, I enjoyed reading Michael Alley's "The Craft of Scientific Writing". I recommend having it by your side when you are stuck writing- it happens to all of us @AlleyMichael2018TCoS.

    #v(9pt)

    Make sure you clean up the template text before submitting your report. ;)

    #v(9pt)
  ],
  header: [INF-XXXX Assignment X #datetime.today().display()],
  authors: (
    (
      name: "Firstname Middlename(s) Lastname",
      organization: [UiT Arctic University of Norway],
      location: [Tromsø, Norway],
      email: "abc123@uit.no",
      git: "abc",
    ),
    (
      name: "Firstname Middlename(s) Lastname",
      organization: [UiT Arctic University of Norway],
      location: [Tromsø, Norway],
      email: "def456@uit.no",
      git: "def",
    ),
  ),
  index-terms: (
    "Assignment submission",
    "Scientific writing",
    "Typesetting",
    "Template",
  ),
  bibliography-file: "refs.bib",
)

= Introduction <sec:introduction>

This section should be brief. Describe the assignment and the requirements in your own words. Avoid listing the requirements directly.

There are many opinions on first person speaking when writing a technical report. In general a:

+ First person report is good at:
  - Expressing individual work, personal opinions and ideas.
  - Creates an informal and personal tone.
  - Reduces cluttering of your writing
+ An objective report is good at:
  - Emphasizing your work

It's not uncommon to mix these in your reports, and people like Einstein, Feynman, and Curie frequently used both forms in their texts.

#v(9pt)

Here are some examples on how to start your introduction:

+ This report describes the design and implementation of a list ADT using a linked
  list. It will go into detail about the design choices made, and discuss benefits
  and tradeoffs of those choices.
+ Boids is a computer model created by Craig Reynolds that simulates the flocking behavior of birds @TanenbaumAndrewS.2024Mos. In this report, we present an implementation of the model using the Python programming language.
+ SQL is a widely used querying language used to process queries into table-based databases. This text details the implementation of a simplified server that implements a subset of the SQL language built over SQLite.


== Outline <subsec:outline>

The rest of this paper is organized as follows:

*@sec:technical_background* outlines concepts and background information relevant to the rest of the paper.

*@sec:design* is a high-level description of your solution to the assignment.

*@sec:implementation* goes into a detailed explanation of your implementation that you described in Section *@sec:design*.

*@sec:experiments_and_results* discusses the methodology for your experiments and includes results from your experiments.

*@sec:discussion* is the most important section in a report; this is where you show that you understand the theory behind your solution and can reflect on it with the choices you made.

*@sec:conclusion* concludes and summarizing possible future work.

= Theoretical Background <sec:technical_background>

This section is where you provide information on the technical aspects of your design. You can usually assume that the theory required to solve the assignment is know to the reader, but if you want to clarify terms or go into detail about specific points in the theory (if you are doing something slightly different, or a detail of it is of notable importance to your implementation), consider writing a few words about it here.

#v(9pt)

We want you to write a short section explaining the most important background information required to read and understand the rest of the report.

#v(12pt)

== Virtual Memory <subsec:virtualmemory>

The basic concept of virtual memory is that you map the virtual address the processes use to a unique physical address in physical memory. This means that two processes can access the same virtual address in their address space but get two different results since the addresses point to different places in the physical memory. This again means that each process can use all of its 32-bit address space while still ensuring that no other processes can access its data @TanenbaumAndrewS.2024Mos.

#v(9pt)

Using figures in technical backgrounds is encouraged, if that makes the concept easier to explain. Usually, you want figures/images as scaleable vector graphics\(SVG), especially for your graphs. Sometimes that is not doable, and you can use portable network graphics\(PNG) or similar.

#v(9pt)

The following snippet shows how to import figures.

#v(9pt)

#figure(
  image("figures/jetson_nx.png", width: 90%),
  caption: [Block diagram of the Jetson Xavier NX],
) <fig:block_diagram>

#figure(
  image("figures/NVSD_VDD_IN.svg", width: 90%),
  caption: [Total power consumption compared between NAS and SD-Card. / _Note_ the NAS-experiment did not complete in time, and the measurements for the NAS is fit to the SD-card measurements],
) <fig:local_nas_sd_compare>

= Design <sec:design>

This is where you describe how you solved the assignment, at least on paper. Give a high-level view of your design.This is where you describe how you solved the assignment, at least on paper. Give a high-level view of your design.
As a rule of thumb, if you find yourself describing code, you need to go to a higher abstraction level. If you for some reson want to write code you can use the `raw` block as seen in the following example.

```c
/* Simple copy from src to dest */
char *strcpy(char *restrict dest,
		const char *restrict src)
{
    char *destorig = dest;
    for (;; dest++, src++) {
		char copiedchar = *dest = *src;
		if (!copiedchar) break;
    }
	printf("Strings are green\n");
    return destorig;
}
```

#v(12pt)

This section is also a good place to put illustrations to enhance the text. There are multiple tools out there to create good illustrations.
draw.io is a strong tool that can be run in a browser. There are stronger, free tools, such as Yed Graph Editor, for more advanced users.

#v(12pt)

While illustrations are good at making your report clearer and look more polished, avoid using them to fill up space if you can convey the same information clearly using just text.

#v(12pt)

Examples of what the design section should cover:

- The interface of the list ADT supports six methods. These are ```c create_list()```, ```c destroy_list()```, ```c add_list()```, ```c remove_list()```, ```c iterate_list()``` and ```c sort_list()```. When a list is created, it is provided with a comparator method that is used to handle sorting.

- The Boids simulation consists of a set of entities called Boids, Each boid moves independently according to a set of criteria, specified in three rules. Firstly, boids avoid crashing into obstacles, including other boids. Secondly, boids attempt to maintain the same speed and heading as nearby boids. Finally, all boids attempt to move closer to each other to form a cohesive flock.

- The server parses incoming data requests into an SQL query and runs them on its database. The result is then processed into JSON and returned to the client.

#v(12pt)

Remember to avoid low-level details! An expert should in theory be able to implement your design in any programming language based on what you write in this section.

= Implementation <sec:implementation>

This is where you go into detail about your specific implementation. Questions you should answer here are things such as ``How does your implementation match your design?'' and ``Are there any bugs, and do you have any ideas about what may be causing them?''. What sort of difficulties did you experience when working, and how did you overcome them? If you found a clever solution to the problem, this is also the place to write about that.

== Technical Details <subsec:technical_details>

You may want to include a short section giving high-level details about your implementation, such as the programming language used and other information you find relevant for your report. In most cases however, this section is unnecessary, as the assignment usually decides those details for you. Even if you have the freedom of choice, consider whether this information is really relevant to the report, which should avoid low-level implementation details most of the time.

= Experiments and Results <sec:experiments_and_results>

A core pillar of computer science is testing. In this section, you should include your methodology for testing your implementation. How do you know your implementation meets the requirements? What sort of performance metrics have you chosen to benchmark your solution, and how did you go about performing tests to gather those metrics?

#v(12pt)

You should present the results of your tests here, either using an illustration and/or a table of results. These will be valuable in the discussion section. The following is an example for how to format a table of results in Typst.

#v(12pt)

#figure(
  table(
    columns: 7,
    align: center + horizon,
    /* --- header --- */
    table.header(
      table.cell([*Classifier*], rowspan: 2),
      table.cell([*Precision*], colspan: 6),
      [1],
      [2],
      [3],
      [1&2],
      [1&3],
      [All],
    ),
    /* -------------- */
    /* --- body --- */
    [Perceptron],
    [0.78],
    [0.82],
    [0.24],
    [0.81],
    [0.77],
    [0.83],
    [Decision Tree],
    [0.65],
    [0.79],
    [0.56],
    [0.75],
    [0.65],
    [0.73],
    [One-Class SVM],
    [0.74],
    [0.72],
    [0.50],
    [0.80],
    [0.73],
    [0.85],
    [Isolation Forest],
    [0.54],
    [0.51],
    [0.52],
    [0.53],
    [0.54],
    [0.53],
    /* -------------- */
  ),
  caption: [Precision results of classifiers for different feature sets],
)

= Discussion <sec:discussion>

The discussion section is the most important section in a report, This is where you show that you understand the theory behind the solution, and also a chance to argue the pros and cons of your solution. You should discuss about the results of your measurements and why you think they are the way they are. Also bring up tradeoffs, and why you made the choices you did; show that you understand the alternatives, and why they may be a good idea (or not) for the particular problem the assignment asked you to solve.

#v(12pt)

Here is an example of a discussion subsection:

== Recovery of a simulated crash <subsec:recovery_simulated_crash>

When a node recovers from a simulated crash, it will check if its neighbors are still connected to it. If not, it will try to start an internal join to its previous successor. This works as long as the previous successor is still active in the network. The case where the previous successor is not active is not dealt with, and will result in the node not being able to recover.

= Conclusion <sec:conclusion>

Here you sum up the report and reiterate the results. Does not need to be very long, a few sentences is fine.
