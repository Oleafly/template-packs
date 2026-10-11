/*
 * Book component for academic CV
 * Supports books and book chapters with multiple citation styles
 */

// Counter for numbered list
#let _book-counter = state("book-counter", 0)

// Reset the book counter (call at the beginning of a section)
#let reset-book-counter() = {
  _book-counter.update(0)
}

// GB/T 7714-2015 format for books
#let format-book-gb7714(
  authors: (),
  title: "",
  publisher: "",
  location: "",
  year: "",
  pages: "",
  chapter: "",
  chapter-authors: (),
) = {
  let author-str = authors.join(", ")

  if chapter != "" {
    // Book chapter format: 章节作者. 章节名[M]//全书作者. 书名. 出版地: 出版社, 出版年: 页码.
    let chapter-author-str = if chapter-authors.len() > 0 {
      chapter-authors.join(", ")
    } else {
      author-str
    }
    let result = [#chapter-author-str. #chapter\[M\]#("//")#author-str. #title. #location: #publisher, #year]
    if pages != "" {
      result = [#result: #pages.]
    } else {
      result = [#result.]
    }
    result
  } else {
    // Whole book format
    [#author-str. #title\[M\]. #location: #publisher, #year.]
  }
}

// APA 7th edition format for books
#let format-book-apa(
  authors: (),
  title: "",
  publisher: "",
  location: "",
  year: "",
  pages: "",
  chapter: "",
  chapter-authors: (),
) = {
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

  if chapter != "" {
    // Book chapter format
    let cn = chapter-authors.len()
    let chapter-author-str = if cn > 0 {
      if cn == 1 {
        chapter-authors.at(0)
      } else if cn == 2 {
        [#chapter-authors.at(0), \& #chapter-authors.at(1)]
      } else {
        let all-but-last = chapter-authors.slice(0, cn - 1).join(", ")
        [#all-but-last, \& #chapter-authors.at(cn - 1)]
      }
    } else {
      formatted-authors
    }
    let result = [#chapter-author-str. (#year). #chapter. In *#title*]
    if pages != "" {
      result = [#result (pp. #pages)]
    }
    [#result. #publisher.]
  } else {
    // Whole book format
    [#formatted-authors. (#year). *#title*. #publisher.]
  }
}

// IEEE format for books
#let format-book-ieee(
  authors: (),
  title: "",
  publisher: "",
  location: "",
  year: "",
  pages: "",
  chapter: "",
  chapter-authors: (),
) = {
  let author-str = authors.join(", ")

  if chapter != "" {
    // Book chapter format
    let chapter-author-str = if chapter-authors.len() > 0 {
      chapter-authors.join(", ")
    } else {
      author-str
    }
    let result = [#chapter-author-str, "#chapter," in *#title*]
    if pages != "" {
      result = [#result, pp. #pages]
    }
    [#result. #location: #publisher, #year.]
  } else {
    // Whole book format
    [#author-str, *#title*. #location: #publisher, #year.]
  }
}

// Main book function
#let book(
  authors: (),              // 书籍作者列表
  highlight-authors: (),    // 需要加粗的作者索引（数组，从0开始）
  title: "",                // 书名
  publisher: "",            // 出版社
  location: "",             // 出版地
  year: "",                 // 年份
  pages: "",                // 页码（章节用）
  chapter: "",              // 章节名（书籍章节用）
  chapter-authors: (),      // 章节作者列表（书籍章节用）
  note: "",                 // 备注
  style: "gb-7714",         // 引用格式：gb-7714, apa, ieee
  list-style: "bullet",     // 列表样式：bullet, none, number
  spacing: -0.2em,          // 条目间距
  number: none,             // 手动指定编号（可选，覆盖自动编号）
) = {
  // Determine if we have chapter authors
  let has-chapter-authors = chapter-authors.len() > 0 and chapter != ""

  // Format authors with highlight (only if no chapter authors)
  let formatted-authors = if has-chapter-authors {
    // No highlight for book authors when chapter authors exist
    authors
  } else {
    authors.enumerate().map(((i, author)) => {
      if i in highlight-authors {
        strong(author)
      } else {
        author
      }
    })
  }

  // Format chapter authors with highlight (only if chapter authors exist)
  let formatted-chapter-authors = if has-chapter-authors {
    chapter-authors.enumerate().map(((i, author)) => {
      if i in highlight-authors {
        strong(author)
      } else {
        author
      }
    })
  } else {
    chapter-authors
  }

  // Generate citation based on style
  let content = if style == "gb-7714" {
    format-book-gb7714(
      authors: formatted-authors,
      title: title,
      publisher: publisher,
      location: location,
      year: year,
      pages: pages,
      chapter: chapter,
      chapter-authors: formatted-chapter-authors,
    )
  } else if style == "apa" {
    format-book-apa(
      authors: formatted-authors,
      title: title,
      publisher: publisher,
      location: location,
      year: year,
      pages: pages,
      chapter: chapter,
      chapter-authors: formatted-chapter-authors,
    )
  } else if style == "ieee" {
    format-book-ieee(
      authors: formatted-authors,
      title: title,
      publisher: publisher,
      location: location,
      year: year,
      pages: pages,
      chapter: chapter,
      chapter-authors: formatted-chapter-authors,
    )
  } else {
    format-book-gb7714(
      authors: formatted-authors,
      title: title,
      publisher: publisher,
      location: location,
      year: year,
      pages: pages,
      chapter: chapter,
      chapter-authors: formatted-chapter-authors,
    )
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
        _book-counter.get() + 1
      }
      _book-counter.update(n => n + 1)
      [\[#num\] #content]
    }
    v(spacing)
  } else {
    content
    v(spacing)
  }
}
