#import "../src/lib.typ": *

#show: article.with(
  header-display: true,
  header-title: "The Title of the Paper",
  eq-numbering: "(1.1)",
  eq-chapterwise: true,
  page-margins: 1.75in,
)

#maketitle(title: "The Title of the Paper", authors: ("Authors Name",), date: datetime
  .today()
  .display("[day]. [month repr:long] [year]"))

// Some example content has been added for you to see how the template looks like.
= Introduction
#lorem(100)

#lorem(80)
$
  x_(1,2) = (-b plus.minus sqrt(b^2 - 4 a c))/ (2 a)
$
#lorem(100)
