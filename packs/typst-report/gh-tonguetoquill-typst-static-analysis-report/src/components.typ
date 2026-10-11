// components.typ
#import "layout.typ": config, vgap, get-severity, validate-severity, validate-column-index

// --- Utility Functions ---

/// Load an icon from the assets directory.
///
/// Parameters:
/// - name: Icon filename (without extension)
/// - size: Icon height (default: 12pt)
/// - fill: Icon color (default: text-primary)
/// - variant: Icon set to use: "solid", "regular", or "brands" (default: "solid")
///
/// Returns: A box containing the icon image
#let icon(
  name, 
  size: config.icon.default-size,
  fill: none,
  variant: config.icon.default-variant,
) = {
  let icon-fill = if fill != none { fill } else { config.colors.text-primary }
  let path = "assets/" + variant + "/" + name + ".svg"
  
  box(
    height: size,
    baseline: config.icon.baseline,
    image(path, height: size)
  )
}

/// Horizontal rule for section dividers.
///
/// Returns: A horizontal line with header accent color
#let hrule = {
  line(length: 100%, stroke: 2pt + config.colors.header-accent)
}

/// Create a severity badge with appropriate color and styling.
///
/// Parameters:
/// - level: Severity level (case-insensitive: "high", "medium", "warning", "info", "secure", "hotspot")
///
/// Returns: A centered box with colored badge
#let severity-badge(level) = {
  let sev = get-severity(level)
  
  align(center, box(
    fill: sev.color.lighten(85%),
    outset: config.badge.padding,
    radius: config.badge.radius,
    stroke: 1pt + sev.color,
    text(
      fill: sev.color.darken(10%),
      weight: "bold",
      size: config.badge.font-size,
      upper(sev.label)
    )
  ))
}

// --- Component Exports ---

/// Create a report header with branding, title, and metadata.
///
/// Parameters:
/// - title: Main report title (default: "Security Analysis Report")
/// - subtitle: Optional subtitle text (default: none)
/// - app-name: Application name (default: "")
/// - app-icon: Optional application icon (default: none)
/// - metadata: Dictionary of key-value pairs to display (default: (:))
/// - banner: Optional banner image path (default: none)
///
/// Returns: A formatted header block
#let report-header(
  title: "Security Analysis Report",
  subtitle: none,
  app-name: "",
  app-icon: none,
  metadata: (:),
  banner: none,
) = {
  set align(center)
  
  // Custom Banner (if provided)
  if banner != none {
    block(
      width: 100%,
      {
        image(banner, width: 100%)
      }
    )
    vgap(config.section-spacing * 1.5)
  }

  // Title/Branding
  block({
    text(size: 36pt, weight: "bold", fill: config.colors.text-primary, title)
    if subtitle != none {
      linebreak()
      v(8pt)
      text(size: 14pt, weight: "regular", fill: config.colors.text-secondary, subtitle)
    }
  })

  vgap(config.section-spacing * 2)

  // App Icon (if provided)
  if app-icon != none {
    block(app-icon)
    vgap(config.entry-spacing)
  }

  set align(left)

  // Key Metadata Block
  if metadata.len() > 0 {
    vgap(config.section-spacing * 2.5)
    block(
      width: 100%,
      inset: 18pt,
      radius: 4pt,
      stroke: 0.5pt + config.colors.border.lighten(20%),
      fill: config.colors.bg-primary,
      {
        grid(
          columns: (auto, 1fr),
          row-gutter: 0.75em,
          column-gutter: 2.5em,
          ..metadata.pairs().map(((key, value)) => (
            text(weight: "bold", fill: config.colors.text-primary, size: 10pt, key + ":"),
            text(fill: config.colors.text-primary, size: 10pt, value),
          )).flatten()
        )
      }
    )
  }
}

/// Display a security scorecard with score and findings summary.
///
/// Parameters:
/// - score: Security score (0-100)
/// - risk-level: Risk level label (e.g., "HIGH", "MEDIUM", "LOW")
/// - findings: Dictionary of finding categories and their counts
///
/// Returns: A formatted scorecard block
#let scorecard(score: 0, risk-level: "UNKNOWN", findings: (:)) = {
  vgap(config.section-spacing)

  block(
    width: 100%,
    inset: 16pt,
    radius: 4pt,
    stroke: config.table-stroke,
    fill: config.colors.bg-primary,
    {
      // Score Display
      align(center, {
        icon("shield-halved", size: 22pt, fill: config.colors.text-primary)
        h(9pt)
        text(size: 18pt, weight: "bold", fill: config.colors.text-primary, "App Security Score")
        v(8pt)
        text(size: 46pt, weight: "bold", fill: config.colors.text-primary, str(score) + "/100")
        v(6pt)
        severity-badge(risk-level.replace(" RISK", ""))
        text(fill: config.colors.text-secondary, size: 10pt, weight: "medium", " RISK")
      })

      vgap(config.entry-spacing * 1.3)

      // Findings Summary Table
      if findings.len() > 0 {
        align(center, {
          text(size: 11.5pt, weight: "bold", fill: config.colors.text-primary, "Findings by Severity")
          vgap(0.6em)
          table(
            columns: findings.keys().len() + 1,
            stroke: 0.8pt + config.colors.border,
            align: center + horizon,
            inset: (x: 10pt, y: 6.5pt),
            fill: (col, row) => if row == 0 { config.colors.bg-secondary } else { none },
            [*Category*], ..findings.keys().map(k => text(weight: "bold", size: 9.5pt, upper(k))),
            [*Count*], ..findings.values().map(v => text(size: 10.5pt, weight: "medium", str(v))),
          )
        })
      }
    }
  )
}

