/*
 * Article component for academic CV
 * Supports multiple citation styles for journal articles
 */

// Counter for numbered list
#let _article-counter = state("article-counter", 0)

// Reset the article counter (call at the beginning of a section)
#let reset-article-counter() = {
  _article-counter.update(0)
}

// GB/T 7714-2015 format (Chinese national standard)
#let format-gb7714(
  authors: (),
  title: "",
  journal: "",
  year: "",
  volume: "",
  issue: "",
  pages: "",
  doi: "",
) = {
  let author-str = authors.join(", ")
  let journal-part = journal
  if year != "" {
    journal-part = [#journal-part, #year]
  }
  if volume != "" {
    if issue != "" {
      journal-part = [#journal-part, #volume\(#issue\)]
    } else {
      journal-part = [#journal-part, #volume]
    }
  }
  if pages != "" {
    journal-part = [#journal-part: #pages]
  }
  let result = [#author-str. #title\[J\]. #journal-part.]
  if doi != "" {
    result = [#result doi: #doi.]
  }
  result
}

// APA 7th edition format
#let format-apa(
  authors: (),
  title: "",
  journal: "",
  year: "",
  volume: "",
  issue: "",
  pages: "",
  doi: "",
) = {
  // Format authors: LastName, F. M., & LastName, F. M.
  let n = authors.len()
  let formatted-authors = if n == 0 {
    []
  } else if n == 1 {
    authors.at(0)
  } else if n == 2 {
    [#authors.at(0), \& #authors.at(1)]
  } else {
    let all-but-last = authors.slice(0, n - 1).join(", ")
    [#all-but-last, \& #authors.at(n - 1)]
  }

  let result = [#formatted-authors. (#year). #title.]
  let journal-part = [*#journal*]
  if volume != "" {
    journal-part = [#journal-part, *#volume*]
  }
  if issue != "" {
    journal-part = [#journal-part\(#issue\)]
  }
  if pages != "" {
    journal-part = [#journal-part, #pages]
  }
  result = [#result #journal-part.]
  if doi != "" {
    result = [#result https://doi.org/#doi]
  }
  result
}

// IEEE format
#let format-ieee(
  authors: (),
  title: "",
  journal: "",
  year: "",
  volume: "",
  issue: "",
  pages: "",
  doi: "",
) = {
  let author-str = authors.join(", ")
  let result = [#author-str, "#title,"]
  let journal-part = [ *#journal*]
  if volume != "" {
    journal-part = [#journal-part, vol. #volume]
  }
  if issue != "" {
    journal-part = [#journal-part, no. #issue]
  }
  if pages != "" {
    journal-part = [#journal-part, pp. #pages]
  }
  if year != "" {
    journal-part = [#journal-part, #year]
  }
  result = [#result #journal-part.]
  if doi != "" {
    result = [#result doi: #doi.]
  }
  result
}

// MLA 9th edition format
#let format-mla(
  authors: (),
  title: "",
  journal: "",
  year: "",
  volume: "",
  issue: "",
  pages: "",
  doi: "",
) = {
  let n = authors.len()
  let formatted-authors = if n == 0 {
    []
  } else if n == 1 {
    authors.at(0)
  } else {
    [#authors.at(0), et al.]
  }

  let result = [#formatted-authors. "#title."]
  let journal-part = [ *#journal*]
  if volume != "" {
    journal-part = [#journal-part, vol. #volume]
  }
  if issue != "" {
    journal-part = [#journal-part, no. #issue]
  }
  if year != "" {
    journal-part = [#journal-part, #year]
  }
  if pages != "" {
    journal-part = [#journal-part, pp. #pages]
  }
  result = [#result #journal-part.]
  if doi != "" {
    result = [#result https://doi.org/#doi]
  }
  result
}

// Main article function
#let article(
  authors: (),              // 作者列表（数组）
  highlight-authors: (),    // 需要加粗的作者索引（数组，从0开始）
  corresponding-authors: (),// 通讯作者索引（数组，从0开始）
  title: "",                // 论文标题
  journal: "",              // 期刊名
  year: "",                 // 年份
  volume: "",               // 卷号
  issue: "",                // 期号
  pages: "",                // 页码
  doi: "",                  // DOI
  url: "",                  // URL
  note: "",                 // 备注
  style: "gb-7714",         // 引用格式：gb-7714, apa, ieee, mla
  list-style: "bullet",     // 列表样式：bullet, none, number
  spacing: -0.2em,          // 条目间距
  number: none,             // 手动指定编号（可选，覆盖自动编号）
) = {
  // Format authors with highlight and corresponding author markers
  let formatted-authors = authors.enumerate().map(((i, author)) => {
    let formatted = author
    // Highlight (bold) author
    if i in highlight-authors {
      formatted = strong(author)
    }
    // Add corresponding author marker
    if i in corresponding-authors {
      formatted = [#formatted#super[\*]]
    }
    formatted
  })

  // Generate citation based on style
  let content = if style == "gb-7714" {
    format-gb7714(
      authors: formatted-authors,
      title: title,
      journal: journal,
      year: year,
      volume: volume,
      issue: issue,
      pages: pages,
      doi: doi,
    )
  } else if style == "apa" {
    format-apa(
      authors: formatted-authors,
      title: title,
      journal: journal,
      year: year,
      volume: volume,
      issue: issue,
      pages: pages,
      doi: doi,
    )
  } else if style == "ieee" {
    format-ieee(
      authors: formatted-authors,
      title: title,
      journal: journal,
      year: year,
      volume: volume,
      issue: issue,
      pages: pages,
      doi: doi,
    )
  } else if style == "mla" {
    format-mla(
      authors: formatted-authors,
      title: title,
      journal: journal,
      year: year,
      volume: volume,
      issue: issue,
      pages: pages,
      doi: doi,
    )
  } else {
    // Fallback to gb-7714
    format-gb7714(
      authors: formatted-authors,
      title: title,
      journal: journal,
      year: year,
      volume: volume,
      issue: issue,
      pages: pages,
      doi: doi,
    )
  }

  // Add URL if no DOI
  if doi == "" and url != "" {
    content = [#content #url]
  }

  // Add note
  if note != "" {
    content = [#content #note]
  }

  // Apply list style with spacing
  if list-style == "bullet" {
    [- #content]
    v(spacing)
  } else if list-style == "number" {
    context {
      let num = if number != none {
        number
      } else {
        _article-counter.get() + 1
      }
      _article-counter.update(n => n + 1)
      [\[#num\] #content]
    }
    v(spacing)
  } else {
    content
    v(spacing)
  }
}
