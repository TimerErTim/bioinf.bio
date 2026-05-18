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
      show: pad.with(bottom: 5mm)
      show: box.with(width: 38%)
      show: it => [#it <bloodsmear-macro>]
      show: figure.with(
        caption: [@src_bloodsmear_macro Blutausstriche auf einer Mikroskopplatte; Unterscheidung zwischen dünnem und dickem Film.],
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
        caption: [@src_bloodsmear_microscopy Mikroskopische Untersuchung eines Blutausstrichs. Sichtbar sind Erythrozyten und Leukozyten.],
      )
      show: rect.with(inset: 0pt)
      image("assets/bloodsmear_micro.jpg")
    },
    boundary: contour.margin(5mm),
    dy: 0cm,
  )

  container()
  content([
    Blutausstriche werden verwendet, um unter dem Mikroskop Zelltypen und Zellzahlen im Blut zu bestimmen. Wie in @bloodsmear-macro dargestellt, wird dazu ein dünner Blutfilm auf einem Objektträger erzeugt. @src_angabe

    Typischerweise werden Blutausstriche mit Kombinationen aus sauren und basischen Farbstoffen gefärbt, um unterschiedliche Zellarten und Zellbestandteile besser sichtbar zu machen. In den Zellen reagieren bestimmte Strukturen unterschiedlich auf diese Farbstoffe, wodurch eine charakteristische Anfärbung entsteht, die die Unterscheidung der Zellarten im Mikroskop erleichtert. @src_angabe

    Ein zentrales Prinzip dabei ist der sogenannte Romanowsky-Effekt: Durch die spezielle Mischung aus sauren (z. B. Eosin) und basischen (z. B. Methylenblau, Azuren) Farbstoffen entstehen auf den Zellstrukturen Farbtöne, die weder der einen noch der anderen Farbstoffkomponente alleine zuzuordnen sind, sondern auf spezielle Wechselwirkungen (sog. Polychromasie) zurückgehen. Der Romanowsky-Effekt sorgt beispielsweise für die typische Purpurfärbung der Chromatinstrukturen im Zellkern und erlaubt auf diese Weise eine besonders differenzierte zytologische Diagnostik in Blutausstrichen. @src_pappenheim_staining_forum

    In @bloodsmear-microscopy ist ein Blutausstrich nach Färbung mit basischem und saurem Farbstoff abgebildet. Sowohl Erythrozyten als auch Leukozyten sind klar zu erkennen. Die Bestimmung und Zählung der Leukozyten dient häufig zur Diagnose von Infektionen oder Entzündungen. @src_angabe

    Die Differenzierung der verschiedenen Leukozytentypen nach Färbung ist in @leukozyt-types dargestellt.

    == Erweiterte Theorie zur Zellfärbung <extended-theory-of-cell-staining>

    - *Basophile Strukturen:* Saure Zellbestandteile wie DNA oder RNA binden basische (kationische) Farbstoffe (z.B. Methylenblau), wodurch sie intensiv blau bis violett gefärbt erscheinen. @src_hämatologische_standardfärbung @src_angabe
    - *Eosinophile (azidophile) Strukturen:* Basische Zellkomponenten, zu denen Hämoglobin in Erythrozyten und bestimmte Protein-Granula zählen, binden saure (anionische) Farbstoffe wie Eosin, was eine charakteristische rötliche bis rosafarbene Färbung bewirkt. @src_hämatologische_standardfärbung @src_angabe

    Erythrozyten und bestimmte Leukozytengranula werden unterschiedlich intensiv angefärbt. Im Protokoll erfolgt die Färbung der Blutzellen nach Pappenheim, also panoptisch mittels Kombination aus May-Grünwald- und Giemsa-Färbung. Panoptisch bedeutet, dass ein möglichst breites Spektrum an Zellbestandteilen sichtbar gemacht wird. Dies ist für eine genaue Auswertung des Differentialblutbildes entscheidend und unterstützt die Unterscheidung verschiedener Leukozytenarten (z.B. Lymphozyten, Monozyten, Granulozyten). @src_hämatologische_standardfärbung @src_angabe

    - *May-Grünwald-Lösung:* Enthält eosinsaures Methylenblau in Methanol. Das Methanol dient gleichzeitig zur Fixierung der Zellen vor der eigentlichen Färbung. @src_angabe

    - *Giemsa-Lösung:* Enthält Methylenazur, Methylenviolett, Methylenblau und Eosin, gelöst in Methanol und Glycerin. @src_angabe

    == Referenzwerte aus der Literatur <reference-values-from-literature>

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
    caption: [Referenzgrößen der verschiedenen Leukozytentypen.],
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
    caption: [@src_leukozyt_type Referenzform der Leukozytenarten nach Färbung im Mikroskop.],
  )
  show: rect.with(inset: 0pt)
  image("assets/leukozytarten.png")
}

