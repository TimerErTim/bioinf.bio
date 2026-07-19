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

#outline(depth: 3, title: none)
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
#import "components/helpers.typ": result-section, result-label
#import "components/tables.typ": *
#import "components/figures.typ": *
#import "@preview/meander:0.4.2"
#new-chapter[Einleitung und Zielsetzung]

In der BLT4-Übung *Isolation von genomischer DNA* wurde die Extraktion genomischer DNA (gDNA) aus zwei unterschiedlichen Ausgangsmaterialien durchgeführt: aus Schweineleber als eukaryotischem Gewebe und aus *E. coli*-Kulturen als prokaryotischem Modellorganismus. Die isolierten Proben wurden anschließend hinsichtlich Reinheit und Konzentration photometrisch charakterisiert, der RNA-Abbau durch RNase-Behandlung nachgewiesen und die Integrität der DNA mittels Restriktionsenzym-Verdau sowie Gelelektrophorese beurteilt. Die methodische Grundlage bildet die Angabe zur Isolierung genomischer DNA (@durchfuehrung-chapter).

== Zielsetzung

Die Ziele des protokollierten Experiments können wie folgt zusammengefasst werden:

+ #[
    *Isolierung* (→ @leber-photometrie, @bakterien-photometrie):
    Extraktion genomischer DNA aus Schweineleber und E. coli-Kulturen. Erfolgskriterium: sichtbare Hochmolekular-DNA im Agarosegel bzw. messbare Absorption bei 260 nm.
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

== Genomarchitektur und Unterschiede zwischen Proben <genome-architektur-theorie>

Wie die DNA-Extraktion abläuft, hängt davon ab, ob man mit tierischen oder bakteriellen Zellen arbeitet. Die genomische DNA (gDNA) findet man in der Zelle nicht einfach frei schwimmend, sondern sie ist mit Proteinen verbunden und von Zellhüllen umgeben. @src_molecular-biology-of-the-cell

- *Eukaryotische DNA (Schweineleber)*: Das Genom der Schweineleberzellen (etwa 2,8 Milliarden Basenpaare, 38 Chromosomen) ist stark gepackt, weil es um spezielle, positiv geladene Proteine (Histone) gewickelt ist, wodurch Chromatin entsteht. @src_molecular-biology-of-the-cell Außerdem enthalten Leberzellen sehr viel RNA, vor allem rRNA und mRNA. Aufgrund der hohen Stoffwechselaktivität kann der Anteil bis zu 80-90 % der Nukleinsäuren ausmachen. @src_lodish-molecular-cell-biology Deshalb braucht man proteinabbauende Enzyme wie Proteinase K, um die Histone zu entfernen. Für den Abbau der RNA gibt man RNase dazu. Eine zu erwartende Ausbeute beträgt 3-4 mg DNA pro Gramm Leber. @src_csh-protocols-isolation

- *Prokaryotische DNA (E. coli)*: Bei Bakterien wie E. coli liegt die DNA als ein ringförmiges Chromosom mit rund 4,6 Millionen Basenpaaren ohne Histone vor und ist durch Supercoiling kompakter gemacht. @src_brock-mikrobiologie Das größte Problem bei der Extraktion ist die Zellwand. E. coli besitzt als gramnegatives Bakterium eine dicke äußere Schicht aus Lipopolysacchariden (LPS; große Fett-Zucker-Moleküle, die als Schutzschild der äußeren Membran dienen), die das Enzym Lysozym daran hindern kann, die Zellwand aufzubrechen. Erst wenn diese äußere Schicht zum Beispiel mit Hilfe von EDTA (einem chemischen Bindemittel, das stabilisierende Metallionen aus der Membran herauszieht) gestört wird, kann die darunterliegende Mureinschicht (das feste Stützgerüst der Bakterienwand aus Zuckern und Aminosäuren) angreifbar werden. Bleibt sie intakt, klappt die Lyse nicht und es kann keine DNA extrahiert werden. @src_csh-bacterial-cell-envelope Ebenfalls wird RNase genutzt, um die bakterielle RNA loszuwerden und am Ende reine DNA im Röhrchen zu haben. 

== Photometrie <photometrie-theorie>
Die Photometriemessung ist ein optisches Analyseverfahren, bei dem die Konzentration und Reinheit von gelösten Stoffen (wie Nukleinsäuren) bestimmt wird, indem man Licht einer bestimmten Wellenlänge durch die Probe leitet und misst, wie viel Licht absorbiert wird. Die Abschwächung des Lichts wird als Extinktion ($E_lambda$, auch optische Dichte genannt) bezeichnet.

Das grundlegende Prinzip basiert auf dem Lambert-Beer'schen Gesetz:
$
  E_lambda = sum_(i=1)^n epsilon_(i, lambda) dot c_i space.thin underbrace(cancel(dot d), bold(1)"cm")
$ <beer-lambert-equation>

@beer-lambert-equation zeigt die Beziehung zwischen der Extinktion $E_lambda$ bei einer bestimmten Wellenlänge $lambda$ und der Konzentration $c_i$ der $n$ verschiedenen Komponenten indiziert mit $i$. Die Extinktionskoeffizienten $epsilon_(i, lambda)$ sind spezifisch für jede Komponente und Wellenlänge. @src_wikipedia-molar-extinction-coefficient

Bei doppelsträngiger DNA gilt der lineare Zusammenhang $E_260 = 1.0 => "dsDNA" = 50 space upright(mu"g/ml")$ bei einer Küvettenlichtweg von $d = 1 "cm"$. @src_dna-spektrum_img Daraus folgt für die Konzentrationsberechnung bei bekannter Verdünnung:

$
  c_"DNA" = E_260 dot 50 space upright(mu"g/ml") dot "Verdünnungsfaktor"
$ <dna-concentration-equation>

Um neben der Konzentration auch die Qualität der isolierten DNA zu beurteilen, werden Reinheitsquotienten berechnet. Ein Reinheitsquotient ist ein Extinktionsverhältnis, bei dem die gemessene Absorption der DNA (Maximum bei $260"nm"$) durch die Absorption potenzieller Verunreinigungen bei anderen Wellenlängen geteilt wird:

$
  E_260 slash E_280 = E_260 / E_280
$ <purity-protein-equation>

$
  E_260 slash E_230 = E_260 / E_230
$ <purity-salt-equation>

Der Quotient @purity-protein-equation dient zur Überprüfung auf Proteinverunreinigungen (Proteine absorbieren maximal bei $280"nm"$ durch aromatische Aminosäuren; ein Wert von $#sym.tilde 1.8$ gilt als reine DNA). Der Quotient @purity-salt-equation zeigt Verunreinigungen durch Salze, Chaotrope oder Alkohole an (absorbieren bei $230"nm"$; ein Wert von $#sym.tilde 2.0-2.2$ gilt als rein). Es wird aber unter Abbildung 1 nochmal genauer darauf eingegangen.

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

*Entstehung dieser Verunreinigungen:*
Zu einer Proteinkontamination kommt es vor allem dann, wenn der Zellaufschluss (Lyse) unvollständig war oder der anschließende Proteinentfernungsschritt (z. B. durch Proteinase K oder eine Phenol-Chloroform-Extraktion) nicht effizient genug durchgeführt wurde. Auch ungenaues Pipettieren, bei dem versehentlich Teile der proteinreichen Phase oder des Pellets nach der Zentrifugation mitgerissen werden, ist eine häufige Ursache. Eine Phenolkontamination entsteht, wenn nach einer organischen Extraktion Reste der organischen Phase in die wässrige DNA-Phase verschleppt werden.

*Der 260/230-Quotient (Salze und organische Lösungsmittel)*\
Dieser Wert dient als sekundäres Maß für die Reinheit von Nukleinsäuren und reagiert sensibel auf Rückstände aus den Extraktionspuffern. Für reine Nukleinsäuren werden allgemein 260/230-Werte im Bereich von 2,0 bis 2,2 erwartet. Der 260/230-Quotient wird verwendet, um die Anwesenheit unerwünschter organischer Verbindungen wie Phenol, Guanidinhydrochlorid und Guanidinthiocyanat anzuzeigen. Verunreinigungen durch diese Chemikalien zeigen eine starke Absorption bei 230 nm oder darunter, was den 260/230-Quotienten drastisch senkt. @src_assessment-of-nucleic-purity

*Entstehung dieser Verunreinigungen:*
Diese Art der Kontamination geht fast immer auf Rückstände aus den verwendeten Extraktions- und Waschpuffern zurück. Guanidinsalze (Guanidinhydrochlorid/Guanidinthiocyanat) sind Hauptbestandteile von Lyse- und Bindungspuffern in klassischen Säulchen-Kits (Spin-Columns). Wenn die anschließenden Waschschritte mit ethanolhaltigen Puffern zu kurz waren, das Ethanol nicht vollständig durch ein trockenes Zentrifugieren entfernt wurde oder Pufferreste am Rand des Reaktionsgefäßes verblieben sind, werden diese Salze und Alkohole im letzten Schritt zusammen mit der DNA eluiert.

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

== Referenzwerte <referenzwerte-theorie>
Für die anschließende quantitative und qualitative Beurteilung der isolierten Nukleinsäuren sowie der elektrophoretischen Analyse werden etablierte Literatur- und Vergleichswerte herangezogen. Diese dienen in der späteren Diskussion als Kontrollinstanz, um die Effizienz der Zelllyse, den Erfolg des Restriktionsverdaus sowie den Reinheitsgrad der Proben systematisch zu bewerten. Die genutzten Parameter und deren Quellen sind in folgender Tabelle zusammengefasst.
#{
  show: figure.with(
    caption: [Zusammenfassung der für die Beurteilung der Versuchsergebnisse herangezogenen Referenzwerte.],
  )
  set cite(form: "prose")
  table(
    columns: 3,
    table.header[*Parameter*][*Referenzwert*][*Quelle*],
    [DNA-Ausbeute (Leber)], [3-4 mg/g Gewebe], [
      #show super: it => it.body
      @src_csh-protocols-isolation
    ],
    [*E. coli*-Chromosom], [≈4,6 Mbp, ringförmig], [
      #show super: it => it.body
      @src_brock-mikrobiologie
    ],
    [$E_260 slash E_280$ (reine DNA)], [≈1,8], [
      #show super: it => it.body
      @src_assessment-of-nucleic-purity
    ],
    [$E_260 slash E_230$ (reine DNA)], [2,0-2,2], [
      #show super: it => it.body
      @src_assessment-of-nucleic-purity
    ],
    [Konzentration aus Photometrie], [$E_260 = 1.0 => 50 mu"g/ml"$ (1 cm)], [
      #show super: it => it.body
      @src_dna-spektrum_img
    ],
    [Gel unrestriktiert], [Band >20 kbp am Gelanfang], [Theorie, @genome-architektur-theorie],
    [Gel restr.-verdaut], [durchgehender Schmierstreifen], [@restr-enzyme-theorie],
  )
} <reference-values-table>

