#import "../../templates/protocol.tpl.typ": bio-template, new-chapter

#set document(
  title: "Isolation von genomischer DNA",
  author: ("Tim Peko", "Nathalie Sonnleitner"),
  description: "Konzentrations- und Längenbestimmung von verschiedenen Proben",
  date: datetime.today(),
)
#show: bio-template.with(
  show-cover-page: true,
  subtitle: context document.description,
  author: none,
  members: ("Tim Peko", "Nathalie Sonnleitner"),
  course: "BLT4",
  semester: "SS 2026",
  language: "de",
  format-page-counter: (current, total) => [
    Seite #current / #total
  ],
  version: "0.1",
  date: context document.date.display("[day].[month].[year]"),
)
#show link: it => {
  set text(fill: blue)
  underline(it)
}

#heading(depth: 1, outlined: false)[Inhaltsverzeichnis]

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
#show figure: set rect(stroke: 0.5pt)
#show figure: set place(clearance: 2em)
#set figure(placement: auto)

#import "deps.typ": *
#import "../analysis/processing.typ": *

#new-chapter[Einleitung]

== Ziele

Die Ziele des protokollierten Experiments können wiefolgt zusammengefasst werden:

+ #[
    *Isolierung*:
    Die Extraktion genomischer DNA aus tierischem Gewebe (Schweineleber) und bakteriellen Kulturen (E. coli).
  ]
+ #[
    *RNase-Verdau*:
    Nachweis des RNA-Abbaus durch den Einsatz von RNase mittels Photometrie und Auswertung des Bandenmusters in der Gelelektrophorese.
  ]
+ #[
    *Konzentrationsbestimmung*:
    Photometrische Messung der isolierten DNA, um die Konzentration und Reinheit zu beurteilen.
  ]
+ #[
    *Restriktionsenzym-Verdau*:
    Einsatz von Restriktionsenzymen, um Qualität zu beurteilen und die Länge der Fragmente zu bestimmen.
  ]

== Theorie

=== Genomarchitektur und Unterschiede zwischen Proben

Wie die DNA-Extraktion abläuft, hängt davon ab, ob man mit tierischen oder bakteriellen Zellen arbeitet. Die genomische DNA (gDNA) findet man in der Zelle nicht einfach frei schwimmend, sondern sie ist mit Proteinen verbunden und von Zellhüllen umgeben. @src_molecular-biology-of-the-cell

- *Eukaryotische DNA (Schweineleber)*: Das Genom der Schweineleberzellen (etwa 2,8 Milliarden Basenpaare, 38 Chromosome) ist stark gepackt, weil es um spezielle, positiv geladene Proteine (Histone) gewickelt ist, wodurch Chromatin entsteht. @src_molecular-biology-of-the-cell Außerdem enthalten Leberzellen sehr viel RNA, vor allem rRNA und mRNA. Aufgrund der hohen Stoffwechselaktivität kann der Anteil bis zu 80-90 % der Nukleinsäuren ausmachen. @src_lodish-molecular-cell-biology Deshalb braucht man Proteine abbauende Enzyme wie Proteinase K, um die Histone zu entfernen. Für den Abbau der RNA gibt man RNase dazu. Eine zu erwartende Ausbeute beträgt 3-4 mg DNA pro Gramm Leber. @src_csh-protocols-isolation

- *Prokaryotische DNA (E. coli)*: Bei Bakterien wie E. coli liegt die DNA als ringförmiges Chromosom ohne Histone vor und ist durch Supercoiling kompakter gemacht. @src_brock-mikrobiologie Das größte Problem bei der Extraktion ist die Zellwand. E. coli besitzt als gramnegatives Bakterium eine dicke äußere Schicht aus Lipopolysacchariden (LPS), die das Enzym Lysozym daran hindern kann, die Zellwand aufzubrechen. Erst wenn diese äußere Schicht zum Beispiel mit Hilfe von EDTA gestört wird, kann die darunterliegende Mureinschicht angreifbar werden. Bleibt sie intakt, klappt die Lyse nicht und es kann keine DNA extrahiert werden. @src_csh-bacterial-cell-envelope

