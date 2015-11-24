! can beexchanged for END_ANY, although that won't skip the lines (making the output uglier, but still completely compilable)
subroutine END_STAFF()

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

write(*,"(A)") "}"
write(11,"(A)") "}"

! skiping one more line
write(*,*)
write(11,*)

end subroutine END_STAFF
