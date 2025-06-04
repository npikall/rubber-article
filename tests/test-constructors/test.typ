#set page(width: auto, height: auto)
#import "../../src/lib.typ":*

// Test the maketitle function
#maketitle(
  authors: ("Authors Name",),
  date: datetime(day: 14, month: 4, year: 2025).display("[day].[month].[year]"),
  title: "The Title of the Paper",
  metadata: false,
)

// Test the ctable function
#pagebreak()
#ctable(
  cols: "l|cr",
  [A],
  [B],
  [C],
  ..range(1, 16).map(str),
)

// Test the custom figure outline
#pagebreak()

// Example of a image
#figure(
  rect(),
  caption: "Fig1",
)
#figure(
  rect(),
  caption: "Fig2",
)
#fig-outline()

// Test the custom figure outline
#pagebreak()

// Example of a image
#figure(
  table(
    columns: 3,
    [A],
    [B],
    [C],
    ..range(12).map(str),
  ),
  caption: "Tab1",
)
#figure(
  table(
    columns: 3,
    [A],
    [B],
    [C],
    ..range(12).map(str),
  ),
  caption: "Tab2",
)
#tab-outline()

#pagebreak()
#abstract(alignment: center)[
  #lorem(5)
]
= Intro 
#lorem(5)
