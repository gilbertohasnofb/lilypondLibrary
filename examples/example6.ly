\version "2.19.15"

\header {
  title = \markup{Example 6}
  tagline = ""
}

A = {
  \include "example6-A.ily"
}

B = {
  \include "example6-B.ily"
}

\score {
  <<
    \new Staff \A
    \new Staff \B
  >>
  \layout{ }
}

