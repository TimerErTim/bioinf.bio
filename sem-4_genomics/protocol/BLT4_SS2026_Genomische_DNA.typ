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

=== Genomarchitektur und Unterschiede zwischen Proben <genome-architektur-theorie>

Wie die DNA-Extraktion abläuft, hängt davon ab, ob man mit tierischen oder bakteriellen Zellen arbeitet. Die genomische DNA (gDNA) findet man in der Zelle nicht einfach frei schwimmend, sondern sie ist mit Proteinen verbunden und von Zellhüllen umgeben. @src_molecular-biology-of-the-cell

- *Eukaryotische DNA (Schweineleber)*: Das Genom der Schweineleberzellen (etwa 2,8 Milliarden Basenpaare, 38 Chromosome) ist stark gepackt, weil es um spezielle, positiv geladene Proteine (Histone) gewickelt ist, wodurch Chromatin entsteht. @src_molecular-biology-of-the-cell Außerdem enthalten Leberzellen sehr viel RNA, vor allem rRNA und mRNA. Aufgrund der hohen Stoffwechselaktivität kann der Anteil bis zu 80-90 % der Nukleinsäuren ausmachen. @src_lodish-molecular-cell-biology Deshalb braucht man Proteine abbauende Enzyme wie Proteinase K, um die Histone zu entfernen. Für den Abbau der RNA gibt man RNase dazu. Eine zu erwartende Ausbeute beträgt 3-4 mg DNA pro Gramm Leber. @src_csh-protocols-isolation

- *Prokaryotische DNA (E. coli)*: Bei Bakterien wie E. coli liegt die DNA als ein ringförmiges Chromosom mit rund 4,6 Millionen Basenpaaren ohne Histone vor und ist durch Supercoiling kompakter gemacht. @src_brock-mikrobiologie Das größte Problem bei der Extraktion ist die Zellwand. E. coli besitzt als gramnegatives Bakterium eine dicke äußere Schicht aus Lipopolysacchariden (LPS), die das Enzym Lysozym daran hindern kann, die Zellwand aufzubrechen. Erst wenn diese äußere Schicht zum Beispiel mit Hilfe von EDTA gestört wird, kann die darunterliegende Mureinschicht angreifbar werden. Bleibt sie intakt, klappt die Lyse nicht und es kann keine DNA extrahiert werden. @src_csh-bacterial-cell-envelope

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

Meist wird die Probe mit einem Färbemittel angereichert, das unter UV-Licht deutlich sichtbar wird und so Bandenmuster entstehen lassen. Im Fall von Ethidiumbromid korreliert die Leuchtkraft mit der Masse der DNA-Fragmente.
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
      show: figure.with(
        caption: [Beispiel für das gemessene Spektrum bei einer Probe _-RNase_.],
      )
      set rect(inset: 0pt)
      image("../assets/nathalie_raw_spektrum.png", width: 100%)
    },
    {
      show: box
      show: it => [#it <rnase-spectrum-measured-img>]
      show: figure.with(
        caption: [Beispiel für das gemessene Spektrum bei einer Probe _+RNase_.],
      )
      set rect(inset: 0pt)
      image("../assets/nathalie_rnase_spektrum.png", width: 100%)
    },
  )
})

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
  ..photometrie-data.filter(it => (
    it.sample_source == "Leber" and it.trial == 1
  )),
  ..photometrie-data.filter(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )),
)

Zuerst werden die Ergebnisse visuell interpretiert bevor sie anschließend statistisch ausgewertet werden.

== Leberproben <leberproben>

Aufgrund der scheinbar an sich erfolgreichen DNA-Extraktion können Gelelektrophoresen für unrestriktierte und mit Restriktionsenzymen verdaute DNA durchgeführt werden.

=== Unrestriktierte Leber-DNA <unrestriktierte-leber-dna-chapter>

@annotated-leber-unrestr-gelelectro-img bestätigt, dass die DNA-Extraktion grundsätzlich erfolgreich war. Die ganz dicke Schicht am oberen Rand des Gels ist die DNA, die aufgrund der extrem hohen bp Länge nicht durch die Gelporen passieren konnte. Der Schmier in der Mitte ist vermutlich durch mechanische Belastung (Pipettieren) zerrissene DNA oder eine Überlappung von unterschiedlich langen mRNAs. Die helle Wolke am unteren Rand besteht wahrscheinlich aus sehr kleinen RNA-Fragmenten bzw. -Kontaminationen. Hinzugabe der RNase reduziert diese Kontaminationen und somit auch die Wolke. Das Bild zeigt, dass dies grundsätzlich der Fall ist. Bei den Proben von SG, TP und SS ist dieser Effekt deutlich zu sehen.

