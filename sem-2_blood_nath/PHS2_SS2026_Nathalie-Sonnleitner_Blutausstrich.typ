#import "../templates/protocol.tpl.typ": bio-template

#set document(title: "Blutausstrich")
#set text(lang: "de")
#show: bio-template.with(
  show-cover-page: true,
  subtitle: "Zelltyp- und Zellzahlbestimmung",
  author: "Nathalie Sonnleitner",
  course: "PHS2",
  semester: "SS 2026",
  format-page-counter: (current, total) => [
    Seite *#current* / *#total*
  ],
  version: "1.0",
  date: datetime.today(offset: auto).display("[day].[month].[year]"),
)
#show link: it => underline(text(fill: blue)[#it])

// General styling
#outline(depth: 2)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.equation(numbering: "(1)", number-align: start + top)

#pagebreak()

// Content
#pdf.attach(
  "Instructions Blood experiments.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe für den Blutausstrich",
)
#import "@preview/meander:0.4.2"

= Theoretischer Hintergrund

#meander.reflow({
  import meander: *

  placed(
    top + left,
    {
      show: box.with(width: 38%)
      show: it => [#it <bloodsmear-macro>]
      show: figure.with(
        caption: [@src_bloodsmear_macro Blutausstriche auf einer Mikroskopplatte; Unterscheidung zwischen dünnen und dickem Film.],
      )
      show: rect.with(inset: 0pt)
      show: scale.with(x: -100%)
      image("assets/bloodsmear_macro.jpg")
    },
    boundary: contour.margin(5mm),
  )

  placed(
    horizon + right,
    {
      show: box.with(width: 50%)
      show: it => [#it <bloodsmear-microscopy>]
      show: figure.with(
        caption: [@src_bloodsmear_microscopy Mikroskopische Untersuchung eines Blutausstriches. Erkennbar sind die Erythrozyten und Leukozyten.],
      )
      show: rect.with(inset: 0pt)
      image("assets/bloodsmear_micro.jpg")
    },
    boundary: contour.margin(5mm),
    dy: -1cm,
  )

  container()
  content([
    Blutausstriche werden genutzt, um mikroskopisch Zelltypen und deren Zellzahl zu bestimmen. Dazu wird wie in @bloodsmear-macro gezeigt eine Mikroskopplatte mit einem dünnen Blutfilm bestrichen. @src_angabe

    Blutausstriche werden üblicherweise mit Kombinationen aus sauren und basischen Farbstoffen gefärbt, um verschiedene Zelltypen und Zellbestandteile im Blut besser sichtbar zu machen. Bestimmte Bestandteile in den Zellen reagieren unterschiedlich auf diese Farbstoffe, was zu einer charakteristischen Anfärbung führt und die Unterscheidung der einzelnen Zellarten im Mikroskop erleichtert. @src_angabe

    In @bloodsmear-microscopy ist ein Blutausstrich mit saurem und basischem Farbstoff zu sehen. Es sind sowohl Erythrozyten als auch Leukozyten gut erkennbar. Häufig werden die Leukozyten gezählt, um eine Infektion oder eine Entzündung zu diagnostizieren. @src_angabe

    == Erweiterte Theorie zur Zellfärbung <extended-theory-of-cell-staining>

    - *Basophile Strukturen:* Saure Zellbestandteile, wie beispielsweise die DNA im Zellkern oder die RNA im Zytoplasma, ziehen basische (kationische) Farbstoffe an. Farbstoffe wie Methylenblau binden an diese Strukturen und färben sie intensiv blau bis violett. @src_hämatologische_standardfärbung @src_angabe
    - *Eosinophile (azidophile) Strukturen:* Basische Zellbestandteile, zu denen das Hämoglobin in den roten Blutkörperchen oder bestimmte proteinreiche Granula in weißen Blutkörperchen gehören, ziehen saure (anionische) Farbstoffe an. Eosin bindet an diese Strukturen und verleiht ihnen eine typisch rötliche oder rosa Färbung. @src_hämatologische_standardfärbung @src_angabe

    Erythrozyten und bestimmte Leukozytengranula werden von den basischen Farbstoffen unterschiedlich intensiv angefärbt. In diesem Protokoll werden die Blutzellen nach Pappenheim gefärbt, einer sogenannten panoptischen Färbung, die eine Kombination aus der May-Grünwald- und der Giemsa-Färbung darstellt. Der Begriff „panoptisch“ (alles sichtbar machend) bedeutet in diesem Zusammenhang, dass durch die Kombination der beiden Lösungen ein besonders breites Spektrum an Zellbestandteilen angefärbt wird. Dies ist entscheidend, um das Differenzialblutbild exakt auszuwerten und die verschiedenen Arten von Leukozyten (wie Lymphozyten, Monozyten und die verschiedenen Granulozyten) voneinander zu unterscheiden. @src_hämatologische_standardfärbung @src_angabe

    - *May-Grünwald-Lösung:* Diese enthält eosinsaures Methylenblau gelöst in Methanol. Das Methanol dient dabei gleichzeitig als Fixiermittel, um die Zellstrukturen vor der eigentlichen Färbung zu stabilisieren und zu erhalten. @src_angabe
    - *Giemsa-Lösung:* Diese enthält Methylenazur, Methylenviolett, Methylenblau und Eosin, welche in Methanol und Glycerin gelöst sind. @src_angabe
  ])
})

