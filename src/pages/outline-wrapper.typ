/// Outline Wrapper Page
#let outline-wrapper(
  twoside: false, // (bool, str) Enable two-sided layout.
  fonts: (:), // (dictionary) Font family configuration.
  depth: 3, // (int) The maximum depth of the outline.
  font: ("HeiTi", "SongTi"), // (array) The font family for each heading level.
  size: ("小四",), // (array) The font size for each heading level.
  title: [目　录], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  above: (10.5pt, 11.8pt), // (array) The vertical space above each heading based on its level.
  below: (11.4pt, 11.8pt), // (array) The vertical space below each heading based on its level.
  indent: (0pt, 12pt, 12pt), // (array) The indentation for each heading level.
  gap: .3em, // (length) The gap between the heading and the numbering.
  fill: (repeat([.], gap: .1pt),), // (array) The fill content for the outline entries.
) = {
  import "../utils/font.typ": _use-fonts, use-size
  import "../utils/util.typ": array-at, is-not-empty, twoside-pagebreak

  /// Parse the outline configuration
  font = font.map(name => _use-fonts(fonts, name))

  size = size.map(use-size)

  /// Render the outline
  twoside-pagebreak(twoside)

  heading(level: 1, outlined: outlined, bookmarked: bookmarked, title)

  // set outline style
  set outline(indent: level => indent
    .slice(0, calc.min(level + 1, indent.len()))
    .sum())

  show outline.entry: it => link(
    it.element.location(),
    it.indented(
      none,
      par(
        {
          text(font: array-at(font, it.level), size: array-at(size, it.level), {
            if is-not-empty(it.prefix()) {
              it.prefix()
              h(gap)
            }
            it.body()
          })
          box(width: 1fr, inset: (x: .25em), array-at(fill, it.level))
          it.page()
        },
        first-line-indent: 0pt,
        hanging-indent: 1.5em,
      ),
      gap: 0pt,
    ),
  )

  // display the outline
  outline(title: none, depth: depth)
}
