#import "../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Hemiglobincyanide Method",
  subtitle: "Determination of Methemoglobin in Blood",
  author: "Tim Peko",
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "0.1",
  date: "2025-05-28",
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

== Hemoglobin

#block(width: 100%)[
  #block(width: 22.5%)[
    Hemoglobin $"Hb"$ (@hemoglobin-structure) is a vital oxygen-carrying protein found in red blood cells. It consists of four subunits:
    - 2x #math.alpha\-chains
    - 2x #math.beta\-chains

    Each chain contains a heme group with a central iron ion in the ferrous state $"Fe"^(2+)$, which is responsible for binding oxygen.
  ]
  #place(right + top)[
    #figure(
      image(
        "assets/hemoglobin_structure.png",
        width: 75%
      ),
      caption: "Structure of hemoglobin"
    ) <hemoglobin-structure>
  ]
]

== Methemoglobin

When the iron in $"Hb"$ is oxidized to the ferric state $"Fe"^(3+)$, it forms methemoglobin $"MetHb"$, which cannot bind oxygen and therefore cannot participate in oxygen transport.

The oxidation of $"Hb"$ to $"MetHb"$ is a normal process, but the human body tries to keep the amount of $"MetHb"$ at $< 1%$  of the total $"Hb"$. Enzymes in red blood cells (like NADPH methemoglobin reductase) continuously reduce the iron back to $"Fe"^(2+)$ to regenerate functional hemoglobin. However, if someone is exposed to certain oxidizing agents (for example, nitrates in well water, benzocaine, or dapsone), the rate of $"Fe"^(2+) arrow "Fe"^(3+)$ conversion can overwhelm the repair enzymes.

#figure(
  image(
    "assets/methemoglobin_cycle.png",
    width: 95%
  ),
  caption: "Methemoglobin regeneration cycle"
) <methomoglobin-cycle>

The result is methemoglobinemia, where a significant fraction of hemoglobin is stuck in the $"Fe"^(3+)$ form. Blood with high methemoglobin turns a chocolate-brown color and can cause symptoms of hypoxia (like cyanosis, fatigue or even neurological symptoms at very high levels)

== Hemiglobincyanide Method

To measure the concentration of hemoglobin in blood samples, one reliable laboratory method is the hemiglobincyanide $"HiCN"$ method, also known as the cyanmethemoglobin method. This technique converts all forms of hemoglobin (except sulfhemoglobin) into a single, stable colored complex, cyanmethemoglobin = hemiglobincyanide, which can be measured photometrically. This approach is recommended by the World Health Organization (WHO) due to its high accuracy and reproducibility.

The conversion is achieved using Drabkin's reagent, which contains potassium ferricyanide $"K"_3"Fe(CN)"_6$ and potassium cyanide $"KCN"$. @drabkin-reaction describes: The ferricyanide oxidizes hemoglobin to $"MetHb"$, and the cyanide then binds to $"MetHb"$ to form $"HiCN"$.

  $
    "Hb" + upright("K")_3 "Fe"^(3+)("CN")_6 + upright("K")^+ &arrow "MetHb" + upright("K")_4 "Fe"^(2+)("CN")_6 \
    "MetHb" + "KCN" &arrow "HiCN" + upright("K")^+
  $ <drabkin-reaction>

The resulting $"HiCN"$ complex is stable and has a specific absorbance peak at wavelengths around $540 - 546"nm"$. This property allows for photometric measurement of hemoglobin concentration using a spectrophotometer. Finally the hemoglobin concentration is determined based on the Beer–Lambert law, shown in @beer-lambert-law.

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

An alternative method for hemoglobin determination is the Reflotron system, a point-of-care device that uses dry reagent strips and reflectance photometry. A drop of whole blood is applied to a test strip, and the device measures the color intensity reflected from the strip to calculate hemoglobin concentration. While the Reflotron provides rapid and user-friendly results, the $"HiCN"$ method remains the gold standard due to its accuracy and standardization.

#pagebreak()
= Procedure

