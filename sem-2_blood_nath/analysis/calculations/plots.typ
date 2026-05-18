#import "@preview/lilaq:0.6.0" as lq
#import "data-processing.typ": (
  data-acute-erkrankungen-group, data-all-group, data-allergies-group,
  data-current-year-group, data-dict, stats-acute-erkrankungen-group,
  stats-all-group, stats-allergies-group, stats-current-year-group, adult-leukozyten-reference-data-probs,
)
#import "../../../lib/maths/statistics.typ": mean, median, stddev, chi-square-anpassungstest, one-sample-t-test,  two-sample-t-test, is-contingency-table-significant-independent

#let heatmap-leukozyten-difference(
  width: 75%,
  height: 100%,
  data-transform: it => it,
  title: none
) = {
  show: lq.set-diagram(width: width, height: height)
  let filtered-data = data-dict
    .filter(it => it.at("unprocessable", default: false) == false)
    .rev()
  let data = data-transform(filtered-data)

  let mesh = lq.colormesh(
    range(5),
    range(data.len()),
    (x, y) => calc.sqrt(data.at(y).chi-square-deviations.values().at(x)),
    map: color.map.mako,
  )

  show: block.with(breakable: true, width: width)
  if title != none {
    set text(size: 12pt)
    show: strong
    title
  }
  grid(
    columns: (1fr, auto),
    gutter: 2mm,
    lq.diagram(
      width: 100%,
      yaxis: none,
      xaxis: (
        ticks: data
          .at(0)
          .chi-square-deviations
          .keys()
          .map(rotate.with(-30deg, reflow: true))
          .enumerate(),
      ),
      mesh,
    ),
    grid.cell(inset: (bottom: 1em + 2pt), lq.colorbar(
      mesh,
      width: 5mm,
    )),
  )
}

