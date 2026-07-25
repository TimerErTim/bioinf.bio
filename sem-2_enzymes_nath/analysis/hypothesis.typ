#import "data.typ": lipase-data
#import "../../lib/maths/statistics.typ": paired-t-test, anova-test

#let paired-t-tests-active-vs-inactive = {
  let pairs = lipase-data.map(series => {
    // Find the last measurement where both uncooked and cooked values are present (not none)
    let last_entry = series.measurements.rev().find(m => m.uncooked != none and m.cooked != none)
    let first_entry = series.measurements.find(m => m.uncooked != none and m.cooked != none)
    (first_entry.uncooked - last_entry.uncooked, first_entry.cooked - last_entry.cooked)
  })

  let t-test = paired-t-test(pairs.map(it => it.at(0)), pairs.map(it => it.at(1)))
  t-test
}

#let anova-tests-amount = {
  let values = lipase-data.map(series => {
    // Find the last measurement where both uncooked and cooked values are present (not none)
    let last_entry = series.measurements.rev().find(m => m.uncooked != none and m.cooked != none)
    let first_entry = series.measurements.find(m => m.uncooked != none and m.cooked != none)
    (series.amount, first_entry.uncooked - last_entry.uncooked)
  })
  // Group the values based on the series amount
  let groups = (:)
  for (amount, value) in values {
    if amount == none {
      continue
    }
    if not str(amount) in groups {
      groups.insert(str(amount), ())
    }
    groups.at(str(amount)).push(value)
  }

  let anova = anova-test(..groups.values())
  anova
}
