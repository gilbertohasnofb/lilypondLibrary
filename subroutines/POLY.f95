subroutine POLY(voice)

integer, intent(IN) :: voice ! if voice = 1, then it starts the 1st voice of a polyphonic passage. If voice > 1, it goes for the next voice in the passage. To finish the polyphony, use voice = 0 or alternatively call END_POLY()
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
  write(*,*)
  write(11,*)
endif
close(unit=7,status="delete")
! =================================

if (voice==1) then

	write(*,"(A)",advance="NO") "  << {"
	write(11,"(A)",advance="NO") "  << {"
	open(unit=7,file="temp3")
	write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
	
	else if (voice>1) then

		write(*,"(A)",advance="NO") " } \\ {"
		write(11,"(A)",advance="NO") " } \\ {"
		open(unit=7,file="temp3")
		write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"		

	else if (voice==0) then

		write(*,"(A)") " } >>"
		write(11,"(A)") " } >>"
		open(unit=7,file="temp3")
		write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"

endif

end subroutine POLY
