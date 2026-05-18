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
    dy: 0cm,
  )

  container()
  content([
    Blutausstriche werden genutzt, um mikroskopisch Zelltypen und deren Zellzahl zu bestimmen. Dazu wird wie in @bloodsmear-macro gezeigt eine Mikroskopplatte mit einem dünnen Blutfilm bestrichen. @src_angabe

    Blutausstriche werden üblicherweise mit Kombinationen aus sauren und basischen Farbstoffen gefärbt, um verschiedene Zelltypen und Zellbestandteile im Blut besser sichtbar zu machen. Bestimmte Bestandteile in den Zellen reagieren unterschiedlich auf diese Farbstoffe, was zu einer charakteristischen Anfärbung führt und die Unterscheidung der einzelnen Zellarten im Mikroskop erleichtert. @src_angabe

    In @bloodsmear-microscopy ist ein Blutausstrich mit saurem und basischem Farbstoff zu sehen. Es sind sowohl Erythrozyten als auch Leukozyten gut erkennbar. Häufig werden die Leukozyten gezählt, um eine Infektion oder eine Entzündung zu diagnostizieren. @src_angabe

    Die verschiedenen Leukozytenarten sind in @leukozyt-types dargestellt. Diese können so unter dem Mikroskop nach der Färbung klassifiziert werden.

    == Erweiterte Theorie zur Zellfärbung <extended-theory-of-cell-staining>

    - *Basophile Strukturen:* Saure Zellbestandteile, wie beispielsweise die DNA im Zellkern oder die RNA im Zytoplasma, ziehen basische (kationische) Farbstoffe an. Farbstoffe wie Methylenblau binden an diese Strukturen und färben sie intensiv blau bis violett. @src_hämatologische_standardfärbung @src_angabe
    - *Eosinophile (azidophile) Strukturen:* Basische Zellbestandteile, zu denen das Hämoglobin in den roten Blutkörperchen oder bestimmte proteinreiche Granula in weißen Blutkörperchen gehören, ziehen saure (anionische) Farbstoffe an. Eosin bindet an diese Strukturen und verleiht ihnen eine typisch rötliche oder rosa Färbung. @src_hämatologische_standardfärbung @src_angabe

    Erythrozyten und bestimmte Leukozytengranula werden von den basischen Farbstoffen unterschiedlich intensiv angefärbt. In diesem Protokoll werden die Blutzellen nach Pappenheim gefärbt, einer sogenannten panoptischen Färbung, die eine Kombination aus der May-Grünwald- und der Giemsa-Färbung darstellt. Der Begriff „panoptisch“ (alles sichtbar machend) bedeutet in diesem Zusammenhang, dass durch die Kombination der beiden Lösungen ein besonders breites Spektrum an Zellbestandteilen angefärbt wird. Dies ist entscheidend, um das Differenzialblutbild exakt auszuwerten und die verschiedenen Arten von Leukozyten (wie Lymphozyten, Monozyten und die verschiedenen Granulozyten) voneinander zu unterscheiden. @src_hämatologische_standardfärbung @src_angabe

    - *May-Grünwald-Lösung:* Diese enthält eosinsaures Methylenblau gelöst in Methanol. Das Methanol dient dabei gleichzeitig als Fixiermittel, um die Zellstrukturen vor der eigentlichen Färbung zu stabilisieren und zu erhalten. @src_angabe

    - *Giemsa-Lösung:* Diese enthält Methylenazur, Methylenviolett, Methylenblau und Eosin, welche in Methanol und Glycerin gelöst sind. @src_angabe

    == Referenzwerte aus Literatur <reference-values-from-literature>

    #{
      show: it => [#it <reference-values-adult-table>]
      show: figure.with(
        caption: [Referenzwerte für die relative Zellanzahl bei Erwachsenen. @src_doccheck_differential_blutbild],
      )
      let data = json("analysis/data/reference_values.json")
      let adult-data = data.at("Erwachsene")
      table(
        columns: 3,
        table.header[*Zelltyp*][*Relativer Anteil [%]*][*Absoluter Anteil [Zellen/µl]*],
        ..for (cell-type, values) in adult-data {
          (
            [#cell-type],
            [#values.at("relativer_anteil_prozent").map(str).join(" - ")],
            [#values.at("absolute_anzahl_pro_ul").map(str).join(" - ")],
          )
        },
      )
    }
  ])
})

#{
  show: it => [#it <leukozyt-reference-sizes>]
  show: figure.with(
    caption: [Referenzgrößen der verschiedenen Typen von Leukozyten.],
  )
  table(
    columns: 2,
    table.header[*Zelltyp*][*Größenbereich [#sym.mu\m]*],
    [Neutrophile], [12 - 15 @src_kenhub],
    [Eosinophile], [15 - 18 @src_kenhub],
    [Basophile], [\~10 @src_doccheck_basophil],
    [Monozyten], [12 - 20 @src_kenhub],
    [Lymphozyten], [8 - 10 @src_doccheck_lymphozyt],
  )
}

#{
  show: it => [#it <leukozyt-types>]
  show: figure.with(
    caption: [@src_leukozyt_type Leukozyten-Arten - so wie sie nach Einfärbung unter dem Mikroskop erscheinen.],
  )
  show: rect.with(inset: 0pt)
  image("assets/leukozytarten.png")
}

== Relevanz in der Klinik <relevance-in-the-hospital>

Blutausstriche sind in der klinischen Diagnostik von großer Bedeutung, da sie eine schnelle und differenzierte Beurteilung der verschiedenen Blutzellarten ermöglichen. Sie unterstützen die Erkennung und Überwachung von Infektionen, Entzündungsreaktionen, Allergien und hämatologischen Erkrankungen wie Leukämien. Die relative und absolute Verteilung der Leukozyten liefert dabei wertvolle Hinweise auf akute oder chronische Krankheitsprozesse sowie auf den aktuellen Zustandsverlauf eines Patienten. Die Blutausstrich-Analyse ist damit ein unverzichtbares Werkzeug in der hämatologischen Routinediagnostik.
@src_doccheck_differential_blutbild @src_blutwert_net

Die Aufgaben und die typische Verteilung der Leukozytenarten im peripheren Blut ergeben sich aus ihren jeweiligen Funktionen im Immunsystem:
- *Neutrophile Granulozyten*
  Häufigster Zelltyp. Sie stellen die „erste Abwehrlinie“ gegen bakterielle Infektionen dar und können rasch in großer Zahl bereitgestellt werden. @src_blutwert_net @src_doccheck_differential_blutbild
- *Lymphozyten*
  Teil des adaptiven Immunsystems. Sie ermöglichen gezielte Immunantworten gegen bestimmte Erreger. @src_blutwert_net @src_doccheck_differential_blutbild
- *Monozyten*
  Vorläufer der Makrophagen und an der Phagozytose beteiligt. Tragen so ebenfalls zur Krankheitsabwehr bei. @src_blutwert_net @src_doccheck_differential_blutbild
- *Eosinophile Granulozyten*
  Übernehmen spezielle Funktionen, hauptsächlich bei der Abwehr von Parasiten. Treten daher seltener auf. @src_blutwert_net @src_doccheck_differential_blutbild
- *Basophile Granulozyten*
  Sind wichtig bei allergischen Reaktionen. Kommen ebenfalls seltener vor. @src_blutwert_net @src_doccheck_differential_blutbild

Diese funktionellen Unterschiede spiegeln sich im typischen prozentualen Verhältnis der Leukozytenarten im Blut wider. @src_blutwert_net @src_doccheck_differential_blutbild

Eine Allergie ist oft die Ursache von:
- erhöhter basophiler Granulozytenanteil. @src_blutwert_net
- erhöhter eosinophiler Granulozytenanteil. @src_blutwert_net
- kurzzeitig verringerter basophiler Granulozytenanteil. @src_blutwert_net

Hingegen sind akute Erkrankungen oft die Ursache von:
- erhöhter neutrophiler Granulozytenanteil. @src_blutwert_net
- verringerter eosinophiler Granulozytenanteil. @src_blutwert_net
- erhöhter Anteil an Monozyten in der Abheilungsphase. @src_blutwert_net
- erhöhter Lymphozytenanteil (viral). @src_blutwert_net

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
    + *Hinweis:* Während des Färbeprozesses darauf achten, dass stets genügend Färbelösung vorhanden ist und der Objektträger vollständig bedeckt bleibt - das Präparat darf nicht austrocknen! Bei Bedarf Farblösung nachgeben.
    + *Abschluss:* Nach der Färbung die Objektträger mit destilliertem Wasser abspülen, die Unterseite reinigen, die Gläser aufrecht aufstellen und an der Luft trocknen lassen.

    @bloodsmear-staining zeigt den Vorgang der Färbung.

    == Auswertung und Analyse <evaluation-and-analysis>

    - *Beobachtung:* Die ungefärbten sowie die gefärbten Blutausstriche sorgfältig mikroskopisch betrachten und fotografisch dokumentieren.
    - *Auszählung:* Die Leukozyten durch systematisches Führen des Sichtfelds in „Schlangenlinien“ über das Präparat auszählen.
    - *Differenzierung:* Anhand eines histologischen Atlas oder Vergleichspräparaten die verschiedenen Leukozytentypen identifizieren. Die Ergebnisse (mononukleäre Zellen: Lymphozyten, Monozyten; Granulozyten: Neutrophile, Eosinophile, Basophile) in eine Tabelle und in ein Liniendiagramm eintragen.
    - *Statistik:* Die absolute Anzahl und prozentuale Verteilung der Leukozytenarten erfassen, Bilder der Zelltypen ins Protokoll aufnehmen und die eigenen Werte mit Literaturangaben vergleichen.
  ])
})