=== Photometrie <photometrie-theorie>

$
  E_lambda = sum_(i=1)^n epsilon_(i, lambda) dot c_i space.thin underbrace(cancel(dot d), bold(1)"cm")
$ <beer-lambert-equation>

@beer-lambert-equation zeigt die Beziehung zwischen der Extinktion $E_lambda$ bei einer bestimmten Wellenlänge $lambda$ und der Konzentration $c_i$ der $n$ verschiedenen Komponenten indiziert mit $i$. Die Extinktionskoeffizienten $epsilon_(i, lambda)$ sind spezifisch für jede Komponente und Wellenlänge. @src_wikipedia-molar-extinction-coefficient

Bei doppelsträngiger DNA gilt der lineare Zusammenhang $E_260 = 1.0 => "dsDNA" = 50 space upright(mu"g/ml")$. @src_dna-spektrum_img

#{
  show: figure.with(
    caption: [Spektrum von Nukleinsäuren und üblichen Verunreinigungen. @src_dna-spektrum_img],
  )
  image("../assets/dna-spektrum.png", width: 100%)
} <dna-spektrum-img>

@dna-spektrum-img zeigt ein illustratives Spektrum der verschiedenen üblichen Komponenten einer isolierten Nukleinsäureprobe. Dabei lassen sich wichtige Quotienten zur Beurteilung der Reinheit der Probe formulieren:

*Der 260/280-Quotient (Protein-Kontamination)*\
Dieser Quotient ist der Standardwert zur Überprüfung der DNA- und RNA-Reinheit gegenüber Proteinen. Ein Verhältnis von etwa 1,8 wird allgemein als Indikator für reine DNA akzeptiert. Abweichende, niedrigere 260/280-Verhältnisse weisen in der Regel darauf hin, dass die Probe entweder durch Proteine oder durch Reagenzien wie Phenol verunreinigt ist. @src_assessment-of-nucleic-purity

Da DNA bei 260 nm im Vergleich zu Proteinen bei 280 nm extrem stark absorbiert, kann selbst eine Probe mit einem akzeptablen 260/280-Wert noch erhebliche Mengen an Proteinverunreinigungen enthalten, bevor der Quotient massiv abfällt. @src_assessment-of-nucleic-purity

*Der 260/230-Quotient (Salze und organische Lösungsmittel)*\
Dieser Wert dient als sekundäres Maß für die Reinheit von Nukleinsäuren und reagiert sensibel auf Rückstände aus den Extraktionspuffern. Für reine Nukleinsäuren werden allgemein 260/230-Werte im Bereich von 2,0 bis 2,2 erwartet. Der 260/230-Quotient wird verwendet, um die Anwesenheit unerwünschter organischer Verbindungen wie Phenol, Guanidinhydrochlorid und Guanidinthiocyanat anzuzeigen. Verunreinigungen durch diese Chemikalien zeigen eine starke Absorption bei 230 nm oder darunter, was den 260/230-Quotienten drastisch senkt. @src_assessment-of-nucleic-purity


#{
  show: figure.with(
    caption: [Extinktionskoeffizienten von dsDNA, Proteinen und Phenolen. Referenzen von Gemini 3.1 Pro. Sollen ein grobes Gefühl der Verhältnisse geben.],
  )
  table(
    columns: 4,
    table.header[
      *Substanz*
    ][
      *Wert bei 230 nm*
    ][
      *Wert bei 260 nm (DNA-Peak)*
    ][
      *Wert bei 280 nm (Protein-Peak)*
    ],
    [dsDNA], [≈10,0], [20,0], [≈11,1],

    [Proteine (BSA)], [≈2,0 bis 3,0], [≈0,4], [0,66],
    [Phenol], [Sehr hoch (>100)], [≈15,0], [≈12,5],
  )
}

