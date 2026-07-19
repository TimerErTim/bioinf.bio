#import "../../analysis/processing.typ": *

#let table-photometrie-results(sample) = {
  table(
    columns: 3,
    align: left,
    ..(
      table.header(table.cell(
        colspan: 3,
        align: left,
      )[*#sample.sample_source (#sample.trial\. Durchlauf)*]),
      table.header(level: 2)[][*+RNase*][*-RNase*],
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
            #show: rotate.with(-90deg, reflow: true)
            *#initials*
          ],
          ..for measurement in (
            if with_rnase != none { with_rnase },
            if without_rnase != none { without_rnase },
          ) {
            if measurement != none {
              (
                [
                  Konz.: #calc.round(measurement.concentration, digits: 1) #sym.mu\g DNA/ml\
                  $E_260 slash E_280$: #calc.round(measurement.cleaness_proteins, digits: 1)\
                  $E_260 slash E_230$: #calc.round(measurement.cleaness_salts, digits: 1)\
                ],
              )
            } else {
              ([],)
            }
          },
        )
      },
    ),
  )
}

#let table-descriptive-statistics(relevant-data) = {
  table(
    columns: relevant-data.len() * 2 + 1,
    table.header(
      table.cell(rowspan: 2, stroke: none, fill: none)[],
      ..for sample in relevant-data {
        (
          table.cell(
            colspan: 2,
          )[*#sample.sample_source (#sample.trial\. Durchlauf)*],
        )
      },
      ..for sample in relevant-data {
        (
          [\+ RNase],
          [\- RNase],
        )
      },
    ),
    [Konzentration [#sym.mu\g DNA/ml]],
    ..for sample in relevant-data {
      (
        [
          #calc.round(sample.with_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.concentration.stddev, digits: 1)\ #sym.mu\g DNA/ml
        ],
        [
          #calc.round(sample.without_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.concentration.stddev, digits: 1)\ #sym.mu\g DNA/ml
        ],
      )
    },
    [
      $E_260 slash E_280 approx space.thin ~1.8$
    ],
    ..for sample in relevant-data {
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
      $E_260 slash E_230 approx space.thin 2.0 - 2.2$
    ],
    ..for sample in relevant-data {
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
}

#let table-restr-enzyme-distribution = {
  table(
    columns: 3,
    align: (right, center, center),
    table.header([*Enzym*], [*Alt*], [*Neu*]),
    ..for enzyme in restr-enzyme-distr-data
      .values()
      .map(it => it.enzyme)
      .dedup() {
      let person-has-liver(initials) = {
        initials in liver-weights-data
      }
      let found-old-person = restr-enzyme-distr-data
        .values()
        .find(it => it.enzyme == enzyme and it.new_charge == false)
      let found-new-person = restr-enzyme-distr-data
        .values()
        .find(it => it.enzyme == enzyme and it.new_charge == true)

      (
        [*#enzyme*],
        if found-new-person != none [
          #set text(fill: if person-has-liver(found-new-person.initials) {
            red
          } else { green })
          #found-new-person.initials
        ] else [
          #sym.crossmark
        ],
        if found-old-person != none [
          #set text(fill: if person-has-liver(found-old-person.initials) {
            red
          } else { green })
          #found-old-person.initials
        ] else [
          #sym.crossmark
        ],
      )
    },
  )
}

#let table-restr-enzyme-sequences = {
  table(
    columns: 2,
    table.header([*Enzym*], [*Erkennungssequenz*]),
    [*EcoRI*], image("../../assets/ecor-i.png", height: 5em),
    [*NaeI*], image("../../assets/nae-i.png", height: 5em),
    [*PstI*], image("../../assets/pst-i.png", height: 5em),
  )
}

#let table-liver-weights = {
  table(
    columns: 3,
    table.header[*Name*][*Kürzel*][*Gewicht [g]*],
    ..for entry in liver-weights-raw-data {
      ([#entry.name], [#entry.initials], [#str(entry.weight_g)])
    },
  )
}

#let table-soll-ist-vergleich = {
  table(
    columns: 4,
    table.header[*Befund*][*Erwartung (Soll)*][*Beobachtung (Ist)*][*Wahrscheinliche Ursache*],
    [Leber-Gel unrestriktiert],
    [Band >20 kbp],
    [Band + RNA-Wolke],
    [RNA-reiches Gewebe, teils erfolgreiche Isolierung],

    [Leber RNase],
    [weniger RNA-Signal],
    [teilweise sichtbar],
    [RNase wirkt, aber unvollständig],

    [Leber Restriktion],
    [Schmier],
    [Schmier; LS kürzer],
    [Verdau ok; PstI-Teilverdau bei LS],

    [Bakterien-Gel],
    [Band oben],
    [kaum Signal],
    [Lyse/Extraktion fehlgeschlagen],

    [RNase-Konzentration],
    [+RNase < −RNase],
    [+RNase höher im Mittel],
    [Verunreinigungen; kleines $n$; RNA in $E_260$],

    [Statistik], [—], [nicht signifikant], [Stichprobe zu klein ($n = 5$–$10$)],
  )
}
