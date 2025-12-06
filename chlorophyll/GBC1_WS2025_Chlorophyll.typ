#import "../templates/protocol.tpl.typ": bio-template, new-chapter

#set document(title: "Chlorophyll Determination")
#show: bio-template.with(
  show-cover-page: true,
  subtitle: "Determination of Chlorophyll Concentration in Biomatter using Spectrophotometry",
  author: "Tim Peko",
  members: ("Dijana Panic", "David Kaiser", "Tim Peko"),
  course: "GBC1",
  semester: "WS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page #current / #total
  ],
  version: "0.1",
  date: datetime.today(offset: auto).display("[year]-[month]-[day]"),
)
#import "analysis/visualizations.typ": *
#show link: it => {
  set text(fill: blue)
  underline(it)
}


#heading(depth: 1, outlined: false)[Contents]

#outline(depth: 2, title: none)
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
#show image: rect.with(stroke: 0.5pt)

#new-chapter[Background]

== Chlorophyll

Chlorophyll is a green pigment found in plants and some bacteria. It is responsible for the green color of plants and is essential for photosynthesis. It consists of two main types: Chlorophyll a ($"Chl"_"a"$) and Chlorophyll b ($"Chl"_"b"$).

#box(figure(
  image("assets/chla.structure.png", width: 48%),
  caption: [Chlorophyll A structure @src_chlorophyll-a-photochem],
)) <chla-structure>
#h(1fr)
#box(figure(
  image("assets/chlb.structure.png", width: 48%),
  caption: [Chlorophyll B structure @src_chlorophyll-b-photochem],
)) <chlb-structure>

=== Solvatochromism <solvatochromism>

The solvent effect, known as "Solvatochromism", is a phenomenon that occurs when the absorption spectrum of a compound changes between different solvents used. @src_wikipedia-solvatochromism
This solvent-dependent effect applies to chlorophyll and arises from the interaction between the solvent molecules and the chlorophyll's $pi$-electron cloud. 
@src_wikipedia-solvatochromism
@src_plants-in-action

Consequently, absorption coefficients derived for methanol cannot be used for acetone extracts, and coefficients for 100% acetone cannot be used for 80% acetone. The specific equations discussed in Section 5 (using 11.78 and 2.29) #footnote[replace with actual section used in this document] are strictly valid only for 80% Acetone extracts. @src_wikipedia-solvatochromism @src_chlorophyll-lichtenthaler

== Spectrophotometry

#new-chapter("Execution")

#new-chapter("Results")

We performed various analysis tasks in order to gain a better understanding of the data and the results. These were done in isolation to avoid any confounding factors.

== Spectral Analysis
#let results-spect-data = csv("data/results.absorption.txt", delimiter: "\t").slice(1)
#let chla-spect-data = csv("data/chla.absorption.txt", delimiter: "\t").slice(1)
#let chlb-spect-data = csv("data/chlb.absorption.txt", delimiter: "\t").slice(1)

We decided to take a detailed full spectrum sample using ... #footnote[hier einfügen von welcher Gruppe und Sample aus Excel Datei online]. The full spectrum data was derived by sampling absorption rates at $10"n" "m"$ intervals from the spectrophotometer's automatic full spectrum curve. Results are shown in @spectral-analysis-sample.

=== Reference spectrum

We compare our full spectrum data with the reference spectra of chlorophyll a and chlorophyll b in diethyl ether. This is used for reference even though we used
acetone in our experiment, because we failed to find other publically available full spectrum reference data.

#figure(
  rect(inset: 0.5cm, visualize-reference-absorption(chla-spect-data, chlb-spect-data)),
  caption: [Reference Chlorophyll Absorption Spectra in Diethyl Ether @src_chlorophyll-a-photochem @src_chlorophyll-b-photochem\ Blue shows $"Chl"_"a"$ and red shows $"Chl"_"b"$],
) <spectral-analysis-reference>

In @spectral-analysis-reference we can observe the blue spectrum peaks at
$~430"n" "m"$ for $"Chl"_"a"$ and
$~452"n" "m"$ for $"Chl"_"b"$.
The red spectrum peaks at $~660"n" "m"$ for $"Chl"_"a"$ and $~642"n" "m"$ for $"Chl"_"b"$.

These match the characteristics of the chlorophylls absorption spectrum in diethyl ether. @src_plants-in-action
We can observe the spectrum line of $"Chl"_"a"$ buckles when crossing the line of $"Chl"_"b"$ in the blue region, which is also characteristic for both chlorophyll variants. @src_plants-in-action
Therefore, we conclude the found dataset to be a viable and accurate source of reference.

=== Sample spectrum

