#import "../../templates/protocol.tpl.typ": bio-template

#show: bio-template.with(
  show-cover-page: true,
  title: "Lipase Activity in Milk",
  subtitle: "Hydrolysis of Milk Fat by Pancreatic Lipase",
  author: "Tim Peko",
  course: "PHS2",
  semester: "SS 2025",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* / *#total*
  ],
  version: "1.0",
  date: "2025-07-15",
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

== Milk Fat and Digestion

Milk is an oil-in-water emulsion: fat is present as microscopic globules coated by a protein-phospholipid membrane (the milk fat globule membrane, MFGM). Typical cow's milk contains about 3-4% lipids (mostly triacylglycerols), with hundreds of different fatty acids; roughly 11% of these are short-chain acids (≈C4-C10), almost half of which is butyric acid. In vivo, many short and medium-chain fatty acids from milk are absorbed directly by intestinal cells and shuttled via the portal blood to the liver for metabolism, often without needing full luminal hydrolysis. However, pancreatic lipase (the digestive enzyme from the pancreas) normally cleaves dietary triglycerides into glycerol and free fatty acids. In our test-tube model, the very fine dispersion of milk fat globules (large surface area) and the presence of many short-chain glycerides make milk an excellent substrate for rapid enzymatic hydrolysis. When lipase acts on milk fat, it releases free fatty acids (and glycerol), acidifying the mixture.

== Principle of the Indicator

The experiment uses phenolphthalein indicator in an alkaline milk solution. Phenolphthalein is pink in sufficiently alkaline solutions (around pH 10-12) and turns colorless when the pH falls below about 8.3. By adding a measured amount of NaOH to the milk (turning it pink), we create an initial alkaline condition. As active lipase cleaves triglycerides to free fatty acids, the pH of the mixture drops. This produces a visible color change from pink toward colorless once pH drops below the indicator threshold. In effect, the duration until loss of pink color (and the pH-versus-time curve) reports the rate of lipase action: rapid acid release will quickly neutralize the base, whereas no acid release (or slow release) will keep the solution pink longer.

== Experimental Rationale

This protocol demonstrates the fundamental principle that pancreatic lipase cleaves milk triglycerides to free fatty acids and glycerol, and that free fatty acids cause a measurable drop in pH (observed via phenolphthalein) when hydrolysis occurs. The contrast with boiled (inactive) enzyme and with low-fat milk reinforces the roles of enzyme activity and substrate availability. The experiment models intestinal fat digestion in vitro, showing that only active lipase can catalyze the reaction, and that more substrate (fat) yields more acid for neutralization.

#pagebreak()
= Experimental Setup

== Materials

- Pipettes
- Test tubes
- Water bath (37 °C)
- pH meter
- Milk (3.5% fat, and optionally low-fat milk)
- 1M NaOH
- Pancreatic lipase
- 1% phenolphthalein solution
- 0.9% NaCl solution

== Safety Notes

- *NaOH is a strong base. Wear goggles and gloves.*
- *When boiling enzyme solution, point the tube away from yourself and others. Boiling may cause splattering.*

== Preparation

+ Dissolve 50 mg of pancreatic lipase in 10 mL of 0.9% NaCl (shake for 10 min, then let settle).
+ Boil 2 mL of this solution in a test tube using a clamp and Bunsen burner. Allow to cool.

== Setup

Label two test tubes (Tube 1 and Tube 2). For each:
- 5 mL whole milk (≈3.5% fat)
- #sym.tilde\2 drops 1% phenolphthalein indicator solution
- #sym.tilde\50 μL 1M NaOH (until pink)

