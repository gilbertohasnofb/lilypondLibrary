! Subroutine start repetition. Repeats a (group of) bar(s) N times. If N not present, then repeats 2x.
! percent uses %|%|% for repetition, not |:   :|:    :|
subroutine REPEAT(N,percent)
 
integer, optional, intent(in) :: N ! number of repetitions
logical, optional, intent(in) :: percent ! if .TRUE., then uses %|%|% for repetition, not |:   :|:    :| 
integer :: N_AUX
logical :: percent_AUX
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
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

N_AUX=2
percent_AUX=.FALSE.
if (present(N)) N_AUX=N
if (present(percent)) percent_AUX=percent

if (N_AUX >= 2) then

	write(*,"(A,1X)",advance="NO") "  \repeat"
	write(11,"(A,1X)",advance="NO") "  \repeat"
	
	if (.NOT. percent_AUX) then
		write(*,"(A,1X)",advance="NO") "volta"
		write(11,"(A,1X)",advance="NO") "volta"
		else
			write(*,"(A,1X)",advance="NO") "percent"
			write(11,"(A,1X)",advance="NO") "percent"
	endif

	if (N_AUX < 10) then
		write(*,"(I1,1X,A)",advance="NO") N_AUX, "{"
		write(11,"(I1,1X,A)",advance="NO") N_AUX, "{"
		else
			write(*,"(I2,1X,A)",advance="NO") N_AUX, "{"
			write(11,"(I2,1X,A)",advance="NO") N_AUX, "{"
	endif

endif

end subroutine REPEAT
