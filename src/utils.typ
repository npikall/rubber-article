// This file contains utility functions used in other functions.

#let reset-eq-counter = it => {
  counter(math.equation).update(0)
  it
}

#let header-oddPage(header-line-stroke) = context {
  set text(10pt)
  set grid.hline(stroke: header-line-stroke)
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    inset:4pt,
    smallcaps(header-title),
    smallcaps(hydra(1)),
    grid.hline(),
  )
}

#let header-evenPage(header-line-stroke) = context {
  set text(10pt)
  set grid.hline(stroke: header-line-stroke)
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    inset:4pt,
    smallcaps(hydra(1)),
    smallcaps(header-title),
    grid.hline(),
  )
}

#let header-content(first-page-header, alternating-header) = context {
  let current = counter(page).get().first()

  if current > first-page-header and calc.rem(current,2) == 0{
    return header-evenPage
  } else if current > first-page-header {
    if alternating-header {
      return header-oddPage
    } else {
      return header-evenPage
    }
  }
}
