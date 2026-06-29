#import "../../templates/protocol.tpl.typ": bio-template

#set document(title: "Messung der Sehschärfe")
#set text(lang: "de")
#show: bio-template.with(
  show-cover-page: true,
  subtitle: "Landoltringe",
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
//#pdf.attach(
 // "Instructions Blood experiments.pdf",
 // mime-type: "application/pdf",
 // relationship: "supplement",
 // description: "Angabe für den Blutausstrich",
//)
#import "@preview/meander:0.4.3"

#pdf.attach(
  "Sinne_Landoltring.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe",
)
#import "@preview/meander:0.4.2"


// ==========================================
// GLOBALE DESIGN-REGELN
// ==========================================

// 1. Schöne, hervorgehobene Formeln
// Gilt nur für abgesetzte Formeln (mit $$ oder leeren Zeilen), 
// normale Formeln im Text ($...$) bleiben unberührt!
#show math.equation.where(block: true): it => block(
  fill: rgb("f8f9fa"),                 // Sehr helles, edles Grau als Hintergrund
  width: 100%,                         // Block geht über die ganze Textbreite
  inset: 12pt,                         // Innenabstand (Luft zum Atmen)
  radius: 6pt,                         // Leicht abgerundete Ecken
  stroke: 0.5pt + rgb("ced4da"),       // Dezenter, hellgrauer Rand
  align(center, it)                    // Formel bleibt schön zentriert
)

#show figure.caption: set align(center)

= Theoretischer Hintergrund

== Physiologische Grundlagen der Sehschärfe

Die Sehschärfe (auch Visus genannt) ist das wichtigste Maß für die funktionelle Leistungsfähigkeit des visuellen Systems. Sie beschreibt das räumliche Auflösungsvermögen des Auges, also die Fähigkeit der Netzhaut (Retina), zwei eng nebeneinanderliegende Punkte bei optimalen Kontrastverhältnissen gerade noch als getrennt wahrzunehmen. 

Aus anatomischer Sicht hängt dieses Auflösungsvermögen maßgeblich von der Dichte und Verschaltung der Photorezeptoren (insbesondere der Zapfen) in der Fovea centralis (dem Ort des schärfsten Sehens) ab. Die Messung des Visus erfolgt über ein subjektives Prüfverfahren, bei dem eine Versuchsperson standardisierte Sehzeichen (Optotypen) aus einer definierten Entfernung ablesen muss.


=== Referenzwerte und Einflussfaktoren
Als klinischer Standard für eine normale, fehlerfreie Sehschärfe des menschlichen Auges gilt ein Visus von 1,0 (entspricht nach internationaler Norm 100 % Sehleistung). Dieser Wert ist jedoch kein biologisches Maximum:
- *Jugendliche und junge Erwachsene* erreichen aufgrund einer optimalen Rezeptordichte und klaren Augenmedien häufig überdurchschnittliche Visus-Werte von $1,2$ bis $1,5$ (manchmal sogar bis zu $2,0$).
- *Mit steigendem Lebensalter* nimmt der Visus natürlicherweise kontinuierlich ab. Ursachen hierfür sind die nachlassende Elastizität und Trübung der Augenlinse sowie degenerative Prozesse der Netzhautzellen.

=== Anatomische und optische Einflussfaktoren
Das räumliche Auflösungsvermögen des Auges ist das Endergebnis einer präzise abgestimmten Kette aus physikalischer Lichtbrechung und neuronaler Signalverarbeitung. Es hängt im Wesentlichen von drei physiologischen Komponenten ab:

1. *Die Rezeptordichte in der Fovea centralis:* Damit das Gehirn zwei Punkte als getrennt wahrnehmen kann, müssen auf der Netzhaut zwei Photorezeptoren (Zapfen) erregt werden, zwischen denen mindestens ein nicht erregter Zapfen liegt (die sogenannte Richtungs-Unterscheidungsschwelle). Je enger und feiner diese Zapfen gepackt sind, desto kleinere Details kann das Auge auflösen.
2. *Die neuronale Verschaltung (Konvergenz):* In der Fovea centralis (dem Ort des schärfsten Sehens) liegt eine exakte 1:1:1-Verschaltung vor. Ein einzelner Zapfen leitet sein Signal an genau eine bipolare Zelle weiter, welche es wiederum an genau eine Ganglienzelle abgibt. Es gibt hier keine Signalbündelung (Konvergenz). In der Peripherie der Netzhaut hingegen teilen sich tausende Rezeptoren eine Ganglienzelle – das erhöht zwar die Lichtempfindlichkeit im Dunkeln, reduziert die Sehschärfe jedoch drastisch.
3. *Die Qualität des dioptrischen Apparats:* Die optische Qualität von Hornhaut, Augenlinse, Glaskörper und dem Tränenfilm bestimmt, wie fehlerfrei das Licht auf der Netzhaut fokussiert wird. Physikalische Abbildungsfehler (wie sphärische oder chromatische Aberrationen) begrenzen das theoretisch mögliche Auflösungsvermögen.

=== Ursachen für den überdurchschnittlichen Visus bei Jugendlichen
Dass Jugendliche und junge Erwachsene häufig Visus-Werte von $1,2$ bis $1,5$ (120 % bis 150 %) oder sogar darüber erreichen, liegt an einem biologischen Zustand maximaler Leistungsfähigkeit aller beteiligten Systeme:

- *Maximale Zapfendichte:* Die anatomische Packungsdichte der fovealen Zapfen erreicht im späten Jugendalter ihr biologisches Maximum. Die Zellen sind in diesem Alter extrem schlank, lang und lückenlos aneinandergereiht.
- *Absolute Transparenz der Medien:* Die kristallinen Proteine innerhalb der Augenlinse sind in jungen Jahren perfekt homogen angeordnet. Dadurch entsteht so gut wie kein Streulicht im Auge, was zu einem maximalen Bildkontrast auf der Retina führt.
- *Optimale Pupillendynamik:* Junge Augen besitzen eine hochflexible Iris. Die Pupillengröße wird perfekt reguliert, um den physikalischen Kompromiss zwischen Beugungsunschärfe (bei zu kleiner Pupille) und Linsenfehlern (bei zu weit geöffneter Pupille) zu optimieren.
- *Neuronale Plastizität und Effizienz:* Die synaptische Signalübertragung im visuellen Cortex (Sehrinde) arbeitet auf dem Höhepunkt ihrer Entwicklungs- und Verarbeitungsgeschwindigkeit.

=== Ursachen für den altersbedingten Visusabfall
Mit steigendem Lebensalter nimmt der Visus kontinuierlich ab – selbst dann, wenn keine pathologischen Erkrankungen wie der Graue Star (Katarakt) oder eine Makuladegeneration vorliegen. Dieser natürliche Prozess hat physiologische Gründe:

- *Optischer Qualitätsverlust der Linse:* Die Augenlinse verliert im Laufe des Lebens nicht nur ihre Elastizität (was zur bekannten Alterssichtigkeit/Presbyopie führt), sondern lagert auch kontinuierlich unlösliche Eiweißverbindungen ein. Die Linse vergilbt leicht und wird mikroskopisch unruhiger. Das einfallende Licht wird dadurch gestreut, wodurch das Netzhautbild flauer und unschärfer wird.
- *Altersmiosis (Senile Miosis):* Der Muskel, der die Pupille weitet (*Musculus dilatator pupillae*), degeneriert im Alter leicht und verliert an Kraft. Die Pupille älterer Menschen ist dadurch im Ruhezustand permanent kleiner. Dies führt dazu, dass deutlich weniger Licht auf die Netzhaut trifft (Verringerung der retinalen Beleuchtungsstärke), was das Auflösungsvermögen besonders bei mäßigem Licht stark herabsetzt.
- *Schleichender Zellverlust:* Obwohl die Fovea centralis relativ gut geschützt ist, verliert der Mensch über die Jahrzehnte natürlicherweise einen Prozentsatz seiner Photorezeptoren und retinalen Ganglienzellen. Weniger Rezeptoren pro Quadratmillimeter bedeuten automatisch ein geringeres maximales Auflösungsvermögen.
- *Verlangsamung der zentralen Verarbeitung:* Die neuronale Leitungsgeschwindigkeit im Sehnerv und die Effizienz der Bildauswertung im Gehirn nehmen durch den allgemeinen Alterungsprozess des Nervensystems ab.



== Abgrenzung: Sehschärfe (Visus) vs. Brechwert (Dioptrien)

In der Praxis existiert häufig das Missverständnis, dass ein Visus von 1,0 automatisch bedeutet, dass keine Fehlsichtigkeit (0 Dioptrien) vorliegt. Medizinisch und physikalisch müssen diese beiden Größen jedoch strikt voneinander abgegrenzt werden:

