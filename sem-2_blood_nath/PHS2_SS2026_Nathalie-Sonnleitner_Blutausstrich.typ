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

    - *Beobachtung:* Die ungefärbten sowie die gefärbten Blutausstriche sorgfältig mikroskopisch betrachten.
    - *Auszählung:* Die Leukozyten durch systematisches Führen des Sichtfelds in „Schlangenlinien“ über das Präparat auszählen.
    - *Differenzierung:* Anhand eines histologischen Atlas oder Vergleichspräparaten die verschiedenen Leukozytentypen identifizieren. Die Ergebnisse (mononukleäre Zellen: Lymphozyten, Monozyten; Granulozyten: Neutrophile, Eosinophile, Basophile) in eine Tabelle eintragen.
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

#import "analysis/calculations/plots.typ": (
  boxplot-leukozyten, heatmap-leukozyten-difference,
  table-descriptive-statistics, table-chi-square-anpassungstest, table-one-sample-t-tests, table-chi-square-independence-test, table-two-sample-t-tests
)
#import "analysis/calculations/data-processing.typ": data-all-group, data-current-year-group, data-allergies-group, data-acute-erkrankungen-group, stats-all-group, stats-current-year-group, stats-allergies-group, stats-acute-erkrankungen-group, stats-for-set

Grundlegend werden nur verarbeitbare#footnote[Alle Zelltypzählungen als Zahl interpretierbar und Summe $> 0$.] Einzelpersondaten ausgewertet. Eine leere Zelltypanzahl in den Rohdaten wird als 0 interpretiert.

Wenn sinnvoll werden nachfolgende Statistiken und Grafiken auf vier verschiedene Datengruppen durchgeführt:
+ Alle Daten
+ Der MBI Studiengang mit Startsemester 2025
+ Alle Personen mit Allergien
+ Alle Personen mit akuten Erkrankungen

== Beschreibende Statistik <descriptive-statistics>

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
  show: figure.with(caption: [Boxplot der relativen Anteile der verschiedenen Leukozytenarten im Bezug auf der Gesamtleukozytenzahl.])
  show: rect
  boxplot-leukozyten
}

== Hypothesentests <hypothesis-tests>

Folgende Hypothesen sollen durch das Widerlegen ihrere Alternativhypothese überprüft werden:
- Alle MBI Studenten haben eine signifikant andere Verteilung der Leukozytenarten als die Referenzliteratur.
- Der Jahrgang "MBI 2025" hat eine signifikant andere Verteilung der Leukozytenarten als die Referenzliteratur.
- Allergiker haben eine signifikant andere Verteilung der Leukozytenarten als alle MBI Studenten.
- Akute Erkrankungen haben eine signifikant andere Verteilung der Leukozytenarten als alle MBI Studenten.
- Der Erwartungswert der eosinophilen Anteile in Allergikern ist signifikant höher als der in allen MBI Studenten.
- Der Erwartungswert der basophilen Anteile in Allergikern ist signifikant höher als der in allen MBI Studenten.
- Der Erwartungswert der neutrophilen Anteile in akuten Erkrankungen ist signifikant höher als der in allen MBI Studenten.
- Der Erwartungswert der Monozytenanteile in akuten Erkrankungen ist signifikant höher als der in allen MBI Studenten.

Die in @reference-values-adult-table angegebenen Referenzwerte für die relative Zellanzahl bei Erwachsenen werden für die Auswertung herangezogen#footnote[konkret: Mittelwert des Referenzbereichs]. Sämtliche statistischen Tests werden mit einem Signifikanzniveau von #sym.alpha = 5% durchgeführt.

=== MBI Studenten vs. Referenzliteratur <mbi-students-vs-reference-literature>

Es wird ein $chi^2$-Anpassungstest durchgeführt, um zu prüfen, ob die Verteilung der Leukozytenarten in den MBI Studenten signifikant aus der Referenzliteratur abweicht. Mit diesem Test lässt sich eine Gleichheit der Verteilung nicht signifikant bestätigen. Sie könnte nur widerlegt werden. Dies ist für diesen Test naturbedingt akzeptabel @src_dreiseitl.

Bei der Durchführung des Tests werden die absoluten Zellzählungen über alle Testpersonen aufaddiert. Diese Kategorienwerte werden für den Anpassungstest genutzt.

