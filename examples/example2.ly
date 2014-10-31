\version "2.19.15"

\header {
  title = "Example 2"
  composer = "G. Agostinho"
  subtitle = "the most complex example yet"
  dedication = "to myself"
  tagline = ""
}

A = {
  c'4\p-.\<( d' e' f'\f)
  \bar "|."
}

B = {
  \clef "bass"
  <c e g>2 <c e g>\pp--
  \bar "|."
}

\score {
  <<
    \new PianoStaff <<
      \new Staff \A
      \new Staff \B
    >>
  >>
  \layout{ }
}

