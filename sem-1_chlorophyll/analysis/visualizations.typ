#import "@preview/lilaq:0.5.0" as lq
#import "@preview/fletcher:0.5.8" as fl

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
      fill: color-map.at(1).transparentize(80%),
    ),
  )
}

#let visualize-calculation-paths() = {
  set par(justify: false)
  let color-map = lq.color.map.petroff10
  fl.diagram(
    spacing: (5em, 3em),
    node-shape: rect,
    node-corner-radius: 1em,
    node-fill: white,
    node-stroke: 0.6pt,
    edge-stroke: 1pt,
    label-wrapper: edge => box(
      edge.label,
      inset: (left: -1em),
      width: 2.5em,
      fill: edge.label-fill
    ),
    fl.node((0, 0), [Extinction coefficients], width: 4cm),
    fl.node((0, 1), [Individual concentrations in solution], width: 4cm),
    fl.node(
      enclose: ((0, 0), (0, 1)),
      [
        #show: align.with(left + top)
        #show: pad.with(left: -1.5em, top: -1.5em)
        #set text(size: 9pt, fill: teal.darken(50%))
        Results sheet
      ],
      shape: rect,
      stroke: teal,
      fill: teal.lighten(90%),
      inset: 2em,
      corner-radius: 0pt,
      snap: -1,
    ),
    fl.node(
      (2, 1),
      [Concentration in fresh weight],
      shape: fl.shapes.hexagon,
      fill: blue.lighten(80%),
      stroke: blue,
      width: 4cm,
    ),
    fl.node((1, 1), [Total concentration in solution], width: 4cm),
    fl.node((1, 0), [Individual concentrations in solution], width: 4cm),


    fl.edge((0, 0), (0, 1), "-|>", label: [???], stroke: color-map.at(2)),
    fl.edge((0, 0), (1, 0), "-|>", label: [Instructor's formula], stroke: color-map.at(0)),
    fl.edge((0, 0), (1, 1), "-|>", label: [$652"nm"$ formula], stroke: color-map.at(1)),
    fl.edge((0, 1), (1, 1), "-|>", label: [Addition], stroke: color-map.at(2)),
    fl.edge((1, 0), (1, 1), "-|>", label: [Addition], stroke: color-map.at(0)),
    fl.edge((1, 1), (2, 1), "-|>", label: align(right)[Dilution factor], stroke: color-map.at(0), shift: 0.15),
    fl.edge((1, 1), (2, 1), "-|>", stroke: color-map.at(1), shift: 0),
    fl.edge((1, 1), (2, 1), "-|>", stroke: color-map.at(2), shift: -0.15),
  )
  place(
    top + right
  )[
    #grid(
      columns: 2,
      align: horizon,
      column-gutter: 1em,
      row-gutter: 1.5mm,
        [Freshly calculated concentrations],[#line(length: 2em, stroke: color-map.at(0) + 2pt)],
        [Instructor's $652"nm"$ formula],[#line(length: 2em, stroke: color-map.at(1) + 2pt)],
        [Filled out concentrations],[#line(length: 2em, stroke: color-map.at(2) + 2pt)],
      )
  ]
}

#let plot-calculation-sources-comparisons(
  filled-out-values,
  calculated-652nm-values,
  freshly-calculated-values,
) = {
  lq.diagram(
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"mg"slash"g"$),
    ),
    ylabel: [Other sources' concentrations],
    xlabel: [Freshly calculated concentration],
    width: 100%,
    height: 7cm,
    title: "Correlation between freshly calculated concentrations and other sources",
    legend: (position: top + left),
    lq.scatter(
      freshly-calculated-values,
      filled-out-values,
      size: (50,) * freshly-calculated-values.len(),
      label: [Filled out],
    ),
    lq.scatter(
      freshly-calculated-values,
      calculated-652nm-values,
      size: (50,) * freshly-calculated-values.len(),
      label: [Instructor's $652"nm"$ formula],
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
      label: [Concentration based on $652"nm"$ formula],
      offset: -0.2,
      width: 0.4,
    ),
  )
}
