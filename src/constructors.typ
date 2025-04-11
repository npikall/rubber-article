// This file contains functions that will generate some content.

#import "dependencies.typ": *

/// This function will display the frontmatter of the document.
/// This includes the title, authors, and date.
/// 
/// Example usage:
/// ```typ
/// #maketitle(
///   title: "The Title of the Paper",
///   authors: ("Authors Name",),
///   date: "2025-01-01",
/// )
/// ```
/// 
/// -> content
#let maketitle(
  /// The title of the document.
  /// -> string | content
  title: "",
  /// The authors of the document.
  /// -> array
  authors: (),
  /// The date of the document.
  /// -> string | content | datetime
  date: none,
  /// Use title and author information for
  /// the document metadata.
  /// -> bool
  metadata: true,
) = {
  if metadata {
    set document(author: authors, title: title)
  }
  // Author information.

  let authors-text = {
    set text(size: 1.1em)
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, author)),
      ),
    )}
    // Frontmatter

    align(center)[
      #v(60pt)
      #block(text(weight: 400, 18pt, title))
      #v(1em, weak: true)
      #authors-text
      #v(1em, weak: true)
      #block(text(weight: 400, 1.1em, date))
      #v(20pt)
    ]
  }

