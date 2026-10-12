/// Notation Page
#let notation(
  twoside: false, // (bool, str) Enable two-sided layout.
  title: [符号和缩略语说明], // (content) Page title.
  outlined: false, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  width: 100%, // (length, relative) The width of the notation grid.
  columns: (96pt, 1fr), // (array) The widths of the grid columns for terms and descriptions.
  row-gutter: 12pt, // (length) The vertical space between rows.
  chunked: false, // (bool) Whether to chunk the content by parbreaks.
  blank-row-gutter: none, // (length, none) Blank-row spacing; none uses 1.5 times row-gutter.
  it, // (content) Content to render.
) = {
  assert(
    type(row-gutter) == length,
    message: "row-gutter must be a length value here.",
  )

  import "../utils/util.typ": twoside-pagebreak

  let blank-row-gutter = if blank-row-gutter == none { 1.5 * row-gutter } else {
    blank-row-gutter
  }

  let blank-row-inset = if chunked {
    (blank-row-gutter - 2 * row-gutter) / 2
  } else { -row-gutter / 2 }

  let select-term = it => if (it.func() == terms.item) {
    (it.term, it.description)
  } else {
    grid.cell(none, colspan: 2, inset: (y: blank-row-inset)) // it.func() == parbreak
  }

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  align(center, block(width: width, align(start, grid(
    columns: columns, row-gutter: row-gutter,
    ..it
      .children
      .filter(it => it.func() == parbreak or it.func() == terms.item)
      .map(select-term)
      .flatten()
  ))))
}
