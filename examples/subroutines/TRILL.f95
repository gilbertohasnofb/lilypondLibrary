! should be called after NOTE. TRILL(.TRUE.) starts a trill, TRILL(.FALSE.) stops it.
subroutine TRILL(start,pitchedTrill,accidental,quartertone)

logical, intent(IN) :: start ! .TRUE. starts a trill, .FALSE. stops it
integer, optional, intent(IN) :: pitchedTrill ! if PITCHEDTRILL was called before the note, then use this variable to define the pitch for the pitchedTrill
character (LEN=*), optional, intent(in) :: accidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
character (LEN=*), optional, intent(in) :: quartertone ! if "ih", "up" or "higher", then quarter tone higher, if "eh", "down" or "lower", then quarter tone lower. If "" or "neuter" or "default", then no quarter tone will be used
character (LEN=256) :: accidental_AUX, quartertone_AUX ! Auxiliary variable
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

! dealing with optional variables
accidental_AUX="sharp"
quartertone_AUX="neuter"
if (present(accidental)) accidental_AUX = TRIM(accidental)
if (present(quartertone)) quartertone_AUX = TRIM(quartertone)

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