=== Gelelektrophorese <gelelektrophorese-theorie>

Die Gelelektrophorese ist eine zentrale Methode zur Trennung und Analyse von DNA-Fragmenten. Grundlage dieses Verfahrens ist, dass DNA aufgrund ihrer negativ geladenen Phosphatgruppen in einem elektrischen Feld wandert. Durch das Gel (meist aus Agarose) werden die DNA-Fragmente unterschiedlich stark aufgehalten.
@src_thermo-fischer-gelelectro

*Der Trennmechanismus (Siebeffekt)*\
Da die Ladung der DNA proportional zu ihrer Länge (Anzahl der Basenpaare) zunimmt, ist das Verhältnis von Ladung zu Masse für alle DNA-Moleküle konstant. Würden sie im freien Wasser wandern, wären alle DNA-Stücke gleich schnell. @src_thermo-fischer-gelelectro

Agarose ist ein Polysaccharid, das beim Abkühlen ein dreidimensionales Porennetzwerk bildet. Während die DNA zur Anode wandert, zwängt sie sich durch dieses Gel-Netzwerk. Dabei wirkt eine Reibungskraft, die der elektrischen Kraft entgegenwirkt:
- _Kleine DNA-Fragmente_ chlüpfen leicht durch die Poren und wandern sehr schnell.
- _Große DNA-Fragmente_ bleiben in den Poren hängen, verheddern sich und wandern sehr langsam.

@src_thermo-fischer-gelelectro

#{
  show: figure.with(
    caption: [Bandenmuster bei der Gelelektrophorese. @src_gelelektro-illustr_img],
  )
  set rect(inset: 0pt)
  image("../assets/gelelktro-illustr.png", width: 100%)
} <gelelektro-illustr-img>

Dieser "Siebeffekt" sorgt dafür, dass die DNA-Moleküle logarithmisch, wie in @gelelektro-illustr-img zu sehen, nach ihrer Größe sortiert werden. Ein Abstand zwischen 1000 bp und 2000 bp ist viel größer als der Abstand zwischen 10000 bp und 11000 bp.
@src_thermo-fischer-gelelectro

=== Typ-II-Restriktionsenzyme <restr-enzyme-theorie>

Ursprünglich entwickelten Bakterien Restriktionsenzyme zur Abwehr von eindringender Virus-DNA. Heute sind sie für das Labor äußerst wertvoll, weil sie zwei praktische Eigenschaften besitzen, die in Typ-I- oder Typ-III-Enzymen so nicht vorhanden sind: @src_neb-typ2-restr-enzyme
+ _Erkennung_: Bindung an spezifische DNA-Sequenzen, meist 4-8 Basenpaare lang. Meistens handelt es sich um Palindromstrukturen#footnote[Am Gegenstrang in 5' #sym.arrow 3' Richtung gleich]. EcoRI: 5'-GAATTC-3' #math.underbrace(sym.arrow, [
    #show: box.with(height: 1em)
    #show: place.with(center)
    Gegenstrang
  ]) 3'-CTTAAG-5'
+ _Schnitt_: Die DNA wird zuverlässig innerhalb oder unmittelbar neben der Erkennungssequenz geschnitten.
@src_neb-typ2-restr-enzyme

#{
  show: figure.with(
    caption: [DNA kann mit molekularen „Scheren“, den Restriktionsenzymen, an definierten Stellen zerschnitten werden. Orange markiert ist die Stelle, welche von genau diesem Restriktionsenzym (es hat den Namen EcoRI) erkannt wird. @src_restr-enzyme-working_img],
  )
  image("../assets/restr-enzyme-working.png", width: 100%)
} <restr-enzyme-working-img>