== Gelelektrophorese <gelelektrophorese-theorie>



#meander.reflow({
  import meander: *
  // Obstacles
  placed(top + right, boundary: // Override the default margin
      contour.margin(5mm), figure(image("../assets/gelelktro-illustr.png", width: 50%,), caption: [Bandenmuster bei der Gelelektrophorese. 
      \
      @src_gelelektro-illustr_img]))
  // Container
  container(margin:5cm)

  // Flowing text
  content[

Die Gelelektrophorese ist eine zentrale Methode zur Trennung und Analyse von DNA-Fragmenten. Grundlage dieses Verfahrens ist, dass DNA aufgrund ihrer negativ geladenen Phosphatgruppen in einem elektrischen Feld wandert. Durch das Gel (meist aus Agarose) werden die DNA-Fragmente unterschiedlich stark aufgehalten.
@src_thermo-fischer-gelelectro

Meist wird die Probe mit einem Färbemittel angereichert, das unter UV-Licht deutlich sichtbar wird und so Bandenmuster entstehen lassen. Im Fall von Ethidiumbromid korreliert die Leuchtkraft mit der Masse der DNA-Fragmente.
@src_thermo-fischer-gelelectro

*Der Trennmechanismus (Siebeffekt)*\
Da die Ladung der DNA proportional zu ihrer Länge (Anzahl der Basenpaare) zunimmt, ist das Verhältnis von Ladung zu Masse für alle DNA-Moleküle konstant. Würden sie im freien Wasser wandern, wären alle DNA-Stücke gleich schnell. @src_thermo-fischer-gelelectro

Agarose ist ein Polysaccharid, das beim Abkühlen ein dreidimensionales Porennetzwerk bildet. Während die DNA zur Anode wandert, zwängt sie sich durch dieses Gel-Netzwerk. Dabei wirkt eine Reibungskraft, die der elektrischen Kraft entgegenwirkt:
- _Kleine DNA-Fragmente_ schlüpfen leicht durch die Poren und wandern sehr schnell.
- _Große DNA-Fragmente_ bleiben in den Poren hängen, verheddern sich und wandern sehr langsam. @src_thermo-fischer-gelelectro

]
})
#meander.reflow({
  import meander: *
  // Obstacles
  placed(top + left, boundary: // Override the default margin
      contour.margin(5mm), figure(image("image.png", width: 20%,), caption: [Logarithmische \ Trennung von DNA-Fragmenten \ in einem Agarosegel. TIM QUELLE]))
  // Container
  container(margin:5mm)

  // Flowing text
  content[

Dieser "Siebeffekt" sorgt dafür, dass die DNA-Moleküle logarithmisch nach ihrer Größe sortiert werden. Ein Abstand zwischen 1000 bp und 2000 bp ist viel größer als der Abstand zwischen 10000 bp und 11000 bp.
@src_thermo-fischer-gelelectro
]
})

*Versuchsrelevanz der elektrophoretischen Analyse*\
Im Kontext dieses Experiments erfüllt die Gelelektrophorese drei kritische Funktionen zur Qualitätskontrolle der isolierten genomischen DNA (gDNA), die rein photometrisch nicht beurteilt werden können:
- *Integritätsprüfung (Degradation):* Unbeschädigte gDNA ist hochmolekular und wandert aufgrund ihrer enormen Größe kaum in das Gel ein; sie verbleibt als scharfe Bande nahe der Lichttaschen (>20 kbp). Mechanisch gescherte oder degradierte DNA zeigt sich hingegen als unspezifischer Schmierstreifen. @src_csh-protocols-isolation
- *Erfolgsnachweis des RNA-Abbaus:* Da RNA-Moleküle (vor allem rRNA) deutlich kleiner sind als genomische DNA, sammeln sie sich als diffuse, schnell laufende "Wolke" am unteren Gelrand. Der Vergleich von Proben mit und ohne RNase-Behandlung macht die Effizienz des enzymatischen Abbaus gelbildlich direkt sichtbar. @src_thermo-fischer-gelelectro
- *Funktionalitätsnachweis (Restriktionsverdau):* Durch den Einsatz von Typ-II-Restriktionsenzymen (siehe @restr-enzyme-theorie) wird die gDNA an spezifischen Sequenzen zerschnitten. Die Gelelektrophorese dient hier als Nachweis, ob die isolierte DNA enzymatisch zugänglich ist: Ein erfolgreicher Verdau führt zum vollständigen Verschwinden der hochmolekularen gDNA-Bande und erzeugt ein charakteristisches Fragment-Verteilungsmuster (Schmierstreifen) über einen weiten Größenbereich. @src_csh-protocols-isolation


== Typ-II-Restriktionsenzyme <restr-enzyme-theorie>

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
  image("../assets/restr-enzyme-working.png", width: 80%)
} <restr-enzyme-working-img>

In @restr-enzyme-working-img werden zwei _Sticky Ends_ erzeugt. Die dadurch entstehenden, einzelsträngigen Überhänge erleichtern aufgrund der Wasserstoffbrückenbindungen die Verknüpfung mit anderen komplementären DNA-Strängen. _Blunt Ends_ besitzen diese Übergänge nicht und entstehen durch Schneiden in der Mitte der Erkennungssequenz. @src_neb-typ2-restr-enzyme

*Versuchsrelevanz des Restriktionsverdaus*\
Der Einsatz von Typ-II-Restriktionsenzymen dient in diesem Experiment als funktionaler Qualitätsnachweis der isolierten genomischen DNA. Da diese Enzyme eine hochspezifische 3D-Struktur aufweisen, reagieren sie extrem empfindlich auf Verunreinigungen in der DNA-Lösung. Das präzise Schneiden der DNA liefert uns wichtige Erkenntnisse für die Auswertung:
- *Inhibitions-Check (Reinheitskontrolle):* Rückstände aus der Extraktion (wie Phenol, Ethanol oder hohe Salzkonzentrationen aus den Lysepuffern) denaturieren das Enzym oder blockieren das aktive Zentrum. Wenn im späteren Agarosegel trotz Enzymzugabe die ungeschnittene, hochmolekulare Bande unverändert bleibt, ist dies ein direkter Beweis für eine inhibierende Kontamination der Probe. @src_csh-protocols-isolation
- *Charakteristisches Fragmentierungsmuster:* Da genomische DNA riesig ist und die Erkennungssequenzen der Enzyme statistisch extrem oft vorkommen, wird die gDNA in Millionen unterschiedlich langer Fragmente zerlegt. Elektrophoretisch äußert sich ein erfolgreicher, vollständiger Verdau daher in einem kontinuierlichen "Schmierstreifen" (Smear), der sich von großen zu kleinen Fragmentlängen erstreckt. @src_neb-typ2-restr-enzyme
- *Enzymspezifische Unterschiede:* Je nach Enzym (EcoRI, NaeI, PstI) unterscheidet sich die Häufigkeit der Schnittstellen im Schweine- oder Bakteriengenom. Dies erlaubt es, in der Auswertung potenzielle Unterschiede in der Fragmentverteilung oder der Verdauungseffizienz zwischen den Probenanansätzen zu vergleichen. @src_neb-typ2-restr-enzyme

#new-chapter[Klinische Relevanz]

Die Qualität isolierter genomischer DNA ist eine zentrale Voraussetzung für nahezu alle molekularbiologischen und klinisch-diagnostischen Anwendungen. Während für Standard-PCR-Anwendungen oft einfache Extrakte ausreichen, erfordern moderne Hochdurchsatz-Verfahren wie Next-Generation Sequencing (NGS), Whole-Genome-Sequencing oder klinische Gentests hochmolekulare und extrem reine gDNA. @src_csh-protocols-isolation

