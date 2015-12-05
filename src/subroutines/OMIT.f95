subroutine OMIT(string,undo,once)

character (LEN=*), optional, intent(IN) :: string
logical, optional, intent(IN) :: undo, once ! undo to "unhide" something, once to apply it only once
logical :: undo_AUX, once_AUX
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

undo_AUX = .FALSE.
if (present(undo)) undo_AUX = undo
once_AUX = .FALSE.
if (present(once)) once_AUX = once

if (undo_AUX) then
  write(*,"(A,A)") "  \undo \omit ", TRIM(string)
  write(11,"(A,A)") "  \undo \omit ", TRIM(string)
  else
    if (once_AUX) then
      write(*,"(A,A)") "  \once \omit ", TRIM(string)
      write(11,"(A,A)") "  \once \omit ", TRIM(string)
      else
        write(*,"(A,A)") "  \omit ", TRIM(string)
        write(11,"(A,A)") "  \omit ", TRIM(string)
    endif
endif

end subroutine OMIT
