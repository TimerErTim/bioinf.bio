#import "data.typ": lipase-data
#import "../../lib/maths/aggregation.typ": average-plots
#import "@preview/lilaq:0.6.0" as lq
#import "../../lib/maths/interpolation.typ": interpolate-linear

#let average-ph-drop-plot(
  ..args,
  years: auto,
) = {
  let data = lipase-data.filter(it => if years == auto {
    true
  } else if it.date != none {
    years.contains(it.date.year())
  } else {
    false
  })

  let avg-uncooked = average-plots(..data.map(it => it.measurements.map(it => (it.time, it.uncooked))), interpolate: interpolate-linear)
  let avg-cooked = average-plots(..data.map(it => it.measurements.map(it => (it.time, it.cooked))), interpolate: interpolate-linear)

  lq.diagram(
    title: [pH-Verlauf über alle Gruppen],
    xlabel: [Zeit nach Zugabe der Lipase],
    ylabel: [Durchschnittlicher pH-Wert],
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: "min"),
      tick-args: (
        density: 80%,
      ),
      exponent: 0,
    ),
    legend: (
      position: left + bottom,
    ),
    lq.plot(
      avg-cooked.map(it => it.at(0)),
      avg-cooked.map(it => it.at(1)),
      label: "Gekocht",
    ),
    lq.plot(
      avg-uncooked.map(it => it.at(0)),
      avg-uncooked.map(it => it.at(1)),
      label: "Unkocht",
      mark: "x",
      stroke: (dash: "dashed"),
    ),
    ..args,
  )
}

#let average-ph-drop-by-amount-uncooked-plot(
  ..args,
  years: auto,
) = {
  let data = lipase-data.filter(it => if years == auto {
    true
  } else if it.date != none {
    years.contains(it.date.year())
  } else {
    false
  })

  let amount-measurements = (:)
  for data-point in data {
    if data-point.amount == none {
      continue
    }
    if str(data-point.amount) in amount-measurements {
      amount-measurements.at(str(data-point.amount)).push(data-point.measurements.map(it => (it.time, it.uncooked)))
    } else {
      amount-measurements.insert(str(data-point.amount), (data-point.measurements.map(it => (it.time, it.uncooked)),))
    }
  }

  let plots = ()
  for (amount, measurements) in amount-measurements.pairs().sorted(key: it => eval(it.at(0))) {
    let smoothed = average-plots(..measurements, interpolate: interpolate-linear)
    plots.push(lq.plot(
      smoothed.map(it => it.at(0)),
      smoothed.map(it => it.at(1)),
      label: [Menge #amount],
      mark: "x",
      stroke: (dash: "dashed"),
    ))
  }

  lq.diagram(
    ..args,
    title: [Ungekochter ph-Verlauf in Abhängigkeit von der Lipase-Menge],
    xlabel: [Zeit nach Zugabe der Lipase],
    ylabel: [Durchschnittlicher pH-Wert],
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: "min"),
      tick-args: (
        density: 80%,
      ),
      exponent: 0,
    ),
    legend: (
      position: right + top,
    ),
    ..plots,
  )
}

#let average-ph-drop-by-amount-cooked-plot(
  ..args,
  years: auto,
) = {
  let data = lipase-data.filter(it => if years == auto {
    true
  } else if it.date != none {
    years.contains(it.date.year())
  } else {
    false
  })

  let amount-measurements = (:)
  for data-point in data {
    if data-point.amount == none {
      continue
    }
    if str(data-point.amount) in amount-measurements {
      amount-measurements.at(str(data-point.amount)).push(data-point.measurements.map(it => (it.time, it.cooked)))
    } else {
      amount-measurements.insert(str(data-point.amount), (data-point.measurements.map(it => (it.time, it.cooked)),))
    }
  }

  let plots = ()
  for (amount, measurements) in amount-measurements.pairs().sorted(key: it => eval(it.at(0))) {
    let smoothed = average-plots(..measurements, interpolate: interpolate-linear)
    plots.push(lq.plot(
      smoothed.map(it => it.at(0)),
      smoothed.map(it => it.at(1)),
      label: [Menge #amount],
    ))
  }

  lq.diagram(
    ..args,
    title: [Gekochter ph-Verlauf in Abhängigkeit von der Lipase-Menge],
    xlabel: [Zeit nach Zugabe der Lipase],
    ylabel: [Durchschnittlicher pH-Wert],
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: "min"),
      tick-args: (
        density: 80%,
      ),
      exponent: 0,
    ),
    legend: (
      position: right + top,
    ),
    ..plots,
  )
}

#average-ph-drop-plot(width: 100%)
#average-ph-drop-by-amount-uncooked-plot(width: 100%)
#average-ph-drop-by-amount-cooked-plot(width: 100%)
#average-ph-drop-plot(width: 100%, years: (2026,), title: [ph-Verlauf für MBI25])