#pagebreak()
= Ergebnisse

#pdf.attach(
  "analysis/data/UE_Blut_Ergebnisse.xlsx - Blutausstrich.tsv",
  mime-type: "text/tab-separated-values",
  relationship: "data",
  description: "Ergebnisse der Blutausstrich-Messungen",
)

#import "../lib/maths/statistics.typ": (
  chi-square-ablehnungsbereich, chi-square-teststatistic, chisq-pvalue,
)
#import "analysis/calculations/plots.typ": (
  boxplot-leukozyten, heatmap-leukozyten-difference,
  table-descriptive-statistics,
)
#import "analysis/calculations/data-processing.typ": data-dict

== Beobachtung

== Statistiken

Grundlegend werden nur verarbeitbare#footnote[Alle Zelltypzählungen als Zahl interpretierbar und Summe $> 0$.] Einzelpersondaten ausgewertet. Eine leere Zelltypanzahl in den Rohdaten wird als 0 interpretiert.

Wenn sinnvoll werden nachfolgende Statistiken und Grafiken auf vier verschiedene Datengruppen durchgeführt:
+ Alle Daten
+ Der MBI Studiengang mit Startsemester 2025
+ Alle Personen mit Allergien
+ Alle Personen mit akuten Erkrankungen

=== Beschreibende Statistik <descriptive-statistics>

