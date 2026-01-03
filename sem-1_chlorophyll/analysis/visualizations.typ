#import "@preview/lilaq:0.5.0" as lq

#let visualize-results-absorption(results-data, chla-data, chlb-data) = {
  let results-data = results-data.map(it => (float(it.at(0)), float(it.at(1))))
  let chla-dict = chla-data.to-dict()
  let chlb-dict = chlb-data.to-dict()
  let combinded-data = chla-dict
    .keys()
    .filter(it => it in chlb-dict)
    .map(it => (float(it), float(chla-dict.at(it)) + float(chlb-dict.at(it))))

  lq.diagram(
    xlim: (400, 800),
    width: 100%,
    height: 8cm,
    xaxis: (format-ticks: lq.tick-format.linear.with(suffix: $"nm"$)),
    xlabel: "Wavelength",
    ylabel: [Absorbance in 100% Acetone],
    yaxis: (mirror: false),
    title: "Results Chlorophyll Absorption Spectra",
    cycle: (blue, black),
    lq.plot(
      results-data.map(it => it.at(0)),
      results-data.map(it => it.at(1)),
      label: [Sample absorbance],
      mark: none,
      smooth: true,
    ),
    lq.yaxis(
      position: right,
      label: [Absorbance in Diethyl Ether],
      lq.plot(
        combinded-data.map(it => float(it.at(0))),
        combinded-data.map(it => float(it.at(1))),
        label: [$"Chl"_"a" + "Chl"_"b"$ reference],
        mark: none,
        smooth: true,
        stroke: stroke(dash: "dotted", thickness: 1.25pt),
      ),
    ),
  )
}

#let visualize-reference-absorption(chla-data, chlb-data) = {
  lq.diagram(
    xlim: (400, 800),
    width: 100%,
    height: 8cm,
    xlabel: "Wavelength",
    ylabel: "Absorbance",
    title: "Reference Chlorophyll Absorption Spectra in Diethyl Ether",
    xaxis: (format-ticks: lq.tick-format.linear.with(suffix: $"nm"$)),
    cycle: (blue, red),
    lq.plot(
      chla-data.map(it => float(it.at(0))),
      chla-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: [$"Chl"_"a"$ reference],
    ),
    lq.plot(
      chlb-data.map(it => float(it.at(0))),
      chlb-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: [$"Chl"_"b"$ reference],
    ),
  )
}

#let mean(values) = values.sum() / values.len()
#let std(values) = {
  let mean = mean(values)
  calc.sqrt(
    values.map(it => calc.pow(it - mean, 2)).sum() / (values.len() - 1),
  )
}
#let empiric-var(values) = {
  let mean = mean(values)
  values.map(it => calc.pow(it - mean, 2)).sum() / values.len()
}
#let empiric-corr(x, y) = {
  let mean-x = mean(x)
  let mean-y = mean(y)
  let var-x = empiric-var(x)
  let var-y = empiric-var(y)
  let cov = x.zip(y).map(it => (it.at(0) - mean-x) * (it.at(1) - mean-y)).sum() / x.len()
  cov / calc.sqrt(var-x * var-y)
}
#let median(values) = if calc.rem(values.len(), 2) == 0 {
  (values.sorted().at(values.len() / 2) + values.sorted().at(values.len() / 2 - 1)) / 2
} else {
  values.sorted().at(int(values.len() / 2))
}
#let min-value(values) = values.sorted().at(0)
#let max-value(values) = values.sorted().at(values.len() - 1)
#let range-values(values) = max-value(values) - min-value(values)

