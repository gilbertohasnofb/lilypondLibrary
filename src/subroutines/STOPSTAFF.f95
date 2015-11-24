! stops or starts a staff according to a logical variable (.TRUE. stops, .FALSE. starts)
subroutine STOPSTAFF(l)

logical, optional, intent(in) :: l
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

if ((present(l)).AND.(l)) then
  write(*,"(A)") "  \stopStaff"
  write(11,"(A)") "  \stopStaff"
endif

if ((present(l)).AND.(.NOT. l)) then
  write(*,"(A)") "  \startStaff"
  write(11,"(A)") "  \startStaff"
endif

end subroutine STOPSTAFF

