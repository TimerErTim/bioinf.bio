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
  version: "1.0",
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
//#set figure(placement: auto)

#import "deps.typ": *
#import "../analysis/processing.typ": *
#import "../analysis/plots.typ": boxplot-rnase-concentration, grouped-bar-purity

#new-chapter[Einleitung]

In der BLT4-Übung *Isolation von genomischer DNA* wurde die Extraktion genomischer DNA (gDNA) aus zwei unterschiedlichen Ausgangsmaterialien durchgeführt: aus Schweineleber als eukaryotischem Gewebe und aus *E. coli*-Kulturen als prokaryotischem Modellorganismus. Die isolierten Proben wurden anschließend hinsichtlich Reinheit und Konzentration photometrisch charakterisiert, der RNA-Abbau durch RNase-Behandlung nachgewiesen und die Integrität der DNA mittels Restriktionsenzym-Verdau sowie Gelelektrophorese beurteilt. Die methodische Grundlage bildet die Angabe zur Isolierung genomischer DNA (Kapitel Durchführung).

#new-chapter[Zielsetzung]

Die Ziele des protokollierten Experiments können wie folgt zusammengefasst werden:

+ #[
    *Isolierung* (→ @leber-photometrie, @bakterien-photometrie):
    Extraktion genomischer DNA aus Schweineleber und *E. coli*-Kulturen. Erfolgskriterium: sichtbare Hochmolekular-DNA im Agarosegel bzw. messbare Absorption bei 260 nm.
  ]
+ #[
    *RNase-Verdau* (→ @leber-rnase, @bakterien-rnase):
    Nachweis des RNA-Abbaus durch RNase mittels Photometrie und Gelelektrophorese. Erwartung: Abnahme der RNA-Kontamination (untere Gel-Wolke, erhöhte $E_260$ bei _-RNase_).
  ]
+ #[
    *Konzentrationsbestimmung* (→ @leber-photometrie, @statistik):
    Photometrische Bestimmung der DNA-Konzentration und Reinheit. Referenzwerte: $E_260 slash E_280 approx 1.8$, $E_260 slash E_230 in 2.0 - 2.2$.
  ]
+ #[
    *Restriktionsenzym-Verdau* (→ @leber-restriktion, @bakterien-rnase):
    Einsatz von Typ-II-Restriktionsenzymen zur Beurteilung der DNA-Qualität. Erfolgskriterium: Umwandlung der Hochmolekular-Bande in einen durchgehenden Schmierstreifen.
  ]

#new-chapter[Theoretischer Hintergrund und Referenzwerte]

=== Genomarchitektur und Unterschiede zwischen Proben <genome-architektur-theorie>

Wie die DNA-Extraktion abläuft, hängt davon ab, ob man mit tierischen oder bakteriellen Zellen arbeitet. Die genomische DNA (gDNA) findet man in der Zelle nicht einfach frei schwimmend, sondern sie ist mit Proteinen verbunden und von Zellhüllen umgeben. @src_molecular-biology-of-the-cell

- *Eukaryotische DNA (Schweineleber)*: Das Genom der Schweineleberzellen (etwa 2,8 Milliarden Basenpaare, 38 Chromosomen) ist stark gepackt, weil es um spezielle, positiv geladene Proteine (Histone) gewickelt ist, wodurch Chromatin entsteht. @src_molecular-biology-of-the-cell Außerdem enthalten Leberzellen sehr viel RNA, vor allem rRNA und mRNA. Aufgrund der hohen Stoffwechselaktivität kann der Anteil bis zu 80-90 % der Nukleinsäuren ausmachen. @src_lodish-molecular-cell-biology Deshalb braucht man proteinabbauende Enzyme wie Proteinase K, um die Histone zu entfernen. Für den Abbau der RNA gibt man RNase dazu. Eine zu erwartende Ausbeute beträgt 3-4 mg DNA pro Gramm Leber. @src_csh-protocols-isolation

- *Prokaryotische DNA (E. coli)*: Bei Bakterien wie E. coli liegt die DNA als ein ringförmiges Chromosom mit rund 4,6 Millionen Basenpaaren ohne Histone vor und ist durch Supercoiling kompakter gemacht. @src_brock-mikrobiologie Das größte Problem bei der Extraktion ist die Zellwand. E. coli besitzt als gramnegatives Bakterium eine dicke äußere Schicht aus Lipopolysacchariden (LPS), die das Enzym Lysozym daran hindern kann, die Zellwand aufzubrechen. Erst wenn diese äußere Schicht zum Beispiel mit Hilfe von EDTA gestört wird, kann die darunterliegende Mureinschicht angreifbar werden. Bleibt sie intakt, klappt die Lyse nicht und es kann keine DNA extrahiert werden. @src_csh-bacterial-cell-envelope

=== Photometrie <photometrie-theorie>

$
  E_lambda = sum_(i=1)^n epsilon_(i, lambda) dot c_i space.thin underbrace(cancel(dot d), bold(1)"cm")
$ <beer-lambert-equation>

@beer-lambert-equation zeigt die Beziehung zwischen der Extinktion $E_lambda$ bei einer bestimmten Wellenlänge $lambda$ und der Konzentration $c_i$ der $n$ verschiedenen Komponenten indiziert mit $i$. Die Extinktionskoeffizienten $epsilon_(i, lambda)$ sind spezifisch für jede Komponente und Wellenlänge. @src_wikipedia-molar-extinction-coefficient

Bei doppelsträngiger DNA gilt der lineare Zusammenhang $E_260 = 1.0 => "dsDNA" = 50 space upright(mu"g/ml")$ bei einer Küvettenlichtweg von $d = 1 "cm"$. @src_dna-spektrum_img Daraus folgt für die Konzentrationsberechnung bei bekannter Verdünnung:

$
  c_"DNA" = E_260 dot 50 space upright(mu"g/ml") dot "Verdünnungsfaktor"
$ <dna-concentration-equation>

Die Reinheitsquotienten werden als Extinktionsverhältnisse berechnet:

$
  E_260 slash E_280 = E_260 / E_280
$ <purity-protein-equation>

$
  E_260 slash E_230 = E_260 / E_230
$ <purity-salt-equation>

