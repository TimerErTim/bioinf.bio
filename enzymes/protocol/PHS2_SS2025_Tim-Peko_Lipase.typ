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

In this section, we analyze the collected data from multiple experimental runs to draw comprehensive, data-driven conclusions about lipase activity.

== Descriptive Statistics

The primary metric for this analysis is the total pH drop (initial pH - final pH). A larger drop indicates greater acid production and, therefore, higher enzyme activity.

@table-desc-overall summarizes the findings for all experimental groups combined. The mean pH drop for the active lipase samples was _1.70_, more than triple the mean drop of _0.53_ for the inactive (boiled) samples. This provides strong initial evidence of enzymatic activity.

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

== Visualizations and Statistical Interpretation

The plot of the average pH over time for all groups (@fig-avg-ph) clearly visualizes the conclusion from our t-test. The curve for the unboiled enzyme shows a steady decline, indicating continuous acid production, while the boiled enzyme's curve remains nearly flat, confirming its inactivity.

#figure(
  image("assets/plots/average_ph_verlauf.png", width: 80%),
  caption: [Smoothed average pH vs. time for all groups, comparing boiled (inactive) and unboiled (active) lipase.]
) <fig-avg-ph>

The plots in @fig-vergleich-menge illustrate the dose-response relationship, or lack thereof. For the unboiled enzyme, there is a visible trend where larger amounts of lipase lead to a faster and deeper pH drop. The plot for the boiled enzyme shows no such trend, with all lines clustered together. This visual evidence supports the ANOVA result: while a trend exists for the active enzyme, the high variance within each group prevents the differences from being statistically significant.

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

1.  **Paired T-Test (Active vs. Inactive Lipase):**
    A paired t-test was used to compare the pH drop between the unboiled and boiled samples from the same experimental run. The test yielded a **p-value of 7.56 x 10⁻⁶**, which is far below the standard significance level of 0.05. This result is **highly statistically significant** and confirms that the active, unboiled lipase produces a much greater pH drop than the denatured, boiled lipase.

2.  **ANOVA (Effect of Enzyme Amount):**
    An ANOVA test was conducted to determine if the amount of lipase added (from 200 µL to 600 µL) had a statistically significant effect on the magnitude of the pH drop. The p-value from this test was **0.20**. Since this value is greater than 0.05, we conclude that there is **no statistically significant difference** in the pH drop between the different amounts of enzyme used in this set of experiments. While a trend is visible in the data and plots, the high variability in the data prevented this trend from being statistically significant.

#pagebreak()
= Expected Results & Discussion

- *Active vs. Denatured Lipase:* Tube 2 (with active lipase) should show a gradual color change from pink toward colorless as fatty acids accumulate. Correspondingly, the pH will fall steadily over time. Our analysis confirms this with high statistical confidence (p < 0.0001), showing an average pH drop of *1.70* for active lipase compared to only *0.53* for the inactive enzyme (see @table-desc-overall). Tube 1 (boiled lipase) should remain pink with little or no pH change, since heat inactivation destroys the enzyme's catalytic site. This confirms that the color change and pH drop depend on enzyme activity.
- *pH vs. Time Plot:* Plotting pH against time for each tube yields a flat line for the boiled-enzyme control and a falling curve for the active-enzyme sample, as clearly shown in @fig-avg-ph. The curve typically shows a rapid initial drop as many short-chain esters are cleaved quickly, then it may level off as substrate or base is depleted.
- *Effect of Milk Fat Content:* With regular whole milk (3-4% fat), a larger amount of fatty acids is released than with low-fat milk. Thus, the pH drop in the whole-milk sample should be more pronounced and occur faster than in the low-fat sample. In low-fat milk the reaction may slow sooner and may not reach as low a pH. This directly reflects that more substrate (fat) yields more acid for neutralization.
- *Mechanism Confirmation:* These observations align with the known behavior of lipase: it hydrolyzes triglycerides at the oil-water interface. Milk's tiny fat droplets (with protective MFGM) nonetheless allow rapid enzyme access. Pancreatic lipase digests short-chain triglycerides much faster than long-chain ones, so the short-chain-rich milk fat is hydrolyzed efficiently in vitro. The released free fatty acids are weak acids, so as they accumulate they neutralize the added NaOH, lowering pH. Phenolphthalein, which turns colorless below pH #sym.tilde\8.3, signals this acidification.
- *Graphical Interpretation:* The expected graph has a steep decline of pH in the active lipase tube (@fig-avg-ph and @fig-vergleich-menge), crossing the phenolphthalein threshold (≈8.3) at some point, whereas the boiled-lipase control remains near the initial high pH. Comparing curves for different milk fat levels or enzyme amounts can illustrate the kinetics. Our analysis of enzyme amount showed no statistically significant effect on the final pH drop, suggesting that within the tested range (200-600 µL), the enzyme concentration might not have been the limiting factor, or the experimental variability was too high to detect a significant effect.
- *Relation to Physiology:* Although the experiment is in vitro, it models intestinal fat digestion. In the body, the free fatty acids generated would be absorbed by enterocytes (especially the short/medium-chain ones) and sent to the liver. Pancreatic lipase is the main enzyme for dietary fat breakdown, and our controls show that denatured enzyme is inactive.

In summary, this protocol demonstrates the fundamental principle that pancreatic lipase cleaves milk triglycerides to free fatty acids and glycerol, and that free fatty acids cause a measurable drop in pH (observed via phenolphthalein) when hydrolysis occurs. The contrast with boiled (inactive) enzyme and with low-fat milk reinforces the roles of enzyme activity and substrate availability.

#pagebreak()
= Summary & Discussion

- Summarize your observations: How did pH change over time in each tube?
- Was there a difference between boiled and unboiled enzyme?
- How did low-fat milk compare to regular milk?
- Discuss possible sources of error and compare with other groups.

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



