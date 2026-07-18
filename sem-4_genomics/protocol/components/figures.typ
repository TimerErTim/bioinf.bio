#let rnase-legend = (
  minus: box(stroke: blue, inset: 1em / 2, baseline: 1em / 4),
  plus: box(stroke: green, inset: 1em / 2, baseline: 1em / 4),
)

#let annotated-leber-unrestr-gelelectro = {
  show: block.with(width: 15cm, height: 8.5cm)
  image("../../assets/leber-unrestr-gelelectro.png", width: 100%)
  let draw-rect(x, y, width, height, ..args) = {
    place(top + left, dx: x, dy: y, {
      rect(width: width, height: height, ..args)
    })
  }
  set rect(radius: 0.5em)
  draw-rect(2%, 10%, 10%, 89%, stroke: green + 2pt)
  draw-rect(13%, 10%, 9%, 89%, stroke: blue + 2pt)
  draw-rect(23%, 9.75%, 9%, 89.25%, stroke: green + 2pt)
  draw-rect(33%, 9.75%, 8.5%, 89%, stroke: blue + 2pt)
  draw-rect(42.25%, 9.5%, 7.75%, 88%, stroke: green + 2pt)
  draw-rect(50.75%, 9%, 8.25%, 88.2%, stroke: blue + 2pt)
  draw-rect(60%, 8%, 9.25%, 90%, stroke: green + 2pt)
  draw-rect(70%, 8%, 8.25%, 89%, stroke: blue + 2pt)
  draw-rect(79%, 7%, 8.5%, 89.2%, stroke: green + 2pt)
  draw-rect(88.5%, 7%, 8.25%, 90%, stroke: blue + 2pt)
  set text(weight: "bold", size: 16pt)
  place(top + left, dx: 10%, dy: 1mm)[LS]
  place(top + left, dx: 30%, dy: 1mm)[SG]
  place(top + left, dx: 48%, dy: 1mm)[NS]
  place(top + left, dx: 68%, dy: 1mm)[TP]
  place(top + left, dx: 86%, dy: 1mm)[SS]
}

#let figure-leber-unrestr-gel = {
  show: figure.with(
    caption: [
      Gelelektrophorese unrestriktierter Leber-DNA: _-RNase_ (#rnase-legend.minus) und _+RNase_ (#rnase-legend.plus). Marker: GeneRuler 1 kb Plus [kbp].
    ],
  )
  set rect(inset: 0pt)
  place(top + left, dx: 8%)[Marker]
  box(image("../../assets/leber-unrestr-ref-marker.png", width: 8.7%), baseline: -1mm)
  box(scale(annotated-leber-unrestr-gelelectro, 80%, reflow: true))
}

#let figure-genruler-ladder = {
  show: figure.with(
    caption: [DNA-Ladder GeneRuler#super[TM] 1 kb Plus. Bandengrößen in kbp.],
  )
  image("../../assets/genruler-1kb-plus.png")
}

#let annotated-leber-restr-gelelectro = {
  show: block.with(height: 5cm + 1em, stroke: 0pt)
  {
    show: pad.with(top: 1em)
    box(image("../../assets/ss-restr-leber.png", height: 100%))
    box(image("../../assets/ls-restr-leber.png", height: 100%))
    box(image("../../assets/sg-restr-leber.png", height: 100%))
  }
  place(top + left, dx: 5%, dy: 1mm)[SS]
  place(top + left, dx: 32.5%, dy: 1mm)[LS]
  place(top + left, dx: 70%, dy: 1mm)[SG]
}

#let figure-leber-restr-gel = {
  show: figure.with(
    caption: [
      Gelelektrophorese von mit Restriktionsenzymen verdauter Leber-DNA (_+RNase_). Proben SS (EcoRI), LS (PstI), SG (NaeI).
    ],
  )
  set rect(inset: 0pt)
  annotated-leber-restr-gelelectro
}

#let annotated-bakterien-unrestr-gelelectro = {
  show: block.with(width: 100%, height: 4.82cm + 1em, stroke: 0pt)
  {
    show: pad.with(top: 1em)
    box(image("../../assets/bakterien-unrestr-gel-1.png", height: 100%))
    box(image("../../assets/bakterien-unrestr-gel-2.png", height: 100%))
  }
  let draw-rect(x, y, width, height, ..args) = {
    place(top + left, dx: x, dy: y, {
      rect(width: width, height: height, ..args)
    })
  }
  set rect(radius: 0.5em)
  draw-rect(0.25%, 8%, 4.5%, 90%, stroke: green + 1.5pt)
  draw-rect(5.25%, 8%, 4.75%, 90%, stroke: blue + 1.5pt)
  draw-rect(10.75%, 8%, 4.5%, 90%, stroke: blue + 1.5pt)
  draw-rect(16.25%, 8%, 4.75%, 90%, stroke: green + 1.5pt)
  draw-rect(24%, 10%, 5%, 88%, stroke: blue + 1.5pt)
  draw-rect(29.5%, 10%, 4.75%, 88%, stroke: blue + 1.5pt)
  draw-rect(34.75%, 10%, 5%, 88%, stroke: blue + 1.5pt)
  draw-rect(40.75%, 10%, 4.75%, 88%, stroke: green + 1.5pt)
  draw-rect(46.25%, 10%, 4.5%, 88%, stroke: green + 1.5pt)
  draw-rect(51.25%, 10%, 4.75%, 88%, stroke: blue + 1.5pt)
  draw-rect(56.5%, 10%, 4.5%, 88%, stroke: blue + 1.5pt)
  draw-rect(61.5%, 10%, 4.75%, 88%, stroke: green + 1.5pt)
  draw-rect(66.75%, 10%, 4.5%, 88%, stroke: green + 1.5pt)
  place(top + left, dx: 3%, dy: 1mm)[CB]
  place(top + left, dx: 14%, dy: 1mm)[EL]
  place(top + left, dx: 25%, dy: 1mm)[EL]
  place(top + left, dx: 33%, dy: 1mm)[LH]
  place(top + left, dx: 44%, dy: 1mm)[LH]
  place(top + left, dx: 55%, dy: 1mm)[AL]
  place(top + left, dx: 65%, dy: 1mm)[AL]
  place(top + left, dx: 90%, dy: 1mm)[Marker]
}

#let figure-bakterien-unrestr-gel = {
  show: figure.with(
    caption: [
      Gelelektrophorese unrestriktierter Bakterien-DNA: _-RNase_ (#rnase-legend.minus) und _+RNase_ (#rnase-legend.plus).
    ],
  )
  set rect(inset: 0pt)
  annotated-bakterien-unrestr-gelelectro
}

#let figure-erwartung-unrestr-bakterien = {
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild unrestriktierter Bakterien-DNA (Literatur). @src_unrestr-bakterien-gel-erw_img],
  )
  image("../../assets/erwartung-unrestr-bakterien.png")
}

#let figure-erwartung-restr-bakterien = {
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild restr.-verdauter Bakterien-DNA (Literatur). Spalten „E“ = *E. coli*. @src_restr-bakterien-gel-erw_img],
  )
  set rect(inset: 0pt)
  image("../../assets/erwartung-restr-bakterien.png")
}
