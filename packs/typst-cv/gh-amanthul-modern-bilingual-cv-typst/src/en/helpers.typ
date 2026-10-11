#import "@preview/fontawesome:0.6.0": *
#import "@preview/linguify:0.5.0": *
#import "../common.typ": default-accent-color

// Language data (loaded once, shared by resume and coverletter)
#let lang-data = toml("../../lang.toml")

// Color constants
#let color-darknight = rgb("#131A28")
#let color-darkgray = rgb("#333333")
#let color-gray = rgb("#5d5d5d")
#let default-location-color = rgb("#333333")

// Default paragraph settings
#let default-par = (spacing: 0.75em, justify: true)

// FontAwesome icon constants for contact items
#let linkedin-icon = box(fa-icon("linkedin", fill: color-darknight))
#let github-icon = box(fa-icon("github", fill: color-darknight))
#let gitlab-icon = box(fa-icon("gitlab", fill: color-darknight))
#let bitbucket-icon = box(fa-icon("bitbucket", fill: color-darknight))
#let twitter-icon = box(fa-icon("twitter", fill: color-darknight))
#let bluesky-icon = box(fa-icon("bluesky", fill: color-darknight))
#let mastodon-icon = box(fa-icon("mastodon", fill: color-darknight))
#let google-scholar-icon = box(fa-icon("google-scholar", fill: color-darknight))
#let orcid-icon = box(fa-icon("orcid", fill: color-darknight))
#let phone-icon = box(fa-icon("square-phone", fill: color-darknight))
#let email-icon = box(fa-icon("envelope", fill: color-darknight))
#let birth-icon = box(fa-icon("cake", fill: color-darknight))
#let homepage-icon = box(fa-icon("home", fill: color-darknight))
#let website-icon = box(fa-icon("globe", fill: color-darknight))
#let address-icon = box(fa-icon("location-crosshairs", fill: color-darknight))

// --- Helper Functions ---

#let __format_author_name(author, language) = {
  if language == "zh" or language == "ja" {
    str(author.lastname) + str(author.firstname)
  } else {
    str(author.firstname) + " " + str(author.lastname)
  }
}

#let __apply_smallcaps(content, use-smallcaps) = {
  if use-smallcaps {
    smallcaps(content)
  } else {
    content
  }
}

#let __justify_align(left_body, right_body) = {
  block[
    #left_body
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

#let __justify_align_3(left_body, mid_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(center)[
        #mid_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

// --- Footer Functions ---

#let __resume_footer(author, language, date, use-smallcaps: true) = {
  set text(fill: gray, size: 8pt)
  __justify_align_3[
    #__apply_smallcaps(date, use-smallcaps)
  ][
    #__apply_smallcaps(
      {
        let name = __format_author_name(author, language)
        name + " · " + linguify("resume", from: lang-data)
      },
      use-smallcaps,
    )
  ][
    #context {
      counter(page).display()
    }
  ]
}

#let __coverletter_footer(author, language, date, use-smallcaps: true) = {
  set text(fill: gray, size: 8pt)
  __justify_align_3[
    #__apply_smallcaps(date, use-smallcaps)
  ][
    #__apply_smallcaps(
      {
        let name = __format_author_name(author, language)
        name + " · " + linguify("cover-letter", from: lang-data)
      },
      use-smallcaps,
    )
  ][
    #context {
      counter(page).display()
    }
  ]
}

// --- Contact Item Formatting ---

#let __contact_item(item, link-prefix: "", inset: (:)) = {
  box[
    #set align(bottom)
    #if ("icon" in item) {
      [#item.icon]
    }
    #box(inset: inset)[
      #if ("link" in item) {
        link(link-prefix + item.link)[#item.text]
      } else {
        item.text
      }
    ]
  ]
}

