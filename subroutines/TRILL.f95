! should be called after NOTE. TRILL(.TRUE.) starts a trill, TRILL(.FALSE.) stops it.
subroutine TRILL(start,pitchedTrill,accidental)

logical, intent(IN) :: start ! .TRUE. starts a trill, .FALSE. stops it
integer, optional, intent(IN) :: pitchedTrill ! if PITCHEDTRILL was called before the note, then use this variable to define the pitch for the pitchedTrill
logical, optional, intent(IN) :: accidental ! accidental for the variable above, works just like a regular NOTE
logical :: accidental_AUX
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (.NOT. previousAdvanceNo) then
	write(*,"(A)",advance="NO") "  "
	write(11,"(A)",advance="NO") "  "  	
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

accidental_AUX = .TRUE.
if (present(accidental)) accidental_AUX = accidental

if (start) then

	write(*,"(A)",advance="NO") "\startTrillSpan"
	write(11,"(A)",advance="NO") "\startTrillSpan"
	if (present(pitchedTrill)) then
		write(*,"(A)",advance="NO") " "
		write(11,"(A)",advance="NO") " "
		call MIDI_PITCH_TO_LP(pitchedTrill,accidental_AUX)
	endif
	
	else
	
		write(*,"(A)",advance="NO") "\stopTrillSpan"
		write(11,"(A)",advance="NO") "\stopTrillSpan"
	
endif

end subroutine TRILL
