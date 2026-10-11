
#let parse-csv-to-dict(rows) = {
  let result = (:)
  // Row 0 contains Algorithm names (headers)
  let headers = rows.at(0)

  // Initialize keys for each algorithm found in headers
  // We skip index 0 because that is "Métrica"
  for i in range(1, headers.len()) {
    let algo = headers.at(i)
    if algo != "-" and algo != "" {
      result.insert(algo, (:))
    }
  }

  // Iterate over data rows (skipping header)
  for r in range(1, rows.len()) {
    let row = rows.at(r)
    let metric = row.at(0) // First column is the Metric name (MAE, RMSE, etc.)

    // Iterate columns
    for c in range(1, row.len()) {
      let val-str = row.at(c)
      let algo = headers.at(c)

      // Only insert if we have a valid value
      if val-str != "-" and val-str != "" and algo in result {
        // Try to convert to float for rounding later, or keep as string
        let val = float(val-str)
        result.at(algo).insert(metric, val)
      }
    }
  }
  result
}

#let comparison-table(
  csv-100k: (),
  csv-32m: (),
  algorithms: (),
  caption: none,
) = {
  let d100 = parse-csv-to-dict(csv-100k)
  let d32 = parse-csv-to-dict(csv-32m)
  let metrics = ("MAE", "MAE STD", "RMSE", "RMSE STD", "Time (s)")

  // --- LOGIC TO FIND BEST VALUES ---
  // We need to know the "best" (minimum) value for every row to decide when to highlight.
  // We store this as: best.100k.MAE = 0.6099
  let best-vals = (
    "100k": (:),
    "32m": (:),
  )

  for m in metrics {
    let vals-100k = ()
    let vals-32m = ()

    for algo in algorithms {
      if algo in d100 and m in d100.at(algo) { vals-100k.push(d100.at(algo).at(m)) }
      if algo in d32 and m in d32.at(algo) { vals-32m.push(d32.at(algo).at(m)) }
    }

    // For Error and Time, Lower is better (calc.min)
    // If you had accuracy, you would change this to calc.max
    if vals-100k.len() > 0 { best-vals.at("100k").insert(m, calc.min(..vals-100k)) }
    if vals-32m.len() > 0 { best-vals.at("32m").insert(m, calc.min(..vals-32m)) }
  }

  // --- CELL GENERATOR ---
  let cell(dataset, dataset-key, algo, metric) = {
    if algo in dataset and metric in dataset.at(algo) {
      let val = dataset.at(algo).at(metric)
      let formatted = str(calc.round(val, digits: 4))

      // Check if this value is the best one
      let best = best-vals.at(dataset-key).at(metric, default: none)

      if best != none and val == best {
        // HIGHLIGHT STYLE: Bold Red
        text(fill: red, weight: "bold")[#formatted]
      } else {
        formatted
      }
    } else {
      "-"
    }
  }

  figure(
    caption: caption,
    table(
      columns: (auto, ..((1fr, 1fr) * algorithms.len())),
      align: (x, y) => if x == 0 { left } else { center },
      row-gutter: (auto, 2.2pt, auto),
      stroke: (x, y) => {
        let s = (top: 0.5pt + black, bottom: 0.5pt + black)
        if x == 0 { s.insert("left", 0.5pt + black) }
        if x > 0 and calc.rem(x, 2) == 0 { s.insert("right", 0.5pt + black) }
        if y == 0 { s.bottom = 0.5pt + black }
        if y == 1 { s.bottom = 1pt + black }
        s
      },
      fill: (_, y) => if y < 2 { gray.lighten(90%) },

      // Headers
      table.header(
        [],
        ..algorithms.map(a => table.cell(colspan: 2, strong(a))),
        [],
        ..range(algorithms.len()).map(_ => ([100K], [32M])).flatten(),
      ),

      // Data Rows
      ..metrics
        .map(metric => {
          (
            strong(metric),
            ..algorithms
              .map(algo => {
                (
                  cell(d100, "100k", algo, metric),
                  cell(d32, "32m", algo, metric),
                )
              })
              .flatten(),
          )
        })
        .flatten(),
    ),
  )
}
