#import "../../src/tudelft-phd-thesis.typ": delft-blue

This fictional dissertation demonstrates the public structure of the template. Its scientific setting is chosen solely to make a complete example more enjoyable to read. Replace every scientific claim, name, and result with your own work before using the template.

== A reusable starting point

The study asks a simple illustrative question: how can weak radioactive signals be measured consistently when the apparatus, exposure time, and background conditions vary? The subject is historically associated with the work of Curie and Curie @curie1898, while the present text is entirely template content.

The template keeps thesis metadata and document structure in the entry file, while chapter content remains in ordinary Typst files.

#figure(
  rect(width: 80%, height: 30mm, fill: delft-blue.lighten(85%), radius: 3pt),
  caption: [An illustrative signal and background measurement.],
) <fig:placeholder>

@fig:placeholder is numbered globally and appears in the list of figures. The measured count rate can be expressed as

$ r = (n - b) / t, $

where $n$ is the observed count, $b$ the estimated background count, and $t$ the exposure time. Equations are ordinary Typst mathematics and require no template-specific helper.
