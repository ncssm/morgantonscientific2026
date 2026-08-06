#set text(font: "Noto Sans", size: 10pt)

#let spacer = text(fill: gray)[ #h(8pt) | #h(8pt)]

#set page(
  paper: "us-letter",
  footer: block(
    width: 100%,
    stroke: (top: 1pt + gray),
    inset: (top: 8pt, right: 2pt),
    context [
      Morganton Scientific | Volume 3 | 2025 - 2026
      #h(1fr)
      #counter(page).display()
    ]
  ),
  background: none,
)

#context [
  #counter(page).update([-doc.first_page-])
]

#align(center)[
  #v(14em)
  #image("logo.png", width: 50%)
  #v(3em)
  #text(size:20pt, fill: black.lighten(40%))[
    #smallcaps("[-options.section-]")
  ]
]

#show heading: set text(fill: rgb("#C18849"))
