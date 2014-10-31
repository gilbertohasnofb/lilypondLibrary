\version "2.19.15"

\header {
  title = "Example 2"
  composer = "G. Agostinho"
  subtitle = "the most complex example yet"
  dedication = "to myself"
  tagline = ""
}

A = {
  c'4\p-.\< d'4 e'4 f'4\f
  \bar "|."
}

B = {
  \clef "bass"
  <c e g>1\pp--
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

