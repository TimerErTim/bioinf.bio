#import "../../templates/protocol.tpl.typ": bio-template, new-chapter

#set document(title: "Chlorophyll Determination", author: "Tim Peko")
#show: bio-template.with(
  show-cover-page: true,
  subtitle: "Determination of Chlorophyll Concentration in Biomatter using Spectrophotometry",
  author: none,
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
#import "../analysis/visualizations.typ": *
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
  image("../assets/chla.structure.png", width: 48%),
  caption: [Chlorophyll A structure @src_chlorophyll-a-photochem],
)) <chla-structure>
#h(1fr)
#box(figure(
  image("../assets/chlb.structure.png", width: 48%),
  caption: [Chlorophyll B structure @src_chlorophyll-b-photochem],
)) <chlb-structure>

=== Solutability

Chlorophyll has a long fatty chain called phytol ($C_(20) H_(39)$) attached to it. This chain makes chlorophyll dissolve well in oils and organic solvents, but not in water. The phytol chain acts like an anchor that holds the chlorophyll in place within the plant's membrane structures.

Because of this fatty chain, organic solvents like acetone, methanol, or ethanol are needed to extract chlorophyll from plant tissues.
80% acetone (mixed with 20% water) is commonly used because the small amount of water helps break apart the protein structures that hold the chlorophyll. @src_chlorophyll-lichtenthaler @src_chlorophyll-extraction-protocol
100% acetone is very suitable for leave extracts. @src_chlorophyll-lichtenthaler

=== Solvatochromism <solvatochromism>

The solvent effect, known as "Solvatochromism", is a phenomenon that occurs when the absorption spectrum of a compound changes between different solvents used.
This solvent-dependent effect applies to chlorophyll and arises from the interaction between the solvent molecules and the chlorophyll's $pi$-electron cloud
@src_plants-in-action.
@src_wikipedia-solvatochromism

Consequently, absorption coefficients derived for methanol cannot be used for acetone extracts, and coefficients for 100% acetone cannot be used for 80% acetone. The specific equations discussed in @calculation-with-instructor-formula are strictly valid only for 100% Acetone extracts. @src_plants-in-action
@src_chlorophyll-lichtenthaler

== Spectrophotometry


=== Beer-Lambert law <beer-lambert-law>

The Beer-Lambert law, shown in @beer-lambert-equation, describes the correlation between the dimensionles total absorbance $E_lambda$, the molar extinctioncoefficent $epsilon_lambda$ ($"l"/("mol" dot "cm")$ @src_wikipedia-molar-extinction-coefficient) and concentration $c$ ($"mol"/"l"$) of the substance of interest in the sample, and the light path length $d$ ($"cm"$) through the sample, where $lambda$ is an arbitary wavelength of light.

$
  E_lambda = epsilon_lambda dot c dot d
$ <beer-lambert-equation>

For example $"Chl"_"a"$ has $epsilon_420 = (85thin 000)/("mol" dot thin "l")$. This however depends on a multitude of factors, such as pH, temperature or solvent, and is therefore not a constant @src_wikipedia-molar-extinction-coefficient.

=== Calculation of Chlorophyll Concentration <calculation-chlorophyll-concentration>

By rearranging @beer-lambert-equation we get:

$
  c space ["mol"/"l"] & = E_lambda / epsilon_lambda dot cancel(1 / d)
$ <beer-lambert-equation-concentration>

$d$ is the path length through the sample or in other words the thickness of the cuvette. The global standard for this is $d = 1"cm"$ @src_quartz-cuvette. Therefore we can effectively cancel out $d$ in the equation.

While @beer-lambert-equation-concentration is a general equation yielding $"mol"/"l"$, we can convert to mass concentration $"g"/"l"$ by multiplying with the molar mass $"MG"_S$ of our substance $S$ and factoring in the dilution factor $V_E / V_P$, where $V_E$ is the volume of the extraction solvent and $V_P$ is the volume of the biological source material.