== Relevanz in der Klinik <relevance-in-the-hospital>

Blutausstriche spielen in der klinischen Diagnostik eine zentrale Rolle, da sie eine schnelle und differenzierte Beurteilung der verschiedenen Blutzellarten ermöglichen. Sie dienen der Erkennung und Überwachung von Infektionen, Entzündungen, Allergien oder hämatologischen Erkrankungen wie Leukämien. Die relative und absolute Leukozytenverteilung gibt wertvolle Hinweise auf akute oder chronische Krankheitsprozesse sowie auf den Verlauf von Krankheiten. Die Blutausstrich-Analyse ist damit ein unverzichtbares Instrument in der hämatologischen Routinediagnostik.
@src_doccheck_differential_blutbild @src_blutwert_net

Die Aufgaben und die typische Verteilung der Leukozyten im peripheren Blut ergeben sich aus deren jeweiligen Funktionen im Immunsystem:
- *Neutrophile Granulozyten*: Häufigster Zelltyp. Sie stellen die „erste Abwehrlinie“ gegen bakterielle Infektionen dar und können rasch in großer Zahl auftreten. @src_blutwert_net @src_doccheck_differential_blutbild
- *Lymphozyten*: Teil des adaptiven Immunsystems und ermöglichen gezielte Immunantworten gegen bestimmte Erreger. @src_blutwert_net @src_doccheck_differential_blutbild
- *Monozyten*: Vorläufer der Makrophagen und an der Phagozytose beteiligt, tragen ebenfalls zur Abwehr bei. @src_blutwert_net @src_doccheck_differential_blutbild
- *Eosinophile Granulozyten*: Übernehmen spezielle Aufgaben, insbesondere bei der Abwehr von Parasiten, und sind daher seltener. @src_blutwert_net @src_doccheck_differential_blutbild
- *Basophile Granulozyten*: Wichtige Zellen bei allergischen Reaktionen, ebenfalls selten im Blut. @src_blutwert_net @src_doccheck_differential_blutbild

Diese funktionellen Unterschiede spiegeln sich in den typischen prozentualen Verhältnissen der Leukozytenarten wider. @src_blutwert_net @src_doccheck_differential_blutbild

Eine Allergie ist häufig assoziiert mit:
- erhöhtem basophilen Granulozytenanteil. @src_blutwert_net
- erhöhtem eosinophilen Granulozytenanteil. @src_blutwert_net
- zeitweise erniedrigtem basophilem Anteil. @src_blutwert_net

