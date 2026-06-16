#import "../../lib/maths/statistics.typ": *
#import "../../lib/utils.typ": *

#let raw-data = csv("../data/UE_Sinne_Ergebnisse.xlsx - Sehschärfe.tsv", delimiter: "\t", row-type: array)
#let data = {
  let parse-string-to-number(text) = {
    if text.trim() == "" {
      none
    } else if text.match(regex("^[0-9\\.,]+$")) == none {
      none
    } else {
      float(text.replace(",", "."))
    }
  }

  raw-data.slice(2).map(row => {
    (
      "date": row.at(0),
      "course-of-study": row.at(1),
      "person-id": row.at(2),
      "with-visual-aids": (
        "both": parse-string-to-number(row.at(3)),
        "left": parse-string-to-number(row.at(5)),
        "right": parse-string-to-number(row.at(7)),
      ),
      "no-visual-aids": (
        "both": parse-string-to-number(row.at(4)),
        "left": parse-string-to-number(row.at(6)),
        "right": parse-string-to-number(row.at(8)),
      ),
    )
  })
}

#let statistics-for-data(data) = {
  (
    "mean": mean(data),
    "stddev": stddev(data),
    "min": calc.min(..data),
    "max": calc.max(..data),
    "median": median(data),
    "values": data,
  )
}
#let stats-data = {

  let stats = (
    "with-visual-aids": (
      "both": statistics-for-data(data.map(it => it.with-visual-aids.both).filter(it => it != none)),
      "left": statistics-for-data(data.map(it => it.with-visual-aids.left).filter(it => it != none)),
      "right": statistics-for-data(data.map(it => it.with-visual-aids.right).filter(it => it != none)),
    ),
    "no-visual-aids": (
      "both": statistics-for-data(data.map(it => it.no-visual-aids.both).filter(it => it != none)),
      "left": statistics-for-data(data.map(it => it.no-visual-aids.left).filter(it => it != none)),
      "right": statistics-for-data(data.map(it => it.no-visual-aids.right).filter(it => it != none)),
  )
  )

  (
    "stats": stats,
    "data": data,
  )
}

#let calc-test-results-for-data(data) = {
  let both-eyes_glasses_vs_no-glasses_unpaired = {
    let all-glasses = data.map(it => it.with-visual-aids.both).filter(it => it != none)
    // Filter out the ones that have used glasses
    let no-glasses = data.map(it => if it.with-visual-aids.both == none { it.no-visual-aids.both } else { none }).filter(it => it != none)
    let test-result = two-sample-t-test(all-glasses, no-glasses)
    (
      "test-result": test-result,
      "all-glasses": statistics-for-data(all-glasses),
      "no-glasses": statistics-for-data(no-glasses),
    )
  }

  let both-eyes_glasses_vs_no-glasses_paired = {
    let (with-glasses, no-glasses) = split(
      data.map(it => {
        if it.with-visual-aids.both != none and it.no-visual-aids.both != none {
          (it.with-visual-aids.both, it.no-visual-aids.both)
        } else {
          none
        }
      }).filter(it => it != none),
      n: 2,
    )
    let test-result = paired-t-test(with-glasses, no-glasses)
    (
      "test-result": test-result,
      "with-glasses": statistics-for-data(with-glasses),
      "no-glasses": statistics-for-data(no-glasses),
    )
  }

  let best-single-eye_vs_both-eyes = {
    // Paired test, so every person has to have valid values
    let (best-single-eye, both-eyes) = split(
      data.map(it => {
        // User has glasses, only look at glasses values
        if it.with-visual-aids.both != none {
          if it.with-visual-aids.left == none and it.with-visual-aids.right == none {
            return none
          }

          (
            // single eye
            if it.with-visual-aids.left != none and (it.with-visual-aids.right == none or it.with-visual-aids.left > it.with-visual-aids.right) {
              it.with-visual-aids.left
            } else {
              it.with-visual-aids.right
            },
            // both eyes
            it.with-visual-aids.both,
          )
        } else if it.no-visual-aids.both != none {
          if it.no-visual-aids.left == none and it.no-visual-aids.right == none {
            return none
          }

          (
            // single eye
            if it.no-visual-aids.left != none and (it.no-visual-aids.right == none or it.no-visual-aids.left > it.no-visual-aids.right) {
              it.no-visual-aids.left
            } else {
              it.no-visual-aids.right
            },
            // both eyes
            it.no-visual-aids.both,
          )
        }
      }).filter(it => it != none),
      n: 2,
    )
    let test-result = paired-t-test(best-single-eye, both-eyes)
    (
      "test-result": test-result,
      "best-single-eye": statistics-for-data(best-single-eye),
      "best-both-eyes": statistics-for-data(both-eyes),
    )
  }

  let worst-single-eye_vs_both-eyes = {
    // Paired test, so every person has to have valid values
    let (worst-single-eye, both-eyes) = split(
      data.map(it => {
        // User has glasses, only look at glasses values
        if it.with-visual-aids.both != none {
          if it.with-visual-aids.left == none and it.with-visual-aids.right == none {
            return none
          }

          (
            // single eye
            if it.with-visual-aids.left != none and (it.with-visual-aids.right == none or it.with-visual-aids.left < it.with-visual-aids.right) {
              it.with-visual-aids.left
            } else {
              it.with-visual-aids.right
            },
            // both eyes
            it.with-visual-aids.both,
          )
        } else if it.no-visual-aids.both != none {
          if it.no-visual-aids.left == none and it.no-visual-aids.right == none {
            return none
          }

          (
            // single eye
            if it.no-visual-aids.left != none and (it.no-visual-aids.right == none or it.no-visual-aids.left < it.no-visual-aids.right) {
              it.no-visual-aids.left
            } else {
              it.no-visual-aids.right
            },
            // both eyes
            it.no-visual-aids.both,
          )
        }
      }).filter(it => it != none),
      n: 2,
    )
    let test-result = paired-t-test(worst-single-eye, both-eyes)
    (
      "test-result": test-result,
      "worst-single-eye": statistics-for-data(worst-single-eye),
      "best-both-eyes": statistics-for-data(both-eyes),
    )
  }

  let left-eye_vs_right-eye = {
    let (left-eye, right-eye) = split(
      data.map(it => {
        let wears-glasses = it.with-visual-aids.both != none
        if wears-glasses {
          (it.with-visual-aids.left, it.with-visual-aids.right)
        } else {
          (it.no-visual-aids.left, it.no-visual-aids.right)
        }
      }).filter(it => not it.any(it => it == none)),
    )
    let test-result = paired-t-test(left-eye, right-eye)
    (
      "test-result": test-result,
      "left-eye": statistics-for-data(left-eye),
      "right-eye": statistics-for-data(right-eye),
    )
  }

  (
    "both-eyes_glasses_vs_no-glasses_unpaired": both-eyes_glasses_vs_no-glasses_unpaired,
    "both-eyes_glasses_vs_no-glasses_paired": both-eyes_glasses_vs_no-glasses_paired,
    "best-single-eye_vs_both-eyes": best-single-eye_vs_both-eyes,
    "worst-single-eye_vs_both-eyes": worst-single-eye_vs_both-eyes,
    "left-eye_vs_right-eye": left-eye_vs_right-eye,
  )
}

#let tests-data = {
  (
    "tests": calc-test-results-for-data(stats-data.data),
    "tests-mbi-2025": calc-test-results-for-data(stats-data.data.filter(it => "MBI25" in it.course-of-study)),
    ..stats-data,
  )
}
