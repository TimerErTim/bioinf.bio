#let split(array, n: 2) = {
  let results = ()
  for i in range(n) {
    results.push(array.map(it => it.at(i)))
  }
  results
}
