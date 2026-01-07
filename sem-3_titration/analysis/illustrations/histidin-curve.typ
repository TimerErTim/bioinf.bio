#import "../../../templates/illustration.tpl.typ": *
#show: illustration
#set text(font: "Love Ya Like A Sister")
#import "../calculations/histidin.typ": d2y, d3y, dy, pk1, pk2, pk3, pl_average, pl_derivative, pl_intercept, x, y

#import "@preview/lilaq:0.5.0" as lq
#show lq.selector(lq.legend): scale.with(60%, reflow: true)

#(
  range(3)
    .map(it => {
      let ellipse = if it == 0 {
        lq.ellipse(
          ..pl_average,
          width: 0.15cm,
          height: 0.15cm,
          stroke: or-preview(white, green) + 0.5pt,
          align: center + horizon,
          label: pad(top: 1mm)[$"pl"$ mittels $("pk"_1 + "pk"_2) / 2$],
        )
      } else if it == 1 {
        lq.ellipse(
          ..pl_intercept,
          width: 0.15cm,
          height: 0.15cm,
          stroke: or-preview(white, green) + 0.5pt,
          align: center + horizon,
          label: [$"pl"$ mittels Schnittpunkt],
        )
      } else {
        lq.ellipse(
          ..pl_derivative,
          width: 0.15cm,
          height: 0.15cm,
          stroke: or-preview(white, green) + 0.5pt,
          align: center + horizon,
          label: [$"pl"$ mittels Wendepunkt],
        )
      }

      let iep-value = if it == 0 [
        $("pk"_1 + "pk"_2) / 2$\
        $= #calc.round(digits: 2, pl_average.at(1))$
      ] else if it == 1 [
        Schnittpunkt\
        $= #calc.round(digits: 2, pl_intercept.at(1))$
      ] else [
        Wendepunkt\
        $= #calc.round(digits: 2, pl_derivative.at(1))$
      ]

      let diagram = lq.diagram(
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
            #place(top + center, dy: -1em - 1mm, dx: 1em)[$"pK"_1$]
          ],
        ),
        lq.place(
          ..pk2,
          [
            #set text(size: 5pt)
            #line(angle: 90deg, length: 2mm, stroke: or-preview(white, red))
            #place(top + center, dy: -1em - 1mm)[$"pK"_2$]
          ],
        ),
        lq.place(
          ..pk3,
          [
            #set text(size: 5pt)
            #line(angle: 90deg, length: 2mm, stroke: or-preview(white, red))
            #place(bottom + center, dy: 1em + 1mm)[$"pK"_3$]
          ],
        ),
        lq.line(
          pk2,
          pk3,
          stroke: or-preview(white, red).transparentize(50%) + 0.5pt,
        ),
        lq.line(
          (pl_average.at(0), 0),
          (pl_average.at(0), 9),
          stroke: or-preview(white, black) + 0.5pt,
        ),
        ellipse,
      )

      grid(
        columns: (auto, auto),
        align: horizon,
        [
          $"pk"_1 = #calc.round(digits: 2, pk1.at(1))$\
          $"pk"_2 = #calc.round(digits: 2, pk2.at(1))$\
          $"pk"_3 = #calc.round(digits: 2, pk3.at(1))$
          #v(-0.5em)
          #line(length: 100%, stroke: or-preview(white, black))
          Isoelektrischer\ Punkt

          #iep-value
        ],
        diagram,
      )
      colbreak()
    })
    .join([])
)

#lq.diagram(
  lq.plot(
    x,
    dy,
    smooth: true,
    mark: none,
    stroke: stroke(paint: or-preview(white, blue), thickness: 0.5pt),
    label: [$f'$],
  ),
)


#lq.diagram(
  lq.plot(
    x,
    d2y,
    smooth: true,
    mark: none,
    stroke: stroke(paint: or-preview(white, blue), thickness: 0.5pt),
    label: [$f'$],
  ),
)

#lq.diagram(
  lq.plot(
    x,
    d3y,
    smooth: true,
    mark: none,
    stroke: stroke(paint: or-preview(white, blue), thickness: 0.5pt),
    label: [$f'$],
  ),
)