#let (plot, test-results) = table-chi-square-anpassungstest(data: data-all-group)
#{
  show: it => [#it <table-chi-square-anpassungstest-all-vs-reference>]
  show: figure.with(
    caption: [Tabelle des $chi^2$-Anpassungstests für die Verteilung der Leukozytenarten aller MBI Studenten in Bezug auf die Referenzliteratur.],
  )
  plot
}

@table-chi-square-anpassungstest-all-vs-reference ergibt einen $chi^2$-Wert von #calc.round(digits: 2, test-results.t-value) und einen p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%. Da $#calc.round(digits: 2, test-results.p-value * 100)% < alpha =5%$, wird die Nullhypothese, dass die Verteilung der Leukozytenarten in den MBI Studenten gleich der Referenzliteratur ist, abgelehnt. Auch @heatmap-leukozyten-difference-all-vs-reference zeigt recht klare Abweuchungstrends über den Großteil der Probanten hinweg.

#{
  show: it => [#it <heatmap-leukozyten-difference-all-vs-reference>]
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen der Leukozytenzahlen aller individuellen MBI Studenten von den Referenzwerten.],
    placement: auto
  )
  show: rect
  heatmap-leukozyten-difference(
    title: [Abweichungen aller MBI Studenten von den Referenzwerten.],
    height: 12cm, width: 100%)
}

Alternativ zum $chi^2$-Anpassungstest wird folgend auch ein t-Test für jeden Zelltyp durchgeführt, um zu prüfen, ob dessen Erwartungswert signifikant von der Referenzliteratur abweicht. Da dieser Test normalverteilte Daten vorraussetzt, müssen die prozentualen Anteile $p$ mit $p^* = arcsin(sqrt(p))$ transformiert werden @src_arcsin_squareroot_transform.

#{
  show: it => [#it <t-tests-all-vs-reference>]
  show: figure.with(
    caption: [Tabelle der t-Tests für die Verteilung der Leukozytenarten aller MBI Studenten in Bezug auf die Referenzliteratur.],
    //placement: auto
  )
  table-one-sample-t-tests(stats: stats-all-group)
}

Die Ergebnisse des t-Tests in @t-tests-all-vs-reference bestätigen die Ergebnisse des $chi^2$-Anpassungstests. Alle Leukozytentypen weichen signifikant von der Referenzliteratur ab.

Dieses Kapitel dient als Referenz für weiteres statistisches Vorgehen in den nachfolgenden Abschnitten. Abweichungen und neu etablierte Standardvorgehen werden in diesen bei Bedarf erläutert. 

=== MBI 2025 vs. Referenzliteratur <mbi-2025-vs-reference-literature>

#let (plot, test-results) = table-chi-square-anpassungstest(data: data-current-year-group)
#{
  show: it => [#it <table-chi-square-anpassungstest-mbi-2025-vs-reference>]
  show: figure.with(
    caption: [Tabelle des $chi^2$-Anpassungstests für die Verteilung der Leukozytenarten des Jahrgangs "MBI 2025" in Bezug auf die Referenzliteratur.],
  )
  plot
}

Gleiches Vorgehen zeigt bei @table-chi-square-anpassungstest-mbi-2025-vs-reference einen p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%. Auch der MBI 2025 Jahrgang weicht signifikant von der Referenzliteratur ab. Betrachted man @t-tests-mbi-2025-vs-reference, stellt man fest, dass die eosinophilen Granulozyten konträr zu @mbi-students-vs-reference-literature nicht signifikant von den Refrenzwerten in der Literatur abweichen. Basophile konnten nicht getestet werden, da sie nicht im Jahrgang vertreten sind.

#{
  show: it => [#it <t-tests-mbi-2025-vs-reference>]
  show: figure.with(
    caption: [Tabelle der t-Tests für die Verteilung der Leukozytenarten des Jahrgangs "MBI 2025" in Bezug auf die Referenzliteratur.],
  )
  table-one-sample-t-tests(stats: stats-current-year-group)
}


=== Allergiker vs. restliche MBI Studenten <allergies-vs-mbi-students>

#let (plot, test-results) = table-chi-square-independence-test((
  label: "Allergiker",
  data: data-allergies-group,
), (
  label: "Restliche Probanten",
  data: data-all-group.filter(it => not it.has-allergy),
))

