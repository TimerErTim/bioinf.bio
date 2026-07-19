// Structural helpers for consistent result sections without cluttering the TOC.

#let result-label(title, body) = {
  block(breakable: false, sticky: true)[
    *#title:*\
  ]
  body
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
