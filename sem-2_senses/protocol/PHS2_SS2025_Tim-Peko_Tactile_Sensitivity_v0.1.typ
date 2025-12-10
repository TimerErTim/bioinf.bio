#import "../../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Resolving Power for Tactile Stimuli",
  subtitle: "Two-Point Discrimination and Tactile Acuity",
  author: none,
  members: ("Tim Peko", "Moritz Kieselbach"),
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "0.1",
  date: "2025-06-16",
)
#show link: it => underline(text(fill: blue)[#it])

#outline(depth: 2)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.equation(numbering: "(1)", number-align: start + top)
#show math.equation: it => {
  if it.block {
    rect(stroke: 0.5pt, radius: 0.25em, it)
  } else {
    it
  }
}
#show image: it => {
  rect(stroke: 0.5pt, it)
}

#pagebreak()
= Background

== Mechanoreceptors & Tactile Sensitivity

The sense of touch relies on four main mechanoreceptors, as depicted in @mechanoreceptors.
- *Merkel cells:* Slowly adapting, small receptive fields; senses steady pressure and fine details.
- *Meissner's corpuscles:* Rapidly adapting, small fields; detects light touch and flutter.
- *Ruffini endings:* Slowly adapting, large fields; senses skin stretch and sustained tension.
- *Pacinian corpuscles:* Rapidly adapting, very large fields; detects deep pressure and high-frequency vibration.

#figure(image("assets/tactile_sensors.png", width: 100%), caption: [
  Depiction of mechanoreceptors in the skin
]) <mechanoreceptors>

Merkel and Meissner receptors, located superficially, provide high spatial resolution (small receptive fields), which is
crucial for fine tactile tasks. Ruffini and Pacinian corpuscles, located deeper in the skin, have large receptive fields
and contribute to broader, less detailed touch perception.

== Tactile Resolving Power (Two-Point Discrimination)

#block(
  width: 100%,
)[
  #box(
    width: 55%,
  )[
    The *two-point discrimination (2PD) test* measures the minimum distance at which two simultaneous touches are perceived
    as being separate. This threshold reflects both mechanoreceptor density and receptive field size. High-acuity regions
    (fingertips, lips) have low thresholds, while low-acuity regions (back, forearm) have much higher thresholds.
    @tactile_overview_body lists typical 2PD thresholds across the body.

    Resolving power in touch is analogous to visual resolution: it quantifies how finely spatial details can be
    distinguished on the skin. Differences across the body reflect both receptor density and cortical representation in the
    brain.
  ]

  #place(right + top)[
    #figure(image("assets/tactile_overview_body.png", width: 40%), caption: [
      Overview of typical\
      2PD thresholds across the body
    ]) <tactile_overview_body>
  ]
]

#pagebreak()
= Experimental Setup

== Two-Point Discrimination Test

#block(
  width: 100%,
)[
  #box(
    width: 55%,
  )[
    We use a compass-style two-point aesthesiometer to apply either one or two points to the skin at varying distances. With
    their eyes closed, the subject reports whether they feel one or two points. The smallest distance at which two points
    are reliably perceived as separate is the 2PD threshold. This is tested on different skin regions.

    The test is repeated on the fingertip, palm, back of the hand, forearm, and upper back to compare tactile acuity.
  ]

  #place(right + top)[
    #figure(image("assets/tactile_experiment_scetch.jpg", width: 40%), caption: [
      Sketch of the experiment\
      execution
    ])
  ]
]

== Materials

- Two-point divider (aesthesiometer)
- Ruler (mm scale)
- Alcohol swabs (for hygiene)
- Optional: blindfold, notebook (for recording)

== Procedure

1. *Sanitize* the points of the divider with alcohol.
2. *Prepare the subject:* have them seated with eyes closed. Explain the procedure.
3. *Select a region:* start with the points far apart, and gently touch the skin.
4. *Ask:* "Do you feel one point or two?"
5. *Adjust the distance:* decrease it until only one point is felt; then increase slightly to confirm the threshold.
6. *Record the threshold* (in mm) for each region.
7. *Repeat* for all regions and participants, cleaning the divider between tests.
8. *Conduct multiple trials and average the thresholds for accuracy.*

#pagebreak()
= Results

#let participants-table(male: 0, female: 0) = {
  table(
    columns: (auto, auto),
    [Participants],
    [*Amount*],
    [*Male*],
    [#male],
    [*Female*],
    [#female],
    [*Total*],
    [#(male + female)],
  )
}

During our analysis, we decided to examine two different datasets:

#stack(dir: ltr, spacing: 5em, [

  *Our class:*\
  From year 2025\
  Class MBI2024
  #[
    #show figure: set align(left)
    #align(left, figure(participants-table(male: 5, female: 5), caption: [
      Participants of our class
    ])) <participants-table-our-class>
  ]
], [
  *All years:*\
  From year 2015 #sym.dash 2025
  #v(1.25em)
  #[
    #show figure: set align(left)
    #align(left, figure(participants-table(male: 175, female: 186), caption: [
      Participants of all years
    ])) <participants-table-all-years>
  ]
])

