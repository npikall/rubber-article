#import "@preview/tidy:0.4.1"
#import "../src/lib.typ"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

#show: codly-init.with()
#codly(languages: codly-languages)

#show heading.where(level: 1): it => align(center, it)

#heading(outlined: false)[Rubber Article - Template Documentation]
#align(center, heading(level: 2, [v.0.3.2], outlined: false))
#v(1cm)

#outline(depth: 3)

== Example Usage
```typ
#import "@preview/rubber-article:0.3.2": *
#show: article.with()
#maketitle(
  title: "The Title of the Paper",
  authors: ("Authors Name",),
  date: datetime.today().display("[day].[month].[year]"),
)
```
== Styling functions
These functions are used to style certain elements of the document. They are usually called with a `#show` statement. They do not output any content, but rather modify the appearance of the document.

#let docs-styles = tidy.parse-module(
  read("../src/styles.typ"),
  // name:"Styling functions",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n",
)

#tidy.show-module(
  docs-styles,
  style: tidy.styles.default,
)

#pagebreak()
== Constructor functions
These functions are used to create certain elements of the document. They can be called with certain arguments and output some content.

#let docs-constructors = tidy.parse-module(
  read("../src/constructors.typ"),
  // name:"Constructor functions",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n",
)

#tidy.show-module(
  docs-constructors,
  style: tidy.styles.default,
)
