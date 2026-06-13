#import "../../templates/protocol.tpl.typ": bio-template, new-chapter

#set document(
  title: "Isolation von genomischer DNA",
  author: ("Tim Peko", "Nathalie Sonnleitner"),
  description: "Konzentrations- und Längenbestimmung von verschiedenen Proben",
  date: datetime.today()
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
#set figure(placement: auto)

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

- *Eukaryotische DNA (Schweineleber)*: Das Genom der Schweineleberzellen (etwa 2,8 Milliarden Basenpaare) ist stark gepackt, weil es um spezielle, positiv geladene Proteine (Histone) gewickelt ist, wodurch Chromatin entsteht. @src_molecular-biology-of-the-cell Außerdem enthalten Leberzellen sehr viel RNA, vor allem rRNA und mRNA. Aufgrund der hohen Stoffwechselaktivität kann der Anteil bis zu 80-90 % der Nukleinsäuren ausmachen. @src_lodish-molecular-cell-biology Deshalb braucht man Proteine abbauende Enzyme wie Proteinase K, um die Histone zu entfernen. Für den Abbau der RNA gibt man RNase dazu. @src_csh-protocols-isolation

- *Prokaryotische DNA (E. coli)*: Bei Bakterien wie E. coli liegt die DNA als ringförmiges Chromosom ohne Histone vor und ist durch Supercoiling kompakter gemacht. @src_brock-mikrobiologie Das größte Problem bei der Extraktion ist die Zellwand. E. coli besitzt als gramnegatives Bakterium eine dicke äußere Schicht aus Lipopolysacchariden (LPS), die das Enzym Lysozym daran hindern kann, die Zellwand aufzubrechen. Erst wenn diese äußere Schicht zum Beispiel mit Hilfe von EDTA gestört wird, kann die darunterliegende Mureinschicht angreifbar werden. Bleibt sie intakt, klappt die Lyse nicht und es kann keine DNA extrahiert werden. @src_csh-bacterial-cell-envelope

=== Photometrie <photometrie-theorie>

$ E_lambda = sum_(i=1)^n epsilon_(i, lambda) dot c_i space.thin underbrace(cancel(dot d), bold(1)"cm") $ <beer-lambert-equation>

@beer-lambert-equation zeigt die Beziehung zwischen der Extinktion $E_lambda$ bei einer bestimmten Wellenlänge $lambda$ und der Konzentration $c_i$ der $n$ verschiedenen Komponenten indiziert mit $i$. Die Extinktionskoeffizienten $epsilon_(i, lambda)$ sind spezifisch für jede Komponente und Wellenlänge. @src_wikipedia-molar-extinction-coefficient

Bei doppelsträngiger DNA gilt der lineare Zusammenhang $E_260 = 1.0 => "dsDNA" = 50 space upright(mu"g/ml")$. @src_dna-spektrum_img 

@dna-spektrum-img zeigt ein illustratives Spektrum der verschiedenen üblichen Komponenten einer isolierten Nukleinsäureprobe. 

#{
  show: figure.with(
    caption: [Spektrum von Nukleinsäuren und üblichen Verunreinigungen. @src_dna-spektrum_img]
  )
  image("../assets/dna-spektrum.png", width: 100%)
} <dna-spektrum-img>


#{
  show: figure.with(
    caption: [Extinktionskoeffizienten von dsDNA, Proteinen und Phenolen. ]
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
    [dsDNA],
    [≈10,0],
    [20,0],
    [≈11,1],
    
    [Proteine (BSA)],
    [≈2,0 bis 3,0],
    [≈0,4],
    [0,66],
    [Phenol],
    [Sehr hoch (>100)],
    [≈15,0],
    [≈12,5],
  )
}

== Relevanz

Für Standard-PCRs genügen oft einfache Extrakte. Moderne Anwendungen wie Next-Generation Sequencing erfordern jedoch hochmolekulare und extrem reine gDNA. Verunreinigungen durch Proteine oder Phenole/Salze (siehe @photometrie-theorie) hemmen die empfindlichen Polymerasen der Sequenziergeräte, während RNA-Reste zu fehlerhaften Daten bei der Genom-Assemblierung führen können. @src_csh-protocols-isolation

#new-chapter[Durchführung]

Um an die DNA

#pdf.attach(
  "../instructions/Isolierung.pdf",
  mime-type: "application/pdf",
  relationship: "supplement",
  description: "Angabe für die Isolation von genomischer DNA",
)

#{
  show: figure.with(
    caption: [Zelllyse unter Verwendung eines Detergens zum Öffnen der Zellmembran und Freisetzen der intrazellulären Bestandteile. @src_cell-lysis-img]
  )
  image("../assets/cell-lysis.png", width: 100%)
} <cell-lysis-img>

#{
  show: figure.with(
    caption: [Reinigung von Nucleinsäuren unter Verwendung von Natriumacetat und Ethanol. @src_reinigung-na_img]
  )
  image("../assets/reinigung-na.png", width: 100%)
} <reinigung-na-img>

#{
  show: figure.with(
    caption: [Extraktion und Reinigung von Nukleinsäuren mittels Fällung. @src_rna-fällung_img]
  )
  image("../assets/rna-fällung.png", width: 100%)
} <rna-fällung-img>


#{
  show: figure.with(
    caption: [DNA kann mit molekularen „Scheren“, den Restriktionsenzymen, an definierten Stellen zerschnitten werden. Orange markiert ist die Stelle, welche von genau diesem Restriktionsenzym (es hat den Namen EcoRI) erkannt wird. @src_restr-enzyme-working_img]
  )
  image("../assets/restr-enzyme-working.png", width: 100%)
} <restr-enzyme-working-img>

#{
  set rect(inset: 0pt)
  show: figure.with(
    caption: [Bandenmuster bei der Gelelektrophorese. @src_gelelektro-illustr_img]
  )
  image("../assets/gelelktro-illustr.png", width: 100%)
} <gelelektro-illustr-img>

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

#new-chapter[Diskussion]

#set heading(numbering: none)
#new-chapter("Anhang")

== Sources

#bibliography("../bib.yaml", title: none, style: "apa")

== List of Figures
#outline(title: none, target: figure.where(kind: image))

== List of Tables
#outline(title: none, target: figure.where(kind: table))

