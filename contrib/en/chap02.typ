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

= Examples of Figures and Tables

== Figures

Images are normally inserted with Typst’s `figure` and `image` functions, as
shown in @fig:example. Vector graphics should preferably use PDF, for example
for data visualizations; photographs should use JPG; and other raster graphics
should use lossless PNG. By default, only the first page of an inserted PDF is
used.

#figure(
  align(center, image("../fig/example-image-a.pdf", width: 50%)),
  kind: image,
  caption: [Example image],
) <fig:example>

#align(center, text(size: 10.5pt)[
  Note: International journals often combine the title and explanatory text of a
  figure or table into one paragraph. In a thesis, separate the title from the
  explanation and place the explanation below the figure or in the main text.
])

Notes to a figure or table should be identified by lowercase English letters in
sequence and placed below it. Captions copied from international journals should
be rewritten so that the caption contains only the name of the figure or table;
other explanatory text should appear as notes below it or in the main text.

If a figure contains two or more subfigures, label them (a), (b), (c), and so
on, and provide a title for each one. In Typst, subfigures may be composed with
a grid, as in @fig:multi-image.

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1cm,
    align(center)[
      #image("../fig/example-image-a.pdf", width: 85%)
      (a) Subfigure A
    ],
    align(center)[
      #image("../fig/example-image-b.pdf", width: 85%)
      (b) Subfigure B
    ],
  ),
  kind: image,
  caption: [Example with multiple subfigures],
) <fig:multi-image>

== Tables

A table should be self-explanatory, and every quantity and unit should be
identified by its symbol. For clarity and readability, use three-line tables
such as @tab:three-line. Auxiliary rules may be added when necessary, and a
different format may be used when a three-line table cannot express the data
clearly.

Place the table number and title above the table. Text in table cells is
normally centered vertically and horizontally; use left alignment where
centering is not appropriate.

#figure(
  three-line-table(
    (auto, auto),
    ([File name], [Description]),
    (
      [`thuthesis.dtx`],
      [Template source, including documentation and comments],
      [`thuthesis.cls`],
      [Template class file],
      [`thuthesis-*.bst`],
      [BibTeX bibliography style files],
    ),
    align: (center, left),
  ),
  kind: table,
  caption: [Example three-line table],
) <tab:three-line>

Notes in a table should be identified by lowercase English letters in sequence
and placed below the table. Typst permits footnotes directly in cells or a
collected set of notes after the table.

#figure(
  [
    #three-line-table(
      (auto, auto),
      ([File name], [Description]),
      (
        [`thuthesis.dtx`#super[a]],
        [Template source, including documentation and comments],
        [`thuthesis.cls`#super[b]],
        [Template class file],
        [`thuthesis-*.bst`],
        [BibTeX bibliography style files],
      ),
      align: (center, left),
    )

    #set text(size: 10.5pt)
    #par(hanging-indent: 1.5em)[#super[a]
      This file can generate the template manual or extract a compact class
      file.]
    #par(hanging-indent: 1.5em)[#super[b]
      Regenerate the class file when updating the template to avoid loading an
      outdated version.]
  ],
  kind: table,
  caption: [Example table with notes],
) <tab:three-part-table>

When a table continues onto another page, mark it as a continued table and
repeat the header on every page. Typst tables break automatically when the
remaining page space is insufficient; the following table illustrates the data
organization.

#show figure.where(kind: table): set block(breakable: true)
#figure(
  three-line-table(
    4,
    ([Heading 1], [Heading 2], [Heading 3], [Heading 4]),
    range(1, 11).map(n => ([Row #n], [], [], [])).flatten(),
  ),
  kind: table,
  caption: [Title of a multipage table],
) <tab:longtable>

== Algorithms

The template does not prescribe a pseudocode package. Authors may use any Typst
package or their own layout and then use `figure(kind: "algorithm")` to produce
consistent captions and numbering.

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [Compute $y = x^n$],
)[
  #set par(first-line-indent: 0pt)
  *Input:* $n >= 0$#linebreak() *Output:* $y = x^n$

  $y <- 1$#linebreak() $X <- x$#linebreak()
  $N <- n$

  *while* $N != 0$*:*#linebreak()
  #pad(left: 2em)[
    *if* $N$ is even: $X <- X times X$, $N <- N / 2$;#linebreak() *otherwise:*
    $y <- y times X$, $N <- N - 1$.
  ]
]