*Klinische und diagnostische Anwendungen:*
- *PCR und qPCR (Quantitative PCR):* Diese Methoden bilden das Rückgrat der klinischen Infektionsdiagnostik (z. B. Nachweis von Viren oder bakteriellen Erregern) und der Onkologie. Verunreinigungen durch Proteine oder Phenol denaturieren die hitzestabile Taq-Polymerase. Ein kritischer Faktor ist hierbei auch verschlepptes EDTA aus dem Zellaufschluss: Da EDTA Magnesium-Ionen extrem stark bindet, entzieht es der Polymerase ihren essenziellen Co-Faktor. Die Folge sind falsch-negative Befunde oder künstlich erhöhte Cq-Werte, was im schlimmsten Fall zu einer medizinischen Fehldiagnose führt.
- *Next-Generation Sequencing (NGS) und Liquid Biopsy:* Bei der Entschlüsselung von Patientengenomen oder Tumormutationen blockieren Salz- und Phenolkontaminationen (erkennbar an einem niedrigen $E_260 / E_230$-Quotienten) die Sequenzier-Enzyme. Ein unvollständiger RNA-Abbau (mangelnde RNase-Aktivität) führt dazu, dass RNA-Fragmente mitsubstituiert und sequenziert werden. Dies verschwendet teure Sequenzier-Kapazität ("Reads") für unerwünschte Moleküle und führt zu Fehlern bei der computergestützten Genom-Zusammensetzung (Assemblierung).
- *Forensische Genetik und Identitätsprüfung:* Bei Kriminalfällen oder Vaterschaftstests werden hochvariable Genorte (STRs - Short Tandem Repeats) analysiert. Liegt die DNA im Gel nicht als intakte, hochmolekulare Bande vor, sondern ist sie durch mechanische Scherung oder biologische Degradation (durch DNasen) stark fragmentiert, können die langen STR-Bereiche nicht mehr fehlerfrei vervielfältigt werden. Das führt zum Verlust von Banden im Allelprofil ("Allelic Drop-out") und macht eine eindeutische Täteridentifikation unmöglich.
- *Pharmakogenomik (z. B. CYP450-Varianten):* Vor der Gabe bestimmter Medikamente (wie Chemotherapeutika oder Herzmedikamenten) wird das Genom des Patienten auf Cytochrom-P450-Polymorphismen untersucht, um die individuelle Abbaugeschwindigkeit und Dosierung zu bestimmen. Da diese Assays oft auf sensitiven Multiplex-PCRs oder Microarrays basieren, führen selbst minimale Reinheitsabweichungen zu unvollständigen Signalmustern und damit zu lebensgefährlichen Falsch-Dosierungen.
- *Krebsdiagnostik und Detektion von Copy Number Variations (CNVs):* Bei vielen Tumorarten verändern sich die Anzahl von Genkopien (z. B. HER2-Amplifikation bei Brustkrebs). Um diese CNVs mittels digitaler PCR (dPCR) oder Next-Generation Sequencing exakt quantifizieren zu können, ist eine präzise photometrische Ausgangskonzentration zwingend nötig. Eine Scheinkonzentration, die durch RNA-Kontaminationen oder freie Nukleotide vorgetäuscht wird (erhöhter $E_260$-Wert), führt zu einer falschen Probenverdünnung und verfälscht die klinische Beurteilung des Tumorstadiums. @src_assessment-of-nucleic-purity
- *Pränataldiagnostik (NIPT - Nicht-invasiver Pränataltest):* Aus dem Blut schwangerer Frauen wird zellfreie fetale DNA (cffDNA) isoliert, um Trisomien (z. B. Down-Syndrom) frühzeitig zu erkennen. Da der Anteil der fetalen DNA im mütterlichen Blut extrem gering ist, führen organische Lösungsmittelrückstände (Phenol/Chloroform) oder mangelnde Probenintegrität (Scherung der ohnehin kurzen Fragmente) sofort zum Abbruch des sensiblen Sequenzierprotokolls und erzwingen eine risikoreiche invasive Fruchtwasseruntersuchung. @src_csh-protocols-isolation

*Bezug zu den im Experiment gemessenen Parametern:* \
Die im Versuch bestimmten Reinheitsquotienten ($E_260 slash E_280$, $E_260 slash E_230$) und die Sichtbarkeit intakter Hochmolekular-DNA im Gel sind direkte Qualitätsindikatoren, die in klinischen und Forschungslaboren routinemäßig vor kostenintensiven Downstream-Anwendungen geprüft werden. Verunreinigungen durch Proteine oder Phenole/Salze (siehe @photometrie-theorie) hemmen die empfindlichen Polymerasen der Sequenziergeräte, während RNA-Reste zu fehlerhaften Daten bei der Genom-Assemblierung führen können. @src_csh-protocols-isolation

#new-chapter[Materialien]

Für die Durchführung des Experiments gemäß der Angabe zur Isolierung genomischer DNA wurden folgende Materialien verwendet:

*Probematerial:*
- Frische *Schweineleber* (ca. 3,5–4,5 g pro Ansatz, siehe @table-liver-weights)
- Übernacht-*E. coli*-Kultur in LB-Medium

*Reagenzien für Lyse und Reinigung:*
- Lysis-Puffer: Das enthaltene Detergens bricht die Plasmamembranen auf und denaturiert zelluläre Proteine, um die DNA freizusetzen.
- Lysozym: Dieses Enzym spaltet die Mureinschicht der bakteriellen Zellwand von E. coli.
- Proteinase K: Das Enzym baut die störenden Gewebeproteine sowie die Histone ab, um die eukaryotische DNA zu entpacken.
- EDTA: Es fängt Magnesiumionen weg, wodurch einerseits die schützende äußere Bakterienmembran instabil wird und andererseits DNA-abbauende Enzyme inhibiert werden.
- Phenol (pH 8,0): Es denaturiert Proteine hocheffizient und ermöglicht deren Abtrennung von den wasserlöslichen Nukleinsäuren.
- Phenol/Chloroform/Isoamylalkohol (25:24:1): Dieses Gemisch optimiert die Trennung der wässrigen Phase von der organischen Phase und minimiert die Schaumbildung.
- Chloroform: Es wäscht verbliebene Phenolreste aus der oberen, DNA-haltigen Phase heraus.
- Natriumacetat (3 M, pH 5,2): Die enthaltenen Natriumionen neutralisieren die negativen Ladungen des DNA-Rückgrats, um die spätere Fällung zu ermöglichen.
- Ethanol: Hochprozentiges Ethanol (100 %) erzwingt das Ausfällen der DNA, während 70-prozentiges Ethanol zum Waschen und Entsalzen des Pellets dient.
- TE-Puffer (10 mM Tris-HCl, 1 mM EDTA, pH 8,0): Er dient als stabiles Lösungs- und Aufbewahrungsmedium, das den pH-Wert puffert und die DNA vor biologischem Abbau schützt.

*Enzyme:*
- RNase A: Dieses Enzym baut die in hoher Menge vorhandene zelluläre RNA gezielt ab, damit diese die spätere DNA-Messung nicht verfälscht.
- Restriktionsenzyme *EcoRI*, *NaeI*, *PstI* mit jeweiligem Standard-Reaktionspuffer (NEB): Diese molekularen Scheren schneiden die isolierte DNA an sequenzspezifischen Stellen, um ihre enzymatische Zugänglichkeit und Qualität zu überprüfen.

*Analytik und Gelelektrophorese:*
- UV-Photometer mit 1-cm-Küvetten: Das Gerät misst die Lichtabsorption der Proben bei verschiedenen Wellenlängen, um Konzentration und Reinheit rechnerisch zu ermitteln.
- Destilliertes Wasser: Es wird für die Probenverdünnung und als optische Null-Referenz (Blank) im Photometer benötigt.
- Agarose: Das Polysaccharid bildet nach dem Aufkochen das dreidimensionale Porennetzwerk, welches als Molekularsieb fungiert.
- Ethidiumbromid (oder äquivalentes DNA-Färbemittel): Es lagert sich in die DNA-Doppelhelix ein und bringt die Banden unter UV-Licht zum Leuchten.
- DNA-Ladder GeneRuler#super[TM] 1 kb Plus: Dieser Größenstandard enthält DNA-Fragmente bekannter Längen und dient als Referenzskala im Gel.
- TAE- oder TBE-Laufpuffer: Er leitet den elektrischen Strom durch die Gelkammer und hält den pH-Wert während des Laufs stabil.
- DNA-Ladepuffer mit Tracking-Dye: Er erhöht das Gewicht der Proben, damit sie in den Geltaschen absinken, und zeigt den Fortschritt der Elektrophorese farblich an.

*Geräte und Verbrauchsmaterial:*
- Wasserbad (37 °C und 56 °C): Es sorgt für die exakte Einhaltung der optimalen Arbeitstemperaturen der eingesetzten Enzyme.
- Kühlzentrifuge mit Eppendorf-Adaptern: Sie trennt durch hohe Fliehkräfte die Phasen und sedimentiert das DNA-Pellet unter Temperaturschutz.
- Pipetten und Filterspitzen: Sie ermöglichen das kontaminationsfreie und präzise Dosieren kleinster Flüssigkeitsmengen.
- 1,5-ml- und 2-ml-Reaktionsgefäße: Sie dienen als sichere Behälter für die Durchführung der chemischen und enzymatischen Reaktionen.
- Agarose-Gelelektrophorese-Apparat mit UV-Transilluminator: Das Kombinationssystem erlaubt erst das Auftrennen der Fragmente per Strom und danach das Fotografieren des Bandenmusters auf dem UV-Tisch.
- Sterile Skalpellklingen und Petrischalen: Sie wurden für die saubere mechanische Zerkleinerung des Lebergewebes vor dem Lysis-Schritt genutzt.

== Probenübersicht und Enzymzuteilung <probenuebersicht-anhang>

Nachfolgend sind die spezifischen experimentellen Parameter der einzelnen Arbeitsgruppen zusammengefasst. Die Tabellen dokumentieren die exakten Einwaagen der verwendeten Gewebeproben sowie die individuelle Zuteilung der Restriktionsenzyme zu den jeweiligen Probenkürzeln der Laboranten. Diese Zuordnung ist für die spätere Zuordnung der Gelspuren und die Interpretation der Verdauungsmuster essenziell.

#{
  show: figure.with(
    caption: [Gewichte der verwendeten Leberproben vor der Extraktion [$g$].],
  )
  table-liver-weights
} <table-liver-weights>

#{
  show: figure.with(
    caption: [Bekannte Zuteilung der Proben zu den Restriktionsenzymen. #text(fill: red)[L] = Leber, #text(fill: green)[B] = Bakterien.],
  )
  table-restr-enzyme-distribution
} <table-restr-distr>

== Spezifikationen der Restriktionsenzyme <enzymspezifikationen-anhang>

