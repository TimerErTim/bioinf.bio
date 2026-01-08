#import "../../../lib/maths/statistics.typ": *
#import "glycin.typ" as gly
#import "histidin.typ" as hist

#let expected-values-gly = (
  "pk1": 2.34,
  "pk2": 9.60,
  "pl": 5.97,
)

#let expected-values-hist = (
  "pk1": 1.82,
  "pk2": 9.17,
  "pk3": 6.00,
  "pl": 7.59,
)

#let q-factor-pl(pl, pkleft, pkright) = {
  (pl - pkleft) / (pkright - pkleft)
}

#let (empiric-val-gly-average, empiric-val-gly-intercept, empiric-val-gly-derivative) = (
  gly.pl_average.at(1),
  gly.pl_intercept.at(1),
  gly.pl_derivative.at(1),
).map(it => (
  "pk1": gly.pk1.at(1),
  "pk2": gly.pk2.at(1),
  "pl": it,
))

#let (empiric-val-hist-average, empiric-val-hist-intercept, empiric-val-hist-derivative) = (
  hist.pl_average.at(1),
  hist.pl_intercept.at(1),
  hist.pl_derivative.at(1),
).map(it => (
  "pk1": hist.pk1.at(1),
  "pk2": hist.pk2.at(1),
  "pk3": hist.pk3.at(1),
  "pl": it,
))

#let corr-table = (
  "Average": (
    correlation(empiric-val-gly-average.values(), expected-values-gly.values()),
    correlation(empiric-val-hist-average.values(), expected-values-hist.values()),
  ),
  "Intercept": (
    correlation(empiric-val-gly-intercept.values(), expected-values-gly.values()),
    correlation(empiric-val-hist-intercept.values(), expected-values-hist.values()),
  ),
  "Derivative": (
    correlation(empiric-val-gly-derivative.values(), expected-values-gly.values()),
    correlation(empiric-val-hist-derivative.values(), expected-values-hist.values()),
  ),
)
#let _min-comp-val = corr-table.values().flatten().reduce(calc.min)
#let _max-comp-val = corr-table.values().flatten().reduce(calc.max)

#let normalized-corr-table = (
  corr-table
    .pairs()
    .map(((label, values)) => (
      label,
      values.map(it => (it - _min-comp-val) * (_max-comp-val / (_max-comp-val - _min-comp-val))),
    ))
    .to-dict()
)

#table(
  columns: 3,
  table.header[#table.cell(stroke: none)[]][
    *Glycin*
  ][*Histidin*],
  ..for (label, values) in normalized-corr-table {
    (label, ..values.map(it => [#calc.round(digits: 1, it * 100)%]))
  },
)

#let comp-q-gly(expected, empiric) = {
  calc.abs(q-factor-pl(empiric.at("pl"), empiric.at("pk1"), empiric.at("pk2")) - q-factor-pl(expected.at("pl"), expected.at("pk1"), expected.at("pk2")))
}

#let comp-q-hist(expected, empiric) = {
  calc.abs(q-factor-pl(empiric.at("pl"), empiric.at("pk3"), empiric.at("pk2")) - q-factor-pl(expected.at("pl"), expected.at("pk3"), expected.at("pk2")))
}

#let q-factor-table = (
  "Average": (
    comp-q-gly(expected-values-gly, empiric-val-gly-average),
    comp-q-hist(expected-values-hist, empiric-val-hist-average),
  ),
  "Intercept": (
    comp-q-gly(expected-values-gly, empiric-val-gly-intercept),
    comp-q-hist(expected-values-hist, empiric-val-hist-intercept),
  ),
  "Derivative": (
    comp-q-gly(expected-values-gly, empiric-val-gly-derivative),
    comp-q-hist(expected-values-hist, empiric-val-hist-derivative),
  ),
)
#let _min-comp-q-val = q-factor-table.values().flatten().reduce(calc.min)
#let _max-comp-q-val = q-factor-table.values().flatten().reduce(calc.max)
#let normalized-q-factor-table = (
  q-factor-table
    .pairs()
    .map(((label, values)) => (label, values.map(it => (it - _min-comp-q-val) * (_max-comp-q-val / (_max-comp-q-val - _min-comp-q-val)))))
    .to-dict()
)

#let mixed-normalized-table = normalized-corr-table.pairs().zip(normalized-q-factor-table.values()).map((((label, corr-val), q-val)) => (
  label,
  (mean(corr-val), mean(q-val))
)).to-dict()

#table(
  columns: 3,
  table.header[#table.cell(stroke: none)[]][
    *Glycin*
  ][*Histidin*],
  ..for (label, values) in normalized-q-factor-table {
    (label, ..values.map(it => [#calc.round(digits: 1, it * 100)%]))
  },
)

#table(
  columns: 3,
  table.header[#table.cell(stroke: none)[]][
    *Corr(...)*
  ][*Q-Factor Error*],
  ..for (label, values) in mixed-normalized-table {
    (label, ..values.map(it => [#calc.round(digits: 1, it * 100)%]))
  },
)