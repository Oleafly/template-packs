#let shell-line(prompt: "", indentation_level: 0, lang: none, string) = context {
  let lang = if lang == none { raw.lang } else { lang };

  let char_width = measure(raw("x")).width;
  let prompt_width = measure(raw(prompt)).width;
  let indentation_level = indentation_level;
  set par(leading: 0.2em)
  align(top)[#grid(columns: (char_width * indentation_level, prompt_width, auto), "", raw(lang: lang, prompt), raw(lang: lang, string))]
}

#let shell-block(user: "user", user_colors: (fg: black, bg: gray), host: "host", host_colors: (fg: white, bg: black), dir: "~", dir_colors: (fg: black, bg: gray), command: "sudo rm -rf /", command_colors: (fg: white, bg: black), url: none, fill: none, lang: none, lines) = context{
  let fill = if fill == none { box.fill } else { fill };
  let lang = if lang == none { raw.lang } else { lang };
  let whitespace = h(0.5em);

  if type(lines) != array or lines.len() == 0 {
    panic("`lines` need to be an non-empty array of `str` or `shell-line`")
  }


  let user_box = stack(dir: ltr,
    box(fill: user_colors.bg, height: 100%)[#whitespace#text(fill: user_colors.fg, raw(user))#whitespace], 
    box(fill: host_colors.bg, height: 100%, inset: (left: -0.3pt), outset: (right: 0.3pt))[#polygon(fill: user_colors.bg, (0em, 0em), (0em, 100%), (0.5em, 50%))],
  );

  let host_box = stack(dir: ltr,
    box(fill: host_colors.bg, height: 100%)[#whitespace#text(fill: host_colors.fg, raw(host))#whitespace], 
    box(fill: dir_colors.bg, height: 100%, inset: (left: -0.3pt), outset: (right: 0.3pt))[#polygon(fill: host_colors.bg, (0em, 0em), (0em, 100%), (0.5em, 50%))],
  );

  let directory_box = stack(dir: ltr,
    box(fill: dir_colors.bg, height: 100%)[#whitespace#text(fill: dir_colors.fg, raw(dir))#whitespace], 
    box(fill: command_colors.bg, height: 100%, inset: (left: -0.3pt), outset: (right: 0.3pt))[#polygon(fill: dir_colors.bg, (0em, 0em), (0em, 100%), (0.5em, 50%))],
  );

  let command_box = box(fill: command_colors.bg, height: 100%)[#whitespace#text(fill: command_colors.fg, raw(command))];

  let prompt_box = {
    align(horizon)[
      #box(width: 100%, height: 1.3em, fill: command_colors.bg)[
        #stack(dir: ltr,
          user_box,
          if url != none { link(url, host_box) } else { host_box },
          if url != none { link(url, directory_box) } else { directory_box },
          command_box
       )
    ];
  ];
  };

  let output_box_content = ();
  if type(lines.at(0)) == str {
    let mapping(l) = {return raw(lang: lang, l)}  
    output_box_content = lines.map(mapping);
  }
  else {
    output_box_content = lines;
  }
  
  let output_box = box(width: 100%, fill: fill, inset: 0.5em)[#stack(dir: ttb, spacing: 0.3em, ..output_box_content)]

  //box(stroke: 0.05em + gradient.linear(command_colors.bg, host_colors.bg), radius: 0.3em, clip: true)[#align(left)[#stack(dir: ttb, prompt_box, output_box)]];
  box(stroke: 0.05em + command_colors.bg.darken(20%), radius: 0.3em, clip: true)[#align(left)[#stack(dir: ttb, prompt_box, output_box)]];
}

#let fix-width-text(target_width: 0pt, baseline: none, weight: none, body) = context {
  assert(target_width > 0pt, message: "Please supply a target width!");
  let baseline = if baseline == none { text.baseline } else { baseline };
  let weight = if weight == none { text.weight } else { weight };

  let width(size: 1em, body) = { return measure(text(size: size, body)).width; }

  let previous_size = 1pt;
  let next_size = text.size;
  let EPSILON = 0.1pt;
  let has_reached_target_width = false;

  while not has_reached_target_width {
    previous_size = next_size;
    let previous_width = width(size: previous_size, body);

    let delta = target_width - previous_width;
    let fraction = target_width / previous_width;

    next_size = previous_size * fraction;
    let next_width = width(size: next_size, body);
    let next_delta = target_width - next_width;

    if calc.abs(delta) < EPSILON {
      has_reached_target_width = true;
    }
  }

  show: text(size: next_size, baseline: baseline, weight: weight, body)
}

#let hexagon(
  side_length: 1cm,
  fill: none,
  stroke: none,
) = context {
  let fill = if fill == none { polygon.fill } else { fill };
  let stroke = if stroke == none { polygon.stroke } else { stroke };
  let s = side_length
  let h = s * calc.sin(60deg)

  let pts_relative = (
    (s, 0pt),
    (s / 2, h),
    (-s / 2, h),
    (-s, 0pt),
    (-s / 2, -h),
    (s / 2, -h),
  )

  let offset_x = s
  let offset_y = h
  let final_points = pts_relative.map(p => (p.at(0) + offset_x, p.at(1) + offset_y))

  polygon(
    fill: fill,
    stroke: stroke,
    ..final_points
  )
}

#let triangle(
  side_length: 1cm, // Single parameter to control the size
  fill: none,
  stroke: none,
) = {
  let fill = if fill == none { polygon.fill } else { fill };
  let stroke = if stroke == none { polygon.stroke } else { stroke };
  let s = side_length
  let h = s * calc.sin(60deg)

  let points = (
    (0pt, 0pt),
    (s, 0pt),
    (s / 2, -h),
  )

  polygon(
    fill: fill,
    stroke: stroke,
    ..points
  )
}