/// Display a horizontal summary grid of severity counts.
///
/// Parameters:
/// - counts: Dictionary mapping severity levels to counts (e.g., (high: 5, medium: 3))
///
/// Returns: A grid block with severity cards
#let severity-summary(counts: (:)) = {
  let order = ("high", "medium", "info", "secure", "hotspot")
  
  block(
    width: 100%,
    breakable: false,
    {
      // Severity bars in a horizontal grid layout - no wrapper card
      grid(
        columns: (1fr,) * order.len(),
        row-gutter: 0pt,
        column-gutter: 8pt,
        align: (center, horizon),
        ..order.map(level => {
          let sev = get-severity(level)
          let count = counts.at(level, default: counts.at(sev.label, default: 0))
          
          // Severity card
          block(
            width: 100%,
            height: 46pt,
            inset: (x: 7pt, y: 8pt),
            fill: sev.color,
            stroke: 1pt + sev.color.darken(5%),
            radius: 4pt,
            {
              align(center + horizon, {
                v(5pt)
                // Icon and label
                icon(sev.icon, size: 9pt, fill: white)
                h(4pt)
                text(size: 8pt, weight: "semibold", fill: white, upper(sev.label))

                v(-8pt)
                // Count
                text(size: 18pt, weight: "bold", fill: white, str(count))
                v(4pt)
              })
            }
          )
        })
      )
    }
  )
}

/// Create a section header with optional icon.
///
/// Parameters:
/// - title: Section title text
/// - extra: Optional extra text to append to title (default: none)
/// - icon-name: Optional icon name (default: none)
///
/// Returns: A formatted section header with horizontal rule
#let section-header(title, extra: none, icon-name: none) = {
  vgap(config.section-spacing)
  set align(left)

  // Title with optional icon - sticky block prevents page breaks between header and content
  block(sticky: true, {
    if icon-name != none {
      icon(icon-name, size: 13pt, fill: config.colors.text-primary)
      h(6pt)
    }
    text(size: 12pt, weight: "bold", fill: config.colors.text-primary, upper(title))
    if extra != none {
      text(size: 12pt, weight: "bold", fill: config.colors.text-primary, " " + extra)
    }
  v(2pt)
  hrule
  v(3pt)
  })

}

/// Display a key-value metadata block.
///
/// Parameters:
/// - title: Optional block title (default: none)
/// - data: Dictionary of key-value pairs to display
/// - columns: Number of columns for the grid layout (default: 1)
///
/// Returns: A formatted metadata block
#let metadata-block(title: none, data: (:), columns: 1) = {
  vgap(config.entry-spacing)

  if title != none {
    text(weight: "bold", size: 11pt, title)
    vgap(0.3em)
  }

  block(
    width: 100%,
    inset: config.metadata-block-inset,
    radius: 5pt,
    stroke: 1pt + config.colors.border,
    fill: config.colors.bg-primary,
    {
      let items = data.pairs().map(((key, value)) => (
        text(weight: "bold", fill: config.colors.text-secondary, size: 10pt, key + ":"),
        text(fill: config.colors.text-primary, size: 10pt, value),
      )).flatten()

      grid(
        columns: (auto, 1fr) * columns,
        row-gutter: 0.5em,
        column-gutter: 2em,
        ..items
      )
    }
  )
}

  v(4pt)
}

/// Base table wrapper with consistent styling.
///
/// Parameters:
/// - columns: Column width specification (auto or array of sizes)
/// - headers: Array of header cells
/// - rows: Array of row cells (flattened)
/// - align: Alignment function or auto (default: auto)
/// - severity-columns: Array of column indices containing severity badges (default: ())
///
/// Returns: A formatted table block
#let base-table(
  columns: auto,
  headers: (),
  rows: (),
  align: auto,
  severity-columns: (), // Array of column indices that contain severity badges
) = {
  let default-align = (col, row) => {
    if row == 0 { center + horizon }
    else if col in severity-columns { center + horizon }
    else { left + horizon }
  }
  
  block(breakable: false, {
    table(
      columns: columns,
      stroke: config.table-stroke,
      inset: config.table-inset,
      align: if align == auto { default-align } else { align },
      fill: (col, row) => {
        if row == 0 {
          config.colors.bg-secondary
        } else if calc.rem(row, 2) == 0 {
          config.colors.bg-primary
        } else {
          none
        }
      },
      ..headers,
      ..rows,
    )
  })
}