1. *Visual Acuity / Visus:* Misst die tatsächliche visuelle Leistung (den Output des Gesamtsystems). Es handelt sich um eine dimensionslose Verhältniszahl oder Prozentangabe.
2. *Brechwert (Dioptrien, D):* Misst die optische Brechkraft bzw. den Refraktionsfehler des Auges (den physikalischen Input). Die Einheit ist $1 / "m"$. Ein negativer Wert (z. B. $-2,5$ D) beschreibt eine Myopie (Kurzsichtigkeit), ein positiver Wert eine Hyperopie (Weitsichtigkeit).

*Ursache-Wirkungs-Prinzip:* Die Dioptrienzahl beschreibt die rein physikalische Fehlfokussierung des Lichts vor oder hinter der Netzhaut. Der Visus hingegen beschreibt das Endergebnis inklusive der neuronalen Verarbeitung. Zwei Personen mit exakt demselben Refraktionsfehler von $-2,0$ Dioptrien können nach optimaler Korrektur völlig unterschiedliche Visus-Werte (z. B. $0,8$ vs. $1,2$) aufweisen, da die Netzhautgesundheit und die kortikale Verarbeitung die Sehschärfe limitieren. Ein Visus kann ohne Angabe von Dioptrien existieren, Dioptrien beschreiben lediglich die Stärke des benötigten Korrekturglases.

== Klinische Relevanz

Die Bestimmung der Sehschärfe mittels standardisierter Optotypen wie dem Landolt-Ring ist nicht nur ein theoretisches Instrument der Sinnesphysiologie, sondern bildet das Fundament der täglichen ophthalmologischen und optometrischen Praxis. Der Visus ist der wichtigste funktionelle Parameter zur Beurteilung des visuellen Systems.

=== Diagnostik von Refraktionsfehlern
Die primäre klinische Anwendung des Visustests besteht in der Aufdeckung und Quantifizierung von Fehlsichtigkeiten (Ametropien). Ein verminderter unkorrigierter Visus liefert den initialen Hinweis auf das Vorliegen von:
- *Myopie (Kurzsichtigkeit):* Der Fokus der Lichtstrahlen liegt vor der Retina.
- *Hyperopie (Weitsichtigkeit):* Der physikalische Brennpunkt liegt theoretisch hinter der Netzhaut.
- *Astigmatismus (Stabsichtigkeit):* Eine ungleichmäßige Krümmung der Hornhaut führt zu einer Verzerrung des Netzhautbildes in bestimmten Meridianen. Hierbei erweist sich der Landolt-Ring als besonders wertvoll, da Probanden mit Astigmatismus oft Lücken in bestimmten Achsenlagen (z. B. oben/unten) deutlich schlechter erkennen als in anderen (z. B. links/rechts).

=== Verlaufskontrolle und postoperative Überwachung
In der klinischen Medizin dient der Visus als primärer Indikator für den Erfolg therapeutischer Interventionen. Er wird standardmäßig eingesetzt zur:
- *Postoperativen Überwachung:* Nach chirurgischen Eingriffen wie einer Katarakt-Operation (Einsatz einer künstlichen Intraokularlinse) oder refraktiver Chirurgie (z. B. LASIK/PRK) dokumentiert der Anstieg des Visus den Heilungsverlauf.
- *Verlaufskontrolle progressiver Augenerkrankungen:* Bei chronischen, potenziell erblindenden Erkrankungen wie der altersabhängigen Makuladegeneration (AMD), dem Glaukom (Grüner Star) oder der diabetischen Retinopathie ist ein kontinuierlicher Visusabfall das Leitsymptom für ein Fortschreiten der Pathologie und signalisiert dringenden therapeutischen Handlungsbedarf.

=== Amtliche und gutachterliche Relevanz
Da die Sehschärfe die Teilhabe am öffentlichen Leben und die Eignung für bestimmte Berufe maßgeblich bestimmt, ist die Durchführung von standardisierten Visustests gesetzlich verankert:
- *Führerschein-Sehtest:* Nach den gesetzlichen Vorgaben (in Deutschland/Österreich) ist für das Führen von Kraftfahrzeugen der Klasse B ein monokularer Mindestvisus von $0,7$ auf jedem Auge erforderlich. Die Verwendung des Landolt-Rings ist hierbei für amtliche Gutachten zwingend vorgeschrieben, um eine Verfälschung durch Memorierungseffekte auszuschließen.
- *Berufliche Eignungsprüfungen:* Für Hochrisikoberufe wie Piloten, Fluglotsen, Polizisten oder Triebfahrzeugführer gelten streng limitierte Visus-Grenzwerte (oft ein unkorrigierter oder korrigierter Visus von exakt $1,0$ auf beiden Augen), die im Rahmen von regelmäßigen arbeitsmedizinischen Screenings überprüft werden.

=== Früherkennung neurodegenerativer und zerebraler Erkrankungen
Da die Netzhaut embryologisch eine Ausstülpung des Zwischenhirns darstellt und der Sehnerv direkt zum zentralen Nervensystem (ZNS) gehört, ist die Sehschärfe ein sensibler Indikator für neurologische Pathologien. Ein Sehschärfenverlust ohne primären ophthalmologischen Befund kann auf neurodegenerative Prozesse oder intrakranielle Raumforderungen hinweisen. Beispielsweise ist eine Sehnerventzündung (_Neuritis nervi optici_) in vielen Fällen das klinische Erstsymptom einer Multiplen Sklerose (MS). Ebenso können Tumore im Bereich der Sehbahn (wie Hypophysenadenome) zu Visusminderungen führen.

=== Amblyopie-Screening in der Pädiatrie
In der Kinderheilkunde ist die Visusbestimmung kritisch für die Erkennung einer Amblyopie (funktionelle Sehschwäche). Liegt in den ersten Lebensjahren ein Schielen (_Strabismus_) oder eine ungleiche Brechkraft der Augen (_Anisometropie_) vor, unterdrückt das kortikale Sehzentrum das Bild des betroffenen Auges. Wird dies nicht in der sensiblen Entwicklungsphase (bis ca. zum 7. Lebensjahr) diagnostiziert und therapiert, bleibt die Sehschwäche trotz späterer optimaler Brillenkorrektur lebenslang bestehen.

=== Pharmakotoxikologisches Monitoring
Einige systemische Langzeittherapien erfordern obligatorische Visuskontrollen aufgrund potenzieller Retinotoxizität. Substanzen wie Hydroxychloroquin (Einsatz bei Rheuma) oder Ethambutol (Tuberkulostatikum) können irreversible Schäden an den Photorezeptoren oder dem Sehnerv verursachen, die sich initial durch eine Reduktion des Visus ankündigen.

== Klassifikation und Physiologie von Sehzeichen (Optotypen)

=== Definition und Grundlagen
Als Optotypen (Sehzeichen) werden standardisierte grafische Symbole bezeichnet, die in der Augenheilkunde und Optometrie zur Messung der Sehschärfe (Visus) herangezogen werden. Ihre Konstruktion basiert auf dem Prinzip, dass kritische Details des Zeichens (z. B. Strichstärken, Zwischenräume oder Lücken) unter einem exakt definierten Sehwinkel erscheinen, wenn sich der Proband in der vorgeschriebenen Prüfdistanz befindet. 

In der klinischen Praxis existieren verschiedene Formen von Optotypen, die je nach Anwendungsbereich Vor- und Nachteile aufweisen:
- *Snellen-E (E-Haken / Pflüger-Haken):* Einem „E“ nachempfundenes Zeichen, dessen Balken und Zwischenräume alle dieselbe Breite aufweisen. Der Proband muss die Orientierung (oben, unten, links, rechts) angeben. Häufig eingesetzt bei Kindern oder Analphabeten.
#grid(
  columns: (2fr, 1fr),
  align: left + horizon,
  gutter: 2em, 
[- *Snellen-Buchstaben / Sloan-Buchstaben:* Standardisierte lateinische Großbuchstaben. Sloan-Buchstaben (C, D, H, K, N, O, R, S, V, Z) wurden speziell so entworfen, dass sie untereinander eine nahezu identische Erkennbarkeit aufweisen. Sie sind im klinischen Alltag sehr beliebt, bergen jedoch das Risiko von Memorierungseffekten und weisen kultur- sowie sprachabhängige Barrieren auf. ],
figure(image("/assets/image-6.png", width: 50%), caption: [Snellen-E / E-Haken])
)
- *Kinder-Sehzeichen (z. B. Lea-Symbole):* Einfache geometrische Formen wie Kreis, Quadrat, Haus oder Apfel. Sie dienen der Visusbestimmung im Kleinkindalter, weisen jedoch aufgrund ihrer komplexeren Konturen eine geringere mathematische Präzision auf.