$
  c space ["g"/"l"_E] & = E_lambda / epsilon_lambda dot "MG"_S dot cancel(1 / d) => \
  c space ["g"/"l"_P] & = c space ["g"/"l"_E] dot V_E / V_P
$ <mass-concentration-equations-l>

Here $c ["g"/"l"_E]$ is the mass concentration of the substance $S$ in the extraction solvent and $c ["g"/"l"_P]$ is the mass concentration of the substance $S$ per volume of the biological source material.

*Note*: We can use the same approach as for removing the dilution factor $V_E / V_P$ to convert from $"g"/"l"_E$ to $"mg"/"g"_P$ by multiplying with the dilution factor $V_E / M_P$, as shown in @mass-concentration-equation-mg.

$ c space ["g"/"g"_P] = c space ["g"/"l"_E] dot V_E / M_P dot 1000 $ <mass-concentration-equation-mg>

Where $M_P$ is the mass of the biological source material in $"g"$, and $c space ["g"/"g"_P]$ is the mass of the substance $S$ per weight of biological source material. This is often used to determine the concentration in fresh weight.

#new-chapter("Execution")

#new-chapter("Results")

We performed various analysis tasks in order to gain a better understanding of the data and the results. These were done in isolation to avoid any confounding factors.

== Spectral Analysis
#let results-spect-data = csv("../data/results.absorption.txt", delimiter: "\t").slice(1)
#let chla-spect-data = csv("../data/chla.absorption.txt", delimiter: "\t").slice(1)
#let chlb-spect-data = csv("../data/chlb.absorption.txt", delimiter: "\t").slice(1)

We decided to take a detailed full spectrum sample using a mixture of brussels sprouts and maggi herbs #footnote[Group 1, subgroup 6 from the results sheet]. We will use this sample for all single sample analysis, namely @calculation-with-instructor-formula and @calculation-with-beer-lambert-law. The full spectrum data was derived by sampling absorption rates at $10"n" "m"$ intervals from the spectrophotometer's automatic full spectrum curve. Results are shown in @spectral-analysis-sample.

=== Reference spectrum

We compare our full spectrum data with the reference spectra of chlorophyll a and chlorophyll b in diethyl ether. This is used for reference even though we used
acetone in our experiment, because we failed to find other publically available full spectrum reference data.

#figure(
  rect(inset: 0.5cm, pad(visualize-reference-absorption(chla-spect-data, chlb-spect-data), right: 1em)),
  caption: [Reference Chlorophyll Absorption Spectra in Diethyl Ether @src_chlorophyll-a-photochem @src_chlorophyll-b-photochem\ Blue shows $"Chl"_"a"$ and red shows $"Chl"_"b"$],
) <spectral-analysis-reference>

In @spectral-analysis-reference we can observe the blue spectrum peaks at
$~430"n" "m"$ for $"Chl"_"a"$ and
$~452"n" "m"$ for $"Chl"_"b"$.
The red spectrum peaks at $~660"n" "m"$ for $"Chl"_"a"$ and $~642"n" "m"$ for $"Chl"_"b"$.

These match the characteristics of the chlorophylls absorption spectrum in diethyl ether.
We can observe the spectrum line of $"Chl"_"a"$ buckles when crossing the line of $"Chl"_"b"$ in the blue region, which is also characteristic for both chlorophyll variants.
@src_plants-in-action

Therefore, we conclude the found dataset to be a viable and accurate source of reference.

=== Sample spectrum

#figure(
  rect(inset: 0.5cm, visualize-results-absorption(results-spect-data, chla-spect-data, chlb-spect-data)),
  caption: [Absorption Spectrum of the Sample (shown in blue) and combined $"Chl"_"a" + "Chl"_"b"$ Reference from @spectral-analysis-reference (shown in dotted black)],
) <spectral-analysis-sample>

The sample spectrum shows the absorption of the total, non-isolated chlorophylls ($"Chl"_"a" + "Chl"_"b"$) in the sample. We can observe three peaks: two in the blue region at $~430 "n" "m"$ and $~445"n" "m"$ with one in the red region at $~660"n" "m"$.

