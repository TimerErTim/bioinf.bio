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

It is the foundation of life for plants, algae, and cyanobacteria, due to converting sunlight into chemical energy. It is a key component of the photosynthetic process and is essential for the production of oxygen and food. @src_plants-in-action

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

=== Photophysics and structural distinctions

Chlorophylls are Mg-coordinated chlorins (porphyrin derivatives) with an extended conjugated $pi$-system that gives rise to two dominant absorption regions: an intense Soret band in the blue ($tilde 430-460"nm"$) and a weaker Q band in the red ($tilde 640-670"nm"$) region. The weak absorption in the green explains the perceived color of foliage. @src_plants-in-action

The only structural difference between $"Chl"_"a"$ and $"Chl"_"b"$ at $C-7$ (methyl vs. formyl) shifts the spectra: $"Chl"_"a"$ peaks near $664"nm"$ and $"Chl"_"b"$ near $647"nm"$, enabling simultaneous quantification in mixtures @src_chlorophyll-a-photochem @src_chlorophyll-b-photochem. The hydrophobic phytol tail anchors chlorophylls in thylakoid membranes and dictates solubility in organic solvents @src_chlorophyll-extraction-protocol.

== Spectrophotometry

=== Principle

#figure(
  image("../assets/spectrophotometrie.png", width: 100%),
  caption: [Principle of spectrophotometry (CC BY-4.0; Heesung Shim via LibreTexts) @src_spectrophotometry],
) <spectrophotometry-principle-image>

Spectrophotometry is an analytical technique used to quantify the concentration of a substance by measuring its ability to absorb light at specific wavelengths. When a beam of monochromatic light with an initial intensity $I_0$ passes through a sample, the molecules within the solution interact with the photons, leading to a reduction in intensity to a transmitted value $I$. This interaction is governed by the electronic structure of the analyte, where photons are absorbed if their energy matches the electronic transition states of the molecule, as discussed in @solvatochromism. @src_spectrophotometry

The relationship between the incident and transmitted light is expressed through transmittance $T$ and absorbance $A$:

$
  T = I / I_0
$ <transmittance-equation>

$
  A = -log_(10)(T)
$ <absorbance-equation>

While transmittance describes the fraction of light passing through the sample, absorbance is the preferred metric in quantitative analysis because of its linear relationship with concentration $c$ and path length $d$, as stated by the Beer-Lambert law. This linearity typically holds within a specific concentration range, beyond which chemical or instrumental deviations occur. In standard laboratory settings, cuvettes with a path length of $1"cm"$ are utilized to simplify the mathematical conversion of absorbance into concentration @src_spectrophotometry.

=== General process

The experimental procedure begins with selecting the diagnostic wavelengths relevant to the pigments of interest—most notably the red absorption maxima for chlorophylls—and allowing the spectrophotometer to warm up to ensure a stable light source. A baseline is established by "blanking" the instrument using a cuvette filled with pure solvent (e.g., 80% acetone), which defines $I_0$ and accounts for any absorption or reflection by the cuvette and solvent itself @src_spectrophotometry.

Once the baseline is set, the sample extract is measured to determine the transmitted intensity $I$, from which the absorbance $A$ is calculated. It is critical to ensure that the measured absorbance stays within the instrument's linear dynamic range (typically between 0.1 and 1.0); samples exceeding this range must be diluted and remeasured to preserve accuracy. For mixtures like leaf extracts, measurements are taken at multiple wavelengths (e.g., $647"nm"$ and $664"nm"$) to resolve the individual contributions of $"Chl"_"a"$ and $"Chl"_"b"$ using simultaneous equations based on the principle of additivity (see @mixtures-additivity). In cases where turbidity or light scattering from cell debris is suspected, a measurement at a non-absorbing wavelength such as $750"nm"$ is performed to subtract the background noise from the pigment readings. 
@src_chlorophyll-lichtenthaler 
@src_chlorophyll-extraction-protocol
Finally, the calculated concentrations in the extract are converted to fresh weight values by accounting for the initial sample weight and extraction volume @src_spectrophotometry.

