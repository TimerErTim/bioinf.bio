#import "@preview/lilaq:0.6.0" as lq
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": chart
#import "data-processing.typ": (
  adult-leukozyten-reference-data-probs, data-acute-erkrankungen-group,
  data-all-group, data-allergies-group, data-current-year-group, data-dict,
  stats-acute-erkrankungen-group, stats-all-group, stats-allergies-group,
  stats-current-year-group,
)
#import "../../../lib/maths/statistics.typ": (
  anova-test, chi-square-anpassungstest,
  is-contingency-table-significant-independent, mean, median, one-sample-t-test,
  stddev, two-sample-t-test,
)

#let heatmap-leukozyten-difference(
  width: 75%,
  height: 100%,
  data-transform: it => it,
  title: none,
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
    set align(center)
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
            $#calc.round(digits: 1, it.mean) #sym.plus.minus #calc.round(digits: 1, it.stddev)$\
            min: #calc.round(digits: 1, it.min)\
            max: #calc.round(digits: 1, it.max)
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
          it + (1 - i / (group-labels.len() - 1) - 0.5) * 0.6 - 0.5
        )),
        width: 0.7 / group-labels.len(),
        cap-length: 0.6 / group-labels.len(),
        outlier-size: 2pt,
        outlier-stroke: color-map.at(i).darken(50%),
        ..relevant-keys.map(key => subset.at(key).values),
      ),
    )
  }

  show: pad.with(top: -1cm)
  lq.diagram(
    height: 16cm,
    width: 100%,
    title: [Relative Häufigkeit der Zelltypen pro Datengruppe],
    legend: (
      position: right + horizon,
    ),
    yaxis: (
      ticks: relevant-keys
        .map(rotate.with(-40deg, reflow: true))
        .map(text.with(size: 8pt))
        .map(pad.with(top: 3cm))
        .enumerate(),
    ),
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: "%"),
    ),
    ..boxplots,
  )
}