In @restr-enzyme-working-img werden zwei _Sticky Ends_ erzeugt. Die dadurch entstehenden, einzelsträngigen Überhänge erleichtern aufgrund der Wasserstoffbrückenbindungen die Verknüpfung mit anderen komplementären DNA-Strängen. _Blunt Ends_ besitzen diese Übergänge nicht und entstehen durch Schneiden in Mitte der Erkennungssequenz. @src_neb-typ2-restr-enzyme

== Relevanz

Für Standard-PCRs genügen oft einfache Extrakte. Moderne Anwendungen wie Next-Generation Sequencing erfordern jedoch hochmolekulare und extrem reine gDNA. Verunreinigungen durch Proteine oder Phenole/Salze (siehe @photometrie-theorie) hemmen die empfindlichen Polymerasen der Sequenziergeräte, während RNA-Reste zu fehlerhaften Daten bei der Genom-Assemblierung führen können. @src_csh-protocols-isolation

#new-chapter[Durchführung]

#pdf.attach(
  "../instructions/Isolierung.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe für die Isolation von genomischer DNA",
)

Nachfolgend wird die im Labor durchgeführte Vorgehensweise erläutert. Die Durchführung basiert auf den Angaben im eingebeddeten Angabendokument.

== Zellaufschluss

#{
  show: figure.with(
    caption: [Zelllyse unter Verwendung eines Detergens zum Öffnen der Zellmembran und Freisetzen der intrazellulären Bestandteile. @src_cell-lysis-img],
  )
  image("../assets/cell-lysis.png", width: 100%)
} <cell-lysis-img>

Um an die DNA im Inneren der Zellen zu kommen, müssen diese aufgebrochen werden. @cell-lysis-img zeigt das grundlegende Prinzip. Ein *Lysis-Puffer* bricht grundsätzlich die Zellmembran. Je nach Probentyp wird
- _bei Bakterien_ *Lysozym* eingesetzt, um die harte bakterielle Zellwand zu lösen.
- _bei dem Lebergewebe_ *Proteinase K* eingesetzt, Gewebeproteine zu verdauen und Zellen aufzulösen.

Ein Wasserbad bietet ideale Umgebungstemperatur für die Reaktionen.

== Reinigung


Mittels mehreren Reinigungsvorgängen mit
+ Phenol
+ Phenol/Chloroform/Isoamylalkohol
+ Chloroform\
werden zelluläre Proteine denaturiert. In @reinigung-na-img sammeln sich diese Proteine in einer Interphase, der wässrige Überstand enthält nun nur noch die genomische DNA.

#{
  show: figure.with(
    caption: [Reinigung von Nucleinsäuren unter Verwendung von Natriumacetat und Ethanol. @src_reinigung-na_img],
  )
  image("../assets/reinigung-na.png", width: 100%)
} <reinigung-na-img>

== Isolierung durch Fällung

Um die DNA zu lagern, wird sie mit *Natriumacetat* und hochprozentigem *Ethanol* gefällt. @rna-fällung-img zeigt, wie das neutralisierte DNA pellet in Isopropanol (gleiches Prinzip) ausflockt und sich am Boden des Behälters ansammelt. Die neutralisierte DNA ist in alkoholischen Lösungen nämlich unlöslich. Nach dem Entleeren des Überschuss wird das Pellet mit weniger hochprozentigem Ethanol (\~70%) vorsichtig gerineigt, um restliche Salze wegzuspülen. Gelagert wird die DNA Probe in einem *TE-Puffer*, worin das Pellet schonend aufgelöst wird.

#{
  show: figure.with(
    caption: [Extraktion und Reinigung von Nukleinsäuren mittels Fällung. @src_rna-fällung_img],
  )
  image("../assets/rna-fällung.png", width: 100%)
} <rna-fällung-img>

== Hinzugabe von RNase

Die zuvor gewonnene DNA wird in zwei Proben geteilt:
- _+RNase_: Mit Enzym behandelte DNA
- _-RNase_: Unbehandelte DNA

In den weiterführenden Schritten kann davon ausgegangen werden, dass nur die _+RNase_ Probe verwendet wird, wenn nciht näher spezifiziert.