/// Create a flexible data table with optional auto-numbering and severity highlighting.
///
/// Parameters:
/// - headers: Array of column header strings
/// - rows: Array of row data (each row is an array)
/// - columns: Column width specification (auto or array of sizes) (default: auto)
/// - severity-column: Index of column to apply severity badge, or none to disable (default: none)
/// - auto-number: Add automatic row numbering column (default: false)
/// - title: Optional table title shown above table (default: none)
/// - transform: Optional function to transform row data (default: none)
///
/// Returns: A formatted table block
///
/// Example:
/// ```typst
/// #data-table(
///   headers: ("Issue", "Severity"),
///   rows: ((\"SQL Injection\", \"high\"), (\"XSS\", \"medium\")),
///   severity-column: 1,
///   auto-number: true,
/// )
/// ```
#let data-table(
  headers: (),
  rows: (),
  columns: auto,  // Can be array of sizes or auto
  severity-column: none,
  auto-number: false,
  title: none,
  transform: none,  // Optional row transformation function
) = {
  // Validation
  assert(headers.len() > 0, message: "Headers cannot be empty")
  
  // Validate severity-column index
  if severity-column != none {
    validate-column-index(severity-column, headers.len(), param-name: "severity-column")
  }
  
  vgap(config.entry-spacing)
  
  if rows.len() == 0 { return }
  
  // Add title if provided
  if title != none {
    text(weight: "bold", size: 11pt, fill: config.colors.text-primary, title)
    vgap(0.5em)
  }
  
  // Auto-numbering adds a "NO" column
  let final-headers = if auto-number {
    ([*NO*],) + headers.map(h => text(weight: "bold", size: 9.5pt, h))
  } else {
    headers.map(h => text(weight: "bold", size: 9.5pt, h))
  }
  
  // Adjust severity column index if auto-numbering
  let severity-idx = if severity-column != none and auto-number {
    severity-column + 1
  } else {
    severity-column
  }
  
  // Process rows
  let final-rows = rows.enumerate().map(((idx, row)) => {
    let processed-row = if transform != none {
      transform(row, idx)
    } else {
      row
    }
    
    // Add auto-number if enabled
    let numbered-row = if auto-number {
      (str(idx + 1),) + processed-row
    } else {
      processed-row
    }
    
    // Apply severity highlighting
    numbered-row.enumerate().map(((i, cell)) => {
      if severity-idx != none and i == severity-idx {
        severity-badge(cell)
      } else {
        cell
      }
    })
  }).flatten()
  
  base-table(
    columns: if columns == auto { final-headers.len() } else { columns },
    headers: final-headers.map(h => text(weight: "bold", size: 10pt, h)),
    rows: final-rows,
    severity-columns: if severity-idx != none { (severity-idx,) } else { () },
  )
}

/// Create a security findings table with auto-numbering.
///
/// Parameters:
/// - headers: Array of column header strings
/// - rows: Array of row data (each row is an array)
/// - severity-column: Index of column to apply severity badge, or none (default: none)
///
/// Returns: A formatted security table
#let security-table(headers: (), rows: (), severity-column: none) = {
  vgap(config.entry-spacing)

  if rows.len() == 0 { return }

  let final-headers = ([*NO*],) + headers.map(h => text(weight: "bold", size: 10pt, h))

  let severity-idx = if severity-column != none { severity-column + 1 } else { none }

  let final-rows = rows.enumerate().map(((idx, row)) => {
    let numbered-row = (str(idx + 1),) + row

    numbered-row.enumerate().map(((i, cell)) => {
      if severity-idx != none and i == severity-idx {
        severity-badge(cell)
      } else {
        cell
      }
    })
  }).flatten()

  base-table(
    columns: final-headers.len(),
    headers: final-headers,
    rows: final-rows,
    severity-columns: if severity-idx != none { (severity-idx,) } else { () },
  )
}