Die Unabhängigkeit der beiden Gruppen wird durch einen $chi^2$-Unabhängigkeitstest überprüft und soll verworfen werden. Angewandt auf @chi-square-independence-test-allergies-vs-mbi-students ergibt sich bei diesem Standardvorgehen ein $chi^2$-Wert von #calc.round(digits: 2, test-results.test-statistics) und ein p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%. Da $#calc.round(digits: 2, test-results.p-value * 100)% lt.not alpha = 5%$, wird die Nullhypothese, dass die Verteilung der Leukozytenarten in den Allergikern und restlichen Probanten unabhängig ist, _nicht_ verworfen.

#{
  show: it => [#it <chi-square-independence-test-allergies-vs-mbi-students>]
  show: figure.with(
    caption: [Kontingenztabelle der Leukozytenzahlen aller Allergiker und restlichen Probanten für einen $chi^2$-Unabhängigkeitstest.],
  )
  plot
}

=== akute Erkrankungen vs. restliche MBI Studenten <acute-erkrankungen-vs-mbi-students>

#let (plot, test-results) = table-chi-square-independence-test((
  label: "Akute Erkrankungen",
  data: data-acute-erkrankungen-group,
), (
  label: "Restliche Probanten",
  data: data-all-group.filter(it => not it.has-acute-erkrankung),
))

Auch hier ergibt sich mit @chi-square-independence-test-acute-erkrankungen-vs-mbi-students ein $chi^2$-Wert von #calc.round(digits: 2, test-results.test-statistics) und ein p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%, der dadurch kein Verwerfen der Unabhängigkeitshypothese ermöglicht.

#{
  show: it => [#it <chi-square-independence-test-acute-erkrankungen-vs-mbi-students>]
  show: figure.with(
    caption: [Kontingenztabelle der Leukozytenzahlen aller akuten Erkrankungen und restlichen Probanten für einen $chi^2$-Unabhängigkeitstest.],
  )
  plot
}

Auch ein vergleich der @heatmap-leukozyten-difference-healthy-vs-reference mit @heatmap-leukozyten-difference-all-vs-reference zeigt kaum erkennbare Unterschiede. Das unterstreicht die Ergebnisse der statistischen Tests.

#{
  show: it => [#it <heatmap-leukozyten-difference-healthy-vs-reference>]
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen der Leukozytenzahlen ohne Allergiker oder akuten Erkrankungen von den Referenzwerten.],
    placement: auto
  )
  show: rect
  heatmap-leukozyten-difference(
    title: [Abweichungen aller gesunden#footnote[nicht allergisch und nicht akut erkrankt] MBI Studenten von den Referenzwerten.],
    height: 10cm, width: 100%, data-transform: it => it.filter(it => {
    not it.has-allergy and not it.has-acute-erkrankung
  }))
}

=== Zelltypen bei Allergien vs. restliche MBI Studenten <celltypes-allergies-vs-mbi-students>

Der Zwei-Stichproben-t-Test wird herangezogen, um signfikante Unterschiede im Erwartungswert zweier empirischer Verteilungen zu testen. Wir verwenden ihn hier als Standarvorgehen für den Vergleich einer gesonderten Gruppe mit der Grundgesamtheit. 

Dabei zeigt @t-tests-allergies-vs-mbi-students keine signifikanten Unterschiede in den Erwartungswerten der verschiedenen Zelltypen. Durch diese Untersuchung lässt sich also nicht behaupten, dass Allergien einen Einfluss auf das Blutbild haben.

Dadurch werden gleich zwei der in @hypothesis-tests genannten Hypothesen widerlegt.

#{
  show: it => [#it <t-tests-allergies-vs-mbi-students>]
  show: figure.with(
    caption: [Tabelle der t-Tests für die Verteilung der verschiedenen Zelltypen bei Allergikern verglichen mit den restlichen MBI Studenten.],
  )
  table-two-sample-t-tests((
    label: "Allergiker",
    statistics: stats-allergies-group,
  ), (
    label: "Restliche Probanten",
    statistics: stats-for-set(data-all-group.filter(it => not it.has-allergy)),
  ))
}

=== Zelltypen bei akuten Erkrankungen vs. restliche MBI Studenten <celltypes-acute-erkrankungen-vs-mbi-students>

Auch die beiden Hypothesen im Zusammenhang mit akuten Erkrankungen können durch die Tests in @t-tests-acute-erkrankungen-vs-mbi-students nicht bestaätigt werden. Es ist kein groß genuger Unterschied zwischen den Erwartungswerten der verschiedenen Zelltypen zu erkennen.

