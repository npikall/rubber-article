#import "@preview/tidy:0.4.3"
#import "../src/lib.typ"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/vienna-tech:1.1.0": fancy-latex, fancy-typst


#set par(justify: true)
#show: codly-init.with()
#codly(languages: codly-languages)

#show heading.where(level: 1): it => align(center, it)

#show heading.where(level: 1): set text(rgb("#239DAD"))
#show heading.where(level: 2): set text(rgb("#239DAD"))

#show outline.entry.where(level: 2): it => link(it.element.location(), it.indented(
  it.prefix(),
  strong(it.body()) + h(1fr) + strong(it.page()),
))

#heading(outlined: false)[Rubber Article - Template Documentation]
#align(center, heading(level: 2, text(black)[v.0.5.0], outlined: false))
#v(1cm)

#outline(depth: 3)

#v(1cm)
This template is a replication/implementation of the classic `article` #fancy-latex class in
#fancy-typst. It is designed to be used for writing articles, papers, and other documents. It is a
good starting point for people transitioning from #fancy-latex to #fancy-typst or students starting
with academic writing.


#heading(level: 3, outlined: false)[Example Usage]
```typ
#import "@preview/rubber-article:0.5.0": *
#show: article
#maketitle(
  title: "The Title of the Paper",
  authors: ("Authors Name",),
  date: datetime.today().display("[day].[month].[year]"),
)
```
It shall be noted here, that this is not an exact copy, but rather a very close reinterpretation,
since #fancy-typst is quite different to work with. Additionally some features, that have not been
present in the original `article` class, have been added to this template. For example the
`header-line` has been added, which in #fancy-latex would have needed the package `fancyhdr`. Also
worth a mention is that the default paper size in Typst is the A4 format, while in the original the
US Letter format is used.

In order to recreate the original `article` class, use the following settings.
```typ
#show: article.with(
  page-margins: 1.75in,
  page-paper: "us-letter",
)
```

#show heading.where(level: 2): it => {
  pagebreak(weak: true)
  it
}


== Styling functions
These functions are used to style certain elements of the document. They are usually called with a
`#show` statement. They do not output any content, but rather modify the appearance of the document.

#let docs-styles = tidy.parse-module(
  read("../src/styles.typ"),
  // name:"Styling functions",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n",
)

#tidy.show-module(docs-styles, style: tidy.styles.default)

#pagebreak()
== Constructor functions
These functions are used to create certain elements of the document. They can be called with certain
arguments and output some content.

#let docs-constructors = tidy.parse-module(
  read("../src/constructors.typ"),
  // name:"Constructor functions",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n",
)

#tidy.show-module(docs-constructors, style: tidy.styles.default)

== Utility functions
These functions can be used to perform certain tasks in the document. These functions will help you
style certain elements of the document, where otherwise complicated functions would be needed.

#let docs-utils = tidy.parse-module(
  read("../src/utils.typ"),
  // name:"Constructor functions",
  scope: (rubber-article: lib),
  preamble: "#import rubber-article: *\n",
)

#tidy.show-module(docs-utils, style: tidy.styles.default)