@dna-concentration-equation, @purity-protein-equation und @purity-salt-equation werden für die Auswertung der Photometriemessungen herangezogen. Im Experiment wurde eine Verdünnung von 1:100 verwendet, sodass der Verdünnungsfaktor 100 beträgt.

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
    caption: [Extinktionskoeffizienten ($epsilon$) von dsDNA, Proteinen und Phenol bei den für die Reinheitsbeurteilung relevanten Wellenlängen. @src_assessment-of-nucleic-purity],
  )
  table(
    columns: 4,
    table.header[
      *Substanz*
    ][
      *$epsilon$ bei 230 nm*
    ][
      *$epsilon$ bei 260 nm*
    ][
      *$epsilon$ bei 280 nm*
    ],
    [dsDNA], [≈10,0], [20,0], [≈11,1],
    [Proteine (BSA)], [≈2,0 bis 3,0], [≈0,4], [0,66],
    [Phenol], [sehr hoch], [≈15,0], [≈12,5],
  )
} <extinction-coefficients-table>

=== Referenzwerte <referenzwerte-theorie>

#{
  show: figure.with(
    caption: [Zusammenfassung der für die Beurteilung der Versuchsergebnisse herangezogenen Referenzwerte.],
  )
  table(
    columns: 3,
    table.header[*Parameter*][*Referenzwert*][*Quelle*],
    [DNA-Ausbeute (Leber)], [3–4 mg/g Gewebe], [@src_csh-protocols-isolation],
    [*E. coli*-Chromosom], [≈4,6 Mbp, ringförmig], [@src_brock-mikrobiologie],
    [$E_260 slash E_280$ (reine DNA)], [≈1,8], [@src_assessment-of-nucleic-purity],
    [$E_260 slash E_230$ (reine DNA)], [2,0–2,2], [@src_assessment-of-nucleic-purity],
    [Konzentration aus Photometrie], [$E_260 = 1.0 => 50 mu"g/ml"$ (1 cm)], [@src_dna-spektrum_img],
    [Gel unrestriktiert], [Band >20 kbp am Gelanfang], [Theorie, @genome-architektur-theorie],
    [Gel restr.-verdaut], [durchgehender Schmierstreifen], [@restr-enzyme-theorie],
  )
} <reference-values-table>

=== Gelelektrophorese <gelelektrophorese-theorie>

Die Gelelektrophorese ist eine zentrale Methode zur Trennung und Analyse von DNA-Fragmenten. Grundlage dieses Verfahrens ist, dass DNA aufgrund ihrer negativ geladenen Phosphatgruppen in einem elektrischen Feld wandert. Durch das Gel (meist aus Agarose) werden die DNA-Fragmente unterschiedlich stark aufgehalten.
@src_thermo-fischer-gelelectro

Meist wird die Probe mit einem Färbemittel angereichert, das unter UV-Licht deutlich sichtbar wird und so Bandenmuster entstehen lassen. Im Fall von Ethidiumbromid korreliert die Leuchtkraft mit der Masse der DNA-Fragmente.
@src_thermo-fischer-gelelectro

*Der Trennmechanismus (Siebeffekt)*\
Da die Ladung der DNA proportional zu ihrer Länge (Anzahl der Basenpaare) zunimmt, ist das Verhältnis von Ladung zu Masse für alle DNA-Moleküle konstant. Würden sie im freien Wasser wandern, wären alle DNA-Stücke gleich schnell. @src_thermo-fischer-gelelectro

Agarose ist ein Polysaccharid, das beim Abkühlen ein dreidimensionales Porennetzwerk bildet. Während die DNA zur Anode wandert, zwängt sie sich durch dieses Gel-Netzwerk. Dabei wirkt eine Reibungskraft, die der elektrischen Kraft entgegenwirkt:
- _Kleine DNA-Fragmente_ schlüpfen leicht durch die Poren und wandern sehr schnell.
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

In @restr-enzyme-working-img werden zwei _Sticky Ends_ erzeugt. Die dadurch entstehenden, einzelsträngigen Überhänge erleichtern aufgrund der Wasserstoffbrückenbindungen die Verknüpfung mit anderen komplementären DNA-Strängen. _Blunt Ends_ besitzen diese Übergänge nicht und entstehen durch Schneiden in der Mitte der Erkennungssequenz. @src_neb-typ2-restr-enzyme

#new-chapter[Klinische Relevanz]

Die Qualität isolierter genomischer DNA ist eine zentrale Voraussetzung für nahezu alle molekularbiologischen und klinisch-diagnostischen Anwendungen. Während für Standard-PCR-Anwendungen oft einfache Extrakte ausreichen, erfordern moderne Hochdurchsatz-Verfahren wie Next-Generation Sequencing (NGS), Whole-Genome-Sequencing oder klinische Gentests hochmolekulare und extrem reine gDNA. @src_csh-protocols-isolation

*Klinische und diagnostische Anwendungen:*
- *PCR und qPCR:* Verunreinigungen durch Proteine, Phenol oder EDTA hemmen die Taq-Polymerase und verfälschen Amplifikationsergebnisse.
- *Next-Generation Sequencing:* RNA-Reste führen zu fehlerhaften Reads und erschweren die Genom-Assemblierung; Salz- und Phenol-Kontaminationen inhibieren Sequenzierpolymerasen.
- *Forensische Genetik und Identitätsprüfung:* Die Integrität der DNA (Fragmentlänge) bestimmt, ob STR-Analysen oder SNP-Typisierungen erfolgreich sind.
- *Pharmakogenomik:* Patientenspezifische Genotypisierungen (z. B. CYP450-Varianten) setzen reproduzierbar reine Ausgangsmaterialien voraus.

*Bezug zu den im Experiment gemessenen Parametern:*
Die im Versuch bestimmten Reinheitsquotienten ($E_260 slash E_280$, $E_260 slash E_230$) und die Sichtbarkeit intakter Hochmolekular-DNA im Gel sind direkte Qualitätsindikatoren, die in klinischen und Forschungslaboren routinemäßig vor kostenintensiven Downstream-Anwendungen geprüft werden. Verunreinigungen durch Proteine oder Phenole/Salze (siehe @photometrie-theorie) hemmen die empfindlichen Polymerasen der Sequenziergeräte, während RNA-Reste zu fehlerhaften Daten bei der Genom-Assemblierung führen können. @src_csh-protocols-isolation

#new-chapter[Materialien]

Für die Durchführung des Experiments gemäß der Angabe zur Isolierung genomischer DNA wurden folgende Materialien verwendet:

*Probematerial:*
- Frische oder tiefgekühlte *Schweineleber* (ca. 3,5–4,5 g pro Ansatz, siehe @table-liver-weights)
- Übernacht-*E. coli*-Kultur in LB-Medium

*Reagenzien für Lyse und Reinigung:*
- Lysis-Puffer (mit Detergens zur Membranauflösung)
- *Lysozym* (für bakterielle Zellwände)
- *Proteinase K* (für eukaryotisches Gewebe)
- *EDTA* (Komplexbildner, Störung der gramnegativen Außermembran)
- *Phenol* (pH 8,0)
- *Phenol/Chloroform/Isoamylalkohol* (25:24:1)
- *Chloroform*
- *Natriumacetat* (3 M, pH 5,2)
- *Ethanol* (100 % und 70 %)
- *TE-Puffer* (10 mM Tris-HCl, 1 mM EDTA, pH 8,0)