#let __format_contact_items(author, item-inset: (:)) = {
  let contact-item(item, link-prefix: "") = {
    __contact_item(item, link-prefix: link-prefix, inset: item-inset)
  }

  let items = ()

  if "birth" in author {
    items.push(contact-item((text: author.birth, icon: birth-icon)))
  }
  if "phone" in author {
    items.push(
      contact-item(
        (text: author.phone, icon: phone-icon, link: author.phone),
        link-prefix: "tel:",
      ),
    )
  }
  if "email" in author {
    items.push(
      contact-item(
        (text: author.email, icon: email-icon, link: author.email),
        link-prefix: "mailto:",
      ),
    )
  }
  if "homepage" in author {
    items.push(
      contact-item(
        (text: author.homepage, icon: homepage-icon, link: author.homepage),
      ),
    )
  }
  if "github" in author {
    items.push(
      contact-item(
        (text: author.github, icon: github-icon, link: author.github),
        link-prefix: "https://github.com/",
      ),
    )
  }
  if "gitlab" in author {
    items.push(
      contact-item(
        (text: author.gitlab, icon: gitlab-icon, link: author.gitlab),
        link-prefix: "https://gitlab.com/",
      ),
    )
  }
  if "bitbucket" in author {
    items.push(
      contact-item(
        (text: author.bitbucket, icon: bitbucket-icon, link: author.bitbucket),
        link-prefix: "https://bitbucket.org/",
      ),
    )
  }
  if "linkedin" in author {
    items.push(
      contact-item(
        (
          text: author.firstname + " " + author.lastname,
          icon: linkedin-icon,
          link: author.linkedin,
        ),
        link-prefix: "https://www.linkedin.com/in/",
      ),
    )
  }
  if "twitter" in author {
    items.push(
      contact-item(
        (text: "@" + author.twitter, icon: twitter-icon, link: author.twitter),
        link-prefix: "https://twitter.com/",
      ),
    )
  }
  if "bluesky" in author {
    items.push(
      contact-item(
        (text: "@" + author.bluesky, icon: bluesky-icon, link: author.bluesky),
        link-prefix: "https://bsky.app/profile/",
      ),
    )
  }
  if "mastodon" in author {
    items.push(
      contact-item(
        (
          text: "@" + author.mastodon,
          icon: mastodon-icon,
          link: author.mastodon,
        ),
        link-prefix: "https://mastodon.social/@",
      ),
    )
  }
  if "scholar" in author {
    let fullname = str(author.firstname + " " + author.lastname)
    items.push(
      contact-item(
        (text: fullname, icon: google-scholar-icon, link: author.scholar),
        link-prefix: "https://scholar.google.com/citations?user=",
      ),
    )
  }
  if "orcid" in author {
    items.push(
      contact-item(
        (text: author.orcid, icon: orcid-icon, link: author.orcid),
        link-prefix: "https://orcid.org/",
      ),
    )
  }
  if "website" in author {
    items.push(
      contact-item(
        (text: author.website, icon: website-icon, link: author.website),
      ),
    )
  }
  if "custom" in author and type(author.custom) == array {
    for item in author.custom {
      if "text" in item {
        items.push(
          contact-item(
            (
              text: item.text,
              icon: if ("icon" in item) {
                box(fa-icon(item.icon, fill: color-darknight))
              } else {
                none
              },
              link: if ("link" in item) {
                item.link
              } else {
                none
              },
            ),
            link-prefix: "",
          ),
        )
      }
    }
  }

  items
}

// --- Header Layout Functions ---

#let secondary-right-header(body) = {
  set text(size: 11pt, weight: "medium")
  body
}

#let tertiary-right-header(body) = {
  set text(weight: "light", size: 9pt)
  body
}

#let justified-header(primary, secondary) = {
  set block(above: 0.7em, below: 0.7em)
  pad[
    #__justify_align[
      == #primary
    ][
      #secondary-right-header[#secondary]
    ]
  ]
}

#let secondary-justified-header(primary, secondary) = {
  __justify_align[
    === #primary
  ][
    #tertiary-right-header[#secondary]
  ]
}
