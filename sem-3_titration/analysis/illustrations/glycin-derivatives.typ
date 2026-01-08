#import "../../../templates/illustration.tpl.typ": *
#show: illustration
#set text(font: "Love Ya Like A Sister")
#import "../calculations/glycin.typ": x, y, dy, d2y, d3y

#import "@preview/lilaq:0.5.0" as lq
#show lq.selector(lq.legend): scale.with(100%, reflow: true)

#range(3 + 1).map(it => {
  let data = if it == 0 {
    x.zip(y)
  } else if it == 1 {
    x.zip(dy)
  } else if it == 2 {
    x.zip(d2y)
  } else {
    x.zip(d3y)
  }
  
  show math.equation: set text(font: "Love Ya Like A Sister")

  let label = if it == 0 [
    y
  ] else if it == 1 [
    #show math.equation: set text(font: "Love Ya Like A Sister")
    $#text[dy]/#text[dx]$
  ] else if it == 2 [
    #show math.equation: set text(font: "Love Ya Like A Sister")
    $(#[d]^2#[y])/#[dx]^2$
  ] else [
    #show math.equation: set text(font: "Love Ya Like A Sister")
    $(#[d]^3#[y])/#[dx]^3$
  ]

  show: pad.with(top: 1em, right: 1cm)

  lq.diagram(
    width: 5cm,
    height: 3cm,
    ylim: (auto, auto),
    ylabel: place(left, dy: -1mm)[
      #show: box.with(width: 10cm)
      ph-Wert],
    xlabel: pad(top: -4mm, left: 1mm)[ml\ NaOH],
    legend: (
      position: top + left,
      dx: 4mm,
    ),
    lq.plot(
      data.map(it => it.at(0)),
      data.map(it => it.at(1)),
      smooth: true,
      mark: none,
      color: or-preview(white, black),
      label: label,
    ),
  )
}).intersperse(colbreak()).join([])
