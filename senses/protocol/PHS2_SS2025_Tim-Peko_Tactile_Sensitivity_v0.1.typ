#import "../../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Tactile Sensitivity",
  subtitle: "Determination of Methemoglobin in Blood",
  author: none,
  members: ("Tim Peko", "Moritz Kieselbach"),
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "0.1",
  date: "2025-06-16",
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

== 



#pagebreak()
#set heading(numbering: none)
= Appendix

== Sources

#let source(title, url, date) = [
  #set par(justify: false)
  + "#title" at #link(url) (#date)
]

#source(
  "Merkel nerve ending - Wikipedia",
  "https://en.wikipedia.org/wiki/Merkel_nerve_ending",
  "2025-06-16",
)
#source(
  "Touch: The Skin – Foundations of Neuroscience",
  "https://openbooks.lib.msu.edu/neuroscience/chapter/touch-the-skin/",
  "2025-06-16",
)
#source(
  "Histology, Meissner Corpuscle - StatPearls - NCBI Bookshelf",
  "https://www.ncbi.nlm.nih.gov/books/NBK518980/",
  "2025-06-16",
)
#source(
  "Pacinian corpuscle - Wikipedia",
  "https://en.wikipedia.org/wiki/Pacinian_corpuscle",
  "2025-06-16",
)
#source(
  "Two-point discrimination - Wikipedia",
  "https://en.wikipedia.org/wiki/Two-point_discrimination",
  "2025-06-16"
)
#source(
  "Neuroscience for Kids - Two Point Discrimination",
  "https://faculty.washington.edu/chudler/twopt.html",
  "2025-06-16"
)
#source(
  "Tactile spatial resolution in blind Braille readers - Neurology.org",
  "https://www.neurology.org/doi/10.1212/WNL.54.12.2230",
  "2025-06-16"
)