== Photometer Messung

Verdünnung der extrahierten DNA (_+RNase_ & _-RNase_) in destilliertem *Wasser* um 1:100. Das reine Wasser wird auch als *Null-Referenz* verwendet. Die UV-Küvetten entsprechen der Standarddicke von 1cm.
@rnase-spectrum-measured-img und @nornase-spectrum-measured-img zeigen die gemessenen Spektren und lassen den Zusammenschluss der einzelnen Komponenten aus @dna-spektrum-img erkennen.

#place(auto, float: true, {
  show: pad.with(bottom: -1em)
  grid(
  columns: 2,
  gutter: 1em,
  align: top,
  {
    show: box
    show: it => [#it <nornase-spectrum-measured-img>]
    show: figure.with(caption: [Beispiel für das gemessene Spektrum bei einer Probe _-RNase_.])
    set rect(inset: 0pt)
    image("../assets/nathalie_raw_spektrum.png", width: 100%)
  },
  {
    show: box
    show: it => [#it <rnase-spectrum-measured-img>]
    show: figure.with(caption: [Beispiel für das gemessene Spektrum bei einer Probe _+RNase_.])
    set rect(inset: 0pt)
    image("../assets/nathalie_rnase_spektrum.png", width: 100%)
  },
)})

Die Bakterienproben wurden ein zweites Mal gemessen, weil die ersten Messwerte nicht plausibel waren.

== Restriktionsenzym-Verdau

Die DNA wird mit den in @table-restr-distr aufgeführten Restriktionsenzymen behandelt. Dazu wurde für jedes Enzym der entsprechende Standardpuffer verwendet. Diese sind beispielhaft in @table-restr-enzyme-sequences aufgeführt.

#{
  show: figure.with(
    caption: [Bekannte Zuteilung der Proben zu den Restriktionsenzymen. #text(fill: red)[L] = Leber, #text(fill: green)[B] = Bakterien.],
  )
  table(
    columns: 3,
    align: (right, center, center),
    table.header([*Enzym*], [*Alt*], [*Neu*]),
    ..for enzyme in restr-enzyme-distr-data.values().map(it => it.enzyme).dedup() {
      let person-has-liver(initials) = {
        initials in liver-weights-data
      }
      let found-old-person = restr-enzyme-distr-data.values().find(it => it.enzyme == enzyme and it.new_charge == false)
      let found-new-person = restr-enzyme-distr-data.values().find(it => it.enzyme == enzyme and it.new_charge == true)

      (
        [*#enzyme*],
        if found-new-person != none [
          #if person-has-liver(found-new-person.initials) {
            set text(fill: red)
            [L]
          } else {
            set text(fill: green)
            [B]
          }
        ] else [
          #sym.crossmark
        ],
        if found-old-person != none [
          #if person-has-liver(found-old-person.initials) {
            set text(fill: red)
            [L]
          } else {
            set text(fill: green)
            [B]
          }
        ] else [
          #sym.crossmark
        ],
      )
    },
  )
} <table-restr-distr>

#{
  show: figure.with(
    caption: [Erkennungssequenzen der verwendeten Restriktionsenzyme: EcoRI, NaeI, PstI. Bildquelle: #link("https://www.neb.com/")],
  )
  set rect(inset: 0pt)
  table(
    columns: 2,
    table.header([*Enzym*], [*Erkennungssequenz*]),
    [*EcoRI*], image("../assets/ecor-i.png", height: 5em),
    [*NaeI*], image("../assets/nae-i.png", height: 5em),
    [*PstI*], image("../assets/pst-i.png", height: 5em),
  )
} <table-restr-enzyme-sequences>

== Gelelektrophorese

Die Gelelektrophorese wird mit einem Agarosegel und einem DNA-Marker durchgeführt. Es wurden folgende Kombinationen an Proben verwendet:
+ *Leber*: _-RNase_, _+RNase_
+ *Bakterien*: _-RNase_, _+RNase_
+ *Leber* Restriktionsenzyme: _+RNase_