Die folgende Übersicht zeigt die nukleotidischen Erkennungssequenzen der im Experiment eingesetzten Typ-II-Restriktionsenzyme. Die markierten Pfeilspitzen verdeutlichen die exakten Schnittstellen im DNA-Rückgrat, welche die Entstehung von charakteristischen Überhängen (*Sticky Ends* bei EcoRI und PstI) oder glatten Enden (*Blunt Ends* bei NaeI) definieren.

#{
  show: figure.with(
    caption: [Erkennungssequenzen der verwendeten Restriktionsenzyme: EcoRI, NaeI, PstI. Bildquelle: #link("https://www.neb.com/")],
  )
  set rect(inset: 0pt)
  table-restr-enzyme-sequences
} <table-restr-enzyme-sequences>

#new-chapter[Durchführung]

Nachfolgend wird die im Labor durchgeführte Vorgehensweise Schritt für Schritt erläutert. Die Durchführung basiert auf den Angaben im Anhang (Rohdaten und Versuchsangabe).

== Sicherheitshinweise <durchfuehrung-chapter>

Während der gesamten Durchführung im Labor müssen grundsätzlich und ausnahmslos ein geschlossener Laborkittel sowie geeignete Schutzhandschuhe getragen werden. Für die im Versuch verwendeten Gefahrstoffe gelten darüber hinaus folgende spezifische Sicherheitsvorgaben:

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
+ Leberstück auf einer Petrischale abwiegen (siehe @table-liver-weights) und mit einem Mixstab gründlich pürieren. 
  - *Grund:* Die mechanische Zerkleinerung maximiert die Oberfläche des Gewebes, sodass die Lysechemikalien homogen angreifen können.
+ Gewebe in Lysis-Puffer überführen und *Proteinase K* zugeben. 
 - *Grund:* Der Puffer enthält Detergenzien, welche die Lipiddoppelschicht der Zell- und Kernmembranen solubilisieren. Proteinase K baut zeitgleich die stark verpackenden Histone sowie zelleigene Proteine ab.
+ 1–2 h bei 56 °C im Wasserbad inkubieren, bis das Gewebe vollständig aufgelöst ist. 
 - *Grund:* Die erhöhte Temperatur entspricht dem Aktivitätsoptimum der thermostabilen Proteinase K und beschleunigt die Denaturierung der zellulären Proteinstrukturen.
+ _Qualitätskontrolle:_ Ein homogenes, klares Lysat ohne verbliebene sichtbare Gewebereste zeigt den vollständigen Aufschluss an.

*Bakterien (*E. coli*):*
+ 1,5 ml Bakterienkultur abzentrifugieren (10 min, 10.000 × g), Überstand vorsichtig entfernen. 
 - *Grund:* Dieser Schritt dient der Konzentrierung der Bakterienzellen und der vollständigen Abtrennung des nährstoffreichen Kulturmediums.
+ Bakterienpellet in Lysis-Puffer resuspendieren, *Lysozym* und *EDTA* zugeben. 
  - *Grund:* Als gramnegatives Bakterium besitzt *E. coli* eine robuste Zellwand. Das Enzym Lysozym spaltet die stabilisierende Mureinschicht, während EDTA die schützende äußere Lipopolysaccharid-Membran durch das Wegfangen von Metallionen destabilisiert und zeitgleich zelleigene DNasen inhibiert.
+ 30 min bei 37 °C inkubieren, um die gramnegative Zellwand anzugreifen. 
 - *Grund:* Dies stellt die physiologische Optimaltemperatur für die katalytische Aktivität des Lysozyms dar.
+ _Qualitätskontrolle:_ Das Pellet muss vollständig aufgelöst sein. Da Bakterien eine deutlich geringere Biomasse als Gewebe besitzen, führt eine unvollständige Lyse hier sofort zu einem kritischen Verlust der DNA-Ausbeute.


== Reinigung <reinigung-durchfuehrung>

Mittels mehrstufiger Extraktion mit organischen Lösungsmitteln werden Proteine und Lipide entfernt:

+ *Phenol-Extraktion:* Lysat mit gleichem Volumen Phenol (pH 8,0) vermischen, 2 min intensiv schütteln, 5 min zentrifugieren (10.000 × g). Wässrigen Überstand (obere Phase) vorsichtig übernehmen.
  - *Grund:* Phenol ist ein starkes organisches Lösungsmittel, das Proteine irreversibel denaturiert. Aufgrund des basischen pH-Werts verbleibt die DNA in der oberen, wässrigen Phase, während die hydrophoben, entfalteten Proteine in die untere organische Phase gedrückt werden oder als Feststoff dazwischen ausfallen.
+ *Phenol/Chloroform/Isoamylalkohol (25:24:1):* Wiederholung der Phasentrennung zur weiteren Proteinentfernung. 
  - *Grund:* Die Kombination erhöht die Dichte der organischen Phase, wodurch eine schärfere Phasengrenze entsteht. Das Isoamylalkohol wirkt zusätzlich als Antischaummittel während des Schüttelns.
+ *Chloroform-Extraktion:* Ein reiner Chloroform-Waschschritt wird durchgeführt, gefolgt von einer erneuten Phasentrennung. 
 - *Grund:* Chloroform nimmt verbliebene, gelöste Phenolspuren aus der wässrigen Phase auf, da Phenolrückstände stark enzyminhibitorisch wirken und spätere Downstream-Applikationen stören würden.
+ _Qualitätskontrolle:_ Es muss eine saubere physikalische Trennung in eine klare wässrige Phase, eine weiße Interphase (denaturierte Proteine) und eine organische Phase sichtbar sein (@reinigung-na-img). Beim Abpipettieren darf die Interphase unter keinen Umständen berührt werden, um Proteinkontaminationen zu vermeiden.

#{
  show: figure.with(
    caption: [Phasentrennung bei der Phenol-Chloroform-Extraktion: wässrige Phase (DNA), Interphase (Proteine), organische Phase. @src_reinigung-na_img],
  )
  image("../assets/reinigung-na.png", width: 100%)
} <reinigung-na-img>

== Isolierung durch Fällung <faellung-durchfuehrung>
#meander.reflow({
  import meander: *
  // Obstacles
  placed(top + left, boundary: // Override the default margin
      contour.margin(5mm), figure(image("../assets/rna-fällung.png", width: 50%,), caption: [Fällung von  Nukleinsäuren: Das Pellet \ sammelt  sich nach Zentrifugation  am Boden des \ Gefäßes (schematisch für  Isopropanol-Fällung \ dargestellt). @src_rna-fällung_img])) 
  // Container
  container(margin:5mm)

  // Flowing text
  content[

+ Zum wässrigen Überstand 1/10 Volumen 3 M Natriumacetat (pH 5,2) und 2–2,5 Volumen 100 % Ethanol zugeben. 
 - *Grund:* Das negativ geladene Phosphatrückgrat der DNA ist in Wasser hochlöslich. Die positiv geladenen Natriumionen des Salzes maskieren diese Ladung, während das unpolare Ethanol die schützende Hydrathülle aus Wassermolekülen um die DNA zerstört, wodurch die DNA aggregiert und unlöslich wird.
+ 30 min bei −20 °C oder 10 min bei Raumtemperatur ausfällen lassen.
 - *Grund:* Die Kälte bzw. die Inkubationszeit begünstigt den Zusammenschluss der neutralisierten DNA-Stränge zu größeren, ausfallenden Komplexen.
+ 15 min zentrifugieren (10.000 × g, 4 °C). Das DNA-Pellet sollte als weißer oder durchsichtiger Niederschlag am Boden sichtbar sein. 
 - *Grund:* Durch die hohe Zentrifugalkraft wird die präzipitierte DNA kompaktiert; die Kühlung schützt die freie DNA vor thermischer Degradation.
+ Überstand entfernen, Pellet mit 70 % Ethanol waschen, erneut zentrifugieren. 
 - *Grund:* Der 70-prozentige Alkohol löst die mitgefällten Salze (Natriumacetat) wieder auf und wäscht sie aus, hält die DNA selbst aufgrund des verbliebenen Alkoholanteils jedoch weiterhin unlöslich im Pellet.
+ Pellet bei Raumtemperatur an der Luft trocknen lassen und anschließend in *TE-Puffer* aufnehmen (Abbildung 7 zeigt das Prinzip der Fällung). 
 - *Grund:* Das Ethanol muss vollständig verdampfen, da Alkoholreste Polymerasen hemmen. Der TE-Puffer sorgt für einen stabilen pH-Wert und schützt die gelöste DNA über das enthaltene EDTA langfristig vor Spuren von Nukleasen.
]
})
#pagebreak()
== Hinzugabe von RNase <rnase-durchfuehrung>

Die gewonnene DNA wird in zwei Aliquots aufgeteilt:
- _+RNase_: Mit RNase A behandelte DNA (Inkubation 30 min bei 37 °C).
- _-RNase_: Unbehandelte Kontrollprobe.

In den weiterführenden Schritten wird, sofern nicht anders angegeben, die _+RNase_-Probe verwendet.

== Photometermessung <photometrie-durchfuehrung>

Die spektrophotometrische Analyse dient der zerstörungsfreien Quantifizierung der isolierten Nukleinsäuren sowie der labortechnischen Überprüfung ihres Reinheitsgrades:

+ Extrahierte DNA (_+RNase_ und _-RNase_) im Verhältnis 1:100 in destilliertem Wasser verdünnen. 
  - *Grund:* Die Konzentration der Roh-DNA ist für die Sensitivität des Photometers meist zu hoch (Signal-Sättigung). Eine präzise Verdünnung stellt sicher, dass die Messwerte im linearen Bereich des Lambert-Beer'schen Gesetzes liegen.
+ Messung der Absorption bei 230 nm, 260 nm und 280 nm in 1-cm-Küvetten. 
  - *Grund:* Nukleinsäuren besitzen ihr Absorptionsmaximum bei 260 nm. Proteine absorbieren aufgrund aromatischer Aminosäuren vor allem bei 280 nm, während organische Pufferkomponenten, Salze oder Kohlenhydrate starke Signale bei 230 nm oder darunter erzeugen (siehe @photometrie-theorie).
