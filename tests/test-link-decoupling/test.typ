#import "../../src/lib.typ": *

// This test verifies that outline styling is not affected by global link styling
#show link: set text(fill: blue)

#show: article

#maketitle(
  title: "Test Link Decoupling",
  authors: ("Test Author",),
  date: "2025-01-01"
)

#outline()

= Chapter One
This chapter should appear in the outline above without blue styling.

= Chapter Two  
Another chapter that should not be affected by link styling in the outline.

== Subsection
A subsection for testing.

// This link should be blue due to the show rule
#link("https://www.example.com")[This link should be blue]

Some more text with #link("https://www.example.com")[another blue link].
