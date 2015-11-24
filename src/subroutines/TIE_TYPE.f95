! controls the type of the subsequent ties
subroutine TIE_TYPE(c) ! 

character (LEN=*), intent(in) :: c ! can be "\tieSolid" (or also "default", "\tieDashed", "\tieDotted", "\tieHalfDashed", "\tieHalfSolid"
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
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

if ((c == "tieSolid") .OR. (c == "\tieSolid") .OR. (c == "default")) then
  write(*,"(A)") "  \tieSolid"
  write(11,"(A)") "  \tieSolid"
  else  
    write(*,"(A,A)") "  ", c
    write(11,"(A,A)") "  ", c
endif

end subroutine TIE_TYPE
