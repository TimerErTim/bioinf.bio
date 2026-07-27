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

#let overall-drop-statistics-all = overall-drop-statistics()
#let overall-drop-statistics-current-year = overall-drop-statistics(base-data: lipase-data.filter(series => series.date != none and series.date.year() == 2026))
#let drop-statistics-by-amount-all = drop-statistics-by-amount()
#let drop-statistics-by-amount-current-year = drop-statistics-by-amount(base-data: lipase-data.filter(series => series.date != none and series.date.year() == 2026))

#let overall-drop-table = {
  let get_data_view(extract-fn) = {
    (
      extract-fn(overall-drop-statistics-all.cooked),
      extract-fn(overall-drop-statistics-all.uncooked),
      extract-fn(overall-drop-statistics-current-year.cooked),
      extract-fn(overall-drop-statistics-current-year.uncooked),
    )
  }
  
  table(
    columns: (1fr, auto, auto, auto, auto),
    align: center,
    table.header(table.cell(stroke: none, fill: none)[], table.cell(colspan: 2)[*Alle Jahrgänge*], table.cell(colspan: 2)[*MBI 2025*]),
    table.header(table.cell(stroke: none, fill: none)[], [*Gekocht*], [*Ungekocht*], [*Gekocht*], [*Ungekocht*]),
    [Anzahl], ..get_data_view(it => [#it.count]),
    [$overline(x) plus.minus s$], ..get_data_view(it => [#calc.round(it.mean, digits: 2) #sym.plus.minus #calc.round(it.std, digits: 2)]),
    [$max space dash thin min$], ..get_data_view(it => [$#calc.round(it.max, digits: 2) space dash thin #calc.round(it.min, digits: 2)$]),
  )
}

#let _make-drop-by-amount-table(stats) = {
  let data = stats.pairs().sorted(key: it => it.at(0))
  
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    align: center,
    table.header[*Menge \[#sym.mu\L\]*][*Enzym*][*Anzahl*][*$bold(overline(x) plus.minus s)$*][*$bold(max space dash thin min)$*],
    ..for (amount, stats) in data {
      (
        table.cell(rowspan: 2)[*#amount*],
        [Gekocht],
        [#stats.cooked.count],
        [#calc.round(stats.cooked.mean, digits: 2) #sym.plus.minus #if stats.cooked.std != none { [#calc.round(stats.cooked.std, digits: 2)] } else [$?$]],
        [$#calc.round(stats.cooked.max, digits: 2) space dash thin #calc.round(stats.cooked.min, digits: 2)$],
        [Ungekocht],
        [#stats.uncooked.count],
        [#calc.round(stats.uncooked.mean, digits: 2) #sym.plus.minus #if stats.uncooked.std != none { [#calc.round(stats.uncooked.std, digits: 2)] } else [$?$]],
        [$#calc.round(stats.uncooked.max, digits: 2) space dash thin #calc.round(stats.uncooked.min, digits: 2)$],
      )
    }
  )
}

#let drop-by-amount-table-all-years = _make-drop-by-amount-table(drop-statistics-by-amount-all)
#let drop-by-amount-table-current-year = _make-drop-by-amount-table(drop-statistics-by-amount-current-year)
