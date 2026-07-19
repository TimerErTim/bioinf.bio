// Structural helpers for consistent result sections without cluttering the TOC.

#let result-label(title, body) = [
  *#title:*\
  #body
]

#let result-section(
  darstellung: [],
  erlaeuterung: none,
  interpretation: none,
  schlussfolgerung: none,
) = {
  darstellung
  if erlaeuterung != none {
    result-label[Erläuterung][#erlaeuterung]
    parbreak()
  }
  if interpretation != none {
    result-label[Interpretation][#interpretation]
    parbreak()
  }
  if schlussfolgerung != none {
    result-label[Schlussfolgerung][#schlussfolgerung]
    parbreak()
  }
}
