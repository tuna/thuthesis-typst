/// Spine Page
#let spine(
  info: (:), // (dictionary) The information to be displayed on the spine page.
  fonts: (:), // (dictionary) Font family configuration.
  twoside: false, // (bool, str) Enable two-sided layout.
  anonymous: false, // (bool) Hide identifying information.
  text-font: "FangSong", // (str) The font family to use for the text on the spine.
  text-size: "三号", // (str | length) The font size to use for the text on the spine.
) = {
  import "../utils/font.typ": _use-fonts, use-size
  import "../utils/util.typ": parsed-title, twoside-pagebreak

  info.title = context if "title" in info {
    parsed-title(info.title).sum()
  } else { document.title }
  info.author = context info.at("author", default: document.author.first())

  let use-fonts = name => _use-fonts(fonts, name)

  /// Render
  twoside-pagebreak(twoside)

  set page(margin: (x: 1cm, y: 5.4cm))
  set text(font: use-fonts(text-font), size: use-size(text-size))

  place(right + top, {
    show regex("[\p{script=Han}]"): it => box(rotate(it, -90deg))
    rotate(info.title, 90deg, origin: right + top, reflow: true)
  })

  // Note that the specification does not require the anonymous behavior
  if anonymous { return }

  place(right + bottom, {
    show regex("[\p{script=Han}]"): it => box(rotate(it, -90deg), width: 1cm)
    rotate(info.author, 90deg, origin: right + top, reflow: true)
  })
}
