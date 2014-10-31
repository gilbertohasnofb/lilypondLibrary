! if argument is .TRUE., noteheads will be hidden. If argument is .FALSE., noteheads will come back to normal
subroutine NOTEHEAD_TRANSPARENT(l)

logical, intent(in) :: l
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

if (l) then
	write(*,"(A)") "  \override Staff.NoteHead.transparent = ##t"
	write(11,"(A)") "  \override Staff.NoteHead.transparent = ##t"
	else
		write(*,"(A)") "  \revert Staff.NoteHead.transparent"
		write(11,"(A)") "  \revert Staff.NoteHead.transparent"
endif

end subroutine NOTEHEAD_TRANSPARENT
