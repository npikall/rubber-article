#import "@preview/rubber-article:0.1.0": *

#show: article.with()

#maketitle(
  title: "The Title of the Paper",
  authors: (
    "Authors Name",
  ),
  date: datetime.today().display("[day padding:none]. [month repr:long] [year]"),
)

// Some example content has been added for you to see how the template looks like.
= Introduction
#lorem(60)