= Supplementary Material

An appendix contains material closely related to the thesis that would disrupt
the organization or logic of the main text if included there, such as important
data tables, programs, or statistical tables. It supplements the main body and
may be included as needed.

Figures, tables, and mathematical expressions in an appendix are numbered
separately from those in the main text and carry the appendix identifier, as in
@fig:appendix-figure, @tab:appendix-table, and @eq:appendix-equation. References
used only in an appendix are likewise numbered separately, for example A.1 and
A.2.

== Figures

#figure(
  align(center, image("../fig/example-image-a.pdf", width: 60%)),
  kind: image,
  caption: [Example figure in an appendix],
) <fig:appendix-figure>

== Tables

#figure(
  table(
    columns: (1fr, 2fr),
    align: (center, left),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header([File name], [Description]),
    table.hline(stroke: 0.5pt),
    [`thuthesis.dtx`], [Template source, including documentation and comments],
    [`thuthesis.cls`], [Template class file],
    [`thuthesis-*.bst`], [BibTeX bibliography style files],
    [`thuthesis-*.bbx`], [BibLaTeX bibliography style files],
    [`thuthesis-*.cbx`], [BibLaTeX citation style files],
    table.hline(stroke: 1pt),
  ),
  kind: table,
  caption: [Example table in an appendix],
) <tab:appendix-table>

== Mathematical Expressions

$
  1 / (2 pi upright(i)) integral_gamma f = sum_(k=1)^m n(gamma; a_k) cal(R)(f; a_k)
$ <eq:appendix-equation>

== Citations

An appendix citation such as @dupont1974bone can be accompanied by another
reference such as @zhengkaiqing1987; for example
(@dupont1974bone; @zhengkaiqing1987).
