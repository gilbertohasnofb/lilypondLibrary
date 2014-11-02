! automatic ottavation. Needs SNIPPET(ottavate=.TRUE.)
subroutine OTTAVATE(ottava,fifteenth,ottavaBassa,fifteenthBassa)

integer, intent(IN) :: ottava,fifteenth,ottavaBassa,fifteenthBassa ! each one of these variables correspond to the number of ledger lines in which ottava, fifteenth, ottava bassa and fifteenth bassa will be activate. 
! A reasonable example of values would: be 4, 7, -4, -7
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
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one did not finish with an advance="NO"
! =================================

write(*,"(A, I2,A, I2,A, I2,A, I2,A)") "  \ottavate #'(",ottava," . ",fifteenth,") #'(",ottavaBassa," . ",fifteenthBassa,") {"
write(11,"(A, I2,A, I2,A, I2,A, I2,A)") "  \ottavate #'(",ottava," . ",fifteenth,") #'(",ottavaBassa," . ",fifteenthBassa,") {"

end subroutine OTTAVATE
