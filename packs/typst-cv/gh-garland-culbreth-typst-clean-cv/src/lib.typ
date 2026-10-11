#let is_nonempty_str(x) = {
    x != ""
}

#let date_formatter(start: "", end: "") = {
    let date_range = (start, end)
    date_range = date_range.filter(is_nonempty_str)
    date_range = date_range.join(" – ")
    text(date_range)
}

/// Render a formatted name block. Used for the top left header.
///
/// - name (string): Your name.
/// - font_size (length | text.size): Size of the name text.
/// - font_color (color): Color to give the name text.
/// - pad_above (auto | fraction | length | relative): Space to insert or remove above the block. Useful for vertical alignment.
#let name_block(
    name: "Your name",
    font_size: 24pt,
    font_color: rgb("#002f55"),
    pad_above: 1em,
    pad_below: 0em,
    letter_spacing: 0.5pt,
) = {
    block(above: pad_above, below: pad_below)[
        #text(upper(name), weight: "bold", size: font_size, fill: font_color, tracking: letter_spacing)
    ]
}

/// Render formatted contact information. Used for the top right header.
///
/// - location (string): Your location.
/// - phone (string): Your phone number.
/// - email (string): Your email address. Can be plain text or a `link()`.
/// - website (string): Your website URL. Can be plain text or a `link()`.
/// - pad_below_line (auto | fraction | length | relative): Space to insert below each line in the block.
/// - pad_above (auto | fraction | length | relative): Space to insert or remove above the block. Useful for vertical alignment.
#let contact_block(
    location: "City, Country",
    phone: "+1 (123) 456-7890",
    email: "email@address.com",
    website: "website.com",
    pad_above: 1em,
    pad_below: 0.5em,
) = {
    let contacts = (
        location,
        phone,
        link(email),
        link(website),
    )
    contacts = contacts.filter(is_nonempty_str)
    contacts = contacts.join(" | ")
    block(above: pad_above, below: 0.5em)[#text(contacts)]
}

#let skill_block(
    body,
    title: "",
    hanging_indent: 0.15fr
) = {
    grid(
        columns: (hanging_indent, 1fr),
        align: (left, left),
        text(title, weight: "bold"),
        body
    )
}

/// Render a skill item with a level, such as years of experience.
///
/// - name (string): Skill name.
/// - level (string): Skill level. Often a unit of time.
/// - sep (string): Separator to display between name and level.
#let skill_level(
    skill: "Name",
    level: "1 yr",
    sep: ": ",
) = {
    let skill_level = (skill, level)
    skill_level.join(sep)
}

/// Render a formatted entry, such as a job position.
///
/// - start (string): Date on which you started with the position.
/// - end (string): Date on which you ended with the position.
/// - organization (string): Organization within which you held the position.
/// - location (string): Location from which you worked for the position.
/// - small_font_size (length | text.size): Size to give de-emphasized text elements.
/// - pad_above (auto | fraction | length | relative): Space to insert above position block.
/// - pad_between (auto | fraction | length | relative): Space to insert between lines in position block.
/// - pad_below (auto | fraction | length | relative): Space to insert below position block.
#let entry(
    title: "Position title",
    start: "20xx",
    end: "20xx",
    organization: "Organization name",
    location: "City, country",
    small_font_size: 9pt,
    pad_above: 1.1em,
    pad_between: 0.5em,
    pad_below: 0.7em,
) = {
    let date_range = date_formatter(start: start, end: end)
    block(above: pad_above)[
        #grid(
            columns: (1fr, auto),
            align: (left, right),
            text(title, weight: "bold"), text(date_range, weight: "regular"),
        )
    ]
    block(above: pad_between, below: pad_below)[
        #grid(
            columns: (1fr, auto),
            align: (left, right),
            text(organization, weight: "regular"), text(location, style: "normal", size: small_font_size),
        )
    ]
}

/// Render a formatted entry, such as a job position, in one column only.
///
/// - title (string): Title of your position.
/// - start (string): Date on which you started with the position.
/// - end (string): Date on which you ended with the position.
/// - organization (string): Organization within which you held the position.
/// - location (string): Location from which you worked for the position.
/// - small_font_size (length | text.size): Size to give de-emphasized text elements.
/// - pad_above (auto | fraction | length | relative): Space to insert above position block.
/// - pad_between (auto | fraction | length | relative): Space to insert between lines in position block.
/// - pad_below (auto | fraction | length | relative): Space to insert below position block.
#let entry_one_column(
    title: "Position title",
    start: "20xx",
    end: "20xx",
    organization: "Organization name",
    location: "City, country",
    small_font_size: 9pt,
    pad_above: 1.1em,
    pad_between: 0.5em,
    pad_below: 0.8em,
) = {
    let date_range = date_helper(start: start, end: end)
    block(above: pad_above)[#text(title, weight: "bold")]
    block(above: pad_between)[#text(organization, weight: "regular")]
    block(above: pad_between)[#text(date_range)]
    if (location != "") {
        block(above: pad_between)[
            #text(location, style: "normal", size: small_font_size)
        ]
    }
}

/// Render a formattable bullet list item.
///
/// - item (string): Text to render as bullet point.
/// - font_size (text.size): Font size for bullet item text.
/// - text_color (color): Color for bullet item text.
/// - leading (length):  Line spacing of bullet item.
/// - pad_between (auto | fraction | length | relative): Space to insert between adjacent bullet points.
#let entry_bullet(
    item,
    font_size: 0.95em,
    font_color: rgb("#4c525b"),
    leading: 0.6em,
    pad_between: 0.8em,
    pad_left: 0.5em,
) = {
    set text(style: "normal", size: font_size, fill: font_color)
    set par(leading: leading)
    block(below: pad_between)[#list(item, indent: pad_left)]
}

/// Render a formatted block for a project you've worked on.
///
/// - name (string): Name of project.
/// - start (string): Start date of project.
/// - end (string): End date of project.
/// - role (string): Role you have with project.
/// - website (string): Website of project.
/// - pad_above (auto | fraction | length | relative): Space to insert above project block.
/// - pad_below (auto | fraction | length | relative): Space to insert below project block.
#let project(
    name: "Position title",
    start: "20xx",
    end: "20xx",
    role: "",
    website: "website.com",
    pad_above: 1em,
    pad_below: 0.6em,
) = {
    let date_range = date_formatter(start: start, end: end)
    if website != "" {
        name = text(name, weight: "bold") + " (" + website + ")"
    }
    block(above: pad_above, below: pad_below)[
        #grid(
            columns: (1fr, auto),
            align: (left, right),
            name, date_range,
        )
    ]
    if role != "" {
        block(above: 0em, below: pad_below)[
            #grid(
                columns: (1fr, auto),
                align: (left, right),
                role,
            )
        ]
    }
}

