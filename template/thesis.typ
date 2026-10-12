#!/usr/bin/env -S typst c
// Published packages use the first import. Repository builds use the second.
// #import "@preview/tntt:0.6.0" as tntt
#import "../src/lib.typ" as tntt
#import "@preview/theorion:0.6.0": *
#import cosmos.simple: *
#import "@preview/lovelace:0.3.1": pseudocode-list
#import "@preview/cetz:0.5.2"

#let (
  ..config,
  meta,
  doc,
  front-matter,
  main-matter,
  back-matter,
  cover,
  cover-en,
  copyright,
  abstract,
  abstract-en,
  outline-wrapper,
  bilingual-bibliography,
  acknowledge,
  declaration,
) = tntt.define-config(
  // 论文语言 / Thesis language: "zh" or "en".
  // The CLI can override this with `--input lang=en`.
  lang: "zh",
  // `auto` selects "cn" for Chinese and "us" for English.
  region: auto,
  // 学位层级 / Degree: "bachelor", "master", "doctor", or "postdoc".
  degree: "master",
  degree-type: "academic",
  // Anonymous review hides author information and applicable back matter.
  anonymous: false,
  // Enable this for a thesis intended for two-sided printing.
  twoside: false,
  // This information is also written to the PDF metadata.
  info: (
    title: "论文题目",
    author: "作者姓名",
    date: datetime.today(),
  ),
  // Keep bibliography files next to the entrypoint or update this path.
  bibliography: read("main.bib"),
  // Presets: "windows", "macos", "fandol", "ubuntu". Override families as needed.
  fonts: (
    base: "fandol",
    KaiTi: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolKai"),
    Math: ("XITS Math", "FandolKai"),
  ),
)

// Apply PDF metadata, language, paper size, and global reference behavior.
#show: it => meta(it)

// The Chinese cover is required for both Chinese and English theses.
#cover(info: (
  department: "院系名称",
  major: "学科名称",
  degree-name: "工学硕士",
  supervisor: ("导师姓名", "教授"),
))

// This page is omitted automatically for degree types that do not require it.
#cover-en(info: (
  title: "Thesis Title",
  author: "Author Name",
  major: "Discipline",
  degree-name: "Master of Engineering",
  supervisor: ("Professor Name",),
  co-supervisor: (),
))

// Apply the common typography before emitting the remaining pages.
#show: it => doc(it)
#copyright()

// Front matter uses Roman page numbering where required.
#show: it => front-matter(it)

#abstract(keywords: ("关键词一", "关键词二"))[
  中文摘要概括论文的问题、方法、主要结果和结论。
]

#abstract-en(keywords: ("keyword one", "keyword two"))[
  The abstract states the problem, method, principal results, and conclusion.
]

#outline-wrapper()

// Main matter resets heading and page numbering.
#show: it => main-matter(it)
#show: show-theorion

#if config.lang == "zh" [
  = 引言

  在此撰写论文正文，并使用标签引用文献 @knuth1984。
] else [
  = Introduction

  Write the thesis body here and cite sources with labels @knuth1984.
]

== Theorem environments

#theorem[Central limit theorem][
  For independent and identically distributed random variables with finite
  variance, the normalized sample mean converges in distribution to a normal
  random variable.
] <thm:clt>

#proof[
  Apply the characteristic-function form of the classical central limit theorem.
]

== Pseudocode

#figure(
  pseudocode-list[
    + initialize the estimate
    + *while* the stopping criterion is false
      + update the estimate
    + *return* the estimate
  ],
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [Iterative estimation],
) <alg:estimate>

== Programmatic figures

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((0, 0), radius: 0.35, fill: luma(235))
    content((0, 0), [data])
    line((0.35, 0), (2.15, 0), mark: (end: ">"))
    circle((2.5, 0), radius: 0.35, fill: luma(235))
    content((2.5, 0), [result])
  }),
  caption: [A minimal analysis pipeline],
) <fig:pipeline>

See @thm:clt, @alg:estimate, and @fig:pipeline.

#show: it => back-matter(it)

// Pass `style: "gb-7714-2015-author-date"` for author-date citations.
// Pass `full: true` when uncited bibliography entries must also be printed.
#bilingual-bibliography(full: false)

#acknowledge(if config.lang
  == "zh" [在此感谢对本研究提供帮助的个人和机构。] else [
  Acknowledge the people and institutions that supported this research.
])

#declaration()