+ Destilliertes Wasser als Null-Referenz verwenden. 
  - *Grund:* Der physikalische Nullabgleich (Blanking) kalibriert das Gerät und subtrahiert die Eigenabsorption des Lösungsmittels, um ausschließlich das Signal der gelösten Probenbestandteile zu erfassen.
+ Konzentration nach @dna-concentration-equation und Reinheitsquotienten nach @purity-protein-equation und @purity-salt-equation berechnen.

@nornase-spectrum-measured-img  und @rnase-spectrum-measured-img zeigen beispielhafte Spektren. Die Bakterienproben wurden ein zweites Mal gemessen (2. Durchlauf), da die ersten Messwerte nicht plausibel waren.

#{
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
}

== Restriktionsenzym-Verdau <restriktion-durchfuehrung>

Die enzymatische Fragmentierung dient als funktioneller Nachweis der DNA-Qualität und überprüft, ob Verunreinigungen die katalytische Aktivität sensitiver molekularbiologischer Werkzeuge inhibieren:

Die DNA wird mit den in @table-restr-distr aufgeführten Restriktionsenzymen behandelt. Für jedes Enzym wird der entsprechende Standardpuffer verwendet (@table-restr-enzyme-sequences).

+ Reaktionsansatz: DNA, Restriktionsenzym, 10× Reaktionspuffer, Wasser auf Endvolumen bringen. 
  - *Grund:* Der spezifische 10-fach konzentrierte Puffer stellt durch Verdünnung im Endvolumen exakt den pH-Wert und die Salzkonzentration (insb. Magnesiumionen) ein, die das jeweilige Enzym für seine dreidimensionale Stabilität und katalytische Funktion benötigt.
+ Inkubation 1–2 h bei 37 °C im Wasserbad. 
  - *Grund:* Die Temperatur von 37 °C entspricht dem physiologischen Optimum der verwendeten Endonukleasen, bei dem sie die Phosphodiesterbindungen innerhalb ihrer Erkennungssequenz mit maximaler Spezifität spalten.
+ Reaktion durch Erhitzen auf 65 °C für 20 min (je nach Enzym) oder direkte Verwendung im Gel stoppen. 
  - *Grund:* Die thermische Behandlung denaturiert das Enzym irreversibel (Hitzestopp), um ein unkontrolliertes Nachschneiden nach Versuchsende zu verhindern. Alternativ stoppen die im Ladepuffer der Elektrophorese enthaltenen Detergenzien die Enzymaktivität sofort durch Entfaltung der Proteinstruktur.

== Gelelektrophorese <gelelektrophorese-durchfuehrung>

Die präparative und analytische elektrophoretische Trennung erlaubt die visuelle Beurteilung der Fragmentlängen sowie der molekularen Integrität der Proben:

+ 0,8–1,0 % Agarosegel in TAE/TBE-Puffer gießen, mit Ethidiumbromid anfärben. 
  - *Grund:* Eine Agarose-Konzentration von unter 1 % erzeugt ein weitporiges Netzwerk, das optimal für die Auftrennung großer DNA-Fragmente und hochmolekularer gDNA geeignet ist. Der Laufpuffer liefert die notwendigen Ionen für den Stromfluss, während Ethidiumbromid als Fluoreszenzmarker interkaliert, um die DNA unter UV-Licht sichtbar zu machen.
+ DNA-Proben mit Ladepuffer anmischen und zusammen mit GeneRuler 1 kb Plus Marker laden. 
  - *Grund:* Das im Ladepuffer enthaltene Glycerin erhöht die Dichte der Probe, sodass diese sauber auf den Boden der Geltaschen sinkt, anstatt im Laufpuffer zu diffundieren. Der mitlaufende Größenstandard (Marker) dient als Referenzskala zur exakten Längenbestimmung.
+ Elektrophorese bei ca. 5–8 V/cm für 45–60 min durchführen. 
  - *Grund:* Die gewählte Feldstärke gewährleistet eine zügige Wanderung der negativ geladenen DNA zur Anode (Pluspol), verhindert jedoch eine zu starke Wärmeentwicklung im Gel, die zu unscharfen, verschwommenen Banden führen würde.
+ Dokumentation unter UV-Licht.
  - *Grund:* Die Anregung mit UV-Licht bringt das interkalierte Ethidiumbromid im Wellenlängenbereich der DNA-Banden zum Fluoreszieren und erlaubt das Anfertigen eines digitalen Gelbildes.

Es wurden folgende Probenkombinationen untersucht:
+ *Leber*: _-RNase_, _+RNase_ (unrestriktiert)
+ *Bakterien*: _-RNase_, _+RNase_ (unrestriktiert)
+ *Leber*: _+RNase_ mit Restriktionsenzymen (EcoRI, NaeI, PstI)


#new-chapter[Ergebnisse]

#let relevant-data = (
  ..photometrie-data.filter(it => (
    it.sample_source == "Leber" and it.trial == 1
  )),
  ..photometrie-data.filter(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )),
)

Die Ergebnisse sind nach Probengruppe (Leber, Bakterien) und quantitativer Auswertung gegliedert. Jeder Teilabschnitt folgt dem Muster Darstellung → Erläuterung → Interpretation → Schlussfolgerung.

== Leberproben

=== Isolierung und Photometrie <leber-photometrie>

#result-section(
  darstellung: [
    #{
      show: figure.with(
        caption: [Photometrische Einzelmesswerte der Leberproben (1. Durchlauf). Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
      )
      table-photometrie-results(relevant-data.find(it => (
        it.sample_source == "Leber" and it.trial == 1
      )))
    } <table-photometrie-results-leber>
  ],
  erlaeuterung: [
    @table-photometrie-results-leber listet die nach @dna-concentration-equation berechneten Konzentrationen sowie die Reinheitsquotienten aller Leberproben. Die Konzentrationen liegen zwischen ca. 10 und 400 #sym.mu\g DNA/ml. Die Absorptionsquotienten $E_260 slash E_280$ und $E_260 slash E_230$ weichen bei den meisten Proben deutlich von den Referenzwerten in @reference-values-table ab.
  ],
  interpretation: [
    Im Vergleich zum Referenzwert von $E_260 slash E_280 approx 1.8$ sind fast alle Proben verunreinigt. Die Probe NS +RNase weist mit $E_260 slash E_280 = 1.7$ und $E_260 slash E_230 = 2.0$ die geringsten Abweichungen auf und nähert sich den Idealwerten am ehesten. Die hohen Konzentrationen bei TP und SG deuten auf erfolgreiche Extraktion, aber gleichzeitig auf Protein- oder Phenol-Kontamination hin (niedrige $E_260 slash E_280$-Werte).
  ],
  schlussfolgerung: [
    Die Leber-Extraktion lieferte in allen Fällen nachweisbare DNA in relevanten Konzentrationen. Die Reinheit ist jedoch durchweg suboptimal; nur die Probe NS erfüllt die Referenzwerte annähernd. Das Ziel der Konzentrationsbestimmung wurde erreicht, das Ziel einer hochreinen DNA nur teilweise.
  ],
)

=== RNase-Nachweis <leber-rnase>

#result-section(
  darstellung: [
    #figure-leber-unrestr-gel <annotated-leber-unrestr-gelelectro-img>
    #figure-genruler-ladder <genruler-1kb-plus-img>
  ],
  erlaeuterung: [
  
    @annotated-leber-unrestr-gelelectro-img zeigt das elektrophoretische Trennmuster der unverdauten Nukleinsäureisolate aus Schweineleber im direkten Vergleich mit dem Längenstandard GeneRuler 1 kb Plus (@genruler-1kb-plus-img). In allen Spurpaaren der Studierenden (LS, SG, NS, TP, SS) ist am obersten Probenrand, oberhalb der größten Markerbande von 20 kbp, eine intensiv fluoreszierende, scharfe Hauptbande lokalisiert. 

    Am unteren Ende des Gels (Vortriebsfront) zeigt sich bei den unbehandelten Proben (blau umrandet, _-RNase_) eine stark leuchtende, gelb-orange fluoreszierende Stoffwolke im extrem niedermolekularen Bereich (< 100 bp). Bei den parallel aufgetragenen, mit RNase A behandelten Ansätzen (grün umrandet, _+RNase_) ist diese niedermolekulare Fluoreszenzwolke signifikant verändert: Bei den Proben (vor allem bei SG, TP und SS) ist eine deutliche Signalabschwächung erkennbar ist. Von den Taschen abwärts zieht sich zudem bei allen Proben ein kontinuierlicher vertikaler Schmierstreifen durch die mittleren Gelbereiche.
  ],
  interpretation: [
    Die ausgeprägte, scharfe Bande direkt an den Lichttaschen (> 20 kbp) belegt den Erfolg der Isolation: Die genomische DNA liegt hochmolekular und weitgehend unfragmentiert vor, da ihre enorme Molekülgröße das Agarose-Porennetzwerk kaum durchwandern lässt. Der nachfolgende vertikale Schmier (ca. 1–40 kbp) repräsentiert teils mechanisch gescherte gDNA-Fragmente sowie heterogene, höhermolekulare RNA-Spezies (wie mRNA). 

    Die intensiv leuchtende Signalwolke am unteren Gelrand der _-RNase_-Kontrollproben macht den erwartungsgemäß hohen Anteil an co-isolierter zellulärer RNA (vorwiegend kleine ribosomale RNA-Fragmente und tRNAs) sichtbar. Der direkte visuelle Vergleich mit den _+RNase_-Spuren liefert den eindeutigen Beweis für die erfolgreiche enzymatische Aktivität der RNase A. Durch die Hydrolyse der einzelsträngigen RNA in winzige Ribonukleotide verliert diese ihre Fähigkeit, den interkalierenden Fluoreszenzfarbstoff effizient zu binden, oder wandert aufgrund der minimalen Größe vollständig aus der Gelmatrix heraus. 

    Dieses Gelbild klärt zudem eine zentrale Diskrepanz zur quantitativen Auswertung auf: In den photometrischen Daten (@table-photometrie-results-leber) war nach der RNase-Behandlung kein konsistenter Rückgang der Absorption zu verzeichnen. Da freie Ribonukleotide im Photometer weiterhin bei 260 nm absorbieren und somit fälschlicherweise intakte Nukleinsäuren vortäuschen, liefert erst die Gelelektrophorese den makromolekularen Beweis für den tatsächlichen Abbau der kontaminierenden RNA.
  ],
  schlussfolgerung: [
  Der qualitative Nachweis des erfolgreichen RNA-Abbaus sowie der Isolation intakter, hochmolekularer gDNA aus Schweineleber wurde mittels Agarose-Gelelektrophorese zweifelsfrei erbracht. Während die rein photometrische Konzentrationsbestimmung durch verbliebene Bruchstücke fehleranfällig bleibt, validiert das visuelle Bandenmuster das Erreichen der Kernziele für die eukaryotischen Proben vollständig.
  ],
)

