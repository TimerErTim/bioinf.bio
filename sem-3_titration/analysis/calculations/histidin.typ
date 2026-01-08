#import "../../../lib/maths/derivative.typ": *
#import "../../../lib/maths/interpolation.typ": *

#let load-histidin-data() = {
  let data = csv("../../data/histidin_curve_v1.csv", row-type: dictionary, delimiter: ";")
  let x = data.map(it => float(it.at("Maßlösung[ml]")))
  let y = data.map(it => float(it.at("pH-Wert")))
  let data = x.zip(y).sorted(key: it => it.at(0))
  data
}

#let histidin-data = load-histidin-data()
#let x = histidin-data.map(it => it.at(0))
#let y = diff-smooth(histidin-data, order: 0, window: 10, degree: 2).map(it => it.at(1))
#let dy = diff-smooth(histidin-data, order: 1, window: 20, degree: 2).map(it => it.at(1))
#let d2y = diff-smooth(histidin-data, order: 2, window: 20, degree: 3).map(((x, y)) => y)
#let d3y = diff-smooth(histidin-data, order: 3, window: 30, degree: 3).map(it => it.at(1))

#let wendepunkte = find-linear-intersections(x.zip(d2y), 0, window: 10, degree: 2)
#let pl_derivative = wendepunkte.sorted(key: it => interpolate-smooth(x.zip(d3y), it, window: 10, degree: 2)).first()
#let pl_derivative = (pl_derivative, interpolate-smooth(x.zip(y), pl_derivative, window: 10, degree: 2))
#let (pk1, pk3, pk2) = (
  wendepunkte
    .sorted(key: it => interpolate-smooth(x.zip(d3y), it, window: 10, degree: 2))
    .rev()
    .slice(0, count: 3)
    .rev()
    .sorted()
)
#let pk1 = (pk1, interpolate-smooth(x.zip(y), pk1, window: 10, degree: 2))
#let pk2 = (pk2, interpolate-smooth(x.zip(y), pk2, window: 10, degree: 2))
#let pk3 = (pk3, interpolate-smooth(x.zip(y), pk3, window: 10, degree: 2))
#let _pl_slope = (pk2.at(1) - pk3.at(1)) / (pk2.at(0) - pk3.at(0))
#let _pl_intercept = pk3.at(1) - _pl_slope * pk3.at(0)
#let pl_intercept = (
  find-linear-intersections(x.zip(y), slope: _pl_slope, _pl_intercept, window: 10, degree: 2)
    .filter(it => it > pk3.at(0) + 0.01 and it < pk2.at(0) - 0.01)
    .first()
)
#let pl_intercept = (pl_intercept, interpolate-smooth(x.zip(y), pl_intercept, window: 10, degree: 2))
#let pl_average = (pk3.at(1) + pk2.at(1)) / 2
#let pl_average = (find-linear-intersections(x.zip(y), pl_average, window: 10, degree: 2).map(it => (it, calc.abs(it - pl_average))).sorted(key: it => it.at(1)).last().at(0), pl_average)
