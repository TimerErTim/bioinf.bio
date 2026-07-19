#import "@preview/lilaq:0.6.0" as lq
#import "processing.typ": photometrie-data

#let relevant-photometrie-data = (
  photometrie-data.find(it => it.sample_source == "Leber" and it.trial == 1),
  photometrie-data.find(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )),
)

#let boxplot-rnase-concentration = {
  let groups = (
    (
      label: "Leber +RNase",
      values: relevant-photometrie-data
        .at(0)
        .with_rnase
        .measures
        .map(it => it.concentration),
    ),
    (
      label: "Leber -RNase",
      values: relevant-photometrie-data
        .at(0)
        .without_rnase
        .measures
        .map(it => it.concentration),
    ),
    (
      label: "Bakterien +RNase",
      values: relevant-photometrie-data
        .at(1)
        .with_rnase
        .measures
        .map(it => it.concentration),
    ),
    (
      label: "Bakterien -RNase",
      values: relevant-photometrie-data
        .at(1)
        .without_rnase
        .measures
        .map(it => it.concentration),
    ),
  )
  let color-map = lq.color.map.petroff10
  let boxplots = ()
  for (i, group) in groups.enumerate() {
    boxplots.push(lq.hboxplot(
      group.values,
      y: i,
      width: 0.55,
      cap-length: 0.35,
      outlier-size: 3pt,
      stroke: color-map.at(i).darken(25%),
      fill: color-map.at(i).lighten(10%),
      median: color-map.at(i).darken(75%),
      outlier-stroke: color-map.at(i).darken(50%),
    ))
  }
  lq.diagram(
    width: 100%,
    title: [DNA-Konzentration vor & nach RNase-Behandlung],
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $space mu"g/ml"$),
      tick-args: (
        density: 50%,
      ),
      label: [DNA-Konzentration],
    ),
    yaxis: (
      ticks: groups
        .map(it => rotate(-35deg, reflow: true, it.label))
        .enumerate(),
    ),
    ..boxplots,
  )
}

#let grouped-bar-purity = {
  let metrics = (
    (label: $E_260 slash E_280$, key: "cleaness_proteins"),
    (label: $E_260 slash E_230$, key: "cleaness_salts"),
  )
  let series-labels = (
    "Leber +RNase",
    "Leber -RNase",
    "Bakterien +RNase",
    "Bakterien -RNase",
  )
  let series = (
    relevant-photometrie-data.at(0).with_rnase,
    relevant-photometrie-data.at(0).without_rnase,
    relevant-photometrie-data.at(1).with_rnase,
    relevant-photometrie-data.at(1).without_rnase,
  )
  let color-map = lq.color.map.petroff10
  let bar-plots = ()
  for (j, sample) in series.enumerate() {
    let means = metrics.map(m => sample.stats.at(m.key).mean)
    let stddevs = metrics.map(m => sample.stats.at(m.key).stddev)
    let offset = (j - (series.len() - 1) / 2.0) * 0.18
    bar-plots.push(lq.bar(
      range(metrics.len()).map(i => i + offset),
      means,
      width: 0.15,
      label: series-labels.at(j),
      fill: color-map.at(j).lighten(10%),
      stroke: color-map.at(j).darken(25%),
    ))
    for plot in means
      .enumerate()
      .map(((i, m)) => lq.plot(
        (i + offset,),
        (m,),
        yerr: stddevs.at(i),
        color: color-map.at(j).darken(40%),
        stroke: 1pt,
      )) {
      bar-plots.push(plot)
    }
  }
  lq.diagram(
    width: 100%,
    title: [Mittlere Reinheitsquotienten ($overline(x) plus.minus s$)],
    xaxis: (
      label: [Quotient],
      ticks: metrics.map(m => m.label).enumerate(),
    ),
    yaxis: (
      label: [Wert],
      lim: (0, auto),
    ),
    legend: (position: top + left),
    ..bar-plots,
  )
}
