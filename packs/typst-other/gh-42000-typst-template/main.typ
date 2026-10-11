#import "assets/preamble.typ": *
#import "assets/preamble.typ": cea_table as table

#set text(font: ("DejaVu Sans"), size: 10pt)

// Variable globales du document
#let _title = "Sample Title"
#let _subtitle = "Sample subtitle"
#let _author = "Tim SICARD"
#show "TBD" : it => { tbd[#it] }

#page_garde(
  _title: _title,
  _subtitle: _subtitle,
  author: _author,

  logo_l: image("assets/KUL.png", width: 13em),
  logo_r: image("assets/cesi.jpg", width: 10em),
  text_l : [
    #_author\
    CEA/DRF/Irfu/DIS/LEI
  ],
  text_r: [
    JELASSI Sana\
    CESI/FISA S3E\
  ],
  distribution_header: true,
  distribution_limited: false,
  distribution_txt_limited : [Limited],
  distribution_txt_open : [Open access],
)
#show: cea-theme.with(
  // put those in boxes else treesitter is acting weird
  title: [#_title],
  author: [#_author],
  outline_title: "Table of contents",
  footer_txt: "Document author: ",

  list_tables: true,
  list_figs: true,
  list_code: true,
  list_tables_name: "List of tables",
  list_figs_name: "List of figures",
  list_code_name: "Table of listing",

  logo_l: image("assets/KUL.png", height: 60%),
  logo_r: [],
  color_rule: rgb("#00a0ff"),
)

//================ EVERYTHING FROM HERE CAN BE REMOVED
#heading(numbering: none)[Summary]

This is an example header

= Section Example <ex_ref>

Here is an example section

== Subsection

Subsection stuff with ref @ex_ref

bullet list :
- lol
- ok

ordered list :
+ lol
+ ok

inline code : ```bash sudo rm -rf --no-preserve-root /```\
les listings marchent, en mode swag
#listing(caption: [lol])[
```python
import os

# Extract multiple sets of frames
def multi_extract(
  directory : str
) -> tuple[ArrayLike, ArrayLike]:
  """Function to extract all fits files in different folders under a directory.

  Args:
  directory (str): path of the directory

  Returns:
  tuple[ArrayLike, ArrayLike]: returns a list of all the sets of frames and headers.
  """
  set_frames = []
  set_headers = []
  path_names = glob.glob(f"{directory}/*")
  for path in path_names:
    if path.endswith("ms"):
      frames, headers = extract(path)
      set_frames.append(frames)
      set_headers.append(headers)
  return set_frames, set_headers
```
]
// I need to fix this
#listing(caption: [importing from file])[#raw(read("assets/example_script.py"),lang:"python")]
#figure(
  image("assets/KUL.png"),
  caption: [figure example]
)
This will get reference at the end
#note[an author's note example]
#warning[A big scary warning !!]
#table(
  columns : (auto, 1fr, auto),
  caption: [table example],
  [column],[ok],[again?],
  [ok],[lol],[ok],
  [ok],[test test test],[ok],
  [ok],[lol],[ok],
  [ok],[lol],[ok],
  label: <tableref>
)
Referencing @tableref
