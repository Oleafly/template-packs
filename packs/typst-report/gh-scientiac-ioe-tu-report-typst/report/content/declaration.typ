#import "../lib/lib.typ": project-meta

= Declaration

#context {
  let meta = project-meta.get()
  
  [
    We declare that the work hereby submitted for the degree of Bachelor's in #meta.faculty Engineering at the Institute of Engineering, #meta.campus entitled *"#upper(meta.title)"* is our own work and has not been previously submitted to any university for any academic award.

    We authorize the Institute of Engineering, #meta.campus to lend this report to other institutions or individuals for the purpose of scholarly research.

    \
  ]

  for member in meta.by [
    *#member* \
  ]

  [
    \
    #meta.date
  ]
}
