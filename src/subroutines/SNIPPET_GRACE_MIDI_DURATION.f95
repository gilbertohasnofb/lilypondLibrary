subroutine SNIPPET_GRACE_MIDI_DURATION(value)

character (LEN=*), intent(IN) :: value

write(*,"(A,A,A)") "#(define ac:defaultGraceFactor ", TRIM(value), ")"
write(11,"(A,A,A)") "#(define ac:defaultGraceFactor ", TRIM(value), ")"

end subroutine SNIPPET_GRACE_MIDI_DURATION
