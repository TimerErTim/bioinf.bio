#set page(width: auto, height: auto, fill: white.transparentize(100%), margin: 5mm)
#import "../../lib/utils.typ": *
#import "../../lib/maths/regression.typ": *
#import "../../lib/maths/statistics.typ": *
#import "processing.typ": tests-data

#set text(font: "Arial")
#show math.equation: set text(font: "Fira Math")

#import "@preview/lilaq:0.6.0" as lq
#import "../../lib/metro-pkg/src/lib.typ": num, metro-setup
#metro-setup(exponent-mode: "threshold", round-mode: "places", round-precision: 2, output-decimal-marker: ",")

#let show-test-result-significant(test-result) = {
  if test-result.is-significant [yes #sym.checkmark] else [no #sym.crossmark]
  linebreak()
  $p #if test-result.is-significant { sym.lt } else { sym.lt.not } alpha = #num(0.05)$
}

#let show-table-for-tests(tests) = table(
  columns: (6cm, 4cm, auto, auto, auto),
  table.header(
    table.cell(fill: luma(90%))[*null hypothesis*],
    table.cell(fill: luma(90%))[*chosen test*],
    table.cell(fill: luma(90%))[*test statistic*],
    table.cell(fill: luma(90%))[*p-value*],
    table.cell(fill: luma(90%))[*significant?*],
  ),
  [
    The expected value of all measured visual acuities with glasses is equal to the expected value of all measured visual acuities without glasses.
  ],
  [unpaired two-sample t-test],
  [
    $overline(X_"with glasses") = #num(tests.both-eyes_glasses_vs_no-glasses_unpaired.all-glasses.mean)$\ $overline(X_"without glasses") = #num(tests-data.tests.both-eyes_glasses_vs_no-glasses_unpaired.no-glasses.mean)$\
    $T = #num(tests.both-eyes_glasses_vs_no-glasses_unpaired.test-result.t-value)$\
    $n_1 = #tests.both-eyes_glasses_vs_no-glasses_unpaired.all-glasses.values.len()\; space n_2 = #tests.both-eyes_glasses_vs_no-glasses_unpaired.no-glasses.values.len()$
  ],
  [
    $p = #num(tests.both-eyes_glasses_vs_no-glasses_unpaired.test-result.p-value)$
  ],
  [
    #show-test-result-significant(tests.both-eyes_glasses_vs_no-glasses_unpaired.test-result)
  ],
  [
    Wearing glasses has no effect on visual acuity.
  ],
  [paired two-sample t-test],
  [
    $overline(X_"with glasses") = #num(tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.mean)$\ $overline(X_"without glasses") = #num(tests.both-eyes_glasses_vs_no-glasses_paired.no-glasses.mean)$\
    $T = #num(tests.both-eyes_glasses_vs_no-glasses_paired.test-result.t-value)$\
    $n = #tests.both-eyes_glasses_vs_no-glasses_paired.with-glasses.values.len()$
  ],
  [
    $p = #num(tests.both-eyes_glasses_vs_no-glasses_paired.test-result.p-value)$
  ],
  [
    #show-test-result-significant(tests.both-eyes_glasses_vs_no-glasses_paired.test-result)
  ],
  [
    Visual acuity with both eyes is equal to the visual acuity of the better eye.
  ],
  [paired two-sample t-test],
  [
    $overline(X_"both eyes") = #num(tests.best-single-eye_vs_both-eyes.best-both-eyes.mean)$\ $overline(X_"better eye") = #num(tests.best-single-eye_vs_both-eyes.best-single-eye.mean)$\
    $T = #num(tests.best-single-eye_vs_both-eyes.test-result.t-value)$\
    $n = #tests.best-single-eye_vs_both-eyes.best-both-eyes.values.len()$
  ],
  [
    $p = #num(tests.best-single-eye_vs_both-eyes.test-result.p-value)$
  ],
  [
    #show-test-result-significant(tests.best-single-eye_vs_both-eyes.test-result)
  ],
  [
    Visual acuity with both eyes is equal to the visual acuity of the worse eye.
  ],
  [paired two-sample t-test],
  [
    $overline(X_"both eyes") = #num(tests.worst-single-eye_vs_both-eyes.best-both-eyes.mean)$\ $overline(X_"worse eye") = #num(tests.worst-single-eye_vs_both-eyes.worst-single-eye.mean)$\
    $T = #num(tests.worst-single-eye_vs_both-eyes.test-result.t-value)$\
    $n = #tests.worst-single-eye_vs_both-eyes.best-both-eyes.values.len()$
  ],
  [
    $p = #num(tests.worst-single-eye_vs_both-eyes.test-result.p-value)$
  ],
  [
    #show-test-result-significant(tests.worst-single-eye_vs_both-eyes.test-result)
  ],
  [
    Visual acuity of the left eye is equal to the visual acuity of the right eye.
  ],
  [paired two-sample t-test],
  [
    $overline(X_"left eye") = #num(tests.left-eye_vs_right-eye.left-eye.mean)$\ $overline(X_"right eye") = #num(tests.left-eye_vs_right-eye.right-eye.mean)$\
      $T = #num(tests.left-eye_vs_right-eye.test-result.t-value)$\
    $n = #tests.left-eye_vs_right-eye.left-eye.values.len()$
  ],
  [
    $p = #num(tests.left-eye_vs_right-eye.test-result.p-value)$
  ],
  [
    #show-test-result-significant(tests.left-eye_vs_right-eye.test-result)
  ]
)

+ Alle Sehschärfen mit Brolle = Alle Sehschärfen ohne Brille:\ Es werden naiv alle Einträge für beide Augen bei der "mit Brille" Spalte im ungepaarten Zwei-Stichproben-t-Test mit allen Einträgen fur beide Augen in der "ohne Brille" Spalte verglichen.
+ Einfluss einer Brille auf die Sehschärfe:\ Jede Person, die bei beiden Augen einen Eintrag für "mit Brille" UND einen Eintrag für "ohne Brille" hat, wird in den gepaarten Zwei-Stichproben-t-Test aufgenommen.
+ Sehschärfe mit beiden Augen vs. Sehschärfe mit dem besseren Auge:\ Für jede Person wird ermittelt, ob er eine Brille benutzt oder nicht. Benutzt er eine Brille, wird die Sehschärfe mit beiden Augen und mit der besseren der einzelnen Augen unter Verwendung einer Brille in den gepaarten Zwei-Stichproben-t-Test aufgenommen. Benutzt er keine Brille, gleich, aber nur mit der "ohne Brille" Spalte.
+ Sehschärfe mit beiden Augen vs. Sehschärfe mit dem schlechteren Auge:\ Genau gleich wie oben, aber mit der schlechteren der einzelnen Augen.
+ Sehschärfe mit dem linken Auge vs. Sehschärfe mit dem rechten Auge:\ Für jede Person wird die Sehschärfe mit dem linken und rechten Auge in den ungepaarten Zwei-Stichproben-t-Test aufgenommen. Für Brillenträger (wie oben) werden nur Daten aus "mit Brille" Spalte verwendet. Nicht Brillenträger werden nur Daten aus "ohne Brille" Spalte verwendet.

#pagebreak()

Alle Jahrgänge:
#show-table-for-tests(tests-data.tests)

#pagebreak()
MBI 2025:
#show-table-for-tests(tests-data.tests-mbi-2025)
