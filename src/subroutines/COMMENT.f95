! creates a comment in the LilyPond code
subroutine COMMENT(text)

character (LEN=*), intent(IN) :: text
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (.NOT. previousAdvanceNo) then
	write(*,"(A)",advance="NO") "  "
	write(11,"(A)",advance="NO") "  "
	else
		write(*,"(A)",advance="NO") " "
		write(11,"(A)",advance="NO") " "
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

! dealing with optional variables
write(*,"(A,A)") "% ", TRIM(text)
write(11,"(A,A)") "% ", TRIM(text)

end subroutine COMMENT
