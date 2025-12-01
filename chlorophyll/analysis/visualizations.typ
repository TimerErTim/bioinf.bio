#import "@preview/lilaq:0.5.0" as lq

#let visualize-results-absorption(results-data, chla-data, chlb-data) = {
  let chla-dict = chla-data.to-dict()
  let chlb-dict = chlb-data.to-dict()
  let combinded-data = chla-dict.keys().filter(it => it in chlb-dict).map(it => (float(it), float(chla-dict.at(it)) + float(chlb-dict.at(it))))

  lq.diagram(
    xlim: (400, 800),
    lq.plot(
      results-data.map(it => float(it.at(0))),
      results-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true
    ),
    lq.yaxis(
      position: right,
      lq.plot(
        combinded-data.map(it => float(it.at(0))),
        combinded-data.map(it => float(it.at(1))),
        mark: none,
        smooth: true
      )
    )
  )
}

#let visualize-reference-absorption(chla-data, chlb-data) = {
  lq.diagram(
    width: 100%,
    height: 8cm,
    lq.plot(
      chla-data.map(it => float(it.at(0))),
      chla-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: "Chlorophyll A"
    ),
    lq.plot(
      chlb-data.map(it => float(it.at(0))),
      chlb-data.map(it => float(it.at(1))),
      mark: none,
      smooth: true,
      label: "Chlorophyll B"
    )
  )
}