// SPDX-FileCopyrightText: 2023 Jade Lovelace
//
// SPDX-License-Identifier: MIT

/*
 * Generated AST:
 * (change_indent: int, body: ((ast | content)[] | content | ast)
 */

#let ast_to_content_list(indent, ast) = {
    if type(ast) == "array" {
        ast.map(d => ast_to_content_list(indent, d))
    } else if type(ast) == "content" {
        (pad(left: indent * 0.5em, ast),)
    } else if type(ast) == "dictionary" {
        let new_indent = ast.at("change_indent", default: 0) + indent
        ast_to_content_list(new_indent, ast.body)
    }
}

#let algorithm(..bits, algorithm_name, algorithm_seq, algorithm_input, algorithm_output) = {
  let content = bits.pos().map(b => ast_to_content_list(0, b)).flatten()
  let table_bits = ()
  let lineno = 1
  let no = 0
  set par(leading: 0.5em, spacing: 0.5em)
  while no < content.len() {
      table_bits.push([#lineno])
      table_bits.push(content.at(no))
      lineno = lineno + 1
      no = no + 1
  }

  table(stroke: none, columns: (100%),
    table.hline(start: 0, stroke: 1pt),
    text(font: "Times New Roman")[*Algorithm #algorithm_seq: * #algorithm_name],
    table.hline(start: 0, stroke: 0.5pt),
    text(font: "Times New Roman")[*Input: * #algorithm_input],
    text(font: "Times New Roman")[*Output: * #algorithm_output],
    [
      #table(
          columns: (18pt, 100%),
          // line spacing
          inset: 0.3em,
          stroke: none,
          ..table_bits
      )
    ],
    table.hline(start: 0, stroke: 0.5pt),
  )
}

#let iflike_block(kw1: "", kw2: "", cond: "", ..body) = (
    (strong(kw1) + " " + cond + " " + strong(kw2)),
    // XXX: .pos annoys me here
    (change_indent: 4, body: body.pos())
)

#let function_like(name, kw: "function", args: (), ..body) = (
    iflike_block(kw1: kw, cond: (smallcaps(name) + "(" + args.join(", ") + ")"), ..body)
)

#let listify(v) = {
    if type(v) == "list" {
        v
    } else {
        (v,)
    }
}

#let Function = function_like.with(kw: "function")
#let Procedure = function_like.with(kw: "procedure")

#let State(block) = ((body: block),)

/// Inline call
#let CallI(name, args) = smallcaps(name) + "(" + listify(args).join(", ") + ")"
#let Call(..args) = (CallI(..args),)
#let FnI(f, args) = strong(f) + " (" + listify(args).join(", ") + ")"
#let Fn(..args) = (FnI(..args),)
#let Ic(c) = sym.triangle.stroked.r + " " + c
#let Cmt(c) = (Ic(c),)
// It kind of sucks that Else is a separate block but it's fine
#let If = iflike_block.with(kw1: "if", kw2: "then")
#let While = iflike_block.with(kw1: "while", kw2: "do")
#let For = iflike_block.with(kw1: "for", kw2: "do")
#let Assign(var, val) = (var + " " + $<-$ + " " + val,)

#let Else = iflike_block.with(kw1: "else")
#let ElsIf = iflike_block.with(kw1: "else if", kw2: "then")
#let ElseIf = ElsIf
#let Return(arg) = (strong("return") + " " + arg,)