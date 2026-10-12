//! The main configuration file for the TNTT template.
#import "exports.typ"

#import "imports.typ": *
#import "utils/util.typ": *
#import "utils/font.typ": use-size

/// Define the configuration for the document.
///
/// - lang (str): The document language, either "zh" or "en".
/// - region (str, auto): The language region. Defaults to "cn" for Chinese and "us" for English.
/// - degree (str): The degree.
/// - degree-type (str): The degree-type type.
/// - anonymous (str, bool): Whether to use anonymous mode.
/// - twoside (str, bool): Whether to use two-sided printing.
/// - bibliography (array, bytes, none, str): The bibliography entry.
/// - fonts (dictionary, str): The font family to use.
/// - info (dictionary): The information to be displayed in the document.
/// -> dictionary
#let define-config(
  lang: "zh",
  region: auto,
  degree: "bachelor",
  degree-type: "academic",
  anonymous: false,
  twoside: false,
  bibliography: none,
  fonts: (:),
  info: (:),
) = {
  import exports: *
  import "pages/cover.typ": cover, cover-en
  import "utils/font.typ": _use-cjk-fonts, _use-en-font, _use-fonts

  lang = sys.inputs.at("lang", default: lang)
  region = sys.inputs.at("region", default: region)
  degree = sys.inputs.at("degree", default: degree)
  degree-type = sys.inputs.at("degree-type", default: degree-type)
  anonymous = sys.inputs.at("anonymous", default: anonymous) in (true, "true")
  twoside = sys.inputs.at("twoside", default: twoside)
  fonts = sys.inputs.at("fonts", default: fonts)

  assert(lang in ("zh", "en"), message: "Unsupported language / 不支持的语言: " + lang)
  let t = toml("lang.toml").at(lang)
  assert(type(fonts) == dictionary or fonts in ("windows", "macos", "fandol", "ubuntu"))

  assert(degree in ("bachelor", "master", "doctor", "postdoc"), message: t.error-degree + degree)
  assert(degree-type in ("academic",), message: t.error-degree-type + degree-type)

  // Use a new dictionary to store the fonts, so that we can ensure the type hints for the `fonts` parameter.
  let _fonts = if type(fonts) == dictionary {
    if fonts.at("base", default: none) == none { fonts } else { toml("fonts.toml").at(fonts.remove("base")) + fonts }
  } else { toml("fonts.toml").at(fonts) }

  info.title = parsed-title(info.title)
  info.author = if anonymous { "" } else { info.author }

  // @typstyle off
  (
    /// ------ ///
    /// config ///
    /// ------ ///
    lang: lang,
    region: region,
    info: info,
    fonts: _fonts,
    degree-type: degree-type,
    degree: degree,
    twoside: twoside,
    anonymous: anonymous,
    /// --------- ///
    /// utilities ///
    /// --------- ///
    use-fonts: _use-fonts.with(_fonts),
    use-en-font: _use-en-font.with(_fonts),
    use-cjk-fonts: _use-cjk-fonts.with(_fonts),
    use-twoside: twoside-pagebreak.with(twoside),
    /// ------- ///
    /// layouts ///
    /// ------- ///
    // 文档元配置 | Document Meta Configuration
    meta: meta.with(info: info, lang: lang, region: region, extra-prefixes: ("alg:",)), // info of meta cannot be overwritten
    // 文稿设置 | Document Layout Configuration
    doc: doc.with(header-display: degree != "bachelor", fonts: _fonts, extra-fig-kinds: ("algorithm",)),
    // 前辅文设置 | Front Matter Layout Configuration
    front-matter: front-matter.with(twoside: twoside),
    // 正文设置 | Main Matter Layout Configuration
    main-matter: main-matter.with(twoside: twoside, equation-numbering: "(1-1)", heading-numbering: (
      zh: (formats: ("第1章", "1.1"), depth: 4, supplyment: "　"),
      en: (formats: ((..n) => "CHAPTER " + numbering("1", ..n), "1.1"), depth: 4, supplyment: ""),
    ).at(lang)),
    // 后辅文设置 | Back Matter Layout Configuration
    back-matter: back-matter.with(twoside: twoside, heading-numbering: (
      zh: (formats: ("附录A", "A.1"), depth: 4, supplyment: "　"),
      en: (formats: ((..n) => "APPENDIX " + numbering("A", ..n), "A.1"), depth: 4, supplyment: ""),
    ).at(lang)),
    /// ----- ///
    /// pages ///
    /// ----- ///
    // 字体展示页 | Fonts Display Page
    fonts-display: fonts-display.with(fonts: _fonts),
    // 中文封面页 | Cover Page
    cover: cover.with(degree: degree, degree-type: degree-type, anonymous: anonymous, fonts: _fonts, doc-info: info),
    // 英文封面页 | Cover (English) Page
    cover-en: cover-en.with(degree: degree, degree-type: degree-type, twoside: twoside, anonymous: anonymous, fonts: _fonts),
    // 书脊页 | Spine Page
    spine: spine.with(twoside: twoside, anonymous: anonymous, fonts: _fonts),
    // 学位论文指导小组、公开评阅人和答辩委员会名单页 | Thesis Committee Page
    committee: committee.with(degree: degree, anonymous: anonymous, twoside: twoside, title: t.committee,
      supervisors-title: t.supervisors, reviewers-title: t.reviewers, defenders-title: t.defenders, anonymous-review: t.anonymous-review),
    // 授权页 | Copyright Page
    copyright: copyright.with(degree: degree, anonymous: anonymous, twoside: twoside),
    // 中文摘要页 | Abstract Page
    abstract: abstract.with(twoside: twoside, outlined: degree != "bachelor", fonts: _fonts),
    // 英文摘要页 | Abstract (English) Page
    abstract-en: abstract-en.with(twoside: twoside, outlined: degree != "bachelor", fonts: _fonts),
    // 目录页 | Outline Page
    outline-wrapper: outline-wrapper.with(twoside: twoside, outlined: degree != "bachelor", fonts: _fonts, title: t.outline),
    // 总清单页 | Master List Page
    master-list: master-list.with(twoside: twoside, outlined: degree != "bachelor", title: t.master-list),
    // 插图和附表清单页 | Figure and Table Index Page
    figure-table-list: figure-table-list.with(twoside: twoside, outlined: degree != "bachelor", title: t.figure-table-list),
    // 插图清单页 | Figure List Page
    figure-list: figure-list.with(twoside: twoside, outlined: degree != "bachelor", title: t.figure-list),
    // 附表清单页 | Table List Page
    table-list: table-list.with(twoside: twoside, outlined: degree != "bachelor", title: t.table-list),
    // 公式清单页 | Equation List Page
    equation-list: equation-list.with(twoside: twoside, outlined: degree != "bachelor", title: t.equation-list),
    // 符号表页 | Notation Page
    notation: notation.with(twoside: twoside, outlined: degree != "bachelor", title: t.notation),
    // 参考文献页 | Bibliography Page
    bilingual-bibliography: bilingual-bibliography.with(bibliography, title: t.bibliography),
    // 致谢页 | Acknowledge Page
    acknowledge: acknowledge.with(anonymous: anonymous, twoside: twoside, title: t.acknowledge),
    // 声明页 | Declaration Page
    declaration: declaration.with(degree: degree, anonymous: anonymous, twoside: twoside),
    // 个人简历、在学期间完成的相关学术成果说明页 | Resume & Achievement Page
    achievement: achievement.with(degree: degree, anonymous: anonymous, twoside: twoside),
    // 论文训练记录表 | Record Sheet Page
    record-sheet: record-sheet.with(degree: degree, anonymous: anonymous, twoside: twoside),
    // 指导教师/指导小组评语页 | Advisor Comments Page
    comments: comments.with(degree: degree, anonymous: anonymous, twoside: twoside, title: t.comments),
    // 答辩委员会决议书 | Committee Resolution Page
    resolution: resolution.with(degree: degree, anonymous: anonymous, twoside: twoside, title: t.resolution),
  )
}