*Enzyme:*
- *RNase A* (RNA-Abbau)
- Restriktionsenzyme *EcoRI*, *NaeI*, *PstI* mit jeweiligem Standard-Reaktionspuffer (NEB)

*Analytik und Gelelektrophorese:*
- UV-Photometer mit 1-cm-Küvetten
- Destilliertes Wasser (Null-Referenz)
- *Agarose*
- *Ethidiumbromid* (oder äquivalentes DNA-Färbemittel)
- DNA-Ladder *GeneRuler#super[TM] 1 kb Plus*
- TAE- oder TBE-Laufpuffer
- DNA-Ladepuffer mit Tracking-Dye

*Geräte und Verbrauchsmaterial:*
- Wasserbad (37 °C und 56 °C)
- Kühlzentrifuge mit Eppendorf-Adaptern
- Pipetten und Filterspitzen
- 1,5-ml- und 2-ml-Reaktionsgefäße
- Agarose-Gelelektrophorese-Apparat mit UV-Transilluminator
- Sterile Skalpellklingen und Petrischalen (Gewebehomogenisierung)

#{
  show: figure.with(
    caption: [Gewichte der verwendeten Leberproben vor der Extraktion [$g$].],
  )
  table(
    columns: 3,
    table.header[*Name*][*Kürzel*][*Gewicht [g]*],
    ..for entry in liver-weights-raw-data {
      ([#entry.name], [#entry.initials], [#str(entry.weight_g)])
    },
  )
} <table-liver-weights>

#new-chapter[Durchführung]

#pdf.attach(
  "../instructions/Isolierung.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe für die Isolation von genomischer DNA",
)

Nachfolgend wird die im Labor durchgeführte Vorgehensweise Schritt für Schritt erläutert. Die Durchführung basiert auf den Angaben im eingebetteten Angabendokument.

== Sicherheitshinweise <durchfuehrung-chapter>

- *Phenol und Chloroform:* Stark ätzend und toxisch. Nur unter dem Fume Hood arbeiten, Schutzhandschuhe und Laborkittel tragen. Hautkontakt sofort mit Wasser spülen. Phenol verursacht schwere Verbrennungen.
- *Ethidiumbromid:* Mutagen. Handschuhe tragen, Gelabfälle in Sammelbehälter entsorgen.
- *Biologisches Material:* Leber und Bakterienkulturen als potenziell infektiöses Material behandeln.

== Zellaufschluss <zellaufschluss-durchfuehrung>

#{
  show: figure.with(
    caption: [Zell-Lyse unter Verwendung eines Detergens zum Öffnen der Zellmembran und Freisetzen der intrazellulären Bestandteile. @src_cell-lysis-img],
  )
  image("../assets/cell-lysis.png", width: 100%)
} <cell-lysis-img>

Um an die DNA im Inneren der Zellen zu kommen, müssen diese aufgebrochen werden (@cell-lysis-img). Je nach Probentyp wird unterschiedlich vorgegangen:

*Schweineleber:*
+ Leberstück auf einer Petrischale abwiegen (siehe @table-liver-weights) und mit steriler Klinge in kleine Stücke schneiden.
+ Gewebe in Lysis-Puffer überführen und *Proteinase K* zugeben.
+ 1–2 h bei 56 °C im Wasserbad inkubieren, bis das Gewebe vollständig aufgelöst ist.
+ _Qualitätskontrolle:_ Homogenes, klares Lysat ohne sichtbare Gewebereste.

*Bakterien (*E. coli*):*
+ 1,5 ml Bakterienkultur abzentrifugieren (10 min, 10.000 × g), Überstand vorsichtig entfernen.
+ Bakterienpellet in Lysis-Puffer resuspendieren, *Lysozym* und *EDTA* zugeben.
+ 30 min bei 37 °C inkubieren, um die gramnegative Zellwand anzugreifen.
+ _Qualitätskontrolle:_ Pellet vollständig aufgelöst; bei zu wenig Ausgangsmaterial ist die DNA-Ausbeute stark reduziert.

== Reinigung <reinigung-durchfuehrung>

Mittels mehrstufiger Extraktion mit organischen Lösungsmitteln werden Proteine und Lipide entfernt:

+ *Phenol-Extraktion:* Lysat mit gleichem Volumen Phenol (pH 8,0) vermischen, 2 min schütteln, 5 min zentrifugieren (10.000 × g). Wässrigen Überstand (obere Phase) übernehmen.
+ *Phenol/Chloroform/Isoamylalkohol (25:24:1):* Wiederholung der Phasentrennung zur weiteren Proteinentfernung.
+ *Chloroform-Extraktion:* Entfernung restlicher Phenol-Rückstände.
+ _Qualitätskontrolle:_ Saubere Trennung in wässrige Phase, Interphase (denaturierte Proteine) und organische Phase. In @reinigung-na-img sammeln sich die Proteine in der Interphase.

#{
  show: figure.with(
    caption: [Phasentrennung bei der Phenol-Chloroform-Extraktion: wässrige Phase (DNA), Interphase (Proteine), organische Phase. @src_reinigung-na_img],
  )
  image("../assets/reinigung-na.png", width: 100%)
} <reinigung-na-img>

== Isolierung durch Fällung <faellung-durchfuehrung>

+ Zum wässrigen Überstand 1/10 Volumen 3 M Natriumacetat (pH 5,2) und 2–2,5 Volumen 100 % Ethanol zugeben.
+ 30 min bei −20 °C oder 10 min bei Raumtemperatur ausfällen lassen.
+ 15 min zentrifugieren (10.000 × g, 4 °C). Das DNA-Pellet sollte als weißer/ durchsichtiger Niederschlag am Boden sichtbar sein.
+ Überstand entfernen, Pellet mit 70 % Ethanol waschen, erneut zentrifugieren.
+ Pellet bei Raumtemperatur trocknen und in *TE-Puffer* aufnehmen (@rna-fällung-img zeigt das Prinzip der Fällung in Isopropanol).

#{
  show: figure.with(
    caption: [Fällung von Nukleinsäuren: Das Pellet sammelt sich nach Zentrifugation am Boden des Gefäßes (schematisch für Isopropanol-Fällung dargestellt). @src_rna-fällung_img],
  )
  image("../assets/rna-fällung.png", width: 100%)
} <rna-fällung-img>

== Hinzugabe von RNase <rnase-durchfuehrung>