#{
  show: it => [#it <t-tests-acute-erkrankungen-vs-mbi-students>]
  show: figure.with(
    caption: [Tabelle der t-Tests für die Verteilung der verschiedenen Zelltypen bei akuten Erkrankungen verglichen mit den restlichen MBI Studenten.],
  )
  table-two-sample-t-tests((
    label: "Akute Erkrankungen",
    statistics: stats-acute-erkrankungen-group,
  ), (
    label: "Restliche Probanten",
    statistics: stats-for-set(data-all-group.filter(it => not it.has-acute-erkrankung)),
  ))
}

== Messungen

Messungen der Zellgrößen konnten im Rahmen des Experiments nicht durchgeführt werden. Stattdessen wird auf @leukozyt-reference-sizes in @reference-values-from-literature verwiesen. Diese zeigt die Größenbereiche der verschiedenen Leukozytenarten. Trotz fehlender konkreter Messung können diese Werte experimentell plausibilisiert werden: Die einzelnen Zellen wären sonst im Mikroskop nicht klar erkkenbar gewesen.

#pagebreak()
= Interpretation

== Gegenüberstellung der Messwerte mit Referenzwerten

Die statistische Auswertung der Gesamtgruppe aller MBI-Studierenden ($N = 173$) zeigt im $chi^2$-Anpassungstest eine hochsignifikante Abweichung von der klassischen Referenzliteratur ($chi^2 = 1395.18$, $p = 0%$). Die Nullhypothese einer identischen Verteilung muss somit strikt abgelehnt werden. Auch für die Teilgruppe des Jahrgangs „MBI 2025“ bestätigt sich diese signifikante Abweichung ($p = 0.04%$).

Bei genauerer Betrachtung der transformierten Ein-Stichproben-t-Tests treten markante Verschiebungstrends zu Tage:

- *Neutrophile Granulozyten:* Der empirische Mittelwert liegt mit $43.41%$ dramatisch unter dem Literaturwert von $59.81%$.
- *Lymphozyten, Monozyten und Basophile:* Diese weisen allesamt signifikant erhöhte Werte im Vergleich zur Norm auf (Lymphozyten: $38.39%$ vs. $32.71%$; Monozyten: $12%$ vs. $4.67%$; Basophile: $4.14%$ vs. $0.47%$).

*Das Konzept der statistischen Power bei großen Stichproben:*\
Aus klinischer Sicht ist eine kollektive, derartige Verschiebung bei fast 200 gesunden Probanden unwahrscheinlich. Hier greift ein zentrales statistisches Konzept: Aufgrund der Aggregation der absoluten Zellzahlen über alle Testpersonen hinweg ($N = 173$) besitzt der Anpassungstest eine extrem hohe statistische Power. Selbst winzige, biologisch völlig unbedeutende systematische Abweichungen oder methodische Artefakte bei der manuellen Auszählung führen unweigerlich zu einem $p$-Wert von fast exakt $0%$.

Eine interessante Ausnahme bildet der Jahrgang MBI 2025 ($n = 9$): Hier weichen die eosinophilen Granulozyten als einziger Zelltyp *nicht* signifikant von der Literatur ab ($1.96%$ vs. $2.34%$, $p = 16.86%$). Dies liegt an der geringen Gruppengröße, welche die statistische Power dämpft und zufällige Schwankungen toleriert. Basophile konnten in diesem Jahrgang gar nicht erfasst werden ($0%$).

== Sondersituationen: Allergiker und akut Erkrankte

Der wohl überraschendste Befund der Auswertung ist, dass weder Allergien noch akute Erkrankungen einen statistisch nachweisbaren Einfluss auf das Differentialblutbild der Studierenden hatten:

- *Allergiker vs. Restliche Studierende:* Der $chi^2$-Unabhängigkeitstest liefert einen $p$-Wert von $56.79%$. Auch die nachfolgenden Zwei-Stichproben-t-Tests zeigen für keinen einzigen Zelltyp (einschließlich Eosinophiler und Basophiler) einen signifikanten Unterschied ($p > 0.05$). Die Hypothesen, dass Allergiker mehr Eosinophile ($2.73%$) oder Basophile ($4.63%$) aufweisen, konnten somit nicht nachgewiesen werden.
- *Akut Erkrankte vs. Restliche Studierende:* Der Unabhängigkeitstest verfehlt mit $p = 31.55%$ ebenfalls die Signifikanzschwelle. Weder die erwartete neutrophile Kampfphase (Neutrophilenerhöhung) noch eine akute virale Lymphozytose lassen sich in den Mittelwerten mathematisch sichern.


