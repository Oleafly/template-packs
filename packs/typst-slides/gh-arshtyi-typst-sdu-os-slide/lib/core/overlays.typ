#import "../foundation/theme.typ": theme

#let _marker-kind = "sdu-os-slide-overlay-jump"

/// Creates an overlay jump marker.
///
/// `jump` is the common primitive behind `pause` and `meanwhile`.
/// With `relative: true`, `n` moves the current overlay step by a relative
/// amount. With `relative: false`, `n` sets the current overlay step
/// absolutely.
///
/// ```typ
/// Always visible.
///
/// #jump(2)
///
/// Hidden on overlay 1, visible from overlay 2.
/// ```
///
/// - n (int): Relative or absolute overlay step.
/// - relative (bool): Whether `n` is a relative offset. Defaults to `false`.
/// -> content
#let jump(n, relative: false) = {
    if relative {
        assert(
            type(n) == int and n != 0,
            message: "jump: n must be a non-zero integer when relative is true",
        )
    } else {
        assert(
            type(n) == int and n >= 1,
            message: "jump: n must be a positive integer when relative is false",
        )
    }
    metadata((
        kind: _marker-kind,
        n: n,
        relative: relative,
    ))
}

/// Advances to the next overlay step.
///
/// Content after `pause` is hidden on the current overlay and appears on the
/// next overlay. It is equivalent to `jump(1, relative: true)`.
///
/// ```typ
/// First point.
///
/// #pause
///
/// Second point.
/// ```
///
/// -> content
#let pause = jump(1, relative: true)

/// Resets subsequent content to the first overlay step.
///
/// Content after `meanwhile` appears together with the beginning of the slide,
/// while earlier paused content keeps its own reveal timing. It is equivalent
/// to `jump(1)`.
///
/// ```typ
/// Left story.
///
/// #pause
///
/// Left story, step 2.
///
/// #meanwhile
///
/// Right story starts on overlay 1.
/// ```
///
/// -> content
#let meanwhile = jump(1)

#let _sequence-func = [].func()
#let _styled-func = text(red)[].func()

#let _is-sequence(it) = type(it) == content and it.func() == _sequence-func

#let _is-styled(it) = type(it) == content and it.func() == _styled-func

#let _children(body) = if _is-sequence(body) {
    body.children
} else {
    (body,)
}

#let _flatten(item) = {
    if _is-sequence(item) {
        item.children.map(_flatten).flatten()
    } else if _is-styled(item) {
        _flatten(item.child)
    } else {
        (item,)
    }
}

#let _is-overlay-marker(it) = (
    type(it) == content
        and it.func() == metadata
        and type(it.value) == dictionary
        and it.value.at("kind", default: none) == _marker-kind
)

#let _is-slide-heading(it) = (
    type(it) == content
        and it.func() == heading
)

#let _is-explicit-pagebreak(it) = it in (pagebreak(), pagebreak(weak: true))

#let _is-slide-break(it) = _is-slide-heading(it) or _is-explicit-pagebreak(it)

#let _trim-empty(items) = {
    let empty = ([], [ ], parbreak(), linebreak())
    let start = 0
    let end = items.len()
    while start < end and items.at(start) in empty {
        start += 1
    }
    while end > start and items.at(end - 1) in empty {
        end -= 1
    }
    items.slice(start, end)
}

#let _overlay-count(items) = {
    let step = 1
    let max-step = 1
    for item in items {
        if _is-overlay-marker(item) {
            if item.value.relative {
                step += item.value.n
                assert(step >= 1, message: "jump: overlay step cannot be less than 1")
            } else {
                max-step = calc.max(max-step, step)
                step = item.value.n
            }
            max-step = calc.max(max-step, step)
        }
    }
    max-step
}

#let _render-overlay(items, index, handout: false) = {
    let step = 1
    let result = ()
    for item in items {
        if _is-overlay-marker(item) {
            if item.value.relative {
                step += item.value.n
                assert(step >= 1, message: "jump: overlay step cannot be less than 1")
            } else {
                step = item.value.n
            }
        } else if step <= index {
            if index > 1 and not handout and _is-slide-heading(item) {
                result.push(pagebreak(weak: true))
                if item.depth > 2 {
                    result.push({
                        set align(center)
                        text(size: 20pt, fill: theme.colors.primary, item.body)
                    })
                }
            } else {
                result.push(item)
            }
        } else {
            result.push(hide(item))
        }
    }
    result.sum(default: none)
}

#let _render-slide(items, handout: false) = {
    let items = _trim-empty(items)
    if items == () {
        return none
    }
    let count = _overlay-count(items)
    if handout {
        _render-overlay(items, count, handout: true)
    } else {
        for index in range(1, count + 1) {
            _render-overlay(items, index)
        }
    }
}

/// Renders a document body with slide overlays.
///
/// The renderer splits the body at headings and at
/// explicit `pagebreak()` calls. In presentation mode, each resulting slide is
/// duplicated once for each overlay step introduced by `pause`, `meanwhile`, or
/// `jump`. In handout mode, only the final overlay state of each slide is
/// rendered.
///
/// This is normally called by `setup()`; user documents usually call the
/// overlay markers instead.
///
/// - handout (bool): Whether to render only final overlay states. Defaults to `false`.
/// - body (content): Document body to render.
/// -> content
#let render-overlays(body, handout: false) = {
    let slides = ()
    let current = ()
    let children = _children(body).map(_flatten).flatten()
    for item in children {
        if _is-slide-break(item) and _trim-empty(current) != () {
            slides.push(current)
            current = ()
        }
        current.push(item)
    }
    if _trim-empty(current) != () {
        slides.push(current)
    }
    for slide in slides {
        _render-slide(slide, handout: handout)
    }
}
