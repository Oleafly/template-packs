= Das ist ein Kapitel <link1>
Was geht hier eigentlich. Ich referenziere hier @link1

== Das ist ein Sub-Kapitel auf Level 2
Das ist ein Sub-Kapitel.
#lorem(20)

#figure(
  image("../assets/zf_lifetec_logo.jpeg",width: 60%),
  caption: [ZF Lifetec Logo],
)<fig:zf_lifetec_logo>

Ich schreibe hier noch ein Text zu @fig:zf_lifetec_logo und dann geht es auch schon weiter.
#figure(
  [Content ist hier],
  caption: [Das ist kein Bild],
  supplement: [Custom],
)<fig:no_image>

Ich zitiere hier mal kein Bild: @fig:no_image

=== Hier kommt ein weiteres unterkapitel