=== Restriktionsverdau <leber-restriktion>

#result-section(
  darstellung: [
    #figure-leber-restr-gel <annotated-leber-restr-gelelectro-img>
  ],
  erlaeuterung: [
    @annotated-leber-restr-gelelectro-img zeigt das Agarosegel der mit Restriktionsenzymen behandelten gDNA-Isolate aus Schweineleber für die Probenansätze SS, LS und SG. Ein markanter Unterschied zeigt sich im Vergleich zum unrestriktionerten Gel (@annotated-leber-unrestr-gelelectro-img): 

    In den Spuren SG und SS ist die intensiv leuchtende Hochmolekular-Bande direkt am Taschenrand vollständig verschwunden. Stattdessen erstreckt sich über die gesamte Spurlänge ein kontinuierlicher, diffuser und vollkommen gleichmäßiger Schmierstreifen (Smear), der von der hochmolekularen Region (> 20 kbp) bis in den niedermolekularen Bereich von wenigen hundert Basenpaaren reicht. 
    
    Die Spur LS zeigt ein abweichendes Verteilungsmuster: Der Schmierstreifen ist im Vergleich zu den anderen Spuren in der vertikalen Ausdehnung verkürzt.
  ],
  interpretation: [
    Der erfolgreiche Verdau bestätigt enzymatisch verwertbare DNA trotz photometrisch nachgewiesener Verunreinigungen. Der partielle Verdau bei LS (PstI) kann auf Enzym- oder Reaktionsprobleme zurückzuführen sein.

    Das vollständige Verschwinden der HMW-Ausgangsbande (High Molecular Weight) in den Spuren SG und SS und die Transformation in einen homogenen Schmierstreifen belegen einen erfolgreichen und vollständigen Restriktionsverdau. Da das Genom der Schweineleber hochkomplex ist, enthalten die Chromosomen Millionen von sequenzspezifischen Erkennungsstellen für die Typ-II-Restriktionsenzyme. Das synchrone Schneiden zerlegt die gDNA in eine astronomische Anzahl unterschiedlich langer Fragmente, die aufgrund des logarithmischen Siebeffekts der Agarose als kontinuierlicher Verlauf sichtbar werden. Dies beweist, dass die isolierte DNA in einer enzymatisch hochfunktionalen Qualität vorliegt und keine kritischen Konzentrationen an Polymerase- oder Nuklease-Inhibitoren (wie Phenol oder Ethanol) verschleppt wurden.

Der Befund in Spur LS interpretiert sich primär als partieller (unvollständiger) Restriktionsverdau, wobei jedoch auch die Möglichkeit besteht, dass der Umsatz eigentlich vollständig war und das veränderte Bandenmuster lediglich so wirkt. Als biochemische Ursache für einen unvollständigen Verdau kommt eine partielle Enzyminhibition infrage, beispielsweise durch geringfügige Phenol- oder Salzrückstände aus den Reinigungsschritten (@reinigung-durchfuehrung), die das aktive Zentrum blockiert haben. Eine thermische Degradation oder Alterung des Enzyms kann hierbei jedoch ausgeschlossen werden, da für diesen spezifischen Ansatz eine frische, neue Flasche des Enzyms angebrochen wurde. 

 Ein sehr wahrscheinlicher laborpraktischer Grund für die Inhibition liegt jedoch im Lagerungsmedium des Enzyms selbst: Um Restriktionsenzyme bei -20 °C flüssig und stabil zu halten, sind sie in 50 % Glycerin gelöst. Da Glycerin hochviskos (zähflüssig) ist, kriecht es leicht an den Innenwänden des Vorratsröhrchens hoch. Wenn beim Pipettieren des Enzyms die Pipettenspitze versehentlich an die benetzte Wand geraten ist, führt dies zu einer unbemerkten Verschleppung (Carryover) von konzentriertem Glycerin an der Außenseite der Spitze in den Reaktionsansatz. Übersteigt die finale Glycerinkonzentration im Ansatz den kritischen Grenzwert von 5 %, wird die Enzymaktivität drastisch gehemmt. @src_neb-typ2-restr-enzyme

  ],
  schlussfolgerung: [
    Der funktionelle Nachweis der DNA-Qualität mittels Restriktionsverdau war erfolgreich. Die Isolate zeigen die für nachfolgende molekularbiologische Downstream-Applikationen (wie Klonierungen oder Sequenzierungen) notwendige enzymatische Spaltbarkeit.
  ],
)

== Bakterienproben

=== Isolierung und Photometrie <bakterien-photometrie>

#result-section(
  darstellung: [
    #{
      show: figure.with(
        caption: [Photometrische Einzelmesswerte der Bakterienproben (2. Durchlauf). Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
      )
      table-photometrie-results(relevant-data.find(it => (
        it.sample_source == "Bakterien" and it.trial == 2
      )))
    } <table-photometrie-results-bakterien>
  ],
  erlaeuterung: [
  
    @table-photometrie-results-bakterien dokumentiert die photometrischen Messdaten der Bakterienisolate (E. coli) aus dem zweiten Messdurchlauf, aufgeteilt nach Proben mit und ohne RNase-Behandlung. Die rechnerisch ermittelten Konzentrationen zeigen eine extreme Streuung, die von Totalausfällen mit $0$ bis $-10 #sym.mu\g "DNA/ml"$ (Probe EL) über moderate Werte von $65$ bis $200#sym.mu\g "DNA/ml"$ (Proben AL, IZ, CB) bis hin zu einem formalen Maximum von $480#sym.mu\g "DNA/ml"$ (Probe LH) reicht. 

    Besonders auffällig sind die Reinheitsquotienten: Die Proben CB (sowohl $+$ als auch $-$RNase) und AL ($-$RNase) weisen einen rechnerisch anomalen $E_260 / E_230$-Wert von exakt $6.7$ auf. Zudem sind die Datensätze für CB ($+$ und $-$RNase) sowie AL ($-$RNase) in allen drei Parametern (Konzentration, $E_260/E_280$ und $E_260/E_230$) absolut identisch. Im Gegensatz dazu zeigt die Probe LH zwar die höchste Konzentration, bricht jedoch bei den $E_260 / E_230$-Quotienten auf extrem kritische Werte von $0.9$ bis $1.0$ ein.
  ],
  interpretation: [
    Niedrige Konzentrationen und ungünstige Reinheitsquotienten deuten auf unvollständige Lyse und geringe Ausbeute hin.

    Die detaillierte Betrachtung der Daten offenbart schwerwiegende methodische und messtechnische Probleme während der Isolation und der anschließenden Quantifizierung:

    - *Fehlgeschlagene Isolation / Pelletverlust (Probe EL):* Eine gemessene Konzentration von $0 space #sym.mu\g "DNA/ml"$ bzw. $-10 #sym.mu\g "DNA/ml"$ bedeutet, dass die Probe bei $260"nm"$ weniger Licht absorbiert hat als die reine Wasser-Referenz (Blank). Dies ist ein eindeutiges Zeichen für den vollständigen Verlust der Biomasse. Da bakterielle Pellets nach der Ethanol-Fällung (@faellung-durchfuehrung) winzig und oft kaum sichtbar sind, wurde das DNA-Pellet hier höchstwahrscheinlich beim Abdekantieren des Ethanols unbemerkt mit abgesaugt. Alternativ schlug bereits der Zellaufschluss fehl, da Lysozym ohne vollständige EDTA-Destabilisierung die LPS-Schicht der E. coli-Wand nicht durchbrechen kann.
    - *Extreme Salz- und Pufferkontamination (Probe LH):* Der nominal hohe Wert von über $460 space #sym.mu\g "DNA/ml"$ wird durch die katastrophalen $E_260 / E_230$-Quotienten ($#sym.tilde 0.9$) entwertet. Wie in @photometrie-theorie beschrieben, absorbieren Guanidinsalze aus dem Lysepuffer oder Ethanolreste bei $230"nm"$ extrem stark. Ein so niedriger Quotient beweist ein unzureichendes Waschen des Pellets. Da diese Salze auch bei $260"nm"$ leicht miterfasst werden, ist die hohe Konzentration hier primär ein Artefakt durch Pufferverschleppung und spiegelt keine echte DNA-Menge wider.
    - *Messtechnische Anomalien und Datenübertragung (Proben CB & AL):* Ein Reinheitsquotient von $E_260 / E_230 = 6.7$ ist biologisch und physikalisch unmöglich, da reine DNA ein Maximum von $#sym.tilde 2.2$ besitzt. Ein solcher Wert entsteht nur, wenn die gemessene Absorption bei $230"nm"$ künstlich nahe gegen Null geht. Dies deutet auf einen systematischen Fehler beim optischen Nullabgleich (Fehl-Blanking) oder eine Verunreinigung der Referenzküvette hin. Die absolute mathematische Identität der Werte zwischen CB und AL ($-$-RNase) lässt zudem stark auf einen Übertragungsfehler oder ein versehentliches wiederholtes Messen derselben physikalischen Probe schließen.
    - *Fehlender RNase-Effekt:* Es gibt keinen systematischen Konzentrationsunterschied zwischen den $+$RNase- und $-$RNase-Proben (z. B. LH: $460 space #sym.mu\g "DNA/ml"$ vs. $480 space #sym.mu\g "DNA/ml"$). Da wachsende Bakterien massive Mengen an zellulärer RNA enthalten, müsste die Konzentration nach dem RNA-Abbau drastisch sinken. Das Ausbleiben dieses Effekts stützt die Vermutung, dass die photometrischen Signale hier primär von freien Nukleotiden, Salzen und optischen Störungen dominiert wurden, was eine verlässliche biologische Aussage unmöglich macht.
  ],
  schlussfolgerung: [
  Das Versuchsziel, gDNA aus E. coli-Kulturen photometrisch verlässlich zu charakterisieren, wurde nicht erreicht. Die Daten des zweiten Durchlaufs sind durch eine Kombination aus biologischen Isolationsfehlern (Salz-Carryover, Pelletverlust) und schweren messtechnischen Artefakten (anomale Quotienten, identische Datensätze) kompromittiert. Für zukünftige Versuche ist eine strengere Kontrolle des Waschschritts sowie eine visuelle Überprüfung des Nullabgleichs am Photometer zwingend erforderlich.
  ],
)

