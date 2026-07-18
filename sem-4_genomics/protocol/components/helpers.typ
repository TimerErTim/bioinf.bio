// Structural helpers for consistent result sections without cluttering the TOC.

#let result-label(title, body) = {
  block(breakable: true, below: 2em)[
    #text(weight: "bold", size: 11pt, fill: rgb("#334155"))[#title]
    #v(-0.5em)
    #body
  ]
}

#let result-section(
  darstellung: [],
  erlaeuterung: none,
  interpretation: none,
  schlussfolgerung: none,
) = {
  darstellung
  if erlaeuterung != none {
    result-label[Erläuterung][#erlaeuterung]
  }
  if interpretation != none {
    result-label[Interpretation][#interpretation]
  }
  if schlussfolgerung != none {
    result-label[Schlussfolgerung][#schlussfolgerung]
  }
}