Die gewonnene DNA wird in zwei Aliquots aufgeteilt:
- _+RNase_: Mit RNase A behandelte DNA (Inkubation 30 min bei 37 °C).
- _-RNase_: Unbehandelte Kontrollprobe.

In den weiterführenden Schritten wird, sofern nicht anders angegeben, die _+RNase_-Probe verwendet.

== Photometermessung <photometrie-durchfuehrung>

+ Extrahierte DNA (_+RNase_ und _-RNase_) im Verhältnis 1:100 in destilliertem Wasser verdünnen.
+ Messung der Absorption bei 230 nm, 260 nm und 280 nm in 1-cm-Küvetten.
+ Destilliertes Wasser als Null-Referenz verwenden.
+ Konzentration nach @dna-concentration-equation und Reinheitsquotienten nach @purity-protein-equation und @purity-salt-equation berechnen.

@rnase-spectrum-measured-img und @nornase-spectrum-measured-img zeigen beispielhafte Spektren. Die Bakterienproben wurden ein zweites Mal gemessen (2. Durchlauf), da die ersten Messwerte nicht plausibel waren.

#place(auto, float: true, {
  show: pad.with(bottom: -1em)
  grid(
    columns: 2,
    gutter: 1em,
    align: top,
    {
      show: box
      show: it => [#it <nornase-spectrum-measured-img>]
      show: figure.with(
        caption: [UV-Spektrum einer Leberprobe _-RNase_ (Absorption $E$ bei 230, 260 und 280 nm).],
      )
      set rect(inset: 0pt)
      image("../assets/nathalie_raw_spektrum.png", width: 100%)
    },
    {
      show: box
      show: it => [#it <rnase-spectrum-measured-img>]
      show: figure.with(
        caption: [UV-Spektrum einer Leberprobe _+RNase_ (Absorption $E$ bei 230, 260 und 280 nm).],
      )
      set rect(inset: 0pt)
      image("../assets/nathalie_rnase_spektrum.png", width: 100%)
    },
  )
})

== Restriktionsenzym-Verdau <restriktion-durchfuehrung>

Die DNA wird mit den in @table-restr-distr aufgeführten Restriktionsenzymen behandelt. Für jedes Enzym wird der entsprechende Standardpuffer verwendet (@table-restr-enzyme-sequences).

+ Reaktionsansatz: DNA, Restriktionsenzym, 10× Reaktionspuffer, Wasser auf Endvolumen bringen.
+ Inkubation 1–2 h bei 37 °C im Wasserbad.
+ Reaktion durch Erhitzen auf 65 °C für 20 min (je nach Enzym) oder direkte Verwendung im Gel stoppen.

#{
  show: figure.with(
    caption: [Bekannte Zuteilung der Proben zu den Restriktionsenzymen. #text(fill: red)[L] = Leber, #text(fill: green)[B] = Bakterien.],
  )
  table(
    columns: 3,
    align: (right, center, center),
    table.header([*Enzym*], [*Alt*], [*Neu*]),
    ..for enzyme in restr-enzyme-distr-data
      .values()
      .map(it => it.enzyme)
      .dedup() {
      let person-has-liver(initials) = {
        initials in liver-weights-data
      }
      let found-old-person = restr-enzyme-distr-data
        .values()
        .find(it => it.enzyme == enzyme and it.new_charge == false)
      let found-new-person = restr-enzyme-distr-data
        .values()
        .find(it => it.enzyme == enzyme and it.new_charge == true)

      (
        [*#enzyme*],
        if found-new-person != none [
          #set text(fill: if person-has-liver(found-new-person.initials) {
            red
          } else { green })
          #found-new-person.initials
        ] else [
          #sym.crossmark
        ],
        if found-old-person != none [
          #set text(fill: if person-has-liver(found-old-person.initials) {
            red
          } else { green })
          #found-old-person.initials
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

== Gelelektrophorese <gelelektrophorese-durchfuehrung>

+ 0,8–1,0 % Agarosegel in TAE/TBE-Puffer gießen, mit Ethidiumbromid anfärben.
+ DNA-Proben mit Ladepuffer anmischen und zusammen mit *GeneRuler 1 kb Plus* Marker laden.
+ Elektrophorese bei ca. 5–8 V/cm für 45–60 min.
+ Dokumentation unter UV-Licht.

Es wurden folgende Probenkombinationen untersucht:
+ *Leber*: _-RNase_, _+RNase_ (unrestriktiert)
+ *Bakterien*: _-RNase_, _+RNase_ (unrestriktiert)
+ *Leber*: _+RNase_ mit Restriktionsenzymen (EcoRI, NaeI, PstI)

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
  ..photometrie-data.filter(it => (
    it.sample_source == "Leber" and it.trial == 1
  )),
  ..photometrie-data.filter(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )),
)

Zuerst werden die Ergebnisse je Teilbereich dargestellt und interpretiert. Anschließend folgt die statistische Auswertung. Jeder Abschnitt endet mit einer kurzen Schlussfolgerung.

