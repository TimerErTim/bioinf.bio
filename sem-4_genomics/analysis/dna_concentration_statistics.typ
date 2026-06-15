#set page(
  width: auto,
  height: auto,
  fill: white.transparentize(100%),
  margin: 5mm,
)
#import "processing.typ": photometrie-data

#set text(font: "Arial")
#table(
  columns: photometrie-data.len() * 2 + 1,
  table.header(
    table.cell(rowspan: 2, stroke: none)[],
    ..for sample in photometrie-data {
      (
        table.cell(colspan: 2)[*#sample.sample_source (#sample.trial)*],
      )
    },
    ..for sample in photometrie-data {
      (
        [\+ RNase],
        [\- RNase],
      )
    },
  ),
  [Konzentration],
  ..for sample in photometrie-data {
    (
      [
        #calc.round(sample.with_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.concentration.stddev, digits: 1) #sym.mu\g DNA/ml
      ],
      [
        #calc.round(sample.without_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.concentration.stddev, digits: 1) #sym.mu\g DNA/ml
      ],
    )
  },
  [
    $E_260 slash E_280 approx space ~1.8$\
    Protein/Phenol Verunreinigung
  ],
  ..for sample in photometrie-data {
    (
      [
        #calc.round(
          sample.with_rnase.stats.cleaness_proteins.mean,
          digits: 1,
        ) #sym.plus.minus #calc.round(
          sample.with_rnase.stats.cleaness_proteins.stddev,
          digits: 1,
        )
      ],
      [
        #calc.round(
          sample.without_rnase.stats.cleaness_proteins.mean,
          digits: 1,
        ) #sym.plus.minus #calc.round(
          sample.without_rnase.stats.cleaness_proteins.stddev,
          digits: 1,
        )
      ],
    )
  },
  [
    $E_260 slash E_230 approx space 2.0 - 2.2$\
    Salz/Kohlenhydrat Verunreinigung
  ],
  ..for sample in photometrie-data {
    (
      [
        #calc.round(
          sample.with_rnase.stats.cleaness_salts.mean,
          digits: 1,
        ) #sym.plus.minus #calc.round(
          sample.with_rnase.stats.cleaness_salts.stddev,
          digits: 1,
        )
      ],
      [
        #calc.round(
          sample.without_rnase.stats.cleaness_salts.mean,
          digits: 1,
        ) #sym.plus.minus #calc.round(
          sample.without_rnase.stats.cleaness_salts.stddev,
          digits: 1,
        )
      ],
    )
  },
)
