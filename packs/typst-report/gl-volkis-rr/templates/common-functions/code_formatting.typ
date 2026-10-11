#let code_formatting(it) = [#show raw.where(block: true): it => {
    set par(justify: false)
    block(radius: 1em, fill: luma(246), width: 100%, inset: 1em, it)
}
#it]