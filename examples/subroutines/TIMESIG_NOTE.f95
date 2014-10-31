! This subroutine adds a snippet whose function is to display time signatures as, for instance, 3/quarter-note instead of 3/4. 
! To use it, call it before dealing with any Lilypond variable, and when calling TIME, use bottomNote=.TRUE.
subroutine TIMESIG_NOTE()

write(*,*) "#(define-public (format-time-sig-note grob)"
write(*,*) "   (let* ((frac (ly:grob-property grob 'fraction))"
write(*,*) "          (num (if (pair? frac) (car frac) 4))"
write(*,*) "          (den (if (pair? frac) (cdr frac) 4))"
write(*,*) "          (m (markup #:override '(baseline-skip . 0.5)"
write(*,*) "                     #:center-column (#:number (number->string num)"
write(*,*) "                                               #:override '(style . default)"
write(*,*) "                                               #:note (number->string den) DOWN))))"
write(*,*) "     (grob-interpret-markup grob m)))"
write(*,*)

write(11,*) "#(define-public (format-time-sig-note grob)"
write(11,*) "   (let* ((frac (ly:grob-property grob 'fraction))"
write(11,*) "          (num (if (pair? frac) (car frac) 4))"
write(11,*) "          (den (if (pair? frac) (cdr frac) 4))"
write(11,*) "          (m (markup #:override '(baseline-skip . 0.5)"
write(11,*) "                     #:center-column (#:number (number->string num)"
write(11,*) "                                               #:override '(style . default)"
write(11,*) "                                               #:note (number->string den) DOWN))))"
write(11,*) "     (grob-interpret-markup grob m)))"
write(11,*)

end subroutine TIMESIG_NOTE

