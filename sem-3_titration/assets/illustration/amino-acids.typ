#set page(fill: green.darken(75%))

#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import "./chalc-stroke.typ": chalc-stroke

#let amino-acid-canonical = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(color: white, width: 2pt))

  fletcher.diagram(
    spacing: 1em,
    node((1, 1), [$C$]),
    node((1, 0), [$H$]),
    node((1, 2), [$R$]),
    node((0, 1), [$H_2 N$]),
    node((2, 1), [$C O O H$]),

    chalc-edge((1, 1), (0, 1)),
    chalc-edge((1, 1), (1, 2)),
    chalc-edge((1, 1), (2, 1)),
    chalc-edge((1, 1), (1, 0))
  )
}

#let amino-acid-cationic = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(color: white, width: 2pt))

  fletcher.diagram(
    spacing: 1em,
    node((1, 1), [$C$]),
    node((1, 0), [$H$]),
    node((1, 2), [$R$]),
    node((0, 1), [$H_3^+ N$]),
    node((2, 1), [$C O O^-$]),

    chalc-edge((1, 1), (0, 1)),
    chalc-edge((1, 1), (1, 2)),
    chalc-edge((1, 1), (2, 1)),
    chalc-edge((1, 1), (1, 0))
  )
}

#let amino-acid-deprotonated = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(color: white, width: 2pt))

  fletcher.diagram(
    spacing: 1em,
    node((1, 1), [$C$]),
    node((1, 0), [$H$]),
    node((1, 2), [$R$]),
    node((0, 1), [$H_2 N$]),
    node((2, 1), [$C O O^-$]),

    chalc-edge((1, 1), (0, 1)),
    chalc-edge((1, 1), (1, 2)),
    chalc-edge((1, 1), (2, 1)),
    chalc-edge((1, 1), (1, 0))
  )
}

#let amino-acid-protonated = {
  set text(font: "Lato", stroke: chalc-stroke(color: white))
  show math.equation: set text(font: "Fira Math")
  let chalc-edge(..args) = edge(..args, stroke: chalc-stroke(color: white, width: 2pt))

  fletcher.diagram(
    spacing: 1em,
    node((1, 1), [$C$]),
    node((1, 0), [$H$]),
    node((1, 2), [$R$]),
    node((0, 1), [$H_3^+ N$]),
    node((2, 1), [$C O O H$]),

    chalc-edge((1, 1), (0, 1)),
    chalc-edge((1, 1), (1, 2)),
    chalc-edge((1, 1), (2, 1)),
    chalc-edge((1, 1), (1, 0))
  )
}

#amino-acid-cationic