#let table-descriptive-statistics = {
  set text(size: 10pt)
  table(
    columns: stats-all-group.keys().len() + 1,
    table.header([*Gruppe*\ (Stichproben-größe)], ..stats-all-group
      .pairs()
      .map(((key, val)) => [*#key* [#val.symbol]])),
    ..for (label, subset) in (
      ("Alle", stats-all-group),
      ("MBI 2025", stats-current-year-group),
      ("mit Allergien", stats-allergies-group),
      ("Akute Erkrankungen", stats-acute-erkrankungen-group),
    ) {
      (
        [#label\ (#subset.Gesamt.values.len())],
        ..subset
          .values()
          .map(it => [
            $#calc.round(digits: 2, it.mean) #sym.plus.minus #calc.round(digits: 1, it.stddev)$\
            min: #calc.round(digits: 2, it.min)\
            max: #calc.round(digits: 2, it.max)
          ]),
      )
    }
  )
}

#let boxplot-leukozyten = {
  let group-labels = ("Alle", "MBI 2025", "mit Allergien", "Akute Erkrankungen")
  let relevant-keys = stats-all-group.keys().filter(it => it != "Gesamt")
  let color-map = lq.color.map.petroff10
  let boxplots = for (i, (label, subset)) in group-labels
    .zip((
      stats-all-group,
      stats-current-year-group,
      stats-allergies-group,
      stats-acute-erkrankungen-group,
    ))
    .enumerate() {
    (
      lq.hboxplot(
        label: [#label],
        stroke: color-map.at(i).darken(25%),
        fill: color-map.at(i).lighten(10%),
        median: color-map.at(i).darken(75%),
        y: range(relevant-keys.len()).map(it => (
          it + (1 - i / (group-labels.len() - 1) - 0.5) * 0.6
        )),
        width: 0.75 / group-labels.len(),
        cap-length: 0.5 / group-labels.len(),
        outlier-size: 2pt,
        outlier-stroke: color-map.at(i).darken(50%),
        ..relevant-keys.map(key => subset.at(key).values),
      ),
    )
  }

  lq.diagram(
    height: 10cm,
    width: 100%,
    yaxis: (
      ticks: relevant-keys
        .map(rotate.with(-40deg, reflow: true))
        .map(text.with(size: 8pt))
        .enumerate(),
    ),
    ..boxplots,
  )
}

#let table-chi-square-anpassungstest(data: data-all-group) = {
  let observed-categories = data.first().chi-square-deviations.pairs().map(((key, _)) => (key, 0)).to-dict()
  for entry in data {
    for key in entry.chi-square-deviations.keys() {
      observed-categories.at(key) += entry.at(key)
    }
  }

  let exp-probs-categories = observed-categories.keys().map(key => (key, adult-leukozyten-reference-data-probs.at(key))).to-dict()

  let test-results = chi-square-anpassungstest(observed-categories.values(), exp-probs-categories.values())
  
  (table(
    columns: 4,
    table.header[*Kategorie*][*Beobachtet*][*Erwarteter Anteil*][*Erwarteter Betrag*],
    ..for (i, label) in observed-categories.keys().enumerate() {
      (
        [#label],
        [#observed-categories.at(label)],
        [#calc.round(digits: 2, exp-probs-categories.at(label) * 100)%],
        [#calc.round(digits: 2, test-results.expected.at(i))],
      )
    }
  ), test-results)
}

#let table-chi-square-independence-test(group1, group2) = {
  let group1-label = group1.label
  let group2-label = group2.label
  let group1 = group1.data
  let group2 = group2.data
  let relevant-categories = group1.first().chi-square-deviations.keys()
  let group1-observed = relevant-categories.map(key => (key, 0)).to-dict()
  let group2-observed = relevant-categories.map(key => (key, 0)).to-dict()
  for entry in group1 {
    for key in relevant-categories {
      group1-observed.at(key) += entry.at(key)
    }
  }
  for entry in group2 {
    for key in relevant-categories {
      group2-observed.at(key) += entry.at(key)
    }
  }

  let test-results = is-contingency-table-significant-independent(group1-observed.values(), group2-observed.values())
  (table(
    columns: relevant-categories.len() + 1,
    table.header([*Gruppe*], ..relevant-categories.map(label => [*#label*])),
    ..for (label, observations) in ((group1-label, group1-observed), (group2-label, group2-observed)) {
      ([#label], ..observations.values().map(it => [#it]))
    }
  ), test-results)
}

#let table-one-sample-t-tests(stats: stats-all-group) = {
  let transform-p(p) = calc.asin(calc.sqrt(p)).deg() / 90

  let (..stats, Gesamt) = stats
  let expected-mus = stats.keys().map(key => adult-leukozyten-reference-data-probs.at(key))
  let test-results = for (key, expected-mu) in stats.keys().zip(expected-mus) {
    if stats.at(key).stddev == 0 {
      continue
    }
    ((key, (expected-mu: expected-mu, ..one-sample-t-test(stats.at(key).values.map(it => it / 100).map(transform-p), expected-mu: expected-mu))),).to-dict()
  }
  table(
    columns: 6,
    table.header[*Zelltyp*][*Durchschnittswert*][*Anteil aus Referenz*][*t-Wert*][*p-Wert*][*signifikanter Unterschied?*],
    ..for (label, test-results) in test-results.pairs() {
      ( [#label], [#calc.round(digits: 2, stats.at(label).mean)%], [#calc.round(digits: 2, test-results.expected-mu * 100)%], [#calc.round(digits: 2, test-results.t-value)], [#calc.round(digits: 5, test-results.p-value * 100)%], if test-results.is-significant [ja #sym.checkmark] else [nein #sym.crossmark] )
    }
  )
}

#let table-two-sample-t-tests(stats1, stats2) = {
  let transform-p(p) = calc.asin(calc.sqrt(p)).deg() / 90

  let label1 = stats1.label
  let label2 = stats2.label
  let (..stats1, Gesamt) = stats1.statistics
  let (..stats2, Gesamt) = stats2.statistics
  let test-results = for key in stats1.keys() {
    let data1 = stats1.at(key)
    let data2 = stats2.at(key)
    let result = two-sample-t-test(data1.values.map(it => it / 100).map(transform-p), data2.values.map(it => it / 100).map(transform-p))
    ((key, result),).to-dict()
  }
  table(
    columns: 6,
    table.header[*Zelltyp*][*Durchschnitt\ (#label1)*][*Durchschnitt\ (#label2)*][*t-Wert*][*p-Wert*][*signifikanter Unterschied?*],
    ..for (celltype, test-results) in test-results.pairs() {
      (
        [#celltype],
        [#calc.round(digits: 2, stats1.at(celltype).mean)%],
        [#calc.round(digits: 2, stats2.at(celltype).mean)%],
        [#calc.round(digits: 2, test-results.t-value)],
        [#calc.round(digits: 5, test-results.p-value * 100)%],
        if test-results.is-significant [ja #sym.checkmark] else [nein #sym.crossmark]
      )
    }
  )
}
