//
// exercise.main.typ
//
// This is the main file of this exercise set. It includes
// the exercise problems and their solutions from secondary
// files in this same directory. Write your solutions to the
// included problems to the corresponding solution files.
// To generate a PDF file with the exercises and their
// solutions included, compile this main file using Typst.
//
// To compile your document using a command line interface,
// see the instructions on the Typst GitHub page
//
//   https://github.com/typst/typst?tab=readme-ov-file#usage
//
// If you are using the VS Code extension Tinymist Typst to
// write your solutions, see its online documentation
//
//   https://myriad-dreamin.github.io/tinymist/frontend/vscode.html
//
// and more specifically the section on generating PDF files:
//
//   https://myriad-dreamin.github.io/tinymist/frontend/vscode.html#label-Compiling%20PDF
//
// Basically, if you open this main file using VS Code
// with Tinymist Installed, there should be a button for
// exporting a PDF file somewhere in the toolbar.
//
// If you do not yet know how to write in Typst, see the
// Typst tutorial
//
//   https://typst.app/docs/tutorial/
//
// for basic instructions.
//
// NOTE: if you are using Tinymist, you might
// need to pin the main file so that Tinymist does not
// automatically change the compilation target when you
// open different Typst files in the text editor. See
//
//   https://myriad-dreamin.github.io/tinymist/frontend/vscode.html#label-Working%20with%20Multiple-File%20Projects
//
// for how to do this.
//

// Import definitions from the template file, which needs to reside next to
// this file, in the same folder.

#import "template.typ": docsettings, problem, solution, tehtävä, ratkaisu

// Fill in your personal information into the authors.typ file.

#import "authors.typ": authors

#show: docsettings.with(
  authors : authors,
  topic: "COURSE.CODE.HERE",
  mainTitle: "Exercise template",
  problemFiles: (
    "exercise.problem.01.typ",
    "exercise.problem.02.typ",
    "exercise.problem.03.typ",
    "exercise.problem.04.typ",
    "exercise.problem.05.typ",
  ),
  solutionFiles: (
    "exercise.solution.01.typ",
    "exercise.solution.02.typ",
    "exercise.solution.03.typ",
    "exercise.solution.04.typ",
    "exercise.solution.05.typ",
  ),
  bundleExport: false,
  mainDocumentName: "exercise.pdf",
)
