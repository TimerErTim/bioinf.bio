#set page(width: auto, height: auto, fill: white.transparentize(100%), margin: 5mm)
#import "processing.typ": tests-data

#set text(font: "Arial")

#let stats-content(stats) = [
  $overline(x) plus.minus s =  #calc.round(digits: 2, stats.mean) #sym.plus.minus #calc.round(digits: 2, stats.stddev)$\
  Range: $#calc.round(digits: 1, stats.min) - #calc.round(digits: 1, stats.max)$\
  $n = #stats.values.len()$
]

#let stats-table(stats) = {
  table(
    columns: 4,
    table.header(
      table.cell(stroke: none)[],
      table.cell(fill: luma(90%))[*both eyes*],
      table.cell(fill: luma(90%))[*left eye*],
      table.cell(fill: luma(90%))[*right eye*],
    ),
    ..for (label, key) in (
      ("with glasses", "with-visual-aids"),
      ("without glasses", "no-visual-aids"),
    ) {
      (
        table.cell(fill: luma(90%))[*#label*],
        ..for eye-key in ("both", "left", "right") {
          let stat = stats.at(key).at(eye-key)
          (stats-content(stat),)
        }
      )
    }
  )
}

All time:
#stats-table(tests-data.stats)

#pagebreak()
MBI 2025:
#stats-table(tests-data.stats-mbi-2025)
