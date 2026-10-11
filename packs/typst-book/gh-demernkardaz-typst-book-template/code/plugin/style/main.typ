#import "../../utils/lib.typ": parse-value, regex-rules

#let _parse-dict(dict) = {
  let result = (:)
  for (k, v) in dict {
    result.insert(k, if type(v) == dictionary {
      _parse-dict(v)
    } else {
      parse-value(v)
    })
  }
  result
}

#let use(targets: "", name: "", body) = {
  let target-list = targets
    .split(" ")
    .map(t => t.trim())
    .filter(t => t.len() > 0)

  let apply-par(body) = {
    let path = if name == "" {
      "../../../style/paragraph.yml"
    } else {
      "../../../style/paragraph/" + name + ".yml"
    }
    let data = _parse-dict(yaml(path))
    set par(..data)
    body
  }

  let apply-text(body) = {
    let path = if name == "" {
      "../../../style/text.yml"
    } else {
      "../../../style/text/" + name + ".yml"
    }
    let data = _parse-dict(yaml(path))
    set text(..data)
    body
  }

  for target in target-list {
    if target == "par" {
      body = apply-par(body)
    } else if target == "text" {
      body = apply-text(body)
    }
  }

  body
}

#let use-par(name: "", body) = {
  let path = if name == "" {
    "../../../style/paragraph.yml"
  } else {
    "../../../style/paragraph/" + name + ".yml"
  }

  let data = _parse-dict(yaml(path))

  set par(..data)

  body
}

#let use-text(name: "", body) = {
  let path = if name == "" {
    "../../../style/text.yml"
  } else {
    "../../../style/text/" + name + ".yml"
  }

  let data = _parse-dict(yaml(path))

  set text(..data)

  body
}
