! changes the stem options
subroutine STEM(c)

character (LEN=*), optional, intent(IN) :: c ! possible values are:
! up, stemup, \stemup
! down, stemdown, \stemdown
! neutral, stemneutral, \stemneutral
character (LEN=256) :: c_AUX
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (.NOT. previousAdvanceNo) then
	write(*,"(A)",advance="NO") " "
	write(11,"(A)",advance="NO") " "
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

if (present(c)) then

	c_AUX = c
	call LCASE(c_AUX)

	if ( (TRIM(c_AUX)=="neutral") .OR. (TRIM(c_AUX)=="stemneutral") .OR. (TRIM(c_AUX)=="\stemneutral") ) then
		write(*,"(A)",advance="NO") " \stemNeutral"
		write(11,"(A)",advance="NO") " \stemNeutral"
	endif

	IM(c_AUX)=="up") .OR. (TRIM(c_AUX)=="stemup") .OR. (TRIM(c_AUX)=="\stemup") ) then	
		write(*,"(A)",advance="NO") " \stemUp"
		write(11,"(A)",advance="NO") " \stemUp"
	endif

	if ( (TRIM(c_AUX)=="down") .OR. (TRIM(c_AUX)=="stemdown") .OR. (TRIM(c_AUX)=="\stemdown") ) then
		write(*,"(A)",advance="NO") " \stemDown"
		write(11,"(A)",advance="NO") " \stemDown"
	endif

endif

end subroutine STEM

