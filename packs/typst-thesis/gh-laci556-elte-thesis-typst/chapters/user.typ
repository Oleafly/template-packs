= Felhasználói dokumentáció <ch:user>

Lorem ipsum dolor sit amet $NN$, consectetur adipiscing elit. Duis nibh leo, dapibus in elementum nec, aliquet id sem. Suspendisse potenti. Nullam sit amet consectetur nibh. Donec scelerisque varius turpis at tincidunt. Cras a diam in mauris viverra vehicula. Vivamus mi odio, fermentum vel arcu efficitur, lacinia viverra nibh. Aliquam aliquam ante mi, vel pretium arcu dapibus eu. Nulla finibus ante vel arcu tincidunt, ut consectetur ligula finibus. Mauris mollis lectus sed ipsum bibendum, ac ultrices erat dictum. Suspendisse faucibus euismod lacinia $ZZ$.
// TODO: nomenclature?

== Felsorolások

Etiam vel odio ante. Etiam pulvinar nibh quis massa auctor congue. Pellentesque quis odio vitae sapien molestie vestibulum sit amet et quam. Pellentesque vel dui eget enim hendrerit finibus at sit amet libero. Quisque sollicitudin ultrices enim, nec porta magna imperdiet vitae. Cras condimentum nunc dui, eget molestie nunc accumsan vel.

- Fusce in aliquet neque, in pretium sem.
- Donec tincidunt tellus id lectus pretium fringilla.
- Nunc faucibus, erat pretium tempus tempor, tortor mi fringilla neque, ac congue ex dui vitae mauris.

Donec dapibus sodales ante, at scelerisque nunc laoreet sit amet. Mauris porttitor tincidunt neque, vel ullamcorper neque pulvinar et. Integer eu lorem euismod, faucibus lectus sed, accumsan felis. Nunc ornare mi at augue vulputate, eu venenatis magna mollis. Nunc sed posuere dui, et varius nulla. Sed mollis nibh augue, eget scelerisque eros ornare nec.

+ Donec pretium et quam a cursus. Ut sollicitudin tempus urna et mollis.
+ Aliquam et aliquam turpis, sed fermentum mauris. Nulla eget ex diam.
+ Donec eget tellus pharetra, semper neque eget, rutrum diam 1. lépés. // TODO: list reference?

Praesent porta, metus eget eleifend consequat, eros ligula eleifend ex, a pellentesque mi est vitae urna. Vivamus turpis nunc, iaculis non leo eget, mattis vulputate tellus. Maecenas rutrum eros sem, pharetra interdum nulla porttitor sit amet. In vitae viverra ante. Maecenas sit amet placerat orci, sed tincidunt velit. Vivamus mattis, enim vel suscipit elementum, quam odio venenatis elit #footnote[Phasellus faucibus varius purus, nec tristique enim porta vitae.], et mollis nulla nunc a risus. Praesent purus magna, tristique sed lacus sit amet, convallis malesuada magna.
// TODO: per-page footnote numbering

/ Vestibulum venenatis: malesuada enim, ac auctor erat vestibulum et. Phasellus id purus a leo suscipit accumsan.
/ Orci varius natoque: penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam interdum rhoncus nisl, vel pharetra arcu euismod sagittis. Vestibulum ac turpis auctor, viverra turpis at, tempus tellus.
/ Morbi dignissim: erat ut rutrum aliquet. Nulla eu rutrum urna. Integer non urna at mauris scelerisque rutrum sed non turpis.

=== Szoros térközű felsorolások

Phasellus ultricies, sapien sit amet ultricies placerat, velit purus viverra ligula, id consequat ipsum odio imperdiet enim:

+ Maecenas eget lobortis leo.
+ Donec eget libero enim.
+ In eu eros a eros lacinia maximus ullamcorper eget augue.

// \bigskip
#v(12pt)

In quis turpis metus. Proin maximus nibh et massa eleifend, a feugiat augue porta. Sed eget est purus. Duis in placerat leo. Donec pharetra eros nec enim convallis:

- Pellentesque odio lacus.
- Maximus ut nisl auctor.
- Sagittis vulputate lorem.

// \bigskip
#v(12pt)

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed lorem libero, dignissim vitae gravida a, ornare vitae est.

/ Cras maximus: massa commodo pellentesque viverra.
/ Morbi sit: amet ante risus. Aliquam nec sollicitudin mauris
/ Ut aliquam rhoncus sapien: luctus viverra arcu iaculis posuere

