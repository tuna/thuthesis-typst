/// Front Matter Layout
#let front-matter(
  twoside: false, // (bool, str) Enable two-sided layout.
  page-numbering: "I", // (str) Page numbering format.
  it, // (content) Content to render.
) = {
  import "../utils/util.typ": twoside-pagebreak

  twoside-pagebreak(twoside)

  // Reset the counter of pages
  counter(page).update(1)

  set page(numbering: page-numbering)

  it
}
