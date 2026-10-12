/// Figure and Table Index Page
#let figure-table-list(
  twoside: false, // (bool, str) Enable two-sided layout.
  title: [插图和附表清单], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
) = {
  import "../utils/util.typ": twoside-pagebreak

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  outline(target: figure.where(kind: image), title: none)

  par[] // add a blank line

  outline(target: figure.where(kind: table), title: none)
}

/// Common list page of single target
#let _list-of(
  twoside: false, // (bool, str) Enable two-sided layout.
  title: [清单], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  target: figure, // (selector) The target selector for the outline.
) = {
  import "../utils/util.typ": twoside-pagebreak

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  outline(target: target, title: none)
}

/// Master List Page
#let master-list = _list-of.with(title: [插图和附表清单], target: figure)

/// Figure Index Page
#let figure-list = _list-of.with(
  title: [插图清单],
  target: figure.where(kind: image).or(figure.where(kind: grid)),
)

/// Table Index Page
#let table-list = _list-of.with(
  title: [附表清单],
  target: figure.where(kind: table),
)

/// Equation Index Page
#let equation-list = _list-of.with(title: [公式清单], target: math.equation)
