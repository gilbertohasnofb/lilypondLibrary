subroutine END_POLY()

logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
	write(*,"(A)",advance="NO") " "
	write(11,"(A)",advance="NO") " "
	else
		write(*,"(A)",advance="NO") "  "
		write(11,"(A)",advance="NO") "  "  	
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
! =================================

write(*,"(A)") "} >>"
write(11,"(A)") "} >>"

end subroutine END_POLY