Mix gently. The NaOH will alkalize the mixture, turning it pink. Measure and record the initial pH (should be strongly alkaline, #sym.tilde\pH 10-12).

Add:
- Tube 1: 200-500 μL boiled (inactivated) lipase solution
- Tube 2: same amount of unboiled (active) lipase solution

Record the exact volumes added and measure pH again.

Incubate both tubes at 37 #sym.degree\C in a water bath. Start timing. Continuously or periodically (e.g. at 30s, 1min, 5min, etc.) observe the color and measure the pH of each tube. The solution in Tube 2 (active enzyme) is expected to lose the pink color over time, while Tube 1 (denatured enzyme) should remain pink. Continue until the color change ceases (typically within 10-60min).

Repeat as needed: For comparison, repeat the experiment using low-fat milk (e.g. skim or 1% fat) and plot all pH-versus-time curves.

#pagebreak()
= Data Analysis & Results

== Descriptive Statistics

@table-desc-overall shows a clear difference between the two conditions. The mean pH drop for samples with active (unboiled) lipase was _1.70_, more than triple the mean drop of _0.53_ for samples with inactive (boiled) lipase. This strongly indicates that the enzymatic hydrolysis of milk fat was the primary driver of acidification.

#figure(
  table(
    columns: (1fr, 1.5fr, 1.5fr),
    align: center,
    table.header(
      [], [*Boiled (Inactive)*], [*Unboiled (Active)*]
    ),
    [Count], [65], [66],
    [Mean pH Drop], [0.53], [1.70],
    [Std. Deviation], [0.86], [1.73],
    [Min. pH Drop], [-0.87], [-0.42],
    [Max. pH Drop], [4.65], [10.01],
  ),
  caption: [Overall descriptive statistics for the total pH drop. Values are rounded to two decimal places.]
) <table-desc-overall>

@table-desc-menge breaks down the pH drop by the amount of enzyme solution added. While the ANOVA test did not find a statistically significant effect, this table reveals a weak trend: larger volumes of unboiled lipase tend to correspond to a greater average pH drop. For instance, the mean drop for 200 #sym.mu\L was 1.42, while for 600 #sym.mu\L it was 3.30. The high standard deviation in each group likely contributed to the non-significant ANOVA result.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    table.header(
      [*Menge (µL)*], [*Group*], [*N*], [*Mean Drop*], [*Std. Dev.*], [*Max Drop*]
    ),
    table.cell(rowspan: 2)[200], [Boiled], [11], [0.62], [1.04], [3.67],
    [Unboiled], [12], [1.42], [2.74], [10.01],
    table.cell(rowspan: 2)[350], [Boiled], [18], [0.46], [0.60], [1.86],
    [Unboiled], [18], [0.91], [0.85], [2.66],
    table.cell(rowspan: 2)[400], [Boiled], [3], [0.44], [0.12], [0.55],
    [Unboiled], [3], [2.11], [1.38], [3.44],
    table.cell(rowspan: 2)[500], [Boiled], [25], [0.57], [1.11], [4.65],
    [Unboiled], [25], [2.01], [1.55], [4.70],
    table.cell(rowspan: 2)[600], [Boiled], [3], [0.49], [0.29], [0.80],
    [Unboiled], [3], [3.30], [1.98], [4.63],
  ),
  caption: [Descriptive statistics for pH drop grouped by enzyme volume. Statistics for amounts with fewer than 3 samples were omitted for brevity. Values are rounded.]
) <table-desc-menge>

== Visual and Statistical Interpretation

The average pH change over time is visualized in @fig-avg-ph. The curve for the active enzyme shows a clear, steady decline, while the boiled enzyme's curve remains nearly flat. A paired t-test confirms this observation with a highly significant result (p < 0.0001), validating that active lipase is responsible for the acidification.

#figure(
  image("assets/plots/average_ph_verlauf.png", width: 80%),
  caption: [Smoothed average pH vs. time for all groups, comparing boiled (inactive) and unboiled (active) lipase.]
) <fig-avg-ph>

