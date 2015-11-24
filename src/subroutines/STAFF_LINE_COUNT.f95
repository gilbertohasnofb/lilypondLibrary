! Controls the number of staff lines, according to the argument n. If called without arguments, it restores the traditional 5 lines. 
subroutine STAFF_LINE_COUNT(n)

integer, optional, intent(in) :: n
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

if ((present(n)).AND.(n>=0)) then
  write(*,"(A)") "  \stopStaff"
  write(11,"(A)") "  \stopStaff"
  write(*,"(A,I1)") "  \override Staff.StaffSymbol.line-count = #", n
  write(11,"(A,I1)") "  \override Staff.StaffSymbol.line-count = #", n
  write(*,"(A)") "  \startStaff"
  write(11,"(A)") "  \startStaff"
endif

if (.NOT. present(n)) then
  write(*,"(A)") "  \stopStaff"
  write(11,"(A)") "  \stopStaff"
  write(*,"(A)") "  \revert Staff.StaffSymbol.line-count"
  write(11,"(A)") "  \revert Staff.StaffSymbol.line-count"
  write(*,"(A)") "  \startStaff"
  write(11,"(A)") "  \startStaff"
endif

end subroutine STAFF_LINE_COUNT