Der Schmier in der Mitte macht sichtbar, was bereits in @genome-architektur-theorie erwähnt wurde: Leberzellen sind sehr Stoffwechselaktiv und im Bild abgeschätzt macht dieser Schmier in etwa \~85% der Gesamtmasse der Probe aus (abzüglich der RNA-Kontaminationen am unteren Rand).

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

Links im Bild wird der Marker aus @genruler-1kb-plus-img in der durchgeführten Gelelektrophorese gezeigt. Die verschiedenen Banden entsprechen den verschiedenen DNA-Fragmenten in der Probe. Dieser endet bei 20 kbp in der oberen Grenze. Die genomische DNA liegt deutlich darüber. Er zeigt aber auch, dass sich die mittlere Schmier sich ungefähr im Bereich 1 - 40 kbp befindet. Das könnte oben erwähnte zerbrochene DNA-Fragmente oder mRNA sein.

#{
  show: figure.with(
    caption: [Marker für die Gelelektrophorese: GeneRuler#super[TM] 1 kb Plus DNA Ladder.],
  )
  image("../assets/genruler-1kb-plus.png")
} <genruler-1kb-plus-img>

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
  show: figure.with(
    caption: [Photometrische Messwerte und umgerechnete Konzentration aller Leberproben.],
  )
  table-photometrie-results(relevant-data.find(it => (
    it.sample_source == "Leber" and it.trial == 1
  )))
} <table-photometrie-results-leber>

@table-photometrie-results-leber zeigt die Einzelmesswerte bzw. Konzentration aus der Photometrie. Dabei fällt auf, dass so gut wie alle Proben stark verunreinigt sind. Die mit Abstand am ehesten nicht verunreinigte Probe ist die von NS +RNase. Bei dieser Probe liegt der $E_260 slash E_280$ Quotient bei 1.7, also nahe dem Idealwert von 1.8 (trotzdem Hinweis auf starke Verunreinigung durch Proteine), der $E_260 slash E_230$ Quotient bei 2.00, also im Idealbereich.

Zudem ist für das bloße Auge kein eindeutiger gepaarter Zusammenhang zwischen _-RNase_ und _+RNase_ Proben zu erkennen. Zu erwarten wäre eine verminderte Konzentration bei der _+RNase_ Probe, da störende Nukleinsäuren aufgrund des RNA Abbaus verringert werden sollten.

=== Restriktionsenzym verdaute Leber-DNA

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

Verglichen zur unrestriktierten Leber-DNA ist in @annotated-leber-restr-gelelectro-img zu sehen, dass die dicke Bande ganz oben verschwindet und stattdessen ein durchgehender Schmierstreifen im ganzen Gel entsteht. Das impliziert einen erfolgreichen Verdau, da kaum noch große (>20 kbp) ungeschnitte Stücke übrig sind. Die Restriktionsenzyme haben also gearbeitet.

Aufgrund der Durchtrennung an unzähligen Stellen enstehen hunderttausende DNA-Fragmente in allen erdenklichen Längen. Sie überlappen und bilden eine Schmier. Daher entsteht auch bei jeder Probe ein nahezu identischer Schmierstreifen.

Dieser Streifen beginnt im intensiven Bereich ab etwa \~20 kbp und endet weit unten bei wenigen hunderten kbp. Auffällig ist die Verkürzung bei der LS Probe, die mit dem Enzym PstI behandelt wurde (entnommen @table-restr-distr). Vermutlich fand hier nur ein partieller Verdau statt. Die Möglichkeit der geringeren DNA-Ausgangsmenge wird aufgrund der Daten in @table-photometrie-results-leber und verglichen gleichstarken visuellen Intensität ausgeschlossen.

Die RNA Menge wird durchwegs gegen 0% geschätzt, da der helle Leuchtstreifen ganz unten fehlt. Zusätzlich kann über den erfolgreichen Verdau auf eine akzeptable Qualität der DNA-Extraktion geschlossen werden, weil Restriktionsenzyme extrem sensibel sind und stark auf chemische Verunreinigen, die sie inhibitieren können, reagieren.