@table-descriptive-statistics zeigt sowohl die gesamten Leukozytenzahlen als auch die Verteilung der Zelltypen bezogen auf die gezählte Gesamtzahl. Diese Darstellung vereinfacht die Interpretation, da genau diese zwei Größen von Relevanz sind. Die absoluten Zählungen der einzelnen Leukozytenarten sind kaum von Bedeutung für unsere Analyse.

Durch die Aufteilung in unterschiedliche Gruppen lässt sich beispielsweise erkennen, dass die Gruppe mit kürzlich akuten Erkrankungen einen höheren Durchschnittsanteil an neutrophilen Granulozyten hat als die Grundgesamtheit. Bei Allergikern ist das durchschnittliche Vorkommen der basophilen und eosinophilen Granulozyten höher als bei der Grundgesamtheit.

Dieser Trend ist auch in @boxplot-leukozyten erkennbar. Diese Darstellung zeigt die Verteilung der Leukozytentypen ohne Gesamtanzahl. Dabei ist der Median von basophilen und eosinophilen Granulozyten in allen Gruppen 0%.

#{
  show: it => [#it <table-descriptive-statistics>]
  show: figure.with(
    caption: [Beschreibende Statistik der Leukozytenzahlen. Gesamtleukozyten in absoluten Zellzählungen angegeben. Verteilung der Zelltypen in relativen Anteilen zur Gesamtleukozytenzahl angegeben.],
  )
  set par(justify: false)
  show: pad.with(right: -1cm)
  table-descriptive-statistics
}

