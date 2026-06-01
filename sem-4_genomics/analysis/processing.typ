#import "../../lib/maths/statistics.typ": *

#let photometrie-raw-data = json("../data/dna_photometrie.json")
#let _process-sample(sample) = {
  let process-measurement(measurement) = {
    (
      ..measurement,
      "concentration": measurement.absorbance.at("230") * 50,
      "cleaness_proteins": measurement.absorbance.at("260") / measurement.absorbance.at("280"),
      "cleaness_salts": measurement.absorbance.at("260") / measurement.absorbance.at("230"),
    )
  }

  let process-sample-type(sample-type) = {
    let measures = sample-type.map(process-measurement)
    (
      stats: (
        "concentration": (
          "values": measures.map(it => it.concentration),
          "mean": mean(measures.map(it => it.concentration)),
          "stddev": stddev(measures.map(it => it.concentration)),
        ),
        "cleaness_proteins": (
          "values": measures.map(it => it.cleaness_proteins),
          "mean": mean(measures.map(it => it.cleaness_proteins)),
          "stddev": stddev(measures.map(it => it.cleaness_proteins)),
        ),
        "cleaness_salts": (
          "values": measures.map(it => it.cleaness_salts),
          "mean": mean(measures.map(it => it.cleaness_salts)),
          "stddev": stddev(measures.map(it => it.cleaness_salts)),
        ),
      ),
      measures: measures,
    )
  }
  (
    ..sample,
    "with_rnase": process-sample-type(sample.with_rnase),
    "without_rnase": process-sample-type(sample.without_rnase),
  )
}
#let photometrie-data = (
  ..for sample in photometrie-raw-data {
    (_process-sample(sample),)
  },
)

#let liver-weights-raw-data = json("../data/liver_weights.json")
#let liver-weights-data = liver-weights-raw-data.map(it => (it.initials, it)).to-dict()
