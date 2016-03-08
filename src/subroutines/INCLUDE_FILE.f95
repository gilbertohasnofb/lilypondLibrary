! includes a file, argument is the path
subroutine INCLUDE_FILE(filename)

character (LEN=*), intent(IN) :: filename ! filename (or path) of the variable to be included
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

write(*,"(A,A,A)") '  \include "', TRIM(filename), '"'
write(11,"(A,A,A)") '  \include "', TRIM(filename), '"'

end subroutine INCLUDE_FILE
