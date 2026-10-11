#import "template.typ": project

#show: project.with(
  specialty: [your specialty],
  module: [your module],
  professor: [your name],
  title: [your title],
  year: "20xx/20xx",
  author: (
    "name 1",
    "name 2",
    "name 3",
    "name 4",
  )
)

= something something

== i hope you get it
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas vel eros bibendum, pharetra eros et, aliquet ex. Maecenas eu interdum mi. Praesent pretium libero eu quam congue, quis aliquet lorem bibendum. Suspendisse quis diam cursus, pulvinar lectus eu, bibendum est. Duis scelerisque consequat velit nec vulputate. Nulla ac sem ut odio fringilla fermentum et et ante. Maecenas malesuada eget nibh et fermentum. Aliquam ut convallis ex. Pellentesque vel ipsum lacinia, vestibulum urna a, ullamcorper mauris. Cras eleifend, ante quis consectetur viverra, nibh magna hendrerit sapien, quis bibendum lectus nulla a erat. In felis est, pretium ut hendrerit vel, interdum a urna. In tellus neque, congue in tortor ac, rhoncus molestie nisl. Praesent magna mi, hendrerit vulputate suscipit eu, rutrum at diam. Mauris ipsum massa, congue ac ligula at, rutrum pulvinar leo.

#figure(
    
    table(
        columns : 5,
        inset: 10pt,
        [*one*], [*two*], [*three*], [*four*], [*five*],
        [one], [two], [three], [four], [five],
        [one], [two], [three], [four], [five],
        [one], [two], [three], [four], [five],
        [one], [two], [three], [four], [five],
    
    )

)