=== Beer-Lambert law <beer-lambert-law>

The Beer-Lambert law, shown in @beer-lambert-equation and based on @transmittance-equation, describes the correlation between the dimensionles total absorbance $E_lambda$, the molar extinctioncoefficent $epsilon_lambda$ ($"l"/("mol" dot "cm")$ @src_wikipedia-molar-extinction-coefficient) and concentration $c$ ($"mol"/"l"$) of the substance of interest in the sample, and the light path length $d$ ($"cm"$) through the sample, where $lambda$ is an arbitary wavelength of light.

$
  E_lambda = epsilon_lambda dot c dot d
$ <beer-lambert-equation>

For example $"Chl"_"a"$ has $epsilon_420 = (85thin 000)/("mol" dot thin "l")$. This however depends on a multitude of factors, such as pH, temperature or solvent, and is therefore not a constant @src_wikipedia-molar-extinction-coefficient.

=== Mixtures and additivity

In an extract, total absorbance at a given wavelength is the sum of each pigment's absorbance: 

$
E_lambda = d dot limits(sum)_i epsilon_(i, lambda) dot c_i
$ <mixtures-additivity>

@mixtures-additivity must be taken into account when calculating concentrations of real world samples, since there is rarely any purely isolated sample available. @src_photoplethysmography


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

$ c space ["mg"/"g"_P] = c space ["g"/"l"_E] dot V_E / M_P dot 1000 $ <mass-concentration-equation-mg>

Where $M_P$ is the mass of the biological source material in $"g"$, and $c space ["mg"/"g"_P]$ is the mass of the substance $S$ per weight of biological source material. This is often used to determine the concentration in fresh weight.

#new-chapter("Execution")



#new-chapter("Results")

We performed various analysis tasks in order to gain a better understanding of the data and the results. These were done in isolation to avoid any confounding factors.

We decided to take a detailed full spectrum sample using a mixture of brussels sprouts and maggi herbs #footnote[File group 1, subgroup 6 from the results sheet]. We will use this sample for all single sample analysis, especially in @calculation-with-instructor-formula and @calculation-with-beer-lambert-law. We refer to this sample as "our's" going forward.

== Spectral Analysis
#let results-spect-data = csv("../data/results.absorption.txt", delimiter: "\t").slice(1)
#let chla-spect-data = csv("../data/chla.absorption.txt", delimiter: "\t").slice(1)
#let chlb-spect-data = csv("../data/chlb.absorption.txt", delimiter: "\t").slice(1)

The full spectrum data was derived by sampling absorption rates at $10"n" "m"$ intervals from the spectrophotometer's automatic full spectrum curve. Results are shown in @spectral-analysis-sample.

=== Reference spectrum

We compare our full spectrum data with the reference spectra of chlorophyll a and chlorophyll b in diethyl ether. This is used for reference even though we used
acetone in our experiment, because we failed to find other publically available full spectrum reference data.

#figure(
  rect(inset: 0.5cm, pad(visualize-reference-absorption(chla-spect-data, chlb-spect-data), right: 1em)),
  caption: [Reference Chlorophyll Absorption Spectra in Diethyl Ether @src_chlorophyll-a-photochem @src_chlorophyll-b-photochem. Blue shows $"Chl"_"a"$ and red shows $"Chl"_"b"$],
) <spectral-analysis-reference>

In @spectral-analysis-reference we can observe the blue spectrum peaks at
$~430"nm"$ for $"Chl"_"a"$ and
$~452"nm"$ for $"Chl"_"b"$.
The red spectrum peaks at $~660"nm"$ for $"Chl"_"a"$ and $~642"nm"$ for $"Chl"_"b"$.

