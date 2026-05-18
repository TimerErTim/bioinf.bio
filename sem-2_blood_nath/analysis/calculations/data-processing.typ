#import "../../../lib/maths/statistics.typ": (
  chi-square-anpassungstest, chi-square-teststatistic, mean, median, stddev, chi-square-pvalue
)

#let reference-data = json("../data/reference_values.json")
#let adult-leukozyten-reference-data = reference-data.at("Erwachsene")

#let _observed-to-reference-lable-map = (
  "Neutrophile": (
    adult-leukozyten-reference-data.at(
      "Segmentkernige neutrophile Granulozyten",
    ),
    adult-leukozyten-reference-data.at("Stabkernige neutrophile Granulozyten"),
  ),
  "Eosinophile": (
    adult-leukozyten-reference-data.at("Eosinophile Granulozyten"),
  ),
  "Basophile": (adult-leukozyten-reference-data.at("Basophile Granulozyten"),),
  "Monozyten": (adult-leukozyten-reference-data.at("Monozyten"),),
  "Lymphozyten": (adult-leukozyten-reference-data.at("Lymphozyten"),),
)
#let adult-leukozyten-reference-data-probs = {
  let unnormalized = _observed-to-reference-lable-map
    .pairs()
    .map(((key, values)) => (
      key,
      values.map(it => it.at("relativer_anteil_prozent").sum() / 2).sum(),
    ))
  let total-percent = unnormalized.map(((key, val)) => val).sum()
  unnormalized.map(((key, val)) => (key, val / total-percent)).to-dict()
}

#let chi-square-teststatistic-adult-leukozyten(entries-observed) = {
  let reference-probs = adult-leukozyten-reference-data-probs
  let observed-counts = reference-probs
    .pairs()
    .map(((key, _)) => entries-observed.at(key))
  let total-observed-count = observed-counts.sum()
  let expected-counts = reference-probs
    .pairs()
    .map(((key, value)) => value * total-observed-count)
  chi-square-teststatistic(expected-counts, observed-counts)
}

/// Entries observed shape: ("<Type>": absolute-count, ...)
#let is-difference-adult-leukozyten-significant(
  entries-observed,
  alpha: 0.05,
) = {
  (
    chi-square-pvalue(chi-square-teststatistic-adult-leukozyten(entries-observed).t, df: entries-observed.len() - 1) < alpha
  )
}


#let data = csv(
  "../data/UE_Blut_Ergebnisse.xlsx - Blutausstrich.tsv",
  delimiter: "\t",
  row-type: array,
).map(
  it => it.slice(0, 10),
)
#let data-header = data.first()
#let data-dict = data.slice(1).map(it => data-header.zip(it).to-dict())
#let convert-entry-to-observed(entry) = {
  let parsed-entry = (
    "Neutrophile",
    "Eosinophile",
    "Basophile",
    "Monozyten",
    "Lymphozyten",
  )
    .map(key => {
      let raw-val = entry.at(key)
      let value = if raw-val.trim() == "" {
        0
      } else if raw-val.match(regex("^[0-9]+$")) == none {
        none
      } else {
        int(raw-val)
      }
      (key, value)
    })
    .to-dict()

  if parsed-entry.pairs().all(((_, value)) => value == 0) {
    return none
  }

  parsed-entry
}
#let data-dict = data-dict.map(entry => {
  let entry-has-allergy = (
    entry.Allergie.trim() != ""
      and entry.Allergie.trim() != "n"
      and entry.Allergie.trim() != "nein"
  )
  let entry-has-acute-erkrankung = (
    entry.at("Akute Erkr").trim() != ""
      and entry.at("Akute Erkr").trim() != "n"
      and entry.at("Akute Erkr").trim() != "nein"
  )
  let entry = (
    ..entry,
    "has-allergy": entry-has-allergy,
    "has-acute-erkrankung": entry-has-acute-erkrankung,
  )

  let observation = convert-entry-to-observed(entry)
  if observation == none or observation.values().sum() == 0 {
    return (..entry, "unprocessable": true)
  }
  (
    ..entry,
    ..observation,
    chi-square-deviations: _observed-to-reference-lable-map
      .pairs()
      .map(((key, _)) => key)
      .zip(chi-square-teststatistic-adult-leukozyten(observation).deviations)
      .to-dict(),
    difference-significant: is-difference-adult-leukozyten-significant(
      observation,
    ),
  )
})

#let data-all-group = data-dict.filter(it => (
  it.at("unprocessable", default: false) == false
))
#let data-current-year-group = data-all-group.filter(it => (
  it.Stdgang == "MBI25"
))
#let data-allergies-group = data-all-group.filter(it => it.has-allergy)
#let data-acute-erkrankungen-group = data-all-group.filter(it => {
  it.has-acute-erkrankung
})

#let stats-for-set(data) = {
  let relevant-keys = data.first().chi-square-deviations.keys()
  let relevant-data = (
    Gesamt: (
      symbol: [Zellen],
      values: (),
    ),
    ..relevant-keys
      .map(key => (
        key,
        (
          symbol: sym.percent,
          values: (),
        ),
      ))
      .to-dict(),
  )
  for (entry) in data {
    let total = 0
    for (key) in relevant-keys {
      total += entry.at(key)
    }
    for (key) in relevant-keys {
      relevant-data.at(key).values.push(entry.at(key) / total * 100)
    }
    relevant-data.Gesamt.values.push(total)
  }
  relevant-data
    .pairs()
    .map(((key, val)) => (
      key,
      (
        "mean": mean(val.values),
        "stddev": stddev(val.values, population: false),
        "min": calc.min(..val.values),
        "max": calc.max(..val.values),
        "median": median(val.values),
        ..val,
      ),
    ))
    .to-dict()
}

#let stats-all-group = stats-for-set(data-all-group)
#let stats-current-year-group = stats-for-set(data-current-year-group)
#let stats-allergies-group = stats-for-set(data-allergies-group)
#let stats-acute-erkrankungen-group = stats-for-set(
  data-acute-erkrankungen-group,
)
