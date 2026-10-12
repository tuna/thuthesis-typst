/// Record Sheet Page
#let record-sheet(
  anonymous: false, // (bool) Hide identifying information.
  twoside: false, // (bool, str) Enable two-sided layout.
  info: (:), // (dictionary) Student and thesis fields: author, student-id, class, title.
  degree: "bachelor", // (str) Degree level.
  title: [综合论文训练记录表], // (content) Page title.
  outlined: false, // (bool) Include the page in the outline.
  bookmarked: false, // (bool) Add a PDF bookmark.
  prefill: true, // (bool) Whether to prefill the student information.
  rows: (1cm, 1cm, 12cm, 6.5cm), // (array) Table row heights.
  columns: (2cm, 1fr, 1.5cm, 1fr, 1.5cm, 1fr), // (array) Table column widths.
  content: [], // (content) The main content and progress arrangement.
  mid-term-comment: [], // (content) The mid-term assessment comments.
  instructor-comment: [], // (content) The instructor's comments.
  reviewer-comment: [], // (content) The reviewer's comments.
  defense-comment: [], // (content) The defense committee's comments.
) = {
  /// Precheck
  if anonymous or degree != "bachelor" { return }

  import "../utils/font.typ": use-size
  import "../utils/util.typ": parsed-title, twoside-pagebreak

  let v-text(str, spacing: 3.6pt) = stack(
    dir: ttb,
    ..str.clusters(),
    spacing: spacing,
  )

  twoside-pagebreak(twoside)

  set page(numbering: none)
  set par(first-line-indent: 0em, spacing: 1.75em)
  set text(size: use-size("五号"))

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  show table.cell: it => if it.x == 0 or it.y == 0 and calc.even(it.x) {
    strong(it)
  } else { it }

  let cell-with-back(body, back) = table.cell(colspan: 5, grid(
    columns: 1fr,
    rows: (1fr, auto),
    body,
    align(right, strong(back))
  ))

  info.title = context if "title" in info {
    parsed-title(info.title).sum()
  } else { document.title }
  info.author = context info.at("author", default: document.author.first())

  table(
    stroke: .5pt,
    rows: rows,
    columns: columns,
    align: (x, y) => if x == 0 or y <= 1 { center + horizon } else { auto },
    [学生姓名], info.author, [学号], info.student-id, [班级], info.class,
    [论文题目], table.cell(colspan: 5, info.title),
    v-text[主要内容以及进度安排],
    cell-with-back(content, [
      指导教师签字：#h(4em)

      考核组组长签字：#h(4em)

      年#h(1em)月#h(1em)日
    ]),
    v-text[中期考核意见],
    cell-with-back(mid-term-comment, [
      考核组组长签字：#h(4em)

      年#h(1em)月#h(1em)日
    ]),
    v-text[指导教师评语],
    cell-with-back(instructor-comment, [
      指导教师签字：#h(4em)

      年#h(1em)月#h(1em)日
    ]),
    v-text[评阅教师评语],
    cell-with-back(reviewer-comment, [
      评阅教师签字：#h(4em)

      年#h(1em)月#h(1em)日
    ]),
    v-text[答辩小组评语],
    cell-with-back(defense-comment, [
      答辩小组组长签字：#h(4em)

      年#h(1em)月#h(1em)日
    ]),
  )

  v(1em)

  align(right, strong[
    总成绩：#underline(" " * 12) // 3em

    教学负责人签字：#underline(" " * 12)

    #v(1em)

    年#h(1em)月#h(1em)日#h(3em)
  ])
}

/// Common review page for anything
#let _review-of(
  anonymous: false, // (bool) Hide identifying information.
  twoside: false, // (bool, str) Enable two-sided layout.
  degree: "master", // (str) Degree level.
  title: [评审材料], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  it, // (content) Content to render.
) = {
  if anonymous or degree == "bachelor" { return }

  import "../utils/util.typ": twoside-pagebreak

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  it
}

/// Advisor Comment Page
#let comments = _review-of.with(title: [指导教师学术评语])

/// Committee Resolution Page
#let resolution = _review-of.with(title: [答辩委员会决议书])