#let table-photometrie-results(sample) = {
  table(
    columns: 3,
    align: left,
    ..(
      table.header(table.cell(
        colspan: 3,
        align: left,
      )[*#sample.sample_source (#sample.trial\. Durchlauf)*]),
      table.header(level: 2)[][*+RNase*][*-RNase*],
      ..for initials in (
        sample.with_rnase.measures.map(it => it.initials)
          + sample.without_rnase.measures.map(it => it.initials)
      ).dedup() {
        let with_rnase = sample.with_rnase.measures.find(it => (
          it.initials == initials
        ))
        let without_rnase = sample.without_rnase.measures.find(it => (
          it.initials == initials
        ))
        (
          [
            #show: rotate.with(-90deg, reflow: true)
            *#initials*
          ],
          ..for measurement in (
            if with_rnase != none { with_rnase },
            if without_rnase != none { without_rnase },
          ) {
            if measurement != none {
              (
                [
                  Konz.: #calc.round(measurement.concentration, digits: 1) #sym.mu\g DNA/ml\
                  $E_260 slash E_280$: #calc.round(measurement.cleaness_proteins, digits: 1)\
                  $E_260 slash E_230$: #calc.round(measurement.cleaness_salts, digits: 1)\
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

== Isolierung und Photometrie – Leber <leber-photometrie>

=== Darstellung

#{
  show: figure.with(
    caption: [Photometrische Einzelmesswerte der Leberproben (1. Durchlauf). Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
  )
  table-photometrie-results(relevant-data.find(it => (
    it.sample_source == "Leber" and it.trial == 1
  )))
} <table-photometrie-results-leber>

=== Erläuterung

@table-photometrie-results-leber listet die nach @dna-concentration-equation berechneten Konzentrationen sowie die Reinheitsquotienten aller Leberproben. Die Konzentrationen liegen zwischen ca. 10 und 400 #sym.mu\g DNA/ml. Die Absorptionsquotienten $E_260 slash E_280$ und $E_260 slash E_230$ weichen bei den meisten Proben deutlich von den Referenzwerten in @reference-values-table ab.

=== Interpretation

Im Vergleich zum Referenzwert von $E_260 slash E_280 approx 1.8$ sind fast alle Proben verunreinigt. Die Probe NS +RNase weist mit $E_260 slash E_280 = 1.7$ und $E_260 slash E_230 = 2.0$ die geringsten Abweichungen auf und nähert sich den Idealwerten am ehesten. Die hohen Konzentrationen bei TP und SG deuten auf erfolgreiche Extraktion, aber gleichzeitig auf Protein- oder Phenol-Kontamination hin (niedrige $E_260 slash E_280$-Werte).

=== Schlussfolgerung

Die Leber-Extraktion lieferte in allen Fällen nachweisbare DNA in relevanten Konzentrationen. Die Reinheit ist jedoch durchweg suboptimal; nur die Probe NS erfüllt die Referenzwerte annähernd. Das Ziel der Konzentrationsbestimmung wurde erreicht, das Ziel einer hochreinen DNA nur teilweise.

== RNase-Nachweis – Leber <leber-rnase>

=== Darstellung

#let annotated-leber-unrestr-gelelectro = {
  show: block.with(width: 15cm, height: 8.5cm)
  image("../assets/leber-unrestr-gelelectro.png", width: 100%)
  let draw-rect(x, y, width, height, ..args) = {
    place(top + left, dx: x, dy: y, {
      rect(width: width, height: height, ..args)
    })
  }
  set rect(radius: 0.5em)
  draw-rect(2%, 10%, 10%, 89%, stroke: green + 2pt)
  draw-rect(13%, 10%, 9%, 89%, stroke: blue + 2pt)
  draw-rect(23%, 9.75%, 9%, 89.25%, stroke: green + 2pt)
  draw-rect(33%, 9.75%, 8.5%, 89%, stroke: blue + 2pt)
  draw-rect(42.25%, 9.5%, 7.75%, 88%, stroke: green + 2pt)
  draw-rect(50.75%, 9%, 8.25%, 88.2%, stroke: blue + 2pt)
  draw-rect(60%, 8%, 9.25%, 90%, stroke: green + 2pt)
  draw-rect(70%, 8%, 8.25%, 89%, stroke: blue + 2pt)
  draw-rect(79%, 7%, 8.5%, 89.2%, stroke: green + 2pt)
  draw-rect(88.5%, 7%, 8.25%, 90%, stroke: blue + 2pt)
  set text(weight: "bold", size: 16pt)
  place(top + left, dx: 10%, dy: 1mm)[
    LS
  ]
  place(top + left, dx: 30%, dy: 1mm)[
    SG
  ]
  place(top + left, dx: 48%, dy: 1mm)[
    NS
  ]
  place(top + left, dx: 68%, dy: 1mm)[
    TP
  ]
  place(top + left, dx: 86%, dy: 1mm)[
    SS
  ]
}
#{
  show: figure.with(
    caption: [Annotiertes Gelelektrophorese-Bild der Leberprobe _-RNase_ (#box(stroke: blue, inset: 1em / 2, baseline: 1em / 4)) und _+RNase_ (#box(stroke: green, inset: 1em / 2, baseline: 1em / 4)), beide ohne Restriktionsenzym-Verdau.],
  )
  set rect(inset: 0pt)
  place(top + left, dx: 8%)[
    Marker
  ]
  box(
    image("../assets/leber-unrestr-ref-marker.png", width: 8.7%),
    baseline: -1mm,
  )
  box(scale(annotated-leber-unrestr-gelelectro, 80%, reflow: true))
} <annotated-leber-unrestr-gelelectro-img>

#{
  show: figure.with(
    caption: [Marker für die Gelelektrophorese: GeneRuler#super[TM] 1 kb Plus DNA Ladder.],
  )
  image("../assets/genruler-1kb-plus.png")
} <genruler-1kb-plus-img>

=== Erläuterung

@annotated-leber-unrestr-gelelectro-img zeigt die erfolgreich extrahierte Hochmolekular-DNA als breite Band am oberen Gelrand (>20 kbp). Der mittlere Schmier (ca. 1–40 kbp) stammt aus zerrissener DNA und RNA. Die helle Wolke am unteren Rand deutet auf RNA-Kontamination hin; bei SG, TP und SS ist nach RNase-Behandlung eine Abnahme erkennbar.

=== Interpretation

Der Schmier macht den hohen RNA-Anteil in Leberzellen sichtbar (geschätzt ~85 %). Der RNase-Effekt ist gelbildlich bei einzelnen Proben nachweisbar. Photometrisch ist kein konsistenter Konzentrationsrückgang bei _+RNase_ erkennbar (@table-photometrie-results-leber).

=== Schlussfolgerung

Der RNA-Nachweis und -Abbau gelang im Gel teilweise. Das Ziel wurde nur bei einem Teil der Proben klar erreicht.

== Restriktionsverdau – Leber <leber-restriktion>

=== Darstellung

#let annotated-leber-restr-gelelectro = {
  show: block.with(width: 10cm, height: 5cm + 1em, stroke: 0pt)
  {
    show: pad.with(top: 1em)
    box(image("../assets/ss-restr-leber.png", height: 100%))
    box(image("../assets/ls-restr-leber.png", height: 100%))
    box(image("../assets/sg-restr-leber.png", height: 100%))
  }
  place(top + left, dx: 35%, dy: 1mm)[
    SS
  ]
  place(top + left, dx: 45%, dy: 1mm)[
    LS
  ]
  place(top + left, dx: 56%, dy: 1mm)[
    SG
  ]
}
#{
  show: figure.with(
    caption: [Annotiertes Gelelektrophorese-Bild mit Restriktionsenzymen verdauten Leber-DNA _+RNase_.],
  )
  set rect(inset: 0pt)
  annotated-leber-restr-gelelectro
} <annotated-leber-restr-gelelectro-img>

=== Erläuterung

In @annotated-leber-restr-gelelectro-img verschwindet die Hochmolekular-Bande und es entsteht ein durchgehender Schmierstreifen von ca. 20 kbp bis wenige hundert bp. Die LS-Probe (PstI) zeigt einen verkürzten Schmier.

=== Interpretation

Der erfolgreiche Verdau bestätigt enzymatisch verwertbare DNA trotz photometrisch nachgewiesener Verunreinigungen. Der partielle Verdau bei LS (PstI) kann auf Enzym- oder Reaktionsprobleme zurückzuführen sein.

=== Schlussfolgerung

Das Ziel des Restriktionsverdaus wurde bei zwei von drei Proben vollständig und bei LS teilweise erreicht.

== Isolierung und Photometrie – Bakterien <bakterien-photometrie>

=== Darstellung

#{
  show: figure.with(
    caption: [Photometrische Einzelmesswerte der Bakterienproben (2. Durchlauf). Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
  )
  table-photometrie-results(relevant-data.find(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )))
} <table-photometrie-results-bakterien>

=== Erläuterung

Die Bakterienproben wurden nach unplausiblen Erstmessungen erneut bestimmt. Die Konzentrationen liegen deutlich unter den Leberwerten.

=== Interpretation

Niedrige Konzentrationen und ungünstige Reinheitsquotienten deuten auf unvollständige Lyse und geringe Ausbeute hin.

=== Schlussfolgerung

Die bakterielle DNA-Isolierung war photometrisch nur schwach nachweisbar. Das Isolierungsziel wurde nicht erreicht.

== RNase und Restriktion – Bakterien <bakterien-rnase>

=== Darstellung

#let annotated-bakterien-unrestr-gelelectro = {
  show: block.with(width: 100%, height: 4.82cm + 1em, stroke: 0pt)
  {
    show: pad.with(top: 1em)
    box(image("../assets/bakterien-unrestr-gel-1.png", height: 100%))
    box(image("../assets/bakterien-unrestr-gel-2.png", height: 100%))
  }
  let draw-rect(x, y, width, height, ..args) = {
    place(top + left, dx: x, dy: y, {
      rect(width: width, height: height, ..args)
    })
  }
  set rect(radius: 0.5em)
  draw-rect(0.25%, 8%, 4.5%, 90%, stroke: green + 1.5pt)
  draw-rect(5.25%, 8%, 4.75%, 90%, stroke: blue + 1.5pt)
  draw-rect(10.75%, 8%, 4.5%, 90%, stroke: blue + 1.5pt)
  draw-rect(16.25%, 8%, 4.75%, 90%, stroke: green + 1.5pt)
  draw-rect(24%, 10%, 5%, 88%, stroke: blue + 1.5pt)
  draw-rect(29.5%, 10%, 4.75%, 88%, stroke: blue + 1.5pt)
  draw-rect(34.75%, 10%, 5%, 88%, stroke: blue + 1.5pt)
  draw-rect(40.75%, 10%, 4.75%, 88%, stroke: green + 1.5pt)
  draw-rect(46.25%, 10%, 4.5%, 88%, stroke: green + 1.5pt)
  draw-rect(51.25%, 10%, 4.75%, 88%, stroke: blue + 1.5pt)
  draw-rect(56.5%, 10%, 4.5%, 88%, stroke: blue + 1.5pt)
  draw-rect(61.5%, 10%, 4.75%, 88%, stroke: green + 1.5pt)
  draw-rect(66.75%, 10%, 4.5%, 88%, stroke: green + 1.5pt)
  place(top + left, dx: 3%, dy: 1mm)[
    CB
  ]
  place(top + left, dx: 14%, dy: 1mm)[
    EL
  ]
  place(top + left, dx: 25%, dy: 1mm)[
    EL
  ]
  place(top + left, dx: 33%, dy: 1mm)[
    LH
  ]
  place(top + left, dx: 44%, dy: 1mm)[
    LH
  ]
  place(top + left, dx: 55%, dy: 1mm)[
    AL
  ]
  place(top + left, dx: 65%, dy: 1mm)[
    AL
  ]
  place(top + left, dx: 90%, dy: 1mm)[
    Marker
  ]
}

#{
  show: figure.with(
    caption: [Annotiertes Gelelektrophorese-Bild der Bakterienprobe _-RNase_ (#box(stroke: blue, inset: 1em / 2, baseline: 1em / 4)) und _+RNase_ (#box(stroke: green, inset: 1em / 2, baseline: 1em / 4)), beide ohne Restriktionsenzym-Verdau.],
  )
  set rect(inset: 0pt)
  annotated-bakterien-unrestr-gelelectro
} <annotated-bakterien-unrestr-gelelectro-img>

#{
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild unrestriktierter Bakterien-DNA (Literatur). @src_unrestr-bakterien-gel-erw_img],
  )
  image("../assets/erwartung-unrestr-bakterien.png")
} <erwartung-unrestr-bakterien-gel-img>

#{
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild restr.-verdauter Bakterien-DNA (Literatur). Spalten „E“ = *E. coli*. @src_restr-bakterien-gel-erw_img],
  )
  set rect(inset: 0pt)
  image("../assets/erwartung-restr-bakterien.png")
} <erwartung-restr-bakterien-gel-img>

=== Erläuterung

In @annotated-bakterien-unrestr-gelelectro-img fehlt die erwartete Hochmolekular-Bande am Gelanfang. Es ist nahezu kein Fluoreszenzsignal erkennbar. @erwartung-unrestr-bakterien-gel-img und @erwartung-restr-bakterien-gel-img zeigen die Soll-Befunde aus der Literatur.

=== Interpretation

Die fehlende Bande deutet auf eine fehlgeschlagene bakterielle Extraktion hin (Lyse, zu wenig Ausgangsmaterial). Ein RNase-Vergleich ist aufgrund der geringen Signalintensität nicht möglich. Restriktions-Gele konnten nicht ausgewertet werden.

=== Schlussfolgerung

Weder RNase-Nachweis noch Restriktionsanalyse waren bei Bakterien aussagekräftig. Die Ziele wurden nicht erreicht.

== Statistische Auswertung <statistik>

#{
  show: figure.with(
    caption: [Beschreibende Statistik: Mittelwert $plus.minus$ Standardabweichung. Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
  )
  table(
    columns: relevant-data.len() * 2 + 1,
    table.header(
      table.cell(rowspan: 2, stroke: none, fill: none)[],
      ..for sample in relevant-data {
        (
          table.cell(
            colspan: 2,
          )[*#sample.sample_source (#sample.trial\. Durchlauf)*],
        )
      },
      ..for sample in relevant-data {
        (
          [\+ RNase],
          [\- RNase],
        )
      },
    ),
    [Konzentration [#sym.mu\g DNA/ml]],
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
          #calc.round(
            sample.with_rnase.stats.cleaness_proteins.mean,
            digits: 1,
          ) #sym.plus.minus #calc.round(
            sample.with_rnase.stats.cleaness_proteins.stddev,
            digits: 1,
          )
        ],
        [
          #calc.round(
            sample.without_rnase.stats.cleaness_proteins.mean,
            digits: 1,
          ) #sym.plus.minus #calc.round(
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
          #calc.round(
            sample.with_rnase.stats.cleaness_salts.mean,
            digits: 1,
          ) #sym.plus.minus #calc.round(
            sample.with_rnase.stats.cleaness_salts.stddev,
            digits: 1,
          )
        ],
        [
          #calc.round(
            sample.without_rnase.stats.cleaness_salts.mean,
            digits: 1,
          ) #sym.plus.minus #calc.round(
            sample.without_rnase.stats.cleaness_salts.stddev,
            digits: 1,
          )
        ],
      )
    },
  )
} <table-descriptive-statistics>