=== RNase und Restriktion <bakterien-rnase>

#result-section(
  darstellung: [
    #figure-bakterien-unrestr-gel <annotated-bakterien-unrestr-gelelectro-img>
    //#figure-erwartung-unrestr-bakterien <erwartung-unrestr-bakterien-gel-img>
   // #figure-erwartung-restr-bakterien <erwartung-restr-bakterien-gel-img>

    #pad(top: 0.5em)[
      #grid(
        columns: 2,
        gutter: 1em,
        align: top,
        figure-erwartung-unrestr-bakterien,
        figure-erwartung-restr-bakterien
      )
    ]
  ],
  erlaeuterung: [
    In @annotated-bakterien-unrestr-gelelectro-img fehlt die erwartete Hochmolekular-Bande am Gelanfang. Es ist nahezu kein Fluoreszenzsignal erkennbar. Abbildung 14 und Abbildung 15 zeigen die Soll-Befunde aus der Literatur.

    @annotated-bakterien-unrestr-gelelectro-img zeigt das Agarosegel der unverdauten Bakterienisolate im direkten Vergleich zum Literatur-Sollbefund einer erfolgreichen gDNA-Isolation (Abbildung 14). Im Gegensatz zum Sollbild, das eine scharfe, intensiv leuchtende Hochmolekular-Bande direkt unterhalb der Geltaschen aufweist, ist in fast allen Spuren der Studierenden (EL, LH, AL) keinerlei Fluoreszenzsignal sichtbar; die Gelspuren präsentieren sich als vollständig leer. 

    Eine markante Ausnahme bildet die Probe CB: In der unbehandelten Kontrollspur ($-$RNase, blau umrandet) zeigt sich zwar ebenfalls keine hochmolekulare gDNA-Bande, jedoch ist im extrem niedermolekularen Bereich nahe der Laufmittelfront eine intensiv leuchtende, rosa-orange Fluoreszenzwolke lokalisiert. In der direkt daneben aufgetragenen, behandelten Spur ($+$RNase, grün umrandet) ist dieses niedermolekulare Signal vollständig ausgelöscht. Ein analoges, wenn auch minimal schwächeres Signal im Frontbereich ist bei der Probe AL ($-$RNase) zu erahnen, welches in der zugehörigen $+$RNase-Spur ebenfalls verschwindet.
  ],
  interpretation: [
    Das fast vollständige Fehlen von hochmolekularen Banden am oberen Gelrand bei allen Proben beweist das makromolekulare Fehlschlagen der bakteriellen Genom-Isolation. Die biochemischen Ursachen hierfür lassen sich anhand der differenzierten Spurbefunde präzise eingrenzen:

    - *Unvollständige Lyse der gramnegativen Zellwand (Proben EL, LH, AL):* Die absolute Signalosigkeit (weder DNA noch RNA sichtbar) deutet darauf hin, dass die bakteriellen Zellen nicht ausreichend aufgeschlossen wurden. Wie in @genome-architektur-theorie beschrieben, blockiert die äußere Lipopolysaccharid-Schicht (LPS) gramnegativer Bakterien den Zugriff des Enzyms Lysozym auf das Mureingerüst. Wenn das EDTA im Lysepuffer unterdosiert war oder die Einwirkzeit nicht ausreichte, um die stabilisierenden Calcium- und Magnesiumionen zu chelatisieren, blieb dieser Schutzschild intakt. Die Zellen wurden beim anschließenden Zentrifugieren ungeöffnet als Debris sedimentiert und verworfen. Alternativ kam es auch hier zu einem vollständigen Verlust des winzigen DNA-Pellets während des Dekantierens bei der Ethanol-Fällung.
    - *Partieller Aufschluss und enzymatischer Erfolg (Probe CB):* Der intensive niedermolekulare Fluoreszenzschmier in der $-$-RNase-Spur von CB belegt, dass hier zumindest ein Teil der Bakterienzellen erfolgreich lysiert wurde, wodurch die massenhaft vorhandene zelluläre RNA (tRNA, 5S/16S/23S rRNA) freigesetzt und isoliert werden konnte. Das vollständige Verschwinden dieses Signals in der $+$-RNase-Spur liefert den qualitativen Funktionsbeweis der eingesetzten RNase A. 
    - *Warum fehlt bei CB dennoch die genomische DNA?* Da RNA isoliert wurde, war das Pellet physikalisch vorhanden. Das Fehlen der HMW-DNA-Bande lässt sich durch eine mechanische Zerstörung (Scherung) der riesigen, ringförmigen Bakterienchromosome durch zu abruptes Vortexen oder Pipettieren erklären. Fragmentierte DNA läuft als diffuser, schwacher Hintergrundschmier durch das Gel und verliert bei geringen Konzentrationen jegliche visuelle Nachweisgrenze. Zudem führt ein unvollständiges Abfangen von Magnesiumionen durch EDTA dazu, dass bakterielle endogene DNasen reaktiviert werden und die genomische DNA noch während der Lysephase enzymatisch degradieren.

    Da im unrestriktionerten Gel bereits keine gDNA nachweisbar war, erübrigte sich die elektrophoretische Auswertung der präparierten Restriktionsansätze; ein künstlich erzeugter Verdau lässt sich ohne detektierbares Ausgangsmaterial analytisch nicht darstellen.
  ],
  schlussfolgerung: [
   Die methodischen Ziele bezüglich der prokaryotischen Modellorganismen wurden gelbildlich nicht erreicht. Während die Funktionalität des RNase-Verdaus über die RNA-Komponente der Probe CB erfolgreich validiert werden konnte, blieben die Kernziele der gDNA-Visualisierung und der anschließenden Restriktionsanalytik aufgrund von Lysisdefiziten und Nukleaseaktivitäten unerreicht. Der Versuch unterstreicht die methodische Notwendigkeit einer präzise abgestimmten EDTA-LPS-Destabilisierung beim Umgang mit gramnegativen Zellwänden.
  ],
)

== Quantitative Auswertung

=== Statistische Auswertung <statistik>

