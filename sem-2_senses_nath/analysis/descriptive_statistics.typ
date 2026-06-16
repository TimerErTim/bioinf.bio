#set page(width: auto, height: auto, fill: white.transparentize(100%), margin: 5mm)
#import "processing.typ": tests-data

#set text(font: "Arial")

#let stats-content(stats) = [
  $overline(x) plus.minus s =  #calc.round(digits: 2, stats.mean) #sym.plus.minus #calc.round(digits: 2, stats.stddev)$\
  Range: $#calc.round(digits: 1, stats.min) - #calc.round(digits: 1, stats.max)$\
  $n = #stats.values.len()$
]

#table(
  columns: 4,
  table.header(
    table.cell(stroke: none)[],
    table.cell(fill: luma(90%))[*beide Augen*],
    table.cell(fill: luma(90%))[*linkes Auge*],
    table.cell(fill: luma(90%))[*rechtes Auge*],
  ),
  ..for (label, key) in (
    ("mit Brille", "with-visual-aids"),
    ("ohne Brille", "no-visual-aids"),
  ) {
    (
      table.cell(fill: luma(90%))[*#label*],
      ..for eye-key in ("both", "left", "right") {
        let stats = tests-data.stats.at(key).at(eye-key)
        (stats-content(stats),)
      }
    )
  }
)