=== Skalierungssysteme: Snellen vs. LogMAR
Die Anordnung von Optotypen auf Sehtafeln folgt historisch und methodisch zwei unterschiedlichen mathematischen Prinzipien:

1. *Snellen-Prinzip (Dezimal- und Bruchskalierung):*
   Die klassische Sehtafel vergrößert die Zeichen von Zeile zu Zeile unregelmäßig. Zudem ändert sich die Anzahl der Optotypen pro Zeile (oben wenige, unten viele). Dies führt zu dem methodischen Problem, dass Fehler in den unteren Zeilen statistisch schwerer ins Gewicht fallen als in den oberen. Zudem ist der relative Schwierigkeitssprung zwischen den Zeilen ungleichmäßig.

2. *LogMAR-Prinzip (Logarithmus des Minimum Angle of Resolution):*
   Moderne Forschungstafeln (wie die ETDRS-Charts) nutzen eine rein logarithmische Skalierung. Jede Zeile enthält exakt dieselbe Anzahl an Buchstaben (meist 5) und der Zeilenabstand ist proportional zur Buchstabengröße. Ein LogMAR-Wert von $0,0$ entspricht einem Visus von $1,0$. Dieses Design eliminiert statistische Verzerrungen und ist der Goldstandard in wissenschaftlichen Studien.

== Der Landolt-Ring als internationaler Standard-Optotyp

Für wissenschaftliche Untersuchungen, arbeitsmedizinische Screenings und flugmedizinische Gutachten ist der Landolt-Ring (auch Landolt-C genannt) nach der internationalen Norm *DIN EN ISO 8596* als gesetzliches Standardsehzeichen (Referenzoptotyp) vorgeschrieben. Alle anderen Sehzeichen müssen vor ihrem klinischen Einsatz paritätisch am Landolt-Ring kalibriert werden.

=== Geometrische Eigenschaften und strikte Dimensionierung
Die Geometrie des Landolt-Rings ist mathematisch streng definiert und absolut proportional aufgebaut. Unabhängig von der realen Druckgröße in einer bestimmten Visuszeile gilt für die Bemaßung immer ein fixes Verhältnis von *5 : 3 : 1* (siehe Abbildung 2):
#grid(
  columns: (2fr, 1fr),
  align: left + horizon,
  gutter: 2em, 
[- *Außendurchmesser ($d_("a")$):* Definiert die Gesamtgröße des Sehzeichens. Er entspricht exakt dem 5-fachen Wert der Strichstärke bzw. Lückenbreite ($5 times a$).
- *Innendurchmesser ($d_("i")$):* Beschreibt den inneren, weißen Kreis des Ringes. Er entspricht exakt dem 3-fachen Wert der Lückenbreite ($3 times a$).
],
figure(image("/assets/image-7.png", width: 63%), caption: [Landoltenring])
)




#meander.reflow({
  import meander: *
  // Obstacles
  placed(top + right, boundary: // Override the default margin
      contour.margin(5mm), figure(image("/assets/image-10.png", width: 25%,), caption: [Landoltringe in 8 Orientierungen]))
  // Container
  container(margin:5cm)

  // Flowing text
  content[
- *Die Lücke und Strichstärke ($a$):* Dies ist das kritische Detail, das es aufzulösen gilt. Die Breite der Lücke ist mathematisch identisch mit der Strichstärke des schwarzen Rings und beträgt präzise *1/5* des Außendurchmessers ($a = d_("a") / 5$). 
=== Richtungspräsentation
Um ein Erraten zu minimieren, wird der Ring in insgesamt *8 Orientierungen* dargeboten. Neben den vier Hauptkardinalrichtungen (0°, 90°, 180°, 270°) erfolgt die Präsentation auch in den vier 45°-Schräglagen. Dies erhöht die methodische Validität gegenüber dem E-Haken (nur 4 Richtungen) signifikant.
]
})

== Physiologische und methodische Notwendigkeit der Dimensionen

Die strikte Geometrie des Landolt-Rings ist kein Willkürprodukt, sondern resultiert direkt aus den physikalischen und physiologischen Gesetzmäßigkeiten des menschlichen Auges:

#meander.reflow({
  import meander: *
  // Obstacles
  placed(top + right, boundary: // Override the default margin
      contour.margin(5mm), figure(image("/assets/image-8.png", width: 45%,), caption: [Dimensionierung und Sehwinkel des Landoltringes]))
  // Container
  container(margin:5cm)

  // Flowing text
  content[
1. *Exakte Definition des kritischen Details:*
   Damit das Auge ein Sehzeichen auflösen kann, ist nicht die Gesamterscheinung entscheidend, sondern das kleinste, trennende Detail. Beim Landolt-Ring ist dies die Lücke $a$. Beträgt der Visus $1,0$, erscheint diese Lücke dem Auge unter einem Sehwinkel von exakt einer Bogenminute ($1'$). Da die Strichstärke ebenfalls $1'$ misst und der gesamte Ring somit unter einem Sehwinkel von $5'$ erscheint, wird sichergestellt, dass das Zeichen optimal auf der Fovea centralis abgebildet wird, ohne dass es zu Beugungsunschärfen am Rand kommt.
]
})
2. *Vermeidung von Formwahrnehmung und kortikaler Erkennung:*
   Buchstaben wie ein „E“ oder „A“ besitzen charakteristische geometrische Außenformen. Das menschliche Gehirn ist durch neuronale Lernprozesse (Top-Down-Verarbeitung) extrem gut darin, unscharfe Buchstabenformen zu erraten, selbst wenn die einzelnen Striche physikalisch gar nicht mehr aufgelöst werden können. Der Landolt-Ring hingegen besitzt in jeder Orientierung eine identische kreisrunde Außenkontur. Das Gehirn kann die Position der Lücke nur dann bestimmen, wenn die Photorezeptoren auf der Retina die Lücke physikalisch rein als Helligkeitsunterschied (Weiß vs. Schwarz) auflösen. Es misst somit die reine physiologische Auflösungsgrenze und nicht die kognitive Kombinationsgabe.

3. *Detektion von astigmatischen Abbildungsfehlern:*
   Durch die 8-fache Orientierung der Lücke eignet sich der Landolt-Ring hervorragend zur Aufdeckung eines Astigmatismus (Stabsichtigkeit). Da bei einer Hornhautverkrümmung die Lichtstrahlen in einer Ebene (z. B. vertikal) anders gebrochen werden als in der Ebene senkrecht dazu (z. B. horizontal), verschwimmt das Netzhautbild richtungsabhängig. Ein Proband mit einem unkorrigierten Astigmatismus wird infolgedessen die Lücken bei 12 und 6 Uhr problemlos erkennen, während er die Lücken bei 3 und 9 Uhr völlig übersieht (oder umgekehrt). Konzentrische, regelmäßige Zeichen wie der Landolt-Ring machen diese kortikalen und optischen Asymmetrien sofort messbar.

4. *Kultur- und Sprachunabhängigkeit:*
   Da der Test keinerlei Alphabetisierung oder Kenntnis spezifischer Schriftzeichen voraussetzt, ist er weltweit universell einsetzbar und schließt sprachlich oder bildungsbedingt verfälschte Messergebnisse vollständig aus. 

== Mathematische Beschreibung und der Sehwinkel

Die Sehschärfe wird physikalisch über den sogenannten Sehwinkel ($alpha$) definiert. Der Sehwinkel ist der Winkel, den das betrachtete Objekt (hier die Lücke $a$ des Landolt-Rings) im Auge des Betrachters einnimmt. Er bestimmt die physikalische Bildgröße auf der Netzhaut.