Akute Erkrankungen führen häufig zu:
- erhöhtem neutrophilem Anteil. @src_blutwert_net
- erniedrigtem eosinophilen Anteil. @src_blutwert_net
- erhöhten Monozyten in der Abheilungsphase. @src_blutwert_net
- erhöhten Lymphozyten (bei viralen Infekten). @src_blutwert_net

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
  container(height: 90%)

  pagebreak()

  placed(
    top + right,
    {
      show: box.with(width: 35%)
      show: it => [#it <bloodsmear-staining>]
      show: figure.with(
        caption: [Objektträger suspendiert in Färbelösung.],
      )
      show: rect.with(inset: 0pt)
      image("assets/blutausstrich_einfärbung.jpg")
    },
    boundary: contour.margin(5mm),
  )

  container()
  content([
    Die Vorgehensweise ist vorgegeben#footnote[Angabe ist dieser PDF angehängt und gelistet als #cite(<src_angabe>, form: "full")], die konkrete Durchführung wird im Folgenden beschrieben.

    == Sicherheitsvorkehrungen <safety-precautions>

    - *Umgang mit Blut:* Beim Arbeiten mit Blut ist ständiges Tragen von Handschuhen vorgeschrieben, um Infektionsrisiken zu minimieren.
    - *Chemische Gefahren:* Die eingesetzten Färbelösungen enthalten toxische Stoffe wie Methanol und müssen daher mit besonderer Vorsicht verwendet werden. Hautkontakt und das Einatmen der Dämpfe sind zu vermeiden.
    - *Färbung:* Farbige Lösungen sind schwer von Haut und Kleidung zu entfernen, daher ist das Tragen von Laborkittel und Handschuhen dringend angeraten.

    == Benötigte Materialien @src_angabe <required-materials>

    - *Mikroskop* (ggf. mit Immersionsöl)
    - *Objektträger*
    - *Ausstrichglas* (Deckglas oder zweiter Objektträger)
    - *Färbewanne*
    - *Pinzette*
    - *May-Grünwald-Lösung*, *Giemsa-Lösung*, *destilliertes Wasser*
    - *Frisches (!) Blut*

    == Durchführung: Herstellung des Blutausstrichs <execution-of-blood-stain>

    + Einen kleinen Bluttropfen an das rechte Ende eines sauberen Objektträgers geben.
    + Das Ausstrichglas (z.B. ein zweiter Objektträger) zwischen Daumen und Zeigefinger halten und in einem Winkel von ca. 45° auf den Objektträger aufsetzen.
    + Das Ausstrichglas vorsichtig an den Bluttropfen schieben, bis sich das Blut an der Kante gleichmäßig verteilt.
    + Anschließend das Ausstrichglas mit etwa 30° gleichmäßig und zügig über den Objektträger ziehen, so dass ein dünner, homogener Film entsteht.
    + Kurz trocknen lassen (Handrücken, leichtes Pusten), um Zellstrukturen zu erhalten.
    + Objektträger beschriften.

    Das Ergebnis ist in @bloodsmear-unstained zu sehen.

    == Wichtige Hinweise zur Ausstrichtechnik <important-notes-on-the-streaking-technique>

    - *Achtung:* Zu schnelles Ausstreichen führt zu einem ungleichmäßigen, zu dünnen Film.
    - Zu langsames Arbeiten kann zu deformierten (Stechapfelform) oder verklumpten Erythrozyten führen.

    == Durchführung: Färbung nach Pappenheim <execution-of-pappenheim-staining>

    + *Fixierung:* Präparate für 3 Minuten in May-Grünwald-Lösung inkubieren.
    + *Erster Waschschritt:* Objektträger 1 Minute in eine 1:1-Mischung aus May-Grünwald-Lösung und destilliertem Wasser legen, dann Lösung abgießen.
    + *Giemsa-Färbung:* Die Präparate in eine frische, verdünnte Giemsa-Lösung (10 ml Wasser + 10 Tropfen Giemsa) geben, 15 Minuten inkubieren.
    + *Hinweis:* Während der Färbung stets für genügend Färbelösung sorgen und vollständige Bedeckung der Präparate sicherstellen. Austrocknen unbedingt vermeiden!
    + *Abschluss:* Objektträger mit destilliertem Wasser abspülen, die Unterseite reinigen, zum Trocknen aufrecht aufstellen.

    Der Ablauf der Färbung ist in @bloodsmear-staining dargestellt.

    == Auswertung und Analyse <evaluation-and-analysis>

    - *Beobachtung:* Ungefärbte und gefärbte Präparate sorgfältig mikroskopisch betrachten.
    - *Auszählung:* Leukozyten werden systematisch im „Schlangenlinien“-Muster ausgezählt.
    - *Differenzierung:* Mithilfe histologischer Atlanten oder Vergleichspräparaten werden die Zelltypen identifiziert (Lymphozyten, Monozyten, Granulozyten) und in eine Tabelle eingetragen.
    - *Statistik:* Absolute und prozentuale Verteilungen dokumentieren, Bilder der Zelltypen anfertigen und die erhobenen Werte mit Literatur vergleichen.
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
  table-chi-square-anpassungstest, table-chi-square-independence-test,
  table-descriptive-statistics, table-one-sample-t-tests,
  table-two-sample-t-tests,
)
#import "analysis/calculations/data-processing.typ": (
  data-acute-erkrankungen-group, data-all-group, data-allergies-group,
  data-current-year-group, stats-acute-erkrankungen-group, stats-all-group,
  stats-allergies-group, stats-current-year-group, stats-for-set,
)

Es werden grundsätzlich nur auswertbare#footnote[Zelltypzählungen als Zahlen interpretierbar, Summe $> 0$.] Einzelpersonen-Daten analysiert. Leere Felder in den Rohdaten werden als 0 gewertet.

Sämtliche Statistiken und Grafiken werden, sofern sinnvoll, für folgende Datengruppen berechnet:
+ Alle Daten
+ MBI-Studiengang mit Start 2025
+ Personen mit Allergien
+ Personen mit akuten Erkrankungen

== Beschreibende Statistik <descriptive-statistics>

@table-descriptive-statistics zeigt die Gesamt-Leukozytenzahlen sowie die Verteilung der Zelltypen relativ zur Gesamtzahl. Diese Werte sind für die Interpretation entscheidend. Die absoluten Zahlen pro Zelltyp haben in nur wenig Aussagekraft.

Durch die Gruppierung wird sichtbar, dass Studierende mit akuten Erkrankungen einen höheren Anteil neutrophiler Granulozyten aufweisen als die Gesamtheit. Bei Allergikern treten basophile und eosinophile Granulozyten im Schnitt häufiger auf.

Dieser Trend ist in @boxplot-leukozyten erkennbar. Die Darstellung zeigt die Verteilung der Zelltypen relativ, jeweils ohne Gesamtzahl. In allen Gruppen liegt der Median für basophile und eosinophile Granulozyten bei 0%.

#{
  show: it => [#it <table-descriptive-statistics>]
  show: figure.with(
    caption: [Beschreibende Statistik der Leukozytenzahlen: absolute Leukozytenzahl und relative Anteile der Zelltypen.],
  )
  set par(justify: false)
  show: pad.with(right: -1cm)
  table-descriptive-statistics
}

#{
  show: it => [#it <boxplot-leukozyten>]
  show: figure.with(
    caption: [Boxplot der relativen Anteile der Leukozytenarten im Bezug auf die Gesamtleukozytenzahl.],
  )
  show: rect
  boxplot-leukozyten
}

== Hypothesentests <hypothesis-tests>

Die folgenden Hypothesen werden jeweils gegen ihre Alternativhypothese getestet:
- Alle MBI-Studierenden weisen eine signifikant andere Leukozytenverteilung als die Referenzliteratur auf.
- Der MBI-Jahrgang 2025 hat eine signifikant andere Leukozytenverteilung als die Referenzliteratur.
- Allergiker zeigen eine signifikant andere Leukozytenverteilung als alle übrigen MBI-Studierenden.
- Akute Erkrankungen führen zu einer signifikant anderen Leukozytenverteilung als bei den übrigen MBI-Studierenden.
- Der Mittelwert des eosinophilen Anteils bei Allergikern ist signifikant höher als bei allen MBI-Studierenden.
- Der Mittelwert des basophilen Anteils bei Allergikern ist signifikant höher als bei allen MBI-Studierenden.
- Der Mittelwert des neutrophilen Anteils bei akut Erkrankten ist signifikant höher als bei allen MBI-Studierenden.
- Der Mittelwert des Monozytenanteils bei akut Erkrankten ist signifikant höher als bei allen MBI-Studierenden.

Die in @reference-values-adult-table aufgeführten Referenzbereiche für Erwachsene werden zur Auswertung herangezogen#footnote[Mittelwert des Referenzbereichs]. Das Signifikanzniveau für sämtliche Testungen ist #sym.alpha = 5%.

=== MBI-Studierende vs. Referenzliteratur <mbi-students-vs-reference-literature>

Zur Überprüfung, ob die Verteilung der Leukozytenarten bei allen MBI-Studierenden signifikant von der Literatur abweicht, wird ein $chi^2$-Anpassungstest durchgeführt. Dabei werden alle absoluten Zellzählungen über die Kohorte summiert. Die Testmethodik erlaubt lediglich ein Widerlegen, nicht das Bestätigen der Nullhypothese (Gleichverteilung). Für diesen Anwendungsfall ist das akzeptabel, da nur die Abweichung von der Literatur getestet wird. @src_dreiseitl

#let (plot, test-results) = table-chi-square-anpassungstest(
  data: data-all-group,
)
#{
  show: it => [#it <table-chi-square-anpassungstest-all-vs-reference>]
  show: figure.with(
    caption: [Tabelle des $chi^2$-Anpassungstests: Leukozytenverteilung aller MBI-Studierenden versus Referenzliteratur.],
  )
  plot
}