#let boxplot-all-with-our-value(values, our-value) = {
  lq.diagram(
    width: 100%,
    height: 4cm,
    yaxis: (ticks: none),
    xlabel: "Concentration of total chlorophyll in fresh weight",
    xaxis: (
      locate-ticks: lq.tick-locate.linear.with(density: 50%),
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    title: "Boxplot of all groups' results compared to our results",
    lq.hboxplot(
      stroke: black,
      median: red,
      values,
      label: [All groups's concentration],
    ),
    lq.scatter(
      (our-value,),
      (1,),
      mark: "x",
      color: green.darken(25%),
      size: 0.5cm,
      label: [Our concentration],
    ),
  )
}


#let boxplot-all-per-type(types, values) = {
  let groups = types
    .zip(values)
    .fold((:), (
      (acc, it) => {
        if it.at(0) in acc {
          acc.at(it.at(0)).push(it.at(1))
        } else {
          acc.insert(it.at(0), (it.at(1),))
        }
        acc
      }
    ))
  lq.diagram(
    width: 100%,
    height: 6cm,
    ylabel: "Total chlorophyll concentration",
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    xlabel: "Source material",
    xaxis: (
      ticks: groups
        .keys()
        .map(rotate.with(-60deg, reflow: true))
        //.map(rect.with(stroke: green))
        .map(pad.with(right: 40%))
        .enumerate(start: 1),
      subticks: none,
    ),
    lq.boxplot(
      ..groups.values(),
    ),
  )
}

#let plot-difference-raw-final-values(raw-values, final-values) = {
  let combined-values = raw-values.zip(final-values) //.sorted(key: it => it.at(1)).rev()
  let sorted-raw-values = combined-values.map(it => it.at(0))
  let sorted-final-values = combined-values.map(it => it.at(1) / mean(combined-values.map(it => it.at(1))))

  let color-map = lq.color.map.petroff10

  lq.diagram(
    xlim: (0, raw-values.len() - 1),
    ylim: (0, auto),
    width: 100%,
    height: 6cm,
    yaxis: (ticks: none),
    xlabel: [Difference between concentration $"mg"slash"l"$ in solution and $"mg"slash"g"$ in fresh weight],
    lq.plot(
      range(sorted-raw-values.len()),
      sorted-raw-values,
      label: [Concentration $"mg"slash"l"$ in solution],
      color: color-map.at(2),
    ),
    lq.plot(
      range(sorted-final-values.len()),
      sorted-final-values,
      label: [Concentration $"mg"slash"g"$ in fresh weight],
      color: color-map.at(0),
    ),
    lq.fill-between(
      range(sorted-raw-values.len()),
      sorted-raw-values,
      y2: sorted-final-values,
      fill: color-map.at(1).transparentize(75%),
    ),
  )
}

#let plot-filled-out-vs-freshly-calculated(filled-out-values, freshly-calculated-values) = {
  show: lq.set-errorbar(stroke: red, cap: 1em)
  lq.diagram(
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    xaxis: (
      tick-distance: 1,
      subticks: none,
      format-ticks: none,
    ),
    xlim: (-0.8, freshly-calculated-values.len() - 0.2),
    ylabel: [Concentration in fresh weight],
    width: 100%,
    height: 7cm,
    title: "Filled out vs. freshly calculated concentrations",
    legend: (position: top + left),
    lq.bar(
      range(freshly-calculated-values.len()),
      freshly-calculated-values,
      label: [Freshly calculated concentrations],
      offset: 0.2,
      width: 0.4,
    ),
    lq.bar(
      range(filled-out-values.len()),
      filled-out-values,
      label: [Filled out concentrations],
      offset: -0.2,
      width: 0.4,
    ),
  )
}


#let plot-652nm-instructor-vs-freshly-calculated(instructor-values, freshly-calculated-values) = {
  show: lq.set-errorbar(stroke: red, cap: 1em)
  lq.diagram(
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    xaxis: (
      tick-distance: 1,
      subticks: none,
      format-ticks: none,
    ),
    xlim: (-0.8, freshly-calculated-values.len() - 0.2),
    ylabel: [Concentration in fresh weight],
    width: 100%,
    height: 7cm,
    title: "652nm instructor's formula vs. freshly calculated concentrations",
    legend: (position: top + left),
    lq.bar(
      range(freshly-calculated-values.len()),
      freshly-calculated-values,
      label: [Freshly calculated concentrations],
      offset: 0.2,
      width: 0.4,
    ),
    lq.bar(
      range(instructor-values.len()),
      instructor-values,
      label: [Concentration based on 652nm formula],
      offset: -0.2,
      width: 0.4,
    ),
  )
}