These match the characteristics of the chlorophylls absorption spectrum in diethyl ether.
We can observe the spectrum line of $"Chl"_"a"$ buckles when crossing the line of $"Chl"_"b"$ in the blue region, which is also characteristic for both chlorophyll variants.
@src_plants-in-action

Therefore, we conclude the found dataset to be a viable and accurate source of reference.

=== Sample spectrum

#figure(
  rect(inset: 0.5cm, visualize-results-absorption(results-spect-data, chla-spect-data, chlb-spect-data)),
  caption: [Absorption Spectrum of the Sample (shown in blue) and combined $"Chl"_"a" + "Chl"_"b"$ Reference from @spectral-analysis-reference (shown in dotted black)],
) <spectral-analysis-sample>

The sample spectrum shows the absorption of the total, non-isolated chlorophylls ($"Chl"_"a" + "Chl"_"b"$) in the sample. We can observe three peaks: two in the blue region at $~430"nm"$ and $~445"nm"$ with one in the red region at $~660"nm"$.

We can observe similar peaks as in the reference spectrum, but with slight distortions and more or less pronounced features. This is because the sample consists of total, non-isolated chlorophylls ($"Chl"_"a" + "Chl"_"b"$) and possibly other pigments dissolved in acetone. Furthermore, as mentioned in @solvatochromism, shifts are to be expected when comparing our sample with diethyl ether dissolved reference @src_plants-in-action.
Despite this, one can even spot fine features in our spectrum. For example the valley at the $~650"nm"$ wavelength that is clearly visible in the reference spectrum is present in our data in form of a small bump.

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
$ <instructor-formula-equations>

Plugging in the concrete values, shown in @results-important-wavelengths-given-formula, for our sample we get:

#let calc-instructor-chla-mg(E_647, E_664) = 11.78 * E_664 - 2.29 * E_647
#let calc-instructor-chlb-mg(E_647, E_664) = 20.05 * E_647 - 4.77 * E_664
#let calc-instructor-total-mg(E_652) = 27.8 * E_652

#let chla-given-formula = calc-instructor-chla-mg(results-spect-dict.at("647"), results-spect-dict.at("664"))
#let chlb-given-formula = calc-instructor-chlb-mg(results-spect-dict.at("647"), results-spect-dict.at("664"))
#let total-given-formula = calc-instructor-total-mg(results-spect-dict.at("652"))

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

In order to find both the $"Chl"_"a"$ and $"Chl"_"b"$ concentration, we need to use the Beer-Lambert law. We arrange @beer-lambert-equation and @mixtures-additivity into a linear equation system to solve for both concentrations:

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
#let MG_a = 893.5
#let MG_b = 907.5
#let E_647 = results-spect-dict.at("647")
#let E_664 = results-spect-dict.at("664")
#let M_P = 1910  // mg
#let V_E = 19.98  // ml

#let calc-lambert-chla-mol(E_647, E_664) = (
  (E_664 * epsilon_b_647 - E_647 * epsilon_b_664) / (epsilon_a_664 * epsilon_b_647 - epsilon_a_647 * epsilon_b_664)
)
#let calc-lambert-chlb-mol(E_647, E_664) = (
  (E_647 * epsilon_a_664 - E_664 * epsilon_a_647) / (epsilon_a_664 * epsilon_b_647 - epsilon_a_647 * epsilon_b_664)
)
#let calc-chla-mol-to-mg(c_a_mol) = c_a_mol * MG_a * 1000
#let calc-chlb-mol-to-mg(c_b_mol) = c_b_mol * MG_b * 1000
#let calc-undilute-mg_l-mg_g(c_g, M_P, V_E) = c_g * V_E / M_P

#let c_a_mol = calc-lambert-chla-mol(E_647, E_664)
#let c_b_mol = calc-lambert-chlb-mol(E_647, E_664)

