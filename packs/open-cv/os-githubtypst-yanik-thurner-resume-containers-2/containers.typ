#let two-side-aligned-container(left_elements: (), right_elements: (), left_alignment: (left + horizon), right_alignment: (right + horizon), left_spacing: none, right_spacing: none, height: auto, inset: none ,stroke: none) = context {
  let left_spacing = if left_spacing == none { stack.spacing } else { left_spacing };
  let right_spacing = if right_spacing == none { stack.spacing } else { right_spacing };
  let inset = if inset == none { grid.inset } else { inset };
  let stroke = if stroke == none { grid.stroke } else { stroke };

  let left_side = {
    stack(dir: ltr, spacing: left_spacing, ..left_elements)
  };
  let right_side = {
    stack(dir: ltr, spacing: right_spacing, ..right_elements)
  };
  let container = grid(
    columns: (50%, 50%), rows:(height), align: (left_alignment, right_alignment), stroke: stroke, inset: inset, left_side, right_side,
  )

  show: container
}

#let inline-stack(dir: ltr, spacing: none, .. content) = {
  box[#stack(dir: dir, spacing: spacing, ..content)]
}