Als physiologische Grenzauflösung des gesunden Auges gilt ein Sehwinkel von exakt einer Bogenminute ($1' = 1/60°$). Kann das Auge eine Lücke, die unter diesem Winkel erscheint, gerade noch auflösen, beträgt der Visus exakt $1,0$. Allgemein gilt:

$ V = 1 / alpha_("in Bogenminuten") $ <eq-visus-winkel>

=== Die klinische Standardformel
Im klinischen Alltag wird der Visus als Snellen-Bruch angegeben:

$ V = d / D $ <eq-snellen>

Dabei ist:
- $d$: Die tatsächliche Prüfdistanz(Abstand der Versuchsperson zur Sehtafel in Metern).
- $D$: Die Soll-Entfernung (Nominalabstand). Dies ist die Entfernung, aus der ein normalsichtiges Auge ($V = 1,0$) die Lücke des Rings gerade noch unter einem Sehwinkel von $1'$ sieht.

==== Praktische Rechenbeispiele zur Snellen-Notation

Um das Prinzip des Snellen-Bruchs zu veranschaulichen, werden im Folgenden typische metrische, imperiale und auf dieses Praktikum bezogene Berechnungen gegenübergestellt:

#block(
  fill: rgb("f8f9fa"),
  inset: 15pt,
  radius: 6pt,
  stroke: 0.5pt + rgb("ced4da"),
  width: 100%,
)[
  *Beispiel 1: Normalsichtigkeit im Praktikumsaufbau*
  - *Prüfdistanz ($d$):* Der Proband steht im vorgeschriebenen, fixen Laborabstand von $d = 4,6$ Metern zur Sehtafel.
  - *Soll-Entfernung ($D$):* Der Proband kann die Lücke des Landolt-Rings in der Zeile auflösen, die für eine Soll-Entfernung von $D = 4,6$ Metern konstruiert wurde.
  - *Berechnung:* 
    $ V = (4,6 " m") / (4,6 " m") = 1,0 $
    Dies entspricht einer normalen Sehschärfe (Dezimalvisus von $1,0$ bzw. 100 % Sehleistung).

  #v(8pt)
  *Beispiel 2: Unkorrigierte Fehlsichtigkeit (Myopie)*
  - *Prüfdistanz ($d$):* Der Proband befindet sich weiterhin im fixen Abstand von $d = 4,6$ Metern.
  - *Soll-Entfernung ($D$):* Aufgrund einer Kurzsichtigkeit kann der Proband die kleinen Zeilen nicht auflösen. Das kleinste Zeichen, dessen Lücke er gerade noch korrekt identifizieren kann, stammt aus der großen Zeile mit einer Soll-Entfernung von $D = 9,2$ Metern. (Ein normalsichtiges Auge könnte diesen Ring also noch aus der doppelten Entfernung von $9,2$ Metern auflösen).
  - *Berechnung:*
    $ V = (4,6 " m") / (9,2 " m") = 0,5 $
    Die Sehleistung beträgt hierbei einen Dezimalvisus von $0,5$ (50 % des medizinischen Standards).

  #v(8pt)
  *Beispiel 3: Imperialer Standard (US-System)*
  In den USA und Großbritannien wird die Prüfdistanz traditionell in Fuß (feet) gemessen. Der klinische Standardabstand beträgt hierbei $d = 20$ Fuß (ca. $6$ Meter).
  - *Normalsichtigkeit ($20/20$):* Der Proband erkennt auf 20 Fuß Distanz das, was ein Normalsichtiger auf 20 Fuß erkennt ($V = 20/20 = 1,0$).
  - *Eingeschränkte Sehschärfe ($20/40$):* Der Proband muss auf 20 Fuß herantreten, um Details zu erkennen, die ein Normalsichtiger bereits aus 40 Fuß Entfernung auflösen kann ($V = 20/40 = 0,5$).

  #v(8pt)
  *Beispiel 4: Klassischer metrischer Standard (6-Meter-Norm)*
  In vielen europäischen Kliniken beträgt die Standard-Prüfdistanz $d = 6$ Meter.
  - *Normalsichtigkeit ($6/6$):* $V = 6/6 = 1,0$
  - *Eingeschränkte Sehschärfe ($6/12$):* Der Proband sieht auf 6 Meter Entfernung nur das, was ein Normalsichtiger noch aus 12 Metern Entfernung auflösen kann ($V = 6/12 = 0,5$).
]
== Vergleich der Sehtafel-Typen

In der ophthalmologischen Praxis unterscheidet man grundlegend zwei Konstruktionsarten von Sehtafeln, die auf den oben hergeleiteten mathematischen Prinzipien basieren:

#figure(
  table(
    columns: (1.2fr, 2fr, 2fr),
    align: (center + horizon, left + horizon, left + horizon),
    // Kopfzeile dunkelgrau, danach abwechselnd hellgrau und weiß
    fill: (col, row) => if row == 0 { luma(90%) } else if calc.even(row) {none } else { none },
    stroke: 0.5pt + rgb("dee2e6"),
    
    table.header(
      [*Kriterium*],
      [*Typ A: Universelle Sehtafeln* ],
      [*Typ B: Festabstand-Sehtafeln* ]
    ),
    
    [*Beschriftung*],
    [Neben den Zeilen sind die Soll-Distanzen ($D$-Werte, z. B. $D=50$, $D=5$) angegeben.],
    [Neben den Zeilen sind direkt die fertigen Visus-Werte ($1,0$, $0,9$, $0,8$ etc.) aufgedruckt.],
    
    [*Flexibilität*],
    [Sehr hoch. Die Tafel kann in beliebig großen Räumen aufgehängt werden, da sich die Prüfdistanz ($d$) frei anpassen lässt.],
    [Starr an eine einzige, vom Hersteller definierte Entfernung gebunden (hier im Praktikum exakt $4,6$ Meter).],
    
    [*Berechnung*],
    [Der Visus ist nicht direkt ablesbar. Er muss nach dem Test manuell über den Snellen-Bruch ($V = d/D$) berechnet werden.],
    [Keine Umrechnung erforderlich. Der Wert am linken Rand entspricht direkt dem Endergebnis, sofern der Abstand strikt eingehalten wird.]
  ),
  caption: [Vergleich zwischen Universalsehtafeln und Festabstandsehtafeln.]
)


#meander.reflow({
  import meander: *
  // Obstacles
  placed(right, boundary: // Override the default margin
      contour.margin(5mm),figure(image("/assets/image-17.png", width: 45%), caption: [Landolt-Sehtafel mit $D$ und $V$] )
)
  // Container
  container(margin:5cm)

  // Flowing text
  content[
Die Abbildung 5. zeigt eine standardisierte Landolt-Sehtafel (Festabstand-Sehtafel) zur Bestimmung der Sehschärfe. Am linken Rand jeder Zeile ist die Soll-Entfernung ($D$-Wert in Metern) angegeben, während am rechten Rand der direkt resultierende Dezimalvisus ($V$) aufgedruckt ist.
]
})
#pagebreak()
= Materialien

Für die Durchführung des Experiments zur Bestimmung des räumlichen Auflösungsvermögens wurden folgende standardisierte Arbeitsmaterialien verwendet:

1. *Landolt-Sehtafel (Typ B):* Eine kalibrierte Wandtafel mit standardisierten Optotypen (Landoltringe in 8 verschiedenen Orientierungen). Die Tafel ist speziell für eine fixe Prüfdistanz von exakt $d = 4,6$ Metern ausgelegt, sodass die Visus-Werte direkt am Zeilenrand abgelesen werden können.
2. *Messband / Distanzmesser:* Zur präzisen Einmessung und Markierung der exakten Prüfdistanz auf dem Boden des Laborraums.
3. *Oklusionsklappe / Augenklappe:* Ein standardisiertes, lichtundurchlässiges Hilfsmittel zur sauberen Abdeckung des jeweils nicht geprüften Auges, ohne dabei Druck auf den Augapfel auszuüben. Die Hand zur Abdeckung zu nutzen wird nicht geraten, da die Person schummeln könnte. 
4. *Eigene Sehhilfen (sofern vorhanden):* Brillen oder Kontaktlinsen der jeweiligen Probanden zur Bestimmung des korrigierten Visus im Vergleich zum unkorrigierten Visus.
5. *Standardisierte Laborbeleuchtung:* Eine konstante Raumbeleuchtung zur Gewährleistung stabiler Kontrastverhältnisse und einer definierten Pupillenöffnung (Vermeidung extremer alters- oder helligkeitsbedingter Miosis/Mydriasis).
#pagebreak()
= Durchführung
Die visuelle Akuitätsbestimmung wird nach einem streng standardisierten, klinischen Ablaufplan durchgeführt, um subjektive und umweltbedingte Fehlerquellen zu minimieren:

- *Raumvorbereitung und Distanzsicherung:* Mittels Messband wird die vorgeschriebene Prüfdistanz von exakt $4,6$ Metern von der Sehtafel bis zur Standlinie des/der Patient/in ausgemessen und am Boden präzise markiert.

- *Positionierung des/der Patient/in:* Der/die Patient/in wird aufrecht an der Markierung positioniert. Dabei wird streng darauf geachtet, dass der Kopf ruhig gehalten und der Oberkörper während des gesamten Tests nicht nach vorne gelehnt wird, um eine Verfälschung der kritischen Distanz und des Sehwinkels zu verhindern.

