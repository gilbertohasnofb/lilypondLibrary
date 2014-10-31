! creates a key signature
subroutine KEY(keypitch, mode, accidental)

integer, intent(IN) :: keypitch ! 0=C, 1=C#, ... 11=B (or also according to MIDI number since it includes a MOD operation)
character (LEN=5), optional, intent(IN) :: mode ! should be either "major" or "minor"
character (LEN=*), optional, intent(in) :: accidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
integer :: keypitch_AUX
character (LEN=5) :: mode_AUX
character (LEN=256) :: accidental_AUX
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

keypitch_AUX = MOD(keypitch,12) + 48 ! that is, keypitch is in between 48-59, or between c and b in LilyPond's notation
mode_AUX = "major"
if (present(mode)) mode_AUX = mode
call LCASE(mode_AUX) ! in lower case

! dealing with optional variables
accidental_AUX="sharp"
if (present(accidental)) accidental_AUX = TRIM(accidental)

! skipping a line
write(*,*) 
write(11,*) 

write(*,"(A,A)",advance="NO") "  \key "
write(11,"(A,A)",advance="NO") "  \key "
call MIDI_PITCH_TO_LP(keypitch_AUX,accidental_AUX)
write(*,"(A,A)") " \", mode_AUX
write(11,"(A,A)") " \", mode_AUX

end subroutine KEY
