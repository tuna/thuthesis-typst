/// Main Matter Layout
#let main-matter(
  twoside: false, // (bool, str) Enable two-sided layout.
  page-numbering: "1", // (str) Page numbering format.
  heading-numbering: (formats: ("第1章", "1.1"), depth: 4, supplyment: " "), // (dictionary) Heading numbering.
  figure-numbering: auto, // (str, auto) Figure numbering format.
  subfig-numbering: auto, // (str, auto) Subfigure numbering format.
  equation-numbering: auto, // (str, auto) Equation numbering format.
  subfig-outlined: true, // (bool) Include subfigures in the figure index.
  subfig-numbering-extended: true, // (bool) Prefix subfigure numbers with the figure number.
  it, // (content) Content to render.
) = {
  import "../utils/font.typ": use-size
  import "../utils/util.typ": (
    array-at, multi-numbering, show-grid-figure, twoside-pagebreak,
  )

  if figure-numbering == auto {
    figure-numbering = heading-numbering.formats.last()
  }
  if subfig-numbering == auto { subfig-numbering = "(a)" }
  if equation-numbering == auto {
    equation-numbering = "(" + heading-numbering.formats.last() + ")"
  }

  let fold-numbering = (format, ..nums) => numbering(
    format,
    counter(heading).get().first(),
    ..nums,
  )

  if type(figure-numbering) == str {
    if type(subfig-numbering) == str and subfig-numbering-extended {
      subfig-numbering = (..p, n) => fold-numbering(
        figure-numbering + subfig-numbering,
        ..p,
        n,
      )
    }
    figure-numbering = n => fold-numbering(figure-numbering, n)
  }
  if type(equation-numbering) == str {
    equation-numbering = n => fold-numbering(equation-numbering, n)
  }

  // Page break
  twoside-pagebreak(twoside)

  set heading(numbering: multi-numbering.with(..heading-numbering))

  set math.equation(numbering: equation-numbering)

  counter(page).update(1)

  set page(numbering: page-numbering)

  show-grid-figure(
    figure-numbering,
    subfig-numbering,
    subfig-numbering-extended,
    subfig-outlined,
    it,
  )
}
