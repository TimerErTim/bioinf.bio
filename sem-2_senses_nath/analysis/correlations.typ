#set page(width: auto, height: auto, fill: white.transparentize(100%), margin: 5mm)
#import "../../lib/utils.typ": *
#import "../../lib/maths/regression.typ": *
#import "../../lib/maths/statistics.typ": *
#import "processing.typ": tests-data

#set text(font: "Arial")

#import "@preview/lilaq:0.6.0" as lq

#let (beta_1, beta_0) = linear-regression-iterative(tests-data.tests.left-eye_vs_right-eye.left-eye.values.zip(tests-data.tests.left-eye_vs_right-eye.right-eye.values))

#let (x-min, x-max) = (calc.min(..tests-data.tests.left-eye_vs_right-eye.left-eye.values), calc.max(..tests-data.tests.left-eye_vs_right-eye.left-eye.values))
#let correlation-coeff = correlation(tests-data.tests.left-eye_vs_right-eye.left-eye.values, tests-data.tests.left-eye_vs_right-eye.right-eye.values)

#lq.diagram(
  legend: (
    position: top + left,
  ),
  xaxis: (
    label: [Visual acuity (left eye)],
  ),
  yaxis: (
    label: [Visual acuity (right eye)],
  ),
  width: 10cm,
  height: 8cm,
  lq.scatter(
    label: [Left eye vs. Right eye],
    tests-data.tests.left-eye_vs_right-eye.left-eye.values,
    tests-data.tests.left-eye_vs_right-eye.right-eye.values,
    alpha: 50%,
    stroke: none,
    size: 12pt,
  ),
  lq.plot(
    (x-min, x-max),
    x => beta_1 * x + beta_0,
    label: [Pearson correlation: #calc.round(digits: 2, correlation-coeff)],
    stroke: red + 2pt,
    mark: none,
  )
)

#pagebreak()

#let (beta_1, beta_0) = linear-regression-iterative(tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values.zip(tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.no-glasses.values))

#let (x-min, x-max) = (calc.min(..tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values), calc.max(..tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values))
#let correlation-coeff = correlation(tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values, tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.no-glasses.values)

#lq.diagram(
  legend: (
    position: top + left,
  ),
  xaxis: (
    label: [Visual acuity (with glasses)],
  ),
  yaxis: (
    label: [Visual acuity (without glasses)],
  ),
  width: 10cm,
  height: 8cm,
  lq.scatter(
    label: [With glasses vs. Without glasses],
    tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values,
    tests-data.tests.both-eyes_glasses_vs_no-glasses_paired.no-glasses.values,
    alpha: 50%,
    stroke: none,
    size: 12pt,
  ),
  lq.plot(
    (x-min, x-max),
    x => beta_1 * x + beta_0,
    label: [Pearson correlation: #calc.round(digits: 2, correlation-coeff)],
    stroke: red + 2pt,
    mark: none,
  )
)