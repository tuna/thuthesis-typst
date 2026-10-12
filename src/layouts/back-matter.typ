/// Back Matter Layout
#let back-matter(
  twoside: false, // (bool, str) Enable two-sided layout.
  heading-numbering: (formats: ("附录A", "A.1"), depth: 4, supplyment: " "), // (dictionary) Heading numbering.
  figure-outlined: false, // (bool) Include figures in the figure index.
  figure-numbering: auto, // (str, auto) Figure numbering format.
  subfig-numbering: auto, // (str, auto) Subfigure numbering format.
  equation-numbering: auto, // (str, auto) Equation numbering format.
  subfig-numbering-extended: true, // (bool) Prefix subfigure numbers with the figure number.
  subfig-outlined: true, // (bool) Include subfigures in the figure index.
  reset-counter: false, // (bool) Whether to reset the pages counter.
  it, // (content) Content to render.
) = {
  import "../utils/util.typ": (
    multi-numbering, show-grid-figure, twoside-pagebreak,
  )

  let __page-reset = state("__tntt:back-matter-page-reset", false)

  subfig-outlined = figure-outlined and subfig-outlined

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

  set figure(outlined: figure-outlined)

  // Reset the counter and numbering of headings
  counter(heading).update(0)

  set heading(
    numbering: multi-numbering.with(..heading-numbering),
    outlined: false,
  )
  // Only level 1 headings of the appendices are shown in the outline
  show heading.where(level: 1): set heading(outlined: true)

  set math.equation(numbering: equation-numbering)

  // Reset the counter of pages at the first level 1 heading,
  // to avoid resetting on blank pages without headings when twoside is enabled.
  show heading.where(level: 1): it => {
    it
    if reset-counter and not __page-reset.get() {
      counter(page).update(1) + __page-reset.update(true)
    }
  }

  show-grid-figure(
    figure-numbering,
    subfig-numbering,
    subfig-numbering-extended,
    subfig-outlined,
    it,
  )
}