#new-chapter[Ergebnisse]

#pdf.attach(
  "../data/dna_photometrie.json",
  mime-type: "application/json",
  relationship: "data",
  description: "Photometrische Messwerte der DNA-Konzentrationen",
)
#pdf.attach(
  "../data/liver_weights.json",
  mime-type: "application/json",
  relationship: "data",
  description: "Gewichte der Leberproben",
)
#pdf.attach(
  "../data/restr_enzyme_distr.json",
  mime-type: "application/json",
  relationship: "data",
  description: "Zuteilung der Restriktionsenzyme zu Laboranten",
)

#let relevant-data = (
  ..photometrie-data.filter(it => it.sample_source == "Leber" and it.trial == 1),
  ..photometrie-data.filter(it => it.sample_source == "Bakterien" and it.trial == 2),
)

== Leberproben <leberproben>

What is rong with yo

#let table-photometrie-results(sample) = {
  table(
    columns: 2,
    align: left,
    ..(
      table.header(table.cell(colspan: 2, align: left)[*#sample.sample_source (#sample.trial\. Durchlauf)*]),
      table.header(level: 2)[*+RNase*][*-RNase*],
      ..for initials in (
        sample.with_rnase.measures.map(it => it.initials) + sample.without_rnase.measures.map(it => it.initials)
      ).dedup() {
        let with_rnase = sample.with_rnase.measures.find(it => it.initials == initials)
        let without_rnase = sample.without_rnase.measures.find(it => it.initials == initials)
        (
          ..for measurement in (if with_rnase != none { with_rnase }, if without_rnase != none { without_rnase }) {
            if measurement != none {
              (
                [
                  Konz: #calc.round(measurement.concentration, digits: 1) #sym.mu\g DNA/ml\
                  $E_260 slash E_280$ = #calc.round(measurement.cleaness_proteins, digits: 1)\
                  $E_260 slash E_230$ = #calc.round(measurement.cleaness_salts, digits: 1)\
                ],
              )
            } else {
              ([],)
            }
          },
        )
      },
    ),
  )
}

#{
  show: figure.with(caption: [Photometrische Messwerte und umgerechnete Konzentration aller Leberproben.])
  table-photometrie-results(relevant-data.find(it => it.sample_source == "Leber" and it.trial == 1))
} <table-photometrie-results-leber>



== Bakterienproben <bakterienproben>

#{
  show: figure.with(caption: [Photometrische Messwerte und umgerechnete Konzentration aller Bakterienproben.])
  table-photometrie-results(relevant-data.find(it => it.sample_source == "Bakterien" and it.trial == 2))
} <table-photometrie-results-bakterien>

#lorem(100)

== Statistik

#{
  show: figure.with(caption: [Beschreibende Statistik der DNA-Konzentrationen und Photometrie-Werte der DNA Proben.])
  table(
    columns: relevant-data.len() * 2 + 1,
    table.header(
      table.cell(rowspan: 2, stroke: none, fill: none)[],
      ..for sample in relevant-data {
        (
          table.cell(colspan: 2)[*#sample.sample_source (#sample.trial\. Durchlauf)*],
        )
      },
      ..for sample in relevant-data {
        (
          [\+ RNase],
          [\- RNase],
        )
      },
    ),
    [Konzentration],
    ..for sample in relevant-data {
      (
        [
          #calc.round(sample.with_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.with_rnase.stats.concentration.stddev, digits: 1)\ #sym.mu\g DNA/ml
        ],
        [
          #calc.round(sample.without_rnase.stats.concentration.mean, digits: 1) #sym.plus.minus #calc.round(sample.without_rnase.stats.concentration.stddev, digits: 1)\ #sym.mu\g DNA/ml
        ],
      )
    },
    [
      $E_260 slash E_280 approx space.thin ~1.8$
    ],
    ..for sample in relevant-data {
      (
        [
          #calc.round(sample.with_rnase.stats.cleaness_proteins.mean, digits: 1) #sym.plus.minus #calc.round(
            sample.with_rnase.stats.cleaness_proteins.stddev,
            digits: 1,
          )
        ],
        [
          #calc.round(sample.without_rnase.stats.cleaness_proteins.mean, digits: 1) #sym.plus.minus #calc.round(
            sample.without_rnase.stats.cleaness_proteins.stddev,
            digits: 1,
          )
        ],
      )
    },
    [
      $E_260 slash E_230 approx space.thin 2.0 - 2.2$
    ],
    ..for sample in relevant-data {
      (
        [
          #calc.round(sample.with_rnase.stats.cleaness_salts.mean, digits: 1) #sym.plus.minus #calc.round(
            sample.with_rnase.stats.cleaness_salts.stddev,
            digits: 1,
          )
        ],
        [
          #calc.round(sample.without_rnase.stats.cleaness_salts.mean, digits: 1) #sym.plus.minus #calc.round(
            sample.without_rnase.stats.cleaness_salts.stddev,
            digits: 1,
          )
        ],
      )
    },
  )
} <table-descriptive-statistics>

