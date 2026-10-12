= 引用文献的标注

Typst 原生读取 BibLaTeX 数据库，并通过 CSL 样式生成引用和参考文献。
模板的 `bilingual-bibliography` 函数在这一能力上处理双语条目。

== 顺序编码制

顺序编码制是研究生论文的默认样式，文献序号默认以上标显示。普通引用、作者作为正文、带页码引用和多文献引用可分别写成：

#table(
  columns: (1fr, 1fr),
  align: left,
  stroke: none,
  [`@zhangkun1994`], [@zhangkun1994],
  [`张昆等@zhangkun1994`], [张昆等@zhangkun1994],
  [`#cite(<zhangkun1994>)42`], [#cite(<zhangkun1994>)42],
  [`@zhangkun1994 @zhukezhen1973`], [@zhangkun1994 @zhukezhen1973],
)

当前 GB/T CSL
的叙述式引用会列出完整作者，因此需要“张昆等”这样的简称时，应直接写出作者并在后面引用。该
CSL 也不显示 `@key[页码]`
中的补充信息，所以页码应紧跟在引用之后。多篇文献之间只留空格，Typst
才会把它们合并为一组；两个连续编号显示为逗号分隔，三个及以上连续编号会压缩为区间。

== 著者-出版年制

著者—出版年制可在输出参考文献时通过 CSL 样式启用：

```typ
#bilingual-bibliography(style: "gb-7714-2015-author-date")
```

正文中的引用标签无需改变。叙述式引用可使用 `form: "prose"`，括号式引用使用普通引用形式。

本示例采用顺序编码制，因此这里仍按同一数据库展示引用 @zhangkun1994 和
@zhukezhen1973；将根文件中的 `bilingual-bibliography` 调用改为上述样式后，
正文和文后列表会一起变为著者—出版年格式。

每条列入参考文献表的文献通常都应在正文中标注。`bilingual-bibliography`
当前默认使用 `full: true` 展示数据库中的全部条目；正式论文可传入 `full: false`，
只输出实际引用的条目。
