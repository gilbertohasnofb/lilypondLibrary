! by David Nalesnik. From: http://lilypond.1069038.n5.nabble.com/Automatic-ottava-handling-td167190i20.html
subroutine SNIPPET_NUMERICOTTAVA()

write(*,"(A)") "numericOttava ="
write(*,"(A)") "#(define-music-function"
write(*,"(A)") "     (parser location number)"
write(*,"(A)") "     (integer?)"
write(*,"(A)") "     (cond"
write(*,"(A)") "          ((equal? number 0)"
write(*,"(A)") "           #{"
write(*,"(A)") "             \ottava #0"
write(*,"(A)") "           #}"
write(*,"(A)") "           )"
write(*,"(A)") "          ((equal? number 1)"
write(*,"(A)") "           #{"
write(*,"(A)") "              \ottava #number"
write(*,"(A)") '              \set Staff.ottavation ="8"'
write(*,"(A)") "           #}"
write(*,"(A)") "           )"
write(*,"(A)") "          ((equal? number 2)"
write(*,"(A)") "           #{"
write(*,"(A)") "              \ottava #number"
write(*,"(A)") '              \set Staff.ottavation = \markup\concat{"15" \teeny""}'
write(*,"(A)") "           #}"
write(*,"(A)") "           )"
write(*,"(A)") "          ((equal? number -1)"
write(*,"(A)") "           #{"
write(*,"(A)") "              \ottava #number"
write(*,"(A)") '              \set Staff.ottavation ="8"'
write(*,"(A)") "           #}"
write(*,"(A)") "           )"
write(*,"(A)") "          ((equal? number -2)"
write(*,"(A)") "           #{"
write(*,"(A)") "              \ottava #number"
write(*,"(A)") '              \set Staff.ottavation ="15"'
write(*,"(A)") "           #}"
write(*,"(A)") "           )))"

write(11,"(A)") "numericOttava ="
write(11,"(A)") "#(define-music-function"
write(11,"(A)") "     (parser location number)"
write(11,"(A)") "     (integer?)"
write(11,"(A)") "     (cond"
write(11,"(A)") "          ((equal? number 0)"
write(11,"(A)") "           #{"
write(11,"(A)") "             \ottava #0"
write(11,"(A)") "           #}"
write(11,"(A)") "           )"
write(11,"(A)") "          ((equal? number 1)"
write(11,"(A)") "           #{"
write(11,"(A)") "              \ottava #number"
write(11,"(A)") '              \set Staff.ottavation ="8"'
write(11,"(A)") "           #}"
write(11,"(A)") "           )"
write(11,"(A)") "          ((equal? number 2)"
write(11,"(A)") "           #{"
write(11,"(A)") "              \ottava #number"
write(11,"(A)") '              \set Staff.ottavation = \markup\concat{"15" \teeny""}'
write(11,"(A)") "           #}"
write(11,"(A)") "           )"
write(11,"(A)") "          ((equal? number -1)"
write(11,"(A)") "           #{"
write(11,"(A)") "              \ottava #number"
write(11,"(A)") '              \set Staff.ottavation ="8"'
write(11,"(A)") "           #}"
write(11,"(A)") "           )"
write(11,"(A)") "          ((equal? number -2)"
write(11,"(A)") "           #{"
write(11,"(A)") "              \ottava #number"
write(11,"(A)") '              \set Staff.ottavation ="15"'
write(11,"(A)") "           #}"
write(11,"(A)") "           )))"

end subroutine SNIPPET_NUMERICOTTAVA