We can observe similar peaks as in the reference spectrum, but with slight distortions and more or less pronounced features. This is because the sample consists of total, non-isolated chlorophylls ($"Chl"_"a" + "Chl"_"b"$) and possibly other pigments dissolved in acetone. Furthermore, as mentioned in @solvatochromism, shifts are to be expected when comparing our sample with diethyl ether dissolved reference @src_plants-in-action.
Despite this, one can even spot fine features in our spectrum. For example the valley at the $~650 "n" "m"$ wavelength that is clearly visible in the reference spectrum is present in our data in form of a small bump.

The most claring difference compared to reference is the samples gradually increasing absorption in the green spectrum (read from right/red to left/blue), whereas according to the reference the absorption should slightly decrease.
One possible explanation for this is the presence of other pigments in the sample that absorb in the green spectrum, such as carotenoids
@src_chlorophyll-extraction-protocol @src_plants-in-action. Another plausible explanation is incomplete calibration: Calibration did not happen across the entire spectrum but only once on the higher end of the wavelength. The level of unfamiliarity with the spectrophotometer and the spectrometer itself might have contributed to this.

== Chlorophyll Concentration with Instructor's Formula <calculation-with-instructor-formula>

#let results-spect-dict = results-spect-data.map(it => (it.at(0), float(it.at(1)))).to-dict()

The instructor provided us with a formula to calculate the chlorophyll concentration:

$
  c_a space ["mg"/"l"] & = 11.78 space E_664 - 2.29 space E_647 \
  c_b space ["mg"/"l"] & = 20.05 space E_647 - 4.77 space E_664 \
             c_"total" & = c_a + c_b = 27.8 space E_652
$

Plugging in the concrete values, shown in @results-important-wavelengths-given-formula, for our sample we get:

#let chla-given-formula = 11.78 * results-spect-dict.at("664") - 2.29 * results-spect-dict.at("647")
#let chlb-given-formula = 20.05 * results-spect-dict.at("647") - 4.77 * results-spect-dict.at("664")
#let total-given-formula = 27.8 * results-spect-dict.at("652")
$c_a space ["mg"/"l"] = 11.78 dot #results-spect-dict.at("664") - 2.29 dot #results-spect-dict.at("647") = bold(#str(chla-given-formula))$ <results-chla-given-formula>

$c_b space ["mg"/"l"] = 20.05 dot #results-spect-dict.at("647") - 4.77 dot #results-spect-dict.at("664") = bold(#str(chlb-given-formula))$ <results-chlb-given-formula>

$c_"total" space ["mg"/"l"] &= c_a + c_b = #str(chla-given-formula) + #str(chlb-given-formula) = bold(#str(chla-given-formula + chlb-given-formula))\ &= 27.8 space E_652 = 27.8 dot #results-spect-dict.at("652") = bold(#str(total-given-formula))$ <results-total-given-formula>

