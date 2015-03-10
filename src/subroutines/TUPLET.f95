! Subroutine start tuplet. Creates a tuplet of TOTAL duration ref, with t notes inside of it, instead of n.
! If no values are intered, it uses t=3, n=2, i.e., a triplet of three notes in the place of two
subroutine TUPLET(t,n,totalDuration)

integer, optional, intent(in) :: t, n ! t = no. of notes inside of the tuplet, n = number of notes that would normally fir there if there was no tuplet
integer, optional, intent(in) :: totalDuration ! TOTAL duration of the tuplet in sixteenth notes (i.e., quarter note in the case of a triplet of three eighth notes). Please use only whole values: whole note, half note, quarter note, eighth note or sixteenth note.
integer :: t_AUX, n_AUX, totalDuration_AUX
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

t_AUX=3
n_AUX=2
if (present(t)) t_AUX=t
if (present(n)) n_AUX=n
if (present(totalDuration)) totalDuration_AUX=16/totalDuration

write(*,"(A,1X)",advance="NO") " \tuplet"
write(11,"(A,1X)",advance="NO") " \tuplet"

if (t_AUX < 10 ) then
	write(*,"(I1,A)",advance="NO") t_AUX, "/"
	write(11,"(I1,A)",advance="NO") t_AUX, "/"
	else
		write(*,"(I2,A)",advance="NO") t_AUX, "/"
		write(11,"(I2,A)",advance="NO") t_AUX, "/"
endif

if (n_AUX < 10 ) then
	write(*,"(I1,1X)",advance="NO") n_AUX
	write(11,"(I1,1X)",advance="NO") n_AUX
	else
		write(*,"(I2,1X)",advance="NO") n_AUX
		write(11,"(I2,1X)",advance="NO") n_AUX
endif

if (present(totalDuration)) then
	if (totalDuration_AUX < 10 ) then
		write(*,"(I1,1X)",advance="NO") totalDuration_AUX
		write(11,"(I1,1X)",advance="NO") totalDuration_AUX
		else
			write(*,"(I2,1X)",advance="NO") totalDuration_AUX
			write(11,"(I2,1X)",advance="NO") totalDuration_AUX
	endif
endif

write(*,"(A)",advance="NO") "{"
write(11,"(A)",advance="NO") "{"

end subroutine TUPLET