== Képek, ábrák

Aliquam vehicula luctus mi a pretium. Nulla quam neque, maximus nec velit in, aliquam mollis tortor. Aliquam erat volutpat. Curabitur vitae laoreet turpis. Integer id diam ligula. Nulla sodales purus id mi consequat, eu venenatis odio pharetra. Cras a arcu quam. Suspendisse augue risus, pulvinar a turpis et, commodo aliquet turpis. Nulla aliquam scelerisque mi eget pharetra. Mauris sed posuere elit, ac lobortis metus. Proin lacinia sit amet diam sed auctor. Nam viverra orci id sapien sollicitudin, a aliquam lacus suscipit, @fig:example-1:

#figure(
  image("../images/elte_cimer_szines.svg", width: 60%, height: 100pt, fit: "stretch"),
  caption: "Quisque ac tincidunt leo",
) <fig:example-1>

=== Képek szegélyezése

Ut aliquet nec neque eget fermentum. Cras volutpat tellus sed placerat elementum. Quisque neque dui, consectetur nec finibus eget, blandit id purus. Nam eget ipsum non nunc placerat interdum.

#figure(
  rect(inset: 0pt, stroke: 0.5pt)[
    #image(
      "../images/elte_cimer_szines.svg",
      width: 60%,
      height: 100pt,
      fit: "stretch",
    )],
  caption: "Quisque ac tincidunt leo",
)


=== Képek csoportosítása

In non ipsum fermentum urna feugiat rutrum a at odio. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla tincidunt mattis nisl id suscipit. Sed bibendum ac felis sed volutpat. Nam pharetra nisi nec facilisis faucibus. Aenean tristique nec libero non commodo. Nulla egestas laoreet tempus. Nunc eu aliquet nulla, quis vehicula dui. Proin ac risus sodales, gravida nisi vitae, efficitur neque, @fig:example-2:

#figure(
  {
    set figure.caption(separator: " ")

    stack(
      block(
        figure(
          image("../images/elte_cimer_szines.svg"),
          caption: "Vestibulum quis mattis urna",
          supplement: "(a)",
          outlined: false,
          numbering: none,
        ),
        width: 45%,
      ),
      block(
        figure(
          image("../images/elte_cimer_szines.svg"),
          caption: "Donec hendrerit quis dui sit amet venenatis",
          supplement: "(b)",
          outlined: false,
          numbering: none,
        ),
        width: 45%,
      ),
      dir: ltr,
      spacing: 1fr,
    )
  },
  caption: "Aenean porttitor mi volutpat massa gravida",
) <fig:example-2>

Nam et nunc eget elit tincidunt sollicitudin. Quisque ligula ipsum, tempor vitae tortor ut, commodo rhoncus diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus vehicula quam dui, eu convallis metus porta ac.


== Táblázatok

Nam magna ex, euismod nec interdum sed, sagittis nec leo. Nam blandit massa bibendum mattis tristique. Phasellus tortor ligula, sodales a consectetur vitae, placerat vitae dolor. Aenean consequat in quam ac mollis.

#figure(
  table(
    columns: (5fr, 13fr),
    table.header([*Phasellus tortor*], [*Aenean consequat*]),
    [_Sed malesuada_], [Aliquam aliquam velit in convallis ultrices.],
    [_Purus sagittis_], [Quisque lobortis eros vitae urna lacinia euismod.],
    [_Pellentesque_],
    [Curabitur ac lacus pellentesque, eleifend sem ut, placerat enim. Ut auctor tempor odio ut dapibus.],
  ),
  caption: "Maecenas tincidunt non justo quis accumsan",
) <tab:example-1>


=== Sorok és oszlopok egyesítése

Mauris a dapibus lectus. Vestibulum commodo nibh ante, ut maximus magna eleifend vel. Integer vehicula elit non lacus lacinia, vitae porttitor dolor ultrices. Vivamus gravida faucibus efficitur. Ut non erat quis arcu vehicula lacinia. Nulla felis mauris, laoreet sed malesuada in, euismod et lacus. Aenean at finibus ipsum. Pellentesque dignissim elit sit amet lacus congue vulputate.

