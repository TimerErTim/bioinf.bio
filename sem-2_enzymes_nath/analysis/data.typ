#let raw-lipase = csv(bytes(read("../data/UE_Sonstiges_Ergebnisse.xlsx - Lipase.csv").split("\n").slice(1).join("\n")), row-type: dictionary)
#let raw-tn = csv("../data/UE_Sonstiges_Ergebnisse.xlsx - TN-Liste.csv", row-type: dictionary)

#let _parse_number(number) = {
  if number == "-" {
    none
  } else if number.contains(",") {
    eval(number.replace(",", "."))
  } else {
    eval(number)
  }
}

#let lipase-data = {
  let accumulated-results = ()
  for row in raw-lipase {
    
    
    if row.Stdgang != "" {
      // Start new sample series
      let date = {
        if row.Datum.contains(".") {
          let date-parts = row.Datum.split(".")
          datetime(day: eval(date-parts.at(0)), month: eval(date-parts.at(1)), year: eval(date-parts.at(2)))
        } else if row.Datum.contains("/") {
          let date-parts = row.Datum.split("/")
          datetime(day: eval(date-parts.at(1)), month: eval(date-parts.at(0)), year: eval(date-parts.at(2)))
        } else {
          none
        }
      }
      let series = (
        date: date,
        stdgang: row.Stdgang,
        group: row.Gruppe,
        amount: eval(row.Menge),
        note: row.Sonstiges,
        measurements: ()
      )
      if not row.Zeit.contains("in min") {
        series.measurements.push(
          (
            time: _parse_number(row.Zeit),
            cooked: _parse_number(row.gekocht),
            uncooked: _parse_number(row.ungekocht),
          )
        )
      }
      accumulated-results.push(series)
    } else if row.Zeit.contains("in min") {
      continue
    } else {
      // Append to latest series, only if time is later than latest measurement
      let latest-series = accumulated-results.last()
      let latest-measurement-time = latest-series.measurements.last(default: (time: -1)).time
      let parsed-time = _parse_number(row.Zeit)
      if parsed-time > latest-measurement-time {
        latest-series.measurements.push(
          (
            time: parsed-time,
            cooked: _parse_number(row.gekocht),
            uncooked: _parse_number(row.ungekocht),
          )
        )
      } else if parsed-time == latest-measurement-time {
        latest-series.measurements.last() = (
          time: parsed-time,
          cooked: _parse_number(row.gekocht),
          uncooked: _parse_number(row.ungekocht),
        )
      }
      accumulated-results.last() = latest-series
    }
  }
  accumulated-results
}