== Bakterienproben <bakterienproben>

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

In @annotated-bakterien-unrestr-gelelectro-img sollte aufgrund der unglaublichen Größe des Bakterien Chromosoms ähnnlich wie in @unrestriktierte-leber-dna-chapter eine dicke Bande ganz oben zu sehen sein, da die extrem lange DNA nicht durch die Gelporen passt. Diese Erwartung konnte bei uns nicht erfüllt werden, was auf eine fehlerhafte DNA-Extraktion hindeuten könnte. Der mittlere Schmier fehlt komplett, was durch zu wenig DNA/RNA, um beim Zerreißen einen sichtbaren Effekt zu erzielen, erklärbar ist. Die leicht helleren Regionen am unteren Rand könnte kleine, restliche RNA oder angesammelter Lauf-Farbstoff aus dem Ladepuffer sein.

Ein visueller Vergleich der Proben mit und ohne RNase gestaltet sich aufgrund der fehlenden Leuchtkraft als schwierig. Prinzipiell haben Bakterien weniger RNA-Masse als stoffwechselaktive Leberzellen. Da allerdings auch in _-RNase_ Proben fast keine Leuchtkraft zu sehen ist, ist anzunehmen, dass die RNA-Menge generell gegen null geht.

Auch hier ist der im Gel verwendete Referenzmarker aus @genruler-1kb-plus-img. Zerrissene Stücke sollte man in etwa im 30 kbp - 100 kbp Bereich erkennen. Bei der durchgeführten Gelelektrophorese ist kein Leuchten zu sehen und daher auch kein Abschätzen möglich. Die zwei Proben mit den anomalen Ergebnissen sind vermutlich auf äußere Fehlerquellen zurückzuführen, wie beispielsweise Verwechslung der Probne, falsche Probne oder Verunreinigungen.

#{
  show: figure.with(
    caption: [Photometrische Messwerte und umgerechnete Konzentration aller Bakterienproben.],
  )
  table-photometrie-results(relevant-data.find(it => (
    it.sample_source == "Bakterien" and it.trial == 2
  )))
} <table-photometrie-results-bakterien>

== Statistik

#{
  show: figure.with(
    caption: [Beschreibende Statistik der DNA-Konzentrationen und Photometrie-Werte der DNA Proben.],
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

Leider lässt sich aus den Daten in @table-descriptive-statistics keine Gesamtausbeute der einzelnen Proben berechnen, da dafür die Information über das Verhältnis der im Photometer gemessenen Menge und der gesamt isolierten Menge fehlt. Die Tabelle zeigt einen Trend, der auch durch @dna-concentration-comparison-diagram verdeutlicht und in sowohl @leberproben als auch in @bakterienproben sichtbar ist: Die DNA Konzentration in Leberproben ist \~12x höher als in Bakterienproben.

#{
  show: figure.with(
    caption: [Diagramm der DNA-Konzentrationen und Verteilung der Leber- und Bakterienproben.],
  )
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

Wie bereits in @photometrie-theorie erwähnt, kann schon ein leicht suboptimales Verhältnis $E_260 slash E_280$ oder $E_260 slash E_230$ auf eine äußerst starke Verunreinigung hindeuten. Diese ist um Durchschnitt bei allen Gruppen gegeben. Trotz eines in den Idealbereich fallenden Durchschnitts beim $E_260 slash E_230$ Quotienten der _-RNase_ Leberprobe ist aufgrund der hohen Standardabweichung davon auszugehen, dass bei der Probengruppe eine starke Verunreinigung vorliegt.

Interessanterweise ist bei RNase-behandelten Proben der Durchschnittswert für die DNA-Konzentration entgegen der intuitiven Vermutung, dass gemessene Nukleinsäuren aufgrund des RNA Abbaus verringert werden, höher als bei unbehandelten Proben.


== Hypothesentests <hypothesentests-chapter>

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

#block(
  sticky: true,
)[*Gibt es einen signifikanten Unterschied ziwschen der DNA-Konzentration in Leber- und Bakterienproben?*]

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
)[*Gibt es einen signifikanten Unterschied ziwschen der DNA-Konzentration in _-RNase_ und _+RNase_ Proben?*]

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

#new-chapter[Diskussion]

== Nicht ermittelte Sollwerte

Da die Gelelektrophoresen bei den Bakterien Proben fehlschlugen, werden hier die erwarteten Sollwerte aus der Literatur diskutiert.

