#import "@preview/lilaq:0.5.0" as lq

#let visualize-results-absorption(results-data, chla-data, chlb-data) = {
  let results-data = results-data.map(it => (float(it.at(0)), float(it.at(1))))
  let chla-dict = chla-data.to-dict()
  let chlb-dict = chlb-data.to-dict()
  let combinded-data = chla-dict.keys().filter(it => it in chlb-dict).map(it => (float(it), float(chla-dict.at(it)) + float(chlb-dict.at(it))))

  lq.diagram(
    xlim: (400, 800),
    width: 100%,
    height: 8cm,
    xaxis: (format-ticks: lq.tick-format.linear.with(suffix: $"n" "m"$)),
    xlabel: "Wavelength",
    ylabel: [Absorbance in 100% Acetone],
    title: "Results Chlorophyll Absorption Spectra",
    cycle: (blue, black),
    lq.plot(
      results-data.map(it => it.at(0)),
      results-data.map(it => it.at(1)),
      label: [Sample absorbance],
      mark: none,
      smooth: true
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
        stroke: stroke(dash: "dotted", thickness: 1.25pt)
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
    xaxis: (format-ticks: lq.tick-format.linear.with(suffix: $"n" "m"$)),
    cycle: (blue, red),
    lq.plot(
      chla-data.map(it => float(it.at(0))),
      chla-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: [$"Chl"_"a"$ reference]
    ),
    lq.plot(
      chlb-data.map(it => float(it.at(0))),
      chlb-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: [$"Chl"_"b"$ reference]
    )
  )
}