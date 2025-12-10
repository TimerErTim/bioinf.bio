#set page(fill: if sys.inputs.at("x-preview", default: none) == none { none } else { gray.darken(75%) }, width: auto, height: auto)
#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import "./chalc-stroke.typ": chalc-stroke
#import "./amino-acids.typ": *

#let zwitterion = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(color: white, width: 2pt))

  fletcher.diagram(
    spacing: (6em, 4em),
    node-shape: rect,
    node((0, 0), [Deprotonisiert\ #amino-acid-deprotonated]),
    chalc-edge("-harpoon", label: text(stroke: chalc-stroke(color: red), $+ H^+$), shift: 2pt),
    chalc-edge("harpoon'-", label: text(stroke: chalc-stroke(color: blue), $- H^+$), shift: -2pt, label-side: right),
    node((1, 0), [Physiologisch\ #amino-acid-cationic]),
    chalc-edge("-harpoon", label: text(stroke: chalc-stroke(color: red), $+ H^+$), shift: 2pt),
    chalc-edge("harpoon'-", label: text(stroke: chalc-stroke(color: blue), $- H^+$), shift: -2pt, label-side: right),
    node((2, 0), [Protonisiert\ #amino-acid-protonated]),
    chalc-edge((1, 0.5), (1, 1), "-harpoon", shift: 2pt),
    chalc-edge((1, 0), (1, 1), "harpoon'-", shift: -2pt, label: [#h(0.5em) Zwitterion Eigenschaft], label-side: left),
    node((1, 1), amino-acid-canonical)
  )
}

#zwitterion