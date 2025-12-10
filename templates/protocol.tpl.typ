#let format-equation(it) = {
  set text(font: "Fira Math")
  it
}

#let new-chapter(title) = [
  #colbreak(weak: true)
  = #title
]

#let bio-template(
  subtitle: "",
  course: none,
  semester: none,
  author: "Tim Peko",
  members: none,
  version: none,
  date: none,
  show-cover-page: none,
  language: "de",
  format-page-counter: (current, total) => [
    Seite *#current* von *#total*
  ],
  doc,
) = {
  // Set document-wide styles
  set text(font: "Lato", lang: language)
  set table(
    fill: (_, row) => if calc.even(row) { rgb(230, 230, 230) } else { white },
    align: (col, row) => if col == 0 { right } else { left },
    stroke: 1pt,
  )
  set heading(numbering: none)
  show heading: it => {
    set block(above: 1.5em, below: 0.8em)
    block[
      #if it.numbering != none {
        box(width: 1.25cm, clip: true, counter(heading).display())
      }
      #it.body
    ]
  }
  show heading.where(numbering: none): it => {
    set align(right)
    it
  }
  set page(
    footer: context [
      #line(length: 100%) <_footer>
      #set text(size: 9pt)
      #grid(
        columns: (auto, 1fr),
        align: (left, right),
        [
          #set align(left)
          #set text(size: 9pt)
          #set table.cell(inset: 0pt)
          #table(
            columns: (auto, auto),
            [Date:], [#date],
            [Version:], [#version],
            fill: none,
            stroke: none,
            align: left,
            gutter: 0.5em,
            column-gutter: 1em,
          )],
        format-page-counter(
          counter(page).display("1"),
          counter(page).final().first(),
        ),
      )
    ],
  )

  // Cover page
  let cover-page = {
    align(center)[
      #text(16pt)[
        *Fachhochschule Hagenberg*
      ]
      #image("assets/fh-hagenberg-logo.png", height: 8em)
      #v(8em)
      #text(16pt)[
        #course#if semester != none and course != none {
          ","
        }
        #semester
      ]
      #v(2em)
      #show title: set text(size: 24pt, weight: "bold")
      #show title: set block(spacing: 2em)
      #title(auto)

      #text(20pt)[
        #subtitle
      ]

      #v(2em)
      #if author != none {
        text(16pt)[
          *Author*\
          #author
        ]
      }

      #if members != none {
        v(1em)
        text(16pt)[
          *Members*\
          #for member in members {
            [#member\ ]
          }
        ]
      }

      #v(1fr)
    ]

    pagebreak()
  }

  // By default, show the cover page if the document has at least 3 pages
  context [
    #let cover-page-visible = if show-cover-page == none {
      counter(page).final().first() >= 3
    } else {
      show-cover-page
    }
    #if cover-page-visible {
      cover-page
    }
  ]

  // Set up the header and footer
  set page(
    header: context [
      #let next-footer = query(selector(<_footer>).after(here())).first()
      #let top-heading = query(selector(heading.where(level: 1)).before(next-footer.location())).last(default: none)
      #set text(size: 9pt)
      #document.title
      #h(1fr)
      #if top-heading != none [
        #set text(size: 10pt)
        #underline[*#top-heading.body*]
      ]
      #line(length: 100%)
    ],
    header-ascent: 12pt,
  )

  show math.equation: format-equation

  show cite: super

  doc
}

#show: bio-template.with(
  subtitle: "Vergleich & Entscheidung",
  date: "14. März 2025",
  course: "PHS2",
  semester: "SS 2025",
  author: "Tim Peko",
  members: ("Tim Peko", "Max Mustermann"),
  version: "1.0",
  language: "en",
  format-page-counter: (current, total) => [
    Page *#current* of *#total*
  ],
  show-cover-page: true,
)
This is a test
