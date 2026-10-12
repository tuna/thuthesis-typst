/// Declaration Page
#let declaration(
  anonymous: false, // (bool) Hide identifying information.
  twoside: false, // (bool, str) Enable two-sided layout.
  degree: "bachelor", // (str) Degree level.
  title: [声　明], // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  confidential: false, // (bool) Whether the thesis is confidential.
  body: [], // (content) The body content of the declaration page.
  back-vspace: 38pt, // (length) The vertical space after the body.
  back: "签  名：____________  日  期：____________", // (content) The back text for signatures.
) = {
  if anonymous { return }

  import "../utils/font.typ": use-size
  import "../utils/util.typ": is-not-empty, twoside-pagebreak

  let preset-body = (
    bachelor: [
      本人郑重声明：所呈交的综合论文训练论文，是本人在导师指导下，独立进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容外，本论文的研究成果不包含任何他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。
    ],
    graduate: [
      本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所取得的成果，不包含涉及国家秘密的内容。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。
    ],
    confidential: [
      本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。
    ],
  )

  /// Render the page
  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  if is-not-empty(body) { body } else {
    if degree == "bachelor" { preset-body.bachelor } else {
      if confidential { preset-body.confidential } else { preset-body.graduate }
    }
  }

  v(back-vspace)

  text(size: use-size(13pt), align(right, back))
}