#let table-chi-square-anpassungstest(data: data-all-group) = {
  let observed-categories = data
    .first()
    .chi-square-deviations
    .pairs()
    .map(((key, _)) => (key, 0))
    .to-dict()
  for entry in data {
    for key in entry.chi-square-deviations.keys() {
      observed-categories.at(key) += entry.at(key)
    }
  }

  let exp-probs-categories = observed-categories
    .keys()
    .map(key => (key, adult-leukozyten-reference-data-probs.at(key)))
    .to-dict()

  let test-results = chi-square-anpassungstest(
    observed-categories.values(),
    exp-probs-categories.values(),
  )

  (
    table(
      columns: 4,
      table.header[*Kategorie*][*Beobachtet*][*Erwarteter Anteil*][*Erwarteter Betrag*],
      ..for (i, label) in observed-categories.keys().enumerate() {
        (
          [#label],
          [#observed-categories.at(label)],
          [#calc.round(digits: 2, exp-probs-categories.at(label) * 100)%],
          [#calc.round(digits: 2, test-results.expected.at(i))],
        )
      },
    ),
    test-results,
  )
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

  let test-results = is-contingency-table-significant-independent(
    group1-observed.values(),
    group2-observed.values(),
  )
  (
    {
      set par(justify: false)
      table(
        columns: relevant-categories.len() + 1,
        table.header([*Gruppe*], ..relevant-categories.map(
          label => [*#label*],
        )),
        ..for (label, observations) in (
          (group1-label, group1-observed),
          (group2-label, group2-observed),
        ) {
          ([#label], ..observations.values().map(it => [#it]))
        }
      )
    },
    test-results,
  )
}

#let _transform-p(p) = calc.asin(calc.sqrt(p)).deg() / 90

#let table-one-sample-t-tests(stats: stats-all-group) = {
  let (..stats, Gesamt) = stats
  let expected-mus = stats
    .keys()
    .map(key => adult-leukozyten-reference-data-probs.at(key))
  let test-results = for (key, expected-mu) in stats.keys().zip(expected-mus) {
    if stats.at(key).stddev == 0 {
      continue
    }
    (
      (
        key,
        (
          expected-mu: expected-mu,
          ..one-sample-t-test(
            stats.at(key).values.map(it => it / 100).map(_transform-p),
            expected-mu: expected-mu,
          ),
        ),
      ),
    ).to-dict()
  }

  set par(justify: false)
  table(
    columns: 6,
    table.header[*Zelltyp*][*Durchschnitt*][*Anteil aus Referenz*][*t-Wert*][*p-Wert*][*signifikanter Unterschied?*],
    ..for (label, test-results) in test-results.pairs() {
      (
        [#label],
        [#calc.round(digits: 1, stats.at(label).mean)%],
        [#calc.round(digits: 1, test-results.expected-mu * 100)%],
        [#calc.round(digits: 1, test-results.t-value)],
        [#calc.round(digits: 2, test-results.p-value * 100)%],
        if test-results.is-significant [ja #sym.checkmark] else [nein #sym.crossmark],
      )
    },
  )
}

#let table-two-sample-t-tests(stats1, stats2) = {
  let label1 = stats1.label
  let label2 = stats2.label
  let (..stats1, Gesamt) = stats1.statistics
  let (..stats2, Gesamt) = stats2.statistics
  let test-results = for key in stats1.keys() {
    let data1 = stats1.at(key)
    let data2 = stats2.at(key)
    let result = two-sample-t-test(
      data1.values.map(it => it / 100).map(_transform-p),
      data2.values.map(it => it / 100).map(_transform-p),
    )
    ((key, result),).to-dict()
  }

  set par(justify: false)
  table(
    columns: 6,
    table.header[*Zelltyp*][*Durchschnitt\ (#label1)*][*Durchschnitt\ (#label2)*][*t-Wert*][*p-Wert*][*signifikanter Unterschied?*],
    ..for (celltype, test-results) in test-results.pairs() {
      (
        [#celltype],
        [#calc.round(digits: 1, stats1.at(celltype).mean)%],
        [#calc.round(digits: 1, stats2.at(celltype).mean)%],
        [#calc.round(digits: 1, test-results.t-value)],
        [#calc.round(digits: 2, test-results.p-value * 100)%],
        if test-results.is-significant [ja #sym.checkmark] else [nein #sym.crossmark],
      )
    },
  )
}


#let piecharts-for-known-groups = {
  cetz.canvas({
    import cetz.draw: *

    let color-map = lq.color.map.petroff10
    let relevant-cells = data-all-group
      .first()
      .chi-square-deviations
      .keys()
      .chunks(2)
      .map(it => it.rev())
      .flatten()
    let radius = 2.5

    content((0, radius * 1.5))[Alle Gruppen]
    chart.piechart(
      relevant-cells.map(key => (key, stats-all-group.at(key).mean)),
      value-key: 1,
      slice-style: color-map,
      radius: radius,
      label-key: 0,
      outer-label: (content: "%"),
      legend: (position: "south-west"),
    )
    for (i, (label, data)) in (
      ("MBI 2025", stats-current-year-group),
      ("mit Allergien", stats-allergies-group),
      ("Akute Erkrankungen", stats-acute-erkrankungen-group),
    ).enumerate() {
      translate(
        x: radius * 1.5 * 2 * if calc.rem(i, 2) == 0 { -1 } else { 1 },
        y: radius * 1.75 * 2 * if calc.rem(i, 2) == 0 { 0 } else { 1 },
      )
      content((0, radius * 1.5))[#label]
      chart.piechart(
        relevant-cells.map(key => (key, data.at(key).mean)),
        value-key: 1,
        slice-style: color-map,
        radius: radius,
        label-key: none,
        outer-label: (
          content: (value, label) => [
            #calc.round(digits: 0, value)%
          ],
        ),
      )
    }
  })
}


#let anova-table(..groups) = {
  let groups = groups.pos()
  let relevant-celltypes = data-all-group.first().chi-square-deviations.keys()
  let data = (:)
  for celltype in relevant-celltypes {
    let values = groups.map(group => group
      .at(celltype)
      .values
      .map(it => it / 100)
      .map(_transform-p)
      .map(it => it * 100))
    data.insert(celltype, values)
  }

  table(
    columns: 6,
    table.header[*Zelltyp*][*MSW*][*MSB*][*F-Wert*][*p-Wert*][*signifikanter Unterschied?*],
    ..for (celltype, groups) in data.pairs() {
      let anova-results = anova-test(..groups)
      (
        [#celltype],
        [#calc.round(digits: 1, anova-results.msw)],
        [#calc.round(digits: 1, anova-results.msb)],
        [#calc.round(digits: 2, anova-results.f-value)],
        [#calc.round(digits: 2, anova-results.p-value * 100)%],
        if anova-results.is-significant [ja #sym.checkmark] else [nein #sym.crossmark],
      )
    },
  )
}
