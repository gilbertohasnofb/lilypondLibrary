! if argument = .TRUE., "\xNotesOn". If argument = .FALSE., "\xNotesOff"
subroutine XNOTE(l)

logical, optional, intent(in) :: l
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

if ((present(l)) .AND. (l)) then
	write(*,"(A)") "  \xNotesOn"
	write(11,"(A)") "  \xNotesOn"
	else
		write(*,"(A)") "  \xNotesOff"
		write(11,"(A)") "  \xNotesOff"
endif

end subroutine XNOTE
