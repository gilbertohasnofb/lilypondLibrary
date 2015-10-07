\version "2.19.15"

\header {
  title = \markup{Example 5}
  subtitle = \markup{example of random melody}
  tagline = ""
}

A = {
  \accidentalStyle Score.dodecaphonic-no-repeat
  e'4 c''4 cis'4 e'4 c''4 b'4 d''4 ais''4
}

\score {
  \new Staff \A
  \layout{ }
}