We mainly focused on the analysis of the "Our class" dataset, as it is the most recent dataset and more personal to us.
The analysis of the "All years" dataset is only for sanity checking and comparison purposes.

#let descriptive-statistics(path) = {
  let data = csv(path, row-type: dictionary)

  table(
    columns: (1fr, 1fr, 1fr, 2fr, 1fr),
    table.header[*Region*][*Participants*][*Range*][*Mean #sym.plus.minus SD*][*Median*],
    ..for row in data {
      row.n = calc.trunc(decimal(row.n))
      row.mean = calc.round(float(row.mean), digits: 2)
      row.std = calc.round(float(row.std), digits: 2)
      row.median = calc.round(float(row.median), digits: 2)
      row.min = calc.round(float(row.min), digits: 2)
      row.max = calc.round(float(row.max), digits: 2)

      (
        [#row.at("")],
        [#row.n],
        [#row.at("min") #sym.dash #row.at("max") mm],
        [#row.at("mean") #sym.plus.minus #row.at("std") mm],
        [#calc.round(float(row.at("median")), digits: 1) mm],
      )
    },
  )
}

== Our class

=== Overview <our-class-overview>

#figure(descriptive-statistics("../analysis/out/current-year/descriptive_statistics.csv"), caption: [
  Descriptive statistics of our class
]) <descriptive-statistics-our-class>

@descriptive-statistics-our-class shows the descriptive analysis of our class dataset. Displayed values are rounded to
two decimal places. We observe that the highest standard deviation is in the forearm region, which could be explained by
the fact that forearm sensitivity varies greatly depending on the radial distance from the body.

#block(
  breakable: false,
  width: 100%,
)[

  @our-class-body-regions-boxplot clearly demonstrates the differences in tactile sensitivity between the various body
  regions. The regions can be ordered from highest to lowest sensitivity as follows:

  #align(top, grid(columns: 2, gutter: 1em, box(width: auto)[
    + Fingertip
    + Palm
    + Back of hand
    + Forearm
    + Upper back
  ], box(width: 1fr)[
    #figure(image("assets/our-class_body_regions_boxplot.png", width: 100%), caption: [
      Boxplot of tactile sensitivity in our class per body region
    ]) <our-class-body-regions-boxplot>
  ]))
]

#let t-test-body-regions(csv-path) = {
  let data = csv(csv-path, row-type: dictionary)

  //[#data]

  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    table.header[*Region 1*][*Region 2*][*t-statistic*][*p-value*],
    ..for row in data {
      row.region1 = row.at("Region 1")
      row.region2 = row.at("Region 2")
      row.p_value = calc.round(float(row.at("p-value")), digits: 3)
      row.t_statistic = calc.abs(calc.round(float(row.at("t-statistic")), digits: 3))
      row.significant = row.at("Significant").contains("True")

      let colored-cell(content) = if row.significant {
        table.cell(fill: green.transparentize(70%), content)
      } else {
        table.cell(fill: red.transparentize(70%), content)
      }

      ([#row.region1], [#row.region2], [#sym.tilde.op #row.t_statistic], colored-cell[#sym.tilde.op #row.p_value],)
    },
  )
}

=== Body regions comparison

In order to confirm statistically significant differences between the body regions, we performed a t-test for each pair
of regions. @t-test-body-regions-our-class shows the results of the t-test, all numbers are rounded to three decimal
places. We observe that all pairs of regions show statistically significant differences, except for the comparisons
between:
- back of hand and forearm
- back and forearm

#figure(t-test-body-regions("../analysis/out/current-year/region_comparisons.csv"), caption: [
  t-test of tactile sensitivity in our class comparing body regions
]) <t-test-body-regions-our-class>

Despite our relatively small sample size, the results are consistent with our expectations that different regions have
different tactile sensitivities.

=== Gender comparison

#let gender-comparison-table(csv-path) = {
  let data = csv(csv-path, row-type: dictionary)

  //[#data]

  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: horizon,
    table.header[*Body Region*][*Male*][*Female*][*t-statistic*][*p-value*],
    ..for row in data {
      row.region = row.at("Body Region")
      row.p_value = calc.round(float(row.at("p-value")), digits: 3)
      row.t_statistic = calc.abs(calc.round(float(row.at("t-statistic")), digits: 3))
      row.significant = row.at("Significant").contains("True")

      row.mean_male = calc.round(float(row.at("Male Mean")), digits: 2)
      row.mean_female = calc.round(float(row.at("Female Mean")), digits: 2)
      row.n_male = calc.round(float(row.at("Male N")), digits: 2)
      row.n_female = calc.round(float(row.at("Female N")), digits: 2)

      let colored-cell(content) = if row.significant {
        table.cell(fill: green.transparentize(70%), content)
      } else {
        table.cell(fill: red.transparentize(70%), content)
      }

      ([#row.region], [
        #row.n_male Samples\
        Mean: #row.mean_male mm
      ], [
        #row.n_female Samples\
        Mean: #row.mean_female mm
      ], [#sym.tilde.op #row.t_statistic], colored-cell[#sym.tilde.op #row.p_value],)
    },
  )
}

