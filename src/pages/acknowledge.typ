/// Acknowledgement Page
#let acknowledge(
  anonymous: false, // (bool) Hide identifying information.
  twoside: false, // (bool, str) Enable two-sided layout.
  title: [致　谢], // (content) Page title.
  title-vspace: 2pt, // (length) The vertical space after the title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  it, // (content) Content to render.
) = {
  if anonymous { return }

  import "../utils/util.typ": twoside-pagebreak

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  v(title-vspace)

  it
}