#figure(
  rect(inset: 0.5cm, visualize-results-absorption(results-spect-data, chla-spect-data, chlb-spect-data)),
  caption: [Absorption Spectrum of the Sample (shown in blue) and combined $"Chl"_"a" + "Chl"_"b"$ Reference from @spectral-analysis-reference (shown in dotted black)],
) <spectral-analysis-sample>

The sample spectrum shows the absoprtion of the total, non-isolated chlorophylls ($"Chl"_"a" + "Chl"_"b"$) in the sample. We can observe three peaks: two in the blue region at $~430 "n" "m"$ and $~445"n" "m"$ with one in the red region at $~660"n" "m"$. 

=== Spectrum Statistics




#pagebreak()
#pagebreak()
= Hemoglobin

#block(
  width: 100%,
)[
  #block(
    width: 22.5%,
  )[
    Hemoglobin $"Hb"$ is a vital oxygen-carrying protein found in red blood cells. It consists of
    four subunits:
    - 2x #math.alpha\-chains
    - 2x #math.beta\-chains

    Each chain contains a heme group with a central iron ion in the ferrous state $"Fe"^(2+)$, which is responsible for
    binding oxygen.
  ]
]

== Methemoglobin

When the iron in $"Hb"$ is oxidized to the ferric state $"Fe"^(3+)$, it forms methemoglobin $"MetHb"$, which cannot bind
oxygen and therefore cannot participate in oxygen transport.

The oxidation of $"Hb"$ to $"MetHb"$ is a normal process, but the human body tries to keep the amount of $"MetHb"$ at $< 1%$ of
the total $"Hb"$. Enzymes in red blood cells (like NADPH methemoglobin reductase) continuously reduce the iron back to $"Fe"^(2+)$ to
regenerate functional hemoglobin. However, if someone is exposed to certain oxidizing agents (for example, nitrates in
well water, benzocaine, or dapsone), the rate of $"Fe"^(2+) arrow "Fe"^(3+)$ conversion can overwhelm the repair
enzymes.

The result is methemoglobinemia, where a significant fraction of hemoglobin is stuck in the $"Fe"^(3+)$ form. Blood with
high methemoglobin turns a chocolate-brown color and can cause symptoms of hypoxia (like cyanosis, fatigue or even
neurological symptoms at very high levels)

== Hemiglobincyanide Method

To measure the concentration of hemoglobin in blood samples, one reliable laboratory method is the hemiglobincyanide $"HiCN"$ method,
also known as the cyanmethemoglobin method. This technique converts all forms of hemoglobin (except sulfhemoglobin) into
a single, stable colored complex, cyanmethemoglobin = hemiglobincyanide, which can be measured photometrically. This
approach is recommended by the World Health Organization (WHO) due to its high accuracy and reproducibility.

The conversion is achieved using Drabkin's reagent, which contains potassium ferricyanide $"K"_3"Fe(CN)"_6$ and
potassium cyanide $"KCN"$. @drabkin-reaction describes: The ferricyanide oxidizes hemoglobin to $"MetHb"$, and the
cyanide then binds to $"MetHb"$ to form $"HiCN"$.

$
  "Hb" + upright("K")_3 "Fe"^(3+)("CN")_6 + upright("K")^+ & arrow "MetHb" + upright("K")_4 "Fe"^(2+)("CN")_6 \
                                           "MetHb" + "KCN" & arrow "HiCN" + upright("K")^+
$ <drabkin-reaction>

The resulting $"HiCN"$ complex is stable and has a specific absorbance peak at wavelengths around $540 - 546"nm"$. This
property allows for photometric measurement of hemoglobin concentration using a spectrophotometer. Finally the
hemoglobin concentration is determined based on the Beer–Lambert law, shown in @beer-lambert-law.

$
  A = epsilon * c * ell \ \
  #block[
    $A & ... "total absorbance" \
    epsilon & ... "molar absorptivity of the substance" \
    c & ... "concentration of substance in the sample" \
    ell & ... "path length through sample"$
  ]
$ <beer-lambert-law>

== Reflotron Method

An alternative method for hemoglobin determination is the Reflotron system, a point-of-care device that uses dry reagent
strips and reflectance photometry. A drop of whole blood is applied to a test strip, and the device measures the color
intensity reflected from the strip to calculate hemoglobin concentration. While the Reflotron provides rapid and
user-friendly results, the $"HiCN"$ method remains the gold standard due to its accuracy and standardization.

#new-chapter("Procedure")

Due to unfortunate circumstances, the Reflotron during our lab session was defective and therefore no test data using that
method could be collected. As a result, this chapter only covers the hemiglobincyanide method.

== Materials

