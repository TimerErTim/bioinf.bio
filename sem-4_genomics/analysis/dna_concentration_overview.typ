#set page(
  width: auto,
  height: auto,
  fill: white.transparentize(100%),
  margin: 5mm,
)
#import "processing.typ": photometrie-data

#table(
  columns: 3,
  ..for sample in photometrie-data {
    (
      table.header(table.cell(
        colspan: 3,
      )[*#sample.sample_source (#sample.trial)*]),
      table.header(level: 2)[][*+RNase*][*-RNase*],
      [
        #show: rotate.with(90deg, reflow: true)
        *Stats*
      ],
      [
        Konz: #calc.round(sample.with_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.concentration.stddev, digits: 1) #sym.mu\g DNA/ml\
        $E_260 slash E_280$ = #calc.round(sample.with_rnase.stats.cleaness_proteins.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.cleaness_proteins.stddev, digits: 1)\
        $E_260 slash E_230$ = #calc.round(sample.with_rnase.stats.cleaness_salts.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.cleaness_salts.stddev, digits: 1)\
      ],
      [
        Konz: #calc.round(sample.without_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.concentration.stddev, digits: 1) #sym.mu\g DNA/ml\
        $E_260 slash E_280$ = #calc.round(sample.without_rnase.stats.cleaness_proteins.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.cleaness_proteins.stddev, digits: 1)\
        $E_260 slash E_230$ = #calc.round(sample.without_rnase.stats.cleaness_salts.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.cleaness_salts.stddev, digits: 1)\
      ],
      ..for initials in (
        sample.with_rnase.measures.map(it => it.initials)
          + sample.without_rnase.measures.map(it => it.initials)
      ).dedup() {
        let with_rnase = sample.with_rnase.measures.find(it => (
          it.initials == initials
        ))
        let without_rnase = sample.without_rnase.measures.find(it => (
          it.initials == initials
        ))
        (
          [
            #show: rotate.with(90deg, reflow: true)
            #initials
          ],
          ..for measurement in (
            if with_rnase != none { with_rnase },
            if without_rnase != none { without_rnase },
          ) {
            if measurement != none {
              (
                [
                  Konz: #calc.round(measurement.concentration, digits: 1) #sym.mu\g DNA/ml\
                  $E_260 slash E_280$ = #calc.round(measurement.cleaness_proteins, digits: 1)\
                  $E_260 slash E_230$ = #calc.round(measurement.cleaness_salts, digits: 1)\
                ],
              )
            } else {
              ([],)
            }
          },
        )
      },
    )
  }
)

Idealwert $E_260 slash E_280$ = \~1,8\
Idealwert $E_260 slash E_230$ = 2.0 - 2.2