- *Monokulare Testung (Rechtes Auge):* Das linke Auge des/der Patient/in wird mit der Oklusionsklappe vollständig abgedeckt. Der/die Patient/in wird angewiesen, beide Augen offen zu lassen, um ein Zukneifen und die damit einhergehende Veränderung des Tränenfilms oder eine künstliche Sehschärfenverbesserung durch eine stenopäische Lücke zu vermeiden. Beginnend bei einer oberen Zeile mit großem Visus wird die Richtung der Ringlücke (oben, unten, links, rechts sowie die 45°-Zwischenstufen) zeilenweise von links nach rechts abgefragt und vom/von der Patient/in benannt.

- *Ermittlung der Abbruchschwelle:* Die Auswertung erfolgt nach der strikten 60%-Grenzwertregel. Eine Zeile gilt als erfolgreich erkannt, wenn mindestens 60 % der präsentierten Optotypen korrekt identifiziert werden. Der Test wird erst abgebrochen, sobald diese Quote in einer Zeile unterschritten wird. Der Visus-Wert der letzten erfolgreich absolvierten Zeile wird dokumentiert.

- *Monokulare Testung (Linkes Auge):* Die Oklusionsklappe wird auf das rechte Auge gewechselt und das Verfahren wird für das linke Auge des/der Patient/in exakt wie oben beschrieben wiederholt.

- *Binokulare Testung:* Der Test wird abschließend mit beiden Augen gleichzeitig durchgeführt, um den Effekt der binokularen Summation zu überprüfen.

- *Testung mit optischer Korrektur:* Trägt der/die Patient/in im Alltag eine Sehhilfe (Brille oder Kontaktlinsen), so wird der gesamte Durchlauf (monokular rechts/links sowie binokular) ein zweites Mal mit aufgesetzter Korrektur durchgeführt.
#pagebreak()
== Ablaufdiagramm des klinischen Testablaufs
// Helper-Funktionen für das Ablaufdiagramm (kannst du oben im File oder direkt vor dem Diagramm definieren)
#let flow-step(num, title, desc, fill: rgb("f8f9fa"), stroke-color: rgb("ced4da")) = {
  block(
    fill: fill,
    inset: 12pt,
    radius: 8pt,
    stroke: 0.5pt + stroke-color,
    width: 100%,
    [
      #grid(
        columns: (auto, 1fr),
        gutter: 12pt,
        align: center + horizon,
        block(
          width: 22pt,
          height: 22pt,
          radius: 11pt,
          fill: rgb("005088"), // Dein edles Blau aus der Präsentation
          align(center + horizon)[#text(fill: white, weight: "bold", size: 10pt)[#num]]
        ),
        [
          #text(weight: "bold", size: 10.5pt, fill: rgb("1e293b"))[#title] \
          #v(1pt)
          #text(size: 9pt, fill: rgb("475569"))[#desc]
        ]
      )
    ]
  )
}

#let arrow-down() = {
  align(center)[
    #v(-4pt)
    #text(fill: rgb("005088"), size: 14pt)[$arrow.b$]
    #v(-4pt)
  ]
}

#let split-arrows() = {
  align(center)[
    #v(-2pt)
    #grid(
      columns: (1fr, 1fr),
      align: center,
      text(fill: rgb("005088"), size: 14pt)[$arrow.bl$], // bl statt dl
      text(fill: rgb("005088"), size: 14pt)[$arrow.br$]  // br statt dr
    )
    #v(-2pt)
  ]
}

#let merge-arrows() = {
  align(center)[
    #v(-2pt)
    #grid(
      columns: (1fr, 1fr),
      align: center,
      text(fill: rgb("005088"), size: 14pt)[$arrow.br$], // br statt dr
      text(fill: rgb("005088"), size: 14pt)[$arrow.bl$]  // bl statt dl
    )
    #v(-2pt)
  ]
}

// Das eigentliche Ablaufdiagramm
#align(center)[
  #block(
    width: 95%,
    fill: rgb("fffdf9"), // Ein ganz zarter Cremeton passend zur Laboratmosphäre
    inset: 18pt,
    radius: 10pt,
    stroke: 0.5pt + rgb("e2e8f0"),
    [
      #align(center)[
        #text(weight: "bold", size: 12pt, fill: rgb("005088"))[Klinischer Ablaufplan der Visusbestimmung]
        #v(12pt)
      ]
      
      #flow-step("1", "Raumvorbereitung", "Präzises Ausmessen und Markieren der Prüfdistanz von exakt 4,6 Metern am Boden.")
      
      #arrow-down()
      
      #flow-step("2", "Positionierung des/der Patient:in", "Aufrechte Ausrichtung an der Markierung; Sicherstellung einer absolut ruhigen Kopf- und Körperhaltung.")
      
      #split-arrows()
      
      #grid(
        columns: (1fr, 1fr),
        gutter: 14pt,
        flow-step("3a", "Monokulare Testung (Rechts)", "Abdeckung des linken Auges. Bestimmung der Abbruchschwelle mittels 60%-Regel."),
        flow-step("3b", "Monokulare Testung (Links)", "Wechsel der Oklusionsklappe auf das rechte Auge. Identische Abfrage der Ringlücken.")
      )
      
      #merge-arrows()
      
      #flow-step("4", "Binokulare Testung", "Gleichzeitiger Sehtest mit beiden Augen zur Überprüfung des Effekts der binokularen Summation.")
      
      #arrow-down()
      
      #flow-step("5", "Optionale Wiederholung mit Sehhilfe", "Trägt der/die Patient:in eine Brille oder Kontaktlinsen, wird der gesamte Ablauf ein zweites Mal mit Korrektur durchlaufen.")
    ]
  )
]

== Methodische Relevanz der Testreihenfolge

Die Einhaltung einer strikten Prüfreihenfolge ist für die Validität der Messergebnisse von fundamentaler Bedeutung:

1. *Priorität der unkorrigierten Messung:* 
   Die Testung ohne Sehhilfe muss zwingend vor der Messung mit Sehhilfe durchgeführt werden. Würde man zuerst mit optimaler Korrektur testen, könnte der Proband die kleinsten Optotypen fehlerfrei auflösen. Bei der anschließenden unkorrigierten Messung käme es zu einem starken Memorierungseffekt (Lerneffekt), bei dem das Gehirn die Richtungen der verschwommen wahrgenommenen Ringe unbewusst aus dem Kurzzeitgedächtnis rekonstruiert. Dies würde den Rohvisus systematisch überschätzen.

2. *Monokular vor Binokular:*
   Aus demselben Grund müssen die Einzelaugen vor der beidäugigen (binokularen) Betrachtung getestet werden. Da der Visus unter binokularer Summation am höchsten ist, würde ein Erstkontakt im binokularen Modus die monokularen Einzeltests durch Lerneffekte verfälschen.

3. *Vermeidung von sequentiellem Wechsel:*
   Ein ständiger Wechsel zwischen den Zuständen „mit“ und „ohne“ Sehhilfe für jedes einzelne Auge ist zu vermeiden. Die permanente Umstellung erzwingt eine kontinuierliche Akkommodationsänderung des Ziliarmuskels, was zu einer vorzeitigen neuronalen und muskulären Ermüdung (_visuelle Fatigue_) führt und die Genauigkeit der Abbruchschwelle mindert.

#pagebreak()
= Ergebnisse

#import "analysis/correlations.typ": left-vs-right-corr, no-vs-with-glasses-corr
#import "analysis/descriptive_statistics.typ": all-time as all-time-stats, mbi-2025 as mbi-2025-stats
#import "analysis/hypothesis_tests.typ": all-time as all-time-tests, mbi-2025 as mbi-2025-tests

== Diskriptive Statistik über alle Jahrgänge

#figure(all-time-stats, caption: [Deskriptive Statistik über alle Jahrgänge])

Die Tabelle 2 fasst die erhobenen Daten zur Sehschärfe (Visus) über alle Jahrgänge zusammen. Die Stichprobe ist dabei in zwei Hauptgruppen unterteilt: Probanden mit Brille ($n = 221$) und Probanden ohne Brille ($n = 321$). Für jede Gruppe wurden der Mittelwert samt Standardabweichung ($overline(x) plus.minus s$), die Spannweite (_Range_) sowie die Stichprobengröße ($n$) für beide Augen gemeinsam (binokular) sowie für das linke und rechte Auge getrennt (monokular) dokumentiert.

Beim Betrachten der reinen Zahlenwerte lassen sich folgende unmittelbare Beobachtungen festhalten:

- *Höhere Werte bei beidäugiger Messung:* In beiden Versuchsgruppen (mit und ohne Brille) liegt der Mittelwert für beide Augen deutlich über den Werten der Einzelaugen. Bei den Probanden mit Brille wird hier ein Wert von $1,44$ erreicht, während die Einzelaugen bei $1,18$ und $1,17$ liegen.
- *Höheres und homogeneres Niveau mit Sehhilfe:* Die Gruppe mit Brille weist durchgehend höhere Mittelwerte auf als die Gruppe ohne Brille (z. B. $1,44$ gegenüber $1,19$ bei beiden Augen). Zudem ist die Standardabweichung mit Brille in allen Spalten kleiner (z. B. $0,31$ zu $0,58$ bei beiden Augen), was auf eine geringere Streuung der Werte hindeutet.
- *Größere Spannweite ohne Sehhilfe:* Die minimale Sehschärfe sinkt in der Gruppe ohne Brille bei allen Messungen bis auf $0$ ab, während das Minimum mit Brille nicht unter $0,3$ fällt. Das Maximum liegt in fast allen Kategorien bei einem Visus von $2$.
- *Symmetrie der Einzelaugen:* Die Werte für das linke Auge und das rechte Auge liegen innerhalb der jeweiligen Gruppen extrem nah beieinander. Mit Brille unterscheiden sich die Mittelwerte nur um $0,01$ ($1,18$ vs. $1,17$), ohne Brille um $0,03$ ($0,99$ vs. $0,96$).


== Diskriptive Statistik MBI 2025

#figure(mbi-2025-stats, caption: [Deskriptive Statistik MBI 2025])

Die Tabelle 3 zeigt die deskriptiven statistischen Kennwerte für den spezifischen Jahrgang MBI 2025. Das kleinere Teilkollektiv teilt sich auf in Probanden mit Brille ($n = 9$) und Probanden ohne Brille ($n = 16$). Erhoben wurden analog die Parameter Mittelwert und Standardabweichung ($overline(x) plus.minus s$), die Spannweite (_Range_) sowie die Stichprobengröße ($n$) für die binokulare sowie die beiden monokularen Messungen.

Die rein numerische Betrachtung dieser Daten liefert folgende primäre Beobachtungen:

- *Höhere Sehschärfe bei binokularer Messung:* Auch im Jahrgang MBI 2025 liegen die Mittelwerte für beide Augen in beiden Versuchsgruppen über den Werten der jeweiligen Einzelaugen. Bei den Probanden mit Brille beträgt der kombinierte Wert $1,36$ (gegenüber $1,1$ und $1,09$ monokular), während er ohne Brille bei $1,22$ liegt (gegenüber $0,94$ und $0,98$ monokular).
- *Höheres visuelles Niveau mit Korrektur:* Die Mittelwerte der Gruppe mit Brille übertreffen jene der Gruppe ohne Brille bei den Messungen beider Augen ($1,36$ vs. $1,22$) sowie des linken Auges ($1,1$ vs. $0,94$). Beim rechten Auge liegt der unkorrigierte Mittelwert mit $0,98$ minimal über dem korrigierten Monokularwert von $1,09$ der anderen Gruppe.
- *Geringere Streuung in der korrigierten Gruppe:* Die Werte der Probanden mit Sehhilfe weisen eine deutlich geringere Standardabweichung auf ($s = 0,24$ bzw. $0,25$) als die Werte der unkorrigierten Probanden ($s = 0,55$ bzw. $0,58$). Die Messergebnisse streuen ohne Brille somit mehr als doppelt so stark.
- *Deutliche Unterschiede in den Minima der Spannweite:* Während die minimale Sehschärfe bei Probanden mit Brille in keiner Messung unter einen Visus von $0,8$ fällt, sinkt der Minimalwert in der Gruppe ohne Brille bei allen drei Messkonditionen bis auf den Nullpunkt ($0$) ab. Die Maxima bewegen sich in beiden Gruppen in einem ähnlichen Bereich zwischen $1,4$ und $1,8$.
- *Weitgehende Symmetrie der Einzelaugen:* Innerhalb der beiden Versuchsgruppen verhalten sich das linke und rechte Auge numerisch sehr ähnlich. Die Differenz der monokularen Mittelwerte beträgt mit Brille lediglich $0,01$ ($1,1$ vs. $1,09$) und ohne Brille $0,04$ ($0,94$ vs. $0,98$).

== Korrelation zwischen linkem und rechtem Auge

#figure(left-vs-right-corr, caption: [Korrelation zwischen linkem und rechtem Auge])

Die Abbildung 5 zeigt ein Streudiagramm (Scatterplot), in dem die Sehschärfe des linken Auges (X-Achse) gegen die Sehschärfe des rechten Auges (Y-Achse) aufgetragen ist. Jeder blaue Datenpunkt repräsentiert die Messwerte eines Probanden. Durch die Farbintensität (Überlagerung von Punkten) wird ersichtlich, wo sich die Messwerte häufen. Zudem ist eine rote lineare Regressionsgerade eingezeichnet.

Die rein optische und numerische Auswertung der Grafik zeigt folgende Beobachtungen:

- *Positiver Trend:* Die Regressionsgerade steigt von links unten nach rechts oben an. Dies verdeutlicht, dass eine höhere Sehschärfe auf dem linken Auge tendenziell mit einer höheren Sehschärfe auf dem rechten Auge einhergeht.
- *Stärke des Zusammenhangs:* Der oben links angegebene Pearson-Korrelationskoeffizient beträgt $0,61$. Dies weist numerisch auf einen moderat bis stark ausgeprägten positiven linearen Zusammenhang zwischen den beiden Augen hin.
- *Konzentration im oberen Bereich:* Ein Großteil der Datenpunkte häuft sich im rechten, oberen Quadranten der Grafik (Bereich zwischen $1,0$ und $2,0$ auf beiden Achsen). Hier sind die Datenpunkte besonders dunkel gefärbt, was auf eine hohe Dichte an Probanden mit überdurchschnittlicher Sehschärfe auf beiden Augen hindeutet.
- *Streuung und Abweichungen (Ausreißer):* Die Punkte liegen nicht exakt auf der roten Geraden, sondern streuen spürbar darum herum. Es lassen sich auch einzelne Probanden finden, bei denen stärkere Unterschiede zwischen den Augen vorliegen (z. B. ein Datenpunkt ganz links bei einem Visus von $0,0$ für das linke Auge, aber $1,2$ bis $1,5$ für das rechte Auge).

== Korrelation zwischen unkorrigiertem und korrigiertem Visus

#figure(no-vs-with-glasses-corr, caption: [Korrelation zwischen unkorrigiertem und korrigiertem Visus])

Die Abbildung 6 zeigt ein weiteres Streudiagramm, bei dem die Sehschärfe mit Brille (X-Achse, korrigierter Visus) gegen die Sehschärfe ohne Brille (Y-Achse, unkorrigierter Visus) aufgetragen ist. Die blauen Punkte zeigen die Verteilung der Probandenwerte, wobei dunklere Punkte durch überlagerte Datenpunkte entstehen. Eine rote lineare Regressionsgerade stellt den Gesamttrend dar.

Bei der reinen Betrachtung der Werte fallen folgende Punkte auf:

- *Schwacher positiver Trend:* Die rote Regressionsgerade zeigt einen leicht ansteigenden Verlauf von links nach rechts. Das bedeutet, dass höhere korrigierte Werte tendenziell mit etwas höheren unkorrigierten Werten einhergehen.
- *Geringe Stärke des Zusammenhangs:* Der Pearson-Korrelationskoeffizient ist mit $0,27$ angegeben. Dieser Wert zeigt rein numerisch, dass der lineare Zusammenhang zwischen dem korrigierten und dem unkorrigierten Visus in diesem Kollektiv nur schwach ausgeprägt ist.
- *Hohe Streuung auf der Y-Achse:* Während sich die Werte auf der X-Achse (mit Brille) fast ausschließlich im oberen Bereich zwischen ca. $1,2$ und $2,0$ konzentrieren, streuen die zugehörigen Werte ohne Brille auf der Y-Achse extrem weit über das gesamte Spektrum von $0,0$ bis $1,8$.
- *Anhäufung am unteren Rand:* Am untersten Rand der Grafik (Y-Wert von $0,0$) zieht sich eine deutliche Kette von Datenpunkten über den X-Bereich von $0,5$ bis $2,0$. Dies zeigt eine Gruppe von Probanden, die ohne Sehhilfe eine Sehschärfe von nahe oder exakt $0$ aufweisen, mit Brille jedoch Werte über das gesamte Spektrum bis hin zum Maximum erreichen.

== Hypothesenprüfung: alle Jahrgänge
#pad(x: -2cm)[
#figure(all-time-tests, caption: [Hypothesenprüfung: alle Jahrgänge])]