#figure(image("assets/our-class_gender_comparison.png", width: 100%), caption: [
  Boxplot of tactile sensitivity in our class comparing gender per body region
]) <our-class-gender-comparison>

To analyze differences between genders, we performed a t-test for each body region. @gender-comparison-table-our-class
shows the results of the t-test, all test results are rounded to three decimal places, and group means are rounded to
two decimal places. The results show no significant differences between genders in any of the body regions.

#figure(gender-comparison-table("../analysis/out/current-year/gender_comparisons.csv"), caption: [
  t-test of tactile sensitivity in our class comparing gender per body region
]) <gender-comparison-table-our-class>

We were unable to process the back region, as data was available only from male participants.

== All years

The all-years dataset includes many more samples than our class dataset, so we expect to see more consistent and
reliable results.

=== Overview

@descriptive-statistics-all-years shows the descriptive statistics of the all-years dataset. There is a higher standard
deviation in the all-years dataset, which is expected due to the larger sample size.

#figure(descriptive-statistics("../analysis/out/all-years/descriptive_statistics.csv"), caption: [
  Descriptive statistics of all years
]) <descriptive-statistics-all-years>

@all-years-body-regions-distribution displays the distribution of tactile sensitivity in all years per body region. It
supports our general conclusion from @our-class-overview regarding the order of regions from highest to lowest
sensitivity.

#figure(image("assets/all-years_distribution.png", width: 100%), caption: [
  Distribution of tactile sensitivity in all years per body region
]) <all-years-body-regions-distribution>

=== Body regions comparison

@t-test-body-regions-all-years confirms our hypothesis that different regions have significantly different tactile
sensitivities. Displayed values are again rounded to three decimal places. We suspect that the larger sample size of the
all-years dataset accounts for the higher accuracy and more pronounced features of the results.

#figure(t-test-body-regions("../analysis/out/all-years/region_comparisons.csv"), caption: [
  t-test of tactile sensitivity in all years comparing body regions
]) <t-test-body-regions-all-years>

=== Gender comparison

Performing the gender analysis on the all-years dataset led to the same results as the analysis of our class dataset: We
found no significant differences between genders in any of the body regions. @all-years-gender-comparison-table shows
the detailed results of the t-tests.

#figure(gender-comparison-table("../analysis/out/all-years/gender_comparisons.csv"), caption: [
  t-test of tactile sensitivity in all years comparing gender per body region
]) <all-years-gender-comparison-table>

Various studies have shown that female participants tend to have higher tactile sensitivity than male participants. This
could not be replicated in our analysis. Possible explanations include an insufficient sample size in the all-years
dataset or inconsistent experimental procedures between experimenters and teams.

#pagebreak()
= Summary & Conclusion

The two-point discrimination test quantifies tactile resolving power, revealing large differences across body regions.
Statistical tests (t-tests) confirm significant differences in thresholds between regions. According to other
literature, sex differences should be present, but they are absent in our experiment. These differences are underpinned
by mechanoreceptor density and cortical representation. Our results show fingertips have the finest acuity, back the
poorest. Females showed no significant difference in tactile sensitivity. Understanding these patterns informs
neuroscience, clinical practice, evolutionary biology, and technology design.

#pagebreak()
#set heading(numbering: none)
= Appendix

== Sources

#let source(title, url, date) = [
  #set par(justify: false)
  + "#title" at #link(url) (#date)
]

#source("Merkel nerve ending - Wikipedia", "https://en.wikipedia.org/wiki/Merkel_nerve_ending", "2025-06-16")
#source(
  "Touch: The Skin – Foundations of Neuroscience",
  "https://openbooks.lib.msu.edu/neuroscience/chapter/touch-the-skin/",
  "2025-06-16",
)
#source(
  "Histology, Meissner Corpuscle - StatPearls - NCBI Bookshelf",
  "https://www.ncbi.nlm.nih.gov/books/NBK518980/",
  "2025-06-16",
)
#source("Pacinian corpuscle - Wikipedia", "https://en.wikipedia.org/wiki/Pacinian_corpuscle", "2025-06-16")
#source("Two-point discrimination - Wikipedia", "https://en.wikipedia.org/wiki/Two-point_discrimination", "2025-06-16")
#source(
  "Neuroscience for Kids - Two Point Discrimination",
  "https://faculty.washington.edu/chudler/twopt.html",
  "2025-06-16",
)
#source(
  "Tactile spatial resolution in blind Braille readers - Neurology.org",
  "https://www.neurology.org/doi/10.1212/WNL.54.12.2230",
  "2025-06-16",
)