Leider lässt sich aus den Daten in @table-descriptive-statistics keine Gesamtausbeute der einzelnen Proben berechnen, da dafür die Information über das Verhältnis der im Photometer gemessenen Menge und der gesamt isolierten Menge fehlt. Die Tabelle zeigt einen Trend, der auch durch @dna-concentration-comparison-diagram verdeutlicht und in sowohl @leberproben als auch in @bakterienproben sichtbar ist: Die DNA Konzentration in Leberproben ist \~12x höher als in Bakterienproben.

Wie bereits in @photometrie-theorie erwähnt, kann schon ein leicht suboptimales Verhältnis $E_260 slash E_280$ oder $E_260 slash E_230$ auf eine äußerst starke Verunreinigung hindeuten. Diese ist um Durchschnitt bei allen Gruppen gegeben. Trotz eines in den Idealbereich fallenden Durchschnitts beim $E_260 slash E_230$ Quotienten der _-RNase_ Leberprobe ist aufgrund der hohen Standardabweichung davon auszugehen, dass bei der Probengruppe eine starke Verunreinigung vorliegt.

Interessanterweise ist bei RNase-behandelten Proben der Durchschnittswert für die DNA-Konzentration entgegen der intuitiven Vermutung, dass gemessene Nukleinsäuren aufgrund des RNA Abbaus verringert werden, höher als bei unbehandelten Proben.

#{
  show: figure.with(caption: [Diagramm der DNA-Konzentrationen und Verteilung der Leber- und Bakterienproben.])
  show: rect
  // Diagram for DNA concentration comparison
  lq.diagram(
    width: 7cm,
    title: [
      *Leber* vs. *Bakterien*\ DNA Konzentration
    ],
    xlim: (0, auto),
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
      tick-args: (density: 70%),
      label: [DNA Konzentration],
    ),
    yaxis: (
      //tick-args: (tick-distance: 1.0),
      ticks: relevant-data.map(it => it.sample_source).map(rotate.with(-45deg, reflow: true)).enumerate(),
    ),
    lq.hbar(
      relevant-data.map(it => it.with_rnase.stats.concentration.mean),
      range(relevant-data.len()),
    ),
    lq.plot(
      relevant-data.map(it => it.with_rnase.stats.concentration.mean),
      range(relevant-data.len()),
      xerr: relevant-data.map(it => it.with_rnase.stats.concentration.stddev),
      color: red,
      stroke: none,
    ),
  )
} <dna-concentration-comparison-diagram>

== Hypothesentests

Sämtliche Hypothesentests werden mit einem Signifikanzniveau von $alpha = 0.05$ durchgeführt. Die kritischen Werte für die nicht-parametrischen Tests werden aus standardisierten, vorberechneten Tabellen entnommen. Es werden, sofern nicht anders angegeben, die Daten aus @table-descriptive-statistics und sowohl @leberproben als auch @bakterienproben verwendet.

