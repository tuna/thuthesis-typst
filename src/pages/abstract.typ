/// Abstract Page (Simplified Chinese version)
#let abstract(
  fonts: (:), // (dictionary) Font family configuration.
  twoside: false, // (bool, str) Enable two-sided layout.
  title: [摘　要], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  embeded: true, // (bool) Write the abstract and keywords to PDF metadata.
  back: [*关键词：*], // (content) The back text.
  back-font: "HeiTi", // (str) The font for the back text.
  back-indent: 0em, // (length) The first line indent for the back text.
  back-vspace: 1.7em, // (length) The vertical space after the abstract content.
  keywords: (), // (array) Keywords to be included in the abstract.
  keyword-sperator: "；", // (str) Keyword separator.
  keyword-font: "SongTi", // (str) The font for the keywords.
  it, // (content) Content to render.
) = {
  import "../utils/font.typ": _use-fonts
  import "../utils/util.typ": twoside-pagebreak

  let use-fonts = name => _use-fonts(fonts, name)

  twoside-pagebreak(twoside)

  heading(level: 1, outlined: outlined, bookmarked: bookmarked, title)

  it

  v(back-vspace)

  par(
    first-line-indent: back-indent,
    text(font: use-fonts(back-font), back)
      + text(font: use-fonts(keyword-font), keywords.join(keyword-sperator)),
  )

  set document(keywords: keywords, description: it) if embeded
}

/// Abstract Page (English version), Inherited from the Chinese version
#let abstract-en = abstract.with(
  title: [ABSTRACT],
  embeded: false,
  back: [*Keywords: *],
  back-font: "SongTi",
  keyword-sperator: "; ",
)
