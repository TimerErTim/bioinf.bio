#import "@preview/lilaq:0.5.0" as lq

#let _is-preview() = {
  "x-preview" in sys.inputs
}

#let or-preview(default, preview) = {
  if _is-preview() { preview } else { default }
}

#let illustration(body) = {
  set page(fill: white.transparentize(100%), width: auto, height: auto, margin: 1mm)
  set text(fill: or-preview(white, black), size: 8pt, font: "Lato")
  show math.equation: set text(font: "Fira Math")

  show: it => lq.theme.schoolbook(it)
  show: lq.set-spine(stroke: or-preview(white, black))
  show: lq.set-legend(fill: white.transparentize(100%))
  set table(stroke: or-preview(white, black))

  body
}