@table-chi-square-anpassungstest-all-vs-reference ergibt einen $chi^2$-Wert von #calc.round(digits: 2, test-results.t-value) sowie einen p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%. Da $#calc.round(digits: 2, test-results.p-value * 100)% < alpha = 5\%$, wird die Nullhypothese verworfen: die Leukozytenverteilung unterscheidet sich signifikant von der Referenz. Auch @heatmap-leukozyten-difference-all-vs-reference liefert entsprechende Hinweise.

#{
  show: it => [#it <heatmap-leukozyten-difference-all-vs-reference>]
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen der Leukozytenzahlen aller MBI-Studierenden von den Referenzwerten.],
  )
  show: rect
  heatmap-leukozyten-difference(
    title: [Abweichung aller MBI-Studierenden von den Referenzwerten.],
    height: 12cm,
    width: 100%,
  )
}

Alternativ wird für jeden Zelltyp ein Ein-Stichproben-t-Test gegen die Literatur durchgeführt. Dazu müssen die prozentualen Anteile $p$ mit $p^* = arcsin(sqrt(p))$ in eine annähernd normalverteilte Variable transformiert werden. @src_arcsin_squareroot_transform

#{
  show: it => [#it <t-tests-all-vs-reference>]
  show: figure.with(
    caption: [Tabelle der Ein-Stichproben-t-Tests: Leukozytenverteilung aller MBI-Studierenden gegen Literatur.],
  )
  table-one-sample-t-tests(stats: stats-all-group)
}

