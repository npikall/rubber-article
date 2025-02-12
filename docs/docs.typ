#import "@preview/tidy:0.4.1"
#import "../src/lib.typ"
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.1": *


#show: codly-init.with()
#codly(languages: codly-languages)

#show heading.where(level: 1): it => align(center, it)

= Rubber Article - Template Documentation
#align(center, heading(level:2, [v.0.2.0]))
#v(1cm)
== Example Usage
```typ
#import "@preview/rubber-article:0.2.0": *
#show: article.with()
#maketitle(
  title: "The Title of the Paper",
  authors: ("Authors Name",),
  date: datetime.today().display("[day].[month].[year]"),
)
```

#let docs = tidy.parse-module(
  read("../src/lib.typ"),
  name:"rubber-article",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n"
)

#tidy.show-module(
  docs,
  style: tidy.styles.default,
)