#figure(
  table(
    columns: (auto, auto),
    table.header[*Wavelength*][*Absorbance*],
    ..for wavelength in (664, 647, 652) {
      ([#wavelength], [#results-spect-dict.at(str(wavelength))])
    },
  ),
  caption: "Wavelengths and absorbance of the results from our sample needed for calculating the chlorophyll concentration using the given formulas",
) <results-important-wavelengths-given-formula>

A quick sanity check with the Gemini LLM for the plausability of these values was positive. Lab extracts have a common range of $10 - 30 "mg"/"l"$. This aligns with our values.

We can see a significant difference between the total result using the standalone aborbance factor and the addition of $"Chl"_"a"$ and $"Chl"_"b"$, with an absolute difference of $#(calc.round(digits: 4, calc.abs(total-given-formula - (chla-given-formula + chlb-given-formula)))) space "mg"/"l"$ and a relative difference of $#(calc.round(digits: 2, calc.abs(total-given-formula - (chla-given-formula + chlb-given-formula)) / total-given-formula * 100)) space "%"$.


=== Interpretation of the difference <instructor-formula-difference-interpretation>

It proves difficult to reason for a possible explanation for this discrepancy without knowing where the given formulas originate from and how they were derived. Measurement or execution errors are a possibility, even though seeming unlikely due to the high difference.

== Chlorophyll Concentration using Beer-Lambert Law <calculation-with-beer-lambert-law>

In order to find both the $"Chl"_"a"$ and $"Chl"_"b"$ concentration, we need to use the Beer-Lambert law. We arrange the @beer-lambert-equation into a linear equation system to solve for both concentrations:

$
  E_664 = epsilon_(a, 664) dot c_a + epsilon_(b, 664) dot c_b\
  E_647 = epsilon_(a, 647) dot c_a + epsilon_(b, 647) dot c_b\
$

Because we use the standard path length of $d = 1"cm"$ we can ignore $1/d$ in our calculations.\
Using substitution we can solve for $c_a$ and $c_b$:

$
  c_a space ["mol"/"l"] = (E_664 space epsilon_(b, 647) - E_647 space epsilon_(a, 664)) / (epsilon_(a, 664) space epsilon_(b, 647) - epsilon_(a, 647) space epsilon_(b, 664))\
  c_b space ["mol"/"l"] = (E_647 space epsilon_(a, 664) - E_664 space epsilon_(b, 647)) / (epsilon_(a, 664) space epsilon_(b, 647) - epsilon_(b, 664) space epsilon_(a, 647))\
$

We arrive at final formula for calculating the total chlorophyll concentration, accounting for the mass concentration and dilution factor:

$
        c_a space ["g"/"l"_E] & = c_a space ["mol"/"l"] dot "MG"_"Chl"_a \
        c_b space ["g"/"l"_E] & = c_b space ["mol"/"l"] dot "MG"_"Chl"_b \
  c_"total" space ["g"/"l"_E] & = c_a space ["g"/"l"_E] + c_b space ["g"/"l"_E] \
  c_"total" space ["g"/"g"_P] & = c_"total" space ["g"/"l"_E] dot V_E / M_P \
$

By plugging in the values from @concentration-value-table-beer-lambert for this equation we arrive at the final values for the mass concentration in the extraction solvent:

#let epsilon_a_647 = 17464
#let epsilon_a_664 = 76790
#let epsilon_b_647 = 47040
#let epsilon_b_664 = 9121
#let E_664 = results-spect-dict.at("664")
#let E_647 = results-spect-dict.at("647")
#let MG_a = 893.5
#let MG_b = 907.5
#let M_P = 1910  // mg
#let V_E = 19.98  // ml

#let c_a_mol = (
  (E_664 * epsilon_b_647 - E_647 * epsilon_b_664) / (epsilon_a_664 * epsilon_b_647 - epsilon_a_647 * epsilon_b_664)
)
#let c_b_mol = (
  (E_647 * epsilon_a_664 - E_664 * epsilon_a_647) / (epsilon_a_664 * epsilon_b_647 - epsilon_a_647 * epsilon_b_664)
)

#let c_a_g_dil = c_a_mol * MG_a
#let c_b_g_dil = c_b_mol * MG_b
#let c_total_g_dil = c_a_g_dil + c_b_g_dil
#let c_total_g_undil = c_total_g_dil * V_E / M_P

$c_a space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_a_g_dil * 1000) wj) \
c_b space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_b_g_dil * 1000) wj) \
c_"total" space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_total_g_dil * 1000) wj)$

Accounted for the dilution factor, the final determined mass concentration in the biological source material (fresh weight) is:

