! ottavation. If i = 1 then ottava up, i = 2 then fifteenth up, i = -1 then ottava bassa, etc. To reset, use i = 0
subroutine NUMERICOTTAVA(i)

integer, intent(IN) :: i ! If i = 1 then ottava up, i = 2 then fifteenth up, i = -1 then ottava bassa, etc. To reset, use i = 0
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

if ((i < 10) .AND. (i >= 0)) then
  write(*,"(A,I1)",advance="NO") " \numericOttava #", i
  write(11,"(A,I1)",advance="NO") " \numericOttava #", i
  else
    write(*,"(A,I2)",advance="NO") "  \numericOttava #", i
    write(11,"(A,I2)",advance="NO") " \numericOttava #", i  
endif

end subroutine NUMERICOTTAVA
