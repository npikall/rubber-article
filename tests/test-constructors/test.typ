#set page(width: auto, height: auto)
#import "@preview/rubber-article:0.3.2":*

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
