#import "../../../templates/illustration.tpl.typ": *
#show: illustration
#set text(font: "Love Ya Like A Sister")
#import "../calculations/glycin.typ": x, y, pl_average, pk1, pk2, pl_intercept

#import "@preview/lilaq:0.5.0" as lq
#show lq.selector(lq.legend): scale.with(60%, reflow: true)
#let diagram = lq.diagram(
  legend: (
    position: top + left,
    dx: 4mm,
  ),
  lq.plot(
    x,
    y,
    smooth: true,
    mark: none,
    color: or-preview(white, black),
  ),
  lq.ellipse(
    ..pl_average,
    width: 0.15cm,
    height: 0.15cm,
    stroke: or-preview(white, green) + 0.5pt,
    align: center + horizon,
    label: pad(top: 1mm)[$"pl"$ mittels $("pk"_1 + "pk"_2) / 2$]
  ),
  lq.place(
    ..pl_average,
    align: left,
    [
      #set text(size: 5pt)
      #show: pad.with(left: 1em, top: 1em)
      isoelektrischer Punkt
    ],
  ),
  lq.place(
    ..pk1,
    [
      #set text(size: 5pt)
      #line(angle: 90deg, length: 2mm, stroke: or-preview(white, red))
      #place(top + center, dy: -1em - 1mm)[$"pK"_1$]
    ]
  ),
  lq.place(
    ..pk2,
    [
      #set text(size: 5pt)
      #line(angle: 90deg, length: 2mm, stroke: or-preview(white, red))
      #place(bottom + center, dy: 1em + 1mm)[$"pK"_2$]
    ]
  ),
  lq.line(
    pk1,
    pk2,
    stroke: or-preview(white, red).transparentize(50%) + 0.5pt,
  ),
  lq.line(
    (pl_average.at(0), 0),
    (pl_average.at(0), 9),
    stroke: or-preview(white, black) + 0.5pt,
  ),
  lq.ellipse(
    ..pl_intercept,
    width: 0.15cm,
    height: 0.15cm,
    stroke: stroke(dash: "densely-dotted", paint: or-preview(white, red), thickness: 0.5pt) ,
    align: center + horizon,
    label: [$"pl"$ mittels Schnittpunkt]
  )
)

#grid(
  columns: (auto, auto),
  align: horizon,
  [
    $"pk"_1 = #calc.round(digits: 2, pk1.at(1))$\
    $"pk"_2 = #calc.round(digits: 2, pk2.at(1))$
    #v(-0.5em)
    #line(length: 100%, stroke: or-preview(white, black))
    Isoelektrischer\ Punkt

    $("pk"_1 + "pk"_2) / 2 = #calc.round(digits: 2, pl_average.at(1))$\
    $"Schnittpunkt" = #calc.round(digits: 2, pl_intercept.at(1))$
  ],
  diagram,
)