Due to unfortunate circumstances, the Reflotron during our lab session was defect and therefore no test data using that method could be collected. As a result, this chapter only covers the hemiglobincyanide method.

== Materials

- Fresh blood sample (capillary or venous)
- Drabkin’s reagent (contains K₃Fe(CN)₆ and KCN)
- Spectrophotometer with a 546 nm filter
- Cuvettes
- Pipettes and tips
- Parafilm
- Reagent tubes
- Gloves, lab coat, protective eyewear

== Safety Notes

Always wear gloves and handle blood as a biohazard.

Drabkin's reagent contains potassium cyanide, a highly potent neurotoxin. Prevent inhalation or other absorbtion of the substance. Be mindful of proper wastedisposal.

== Steps

Label two reagent tubes: one for the sample and one for the blank.

To the sample tube, add 5 mL of Drabkin’s reagent.

Add 20 µL of well-mixed blood to the reagent tube. Seal with Parafilm.

Gently invert the tube several times to mix. Incubate for at least 5 minutes in the dark to allow full conversion to cyanmethemoglobin.

Prepare a blank by adding 5 mL of Drabkin’s reagent to a second cuvette (no blood).

Transfer the reacted blood-reagent mixture into a cuvette.

Set the spectrophotometer to 546 nm. Zero the device using the blank.

Insert the sample cuvette and record the absorbance (E₅₄₆).

Optionally, measure a calibration standard of known hemoglobin concentration to ensure accuracy.

If available and functional, apply 30 µL of whole blood to a Reflotron Hb test strip and insert it into the Reflotron device. Record the result.

== Calculation of Hemoglobin Concentration

Using the Beer-Lambert law from @beer-lambert-law we formulate:

$ c" "["mol"slash L] = A/(epsilon times ell) $

Plugging in the values for\
$epsilon = 44 000  L/"mol""cm"$

Where:

A is the absorbance (measured at 546 nm)

ε is the molar absorptivity of HiCN (ε = 44,000 L/mol·cm)
gabriel
l is the path length of the cuvette (usually 1 cm)

c is the concentration in mol/L

To convert absorbance directly to hemoglobin concentration in g/dL, the following derived formula is used:

c [g/dL] = E₅₄₆ × 14.746

This formula accounts for the extinction coefficient, the dilution factor, and the molecular weight of hemoglobin (64,458 g/mol). All variables are pre-included based on a standard 1:251 dilution and a 1 cm path length.

Example calculation (placeholder values):

E₅₄₆ = 0.52

Hb = 0.52 × 14.746 = 7.67 g/dL

#pagebreak()
= Results



#pagebreak()
#set heading(numbering: none)
= Appendix

== Sources

#let source(title, url, date) = [
  + "#title" at #link(url) (#date)
]

#source("Hemoglobin - Wikipedia", "https://en.wikipedia.org/wiki/Hemoglobin", "2025-05-26")
#source("Cyanmethemoglobin Method For The Estimation Of Hemoglobin", "https://laboratorytests.org/cyanmethemoglobin-method/", "2025-05-26")
#source("Methemoglobinemia - Wikipedia", "https://en.wikipedia.org/wiki/Methemoglobinemia", "2025-05-26")
#source("Hemoglobin and its measurement", "https://acutecaretesting.org/en/articles/hemoglobin-and-its-measurement", "2025-05-26")
#source("[PDF] Drabkin's Reagent (D5941) - Datasheet - Sigma-Aldrich", "https://www.sigmaaldrich.com/deepweb/assets/sigmaaldrich/product/documents/139/718/d5941dat.pdf?srsltid=AfmBOoru-9lYL7u5ha3B3y4N6n8y0q4yk6dqfKOusmH2VnBURns0na9F", "2025-05-26")
#source("Reflotron®", "https://photos.labwrench.com/equipmentManuals/11023-6349.pdf", "2025-05-26")
#source("Low Hemoglobin: Causes, Signs & Treatment", "https://my.clevelandclinic.org/health/symptoms/17705-low-hemoglobin", "2025-05-26")