/// Render a formatted block for reference contact information.
///
/// - name (string): Name of reference contact.
/// - position (string): Position title of reference contact.
/// - organization (string): Organizational affiliation of reference contact.
/// - email (string): Email address of reference contact.
/// - phone (string): Phone number of reference contact.
/// - pad_between_lines (auto | fraction | length | relative): Space to insert between lines in the reference block.
/// - pad_below (auto | fraction | length | relative): Space to insert above reference block.
/// - small_font_size (length | text.size): Size to give de-emphasized text elements.
/// - light_font_color (color): Color to give de-emphasized text elements.
#let reference(
    name: "Contact Name",
    position: "Position title",
    organization: "Organization",
    email: "email@address.com",
    phone: "+1 (123) 456-7890",
    pad_between_lines: 0.7em,
    pad_above: 1em,
    small_font_size: 0.9em,
    light_font_color: rgb("#393f46"),
) = {
    block(above: pad_above, below: pad_between_lines)[#text(name)]
    block(below: pad_between_lines)[
        #text(organization, style: "italic", size: small_font_size)
    ]
    block(below: pad_between_lines)[
        #text(position, weight: "regular", size: small_font_size, fill: light_font_color)
    ]
    if (email != "") {
        block(below: pad_between_lines)[
            #text(email, weight: "regular", size: small_font_size)
        ]
    }
    if (phone != "") {
        block(below: pad_between_lines)[
            #text(phone, weight: "regular", size: small_font_size, fill: light_font_color)
        ]
    }
}

/// Render a formatted bibliography style list of publications
///
/// - file (string): File path to a BibLaTeX `.bib` or Hayagriva `.yml` file containing references to be cited. All entries will be displayed in the order they appear in the file.
/// - style (string): Bibliography style to display.
#let publications(file, style: "elsevier-harvard") = {
    bibliography(file, full: true, title: none, style: style)
}

/// Render a simply styled clean looking CV.
///
/// - name (string): Your name.
/// - location (string): Your location.
/// - phone (string): Your phone number.
/// - email (string | link): Your email address. May be plain text or a `link()`.
/// - website (string | link): Your website URL. May be plain text or a `link()`.
/// - page_size (string): Page size.
/// - page_margin (length | margin): Page margin width.
/// - font_family (array | str | text.font): Font family for all text.
/// - base_font_size (length | text.size):Size of body text.
/// - heading_font_size (length | text.size): Size for section heading text.
/// - base_font_color (length | text.size): Color of basic text elements.
/// - heading_font_color (color): Color of section heading and name text.
/// - hyperlink_font_color (color): Color of hyperlinks.
#let clean_cv(
    name: "Your Name",
    location: "City, Country",
    phone: "+1 (123) 456-7890",
    email: link("mailto:email@address.com", "email@address.com"),
    website: link("https://website.com", "website.com"),
    page_size: "us-letter",
    page_margin: 0.5in,
    font_family: "Fira Sans",
    base_font_size: 10pt,
    heading_font_size: 1.1em,
    base_font_color: rgb("#1f2328"),
    heading_font_color: rgb("#1e496d"),
    hyperlink_font_color: rgb("#0969da"),
    body,
) = {
    set page(paper: page_size, margin: page_margin)
    set text(font: font_family, size: base_font_size, fill: base_font_color)
    show link: x => {
        set text(fill: hyperlink_font_color)
        underline(x)
    }
    show heading: title => [
        #set text(size: heading_font_size, weight: "bold", fill: heading_font_color)
        #block(smallcaps(title.body), above: 1.2em, below: 0.4em)
        #block(above: 0em, below: 0.6em)[
            #line(length: 100%, stroke: (paint: rgb("#888888"), thickness: 0.5pt))
        ]
    ]
    name_block(name: name, font_color: heading_font_color)
    contact_block(
        location: location,
        phone: phone,
        email: email,
        website: website,
    )
    body
}