#pagebreak()

= Methodik <methodology>

#meander.reflow({
  import meander: *

  placed(
    horizon + right,
    {
      show: box.with(width: 30%)
      show: it => [#it <bloodsmear-unstained>]
      show: figure.with(
        caption: [Vier Objektträger mit ungefärbten Blutausstrichen unterschiedlicher Dicke.],
      )
      show: rect.with(inset: 0pt)
      image("assets/blutausstrich_objekt_ungefärbt.jpg")
    },
    boundary: contour.margin(5mm),
    dy: -1cm,
  )
  container()

  pagebreak()

  placed(
    top + right,
    {
      show: box.with(width: 35%)
      show: it => [#it <bloodsmear-staining>]
      show: figure.with(
        caption: [Objekträger suspendiert in der Färbelösung.],
      )
      show: rect.with(inset: 0pt)
      image("assets/blutausstrich_einfärbung.jpg")
    },
    boundary: contour.margin(5mm),
  )

  container()
  content([
    Die Vorgehensweise wird vorgegeben #cite(<src_angabe>, form: "full") und die tatsächliche Durchführung im folgenden beschrieben.

    == Sicherheitsvorkehrungen <safety-precautions>

    - *Umgang mit Blut:* Beim Arbeiten mit Blut ist jederzeit das Tragen von Handschuhen verpflichtend, um Infektionsrisiken zu minimieren.
    - *Chemische Gefahren:* Die verwendeten Färbelösungen enthalten toxische Stoffe wie Methanol und sind daher mit besonderer Vorsicht zu handhaben. Direkter Hautkontakt und das Einatmen der Dämpfe sind zu vermeiden.
    - *Färbung:* Da Farblösungen nur äußerst schwer von Haut oder Kleidung zu entfernen sind, ist das Tragen eines Laborkittels und zusätzlicher Handschuhe dringend angeraten.

    == Benötigte Materialien @src_angabe <required-materials>

    - *Mikroskop* (ggf. mit Immersionsöl)
    - *Objektträger*
    - *Ausstrichglas* (Deckglas oder zweiter Objektträger)
    - *Färbewanne*
    - *Pinzette*
    - *May-Grünwald-Lösung*, *Giemsa-Lösung*, *destilliertes Wasser*
    - *Frisches (!) Blut*

    == Durchführung: Herstellung des Blutausstrichs <execution-of-blood-stain>

    + Einen kleinen Tropfen Blut auf das rechte Ende eines sauberen Objektträgers geben.
    + Das Ausstrichglas (zum Beispiel ein weiterer Objektträger) zwischen Daumen und Zeigefinger halten und zentral auf dem liegenden Objektträger in einem Winkel von etwa 45° ansetzen.
    + Das Ausstrichglas vorsichtig an den Bluttropfen heranschieben, sodass sich das Blut an der Kante gleichmäßig verteilt.
    + Anschließend das Ausstrichglas in einem etwa 30°-Winkel gleichmäßig und zügig nach links über den Objektträger ziehen, sodass ein dünner, homogener Film entsteht.
    + Den Objektträger kurz auf den Handrücken legen und sanft darüberblasen, um die Trocknung zu beschleunigen und die Zellstrukturen zu erhalten.
    + Den Objektträger sorgfältig beschriften.

    Ergebnisse zu sehen in @bloodsmear-unstained.

    == Wichtige Hinweise zur Ausstrichtechnik <important-notes-on-the-streaking-technique>

    - *Achtung:* Wird der Ausstrich zu schnell ausgeführt, entsteht ein ungleichmäßiger und zu dünner Film.
    - Erfolgt der Ausstrich hingegen zu langsam, besteht die Gefahr, dass die Erythrozyten deformiert werden (Stechapfelform) oder verklumpen.

    == Durchführung: Färbung (nach Pappenheim) <execution-of-pappenheim-staining>

    + *Fixierung:* Die Präparate für 3 Minuten in eine Färbewanne mit May-Grünwald-Lösung legen.
    + *Erster Waschschritt:* Die Objektträger 1 Minute lang in eine 1:1-Mischung aus May-Grünwald-Lösung und destilliertem Wasser legen und anschließend die Farblösung rasch abgießen.
    + *Giemsa-Färbung:* Die Präparate direkt in eine Färbewanne mit frisch angesetzter, verdünnter Giemsa-Lösung (10 ml Wasser + 10 Tropfen Giemsa) legen und 15 Minuten inkubieren.
    + *Hinweis:* Während des Färbeprozesses darauf achten, dass stets genügend Färbelösung vorhanden ist und der Objektträger vollständig bedeckt bleibt – das Präparat darf nicht austrocknen! Bei Bedarf Farblösung nachgeben.
    + *Abschluss:* Nach der Färbung die Objektträger mit destilliertem Wasser abspülen, die Unterseite reinigen, die Gläser aufrecht aufstellen und an der Luft trocknen lassen.

    @bloodsmear-staining zeigt den Vorgang der Färbung.

    == Auswertung und Analyse <evaluation-and-analysis>

    - *Beobachtung:* Die ungefärbten sowie die gefärbten Blutausstriche sorgfältig mikroskopisch betrachten und fotografisch dokumentieren.
    - *Auszählung:* Die Leukozyten durch systematisches Führen des Sichtfelds in „Schlangenlinien“ über das Präparat auszählen.
    - *Differenzierung:* Anhand eines histologischen Atlas oder Vergleichspräparaten die verschiedenen Leukozytentypen identifizieren. Die Ergebnisse (mononukleäre Zellen: Lymphozyten, Monozyten; Granulozyten: Neutrophile, Eosinophile, Basophile) in eine Tabelle und in ein Liniendiagramm eintragen.
    - *Statistik:* Die absolute Anzahl und prozentuale Verteilung der Leukozytenarten erfassen, Bilder der Zelltypen ins Protokoll aufnehmen und die eigenen Werte mit Literaturangaben vergleichen (z. B. mittels Chi-Quadrat-Test).
    - *Messungen:* Die Zellgröße für jede Zellart an mehreren Zellen ermitteln und Mittelwerte berechnen.
  ])
})

#pagebreak()
= Ergebnisse

== Beobachtung

== Statistik

#{
  show: it => [#it <reference-values-adult-table>]
  show: figure.with(
    caption: [Referenzwerte für die relative Zellanzahl bei Erwachsenen. @src_doccheck_differential_blutbild],
  )
  let data = json("analysis/data/reference_values.json")
  let adult-data = data.at("Erwachsene")
  table(
    columns: 2,
    table.header[*Zelltyp*][*Relativer Anteil [%]*],
    ..for (cell-type, values) in adult-data {
      ([#cell-type], [#values.at("relativer_anteil_prozent").map(str).join(" - ")])
    },
  )
}

== Messungen

#pagebreak()

#set heading(numbering: none)
#show heading.where(level: 1): box
= Anhang <appendix>

#show bibliography: set heading(level: 2)
#show outline: set heading(level: 2)
#bibliography("bib.yaml", title: "Literaturverzeichnis", style: "ieee")

#outline(target: figure.where(kind: image), title: "Abbildungsverzeichnis")

#outline(target: figure.where(kind: table), title: "Tabellenverzeichnis")
