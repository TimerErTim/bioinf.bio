#import "../../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Lipase Analysis",
  subtitle: "Determination of Lipase Activity",
  author: "Tim Peko",
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "0.1",
  date: "2025-07-15",
)
#show link: it => underline(text(fill: blue)[#it])

#outline(depth: 2)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.equation(numbering: "(1)", number-align: start + top)
#show math.equation: it => {
  if it.block {
    rect(stroke: 0.5pt, radius: 0.25em, it)
  } else {
    it
  }
}
#show image: it => {
  rect(stroke: 0.5pt, it)
}

#pagebreak()
= Background

== Lipase



#pagebreak()
#set heading(numbering: none)
= Appendix

== Sources

#let source(title, url, date) = [
  #set par(justify: false)
  + "#title" at #link(url) (#date)
]



