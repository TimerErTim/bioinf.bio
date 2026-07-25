#import "interpolation.typ": interpolate-smooth

#let average-plots(..datasets, interpolate: interpolate-smooth.with(window: 5, degree: 2)) = {
  let datasets = datasets.pos()
  if datasets.len() == 0 { return () }
  if datasets.len() == 1 { return datasets.at(0) }

  // 1. Alle x-Werte sammeln
  let all-x = ()
  for ds in datasets {
    for pt in ds {
      let x = pt.at(0)
      if x not in all-x {
        all-x.push(x)
      }
    }
  }
  
  // x-Werte aufsteigend sortieren
  all-x = all-x.sorted()

  // Helper: Lineare Interpolation für einen einzelnen Datensatz an Stelle x

  // 2. Für jeden x-Wert den Mittelwert über alle Datensätze berechnen
  let result = ()
  let n = float(datasets.len())

  for x in all-x {
    let sum-y = 0.0
    for ds in datasets {
      sum-y += interpolate(ds, x)
    }
    result.push((x, sum-y / n))
  }

  return result
}