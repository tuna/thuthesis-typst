#import "../src/lib.typ" as thu

#let degree = sys.inputs.at("degree")
#let lang = sys.inputs.at("lang")
#let degree-type = sys.inputs.at("degree-type")
#let twoside = sys.inputs.at("twoside", default: "false") in (true, "true")

#let text = (
  zh: (
    title: "论文模板视觉对比",
    chapter: "比较章节",
    body: "这是用于检查正文、页眉、页码和章节编号的示例文字。",
    section: "图表与公式",
    figure: "示例图",
    table: "示例表",
    appendix: "附录测试",
    appendix-body: "这是用于检查附录编号和页眉的示例文字。",
  ),
  en: (
    title: "Visual Comparison of Thesis Templates",
    chapter: "Comparison Chapter",
    body: "This text checks the body, header, page number, and chapter number.",
    section: "Figures, Tables, and Equations",
    figure: "Example figure",
    table: "Example table",
    appendix: "Appendix Test",
    appendix-body: "This text checks appendix numbering and running headers.",
  ),
).at(lang)

#let (
  ..config,
  meta,
  doc,
  front-matter,
  main-matter,
  back-matter,
  cover,
  cover-en,
  abstract,
  abstract-en,
  outline-wrapper,
) = thu.define-config(
  lang: lang,
  degree: degree,
  degree-type: degree-type,
  twoside: twoside,
  fonts: (
    base: "fandol",
    SongTi: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolSong", "FandolKai"),
    KaiTi: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolKai"),
    Math: ("XITS Math", "FandolKai"),
  ),
  info: (
    title: text.title,
    author: "测试作者",
    date: datetime(year: 2026, month: 8, day: 8),
  ),
)

#show: it => meta(it)

#cover(info: (
  department: "计算机科学与技术系",
  major: "计算机科学与技术",
  degree-name: "工学学位",
  supervisor: ("测试导师", "教授"),
))

#cover-en(info: (
  title: "Visual Comparison of Thesis Templates",
  author: "Test Author",
  major: "Computer Science and Technology",
  degree-name: "Degree of Engineering",
  supervisor: ("Professor Test Supervisor",),
  co-supervisor: (),
))

#show: it => doc(it)

#show: it => front-matter(it)

#abstract(keywords: ("模板", "对比"))[
  本文用于比较 LaTeX 与 Typst 模板在不同论文配置下的版式。
]
#abstract-en(keywords: ("template", "comparison"))[
  This document compares the LaTeX and Typst layouts under different thesis
  configurations.
]
#outline-wrapper()

#show: it => main-matter(it)

= #text.chapter

#text.body

== #text.section

#figure(rect(width: 3cm, height: 1cm), caption: text.figure)

#figure(
  table(columns: 2, [Item], [Value], [A], [1]),
  kind: table,
  caption: text.table,
)

$ E = m c^2 $

#show: it => back-matter(it)

= #text.appendix

#text.appendix-body
