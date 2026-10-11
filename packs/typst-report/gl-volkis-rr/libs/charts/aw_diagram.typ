#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import fletcher.shapes: *
#import "/constants.typ": *
#import template: color_palette

#let step_indicator(pos, label, tint: white, ..args) = node(
  pos, align(center, label),
  inset: 5pt,
  fill: tint.lighten(60%),
  stroke: 1pt + tint.darken(20%),
  corner-radius: 5pt,
  ..args,
)

#let stage_indicator(pos, stage_name, color, selected_shape,..args) = step_indicator(
  pos, 
  stage_name, 
  tint: color, 
  shape: selected_shape, 
  inset: 10pt, 
  ..args
)

#let attack_chain_diagram(stages) = {
    return {
  let height = 0

  for (i, stage) in stages.enumerate() {
    
    let current_color = color_palette.at("main").lighten(30%)
    if stage.color != none {
      current_color = stage.color.lighten(20%)
    } 

    let current_shape = ellipse
    if stage.shape != none {
      current_shape = stage.shape
    }

    stage_indicator((0, height), stage.name, current_color, current_shape)

    let offset = {
      if calc.rem(stage.steps.len(), 2) == 0{
        0.5 -(stage.steps.len() / 2) 
      } else {
        -((stage.steps.len() - 1) / 2)
      }
    }

    let steps_height = {
      if stage.steps.len() > 0 {
        calc.max(
          ..stage.steps.map(
            (x) => { 
              if type(x) == array { 
                x.len()
              } else if type(x) == dictionary {
                x.steps.len()
              } else { 
                1 
              }
            }
          )
        )
      } else {
        0
      }
    }

    for (j, step) in stage.steps.enumerate() {
      let should_end = false
      if type(step) == dictionary {
        should_end = step.ends
        step = step.steps
      }

      if type(step) == array {
        
          edge((offset + j, height + 1), (0, height))

          for (k, substep) in step.enumerate() {
            if k != 0 {
              edge((offset + j, height + k), (offset + j, height + k + 1))
            }
            step_indicator((offset + j, height + 1 + k), substep, tint: current_color)
          }

          if not should_end {
            edge((offset + j, height + step.len()), (0, steps_height + height + 1))
          }

          continue
        }

      edge((offset + j, height + 1), (0, height))

      step_indicator((offset + j, height + 1), step, tint: current_color)

      edge((offset + j, height + 1), (0, steps_height + height + 1))
    }

    height = height + steps_height + 1
  }
}
}