/// Create a table displaying binary security features.
///
/// Parameters:
/// - entries: Array of dictionaries with keys: path, nx, stack-canary, arc, rpath, code-signature, encrypted
/// - columns: Column width specification (default: pre-configured)
///
/// Returns: A formatted binary analysis table
#let binary-table(
  entries: (),
  columns: (auto, 2.8fr, 0.8fr, 0.9fr, 0.7fr, 0.8fr, 0.8fr, 0.9fr),
) = {
  vgap(config.entry-spacing)

  if entries.len() == 0 { return }

  let headers = (
    [*NO*],
    [*DYLIB/FRAMEWORK*],
    [*NX*],
    [*STACK#linebreak()CANARY*],
    [*ARC*],
    [*RPATH*],
    [*CODE#linebreak()SIG*],
    [*ENCRYPTED*]
  )

  let rows = entries.enumerate().map(((idx, entry)) => (
    str(idx + 1),
    text(size: 8.5pt, font: "Courier New", entry.path),
    severity-badge(entry.nx),
    severity-badge(entry.at("stack-canary")),
    severity-badge(entry.arc),
    severity-badge(entry.rpath),
    severity-badge(entry.at("code-signature")),
    severity-badge(entry.encrypted),
  )).flatten()

  base-table(
    columns: columns,
    headers: headers,
    rows: rows,
    severity-columns: (2, 3, 4, 5, 6, 7), // All badge columns
    align: (col, row) => {
      if col == 0 { center + horizon }
      else if row == 0 { center + horizon }
      else if col == 1 { left + horizon }
      else { center + horizon }
    },
  )
}

/// Create a table displaying domain information.
///
/// Parameters:
/// - domains: Array of dictionaries with keys: url, status, geolocation (optional)
/// - columns: Column width specification (default: pre-configured)
///
/// Returns: A formatted domain table
#let domain-table(
  domains: (),
  columns: (auto, 2fr, auto, 3fr),
) = {
  vgap(config.entry-spacing)

  if domains.len() == 0 { return }

  let headers = ([*NO*], [*DOMAIN*], [*STATUS*], [*GEOLOCATION*])

  let rows = domains.enumerate().map(((idx, domain)) => (
    str(idx + 1),
    text(font: "Courier New", size: 9pt, domain.url),
    text(size: 9pt, weight: "medium", fill: config.colors.secure, domain.status),
    if "geolocation" in domain {
      let geo = domain.geolocation
      text(size: 8.5pt, [IP: #geo.ip | Country: #geo.country | City: #geo.city])
    } else {
      text(size: 8.5pt, [N/A])
    },
  )).flatten()

  base-table(
    columns: columns,
    headers: headers,
    rows: rows,
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 or col == 2 { center + horizon }
      else { left + horizon }
    },
  )
}

/// Create a table displaying log entries.
///
/// Parameters:
/// - logs: Array of dictionaries with keys: timestamp, event, status
/// - columns: Column width specification (default: pre-configured)
///
/// Returns: A formatted log table
#let log-table(
  logs: (),
  columns: (auto, 1.8fr, 3fr, auto),
) = {
  vgap(config.entry-spacing)

  if logs.len() == 0 { return }

  let headers = ([*NO*], [*TIMESTAMP*], [*EVENT*], [*STATUS*])

  let rows = logs.enumerate().map(((idx, log)) => (
    str(idx + 1),
    text(size: 9pt, log.timestamp),
    text(size: 9pt, log.event),
    if log.status == "OK" {
      text(fill: config.colors.secure, weight: "bold", size: 9pt, "OK")
    } else {
      text(fill: config.colors.high, weight: "bold", size: 9pt, log.status)
    },
  )).flatten()

  base-table(
    columns: columns,
    headers: headers,
    rows: rows,
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 or col == 3 { center + horizon }
      else { left + horizon }
    },
  )
}

/// Create a reconnaissance table for discovered items.
///
/// Parameters:
/// - title: Table title (default: "Discovered Items")
/// - items: Array of dictionaries with keys: value, source
/// - item-label: Column label for items (default: "Item")
/// - source-label: Column label for sources (default: "Source")
/// - icon-name: Optional icon for the title (default: none)
/// - columns: Column width specification (default: pre-configured)
///
/// Returns: A formatted reconnaissance table
#let recon-table(
  title: "Discovered Items",
  items: (),
  item-label: "Item",
  source-label: "Source",
  icon-name: none,
  columns: (auto, 2.5fr, 2fr),
) = {
  vgap(config.entry-spacing * 1.2)

  if title != none {
    block({
      if icon-name != none {
        icon(icon-name, size: 12pt, fill: config.colors.text-primary)
        h(7pt)
      }
      text(weight: "bold", size: 12pt, fill: config.colors.text-primary, title)
      vgap(0.6em)
    }, sticky: true)
  }

  if items.len() == 0 { return }

  let headers = ([*NO*], [*#item-label*], [*#source-label*])

  let rows = items.enumerate().map(((idx, item)) => (
    str(idx + 1),
    text(font: "Courier New", size: 9pt, item.value),
    text(size: 9pt, item.source),
  )).flatten()

  base-table(
    columns: columns,
    headers: headers,
    rows: rows,
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 { center + horizon }
      else { left + horizon }
    },
  )
}
