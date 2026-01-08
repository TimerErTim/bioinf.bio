#import "../../../templates/illustration.tpl.typ": *
#show: illustration
#set text(font: "Love Ya Like A Sister")
#import "../calculations/comparison.typ": corr-table, q-factor-table, mixed-normalized-table

#let (Average: average, Intercept: intercept, Derivative: derivative) = mixed-normalized-table

#table(
  columns: 2,
  stroke: none,
  row-gutter: (0pt, 4em),
  column-gutter: 1em,
  table.header[
    *Linear*
  ][*Geometr. Fehler*],
  ..for values in (average, derivative, intercept) {
    (..values.map(it => [#calc.round(digits: 1, it * 100)%]))
  },
)