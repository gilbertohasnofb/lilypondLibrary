\version "2.19.15"

\header {
  title = "Example 4"
  tagline = ""
}

A = {
  \accidentalStyle Score.dodecaphonic
  cis'1 |
  cis'4 cis'4 cis'4 r4 |
  des'4 des'4 des'4 r4 |
  <fis' ais' cis''>4 <ges' bes' des''>4 <ges' ais' cis''>4 r4 |
  \break
  c'8 bis8 f'8 eis'8 e'8 fes'8 b'8 ces''8 |
  cih'4 c'4 ceh'4 r4 |
  fisih'4 fis'4 geseh'4 r4 |
  fisih'4 ges'4 geseh'4 r4 |
  <fisih' fisih''>4 <geseh' geseh''>4 r2 |
}

\score {
  \new Staff \A
  \layout{ }
}