#figure(
  table(
    columns: 7,
    row-gutter: (0pt, 3pt, 0pt),
    align: right + horizon,
    table.header(
      table.cell([*Quisque*], rowspan: 2, align: center),
      table.cell([*Suspendisse*], colspan: 2, align: center),
      table.cell([*Aliquam*], colspan: 2, align: center),
      table.cell([*Vivamus*], colspan: 2, align: center),
      [Proin], [Nunc], [Proin], [Nunc], [Proin], [Nunc],
    ),
    table.cell([Leo], align: center), [2,80 MB], [100%], [232 KB], [8,09%], [248 KB], [8,64%],
    table.cell([Vel], align: center), [9,60 MB], [100%], [564 KB], [5,74%], [292 KB], [2,97%],
    table.cell([Auge], align: center), [78,2 MB], [100%], [52,3 MB], [66,88%], [3,22 MB], [4,12%],
  ),
  caption: "Vivamus ac arcu fringilla, fermentum neque sed, interdum erat. Mauris bibendum mauris vitae enim mollis, et eleifend turpis aliquet.",
) <tab:example-2>
// TODO: separate caption for outline

=== Több oldalra átnyúló táblázatok

Nunc porta placerat leo, sit amet porttitor dui porta molestie. Aliquam at fermentum mi. Maecenas vitae lorem at leo tincidunt volutpat at nec tortor. Vivamus semper lacus eu diam laoreet congue. Vivamus in ipsum risus. Nulla ullamcorper finibus mauris non aliquet. Vivamus elementum rhoncus ex ut porttitor.

#[
  #show figure: set block(breakable: true)
  #figure(
    table(
      columns: 2,
      row-gutter: (0pt, 3pt, 0pt),
      table.header(
        table.cell([*Praesent aliquam mauris enim*], colspan: 2),
        [_Suspendisse potenti_], [_Lorem ipsum dolor sit amet_],
      ),

      [_Praesent_],
      [Nulla ultrices et libero sit amet fringilla. Nunc scelerisque ante tempus sapien placerat convallis.],

      [_Luctus_],
      [Integer hendrerit erat massa, non hendrerit risus convallis at. Curabitur ultrices, justo in imperdiet condimentum, neque tortor luctus enim, luctus posuere massa erat vitae nibh.],

      [_Egestas_],
      [Duis fermentum feugiat augue in blandit. Mauris a tempor felis. Pellentesque ultricies tristique dignissim. Pellentesque aliquam semper tristique. Nam nec egestas dolor. Vestibulum id elit quis enim fringilla tempor eu a mauris. Aliquam vitae lacus tellus. Phasellus mauris lectus, aliquam id leo eget, auctor dapibus magna. Fusce lacinia felis ac elit luctus luctus.],

      [_Dignissim_],
      [Praesent aliquam mauris enim, vestibulum posuere massa facilisis in. Suspendisse potenti. Nam quam purus, rutrum eu augue ut, varius vehicula tellus. Fusce dui diam, aliquet sit amet eros at, sollicitudin facilisis quam. Phasellus tempor metus vel augue gravida pretium. Proin aliquam aliquam blandit. Nulla id tempus mi. Fusce in aliquam tortor.],

      [_Pellentesque_],
      [Donec felis nibh, imperdiet a arcu non, vehicula gravida nibh. Quisque interdum sapien eu massa commodo, ac elementum felis faucibus.],

      [_Molestie_],
      [Cras ullamcorper tellus et auctor ultricies. Maecenas tincidunt euismod lectus nec venenatis. Suspendisse potenti. Pellentesque pretium nunc ut euismod cursus. Nam venenatis condimentum quam. Curabitur suscipit efficitur aliquet. Interdum et malesuada fames ac ante ipsum primis in faucibus.],

      [_Vivamus semper_],
      [Vivamus semper lacus eu diam laoreet congue. Vivamus in ipsum risus. Nulla ullamcorper finibus mauris non aliquet. Vivamus elementum rhoncus ex ut porttitor.],

      [_Condimentum_],
      [Nulla scelerisque, leo et facilisis pretium, risus enim cursus turpis, eu suscipit ipsum ipsum in mauris. Praesent eget pulvinar ipsum, suscipit interdum nunc. Nam varius massa ut justo ullamcorper sollicitudin. Vivamus facilisis suscipit neque, eu fermentum risus. Ut at mi mauris.],
    ),
    caption: "Praesent ullamcorper consequat tellus ut eleifend",
  ) <tab:example-3>
]
