// Produce an error message.
#let _error-message(message, file: none) = {
    if file != none {
        // Hack to remove `path("")` and print the path.
        repr(file).slice(6,-2)
        ": "
    }
    message
}

// Parse typst code given a context.
#let _typst(content, ctx: none) = eval(content, mode: "markup", scope: (CTX: ctx))

// Parse data for a CV section given a raw section dictionary.
#let _parse-cv-section(raw-section, level: 1, ctx: none, file: none) = {
    let _parse-cv-entry(raw-entry, ctx: none, file: none) = {
        if "entries" in raw-entry {
            // Entry is actually a subsection.
            _parse-cv-section(raw-entry, level: level + 1, ctx: ctx, file: file)
        } else {
            assert(
                "body" in raw-entry,
                message: _error-message(
                    "missing key `body` in entry " + repr(raw-entry) + "."
                ),
            )

            (
                kind: "entry",
                body: _typst(raw-entry.body, ctx: ctx),
                ..(
                    "title",
                    "institution",
                    "location",
                    "aside",
                )
                    .map(item => (item, if item in raw-entry {
                        _typst(raw-entry.at(item), ctx: ctx)
                    }))
                    .to-dict()
            )
        }
    }

    assert(
        "title" in raw-section,
        message: _error-message(
            "missing key `title` in section.",
            file: file,
        )
    )
    assert(
        "entries" in raw-section,
        message: _error-message(
            "missing key `entries` in section.",
            file: file,
        )
    )

    (
        kind: "section",
        level: level,
        title: _typst(raw-section.title, ctx: ctx),
        breakable: raw-section.at("breakable", default: true),
        entries: raw-section
            .entries
            .map(entry => _parse-cv-entry(entry, ctx: ctx, file: file))
    )
}

/// Parse #link("https://toml.io/en/", text(fill: blue, underline("TOML"))) CV data.
///
/// The data is expected to follow this #link("https://toml-schema.org/", text(fill: blue, underline("schema"))):
///
/// #raw(
///     lang: "toml",
///     toml-schema,
/// )
///
/// -> dict
#let parse-cv-data(
    /// The TOML data to parse.
    /// -> str | path | bytes
    input
) = {
    let parsed-data = toml(input)
    let file = if type(input) != bytes { input } else { none }

    let data = (:)
    let ctx = (:)

    assert(
        "name" in parsed-data,
        message: _error-message("missing key `name` (string).", file: file)
    )
    data.name = parsed-data.name
    // Email and homepage are optional.
    data.email = if "email" in parsed-data { link("mailto:" + parsed-data.email) }
    data.homepage = if "homepage" in parsed-data { link(parsed-data.homepage) }

    // Build the context.
    ctx.name = data.name
    ctx.email = data.email
    ctx.homepage = data.homepage

    assert(
        "sections" in parsed-data,
        message: _error-message("missing key `sections` (array).", file: file)
    )
    data.sections = parsed-data.sections.map(
        section => _parse-cv-section(section, ctx: ctx, file: file)
    )

    data
}
