#import "@preview/lilaq:0.6.0" as lq
#import "data-processing.typ": (
  data-acute-erkrankungen-group, data-all-group, data-allergies-group,
  data-current-year-group, data-dict, stats-acute-erkrankungen-group,
  stats-all-group, stats-allergies-group, stats-current-year-group,
)
#import "../../../lib/maths/statistics.typ": mean, median, stddev

#let heatmap-leukozyten-difference(
  width: 60%,
  height: 100%,
  data-transform: it => it,
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
  grid(
    columns: (1fr, auto),
    gutter: 2mm,
    lq.diagram(
      width: 100%,
      yaxis: (
        ticks: data
          .map(it => [
            #set text(size: 6pt)
            (#it.Person) #it.Stdgang
          ])
          .enumerate(),
      ),
      xaxis: (
        ticks: data
          .at(0)
          .chi-square-deviations
          .keys()
          .map(rotate.with(-60deg, reflow: true))
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
