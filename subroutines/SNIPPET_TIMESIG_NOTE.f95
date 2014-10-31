! This subroutine adds a snippet whose function is to display time signatures as, for instance, 3/quarter-note instead of 3/4. 
subroutine SNIPPET_TIMESIG_NOTE()

write(*,"(A)") "#(define-public (format-time-sig-note grob)"
write(*,"(A)") "   (let* ((frac (ly:grob-property grob 'fraction))"
write(*,"(A)") "          (num (if (pair? frac) (car frac) 4))"
write(*,"(A)") "          (den (if (pair? frac) (cdr frac) 4))"
write(*,"(A)") "          (m (markup #:override '(baseline-skip . 0.5)"
write(*,"(A)") "                     #:center-column (#:number (number->string num)"
write(*,"(A)") "                                               #:override '(style . default)"
write(*,"(A)") "                                               #:note (number->string den) DOWN))))"
write(*,"(A)") "     (grob-interpret-markup grob m)))"

write(11,"(A)") "#(define-public (format-time-sig-note grob)"
write(11,"(A)") "   (let* ((frac (ly:grob-property grob 'fraction))"
write(11,"(A)") "          (num (if (pair? frac) (car frac) 4))"
write(11,"(A)") "          (den (if (pair? frac) (cdr frac) 4))"
write(11,"(A)") "          (m (markup #:override '(baseline-skip . 0.5)"
write(11,"(A)") "                     #:center-column (#:number (number->string num)"
write(11,"(A)") "                                               #:override '(style . default)"
write(11,"(A)") "                                               #:note (number->string den) DOWN))))"
write(11,"(A)") "     (grob-interpret-markup grob m)))"

end subroutine SNIPPET_TIMESIG_NOTE
