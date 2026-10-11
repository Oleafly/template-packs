
/// Small function to mark text italic red and add the prefix "ToDo: ". 
/// 
/// ```example
/// #todo("Add a pagebreak")
/// ```
/// 
/// -> content
#let todo(
  /// Content of the task. -> str | content
  task,
) = [
  #emph(
    text(red)[
      ToDo: #task \
    ],
  )
]

