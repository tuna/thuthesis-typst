#let three-line-table(columns, header, cells, align: center) = context {
  let heavy-rule = 1.5pt
  let light-rule = 1pt
  // `booktabs` separates a rule from the neighboring row by 0.65ex below
  // and 0.4ex above; the rule itself also occupies its declared thickness.
  let x-height = measure(text(
    size: 12pt,
    top-edge: "bounds",
    bottom-edge: "baseline",
    [x],
  )).height
  let column-count = if type(columns) == int { columns } else {
    columns.len()
  }
  let spacer(height) = table.cell(
    colspan: column-count,
    inset: 0pt,
    box(width: 0pt, height: height),
  )
  table(
    columns: columns,
    align: align,
    stroke: none,
    table.header(
      spacer(heavy-rule / 2),
      table.hline(stroke: heavy-rule),
      spacer(heavy-rule / 2 + 0.65 * x-height),
      ..header,
      spacer(0.4 * x-height + light-rule / 2),
      table.hline(stroke: light-rule),
      spacer(light-rule / 2 + 0.65 * x-height),
    ),
    ..cells,
    table.footer(
      spacer(0.4 * x-height + heavy-rule / 2),
      table.hline(stroke: heavy-rule),
      spacer(heavy-rule / 2),
    ),
  )
}

= 图表示例

== 插图

图片通常使用 Typst 的 `figure` 与 `image` 函数插入，如 @fig:example 所示。
建议矢量图片使用 PDF 格式，比如数据可视化的绘图；照片应使用 JPG
格式；其他栅格图应使用无损的 PNG 格式。注意，默认插入的 PDF
格式的图片只取第一页。

#figure(
  align(center, image("../fig/example-image-a.pdf", width: 50%)),
  kind: image,
  caption: [示例图片标题],
) <fig:example>

#align(center, text(size: 10.5pt)[
  注：国外期刊习惯将图表的标题和说明文字写成一段，写作论文时应将题名和说明分开，说明文字放在图下或正文中。
])

若图或表中有附注，采用英文小写字母顺序编号，附注写在图或表的下方。
国外期刊习惯将图表的标题和说明文字写成一段，需要改写为标题只含图表名称，其他说明文字以注释方式写在图表下方，或者写在正文中。

如果一个图由两个或两个以上分图组成，各分图分别以
(a)、(b)、(c)……作为图序，并须有分图题。 在 Typst 中可以使用网格组合分图，如
@fig:multi-image。

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1cm,
    align(center)[
      #image("../fig/example-image-a.pdf", width: 85%)
      (a) 分图 A
    ],
    align(center)[
      #image("../fig/example-image-b.pdf", width: 85%)
      (b) 分图 B
    ],
  ),
  kind: image,
  caption: [多个分图的示例],
) <fig:multi-image>

== 表格

表应具有自明性。表中参数应标明量和单位的符号。
为使表格简洁易读，均采用三线表（例如
@tab:three-line）。必要时可加辅助线，三线表无法清晰表达时可采用其他格式。

表序与表题置于表的上方。表单元格中的文字一般应上下、左右居中书写；不宜左右居中的，可采用左对齐。

#figure(
  three-line-table(
    (auto, auto),
    ([文件名], [描述]),
    (
      [`thuthesis.dtx`],
      [模板的源文件，包括文档和注释],
      [`thuthesis.cls`],
      [模板文件],
      [`thuthesis-*.bst`],
      [BibTeX 参考文献表样式文件],
    ),
    align: (center, left),
  ),
  kind: table,
  caption: [三线表示例],
) <tab:three-line>

若表中有附注，采用英文小写字母顺序编号，附注写在表的下方。 Typst
可以直接在单元格中使用脚注，也可以在表格后集中列出表注。

#figure(
  [
    #three-line-table(
      (auto, auto),
      ([文件名], [描述]),
      (
        [`thuthesis.dtx`#super[a]],
        [模板的源文件，包括文档和注释],
        [`thuthesis.cls`#super[b]],
        [模板文件],
        [`thuthesis-*.bst`],
        [BibTeX 参考文献表样式文件],
      ),
      align: (center, left),
    )

    #set text(size: 10.5pt)
    #par(hanging-indent: 1.5em)[#super[a]
      可以编译生成模板的使用说明文档，也可以抽取精简的模板文件。]
    #par(hanging-indent: 1.5em)[#super[b]
      更新模板时应同步生成模板文件，避免继续载入旧版本。]
  ],
  kind: table,
  caption: [带附注的表格示例],
) <tab:three-part-table>

如某个表需要转页接排，可以“续表”的形式另页排印，并在每页重复表头。 Typst
表格在页面空间不足时可以自动跨页；下表展示对应的数据组织方式。

#show figure.where(kind: table): set block(breakable: true)
#figure(
  three-line-table(
    4,
    ([表头 1], [表头 2], [表头 3], [表头 4]),
    range(1, 11).map(n => ([Row #n], [], [], [])).flatten(),
  ),
  kind: table,
  caption: [跨页长表格的表题],
) <tab:longtable>

== 算法

模板不固定伪代码包；用户可以选择任意 Typst 包或自行排版，再使用
`figure(kind: "algorithm")` 统一生成算法题注和编号。

#figure(kind: "algorithm", supplement: [算法], caption: [计算 $y = x^n$])[
  #set par(first-line-indent: 0pt)
  *输入：* $n >= 0$#linebreak() *输出：* $y = x^n$

  $y <- 1$#linebreak() $X <- x$#linebreak()
  $N <- n$

  *当* $N != 0$ *时：*#linebreak()
  #pad(left: 2em)[
    *若* $N$ 为偶数：$X <- X times X$，$N <- N / 2$；#linebreak()
    *否则*：$y <- y times X$，$N <- N - 1$。
  ]
]
