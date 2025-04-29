
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  header: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    number-align: right + bottom,
    header: context {
  if counter(page).get().first() > 1 [
    #grid(
      columns: 1fr,
      [#upper(header)
      #v(0.5em)],
      grid.hline()
    )
    ]
    
},
  )

  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  // if title != none {
  //   stack(
  //     dir: ltr,
  //     spacing: 1fr,
      
  //       text(weight: "bold", size: 1.5em)[#title]
  //     ,
      
  //       if date != none {
  //         text(style: "italic")[#date]
  //         }
      
  //   )
  // }

    if title != none {
      grid(
        columns: 1fr,
        [
        #text(weight: "bold", size: 1.5em)[#upper(title)]
        #v(0.5em)],
        grid.hline()
      )
    // text(weight: "bold", size: 1.5em)[#title]
  }

  // if title != none {
  //   line(length: 100%)
  // }



  if authors != none {
    let count = authors.len()
    let nrows = calc.min(count, 3)
    grid(
    columns: (1fr, ),
    // Create one row per author; you can use auto height (or repeat(authors.len(), auto))
    rows: nrows,
    row-gutter: 1em,
    ..authors.map(author =>
      stack(dir: ltr,
      spacing: 1fr,
        [
        #text(style: "italic")[#author.name]
        #if author.email != "" {link(str("mailto:" + author.email.replace("\\@", "@")), "✉")
        }],
        if author.affiliation != "" {
        author.affiliation
        }
        )
    )
      )
  
  }

  

  if date != none {
    align(left)[
      #text(style: "italic")[#date]
    ]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  v(3em)

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)

// #show heading.where(
//   level: 1
// ): it => block(width: 100%)[
//   #smallcaps(it)
//   #line(length: 100%)
// ]

#set bibliography(
  title:none
)

#show heading.where(
  level: 1
): it => grid(
  columns: 1fr,
  [#it #v(0.5em)],
  grid.hline(),
  v(0.4em)
)