#result-section(
  darstellung: [
    #{
      show: figure.with(
        caption: [Beschreibende Statistik: Mittelwert $plus.minus$ Standardabweichung. Konzentration [#sym.mu\g DNA/ml], Reinheitsquotienten [$-$].],
      )
      table-descriptive-statistics(relevant-data)
    } <table-descriptive-statistics>

    Leider lässt sich aus den Daten in @table-descriptive-statistics keine Gesamtausbeute in mg DNA/g Leber berechnen, da das Endvolumen der Aufnahme fehlt. Die Tabelle zeigt einen Trend, der auch durch @dna-concentration-comparison-diagram, @boxplot-rnase-concentration-diagram und @grouped-bar-purity-diagram verdeutlicht wird: Die DNA-Konzentration in Leberproben ist deutlich höher als in Bakterienproben.
    
*Erläuterung: * \
    @table-descriptive-statistics fasst die berechneten Mittelwerte und deren zugehörige Standardabweichungen ($"Mean" plus.minus "SD"$) für beide Versuchsansätze zusammen. Ein direkter Vergleich zeigt, dass die mittleren DNA-Konzentrationen der Leberproben mit $2138 plus.minus 1355.2 space #sym.mu\g "DNA/ml"$ ($+$RNase) beziehungsweise $1627 plus.minus 963.2 space #sym.mu\g "DNA/ml"$ ($-$RNase) um ein Vielfaches höher liegen als die der Bakterienisolate, welche lediglich $170 plus.minus 178.2 space #sym.mu\g "DNA/ml"$ ($+$RNase) und $204 plus.minus 176.7 space #sym.mu\g "DNA/ml"$ ($-$RNase) erreichen. 

    Auffallend sind die extrem weiten Standardabweichungen in allen Konzentrationsmessungen, die teilweise fast die Höhe des eigentlichen Mittelwertes erreichen oder diesen (wie bei den Bakterien) sogar übersteigen. Bei den Reinheitsquotienten verharren die Leberproben stabil bei einem suboptimalen $E_260 / E_280$-Wert von $1.5 plus.minus 0.1$. Die Bakterienproben fallen hier auf $1.2 plus.minus 0.7$ bzw. $1.2 plus.minus 1$ ab. Im Bereich der $E_260 / E_230$-Quotienten zeigt die Leber-$-$RNase-Gruppe eine starke Streuung von $2 plus.minus 1$, während die Bakterien mit Werten von bis zu $3.2 plus.minus 3.2$ mathematisch anomale Varianzen aufweisen.

*Interpretation: *\
    Die deskriptive Statistik verdeutlicht die methodischen Kernunterschiede und Fehlerquellen des gesamten Kursdurchlaufs:

    - *Massen- und Lysis-Diskrepanz:* Der gravierende Konzentrationsunterschied zwischen Gewebe und Bakterien spiegelt primär die biologisch eingesetzte Biomasse wider. Während bei der Leber eine massive Gewebemenge mechanisch homogenisiert wurde, stand bei *E. coli* nur ein minimales Zellpellet zur Verfügung, dessen Aufschluss zudem durch die bakterielle LPS-Zellwand unvollständig blieb.
    - *Das RNase-Konzentrations-Paradoxon:* Ein unerwarteter biochemischer Befund zeigt sich bei den Leberproben: Nach der RNase-Behandlung *steigt* der Konzentrationsmittelwert formal von $1627 space #sym.mu\g "DNA/ml"$ auf $2138 space #sym.mu\g "DNA/ml"$. Theoretisch müsste der enzymatische Abbau der RNA zu einer Abnahme der Gesamtabsorption bei 260 nm führen. Dieses Paradoxon lässt sich durch zwei Effekte erklären: Zum einen liegt hier ein *hyperchromer Effekt* vor. Wenn die RNase A die hochstrukturierte, einzelsträngige RNA in kurze Fragmente und freie Nukleotide zerlegt, verringert sich die Basenstapelung. Die freigelegten Basen absorbieren UV-Licht der Wellenlänge 260 nm signifikant *intensiver* als im intakten RNA-Strang, was dem Photometer eine künstlich erhöhte DNA-Menge vortäuscht. Zum anderen begünstigt die 30-minütige Inkubation bei 37 °C die Verdunstung von minimalen Flüssigkeitsmengen in den Mikroreaktionsgefäßen, was zu einer physikalischen Aufkonzentrierung der Probe führt.
    - *Auswertung der Reinheitsdefizite:* Der Proteinquotient ($E_260 / E_280$) liegt mit $1.5$ bei der Leber reproduzierbar unter dem Reinheitsoptimum von $1.8$ (@reference-values-table), was eine systematische Verschleppung von residualen Proteinen oder Phenolresten beweist. Bei den Bakterien bricht dieser Wert vollständig ein ($1.2$). Die dort beobachtete, gigantische Standardabweichung von $1$ zeigt, dass die Messungen in dieser Gruppe nicht mehr im verlässlichen Vertrauensbereich des Photometers lagen. 
    - *Anomale Salzquotienten:* Für reine DNA wird ein $E_260 / E_230$-Verhältnis von maximal $2.2$ erwartet. Ein statistischer Mittelwert von $2.5$ ($+$RNase) bzw. $3.2$ ($-$RNase) bei den Bakterien ist physikalisch unmöglich. Er resultiert, wie in @bakterien-photometrie interpretiert, aus einem gegen Null tendierenden Nenner ($E_230$), verursacht durch systematische Fehl-Blankings am Messgerät. Die riesige Standardabweichung von $3.2$ untermauert, dass es sich hierbei um extreme methodische Ausreißer handelt, die den Gesamtmittelwert verzerren.
    - *Ursachen der enormen Streuung (SD):* Die massiven Standardabweichungen in allen Gruppen sind das klassische Resultat eines Studentenlabors. Ungenauigkeiten beim Abpipettieren der wässrigen Phase, variierende Verluste des DNA-Pellets beim Dekantieren des Ethanols sowie inhomogen pürierte Gewebestücke führen dazu, dass sich Einzelfehler mathematisch zu einer enormen Gesamtvarianz aufschaukeln.

*Schlussfolgerung: * \
    Die mathematische Auswertung bestätigt die qualitativen Befunde der Gelelektrophorese, erweitert diese jedoch um kritische messtechnische Erkenntnisse. Konzentrationsangaben aus spektrophotometrischen Messungen dürfen in der Praxis niemals blind übernommen werden, da Effekte wie die Hyperchromie nach RNase-Verdau oder Salzverschleppungen (LH) künstliche Scheinkonzentrationen erzeugen. Für zukünftige Versuchsreihen zeigt die Statistik deutlich, dass eine saubere laborpraktische Standardisierung (z. B. automatisierte Homogenisierung und standardisierte Waschzyklen) zwingend erforderlich ist, um die enorme Streuung innerhalb der Datensätze auf ein wissenschaftlich verwertbares Maß zu reduzieren.



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
  ],
  schlussfolgerung: [
    Die deskriptive Statistik bestätigt den qualitativen Befund: Leber-DNA in hohen Konzentrationen, aber meist verunreinigt; Bakterien-DNA kaum nachweisbar. Eine RNase-bedingte Konzentrationsänderung ist im Mittel nicht erkennbar.
  ],
)

=== Hypothesentests <hypothesentests-chapter>

*Verwendete Testformeln*

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

#result-label[Schlussfolgerung][
  Keiner der durchgeführten Hypothesentests ergab signifikante Unterschiede. Dies ist vor allem auf den geringen Stichprobenumfang ($n = 5$–$10$) zurückzuführen.
]

#new-chapter[Diskussion]

== Gesamtinterpretation

Die Ergebnisse der genomischen DNA-Isolation zeigen ein deutliches Zweiteilungsbild: Die Extraktion aus Schweineleber gelang grundsätzlich, während die bakterielle Isolierung aus *E. coli* weitgehend fehlschlug.

*Leberproben:* Photometrisch wurde DNA in allen Proben nachgewiesen (@leber-photometrie), jedoch mit überwiegend ungünstigen Reinheitsquotienten. Im Agarosegel war Hochmolekular-DNA sichtbar (@leber-rnase); RNase reduzierte die RNA-Kontamination bei einzelnen Proben. Der Restriktionsverdau bestätigte die enzymatische Verwertbarkeit der DNA (@leber-restriktion).

*Bakterienproben:* Weder Gel noch Photometrie lieferten überzeugende Ergebnisse (@bakterien-photometrie, @bakterien-rnase). Die Soll-Befunde aus der Literatur (Abbildung 14, Abbildung 15) konnten nicht reproduziert werden.

#{
  show: figure.with(
    caption: [Soll-Ist-Vergleich der zentralen Versuchsbefunde.],
  )
  table-soll-ist-vergleich
} <soll-ist-vergleich-table>

*Gesamtbewertung der Zielsetzung:*
+ Isolierung Leber: *erreicht* (DNA nachweisbar, Gel positiv)
+ Isolierung Bakterien: *nicht erreicht*
+ RNase-Nachweis: *teilweise erreicht* (Leber ja, Bakterien nein)
+ Konzentrationsbestimmung: *erreicht* (Leber), *nicht erreicht* (Bakterien)
+ Restriktionsverdau: *erreicht* (Leber), *nicht auswertbar* (Bakterien)

Das Studentenlabor eignet sich gut, um die Prinzipien der Phenol-Chloroform-Extraktion, Photometrie und Gelelektrophorese zu erlernen. Für quantitative oder klinische Anwendungen wären standardisierte Kits und größere Stichproben erforderlich.

== Fehlerquellen

=== Probenvorbereitung

- *Zu wenig Bakterienpellet:* Durch unzureichendes Abzentrifugieren der Kultur war das Ausgangsmaterial zu gering, was die fehlende DNA-Ausbeute erklärt (@bakterien-photometrie).
- *Gewichtsschwankungen der Leberproben:* Die eingesetzten Massen lagen zwischen 3,5 und 4,4 g (@table-liver-weights); ein Zusammenhang zur Konzentration war statistisch nicht nachweisbar ($r approx #calc.round(correlation, digits: 2)$).

=== Lyse und Extraktion

- *Gramnegative Zellwand:* Lysozym allein reichte offenbar nicht aus, die LPS-haltige Außermembran von *E. coli* zu durchbrechen (@bakterien-rnase).
- *Unvollständige Gewebehomogenisierung:* Grobe Gewebefragmente können die Proteinase-K-Lyse verzögern.

=== Reinigung und Aufreinigung

- *Phenol-Carryover:* Senkt $E_260 slash E_230$ und hemmt Enzyme; erklärt die photometrisch nachgewiesenen Verunreinigungen bei Leberproben.
- *Mechanische DNA-Schädigung:* Vorschnelles Pipettieren erzeugt den mittleren Schmier im Gel (@leber-rnase).

=== RNase-Behandlung und Photometrie

- *Unvollständiger RNA-Abbau:* RNase wurde erst nach der Extraktion zugesetzt; RNA kann bereits in $E_260$ einfließen.
- *Falsche Verdünnung oder Küvettenfehler:* Erklärt die Notwendigkeit der zweiten Bakterienmessung.

=== Restriktionsverdau und Gelelektrophorese

- *Partieller Verdau (LS, PstI):* Mögliche Ursachen: abgelaufenes Enzym, falscher Puffer oder inhibitorische Verunreinigungen.
- *Probe verwechselt oder überladen:* Erklärt anomale Bakterien-Gelspuren.

=== Statistik

- *Zu kleine Stichprobe:* Mit $n = 5$ (Leber) bzw. $n = 5$ (Bakterien) ist die Teststärke zu gering, um moderate Effekte nachzuweisen (@hypothesentests-chapter).
- *Ausreißer:* Einzelne Proben (z. B. TP, SG) mit extrem hohen Konzentrationen verzerren Mittelwert und Standardabweichung.

#set heading(numbering: none)
#new-chapter("Anhang")

== Rohdaten und Versuchsangabe

#pdf.attach(
  "../instructions/Isolierung.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe für die Isolation von genomischer DNA",
)

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

Die Versuchsangabe und Messdaten sind als eingebettete Anhänge im PDF verfügbar.

== Quellen

#bibliography("../bib.yaml", title: none, style: "apa")

== Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

== Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