Die Ergebnisse in @t-tests-all-vs-reference bestätigen die $chi^2$-Resultate: Jeder Leukozytentyp weicht signifikant von den Referenzwerten ab.

Dieses Kapitel dient als methodische Referenz für nachfolgende statistische Vergleiche.

=== MBI 2025 vs. Referenzliteratur <mbi-2025-vs-reference-literature>

#let (plot, test-results) = table-chi-square-anpassungstest(
  data: data-current-year-group,
)
#{
  show: it => [#it <table-chi-square-anpassungstest-mbi-2025-vs-reference>]
  show: figure.with(
    caption: [Tabelle des $chi^2$-Anpassungstests: Leukozytenverteilung MBI 2025 gegen Literatur.],
  )
  plot
}

Bei @table-chi-square-anpassungstest-mbi-2025-vs-reference ergibt der $chi^2$-Wert von #calc.round(digits: 2, test-results.t-value) einen p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%, der erneut signifikante Abweichungen bedeutet. @t-tests-mbi-2025-vs-reference zeigt, dass lediglich die eosinophilen Granulozyten nicht signifikant differieren, im Gegensatz zum Gesamtkollektiv. Basophile traten im Jahrgang 2025 nicht auf und konnten nicht getestet werden.

#{
  show: it => [#it <t-tests-mbi-2025-vs-reference>]
  show: figure.with(
    caption: [Tabelle der Ein-Stichproben-t-Tests: Leukozytenverteilung MBI 2025 und Literatur.],
  )
  table-one-sample-t-tests(stats: stats-current-year-group)
}