$c_"total" space ["mg"/"g"_P] & = c_"total" space ["mg"/"l"_E] dot V_E / M_P = bold(#calc.round(digits: 4, c_total_g_undil * 1000) wj)$

#let fmt-extinction-coeff(value) = {
  $#str(value).split("").rev().slice(1).chunks(3).map(it => it.rev().join("")).rev().join(thin) space "l" thin "mol"^(-1) thin "cm"^(-1)$
}
#figure(
  table(
    columns: 7,
    rows: (auto, 2em, 2em),
    table.header[#table.cell(
      stroke: none,
      fill: none,
    )[]][$bold("MG")_S$][$bold(epsilon_647)$][$bold(epsilon_664)$][$bold(E_647)$][$bold(E_664)$][$bold(V_E div M_P)$],
    table.cell(x: 4, y: 1, rowspan: 2, align: horizon)[$#E_647$],
    table.cell(x: 5, y: 1, rowspan: 2, align: horizon)[$#E_664$],
    table.cell(x: 6, y: 1, rowspan: 2, align: horizon, inset: (
      top: 1em,
    ))[$(#V_E"ml") / (#M_P"mg") =\ #calc.round(digits: 5, V_E / M_P)$],
    [$"Chl"_a$],
    [$#MG_a space "g" thin "mol"^(-1)$],
    [#fmt-extinction-coeff(epsilon_a_647)],
    [#fmt-extinction-coeff(epsilon_a_664)],
    [$"Chl"_b$],
    [$#MG_b space "g" thin "mol"^(-1)$],
    [#fmt-extinction-coeff(epsilon_b_647)],
    [#fmt-extinction-coeff(epsilon_b_664)],
  ),
  caption: [Extinction coefficients @src_coeffecients, molecular weights, absorbance values and dilution factor needed for calculating the chlorophyll concentration using the Beer-Lambert law.],
  placement: bottom,
) <concentration-value-table-beer-lambert>

=== Comparison to instructor's formula

The values calculated using the Beer-Lambert law are in line with the values calculated using the instructor's formulas in @calculation-with-instructor-formula. The difference is small ($#(calc.round(digits: 2, calc.abs((chla-given-formula + chlb-given-formula) / 1000 - c_total_g_dil) / c_total_g_dil * 100)) space "%"$) and indicates that the Beer-Lambert law and our calculations are a valid method for determining the chlorophyll concentration. Small differences can be attributed to different extinction coefficients of the chlorophylls used when precalculating the given formulas' factors.

@instructor-formula-difference-interpretation describes the unknown origin of the instructor-provided formulas. After performing the calculations ourselves, we can observe that once the extinction coefficients $epsilon$ and molecular weights $"MG"$ are known for both chlorophyll types, the concentration equation reduces to simple multilinear functions with constant factors applied to the remaining variables $E_lambda$. This suggests that the given formulas are simplified versions of the complete calculation chain we performed based on the Beer-Lambert law.

Interestingly enough, even though the extinction coefficients $epsilon$ used in our manual calculations are for 80% acetone solutions @src_coeffecients, the Beer-Lambert law calculations still yield results in line with the instructors formulas, despite the solvatochromism effect, stated in @solvatochromism. The small difference between the results of the instructor's formula and the Beer-Lambert law calculations could then be explained by this and the hypothesis, that the absorption difference between 80% acetone and 100% acetone is not significant enough to cause a noticeable difference in the calculated concentration.

=== Checking for alignment with known concentrations

With the calculated concentration value in fresh weight for our sample, we want to check for plausability by comparing to other well known concentrations of common leafy vegetables in fresh weight.

#quote(block: true, attribution: [Gemini LLM 2025])[
  Chlorophyll content varies widely by species, leaf age, and sunlight exposure.
  - Total Chlorophyll (a+b): Generally ranges from 0.08 to 19.2 mg/g fresh weight.
  - Common Leafy Vegetables:
    - Spinach: ~120-150 mg/100g (~1.2-1.5 mg/g).
    - Chard: ~121 mg/100g.
    - Lettuce: ~19-58 mg/100g.
    - Parsley: ~5-20 μg/g.
]

#quote(block: true, attribution: [Gemini LLM 2025])[
  Chlorophyll Content Comparison:
  
  Lovage generally has higher chlorophyll concentrations than most lettuce varieties but slightly lower levels than the most dense leafy herbs like parsley.
  
  - *Lovage (Maggi Herb)*: ~0.68 mg/g (68.5 mg/100g)
  - *Brussels Sprouts*: ~2.41 mg/g
  - *Lettuce*: ~0.12 - 1.0 mg/g
  - *Parsley*: ~2.18 - 2.23 mg/g
]

#let common-leafy-vegetables-concentrations = (
  ("Spinach", [$#(120 / 100) - #(150 / 100)$]),
  ("Chard", [$#(121 / 100)$]),
  ("Lovage (Maggi Herb)", [$#(0.68)$]),
  ("Brussels Sprouts", [$#(2.41)$]),
  ("Lettuce", [$#(0.12) - #(1.0)$]),
  ("Parsley", [$#(2.18) - #(2.23)$]),
)
#figure(
  table(
    columns: common-leafy-vegetables-concentrations.len(),
    table.header(..common-leafy-vegetables-concentrations.map(it => [#it.at(0)])),
    ..common-leafy-vegetables-concentrations.map(it => [#it.at(1)]),
  ),
  caption: [Known concentrations of common leafy vegetables, queried from Gemini 2025, normalized to $"mg"/"g"$ of fresh weight.],
  placement: bottom,
) <known-concentrations-normalized>

Using this information and normalizing to $"mg"slash"g"$ of fresh weight, the results of which are shown in @known-concentrations-normalized, we can compare our results in fresh weight to the known concentrations of common leafy vegetables.

*Note*: Even though Gemini is no scientific source, we only use it for a basic plausability check of our own results. It can therefore be deemed a reliable enough source for this specific usecase.

The total chlorophyll concentration of our sample is $#(calc.round(digits: 4, c_total_g_undil * 1000)) "mg"slash"g"$ of fresh weight. This is less than known concentrations of both brussel sprouts and maggi herbs, which are the only components of our analysed sample. This is unexpected and suggests multiple potential error sources. These could include inadequate processing/grinding with quartz sand, the fact that the material was cooled and partially frozen during preparation, incomplete extraction due to insufficient contact time with the solvent, or degradation of chlorophyll during sample handling.

Nevertheless, the results are within general ranges of our expected results, and are therefore deemed plausible. We do not suspect a great systematic error in our measurements, but rather a combination of multiple smaller errors.


== Descriptive Statistics

#footnote[Calculate all concentrations purely on the given formula based on extinction.]
#footnote[All and by source material type.]
#footnote[
  Compare concentrations filled out on sheet vs newly calculated. Compare filled out total concentrations vs.newly calculated vs. 652nm formula.
]

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
$ <beer-lambert>

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
  image("../assets/chla.structure.png", width: 50%),
  caption: [Chlorophyll A structure @src_chlorophyll-a-photochem],
)
#csv("../data/results.absorption.txt", delimiter: "\t").last()

#set heading(numbering: none)
#new-chapter("Appendix")

== Sources

#bibliography("sources.yaml", title: none, style: "ieee")

#colbreak()

== List of Figures
#outline(title: none, target: figure.where(kind: image))

== List of Tables
#outline(title: none, target: figure.where(kind: table))


// Attachments
#pdf.attach(
  "../instructions/F_Spektralphotometrie.doc",
  mime-type: "application/msword",
  relationship: "supplement",
  description: "Instructions for Experiment",
)
#pdf.attach(
  "../data/chla.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Chlorophyll A reference absorption data",
)
#pdf.attach(
  "../data/chlb.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Chlorophyll B reference absorption data",
)
#pdf.attach(
  "../data/results.absorption.txt",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Experiment spectrum results absorption data",
)
#pdf.attach(
  "../data/GBC1UE_Spectometry_Grp1_2025.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Group 1 raw PDF results from 2025",
)
#pdf.attach(
  "../data/GBC1UE_Spectometry_Grp2_2025.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Group 2 raw PDF results from 2025",
)
#pdf.attach(
  "../data/group_results.json",
  mime-type: "application/json",
  relationship: "data",
  description: "Group results data (digitalized from the raw group PDFs)",
)