#{
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild der unrestriktierten Bakterien-DNA. @src_unrestr-bakterien-gel-erw_img Verwendert Marker aus @genruler-1kb-plus-img.],
  )
  image("../assets/erwartung-unrestr-bakterien.png")
} <erwartung-unrestr-bakterien-gel-img>

#{
  show: figure.with(
    caption: [Erwartetes Gelelektrophorese-Bild der durch Restriktionsenzyme verdauten Bakterien-DNA. Die Spalten annotiert mit "E" beziehen sich auf Proben aus E. coli Bakterien. @src_restr-bakterien-gel-erw_img],
  )
  set rect(inset: 0pt)
  image("../assets/erwartung-restr-bakterien.png")
} <erwartung-restr-bakterien-gel-img>

In @erwartung-unrestr-bakterien-gel-img sieht man deutlich die in @bakterienproben beschriebene Erwartung, dass die genomische DNA eigentlich viel zu lang ist, um sich durch das Gel zu bewegen. Daher der intensivste Strich am oberen Beginn der Gelbahn. Dazwischen befindet sich ein leichter Schleier, vermutlich bestehend aus durch die Handhabung zerbrochener DNA, der sich bis \~20 kbp erstreckt. Am Ende des Schleiers befindet sich eine letzte hellere Bande, die wohl die untere Grenze der mechanischen Instabilität darstellt. Eine länge von etwa 20 kbp ist sowohl zulang für die mRNA der Gene, als auch für die ribosomale RNA. @src_ecoli-rna-length

@erwartung-restr-bakterien-gel-img zeigt anschaulich, wie sich der Verdau mit Restriktionsenzymen auf die genomische DNA auswirkt. Die Bande 4 dient als Referenz und wurde nicht mit Enzyment behandelt. Diese deckt sich mit der Erläuterung im obigen Absatz. Die anderen Banden sind die Ergebnisse der verschiedenen Restriktionsenzyme. Es ist deutlich zu sehen, wie die DNA der E. coli Bakterien in kleinere Fragmente geschnitten wird und somit weiter im Gel nach unten wandert. Die daraus entstehenden Fragmente sind viel kürzer, die Erkennungssequenzen also viel näher aneinander als in den anderen Proben (L = Lymphozyten, P = Slime Mold).

== Potentielle Fehlerquellen

#block(
  sticky: true,
)[*Fehlende Bakterien-DNA*]
Hauptproblem: Lyse. Aufgrund der extrem zähen Zellwand von Bakterien konnte *Lysozym* diese Barriere nicht durchbrechen und die Bakterien blieben intakt.

Zu Beginn zu wenig Bakterienflüssigkeit abzentrifugiert, sodass ein extrem kleines Start-Pellet zu sehr wenig DNA-Konzentration führte.

#block(
  sticky: true,
)[*Verunreinigte Leber-DNA*]
Das Arbeiten mit DNA erfordert ein hohes Maß an Sorgfalt, reine Laborbedingungen und korrekte Vorgehensweisen. Es könnte die Annahme getroffen werden, dass in einem Studentenlabor, das für persönliche Entwicklung und das Erlauben, Fehler zu machen, vorgesehen ist, diese Vorraussetzungen nicht immer erfüllt sind. Dass dennoch eine recht hoher Reinheitsgrad erzielt werden kann, wird in @leberproben gezeigt. Es wird hier also eher auf menschliche Ungenauigkeiten zurückgeschlossen anstatt auf systematische Fehler.

#block(
  sticky: true,
)[*Statistische nicht-Signifikanz*]
Die Ergebnisse in @hypothesentests-chapter sind nicht signifikant. Das liegt höchstwahrscheinlich an dem extrem niedrigen Stichprobenumfang (10 bzw. 5 Datenpunkte), der schlichtweg keine statistisch signifikanten Aussagen ermöglicht. Auch könnten die Tests selbst keinen Fehler sondern ein richtiges Ergebnis liefern und unter den gearbeiteten Laborbedingungen besteht tatsächlich kein relevanter Unterschied zwischen beispielsweise der DNA-Konzentration mit und ohne RNase. Das ist aber aufgrund des Stichprobenumfangs nicht nachweisbar.

#set heading(numbering: none)
#new-chapter("Anhang")

== Quellen

#bibliography("../bib.yaml", title: none, style: "apa")

== Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

== Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

