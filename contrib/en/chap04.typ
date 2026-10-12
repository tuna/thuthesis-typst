= Citing References

Typst reads BibLaTeX databases natively and generates citations and reference
lists with CSL styles. The template's `bilingual-bibliography` function extends
this functionality for bilingual entries.

== Numeric Citations

Numeric citations are the default for graduate theses, and reference numbers are
normally printed as superscripts. Ordinary citations, author names in prose,
citations with page numbers, and multiple citations can be written as follows:

#table(
  columns: (1fr, 1fr),
  align: left,
  stroke: none,
  [`@zhangkun1994`], [@zhangkun1994],
  [`Zhang et al. @zhangkun1994`], [Zhang et al. @zhangkun1994],
  [`#cite(<zhangkun1994>)42`], [#cite(<zhangkun1994>)42],
  [`@zhangkun1994 @zhukezhen1973`], [@zhangkun1994 @zhukezhen1973],
)

The current GB/T CSL style lists every author in a narrative citation. When an
abbreviated form such as “Zhang et al.” is required, write the author text
directly and place the citation after it. The style also omits the supplement in
`@key[page]`, so the page number should immediately follow the citation. Separate
multiple references with spaces only, so Typst merges them into one group. Two
consecutive numbers are separated by a comma, while three or more are compressed
into a range.

== Author–Year Citations

Select an author–year CSL style when the bibliography is rendered:

```typ
#bilingual-bibliography(style: "gb-7714-2015-author-date")
```

The citation labels in the body remain unchanged. Narrative citations use
`form: "prose"`, and parenthetical citations use the ordinary citation form.

This example uses numeric citations and therefore continues to show references
@zhangkun1994 and @zhukezhen1973 from the same database. After the
`bilingual-bibliography` call in the root file selects the style above, both
in-text citations and the reference list use the author–year format.

Every item in the reference list should normally be cited in the text.
`bilingual-bibliography` currently defaults to `full: true` and prints the entire
database. A formal thesis can pass `full: false` to print only cited entries.