#let weight-data = (
  relevant-data
    .find(it => it.sample_source == "Leber")
    .with_rnase
    .measures
    .map(it => (it.concentration, liver-weights-data.at(it.initials).weight_g))
)
#let correlation = correlation(
  weight-data.map(it => it.at(0)),
  weight-data.map(it => it.at(1)),
)

#block(
  sticky: true,
)[*Gibt es einen Zusammenhang zwischen Gewicht der Leberprobe und der DNA-Konzentration im fertigen Isolat?*]

@weight-vs-concentration-diagram zeigt mit einem Korrelationskoeffizienten von $#calc.round(correlation, digits: 2)$ keinen deutlichen Zusammenhang.

#block(
  sticky: true,
)[*Gibt es einen signifikanten Unterschied ziwschen der DNA-Konzentration in Leber- und Bakterienproben?*]

#let leber-concentrations = (
  relevant-data.find(it => it.sample_source == "Leber").with_rnase.measures.map(it => it.concentration)
)
#let bakterien-concentrations = (
  relevant-data.find(it => it.sample_source == "Bakterien").with_rnase.measures.map(it => it.concentration)
)

Aufgrund der niedrigen Anzahl an Proben wird zur Beantwortung ein Wilcoxon-Rang-Summen-Test durchgeführt. Dieser liefert eine Teststatistik von $bold(#str(calc.round(wilcoxon-rank-sum-statistic(leber-concentrations, bakterien-concentrations).w-statistic, digits: 2))) ~ W_(#leber-concentrations.len(), #bakterien-concentrations.len())$, der aber #underline[nicht] unterhalb des kritischen Wertes von *2* liegt und daher #underline[*nicht signifikant*] ist.

#block(
  sticky: true,
)[*Gibt es einen signifikanten Unterschied ziwschen der DNA-Konzentration in _-RNase_ und _+RNase_ Proben?*]

#let rnase-concentrations = relevant-data.map(it => it.with_rnase.measures.map(it => it.concentration)).flatten()
#let nornase-concentrations = relevant-data.map(it => it.without_rnase.measures.map(it => it.concentration)).flatten()

Aufgrund der niedrigen Anzahl an Proben wird zur Beantwortung ein Wilcoxon-Vorzeichen-Rang-Test durchgeführt. Dieser liefert eine Teststatistik von $bold(#str(calc.round(wilcoxon-signed-rank-statistic(rnase-concentrations.zip(nornase-concentrations)).w-statistic, digits: 2))) ~ W_(#rnase-concentrations.len())$, der aber #underline[nicht] unterhalb des kritischen Wertes von *8* liegt und daher #underline[*nicht signifikant*] ist.

#{
  show: figure.with(
    caption: [Zusammenhang zwischen Gewicht der Leberprobe und der DNA-Konzentration im fertigen Isolat. Pearson-Korrelationskoeffizient: $#calc.round(correlation, digits: 2)$],
  )
  show: rect
  lq.diagram(
    width: 60%,
    title: [
      //#show: pad.with(left: 1cm)
      Leber (\+RNase)\
      Gewicht vs. DNA Konzentration],
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $"g"$),
      tick-args: (density: 70%),
      label: [Leber Gewicht],
    ),
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
      tick-args: (density: 70%),
      label: [DNA Konzentration],
    ),
    lq.scatter(
      weight-data.map(it => it.at(1)),
      weight-data.map(it => it.at(0)),
      size: 6pt,
      label: [$"Corr"(X, Y)$ = #calc.round(correlation, digits: 2)],
    ),
  )
} <weight-vs-concentration-diagram>


#new-chapter[Diskussion]

#set heading(numbering: none)
#new-chapter("Anhang")

== Quellen

#bibliography("../bib.yaml", title: none, style: "apa")

== Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

== Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