#let c_a_mg_dil = calc-chla-mol-to-mg(c_a_mol)
#let c_b_mg_dil = calc-chlb-mol-to-mg(c_b_mol)
#let c_total_mg_dil = c_a_mg_dil + c_b_mg_dil
#let c_total_mg_undil = calc-undilute-mg_l-mg_g(c_total_mg_dil, M_P, V_E)

$c_a space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_a_mg_dil) wj) \
c_b space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_b_mg_dil) wj) \
c_"total" space ["mg"/"l"_E] & = bold(#calc.round(digits: 2, c_total_mg_dil) wj)$

Accounted for the dilution factor, the final determined mass concentration in the biological source material (fresh weight) is:

$c_"total" space ["mg"/"g"_P] & = c_"total" space ["mg"/"l"_E] dot V_E / M_P = bold(#calc.round(digits: 4, c_total_mg_undil) wj)$

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

The values calculated using the Beer-Lambert law are in line with the values calculated using the instructor's formulas in @calculation-with-instructor-formula. The difference is small ($#(calc.round(digits: 2, calc.abs((chla-given-formula + chlb-given-formula) - c_total_mg_dil) / c_total_mg_dil * 100)) space "%"$) and indicates that the Beer-Lambert law and our calculations are a valid method for determining the chlorophyll concentration. Small differences can be attributed to different extinction coefficients of the chlorophylls used when precalculating the given formulas' factors.

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
  ("Lovage (Maggi Herb)", [$#0.68$]),
  ("Brussels Sprouts", [$#2.41$]),
  ("Lettuce", [$#0.12 - #1.0$]),
  ("Parsley", [$#2.18 - #2.23$]),
)
#figure(
  table(
    columns: common-leafy-vegetables-concentrations.len(),
    table.header(..common-leafy-vegetables-concentrations.map(it => [#it.at(0)])),
    ..common-leafy-vegetables-concentrations.map(it => [#it.at(1)]),
  ),
  caption: [Known concentrations of common leafy vegetables, queried from Gemini 2025, normalized to $"mg"slash"g"$ of fresh weight.],
  placement: bottom,
) <known-concentrations-normalized>

Using this information and normalizing to $"mg"slash"g"$ of fresh weight, the results of which are shown in @known-concentrations-normalized, we can compare our results in fresh weight to the known concentrations of common leafy vegetables.

*Note*: Even though Gemini is no scientific source, we only use it for a basic plausability check of our own results. It can therefore be deemed a reliable enough source for this specific usecase.

The total chlorophyll concentration of our sample is $#(calc.round(digits: 4, c_total_mg_undil)) "mg"slash"g"$ of fresh weight. This is less than known concentrations of both brussel sprouts and maggi herbs, which are the only components of our analysed sample. This is unexpected and suggests multiple potential error sources. These could include inadequate processing/grinding with quartz sand, the fact that the material was cooled and partially frozen during preparation, incomplete extraction due to insufficient contact time with the solvent, or degradation of chlorophyll during sample handling.

Nevertheless, the results are within general ranges of our expected values, and are therefore deemed plausible. We do not suspect a great systematic error in our measurements, but rather a combination of multiple smaller errors.


== Descriptive Statistics <descriptive-statistics>

#let groups-results-data = json("../data/group_results.json")

We analyze the results of all groups in our class and compare them to our own results. We also compare different source materials with each other. Except for explicitly stated otherwise, the concentrations in fresh weight are computed using the instructor's formula for individual chlorophyll types and adding them together, after which dilution compensation is performed. We do not use the pre-calculated concentrations from the results sheet.

=== Overall results

#let groups-results-addedformula-concentration = (
  groups-results-data
    .filter(it => it.volume_ml != none)
    .map(it => {
      let total_added_mg_l = (
        calc-instructor-chla-mg(it.extinction_647, it.extinction_664)
          + calc-instructor-chlb-mg(it.extinction_647, it.extinction_664)
      )
      let total_instructor_mg_l = calc-instructor-total-mg(it.extinction_652)
      return (
        ..it,
        total_added_mg_freshweight: calc-undilute-mg_l-mg_g(
          total_added_mg_l,
          it.weight_mg,
          it.volume_ml,
        ),
        total_instructor_mg_freshweight: calc-undilute-mg_l-mg_g(
          total_instructor_mg_l,
          it.weight_mg,
          it.volume_ml,
        ),
        total_instructor_mg_l: total_instructor_mg_l,
        total_added_mg_l: total_added_mg_l,
        concentration_total: it.concentration_chla + it.concentration_chlb,
        concentration_freshweight: calc-undilute-mg_l-mg_g(
          it.concentration_chla + it.concentration_chlb,
          it.weight_mg,
          it.volume_ml,
        ),
      )
    })
)

#figure(
  table(
    columns: 4,
    align: horizon + start,
    table.header[*Mean* $bold(dash(x))$][*Standard Deviation $bold("std"(x))$*][*Median $bold(tilde(x))$*][*Range $bold(max(x) - min(x))$*],
    [$#(calc.round(digits: 4, mean(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight)))) "mg"slash"g"$],
    [$#(calc.round(digits: 4, std(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight)))) "mg"slash"g"$],
    [$#(calc.round(digits: 4, median(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight)))) "mg"slash"g"$],
    [$#(calc.round(digits: 4, max-value(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight))))
    -
    #(calc.round(digits: 4, min-value(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight))))
    "mg"slash"g"$],
  ),
  caption: [Descriptive statistics of the total chlorophyll concentration for all groups],
) <descriptive-statistics-table-all-groups>

@descriptive-statistics-table-all-groups shows all descriptive statistics of the total chlorophyll concentration in fresh weight for all groups. We can use this information to put our group's results in context.

#let c_total_instructor_undil = calc-undilute-mg_l-mg_g(chla-given-formula + chlb-given-formula, M_P, V_E)

Based on the instructor's formula for the total chlorophyll concentration, our total chlorophyll concentration in fresh weight is $#(calc.round(digits: 4, c_total_instructor_undil)) "mg"slash"g"$. This belongs to the higher end of our value range, but is not an outlier. It indicates a result value fitting for our experiment. The high value makes sense, as @known-concentrations-normalized shows that brussels sprouts have a very high concentration of chlorophyll.

#figure(
  rect(inset: 0.5cm, boxplot-all-with-our-value(
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
    c_total_instructor_undil,
  )),
  caption: [Boxplot of all groups' results compared to our results],
) <boxplot-all-groups-compared-to-our-results>

@boxplot-all-groups-compared-to-our-results shows a boxplot of all groups' results compared to our results. It demonstrated we lie between the third and fourth quartile of the data, and supports our claims above.

=== Results per source material

#figure(
  rect(inset: 0.5cm, boxplot-all-per-type(
    groups-results-addedformula-concentration.map(it => it.sample_source),
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
  )),
  caption: [Boxplot of all groups' results per source material],
) <boxplot-all-groups-per-source-material>

@boxplot-all-groups-per-source-material shows interesting insights. Most of the source materials have only a singular entry and are therefore shown flat in the plot.

For the shine mix, parsley, edamame (with or without pods), and cabbage, the results are very similar. This is quite surprising, as @known-concentrations-normalized lists parsley with about $15times$ higher concentration than we see in the boxplot.

The brussels sprouts and maggi mix has the highest concentration of the natural source materials (which excludes the chlorophyll solution). This should not be the case, as it should be somewhere in between the concentration for pure maggi herbs and brussels sprouts, yet it exceeds both.

One would expect the chlorophyll solution to have a very high concentration, as theoretically there should be a fresh weight concentration of $1"mg"slash"g"$ (due to assuming $0.1%$ solution to be the fresh weight). We can see that trend reflected in the boxplot, even though the median is below the theoretical value.

This deviation is not unique to the chlorophyll solution, as virtually all natural source materials have a lower concentration than their expected value, based on @known-concentrations-normalized.

==== Explanation for the deviation

Several factors explain why our measured values may be lower than expected:
- *Incomplete extraction*: The acetone may not have extracted all chlorophyll from the plant cells. Different plants have different cell wall structures, making some harder to extract from than others.
- *Chlorophyll breakdown*: Chlorophyll is sensitive to light and heat. Some may have broken down during extraction and measurement, reducing the final concentration.
- *Measurement errors*: Small errors in weighing samples, measuring volumes, or reading the spectrophotometer can add up and affect the results.
- *Natural variation*: Real plants vary in chlorophyll content depending on age, growing conditions, and storage. The reference values are averages that may not match our specific samples.

We do not conclude the calculations or values to be catastrophically wrong, as even though there are wildy different raw data points, the overall end results of the calcualation chain seem to settle in sensible values, as illustrated in @difference-raw-final-values-plot. Instead, we assume that error sources are small but consistent across all groups.

#figure(
  rect(inset: 0.5cm, plot-difference-raw-final-values(
    groups-results-addedformula-concentration.map(it => it.total_instructor_mg_l),
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
  )),
  caption: [Difference between chlorophyll concentration in solution and in fresh weight for all groups, showing the diverge],
) <difference-raw-final-values-plot>

#figure(
  table(
    columns: 3,
    table.header[*Data Points*][*Standard Deviation*][*Normalized Standard Deviation*],
    [Concentration $"mg"slash"l"$ in solution],
    [$plus.minus #(calc.round(digits: 4, std(groups-results-addedformula-concentration.map(it => it.total_instructor_mg_l)))) "mg"slash"l"$],
    [$plus.minus #(calc.round(digits: 4, std(groups-results-addedformula-concentration.map(it => it.total_instructor_mg_l / mean(groups-results-addedformula-concentration.map(it => it.total_instructor_mg_l))))))$],

    [Concentration $"mg"slash"g"$ in fresh weight],
    [$plus.minus#(calc.round(digits: 4, std(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight)))) "mg"slash"g"$],
    [$plus.minus #(calc.round(digits: 4, std(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight / mean(groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight))))))$],
  ),
  caption: [Standard deviation of the data points for concentration in solution and in fresh weight],
) <standard-deviation-raw-final-concentrations>

We can also compare the standard deviation of the soluted data points and the fresh weight data points. @standard-deviation-raw-final-concentrations shows that the compensation of the dilution factor works well, since we can effectively map all data points to a smaller more concrete range. This however is not perfect, as the _normalized_ #footnote[normalized: data points divided by their common mean] standard deviation of the fresh weight data points is slightly higher than the standard deviation of the solution data points. It shows that when accounted for unit differences, the fresh weight data points are more scattered than the solution data points.

=== Comparison between fresh weight concentration sources

As mentioned in the introduction of @descriptive-statistics, until now we have ignored the filled out concentrations on the results sheet, and instead recalculated using the instructor's formula based on the written down extinction coefficients. We will now compare these freshly recalculated concentrations with the concentrations filled out on the results sheets. For this purpose, we take the $"Chl"_a$ and $"Chl"_b$ concentrations filled out on the results sheet, add them together and compensate for the dilution factor to get the total chlorophyll concentration in fresh weight.

Afterwards, we compare the freshly recalculated total concentration with a total concentration calculated using the instructor's formula based on the 652nm extinction coefficient.

#figure(
  rect(inset: 0.5cm, plot-calculation-sources-comparisons(
    groups-results-addedformula-concentration.map(it => it.concentration_freshweight),
    groups-results-addedformula-concentration.map(it => it.total_instructor_mg_freshweight),
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
  )),
  caption: [Comparison between freshly calculated concentrations and other sources using a scatter plot for correlation visualization, showing strong linear correlation between the sources],
) <concentration-sources-comparison-plot>

#figure(
  rect(inset: 0.5cm, scale(85%, visualize-calculation-paths(
  ), reflow: true)),
  caption: [Diagram of the different calculation paths for the total chlorophyll concentration in fresh weight],
  placement: bottom
) <calculation-paths-diagram>

The different calculation paths are visualized in @calculation-paths-diagram. It shows the different steps of the calculation process and the different sources of data used. It especially highlights the difference between individual concentrations used for the freshly calculated concentrations and filled out concentrations paths.



==== Filled out & freshly calculated <filled-out-vs-freshly-calculated-comparison>

There is almost no difference between the filled out and freshly calculated concentrations. @filled-out-vs-freshly-calculated-plot shows that there is only one entry with a difference of $tilde 1"mg"slash"g"$ between the two values. This discrepancy is likely due to an error in writing down the concentration values on the results sheet, rather than a systematic calculation error, as the difference is isolated to a single data point and not significant enough to indicate a fundamental issue with the calculation methodology itself.

Furthermore, @concentration-sources-comparison-plot implies a strong linear correlation between the filled out and freshly calculated concentrations, with a correlation coefficient of $#(calc.round(digits: 6, empiric-corr(groups-results-addedformula-concentration.map(it => it.concentration_freshweight), groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight))))$, which is very close to $1$, supporting this observation. It shows, that there was little error in the group individual calculations, as the filled out concentrations are very close to the freshly calculated concentrations.

#figure(
  rect(inset: 0.5cm, plot-filled-out-vs-freshly-calculated(
    groups-results-addedformula-concentration.map(it => it.concentration_freshweight),
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
  )),
  caption: [Comparison between filled out concentrations and freshly calculated concentrations],
) <filled-out-vs-freshly-calculated-plot>



==== Direct $652"nm"$ formula & freshly calculated

The instructor's formulas in @instructor-formula-equations  for calculating the total chlorophyll concentration describe, how to use the 652nm extinction coefficient for that purpose. @concentration-sources-comparison-plot shows the correlation between the freshly calculated concentrations and the concentrations calculated using the 652nm instructor's formula. There we can also see a strong linear correlation between the two sources, with a correlation coefficient of $#(calc.round(digits: 6, empiric-corr(groups-results-addedformula-concentration.map(it => it.total_instructor_mg_freshweight), groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight))))$.

#figure(
  rect(inset: 0.5cm, plot-652nm-instructor-vs-freshly-calculated(
    groups-results-addedformula-concentration.map(it => it.total_instructor_mg_freshweight),
    groups-results-addedformula-concentration.map(it => it.total_added_mg_freshweight),
  )),
  caption: [Comparison between 652nm instructor's formula and freshly calculated concentrations],
) <652nm-instructor-vs-freshly-calculated-plot>

@652nm-instructor-vs-freshly-calculated-plot shows that there is only a small difference between the two sources. Apart from the same outlier as in @filled-out-vs-freshly-calculated-comparison, there seems to be a positive offset in regards to the the $652"nm"$ formula. This offset seems to grow proportionally to the concentration and therefore classifies it as a fractional offset. 

Interestingly enough, at closer observation of @concentration-sources-comparison-plot, a strong correlation between the 652nm instructor's formula and the filled out concentrations is visible. Indeed, the correlation coefficient is $#(calc.round(digits: 6, empiric-corr(groups-results-addedformula-concentration.map(it => it.total_instructor_mg_freshweight), groups-results-addedformula-concentration.map(it => it.concentration_freshweight))))$, which is practically equivalent to $1$. 

All of the above observations lead us to conclude, that the instructor's formula is very precise, but has a certain constant percentile accuracy offset. Lowering the factor of $27.8 thin E_652$ by a nodge might result in a more accurate calculation (assuming the addition of $"Chl"_a$ and $"Chl"_b$ is the accurate baseline).

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
