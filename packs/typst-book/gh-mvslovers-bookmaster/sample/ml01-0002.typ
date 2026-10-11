#import "../bookmaster.typ": *

#show: book.with(
  title: "cc370 Cross-Toolchain for MVS 3.8j",
  subtitle: "Command Reference",
  short-title: "cc370 Command Reference",
  number: "ML01-0002-0",
  date: "October 2026",
  authors: ("Mike Großmann",),
  edition: [
    #text(font: head-font, weight: "bold", size: 11pt)[First Edition (October 2026)]

    This edition applies to Version 1 Release 2 of the cc370 cross-toolchain
    (cc370 1.2.0) and to all subsequent releases and modifications until
    otherwise indicated in new editions.

    *This is a sample.* It carries parts of two chapters of the planned book
    so that its style can be judged; the chapters listed under “How This Book
    Is Organized” but not printed here have not yet been written.

    Comments on this book may be addressed to the issue tracker of
    the mvslovers/cc370 repository on GitHub.

    © Copyright Mike Großmann 2026. All rights reserved.
  ],
)

#contents()
#figures()

#heading(numbering: none)[About This Book] <about>

This book describes the commands of the cc370 cross-toolchain: the C
compiler, the assembler, the linkage editor, the archiver and two utilities,
all of which run on a workstation and produce programs for MVS 3.8j. For
each command it gives the syntax, every option, the files it reads and
writes, and its return codes.

How the tools are used together, from the first program to its deployment on
MVS, is the subject of the companion volume, the _cc370 User's Guide_.

== Who Should Use This Book

This book is for programmers who write C or assembler programs for MVS 3.8j
on a macOS or Linux workstation. It assumes that you know the C language,
System/370 assembler language and the basic concepts of MVS: data sets,
partitioned data sets, load modules and job control language.

== How This Book Is Organized

#deflist(width: 1.35in,
  [Chapter 1], [“The cc370 Command” describes the compiler driver.],
  [Chapter 2], [“The as370 Command” describes the assembler.],
  [Chapter 3], [“The ld370 Command” describes the linkage editor and the
    transport formats it writes.],
  [Chapter 4], [“The ar370 Command” describes object libraries.],
  [Chapter 5], [“The file370 Command” describes the inspector.],
  [Chapter 6], [“The xmit370 Command” describes source library transmission.],
  [Appendix A], [“Object Module Format”.],
  [Appendix B], [“Load Module and Transport Formats”.],
  [Appendix C], [“Messages and Return Codes”.],
)

== Related Publications

