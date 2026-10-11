/**/

#let format_datetime(timestamp: datetime, has_time: false) = {
  let date_segment = [#timestamp.year() 年 #timestamp.month() 月 #timestamp.day() 日]
  if has_time {
    return [#date_segment #timestamp.hour() : #timestamp.minute() : #timestamp.second()]
  } else {
    return date_segment
  }
}

// TODO: implement.
#let set_comment(comments: (:)) = {
  let render(content) = text(size: 8pt)

  rect(radius: 6pt, fill: gray,
    for comment in comments {
      if type(comment) == content {}
      if type(comment) == array {}
    }
  )
}

#let content_opt(header, ..content_and_comment) = {
  // Oprate comment.
  let content = content_and_comment.pos().first()
  let comments = content_and_comment.pos().slice(1)

  // Body part.
  if comments.len() > 1 {
    box(
      grid(columns: (2fr, 9fr, 3fr))[#header][#par(first-line-indent: 2em, content)][#set_comment(comments)]
    )
  } else {
    box(
      grid(columns: (1fr, 6fr))[#header][#par(first-line-indent: 2em, content)]
    )
  }
}

#let record(color: none, sign: none, name, ..content_and_comment) = {
  // Header part.
  let header = ""
  let header_common_args = arguments(font: "SimHei", weight: 500, name)
  if color == none {
    header = text(..header_common_args)
  } else {
    header = text(..header_common_args, fill: color)
  }
  // if use sign, replace name.
  if sign != none {
    let color_in_sign = if color != none {color} else {"black"}
    header = text(color: color_in_sign, sign)
  }

  content_opt(header, ..content_and_comment)
}

#let follow(..content_and_comments) = content_opt([], ..content_and_comments)

/**
 * Present interview.
 */
#let interview(
  title: none,
  subtitle: none,
  interviewer: none,
  interviewee: none,
  interview_time: datetime.today(),
  interview_method: none,
  theme: none,
  archive_name: none,
  transcript: none,
  brief_intro: none,
  meta_extra: (:),
  context_extra: (:),
  body
) = {
  set page(
    paper: "a4",
    margin: 1.15in,
    numbering: "1"
  )

  // Title
  let gen_title(title, subtitle) = {
    if title == none {
      return []
    } else {
      if subtitle == none {
        return text(17pt, font: "SimHei")[*#title*]
      } else {
        return [
          #text(17pt, font: "SimHei")[*#title*] \
          #text(15pt, subtitle)]
      }
    }
  }
  align(center, gen_title(title, subtitle))
  // insert a blank line if title is not none.
  if gen_title(title, subtitle) != [] {
    [\ ]
  }

  // Meta
  let fields = (
    interviewer: "采访者",
    interviewee: "受访者",
    theme: "采访主题",
    method: "采访方式",
    interview_time: "访谈时间",
    archive_name: "存档名",
    transcript: "转录者",
  )
  let special_fields = (fields.archive_name, fields.interview_time)
  // let name_fields = (fields.interviewer, fields.interviewee, fields.transcript)
  let gen_mata(items) = {
    [
      #set par(leading: 8pt)
      #set block(spacing: 8pt)
      #for (key, value) in items {
        if key in special_fields and value != none {
          if key == fields.interview_time {
            // 时间修正为特定的格式
            grid(
              columns: (1fr, 4fr), [#fields.interview_time：],
              format_datetime(timestamp: value)
            )
          }
          if key == fields.archive_name {
            // 存档名选择等线字体
            grid(
              columns: (1fr, 4fr), [#fields.archive_name：],
              text(font: "Consolas", weight: 400, value)
            )
          }
        } else {
          if  value != none {grid(columns: (1fr, 4fr), [#key：], value)}
          // if none => do nothing.
        }
      }
    ]
  }

  align(center,
    [
    // Meta section.
      #set block(width: 80%)
      #set text(font: "SimSun")
      #block(width: 80%, align(left, gen_mata((
        fields.interviewer: interviewer,
        fields.interviewee: interviewee,
        fields.interview_time: interview_time,
        fields.theme: theme,
        fields.method: interview_method,
        fields.archive_name: archive_name,
        fields.transcript: transcript,
      ) + meta_extra)))

    \ // Blank line.
    ]
  )

  // Brief intro and context
  align(center, [
    #block(
      width: 92%,
      [
        #if brief_intro != none {
          [#text(font: "SimHei", "受访者的小传", size: 11pt)
          #par(first-line-indent: 2em, align(left, brief_intro))]
        }
        #if context_extra.len() > 0 {
          for (title, body) in context_extra {
            [#text(font: "SimHei", title, size: 11pt)
            #par(first-line-indent: 2em, align(left, body))]
          }
        }
      ]
    )
  ])

  [\ #body]
}
