#import "../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Lipase Analysis",
  subtitle: "Determination of Methemoglobin in Blood",
  author: "Tim Peko",
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "0.1",
  date: "2025-06-06",
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

#source("Hemoglobin - Wikipedia", "https://en.wikipedia.org/wiki/Hemoglobin", "2025-05-26")
#source(
  "Cyanmethemoglobin Method For The Estimation Of Hemoglobin",
  "https://laboratorytests.org/cyanmethemoglobin-method/",
  "2025-05-26",
)
#source("Methemoglobinemia - Wikipedia", "https://en.wikipedia.org/wiki/Methemoglobinemia", "2025-05-26")
#source(
  "Hemoglobin and its measurement",
  "https://acutecaretesting.org/en/articles/hemoglobin-and-its-measurement",
  "2025-05-26",
)
#source(
  "[PDF] Drabkin's Reagent (D5941) - Datasheet - Sigma-Aldrich",
  "https://www.sigmaaldrich.com/deepweb/assets/sigmaaldrich/product/documents/139/718/d5941dat.pdf?srsltid=AfmBOoru-9lYL7u5ha3B3y4N6n8y0q4yk6dqfKOusmH2VnBURns0na9F",
  "2025-05-26",
)
#source("Reflotron®", "https://photos.labwrench.com/equipmentManuals/11023-6349.pdf", "2025-05-26")
#source(
  "Low Hemoglobin: Causes, Signs & Treatment",
  "https://my.clevelandclinic.org/health/symptoms/17705-low-hemoglobin",
  "2025-05-26",
)

