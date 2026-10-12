#!/usr/bin/env -S typst c
// #import "@preview/tntt:0.6.0" as tntt
#import "../src/lib.typ" as tntt

// This reference document uses TnTT's page-level API.
#let (
  ..config,
  meta,
  doc,
  front-matter,
  main-matter,
  back-matter,
  cover,
  cover-en,
  committee,
  copyright,
  abstract,
  abstract-en,
  outline-wrapper,
  figure-list,
  table-list,
  notation,
  bilingual-bibliography,
  acknowledge,
  declaration,
  achievement,
  comments,
  resolution,
) = tntt.define-config(
  lang: "en",
  degree: "master",
  degree-type: "academic",
  anonymous: false,
  twoside: false,
  info: (
    title: ("清华大学学位论文 Typst 模板", "使用示例文档 v0.1.0"),
    author: "薛瑞尼",
    date: datetime(year: 2026, month: 8, day: 8),
  ),
  bibliography: read("main.bib"),
  fonts: (
    base: "fandol",
    SongTi: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolSong", "FandolKai"),
    KaiTi: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FandolKai"),
    Math: ("XITS Math", "FandolKai"),
  ),
)

#show: it => meta(it)

#cover(info: (
  department: "计算机科学与技术系",
  major: "计算机科学与技术",
  degree-name: "工学硕士",
  supervisor: ("郑纬民", "教授"),
  co-supervisor: ("陈文光", "教授"),
))

#cover-en(info: (
  title: "An Introduction to Typst Thesis Template of Tsinghua University",
  author: "Xue Ruini",
  major: "Computer Science and Technology",
  degree-name: "Master of Science",
  supervisor: ("Professor Zheng Weimin",),
  co-supervisor: ("Professor Chen Wenguang",),
))

#show: it => doc(it)

#committee(..(
  zh: (
    supervisors: (
      ("李XX", "教授", "清华大学"),
      ("王XX", "副教授", "清华大学"),
      ("张XX", "助理教授", "清华大学"),
    ),
    reviewers: (),
    defenders: (
      主席: (("赵XX", "教授", "清华大学"),),
      委员: (
        ("刘XX", "教授", "清华大学"),
        ("杨XX", "研究员", "中国XXXX科学院XXXXXXX研究所"),
      ),
      秘书: (("吴XX", "助理研究员", "清华大学"),),
    ),
  ),
  en: (
    supervisors: (
      ("Li XX", "Professor", "Tsinghua University"),
      ("Wang XX", "Associate Professor", "Tsinghua University"),
      ("Zhang XX", "Assistant Professor", "Tsinghua University"),
    ),
    reviewers: (),
    defenders: (
      Chair: (("Zhao XX", "Professor", "Tsinghua University"),),
      Members: (
        ("Liu XX", "Professor", "Tsinghua University"),
        (
          "Yang XX",
          "Research Professor",
          "Institute XXXXXXX, Chinese Academy of Sciences",
        ),
      ),
      Secretary: (
        ("Wu XX", "Assistant Research Professor", "Tsinghua University"),
      ),
    ),
  ),
).at(config.lang))

#copyright()

#show: it => front-matter(it)

#abstract(keywords: ("关键词 1", "关键词 2", "关键词 3", "关键词 4", "关键词 5"))[
  论文的摘要是对论文研究内容和成果的高度概括。
  摘要应对论文所研究的问题及其研究目的进行描述，对研究方法和过程进行简单介绍，对研究成果和所得结论进行概括。
  摘要应具有独立性和自明性，其内容应包含与论文全文同等量的主要信息。
  使读者即使不阅读全文，通过摘要就能了解论文的总体内容和主要成果。

  论文摘要的书写应力求精确、简明。
  切忌写成对论文书写内容进行提要的形式，尤其要避免“第 1 章……；第 2 章……；……”这种或类似的陈述方式。

  关键词是为了文献标引工作、用以表示全文主要内容信息的单词或术语。 关键词不超过 5 个，每个关键词中间用分号分隔。
]

#abstract-en(keywords: ("Keyword 1", "Keyword 2", "Keyword 3", "Keyword 4", "Keyword 5"))[
  An abstract of a dissertation is a summary and extraction of research work and
  contributions. Included in an abstract should be description of research topic
  and research objective, brief introduction to methodology and research
  process, and summary of conclusion and contributions of the research. An
  abstract should be characterized by independence and clarity and carry
  identical information with the dissertation. It should be such that the
  general idea and major contributions of the dissertation are conveyed without
  reading the dissertation.

  An abstract should be concise and to the point. It is a misunderstanding to
  make an abstract an outline of the dissertation and words “the first chapter”,
  “the second chapter” and the like should be avoided in the abstract.

  Keywords are terms used for indexing and should be separated with semi-colons.
]

#outline-wrapper()
#figure-list()
#table-list()
#notation(include config.lang + "/notation.typ")

#show: it => main-matter(it)

#include config.lang + "/chap01.typ"
#include config.lang + "/chap02.typ"
#include config.lang + "/chap03.typ"
#include config.lang + "/chap04.typ"

#show: it => back-matter(it)

#bilingual-bibliography()
#include config.lang + "/appendix.typ"

#acknowledge(include config.lang + "/acknowledgements.typ")
#declaration()
#achievement(..(
  zh: (
    resume: [197× 年 ×× 月 ×× 日出生于四川××县。],
    paper: [
      1. Yang Y, Ren T L, Zhang L T, et al. Miniature microphone with silicon-based
      ferroelectric thin films[J]. Integrated Ferroelectrics, 2003, 52:229-235.
    ],
    patent: [
      1. 任天令, 杨轶, 朱一平, 等. 硅基铁电微声学传感器畴极化区域控制和电极连接的方法[P].
    ],
  ),
  en: (
    resume: [Born in a county in Sichuan Province on Month ×, 197×.],
    paper: [
      1. Yang Y, Ren T L, Zhang L T, et al. Miniature microphone with silicon-based
      ferroelectric thin films[J]. Integrated Ferroelectrics, 2003, 52:229-235.
    ],
    patent: [
      1. Ren T L, Yang Y, Zhu Y P, et al. Method for controlling domain-polarized
      regions and connecting electrodes in a silicon-based ferroelectric
      microacoustic sensor[P].
    ],
  ),
).at(config.lang))
#comments(include config.lang + "/comments.typ")
#resolution(include config.lang + "/resolution.typ")
