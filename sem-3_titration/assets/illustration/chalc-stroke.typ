#set page(fill: green.darken(75%))

#let chalc-stroke(width: 1pt, color: white) = {
  stroke(
    paint: tiling(
      size: (5pt, 1pt),
      {
        let transp-color = color.transparentize(25%)
        place(line(
          start: (0pt, 0pt),
          length: 10pt,
          angle: 10deg,
          stroke: stroke(paint: transp-color, thickness: 0.5pt),
        ))
        place(line(
          start: (2pt, 0pt),
          length: 10pt,
          angle: 10deg,
          stroke: stroke(paint: transp-color, thickness: 0.5pt),
        ))
        place(line(
          start: (0pt, 1pt),
          length: 10pt,
          angle: -10deg,
          stroke: stroke(paint: transp-color, thickness: 0.5pt),
        ))
        place(line(
          start: (0pt, 1pt),
          length: 10pt,
          angle: 0deg,
          stroke: stroke(paint: transp-color, thickness: 0.5pt),
        ))
        place(line(
          start: (0pt, 0.5pt),
          length: 2pt,
          angle: 0deg,
          stroke: stroke(paint: transp-color, thickness: 0.5pt),
        ))
      }
    ),
    thickness: width
  )
}