- Fresh blood sample (capillary or venous)
- Drabkin's reagent (contains K₃Fe(CN)₆ and KCN)
- Spectrophotometer with a 546 nm filter
- Cuvettes
- Pipettes and tips
- Gloves, lab coat, protective eyewear

== Safety Notes

Always wear gloves and handle blood as a biohazard.

Drabkin's reagent contains potassium cyanide, a highly potent neurotoxin. Prevent inhalation or other absorption of the
substance. Be mindful of proper waste disposal.

== Steps

#block(width: 100%)[
  #block(
    width: 70%,
    height: 21em,
  )[
    + Prepare sample and reference cuvettes.
      + Fill both cuvettes with 5mL of Drabkin's reagent.
      + Add 20µL of blood to the sample cuvette.
    + Gently shake the sample cuvette to mix the contents.
    + Incubate for #sym.gt.eq 5 minutes in the dark for full conversion to cyanmethemoglobin $"HiCN"$.
    + Set the spectrophotometer to 546 nm.
    + Zero the device using the reference cuvette.
    + Insert the sample cuvette and record the absorbance (E#sub("546") = $A$).
    + Calculate the hemoglobin concentration using @instructor-concentration-formula.
  ]
]

== Calculation of Hemoglobin Concentration

=== Seemingly wrong formula

Using the Beer-Lambert law from @beer-lambert-law we formulate:

$ \cspace["mol"slash\L] = A/epsilon times 1/ell $

We can calculate our absorptivity $epsilon$ of $"HiCN"$ for the total sample:

$
  epsilon_"total" & = epsilon_"HiCN"/("MG"_"Hb") times (V_"probe")/(V_"total") \
                  & = (44thin\000 "L"/("mol" dot "cm"))/(64thin\458 "g"/"mol") times (20 mu\L)/(5.02\m\L) \
                  & tilde.eq 0.272 m^2 / "kg" = 2.72 "L"/("kg" dot "cm")
$

This was calculated using the following values:
- molar absorptivity of $"HiCN"$: $epsilon_"HiCN" = 44thin\000 "L"/("mol" dot "cm")$
- molar mass of $"Hb"$: $"MG"_"Hb" = 64thin\458 "g"/"mol"$
- volume of the blood probe: $V_"probe" = 20 mu\L$
- volume of the total sample: $V_"total" = 5.02\m\L$

Since we know that our cuvette has a thickness of $ell = 1"cm"$ we can calculate the concentration of $"Hb"$ in the sample:

$
                 \cspace["kg"slash"L"] & = A / epsilon_"total" times 1/ell \
                                       & = A / (2.72 "L"/("kg" dot "cm")) times 1/(0.01"m") \
                                       & = A times 1 / (2.72 "L"/("kg" dot "cm") times 1"cm") \
                                       & = A times 1 / (2.72 ) space "kg"/L \
                                       & tilde.eq A times 0.368 "kg"/L \
  arrow.r.double \cspace["g"slash"dL"] & = A times 36.77 "g"/("d"L) \
$

=== Correct formula from instructor

The instructor provided us with a formula containing the precalculated factor to calculate the hemoglobin concentration:

$
  \cspace["g"slash"dL"] = A times 14.746 "g"/"dL" \
$ <instructor-concentration-formula>

We will use this factor in all further applications, even though there seems to be no explanation for the significant difference between the two formulas. Plugging in the values in their formula $A times "MG"_"Hb"/"epsilon"_"HiCN" times "V"_"total"/"V"_"probe" times 1/d [g/l]$ does not yield the same result for me.

Example calculation using placeholder values:\
$A = 1.21$\
$"c"_"Hb" = 1.21 times 14.746 "g"/"dL" = 17.843 "g"/"dL"$

#pagebreak()
= Results

We analyzed the data from
+ our class
+ the data of all years, ranging from 2015 to 2024

== Our class: MBI24 (current year) <mbi24-results>

@current-year-table-overview-results shows the summary of our class. In total 22 students participated in the experiment, split between 12 females and 10 males. One can observe that the mean $"c"_"Hb"$ of the females is lower than the mean of the males, and the range also suggests that the males hemoglobin concentration tends to be higher.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    table.header[*Group*][*Amount*][*Range ($"g"/"dL"$)*][*Mean #sym.plus.minus SD ($"g"/"dL"$)*][*Variance*],
    [Male], [10], [10.9 #sym.dash 23.0], [16.7 #sym.plus.minus 3.5], [13.5],
    [Female], [12], [10.1 #sym.dash 17.3], [12.1 #sym.plus.minus 4.3], [19.9],
  ),
  caption: "MBI24 results summary male vs. female",
) <current-year-table-overview-results>


#h(1em)
#box(width: 1fr, baseline: -0.5em)[
  We expect the difference in $"c"_"Hb"$ between males and females to be statistically significant. Therefore we performed a two-sample t-test with different variances using an #math.alpha of 5% to test the null hypothesis that the difference in $"c"_"Hb"$ between males and females is zero.
]

