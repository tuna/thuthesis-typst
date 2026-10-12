/// Cover Page
#let cover(
  anonymous: false, // (bool) Hide identifying information.
  fonts: (:), // (dictionary) Font family configuration.
  info: (:), // (dictionary) The information to be displayed on the cover page.
  degree: "bachelor", // (str) Degree level.
  degree-type: "academic", // (str) Degree type.
  doc-info: (:), // (dictionary) The document information to extend the info with.
  content: [], // (content) Custom cover content replacing the preset.
  info-items: (:), // (dictionary) Field labels.
  info-item-width: none, // (length, auto, none) Label width; auto fits labels, none uses the supervisor layout.
) = {
  import "../utils/font.typ": _use-cjk-fonts, _use-fonts, use-size
  import "../utils/util.typ": is-not-empty

  let fixed-text(str, width) = text(
    tracking: (width - str.clusters().len() * 1em) / (str.clusters().len() - 1),
    str,
  )

  info = doc-info + info

  let use-fonts = name => _use-fonts(fonts, name)
  let use-cjk-fonts = name => _use-cjk-fonts(fonts, name)
  let use-anonymous = width => block(width: width, fill: black, "", outset: (
    y: 2pt,
  ))

  let has-co-supervisor = (
    info.at("co-supervisor", default: none) not in (none, ())
  )

  info-items = (
    (department: "系别", major: "专业", author: "姓名", supervisor: "指导教师")
      + if has-co-supervisor { (co-supervisor: "联合指导教师") }
      + info-items
  )

  assert(
    info-items.keys().all(k => k in info),
    message: "Required info-items for info: "
      + info-items.keys().filter(k => k not in info).join(", "),
  )

  // Calculate suitable width of info items
  info-item-width = if info-item-width == none {
    if has-co-supervisor { 5em } else { 4em }
  } else if info-item-width == auto {
    calc.max(info-items.values().map(v => v.clusters().len())) * 1em
  } else { info-item-width }

  let format-info-item(it) = block(
    width: info-item-width + if degree == "bachelor" { 0em } else { 0.5em },
    fixed-text(it, info-item-width)
      + if degree == "bachelor" { "" } else { " " },
  )

  info.supervisor = info.supervisor.chunks(2)
  if has-co-supervisor { info.co-supervisor = info.co-supervisor.chunks(2) }

  // Calculate suitable width of supervisor
  let supervisor-width = {
    let name-width = calc.max(
      info.author.clusters().len(),
      ..info.supervisor.map(p => p.first().clusters().len()),
      ..if has-co-supervisor {
        info.co-supervisor.map(p => p.first().clusters().len())
      },
    )
    let post-width = calc.max(
      ..info.supervisor.map(p => p.last().clusters().len()),
      ..if has-co-supervisor {
        info.co-supervisor.map(p => p.last().clusters().len())
      },
    )

    if (
      name-width <= 2
        and info.supervisor.all(p => (
          p.first().clusters().len() < p.last().clusters().len()
        ))
    ) {
      (3em, calc.max(4, post-width) * 1em)
    } else {
      (calc.max(4, name-width) * 1em, calc.max(3, post-width) * 1em)
    }
  }

  info.author = if anonymous { use-anonymous(4em) } else {
    block(
      fixed-text(info.author, supervisor-width.first()),
      width: supervisor-width.first(),
    )
  }

  let format-supervisor(arr) = arr
    .intersperse("")
    .map(p => if p == "" { ("", "") } else if anonymous {
      use-anonymous(8em)
    } else {
      block(
        fixed-text(p.first(), supervisor-width.first())
          + "　"
          + fixed-text(p.last(), supervisor-width.last()),
        width: supervisor-width.sum() + 1em,
      )
    })
  info.supervisor = format-supervisor(info.supervisor)

  if has-co-supervisor {
    info.co-supervisor = format-supervisor(info.co-supervisor)
  }

  let format-info(items) = grid(
    align: (center + horizon, center + horizon, left), columns: (
      2.80cm,
      0.82cm,
      5.62cm,
    ), row-gutter: 0.715cm,
    ..items
      .keys()
      .map(k => (format-info-item(items.at(k)), "：", info.at(k)))
      .flatten()
  )

  let display-zh(date) = {
    let date-list = (
      "○",
      "一",
      "二",
      "三",
      "四",
      "五",
      "六",
      "七",
      "八",
      "九",
      "十",
      "十一",
      "十二",
    )
    (
      str(date.year()).clusters().map(c => date-list.at(int(c))).sum()
        + "年"
        + date-list.at(date.month())
        + "月"
    )
  }

  let placed-top(content, dy) = place(center + top, content, dy: dy)
  let placed-bottom(content, dy) = place(center + bottom, content, dy: dy)

  /// Render cover page
  set align(center)
  if is-not-empty(content) { content } else if degree == "bachelor" {
    set page(margin: (top: 3.8cm, bottom: 3.2cm, x: 3cm))
    v(34pt)
    stack(
      dir: ltr,
      h(5pt),
      image("../assets/thu-fig-logo.pdf", width: 49pt),
      h(10pt),
      align(horizon, image(
        "../assets/thu-text-logo.pdf",
        width: 112pt,
        height: 41pt,
        fit: "stretch",
      )),
    )
    text(size: use-size("小初"), font: use-fonts("HeiTi"), weight: "bold", text(
      "综合论文训练",
      tracking: 0.3em,
    ))
    v(1.4em)
    set par(leading: 0.95em)
    text(
      size: use-size("一号"),
      font: use-fonts("HeiTi"),
      info.title.join("\n"),
    )
    set par(leading: 0.6em)
    placed-bottom(
      text(
        size: use-size("三号"),
        font: use-cjk-fonts("FangSong"),
        format-info(info-items),
      ),
      -16.8em,
    )
    placed-bottom(
      text(size: use-size("三号"), font: use-cjk-fonts("SongTi"), display-zh(
        info.date,
      )),
      -5em,
    )
  } else {
    set page(margin: (x: 4cm, y: 6cm))
    set par(leading: 1.15em, spacing: 1.32em)
    v(1.2em)
    text(
      size: use-size("一号"),
      font: use-fonts("HeiTi"),
      info.title.join("\n"),
    )
    parbreak()
    text(
      size: use-size("小二"),
      font: use-fonts("SongTi"),
      [（申请清华大学#info.degree-name;学位论文）],
    )
    set par(leading: 0.6em)
    placed-top(
      text(
        size: use-size("三号"),
        font: use-cjk-fonts("FangSong"),
        format-info(info-items),
      ),
      25.8em,
    )
    placed-bottom(
      text(size: use-size("三号"), font: use-cjk-fonts("SongTi"), display-zh(
        info.date,
      )),
      -0.9em,
    )
  }
}

/// English Cover Page
#let cover-en(
  anonymous: false, // (bool) Hide identifying information.
  fonts: (:), // (dictionary) Font family configuration.
  info: (:), // (dictionary) The information to be displayed on the cover page.
  degree: "master", // (str) Degree level.
  degree-type: "academic", // (str) Degree type.
  twoside: false, // (bool, str) Enable two-sided layout.
  info-items: (
    supervisor: "Thesis Supervisor",
    co-supervisor: "Associate Supervisor",
  ), // (dictionary) Field labels.
) = {
  if degree == "bachelor" { return }

  import "../utils/util.typ": twoside-pagebreak
  import "../utils/font.typ": _use-fonts, use-size

  info.date = context info
    .at("date", default: document.date)
    .display("[month repr:long], [year]")

  let use-fonts = name => _use-fonts(fonts, name)
  let use-anonymous = width => block(width: width, fill: black, "", outset: (
    y: 2pt,
  ))

  let placed-content(dy, content) = place(bottom + center, content, dy: dy)
  let format-supervisor(items) = grid(
    align: (right, left), columns: (
      5.95cm,
      1fr,
    ), rows: 1.1cm, column-gutter: 9.5pt,
    ..items
      .pairs()
      .filter(((k, _)) => info.at(k, default: ()) != ())
      .map(((k, v)) => (
        v + " : ",
        if anonymous { use-anonymous(10em) } else {
          info.at(k).intersperse("")
        },
      ))
      .flatten()
  )

  if type(info.title) == str { info.title = info.title.split("\n") }

  /// Render cover page
  twoside-pagebreak(twoside)

  set align(center)
  set page(margin: (x: 4cm, y: 5.8cm))
  set text(size: use-size("三号"))

  text(size: use-size("二号"), font: use-fonts("HeiTi"), strong(
    info.title.join("\n"),
  ))

  placed-content(-11.64em, {
    set par(leading: 1em, spacing: 1.05em)
    set text(font: use-fonts("SongTi"))
    [
      Thesis submitted to

      *Tsinghua University*

      in partial fulfillment of the requirement

      for the degree of
    ]
    v(-0.4pt)
    strong(text(font: use-fonts("HeiTi"), info.degree-name))
    v(3pt)
    [in]
    v(3pt)
    strong(text(font: use-fonts("HeiTi"), info.major))
  })

  placed-content(-2.56em, {
    set text(font: use-fonts("HeiTi"))
    [by]
    v(3pt)
    strong(if anonymous { use-anonymous(5em) } else { info.author })
    v(-21pt)
    text(
      font: use-fonts("SongTi"),
      tracking: -0.45pt,
      format-supervisor(info-items),
    )
  })

  placed-content(3pt, strong(text(font: use-fonts("HeiTi"), info.date)))
}
