subroutine SNIPPET_TRILL_SPEED(string)

character (LEN=*), intent(IN) :: string

write(*,"(A)") "  #(define (ac:twiddletime music)"
write(*,"(A)") "    (let* ((tr (filter (lambda (x)"
write(*,"(A)") "                       (and (eq? 'ArticulationEvent (ly:music-property x 'name))"
write(*,"(A)") '                        (string= "trill"'//" (ly:music-property x 'articulation-type))))"
write(*,"(A)") "                (ly:music-property music 'elements)))"
write(*,"(A)") "           (pre-t (if (pair? tr) (ly:music-property (car tr) 'twiddle)"
write(*,"(A)") "                   '()))"
write(*,"(A,A,A)") "           (hemisemimom (ly:make-moment ",string,"))"
write(*,"(A)") "           (t (ac:targetTwiddleTime)))"
write(*,"(A)") "     (if (ly:moment? pre-t)"
write(*,"(A)") "      pre-t"
write(*,"(A)") "      hemisemimom)))"

write(11,"(A)") "  #(define (ac:twiddletime music)"
write(11,"(A)") "    (let* ((tr (filter (lambda (x)"
write(11,"(A)") "                       (and (eq? 'ArticulationEvent (ly:music-property x 'name))"
write(11,"(A)") '                        (string= "trill"'//" (ly:music-property x 'articulation-type))))"
write(11,"(A)") "                (ly:music-property music 'elements)))"
write(11,"(A)") "           (pre-t (if (pair? tr) (ly:music-property (car tr) 'twiddle)"
write(11,"(A)") "                   '()))"
write(11,"(A,A,A)") "           (hemisemimom (ly:make-moment ",string,"))"
write(11,"(A)") "           (t (ac:targetTwiddleTime)))"
write(11,"(A)") "     (if (ly:moment? pre-t)"
write(11,"(A)") "      pre-t"
write(11,"(A)") "      hemisemimom)))"

end subroutine SNIPPET_TRILL_SPEED
