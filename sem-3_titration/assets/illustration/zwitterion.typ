#set page(
  fill: if sys.inputs.at("x-preview", default: none) == none { none } else {
    gray.darken(75%)
  },
  width: auto,
  height: auto,
)
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "./chalc-stroke.typ": chalc-stroke
#import "./amino-acids.typ": *

#let zwitterion = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(
    color: white,
    width: 2pt,
  ))

  fletcher.diagram(
    spacing: 5em,
    node((0, 0), amino-acid-canonical),
    node((1, 0), amino-acid-cationic),
    chalc-edge((0, 0), (0.5, 0), "harpoon'-", shift: -2pt),
    chalc-edge(auto, (0, 0), "harpoon'-", shift: -2pt),
  )
}

#zwitterion