*Biologische Erwartung vs. studentische Realität:*\
Klinisch-pathophysiologisch müssten akute bakterielle Infektionen zu einer Neutrophilie mit Linksverschiebung und Allergien zu einer Eosinophilie/Basophilie führen. Dass dieser Effekt hier völlig verpufft, liegt primär an der Natur der Datenerhebung. Das binäre Abfragefeld „vor kurzem krank“ oder „Allergie“ differenziert weder nach Schweregrad, Reaktivität noch nach dem exakten zeitlichen Verlauf. Ein abklingender, milder Schnupfen vor zwei Wochen hinterlässt im Blutausstrich schlicht keine Spuren einer akuten Leukozytose mehr, verwässert jedoch die statistische Gruppe „Akute Erkrankungen“.

== Fehlerbetrachtung und methodische Einschränkungen

Das Verfehlen klinisch erwarteter Trends und die extremen Abweichungen zur Literatur lassen sich durch eine Reihe massiver, methodischer Fehlerquellen im Experimentaufbau erklären:

- *Enorme Varianz bei den Gesamt-Zellzahlen:* Ein Blick auf die beschreibende Statistik zeigt bei der Gesamtanzahl gezählter Zellen pro Person einen Mittelwert von $31.36 plus.minus 25.5$ Zellen bei einem Minimum von nur $1$ und einem Maximum von $191$ Zellen. Mathematisch ist eine prozentuale Differenzierung auf Basis von teilweise unter 10 oder gar nur einer einzigen gezählten Zelle pro Objektträger absolut fehlerhaft. Das Gesetz der großen Zahlen wird hier komplett verletzt, was zu extremen, zufälligen Verzerrungen in der relativen Verteilung führt. 
- *Subjektive Fehlklassifikation beim Mikroskopieren:* Da die Zellgrößen im Experiment nicht exakt vermessen werden konnten (fehlendes Okularmikrometer) , basierte die Unterscheidung der Leukozytenarten rein auf der visuellen, subjektiven Beurteilung des Färbemusters. Große Lymphozyten (Reizformen) werden von ungeübten Augen leicht mit Monozyten verwechselt, was den künstlich erhöhten Monozytenwert ($12%$ vs. $4.67%$) in der Auswertung erklären könnte.
- *Mängel in der Ausstrichtechnik:* Laut Vorgabe führt ein zu schnelles Streichen zu ungleichmäßigen Filmen , während zu langsames Streichen die Erythrozyten deformiert (Stechapfelform) oder verklumpen lässt. Schlecht ausgestrichene Präparate erschweren die Identifikation in den Randbereichen („Snaking Lines“) erheblich.
- *Qualität der Pappenheim-Färbung:* Die panoptische Färbung steht und fällt mit den Zeiten und der Feuchtigkeit. Kam es während der 15-minütigen Giemsa-Inkubation zu einem partiellen Antrocknen der Farblösung auf dem Objektträger , verändern sich die Färbeeigenschaften von Eosin und Methylenblau dramatisch. Basophile Strukturen erscheinen dann unzureichend blau/violett oder neutrophile Granula werden azidophil überfärbt.

== Zusammenfassende Bedeutung

Zusammenfassend lässt sich sagen, dass das studentische Experiment „Blutausstrich“ zwar hervorragend geeignet ist, um die handwerklichen Grundlagen der Hämatologie (Ausstrichtechnik, Pappenheim-Färbung) und die morphologische Vielfalt der Leukozyten kennenzulernen. Für eine valide epidemiologische oder klinische Auswertung ist die Datenbasis jedoch ungeeignet.

Durch die fehlende Standardisierung der Zellzählung und subjektive Unsicherheiten bei der manuellen Identifikation werden tatsächliche biologische Effekte oft überdeckt. Automatisierte Verfahren wie Hämatologie-Analyzer liefern hier deutlich zuverlässigere und objektivere Ergebnisse und sind daher in der modernen Diagnostik sinnvoll und etabliert @src_doccheck_differential_blutbild.


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
