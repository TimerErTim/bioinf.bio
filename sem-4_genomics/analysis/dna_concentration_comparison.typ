#set page(
  width: auto,
  height: auto,
  fill: white.transparentize(100%),
  margin: 5mm,
)
#import "processing.typ": liver-weights-data, photometrie-data
#import "../../lib/maths/regression.typ": linear-regression-iterative
#import "../../lib/maths/statistics.typ": (
  correlation, wilcoxon-rank-sum-statistic, wilcoxon-signed-rank-statistic,
)

#let relevant-data = (
  photometrie-data.find(
    it => it.sample_source == "Leber" and it.trial == 1,
  ),
  photometrie-data.find(
    it => it.sample_source == "Bakterien" and it.trial == 2,
  ),
)

#set text(font: "Arial")
#import "@preview/lilaq:0.6.0" as lq
// Diagram for DNA concentration comparison
#lq.diagram(
  width: 7cm,
  title: [
    *Leber* vs *Bakterien* DNA Konzentration\
    \+RNase
  ],
  xlim: (0, auto),
  xaxis: (
    format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
    tick-args: (density: 70%),
    label: [DNA Konzentration],
  ),
  yaxis: (
    //tick-args: (tick-distance: 1.0),
    ticks: relevant-data
      .map(it => it.sample_source)
      .map(rotate.with(-45deg, reflow: true))
      .enumerate(),
  ),
  lq.hbar(
    relevant-data.map(it => it.with_rnase.stats.concentration.mean),
    range(relevant-data.len()),
  ),
  lq.plot(
    relevant-data.map(it => it.with_rnase.stats.concentration.mean),
    range(relevant-data.len()),
    xerr: relevant-data.map(it => it.with_rnase.stats.concentration.stddev),
    color: red,
    stroke: none,
  ),
)

#pagebreak()

// Statistics for DNA concentration comparison
#let weight-data = (
  relevant-data
    .find(it => it.sample_source == "Leber")
    .with_rnase
    .measures
    .map(it => (it.concentration, liver-weights-data.at(it.initials).weight_g))
)
#let correlation = correlation(
  weight-data.map(it => it.at(0)),
  weight-data.map(it => it.at(1)),
)
#lq.diagram(
  title: [Leber Gewicht vs. DNA Konzentration (\+RNase)],
  xaxis: (
    format-ticks: lq.tick-format.linear.with(suffix: $"g"$),
    tick-args: (density: 70%),
    label: [Leber Gewicht],
  ),
  yaxis: (
    format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
    tick-args: (density: 70%),
    label: [DNA Konzentration],
  ),
  lq.scatter(
    weight-data.map(it => it.at(1)),
    weight-data.map(it => it.at(0)),
    size: 6pt,
    label: [$"Corr"(X, Y)$ = #calc.round(correlation, digits: 2)],
  ),
)

#let wilcoxon-rank-sum-statistic = wilcoxon-rank-sum-statistic(
  relevant-data
    .find(it => it.sample_source == "Leber")
    .with_rnase
    .measures
    .map(it => it.concentration),
  relevant-data
    .find(it => it.sample_source == "Bakterien")
    .with_rnase
    .measures
    .map(it => it.concentration),
)
Konzentration *Leber* vs. *Bakterien*:\
Wilcoxon-Rang-Summen-Test = #wilcoxon-rank-sum-statistic.w-statistic \~ $W_(#wilcoxon-rank-sum-statistic.n_a, #wilcoxon-rank-sum-statistic.n_b) lt.eq.not underbrace(2, #place(center)[kritischer Wert]) =>$ #underline[*nicht signifikant*]

#v(1cm)
#let wilcoxon-signed-rank-statistic = wilcoxon-signed-rank-statistic(
  relevant-data
    .map(it => it.with_rnase.measures.map(it => it.concentration))
    .flatten()
    .zip(
      relevant-data
        .map(it => it.without_rnase.measures.map(it => it.concentration))
        .flatten(),
    ),
)
Konzentration *-RNase* vs. *+RNase*:\
Wilcoxon-Vorzeichen-Rang-Test = #wilcoxon-signed-rank-statistic.w-statistic \~ $W_(#wilcoxon-signed-rank-statistic.n) lt.eq.not underbrace(8, #place(center)[kritischer Wert]) =>$ #underline[*nicht signifikant*]


