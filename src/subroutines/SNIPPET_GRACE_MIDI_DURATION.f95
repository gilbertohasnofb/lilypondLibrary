subroutine SNIPPET_GRACE_MIDI_DURATION(value)

character (LEN=*), intent(IN) :: value

write(*,"(A)") "#(define ac:defaultGraceFactor ", TRIM(value), ")"
write(11,"(A)") "#(define ac:defaultGraceFactor ", TRIM(value), ")"

end subroutine SNIPPET_GRACE_MIDI_DURATION
