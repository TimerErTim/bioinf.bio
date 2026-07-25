#import "data.typ": lipase-data
#import "../../lib/maths/statistics.typ": mean, stddev, percentiles

#let _drop-data(base-data) = {
   let data = base-data.filter(series => series.measurements.len() > 0).map(series => {
    let last = series.measurements.rev().find(m => m.uncooked != none and m.cooked != none)
    let first = series.measurements.find(m => m.uncooked != none and m.cooked != none)
    (
      amount: series.amount,
      uncooked-drop: first.uncooked - last.uncooked,
      cooked-drop: first.cooked - last.cooked,
    )
  })
  data
}

#let _stats(data) = (
    mean: mean(data),
    std: if data.len() > 1 { stddev(data) } else { none },
    count: data.len(),
    min: calc.min(..data),
    max: calc.max(..data),
    p25: percentiles(data, 0.25),
    p50: percentiles(data, 0.5),
    p75: percentiles(data, 0.75),
  )

#let overall-drop-statistics(base-data: lipase-data) = {
  let data = _drop-data(base-data)


  (
    uncooked: _stats(data.map(it => it.uncooked-drop)),
    cooked: _stats(data.map(it => it.cooked-drop)),
  )
}

#let drop-statistics-by-amount(base-data: lipase-data) = {
  let data = _drop-data(base-data)

  let groups = (:)
  for entry in data {
    if entry.amount == none {
      continue
    }
    if not str(entry.amount) in groups {
      groups.insert(str(entry.amount), ())
    }
    groups.at(str(entry.amount)).push(entry)
  }

  for amount in groups.keys() {
    groups.at(amount) = (
      uncooked: _stats(groups.at(amount).map(it => it.uncooked-drop)),
      cooked: _stats(groups.at(amount).map(it => it.cooked-drop)),
    )
  }

  groups
}
