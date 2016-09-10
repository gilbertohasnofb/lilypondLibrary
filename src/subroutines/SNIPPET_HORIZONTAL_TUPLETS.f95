subroutine SNIPPET_HORIZONTAL_TUPLETS()

write(*,"(A)") "  horizontalTuplets ="
write(*,"(A)") "  \override TupletBracket  #'positions ="
write(*,"(A)") "  #(lambda (grob)"
write(*,"(A)") "     (let* ((pos (ly:tuplet-bracket::calc-positions grob))"
write(*,"(A)") "            (dir (ly:grob-property grob 'direction))"
write(*,"(A)") "            (new-pos (if (= dir 1)"
write(*,"(A)") "                         (max (car pos)(cdr pos))"
write(*,"(A)") "                         (min (car pos)(cdr pos)))))"
write(*,"(A)") "       (cons new-pos new-pos)))"

write(11,"(A)") "  horizontalTuplets ="
write(11,"(A)") "  \override TupletBracket  #'positions ="
write(11,"(A)") "  #(lambda (grob)"
write(11,"(A)") "     (let* ((pos (ly:tuplet-bracket::calc-positions grob))"
write(11,"(A)") "            (dir (ly:grob-property grob 'direction))"
write(11,"(A)") "            (new-pos (if (= dir 1)"
write(11,"(A)") "                         (max (car pos)(cdr pos))"
write(11,"(A)") "                         (min (car pos)(cdr pos)))))"
write(11,"(A)") "       (cons new-pos new-pos)))"

end subroutine SNIPPET_HORIZONTAL_TUPLETS