Die Tabelle 4 fasst die Ergebnisse der inferenzstatistischen Prüfung (Hypothesentests) für das Gesamtkollektiv über alle Jahrgänge zusammen. Die Tabelle ist in fünf Spalten unterteilt: die aufgestellte *Nullhypothese ($H_0$)*, das gewählte *Testverfahren*, die berechneten *Prüfstatistiken* samt Stichprobengrößen ($n$), der resultierende *p-Wert* sowie die finale Entscheidung über die statistische *Signifikanz* bezogen auf ein vorgegebenes Signifikanzniveau von $alpha = 0,05$.

=== Ungepaarter Zwei-Stichproben-t-Test 
Für den Vergleich aller unkorrigierten und korrigierten Messwerte als unabhängige Gruppen ($n_1 = 221$, $n_2 = 197$) fließt die Formel für unabhängige Stichproben bei ungleichen Stichprobengrößen ein. Die Prüfgröße $T$ berechnet sich aus den Gruppenmittelwerten ($overline(X)_1, overline(X)_2$) und den Gruppenvarianzen ($s_1^2, s_2^2$):

$ T = (overline(X)_1 - overline(X)_2) / sqrt(s_1^2 / n_1 + s_2^2 / n_2) $

Da hier die Gesamtheiten aller Messwerte (über alle Personen hinweg) aggregiert verglichen werden, mitteln sich die individuellen Effekte heraus. Numerisch liegen die Gruppenmittelwerte nahe beieinander ($overline(X_1) = 1,44$ und $overline(X_2) = 1,53$), was zu einem niedrigen $T$-Wert von $-0,68$ führt.

=== Gepaarter Zwei-Stichproben-t-Test 
Bei den restlichen Fragestellungen handelt es sich um abhängige Stichproben (Messwiederholungen oder paarweise Organe derselben Person). Hier fließt nicht der Gruppenmittelwert in die mathematische Formel ein, sondern die individuelle Differenz $d_i = X_(1,i) - X_(2,i)$ jedes einzelnen Probanden. Die Prüfgröße $T$ berechnet sich aus dem Mittelwert dieser Differenzen ($overline(d)$) und der Standardabweichung der Differenzen ($s_d$):

$ T = overline(d) / (s_d / sqrt(n)) $

Durch diesen mathematischen Ansatz wird die Varianz, die zwischen verschiedenen Personen existiert, eliminiert. Die Formel prüft isoliert, wie stark sich die Bedingungen innerhalb derselben Person systematisch unterscheiden. Dadurch resultieren trotz kleinerer Paar-Stichproben (z.B. $n = 124$ in Zeile 2) extrem hohe, trennscharfe $T$-Werte (wie $T = 19,95$).

=== Die t-Verteilung
Die aus den Formeln berechneten $T$-Werte werden anschließend gegen die theoretische Student-t-Verteilungsdichte mit den entsprechenden Freiheitsgraden ($"df"=n-1$) abgeglichen. Der in der Tabelle ausgewiesene $p$-Wert entspricht der verbleibenden Fläche unter den Verteilungskurven an den äußeren Extremwerten. Je weiter der berechnete $T$-Wert vom Nullpunkt abweicht, desto kleiner wird diese Fläche (der $p$-Wert) und desto sicherer wird die Nullhypothese verworfen.


*Beim reinen Ablesen der Tabellenwerte lassen sich folgende Beobachtungen festhalten:*

=== Übersicht der untersuchten Fragestellungen und Testergebnisse
- *Test 1 (Alle Messungen mit vs. ohne Brille ungepaart):* Geprüft wurde, ob der Erwartungswert aller Messungen mit Brille gleich dem ohne Brille ist. Bei einem ungepaarten t-Test ergab sich ein $T$-Wert von $-0,68$ und ein hoher $p$-Wert von $0,50$. Dieses Ergebnis ist nicht signifikant ($p #sym.lt.not alpha$).
- *Test 2 (Einfluss des Brillentragens gepaart):* Hier wurde untersucht, ob das Tragen einer Sehhilfe bei denselben Probanden einen Unterschied macht. Der gepaarte t-Test liefert einen hohen $T$-Wert von $19,95$ und einen $p$-Wert von $0,00$. Dieser Unterschied ist hochsignifikant ($p < alpha$).
- *Test 3 & 4 (Binokularer Visus vs. besseres/schlechteres Einzelauge):* Es wurde getestet, ob der Visus mit beiden Augen identisch zum jeweils besseren bzw. schlechteren Einzelauge ist. Beide gepaarten t-Tests zeigen extrem hohe negative $T$-Werte ($-15,29$ und $-28,98$) und extrem kleine $p$-Werte ($3,33 times 10^(-16)$ und $1,11 times 10^(-16)$). Beide Abweichungen sind hochsignifikant.
- *Test 5 (Vergleich linkes vs. rechtes Auge):* Der gepaarte t-Test vergleicht die Sehschärfe beider Einzelaugen miteinander. Bei einem $T$-Wert von $1,98$ wird ein $p$-Wert von exakt $0,05$ erreicht. Das Ergebnis wird in der Tabelle knapp als signifikant($p <= alpha$) ausgewiesen.

== Hypothesenprüfung: MBI 2025
#pad(x: -2cm)[
#figure(mbi-2025-tests, caption: [Hypothesenprüfung: MBI 2025])
]
Die Tabelle 5 fasst die Ergebnisse der Hypothesentests für das spezifische Teilkollektiv des Jahrgangs MBI 2025 zusammen. Die mathematischen Teststatistiken (Prüfgrößen $T$) sowie die p-Werte basieren auf den identischen Berechnungsformeln des ungepaarten bzw. gepaarten Zwei-Stichproben-t-Tests und der zugehörigen Student-t-Verteilung, wie sie im vorherigen Abschnitt erklärt wurden.

Die rein numerische Beschreibung der Testergebnisse für diesen Jahrgang stellt sich wie folgt dar:

- *Test 1 (Alle Messungen mit vs. ohne Brille ungepaart):* Der ungepaarte t-Test vergleicht alle erhobenen Sehschärfenwerte als unabhängige Stichproben ($n_1 = 9, n_2 = 11$). Mit den Gruppenmittelwerten von $overline(X_1) = 1,36$ und $overline(X_2) = 1,53$ resultiert ein $T$-Wert von $-0,55$ und ein p-Wert von $p = 0,60$. Das Ergebnis ist nicht signifikant ($p #sym.lt.not alpha$).
- *Test 2 (Einfluss des Brillentragens gepaart):* Beim paarweisen Vergleich der Sehschärfe mit und ohne Sehhilfe bei denselben Probanden ($n = 5$ Paare) ergibt sich ein Mittelwert von $overline(X_1) = 1,36$ (mit Brille) gegenüber $overline(X_2) = 0,62$ (ohne Brille). Die Teststatistik liefert einen $T$-Wert von $3,21$ und einen p-Wert von $p = 0,03$. Dieses Ergebnis ist signifikant ($p < alpha$).
- *Test 3 (Binokularer Visus vs. besseres Auge gepaart):* Der gepaarte Vergleich zwischen der beidäugigen Messung ($overline(X) = 1,43$) und dem jeweils besseren Einzelauge ($overline(X) = 1,27$) bei $n = 20$ Datenpaaren liefert eine Prüfgröße von $T = -3,23$ und einen p-Wert von $p = 4,37 times 10^(-3)$. Der Unterschied ist *signifikant*.
- *Test 4 (Binokularer Visus vs. schlechteres Auge gepaart):* Der gepaarte t-Test für den Unterschied zwischen der beidäugigen Sehschärfe ($overline(X) = 1,43$) und dem schlechteren Einzelauge ($overline(X) = 1,04$, $n = 20$) ergibt einen $T$-Wert von $-4,54$ und einen p-Wert von $p = 2,25 times 10^(-4)$. Diese Abweichung ist hochsignifikant.
- *Test 5 (Vergleich linkes vs. rechtes Auge gepaart):* Die paarweise Gegenüberstellung der monokularen Sehschärfe des linken Auges ($overline(X) = 1,13$) und des rechten Auges ($overline(X) = 1,17$) bei $n = 19$ Probanden liefert eine Prüfgröße von $T = -0,33$ und einen hohen p-Wert von $p = 0,75$. Das Ergebnis ist nicht signifikant ($p #sym.lt.not alpha$).

#pagebreak()

= Diskussion und Interpretation
Die Analyse der deskriptiven und inferenzstatistischen Ergebnisse liefert tiefere Einblicke in die Physiologie des Sehens sowie in die Funktionsweise optischer Korrekturen. Im Folgenden werden die zentralen Befunde im Kontext der physiologischen Grundlagen diskutiert.

== Okulare Symmetrie des Kollektivs
Sowohl in der Gesamtstichprobe (Tabelle 2) als auch im spezifischen Jahrgang MBI 2025 (Tabelle 3) zeigt sich eine ausgeprägte numerische Symmetrie zwischen dem linken und rechten Auge. Die Mittelwerte weichen maximal um $0,04$ Visuspunkte voneinander ab. 
Inferenzstatistisch liefert der gepaarte t-Test für das Gesamtkollektiv (Tabelle 4, Test 5) zwar ein knapp signifikantes Ergebnis ($p = 0,05$), im kleineren Jahrgang MBI 2025 (Tabelle 5, Test 5) ist die Abweichung mit $p = 0,75$ jedoch rein zufällig. Das bedeutet, dass im statistischen Mittel keine relevante biologische Asymmetrie (wie eine systematische Einäugigkeit oder ausgeprägte Anisometropie) im Kollektiv vorliegt. Das Sehvermögen ist auf beiden Augen nahezu identisch verteilt.

== Der Effekt der binokularen Summation
Ein besonders robuster Trend in allen Tabellen ist der systematische Anstieg des Visus bei der beidäugigen (binokularen) Messung im Vergleich zu den monokularen Einzelwerten. Die gepaarten t-Tests (Tests 3 und 4) bestätigen in beiden Datensätzen mit extrem kleinen p-werten ($p < 0,01$), dass dieser Unterschied hochgradig signifikant ist.

Aus physiologischer Sicht lässt sich dies durch die *binokulare Summation* im visuellen Cortex erklären. Das Gehirn addiert nicht einfach die Sehschärfen, sondern fusioniert die separaten neuronalen Signale beider Netzhäute. Durch diese kortikale Überlagerung wird das physiologische "Rauschen" (kleine Rezeptor- oder Signalfehler) herausgefiltert. Das führt zu einer nachweisbaren Steigerung der Kontrastsensitivität und des räumlichen Auflösungsvermögens – der binokulare Visus ist folglich signifikant besser als das mathematisch bessere Einzelauge.

== Effektivität von Sehhilfen (Brille/Kontaktlinse)
Der direkte Vergleich der Gruppen zeigt die deutliche Auswirkung optischer Korrekturen. Die Probanden mit Sehhilfe erreichen ein deutlich höheres und homogeneres Visusniveau (Mittelwert von $1,44$ binokular über alle Jahrgänge) als jene ohne Brille ($1,19$). 
Zudem ist die Standardabweichung in der korrigierten Gruppe signifikant geringer ($s = 0,31$ vs. $s = 0,58$). Das unkorrigierte Kollektiv weist eine enorme Streuung auf, da hier alle Ausprägungen von Kurz-, Weit- oder Stabsichtigkeit unkompensiert einfließen (was auch die Minima der Range von $0$ erklärt). Die Brille bzw. Kontaktlinse gleicht diese physikalischen Abbildungsfehler (Ametropien) aus, indem sie den Brennpunkt des Lichts präzise auf die Netzhautebene zurückwirft. Sie homogenisiert das Leistungsvermögen des Kollektivs auf einem hohen, überdurchschnittlichen Niveau.

== Paradoxon der t-Tests: Ungepaart vs. Gepaart (Zeile 1 vs. Zeile 2)
Ein scheinbares mathematisches Paradoxon zeigt sich beim Vergleich der ersten beiden Zeilen der Hypothesenprüfungen:
- *Test 1 (ungepaart):* Der Vergleich aller Brillenträger mit allen Nicht-Brillenträgern ist nicht signifikant ($p = 0,50$ bzw. $p = 0,60$).
- *Test 2 (gepaart):* Der direkte Vorher-Nachher-Vergleich derselben Personen (mit vs. ohne Brille) ist hochsignifikant ($p = 0,00$ bzw. $p = 0,03$).

Der Grund hierfür liegt im fundamentalen Unterschied der statistischen Testdesigns und der biologischen Varianz:

1. *Wieso der ungepaarte Test (Zeile 1) fehlschlägt:*
   Der ungepaarte t-Test betrachtet die beiden Gruppen als völlig unabhängig voneinander. In der Gruppe "ohne Brille" befinden sich jedoch zwei fundamental unterschiedliche Typen von Menschen: Emmetrope (von Natur aus Normalsichtige mit einem Visus von oft $1,2$ bis $1,5$) und unkorrigierte Ametrope (Fehlsichtige, die in diesem Moment keine Brille tragen und Werte nahe $0$ haben). Wenn man nun den Mittelwert aller Personen mit Brille ($overline(X) = 1,44$) mit dem Mittelwert aller Personen ohne Brille ($overline(X) = 1,53$) vergleicht, maskieren die natürlich Normalsichtigen den Effekt der Fehlsichtigen. Die Varianz innerhalb der Gruppen ist so riesig, dass der Test keinen systematischen Unterschied zwischen den Gruppenidentitäten erkennt.

2. *Wieso der gepaarte Test (Zeile 2) hochsignifikant ist:*
   Der gepaarte t-Test eliminiert die interindividuelle Varianz (die Unterschiede zwischen verschiedenen Menschen) vollständig. Er schaut sich isoliert die personenspezifische Differenz an: Wie viel besser sieht dieselbe kurzsichtige Person, wenn sie ihre Brille aufsetzt? Hier vergleicht die Formel den korrigierten Zustand ($overline(X) = 1,50$) mit dem unkorrigierten Zustand ($overline(X) = 0,66$) derselben Probanden. Da sich das Sehvermögen bei jedem Fehlsichtigen durch das Aufsetzen der Sehhilfe drastisch und systematisch verbessert, ist die Varianz dieser Differenzen minimal und der t-Wert schießt nach oben. Der Test besitzt eine ungleich höhere statistische Power und weißt die Effektivität der Brille fehlerfrei nach.
#pagebreak()
= Mögliche Fehlerquellen

Die Bestimmung der Sehschärfe mittels Landolt-Ringen ist ein subjektives Prüfverfahren, das trotz Standardisierung verschiedenen systematischen und zufälligen Fehlerquellen unterliegt. Die wichtigsten Einflussfaktoren werden im Folgenden kategorisiert:

== Probandenbezogene Faktoren (Haltung und Ermüdung)
- *Körperhaltung und Distanzschwankungen:* Das unbewusste Vorlehnen des Oberkörpers oder Vorstrecken des Kopfes während des Ablesens verkürzt die standardisierte Prüfdistanz von $d = 4,6$ Metern. Da sich der physikalische Sehwinkel direkt aus der Distanz berechnet, führt ein verkürzter Abstand zu einer künstlichen Vergrößerung des Netzhautbildes und damit zu einer systematischen Überschätzung des tatsächlichen Visus.
- *Visuelle Fatigue (Ermüdung) und Konzentrationsabfall:* Die serielle Abfrage zahlreicher Landoltringe über mehrere Durchgänge hinweg (monokular rechts, links, binokular sowie mit und ohne Korrektur) erfordert eine anhaltend hohe kognitive und neuronale Fokussierung. Gegen Ende der Testreihe kann es zu Ermüdungserscheinungen des Ziliarmuskels sowie zu einem Abfall der Konzentration kommen, was zu falsch-negativen Antworten in den unteren Zeilen führt.

== Methodische und statistische Artefakte
- *Der Ratefaktor (Guessing Factor):* Da der Landolt-Ring mit insgesamt 8 Lückenorientierungen dargeboten wird, besteht bei jeder einzelnen Abfrage eine rein stochastische Ratewahrscheinlichkeit von $12,5 %$ ($1 / 8$), die Richtung durch reines Glück korrekt zu erraten. Bei sequenziellem Raten kann dies dazu führen, dass eine Abbruchzeile fälschlicherweise noch als "bestanden" gewertet wird.
- *Fehlinterpretation der Abbruchschwelle (Misapplication):* Ein methodischer Fehler des Untersuchers liegt vor, wenn der Test fälschlicherweise beim ersten individuellen Fehler des Probanden abgebrochen wird. Um valide Messwerte zu erhalten, muss die klinische Grenzwertregel von mindestens $60 %$ korrekt erkannten Zeichen pro Visuszeile strikt kontrolliert und erzwungen werden.

== Umgebungsbedingungen (Umweltvariablen)
- *Schwankungen der Raumbeleuchtung:* Die Leuchtdichte der Sehtafel sowie die Umgebungshelligkeit im Laborraum beeinflussen maßgeblich den retinalen Kontrast sowie den Pupillendurchmesser (Ablauf von Miosis und Mydriasis). Eine zu dunkle Raumbeleuchtung führt zu einer Pupillenweitung, wodurch sphärische Aberrationen des Auges verstärkt werden und der unkorrigierte Visus abfällt. Unstetige Lichtverhältnisse schränken somit die Reproduzierbarkeit der Messergebnisse ein.

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