#{
  show: it => [#it <boxplot-leukozyten>]
  show: figure.with(caption: [Boxplot der Leukozytenzahlen.])
  show: rect
  boxplot-leukozyten
}

=== Hypothesentests <hypothesis-tests>

Folgende Hypothesen sollen durch das Widerlegen ihrere Alternativhypothese überprüft werden:
- Alle MBI Studenten haben eine signifikant andere Verteilung der Leukozytenarten als die Referenzliteratur.
- Allergiker haben eine signifikant andere Verteilung der Leukozytenarten als die Grundgesamtheit.
- Akute Erkrankungen haben eine signifikant andere Verteilung der Leukozytenarten als die Grundgesamtheit.
- Der Erwartungswert der eosinophilen Anteile in Allergikern ist signifikant höher als der in der Grundgesamtheit.
- Der Erwartungswert der basophilen Anteile in Allergikern ist signifikant höher als der in der Grundgesamtheit.
- Der Erwartungswert der neutrophilen Anteile in akuten Erkrankungen ist signifikant höher als der in der Grundgesamtheit.
- Der Erwartungswert der Monozytenanteile in akuten Erkrankungen ist signifikant höher als der in der Grundgesamtheit.

Die in @reference-values-adult-table angegebenen Referenzwerte für die relative Zellanzahl bei Erwachsenen wurden für die Auswertung herangezogen#footnote[konkret: Mittelwert des Referenzbereichs]. Sämtliche statistischen Tests wurden mit einem Signifikanzniveau von #sym.alpha = 5% durchgeführt.

#{}

#{
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen der Leukozytenzahlen von den Referenzwerten.],
  )
  show: rect
  heatmap-leukozyten-difference(height: 6cm, data-transform: it => it.filter(
    it => it.has-allergy,
  ))
}

#{
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen der Leukozytenzahlen von den Referenzwerten.],
  )
  show: rect
  heatmap-leukozyten-difference(data-transform: it => it.filter(it => {
    it.has-acute-erkrankung
  }))
}

== Messungen

Messungen der Zellgrößen konnten im Rahmen des Experiments nicht durchgeführt werden. Stattdessen wird auf @leukozyt-reference-sizes in @reference-values-from-literature verwiesen. Diese zeigt die Größenbereiche der verschiedenen Leukozytenarten. Trotz fehlender konkreter Messung können diese Werte experimentell plausibilisiert werden: Die einzelnen Zellen wären sonst im Mikroskop nicht klar erkkenbar gewesen.

#pagebreak()
= Interpretation

== Gegenüberstellung der Messwerte mit Referenzwerten <comparison-of-measurements-with-reference-values>

#pagebreak()
#set heading(numbering: none)
#show heading.where(level: 1): box
= Anhang <appendix>

#show bibliography: set heading(level: 2)
#show outline: set heading(level: 2, outlined: true)
#bibliography("bib.yaml", title: "Literaturverzeichnis", style: "ieee")

#colbreak()
#outline(target: figure.where(kind: image), title: "Abbildungsverzeichnis")

#colbreak()
#outline(target: figure.where(kind: table), title: "Tabellenverzeichnis")