#deflist(width: 1.35in,
  [ML01-0001], [_cc370 User's Guide_],
  [ML01-0003], [_libc370 Programmer's Guide_],
  [ML01-0004], [_libc370 Library Reference_],
)

== How to Read the Syntax Diagrams

Read the syntax diagrams from left to right, from top to bottom, following
the path of the line.

#deflist(width: 1.35in,
  [#syntax(framed: false, "►►──")], [begins a statement.],
  [#syntax(framed: false, "──►")], [shows that the statement continues on the next line.],
  [#syntax(framed: false, "──►◄")], [ends the statement.],
  [#syntax(framed: false, "├──") #syntax(framed: false, "──┤")], [begin and end a fragment, which is described
    in a diagram of its own.],
)

Items on the main path are required. Items below the main path are
optional. When you can choose from two or more items, they are stacked
vertically. An arrow returning to the left above the main line shows an item
that can be repeated. Keywords and options appear as they are typed; a
variable, for which you supply a value, appears in _italics_.

#mainmatter()
#set page(numbering: "1")

= The cc370 Command <cc>

#idx("cc370")
The cc370 command is the compiler driver. It compiles C source to System/370
assembler language, runs as370 on the result and, unless told to stop
earlier, ld370 on the object modules. This sample shows only what the
compiler produces.

== From C Source to Assembler Source

#idx("cc370", "-S option")
With #cmd("-S"), cc370 stops after compiling and writes the assembler source
to a file named after the C source, with the extension #cmd(".s"). The
program in @upcase-c copies #cmd("SYSIN") to #cmd("SYSPRINT") and folds
each record to upper case; the command

```
cc370 -O1 -S upcase.c
```

writes #cmd("upcase.s"), the beginning of which is shown in @upcase-s.

#fig(caption: [UPCASE, a C program])[
  #code(read("ex/upcase.c"), numbers: true)
] <upcase-c>

Three things in @upcase-s are worth noting:

- String literals become #cmd("DC") statements in EBCDIC. The newline that
  ends the #cmd("fprintf") format is the byte #cmd("X'15'"), the EBCDIC
  newline used throughout the mvslovers ecosystem.
- #cmd("@@MAIN") is a stub that branches to #cmd("@@CRT0"), the start-up
  routine of the C library, which in turn calls #cmd("main").
- Each function begins with the #cmd("PDPPRLG") macro and ends with
  #cmd("PDPEPIL"). The macros come with the toolchain and are found by as370
  as described in @maclib.#idx("PDPPRLG")#idx("PDPEPIL")

#fig(caption: [Assembler source generated for UPCASE (beginning)])[
  #code(read("ex/upcase.s").split("\n").slice(0, 52).join("\n"), numbers: true, size: 7.5pt)
] <upcase-s>

= The as370 Command <asm>

#idx("as370")
The as370 assembler reads System/370 assembler language source on the
workstation and writes an OS/360 object module. It accepts the language of
the OS/VS Assembler XF (IFOX00), which is the assembler of MVS 3.8j, and it
produces the same object module: the external symbol dictionary, the text
and the relocation dictionary are identical, byte for byte, to what IFOX00
writes for the same source.
#idx("IFOX00", "compatibility with")

You do not usually call as370 yourself. The cc370 driver runs it for every C
source it compiles, as described in @cc. You call it directly to
assemble a program written in assembler language, or to obtain a listing.

== What as370 Produces

#idx("object module")
The object module is written as 80-byte card images in EBCDIC: ESD, TXT, RLD
and END records, in the format that the MVS linkage editor reads. It can be
link-edited on the workstation with ld370 (see Chapter 3) or uploaded and
link-edited on MVS with IEWL; both accept it. Appendix A describes the
format.

The one difference from IFOX00 is the translator identification on the END
record, which reads #cmd("ASM370") where IFOX00 writes its own program number. It does not affect the
linkage editor.

On request, as370 also writes an assembler listing (see @listing) and three
tab-separated data files that describe the assembly for other programs (see
@datafiles).

== Invoking as370 <invoke>

#idx("as370", "syntax")
#syntax(read("ex/syn-main.txt"))

#syntax(title: "Option:", read("ex/syn-opt.txt"))

=== Operands

#deflist(
  [#var("source-file")], [is the assembler source to read. It is a host
    file; see @encoding for the character sets as370 accepts.],
  [#cmd("-a")], [writes an assembler listing. The listing always contains
    the source statements. Without #var("sub-options") it also contains the
    external symbol dictionary, the relocation dictionary when the module has
    one, and the cross-reference. Each sub-option is one letter and asks for
    one section:
    #v(0.3em)
    #deflist(width: 0.3in,
      [#cmd("e")], [the external symbol dictionary],
      [#cmd("r")], [the relocation dictionary],
      [#cmd("s")], [the ordinary symbol and literal cross-reference],
    )
    #v(0.3em)
    The sub-options #cmd("g"), #cmd("i"), #cmd("m") and #cmd("x") are
    accepted and have no effect yet. The listing goes to standard output
    unless #cmd("=")#var("file") follows the sub-options; it must be the last
    of them.#idx("listing", "requesting")],
  [#cmd("-I") #var("directory")], [adds #var("directory") to the macro and
    COPY library search. Repeat the option to add several directories; they
    are searched in the order given. See @maclib.],
  [#cmd("-o") #var("object-file")], [names the object module to write. *No
    object module is written when #cmd("-o") is omitted*, which is what you
    want when you need only a listing.],
  [#cmd("--xref=")#var("form")], [selects the form of the cross-reference:
    #cmd("full"), the default, lists every symbol, as IFOX00 does for
    #cmd("XREF(FULL)")\; #cmd("short") leaves out the symbols that nothing
    references, as #cmd("XREF(SHORT)") does.],
  [#cmd("--sym="), #cmd("--stmts="), #cmd("--usings=")], [write the symbol
    table, the generated statements, or the #cmd("USING") and #cmd("DROP")
    events to #var("file"). See @datafiles.],
  [#cmd("--help")], [displays a summary of the options and ends.],
  [#cmd("-v"), #cmd("--version")], [displays the toolchain version and the
    commit from which as370 was built, for example
    #cmd("as370 1.2.0 (b17cd14)"), and ends.],
)

== Macro and COPY Libraries <maclib>

#idx("macro library", "search order")
#idx("COPY")
A macro instruction that is not defined in the source, and every #cmd("COPY")
statement, is resolved from a library. On the workstation a library is a
directory, and each of its members is a file. as370 searches these
directories, highest priority first:

+ the directories named by #cmd("-I"), in the order given;
+ the directories named by the environment variable #cmd("AS370_MACLIB"),
  separated by colons;#idx("AS370_MACLIB")
+ #cmd("../macros") relative to the directory that holds the as370 program;
+ #cmd("../libc370/macros") relative to the same directory.

The last two are the macro libraries of the installed toolchain, so an
installed as370 assembles a program that uses the libc370 and system macros
with no #cmd("-I") and no environment variable.

Within a directory, as370 looks for the member name as written and then, if
it contains capitals, in lowercase. For each spelling it tries the
extensions #cmd(".macro"), #cmd(".copy"), #cmd(".mac") and #cmd(".asm"), and
finally the name with no extension. The macro #cmd("SAVE") is therefore found
as #cmd("SAVE.macro"), #cmd("save.mac") or simply #cmd("SAVE").

#note[A directory that does not exist is not an error. It is skipped, so a
misspelled #cmd("-I") shows itself only as an undefined operation code.]

== Source Encoding <encoding>

#idx("character set", "of the source")
IFOX00 reads EBCDIC, one byte to a character, and column 72 marks a
continuation. as370 reads a host file and keeps that rule by deciding the
encoding of each file, source or library member, by itself:

- A file that is valid UTF-8 and contains a character above #cmd("X'7F'") is
  read as UTF-8, one character to a column. A leading byte order mark is
  ignored.
- Any other file is read one byte to a character, as Latin-1. Many existing
  macros are Latin-1: their #cmd("¬") is the byte #cmd("X'AC'").

Every character is then translated from Latin-1 to EBCDIC code page 037. A
character above U+00FF has no image in code page 037: as370 reads it as
#cmd("X'3F'"), flags its statement with severity 4, and with severity 8 if
the character reaches the object module.

== The Assembler Listing <listing>

#idx("listing", "format")
The listing follows the IFOX00 listing column for column, so that a listing
from as370 can be compared with one printed on MVS. @hello-lst shows the
listing of a six-statement program, produced by the following command:

```
as370 -a=hello.lst -o hello.o hello.asm
```

#fig(caption: [Assembler listing of HELLO])[
  #set par(justify: false, leading: 0.32em)
  #text(font: mono-font, size: 6.1pt,
    read("ex/hello.lst").replace("\f", "").split("\n").map(l => l.trim(at: end)).join("\n"))
] <hello-lst>


The listing has one page for each section. The headings are those of
IFOX00; #cmd("ASM370 0100") in the top right-hand corner takes the place of
the IFOX00 release level, followed by the time and date of the assembly.
The diagnostics and statistics pages of IFOX00 are not produced; messages
are written to standard error instead.

== Data Files for Other Programs <datafiles>

#idx("data files")
Three options write a description of the assembly as tab-separated text, one
record to a line, for programs that compare or analyse object modules. A
file name of #cmd("-") writes to standard output.

#deflist(width: 1.1in,
  [#cmd("--sym=")], [The symbol table.],
  [#cmd("--stmts=")], [One record for each generated statement: where it
    is placed, how many bytes it produces, whether it reserves storage or
    only aligns, and which macro call generated it. An object module cannot
    show the difference between #cmd("DS 0F") and #cmd("DS CL1")\; this file
    can.],
  [#cmd("--usings=")], [One record for each #cmd("USING"), #cmd("DROP"),
    #cmd("PUSH") and #cmd("POP") event and base register, each with its
    section and location counter.],
)

== Return Codes <rc>

#idx("as370", "return codes")#idx("return codes")
as370 ends with the highest severity of the messages it issued, using the
convention of IFOX00. @rc-tab lists the values.

#tab(caption: [as370 return codes])[
  #table(columns: (0.9in, 1fr),
    [Code], [Meaning],
    [0], [The assembly completed without messages.],
    [4], [Warnings only. The object module is complete.],
    [8], [Errors. At least one statement could not be assembled as
      written, for example an undefined operation code. The object module is
      written, but it is not expected to run.],
    [12], [Severe errors.],
    [16], [Terminal error. A file could not be opened or written; the
      assembly was not completed.],
  )
] <rc-tab>

A statement in error is shown on standard error with its line number, as in
@session.

== Example

@session shows a session that assembles the program of @hello-lst, examines
the object module with file370, and then assembles a source with an
undefined operation code.

#fig(caption: [Assembling and inspecting a program])[
  #screen(```
$ as370 -o hello.o hello.asm
$ echo $?
0
$ file370 -v hello.o
hello.o: OS/360 object deck -- 1 section(s) (first HELLO), 14B text
    3 card(s) of 80 bytes; 0 LD entr(y/ies)
    ESD    1  HELLO     SD  addr=000000  len=00000E
    END  entry at offset 000000
$ as370 -o bad.o bad.asm
   FOO 1,2
 ERROR: Undefined operation code in line 2 - FOO
 Assembler Done   1 Statement Flagged /   8 was Highest Severity
$ echo $?
8
```)
] <session>

#heading(numbering: none)[Index]
#make-index()
