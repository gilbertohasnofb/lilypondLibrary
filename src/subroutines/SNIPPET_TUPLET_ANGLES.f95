! By Thomas Morley. From: lilypond.1069038.n5.nabble.com/Tuplet-bracket-and-cross-staff-td191922.html
subroutine SNIPPET_TUPLET_ANGLES()

write(*,"(A)") "  tupletAngles ="
write(*,"(A)") "  #(define-music-function (y-off angl)(number? number?)"
write(*,"(A)") "     #{"
write(*,"(A)") "       \once\override TupletBracket #'positions ="
write(*,"(A)") "       #(lambda (grob)"
write(*,"(A)") "          (let* ((pos (ly:tuplet-bracket::calc-positions grob))"
write(*,"(A)") "                 (y-length (interval-length pos))"
write(*,"(A)") "                 (x-length (interval-length"
write(*,"(A)") "  (ly:tuplet-bracket::calc-x-positions grob)))"
write(*,"(A)") "                 (alpha (degrees->radians angl))"
write(*,"(A)") "                 (dir (ly:grob-property grob 'direction))"
write(*,"(A)") "                 (new-start (+ (if (= dir 1)"
write(*,"(A)") "                                   (max (car pos)(cdr pos))"
write(*,"(A)") "                                   (min (car pos)(cdr pos)))"
write(*,"(A)") "                              y-off))"
write(*,"(A)") "                 (new-y (* x-length (tan alpha))))"
write(*,"(A)") "            (cons new-start (+ new-start new-y))))"
write(*,"(A)") "     #})"

write(11,"(A)") "  tupletAngles ="
write(11,"(A)") "  #(define-music-function (y-off angl)(number? number?)"
write(11,"(A)") "     #{"
write(11,"(A)") "       \once\override TupletBracket #'positions ="
write(11,"(A)") "       #(lambda (grob)"
write(11,"(A)") "          (let* ((pos (ly:tuplet-bracket::calc-positions grob))"
write(11,"(A)") "                 (y-length (interval-length pos))"
write(11,"(A)") "                 (x-length (interval-length"
write(11,"(A)") "  (ly:tuplet-bracket::calc-x-positions grob)))"
write(11,"(A)") "                 (alpha (degrees->radians angl))"
write(11,"(A)") "                 (dir (ly:grob-property grob 'direction))"
write(11,"(A)") "                 (new-start (+ (if (= dir 1)"
write(11,"(A)") "                                   (max (car pos)(cdr pos))"
write(11,"(A)") "                                   (min (car pos)(cdr pos)))"
write(11,"(A)") "                              y-off))"
write(11,"(A)") "                 (new-y (* x-length (tan alpha))))"
write(11,"(A)") "            (cons new-start (+ new-start new-y))))"
write(11,"(A)") "     #})"

end subroutine SNIPPET_TUPLET_ANGLES
