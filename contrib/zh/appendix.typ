= 补充内容

附录是与论文内容密切相关、但编入正文又影响整篇论文编排条理和逻辑性的资料，例如某些重要的数据表格、计算程序、统计表等，是论文主体的补充内容，可根据需要设置。

附录中的图、表和数学表达式等另行编号，与正文分开，并在数码前冠以附录序号，例如
@fig:appendix-figure、@tab:appendix-table 和 @eq:appendix-equation 等。附录参考文献也与正文分开，并冠以附录序号，例如 A.1、A.2。

== 插图

#figure(
  align(center, image("../fig/example-image-a.pdf", width: 60%)),
  kind: image,
  caption: [附录中的图片示例],
) <fig:appendix-figure>

== 表格

#figure(
  table(
    columns: (1fr, 2fr),
    align: (center, left),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header([文件名], [描述]),
    table.hline(stroke: 0.5pt),
    [`thuthesis.dtx`], [模板的源文件，包括文档和注释],
    [`thuthesis.cls`], [模板文件],
    [`thuthesis-*.bst`], [BibTeX 参考文献表样式文件],
    [`thuthesis-*.bbx`], [BibLaTeX 参考文献表样式文件],
    [`thuthesis-*.cbx`], [BibLaTeX 引用样式文件],
    table.hline(stroke: 1pt),
  ),
  kind: table,
  caption: [附录中的表格示例],
) <tab:appendix-table>

== 数学表达式

$
  1 / (2 pi upright(i)) integral_gamma f = sum_(k=1)^m n(gamma; a_k) cal(R)(f; a_k)
$ <eq:appendix-equation>

== 文献引用

附录 @dupont1974bone 中的参考文献引用 @zhengkaiqing1987
示例（@dupont1974bone；@zhengkaiqing1987）。
