= Mathematical Symbols and Equations

== Mathematical Symbols

Mathematical symbols in a Chinese thesis normally follow GB/T 3102.11—1993,
“Mathematical Signs and Symbols for Use in the Physical Sciences and
Technology,”#footnote[The former mandatory standard GB 3102.11—1993 became a recommended standard on March 23, 2017.] which adopted ISO 31-11:1992#footnote[The current edition is ISO 80000-2:2019.] with modifications. Its conventions differ in several respects from the defaults used by the American Mathematical Society:

+ Uppercase Greek letters are italic by default, as in
  $Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi Psi Omega$; a finite
  increment uses an upright $∆ x$.
+ The less-than-or-equal and greater-than-or-equal signs are $<=$ and $>=$.
+ Integral signs are upright, for example $integral$ and $integral.cont$.
+ The partial-derivative symbol $partial$ is upright.
+ Ellipses are vertically centered, as in $1, 2, dots, n$ and
  $1 + 2 + dots + n$.
+ The real and imaginary parts are upright, as in $upright("Re")$ and
  $upright("Im")$.

The author should apply the chosen standard consistently to mathematical
constants, special functions, differential symbols, vectors, and matrices. For
example,

$
  pi = 3.14 dots; quad upright(i)^2 = -1; quad upright(e) = lim_(n -> infinity) (1 + 1/n)^n.
$

Vectors, matrices, and tensors are normally bold italic, as in $bold(x)$ and
$bold(Sigma)$; the natural logarithm is written $ln x$.

The template selects `math-style: "GB"` for Chinese and `math-style: "TeX"` for
English. The author may also select `"GB"`, `"ISO"`, or `"TeX"` explicitly. The
GB style uses italic uppercase Greek letters, slanted inequality signs, upright
integral and partial-derivative symbols, centered ellipses, and upright real and
imaginary parts. The ISO style additionally places the limits of display
integrals above and below the integral sign. Document-level `show`, `set text`,
and equation functions can further configure fonts and symbols.

Quantities and units should use consistent formats for numbers, units, and
exponents, for example $6.4 times 10^6 "m"$, $9 "μm"$,
$"kg" dot "m" dot "s"^(-1)$, and $10 "°C" dash 20 "°C"$.

== Mathematical Equations

Display equations can be written directly with spaced mathematical markup.
References to equations should be enclosed in parentheses, as in @eq:example.

$
  1 / (2 pi upright(i)) integral_gamma f = sum_(k=1)^m n(gamma; a_k) cal(R)(f; a_k).
$ <eq:example>

Multiline equations should align at the equals sign where possible. Use `&` to
specify alignment points:

#align(center, grid(
  columns: (auto, auto),
  align: (right, left),
  column-gutter: 0.5em,
  [$a$], [$= b + c + d + e$],
  [], [$= f + g$],
))

== Mathematical Theorems

The template does not require a particular theorem package. The following small
Typst definitions produce a theorem and proof equivalent to the LaTeX example;
a formal thesis may instead import a package such as theorion.

#let theorem-counter = counter("thuthesis-example-theorem-en")
#let example-theorem(title: none, body) = context {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 0.8em,
    stroke: 0.5pt + luma(160),
    radius: 2pt,
  )[
    *Theorem #theorem-counter.display("1")#if title != none [ (#title)]*
    #body
  ]
}
#let example-proof(body) = {
  strong[Proof]
  h(1em)
  body
  h(1fr)
  [$square$]
}

#example-theorem(title: [Lindeberg–Lévy central limit theorem])[
  Let $X_1, X_2, dots, X_n$ be independent and identically distributed random
  variables with expectation $mu$ and finite variance $sigma^2 != 0$. Define
  $macron(X)_n = 1/n sum_(i=1)^n X_i$. Then

  $ lim_(n -> infinity) P((sqrt(n) (macron(X)_n - mu)) / sigma <= z) = Phi(z), $

  where $Phi(z)$ is the cumulative distribution function of the standard normal
  distribution.
]

#example-proof[The result follows directly from the classical central limit theorem.]

Authors may use their chosen theorem package to define hypotheses, definitions,
propositions, lemmas, theorems, axioms, corollaries, exercises, examples,
remarks, problems, and conjectures consistently.