=== Allergiker vs. restliche MBI-Studierende <allergies-vs-mbi-students>

#let (plot, test-results) = table-chi-square-independence-test(
  (
    label: "Allergiker",
    data: data-allergies-group,
  ),
  (
    label: "Restliche Probanten",
    data: data-all-group.filter(it => not it.has-allergy),
  ),
)

Die Unabhängigkeit der Gruppen wird mittels $chi^2$-Unabhängigkeitstest evaluiert. Er wird als Standardverfahren für den Vergleich zwei empirisch ermittelter Datengruppen verwendet. Das Ergebnis: @chi-square-independence-test-allergies-vs-mbi-students liefert einen $chi^2$-Wert von #calc.round(digits: 2, test-results.test-statistics) und einen p-Wert von #calc.round(digits: 2, test-results.p-value * 100)%. Die Nullhypothese (Unabhängigkeit) wird _nicht_ verworfen, da $#calc.round(digits: 2, test-results.p-value * 100)% > alpha = 5%$.

#{
  show: it => [#it <chi-square-independence-test-allergies-vs-mbi-students>]
  show: figure.with(
    caption: [Kontingenztabelle: Allergiker vs. restliche MBI-Studierende.],
  )
  plot
}

=== Akute Erkrankungen vs. restliche MBI-Studierende <acute-erkrankungen-vs-mbi-students>

#let (plot, test-results) = table-chi-square-independence-test(
  (
    label: "Akute Erkrankungen",
    data: data-acute-erkrankungen-group,
  ),
  (
    label: "Restliche Probanten",
    data: data-all-group.filter(it => not it.has-acute-erkrankung),
  ),
)

