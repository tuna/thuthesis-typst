= 数学符号和公式

== 数学符号

中文论文的数学符号通常遵循 GB/T
3102.11—1993《物理科学和技术中使用的数学符号》#footnote[原 GB 3102.11—1993，自
  2017 年 3 月 23 日起转为推荐性标准。]。 该标准参照采用 ISO
31-11:1992#footnote[目前已更新为 ISO 80000-2:2019。]，但与 TeX
默认的美国数学学会符号习惯有所区别。主要差异包括：

+ 大写希腊字母默认为斜体，如
  $Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi Psi Omega$；有限增量使用固定正体的
  $∆ x$。
+ 小于等于号和大于等于号使用 $<=$、$>=$。
+ 积分号采用正体字形，例如 $integral$、$integral.cont$。
+ 偏微分符号 $partial$ 使用正体。
+ 省略号固定居中，例如 $1, 2, dots, n$ 和 $1 + 2 + dots + n$。
+ 实部和虚部使用罗马体，例如 $upright("Re")$ 和 $upright("Im")$。

数学常数、特殊函数、微分符号、向量和矩阵的正斜体应由作者按采用的标准统一处理。例如：

$
  pi = 3.14 dots; quad upright(i)^2 = -1; quad upright(e) = lim_(n -> infinity) (1 + 1/n)^n.
$

向量、矩阵和张量通常使用粗斜体，如 $bold(x)$、$bold(Sigma)$；自然对数写作
$ln x$。

模板会随论文语言自动选择 `math-style: "GB"`（中文）或 `math-style: "TeX"`
（英文）；也可以在配置中显式选择 `"GB"`、`"ISO"` 或 `"TeX"`。其中 GB
样式统一设置斜体大写希腊字母、倾斜的不等号、正体积分号与偏微分号、居中省略号及
罗马体实部和虚部；ISO
样式还会把行间积分的上下限放到积分号上下。数学字体和符号仍可通过文档级
`show`、`set text` 与公式函数进一步配置。

量和单位应保持数字、单位和指数格式一致，例如
$6.4 times 10^6 "m"$、$9 "μm"$、$"kg" dot "m" dot "s"^(-1)$ 和
$10 "°C" dash 20 "°C"$。

== 数学公式

行间公式可直接用带空格的数学标记书写。数学公式的引用应前后带括号，例如@eq:example。

$
  1 / (2 pi upright(i)) integral_gamma f = sum_(k=1)^m n(gamma; a_k) cal(R)(f; a_k).
$ <eq:example>

多行公式尽可能在等号处对齐，可以使用 `&` 设置对齐点：

#align(center, grid(
  columns: (auto, auto),
  align: (right, left),
  column-gutter: 0.5em,
  [$a$], [$= b + c + d + e$],
  [], [$= f + g$],
))

== 数学定理

模板不强制绑定定理包。下面用少量 Typst 代码给出与 LaTeX
示例等效的定理和证明；正式论文也可以自行导入 theorion 等定理包。

#let theorem-counter = counter("thuthesis-example-theorem")
#let example-theorem(title: none, body) = context {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 0.8em,
    stroke: 0.5pt + luma(160),
    radius: 2pt,
  )[
    *定理 #theorem-counter.display("1")#if title != none [（#title）]*
    #body
  ]
}
#let example-proof(body) = {
  strong[证明]
  h(1em)
  body
  h(1fr)
  [$square$]
}

#example-theorem(title: [Lindeberg–Lévy 中心极限定理])[
  设随机变量 $X_1, X_2, dots, X_n$ 独立同分布，且具有期望 $mu$ 和有限的方差
  $sigma^2 != 0$，记 $macron(X)_n = 1/n sum_(i=1)^n X_i$，则

  $ lim_(n -> infinity) P((sqrt(n) (macron(X)_n - mu)) / sigma <= z) = Phi(z), $

  其中 $Phi(z)$ 是标准正态分布的分布函数。
]

#example-proof[结论由经典中心极限定理直接得到。]

常见的假设、定义、命题、引理、定理、公理、推论、例题、示例、注记、问题和猜想环境，可由论文作者选择的定理包统一定义。
