\version "2.19.15"

\header {
  title = "Example 3"
  tagline = ""
}

A = {

  \key d \major
  d'4 e'4 fis'4 g'4 |
  a'4 b'4 cis''4 d''4
  \bar "|."
}

\score {
  \new Staff \A
  \layout{ }
}

