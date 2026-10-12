/// Meta Information for the Document / PDF
#let meta(
  info: (:), // (dictionary) The metadata for the document, including title and author.
  lang: "zh", // (str) Document language.
  region: auto, // (str, auto) Text region; auto selects cn or us from the language.
  margin: 3cm, // (margin) The margin settings for the document.
  paper: "a4", // (str) Paper size.
  fallback: false, // (bool) Allow fallback fonts for missing glyphs.
  use-fakebold: auto, // (bool, auto) Use fake bold for Chinese text.
  use-latexref: false, // (bool) Whether to apply LaTeX/i-figured reference compatibility.
  unnumbered-label: "-", // (str) The label for unnumbered equations.
  extra-prefixes: (), // (array) Additional prefixes for LaTeX references.
  default-prefixes: ("fig:", "tbl:", "eqt:", "lst:", "img:"), // (array) Default prefixes for LaTeX references.
  it, // (content) Content to render.
) = {
  import "../utils/util.typ": show-latexref

  import "../imports.typ": cuti
  import cuti: show-cn-fakebold

  region = if region == auto { if lang == "zh" { "cn" } else { "us" } } else {
    region
  }
  use-fakebold = if use-fakebold == auto { lang == "zh" } else { use-fakebold }

  // Apply LaTeX/i-figured reference compatibility
  show: if use-latexref {
    show-latexref.with(default-prefixes + extra-prefixes)
  } else { it => it }

  // Fix for Chinese fake bold rendering
  show: if use-fakebold { show-cn-fakebold } else { it => it }

  // Apply unnumbered equation label
  show math.equation.where(label: label(unnumbered-label)): set math.equation(
    numbering: none,
  ) if not (
    unnumbered-label in ("", none)
  )

  show <__tntt:pagebreak-blank-only>: it => (
    if calc.even(here().page()) { counter(page).update(p => p - 1) } + it
  )

  set text(fallback: fallback, lang: lang, region: region)

  set page(margin: margin, paper: paper)

  set heading(bookmarked: true)

  set document(title: info.title.sum(), author: info.author, date: info.date)

  it
}

