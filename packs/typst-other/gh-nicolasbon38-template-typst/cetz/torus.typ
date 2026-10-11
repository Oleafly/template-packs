#import "@preview/cetz:0.5.2"

#let torus(
  position:(0, 0),
  n-sectors: 64,
  inner-radius: 5,
  outer-radius: 6,
  label-size: 10pt,
  with-lines:false,
  palette: ()
) = {
    assert(n-sectors > 0, message: "n-sectors must be positive")
    assert(inner-radius < outer-radius, message: "inner-radius must be smaller than outer-radius")

    import cetz.draw: *
    group({
      let step = 360deg / n-sectors

      let half-step-rotation = -step/2

      let middle-radius = (inner-radius + outer-radius) / 2

      let with-colors = palette.len() > 0

      let n-colors = { if with-colors {palette.len()} else {0}}



      for k in range(n-sectors) {
        let start-angle = k* step + half-step-rotation
        let stop-angle = (k+1) * step + half-step-rotation
        let middle-angle = (k + 0.5) * step + half-step-rotation


        let label-position = (angle: middle-angle, radius: middle-radius)
        let label-angle = middle-angle + half-step-rotation

        if with-lines{
          line(
            position, (angle: start-angle, radius: inner-radius),
            stroke: (dash: "dashed")
          )
        }

        let k-color = if with-colors {
          calc.rem(
            calc.floor(k * n-colors / n-sectors + 0.5),
            n-colors,
          )
        } else {
          0
        }


        let draw-sector = {
            line(
              (angle: start-angle, radius: inner-radius),
              (angle: start-angle, radius: outer-radius),
            )

            arc(
              (angle: start-angle, radius:outer-radius),
              start: start-angle,
              stop: stop-angle,
              radius: outer-radius
            )

            line(
              (angle: stop-angle, radius: outer-radius),
              (angle: stop-angle, radius: inner-radius),
            )


            arc(
              (angle: stop-angle, radius:inner-radius),
              start: stop-angle,
              stop: start-angle,
              radius: inner-radius
            )
        }

        if with-colors{
          merge-path(draw-sector, fill: palette.at(k-color))
        }
        else{
          merge-path(draw-sector)
        }

        content(label-position, angle: label-angle - 90deg, [
          #set text(size: label-size)
          #k
        ])


      }
    })
  }


#let embedded-torus = cetz.canvas({
  import cetz.draw: *


  let sample-colors(n-colors) = {
    let indices = range(0,n-colors).map(
      x => x/n-colors*360deg
    )
    gradient.linear(..color.map.rainbow).samples(..indices)
  }

  let colors = sample-colors(8)

  torus(
    n-sectors: 8,
    inner-radius: 4,
    outer-radius: 5,
    with-lines:true,
    palette:colors
  )

  torus(
    n-sectors: 64,
    inner-radius: 5,
    outer-radius: 6,
    palette:colors
  )
})
