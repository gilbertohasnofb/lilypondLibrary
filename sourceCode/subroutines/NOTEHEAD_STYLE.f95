! All notes and/or chords after this subroutine will be influenced. The argument should be a string such as "harmonic", or "cross". To revert, use "default" or "revert"
subroutine NOTEHEAD_STYLE(string,revert)

character (LEN=*), optional, intent(in) :: string
logical, optional, intent(in) :: revert
character (LEN=256) string_AUX
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
	write(*,*)
	write(11,*)
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
! =================================

if (present(revert)) then
	if (revert) then ! if revert is .TRUE., then it reverts the NoteHead style
		write(*,"(A)") "  \revert NoteHead.style"
		write(11,"(A)") "  \revert NoteHead.style"
	endif
	else
		if (present(string)) then
			string_AUX = string
			call LCASE(string_AUX)
			if ((string == "default") .OR. (string == "revert")) then ! if string is present and equals to "revert" or "default", then it also reverts the NoteHead style
				write(*,"(A)") "  \revert NoteHead.style"
				write(11,"(A)") "  \revert NoteHead.style"
				else ! else new notehead style
					write(*,"(A,A)") "  \override NoteHead.style = #'", TRIM(string_AUX)
					write(11,"(A,A)") "  \override NoteHead.style = #'", TRIM(string_AUX)
			endif
	endif
endif

end subroutine NOTEHEAD_STYLE
