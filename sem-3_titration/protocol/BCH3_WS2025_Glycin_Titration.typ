#import "../../templates/protocol.tpl.typ": bio-template, new-chapter

#set document(title: "Titrationskurve von Glycin")
#show: bio-template.with(
  show-cover-page: true,
  subtitle: "",
  author: none,
  members: ("Tim Peko", "Nathalie Sonnleitner"),
  course: "BCH3",
  semester: "WS 2025",
  language: "de",
  format-page-counter: (current, total) => [
    Seite #current / #total
  ],
  version: "0.1",
  date: datetime.today().display("TT.MM.JJJJ"),
)
#import "../analysis/visualizations.typ": *
#show link: it => {
  set text(fill: blue)
  underline(it)
}


#heading(depth: 1, outlined: false)[Inhaltsverzeichnis]

#outline(depth: 2, title: none)
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
#show image: rect.with(stroke: 0.5pt)

#new-chapter[Theorie]

#new-chapter[Experiment]

#new-chapter[Ergebnisse]

#set heading(numbering: none)
#new-chapter("Appendix")

== Sources

#bibliography("sources.yaml", title: none, style: "ieee")


// Attachments
#pdf.attach(
  "../instructions/TitrationGlycin_f.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Instructions for Experiment",
)

// #pdf.attach(
//   "data/chla.absorption.txt",
//   mime-type: "text/tab-separated-values",
//   relationship: "data",
//   description: "Chlorophyll A absorption data",
// )
// #pdf.attach(
//   "data/chlb.absorption.txt",
//   mime-type: "text/tab-separated-values",
//   relationship: "data",
//   description: "Chlorophyll B absorption data",
// )
// #pdf.attach(
//   "data/results.absorption.txt",
//   mime-type: "text/tab-separated-values",
//   relationship: "data",
//   description: "Experiment results absorption data",
// )
