#import "../settings/wi-thesis.typ": *

= Introduction <ch01:intro>

Welcome! The purpose of this document is to outline the guidelines for creating
and formatting seminar papers, as well as Bachelor and Master theses. It will be
explained which general formatting rules should be applied for any written
submission and how the provided Typst template can help produce a well formatted
piece of work. Throughout the document, a number of examples will illustrate the
structure of an academic work and at the same time show how the template can be
used. Note, though, that there are so many aspects of writing a good paper and
producing a good-looking result that it is impossible to cover all of them in
this guide. For further references on what we expect from seminar participants
please consult our Guide to Seminars.

This template consists of a `main_thesis.typ`-file in which all relevant parts
are defined. In the `code` folder, you can include files of algorithms and code
blocks that are part of the thesis. In the `content` folder, you can include all
relevant chapters as single `.typ`-files. In the `figures` folder---as the name
already suggests---you can include images and graphics. We advise you to not
edit the `settings` folder. If you need any additional definitions which are not
part of this template, you can add them in `main_thesis.typ` before the
`#show` rule.

You are free to use any Typst environment. Some people prefer local
installations and editors under their own control, for instance the Typst
CLI#footnote[https://github.com/typst/typst] together with the Tinymist
extension for Visual Studio Code, while others prefer the hosted Typst web
app#footnote[https://typst.app]---due to zero-installation, automated storage,
nice user experience, and easy collaboration options. Nevertheless, as usual,
gratis hosted solutions come with disadvantages (loss of control and privacy,
dependence on a third party). We advise you to carefully read the privacy notice
of any hosted service before using it. As an example of typical data collection
practices, consider this excerpt from the privacy notice of Overleaf, a
comparable hosted service for LaTeX:

#quote[
  When you use Overleaf, we may collect information about that usage and other
  technical information, such as your IP address, browser type and any referring
  website addresses. We may combine this automatically collected log information
  with other information we collect about you and use it to keep a record of our
  interaction and to enable us to support, personalise and improve
  Overleaf. @overleafprivacy
]

In contrast to LaTeX, the Typst compiler warns on-the-fly in case of typical
beginners' errors, with error messages that point directly at the offending
position in the source file.

In case of working outside the web app, installing this template is easy. Simply
unzip the contents into the folder where your document resides and compile it
with `typst compile main_thesis.typ` (or keep a preview up to date with
`typst watch main_thesis.typ`). All required functionality is part of the
template itself; no additional packages have to be installed.

A frequently asked question is that of length. While we recommend you talk to
your supervisor about your specific case, some general remarks can be made here.
A Bachelor thesis is supposed to have "approximately 40 pages" according to the
Examination Rules (PO Bachelor WI 2010). For Master theses, it is much more
difficult to specify a number of pages due to variations in the assigned topics.
Typically, however, a length of about 80 pages seems appropriate. Seminar papers
ought to be about 15 pages in length and never exceed 20 pages.