#box(width: 1fr, baseline: 4em)[
  The results of the test are shown in @class-key-values. The t-statistic is 2.63, the critical t-value is 1.72, the p-value is 0.81% and the Cohen's d is 0.32.

  Since the p-value is less than the chosen #math.alpha = 5%, we reject the null hypothesis and conclude that the difference in $"c"_"Hb"$ between males and females is statistically significant. This is also supported by the t-statistic of 2.63 exceeding the critical t-value of 1.72.

  The Cohen's d of 0.32 indicates a small effect size, which means that the difference in $"c"_"Hb"$ between males and females is not very large.
]
#h(1em)
#box(width: 38%)[
  #figure(
    table(
      columns: (1fr, 1fr),
      table.header(table.cell(colspan: 2, align: center)[*Key Values*]),
      [*chosen #math.alpha*], [5%],
      [*t-statistic*], [2.63],
      [*critical t-value*], [1.72],
      [*p-value*], [0.81%],
      [*Cohen's d*], [0.32],
    ),
    caption: "MBI24 t-test values",
  ) <class-key-values>
]

== All years: 2015 - 2024

The analysis is repeated for the years 2015 to 2024 (including MBI24). The results are shown in @all-years-table-overview-results. We can observe the same tendency as in @mbi24-results of a higher $"c"_"Hb"$ in males than in females.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    table.header[*Group*][*Amount*][*Range ($"g"/"dL"$)*][*Mean #sym.plus.minus SD ($"g"/"dL"$)*][*Variance*],
    [Male], [117], [2.32 #sym.dash 53.2], [16.72 #sym.plus.minus 7.83], [61.36],
    [Female], [126], [0.37 #sym.dash 59.8], [14.87 #sym.plus.minus 7.24], [52.35],
  ),
  caption: "All years results summary male vs. female",
) <all-years-table-overview-results>

#h(1em)
#box(width: 1fr, baseline: -3em)[
  For this dataset we also performed a two-sample t-test with different variances using an #math.alpha of 5%.

  The results are shown in @all-years-key-values. The t-statistic is 1.66, the critical t-value is 1.65, the p-value is 4.98% and the Cohen's d is 0.026.
]

#box(width: 1fr, baseline: 0em)[
  Since the p-value is less than the chosen #math.alpha = 5%, we reject the null hypothesis and conclude that the difference in $"c"_"Hb"$ between males and females is statistically significant. This is also supported by the t-statistic of 1.66 being slightly greater than the critical t-value of 1.65.

  The Cohen's d of 0.026 indicates a very small effect size, which means that the difference in $"c"_"Hb"$ between males and females is tiny.
]
#h(1em)
#box(width: 38%)[
  #figure(
    table(
      columns: (1fr, 1fr),
      table.header(table.cell(colspan: 2, align: center)[*Key Values*]),
      [*chosen #math.alpha*], [5%],
      [*t-statistic*], [1.66],
      [*critical t-value*], [1.65],
      [*p-value*], [4.98%],
      [*Cohen's d*], [0.026],
    ),
    caption: "All years t-test values",
  ) <all-years-key-values>
]

This matches the intuitive interpretation of the data based on the boxplots seen in, where the observed difference is rather marginal.

== Conclusion

The results of both t-tests show that the difference in $"c"_"Hb"$ between males and females is statistically significant. This is also supported by the boxplots and the key values. We can observe less pronounced differences in the all years dataset, which can probably be attributed to the higher sample size and therefore more noise accumulation.

In @mbi24-results covering the class of the current year (MBI24), we can observe a significant difference in $"c"_"Hb"$ between males and females, despite the comparatively small sample size. This indicates high accuracy of the hemiglobincyanide method.


#figure(
  image("assets/chla.structure.png", width: 50%),
  caption: [Chlorophyll A structure @src_chlorophyll-a-photochem],
)
#csv("data/results.absorption.txt", delimiter: "\t").last()

#set heading(numbering: none)
#new-chapter("Appendix")

== Sources

#bibliography("sources.yaml", title: none, style: "ieee")


// Attachments
#pdf.attach(
  "instructions/F_Spektralphotometrie.doc",
  mime-type: "application/msword",
  relationship: "supplement",
  description: "Instructions for Experiment",
)
#pdf.attach(
  "data/chla.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Chlorophyll A absorption data",
)
#pdf.attach(
  "data/chlb.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Chlorophyll B absorption data",
)
#pdf.attach(
  "data/results.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Experiment results absorption data",
)