/// Document Configuration
#let doc(
  fonts: (:), // (dictionary) Font family configuration.
  indent: 2em, // (length) Paragraph indentation.
  justify: true, // (bool) Whether to justify text in paragraphs.
  leading: 0.98em, // (length) The leading (line height) for paragraphs.
  spacing: 0.98em, // (length) The spacing (line spacing) between paragraphs.
  code-block-leading: 1em, // (length) The leading for code blocks.
  code-block-spacing: 1em, // (length) The spacing for code blocks.
  heading-font: ("HeiTi",), // (array) The font for headings.
  heading-size: ("三号", "四号", "中四", "小四"), // (array) Named or absolute font sizes by heading level.
  heading-front-vspace: (28.6pt, 0pt), // (array) The vertical space before the heading.
  heading-back-vspace: (9.4pt, 0pt), // (array) The vertical space after the heading.
  heading-above: (0pt, 25.1pt, 22pt), // (array) The space above the heading.
  heading-below: (21.2pt, 18.6pt), // (array) The space below the heading.
  heading-align: (center, left), // (array) The alignment of headings.
  heading-weight: ("regular",), // (array) The font weight for headings.
  heading-pagebreak: (true, false), // (array) Whether to insert a page break before the headings.
  body-font: "SongTi", // (str) The font for body text.
  body-size: "小四", // (length, str) The size of body text, can be length value or str.
  header-display: false, // (bool) Whether to display headers.
  header-stroke: 1pt + black, // (stroke) The stroke for the header line.
  header-ascent: 10% + 0pt, // (length) The ascent for the header.
  header-font: "SongTi", // (str) The font for headers.
  header-size: "五号", // (length, str) Header font size.
  footnote-font: "SongTi", // (str) The font for footnotes.
  footnote-size: "小五", // (length, str) The size of footnotes, can be length value or str.
  footnote-style: "normal", // ("normal", "super") Footnote marker style.
  footnote-reset: "by-page", // ("by-page", "by-chapter", "off") Footnote counter reset scope.
  footnote-numbering: "①", // (str) The numbering style for footnotes.
  footnote-hanging-indent: 1.5em, // (length) Hanging indent of footnote entries.
  math-font: "Math", // (str) The font for math equations.
  math-size: "小四", // (length, str) Math font size.
  raw-font: "Mono", // (str) The font for raw text.
  raw-size: "五号", // (length, str) The size of raw text, can be length value or str.
  caption-font: "SongTi", // (str) The font for captions.
  caption-size: "五号", // (length, str) Caption font size.
  caption-style: strong, // (function) The style of captions.
  caption-separator: "  ", // (str) The separator for captions.
  underline-offset: .1em, // (length) The offset for underlines.
  underline-stroke: .05em, // (stroke) The stroke for underlines.
  underline-evade: false, // (bool) Whether to evade underlines for certain elements.
  cite-style: "super", // ("normal", "super") Citation marker style.
  bibliography-font: "SongTi", // (str) The font for bibliography entries.
  bibliography-size: "五号", // (length, str) Bibliography font size.
  bibliography-spacing: 12pt, // (length) The spacing for bibliography entries.
  extra-fig-kinds: (), // (array) Additional figure kinds whose counters reset by chapter.
  outline-fill: repeat([.], gap: .1pt), // (content) Fill between outline entries and page numbers.
  it, // (content) Content to render.
) = {
  import "../utils/font.typ": _use-en-font, _use-fonts, use-size
  import "../utils/util.typ": array-at

  /// Auxiliary functions
  let use-fonts = _use-fonts.with(fonts)

  /// Render the document with the specified fonts and styles.
  /// Paragraph
  set par(
    justify: justify,
    leading: leading,
    spacing: spacing,
    first-line-indent: (amount: indent, all: true),
  )

  /// List
  set list(indent: indent)

  /// Enum
  set enum(indent: indent)

  /// Term
  show terms: set par(first-line-indent: 0em)

  /// Heading
  // TODO: use `show-set` instead of `show-closure` for better override ability
  show heading: set text(
    font: use-fonts(heading-font.last()),
    weight: heading-weight.last(),
  )
  show heading: it => {
    if array-at(heading-pagebreak, it.level) { pagebreak(weak: true) }

    v(array-at(heading-front-vspace, it.level))

    align(array-at(heading-align, it.level), block(
      above: array-at(heading-above, it.level),
      below: array-at(heading-below, it.level),
      text(
        size: use-size(array-at(heading-size, it.level)),
        font: use-fonts(array-at(heading-font, it.level)),
        weight: array-at(heading-weight, it.level),
        it,
      ),
    ))

    v(array-at(heading-back-vspace, it.level))
  }

  // Reset counters by chapter
  show heading.where(level: 1): it => {
    it
    for target in (
      math.equation,
      ..(image, table, raw, grid, ..extra-fig-kinds).map(kind => figure.where(
        kind: kind,
      )),
    ) { counter(target).update(0) }
  }

  /// Body Text
  set text(font: use-fonts(body-font), size: use-size(body-size))

  /// Smartquote
  show smartquote: set text(font: _use-en-font(fonts, body-font))

  /// Header & Footer
  set page(header-ascent: header-ascent, header: context {
    if footnote-reset == "by-page" { counter(footnote).update(0) }

    let head = query(selector(heading.where(level: 1)).after(here()))
      .filter(it => it.location().page() == here().page())
      .first(default: none)

    if head != none {
      if footnote-reset == "by-chapter" { counter(footnote).update(0) }
    } else {
      head = query(selector(heading.where(level: 1)).before(here())).last(
        default: none,
      )
    }

    if head == none or not header-display { return }

    align(center, text(
      size: use-size(header-size),
      font: use-fonts(header-font),
      {
        if head.numbering != none {
          numbering(head.numbering, ..counter(heading).at(head.location()))
        }
        head.body
      },
    ))

    v(-0.6em)

    line(length: 100%, stroke: header-stroke)
  })

  set footnote(numbering: footnote-numbering)

  show footnote: it => if footnote-style == "normal" {
    // unset super style, only for bachelor thesis
    show super: it => it.body
    it
  } else if footnote-style == "super" { it } else {
    panic("Unknown footnote-style: " + footnote-style)
  }

  show footnote.entry: set text(
    font: use-fonts(footnote-font),
    size: use-size(footnote-size),
  )

  show footnote.entry: it => par(
    hanging-indent: footnote-hanging-indent,
    first-line-indent: 0em,
  )[
    #numbering(it.note.numbering, ..counter(footnote).at(it.note.location()))
    #it.note.body
  ]

  /// Math Equation
  show math.equation: set text(
    font: use-fonts(math-font),
    size: use-size(math-size),
  )

  /// Raw
  show raw: set text(font: use-fonts(raw-font), size: use-size(raw-size))
  // unset paragraph for raw block
  show raw.where(block: true): set par(
    leading: code-block-leading,
    spacing: code-block-spacing,
  )

  /// Underline
  set underline(
    offset: underline-offset,
    stroke: underline-stroke,
    evade: underline-evade,
  )

  /// Figure
  show figure.where(kind: table): set figure.caption(position: top)

  /// Figure Caption
  set figure.caption(separator: caption-separator)

  show figure.caption: caption-style
  show figure.caption: set text(
    font: use-fonts(caption-font),
    size: use-size(caption-size),
  )

  /// Bibliography
  show cite: it => if cite-style == "normal" {
    // unset super style, for bachelor thesis
    show super: it => it.body
    it
  } else if cite-style == "super" { it } else {
    panic("Unknown cite-style: " + cite-style)
  }

  show bibliography: set text(
    font: use-fonts(bibliography-font),
    size: use-size(bibliography-size),
  )

  show bibliography: set par(spacing: bibliography-spacing)

  set outline.entry(fill: outline-fill)
  show outline.entry: set par(justify: true)

  /// Content
  it
}