Leider lässt sich aus den Daten in @table-descriptive-statistics keine Gesamtausbeute in mg DNA/g Leber berechnen, da das Endvolumen der Aufnahme fehlt. Die Tabelle zeigt einen Trend, der auch durch @dna-concentration-comparison-diagram, @boxplot-rnase-concentration-diagram und @grouped-bar-purity-diagram verdeutlicht wird: Die DNA-Konzentration in Leberproben ist deutlich höher als in Bakterienproben.

#{
  show: figure.with(
    caption: [Horizontalbalkendiagramm: mittlere DNA-Konzentration [#sym.mu\g DNA/ml, +RNase] von Leber- und Bakterienproben mit Standardabweichung.],
  )
  show: rect
  lq.diagram(
    width: 7cm,
    title: [
      *Leber* vs. *Bakterien*\
      DNA-Konzentration
    ],
    xlim: (0, auto),
    xaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
      tick-args: (density: 70%),
      label: [DNA-Konzentration [#sym.mu\g DNA/ml]],
    ),
    yaxis: (
      ticks: relevant-data
        .map(it => it.sample_source)
        .map(rotate.with(-45deg, reflow: true))
        .enumerate(),
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

#{
  show: figure.with(
    caption: [Boxplot der DNA-Konzentrationen [#sym.mu\g DNA/ml] für +RNase- und -RNase-Proben je Probengruppe.],
  )
  show: rect
  boxplot-rnase-concentration
} <boxplot-rnase-concentration-diagram>

#{
  show: figure.with(
    caption: [Gruppierte Balkendiagramme der mittleren Reinheitsquotienten $E_260 slash E_280$ und $E_260 slash E_230$ [$-$] mit Standardabweichung.],
  )
  show: rect
  grouped-bar-purity
} <grouped-bar-purity-diagram>

Wie in @photometrie-theorie beschrieben, kann schon ein leicht suboptimales Verhältnis $E_260 slash E_280$ oder $E_260 slash E_230$ auf starke Verunreinigung hindeuten. Interessanterweise ist bei RNase-behandelten Proben der Mittelwert der DNA-Konzentration höher als bei unbehandelten Proben — entgegen der Erwartung, dass RNA-Abbau die gemessene Nukleinsäure-Menge senkt.

=== Schlussfolgerung

Die deskriptive Statistik bestätigt den qualitativen Befund: Leber-DNA in hohen Konzentrationen, aber meist verunreinigt; Bakterien-DNA kaum nachweisbar. Eine RNase-bedingte Konzentrationsänderung ist im Mittel nicht erkennbar.

== Hypothesentests <hypothesentests-chapter>

=== Verwendete Testformeln

Für den Zusammenhang zwischen Lebergewicht und DNA-Konzentration wird der Pearson-Korrelationskoeffizient verwendet:

$
  r = (sum_(i=1)^n (x_i - overline(x))(y_i - overline(y))) / (sqrt(sum_(i=1)^n (x_i - overline(x))^2) sqrt(sum_(i=1)^n (y_i - overline(y))^2))
$ <pearson-correlation-equation>

Bei kleinen Stichproben ($n < 30$) werden nicht-parametrische Tests eingesetzt. Der *Wilcoxon-Rang-Summen-Test* vergleicht zwei unabhängige Gruppen; die Teststatistik $W$ ist die kleinere Summe der Ränge einer der Gruppen. Der *Wilcoxon-Vorzeichen-Rang-Test* vergleicht gepaarte Messwerte; $W$ ist die kleinere Summe der Ränge der positiven oder negativen Differenzen.

Entscheidungsregel (beide Tests, $alpha = 0.05$): Liegt $W$ oberhalb des tabellierten kritischen Wertes, wird die Nullhypothese (_kein Unterschied_) nicht verworfen.

Sämtliche Hypothesentests werden mit einem Signifikanzniveau von $alpha = 0.05$ durchgeführt. Die kritischen Werte werden aus standardisierten Tabellen entnommen.

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

#{
  show: figure.with(
    caption: [Streudiagramm: Lebergewicht [$g$] vs. DNA-Konzentration [#sym.mu\g DNA/ml, +RNase]. Pearson-$r$ = #calc.round(correlation, digits: 2).],
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
      label: [Lebergewicht [$g$]],
    ),
    yaxis: (
      format-ticks: lq.tick-format.linear.with(suffix: $mu"g/ml"$),
      tick-args: (density: 70%),
      label: [DNA-Konzentration [#sym.mu\g DNA/ml]],
    ),
    lq.scatter(
      weight-data.map(it => it.at(1)),
      weight-data.map(it => it.at(0)),
      size: 6pt,
      label: [$"Corr"(X, Y)$ = #calc.round(correlation, digits: 2)],
    ),
  )
} <weight-vs-concentration-diagram>

#block(
  sticky: true,
)[*Gibt es einen signifikanten Unterschied zwischen der DNA-Konzentration in Leber- und Bakterienproben?*]

#let leber-concentrations = (
  relevant-data
    .find(it => it.sample_source == "Leber")
    .with_rnase
    .measures
    .map(it => it.concentration)
)
#let bakterien-concentrations = (
  relevant-data
    .find(it => it.sample_source == "Bakterien")
    .with_rnase
    .measures
    .map(it => it.concentration)
)

Aufgrund der niedrigen Anzahl an Proben wird zur Beantwortung ein Wilcoxon-Rang-Summen-Test durchgeführt. Dieser liefert eine Teststatistik von $bold(#str(calc.round(wilcoxon-rank-sum-statistic(leber-concentrations, bakterien-concentrations).w-statistic, digits: 2))) ~ W_(#leber-concentrations.len(), #bakterien-concentrations.len())$, der aber #underline[nicht] unterhalb des kritischen Wertes von *2* liegt und daher #underline[*nicht signifikant*] ist.

#block(
  sticky: true,
)[*Gibt es einen signifikanten Unterschied zwischen der DNA-Konzentration in _-RNase_- und _+RNase_-Proben?*]

#let rnase-concentrations = (
  relevant-data
    .map(it => it.with_rnase.measures.map(it => it.concentration))
    .flatten()
)
#let nornase-concentrations = (
  relevant-data
    .map(it => it.without_rnase.measures.map(it => it.concentration))
    .flatten()
)

Aufgrund der niedrigen Anzahl an Proben wird zur Beantwortung ein Wilcoxon-Vorzeichen-Rang-Test durchgeführt. Dieser liefert eine Teststatistik von $bold(#str(calc.round(wilcoxon-signed-rank-statistic(rnase-concentrations.zip(nornase-concentrations)).w-statistic, digits: 2))) ~ W_(#rnase-concentrations.len())$, der aber #underline[nicht] unterhalb des kritischen Wertes von *8* liegt und daher #underline[*nicht signifikant*] ist.

=== Schlussfolgerung

Keiner der durchgeführten Hypothesentests ergab signifikante Unterschiede. Dies ist vor allem auf den geringen Stichprobenumfang ($n = 5$–$10$) zurückzuführen.

#new-chapter[Gesamtinterpretation und Diskussion]

Die Ergebnisse der genomischen DNA-Isolation zeigen ein deutliches Zweiteilungsbild: Die Extraktion aus Schweineleber gelang grundsätzlich, während die bakterielle Isolierung aus *E. coli* weitgehend fehlschlug.

*Leberproben:* Photometrisch wurde DNA in allen Proben nachgewiesen (@leber-photometrie), jedoch mit überwiegend ungünstigen Reinheitsquotienten. Im Agarosegel war Hochmolekular-DNA sichtbar (@leber-rnase); RNase reduzierte die RNA-Kontamination bei einzelnen Proben. Der Restriktionsverdau bestätigte die enzymatische Verwertbarkeit der DNA (@leber-restriktion).

*Bakterienproben:* Weder Gel noch Photometrie lieferten überzeugende Ergebnisse (@bakterien-photometrie, @bakterien-rnase). Die Soll-Befunde aus der Literatur (@erwartung-unrestr-bakterien-gel-img, @erwartung-restr-bakterien-gel-img) konnten nicht reproduziert werden.

#{
  show: figure.with(
    caption: [Soll-Ist-Vergleich der zentralen Versuchsbefunde.],
  )
  table(
    columns: 4,
    table.header[*Befund*][*Erwartung (Soll)*][*Beobachtung (Ist)*][*Wahrscheinliche Ursache*],
    [Leber-Gel unrestriktiert], [Band >20 kbp], [Band + RNA-Wolke], [RNA-reiches Gewebe, teils erfolgreiche Isolierung],
    [Leber RNase], [weniger RNA-Signal], [teilweise sichtbar], [RNase wirkt, aber unvollständig],
    [Leber Restriktion], [Schmier], [Schmier; LS kürzer], [Verdau ok; PstI-Teilverdau bei LS],
    [Bakterien-Gel], [Band oben], [kaum Signal], [Lyse/Extraktion fehlgeschlagen],
    [RNase-Konzentration], [+RNase < −RNase], [+RNase höher im Mittel], [Verunreinigungen; kleines $n$; RNA in $E_260$],
    [Statistik], [—], [nicht signifikant], [Stichprobe zu klein ($n = 5$–$10$)],
  )
} <soll-ist-vergleich-table>

*Gesamtbewertung der Zielsetzung:*
+ Isolierung Leber: *erreicht* (DNA nachweisbar, Gel positiv)
+ Isolierung Bakterien: *nicht erreicht*
+ RNase-Nachweis: *teilweise erreicht* (Leber ja, Bakterien nein)
+ Konzentrationsbestimmung: *erreicht* (Leber), *nicht erreicht* (Bakterien)
+ Restriktionsverdau: *erreicht* (Leber), *nicht auswertbar* (Bakterien)

Das Studentenlabor eignet sich gut, um die Prinzipien der Phenol-Chloroform-Extraktion, Photometrie und Gelelektrophorese zu erlernen. Für quantitative oder klinische Anwendungen wären standardisierte Kits und größere Stichproben erforderlich.

#new-chapter[Fehlerquellen]

== Probenvorbereitung

- *Zu wenig Bakterienpellet:* Durch unzureichendes Abzentrifugieren der Kultur war das Ausgangsmaterial zu gering, was die fehlende DNA-Ausbeute erklärt (@bakterien-photometrie).
- *Gewichtsschwankungen der Leberproben:* Die eingesetzten Massen lagen zwischen 3,5 und 4,4 g (@table-liver-weights); ein Zusammenhang zur Konzentration war statistisch nicht nachweisbar ($r approx #calc.round(correlation, digits: 2)$).

== Lyse und Extraktion

- *Gramnegative Zellwand:* Lysozym allein reichte offenbar nicht aus, die LPS-haltige Außermembran von *E. coli* zu durchbrechen (@bakterien-rnase).
- *Unvollständige Gewebehomogenisierung:* Grobe Gewebefragmente können die Proteinase-K-Lyse verzögern.

== Reinigung und Aufreinigung

- *Phenol-Carryover:* Senkt $E_260 slash E_230$ und hemmt Enzyme; erklärt die photometrisch nachgewiesenen Verunreinigungen bei Leberproben.
- *Mechanische DNA-Schädigung:* Vorschnelles Pipettieren erzeugt den mittleren Schmier im Gel (@leber-rnase).

== RNase-Behandlung und Photometrie

- *Unvollständiger RNA-Abbau:* RNase wurde erst nach der Extraktion zugesetzt; RNA kann bereits in $E_260$ einfließen.
- *Falsche Verdünnung oder Küvettenfehler:* Erklärt die Notwendigkeit der zweiten Bakterienmessung.

== Restriktionsverdau und Gelelektrophorese

- *Partieller Verdau (LS, PstI):* Mögliche Ursachen: abgelaufenes Enzym, falscher Puffer oder inhibitorische Verunreinigungen.
- *Probe verwechselt oder überladen:* Erklärt anomale Bakterien-Gelspuren.

== Statistik

- *Zu kleine Stichprobe:* Mit $n = 5$ (Leber) bzw. $n = 5$ (Bakterien) ist die Teststärke zu gering, um moderate Effekte nachzuweisen (@hypothesentests-chapter).
- *Ausreißer:* Einzelne Proben (z. B. TP, SG) mit extrem hohen Konzentrationen verzerren Mittelwert und Standardabweichung.

#set heading(numbering: none)
#new-chapter("Anhang")

== Quellen

#bibliography("../bib.yaml", title: none, style: "apa")

== Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

== Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