The plots in @fig-vergleich-menge illustrate the effect of enzyme concentration. For active lipase, larger amounts show a trend towards a faster pH drop. An ANOVA test, however, found this trend not to be statistically significant (p = 0.20), likely due to the high inter-experiment variability visible in the plot. The boiled lipase shows no dose-dependent effect.

#figure(
  grid(
    rows: (auto, auto),
    gutter: 1em,
    image("assets/plots/vergleich_ungekocht_nach_menge.png", width: 90%),
    image("assets/plots/vergleich_gekocht_nach_menge.png", width: 90%),
  ),
  caption: [Comparison of smoothed pH drop over time, grouped by enzyme amount.\
  *Top:* Unboiled (active) lipase. \
  *Bottom:* Boiled (inactive) lipase.]
) <fig-vergleich-menge>

An individual group's plot, like the one in @fig-group-example, shows the raw data behind the averages, capturing the real-time progress of the experiment.

#figure(
  image("assets/plots/MBI24_Gr1_Gruppe_A.png", width: 80%),
  caption: [Example of a pH vs. time plot for a single experimental group (MBI24, Group 1A).]
) <fig-group-example>

== Statistical Tests

To validate these observations, two main statistical tests were performed:

1.  *Paired T-Test (Active vs. Inactive Lipase):*
    A paired t-test was used to compare the pH drop between the unboiled and boiled samples from the same experimental run. The test yielded a _p-value of 7.56 x 10⁻⁶_, which is far below the standard significance level of 0.05. This result is *highly statistically significant* and confirms that the active, unboiled lipase produces a much greater pH drop than the denatured, boiled lipase.

2.  *ANOVA (Effect of Enzyme Amount):*
    An ANOVA test was conducted to determine if the amount of lipase added (from 200 #sym.mu\L to 600 #sym.mu\L) had a statistically significant effect on the magnitude of the pH drop. The p-value from this test was _0.20_. Since this value is greater than 0.05, we conclude that there is *no statistically significant difference* in the pH drop between the different amounts of enzyme used in this set of experiments. While a trend is visible in the data and plots, the high variability in the data prevented this trend from being statistically significant.

#pagebreak()
= Conclusion

This experiment successfully demonstrated that pancreatic lipase actively hydrolyzes triglycerides in milk, leading to a release of free fatty acids and a measurable drop in pH. The difference in activity between unboiled (active) and boiled (denatured) lipase was statistically highly significant. This confirms that the observed effect is due to the enzyme's catalytic function.

While there was a visible trend suggesting that a higher concentration of lipase leads to a faster reaction, this effect was not statistically significant across the tested range (200-500 µL), likely due to high variability between individual experiments. Overall, the experiment provides a clear and effective model for enzymatic fat digestion.
#pagebreak()
#set heading(numbering: none)
= Appendix

== Sources

#let source(title, url, date) = [
  #set par(justify: false)
  + "#title" at #link(url) (#date)
]

#source("Roles of Milk Fat Globule Membrane on Fat Digestion and Infant Nutrition - PMC", "https://pmc.ncbi.nlm.nih.gov/articles/PMC9108948/", "2025-07-10")
#source("Fatty acids in bovine milk fat - PubMed", "https://pubmed.ncbi.nlm.nih.gov/19109654/", "2025-07-10")
#source("Short- and medium-chain fatty acids in energy metabolism: the cellular perspective - PMC", "https://pmc.ncbi.nlm.nih.gov/articles/PMC4878196/", "2025-07-10")
#source("Biochemistry, Lipase - StatPearls - NCBI Bookshelf", "https://www.ncbi.nlm.nih.gov/books/NBK537346/", "2025-07-10")
#source("Free fatty acid profiles of emulsified lipids during in vitro digestion with pancreatic lipase - PubMed", "https://pubmed.ncbi.nlm.nih.gov/23561123/", "2025-07-10")
#source("wjec.co.uk", "https://www.wjec.co.uk/media/vithrt5f/tg07in-1.pdf", "2025-07-10")