Auch in @chi-square-independence-test-acute-erkrankungen-vs-mbi-students ergibt sich kein signifikanter Unterschied (p-Wert = #calc.round(digits: 2, test-results.p-value * 100)% > 5% mit $chi^2$-Wert = #calc.round(digits: 2, test-results.test-statistics)).

#{
  show: it => [#it <chi-square-independence-test-acute-erkrankungen-vs-mbi-students>]
  show: figure.with(
    caption: [Kontingenztabelle: Akute Erkrankungen vs. restliche MBI-Studierende.],
  )
  plot
}

Ein Vergleich der Heatmaps (@heatmap-leukozyten-difference-healthy-vs-reference gegenüber @heatmap-leukozyten-difference-all-vs-reference) verdeutlicht die sehr geringe Differenz zwischen gesunden und Gesamtgruppe.

#{
  show: it => [#it <heatmap-leukozyten-difference-healthy-vs-reference>]
  show: figure.with(
    caption: [Heatmap der relativen Abweichungen (ohne Allergiker und Akute) gegenüber Referenzwerten.],
  )
  show: rect
  heatmap-leukozyten-difference(
    title: [Abweichungen gesunder#footnote[nicht allergisch, nicht akut erkrankt] MBI-Studierender von Referenzwerten.],
    height: 10cm,
    width: 100%,
    data-transform: it => it.filter(it => {
      not it.has-allergy and not it.has-acute-erkrankung
    }),
  )
}

=== Zelltypen bei Allergien vs. restliche MBI-Studierende <celltypes-allergies-vs-mbi-students>

Der Zwei-Stichproben-t-Test dient als Standardverfahren für Gruppenvergleiche. In @t-tests-allergies-vs-mbi-students zeigen sich keine signifikanten Unterschiede in den Erwartungswerten irgendeines Zelltyps und somit kein statistisch belegbarer Einfluss von Allergien auf das Blutbild.

Beide entsprechenden Hypothesen aus @hypothesis-tests werden nicht belegt.

#{
  show: it => [#it <t-tests-allergies-vs-mbi-students>]
  show: figure.with(
    caption: [Tabelle der Zwei-Stichproben-t-Tests: Allergiker vs. restliche MBI-Studierende.],
  )
  table-two-sample-t-tests(
    (
      label: "Allergiker",
      statistics: stats-allergies-group,
    ),
    (
      label: "Restliche Probanten",
      statistics: stats-for-set(data-all-group.filter(it => {
        not it.has-allergy
      })),
    ),
  )
}

=== Zelltypen bei akuten Erkrankungen vs. restliche MBI-Studierende <celltypes-acute-erkrankungen-vs-mbi-students>

Auch für akute Erkrankungen führt der Gruppenvergleich @t-tests-acute-erkrankungen-vs-mbi-students zu keinem signifikanten Unterschied in den Verteilungen der Zelltypen. Keine der testierten Hypothesen kann bestätigt werden.

#{
  show: it => [#it <t-tests-acute-erkrankungen-vs-mbi-students>]
  show: figure.with(
    caption: [Tabelle der Zwei-Stichproben-t-Tests: Akute Erkrankungen vs. restliche MBI-Studierende.],
  )
  table-two-sample-t-tests(
    (
      label: "Akute Erkrankungen",
      statistics: stats-acute-erkrankungen-group,
    ),
    (
      label: "Restliche Probanten",
      statistics: stats-for-set(data-all-group.filter(it => {
        not it.has-acute-erkrankung
      })),
    ),
  )
}

== Messungen

Konkrete Zellgrößenmessungen konnten im Experiment nicht vorgenommen werden. @leukozyt-reference-sizes aus @reference-values-from-literature gibt die Literaturwerte für die einzelnen Zellarten an. Diese Angaben erscheinen plausibel, da die Zellen sonst mikroskopisch in dem durchgeführten Experiment nicht klar erkennbar wären.

#pagebreak()
= Interpretation

== Vergleich der Messwerte mit Referenzwerten

Die statistische Analyse der gesamten MBI-Studierenden ($N = 173$) ergibt im $chi^2$-Anpassungstest eine hochsignifikante Abweichung zur Literatur ($chi^2 = 1395.18$, $p = 0%$). Die Nullhypothese identischer Verteilung wird eindeutig verworfen. Das gleiche Resultat zeigt sich für die Teilgruppe "MBI 2025" ($p = 0.04%$).

Die Einzel-Betrachtung der transformierten Ein-Stichproben-t-Tests verdeutlicht wichtige Trends:

- *Neutrophile Granulozyten:* Der Mittelwert liegt mit $43.41%$ deutlich unter dem Literaturwert ($59.81%$).
- *Lymphozyten, Monozyten und Basophile:* Bei allen ist der Mittelwert signifikant erhöht (Lymphozyten: $38.39%$ vs. $32.71%$; Monozyten: $12%$ vs. $4.67%$; Basophile: $4.14%$ vs. $0.47%$).

*Statistische Power großer Stichproben*\
Die kollektive, derart starke Abweichung bei nahezu 200 mutmaßlich gesunden Proband*innen ist klinisch unwahrscheinlich. Das liegt an der sehr hohen Power des Anpassungstests bei Aggregation aller Einzelzählungen ($N = 173$): Selbst geringste, biologisch unbedeutende Verzerrungen oder Zählfehler führen zu extrem niedrigen p-Werten.

Eine Ausnahme bildet "MBI 2025" ($n = 9$): Nur die eosinophilen Granulozyten weichen nicht signifikant ab ($1.96%$ vs. $2.34%$, $p = 16.86%$). Hier wirkt sich die geringere Stichprobengröße aus und lässt größere Zufallsschwankungen zu. Basophile wurden in diesem Jahrgang nicht gefunden.

== Sondersituationen: Allergiker und Akut-Erkrankte

Am überraschendsten ist, dass weder Allergien noch akute Erkrankungen einen statistisch belegten Einfluss auf das Differentialblutbild der Studierenden hatten:

- *Allergiker vs. übrige*: Der $chi^2$-Test weist mit $p = 56.79%$ keine Gruppenabhängigkeit nach. Auch die Zwei-Stichproben-t-Tests zeigen bei keinem Zelltyp (einschließlich Eosinophiler und Basophiler) einen signifikanten Unterschied ($p > 0.05$). Die Hypothesen, Allergiker hätten mehr Eosinophile ($2.73%$) oder Basophile ($4.63%$), werden damit nicht bestätigt.
- *Akut Erkrankte vs. übrige*: Auch hier bleibt der $chi^2$-Test mit $p = 31.55\%$ weit von der Signifikanz entfernt. Weder eine erwartbare Neutrophilien-Phase noch eine akute Lymphozytose können rechnerisch gezeigt werden.

*Klinische Erwartung versus studentische Praxis*\
Pathophysiologisch würden akute bakterielle Infektionen zu einer Neutrophilie (mit Linksverschiebung), Allergien zu einer Eosinophilie/Basophilie führen. Das bleibt im Labordatenbild aus. Der Hauptgrund ist das unspezifische Abfragefeld („kürzlich krank“ oder „Allergie“): Es differenziert nicht nach Schwere, Reaktivität oder zeitlichem Verlauf. Ein abklingender leichter Infekt vor zwei Wochen hinterlässt im Blutausstrich keine nachweisbare Leukozytose, verwässert aber statistisch die Gruppe „Akute Erkrankungen“.

== Fehlerbetrachtung und methodische Einschränkungen

Sowohl das Ausbleiben klinisch erwarteter Trends als auch die extremen Abweichungen zur Literatur erklären sich durch mehrere gravierende methodische Schwachstellen:

- *Hohe Varianz bei Gesamtzellzahlen:* Die beschreibende Statistik zeigt einen Mittelwert von $31.36 plus.minus 25.5$ Zellen pro Person (Minimum $1$, Maximum $191$ Zellen). Prozentuale Differenzierung auf Basis von unter 10 Zellen ist statistisch unzulässig, denn das Gesetz der großen Zahlen greift nicht. Es entstehen starke Zufallsschwankungen in den Relativwerten.
- *Subjektive Fehlklassifikation beim Mikroskopieren:* Ohne Okularmikrometer erfolgte die Zelltypbestimmung rein visuell. Besonders große Lymphozyten können leicht mit Monozyten verwechselt werden und erklären vermutlich den auffällig hohen Monozytenanteil ($12%$ vs. $4.67%$).
- *Mängel in der Ausstrichtechnik:* Zu schnelles Streichen erzeugt ungleichmäßige, zu dünne Filme; zu langsames Streichen deformiert oder verklumpt Erythrozyten. Beides erschwert die Identifikation im Randbereich.
- *Qualität der Pappenheim-Färbung:* Die Färbung ist sehr empfindlich gegen Zeit und Feuchtigkeit. Trocknet die Giemsa-Lösung während der 15-minütigen Inkubation partiell an, ändert sich das Färbeverhalten der Zellbestandteile massiv. In etwa erscheinen basophile Strukturen zu schwach, neutrophile Granula werden zu stark gefärbt.

== Zusammenfassende Bedeutung

Fazit: Das Experiment „Blutausstrich“ eignet sich bestens, um praktische Grundlagen der Hämatologie (Ausstrichtechnik, Pappenheim-Färbung) und die morphologische Vielfalt der Leukozyten kennenzulernen. Für epidemiologische oder klinische Fragestellungen ist diese studentische Datengrundlage jedoch nicht geeignet.

Wesentliche Gründe: Fehlende Standardisierung der Zellzählung, subjektive Fehlerquellen bei der Identifikation und Auswertung, sowie sehr begrenzte Gruppengrößen. Moderne Diagnostik setzt aus gutem Grund auf automatisierte Hämatologie-Analysatoren, da sie objektive und zuverlässige Ergebnisse liefern @src_doccheck_differential_blutbild.

#pagebreak()
#set heading(numbering: none)
#show heading.where(level: 1): box
= Anhang <appendix>

#show bibliography: set heading(level: 2)
#show outline: set heading(level: 2, outlined: true)
#bibliography("bib.yaml", title: "Literaturverzeichnis", style: "ieee")

#colbreak()
#outline(target: figure.where(kind: image), title: "Abbildungsverzeichnis")

#outline(target: figure.where(kind: table), title: "Tabellenverzeichnis")
