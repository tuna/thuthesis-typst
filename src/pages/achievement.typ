/// Achievement Page
#let achievement(
  anonymous: false, // (bool) Hide identifying information.
  twoside: false, // (bool, str) Enable two-sided layout.
  degree: "bachelor", // (str) Degree level.
  title: auto, // (content) Page title.
  outlined: true, // (bool) Include the page in the outline.
  bookmarked: true, // (bool) Add a PDF bookmark.
  resume-title: [个人简历], // (content) Resume section title.
  resume: [], // (content) The resume content.
  achievement-title: [在学期间完成的相关学术成果], // (content) Achievements section title.
  paper-title: [学术论文：], // (content) Publications section title.
  paper: [], // (content) The list of papers.
  patent-title: [专利：], // (content) Patents section title.
  patent: [], // (content) The list of patents.
) = {
  if anonymous { return }

  import "../utils/font.typ": use-size
  import "../utils/util.typ": is-not-empty, twoside-pagebreak

  title = if title == auto {
    if (
      degree == "bachelor"
    ) [在学期间参加课题的研究成果] else [个人简历、在学期间完成的相关学术成果]
  } else { title }

  twoside-pagebreak(twoside)

  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    bookmarked: bookmarked,
    title,
  )

  if degree != "bachelor" {
    show heading.where(level: 2): it => {
      align(center, text(size: use-size("四号"), it.body))
    }
    heading(
      level: 2,
      numbering: none,
      outlined: false,
      bookmarked: false,
      resume-title,
    )
    v(8pt)
    resume
    v(8pt)
    par[]
    heading(
      level: 2,
      numbering: none,
      outlined: false,
      bookmarked: false,
      achievement-title,
    )
    if is-not-empty(paper) or is-not-empty(patent) { v(1.7em) }
  }

  set par(first-line-indent: 0pt, leading: 8pt)
  set enum(indent: 0pt, numbering: "[1]", body-indent: 1.2em, spacing: 1.14em)
  show heading.where(level: 2): it => { text(size: use-size("四号"), it.body) }

  if is-not-empty(paper) {
    heading(
      level: 2,
      numbering: none,
      outlined: false,
      bookmarked: false,
      paper-title,
    )
    v(1pt)
    paper
    par[]
    v(9pt)
  }

  if is-not-empty(patent) {
    heading(
      level: 2,
      numbering: none,
      outlined: false,
      bookmarked: false,
      patent-title,
    )
    v(1pt)
    patent
  }

  if not is-not-empty(paper) and not is-not-empty(patent) { [无。] }
}
