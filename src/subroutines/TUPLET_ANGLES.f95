! changes the angles and offset of tuplet brackets
subroutine TUPLET_ANGLES(offset, angle)

real, intent(IN) :: offset, angle ! 
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

write(*,"(A,1x,F4.1,1x,F4.1)") " \tupletAngles", offset, angle
write(11,"(A,1x,F4.1,1x,F4.1)") " \horizontalTuplets", offset, angle

end subroutine  TUPLET_ANGLES
